Return-Path: <linux-rdma+bounces-6745-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E3A9FC963
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 08:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C4BA7A1293
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2024 07:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102D1684B4;
	Thu, 26 Dec 2024 07:12:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C31145B21;
	Thu, 26 Dec 2024 07:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735197129; cv=none; b=u+2agSZlVR2fsjSKoZzCvLNF1gnDcbiXpuxYBwYlJkpSzSPgRebvwGrDykhZuL8CWdJHhIzrz7vwv3EI53wMK53MUgXMUtGh6mTZ1uCx5TUJs3xwQaBVUsMe5XEpy2G1AXtArOc3U1ya8KpSIa5b+00eZSKSNry7TQMpu/1ixOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735197129; c=relaxed/simple;
	bh=Knj5TIsDQgyLg8p5+cY2aWCAJDz82Z4lK2SWfH0yCD8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S7fZcnXv2KbH1hUaJWRzAP1ADv4udlJcrdn6b7xnuyQj33On7CVmBcKjXTs0sSQuvfec8mZhLJ/CiwVEhl8Iv3bhetP76pKk2NwYiy/8kUI+WOFWZLrhvQfEPYoB7DXCz/rsR8bezhdCjmhnyYy56BNJ6Uqo8uXWUtwLq1k6YBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQ6ngEe031103;
	Thu, 26 Dec 2024 07:11:37 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43njw0vbxa-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Dec 2024 07:11:37 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Wed, 25 Dec 2024 23:11:36 -0800
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Wed, 25 Dec 2024 23:11:31 -0800
From: <jianqi.ren.cn@windriver.com>
To: <stable@vger.kernel.org>
CC: <dtatulea@nvidia.com>, <tariqt@nvidia.com>, <pabeni@redhat.com>,
        <patches@lists.linux.dev>, <cratiu@nvidia.com>,
        <gregkh@linuxfoundation.org>, <saeedm@nvidia.com>, <leon@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <roid@nvidia.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
Subject: [PATCH 6.1.y] net/mlx5e: Don't call cleanup on profile rollback failure
Date: Thu, 26 Dec 2024 15:11:31 +0800
Message-ID: <20241226071131.773866-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Yc5H5xRf c=1 sm=1 tr=0 ts=676d01a9 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=RZcAm9yDv7YA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=O6WMtLnDkRuORcTRUxwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: -L1J8KUDgx1xFnGnWKNir4RMeYwJltsl
X-Proofpoint-GUID: -L1J8KUDgx1xFnGnWKNir4RMeYwJltsl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-26_02,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412260062

From: Cosmin Ratiu <cratiu@nvidia.com>

[ Upstream commit 4dbc1d1a9f39c3711ad2a40addca04d07d9ab5d0 ]

When profile rollback fails in mlx5e_netdev_change_profile, the netdev
profile var is left set to NULL. Avoid a crash when unloading the driver
by not calling profile->cleanup in such a case.

This was encountered while testing, with the original trigger that
the wq rescuer thread creation got interrupted (presumably due to
Ctrl+C-ing modprobe), which gets converted to ENOMEM (-12) by
mlx5e_priv_init, the profile rollback also fails for the same reason
(signal still active) so the profile is left as NULL, leading to a crash
later in _mlx5e_remove.

 [  732.473932] mlx5_core 0000:08:00.1: E-Switch: Unload vfs: mode(OFFLOADS), nvfs(2), necvfs(0), active vports(2)
 [  734.525513] workqueue: Failed to create a rescuer kthread for wq "mlx5e": -EINTR
 [  734.557372] mlx5_core 0000:08:00.1: mlx5e_netdev_init_profile:6235:(pid 6086): mlx5e_priv_init failed, err=-12
 [  734.559187] mlx5_core 0000:08:00.1 eth3: mlx5e_netdev_change_profile: new profile init failed, -12
 [  734.560153] workqueue: Failed to create a rescuer kthread for wq "mlx5e": -EINTR
 [  734.589378] mlx5_core 0000:08:00.1: mlx5e_netdev_init_profile:6235:(pid 6086): mlx5e_priv_init failed, err=-12
 [  734.591136] mlx5_core 0000:08:00.1 eth3: mlx5e_netdev_change_profile: failed to rollback to orig profile, -12
 [  745.537492] BUG: kernel NULL pointer dereference, address: 0000000000000008
 [  745.538222] #PF: supervisor read access in kernel mode
<snipped>
 [  745.551290] Call Trace:
 [  745.551590]  <TASK>
 [  745.551866]  ? __die+0x20/0x60
 [  745.552218]  ? page_fault_oops+0x150/0x400
 [  745.555307]  ? exc_page_fault+0x79/0x240
 [  745.555729]  ? asm_exc_page_fault+0x22/0x30
 [  745.556166]  ? mlx5e_remove+0x6b/0xb0 [mlx5_core]
 [  745.556698]  auxiliary_bus_remove+0x18/0x30
 [  745.557134]  device_release_driver_internal+0x1df/0x240
 [  745.557654]  bus_remove_device+0xd7/0x140
 [  745.558075]  device_del+0x15b/0x3c0
 [  745.558456]  mlx5_rescan_drivers_locked.part.0+0xb1/0x2f0 [mlx5_core]
 [  745.559112]  mlx5_unregister_device+0x34/0x50 [mlx5_core]
 [  745.559686]  mlx5_uninit_one+0x46/0xf0 [mlx5_core]
 [  745.560203]  remove_one+0x4e/0xd0 [mlx5_core]
 [  745.560694]  pci_device_remove+0x39/0xa0
 [  745.561112]  device_release_driver_internal+0x1df/0x240
 [  745.561631]  driver_detach+0x47/0x90
 [  745.562022]  bus_remove_driver+0x84/0x100
 [  745.562444]  pci_unregister_driver+0x3b/0x90
 [  745.562890]  mlx5_cleanup+0xc/0x1b [mlx5_core]
 [  745.563415]  __x64_sys_delete_module+0x14d/0x2f0
 [  745.563886]  ? kmem_cache_free+0x1b0/0x460
 [  745.564313]  ? lockdep_hardirqs_on_prepare+0xe2/0x190
 [  745.564825]  do_syscall_64+0x6d/0x140
 [  745.565223]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 [  745.565725] RIP: 0033:0x7f1579b1288b

Fixes: 3ef14e463f6e ("net/mlx5e: Separate between netdev objects and mlx5e profiles initialization")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 385904502a6b..8ee6a81b42b4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5980,7 +5980,9 @@ static void mlx5e_remove(struct auxiliary_device *adev)
 	mlx5e_dcbnl_delete_app(priv);
 	unregister_netdev(priv->netdev);
 	mlx5e_suspend(adev, state);
-	priv->profile->cleanup(priv);
+	/* Avoid cleanup if profile rollback failed. */
+	if (priv->profile)
+		priv->profile->cleanup(priv);
 	mlx5e_devlink_port_unregister(priv);
 	mlx5e_destroy_netdev(priv);
 }
-- 
2.25.1


