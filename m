Return-Path: <linux-rdma+bounces-19362-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBmCEhLh3mklMAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19362-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 02:51:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C190D3FF627
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 02:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75CC53049967
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB612874FF;
	Wed, 15 Apr 2026 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXeOqfPR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D723E320
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776214235; cv=none; b=EqSIXIJOle3myvKmeAZB7xCiuG/T+1uyOuuwbK7QVnduJuMl2NWFRKje2CX2iuAbAy+SrlUrELLhykM8skJ+grQVRdba+koztHjLkPhdwgiU46TS5anebm4ckM6le+j+bGChESeE1lUWDa6u+UjNdC8Qx46c/vRQx4Nrc5WiX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776214235; c=relaxed/simple;
	bh=0HD1sM/H6vtsyRXMKFt2dw1zMlPDCFSkbhdELIpF2T8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqTrhYx5ITasiomcgcigg6rSDRVChdxatBF1pW/HTvhpQEj25Y86sYmfqFqaqo7nNkJQQGhwY1Y7Pr057pSlTcnBhKWnIIYbrwkALVe/RIedkNrqde62gc/e4VndNUrs8dINtuXpOsarupZop81Az+EyRugdfpoW2hsz2m6y4CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXeOqfPR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso101374075e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 17:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776214232; x=1776819032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWmbM2eqBTaj0A/LB8ecXRl5QyDwV/1SX44TmFsuPUk=;
        b=XXeOqfPRBKeindy91jbxf+nars1KQ5DFJBl7x1SBTUXTX4V/a9IE8VsAUYXo+FCAdx
         FEmcSUuhRfBGkBIdB6f6U/slqSDmJpBCEMTZoNTSSov18ckGfYmQ8EX7ti/bcg2rJGEu
         w67Lhjf6CgGO2UtxTdKVVxYp/JT5QSjLn1QYtMeSkjkQzKcpfNQhbr2MjzSla5OU8rPn
         foM593Lxok48uM4FwUffpiiumZXeBCUfPK6o6aP+RBoCOwv3RNZnljvzXhr/GrocTBvC
         P1ctwfpVdbGs/yXnsSMjKnmB8mqiUHbS0DITBLoPV4Z12HbeNy79sjiYgzqWz5WSVTxC
         TJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776214232; x=1776819032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWmbM2eqBTaj0A/LB8ecXRl5QyDwV/1SX44TmFsuPUk=;
        b=sJotRBD2ujkRo9ULD1XT96n0sGu6RXgGSL2K9f0Vj7xIODAdWeAtSb/13bu6me5QYa
         Pdq3hjs7TiEgwNeg/ys5sT47JHbSGBJXirFytRx8sK1nXmw4ziwsPIDJEYJnL6T5cswH
         yfYwHl/0fgR3DF1gzpcHlYnJfQrVKebgGdg4iI7w3LY91N424o8Zk53mhWSzg2tYrLGA
         uJr46vgSTSckEIHZTvsEUziqGVYlfl4FBg111/qAbUjSHb4goFLQWVV1Mfwp3aacRJvh
         KruX4jaFibkhELnZXFAz1xzMKtlYKBDpUxImdyRF0lMTUUFUiSjJuL3yHWbmONiXse7J
         Ze0g==
X-Forwarded-Encrypted: i=1; AFNElJ/9Xh+tfYVIT1HJpQwa+E4cmgcWD/At29vft8a0Hv0tFJ5IrnX+sRZNFRNoV5fSZmE5OSsn0FKfwRXP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr41woYfA44bLIaT7XqIY9/ucqM/Ac60IX3udpzzap+kivoS7S
	PInqFH0l4Z0+TTuHh5kzkBSIfsZrM9XKxTxhiAkSGC4rCDbCEoojxXjc
X-Gm-Gg: AeBDievkqJjYNM6fstx4Q/G4HxCQcIrnk8tnKmBq1g0YsfbOndh2QOsvUWJV5QYXRiD
	jlrONA0GxlIf+lRpDseh/RnP3Nn6ObK8iV5VyVG0eoSEdTiFYjXrH7EKORdtjgjqeb1R5R+lmMJ
	MG+mSmJnsK89tLPewLIxUXjECmKeSEL8RwwXdhgy60LQ40mzleleUySjNTUxWxQX//jkanIDDew
	ah8nu6onJYS8MTfI6/zWAnKyxVAndsjo5WpKBwwomvDQGkCwEzAU2JWCee53zyiZpAV77bEnfeC
	IjRFfNAXs26DHXj1mtdZicIrBe+xMCmz+7SWuKTycBqUMWO+SFxMXBEIOdZF/9+HPZ4eYsFw+OI
	84FFEqTA/7FGBIf1N3/Fieenx7tkdpIgC1MZgS33moyxiZrs6rPKYyWfjpIEHRa7nkGKJQ+jwc0
	o3fvPsu8dSDMEPQTD3EBsZpyynCuNnT12N3aPxKuXhbtUUG/5RdyRlD8fVj1Mv77BvuO0iKOr5v
	sh1jShckuri3v9g6G/1hUFyGlYwa7WmNU2If+oI7A==
X-Received: by 2002:a05:6000:1889:b0:43e:a935:838 with SMTP id ffacd0b85a97d-43ea93508c3mr3084403f8f.50.1776214232391;
        Tue, 14 Apr 2026 17:50:32 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3566c4sm413130f8f.12.2026.04.14.17.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 17:50:30 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>
Cc: Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5: Fix HCA caps leak on notifier init failure
Date: Wed, 15 Apr 2026 01:49:37 +0100
Message-ID: <20260415005022.34764-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19362-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C190D3FF627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx5_mdev_init() allocates HCA caps via mlx5_hca_caps_alloc() before
calling mlx5_notifiers_init(). If notifier initialization fails, the
error path jumps to err_hca_caps and skips mlx5_hca_caps_free(), leaking
allocated caps.

Add a dedicated unwind label for notifier-init failure that frees HCA
caps before continuing the existing cleanup sequence.

Fixes: b6b03097f982 ("net/mlx5: Initialize events outside devlink lock")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 3f73d9b1115d..fab80c79ff07 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1907,7 +1907,7 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 
 	err = mlx5_notifiers_init(dev);
 	if (err)
-		goto err_hca_caps;
+		goto err_notifiers_init;
 
 	/* The conjunction of sw_vhca_id with sw_owner_id will be a global
 	 * unique id per function which uses mlx5_core.
@@ -1923,6 +1923,8 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 
 	return 0;
 
+err_notifiers_init:
+	mlx5_hca_caps_free(dev);
 err_hca_caps:
 	mlx5_adev_cleanup(dev);
 err_adev_init:
-- 
2.43.0


