class Univariate():
    def quanQual(self,dataset):
        quan = []
        qual = []
        for data in dataset.columns:
            if(dataset[data].dtype=='object'):
                qual.append(data)
            else:
                quan.append(data)
        return quan,qual 