Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD51C36734
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 00:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFEWGE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 18:06:04 -0400
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]:24392
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfFEWGE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 18:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNDZ68/Gbg9/AOH+XSS3nfToyvKmUl0j2SiTjE0TT6s=;
 b=kR2/0bPFwAZIzjko1+NF1kK03/LeJDUsqxCMVGW5OO9YosDB/LXmQCbdcWEE3h1NYD1NSKnsaX+mOJOEruG/DUspaU1pN9/ds3rZYq0fWFHjHtzoJkcgrhNsulASfw2mDiaPrxeEkJfFHaOvhiYeSuHlU7WaU1YENUo6pfPD+OA=
Received: from HE1PR05CA0216.eurprd05.prod.outlook.com (2603:10a6:3:fa::16) by
 HE1PR0502MB3017.eurprd05.prod.outlook.com (2603:10a6:3:d7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Wed, 5 Jun 2019 22:05:59 +0000
Received: from DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by HE1PR05CA0216.outlook.office365.com
 (2603:10a6:3:fa::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.12 via Frontend
 Transport; Wed, 5 Jun 2019 22:05:59 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT026.mail.protection.outlook.com (10.152.20.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Wed, 5 Jun 2019 22:05:58 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 6 Jun 2019 01:05:57
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 6 Jun 2019 01:05:57 +0300
Received: from [172.16.0.12] (172.16.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 6 Jun 2019 01:05:55
 +0300
Subject: Re: [PATCH 15/20] RDMA/core: Validate signature handover device cap
To:     Sagi Grimberg <sagi@grimberg.me>, <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, <jgg@mellanox.com>,
        <dledford@redhat.com>, <hch@lst.de>, <bvanassche@acm.org>
CC:     <israelr@mellanox.com>, <idanb@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-16-git-send-email-maxg@mellanox.com>
 <4780f87f-98ba-9432-2de9-352bdf8bf5a0@grimberg.me>
 <a69a134b-d0a5-3144-142e-2050ce935037@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <45f75d84-0616-8516-c482-65cbab7b8557@mellanox.com>
Date:   Thu, 6 Jun 2019 01:05:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a69a134b-d0a5-3144-142e-2050ce935037@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.16.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39850400004)(396003)(2980300002)(199004)(189003)(110136005)(229853002)(76176011)(6246003)(478600001)(16576012)(67846002)(16526019)(107886003)(70586007)(70206006)(36756003)(336012)(8936002)(316002)(31686004)(64126003)(54906003)(2906002)(106002)(58126008)(23676004)(2486003)(356004)(3846002)(2870700001)(6116002)(65826007)(11346002)(53546011)(86362001)(4744005)(2201001)(305945005)(7736002)(186003)(2616005)(5660300002)(4326008)(126002)(65806001)(81156014)(486006)(31696002)(50466002)(77096007)(65956001)(81166006)(476003)(26005)(47776003)(446003)(8676002)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3017;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53112511-50a6-4624-64a2-08d6ea01fd89
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:HE1PR0502MB3017;
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3017:
X-Microsoft-Antispam-PRVS: <HE1PR0502MB3017264CF80AD8DCC4BB52BBB6160@HE1PR0502MB3017.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +6/cCVfAt5a8+t1Vi0/9UN3rJqvWglG4h2lKdXt0bbZ55ZYdBYkgg71+z8m7QnoMaAOmHPGB5g6vPfIJdAyvSUitWvcy35eGMnlK67T6L6CbJ7VfIrEssOm2WS0CazIN0Nnnwlc6DfzIuO0eCmMVKxOi99JUpvd/V6DMJqO5qYxTofq425u6D0nkI7i5ZPTq2b1F4yhEPOAs84+PFCu78etbSiPjSr6/6xqlSXTX57a7GXMk96ZX9XnbLl42rh9Yg3yb87QQPB7zVPmDVXXfdxSStPHuLmBYBOWTYYrIC4ROxAHJAbtTYN8iapMd9yKfl9w/so0T99MAbr+q04Xtae5Q2GeVCbMpDm8PkpYdPVJt7OwDLF6k7BK/xaY9gC5xycCuMPNTNYJE+cbqIYfjUgClWUnVJUv0xJAsYWOPNL4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 22:05:58.5617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53112511-50a6-4624-64a2-08d6ea01fd89
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3017
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/5/2019 10:40 PM, Sagi Grimberg wrote:
>
>>> -    if (qp_init_attr->rwq_ind_tbl &&
>>> -        (qp_init_attr->recv_cq ||
>>> -        qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
>>> -        qp_init_attr->cap.max_recv_sge))
>>> +    if ((qp_init_attr->rwq_ind_tbl &&
>>> +         (qp_init_attr->recv_cq ||
>>> +          qp_init_attr->srq || qp_init_attr->cap.max_recv_wr ||
>>> +          qp_init_attr->cap.max_recv_sge)) ||
>>> +        ((qp_init_attr->create_flags & IB_QP_CREATE_SIGNATURE_EN) &&
>>> +         !(device->attrs.device_cap_flags & 
>>> IB_DEVICE_SIGNATURE_HANDOVER)))
>>
>> Wouldn't it make sense to also change the qp create flag and the device
>> cap to be PI_EN/PI_HANDOVER while we're at it?

We're already standing on 20 patches in this series, so if Jason will 
agree I'll do this renaming in a separate commit or we can stay with the 
current naming.

>
> Or INTEGRITY_EN/INTEGRITY_HANDOVER?
