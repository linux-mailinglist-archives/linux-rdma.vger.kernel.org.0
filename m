Return-Path: <linux-rdma+bounces-2220-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515728BA23B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 23:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075A6284B00
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 21:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A1A18411E;
	Thu,  2 May 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DAANplb8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C9181BB2
	for <linux-rdma@vger.kernel.org>; Thu,  2 May 2024 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685197; cv=none; b=VL2t7E6u9PeFEuhSFhWKO6xSW91icJQ3r8mKRt9xdxio1iFYb4r7P2Im1j9aTa2uEwernvqTX2A2bWjHA2X/tkMP6OLVqPt5nHsGyWU7E02rLzDbUuXRJRSKkr5+Rzd5hlk7EGAo1/zRsrnXGVeRZuNA/VfK4Lwklal7raUzFxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685197; c=relaxed/simple;
	bh=FXv+vJcBCmEgOu5jScWUmm7QGv45QW6i+T+dLFjv6OY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MCbExRZbZWZPR5KWq4NFE4Opud2CJ5I+dwEVZaOqw4NDkvfS34SOBx+SQr8vWUN3EodORyMwaC1U7XN5k7JXn7JZcaOXlmwdyWKNKMt0+C3S+q8g15Hy1TzRJTH+1ZUKP5Vm7Td7n0yItRmaBfBtKQIECvvhzER4zSLMRMUqY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DAANplb8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f4178aec15so2675401b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 May 2024 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714685196; x=1715289996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jgR8JD3oQd88EH8HKGjA3Az+hSDzBJU5y5/SDxJYdM=;
        b=DAANplb8T8epsb7QiagB9494a98DfQ2G1zai+CmFE/BJ8x/eMqVrLKjRHIqjQX2O+v
         NrUQk4UPZkwKJUDoSfhOZx4KzHdh8Vt0kePRQiBoISWV7SmCvfHdL2WfuAzB68TCWciq
         xKDILOO6d1/zqZQ0fBpHQ9AXWw3e/xew+qfMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685196; x=1715289996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jgR8JD3oQd88EH8HKGjA3Az+hSDzBJU5y5/SDxJYdM=;
        b=AYNlIXuPLzXcJ6gy2W0C3elDHI1ivp8bJMIVBdVCtA2Au9GvbvhdLa2Zzq16q/YZZR
         1g/j7LAhVW0AEc03RLoAQpdygHFrUyz6z2UMApewjZcGqPXSDQ/mmv3MLjn8/YqBMKrc
         DxM9xiyIb0Au1Tl7YRl2mocNBfTsR1MLP4FSmLSv1msI2mdMRmgWmhO1grh3Tzd5THFB
         1NGJqDvzvByK1nG0cLV2eFZrmiATfPyeTBFXEj74slWeaKEuy0WuyCavRh/NTuwlj6Cd
         Fgw1X60qOutzWcz92w3LI8UuQI3ee5KTF2WmzAizS4C+d0/CFqHPedm0swjQzy0PEtfn
         wi0A==
X-Forwarded-Encrypted: i=1; AJvYcCVXbVPC7GT8zSKKsXdhp+JWZyeQxWwSkIxmIxrJAcpeDuxqRdLcMxWzQxTQZE4Lg45xswSnna4jkMr3LVe3QJ2nuHgqpfSxhGhWtA==
X-Gm-Message-State: AOJu0YxCWMq2RRTQqzZOLOkBvgb+wwPSjM+01vpeySxmMFhyVj4WySdU
	yDdg95H5za9z90c4DS3ZEI/MOZS0qE5BP0whNkBiaonHeIania7G0tQGCfI5ud8=
X-Google-Smtp-Source: AGHT+IHJviS1wozqDADgp5NssiZSlqz3RTUpOU3MNs7wdW2gVo+a7TIkffxM2G6uXIzsaRMwMWuSKg==
X-Received: by 2002:a05:6a00:1305:b0:6ed:416d:e9a with SMTP id j5-20020a056a00130500b006ed416d0e9amr1014030pfu.7.1714685195864;
        Thu, 02 May 2024 14:26:35 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id it21-20020a056a00459500b006f4401df6c9sm1371345pfb.113.2024.05.02.14.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:35 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: mkarsten@uwaterloo.ca,
	gal@nvidia.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v3 1/3] net/mlx4: Track RX allocation failures in a stat
Date: Thu,  2 May 2024 21:26:25 +0000
Message-Id: <20240502212628.381069-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502212628.381069-1-jdamato@fastly.com>
References: <20240502212628.381069-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
fails but does not increment a stat field when this occurs.

struct mlx4_en_rx_ring has a dropped field which is tabulated in
mlx4_en_DUMP_ETH_STATS, but never incremented by the driver.

This change modifies mlx4_en_alloc_frags to increment mlx4_en_rx_ring's
dropped field for the -ENOMEM case.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 8328df8645d5..573ae10300c7 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
 
 	for (i = 0; i < priv->num_frags; i++, frags++) {
 		if (!frags->page) {
-			if (mlx4_alloc_page(priv, frags, gfp))
+			if (mlx4_alloc_page(priv, frags, gfp)) {
+				ring->dropped++;
 				return -ENOMEM;
+			}
 			ring->rx_alloc_pages++;
 		}
 		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
-- 
2.25.1


