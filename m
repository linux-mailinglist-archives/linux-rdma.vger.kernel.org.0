Return-Path: <linux-rdma+bounces-11422-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44BCADE44C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 09:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2763B6CD2
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 07:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB2827F009;
	Wed, 18 Jun 2025 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FQpO8WFl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qw4ozD8y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0B27E050;
	Wed, 18 Jun 2025 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750230500; cv=none; b=rn6uHR4HfMmGO2XIb07OpF1SSF3UTPS858Ukl2IYDXek3CSmN1HQync6akpttXCOuHjvcksbOHc1j5VjE52lvrLj1fbhyHTuwVY2noVtadt7DEqoVap1+KfwSJQAZbehOUqeijN0ljvvGrqtu+4S6PypsPTh2WM0UAkeSXb5bbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750230500; c=relaxed/simple;
	bh=LwyFCg1hPwOB3FrGaSxk8SWGYFXPgImSK0vRpO9RTGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rRnzQSC57ITyEERUTFSUG8VFHcVfriTJp1AdfCIVRhCGXDs2cm9fgr5avjO8iC+gf0+uiRnBmPmuBKaxyR3uanYUVHYM+5ncVkrPdkDl0KsHLg514CVXVLbXy+fiqrIohyb3U9d9elszsX9B2V/3B2N+qwWHpU0kS6CO/hXeVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FQpO8WFl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qw4ozD8y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750230497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGK97/9CBMGDn1jVvJaZcWRYHnqpFOoQ221JfSRUEOg=;
	b=FQpO8WFl2oBTyLCDow7uKVsRvnflLcvil+7wIDFgdbPYXYP/UbzO7jjfqqYFBvVMijtijt
	YkOqKWQxoOhHtRNArJVJBdxMWLFOPkskfRORyNBv8btHYBfzgjszPzjDoSxyYXQDgf7sNV
	RdYITFD9Jfhkl2a1bhMEz3IZmneFo3YxNrKnBY384JHbkbHIudc364rm8A5vDYIdhmwM/Q
	g+EI8SBWc9pAf3EVMRm0g/VyFT1NLp9mZhH2cBDSXBVSvo3PcQ7/vU5ioHYREQr78mpsaq
	Uby/FexnPEbHm4HZ4W3WFQufnUJQKWCs6jxK2Lc8dz3aqNXn+dRJfSnmfR4Rig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750230497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGK97/9CBMGDn1jVvJaZcWRYHnqpFOoQ221JfSRUEOg=;
	b=qw4ozD8ypbX6sEExvdeQ6aL78/JpSKiRdkhsJQnbbvL+r5jKr7ObW3DBGMXoq8jE2aXhrl
	rcKFMOmoRHWciQAQ==
Date: Wed, 18 Jun 2025 09:08:07 +0200
Subject: [PATCH net-next v3 2/2] net/mlx5: Don't use %pK through printk or
 tracepoints
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250618-restricted-pointers-net-v3-2-3b7a531e58bb@linutronix.de>
References: <20250618-restricted-pointers-net-v3-0-3b7a531e58bb@linutronix.de>
In-Reply-To: <20250618-restricted-pointers-net-v3-0-3b7a531e58bb@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750230493; l=1753;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LwyFCg1hPwOB3FrGaSxk8SWGYFXPgImSK0vRpO9RTGI=;
 b=13EGGL/pGeWrq7COE6/dKm8CewTN7vPHrb2NvryTUPw/D9EerXvdGKcYEGE1UY6c7bzvm7zga
 ltZrQmo2USMB4QuewDf0McoGBUfAx+i/7ntsCusdqHTzWh4p1uLIHWU
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through tracepoints. They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

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


