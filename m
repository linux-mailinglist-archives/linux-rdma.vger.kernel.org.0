Return-Path: <linux-rdma+bounces-19005-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDNNKAHb0mnebgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19005-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 23:58:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA02139FEDF
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 23:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE2893011593
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 21:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6523845A0;
	Sun,  5 Apr 2026 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkmthDRa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB0383C81
	for <linux-rdma@vger.kernel.org>; Sun,  5 Apr 2026 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775426281; cv=none; b=GKp0IRfvc+2wOvwwqE/XvZFHFPwdpfIGWVejH41hq2Gkq0Nksag0JV64eteNmDEpRP3bCsOS2e5JHw5WdeM0xP1iutFFXBwmoDYihJOre122RgCNcRX3QUD5RkI2WdtKVU8h9NcOtx0yld8I/yfet2c/K2+hYzO1TUcJDx7uR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775426281; c=relaxed/simple;
	bh=DdsGXKq7JrIi6Ap2XlQ6ivb0KWDCoxWf3NDaNcl8uRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEGAueaZ3EBsXdBe/tb7rua/55Fvz+VxZmHIChZomtoAx76vP08+I9UoAH59oCwEOCtKa0EzzSxgEyPnijjBc9XXTgqLo+12s9EUpXVAIvXkYv6sAolT/UY5rcYGLnh80wxbNGdsRBXrhIawpIFm7WfQGK/E/rTiqL9iYyldMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkmthDRa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488971db0fdso23158775e9.0
        for <linux-rdma@vger.kernel.org>; Sun, 05 Apr 2026 14:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775426278; x=1776031078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxHEOhMOVO/qSnCy85SUvcOrw4K95Fgay2xDlWGFRLU=;
        b=mkmthDRaH74shdqey89bMUVC9zSDyCGxatKCPdY6R1mGDD6jF0fYOcaZu8uMAS1dH2
         1QZI22hf+8BV7eysBxkts0SppAQyJWj3ZE7/8j9UYoJJJK9gQusx0R6ES0vmVAKjV+eH
         Jf7Jv8qvlqsnJ8nGFVd2OEyydo3xsM28pZg2tFxuXBZWBDJZkax2YAadfFgJPBROaYTE
         L5f6RXOkbnSEHwVg7ko1bjdjUy63ukawBKBcukNS2foVrO25Aka3mbTxaF4Djcet6LUZ
         av/XiY8DpGkzthG6NPlfMBntHRekmbGIsFwL98j5aCekxez6y3kLiBght2eclFJKbWou
         hCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775426278; x=1776031078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NxHEOhMOVO/qSnCy85SUvcOrw4K95Fgay2xDlWGFRLU=;
        b=fxVj+/OZeFE2P9FD91wO4/UMabbfxOiLZJLzhVlGh+YwvQ0kn349yZ+/ONLsV+P51J
         Zhb7RzVo1wQIMz3ellMc01EFnkatRZwxn70wZUvNUs9eCkRvyYVWhmsbv/pglfY7bj0Y
         ORR81C0L0WW7xaFMdq0nEqTWciWGX+O3oOXZiWqFRYrNriEBtAqxEYPkW9jrL+xrsVUu
         jEHDRhxydPSWrtgOUEVgt9amcPCc26bmCRVSWvlmcXmszAafpY5CpPCruVbAVIc5Wa8h
         ccCqThPvujui103M9gDTAOPuN8TSsq5vtBAGrhxgzLQXJeFx6U1mTg0l0Oa/uoLi7bHe
         bPIQ==
X-Gm-Message-State: AOJu0Yzz1R9QA1bWLMN344B1o2yzZhlljeBC6MLP+fLx6gZ0r3EN80fv
	njqGEf/g2QHZhOECXU6rRWE7W6HgtsnPzkqr4R0IpF+AF7Ku6b+dg3Ukk/yr6NTl
