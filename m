Return-Path: <linux-rdma+bounces-12303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA84B0A50A
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 15:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D87AA2A90
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 13:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482A22DCF40;
	Fri, 18 Jul 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wPrnENv0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fZwcWDbq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE042DC32A;
	Fri, 18 Jul 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845033; cv=none; b=ke6NyDnXHdRqlI4/loAHzz8Cx7J3O/2cLatDnMV7pVJn6KqkDq+H/9CKDxMp7bTHQwJg0hDFQFzbk+DJt3kb6KUGnfz0sFjXOXiEZi7xHDLds9HLrBLeYRKFBCmH5tGJr1TQy98UR+ipFsCtRk439Ercl/IxQDmpP3k4BmK0C6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845033; c=relaxed/simple;
	bh=aDE2F+i5U/RwF3bKKM80JxNThsV/LVClmb28mInGzlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=li2w/YcfmCx6GQc8TjFhjVvV9tj1I2rweFFiG0P3pTaRG56Qf18OvuLLBOPNdde3aOEmpKVI727elBsbIus9+YVn/t4BfvC4Oq6Tb0XqqKbRQ002t96Ro9YktYQ7ELnLrNMmUnWxfZDPHN9Fdxh2VYt/pBLx0Xn1FTMkHalgAZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wPrnENv0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fZwcWDbq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752845029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4RLhqXeWrS5RgZJNQezfsxzg5XGF5Z2AEnOcuhDTjk=;
	b=wPrnENv06N8UIVCEh7GN7huPaGCkPrf/LRIrlWG9kf0JApUTTnwLnZm19AyEoH7EYYPnfe
	2rUyhQ89E479cPf0NfRdGMrzHQk2IMqWDme36KBciJwcdSAS9zxD2dec+bpsuEOyNQLFcS
	LuLSu0L6SHJh1XB0GXUnpIJWfFWMXX6l26AFsh/9ERH72Hw+VG9rpdqWxgrcu+chLMCQuQ
	ZddSey9m9XuaV6+eE/X6o6QoefcB+r66HKHyql9WrB8TwRS1IPNx29c0ff2O5Z8n3h6nDz
	xI5EhsjE9cTdGkyyrQQqbT+ZaglZP+0D/612LpG8eV3pePIfPX+/beOiyPsFyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752845029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4RLhqXeWrS5RgZJNQezfsxzg5XGF5Z2AEnOcuhDTjk=;
	b=fZwcWDbqEHE5G48achDLvaYWRQDua2DiiFMSnNPctFoKX+iSod4JKk8B0v4v9Z0ZHyMkja
	ee9ygxkk5Fd4fhBg==
Date: Fri, 18 Jul 2025 15:23:43 +0200
Subject: [PATCH net-next v4 2/2] net/mlx5: Don't use %pK through printk or
 tracepoints
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250718-restricted-pointers-net-v4-2-4baa64e40658@linutronix.de>
References: <20250718-restricted-pointers-net-v4-0-4baa64e40658@linutronix.de>
In-Reply-To: <20250718-restricted-pointers-net-v4-0-4baa64e40658@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752845027; l=1799;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aDE2F+i5U/RwF3bKKM80JxNThsV/LVClmb28mInGzlg=;
 b=GTdAOYrxRWkN606mCj94ouCBtR8Bj3//Ieq8iAC12TTJ5SRo1fgAgU5ZfYRMVlGgf3wvxj49g
 3DVA9ISChT3Bxqn1nQghWmkPNLSDLMlhVSweD9deb0BztPXeXYSi8uc
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
Reviewed-by: Simon Horman <horms@kernel.org>
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
2.50.1


