Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F75341FC
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 10:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfFDIh5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 04:37:57 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:17376
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfFDIh4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 04:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGOp1m0nSp8GF2pO+9ga283PZrOQdgTSsSvONNEpO2A=;
 b=Wgh+92Qj3AIL5endcOuLnCFe6VwRJBwgG5KWgZqJ7P7EfLxWhhHPphOG/jcXFTjujqqwxv0JTZb7LPuhHV5OX2PBNq0XIa1Oj8xmVx1gtqa50kfjp6cVBXDr2Q1r9P3TPDPcMVYKaKjHF3+70OGwEmw3+/02UELHSGEd4zZIB6c=
Received: from AM5PR0502CA0001.eurprd05.prod.outlook.com
 (2603:10a6:203:91::11) by VI1PR05MB6429.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.21; Tue, 4 Jun
 2019 08:37:52 +0000
Received: from VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by AM5PR0502CA0001.outlook.office365.com
 (2603:10a6:203:91::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.18 via Frontend
 Transport; Tue, 4 Jun 2019 08:37:52 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT011.mail.protection.outlook.com (10.152.18.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1943.19 via Frontend Transport; Tue, 4 Jun 2019 08:37:52 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 4 Jun 2019 11:37:51
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 4 Jun 2019 11:37:51 +0300
Received: from [172.16.0.17] (172.16.0.17) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Tue, 4 Jun 2019 11:36:56
 +0300
Subject: Re: [PATCH 06/20] RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
 mlx5_ib_alloc_mr_integrity
To:     Christoph Hellwig <hch@lst.de>
CC:     <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <jgg@mellanox.com>, <dledford@redhat.com>, <sagi@grimberg.me>,
        <bvanassche@acm.org>, <israelr@mellanox.com>, <idanb@mellanox.com>,
        <oren@mellanox.com>, <vladimirk@mellanox.com>,
        <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-7-git-send-email-maxg@mellanox.com>
 <20190604073851.GO15680@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <1481c955-b6fa-abce-94ea-3eea62c9d18f@mellanox.com>
Date:   Tue, 4 Jun 2019 11:36:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604073851.GO15680@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.17]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(199004)(189003)(65826007)(6916009)(356004)(36756003)(316002)(54906003)(126002)(50466002)(65806001)(86362001)(67846002)(26005)(486006)(47776003)(8676002)(4744005)(81166006)(81156014)(106002)(7736002)(8936002)(64126003)(77096007)(305945005)(16526019)(476003)(508600001)(2616005)(186003)(6116002)(2486003)(23676004)(70586007)(70206006)(230700001)(65956001)(76176011)(31696002)(53546011)(16576012)(6246003)(229853002)(4326008)(58126008)(5660300002)(107886003)(446003)(3846002)(336012)(11346002)(31686004)(2906002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6429;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ca11f2f-da7e-496a-81b7-08d6e8c7eed9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB6429;
X-MS-TrafficTypeDiagnostic: VI1PR05MB6429:
X-Microsoft-Antispam-PRVS: <VI1PR05MB64295779A19C8AB12F4A560DB6150@VI1PR05MB6429.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0058ABBBC7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 1h8C0P+BAMVH1KCqYuzvfdSGr/lIy7XJYp3dqeEs1THgw2AANrYFiOXxOm3q5Bv1JeeyTJQWuhEj9eaf+i1dWgm9KZAgPDE9aMtqFWeqp4ZhzJYGAgLeNVdlDez5/AHeQWwLgFK6k4TWWZwmT0WIBmEQpEPEqD/ea2Evu30A2uNUjbqCuf25q8kdj+38XgeSEyZW6uLGiByST0ecZOUpFCN2yLIZSpliYFAzueV69OGLgVyqEUOxUGKEdnalXvMA67yJj3+kb4YlyJrVcycGGaJjh9lsLDqB7rVB++j/MXqwSYviRUOs9r3q9orXFzR2l9/ZY73fbffvP84rDETZJPzMHo3z21IPUCefywo71zrN4KF9nqpzUTvcyj6KGcUl998Y08kwD1zncoOH45HI62COwyJgUMibFRbx4RxmKlQ=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2019 08:37:52.0009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca11f2f-da7e-496a-81b7-08d6e8c7eed9
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6429
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/4/2019 10:38 AM, Christoph Hellwig wrote:
>>   int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>>   {
>> -	dereg_mr(to_mdev(ibmr->device), to_mmr(ibmr));
>> +	struct mlx5_ib_mr *mmr = to_mmr(ibmr);
>> +
>> +	if (ibmr->type == IB_MR_TYPE_INTEGRITY)
>> +		dereg_mr(to_mdev(mmr->pi_mr->ibmr.device), mmr->pi_mr);
>> +
>> +	dereg_mr(to_mdev(ibmr->device), mmr);
> Just curious: how could the device for the PI MR be different?  In other
> words, why can't this just be:

The device is not different but we need to do both dereg_mr(mdev, 
mmr->pi_mr) and dereg_mr(mdev, mmr).

>
> 	struct mlx5_ib_mr *mmr = to_mmr(ibmr);
>
> 	if (ibmr->type == IB_MR_TYPE_INTEGRITY)
> 		mmr = mmr->pi_mr;
> 	dereg_mr(to_mdev(ibmr->device), mmr);
>