X-Gm-Gg: AeBDieuHUFnCAbof1RqLyYKo0hHQYxHn+6IDf+P7BBN9/wyWlqYSBJs5A0rg8p+eboJ
	/Zah8JgJAFxQBNp5Ntp1jlrNF6hObhxj5qnSVjEDPjG77wrWm/4hwD6dtB7iyu9S1iXyRg5BEtF
	pP/+xJmeuzV37KRRKnx887R4Zq1AV+fD2MLaqmsvGyLYlY0wT6jT7BUZvq5DCzrF5sh8WwaHkzr
	tuO473+xvtv3KAfxFnyrQ//CGzcIoTRZILcaz5bALjuYyeGKLEQNHjrrT4K8of6IOSUZPMTC/SG
	YHZTaRpgWsNptpxvPLNsl3azD3GrZoQPdIUVcpJgLdAnGvnkQKnDfYfE0XvS1lOfeymlttjT84v
	G2SQkFJrbrVoGG5DmnRus4STyQ/Tk9q+q28dGqbeSkDyGFCJc6zGcy0O7LqkDGPi6gDiiAo5R8m
	RToGPEIyq2FUz0gy5uolau1MLTNt1tO5tXyw1xg8kanxdD0vPy82jPnbjE3VMy+aafMwtsOQnzQ
	dYsLcWKPxsjSpvysxawVaJ8F0mi6cO7q7zIwWqj4JeYpmx8
X-Received: by 2002:a05:600c:820e:b0:485:40c6:f507 with SMTP id 5b1f17b1804b1-488997ee0bdmr157827325e9.30.1775426277589;
        Sun, 05 Apr 2026 14:57:57 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822227sm479479095e9.4.2026.04.05.14.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 14:57:56 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: prathameshdeshpande7@gmail.com,
	dledford@redhat.com,
	haggaie@mellanox.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/2] IB/mlx5: Fix success return path and mutex initialization
Date: Sun,  5 Apr 2026 22:57:17 +0100
Message-ID: <20260405215718.19301-2-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405215718.19301-1-prathameshdeshpande7@gmail.com>
References: <20260405215718.19301-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-19005-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,mellanox.com,ziepe.ca,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA02139FEDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix an incorrect return path in mlx5_ib_alloc_transport_domain() where
a success case could return an uninitialized error value instead of 0.

Additionally, move dev->lb.mutex initialization to
mlx5_ib_stage_init_init(). This ensures the mutex is initialized
before potential access by create_raw_packet_qp_tir(), preventing
a null pointer dereference.

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v8:
- Resubmitted as a fresh, independent thread per maintainer request.
- No functional changes since v7.
v7:
- Split from the main loopback refactor into a standalone patch to
  improve bisection and isolate the return-value fix.
v1-v6:
- Part of the combined "IB/mlx5: Fix loopback enablement state and 
  resource leaks" patch.

 drivers/infiniband/hw/mlx5/main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b74bf2697655..f49f746bc5bd 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2068,7 +2068,7 @@ static int mlx5_ib_alloc_transport_domain(struct mlx5_ib_dev *dev, u32 *tdn,
 	if ((MLX5_CAP_GEN(dev->mdev, port_type) != MLX5_CAP_PORT_TYPE_ETH) ||
 	    (!MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) &&
 	     !MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
-		return err;
+		return 0;
 
 	return mlx5_ib_enable_lb(dev, true, false);
 }
@@ -4515,6 +4515,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->data_direct_lock);
 	INIT_LIST_HEAD(&dev->qp_list);
 	spin_lock_init(&dev->reset_flow_resource_lock);
+	mutex_init(&dev->lb.mutex);
 	xa_init(&dev->odp_mkeys);
 	xa_init(&dev->sig_mrs);
 	atomic_set(&dev->mkey_var, 0);
@@ -4786,11 +4787,6 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	if (err)
 		return err;
 
-	if ((MLX5_CAP_GEN(dev->mdev, port_type) == MLX5_CAP_PORT_TYPE_ETH) &&
-	    (MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) ||
-	     MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
-		mutex_init(&dev->lb.mutex);
-
 	if (MLX5_CAP_GEN_64(dev->mdev, general_obj_types) &
 			MLX5_GENERAL_OBJ_TYPES_CAP_VIRTIO_NET_Q) {
 		err = mlx5_ib_init_var_region(dev);
-- 
2.43.0


