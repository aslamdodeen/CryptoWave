//
//  ChartView.swift
//  CryptoWave
//
//  Created by Islam Aldarabea on 25/12/2023.
//

import SwiftUI

struct ChartView: View {
    
    private  let data:[Double]
    private  let maxY: Double
    private  let minY:Double
    private  let lineColor: Color
    private  let startingDate: Date
    private  let endingdate: Date
    @State private var percentage: CGFloat = 0
    
    init(coin: Coin) {
        print(coin.sparklineIn7D)
        print(coin.sparklineIn7D?.price)
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingdate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingdate.addingTimeInterval(-7*24*60)
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 222)
                .background(chartBackground)
                .overlay( chartYAxis.padding(.horizontal,4),alignment: .leading)
            chartDateLabel
                .padding(.horizontal,4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}


#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                
                for index in data.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0,to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round,lineJoin: .round))
            .shadow(color:lineColor ,radius: 7,x: 0.0,y: 7)
            .shadow(color:lineColor.opacity(0.4) ,radius: 8,x: 0.0,y:7)
            .shadow(color:lineColor.opacity(0.1) ,radius: 8,x:0.0,y:2)


        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
        
    }
    
    private var chartDateLabel: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingdate.asShortDateString())
        }
    }
}
