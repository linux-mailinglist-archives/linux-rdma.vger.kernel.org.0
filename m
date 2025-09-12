Return-Path: <linux-rdma+bounces-13312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6BAB54E55
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 14:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E02F17FF60
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 12:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCAB3043B6;
	Fri, 12 Sep 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHkH4g9t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053771E32B7
	for <linux-rdma@vger.kernel.org>; Fri, 12 Sep 2025 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681281; cv=none; b=Qsn3ZVCF1+U06RHigmHnTjuziRxxwrd1T5f8T+FAC1Q2JrvaOfL1t+9RNo1evXPjDz/3ps0i1A2BqtfH2zuGvqJSVWesiFE4tbWjX5KlUjyx4ArsQm3Z2v4sQ9vGVCZZji+XXaups+3NTCFnneV7uUaw5KfQLEWZ0XmKteU8mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681281; c=relaxed/simple;
	bh=/bBHlqvuYw4F8PIEEXnZUXLj1HeRzcL3zjGXNwkqvb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tzwYJBcjnJE9Vd4BcfRZvsEyFFNx5rca2SUCwPVZ6MCE/4OEXj4O9OAz1skp7KtLbHH29Hf02stkzo6taZCdD0pdmv3GSql6By3AeheSdeASW4VssZVTkwXSJ3mF4lDcsxDYTGAaMHz8IBnPNUGVRL3rXJ+D8eK2FSiFRAvStYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UHkH4g9t; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so22372535e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 12 Sep 2025 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757681278; x=1758286078; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEdkkKvxismcS58hXRownNWSxQZrbC2LFYQFClP1g8I=;
        b=UHkH4g9tSxlWsS9WoKL4c/7SHZKOO8BMLl/MIqn9+vx6o7UKBbqy2HVrrNN4Yr/JlE
         DTxSvq7ma6ZN6oVXBTr/roAGh0IwAmgnWQAQ0xcL5IVF+3qP2E0k0jG1JGgXXOCbhY7k
         0xz4jCyZuFh1y2+r56m17TCT+AuqndR8FVNcq5iAoZdL0syH2xzEHQR1rZHw0yUscT6e
         VD5DqylqxPHSFchagxPHiXQokBlnFbGaR/vT/rJAJCat0HrF8GhA3kWcvJxjFGbuYA1x
         aPp3KdYSPGF7h07Vy1G47MFSvw4feNcBHqXe3zMVF6xhbzKezud6xNWUZYP+Fc2kOhfQ
         OQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757681278; x=1758286078;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEdkkKvxismcS58hXRownNWSxQZrbC2LFYQFClP1g8I=;
        b=SSRdeXNobdZYn3gM4IqNX2JqEWKPnLMbSsWdgT1zh47dsGTNie5aiCyXZMX6OVZGDw
         E0ekxdQVTuHhon/J+Kua2D02PTqoo+Gx6rPrUKXIq/r8Jk+1i9vp37r/v+J+KO9FKAdD
         yapE0FBgExbaGlOuyjGz1QaeQ6GntIPPJM/WH7co/b/qQ/KxOTBE+XU9RY3naRsP11pV
         cEu0um/9XObUkfJSU85aDTb2AoqmvEuo0nQbDEXFLkbr0x/7YNOIyI2+D1q2jG0KVRpa
         UWoYes5yvzH43IC3v6FB196BACVy9+tQbXwuZt8zfWuW5/jKc/dnRae+jC1cFJqKKlzI
         qJSQ==
X-Gm-Message-State: AOJu0YwEN+MhO0zkjDH7vweEO7sPtEVnAkgFLF9mOeOlLZbr4lrDludJ
	IK4F3lBOsh6xCDEkbkGmMwixgibn5uVU6ntA3vBh0x9bLd6QizimBwWR9HJbNrNKGgMWpIAeBut
	aUMXf
