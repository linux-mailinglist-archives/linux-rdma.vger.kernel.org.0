Return-Path: <linux-rdma+bounces-18924-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEY1ERWezWm9fQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18924-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 00:37:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A803D381095
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 00:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C77E3024C84
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 22:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC623D648C;
	Wed,  1 Apr 2026 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDkNzTxK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C63CD8AE
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083023; cv=none; b=AdOQppny9486BKUhOp7R8PD7M+IAVpa4xPNuk33iCtjqFNrefdEpG5cpy2ZIJSVjgUy3a1da1sCqc0BtEPGrrqqcY/v//hE76ksHc7Yx8ThQan3zxk6iC2bxS89yWOyIz5Gm6bFho/gQzTLOVstBU6k0p9Ti33T7TwqRI79+w18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083023; c=relaxed/simple;
	bh=4rMAAirtKvyCDqoRrw6ORajqieswQnbEv6cHcq12FEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlUWn7TEOq3+z96LpzQ2bS+WIxYBRkxsuuq5G4nLT118FRRHq5ynG/IWoNJGqMXd8Q4j8gt0teycSABCMriWIYmWHex7GSxVUvpowm5iM924+j57mxD9i0RqQlrRKWTTi4ROJVHr7tGHQKndl0B6D+MN2Gwpr4DA/WimRG8Q4QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDkNzTxK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso1795765e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2026 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775083016; x=1775687816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPTqHmm+mcBn865+o6reF9Ra06TvDtBCNwLriGowBOI=;
        b=GDkNzTxK3vZrL/a90o4Nh6tVX73AAQ93X/h60hyOosqOVhMi0V+Jdz33fcvhB+SXHX
         GIYxcU4Rm2QRz4zYP+a/HPcroK+ti/+WZvs5RA7cuCex9JO8uF1xoIhjRvnPBuT7mA4b
         zOpuy3cIH3XUdVjpP9OmpA9XGgb1huPCBXglv3WqtRDZbv+fG3aerdPHit9STJ/oTTBA
         Ctony+3vYMDL903Jr9vRlD1PT+B8r88AALedNk/ku9cFJwpaGm4E7HoJ/gSCPjT8qAmE
         EQVzsRZUGLTalfJ96Ci7MiGwueKm9oVg8wjtyhOjoCsxNqffuHy0UbJnIam9j16PMRUY
         hU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083016; x=1775687816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rPTqHmm+mcBn865+o6reF9Ra06TvDtBCNwLriGowBOI=;
        b=aSyUWedxM69y3t+LXmwFIMGF6QBLPsfxurX+1QTYP3PiV4Rbzzu8aqj+ZH71gppROj
         FR/F+b2G9ecEd61DzM5Bg+Kq7exdpeNNOKExaP0FLYjLdLVxUEGAftpf0v/eVnoduIuL
         +HeOUWquEl5r3AqH/jOjK+7sr7Q/goYbu+fnz2cvPwHwMoejmqBays4kt2h8ALv4Yl/s
         l6MKwrZ3TOo17CUIPkDxchpTfNgjtxCZf5p9onVXCdOUQnDmnlJpTimY5i9YAEHb9IUt
         7/wHhuEJMfRdO9cbsSk5UIrUwANu9fO6n9PluiWuHBahyCQ4ekDNsfxI0a0tGXJz5f1Y
         OZsA==
X-Forwarded-Encrypted: i=1; AJvYcCVaNwxlycXzfJJCO7Rh1HySSuxbYiZiiIxumyJFfYNFTMFC92EtpQRYyrijdqDGs1WurlbYrchCdQsP@vger.kernel.org
X-Gm-Message-State: AOJu0YxMoNxZi9f152Dy0BqZEHTTHyEKIWAXuy+PSn2X0+l1mCqjcTY7
	eytqHHidRb25X1/xpcf9zCBA8QgaGypGwpW+9HcRXh8FNrbzZAWtR5LZTkdeT2Zp
