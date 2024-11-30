Return-Path: <linux-rdma+bounces-6165-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD159DEFC5
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Nov 2024 11:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322CA1636A7
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Nov 2024 10:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5978156991;
	Sat, 30 Nov 2024 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1YyKLUz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E51531CB
	for <linux-rdma@vger.kernel.org>; Sat, 30 Nov 2024 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960870; cv=none; b=RBKuZ0vum2C6bJsVEfoTqR6oDYPBVI1Trf/t/CWHZ9HzU62DiRydXa+SJOmzfBa/20pZMNR7mfwWT4k9flgsSWUCzuggENi8GrS+tw7tBqKoG/WVZ8PXZa8qJ22ftVTNI9IqvPC1UrCFslAH4p3Fj8JiVoPRN0q0lS3Y7WEQUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960870; c=relaxed/simple;
	bh=/XpaTseG/TEeisBd+wk4TWWeiStEhV6ICnH01fIZSu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ir+gjIHeLqCqI/PkQch2MrD+a+yyXGlMuX/ujoEeeFjDsuiq1qUKnxEDPFoaBssfubL7lMxofL/qFUhUmKVWJQ6i71JLd0Mu/QqUAaOvKSpNzXzxQu/MMWaD+Wdu8/Jq+WQC0kh3NJgZh2XICoRDDWhy7Za08T0KOo+PFAy63Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d1YyKLUz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso2973596a12.3
        for <linux-rdma@vger.kernel.org>; Sat, 30 Nov 2024 02:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732960866; x=1733565666; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a67SmAxg7nZOip6zVhj4ZsmBcbeJIrKRZCIwBRUJFXg=;
        b=d1YyKLUzWuTjh2B4bEUrPOGTF5zhAiYqp3Ha8yY5Quyjso2KPJm4Yt6xEyzT99yZz2
         nFTJbNWOzGTTXjU4aPAATBmUn9maJj4zvf1B4UH2+n2o8SSGI5XRf5s0U2ynrVd5ZKuv
         YUzR+igj4Mu9a8DiHoCfEAWtSUzpMBwqOVMcG6dwxs0d8tGpWBcLnAN7x1FzwIZXFXqs
         T33rqTeCOZ/nOxYSQbL4xJI4egCBO00mku5/zd8Zpodkuw367jFtr5ktz4QjnNhR5TJ1
         9Q8N4GlOZI6BhdRzkg8HKX+AwHu4VlfYOohIYLH3AcMBeLpuR7GkjR5Ude0X1SclfK12
         OCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960866; x=1733565666;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a67SmAxg7nZOip6zVhj4ZsmBcbeJIrKRZCIwBRUJFXg=;
        b=ABBIbdCQQpu2OYpNHguNdUXk/k2q2h4T8u9UL4Ov2BDBL/xn9kMHe14NFiczegLsF+
         ltmspq/NlZxRKaBwdFXi7oweu/uS/yLOvSoughkREJTvkI6Xhr4pw5kcXnisRuG2JIGx
         Dd/g4qyHW/+sgPhMfUHj1dReUCC07J0F9gy5prGmhvZqgCDShpz8WylCuaaPKENNvZ1h
         aMzCHJhEaV7CvIPkib0ryoQo+A882QznsB/RgOWMvl0VlN+EdWlXDBuZoMYXq6BdAzw5
         otpB1xcXy7oxHwYvPv+JtBa4cudpHvsV966Hjnit+VXvgCR9MDnWezbal6NRsZoKUZKX
         E+pA==
X-Forwarded-Encrypted: i=1; AJvYcCX3MB3YIr1fLJArnIohe37+bOs2ufUzM2ecRa+K9y9ltGw7NdE+UsSoZUKhgpKMdcJ6sYFKohiQAFfl@vger.kernel.org
X-Gm-Message-State: AOJu0YxTPq9d3dr21lzwJbOPpsBYGsYIRKprrCJKvglB8g0kgroNpYdd
	73gkKowt9jW8LrUue1iDv2sJTrItfyzJLHmO+5LVShhTJ9DbBFXNF7M8bFRLQys=
X-Gm-Gg: ASbGncuRJGV5JeZc+iYROiuLYlEvEKCYtw/sOVoknwFDEXMg8LtzDProYoHQwZa7ady
	+JVhF+alX96nYOZa3vhxaod64umpzdElHjq++9ut9OBQFTN0XXhXZz1a1AmJ6GYlJBXdWBwtc6m
	uQbpJE0/2MU/A5fa/dIQSszO65h6vZl3U2mVIfNP7Hp+9JqEVPKacFTWj2vPKUHgkCNVPWnkUr2
	ZBneCmc4VqU6BIbl2bSxF9xNhAzCEYcUfo5nEMRGYai0rMQIQ6XMyBiYLxjSHDWbURckjfY
X-Google-Smtp-Source: AGHT+IHz6Lgpgq1CwlN5SY6GoUtJEsnuXZdZiLP/TvT694J0WqT85iYkJrByZ7WTMbPj28wc6GAvsQ==
X-Received: by 2002:a05:6402:354c:b0:5cf:e9d6:cc8a with SMTP id 4fb4d7f45d1cf-5d080bd019amr12849937a12.20.1732960865832;
        Sat, 30 Nov 2024 02:01:05 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dd619bsm2665439a12.39.2024.11.30.02.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:01:05 -0800 (PST)
Date: Sat, 30 Nov 2024 13:01:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net/mlx5: DR, prevent potential error pointer dereference
Message-ID: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dr_domain_add_vport_cap() function genereally returns NULL on error
but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
and if it's and -ENOMEM then the error pointer is propogated back and
eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().

Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
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


