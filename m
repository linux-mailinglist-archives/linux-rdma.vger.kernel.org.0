Return-Path: <linux-rdma+bounces-2181-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3748B8318
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 01:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41F0B213D1
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 23:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5581C0DD7;
	Tue, 30 Apr 2024 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVBxbu0m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB271C0DD3;
	Tue, 30 Apr 2024 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520808; cv=none; b=RxVRdcIKT2WE9WDBPjN0ov3MsSmZ2LvhmZQT6hwJTy8yWFZvKgTmU99sp6lHeMPeZtdRfnzr4T3263FGu0v9owbptZ7LHs3SnnvYhW/InPIyyzRPOgkC+15Fj+NmmxTpxn/iqpF2SJNDqhuOwvPDvGqFMGw2lca/d4sf5x61P54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520808; c=relaxed/simple;
	bh=5F6ZplCAmEgFgPquJv3INfjuKSpwKrq4QVtlp6h2kDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hYPlNb6eCHDvrIYsn2zDw6KO10P2Nn7lzgUTxNSBFbjBBfWEWLcu3/AFkW+mB0DgW1wOzBYD0riSp0KUmWQvYLevKtemN2jWmELjKDQ5ZYqgpKxcBeu285/d5pJsxUMEFxLymQagxJOF8t6YIzmTu3SD9tAwmLnB6Lw4aFxsOAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVBxbu0m; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e9so35573025e9.3;
        Tue, 30 Apr 2024 16:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714520804; x=1715125604; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PugqrNxdjGjwJFTS0LZE4hIzxF1okCPNtGWxtNNqIdg=;
        b=QVBxbu0mEFbVb0kkOKcNMaesSvD1Q1buvIWrVnsujEvDi8IdcbT4UmjjDz/K4R2KLG
         YaZ+Fh/LH5oe64TpXOlP/RD8D/Z8v3ioxVmhbbrTkF37OYho2b/8TSi1wmEOR6QamAas
         4YzP+ETxq5cO6Hryyx9GCal4tCaxhTtXXF08x+9I2YyxXJ7dTEhX9sTDtzbLHO8KM7sj
         AQO7F6wASGzfWJg0JuDrQ+oNsqXHnl+uPcxvGeiHdd2GBWywDUoF/T/c/K/LNcaWQUDd
         LCtYrtsjTNFAbgI4SnQWE5S506cL3/nr7TzFLTWQR1IJ2a+6wFZL9gWoQTAJdlXVEzFV
         Xv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714520804; x=1715125604;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PugqrNxdjGjwJFTS0LZE4hIzxF1okCPNtGWxtNNqIdg=;
        b=e0+Cjt7MrfK1sasrEr/HJUpz9mTHWPsl6CiQqRCaqd/xSEUzNvyC9FMLP1JYtka4gu
         hjyAjbJxOKFX3JX931wYuXidU5ARBrjRgV3/zfe9Pvj9ejCwCb05muvjPnXlaSf2Qc7t
         8fqQwl7Pgb8Va4kdAMDYW7Usgg2Wf08lccbOc3t9xNfMSJYUjnYV1iKw6Lzh+U7/kO1/
         jO/BnkaBSrwFqCbKMVvYkX1z+iOpe9hLJwVKTPujhrNfGnT3ojh926BeHoiwQyidnRyq
         ymVTGgaGBeuGTBe8My5ChBYYdJ2ox0qtQziyC3eLPexwp3wztdDFL6j5gRbsyg9JR07V
         EICQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVl5P8N0Y9TdDjyh00ZB4LTM+++A5YodYLFGVwHbLJSOMTu9onjkgKSUXYaWHipZwResRZM+DVSiFWrE/bRCtpDeb1VgyLR+RVi/ikzDq3nGWTk4aTt9tHjyHDmWZ/51oeX3OmIKOXzA==
X-Gm-Message-State: AOJu0YzLRf92/Ng91M12q889qjYG2KbwYc28Aqv5X74JIzy6SAyZz7jA
	iCbH7/FbXcV3+iCq3kaCqPqzr5aNALQM74TsQZj4Vd7zxW/x/SM=
X-Google-Smtp-Source: AGHT+IElrP2lP8H3vndJEd672Z13EkP893g0ErBLPvTJrVfJbu/vLqBmQR+FWKQyzvGXxGagblmd0A==
X-Received: by 2002:a05:600c:4744:b0:41c:11fe:4de3 with SMTP id w4-20020a05600c474400b0041c11fe4de3mr598642wmo.24.1714520804380;
        Tue, 30 Apr 2024 16:46:44 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0041abdaf8c6asm400181wmo.13.2024.04.30.16.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 16:46:44 -0700 (PDT)
Date: Wed, 1 May 2024 00:46:42 +0100
From: Jules Irenge <jbi.octave@gmail.com>
To: leon@kernel.org
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	lishifeng@sangfor.com.cn, gustavoars@kernel.org
Subject: [PATCH] RDMA/mlx5: Remove NULL check before dev_{put, hold}
Message-ID: <ZjGC4qXrOwZE0aHi@octinomon.home>
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
 drivers/infiniband/hw/mlx5/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c2b557e64290..2366c46eebc8 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -264,8 +264,7 @@ static struct net_device *mlx5_ib_get_netdev(struct ib_device *device,
 	 */
 	read_lock(&ibdev->port[port_num - 1].roce.netdev_lock);
 	ndev = ibdev->port[port_num - 1].roce.netdev;
-	if (ndev)
-		dev_hold(ndev);
+	dev_hold(ndev);
 	read_unlock(&ibdev->port[port_num - 1].roce.netdev_lock);
 
 out:
-- 
2.43.2


