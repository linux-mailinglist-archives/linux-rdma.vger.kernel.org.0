Return-Path: <linux-rdma+bounces-165-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8264A7FEC5B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 10:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868661C20DF4
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 09:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D926D3AC25;
	Thu, 30 Nov 2023 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-rdma@vger.kernel.org
X-Greylist: delayed 573 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 01:57:03 PST
Received: from mail-m25476.xmail.ntesmail.com (mail-m25476.xmail.ntesmail.com [103.129.254.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E859A;
	Thu, 30 Nov 2023 01:57:03 -0800 (PST)
Received: from ubuntu.localdomain (unknown [111.222.250.119])
	by mail-m12750.qiye.163.com (Hmail) with ESMTPA id 5D1DAF20542;
	Thu, 30 Nov 2023 17:46:59 +0800 (CST)
From: Shifeng Li <lishifeng@sangfor.com.cn>
To: saeedm@nvidia.com,
	leon@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ogerlitz@mellanox.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dinghui@sangfor.com.cn,
	lishifeng1992@126.com,
	Shifeng Li <lishifeng@sangfor.com.cn>
Subject: [PATCH] net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()
Date: Thu, 30 Nov 2023 01:46:56 -0800
Message-Id: <20231130094656.894412-1-lishifeng@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBhOVkkdQ0pPTEhNTRlISlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSlVJSUlVSU5LVUpKQllXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8c1f9fddd3b21dkuuu5d1daf20542
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjI6Sjo4Sjw#HhA3HgsVIS5L
	OTowCzFVSlVKTEtKSEhMTUlLT0NMVTMWGhIXVRcSCBMSHR4VHDsIGhUcHRQJVRgUFlUYFUVZV1kS
	C1lBWUpKSlVJSUlVSU5LVUpKQllXWQgBWUFISEpNNwY+

Out_sz that the size of out buffer is calculated using query_nic_vport
_context_in structure when driver query the MAC list. However query_nic
_vport_context_in structure is smaller than query_nic_vport_context_out.
When allowed_list_size is greater than 96, calling ether_addr_copy() will
trigger an slab-out-of-bounds.

[ 1170.055866] BUG: KASAN: slab-out-of-bounds in mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
[ 1170.055869] Read of size 4 at addr ffff88bdbc57d912 by task kworker/u128:1/461
[ 1170.055870]
[ 1170.055932] Workqueue: mlx5_esw_wq esw_vport_change_handler [mlx5_core]
[ 1170.055936] Call Trace:
[ 1170.055949]  dump_stack+0x8b/0xbb
[ 1170.055958]  print_address_description+0x6a/0x270
[ 1170.055961]  kasan_report+0x179/0x2c0
[ 1170.056061]  mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
[ 1170.056162]  esw_update_vport_addr_list+0x2c5/0xcd0 [mlx5_core]
[ 1170.056257]  esw_vport_change_handle_locked+0xd08/0x1a20 [mlx5_core]
[ 1170.056377]  esw_vport_change_handler+0x6b/0x90 [mlx5_core]
[ 1170.056381]  process_one_work+0x65f/0x12d0
[ 1170.056383]  worker_thread+0x87/0xb50
[ 1170.056390]  kthread+0x2e9/0x3a0
[ 1170.056394]  ret_from_fork+0x1f/0x40

Fixes: e16aea2744ab ("net/mlx5: Introduce access functions to modify/query vport mac lists")
Cc: Ding Hui <dinghui@sangfor.com.cn>
Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 5a31fb47ffa5..21753f327868 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -277,7 +277,7 @@ int mlx5_query_nic_vport_mac_list(struct mlx5_core_dev *dev,
 		req_list_size = max_list_size;
 	}
 
-	out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_in) +
+	out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_out) +
 			req_list_size * MLX5_ST_SZ_BYTES(mac_address_layout);
 
 	out = kvzalloc(out_sz, GFP_KERNEL);
-- 
2.25.1


