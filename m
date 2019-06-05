Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB81A3684F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 01:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFEXpK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 19:45:10 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:22248
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726836AbfFEXpK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 19:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxPpD4AQm0mt6YsEMxJVxOWBdQVGWBFvbN3gSmcf+CY=;
 b=CZ8rsuRXY5fd/v6r3xhRjPTrg5a/K4LkQP9uqezNQhrvJSa3Koc3HT/mMA61zENQMZKNvK6NhqpMmgBoZwy+TWWvr/yZWYJ2Nx8yhLo1bc3N2eaBhYE9svkf2OwAdQfe1P471dOksOhjhSizMvpJmOfKA2Mdxd1K3FVw8hL1XsI=
Received: from HE1PR05CA0211.eurprd05.prod.outlook.com (2603:10a6:3:fa::11) by
 AM6PR05MB6422.eurprd05.prod.outlook.com (2603:10a6:20b:bb::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 5 Jun 2019 23:45:04 +0000
Received: from VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by HE1PR05CA0211.outlook.office365.com
 (2603:10a6:3:fa::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.12 via Frontend
 Transport; Wed, 5 Jun 2019 23:45:04 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT030.mail.protection.outlook.com (10.152.18.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Wed, 5 Jun 2019 23:45:03 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 6 Jun 2019 02:45:03
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 6 Jun 2019 02:45:03 +0300
Received: from [172.16.0.12] (172.16.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 6 Jun 2019 02:44:59
 +0300
Subject: Re: [PATCH 18/20] RDMA/mlx5: Improve PI handover performance
To:     Sagi Grimberg <sagi@grimberg.me>, <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, <jgg@mellanox.com>,
        <dledford@redhat.com>, <hch@lst.de>, <bvanassche@acm.org>
CC:     <israelr@mellanox.com>, <idanb@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-19-git-send-email-maxg@mellanox.com>
 <b3055107-a91a-a62b-a642-82d14fe3209b@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <11c5be7b-05c1-29aa-b407-a4a2655ea288@mellanox.com>
Date:   Thu, 6 Jun 2019 02:44:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b3055107-a91a-a62b-a642-82d14fe3209b@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.16.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(76176011)(2870700001)(8936002)(16576012)(26005)(229853002)(5660300002)(2201001)(53546011)(54906003)(356004)(486006)(70206006)(336012)(70586007)(81156014)(81166006)(64126003)(14444005)(4326008)(31696002)(8676002)(86362001)(67846002)(316002)(58126008)(107886003)(31686004)(36756003)(2906002)(110136005)(305945005)(7736002)(50466002)(11346002)(77096007)(476003)(65826007)(478600001)(126002)(2616005)(16526019)(65956001)(186003)(65806001)(23676004)(6246003)(3846002)(106002)(446003)(6116002)(2486003)(47776003)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6422;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82fe069c-e75e-468e-6fa9-08d6ea0fd534
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR05MB6422;
X-MS-TrafficTypeDiagnostic: AM6PR05MB6422:
X-Microsoft-Antispam-PRVS: <AM6PR05MB642270F8A3D9191C5091AA01B6160@AM6PR05MB6422.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +6gB578C582EBQiBFzKi6tWxEHC5aHZUxhHNVy9Ihzc/I0PNXQYfVRGXRbXc1cbhYw91rFfVx9uS9DsCuaPqNSGNgP47OiiHux7TJhprOpDR6XjK1AAo0RB8JDX2Imk6HGFa3QDnX1DL2AsBBlTAe3lA/gQgcETSb5fh56AWWrnLYswhdeswCmLU342Vzw9VbTSRCWgcC/PZFWkNSIp3EDYIqyDMtzy7XGaiHsdUreAh+j/mM/cNesfNw2ZTHb9AgYzcKtsAh8lyJKll5Ho2JBn3YmkXRY+FS1e3ZESIRncKCr6EpGiDwee9Mq0FNlX81GcWZmpYnUO78RwxUiIuthzgWAbaVOY0A6NedqfzSyVNBrqfeiNDhM81awRIoEqxP6BvJ4I0R9kt/Q/KqFhfx//HUgneBwE1nr74mz5sMPc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 23:45:03.9925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fe069c-e75e-468e-6fa9-08d6ea0fd534
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6422
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/6/2019 1:52 AM, Sagi Grimberg wrote:
>
>> In some loads, there is performace
>
> typo
>
>  degradation when using KLM mkey
>> instead of MTT mkey. This is because KLM descriptor access is via
>> indirection that might require more HW resources and cycles.
>> Using KLM descriptor is not nessecery
>
> typo
>
>  when there are no gaps at the
>> data/metadata sg lists. As an optimization, use MTT mkey whenever it
>> is possible. For that matter, allocate internal MTT mkey and choose the
>> effective pi_mr for in transaction according to the required mapping
>> scheme.
>
> You just doubled the number of resources (mrs+page_vectors) allocated
> for a performance optimization (25% in large writes). I'm asking myself
> if that is that acceptable? We tend to allocate a lot of those (not to
> mention the target side).

We're using same amount of mkey's as before (sig + data + meta mkeys vs. 
sig + internal_klm + internal_mtt mkey).

And we save their invalidations (of the internal mkeys).

>
> I'm not sure what is the correct answer here, I'm just wandering if this
> is what we want to do. We have seen people bound by the max_mrs
> limitation before, and this is making it worse (at least for the pi 
> case).

it's not (see above). The limitation of mkeys is mostly with older HCA's 
that are not signature capable.

>
> Anyways, just wanted to raise the concern. You guys are probably a lot
> more familiar than I am on the usage patterns of this and if this is
> a real problem or not...
>
>> +int mlx5_ib_map_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist 
>> *data_sg,
>> +             int data_sg_nents, unsigned int *data_sg_offset,
>> +             struct scatterlist *meta_sg, int meta_sg_nents,
>> +             unsigned int *meta_sg_offset)
>> +{
>> +    struct mlx5_ib_mr *mr = to_mmr(ibmr);
>> +    struct mlx5_ib_mr *pi_mr = mr->mtt_mr;
>> +    int n;
>> +
>> +    WARN_ON(ibmr->type != IB_MR_TYPE_INTEGRITY);
>> +
>> +    /*
>> +     * As a performance optimization, if possible, there is no need 
>> to map
>> +     * the sg lists to KLM descriptors. First try to map the sg 
>> lists to MTT
>> +     * descriptors and fallback to KLM only in case of a failure.
>> +     * It's more efficient for the HW to work with MTT descriptors
>> +     * (especially in high load).
>> +     * Use KLM (indirect access) only if it's mandatory.
>> +     */
>> +    n = mlx5_ib_map_mtt_mr_sg_pi(ibmr, data_sg, data_sg_nents,
>> +                     data_sg_offset, meta_sg, meta_sg_nents,
>> +                     meta_sg_offset);
>> +    if (n == data_sg_nents + meta_sg_nents)
>> +        goto out;
>> +
>> +    pi_mr = mr->klm_mr;
>> +    n = mlx5_ib_map_klm_mr_sg_pi(ibmr, data_sg, data_sg_nents,
>> +                     data_sg_offset, meta_sg, meta_sg_nents,
>> +                     meta_sg_offset);
>
> Does this have any impact when all your I/O is gappy?
>
you mean trying to do a MTT mapping and fail ? I think it's a non-issue.


> IIRC it was fairly easy to simulate that by running small block size
> sequential I/O with an I/O scheduler (to a real device).
>
> Would be interesting to measure the impact of the fallback?

I hope I'll have some spare time to add a flag to fio that will issue a 
gappy I/O always...

Maybe when I'll add an optimization to the SG_GAP MR (and not bound it 
to KLM as it now) and add it to NVMeoF/RDMA initiator stack.


>
> Although I don't have any better suggestion other than signal
> the application that you always want I/O without gaps (which poses
> a different limitation)...

We can deal with gappy and non-gappy IO so application can send what 
ever makes it run fast.

