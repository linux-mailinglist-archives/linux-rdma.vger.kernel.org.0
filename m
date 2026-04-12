Return-Path: <linux-rdma+bounces-19247-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBo5A4Lz2mn87QgAu9opvQ
	(envelope-from <linux-rdma+bounces-19247-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 03:21:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DF33E2596
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 03:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7AFA303AAAB
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Apr 2026 01:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A392C11CA;
	Sun, 12 Apr 2026 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5f2huoM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9E28504F
	for <linux-rdma@vger.kernel.org>; Sun, 12 Apr 2026 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956804; cv=none; b=bDKqCFQbqKi+HOkjIdXdikPLjrnT/MwdEKp2u1EzRGoWRurD5M5YxNCX3zXmkms6t2w4Z/utW8GCg5TEsJTmoaGOoHY9KKIVmYx0hTExQyzgsDvCHoemF0PRY/RCF7E+ccJFzOVqco7YgGnx1UFAjxYGcwTgOYza827glh1HhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956804; c=relaxed/simple;
	bh=LeP2oP08iWfA527sR3xSm3hK0yGVnGcK8rykCpaWSGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZhjxOSOruwFR32ZW6L5CuhW5SL5s/XFpAxJm4oEoQZuTdsD1VG/l+WwYS+bDCVbEacdCnNxhvpWv/S5LNPnZILNwiK/ojZMI/x9vkNjCwdcKXzCXEoHWyZ5mEY1cL7tV5h8R6QdqiOzqDcpNSoleVzOQwBqS9giVocO/FpQqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5f2huoM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfce3a195so2027027f8f.2
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 18:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775956801; x=1776561601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CcaICa7vcqzbMPnF104DyEZHT8VB+CnqUsr4qDqEA8=;
        b=S5f2huoMKNnUyLhBacV0GL1WSKZHYr3Q7y5aI4DKA2yjy4hVbQwt73RsaBBBMLuKc6
         iYrn0YrAaEe7v7XeN9pfL+J7UFqjblfQgPShhZ23cT3To7NrMj5QbgqoG9fT3Ljl0TmS
         wK0xosiFeoFmgccg+t5xivJo9YE2M0XBuRVftuDxHvzoc5k2YJhsonuI/b3TtHnvbDFD
         hdsCelV1Im9W7Tf1ceuNEOdAsp0GuriPQXSs2CML9lIT96Xlb1nfgBn+8+ERA5qS6zzB
         Q4LitSFK2oqAmNqFeHCTaBnF8GLxPGrW/H26LjSGLOjhZO2EyVGujqMK/oFWvbzoQPRT
         luOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775956801; x=1776561601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+CcaICa7vcqzbMPnF104DyEZHT8VB+CnqUsr4qDqEA8=;
        b=WQjkz1TRecIR+ARYmNHJ23mD7U2LyiG8h9XgX7meLwYZx2O9jK4p4pYsUgU0xPpyDF
         iz7tBxuywhq9Sjq2JUWPp4mNliwo/FpMyVJ8Nw10tu3ikupIv8965e54/tonNEPbIwHi
         KSmOCzmOCtwB5zFUw1w/eZcuJLsXgnHqLXba4xjleHMxxAtQ93lO6pSVbuIwJuXvNDkt
         5Uuqv0R7Cy8pIM40PFL/MS1MRFJCE5xjZNWK2gvLstt3EtPn92oLnQhbqZGl04u3i1SF
         bKYYMCvAiTHzT8RLuwmPat5c0ZVvwLS0JCcMmgpryreep5Jzlpi27LEmU+GIxNgjmvAO
         +GRA==
X-Gm-Message-State: AOJu0YwVRgOM4cnAthaRxNN94OW3FhL5fX1PYN75cZmgAKFw5tO9zV0I
	CfrXTfwXQxFdRjoYDoQIkVX+IieXcaoCZiTMnGHX+FyQW6+Y5/yvp/Zao0kAQOZT
X-Gm-Gg: AeBDievPBP6gBjNnvBCpGUsxP33MP8aOv4SSM0OxkXiZSzCaGp4glSk2pvZvP02xQuh
	X1zPYbKRgQRaBmah3Y6Odr3d0lmTD2IIqLGPKegbbofWchilnzAkdQdd+40J/EDF31BDnOG2zG3
	hKKNdfeqSuxXxAjmrV62P25Ap6IO7bz+abacaDQ64pXo+KI9OzqyUAvznIbwOp+XylbAolxhmj3
	bzjTVe03ib1vXIxWvMIy6GLM7VI0AryEEmd4xNnbxNQzvR+mO+Hk2TsOai3FzVoqQ6qh8yxO3hc
	hC9e1adM+6kioNd4ruN7UHsh98EUW6+Mb/68AoaEf2QJTpiF6kX857FRN3F8ZDBuM3t07fRlEBF
	nguEnOD2TG3Mx4kBgpWuuAiiPSLCMMKmjlLYeOHKo2BUoqIEDhE2YuV872PvyRQ23uCaHhUK25L
	NxbJRC3WjL8JGPBVSXwEFxpdldi3Sn/TqfN0AmXTRLt/xnEuIk0qsJ0gnx74YeQxTPgPL3Xbn4V
	nzYGAkj8kYZfwSv6s3WKHfDrTTWTEA=
X-Received: by 2002:a05:6000:26c4:b0:439:ac6b:dd38 with SMTP id ffacd0b85a97d-43d642ab99bmr11346306f8f.31.1775956800948;
        Sat, 11 Apr 2026 18:20:00 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec295sm19903643f8f.14.2026.04.11.18.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 18:19:58 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dledford@redhat.com,
	haggaie@mellanox.com,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v10 1/2] IB/mlx5: Fix transport-domain rollback and initialize lb mutex earlier
Date: Sun, 12 Apr 2026 02:18:49 +0100
Message-ID: <20260412011942.13744-2-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412011942.13744-1-prathameshdeshpande7@gmail.com>
References: <20260412011942.13744-1-prathameshdeshpande7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mellanox.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19247-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61DF33E2596
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


