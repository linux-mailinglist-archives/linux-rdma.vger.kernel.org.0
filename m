Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDB188E7A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 20:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgCQT7k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 15:59:40 -0400
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:5442
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbgCQT7j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 15:59:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ym2JXsMXaWfsqHVV+oXBidTjis5pBUr99jmnAItoRS6KOLnoU/Rcu172Z9h6GDyk6yyPgKGqihwVQLVKoXJXkEVysNsID9dpJLyEcPdWReQoEB0A2OpfgxNVf+Ch5cLHsRQeiluR1Dr5cCc47YmXDViBkIFtDvTSVMDOhLUNWBRCKcBD0oEjv40Jfw/w9Iqpu0vvinhOaQrXIPpwdfk4MXm4DSW39YXYra1x4BiTTd2XHSAgO5xHLciqkCfdfwg+SCJkmhBLrGP6dEJnh5wZ+3KeHa3+f/JI8FspDP+eZzUcgGmmWEdwZuj/tfkLXaoMta6uAo2q6WuDgZkejaNUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOv4P6Vqwf7iZRgfhwCMByH2D0pS4SdKgenwWGBMy0c=;
 b=Nyn4Q7LBnDf1cG45ltQS3wig5AgkWuuDTMkD5JNhLBEm91E8hw3/gMxd4zw4nM9TI2RHMvmwU1GpNv64vTWLEUSX6CPPzao1DqInES0eCf0pezgPhFFfkP2XcaF+MozcDeQVybFCO0Tx8mgcPbGUiETiSdx8mrlbMkfPVs/Nh1lXYrCiAXb8gSsYvks0/FZBmG/R/qpdUlUmpA4/GPs/xwCp1vInN6AtqICZgu0pwK1oLuwPbUzt3Lhz0dhMF37pFPEcdmtJoqZ9tIVE+hk3nMAbmO6m2lbicMN5CaDycDZC6DQpqbSLCYoLknIO5wb8xSnS+FPkzEN4P3HHEhEAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOv4P6Vqwf7iZRgfhwCMByH2D0pS4SdKgenwWGBMy0c=;
 b=J98lOg2LmAQAl8jTaj905Z8maDfr0cQTN1Y2HXcJlYw6Fq26lNWvNe7ddFFjocWNMIOGsno/aILuajpOkrLuSZrbk0NrjKDTb7rLgk/9PCVqPkXNU9ObV251XAPt+ZglRQtXF7nxw228XePRafuKG6p61sMnIaqfIHOvI8ufGgw=
Received: from DB6P192CA0024.EURP192.PROD.OUTLOOK.COM (2603:10a6:4:b8::34) by
 VI1PR05MB3183.eurprd05.prod.outlook.com (2603:10a6:802:1b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 19:59:32 +0000
Received: from DB5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:b8:cafe::3b) by DB6P192CA0024.outlook.office365.com
 (2603:10a6:4:b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 17 Mar 2020 19:59:32 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT040.mail.protection.outlook.com (10.152.20.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 19:59:32 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 17 Mar 2020 20:25:07
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 17 Mar 2020 20:25:07 +0200
Received: from [172.27.14.181] (172.27.14.181) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Mar 2020 20:24:31
 +0200
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <loberman@redhat.com>, <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>, <kbusch@kernel.org>,
        <dledford@redhat.com>, <idanb@mellanox.com>,
        <shlomin@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com> <20200317135518.GG3351@unreal>
 <46bb23ed-2941-2eaa-511a-3d0f3b09a9ed@mellanox.com>
 <20200317181036.GX13183@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <290500dc-7a89-2326-2abf-1ab9f613162e@mellanox.com>
Date:   Tue, 17 Mar 2020 20:24:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317181036.GX13183@mellanox.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.27.14.181]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(199004)(46966005)(70586007)(81166006)(4326008)(70206006)(2906002)(81156014)(2616005)(356004)(36756003)(4744005)(37006003)(54906003)(336012)(8936002)(53546011)(8676002)(107886003)(16526019)(47076004)(186003)(31686004)(6636002)(26005)(478600001)(16576012)(86362001)(316002)(6862004)(31696002)(5660300002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3183;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e40bd954-3012-41c5-304f-08d7caadb5fc
X-MS-TrafficTypeDiagnostic: VI1PR05MB3183:
X-Microsoft-Antispam-PRVS: <VI1PR05MB318393DA47B90AB50538430BB6F60@VI1PR05MB3183.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0345CFD558
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITpHa1c3tGTS4ZOzAmPGwxsAoOHUXt9+yKNlNhsTDOthwf11pO0/PYG51HKf5AEY8XDaxMuVe26mJ5mV2TO1QbbPuzBMkgKQHUKQN9GaU9pCjmyuQhwomRj7B7z0NoNtInZxrBxkOO9KJOCkfdEoHRR04dCskoC2xSqMuaISyl7TLpDBMvH+XOAUMyY1fSNDC+Vb1jkEtT6SVVv7cR6GIr0CEELxWemd4T54bYh08uBXNBFp8Vb7s4QkI6gSCGGCKxlzu0EBSdXDVbOsJNi5RshAt3Ma9DSFq4z3XxOXPD6jA67QaKpQHZWtAw8EYeOkAUluW7fJz0cJO4NTQx1rMSyLQR7STn7L1q9+y9fLbb44aNQsnBbGaCLYNNxBopBrz2TZ/JxX740eeo0RjhQlNk1erkpFQ9f6VC1pQKtr1ff1gjunKA0AJKfoinBpEvHe1CPcet+F+xeJG7DOxE7DxRejOWpH14M2+qCDOfDSlAN5uJL2G0ZQjGlmpMTQZT1hBUDWJ6gTjGI+bYknLs/e8jwKDZ8ZLhPl0H+lLxqodMk=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 19:59:32.5639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e40bd954-3012-41c5-304f-08d7caadb5fc
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3183
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/17/2020 8:10 PM, Jason Gunthorpe wrote:
> On Tue, Mar 17, 2020 at 06:37:57PM +0200, Max Gurtovoy wrote:
>
>>>> +#include <rdma/ib_verbs.h>
>>>> +
>>>> +struct ib_srq *rdma_srq_get(struct ib_pd *pd);
>>>> +void rdma_srq_put(struct ib_pd *pd, struct ib_srq *srq);
>>> At the end, it is not get/put semantics but more add/remove.
>> srq = rdma_srq_add ?
>>
>> rdma_srq_remove(pd, srq) ?
>>
>> Doesn't seems right to me.
>>
>> Lets make it simple. For asking a SRQ from the PD set lets use rdma_srq_get
>> and returning to we'll use rdma_srq_put.
> Is there reference couting here? get/put should be restricted to
> refcounting APIs, IMHO.

I've added a counter (pd->srqs_used) that Leon asked to remove .

There is no call to kref get/put here.

Do you prefer that I'll change it to be array in PD: "struct 
ib_srq           **srqs;" ?

And update ib_alloc_pd API to get pd_attrs and allocate the array during 
PD allocation ?

>
> Jason
