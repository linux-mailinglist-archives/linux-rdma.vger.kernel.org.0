Return-Path: <linux-rdma+bounces-9520-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41775A91DE5
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 15:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657CF3A5CC4
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EB524889D;
	Thu, 17 Apr 2025 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g6QoP311";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3PHqCejP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD132245011;
	Thu, 17 Apr 2025 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896272; cv=none; b=UabPgLCX7SybaJIUtSbdnmQiRoEHSuwwkjeoaI4Nnw5/xOXVVK/1iQPm69IwXVc9R+0j8EeA0y9kWuB7oB7DJKOsBPpRA3ZFrvXu2MjB59p8sO+s0329E/Bn9LnKkRFXsmn665VNsvjZUSl/VpzqPeZJ0pJfdeQfoDd8qQXoQyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896272; c=relaxed/simple;
	bh=1O27NFYPZ19IgzsREQln6IV5+vcG07b7Uu4J0pPD9hY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WoJr8lCwySE7hCZXKbEa5xFZ/jWmJIxD2M8+nuLGUxtzCRGpblPzHSvTt1QhwXVONB1KvelUlspC2zradPUDKM+ypGnW+o7ti6SvCHU/PvY/NezeSJ+YdoRAHFXd2aC5zhJitfXGEq6PxGplI4ZwU1318SkpUL7ouR0M84IdGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g6QoP311; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3PHqCejP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744896269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qeA/MlLg5TVbU0397qorNcHIJah7W1zDQiEVoWGxtM=;
	b=g6QoP311AeS6Mx1cg5R8FbGlIPKlDyonmDm7HQC5di/uZqWa5NMemkurzPCsuK1ygx4gs7
	7xZlHAyAxpa2BjqzLAiXrdSpyG7K8cnfHF1v9R4tX+m7fbDkYqERgyhbCKNiWA98eFo9dA
	rs9W1VEKHp4Rp92w+fGDOWgyCtuSS/Ovy8OJlNacqenWg2EM+sUjV65nMkzqf9v2sn0M+1
	EhWA9GAV+sFd90YAbwpxcJ0S7faDeIgzAuDvKUB+uEoO2yavl8/Uzl/TWfdjdc1kcbRXKK
	szOnXS7VLoPLgUbHla/WOiAMRQgpMQdZkaqbGZfMaq+Bs/bZbeCii9jktLQpow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744896269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qeA/MlLg5TVbU0397qorNcHIJah7W1zDQiEVoWGxtM=;
	b=3PHqCejP2SQSvoddhTitFoMUXI2U5NWhD1r/og0rnq8ykl4l7StGnf+hPP9a0v4aH017Bl
	g39UzVDsYL5H75Ag==
Date: Thu, 17 Apr 2025 15:24:02 +0200
Subject: [PATCH net-next v2 2/2] net/mlx5: Don't use %pK through
 tracepoints
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250417-restricted-pointers-net-v2-2-94cf7ef8e6ae@linutronix.de>
References: <20250417-restricted-pointers-net-v2-0-94cf7ef8e6ae@linutronix.de>
In-Reply-To: <20250417-restricted-pointers-net-v2-0-94cf7ef8e6ae@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744896267; l=1753;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1O27NFYPZ19IgzsREQln6IV5+vcG07b7Uu4J0pPD9hY=;
 b=WC7ZK4Hrm/09jUGuveXUDEo+yg1Ik/GZ/ozPjzk7bqcG8rwjI0WtWwjvGegAgrwKQQVmE6mxP
 tIYIHp8vJCrDD7rFXaoatFMXxgBKxvKuuCUaIpm9Kp86BgyBvjNtJS/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through tracepoints. They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h
index 0537de86f9817dc80bd897688c539135b1ad37ac..9b0f44253f332aa602a84a1f6d7532a500dd4f55 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/diag/dev_tracepoint.h
@@ -28,7 +28,7 @@ DECLARE_EVENT_CLASS(mlx5_sf_dev_template,
 				   __entry->hw_fn_id = sfdev->fn_id;
 				   __entry->sfnum = sfdev->sfnum;
 		    ),
-		    TP_printk("(%s) sfdev=%pK aux_id=%d hw_id=0x%x sfnum=%u\n",
+		    TP_printk("(%s) sfdev=%p aux_id=%d hw_id=0x%x sfnum=%u\n",
 			      __get_str(devname), __entry->sfdev,
 			      __entry->aux_id, __entry->hw_fn_id,
 			      __entry->sfnum)

-- 
2.49.0


