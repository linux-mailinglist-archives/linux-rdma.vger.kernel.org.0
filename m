Return-Path: <linux-rdma+bounces-5322-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D72F995C92
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 02:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC061C20C6B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 00:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F552AF16;
	Wed,  9 Oct 2024 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fGhCcnku"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4828399
	for <linux-rdma@vger.kernel.org>; Wed,  9 Oct 2024 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435376; cv=none; b=teHOcy33JPA4Yb8iXPlxg1Vqsho+mtP+JA13lYfhY4UOLaDdxJPMFfoBn6r3R4UQcapnLnwvoWPHAMH5JeabDni5q+fMh+7rtoizma93hFjlXjABDUctm915EVlukPRE/mufXBzCZu8WuzybuYTNTDMOMd1cW4BAd6AEvUOvKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435376; c=relaxed/simple;
	bh=9AG0+lo9vEUg3YGDMTJw7BHymobbZ1x4BvfJUKFyf90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MuRIBbSu0Pvy054PFJaXDpQCHTX3vFOd07Ye+Yt0yfPOUd2eWMMyXPhBoi3+V5HJtC5ziN1XUOC7SI4jHwtVN4wV6P5mniiWz5YhwQfDsDtjBau8+1UDn1gu5Pf6hoonFCwkwOUoHOyjj/06+yJauAP27Z65UnwmK61bEhKy3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fGhCcnku; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ba9f3824fso48117625ad.0
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2024 17:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728435374; x=1729040174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiZhR6ZDOV6PKrXmW0MGtxp50pihY0OuQCjK7Nfyoqk=;
        b=fGhCcnkuPEPfs4pGreJdyccOUxG+03xH2cz27ZfxnbQmgfVT1sDCJArhle71D6nYZ8
         paqmvzO+2aTk5URAhqT2nd2QpcDFZvouljRGQxv82qBEOcAFpD/SDmtE9mPJ3+Y+1BGS
         WbeKbNkzGVcIryWTdOaJStX0e1vZNRzmyomOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435374; x=1729040174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiZhR6ZDOV6PKrXmW0MGtxp50pihY0OuQCjK7Nfyoqk=;
        b=fhS+5lFlDaGCQPT7oigNTuPjZVjB5jNDJfXswsfA4kZsrxeeC3FYYt2L0fNgB3eGty
         YSeKGf0iihJqVcrW3V5HuhkXfy8N1onTSRKaHYLHpPimk8+xcZzDbqlSt7H8ttTGRv0/
         BWCO7e6T9tBvrjF9pdLZv4+3mzTgFqv6/cHwIzVsayXkY2IiS+T2TlDF5KzYTw+O59dn
         1dRJL17c4xGapmm2+teUb4nHk0V+FO3i/YvTu8pT3APRMoB/9URHBgLKQKoL4kl46Bup
         H70GGkRd5K66xwLdIVEbr8Dnfz6FBjG0uTIz4gMH8PnWngLavMrfOI7kfn5VnWE5btQT
         Q5iA==
X-Forwarded-Encrypted: i=1; AJvYcCUQTIqXDd295li6JA0Ir6GCEXhdd6c04SAoNluMUgLL2dfV8flWMTitR5FP2sv1Xcb6uhs3+3FosDql@vger.kernel.org
X-Gm-Message-State: AOJu0YwMchzOC84kL0nfR8RPTdtPlhngz6wqMWc4zhP2CaVsyVswjF04
	sxmND1FYwKqhA7vZlRTSyk11Ia9j9OE47ZFZbOEueHTo3jizB9bHpF50otgmpp4=
X-Google-Smtp-Source: AGHT+IH6h1S0EIM9d4SunI15VDvdI8I+pNVG0304L1KJl7mZQ1dQzI5hTEQrUahwl6H9gOdnwxmgrA==
X-Received: by 2002:a17:903:228f:b0:20b:9088:6545 with SMTP id d9443c01a7336-20c6380574dmr12981235ad.46.1728435374645;
        Tue, 08 Oct 2024 17:56:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm60996045ad.101.2024.10.08.17.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:56:14 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v5 8/9] mlx5: Add support for persistent NAPI config
Date: Wed,  9 Oct 2024 00:55:02 +0000
Message-Id: <20241009005525.13651-9-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009005525.13651-1-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a5659c0c4236..09ab7ac07c29 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2697,7 +2697,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
-	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
+	netif_napi_add_config(netdev, &c->napi, mlx5e_napi_poll, ix);
 	netif_napi_set_irq(&c->napi, irq);
 
 	err = mlx5e_open_queues(c, params, cparam);
-- 
2.34.1


