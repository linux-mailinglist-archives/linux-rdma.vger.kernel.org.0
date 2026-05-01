Return-Path: <linux-rdma+bounces-19838-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFcwN0s19WnoJQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19838-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 01:20:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BE14B043D
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 01:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7A1B300C0DE
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 23:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A362237E30B;
	Fri,  1 May 2026 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ28x1fY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB5370D43
	for <linux-rdma@vger.kernel.org>; Fri,  1 May 2026 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677640; cv=none; b=WtmB3/UP1mnTUZN/4ws9Zrs2Am5vsz526OZjgu1kk6dYx5BVBA3a6PhTIWDyoBZ3wDIhV+lZc8Gncj9Bq4+6FQ47Prd82zNt3RLeKSPrTiefbfMAKi+dqSYFvUYLzdvcfCMJJGg9Z3XNewrk+N+wgSYEwo/3WqztfLRsd7njtjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677640; c=relaxed/simple;
	bh=sTKHrcsmYbMcWsLC1yGTiQpud1Y4vAojqIbF4kwh9cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7xAjkZCEO1RhyU7YzJQ/H/Zto5LA5o1eWdGTpxenwdDfIsqwzhOuyRXUrf7qQ1QJhreKvH1GSfS0nIvxxf2ZLT96xlPMusJHe6pTkt+rutjH+kfT7uCeyJbXozKOH9B1+3tb/dXp9Zpq3e3iumA+9+BOuqcHGwuJ9x2prAJ1Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ28x1fY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso17005135e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 01 May 2026 16:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777677637; x=1778282437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKEaF2iRw0R0guzHvQGGi1fNA7z9KrsHAT4UjhLPp+c=;
        b=mJ28x1fY3/1DwAJ3P1/6TAw2KcUtvAa2sYg1gBkjhFGKsK3sVJnkAhz8cN5VMYscDr
         Y2Dk5/YPRxyJ24MBZjmvPW7jvGNdfL//t/Gulaex2Swr58oJ64mxYe78AZtXPfOwba1E
         VKB0s6rIAr7HdoRbzrVNYAMV7c1A4PtQFpUPPUpAG+EBvT85hjtad75a+bZmQIJWiOrI
         16rOWroXFBSDivSy4L6Rxd3HRcgzp6lIKywY575slZOFa9RswXXiEXxouwLprCGkkqYg
         D3iUi1TgHMCsg4/hYFF/lpZMacdirI+ZObSvxOil10p3ZpMh14Z83vY8k8QdZ4bG77j0
         Xj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777677637; x=1778282437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKEaF2iRw0R0guzHvQGGi1fNA7z9KrsHAT4UjhLPp+c=;
        b=RYWScEeUkmcck83JA9alnk6wWtjagMTmxK+KJATDdwgc+tmGjLTViLPPb/BRtPtkuw
         hNVxWaH44W4hXN2m16rhWsbyN1iZJDPSRlG0SEZ4GB0qu2RZ6Vl2hcdBf5nGuXN1V9VE
         mq2Cg4vhn/+Tr1UoR60V8mI2HUNHEApml/sWKzeOUGU6rQHXFrkM8Y5/5rbXVXb+p7dk
         phxWq/DG4S/GnkKeK5x1epOGB3ZcLaVhDN/ISImyZyN03wOdliIPtJGzrGK6AJqhJqt+
         6LSNSiurdUqRs2dTIcu1THnnWarqVXE9/OZezOEIG+T60sq91YCrEzjbVobBymcFU1OU
         TMgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+L2VtY77ZAWmW5ar39ehcxcKLpvH1AKWmsVjhcBVxzr1RWigFEgVU4or0QxvAY/BhA6maT1/WoKXBL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw060D6LtEBS1O6ifMoTiaYtQ9xhCRpwc8122fA7n4HE8Y8nFZi
	qUpt+C9qeMdHD5k7ZSpd860zLh8jfeVJBg4rWpJTX5aL+0ED28xOAkLm
X-Gm-Gg: AeBDiesEEyWFt1uT7kdrrP6/SlHGiZHAE5E3xm6dByaeIQ3V7RW6chKbx2yDcbzuzu1
	0v98dI7l851dEWQK1RQR3TzKDSUspe2wBPeHNj24IfPfj7KKNCN+1MIImrgo7iirI+JRxUrP1eX
	Y1gacJW5iaNRl1WJRg3kdvh6zQTABcum2aT2l2Hf0B1e6E0NNqLbZT7zK4J1nuFepYQWvSXzEnA
	a7+4BqhfcQJE9cs6UJdmt0MpBDgpwyUvrGg71SW4X4iNnTi77PnLrCIFwcGfN9Lcl74dCYlnRDm
	ufRqydvppenDRJudEcwGry6S1Ep6uX6sabakvm1YiFZAaSu3erN99EAVSZcIg3kex/8553gjsRl
	EJqLb/5qPXpgujPfblvixJf074iIhecwTPokk3qUCXFSKavAzwsnAkMngaYJ2IVlqVD2OM4C68K
	g4/7atCf/v9orKHQnVEEBiiT3SVFArLPNGqUZsmt4PYPKq0eK1SWgdN8IxIvI6NWjco1n0VFKfX
	it9M18oLEsvDpT/iODlv2MhwxADIsHIwbBdYX6aRA==
X-Received: by 2002:a05:600c:5297:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48a988a78d3mr14510395e9.22.1777677637405;
        Fri, 01 May 2026 16:20:37 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb2fa5sm72414955e9.12.2026.05.01.16.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:20:35 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: mbloch@nvidia.com,
	shayd@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5: Fix flow steering alloc unwind
Date: Sat,  2 May 2026 00:20:29 +0100
Message-ID: <20260501232031.41688-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 84BE14B043D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-19838-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

mlx5_fs_core_alloc() uses mlx5_fs_core_free() for its common error path,
but mlx5_fs_core_free() dereferences dev->priv.steering.

If mlx5_ft_pool_init() fails, or if allocating the steering object fails,
dev->priv.steering has not been assigned yet. The error path can then
dereference NULL while unwinding the original failure.

Split the unwind paths so only resources that were successfully
initialized are released.

Fixes: b33886971dbc ("net/mlx5: Initialize flow steering during driver probe")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 61a6ba1e49dd..e1662dcedbf4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3984,12 +3984,12 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 
 	err = mlx5_ft_pool_init(dev);
 	if (err)
-		goto err;
+		goto err_fc_stats;
 
 	steering = kzalloc_obj(*steering);
 	if (!steering) {
 		err = -ENOMEM;
-		goto err;
+		goto err_ft_pool;
 	}
 
 	steering->dev = dev;
@@ -4011,13 +4011,19 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 						 0, NULL);
 	if (!steering->ftes_cache || !steering->fgs_cache) {
 		err = -ENOMEM;
-		goto err;
+		goto err_fs_core;
 	}
 
 	return 0;
 
-err:
-	mlx5_fs_core_free(dev);
+err_fs_core:
+	kmem_cache_destroy(steering->ftes_cache);
+	kmem_cache_destroy(steering->fgs_cache);
+	kfree(steering);
+err_ft_pool:
+	mlx5_ft_pool_destroy(dev);
+err_fc_stats:
+	mlx5_cleanup_fc_stats(dev);
 	return err;
 }
 
-- 
2.43.0


