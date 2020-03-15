Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC4F185EE7
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2020 19:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgCOSVE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Mar 2020 14:21:04 -0400
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:6016
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728104AbgCOSVE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Mar 2020 14:21:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OifyvrLK/uUsarqDiEaEC6ulhqk3bvA3SbkzuIEij3nzdEM+Jrp/fqHVDw+Vwddfjh7pSkE9sPuhj43/0o2qV+TL+shu1hBhoklPuVKNQDzGNCslbBuzSAm3emhAlhLif69h5uRFE9agDLXUAGM4gCITTdNivR/DxvlPI2Ki3QQqwh3wFNfLDkFnM0i1wOntDwenmxQiJyr6oRTM33atAXZFJPyDgLKqNxsG4FNjUmpwv/OFfXFdQK7qSVTQw5kyhxdPCYAs18L11ArG6784PyYs4fzDwmi5jno3YsaGBwUxz0T9ABiVEAsqMV3R5T1PZTnlSIpEVznspwhrIJavfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCFD1y9jl4kVLKeOrh+mkomTgx20B4LqravrUdwYZFE=;
 b=Qk0CGAGaCVZZI+WvUtT3k8MTkFPuuqZI5/kNfMIzpjVj5MCD/0EuNf18fygT9UYcXCdj9VSYotoB8XXUJPZL+ufkxx4/0pleuO1qSLZALpHPHMvyWT99y5XF2g4oKDZ3b0u4sm1kPno05SE/1nyK6YjxRcZix2TNX0uCDA7SKqJrTFcl+5B8uqyxFMbb3RV10qAkX87iaIojLUUZ4ndJM3rZaxiSekJkx7HT1sgS/gecfZU7IHGd9njGeWO/BunhONr/ry230YwKg79lyC7ZCTWObkNby7dQYOQMPLrHw8/xYEs+QgVtKwkfCrDNrqj+i0EEMnrUVw6Aj8kIVFRZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCFD1y9jl4kVLKeOrh+mkomTgx20B4LqravrUdwYZFE=;
 b=g4F1x112JqQtN3NjOFK9T+z8aDUyuZ2OFfypE2eTiVqEfYWNyCv+f042IG+OiGQtIq5NT8U2mVrwM4AXsnXrquTKvh7QM+eW5VJFULYfXI3xJZFRbjlEkgYulEeJALSLtwCmrsKMf/nsz1KexRPHpTQno9TzQBtCzpIslUGz4Ls=
