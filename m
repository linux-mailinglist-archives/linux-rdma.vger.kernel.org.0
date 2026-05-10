Return-Path: <linux-rdma+bounces-20324-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPMzAnsFAWptPwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20324-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 00:23:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ADD506ADF
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 00:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27A6E3007640
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 22:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4AD361647;
	Sun, 10 May 2026 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oucLIli7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9C35F18A
	for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778451826; cv=none; b=n02S6w09T68wzwqV/U6avm+Pq3tZghmQG5FqHHLlm/EtaONYvfevqIY5SVdFkhIVC/R2z+7Md3sWW1cCkMZ9BDtGp4YzUgqxd9GNgQNVau40fuZ6vfL7pt8R2FJJSJET57sgxoFV/jn8I6WQLvR5QG1DxunbsuL70cYWRjIr5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778451826; c=relaxed/simple;
	bh=JYuqqwM3Q/NCyB73B9zggRpuK1CAnClS5m4auWFtysE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuSOqEyH9m4xg06UQAkhqqVdkJ4tfaYhWwkSmWuclzJrbPxWAUWot7S90PFgJjZZDOFYP5UVuhuzs3J244DthOZm9OC9wFKv8X0NXrNi9QbV55zOYAsT4YbEwOpOM7AhH1nHZ0U/7QJzj5ibbzQ+CnSTgF5w+GzxJ5V3Qbw1IDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oucLIli7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891b0786beso24074855e9.1
        for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778451822; x=1779056622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttTut/Uo6EwTGXBeQX8rzoXbswkCtg8c9RsbPycbhWU=;
        b=oucLIli7DrXVjEWjbS2qvgTUgUd8YbDsIfug42OrN2NSdu4aNZszdR0GxZIP8lTtDu
         AfxMUECXPay9s+YpYFTpOWOkX9PQaIyx6+gwuT8zENckMFXzRqkboSJqPJWx71W76rij
         cifZGQGGqSsYYz2733LL0U8MI2JdsCJRjEbTy5M5uDaEYVm1NnCco0Wed4J5kM05eywE
         O+wfoXlcsNnbgmtPhEoo6/eKu8gvS44hX8gtqAKCeLqXQF1TumQuweILBRWelzD14vjj
         pZH8pdPz99yMnSEf86VCtIzQadORhDO+DTOGwhtWsTIXRnWNgicTYFmh077hW/7gp7gj
         rw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451822; x=1779056622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttTut/Uo6EwTGXBeQX8rzoXbswkCtg8c9RsbPycbhWU=;
        b=oRfSbRk45x8On74gtph8MXunyFc5sfs07eL17lh2VbFVn5bRWk0LF0o4jyigGossq2
         pKtdT9hWjdwE2E5ApUsuQQgl4DOiCyqTDafzGqgdbZi8/RB/t+bP1XoQ3Jj2Yv7ZRKso
         yqH5KFTXKe9qHWMJwOLJIX51Qt9H73++fcGXB1GQPLo2cazsnf2iKs5gesW4TL8l9aUE
         xi4A+fu4jAfwKRcmA1e+mNELlflOgghl8T1C0xUw6O6GQ/yI3I3eDKA/tNvaujyaR3jU
         0NbuX5xzrMFqr/26xTzvx5bNwDABkKtvYD+e9FCZ2YiW6pD7WQVJHu5yf7w9c02UACDP
         rLQg==
X-Forwarded-Encrypted: i=1; AFNElJ9puV1hqIuor2lnsG0XDHXV+S9nKF2zu6/xf6S9il5SNvaEdsbNSK/7DxeYx1P/y7swDwzicpWbYycx@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8zcLosy7yYAA5UCUDAslKL9meQRSAwoCwGF3v/6EFeMa7xhZW
	OFRnhoYo0Bze7HAeKQWr/NGj9guk2KdpmZN8AFouC1VzR3XjukIvm9KF
