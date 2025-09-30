Return-Path: <linux-rdma+bounces-13735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2835ABACCF4
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 14:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28FC7167FBD
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Sep 2025 12:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9272B2FABF7;
	Tue, 30 Sep 2025 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KayxsDOP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88923D7D2
	for <linux-rdma@vger.kernel.org>; Tue, 30 Sep 2025 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235109; cv=none; b=C+1BRj1yjl2koHXMlA9bkeJLTskde32VRbBH4EPV536Is3ei1qz2iI7E2KpBTXx7/12QaC+np+FwX5xZGz9IuJNlnM7HIUwp8cCJFxEZktClflENBgR5xpqeb+vN3l43xHyDFSuh4+xcM9RdFeffRz2e3SePQMJws6p38mTpffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235109; c=relaxed/simple;
	bh=N3iWQBr+C6sq5xql6Cd1AX/fvpXX92N8aQvLLb5U5E8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xx+bKMX+gHzhvpmRao2PLaABHvF7aJU+WtTYkAanhQoMK35JC25w1TOWwp07QcRFBdVR/Qr5JgCO9IWhFrD4GhAQXLK//oNftOvo1CcsuAfM96l8aSYBdnLhBsfoTEp/JBIRNYX/7Cgz0rBRHqF9n3Q402CECjBeFePlWK7ws2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KayxsDOP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso4592034f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 30 Sep 2025 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235105; x=1759839905; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6lOcLfmjHHMwdRKIuWAlaFWrbjWxKqUiXJMf1tdzpQ=;
        b=KayxsDOPIF+Wrm+kQOBRpu9ibozip57hTC9ymTs/ic6YA3Pbm4IV40dKAMSqryYspd
         wYOS6DtGkLc2WhIJyhphMPUgTdOeGA+gdXj88PhsNyE7E5BS6YHIlYK7eXN6n7RXvKy5
         eSsT7uEhGonZxy+jDM8E2dQLHBU3uxHcabK/KgG6+e8WCJZ7EKHuvQs0cPEiCbb2jKlP
         Nwlcu6c/YZltw9iltwQRCmPej+iXAk/rqErkHoH7uGuuyvNkFNuy7I24Yy+EWl4yNpa0
         Hfd6fVPf4HkIFQyqMUm/0NpkNPHTuGHD4sEfrcPMEUtawlOtvTdc7CIvgsC7YtcVvIlx
         D1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235105; x=1759839905;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6lOcLfmjHHMwdRKIuWAlaFWrbjWxKqUiXJMf1tdzpQ=;
        b=cO80cLn1ETiLGnJOl0BVRcD9WUgfrnzqjvvO898ZYHb1VWc/h6EN4K+s8h60mOcL5G
         Z53OFcMjjOWxomw4zOGsnhgVbE+wyuu6e1sHuPftflRecw2HFOByqB0VT31N3ciIixNr
         Mhezqb/5LmFPjdnwl96jEVizsynV8wi8c5E4AOVjbWl1H7EDbRn7mHyRxwUFKNYZCFLX
         RGiy2/ORJggZAui7AyLq8JLANVAhd8hRfBONfs2d4fQIBtzaSdswmcMae3UYvvlok9Br
         zEVG6auACJ7G6wZEoCOkn2f/Fltgk/aNkAnTsd8eIGmYFrJc5x6LAmWEOLPkeJoqyP52
         wIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNIWZCYH0i/xWVlFRande8ns++B5rVeqeljw6aUERGVwHLCF5/wSASaHeqFaTz0q4M3rmHNbBs2ET/@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFlaruRk91rawV3uXS7xl4c0suAU8pPQfoon3hO4t4XDEZLHv
	PUg7sFzwDOv9alAvaLSj6Bl3r6yYRKUQuUpWnXgGGovCA0BoYx2Fzjr96EfQZWvrFl4=
X-Gm-Gg: ASbGnctszsa22yPOMsRaXtliSYUmjPhwO4U4nclyjIUTpCrQ88UONC4WjO9w3vuAaeh
	0RqLIQmHctR6PAhpfgpVDao8ujuh3+L15DPQXrn6VeXUV7Ck5Adm9F0jT76VYE2siQo/B26wY8z
	ia997UKGdfNf6nzFdKLbfQkMYGO51B93p9/bYDlOB55pPmo2QK20Fpz6FzAJD+mlTcyh8JLyIRe
	W4RVpJwwoZDlwNgc9yT7uJARV7GtgFHH33JsfQ9ckM0tWp/MFEJx5d1qp7U3DXPl0ry7h2Iej23
	vJ+fEUQ0EP0ErdQqmiHY2jzuJ2Fm/AGV2tGFDrQkuyJQ42z48MXu5K9iBUbOPM7L0bjHkZnwxMR
	Lt5O9m9mSbS3cDyT7Ys+yfdYuIqyX2TQoOrRV9aZTx/+OPdroZR4/3DmuNwJrbuI=
X-Google-Smtp-Source: AGHT+IHLfXLZ95GySBe9ZuBPDMocDcdm4e3YftS67zYrym4isY22xPTXaFrasbFvqRJbXcP0Bwxl5A==
X-Received: by 2002:a5d:5888:0:b0:3ea:d634:1493 with SMTP id ffacd0b85a97d-4240f261673mr4414743f8f.3.1759235104947;
        Tue, 30 Sep 2025 05:25:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc82f2ff6sm22407808f8f.56.2025.09.30.05.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:25:04 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:25:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yan Burman <yanb@mellanox.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Amir Vadai <amirv@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net/mlx4: prevent potential use after free in
 mlx4_en_do_uc_filter()
Message-ID: <aNvMHX4g8RksFFvV@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Print "entry->mac" before freeing "entry".  The "entry" pointer is
freed with kfree_rcu() so it's unlikely that we would trigger this
in real life, but it's safer to re-order it.

Fixes: cc5387f7346a ("net/mlx4_en: Add unicast MAC filtering")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index d2071aff7b8f..308b4458e0d4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1180,9 +1180,9 @@ static void mlx4_en_do_uc_filter(struct mlx4_en_priv *priv,
 				mlx4_unregister_mac(mdev->dev, priv->port, mac);
 
 				hlist_del_rcu(&entry->hlist);
-				kfree_rcu(entry, rcu);
 				en_dbg(DRV, priv, "Removed MAC %pM on port:%d\n",
 				       entry->mac, priv->port);
+				kfree_rcu(entry, rcu);
 				++removed;
 			}
 		}
-- 
2.51.0


