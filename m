Return-Path: <linux-rdma+bounces-18556-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEyyKt0hwmnHZgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18556-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 06:32:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD041302454
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 06:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61A7C301AA8F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 05:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85729313527;
	Tue, 24 Mar 2026 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCSJx2U4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654E274B5F
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 05:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774330203; cv=none; b=izPM2ytsuJwgoWFQB00t1DOvjQn7WUULHoLgSyWp6rRyMpE4KdeDEO0uIaGhazAaGTvEXmrhBFvH6T4Ei+aVQI2b/JuYhYbphrssZoEOwUzDdp/8C94hQkATztc8EAG+7G1+POanAt3qgOfTONE6xf0uk/+CfW+G4UeJCIcgb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774330203; c=relaxed/simple;
	bh=xNJI8BrDJcjv7B3CyIr/xSgaScE/My8YWxbTHX0hgl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hj2o7hDS/Oa72YqT2exBurgtA5T/puqrvBA4dASjUd+vHf1tUFoAwTWqTdhuXCYac5v1+pZyu0uSb6mic9+9OfR17Az29TN4q+zq5CtvUlgIPg8MIBPCNddJ+LfpSG2mqvKnTXxMmF/BypR7wHoslztFMx/fptrnYZASxk7bgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCSJx2U4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ab077e3f32so16148905ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Mar 2026 22:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774330200; x=1774935000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWQPpxJJ5vqy5RevxN77SFSwx0z5emoC9WwG+dKY3L0=;
        b=iCSJx2U4HZsQdper25KI4WHkLKDbAz3U7F5tWdjc1f9xb56yVGsd4FYIuuGAyIr/mv
         pHz/P5TNk0ZbJZFhZuS/YJWgF2laHydyyW1pJzWnMQ4kwBMwjOdVWk5A03JUWBo7Muys
         nYaNgBJbAXCxthq+hHjn+dtuvY6Ojb8NjRIetdsthC1y8HfZAEUEu5zp34EryzXRcSVg
         fsQi5tZs1ZE7Wifrhem6z+Sxt0JQR4E+67QrodjkQIhHd+AMT3bqRfN11XgWDCgoX0L8
         ayqPjBKP8VLqb8fbZ/9X7R03bMT2iBlHKkp5xcDvfrgZ6cILbG3BxQYVHMy6PLjswzDc
         8Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774330200; x=1774935000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWQPpxJJ5vqy5RevxN77SFSwx0z5emoC9WwG+dKY3L0=;
        b=ly7M8fVwal14FiaIb00S0xQLQT26H3PurnlJYeAmf1J+jdwF7Se0Ph7aRjXAOJoV+H
         kv8w8NJJkKAQANpNWyFxSc6Wg49ECo5rAXdA4ARigKkqRKPtWw5i7Oyh8Bbo8fMowjRP
         1kGBpNhqnkg8bmiA4m0xDSk5BdbpiVxHcmBiYx2eT7emvs8xXOMV/CEIaXPmjSdmFYsA
         xd8Q1OMpNwD85ldBiOPn9MI7Fig0zb1+NJ04EjbXDHtn0aLSIaOdM9dJlcjUW4+1GicW
         DYbj72HLYywzTbQedwyVXJAETjY75B42XcGK70lzhHxJmT8QCvTOtk7EniT88ZiA3uY7
         8W2g==
X-Forwarded-Encrypted: i=1; AJvYcCVB5Fu3UhLJTIqmOR2PDRjxftcrTIMmvElJEmtcSrfnCZx7mT6OaSsUFF7XsJRb1TVuDqy3RkQxhFUy@vger.kernel.org
X-Gm-Message-State: AOJu0YzAEnNA4YDQix9h+JhRm2PJA4Fxcq6kOXRve8jg4Zfn/CEUuXMg
	tIw4LczHrN1aNYZ+FSmoOrsIkN7bdhVop/UbWFuOIxEkAWOVtbSQYddg
X-Gm-Gg: ATEYQzwQVsg6c291V7hc/o2Ezo7q1layMq6Y3PkvrvAIQYoFHmcH3rBdAhtMwW4NYeU
	j56Djq+Xy2WgF73IUIJt15uqadAfQef//HhgDHCMs3f0GiWglj2DpWxIvzgGdFVqfYHMQblm3WI
	+lvjRSk8iQ+oEt4mEU1U56aD8x5WgHPkGAr8sVkrdhMj4sHCOiTKNdd4j7ZZfNo+eEIbFhYrljJ
	VzCgm3YeryZJA57GfE3zL8F7+3sH9bu4Mu7R7bq2+CtHMginQnQ4iYzwhniQuA18TNsJ1xrqitD
	i3RJuguDtuhdMOz8o6Q2YA2TjAXJfvk4hZYtISh0TZJYu5qWZGzzwN57lf02tKqButFNt+Ti7D8
	HqIKrEbfvhoqcP8tADQdA0Cq4t53zHq/GsDNeWEXP4EELqt4rLVM/CpSRI8Qtgg5SLgAFrzpWQ/
	RGT1KlvQYAl//amm/1IspTAcq2KdTD73xz3vn1M4x7
X-Received: by 2002:a17:903:94f:b0:2b0:76b1:93f with SMTP id d9443c01a7336-2b082734032mr121627425ad.18.1774330200449;
        Mon, 23 Mar 2026 22:30:00 -0700 (PDT)
Received: from localhost.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516b96sm165458525ad.7.2026.03.23.22.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:30:00 -0700 (PDT)
From: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
To: rrameshbabu@nvidia.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org,
	joe@dama.to
Subject: [PATCH net-next v2] docs/mlx5: Fix typo subfuction
Date: Tue, 24 Mar 2026 14:34:10 +0900
Message-ID: <20260324053416.70166-1-ryohei.kinugawa@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,dama.to];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18556-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryoheikinugawa@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dama.to:email]
X-Rspamd-Queue-Id: AD041302454
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix two typos:
 - 'Subfunctons' -> 'Subfunctions'
 - 'subfuction' -> 'subfunction'

Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/kconfig.rst         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
index 34e911480108..b45d6871492c 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
@@ -114,13 +114,13 @@ Enabling the driver and kconfig options
 **CONFIG_MLX5_SF=(y/n)**
 
 |    Build support for subfunction.
-|    Subfunctons are more light weight than PCI SRIOV VFs. Choosing this option
+|    Subfunctions are more light weight than PCI SRIOV VFs. Choosing this option
 |    will enable support for creating subfunction devices.
 
 
 **CONFIG_MLX5_SF_MANAGER=(y/n)**
 
-|    Build support for subfuction port in the NIC. A Mellanox subfunction
+|    Build support for subfunction port in the NIC. A Mellanox subfunction
 |    port is managed through devlink.  A subfunction supports RDMA, netdevice
 |    and vdpa device. It is similar to a SRIOV VF but it doesn't require
 |    SRIOV support.
-- 
2.47.3


