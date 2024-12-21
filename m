Return-Path: <linux-rdma+bounces-6691-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC49F9DC7
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 02:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4871E1892E71
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 01:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A97DA73;
	Sat, 21 Dec 2024 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="r8mlntAC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3283288DA;
	Sat, 21 Dec 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734745233; cv=none; b=DhzhKW5FutjoXfnXx9DWjBvoGm5RsHD6wlknJxOZjvO2uzQuKjxxssFUMjvrFuuZYrGzmrePfuZREiELQYTZHihE1snlFhm/DKb00nDvVsq7m5oZABhJnchp33sHOy52oUUawWnJabWIgy6JBcU8loTdxyhpbjcYvKxOinPDl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734745233; c=relaxed/simple;
	bh=t0wSe1vEXTJT7CrxQB22YzkGBxglSvHD+hEM7MF90EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXxAuKMuBBhMbfpuV1AbU4042rgk5rXPOey5jGZq2GsWxU7mU4IgXV27QGzJK+RnPm+pace2znG07X1Ji/kY/fqcI1QKI+iB5wrX4RVaXkMqomjqrhtFZiGAH+Db24ARlF8S4+6Mw18PiKAy24vcbJjoocZdKSB+UNx+DhKvbJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=r8mlntAC; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=xBXnrMAGGAq3U5kaAcYKfGNI6duVEzIOO8CBeqvWFAY=; b=r8mlntACvuwjey8r
	MpHaX4/6nsIj8Idkgx2IWxJRktOpTbQdVOpwj0yxXITDhLUy+doVDtOo/kXhZNfqJfVc966uIE0yW
	vjs2U3NkjO4I1+NG1+LZXnI6j9OBItp/rtweV/NdJRWs4x5QjQsAola7y8RnEQD/zAcxnckM+MdDo
	7Jwdv+beyDJpUUntNbUwiB87NBjTPoAAYTEydG9Q3mGw1ipPK2vyFc8sTH49itPwcod3ELltCiQGd
	xECN4sLYCm1gyZqqElllxKXN3BFPc3PpjF4IDr8taq1HCZdq1msXu6zcIDTW/4Z5ZXr+eb7dP0wtq
	NWXlBcUPMaVsDz0EZA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tOoTk-006dmT-1k;
	Sat, 21 Dec 2024 01:40:28 +0000
From: linux@treblig.org
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/4] RDMA/core: Remove unused ibdev_printk
Date: Sat, 21 Dec 2024 01:40:20 +0000
Message-ID: <20241221014021.343979-4-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221014021.343979-1-linux@treblig.org>
References: <20241221014021.343979-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of ibdev_printk() was removed in 2019 by
commit b2299e83815c ("RDMA: Delete DEBUG code")

Remove it.

Note: The __ibdev_printk() is still used in the idev_err etc functions
so leave that.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/infiniband/core/device.c | 17 -----------------
 include/rdma/ib_verbs.h          |  3 ---
 2 files changed, 20 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ca9b956c034d..a74e192b5588 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -209,23 +209,6 @@ static void __ibdev_printk(const char *level, const struct ib_device *ibdev,
 		printk("%s(NULL ib_device): %pV", level, vaf);
 }
 
-void ibdev_printk(const char *level, const struct ib_device *ibdev,
-		  const char *format, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, format);
-
-	vaf.fmt = format;
-	vaf.va = &args;
-
-	__ibdev_printk(level, ibdev, &vaf);
-
-	va_end(args);
-}
-EXPORT_SYMBOL(ibdev_printk);
-
 #define define_ibdev_printk_level(func, level)                  \
 void func(const struct ib_device *ibdev, const char *fmt, ...)  \
 {                                                               \
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3417636da960..295c394ffb48 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -59,9 +59,6 @@ extern struct workqueue_struct *ib_comp_unbound_wq;
 
 struct ib_ucq_object;
 
-__printf(3, 4) __cold
-void ibdev_printk(const char *level, const struct ib_device *ibdev,
-		  const char *format, ...);
 __printf(2, 3) __cold
 void ibdev_emerg(const struct ib_device *ibdev, const char *format, ...);
 __printf(2, 3) __cold
-- 
2.47.1


