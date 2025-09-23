Return-Path: <linux-rdma+bounces-13588-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941DB948DE
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 08:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B2748329D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 06:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599FF30F80A;
	Tue, 23 Sep 2025 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zo56LyYN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE630648C;
	Tue, 23 Sep 2025 06:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758608929; cv=none; b=PT8kGX8Ah7GYBNo18mturtyIaiNmctpp4G06hx+GYzlfEuPtSx2vRWEBj4LkMKNu/5dsZ4ju4gC/laujtEpo28CMaR/jhte6obzO9lL5IBVxTUJRIOlXbuMoC90YNNs8jLH+farPk3rTcCn/OzXKdfVW8Rpre/CYcF/F2mGwY+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758608929; c=relaxed/simple;
	bh=lqVL/C1jw+XbXaRwVlKDaVSCNgFZfladCfZMOyFF2NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDtE0xESiNE76vOsdPM9tqlFn5SDQEpZ9pMdvAe8XY/UGlwVBHta4bSI/8QvZQ7hWzimkqd6Xlusn0eDB+mudWTi4dyu3+S0878sMttCbMMP/EtCnCQZaeXcrMaoFD852H14s4VrwnnRkA3PsVo7bNeA2npbxvhfFTdZS2pJ5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zo56LyYN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MNBqNn019833;
	Tue, 23 Sep 2025 06:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=67ODy
	jyLiEg6TiZLXLBiG9602wZTrvOJbyC1lMUKcN8=; b=Zo56LyYNMZqbT+q+qN7ca
	NksfUIygDaKW8dVlRlwQbOZangAl+KddkkZYfhhKydYj6/SmSk0sJykrFBOmLdJ6
	aE68NxTeqxkCKiLc33oauhJy3Z5Fq7dVKLvXZCziLxJ3uhv/BV6cVGXibhzIVY2q
	BVHjrxt7CFAnm0fFTUMQ4kPri5PQVBgquFutpBiImgBNH59tf4nrFFTPNIb76ywy
	qgWTQH3GoIb0ORk3AiJ4UfnbUb8BeEUXPtCwbgH0c56pDat5NFtYubQW7dr9NBDa
	XP4n8mcXV9tQLiJq9FMyikD9/M6w8VoesoB6W7KBgi0zl79ZzxyquHfB0LmhW0ot
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499kvtuw77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 06:28:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58N4IgEx025338;
	Tue, 23 Sep 2025 06:28:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq80w64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 06:28:32 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58N6SWCQ024064;
	Tue, 23 Sep 2025 06:28:32 GMT
Received: from prahar-home.osdevelopmeniad.oraclevcn.com (prahar-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.152])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 499jq80w1t-1;
	Tue, 23 Sep 2025 06:28:32 +0000
From: Pradyumn Rahar <pradyumn.rahar@oracle.com>
To: shayd@nvidia.com
Cc: anand.a.khoje@oracle.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, elic@nvidia.com, jacob.e.keller@intel.com,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, manjunath.b.patil@oracle.com,
        mbloch@nvidia.com, pradyumn.rahar@oracle.com, moshe@nvidia.com,
        netdev@vger.kernel.org, pabeni@redhat.com, qing.huang@oracle.com,
        rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        rohit.sajan.kumar@oracle.com, saeedm@nvidia.com, tariqt@nvidia.com
Subject: [PATCH net v2 1/1] net/mlx5: Clean up only new IRQ glue on request_irq() failure
Date: Tue, 23 Sep 2025 06:28:22 +0000
Message-ID: <20250923062823.89874-1-pradyumn.rahar@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <d9bea817-279c-4024-9bff-c258371b3de7@nvidia.com>
References: <d9bea817-279c-4024-9bff-c258371b3de7@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509230058
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfXzaiB7nt65f7l
 T2mYTcl3b3zyHruXhxVNJTwvDF8b9nujynzSGyF5OQusmp8hUAvLCjDqjwetFHc2/qf/sJupyl6
 LK/NJlkR4wCF8CYA0DZdV9NKeeaZXQsmh2VTgptbltrb2NWr/DhwSeFIPUbhIlvIgJb5rwtikyc
 N19y0sto2H9iag0RC77nZPs8zVm7ZWZAySH7flq8lCRd0ygSzBH1qeJEm6221nJDTGGo8djghDA
 ufExPna31cQTFhhje/K0PeBpDJ7Yw/lo8fjyTtv7ZHvh0cY+pznGlODia3mvuLKkUbbD5Lp1yHr
 eti/Sbe3LFdzcbnGgjXXviwUYcBRUCdUucK2ayfOskHR8vpluNJrVSqUfutIvvbqnpUipAXb6WO
 Qwgcqov1
