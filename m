Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0F34218
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 10:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfFDIod (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 04:44:33 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:18819
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfFDIod (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jun 2019 04:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHyF1DIWQY8nBpj79ZRzdQAt8uh/+u8b/DGWZYJDqrA=;
 b=VTGSk8FpEDLxZ56EcRSYWo37YHo3k1nVq4ej6EjpOd0khU5uC1b8nKIzyLMrrQiiBgmN11JW6lgmjXXeJaSclrS34d8qSYXRm2/AOglN7Za7/CHxu3+5LOcrxKDsFF6q84wuMGJKZ0/aGTj5h8iPXZ36JDFthFWvhaU4t5GruJ4=
Received: from DB6PR05CA0004.eurprd05.prod.outlook.com (2603:10a6:6:14::17) by
 DBBPR05MB6425.eurprd05.prod.outlook.com (2603:10a6:10:c9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Tue, 4 Jun 2019 08:44:28 +0000
Received: from VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by DB6PR05CA0004.outlook.office365.com
 (2603:10a6:6:14::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.16 via Frontend
 Transport; Tue, 4 Jun 2019 08:44:27 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT025.mail.protection.outlook.com (10.152.18.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1943.19 via Frontend Transport; Tue, 4 Jun 2019 08:44:27 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 4 Jun 2019 11:44:26
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 4 Jun 2019 11:44:26 +0300
Received: from [172.16.0.17] (172.16.0.17) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Tue, 4 Jun 2019 11:44:24
 +0300
Subject: Re: [PATCH 11/20] IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
To:     Christoph Hellwig <hch@lst.de>
CC:     <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <jgg@mellanox.com>, <dledford@redhat.com>, <sagi@grimberg.me>,
        <bvanassche@acm.org>, <israelr@mellanox.com>, <idanb@mellanox.com>,
        <oren@mellanox.com>, <vladimirk@mellanox.com>,
        <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-12-git-send-email-maxg@mellanox.com>
 <20190604074300.GP15680@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0739949f-a069-289a-576b-d9253acc4d6e@mellanox.com>
Date:   Tue, 4 Jun 2019 11:44:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604074300.GP15680@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.17]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(199004)(189003)(26005)(186003)(5660300002)(16526019)(67846002)(2906002)(77096007)(76176011)(230700001)(31686004)(23676004)(2486003)(2616005)(476003)(126002)(7736002)(305945005)(3846002)(6116002)(508600001)(486006)(336012)(54906003)(81166006)(8676002)(8936002)(81156014)(4744005)(53546011)(58126008)(446003)(106002)(11346002)(356004)(50466002)(107886003)(65956001)(65806001)(36756003)(6246003)(4326008)(70206006)(70586007)(64126003)(65826007)(86362001)(6916009)(31696002)(16576012)(316002)(47776003)(229853002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6425;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f8b4c23-d1d5-4e1c-d8a6-08d6e8c8da93
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DBBPR05MB6425;
X-MS-TrafficTypeDiagnostic: DBBPR05MB6425:
X-Microsoft-Antispam-PRVS: <DBBPR05MB6425FFF699331F40E5FDF2DCB6150@DBBPR05MB6425.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0058ABBBC7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: NzVFKB8kXzOMXO8eyZyJrGq2D+89X5+ZzMRTr5EWDJRjVqkejWt0GByH0janFVT1FeXP/UGH1TL50aSBJKm7czhsa9P3X6tqJ25UHvQl2l3l7HL2ra9EMPFpwyrwDG1lT1Ds7jnsmGCgSSh2pFUs/77MvE7NiiVTy8edKtKArWjfRHxQMUgrQriH6ij1kWfykMb00lXzeW60+OYfa4wWvTYA4N/4L91TzQLLc67jW8v5iVaip0FJ0lrEkH9pjElxZC4O25mLhmSR/2wyhmqqLzmWatP2WF5YkSaucprbBW4S7ECH4u2ktUuYrBfHcDzJctcVE8TADmT5ILzCAUKV23nHumiDQb4SCERJ1QrYMQyZyoYCrHpeP05h2YsYNbU3505znmPzDMrKlp+Tdkpb6HJkNy1TdTVS9hQj4dNBHvA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2019 08:44:27.4536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8b4c23-d1d5-4e1c-d8a6-08d6e8c8da93
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6425
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/4/2019 10:43 AM, Christoph Hellwig wrote:
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> On something very vaguely related:  Can one of you look into dropping
> FMR support in iser/isert now that NFS as the other major user has
> dropped support as well?

Yes I think we mentioned this. Sagi has patches for that and we'll merge 
it on top of this series.


