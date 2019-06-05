Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3936885
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 01:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFEX7H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 19:59:07 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:57027
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbfFEX7H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 19:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq9qFEV59RihoiFFhtFtNT5mLKJ799I5uL3eoYWyRMY=;
 b=d4oSTDn/gl9ZXJ9+CPPb+00xOuAuYnL5YVgJBT/DaKfhjsyyrnrEBaGej13W6+ZPT9NybU14xWzz9krFIlnCdLs/dRHUztl995ftot4y8T2CwpB0baJ7KkxKOzhXCWxcLp4pSNq2yF35BbOXRMm0nmkfWVHd0PxF950CCpGrEAI=
Received: from AM4PR0501CA0053.eurprd05.prod.outlook.com
 (2603:10a6:200:68::21) by DBBPR05MB6427.eurprd05.prod.outlook.com
 (2603:10a6:10:c9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.22; Wed, 5 Jun
 2019 23:58:58 +0000
Received: from VE1EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by AM4PR0501CA0053.outlook.office365.com
 (2603:10a6:200:68::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.12 via Frontend
 Transport; Wed, 5 Jun 2019 23:58:58 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT016.mail.protection.outlook.com (10.152.18.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Wed, 5 Jun 2019 23:58:57 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 6 Jun 2019 02:58:56
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 6 Jun 2019 02:58:56 +0300
Received: from [172.16.0.12] (172.16.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 6 Jun 2019 02:58:10
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
 <11c5be7b-05c1-29aa-b407-a4a2655ea288@mellanox.com>
 <cd290591-66f8-6665-90b7-0eb4b4d7ffb4@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <5a5e5112-3109-aa9a-899c-6cb54bafc1bb@mellanox.com>
Date:   Thu, 6 Jun 2019 02:58:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cd290591-66f8-6665-90b7-0eb4b4d7ffb4@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(189003)(199004)(65826007)(2906002)(5660300002)(8936002)(336012)(446003)(6246003)(76176011)(36756003)(11346002)(53546011)(230700001)(305945005)(77096007)(26005)(186003)(107886003)(81166006)(478600001)(70206006)(70586007)(8676002)(356004)(64126003)(4326008)(81156014)(16526019)(6116002)(3846002)(54906003)(67846002)(86362001)(486006)(31696002)(110136005)(65956001)(47776003)(65806001)(50466002)(229853002)(106002)(2201001)(476003)(316002)(2486003)(2616005)(7736002)(58126008)(31686004)(16576012)(126002)(23676004)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6427;H:mtlcas13.mtl.com;FPR:;SPF:Pass;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6da7f4d-980f-4b44-ba02-08d6ea11c63e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DBBPR05MB6427;
X-MS-TrafficTypeDiagnostic: DBBPR05MB6427:
X-Microsoft-Antispam-PRVS: <DBBPR05MB64270276E3EF50B85E56B62BB6160@DBBPR05MB6427.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 6Ykqmg3fAiPR6yqnGofVJlKNVjVUn5Wnp9uIC/HzgXPoT/KLhe9ftnYTfm8SOEoisOhLMtlDlPjntae2V1fQ4yzhO8qbFoEvQOnILRNMuc+xYNsZ68BSGbZw+tCmhDuH8xL7gD70rn/nBfOfc3Eag2Xn8WJrxv1EfDyj8bTeReCwByK04zcuwUD/avdm3JKT+gbGun8jendYC+I4GtyleL3fI95jznJQTMUfCwRc36SgB7NqIA+Up2oe29VCjjJewsEP3qpzLxgZzCa/26f2fxDq+CJPuvi0z3BPukux4LFA5VP+kwsEZgInBVLG3QikSkGent+j3Vj2x1DUzkLPf4dkyfBXMCWGF/baQPofQOgRkKO+i/fkWEP/zP9jK6BPLOzLu/hd+13hcTibW7i0QqU3+w6AjQuinnX2zzuYBC4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 23:58:57.7934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6da7f4d-980f-4b44-ba02-08d6ea11c63e
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6427
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/6/2019 2:51 AM, Sagi Grimberg wrote:
>
>>> You just doubled the number of resources (mrs+page_vectors) allocated
>>> for a performance optimization (25% in large writes). I'm asking myself
>>> if that is that acceptable? We tend to allocate a lot of those (not to
>>> mention the target side).
>>
>> We're using same amount of mkey's as before (sig + data + meta mkeys 
>> vs. sig + internal_klm + internal_mtt mkey).
>
> But each mkey has twice of mtt/klm space..

No. It's the same size (I reduced the HCA cap, remember ?)

>
>> And we save their invalidations (of the internal mkeys).
>
> Those are not resources.
>
>>
>>>
>>> I'm not sure what is the correct answer here, I'm just wandering if 
>>> this
>>> is what we want to do. We have seen people bound by the max_mrs
>>> limitation before, and this is making it worse (at least for the pi 
>>> case).
>>
>> it's not (see above). The limitation of mkeys is mostly with older 
>> HCA's that are not signature capable.
>
> Its also sw mr page_vec/sgl... But that is less of a concern as well I 
> guess.
