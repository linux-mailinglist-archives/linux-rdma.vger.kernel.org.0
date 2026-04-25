Return-Path: <linux-rdma+bounces-19536-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD5AO3AL7GnbTwAAu9opvQ
	(envelope-from <linux-rdma+bounces-19536-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 02:31:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9094146442B
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 02:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24A87301B92D
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Apr 2026 00:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F911A9FAA;
	Sat, 25 Apr 2026 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KevyhgEd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C215B998
	for <linux-rdma@vger.kernel.org>; Sat, 25 Apr 2026 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777077068; cv=none; b=D94G/Q6x6B28zLzyV5g6E1PRCuJ/2Kce5gNDWHLsTqt4mx7MM4UIQYz1hGOxO2j7FGiihXGJiVsBojqVyKPLisUirUWnlaKrUbaofkxa8yP6kdxEgib/SF6LRzZNZ+ECN15iQ7irx+eLvtVUzWDWkepXLxY2u2KuLhtdin5fa7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777077068; c=relaxed/simple;
	bh=9L62xwjArBntNKO9ecICnkDj175ZgUCNs8W1CCZhLSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgsosJ4zsOpvP7J02tLq2QqxWz+7G24bqH0X28F99dHSLGhnoPIXHOeOak1HK3qrPf64GC4P12OnV3D9o4NKNhBN5JZgfoRI+gRBF+2owpoeOPvSTJul4nVaxDIhVNGw5pEgi0smwm93lgdnirdVZlE0tKjT5mACBAAiyfNH6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KevyhgEd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso54418245e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 17:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777077065; x=1777681865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0srnFrmgBaoPXdArgJP1j4sQT6zcktR4MHuImOUO7nA=;
        b=KevyhgEd7LgaGnJyhApXR+Uc1iQRVFnNXSNLueH1pXJXAgoF4ZTkgBtnyoDEVnCsfW
         EHQqNN2kRXWoeDCqKMhkrAlh8eLPp3F4uzt8Tn6+u2ZF5oiZ5dw5RWkMssnKghyVXKZn
         2uqa5tYzJCHHSedzVWyBI70HtlWgtITxBm/zZsp9umkBHHRk7QbvVliO7X25OSJDgJuQ
         0hdNhC9cDkdqNQAJRVu99kYLg6p9VIe5+sHQANn0WsN+xIMf5cwsU7CIdMqUx/muOKIq
         Xd0VJydnn2BSeJX4bsHc2SHqZ+Pt8VZfIAH/vI4E076aAPFhD9cIiK3Ta0zocS4Yzw77
         rWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777077065; x=1777681865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0srnFrmgBaoPXdArgJP1j4sQT6zcktR4MHuImOUO7nA=;
        b=VLlJJgCbC6WQnoTnxgB5ZOPoh5UsWRqYk/en0IBrIx+e5CYZgcqINzSKPo9WMBbpob
         BgrljCMuCtOi0WWt4iW+oqQzDSJYV0PtgDNeRZv5PoXApTr936aFDN3Nyq7NrliS6Db7
         5EWeA2fMb2DJJAqhKkXZDjQjRUc38RwohTWAMeYSsK4/9nIQX8N72V+7GOs2dl7sG/+e
         FlHvMs9hAyj1uomNVKTPffBSXq04evSPPuhhdBrVX8GHCzb2ly+l20QNr4Qucr/xiVpD
         x4h0cwg75pAy/wn3aEGG6eOR6sFSyL2nYypUga+A3joR21PZHWd5sPyaL+BtQUAcxWy+
         PG9g==
X-Forwarded-Encrypted: i=1; AFNElJ+H61hZeSL/KmWxKEremgJT4hDcmCvTWtuaF1rRZwHI2+otnsZYgBieypwoHPo2kC/lWjNpUMl8YwqG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm4AKFNIPinrWFF+wTClCjGQufsmFTc9Ne7+iDV0TH8IgKiRq+
	IUsMvDW12he0cxQTrpWQXF3GBG0JRzPv58hBpo0jhgzoV1jVjGklp9rzrTKXOl4C
X-Gm-Gg: AeBDievGCvTRgcQOXXa+Lg2T4Fxw/YLSk+i8XBuELgf9t3LaySgYq9Qr+6R+PuJP3cj
	/YSkHhdP3IANg7kTB0xiPbA3WOFFp38Ecgoovqw4BqHft2jRnP9CzUNCDuwNgaAjhtDrn5XG528
	w8J/FPwCUVYA+lUuElm35PDZHLheAyrTXrH/kJJCx197CqC+bphMs5Dp1Xzpgeql68fVascPBPX
	6xS0ovkRdywt9o7wd/0X6Nvpqiu988jcrC8q5uwcmmsnowcztUl2IbJ7PwEwkJlhVpcOlgVtO11
	v+ZXxhbTn7R4Z1eFkHnqOaWpSWFqJH5BP/yuSo4aijN0lPiIVrVWVN2rSxlZvFGYWN6wvMKinm8
	Hzu/NEZB4gDGmQW1pVRu8u5Y6t42EPbyHkdoB3Pss0q/63EdjkjqlEbIG8ejTuwuzlm8NzNbgqV
	Zpd/0Ca7wzJ0ZjOIsQ3gownOLxThHuBiQ6gG6wSpWGrFHzGEJsvlG6s5CsiWEn+p9FZKfc2nmkM
	tLfDXizA9AfyxRwdP9tBQqb9Bqulw6UBflVsrfG6w==
X-Received: by 2002:a05:600c:3150:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-488fb7930famr489626335e9.24.1777077064912;
        Fri, 24 Apr 2026 17:31:04 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489201cde98sm378059485e9.7.2026.04.24.17.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 17:31:03 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: saeedm@nvidia.com,
	leon@kernel.org
Cc: kuba@kernel.org,
	tariqt@nvidia.com,
	cratiu@nvidia.com,
	cjubran@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5: Fix eswitch offloads cleanup on QoS init failure
Date: Sat, 25 Apr 2026 01:29:59 +0100
Message-ID: <20260425003046.6889-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9094146442B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19536-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

If mlx5_esw_qos_init() fails after esw_offloads_init() succeeds,
mlx5_eswitch_init() jumps to reps_err and skips esw_offloads_cleanup(),
leaking the offloads initialization state.

Add a dedicated unwind label for QoS init failure that cleans up
offloads before continuing the existing vport and outer eswitch cleanup.

Fixes: cac7356c653d ("net/mlx5: Rework esw qos domain init and cleanup")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 123c96716a54..db4bf17d2640 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2059,7 +2059,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	esw->mode = MLX5_ESWITCH_LEGACY;
 	err = mlx5_esw_qos_init(esw);
 	if (err)
-		goto reps_err;
+		goto qos_err;
 
 	mutex_init(&esw->offloads.encap_tbl_lock);
 	hash_init(esw->offloads.encap_tbl);
@@ -2088,6 +2088,8 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		 MLX5_MAX_MC_PER_VPORT(dev));
 	return 0;
 
+qos_err:
+	esw_offloads_cleanup(esw);
 reps_err:
 	mlx5_esw_vports_cleanup(esw);
 	dev->priv.eswitch = NULL;
-- 
2.43.0


