Return-Path: <linux-rdma+bounces-18938-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEYTHz4Ezml+kQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18938-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 07:53:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEF0384301
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 07:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39AA3302FF1C
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 05:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257D6363091;
	Thu,  2 Apr 2026 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="lnwnmM1U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (jpmx.baidu.com [119.63.196.201])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AC23A2FE582;
	Thu,  2 Apr 2026 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.63.196.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775109159; cv=none; b=a4vX6z7L5kCoMd9iqzAHfwqgPQmQU7vMm7SdNy2ZH76ySmSACQsigwwdhQyCk1F8byhdcas9jmBi5sYVCzpQYQQSO1QwGUpu+wDsRkMTJwxIHXQKKxAv6hVkcYZY0cNVcU19aYzfJe6BqR5u8p+XYJy2pnxrdd8HDvRo+lcn/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775109159; c=relaxed/simple;
	bh=PQppXGaETl7HsBl4FNqbEK6u0tJ+4rAmM7mQIV1pMso=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FabLClXTWZ9XJNsfqQs7NWE1m+BZ2RvUBpM1d6JudHwyS4gw0Ngu1vN6YspCYXHDX2vZT1/3FhL4VC10OazojjINdA4wc6w5XNzJGX2IKSdeIrbKP0sTL4oVIpEto0MQV5DOe/87x6d29QBZtBwgisqiSnlc69CC/lYgRWGuSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=lnwnmM1U; arc=none smtp.client-ip=119.63.196.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Boris Pismenny <borisp@nvidia.com>, Richard Cochran
	<richardcochran@gmail.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Li RongQing
	<lirongqing@baidu.com>, Kees Cook <kees@kernel.org>, Akiva Goldberger
	<agoldberger@nvidia.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH net-next] net/mlx5: Use dma_wmb() for completion queue doorbell updates
Date: Thu, 2 Apr 2026 01:52:06 -0400
Message-ID: <20260402055206.2311-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc13.internal.baidu.com (172.31.51.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1775109140;
	bh=OkYJlBEhGU26NMF/nb5A1ytM4XV7GIufN+Se8VGdGyc=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=lnwnmM1UPi9HcCJlunM4oqGJy6xxHBysvOaX/ybrWHhwb82H+z3eM5+AEQtwK0wPW
	 fqvG+O8pY4jziu04XNiwfmelBPvqcXue/lyQmgL3CVXBzB6s6IxtIXwGdeoaQ/nMgB
	 Bkx6PNGY/OZZgt/EusO6WFgnbIWRQ+jZdnt+OiMLJgUugz8KV7sfgQRYNCaYN5l6r+
	 t4aVAEt0g7mlp1DhdAa66UK2G7z5M2qsQc2HecvvvNP87yTvK+eXyITob2zyel5kHU
	 4MxZ2lvw+nj0OkhaaRycMZvz1PNoBvDcqAVRyua5wECOYmRLSZfgUVVlI3BmRGfzZo
	 eV5xDsaL1JkKw==
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18938-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me,baidu.com,vger.kernel.org];
	NEURAL_SPAM(0.00)[0.983];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[baidu.com : SPF/DKIM temp error,quarantine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[baidu.com:?];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_TEMPFAIL(0.00)[baidu.com:s=selector1];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ACEF0384301
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Li RongQing <lirongqing@baidu.com>

dma_wmb() barriers are specifically for ordering writes to DMA
coherent memory that is accessible to both the CPU and DMA capable
devices.

The dma_wmb() barrier is lighter than wmb() on some architectures
because it only ensures ordering for DMA writes, not for all writes
including MMIO accesses.

In the MLX5 driver, completion queue (CQ) doorbell records are
allocated as DMA coherent memory via mlx5_dma_zalloc_coherent_node().
The CQ update pattern is:
  1. Update CQ space (device reads via DMA)
  2. Update doorbell record (device reads via DMA)
  3. Memory barrier
  4. Enable more CQEs

Since only DMA coherent memory accesses are involved (no MMIO accesses
follow), can safely use dma_wmb() instead of wmb().

This change improves performance slightly on architectures where
dma_wmb() is lighter than wmb().

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c    | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c    | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c     | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c     | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c   | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/wc.c        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 1b76647..7bd6dfc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -259,7 +259,7 @@ static bool mlx5e_ptp_poll_ts_cq(struct mlx5e_cq *cq, int napi_budget)
 	mlx5_cqwq_update_db_record(cqwq);
 
 	/* ensure cq space is freed before enabling more cqes */
-	wmb();
+	dma_wmb();
 
 	while (metadata_buff_sz > 0)
 		mlx5e_ptp_metadata_fifo_push(&ptpsq->metadata_freelist,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 80f9fc1..dde8856 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -805,7 +805,7 @@ bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq)
 	mlx5_cqwq_update_db_record(&cq->wq);
 
 	/* ensure cq space is freed before enabling more cqes */
-	wmb();
+	dma_wmb();
 
 	sq->cc = sqcc;
 	return (i == MLX5E_TX_CQ_POLL_BUDGET);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 268e208..f17e7f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2447,7 +2447,7 @@ int mlx5e_poll_rx_cq(struct mlx5e_cq *cq, int budget)
 	mlx5_cqwq_update_db_record(cqwq);
 
 	/* ensure cq space is freed before enabling more cqes */
-	wmb();
+	dma_wmb();
 
 	return work_done;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 9f02726..7ba319f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -849,7 +849,7 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 	mlx5_cqwq_update_db_record(&cq->wq);
 
 	/* ensure cq space is freed before enabling more cqes */
-	wmb();
+	dma_wmb();
 
 	sq->dma_fifo_cc = dma_fifo_cc;
 	sq->cc = sqcc;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
index 1f6bde5..1341874 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
@@ -384,7 +384,7 @@ static inline void mlx5_fpga_conn_cqes(struct mlx5_fpga_conn *conn,
 
 	mlx5_fpga_dbg(conn->fdev, "Re-arming CQ with cc# %u\n", conn->cq.wq.cc);
 	/* ensure cq space is freed before enabling more cqes */
-	wmb();
+	dma_wmb();
 	mlx5_fpga_conn_arm_cq(conn);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
index 614cd57..8f7a89a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
@@ -421,7 +421,7 @@ int mlx5_aso_poll_cq(struct mlx5_aso *aso, bool with_data)
 	mlx5_cqwq_update_db_record(&cq->wq);
 
 	/* ensure cq space is freed before enabling more cqes */
-	wmb();
+	dma_wmb();
 
 	if (with_data)
 		aso->cc += MLX5_ASO_WQEBBS_DATA;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 7d3d4d7..1afbdd19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -314,7 +314,7 @@ static void mlx5_wc_post_nop(struct mlx5_wc_sq *sq, unsigned int *offset,
 	/* ensure doorbell record is visible to device before ringing the
 	 * doorbell
 	 */
-	wmb();
+	dma_wmb();
 
 	mlx5_iowrite64_copy(sq, mmio_wqe, sizeof(mmio_wqe), *offset);
 
-- 
2.9.4