Received: from DB6PR0501CA0004.eurprd05.prod.outlook.com (2603:10a6:4:8f::14)
 by HE1PR05MB4778.eurprd05.prod.outlook.com (2603:10a6:7:9a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Sun, 15 Mar
 2020 18:20:58 +0000
Received: from DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:8f:cafe::64) by DB6PR0501CA0004.outlook.office365.com
 (2603:10a6:4:8f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend
 Transport; Sun, 15 Mar 2020 18:20:58 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT045.mail.protection.outlook.com (10.152.21.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Sun, 15 Mar 2020 18:20:49 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 15 Mar 2020 20:20:01
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 15 Mar 2020 20:20:01 +0200
Received: from [172.27.12.224] (172.27.12.224) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 15 Mar 2020 20:20:01
 +0200
Subject: Re: commit ab118da4c10a70b8437f5c90ab77adae1835963e causes ib_srpt to
 fail connections served by target LIO
To:     Laurence Oberman <loberman@redhat.com>,
        rdmadev <rdma-dev-team@redhat.com>, <linux-rdma@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Van Assche, Bart" <bvanassche@acm.org>,
        "Leon Romanovsky" <leonro@mellanox.com>
CC:     Rupesh Girase <rgirase@redhat.com>
References: <88bab94d2fd72f3145835b4518bc63dda587add6.camel@redhat.com>
 <0bef0089-0c46-8fb7-9e44-61654c641cbd@mellanox.com>
 <e57c1763dd99ea958c9834a53ae5688a775c9444.camel@redhat.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <6d5415e3-9314-331a-fade-7593c6a27290@mellanox.com>
Date:   Sun, 15 Mar 2020 20:20:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e57c1763dd99ea958c9834a53ae5688a775c9444.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.12.224]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(199004)(46966005)(110136005)(6636002)(5660300002)(31686004)(478600001)(70586007)(86362001)(70206006)(31696002)(16576012)(316002)(2906002)(47076004)(8936002)(4326008)(8676002)(81166006)(81156014)(36756003)(356004)(16526019)(336012)(2616005)(53546011)(26005)(186003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4778;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31c7a65d-5939-4cf3-a19b-08d7c90d96a2
X-MS-TrafficTypeDiagnostic: HE1PR05MB4778:
X-Microsoft-Antispam-PRVS: <HE1PR05MB47788F39A86789594E7DA392B6F80@HE1PR05MB4778.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0343AC1D30
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDhxpgWP2mxolOUuzIsTMAdIHKh2UxV9TnhUYnQxU9Bvx1kwgZsfM/dRC0OAkLOYSEBrrocZUkkU1Gx5YCpCd+RxmG72myopI04I7sM902Z0aO9MfgbjL9rXmvdUcYRQOEKcfZyL6/sZhyVtdvW81JmP5oHFZVaxhjmcNa5YycPSu3uKMbR9ysQhnbSIuH7LOw/o/2vdtIRnndZ74/QRFEyBWB1890RMFACzLIs1JQRpnBUEELteLoCuyDmQ2o5HcAk9W9N6JrJDY7dmtKfFqdHAB2Cs3o2gPPq5TK5VWk7mK8i7q0s5QSnilvB6X3j2pS2fuskc0C8/P55jdyRgFiFfk0ZCUZVQoD3bAn0T6I0yLykUA4WI8Ccbqo5tYnIe8Dh41lIr6AAaYSL+7+H5N76Mz2aOO87yGI+Mo5HMZ0Vtzs3kk8g+dNF6kNYF1gB4Z9SYWXD2hc6peMdeINz2sXEFKym6VK0eDJLJoYgSOTVsVQlVPvs3Xl1KXa30VrXDWHBgWb60mZWVnFIqS9FUhmxNFv1mWYUaIP8baZUglpQ=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2020 18:20:49.3031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c7a65d-5939-4cf3-a19b-08d7c90d96a2
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4778
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/15/2020 7:59 PM, Laurence Oberman wrote:
> On Sun, 2020-03-15 at 18:47 +0200, Max Gurtovoy wrote:
>> On 3/14/2020 11:30 PM, Laurence Oberman wrote:
>>> Hello Bart, Leon and Max
>> Hi Laurence,
>>
>> thanks for the great analysis and the fast response !!
>>
>>> Max had reached out to me to test a new set of patches for SRQ.
>>> I had not tested upstream ib_srpt on an LIO target for quite a
>>> while,
>>> only ib_srp client tests had been run of late.
>>> During a baseline test before applying Max's patches it was
>>> apparent
>>> that something had broken ib_srpt connections within LIO target
>>> since
>>> 5.5.
>>>
>>> Note thet ib_srp client connectivity with the commit functions
>>> fine,
>>> it's just the target that breaks with this commit.
>>>
>>> After a long bisect this is the commit that seems to break it.
>>> While it's not directly code in ib_srpt, its code in mlx5 vport
>>> ethernet connectivity that then breaks ib_srpt connectivity over
>>> mlx5
>>> IB RDMA with LIO.
>> I was able to connect in loopback and also from remote initiator
>> with
>> this commit.
>>
>> So I'm not sure that this commit is broken.
>>
>> I used Bart's scripts to configure the target and to connect to it
>> in
>> loopback (after some modifications for the updated
>> kernel/sysfs/configfs
>> interface).
>>
>> I did see an issue to connect from remote initiator, but after
>> reloading
>> openibd in the initiator side I was able to connect.
>>
>> So I suspect you had the same issue - that also should be debugged.
>>
>>> I will let Leon and others decide but reverting the below commit
>>> allows
>>> SRP connectivity to an LIO target to work again.
>> I added prints to "mlx5_core_modify_hca_vport_context" function and
>> found that we don't call it in "pure" mlx5 mode with PFs.
>>
>> Maybe you can try it too...
>>
>> I was able to check my patches on my system and I'll send them soon.
>>
>> Thanks again Laurence and Bart.
>>
>>> Max, I will test your new patches once we have a decision on this.
>>>
>>> Client
>>> Linux ibclient.lab.eng.bos.redhat.com 5.6.0-rc5+ #1 SMP Thu Mar 12
>>> 16:58:19 EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> Server with reverted commit
>>> Linux fedstorage.bos.redhat.com 5.6.0-rc5+ #1 SMP Sat Mar 14
>>> 16:39:35
>>> EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> commit ab118da4c10a70b8437f5c90ab77adae1835963e
>>> Author: Leon Romanovsky <leonro@mellanox.com>
>>> Date:   Wed Nov 13 12:03:47 2019 +0200
>>>
>>>       net/mlx5: Don't write read-only fields in
>>> MODIFY_HCA_VPORT_CONTEXT
>>> command
>>>       
>>>       The MODIFY_HCA_VPORT_CONTEXT uses field_selector to mask
>>> fields
>>> needed
>>>       to be written, other fields are required to be zero according
>>> to
>>> the
>>>       HW specification. The supported fields are controlled by
>>> bitfield
>>>       and limited to vport state, node and port GUIDs.
>>>       
>>>       Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>>       Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>>> b/drivers/net/ethernet/mellanox/mlx5
>>> index 30f7848..1faac31f 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>>> @@ -1064,26 +1064,13 @@ int
>>> mlx5_core_modify_hca_vport_context(struct
>>> mlx5_core_dev *dev,
>>>    
>>>           ctx = MLX5_ADDR_OF(modify_hca_vport_context_in, in,
>>> hca_vport_context);
>>>           MLX5_SET(hca_vport_context, ctx, field_select, req-
>>>> field_select);
>>> -       MLX5_SET(hca_vport_context, ctx, sm_virt_aware, req-
>>>> sm_virt_aware);
>>> -       MLX5_SET(hca_vport_context, ctx, has_smi, req->has_smi);
>>> -       MLX5_SET(hca_vport_context, ctx, has_raw, req->has_raw);
>>> -       MLX5_SET(hca_vport_context, ctx, vport_state_policy, req-
>>>> policy);
>>> -       MLX5_SET(hca_vport_context, ctx, port_physical_state, req-
>>>> phys_state);
>>> -       MLX5_SET(hca_vport_context, ctx, vport_state, req-
>>>> vport_state);
>>> -       MLX5_SET64(hca_vport_context, ctx, port_guid, req-
>>>> port_guid);
>>> -       MLX5_SET64(hca_vport_context, ctx, node_guid, req-
>>>> node_guid);
>>> -       MLX5_SET(hca_vport_context, ctx, cap_mask1, req-
>>>> cap_mask1);
>>> -       MLX5_SET(hca_vport_context, ctx, cap_mask1_field_select,
>>> req-
>>>> cap_mask1_perm);
>>> -       MLX5_SET(hca_vport_context, ctx, cap_mask2, req-
>>>> cap_mask2);
>>> -       MLX5_SET(hca_vport_context, ctx, cap_mask2_field_select,
>>> req-
>>>> cap_mask2_perm);
>>> -       MLX5_SET(hca_vport_context, ctx, lid, req->lid);
>>> -       MLX5_SET(hca_vport_context, ctx, init_type_reply, req-
>>>> init_type_reply);
>>> -       MLX5_SET(hca_vport_context, ctx, lmc, req->lmc);
>>> -       MLX5_SET(hca_vport_context, ctx, subnet_timeout, req-
>>>> subnet_timeout);
>>> -       MLX5_SET(hca_vport_context, ctx, sm_lid, req->sm_lid);
>>> -       MLX5_SET(hca_vport_context, ctx, sm_sl, req->sm_sl);
>>> -       MLX5_SET(hca_vport_context, ctx, qkey_violation_counter,
>>> req-
>>>> qkey_violation_counter);
>>> -       MLX5_SET(hca_vport_context, ctx, pkey_violation_counter,
>>> req-
>>>> pkey_violation_counter);
>>> +       if (req->field_select & MLX5_HCA_VPORT_SEL_STATE_POLICY)
>>> +               MLX5_SET(hca_vport_context, ctx,
>>> vport_state_policy,
>>> +                        req->policy);
>>> +       if (req->field_select & MLX5_HCA_VPORT_SEL_PORT_GUID)
>>> +               MLX5_SET64(hca_vport_context, ctx, port_guid, req-
>>>> port_guid);
>>> +       if (req->field_select & MLX5_HCA_VPORT_SEL_NODE_GUID)
>>> +               MLX5_SET64(hca_vport_context, ctx, node_guid, req-
>>>> node_guid);
>>>           err = mlx5_cmd_exec(dev, in, in_sz, out, sizeof(out));
>>>    ex:
>>>           kfree(in);
>>>    
>>>
>>
>
> Hi Max
> Re:
>
> "
> So I'm not sure that this commit is broken.
> ..
> ..
> I added prints to "mlx5_core_modify_hca_vport_context" function and
> found that we don't call it in "pure" mlx5 mode with PFs.
>
> Maybe you can try it too...
> "
>
> The thing is without this commit we connect immediately, no delay no
> issue and I am changing nothing else other than reverting here.
>
> So this clearly has a bearing directly on the functionality.
>
> I will look at adding more debug, but with this commit in there is nor
> evidence even of an attempt to connect and fail.
>
> Its silently faling.

please send me all the configuration steps you run after booting the 
target + steps in the initiator (can be also in attached file).

I'll try to follow this.

Btw, did you try loopback initiator ?

-Max.


>
> Regards
> Laurence
>
>
>
>
