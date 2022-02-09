Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5639F4AECF8
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Feb 2022 09:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiBIIpP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 03:45:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiBIIpN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 03:45:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFBEC094246
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 00:45:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4fl54X1iTuGv1pZUCcwtzEYmQf2MqG31epCKxN+JNuvBmmFFSAZWLt90v7AqkKseMv3KxmkkJTVSNJYwFUvvTatpzYEadhAKGennxDNT3UwORte5OCmAeqWfs3MRX9fqKpyZ8q7WisovqY3dpUPjMzLVdxa8SGw/VR5AnCQf5I39Tn8o0E19hBvGHlCOL391UZVbryqHDac2S9bfxJMg1BdGPsiDWNo7zfxelo27DNyOrFk3te3U05PaSk5+JQj5JPLhXlCcdEbhaC0VNIojtavcUNUye1gLWOBg3SnZno1IWS0tmrBK5VoKeAt27pHRNZVz7r0U3dgNtuBQUHIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jwb6ziommYoucJgYW6nYrEwSvE1OprKF9QEpurYk1o=;
 b=et3C5roTX3J444sEKWasw7ZbUH3u6eu/9fe7AElwFqJFvhGExAH/sys0Va+g6B4PgZoA7WawW66mP+MCkedUar4tTxI5eZm5c9yfGuhVh0sNDs4Jn3IRt2gn+voDxjwSuJK7QQiA4pWuYBpTzSqwLsSXfwXxgF8/Nm0UYCdgifp2ZL8B0gySZy+R8zMvESlHkA8C2pNH7xfET6OZRLEAfi+qG1mByOYT1blbW30qn15C/WRpyrFzBYdRHiarJHcsEp+X7rJ7oYFLkwKOrXxDAIpNz3l3jD8MtSNaqnqCIpWjBzKFfBbjygAoT/+8z03MS64BfThSf9cO96hgjiISqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=googlegroups.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jwb6ziommYoucJgYW6nYrEwSvE1OprKF9QEpurYk1o=;
 b=JcJr9qWj7GNO9HnVCci9eNy8npAAIL4gJTWTmY/gGanejMs5ntb38DX646h7m9FDHkmehI7pyu/pWqQXZvqENJJPE9EKgo1xMJU1R5ApYllnvM2ra62mjHQFPEz/9zOjEYxSIrVtwtJ5Pt05b8n+oQi1Thsf1FbxQ9/pPu03vX/e4+KeB6+0rYYmMvICA/Lhf031Tj/hrHwvdWXb7ZX1pvSEpXDtG1dr9fYVz3m1+U9yGz6taaBru6AI2DY1os3t903Sy6kgkYb1u1XLNE6ByD77uzzdmKBnH08ViL04G3SeuGMY6odyHNSmy26BlwIQ01IoIG/RTPh65K0owS77dQ==
Received: from DM5PR19CA0063.namprd19.prod.outlook.com (2603:10b6:3:116::25)
 by DM5PR12MB1721.namprd12.prod.outlook.com (2603:10b6:3:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 08:43:50 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::5b) by DM5PR19CA0063.outlook.office365.com
 (2603:10b6:3:116::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 08:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 08:43:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Feb
 2022 08:43:49 +0000
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Feb 2022
 00:43:48 -0800
Date:   Wed, 9 Feb 2022 10:43:44 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>,
        <syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH rc] RDMA/cma: Do not change route.addr.src_addr outside
 state checks