X-Gm-Gg: ASbGncuzxC+q5UTUoS9cn6r5yNYxRtWFJZg7NjNZ1eb3NSjgobyJji+5wVpRhG2KsJI
	uWmiW8qvjQXPkpdVT4ldSSsOjFKoyIrHXH6NMWX+Lphz+bl5vjNFCys291FhP5In0uNiZBDhpzs
	298BJaV8pVU/Lb5SoMgO+yGAkr6cYWitjjD5F28SxkTnRWX+OnoMcLfcJU31hd9Zge1qhb52XJ9
	V7t1HjpKPa8h89Ylj6yQTPtwuPGvzO+IFhcwWSMF8TSJVAYHffrNawLfkkb08G5WOYYi7KtSMwi
	EqR+Rla1BvudvrXMFk7qJmebevqvAy7EhKu+n9s1/SNol8DbPKyXNjWQUKqZiwrveF3OcUSHD6H
	YP6d4mbu817srRuKR4rIGK6Wm+nI=
X-Google-Smtp-Source: AGHT+IHNMpizuXUt/LJSYcb2s45nLw6JNQdiFD4UcBQf3Xu8YQ46G5I90BtPf9twWzHmjhr66t89Eg==
X-Received: by 2002:a05:600c:21c4:b0:45b:7f72:340 with SMTP id 5b1f17b1804b1-45f211fdd58mr20899225e9.25.1757681278187;
        Fri, 12 Sep 2025 05:47:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45edd9f75d1sm40876755e9.17.2025.09.12.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:47:57 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:47:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: Implement devlink total_vfs parameter
Message-ID: <aMQWenzpdjhAX4fm@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Vlad Dumitrescu,

Commit a4c49611cf4f ("net/mlx5: Implement devlink total_vfs
parameter") from Sep 6, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c:494 mlx5_devlink_total_vfs_set()
	warn: duplicate check 'per_pf_support' (previous on line 479)

drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
    455 static int mlx5_devlink_total_vfs_set(struct devlink *devlink, u32 id,
    456                                       struct devlink_param_gset_ctx *ctx,
    457                                       struct netlink_ext_ack *extack)
    458 {
    459         struct mlx5_core_dev *dev = devlink_priv(devlink);
    460         u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)];
    461         bool per_pf_support;
    462         void *data;
    463         int err;
    464 
    465         err = mlx5_nv_param_read_global_pci_cap(dev, mnvda, sizeof(mnvda));
    466         if (err) {
    467                 NL_SET_ERR_MSG_MOD(extack, "Failed to read global pci cap");
    468                 return err;
    469         }
    470 
    471         data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
    472         if (!MLX5_GET(nv_global_pci_cap, data, sriov_support)) {
    473                 NL_SET_ERR_MSG_MOD(extack, "Not configurable on this device");
    474                 return -EOPNOTSUPP;
    475         }
    476 
    477         per_pf_support = MLX5_GET(nv_global_pci_cap, data,
    478                                   per_pf_total_vf_supported);
    479         if (!per_pf_support) {
    480                 /* We don't allow global SRIOV setting on per PF devlink */
    481                 NL_SET_ERR_MSG_MOD(extack,
    482                                    "SRIOV is not per PF on this device");
    483                 return -EOPNOTSUPP;

!per_pf_support is not supported.

    484         }
    485 
    486         memset(mnvda, 0, sizeof(mnvda));
    487         err = mlx5_nv_param_read_global_pci_conf(dev, mnvda, sizeof(mnvda));
    488         if (err)
    489                 return err;
    490 
    491         MLX5_SET(nv_global_pci_conf, data, sriov_valid, 1);
    492         MLX5_SET(nv_global_pci_conf, data, per_pf_total_vf, per_pf_support);
    493 
--> 494         if (!per_pf_support) {
    495                 MLX5_SET(nv_global_pci_conf, data, total_vfs, ctx->val.vu32);
    496                 return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));

Dead code.

    497         }
    498 
    499         /* SRIOV is per PF */
    500         err = mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
    501         if (err)
    502                 return err;
    503 
    504         memset(mnvda, 0, sizeof(mnvda));
    505         err = mlx5_nv_param_read_per_host_pf_conf(dev, mnvda, sizeof(mnvda));
    506         if (err)
    507                 return err;
    508 
    509         data = MLX5_ADDR_OF(mnvda_reg, mnvda, configuration_item_data);
    510         MLX5_SET(nv_pf_pci_conf, data, total_vf, ctx->val.vu32);
    511         return mlx5_nv_param_write(dev, mnvda, sizeof(mnvda));
    512 }

regards,
dan carpenter

