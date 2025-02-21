Return-Path: <linux-rdma+bounces-7948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 086BBA3EF94
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 10:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405797A9B36
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D946200110;
	Fri, 21 Feb 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RWpNzL91"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A461FF1CB
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128865; cv=none; b=D8SgydUrAP9IjdjB/rxHjUfoE1ynei8O04cloGo48uXHVMgDTfE7BvaL40HEwxfOoD/PSkEQFArCXs7w46ixmR+0DSKTD1OcuPe23mYBE4tfS/t01Ifx7moK6kPKxOjxGZfoh5D22E6nNveyEKtMTXPNSN8ZL69Su65T+ygjWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128865; c=relaxed/simple;
	bh=ZoewP+I7MPJSYwRR1gmRB8PDPc9ZAqkchO++ck4YW7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aS3MMASguNTa4PW1UkJFeSmB1c+qfPUv5rYxxmigqbx5iCQHzCN8Ph1zFkvAtHuyZiU09xpM/jkTuprBRSLRu+TweiGXQLA/kI9S4mpFFJ+gJOvTn8l1zjgtA/SP9CZVdWthCnioH8w0+mMbeD1kDozHKEG//g+Hwl/KveXBBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RWpNzL91; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740128860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wprGiDaMDqnJuc56NWAkjn4Xo990TLMpiIEvRYQHvNA=;
	b=RWpNzL91fOV76E4FT0Qg1C1hW03gGljtkq+1rcl4o1rRdp8vAwk2Q3E5EhojRW8NAMhROb
	B4mqaqvylpwrNmXriJqprBcMf3Kg690gJS8tS8Dt/IwPPFWgibki9ZwbfcZjPFL5ccqWZe
	cROndeaTRWEenWJIUJbVqOww26KKyLo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Saeed Mahameed <saeed@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH net-next] net/mlx5: Use secs_to_jiffies() instead of msecs_to_jiffies()
Date: Fri, 21 Feb 2025 09:53:22 +0100
Message-ID: <20250221085350.198024-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use secs_to_jiffies() and simplify the code.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Resend with "net-next" in the title as suggested by Jacob and Saeed.
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 3dbd4efa21a2..19dce1ba512d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -220,7 +220,7 @@ static int hws_bwc_queue_poll(struct mlx5hws_context *ctx,
 			      bool drain)
 {
 	unsigned long timeout = jiffies +
-				msecs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT * MSEC_PER_SEC);
+				secs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT);
 	struct mlx5hws_flow_op_result comp[MLX5HWS_BWC_MATCHER_REHASH_BURST_TH];
 	u16 burst_th = hws_bwc_get_burst_th(ctx, queue_id);
 	bool got_comp = *pending_rules >= burst_th;
-- 
2.48.1


