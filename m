Return-Path: <linux-rdma+bounces-19360-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFaIJQTa3mkyJQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19360-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 02:21:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 170923FF479
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 02:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B90F30886E0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 00:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C72A21C181;
	Wed, 15 Apr 2026 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3DHhfh4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AA240DFB8
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776212419; cv=none; b=kBNWzY2HwSxEO2qNRoavCWmT0zIWFMrMnuuXZ6ekNq0Gpj3fwTLLtbJpOcOQhc9m/YmidJqq/K4UZM8eQQssh+XUUa+cd0Tb4MH8PGIfnnH+x8gIAQpUBBGUsXjPTmfRSKhh6xavVQj2mdN/JIBlZq6b7jLjGV/eF8cIncrx/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776212419; c=relaxed/simple;
	bh=LeP2oP08iWfA527sR3xSm3hK0yGVnGcK8rykCpaWSGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFyZTTmGRTL0xnWN9k69J+hUyHbp1FHOQk/XVZc4nu3ZMyT28ekmFBIGDnWuigq3kfu2lv7WR4zf5Uc5FJ60v6VZyAEzEB8MwH2E1GDnDjGaY/t0hsWnsYHuFUpSoNMsvETpIOXwulwYXWchDNpR525uXDAa1FSJGlBh3yPRuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3DHhfh4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so83475665e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776212416; x=1776817216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CcaICa7vcqzbMPnF104DyEZHT8VB+CnqUsr4qDqEA8=;
        b=G3DHhfh45SwN4W1vmoXqCdSnXKPnTFwtsBzFtEfw3LFA8zVCpnLNwDz0Han4P8ZE1+
         IXECWfUDqle5hhFzdZICqsT+gMJr49CzoeBeJVZS/Gy6g446iRj0CYjhNtXhjB+CWUzM
         87QOPP7eM1t2LufF8DmfwAVCDuphCP0W/PGFGSDjD2V633bBFN2UIbAIFJEBIDNKL26g
         OPO3nEyG8f0l1XIxXyyUaJd7hNQYO8sOG0eEfleP1Smi8jyIOgz/nirzinwvsUIMbC1k
         oxBqEGXZiYaw+WvYwAKUZW+zVb5Sa0tNhOH6pA+GhOTWX4GybZlPk+7X7gcwbLbiil2i
         Jexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776212416; x=1776817216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+CcaICa7vcqzbMPnF104DyEZHT8VB+CnqUsr4qDqEA8=;
        b=CovbiHllVvo1H3NT1K36UPUnZvLiBqIoOATdKqFccSSLRwsfPh5yjqdjA7yvsWsWBr
         X1aPSsR/54VWHx0yrh87T0W9GHyHw+p1aeJnvsDhWgruykYYWzcOz6HFdvezX3G3qWIo
         0D80A30ntxGXGDqgGT7gI1cIjrKhIBdwGXoUkApfbzQcE7NJY+sGL6eZcEiiJuGbnRmR
         +RdI7KIgf4eRWVPmUEjMl8hfVQoyVzx0uKAEm21ejJPvTdOtnApLptT2MVPc4Wt7SrCV
         KZZv1xc1TohencfkvMgGPO8fIWtlSSUcCvv3kXfZNO9K51ePV+B6foQTIikkKahOeGT4
         zPTA==
X-Gm-Message-State: AOJu0Ywb6ai0zlD1MKL2uc2xNi/rFPBeyZSfH63OZVUcKMx2raG2cOYH
	zxkbxKotzW1YvC1Kg/lKXXejZumcPxBC6VEG18DWgSO2w8O4lAiuaiVe
X-Gm-Gg: AeBDieuR+BcVJQ0x/k1U3Cun79a1QBdRQtW78o5jIWIhZyIfG/D/drdr1emvrowEz5W
	X9fhYbwWsrTewJXisvcyQfYikwiFSJ2Y4JKPR9ksnzqI4wvJM/Jptt4p/xEynze/NovGiaPCVQp
	8xsZQ5bX7i4C7RGeG+B9HCxr7w3IxAVZXkxFPBUo0xTf2Hl1ukr240YFUUR+oUUJnpESfaHFOuA
	OO3KimBnfazHIJVlIiUkJLxOMUmRt9wEAHW0eREuWEXWlvnlVpteaN/N9OTuDedzDbsjM/RBJlr
	yLJF3S8xJeVbzcKf5mpBw9PTeAUDDpvsZSlB8JxMvl50n7ZotqR5jt73omDc/yIwEvxjqKrt2j0
	xgzcybnxVyHK8qXhRFKZHrs0FnkqPptr+xSG21AXBrFuGElg30HX/LxQSAaJT3h0rMKpiRc4CS7
	eTD88yrDwvIyrvG4pK5Gz9CMsyfNKpmjfDX+gMcwGIZqHGYr8cYDoY2D3pr20H4Jzam0qpOthrE
	2rW8FmwIWFoblnY2HxqtlWUctpP6ye/mt3+/r7wqQ==
X-Received: by 2002:a05:600c:8907:b0:488:a14d:3d8e with SMTP id 5b1f17b1804b1-488d67f4c6fmr185812345e9.11.1776212416157;
        Tue, 14 Apr 2026 17:20:16 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee03898bsm83149055e9.11.2026.04.14.17.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:20:15 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dledford@redhat.com,
	haggaie@mellanox.com,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v11 1/2] IB/mlx5: Fix transport-domain rollback and initialize lb mutex earlier
Date: Wed, 15 Apr 2026 01:19:45 +0100
Message-ID: <20260415002001.25702-2-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415002001.25702-1-prathameshdeshpande7@gmail.com>
References: <20260415002001.25702-1-prathameshdeshpande7@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mellanox.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19360-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 170923FF479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx5_ib_alloc_transport_domain() allocates a transport domain and then
may fail in mlx5_ib_enable_lb(). In that case, the allocated TD is leaked.

Fix this by deallocating the TD when mlx5_ib_enable_lb() returns an
error. Also return 0 explicitly in the no-loopback-capability success
branch, and move dev->lb.mutex initialization to mlx5_ib_stage_init_init().

Fixes: 146d2f1af324 ("IB/mlx5: Allocate a Transport Domain for each ucontext")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/infiniband/hw/mlx5/main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e02bfb1479f5..b3b297bc2f2b 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2068,9 +2068,13 @@ static int mlx5_ib_alloc_transport_domain(struct mlx5_ib_dev *dev, u32 *tdn,
 	if ((MLX5_CAP_GEN(dev->mdev, port_type) != MLX5_CAP_PORT_TYPE_ETH) ||
 	    (!MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) &&
 	     !MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
-		return err;
+		return 0;
+
+	err = mlx5_ib_enable_lb(dev, true, false);
+	if (err)
+		mlx5_cmd_dealloc_transport_domain(dev->mdev, *tdn, uid);
 
-	return mlx5_ib_enable_lb(dev, true, false);
+	return err;
 }
 
 static void mlx5_ib_dealloc_transport_domain(struct mlx5_ib_dev *dev, u32 tdn,
@@ -4486,6 +4490,8 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 		dev->port[i].roce.last_port_state = IB_PORT_DOWN;
 	}
 
+	mutex_init(&dev->lb.mutex);
+
 	err = mlx5r_cmd_query_special_mkeys(dev);
 	if (err)
 		return err;
@@ -4786,11 +4792,6 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
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


