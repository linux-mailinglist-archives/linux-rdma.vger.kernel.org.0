Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B1118AEBE
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 09:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCSItI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 04:49:08 -0400
Received: from mail-am6eur05on2041.outbound.protection.outlook.com ([40.107.22.41]:15200
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbgCSItI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 04:49:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNrs5rstxgC61GhC5Shi3F5BKIKrqe/nL3NFTDUDycFkRhXsaeZ1Qr+ei8HSmtYUBWYupyo+CEpd4XnKJw/AefvZYCRIvte+11YzuRlT3AIRywgrsErKlFdW2aSvmb5fCyteIvE8BNunYH7MWjcWyxFGJ+c9ml6MlKn1Jp4Xkd4yvaMkSXsQ+8fLueKlQ7y193GlUum6JYd8zHBiUJihYaTP2sRRJjQaknaIIqeE6IbF+IDEnrsytsC6xBotX5EuP8KDjJZiLvHOPg+tNBjdn2o1R/9WYJHwC5QryNBMDzqwDvpLPeJMp38nRgd3R0kwuPdpoSLZIK9gWGI239iFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUaTL1BHC1dmWGM+VxpXnW42dA5cOIodaGb8gzwvens=;
 b=WhlkpAQ2jHFV77AnFcZX/h8fFT8lrB93KnxqImv5iVdwBZGc7e+NWvaaaUIYbev9L+fNdbNRKOWz8i0CqwLEOeXygyW0XsmIFbiHFWgR0cI/IAEElNlgVdjtS/6OKchZYdAULQkB6vlLSW0aibnccJ+LC04MxJHpm+T0ZqXdBQLMagYV99ZbDkqGVnpEDmaZrRU0q69VGmazs4T/TJDg3PIgs7jrkVPhUdjKSDuhWpFV1c8JvpENcJ2/ltLNrcdP2y3m4THCp4VMWI5Fwh9+gOwSGlZ0nOJTZ7b9lWiUJsLd5e+Xt3cONaTiKjRZQ6LW5S9LJ8RHayC7ZQLpb2qxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUaTL1BHC1dmWGM+VxpXnW42dA5cOIodaGb8gzwvens=;
 b=HNyNuNEqktBOrTTlNo6b7CeJFsgs2SZMCGrr4ok4DzGxRLYpdybt9e9ehrzZulrdpfZscTxJcNHPKz6gDXTsSVZSbpAqJ7i+FpMVRz67UvQBmJopRQyWXCjtrlrTxceLARutwozxTBWem93gmGYKMRRDqTCG/xb09+i04zOmO08=
Received: from AM7PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:20b:110::24)
 by DB6PR0501MB2534.eurprd05.prod.outlook.com (2603:10a6:4:5f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Thu, 19 Mar
 2020 08:49:03 +0000
Received: from AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::b1) by AM7PR04CA0014.outlook.office365.com
 (2603:10a6:20b:110::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Thu, 19 Mar 2020 08:49:03 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT015.mail.protection.outlook.com (10.152.16.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Thu, 19 Mar 2020 08:49:02 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 19 Mar 2020 10:49:02
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 19 Mar 2020 10:49:02 +0200
Received: from [172.27.15.129] (172.27.15.129) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 19 Mar 2020 10:48:22
 +0200
Subject: Re: [PATCH v2 2/5] nvmet-rdma: add srq pointer to rdma_cmd
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <loberman@redhat.com>, <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>, <kbusch@kernel.org>,
        <leonro@mellanox.com>, <dledford@redhat.com>, <idanb@mellanox.com>,
        <shlomin@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <rgirase@redhat.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-3-maxg@mellanox.com>
 <20200318233258.GR13183@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <1a79f626-c358-2941-4e8e-492f5f7de133@mellanox.com>
Date:   Thu, 19 Mar 2020 10:48:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318233258.GR13183@mellanox.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.15.129]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(199004)(46966005)(6636002)(5660300002)(53546011)(81156014)(26005)(86362001)(81166006)(2906002)(8936002)(8676002)(31686004)(4326008)(31696002)(4744005)(186003)(16526019)(70206006)(2616005)(966005)(336012)(70586007)(478600001)(37006003)(36906005)(16576012)(316002)(6862004)(47076004)(36756003)(54906003)(356004)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2534;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a17c6b84-14fb-42f9-7a1d-08d7cbe2600f
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2534:
X-Microsoft-Antispam-PRVS: <DB6PR0501MB25341EA9036A3BC1312D666CB6F40@DB6PR0501MB2534.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0347410860
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bafhM6y/5CtXy5tLqaKArCXHr5KfHlqInEbE4JPO/KrGYD84dZ+XXJmMnFT4mZZ9Jd1RTxGiO0ND2+MmkPXHmaYz/nwVsF1mQXFHaY5m/AbyrkrqvC2XtwVA7jKGD7kqF5DRCFxOQmDmK+N/rTiopRF9Spm2ZnDZ6vQTn2bzMWj2A3THjOp4ADCFVrNS8DtuGdjtwTX0mieohgQl3RkVnUd3sSv3IHgJHOWW/iaIU3lU1Q0QX9m/NOCtlPsdTmhfQGGwGhxe3adozdy5p2X8DnmegPGYtHnvh6dJQlfWkeZOUFemBXhN1oxQbxec2nYJFO2PGmhDXbPvcFQB4K+CYi5OuK4vQsbILBWRgfCkeGtoMTgw5grZX26t25oaxGSJZxge6C6ucj2w+xVhhCxvWAHJB4GSCK5EBGtazB80HK7i2ptzr1GEdGZseMloBxFu6sBPaw3Ta6L/+fv/YYWTcoZHH7nwXWY6LVTyetBoBIDPcBhs4PexEaut95C7GiJXaPZcZrrHQUMM7AGxzJN7c4VXxRgjBmhHtbRj4rXuszUnyjkHmbCVg1S6+egy6x55K6ykdpZqm+pMp51/Eh6NbvBYoFVpOSQzQjuL6K8hfScC2mN3BQryW3tn0lPehrX9
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 08:49:02.9077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17c6b84-14fb-42f9-7a1d-08d7cbe2600f
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2534
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/19/2020 1:32 AM, Jason Gunthorpe wrote:
> On Wed, Mar 18, 2020 at 05:02:54PM +0200, Max Gurtovoy wrote:
>> This is a preparetion patch for the SRQ per completion vector feature.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>>   drivers/nvme/target/rdma.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
> Max, how are you sending these emails, and why don't they thread
> properly on patchworks:
>
> https://patchwork.kernel.org/project/linux-rdma/list/?series=258271
>
> This patch is missing from the series
>
> v1 had the same issue
>
> Very strange. Can you fix it?

I'm using "git send-email".

Should I use some special flags or CC another email for it ?

How do you suggest sending patches so we'll see it on patchworks ?

>
> Jason
