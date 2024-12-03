Return-Path: <linux-rdma+bounces-6187-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911B69E1A90
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 12:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D6EB60289
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 09:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98C71E1A14;
	Tue,  3 Dec 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uV4ME+gR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031DC1E048F
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219122; cv=none; b=rCNVnKT7IXNcKktpPNTcMH+MKZsdJKHDxtAt3r+YtA2STaHFCVn1IMfjsGpgKuHyTwQAUNGszfVPMfdFWHkKMCk5fPNCpcbeOMrKEVt+Zoh823ZXFBJXW4hdgVM6AikrC6CtFAaW6ju2o/NmEfpYdCIaF0kQOnQPQest/yBZJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219122; c=relaxed/simple;
	bh=RJ4dlBGD3salju0V5qaXj8Hlpmx2bDBn5RHAXBda2Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FCLpWOj9PtGbdv9msLhc2gt7SptcJoXIIREUsmyPB9wFZUGcrKERU2CML3G75hAhT8VYrgKuwrK8QifHsTlBIfj1KWgEA9Z046AZXFk1/ENDb6J+2f7w+VKa0eVagtSLoKYnKqaxRnWo0blBZX7hG9suWr7/zTOLRM+PFvhEGL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uV4ME+gR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a766b475so48688705e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2024 01:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733219119; x=1733823919; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6I1Ptmv2KxZJwio/UIsOX+BhzfGwkhQGEzNHEKVRFKU=;
        b=uV4ME+gRVBtdJasDf2fMwONsoRGQM5JE1tp3+s+c5xfAVh5yqwY3NGe0x9w1ch8Xsk
         wQZZYyiZiqi/WOgXQiv8X8W7Y4hn13uZRQaHX0fOmwg94V+jIA4llTy5fA8LXnSFDuSw
         JKvDa0Ttcqn91PKjU6UNi8az4afbfH9bUyq0/Yw1MNUNugheMzK8Y4a3t8TCJswHZZg6
         RdRxxAZ86ILTnfJm3nhGg6nsjDAfDP1zMahUaEwnBtbGIJ78jz1WdLnGVrJIKosfsE6J
         yqDpErgO+YhsHYSaNcyuqgcTrqYuVLKvBJTHo7vLPmKkXO2weeqSnHSd9mwL+F4BqB/P
         dHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219119; x=1733823919;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I1Ptmv2KxZJwio/UIsOX+BhzfGwkhQGEzNHEKVRFKU=;
        b=S0SkqYv2qFQ3yYOP93mmDvlHhpwxKmJavjZ/u9UAiWS8Ge/bMIJgO/S6z8lsEFOEkD
         rIjUoWJCBlXMFfdK97Gr349voWHeDxgCX/7yLLgZgmowdbHV4d6o19prM4sTJv4y4RwK
         sC21grdEl+ELJRMe1oGGXlcwOgUmbTWB7LxAwlQvRB6YJiRWbOOyo1qufRFc4tLqmKw9
         /mTZCs70WxPKGrsBCaOXMFdVEy1kBTsXne3XtnAtC+MCk1T2Gchi3zErHxt+O5w2ffjP
         9b+DZCkkU6uCUKFSmhW6wuXz4VZPVB7clrphEwGUQ1ztG3IG8i20hUqtUpWnO1rY7OzX
         3Rlg==
X-Forwarded-Encrypted: i=1; AJvYcCVyWPD8/mmDVdcqrcDEdkyPdGcBfhjzWd+/3W6x0S8G9LVEiO0kyGUPCshS0A/OOh9LGP0vm/HENxuI@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOS8/+/0G8EnZYuNOUQq5HN3SmH9rp7gyF28TFBtdX6cQ4krt
	f0nxaDz+pDZ65KfuAT2HtCLOPJVFlkc+xM3HPyqkhqOHYzgOSgAfeRrEGSVpOA0=
X-Gm-Gg: ASbGncvzGbub0qlE+Qu5X1ZMQyd1yPcyHfbdd51uVzWbLVXYhJE5Y1AXMHeFeQa8KkU
	r/pVmFqdKxrTK4/Cxdb+oLX3qORFxeGddDmykYk2Od1LNQBRTOUwalqXDKGsK6hIWzOdRCAHNmg
	fcJ/edEirAL18GAJDKg+UUxOtqC0ZAMS181G1Psna+pztehvt7maTOpIXLCDzX7IbafxEwZkI5k
	NZNcI+/MAAEDpFAm2OTPIxUHq4m+k/E5BK2QOk1zr+YnoW5hCU1Uus=
X-Google-Smtp-Source: AGHT+IFdpiCjCQ4owJdmqakSIReYwoM3vo6fpku4tNVal18DsXpYtsSKHcj3Ceq2fZLtSh1NDS08JA==
X-Received: by 2002:a05:600c:19d3:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-434d0a23b36mr15900425e9.31.1733219119326;
        Tue, 03 Dec 2024 01:45:19 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78007dsm211772455e9.19.2024.12.03.01.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:45:18 -0800 (PST)
Date: Tue, 3 Dec 2024 12:45:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <Z07TKoNepxLApF49@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The dr_domain_add_vport_cap() function generally returns NULL on error
but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
and if it's and -ENOMEM then the error pointer is propogated back and
eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().

Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
---
v2: Fix a typo in the commit message.  "generally".

 .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
index 3d74109f8230..a379e8358f82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
@@ -297,6 +297,8 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
 	if (ret) {
 		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
 		kvfree(vport_caps);
+		if (ret != -EBUSY)
+			return NULL;
 		return ERR_PTR(ret);
 	}
 
-- 
2.45.2