X-Authority-Analysis: v=2.4 cv=UPPdHDfy c=1 sm=1 tr=0 ts=68d23e12 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=ZYKq80_RobotJUz1yaYA:9
X-Proofpoint-GUID: IAJ-wRIqtNYqEAowhtMN6hwMR-aYA5pn
X-Proofpoint-ORIG-GUID: IAJ-wRIqtNYqEAowhtMN6hwMR-aYA5pn

The mlx5_irq_alloc() function can inadvertently free the entire rmap
and end up in a crash[1] when the other threads tries to access this,
when request_irq() fails due to exhausted IRQ vectors. This commit
modifies the cleanup to remove only the specific IRQ mapping that was
just added.

This prevents removal of other valid mappings and ensures precise
cleanup of the failed IRQ allocation's associated glue object.

Note: This error is observed when both fwctl and rds configs are enabled.

[1]
mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
request irq. err = -28
infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
trying to test write-combining support
mlx5_core 0000:05:00.0: Successfully unregistered panic handler for port 1
mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
request irq. err = -28
infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
trying to test write-combining support
mlx5_core 0000:06:00.0: Successfully unregistered panic handler for port 1
mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
request irq. err = -28
mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
request irq. err = -28
general protection fault, probably for non-canonical address
0xe277a58fde16f291: 0000 [#1] SMP NOPTI

RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
Call Trace:
   <TASK>
   ? show_trace_log_lvl+0x1d6/0x2f9
   ? show_trace_log_lvl+0x1d6/0x2f9
   ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
   ? __die_body.cold+0x8/0xa
   ? die_addr+0x39/0x53
   ? exc_general_protection+0x1c4/0x3e9
   ? dev_vprintk_emit+0x5f/0x90
   ? asm_exc_general_protection+0x22/0x27
   ? free_irq_cpu_rmap+0x23/0x7d
   mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
   irq_pool_request_vector+0x7d/0x90 [mlx5_core]
   mlx5_irq_request+0x2e/0xe0 [mlx5_core]
   mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
   comp_irq_request_pci+0x64/0xf0 [mlx5_core]
   create_comp_eq+0x71/0x385 [mlx5_core]
   ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
   mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
   ? xas_load+0x8/0x91
   mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
   mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
   mlx5e_open_channels+0xad/0x250 [mlx5_core]
   mlx5e_open_locked+0x3e/0x110 [mlx5_core]
   mlx5e_open+0x23/0x70 [mlx5_core]
   __dev_open+0xf1/0x1a5
   __dev_change_flags+0x1e1/0x249
   dev_change_flags+0x21/0x5c
   do_setlink+0x28b/0xcc4
   ? __nla_parse+0x22/0x3d
   ? inet6_validate_link_af+0x6b/0x108
   ? cpumask_next+0x1f/0x35
   ? __snmp6_fill_stats64.constprop.0+0x66/0x107
   ? __nla_validate_parse+0x48/0x1e6
   __rtnl_newlink+0x5ff/0xa57
   ? kmem_cache_alloc_trace+0x164/0x2ce
   rtnl_newlink+0x44/0x6e
   rtnetlink_rcv_msg+0x2bb/0x362
   ? __netlink_sendskb+0x4c/0x6c
   ? netlink_unicast+0x28f/0x2ce
   ? rtnl_calcit.isra.0+0x150/0x146
   netlink_rcv_skb+0x5f/0x112
   netlink_unicast+0x213/0x2ce
   netlink_sendmsg+0x24f/0x4d9
   __sock_sendmsg+0x65/0x6a
   ____sys_sendmsg+0x28f/0x2c9
   ? import_iovec+0x17/0x2b
   ___sys_sendmsg+0x97/0xe0
   __sys_sendmsg+0x81/0xd8
   do_syscall_64+0x35/0x87
   entry_SYSCALL_64_after_hwframe+0x6e/0x0
RIP: 0033:0x7fc328603727
Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b ed
ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 00
f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
   </TASK>
---[ end trace f43ce73c3c2b13a2 ]---
RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 00
74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 31
f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range:
0xffffffff80000000-0xffffffffbfffffff)
kvm-guest: disable async PF for cpu 0

Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
Signed-off-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
Tested-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
Reviewed-by: Moshe Shemesh<moshe@nvidia.com>
Signed-off-by: Pradyumn Rahar <pradyumn.rahar@oracle.com>
---
v1->v2: removed unnecessary braces from if conditon.
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 692ef9c2f729..82ada674f8e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -324,10 +324,8 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 	free_irq(irq->map.virq, &irq->nh);
 err_req_irq:
 #ifdef CONFIG_RFS_ACCEL
-	if (i && rmap && *rmap) {
-		free_irq_cpu_rmap(*rmap);
-		*rmap = NULL;
-	}
+	if (i && rmap && *rmap)
+		irq_cpu_rmap_remove(*rmap, irq->map.virq);
 err_irq_rmap:
 #endif
 	if (i && pci_msix_can_alloc_dyn(dev->pdev))
-- 
2.43.7