X-Gm-Gg: Acq92OGQX5jZGTqBvMnbX8IAMX9Bt8ZFHw9NerSIjFI007qqtm2xds7zqf1YHPcX4Px
	5G8mfv9RkxT7aVdGtfl0iNL1Zzaw+qHm0Wf11xtsKsWuqe0C4SD3k2rjtF4/JJhy76ZdV19tLs4
	Km233rU0T6l/5YQz4DYP8f3plWGt59MIDd4H2psHMceiD3Sacsb0+e8kfygZHyyuxP8aLctLm8z
	H4T5jQXX4weRpzpaAWo4LMufFq/gzdQSNua1Mxu3amjVWeY1UQmF2K/KoroWoKMYTNskCWASyjS
	rpDwk3pgGzoRpEhVzzrsevFYl/cw4vkhu0PkRO2ykuCEex45i4rSTKEeFKWEGsup8HtBEVQl68d
	krbrZvbOfLq3DIk3BKp9cH3bemdtiC2exrcAaibiVL9ESFBjuq1OZ0Y36plw4IIjfprNOMpjyC1
	I62FyPCke0Br9vTqC2k6ctT2/pjzlZ7Zc00qgUYxJ0fw1D+hs+CZ8T2ekt04/14Etefe2o5mcTQ
	YGVxYNxAJWcep+qRV2tOdvDtibze9Q=
X-Received: by 2002:a05:600c:696:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-48e51e215a4mr196798045e9.10.1778451821571;
        Sun, 10 May 2026 15:23:41 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6f9fbf12sm152399565e9.0.2026.05.10.15.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 15:23:40 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Doug Ledford <dledford@redhat.com>,
	Haggai Eran <haggaie@nvidia.com>,
	Majd Dibbiny <majd@nvidia.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v12 1/2] IB/mlx5: Fix transport-domain rollback and initialize lb mutex earlier
Date: Sun, 10 May 2026 23:22:53 +0100
Message-ID: <20260510222258.6654-2-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510222258.6654-1-prathameshdeshpande7@gmail.com>
References: <20260510222258.6654-1-prathameshdeshpande7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A1ADD506ADF
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[nvidia.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-20324-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

mlx5_ib_alloc_transport_domain() allocates a transport domain and then
may fail in mlx5_ib_enable_lb(). In that case, the allocated TD is leaked.

Fix this by deallocating the TD when mlx5_ib_enable_lb() returns an
error. Also return 0 explicitly in the no-loopback-capability success
branch, and move dev->lb.mutex initialization to mlx5_ib_stage_init_init().

Destroy dev->lb.mutex in the matching cleanup path and in init failure
paths after the mutex is initialized.

Fixes: 146d2f1af324 ("IB/mlx5: Allocate a Transport Domain for each ucontext")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/infiniband/hw/mlx5/main.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e02bfb1479f5..f6d9841c2bcf 100644
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
@@ -4464,6 +4468,7 @@ static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 	mlx5_ib_cleanup_multiport_master(dev);
 	WARN_ON(!xa_empty(&dev->odp_mkeys));
 	mutex_destroy(&dev->cap_mask_mutex);
+	mutex_destroy(&dev->lb.mutex);
 	WARN_ON(!xa_empty(&dev->sig_mrs));
 	WARN_ON(!bitmap_empty(dev->dm.memic_alloc_pages, MLX5_MAX_MEMIC_PAGES));
 	mlx5r_macsec_dealloc_gids(dev);
@@ -4486,17 +4491,19 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 		dev->port[i].roce.last_port_state = IB_PORT_DOWN;
 	}
 
+	mutex_init(&dev->lb.mutex);
+
 	err = mlx5r_cmd_query_special_mkeys(dev);
 	if (err)
-		return err;
+		goto err_lb_mutex;
 
 	err = mlx5r_macsec_init_gids_and_devlist(dev);
 	if (err)
-		return err;
+		goto err_lb_mutex;
 
 	err = mlx5_ib_init_multiport_master(dev);
 	if (err)
-		goto err;
+		goto err_gids;
 
 	err = set_has_smi_cap(dev);
 	if (err)
@@ -4536,8 +4543,10 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	mlx5_ib_data_direct_cleanup(dev);
 err_mp:
 	mlx5_ib_cleanup_multiport_master(dev);
-err:
+err_gids:
 	mlx5r_macsec_dealloc_gids(dev);
+err_lb_mutex:
+	mutex_destroy(&dev->lb.mutex);
 	return err;
 }
 
@@ -4786,11 +4795,6 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
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


