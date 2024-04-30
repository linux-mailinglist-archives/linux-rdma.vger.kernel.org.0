Return-Path: <linux-rdma+bounces-2180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63208B82C0
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 00:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71E1B22CA6
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 22:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0BA249E8;
	Tue, 30 Apr 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/p/LN6m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DC917C6A;
	Tue, 30 Apr 2024 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517271; cv=none; b=N8FxRduzBqQ3n8asAhabK8prOEHEij6QB/7EKvQEkzacWBMCf2m8ySEQxIscIp/drRuCShsnougKWgfz2IQxa7xx02temvFjg56VGVp0zt3L17gjza7v2JtJrlNOsTeUXzzrZZmEgfcN99jx3wYihUUDEcS3HU8P0xv3AXI/1sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517271; c=relaxed/simple;
	bh=Xf1USnpa+XulFv5ihPzHQ7DFNr0IQIkYHoRSqyKtXYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vBz4xcTFwvSUtSYKqziSbWimyeZudZY1EKN4P91SbcTrxbqQO0aNcRqWOb+J8FhXxx6OWQmdHXNOqMI4EfwnxpkNMkVnv7EVVYq8ZRV5xT4rE6wPu8aVisEeMKzmYCrXptDilFcLsWUnKSkUkxoBfQ12JYIXMnZjwe0aKxB+DD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/p/LN6m; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b79451153so35799805e9.2;
        Tue, 30 Apr 2024 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714517268; x=1715122068; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LwLXBBE4pvLhRvTjhhSvb5mOa3D+9/x3yL6AwSTANHc=;
        b=X/p/LN6msEzhBM7eKgizuWYgWolOBMyvKW5wEb4rny2n4aQt/Qt64DexP8WYPNeao3
         aKtIfz/kBDsqS5majpCH4jaPRFnNz6RwPQQy3C6tUw9spHKWcyaDmxVJPjKdsQmZP0Ef
         fRiuN93C2Vy/QxB9gikowdR1O30pG1T4ynA2PvEgL00NPBqSt7fKgjO1hqne5EeRPxtz
         BgrgBJ9o3TUe+KhzKjP4yRpe/o406zW9pvCvsEIHr/x7chCg5rA+IHY3OASGoz0ptm76
         Du2/odjPmx2FU8YKcE6j8D4DtRtTn93DhWFStXa9mmHajb6TS7gzav/Xjj4+GpBp1qY5
         dPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714517268; x=1715122068;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LwLXBBE4pvLhRvTjhhSvb5mOa3D+9/x3yL6AwSTANHc=;
        b=ERqAJrThUx/39+ra3JAGq0SiWEnQWYthOZW4cfz863BVIte4y3OeqkJ2jxdNeUXFww
         mrWqL1R2N4xyd8ZX2hAnyz/F78Yz3FpMIVVpQd3rGJga3FN1xjLUVREQImpAGDTj4gnQ
         tLrz1mdyH+EbphO1bgnyCIxXTFco3DZMEqxuL5VCSl2jJJ7ip1cM9TJHsmQX+a5kvTI1
         f28VSq7zJh69r0JFmGjVnX3yOTC8Tfr2HH4AM7JfO3j06ORMRPkyQii3Vx5u0G1UDWY/
         tTBQpaQLkO+F6AtcW9KapS3yNyjuTcOlnvMzhoCBdpaVKjGH52sqmwDyoRNbBsvBJnqG
         CGgA==
X-Forwarded-Encrypted: i=1; AJvYcCWUJ/F9zZ9TnFLDvyl/+kAVAjvU1DbPcT4J3cb/JkQEOVfVuFuyhbltPpqvKXMN/863T/OFHwnMlrqhzbjGdIFmwUeGPcdYNQ1FWlI1PvOy7CKntZtJq6zSipjMnM52IR05pKvdXfS2DQ==
X-Gm-Message-State: AOJu0YyRYOzVEr7YYXKOz5LoXtpcrxht8n8h+nJjD1VcL2bg3auLuCZq
	PrpFOiyoRscZ/a/FnzTADnMBQvkYQ/ZMtJPbEab7/DilqdcVypJoj13vsK8=
X-Google-Smtp-Source: AGHT+IFZ+EG9xO7FSqVB3P83XoF9qwG2Z/VBZa5s6o5fCwnCylbFvB7KIjK23V4zkJhv722/Bn81Fg==
X-Received: by 2002:a05:600c:3ca6:b0:41b:cb18:e24b with SMTP id bg38-20020a05600c3ca600b0041bcb18e24bmr571533wmb.9.1714517267718;
        Tue, 30 Apr 2024 15:47:47 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c4e9300b0041bab13cd60sm297610wmq.3.2024.04.30.15.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 15:47:47 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:47:45 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: leon@kernel.org
Cc: jgg@ziepe.ca, wenglianfa@huawei.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, lishifeng@sangfor.com.cn,
	gustavoars@kernel.org
Subject: [PATCH v2] RDMA/core: Remove NULL check before dev_{put, hold}
Message-ID: <ZjF1Eedxwhn4JSkz@octinomon.home>
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
Changes in v2:
  - Merge two previous patches into one as directed 

 drivers/infiniband/core/device.c        | 10 +++-------
 drivers/infiniband/core/lag.c           |  3 +--
 drivers/infiniband/core/roce_gid_mgmt.c |  3 +--
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 07cb6c5ffda0..55aa7aa32d4a 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2174,8 +2174,7 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 	spin_unlock_irqrestore(&pdata->netdev_lock, flags);
 
 	add_ndev_hash(pdata);
-	if (old_ndev)
-		__dev_put(old_ndev);
+	__dev_put(old_ndev);
 
 	return 0;
 }
@@ -2235,8 +2234,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 		spin_lock(&pdata->netdev_lock);
 		res = rcu_dereference_protected(
 			pdata->netdev, lockdep_is_held(&pdata->netdev_lock));
-		if (res)
-			dev_hold(res);
+		dev_hold(res);
 		spin_unlock(&pdata->netdev_lock);
 	}
 
@@ -2311,9 +2309,7 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
 
 			if (filter(ib_dev, port, idev, filter_cookie))
 				cb(ib_dev, port, idev, cookie);
-
-			if (idev)
-				dev_put(idev);
+			dev_put(idev);
 		}
 }
 
diff --git a/drivers/infiniband/core/lag.c b/drivers/infiniband/core/lag.c
index eca6e37c72ba..8fd80adfe833 100644
--- a/drivers/infiniband/core/lag.c
+++ b/drivers/infiniband/core/lag.c
@@ -93,8 +93,7 @@ static struct net_device *rdma_get_xmit_slave_udp(struct ib_device *device,
 	slave = netdev_get_xmit_slave(master, skb,
 				      !!(device->lag_flags &
 					 RDMA_LAG_FLAGS_HASH_ALL_SLAVES));
-	if (slave)
-		dev_hold(slave);
+	dev_hold(slave);
 	rcu_read_unlock();
 	kfree_skb(skb);
 	return slave;
diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index e958c43dd28f..d5131b3ba8ab 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -601,8 +601,7 @@ static void del_netdev_default_ips_join(struct ib_device *ib_dev, u32 port,
 
 	rcu_read_lock();
 	master_ndev = netdev_master_upper_dev_get_rcu(rdma_ndev);
-	if (master_ndev)
-		dev_hold(master_ndev);
+	dev_hold(master_ndev);
 	rcu_read_unlock();
 
 	if (master_ndev) {
-- 
2.43.2


