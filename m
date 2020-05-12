Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16831CEF45
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 10:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgELIkZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 04:40:25 -0400
Received: from mail-am6eur05on2076.outbound.protection.outlook.com ([40.107.22.76]:12925
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgELIkY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 04:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrgWiT7faeR/LbqZRwOP/HqYRuAn89SyiP7ML/QD+gWUXZFx3pOmFRuMlXmHfNHbys1/ZWTrBaAfP5B3UGPnHbog4u9XMeyVR4FAVfn1T3rVVbOUZN0gW6CcT3Id0rwoAAalg+TtnOxj68oD9WTpN5RBxOxeLpB7gPtzCyArSzbLIYtdAM7Qp+/TC1Ich6GoXW3K//t2DabdgAVDhBOIYDB+i2k0b9nxuomTYMOPn0r9zARTLlpmbNaSuKYWIjq7aRiW8vd701GKQ6sZLAyht/5rM/thzH2uoGAuW7zWwbycdkilMxhXUAVzA/kqX0kEsKgVGWyqLeL3GgN45HedMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxMocPJsesPjglEywQ45g9D619kPdBGuRUqn8wa2yUM=;
 b=enzlnir0dA7RobviZxfjIUKK/1b7bBXnvUrQrnWUfXSYoC9e55g4iwWA1aXCjl2AJNygPjMKBKHq/hwOXgLVfhoes4WaqGlKVUpwCy0aIyzCg1F06FqfGZQb6sYREmn7uo/vs30DDgS49w2erMsnwQBiuyQKT8tuP80dSOMSRfO4TNKX4EtiB54mVC3Y2phQJX3LP3F9Lz51klviZpHMzMeIDDDzOJ5391ZeN/9Oa/cFIkXuCFH01cVnrZ9NKAMagdmricxr1T0JFZ0rS4XKMN7NCA2s7U2mw5byXMHqOremYQF7UKP/gsuLI8ZeIP/USPIRtMrGNDsXZ6iwbXPhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxMocPJsesPjglEywQ45g9D619kPdBGuRUqn8wa2yUM=;
 b=CcyWu90VIYEtnEUOAiKadg98NoA+RFx8nJt0KIHpbmdIZywTrg74GNGIvhYdTmZ6sEJW7rM+RXEwmw3lyUuurRpw0JrHnVXFp4tT+mLKSx2VoF2Rg13uglGfOsYmLaBkP50DXstXRq+jGidzzCM6Q3ZRhRwy3FbixFXdHDBfLF0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB4025.eurprd05.prod.outlook.com (2603:10a6:8:8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 08:40:21 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 08:40:20 +0000
Subject: Re: [PATCH 2/4] RDMA/core: Introduce shared CQ pool API
To:     Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-3-git-send-email-yaminf@mellanox.com>
 <f214d59e-2bc1-15f5-4029-99ed322b843e@grimberg.me>
 <921ae7c2-04f0-e89d-7f80-6534ed3b8aa0@mellanox.com>
 <e893419f-f26a-a0d0-1616-970a78c60b04@grimberg.me>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <e83fad63-562c-3746-3963-9209c463c395@mellanox.com>
Date:   Tue, 12 May 2020 11:40:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <e893419f-f26a-a0d0-1616-970a78c60b04@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 08:40:19 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 80d1cd96-3c9b-43b8-c61a-08d7f6501ae1
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4025:|DB3PR0502MB4025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB4025C48B9EA295D58C9B989BB1BE0@DB3PR0502MB4025.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KduL9UlSmkLlU0JSrNZNdHYpiLahWG+Gcke/4/FV59vcmNMHUDgtMDdYrIBBD/6tyugaopMqUkLYRtrTwFnFqD0ZLzmUC/CNnww9XHa2huu4/H+0Ql3dCVVZ7nv88Zi1Maziho/f8o8afk8tHH52fMItkIhiG96XqkaZpj121UPWcdI9fVtgVP1AYRC5D73uaMwGHZIfVlJMcNxKEq98zfFk0YM6bApnyUPdBijf+gJPp+Xqfzz222biyrOkCGsndQ2ynb+6G15/fTbj8JJNiBP7o64UpA0j+wYorSFp1BJxXIlB6jaNhb//Vq351cbyCOd9pPbvGlvllp9pZiKJsdW/fsrYumm8gBkmL89+YLbwgtcjMFBZSifrDTIsDdC4dc/QLtQG+acJnoZLR+aXLj/Lig4GfUyC5d7eDmubWBKWdB1hhRpq9YzwW+DKbd/fHClUrnTLhsIxn7iuyFFfmjxnWBkuyYKnGaLVFnltwR+mLgcR2bWIG9QTerAbs4+1Xf3B4/COv+0aWxm7tGmzpMmN9+J+HNKsVMQ+e+1fDDBbOLZ9TgAP3OFz0tr2ArCo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(33430700001)(52116002)(186003)(36756003)(53546011)(8936002)(316002)(478600001)(26005)(16576012)(33440700001)(31686004)(110136005)(66946007)(66476007)(66556008)(5660300002)(31696002)(16526019)(956004)(4326008)(6486002)(2906002)(8676002)(2616005)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mt8oMaW+2zY+eU88tkpAR6IoVCevoZIAkRd5IOEtgFhXyoBQaBajDkQlPHCNUE4CV+Ds9+aOWSjWSlWtzcoxMYU3R1Walqy2QmQHeXxMVN1rATf6cp4NVfzaJA7jbMjw3hxHwezV2r+Suz4GfoEapOAv5E2kRDEuVSiUOiA1SD9K76/G3GtFIBAWos+T2c6ys27L8zWlIqGgblY/yPZ/5JEK6nNz5+uEfz7tNVhj8cHJsmZEyfkJGF6dRQx42bJCcxvWHVeYvJvuHOh6tefB5EUucGT088eRllB1Gvsq6vJ4qEy1xQEibGLu9MNvZ07GV8G8AEVKNFoicjKobMplN/uuE4RKFBZ2UZMKxBo3GUKaMFh1YRsf/1GJWtLcYVEJ/Z8dEzmKt0rt7U/SfJNKIigA88S0hvzCoMtovWnWzBsdp6l1rmVFlXMVXm4iWfaQ3YjpcqzRY/O3bma4/VsKcVWTVYYVHfe7WmlxHwcuKRg=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d1cd96-3c9b-43b8-c61a-08d7f6501ae1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 08:40:20.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iC1isgVH87qsrIWphTxseM0AheO25B7EjV3gRQJZ0uPH3UakNjCsAAXLc3znVchPOux/oND5YlwEFGbAHD37Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4025
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/12/2020 9:55 AM, Sagi Grimberg wrote:
>
>>> Why are you using the cpu_hint as the vector? Aren't you suppose
>>> to seach the cq with vector that maps to the cpu?
>>>
>>> IIRC my version used ib_get_vector_affinity to locate a cq that
>>> will actually interrupt on the cpu... Otherwise, just call it vector.
>> You are right, I ended up removing the call to ib_get_vector_affinity 
>> because it wasn't implemented anyway. I think it would be best just 
>> to change it from cpu_hint to comp_vector_hint and then we will get 
>> the desired spread over comp vectors which is what happens anyway 
>> without ib_get_vector_affinity.
>
> Why isn't that supported btw? I see mlx5_comp_irq_get_affinity_mask and
> it should be pretty straight forward to have this for all the device
> drivers really, isn't it?
I agree it sounds straight forward but right now there is not a single 
infiniband driver that implements it and I think adding that function is 
outside of the scope of this feature. I definitely think it should be 
used once it exists.
