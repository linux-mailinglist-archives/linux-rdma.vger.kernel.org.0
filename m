Return-Path: <linux-rdma+bounces-4947-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59237978FC2
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 11:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6B51C21C84
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2024 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8C1CEACC;
	Sat, 14 Sep 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTnNCeHW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603ED1CDFD5
	for <linux-rdma@vger.kernel.org>; Sat, 14 Sep 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307914; cv=none; b=F2DUFawasjgWTCxld9Jq4y0307pCndhMCQV24YAgL7SbNJH4gs/uuy628xgnNkZQD5ad/R/1brFkkrWVEanD0ymYZendRdYMOeG4kDqfXpIg18dO85FPF7YqBG1JYFHdablJ5CxB1Mpp7s7ePn+Lpdcc7QeKtiflZs5gQHO561g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307914; c=relaxed/simple;
	bh=ya7/LjfmKpMsoE5aQBDX5qZQrPs7t0zo+9KUYJNQStI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KS7jn4ko/NLH8XNl9dEQ+BX7HtfWyvXiFYhI8hID5+DK0nmvL8wtLzQf4tMmUOew+FgnyQyzZmGWBncZPGu2zxxouufc3ZI1B9OLMREPlNF1I0PBADraGKdjkGYkCYSWXhimKf5fcYfUlUsiBeUpPC9ZEWrhL2uGX4nEgMpkb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vTnNCeHW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32971cso3742117a12.0
        for <linux-rdma@vger.kernel.org>; Sat, 14 Sep 2024 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726307911; x=1726912711; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdccIKzjZeBA+TQzTuhi7PDMeQ4nYvxBAZIlCMJ8mnI=;
        b=vTnNCeHWFAfU0LmCfnv/tvrG5P/re32LBV94Lvc/WUEXelnBWOh67l0Dkg5dvDfrZo
         tOidpEmCDf+cpmvTOdGZ5wDNnGDMW/145L2XVRcXviN39ADSZRX7ReRcpD9sn7N1gHx6
         m+MMSqcdfbUl2/vGuFzczv1z6Je3uPMizntJMkc0+JOIh20o8OMJvRsVUfJEB7o9PXKm
         Id0J6YSO6S2zWmuOtahkN3+FtZYM19sxRKxivNyWnqqLzMmXciXQ+CSV2PjXoxjRwIsk
         0sqwTyS1/acHhyUEG9/vKQjKWJPlAUeX40cQu99/v/QIvbzpTIE1ZaSF2mj61SeF0akx
         /UZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726307911; x=1726912711;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdccIKzjZeBA+TQzTuhi7PDMeQ4nYvxBAZIlCMJ8mnI=;
        b=s+P3IPfwOojf7bX3CPvBPlOIO9XgrG0aPT/4JinxSuJq06SS1NM8Iv8DNLkJMHC12G
         8UWK2ULcNT9jWDN+fUhjY5EtH6S0dPtXJAptPkuQ4/hJL7GsdyiiOaGuoMVHbf3O6Db1
         QbNjqxz6UlXFpSwb1LZxykOHEnSFjf+BDzDVCalKeNGvh/tws+2BF4J4wDYthWTysbrC
         L2siG0PVZI16SiX4EY5oJk7i0tltrowKKe4OQgCpLijaebR59YtY5Hf0jLRpdPhB45Bz
         oQFrRmZSCovV1ioqovw6xJ4emvVX6EZSOad4SirtUJp/jOFk5PdR9phghHZ0rLylbzd1
         AbqA==
X-Forwarded-Encrypted: i=1; AJvYcCViVY8V9f94NRdsuYfKGeahYTohARoj8SIx0igqAFMsavtkbzO/mIuhrlF4xNo9sBApAwCRV0OrgmyB@vger.kernel.org
X-Gm-Message-State: AOJu0YwbZEt5GtMQkTiTeeLgx8F2+PenCd6sHfad2sL+v4AeOSR0/Ayq
	5T89REYWi91ONximfPL3/1ikGOvCU0HOR9qqPoRwi8a8YsMxt04H3GPdLhV5TAk=
X-Google-Smtp-Source: AGHT+IFJrSTGbj6IkzPSkz0zqYy3lgixlfvOUhv6EL9dyvHz+N7B9GcrOxAec6RJljG6MrVvxkq3eg==
X-Received: by 2002:a05:6402:26cc:b0:5c4:2d7d:9759 with SMTP id 4fb4d7f45d1cf-5c42d7d9a77mr783746a12.10.1726307910740;
        Sat, 14 Sep 2024 02:58:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89d44sm499739a12.70.2024.09.14.02.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 02:58:30 -0700 (PDT)
Date: Sat, 14 Sep 2024 12:58:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Itamar Gozlan <igozlan@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: HWS, check the correct variable in
 hws_send_ring_alloc_sq()
Message-ID: <da822315-02b7-4f5b-9c86-0d5176c5069d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a copy and paste bug so this code checks "sq->dep_wqe" where
"sq->wr_priv" was intended.  It could result in a NULL pointer
dereference.

Fixes: 2ca62599aa0b ("net/mlx5: HWS, added send engine and context handling")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
index fb97a15c041a..a1adbb48735c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
@@ -584,7 +584,7 @@ static int hws_send_ring_alloc_sq(struct mlx5_core_dev *mdev,
 	}
 
 	sq->wr_priv = kzalloc(sizeof(*sq->wr_priv) * buf_sz, GFP_KERNEL);
-	if (!sq->dep_wqe) {
+	if (!sq->wr_priv) {
 		err = -ENOMEM;
 		goto free_dep_wqe;
 	}
-- 
2.45.2


