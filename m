Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9FF185E90
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2020 17:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgCOQsX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Mar 2020 12:48:23 -0400
Received: from mail-db8eur05on2081.outbound.protection.outlook.com ([40.107.20.81]:6180
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728682AbgCOQsW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Mar 2020 12:48:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rddh7uMfIXBip3lnTjGIuMkt1Tyug1H37Zyd4xdpSY6dRBIwyIQQzvr8hmTm5QJkErBlzdD3UifazaFMBSqE809nuU/lMaaiKwW+Nt6OWKpqWK8IjUYrpSNVJPtlulKxYgnEEyUZzjGCo5cCp7tbcXgjVkOhK6tSLkjQqLfta/poCQGhUxDPCOIXAWlOcdwN3Qt6u04wnMCwxjg7EcYjvFO3fHWj6e1nput2UVlyql1DjRwalhcbsrFLI03KH+MeSO9IHI2y0JXQTQ8Q99FtF2HE/RxIchLMXpMvwfZKNsGHac2BpYNjsPaX735VCM6BXVwYQHR3GFPSmRqiEUN6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWS62CG40Shf7io9Zrv2/Lbq1aBWz/rsiiH/RsiyJmk=;
 b=TX9c4N0B45MeweeQNqNmLZcwQncR3RRaI533TFozw7kvoaTr39PXHXQMgKJdsXG5z5O0XAzYrvMSBGWr/y8IvxB/SJVgOorSV0c/ug5KRDM7asH4MsSm9l1rEfkoJFGfzkanHBHzecCOPamyWVAbpeBw49kAnRoa2PXj+yRnk7dexMFwjfyw6S+93Qt7xESNDs/8TZkqaLXkr+8vzh8j9VjuoVh4qIGq6vwO03QtQ69oznLBjhI+FRsxtC51rtqcNVllqBV5uwqedNH9sbkgKDmES/IVPLWinNuM5I4psZcKu9oOq06C7MpDiCqfSsPZtAzhSNgqY2pHItetvVKWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWS62CG40Shf7io9Zrv2/Lbq1aBWz/rsiiH/RsiyJmk=;
 b=AfaS1MfVdrrK2zQA4g8r5IT9RNjoltTX9LS86AjenqFxqjFNLDAaVh2iHDNb5P4CDnIR1i5iTmaXPI95Vw6JAjkNbvcsnijh+0lwjbAPdkgkTwyZZMt00Wm5OQvEbei6epAexxbFXwQh0zJktGIIpu1JX7/sRb4NIXgH83XjYkE=
Received: from AM6PR08CA0036.eurprd08.prod.outlook.com (2603:10a6:20b:c0::24)
 by HE1PR0502MB2972.eurprd05.prod.outlook.com (2603:10a6:3:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Sun, 15 Mar
 2020 16:48:15 +0000
Received: from VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:c0:cafe::d6) by AM6PR08CA0036.outlook.office365.com
 (2603:10a6:20b:c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13 via Frontend
 Transport; Sun, 15 Mar 2020 16:48:14 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT060.mail.protection.outlook.com (10.152.19.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Sun, 15 Mar 2020 16:48:14 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 15 Mar 2020 18:48:11
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 15 Mar 2020 18:48:11 +0200
Received: from [172.27.12.224] (172.27.12.224) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 15 Mar 2020 18:47:51
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
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0bef0089-0c46-8fb7-9e44-61654c641cbd@mellanox.com>
Date:   Sun, 15 Mar 2020 18:47:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <88bab94d2fd72f3145835b4518bc63dda587add6.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.12.224]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(39860400002)(199004)(46966005)(31686004)(6636002)(2616005)(6666004)(356004)(36756003)(70206006)(478600001)(5660300002)(53546011)(70586007)(4326008)(31696002)(110136005)(8936002)(36906005)(336012)(81156014)(2906002)(86362001)(186003)(26005)(316002)(47076004)(16526019)(81166006)(8676002)(16576012)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB2972;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da339692-4fd9-4e7f-c4b5-08d7c900a773
X-MS-TrafficTypeDiagnostic: HE1PR0502MB2972:
X-Microsoft-Antispam-PRVS: <HE1PR0502MB2972713E3B6D8104D8B0A03AB6F80@HE1PR0502MB2972.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0343AC1D30
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wq2H00scphwOQtsftbKX+Zf/tpRrGggdIiOj6ekyxAgbKNqtulpSYZKt6KgT+Wrm7yt32Nh9To2DSrdZYXY4H6a7VMZb1i0BPBj1JUGi9Z9BE6NFPgKsBgUkMhbll4EDPOhP0pMOltrzMdEqtdBoRa+HWxE2VNVKGz4AJJIrkGXrDebwVMjRSncaOmIVXat+JLrA5KNIqxUPIVAejmKHm2JxZrdPHP40bbanPdfEfXEfdvV06qUrXg31yzYSovX+DUrtGI4lwFzGvuF0OLeKWZ0RAPpB1Py5kUOFXHdiFeO+X3swF/gIXnDy3dm3crfOrOFA/6KK77yMbMtqPVZVZCZdTdGXoLzEY5B/dn1+l2NwNFeskq845FAUsV+BeEBgFK/KTI+nTaQkXgoUIHeZHF44HrlPJtqN9xBsfiYowFHtNYyjj6dp2NK46QFebLUie863Vvxj6KjK+dRpC0emuYspn0KMayIuEFA/rS0UyOBZLEQS7fE6e9nroTl3hV//glkXmzOVKCnX0md1mwrEoxoEjZVAXqiJ3ZrEZABcPI4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2020 16:48:14.0868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da339692-4fd9-4e7f-c4b5-08d7c900a773
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB2972
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/14/2020 11:30 PM, Laurence Oberman wrote:
> Hello Bart, Leon and Max

Hi Laurence,

thanks for the great analysis and the fast response !!

>
> Max had reached out to me to test a new set of patches for SRQ.
> I had not tested upstream ib_srpt on an LIO target for quite a while,
> only ib_srp client tests had been run of late.
> During a baseline test before applying Max's patches it was apparent
> that something had broken ib_srpt connections within LIO target since
> 5.5.
>
> Note thet ib_srp client connectivity with the commit functions fine,
> it's just the target that breaks with this commit.
>
> After a long bisect this is the commit that seems to break it.
> While it's not directly code in ib_srpt, its code in mlx5 vport
> ethernet connectivity that then breaks ib_srpt connectivity over mlx5
> IB RDMA with LIO.

I was able to connect in loopback and also from remote initiator with 
this commit.

So I'm not sure that this commit is broken.

I used Bart's scripts to configure the target and to connect to it in 
loopback (after some modifications for the updated kernel/sysfs/configfs 
interface).

I did see an issue to connect from remote initiator, but after reloading 
openibd in the initiator side I was able to connect.

So I suspect you had the same issue - that also should be debugged.

>
> I will let Leon and others decide but reverting the below commit allows
> SRP connectivity to an LIO target to work again.

I added prints to "mlx5_core_modify_hca_vport_context" function and 
found that we don't call it in "pure" mlx5 mode with PFs.

Maybe you can try it too...

I was able to check my patches on my system and I'll send them soon.

Thanks again Laurence and Bart.

>
> Max, I will test your new patches once we have a decision on this.
>
> Client
> Linux ibclient.lab.eng.bos.redhat.com 5.6.0-rc5+ #1 SMP Thu Mar 12
> 16:58:19 EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
>
> Server with reverted commit
> Linux fedstorage.bos.redhat.com 5.6.0-rc5+ #1 SMP Sat Mar 14 16:39:35
> EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
>
> commit ab118da4c10a70b8437f5c90ab77adae1835963e
> Author: Leon Romanovsky <leonro@mellanox.com>
> Date:   Wed Nov 13 12:03:47 2019 +0200
>
>      net/mlx5: Don't write read-only fields in MODIFY_HCA_VPORT_CONTEXT
> command
>      
>      The MODIFY_HCA_VPORT_CONTEXT uses field_selector to mask fields
> needed
>      to be written, other fields are required to be zero according to
> the
>      HW specification. The supported fields are controlled by bitfield
>      and limited to vport state, node and port GUIDs.
>      
>      Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>      Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> b/drivers/net/ethernet/mellanox/mlx5
> index 30f7848..1faac31f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
> @@ -1064,26 +1064,13 @@ int mlx5_core_modify_hca_vport_context(struct
> mlx5_core_dev *dev,
>   
>          ctx = MLX5_ADDR_OF(modify_hca_vport_context_in, in,
> hca_vport_context);
>          MLX5_SET(hca_vport_context, ctx, field_select, req-
>> field_select);
> -       MLX5_SET(hca_vport_context, ctx, sm_virt_aware, req-
>> sm_virt_aware);
> -       MLX5_SET(hca_vport_context, ctx, has_smi, req->has_smi);
> -       MLX5_SET(hca_vport_context, ctx, has_raw, req->has_raw);
> -       MLX5_SET(hca_vport_context, ctx, vport_state_policy, req-
>> policy);
> -       MLX5_SET(hca_vport_context, ctx, port_physical_state, req-
>> phys_state);
> -       MLX5_SET(hca_vport_context, ctx, vport_state, req-
>> vport_state);
> -       MLX5_SET64(hca_vport_context, ctx, port_guid, req->port_guid);
> -       MLX5_SET64(hca_vport_context, ctx, node_guid, req->node_guid);
> -       MLX5_SET(hca_vport_context, ctx, cap_mask1, req->cap_mask1);
> -       MLX5_SET(hca_vport_context, ctx, cap_mask1_field_select, req-
>> cap_mask1_perm);
> -       MLX5_SET(hca_vport_context, ctx, cap_mask2, req->cap_mask2);
> -       MLX5_SET(hca_vport_context, ctx, cap_mask2_field_select, req-
>> cap_mask2_perm);
> -       MLX5_SET(hca_vport_context, ctx, lid, req->lid);
> -       MLX5_SET(hca_vport_context, ctx, init_type_reply, req-
>> init_type_reply);
> -       MLX5_SET(hca_vport_context, ctx, lmc, req->lmc);
> -       MLX5_SET(hca_vport_context, ctx, subnet_timeout, req-
>> subnet_timeout);
> -       MLX5_SET(hca_vport_context, ctx, sm_lid, req->sm_lid);
> -       MLX5_SET(hca_vport_context, ctx, sm_sl, req->sm_sl);
> -       MLX5_SET(hca_vport_context, ctx, qkey_violation_counter, req-
>> qkey_violation_counter);
> -       MLX5_SET(hca_vport_context, ctx, pkey_violation_counter, req-
>> pkey_violation_counter);
> +       if (req->field_select & MLX5_HCA_VPORT_SEL_STATE_POLICY)
> +               MLX5_SET(hca_vport_context, ctx, vport_state_policy,
> +                        req->policy);
> +       if (req->field_select & MLX5_HCA_VPORT_SEL_PORT_GUID)
> +               MLX5_SET64(hca_vport_context, ctx, port_guid, req-
>> port_guid);
> +       if (req->field_select & MLX5_HCA_VPORT_SEL_NODE_GUID)
> +               MLX5_SET64(hca_vport_context, ctx, node_guid, req-
>> node_guid);
>          err = mlx5_cmd_exec(dev, in, in_sz, out, sizeof(out));
>   ex:
>          kfree(in);
>   
>
