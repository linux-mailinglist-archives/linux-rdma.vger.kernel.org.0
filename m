Return-Path: <linux-rdma+bounces-5972-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B6F9C806E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 03:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5DE2834EE
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 02:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098E31E3DF2;
	Thu, 14 Nov 2024 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7TMa84R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB445336E;
	Thu, 14 Nov 2024 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731550640; cv=none; b=HiyweRJZYqfGndPnq6Rn4P+h5tC6WkGR6db2kotAYn9FJZcnDTXrsVvmx7wWAhgxXriOYMYyN12pBEyKL4A2qDxXyTWzeV9+nLtRzmVzGIkdtmiwzkVPZ0Uub9hLcz7hsIkIShhRWxvuinPiIxCfqgfbtWlexQnlZ7yOvugM9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731550640; c=relaxed/simple;
	bh=geXDVwvP6PifpMMlmvMYZhWRV/cXyCbKVcgzFYEDDiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E9XRLPFaYnKB/7Ivtxs826o6nUrg/7gGqPebZsCq6ePaSOqljpy4aiSjefO7eKXSpWOVV1HOrDP6nSxGHlSvFmn/bA9dcDB7ppgz6EN/zr9grJZ5MNXCIg3Bsli+LBbjTnMNLEdsLQpEr7ilcTUMngWv8hiSCR6CWbo+zNIKehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7TMa84R; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso114800a91.3;
        Wed, 13 Nov 2024 18:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731550639; x=1732155439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALAAMnArjkDTftOcRgX16COJaTSYEmB9pWHkY1iFjc8=;
        b=A7TMa84R7HVYLYi94uM5mf9NpNveyrQdXTROrOvFkfj/BqY5nyeoCXcOzAR+uz/rHw
         FSp1z9nV9n+bbpEAnnRn0CoG5apwvD3mWH6fZAhQmMvlhG9GlCFMtBC+rVb47PByGH0M
         mF4p4VH60bkpEz0xcAiY3V8VsmLRmzDaQLAr3A0DIZ4dLskNBGxE5FG6SPEnO/MBpWgb
         y7nTLGN+ebLRIHx+/9Go85yn0EeKZ0DsChMEaqSgxCsGFMw9KIB6JeQbvXEv+RP9+8NJ
         8J7kq3P+3aAUPFQO2TXVu56wYX0LW6TyGANrGOJHLgSCgST60UXYGDRqwfvTMo2GSCTJ
         eq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731550639; x=1732155439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALAAMnArjkDTftOcRgX16COJaTSYEmB9pWHkY1iFjc8=;
        b=PsoUXuGcRUCyOXEdd5nqPwwpEWNCFiHACnkjP38GL30k4lIRehEQfSIqOagpgluXiU
         1R0GrLytsvzfKy+Bf4I2+CrxeGiP6aFc2aRwAcUhiLQCZ6/G44ZwCy1XUdcUfWGdfQAL
         XR+rndiuTI0MWKa3V0LmF/e6pDJ0oJ5LCnyIxnCE6BzSNMAGG8FVDeNdRl5W4mP6jN5v
         K/0bWzsJP+pdTTgJ+oV4A/DSC0uDM6xeW5vW9K3MwNTtLBS1HH8Xb/FJ4NgIVKPxpvbx
         j73h1eHtV4lHReS3dbKKn4zSWxql8g4y4ZquZ41cxl2nb/mmRco+OHratt59Wmh65cvU
         mczA==
X-Forwarded-Encrypted: i=1; AJvYcCXglmRe4SdbH3NjYDsh/LJstHXGVVipZGbktB+BJv10yUHjXrc8BCXIT7bYLSiDoRk8Wp8/Rfmk7Rz+@vger.kernel.org
X-Gm-Message-State: AOJu0YzUZczy2beTG7rCBRV3K41TxGUiVg1emUAliJVDREbp+nPA7S8u
	zCUe28w5sn0fOfH+u0lb2xyHi+jf2ZjxBO/P2oTbuhssEo5KHSRe
X-Google-Smtp-Source: AGHT+IEdt8WIZ3GWRaR8gjG7qiiijfcVcFZOeFwbBzZhcB7zrZNzXV5/yh7Kdf/XrvTV8JGMjvPaQQ==
X-Received: by 2002:a17:90b:1d8b:b0:2e2:e159:8f7b with SMTP id 98e67ed59e1d1-2ea062e1db6mr569939a91.3.1731550638400;
        Wed, 13 Nov 2024 18:17:18 -0800 (PST)
Received: from localhost.localdomain ([180.158.221.75])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea02481b30sm224074a91.7.2024.11.13.18.17.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Nov 2024 18:17:17 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ttoukan.linux@gmail.com,
	gal@nvidia.com,
	kuba@kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via rx_fifo_errors
Date: Thu, 14 Nov 2024 10:17:11 +0800
Message-Id: <20241114021711.5691-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We observed a high number of rx_discards_phy events on some servers when
running `ethtool -S`. However, this important counter is not currently
reflected in the /proc/net/dev statistics file, making it challenging to
monitor effectively.

Since rx_fifo_errors represents receive FIFO errors on this network
deivice, it makes sense to include rx_discards_phy in this counter to
enhance monitoring visibility. This change will help administrators track
these events more effectively through standard interfaces.

I’ve also reviewed the manual for ethtool counters on mlx5 [0], and it
appears that rx_discards_phy and rx_fifo_errors have the same meaning.

  rx_discards_phy: The number of received packets dropped due to lack of
                   buffers on a physical port. If this counter is
                   increasing, it implies that the adapter is congested and
                   cannot absorb the traffic coming from the network.

                   ConnectX-3 naming : rx_fifo_errors

The documentation in if_link.h has been updated accordingly.

Link: https://enterprise-support.nvidia.com/s/article/understanding-mlx5-ethtool-counters [0]
Suggested-by: Tariq Toukan <ttoukan.linux@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 include/uapi/linux/if_link.h                      | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

Changes:
v1->v2:
- Use rx_fifo_errors instead (Tariq)
- Update the if_link.h accordingly

v1: https://lore.kernel.org/netdev/20241106064015.4118-1-laoar.shao@gmail.com/

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e601324a690a..15b1a3e6e641 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3916,6 +3916,7 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	}
 
 	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_fifo_errors = PPORT_2863_GET(pstats, if_in_discards);
 
 	stats->rx_length_errors =
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 6dc258993b17..16dfaf5f47ca 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -144,10 +144,6 @@ struct rtnl_link_stats {
  *   not correspond one-to-one with dropped packets.
  *
  *   This statistics was used interchangeably with @rx_over_errors.
- *   Not recommended for use in drivers for high speed interfaces.
- *
- *   This statistic is used on software devices, e.g. to count software
- *   packet queue overflow (can) or sequencing errors (GRE).
  *
  * @rx_missed_errors: Count of packets missed by the host.
  *   Folded into the "drop" counter in `/proc/net/dev`.
-- 
2.43.5