X-Gm-Gg: ATEYQzzTh05DmEU175Vy2sxLVlXWA4KX+AyX285bB2cZArK9SmdCvD45rxqrUu1Aqby
	gGuVEcsTiHQxO0uqI/sdQjeFexZZOckkFvoedXifWwSVWGULBqoqpR8uB5L8vrXmiK+0GAt95GD
	WNtyeeICasle0sRwpK0i5bRresQYa1DzS8nmZ1vnu3rdHBKEvujYlBT27ifa1EVIqmR4aF9ZmUu
	cOPxFFgLov0UwBxlsCZmecMmIcl24uubMk8E4q0sobmOgE5TBgU4LrwiYo3IdiLgwQ7tED5Wsv7
	TrsbScvybSTdht30zVy8N4y3rLEJF++aq9v1hpyyIJyIpt4OxqlQvm4yXK6/l0jzkW0EEs9tTQt
	JEFiu7C7DflwYEed6UJC5csDJUgoKAnlfBplB4lE/fQOw1l6RB9lXPYgZO04rzeYyzHW76KryPo
	QI4sBEQoEYgVNRde14i0qoNWZvgNKBPzMB22gJSLM38t5U+hrS1W7I4bfe48o2bnsOx+Ao4+tbp
	aI/rNnno4O/v4P8mh+evYBcW2TuXcm3xo2xSwxDMO46IInu
X-Received: by 2002:a05:600c:848d:b0:485:3c66:e230 with SMTP id 5b1f17b1804b1-488835b78f1mr98532205e9.29.1775083015767;
        Wed, 01 Apr 2026 15:36:55 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a705ebdsm30503715e9.10.2026.04.01.15.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 15:36:55 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: prathameshdeshpande7@gmail.com
Cc: dledford@redhat.com,
	haggaie@mellanox.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH v3] IB/mlx5: Fix tdn leak and state corruption in mlx5_ib_alloc_transport_domain
Date: Wed,  1 Apr 2026 23:35:50 +0100
Message-ID: <20260401223550.20040-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331230852.18479-1-prathameshdeshpande7@gmail.com>
References: <20260331230852.18479-1-prathameshdeshpande7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18924-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A803D381095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_ib_alloc_transport_domain(), an early success path was
returning 'err' (which is 0) instead of a literal 0.

Additionally, as identified by Sashiko, if mlx5_ib_enable_lb() fails
at the end of the function:
1. The allocated transport domain (tdn) is leaked.
2. The internal loopback software state and reference counters are
   left in an inconsistent state.

Explicitly return 0 in the early success path. In the failure path for
loopback enablement, call mlx5_ib_disable_lb() to roll back the software
state and deallocate the transport domain.

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v3:
- Also call mlx5_ib_disable_lb() on failure to roll back software state/counters
  [Sashiko].
v2:
- Added deallocation of tdn if mlx5_ib_enable_lb() fails [Sashiko].
- Reworded commit message to reflect the functional fix and credit the tool.

Hi Leon,

In this v3, I've incorporated the additional fix identified by Sashiko.
Beyond the tdn leak, Sashiko pointed out that a failure in
mlx5_ib_enable_lb() leaves internal software state and counters
inconsistent. I've added a call to mlx5_ib_disable_lb() in the
error path to safely roll back those changes.

Thanks,
Prathamesh

 drivers/infiniband/hw/mlx5/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 635002e684a5..3d9f0e2e7548 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2068,9 +2068,15 @@ static int mlx5_ib_alloc_transport_domain(struct mlx5_ib_dev *dev, u32 *tdn,
 	if ((MLX5_CAP_GEN(dev->mdev, port_type) != MLX5_CAP_PORT_TYPE_ETH) ||
 	    (!MLX5_CAP_GEN(dev->mdev, disable_local_lb_uc) &&
 	     !MLX5_CAP_GEN(dev->mdev, disable_local_lb_mc)))
-		return err;
+		return 0;
+
+	err = mlx5_ib_enable_lb(dev, true, false);
+	if (err) {
+		mlx5_ib_disable_lb(dev, true, false);
+		mlx5_cmd_dealloc_transport_domain(dev->mdev, *tdn, uid);
+	}
 
-	return mlx5_ib_enable_lb(dev, true, false);
+	return err;
 }
 
 static void mlx5_ib_dealloc_transport_domain(struct mlx5_ib_dev *dev, u32 tdn,
-- 
2.43.0


