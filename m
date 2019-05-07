Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF316585
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEGOSk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 10:18:40 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:18112
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbfEGOSk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 10:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAnfx2gMV9Znc2c6mniy5R0FhYqIcqvDVR6dbIf4/tQ=;
 b=a4eZpj56IA+uP68hsKcoJLPV299BvX22cq1seIki9y6nX1how+kYjtZ3EVHN82NNDOE4pp/ov5SY/1AhTLkJlcQHu1lV/iKEGialXZJcu6Xd/9/FDlIlcxa/d/wBhZg4BiFb5ipX1+rNGFmD7yfYg9apvr8EWoD1tu1RmLZC56M=
Received: from HE1PR0502CA0003.eurprd05.prod.outlook.com (10.175.36.141) by
 AM6PR0502MB4054.eurprd05.prod.outlook.com (52.133.30.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 7 May 2019 14:18:31 +0000
Received: from VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by HE1PR0502CA0003.outlook.office365.com
 (2603:10a6:3:e3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1856.10 via Frontend
 Transport; Tue, 7 May 2019 14:18:31 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT046.mail.protection.outlook.com (10.152.19.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Tue, 7 May 2019 14:18:30 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 7 May 2019 17:18:30
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 7 May 2019 17:18:30 +0300
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Tue, 7 May 2019 17:17:47
 +0300
Subject: Re: [PATCH 00/25 V4] Introduce new API for T10-PI offload
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Israel Rukshin <israelr@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Oren Duer <oren@mellanox.com>,
        Vladimir Koushnir <vladimirk@mellanox.com>,
        "Shlomi Nimrodi" <shlomin@mellanox.com>
References: <1557236319-9986-1-git-send-email-maxg@mellanox.com>
 <20190507134217.GX6186@mellanox.com>
 <2e3d9da7-d4fa-e2fa-5d3b-e60c54e7f7ba@mellanox.com>
 <20190507140818.GZ6186@mellanox.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <1378a723-81c8-63f3-c863-2e7b130eccd0@mellanox.com>
Date:   Tue, 7 May 2019 17:17:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507140818.GZ6186@mellanox.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(199004)(189003)(478600001)(6116002)(77096007)(2906002)(230700001)(6636002)(31686004)(7736002)(70586007)(305945005)(36756003)(65826007)(50466002)(70206006)(31696002)(126002)(14444005)(81166006)(81156014)(8676002)(86362001)(64126003)(2616005)(476003)(3846002)(16526019)(186003)(76176011)(486006)(53546011)(6862004)(336012)(356004)(4326008)(446003)(6246003)(8936002)(67846002)(5660300002)(11346002)(107886003)(229853002)(54906003)(47776003)(65806001)(16576012)(65956001)(106002)(58126008)(316002)(26005)(23676004)(2486003)(37006003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0502MB4054;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 890a2750-7943-4038-0bc8-08d6d2f6e1ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:AM6PR0502MB4054;
X-MS-TrafficTypeDiagnostic: AM6PR0502MB4054:
X-Microsoft-Antispam-PRVS: <AM6PR0502MB4054FACAC3DD3D0F723F9979B6310@AM6PR0502MB4054.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0030839EEE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PvFO/NpRabSQzWJIE6uI+qBESvK3tVfDMfxKDIq80BAbrw6iy3u02JUoGPpik6Ik9LvB+8p/eIRj7oIqdoCuNAF2xqcgr8vqttj4RiHPpViAGsFDC+7QZzGeECSaHco1EFTkk7EavNuU7hwVJVNBqFxkv+8dOuxUtMenOBne+brA9jWck6jBXj9LkvRH1jVsgZDKG0SivF4ZYuuDUo1kd9ZT+wdOzZBw+/epnKmhPFt8K55nYoeUMcfAzInNJ2QPFnXADLqBu9DrWEqX15C/PVWNhug9h/I7mtR5eUODMMp9cnnj8kKmLTBhse/mUWREqgpCIy2N+IwysWor8RDOzYyEpVYLe8MSQkNgqVtUbItkIs4omrm7aoVG/OOZSgFuChIAmjtIYhpbxXnigRYaqUqBHe7pmnH0J3z4MoEysgA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2019 14:18:30.9244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 890a2750-7943-4038-0bc8-08d6d2f6e1ca
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB4054
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/7/2019 5:08 PM, Jason Gunthorpe wrote:
> On Tue, May 07, 2019 at 04:54:56PM +0300, Max Gurtovoy wrote:
>> On 5/7/2019 4:42 PM, Jason Gunthorpe wrote:
>>> On Tue, May 07, 2019 at 04:38:14PM +0300, Max Gurtovoy wrote:
>>>> Israel Rukshin (12):
>>>>     RDMA/core: Introduce IB_MR_TYPE_INTEGRITY and ib_alloc_mr_integrity
>>>>       API
>>>>     IB/iser: Refactor iscsi_iser_check_protection function
>>>>     IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
>>>>     IB/iser: Unwind WR union at iser_tx_desc
>>>>     IB/iser: Remove unused sig_attrs argument
>>>>     IB/isert: Remove unused sig_attrs argument
>>>>     RDMA/core: Add an integrity MR pool support
>>>>     RDMA/rw: Fix doc typo
>>>>     RDMA/rw: Print the correct number of sig MRs
>>>>     RDMA/rw: Use IB_WR_REG_MR_INTEGRITY for PI handover
>>>>     RDMA/core: Remove unused IB_WR_REG_SIG_MR code
>>>>     RDMA/mlx5: Improve PI handover performance
>>>>
>>>> Max Gurtovoy (13):
>>>>     RDMA/core: Introduce new header file for signature operations
>>>>     RDMA/core: Save the MR type in the ib_mr structure
>>>>     RDMA/core: Introduce ib_map_mr_sg_pi to map data/protection sgl's
>>>>     RDMA/core: Add signature attrs element for ib_mr structure
>>>>     RDMA/mlx5: Implement mlx5_ib_map_mr_sg_pi and
>>>>       mlx5_ib_alloc_mr_integrity
>>>>     RDMA/mlx5: Add attr for max number page list length for PI operation
>>>>     RDMA/mlx5: Pass UMR segment flags instead of boolean
>>>>     RDMA/mlx5: Update set_sig_data_segment attribute for new signature API
>>>>     RDMA/mlx5: Introduce and implement new IB_WR_REG_MR_INTEGRITY work
>>>>       request
>>>>     RDMA/mlx5: Move signature_en attribute from mlx5_qp to ib_qp
>>>>     RDMA/core: Validate signature handover device cap
>>>>     RDMA/rw: Add info regarding SG count failure
>>>>     RDMA/mlx5: Use PA mapping for PI handover
>>> Max this is really too many patches now, can you please split this
>>> up.
>>>
>>> Can several patches be applied right now as bug fixes like:
>>>
>>>      RDMA/rw: Fix doc typo
>>>      RDMA/rw: Print the correct number of sig MRs
>>>      RDMA/core: Remove unused IB_WR_REG_SIG_MR code
>>>      RDMA/rw: Add info regarding SG count failure
>>>
>>> ??
>> Yes we can. Except of "RDMA/core: Remove unused IB_WR_REG_SIG_MR code".
>>
>> Patches that also can be merged now are:
>>
>> "IB/iser: Remove unused sig_attrs argument"
>>
>> "IB/isert: Remove unused sig_attrs argument"
>>
>> what is the merge plan ?
>>
>> are we going to squeeze this to 5.2 or 5.3 ?
> The 5.2 merge window is now open so it will not make 5.2

Can we merge it to your for-5.3 branch after getting green light on this 
series ?


>
>> which branch should we sent the 5 patches from above ?
> It is probably best to repost this thing split up against 5.2-rc1 in
> two weeks, I'll drop it off patchworks until then.

Sure, but please approve it to avoid another review cycle.


> Jason
