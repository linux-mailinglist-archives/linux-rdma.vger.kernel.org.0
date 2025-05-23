Return-Path: <linux-rdma+bounces-10628-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0359AAC2704
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F967B418D
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA13211C;
	Fri, 23 May 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7q6CYtP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE415A85A
	for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016020; cv=none; b=Fe5Tk5JYURozaiRTaJMPeE8FgSHZoMgOyST+FwPOCYOo8MzbsshQS6pzAeZA7uxA0HORNEYdCseq//MeeNFGpfF5gLfbZRY0KNGHKbYHQzvUarPkIhNL5nxYGEkumSL0bWXxd6Dw9iNvoeC5nejuAkeYlxoIVLhrIeSaN3FNalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016020; c=relaxed/simple;
	bh=LvObJJaq5KUcG5iCKLaQBZwG/bqZeEkJJz5XwOHjrLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QaHJBZWoE48MXjoQqX4AKDK5IxdnYjw6Waj1Vz8klydJt1R29f3cxFZe1CSRu5td1usXZ9mRhwLRpoCSUGGpt24BO1jgVrzTvyh34b1gkJF9B+bI5lYUHn4t96xNRdiGdAvEp3gbcrdBxQdeVa7HavzjIW4P4/iTmJCTUzuBYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7q6CYtP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-44a57d08bbfso16356415e9.2
        for <linux-rdma@vger.kernel.org>; Fri, 23 May 2025 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748016016; x=1748620816; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WE/1otE+Iljvc13TDUh3vMrtfx4k08FjErn+ne3CuXQ=;
        b=X7q6CYtPqI8OvF+J51c5K9/EOGBOmCyl4XbBeIPf8suEdoZybYnQq88rcaBd6yLzWz
         SpH986Di/MCXTXOeDNNmbYxxZq/xqSCfIhPH/1U32dVpt4zSJaUk9/STZTiCIz8jZYe1
         DjMWD7W4+5oL6j3+Kg0F9GjOCk+NEQlF6+WIDhWb309NGShqkADItvdBL7MEBQ/EzddW
         qWrO78sF2HVToYk5XrIUP15lYCAa1ZAyrV9pBg1/lYc4q5v2v6/2MZXbP9Gp5K2dvzXD
         bw9MlMUkTiS8KbMmra6zzBmXMTGcfuJhG5ofEaXqMuhBt6mn1VdOrqJ7pmVwSF1vGg2e
         hq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748016016; x=1748620816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WE/1otE+Iljvc13TDUh3vMrtfx4k08FjErn+ne3CuXQ=;
        b=pFhvtNsxlT1/28NNFgN60Cq5k0a+kGPqzhplXnxPJslqqdgQZTH0Y+86rTwOwC62LA
         lnyKIA44GmRx57z9DVoquycjSVHPEKfprgBj5fsfsNqOPC7kd8tLiV3uPySyVTSWE+qJ
         vXTI8Oi+xaeQhV4kJX3+hkF7GLbtD9xeuF/YqFVJYMPA5/He/Dpbej/bJK6ACKBAU8NE
         8eYCeHc0bA8d2A4uDXXRf+lp2xPi5eUz9jrqpghO3pqTDpuN02ixr2L0nULREF62YwEX
         JSev3O7N4vSyB1I0PNjneasHecIhoxSVILr/9Sz0me7QaEESlcI0l/Paddn75guj/WgY
         DX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwKZObRoKQwz3LFcjMgZzy5ohAEp8HhZF/tu4AmLTGV9xxCWnnacsjXEyjJtqpa4EaneGaNjqMBX2a@vger.kernel.org
X-Gm-Message-State: AOJu0YwV63LwS4NtMKrx2WBpSL7xUSfRmnUKNFOKMKcc1FMK1eZmFk3p
	vUDBmUlxZN4B0Uu6lLahUyhFn8UHOau79d59i/0ZT18ow59f0cLpng4sWxVoR36d3fY=
X-Gm-Gg: ASbGncvuURITtWNDO4lnBu3bsIXrNRGKWc6VZ5pqYMEu3ibAE4XkNyK2mXSxZ1hrXdf
	5zo+j33f4xy0o1X/Sy8doq5+2VXzb6lEDjePkdnmyy4kdXwQr6MiML2D8Yh5iO6R/t9RYPGjRyA
	GxkHJ+qFRtxlJ5Upu8VzQLDNQLVFzcC2ekMOyvILA/tDGXkzwg4mjByCXMaVRW9AGbekVsizUaG
	xU7IuNAveYW8sw92CwIY0a8GCN4P9E1jFkp7quaku/lkDz1DsPgPBiUj3wN2O6J95DI/9nc3Kvo
	ukHXa3XGuNtaMmDZwSZJgAK/2j3MOLesQ1xR9xwXHE4HBdJvzrR+cdvJ
X-Google-Smtp-Source: AGHT+IEW72aM5Tiovk6+jR6x6I4k/71EWX28cSp5QWzET2iJjFe3Mzu0nM+OSh1vusRA3SRVB++pPQ==
X-Received: by 2002:a05:6000:1ac6:b0:3a4:79e8:cdee with SMTP id ffacd0b85a97d-3a479e8ce2amr9395354f8f.38.1748016015926;
        Fri, 23 May 2025 09:00:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca4d310sm27195640f8f.17.2025.05.23.09.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 09:00:15 -0700 (PDT)
Date: Fri, 23 May 2025 19:00:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Vlad Dogaru <vdogaru@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: HWS, Fix an error code in
 mlx5hws_bwc_rule_create_complex()
Message-ID: <aDCbjNcquNC68Hyj@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This was intended to be negative -ENOMEM but the '-' character was left
off accidentally.  This typo doesn't affect runtime because the caller
treats all non-zero returns the same.

Fixes: 17e0accac577 ("net/mlx5: HWS, support complex matchers")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
index 5d30c5b094fc..70768953a4f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
@@ -1188,7 +1188,7 @@ int mlx5hws_bwc_rule_create_complex(struct mlx5hws_bwc_rule *bwc_rule,
 			      GFP_KERNEL);
 	if (unlikely(!match_buf_2)) {
 		mlx5hws_err(ctx, "Complex rule: failed allocating match_buf\n");
-		ret = ENOMEM;
+		ret = -ENOMEM;
 		goto hash_node_put;
 	}
 
-- 
2.47.2


