Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32F934695F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 20:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhCWT4p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 15:56:45 -0400
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com ([40.107.237.72]:53728
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230327AbhCWT4b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Mar 2021 15:56:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOxnWUCW9iJVSm4P36Th3uEOLxao/ymtwPkiCv+uUCcyrVUcEnoQ3H57qEFAHajvZUIAL0TSelOlE7LBu2yh/1LSjG1Qd39r3IKGDIWlZix6bINDBvsDvovmi5nWlhD+Hu2OwJc9ATgrK0JY1Lb1kKbMW2F/Lb+DdP2jNxWLXEXwu5CUex78n3NNGLKvzojPfeFcvZthGbE54DqAc65d0NDP2oIs9ob7xLNpJStvDxcFXwWm8jRBP79SYrh0iGRzSsyhEYQPp6BXs5gn4Ycu3/43nd8pmayA1DHyowePw0IKr7e0UaF/kEl/t1sPVWNouqPocHIhDiXlA46nEoUC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaPkZS5WIYGXOjo95Cccxb3eiGdEGoKAN+8MGrKhdbc=;
 b=Efk6QShZpZWhUc8eyKKSz/zf3G/z7uYOHgp7e/J8fWs4UNOu9tFsn/IPw4PhQ4sFYnxf99HabLqSjBVT9EKIgAJ/37JoSRIYELcwl925KPjB8qJu6ci5l0BF2HD2IAYl5xEjvPB3Rpi7wUE9/mqMduoSZCrfEjUBemYuOIfLZSTKDOorsmf/r2eAM80rhR3SExAEm5Bg7iEC8nI5AYg+g5NWAesVHsCPOHD9nnEK5Zc0LMEwnuHQisKubCVEAEHjkmPUWv7e1ttbUbsskRagN0e+7yoKuhjhTTmU4+t502SQCA9TsoWoCvBqBdIfuUcxLlb0HjWiEsU+Q9PJ9trwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaPkZS5WIYGXOjo95Cccxb3eiGdEGoKAN+8MGrKhdbc=;
 b=Eyc+vNGLP/igDny2yQ9aEV6WtfCi4V7zMXSeTS14a1UCsMft7+Xi5QEkZ2Zn35G8nczF1bJhYWsEWdjTXMClsbMczrXLgIGrrk1J2CRAvrBOWhZfXSPig5Tw2UR6zKiG8uPK+5SGzIaNSd2rfGP9znsm9eQe19sWVP/1qBPbY15YhTovb0gQiswqTETJGRanpst2qclFhcCva7rX55LJtA8a3939kyf4MobSruj3iY1jRsL1wJYKFQlIBmvCbN7Ot1t+Bxy9LjpSOQEQhJOXncQceKIDdnSEFSF5FlJStsZpj9l9ov/g5HDpB6WKoWkd/Nqzm/GyuS1Sn14b3Gp/AA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 19:56:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 19:56:28 +0000
Date:   Tue, 23 Mar 2021 16:56:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH for-next 1/2] RDMA/hns: Support query information of
 functions from FW
