Return-Path: <linux-rdma+bounces-2131-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2834B8B4C01
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Apr 2024 15:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D862815D7
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Apr 2024 13:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979C16D1A6;
	Sun, 28 Apr 2024 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq+w/6vI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412B3A1DA;
	Sun, 28 Apr 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714311302; cv=none; b=HDk0kto1+vX5x/T60UiSwnIWUucjBAYhkWXsiRB7DGE29MUiFp8zhInTQxALJoKI08FUZ+X26+PJpygneBCORBvl9ptjTUQ7tY3uT38xaqDvwmKz++wrXybrzD6c90NCqNkPAnBd6omgRoiOfrVSg9xXC3glZSRhfd6HH8+UIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714311302; c=relaxed/simple;
	bh=2uRI9LxPo4B51JZchTefSe/fRwTISlvKr+vlD/tMD1g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T2tS/mm2etFMipvjFQNRFipDUC327WbFRISJYg60wqXSRu/lLrig+OZViheogG2RLcs6mtpGhydqjNcl4lFJ+lOzl8eB4a33SwNvTaxVe9ksfQX5rzX2pWzqkJWfhL/9FOQcAbHgW68tUVq7KCmKlUwp3yMCKhzseoRe098ZeUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq+w/6vI; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dd64d6fe94so40309001fa.0;
        Sun, 28 Apr 2024 06:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714311299; x=1714916099; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IP96e4j7N2ga+3IohjdHWOANxjwoUHNjswPRS+pnAU4=;
        b=Tq+w/6vI88gK23Fb/vRSMKbNk95fq+gIFGKajmnc4DikVOcCNQVX1UfUd4gaj7MdLq
         93lZMLyqHEWE9bRuV+639Q8SJV8s+JTu1IBJkl1tb1TjDNiN4mpScXc9EpHX0GBX6kSS
         9GLRh4ZG7mV4zYMWccY1YlXNytPdUGa4N4lkDJVivGOxMA/zElNHTLQTyatr4We2uIZp
         02XB1LPOG0hKmnY+OrGVrDXo3TG/8/aSk7WSqFfAJAtQs/Uwes5BnCA4E7YzbWXjvafk
         vLbJYIzeA9+dvs+xMS0wdjd+GEGNof7/8Ah2K2EuqiCQzeNNnLN7MYluyT488neJPNhf
         uGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714311299; x=1714916099;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IP96e4j7N2ga+3IohjdHWOANxjwoUHNjswPRS+pnAU4=;
        b=o/+Zibn1gRVy07v6pb1SBfIKeSpVQd1Ze94HF1NErKOE4CxwusPteMiLssnlYYhpBi
         ttCfHmz53oESz63ORC29el9bR02UmtIgz5IACZqxaiT8+DPkQ+E4CcahEtaL5ERQRJG0
         k33PJgoL3DlvoMaY5a9WQ/+Gy1U+fCwwOuesuccOS2OlKjW3a7R91b534T2hPr9yP2/1
         yDjtCXyIq6Ulg7E0Iouuzhi5Gd2XbAOx2SoyjafZht1tQGlVi9QEmVQtvQ/W4vnF2zaa
         X/zmXLA5hVWhRYSQAAn3ZY5lFHxJa83NV2yUf0JS23eVwbB4dbl0mfw45t1D0tpwMgQy
         sr4g==
X-Forwarded-Encrypted: i=1; AJvYcCU9DBJC3O/AIEmfG918+PcYjd2LY1Vl9pAEy2N1UrufTE+W0moUP4nF18MCxt3tSzZmRyc0TUllitu559qyKdpyZexBe7DNSVn6ckg8+0Jlr8jpeEdqkgM6DRM7poeZ5/0BSMhCD717Cw==
X-Gm-Message-State: AOJu0Yyoly7YnnILjJq7ngweqngyHyW9Y5DQX8ohFp2WYRFrrxnR5HEO
	bPg6/6//jGB5Albu28XA13zeo/tyqtC97oRwxZp5mCtEGtAmvEA=
X-Google-Smtp-Source: AGHT+IE+EDa/RpA244Drr2Qyd4OYXHmApxtCXrUqvkVYq0vUKmloj1NkIcSPyFBdjssKb4UwMd8tEA==
X-Received: by 2002:a2e:9643:0:b0:2df:97b1:d4f4 with SMTP id z3-20020a2e9643000000b002df97b1d4f4mr3063645ljh.33.1714311298705;
        Sun, 28 Apr 2024 06:34:58 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id fm18-20020a05600c0c1200b0041b5500e438sm12260745wmb.23.2024.04.28.06.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 06:34:58 -0700 (PDT)
Date: Sun, 28 Apr 2024 14:34:56 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: jgg@ziepe.ca
Cc: leon@kernel.org, wenglianfa@huawei.com, gustavoars@kernel.org,
	lishifeng@sangfor.com.cn, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/core: Remove NULL check before dev_{put, hold}
Message-ID: <Zi5QgLIt9sblrfYs@octinomon.home>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Coccinelle reports a warning

WARNING: NULL check before dev_{put, hold} functions is not needed

The reason is the call netdev_{put, hold} of dev_{put,hold} will check NULL
There is no need to check before using dev_{put, hold}

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/infiniband/core/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 07cb6c5ffda0..84be4bb9b625 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2235,8 +2235,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 		spin_lock(&pdata->netdev_lock);
 		res = rcu_dereference_protected(
 			pdata->netdev, lockdep_is_held(&pdata->netdev_lock));
-		if (res)
-			dev_hold(res);
+		dev_hold(res);
 		spin_unlock(&pdata->netdev_lock);
 	}
 
-- 
2.43.2


