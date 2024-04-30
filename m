Return-Path: <linux-rdma+bounces-2182-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 684E78B831A
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 01:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CF31C21151
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 23:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A141C0DD7;
	Tue, 30 Apr 2024 23:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/hM6/74"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2F1BED90;
	Tue, 30 Apr 2024 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520859; cv=none; b=klmK+TFB+rtSrDjc2sQfIIvlVRECgQtHNfPQgg9EpBXKOa/oo/Q2eQlJKG5kV8pToeCcDWCKrJZBDUqatlRbHaVGEqWU41SE+M3cJGm+De6NCr4WCIrS6pFZCIi5G0Be/qbpuxrCiqDpN5Ur4kgrMavQXFwIY8fvNlX40zdAOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520859; c=relaxed/simple;
	bh=0f7aPbWLeez6QzdgFkMH6OaPb4xqp+8j+iosLZwnXpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U8CrtG9M6vz9k1ULb5vMcjzrynsDDGU7oMhhDQSHYeSyyaN/jtZKkoyN5zV1C4vzTzh6SQgWtIVS+4KrKiMstU3eDbfrS1LFP1EoNAYIwz6xy2moQN7EPiZtHhKI/9gkQt2ktykBNY4jsa/GqVfcgCQhrmrw2xt6f/IRJZ9KV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/hM6/74; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41bca450fa3so29369245e9.2;
        Tue, 30 Apr 2024 16:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714520856; x=1715125656; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLTYhyNn9aGD98LGwc7cNb8xE+/23y9UFFLHfFKNA8w=;
        b=U/hM6/74IkGdSnyvClM0+yAotqCVRsX8neMvbdmCUlrciYYKJc1b8kvueatjxA1R/N
         G/N/IM0+Ab67dDJaq1E/1U+PFPASlWSxvBPPp0iKWGO8Krfxvpw82Mt78fGzTPJQ2tsc
         iTbx2k34i5un5pthcvTc6xyKUX6nF1MVVi2wdcWFfKV7ZCJ+NstOlyvdD1Ng6pG2wBKG
         bLcOCY+qj2Arbq5JrTYb3OzxcQcZwXWQIJlSTO3gjFj5tHpqoEsSawZxT1Skf+QM84iA
         9uwgzYY4VmV6PzNkXMgv2jor5qsH+/oF3wS/o40g4lKml/Rk+CulanBwleCMj9Zpkdn7
         wXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714520856; x=1715125656;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLTYhyNn9aGD98LGwc7cNb8xE+/23y9UFFLHfFKNA8w=;
        b=PJ9D0KcvymeOERqDkmbedszRzKcaLNHWL9VciJrNnbG7YVMrNNX4z+N+YHJyt55br8
         AwA66d0sIVbAB8f3TBeiD53mokhYBv8rl1mRH2lDet3bsNzEyva1VEo7QLK7t1KT71Vm
         ljyHRPBsAR+hyXE2k9SC15v4A23n2SXcWU4tDPLzTxAY6MvP/RwyN9ST7DokDSuwJqap
         kNO37z4kZUulHQaIT0JH+JKoGxQzGucNoKeux9HI1HPeDBPIcAip0kHML9IHs+XJOidl
         M2UtTDava6IyBD4E3vXkyBW5xKyU91mWv/JwxzzG6ohwrLVw4Mpg+I4UJXDZEsORumrx
         H+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5QVFF61U3ZmJQWIkZnugEqRyVZ9mi74/VpBZUJXl6YwNtaX2z+Vy+NMlXo6Imq/9bkSL0v7XPZlZtMIJMr6kp+SJFNWHj6LAT2Iq0QPMQlRTBCvYvuA1LCDYeMUaMJFsHSPNkxYvE/w==
X-Gm-Message-State: AOJu0YzK58IRbsBi6zbuFSLslk3+6cUSseqYDCdJjY6e6Yb79KrQDyV4
	ZoRPcDqSt0wG2c3RTnA6zXXmEinEdnaa4sCGXO+fr+gs2BwdyEkruOReTW4=
X-Google-Smtp-Source: AGHT+IG4dqqQxCYfAxMYG+tN5zrDZw8B2ACow30JdV1eF+9lScAd2ws6UpEue5vPqvbaG0RMiuej+w==
X-Received: by 2002:a05:600c:46ce:b0:41b:e609:bc97 with SMTP id q14-20020a05600c46ce00b0041be609bc97mr698348wmo.2.1714520855909;
        Tue, 30 Apr 2024 16:47:35 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0041c02589a7csm386836wmq.40.2024.04.30.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 16:47:35 -0700 (PDT)
Date: Wed, 1 May 2024 00:47:33 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: leon@kernel.org
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	lishifeng@sangfor.com.cn, gustavoars@kernel.org
Subject: [PATCH] RDMA/ipoib: Remove NULL check before dev_{put, hold}
Message-ID: <ZjGDFatHRMI6Eg7M@octinomon.home>
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
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 6f2a688fccbf..4abec0124ea3 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -329,8 +329,7 @@ static struct net_device *ipoib_get_master_net_dev(struct net_device *dev)
 
 	rcu_read_lock();
 	master = netdev_master_upper_dev_get_rcu(dev);
-	if (master)
-		dev_hold(master);
+	dev_hold(master);
 	rcu_read_unlock();
 
 	if (master)
-- 
2.43.2