Message-ID: <20210323195627.GA398808@nvidia.com>
References: <1615542507-40018-1-git-send-email-liweihang@huawei.com>
 <1615542507-40018-2-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615542507-40018-2-git-send-email-liweihang@huawei.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: MN2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:208:23b::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR11CA0016.namprd11.prod.outlook.com (2603:10b6:208:23b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 19:56:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOn8d-001fmB-7P; Tue, 23 Mar 2021 16:56:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad21cc2f-066f-44d7-85e7-08d8ee35bf69
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1337FDA63D27D0FA5230945DC2649@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCta1AN1nZyUqpK6VONfCMT9TZ405xxxnTLtBE1B4qrw2rE1je7sR++8RIhbL7ZOHg8yTxKobrQ0B9HjWKvSOIYGa8eggxbtS5qd9/M9ZWbWY6FJRlrbjSyuA+G9JTbBNiQGc+kUN6uL/GBV1/rJcta5a0NngG1BaooW40T1mNPJu03pZokAF6TMwqElDV0RO9Dvnjl2GpWbsL2Azw/6hAskTg01rCQCTdHhNNP011xwEaORz7tqVApJ2TKSF0N+S2DJKOwFvzb1wcC8BuszOPtxQFRkNTDyrEqAGgBaCEzyXAkGv22DEV4PDdcDzPfTjvUXBZjgtp+2Fv7C4eO9vzG5dVbQHEZMEzmWvwkDbraiWmdY2yyAqxEAI4B83njP3dSulm1HnCLnfVxOg/PDY1b2HgCHxrDXOLsCetDzV8ERUgD9NCUGdQLxol659nLF4r3rCo/4utXfOeo4r0bYebDtLt5tb36ziPA0sR+VS6aPZxNZ5XyMT2VIEYvbS02XnxXma/FqCFW2EDY6YzYz7x6gXaq+N7E6eyfr0znJn7pgit3NABTwBkzoIYybpN1pAun38ioU/ZyM1Mfd4QvsPz1dqGut06rFexINyVYVdtMM6WYqgy919aKOT4GeMAsX9SGLG2nQETKe0KX1EXGHE+mHYu+eXDvGCHcc/MzlRY3T5mdzn/R79ZSoWlArndo8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(6916009)(478600001)(5660300002)(4326008)(36756003)(26005)(186003)(38100700001)(33656002)(8936002)(9786002)(2616005)(9746002)(66556008)(86362001)(316002)(66946007)(66476007)(426003)(1076003)(4744005)(8676002)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xkbztjfc69r2juHg4MpKuGB+pVc6AHJ3Cafsua/AAm5ZNEP4EwcVK7y+FNve?=
 =?us-ascii?Q?ZQzOLLqnDWyR3Rw9WS1FjzYWu2lwYvTcVoI2YaWce575eMlMHlg79vpBi3cS?=
 =?us-ascii?Q?gDSr8UOHGjKJtytcIr6UD2h7/L0ZXzquIJDpqli8gitFuzPmf0rcc1tsReVa?=
 =?us-ascii?Q?x8G8sW/fN/sX9i09u43Oy7OgBAqP/7D9DN8ERMWyy6R15DU1eFt963GBo0Kh?=
 =?us-ascii?Q?nfN23clj5Srmy6E7+ciWWpaAWHckqVDTbVtKfo4DwTnMGoK1m/FWpw58kQLS?=
 =?us-ascii?Q?wAh54lqrjICx8sAvgfszPCKDadf+n407rYQodxYyTPKfgfz62gsBYaKbgGE0?=
 =?us-ascii?Q?fsDurjox8AsFhW4don9AxBM+syOzbyMn8GGTv0HMKy7GpfuDSxNrLqenTmGj?=
 =?us-ascii?Q?ktaDZNW+b+yAX8iorWcRtdto4aqEeyCKtTvBMIWJTarQ/XjFTa1ZwFpJTnxQ?=
 =?us-ascii?Q?ncNnXiTbFM8jStFibClLlR/9dIWKoGVOHpcmeRyLOHXiFH4SEDlHPP04wPeG?=
 =?us-ascii?Q?nAmdYfICEALZxPKDrStjHr4C/+nZZfJz9E1DvXBTndPybanK3ivBwAVV6Bsj?=
 =?us-ascii?Q?gqa6TqIzFmVKx0+w4gQJ1UcFY+odGfu3G7iVNYWa1g1GOC43ajOb6IzNKjTT?=
 =?us-ascii?Q?jwP+56lm2N4i6IalmY3LX8D91OkdyomzG4Ww0885AyxVzsZiarcpWuJO6CDE?=
 =?us-ascii?Q?JqLHdYoVLxCso6lVMqn2kICjU9Vz+T/xCJNLobadeGSoLo9UhBr2e8AZP/ro?=
 =?us-ascii?Q?qaHCiF+2ZaDSGuej4nWpqlgJZJWWPh3IxMhUUq5G+gjAFpHkEMOOWYAnzQ03?=
 =?us-ascii?Q?m+4cwq2nqavPgw72wGy9cgHGPZpHWMXV5FO6WZhN0I0yU9SOyGIZMLwXJgck?=
 =?us-ascii?Q?CO2+/bT4EMP0iFzQh1ddNYqJDdhQlMJZYBC/xgfxbyNt12bWndebJrQ+3tIG?=
 =?us-ascii?Q?QVleamTHIsQJGIP+wwg3ZbuisOYDVqLyy9wiYTELod/Vz0oNuXqAd76O973v?=
 =?us-ascii?Q?o4t3c5rsstc0vmYrA13hV/61nmUxqB6drHUesIhsov5k54yazh/6Es7QDPPa?=
 =?us-ascii?Q?y5DD6TYwHosfJcx+GZQ77N4HEyUvhWbGSQYELM8QWpBSjRfTPI0kkK0ZV5mY?=
 =?us-ascii?Q?YhmFb5sz40vzid6wXMPrJjIi7JZZNTFQXIEyNCpKJwnHFCGBNLE85OLmqmPy?=
 =?us-ascii?Q?A8Tvq19SdSa/N4OBM7uzxgAsslzvRfEJDFd6C32Rvj2iZXuU0H89agR+cm5o?=
 =?us-ascii?Q?ZCeZ7N22xaO3XN5MMCKUgNHhPMXPP6UNwkF6HON75gXsRVqXaBVfeJ5AwrWq?=
 =?us-ascii?Q?6gDCNqunIV8veie4pNb7ga4g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad21cc2f-066f-44d7-85e7-08d8ee35bf69
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 19:56:28.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qrZGp0CgApMos6tA0Ogx+HTz43JEzVwTYS1KUtXhohxHHKJ0D5misYz+FdtCdf/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 12, 2021 at 05:48:26PM +0800, Weihang Li wrote:

> +static int hns_roce_query_func_info(struct hns_roce_dev *hr_dev)
> +{
> +	struct hns_roce_pf_func_info *resp;
> +	struct hns_roce_cmq_desc desc;
> +	int ret;
> +
> +	if (hr_dev->pci_dev->revision < PCI_REVISION_ID_HIP09)
> +		return 0;
> +
> +	hns_roce_cmq_setup_basic_desc(&desc, HNS_ROCE_OPC_QUERY_FUNC_INFO,
> +				      true);
> +	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
> +	if (ret)
> +		return ret;
> +
> +	resp = (struct hns_roce_pf_func_info *)desc.data;

WTF is this cast?

struct hns_roce_cmq_desc {
        __le16 opcode;
        __le16 flag;
        __le16 retval;
        __le16 rsv;
        __le32 data[6];
};

Casting __le32 to a pointer is wrong

Jason