Message-ID: <YgN+wCVmp5V/vQT9@unreal>
References: <0-v1-83dba2d1b721+1c3-syz_cma_srcaddr_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-83dba2d1b721+1c3-syz_cma_srcaddr_jgg@nvidia.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 836aa964-f612-4396-264d-08d9eba84b5d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB17214C1D87B234DA05619E8ABD2E9@DM5PR12MB1721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWSyeqWcD0PV5DQrstVnTCl3RoaRH+zApaDdslaF9FlYOOjigFmGNETRS7S8rzu7SBrrKO8GREaDA2jKhbw7eyljm/jKg9YTidb+GvEPaoIM6Y/91qebr9r3gHjp9qZF223zwkD066GQFwphfBvqaENmi6QVaYWzCdwaLkITSvW8lKIFlQDnzlmXfomnHFf966hqlLft8im/wSomGeJkSl1ev9jNIo24BZVpc1vEmwbMyRGpYoa2Or2sjPREGpK+lrVEj9Q5VjxGAXLzsVawq979q+zJjRd+rhw7C/zFV8RIAuxYAykl9LIe/kF8eBpvkVPivELLp989zG46GfyG9AsvdWnKFvFBzsuygeRaMxOJpPf3CqLPHGsspqABYdDQrtFnzk/Wao3n7MmRvnAqEmseZRuZQXMEdrP/8BQxtrc0PspHneFJCfs7Kv3VPMVoPSfo/AoSotllGNgVfYQaR4g4/EJAARIPFmfIvP2E0wLuZMb0wmDs3B5fEmuAsHW4WYji7dz41JMzfj1i5+OWbQE2r7zOgZ0c3G9DAi6S8SGIgP/fRRf7YI3ZpbZEXnAVvm3Ta8XIE82s7mpbLPEGQEC+3cdbJpfVEHTzCPWNpAkOPPzt+ts5nfo6lAO66Mf43WfeyNCmD2GrhWPeb4Oq4oCHBxoKyql+LfGN8ORGFqg6NtuxjTqHsfTOGPRvLXUrNju1uQIaVfo42cJgAv/gCw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(7916004)(46966006)(40470700004)(36840700001)(9686003)(426003)(8676002)(6636002)(16526019)(70206006)(316002)(6862004)(26005)(54906003)(36860700001)(336012)(8936002)(6666004)(508600001)(5660300002)(2906002)(4326008)(33716001)(82310400004)(47076005)(83380400001)(356005)(70586007)(40460700003)(81166007)(186003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:43:49.9658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 836aa964-f612-4396-264d-08d9eba84b5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 08, 2022 at 04:05:31PM -0400, Jason Gunthorpe wrote:
> If the state is not idle then resolve_prepare_src() will immediately fail
> and no change to global state should happen.
> 
> For instance if the state is already RDMA_CM_LISTEN then this will corrupt
> the src_addr and would cause the test in cma_cancel_operation():
> 
>            if (cma_any_addr(cma_src_addr(id_priv)) && !id_priv->cma_dev)
> 
> This would manifest as this trace from syzkaller:
> 
>   BUG: KASAN: use-after-free in __list_add_valid+0x93/0xa0 lib/list_debug.c:26
>   Read of size 8 at addr ffff8881546491e0 by task syz-executor.1/32204
> 
>   CPU: 1 PID: 32204 Comm: syz-executor.1 Not tainted 5.12.0-rc8-syzkaller #0
>   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>   Call Trace:
>    __dump_stack lib/dump_stack.c:79 [inline]
>    dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>    print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
>    __kasan_report mm/kasan/report.c:399 [inline]
>    kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
>    __list_add_valid+0x93/0xa0 lib/list_debug.c:26
>    __list_add include/linux/list.h:67 [inline]
>    list_add_tail include/linux/list.h:100 [inline]
>    cma_listen_on_all drivers/infiniband/core/cma.c:2557 [inline]
>    rdma_listen+0x787/0xe00 drivers/infiniband/core/cma.c:3751
>    ucma_listen+0x16a/0x210 drivers/infiniband/core/ucma.c:1102
>    ucma_write+0x259/0x350 drivers/infiniband/core/ucma.c:1732
>    vfs_write+0x28e/0xa30 fs/read_write.c:603
>    ksys_write+0x1ee/0x250 fs/read_write.c:658
>    do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Which is indicating that an rdma_id_private was destroyed without doing
> cma_cancel_listens().
> 
> Instead of trying to re-use the src_addr memory to indirectly create an
> any address derived from the dst build one explicitly on the stack and
> bind to that as any other normal flow would do. rdma_bind_addr() will copy
> it over the src_addr once it knows the state is valid.
> 
> Also, src_addr is never NULL in cma_bind_addr().
> 
> This is similar to commit bc0bdc5afaa7 ("RDMA/cma: Do not change
> route.addr.src_addr.ss_family")
> 
> Cc: stable@vger.kernel.org
> Fixes: 732d41c545bb ("RDMA/cma: Make the locking for automatic state transition more clear")
> Reported-by: syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 27a00ce2e10120..f9b7b6f0703f58 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -3368,20 +3368,24 @@ static int cma_resolve_ib_addr(struct rdma_id_private *id_priv)
>  static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
>  			 const struct sockaddr *dst_addr)
>  {
> -	if (!src_addr || !src_addr->sa_family) {
> -		src_addr = (struct sockaddr *) &id->route.addr.src_addr;
> -		src_addr->sa_family = dst_addr->sa_family;
> +	struct sockaddr_storage zero_sock = {};
> +
> +	if (!src_addr->sa_family) {

You removed !src_addr check and it will cause to crash for SRP flow,
as it passes NULL in srp_new_rdma_cm_id() function.

   334 static int srp_new_rdma_cm_id(struct srp_rdma_ch *ch)

....
   349         ret = rdma_resolve_addr(new_cm_id, target->rdma_cm.src_specified ?
   350                                 &target->rdma_cm.src.sa : NULL,
   351                                 &target->rdma_cm.dst.sa,
   352                                 SRP_PATH_REC_TIMEOUT_MS);
....
  3421 int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
  3422                       const struct sockaddr *dst_addr, unsigned long timeout_ms)
  3423 {
....
  3428         ret = resolve_prepare_src(id_priv, src_addr, dst_addr);
....
  3389 static int resolve_prepare_src(struct rdma_id_private *id_priv,
  3390                                struct sockaddr *src_addr,
  3391                                const struct sockaddr *dst_addr)
  3392 {
....
  3362 static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
  3363                          const struct sockaddr *dst_addr)

Maybe it is not possible to do not have src_addr in this stage, but it
is not clear from the code.

Thanks

> +		zero_sock.ss_family = dst_addr->sa_family;
>  		if (IS_ENABLED(CONFIG_IPV6) &&
>  		    dst_addr->sa_family == AF_INET6) {
> -			struct sockaddr_in6 *src_addr6 = (struct sockaddr_in6 *) src_addr;
> +			struct sockaddr_in6 *src_addr6 =
> +				(struct sockaddr_in6 *)&zero_sock;
>  			struct sockaddr_in6 *dst_addr6 = (struct sockaddr_in6 *) dst_addr;
> +
>  			src_addr6->sin6_scope_id = dst_addr6->sin6_scope_id;
>  			if (ipv6_addr_type(&dst_addr6->sin6_addr) & IPV6_ADDR_LINKLOCAL)
>  				id->route.addr.dev_addr.bound_dev_if = dst_addr6->sin6_scope_id;
>  		} else if (dst_addr->sa_family == AF_IB) {
> -			((struct sockaddr_ib *) src_addr)->sib_pkey =
> -				((struct sockaddr_ib *) dst_addr)->sib_pkey;
> +			((struct sockaddr_ib *)&zero_sock)->sib_pkey =
> +				((struct sockaddr_ib *)dst_addr)->sib_pkey;
>  		}
> +		src_addr = (struct sockaddr *)&zero_sock;
>  	}
>  	return rdma_bind_addr(id, src_addr);
>  }
> 
> base-commit: 2f1b2820b546c1eef07d15ed73db4177c0cf6d46
> -- 
> 2.35.1
> 
