Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA22E2108
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Dec 2020 20:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgLWTqv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Dec 2020 14:46:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728791AbgLWTqt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Dec 2020 14:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608752722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hz7m6V9y9LKYDbuYf1YRMJjX+MWq8iR3kXuzC0duUxI=;
        b=C1pVFr6r6Go8r0hwKDeVwkA03oNzmYNRRWsjbypbXPXBF3x7dBYpHGGlT2/CYKFNrd9Qez
        wlqx9bn8//To3QsKTCM+/n9gksxBPRQ/nw29E7kxznfS03YTCJJ53Zarsz3a3RgLk0TMqX
        FViLTdLJEI7R2FVp82t5O12kW2BjSNQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-E717lhrsMse1UT8DQ7yivQ-1; Wed, 23 Dec 2020 14:45:19 -0500
X-MC-Unique: E717lhrsMse1UT8DQ7yivQ-1
Received: by mail-qv1-f71.google.com with SMTP id t17so184819qvv.17
        for <linux-rdma@vger.kernel.org>; Wed, 23 Dec 2020 11:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hz7m6V9y9LKYDbuYf1YRMJjX+MWq8iR3kXuzC0duUxI=;
        b=Lwwxl0npVTWEBhB6FK2Hr+RHmUGp1vJpM6SZg1m1ZmuMtRNRGnNewPgyxCgrHiJKhO
         LfOdWViWofENTrY+3AKszV/Swm5pM3WoKmdzdBv+ju9LIheqKzmBNs+7zVkpXFIVtcm7
         HlnoOUDmPk5NYIwDGJh0LpNB9XseTcWRlhJ03wkcRFJqF9jk3SaC7sXUATSsLklS3mH+
         F6/KuOCDPHzMD73DE+XMWlhEywQvvJkthwlTNR914IxeH+FEOIKuSEV9ygN9Y+wZilzw
         t8cafSfM17mJIMxcU4LR3hBpxJ47Wls/yz4vyq7u9u7gSgWewZx5sqpRTBNu5MTFbc0f
         w36g==
X-Gm-Message-State: AOAM530l1lyU47J/RMPUBpJV6rxHd9qlZYNfQIydaqEnu0MSD7nlN+Gl
        QJ1MpAdm4e0/48Z8le3q7KD63ilUZ4cIzZWcugmtyfUXzP8+fFWP1Lr3QsV44GlYcFgY8Hyb7NY
        xMSQ0p9ZBxBprgSht+K+agA==
X-Received: by 2002:ac8:5286:: with SMTP id s6mr27092698qtn.22.1608752719379;
        Wed, 23 Dec 2020 11:45:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvaGHXwGzRvaSpvVyxfxvDK522ewEsI68QgpytD4dBD53dYAsdhkiyCvoclzmTjNngfpObRQ==
X-Received: by 2002:ac8:5286:: with SMTP id s6mr27092678qtn.22.1608752719201;
        Wed, 23 Dec 2020 11:45:19 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u4sm14517904qtv.49.2020.12.23.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 11:45:18 -0800 (PST)
From:   trix@redhat.com
To:     saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
        kuba@kernel.org, vladyslavt@nvidia.com, maximmi@mellanox.com,
        tariqt@nvidia.com, bjorn.topel@intel.com
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net/mlx5e: remove h from printk format specifier
Date:   Wed, 23 Dec 2020 11:45:12 -0800
Message-Id: <20201223194512.126231-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 43271a3856ca..36381a2ed5a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -179,7 +179,7 @@ int mlx5e_validate_params(struct mlx5e_priv *priv, struct mlx5e_params *params)
 
 	stop_room = mlx5e_calc_sq_stop_room(priv->mdev, params);
 	if (stop_room >= sq_size) {
-		netdev_err(priv->netdev, "Stop room %hu is bigger than the SQ size %zu\n",
+		netdev_err(priv->netdev, "Stop room %u is bigger than the SQ size %zu\n",
 			   stop_room, sq_size);
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 03831650f655..d41bfea85aa2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3763,7 +3763,7 @@ static int set_feature_lro(struct net_device *netdev, bool enable)
 	mutex_lock(&priv->state_lock);
 
 	if (enable && priv->xsk.refcnt) {
-		netdev_warn(netdev, "LRO is incompatible with AF_XDP (%hu XSKs are active)\n",
+		netdev_warn(netdev, "LRO is incompatible with AF_XDP (%u XSKs are active)\n",
 			    priv->xsk.refcnt);
 		err = -EINVAL;
 		goto out;
@@ -4005,7 +4005,7 @@ static bool mlx5e_xsk_validate_mtu(struct net_device *netdev,
 			max_mtu_page = mlx5e_xdp_max_mtu(new_params, &xsk);
 			max_mtu = min(max_mtu_frame, max_mtu_page);
 
-			netdev_err(netdev, "MTU %d is too big for an XSK running on channel %hu. Try MTU <= %d\n",
+			netdev_err(netdev, "MTU %d is too big for an XSK running on channel %u. Try MTU <= %d\n",
 				   new_params->sw_mtu, ix, max_mtu);
 			return false;
 		}
-- 
2.27.0

