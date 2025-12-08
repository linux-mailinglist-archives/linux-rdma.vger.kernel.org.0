Return-Path: <linux-rdma+bounces-14930-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E81CADB7C
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 17:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E58223069573
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803EF2E54D3;
	Mon,  8 Dec 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gQFowxBo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967B2DEA75
	for <linux-rdma@vger.kernel.org>; Mon,  8 Dec 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210527; cv=none; b=dL/y+g5cRzEkKTqXN5KMsV8lQRaVPy4XZgbn1UHgabKgEcud7mzhOnj6UBWtIGauDWPqTIH+iOtOINdGLwt/JDQgxHqajFmScgeKO1sUmt3scow9ZkrV2wbLp89bCr4Q4D9Xe8s8OLghhNO5iOHDA/asjHSz81DZgsvhZIZhrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210527; c=relaxed/simple;
	bh=VPJw5gs1r60iEXHKocCd7mik0ogylUc8xYNWUWNiokk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDSKpQ0Un9wO8LPaehn0eOJLytgc2bmGfF3Q5kIgEwZ+eDrHTYEfGZV/HC/UwqM0WHO/UV+Ei+fEG9uwnOe3m4/CuanJvxDF4l57zpu/Lqw2Nc8h6vXk+vqGqF+dswUfxAw3O2Df5S8keR9107Ynw+YUbrA1LIMqSDZJYqYw4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gQFowxBo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a1c28778so60304545e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 08 Dec 2025 08:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1765210523; x=1765815323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37iB0EG6XRA5V7IqK1AWSgOjToB0Zwczz4BZDa5bJ8Q=;
        b=gQFowxBom27Ad2Fq/kBj4/3sHmoG7ofPWvjGEk3iVsyKElebI9E4nlM7XW+zhsFL4t
         c0c97DXByoG0z3V9BNQRFljJvjTk0t2GuEodXSMumTib80zMVwRVyDmHIG7DUn7fjfox
         f0j3ZfiA/wuT4vfpmAnWGXc3bfNbcsKHZTLtOqBJDdxOSLIJ12CBHjJHMmuyqRTs+iYP
         8WvOoxHOJF6qqakNtyzq0AH/6PgyP6GpD03NAp6z19PLXJhFfIZASNtuxJESV6XTppVE
         eLSKt5DhzNY+QAmGUo1Y0z5eiYm8Tj1QpPvM3uG8mOxstQ2HwjIUWBGYk8QGlePNgn7A
         c8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210523; x=1765815323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37iB0EG6XRA5V7IqK1AWSgOjToB0Zwczz4BZDa5bJ8Q=;
        b=m/X+4Bk/+0R+rWvbh+i55miuFzcz2mGZeVLBGP9DbsE7Jrkx7JB8rQnyjSlGcabu+v
         ex4d+5E+Ug6TPVbfUdlsHgXbbTcvuxyg5TiTO5M83lptL3tAzhMPJHjH1RdLLGybEdvt
         ld1baZRAhK3WT7sYnBmTnvNcnQ57S054jVQoRe2mJM6IEEaRjWPDmAu0bMhSvZ36sDRP
         Tzt5sJZujkYHOKiV75O9sdi/JmvgNl+cqAcP6mFkNfp6xm/WodnFuxJf23AijhiFl+fl
         624tWoIfAIItVsMuGFqeDffgklUIU2HFD5rG3dWWGvATEyF0pBQp5UsPHewdfV0HcxZa
         kxbw==
X-Gm-Message-State: AOJu0YxAuhMvbK9GlAzeg2I/Y01Cxo4A9gckmOa0bbkQAWJ7cBR6vBjQ
	+Jk0MJBlLCtnAkZ6FoY4uI3ieSiHT7MzvEWKmckJPW2pn3VZOzj4tHwHSGf0sV2hr9Zff8bJ50v
	ixGdd
X-Gm-Gg: ASbGnctWe/ufYFI/KLwpCjWczZNdFjnA6QqcHtomqO+G+VJFrYDwPfY5VxGA4rx/NLz
	Hu1j7n4lMrhbSWdIWiBuF+dlKhxj9qD6xBDhtaRIJlA5WGrVz8u5QgjKk+TXghfazHlFrhNUQdI
	T7A0F8UFqWvJpqAQaW7RMyuwIRFYE25MROz5VQ/h0uVxovxIJJq+oX6AFyjvLIkkg00UoLIuEqe
	CLU2F2P0gJ4zUJXqi9BVMeeAiqxVIg/38Q+Hc4tlwVwumNjc2f0mW4drTRLIfSeIdxLuVZJp7cW
	Any2/Vp3kWROssYIUemAvHEVyGxwzwalZ6cgBQheT0LcfFEQ57K65L4zHzORaviycnEeKBFjIA9
	ScwbCymZExrOKE447KFIJrJg4o1+LAgfCfUbmZNPfHm0lJKLS7HNM+z94U79wev8YHjjVIu7S60
	lff8h6EE/iaDHv0/G3qQZcw1lk5pR2yK9G2HFrw0LwOmrk22I7ucwMcgWvtsd0p1N3GugLdQYAb
	vlf79uOdCJze0dmE0q4+ogizNHmMXItHa0=
X-Google-Smtp-Source: AGHT+IGrmtPrbRUhzP7DXwRvJlKRmQAsKTJ2bZz36QLcM6+kddldx2OoJiOlfLEib2q2jeQKNs7RFQ==
X-Received: by 2002:a05:600c:2313:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-47a179c27e9mr52101795e9.20.1765210523125;
        Mon, 08 Dec 2025 08:15:23 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net (p200300f00f28af1ae57f1d6cbb50b9bc.dip0.t-ipconnect.de. [2003:f0:f28:af1a:e57f:1d6c:bb50:b9bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ed466sm245275655e9.13.2025.12.08.08.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:15:22 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: [PATCH 8/9] RDMA/rtrs: Extend log message when a port fails
Date: Mon,  8 Dec 2025 17:15:12 +0100
Message-ID: <20251208161513.127049-9-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208161513.127049-1-haris.iqbal@ionos.com>
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kim Zhu <zhu.yanjun@ionos.com>

Add HCA name and port of this HCA.
This would help with analysing and debugging the logs.

The logs would looks something like this,

rtrs_server L2516: Handling event: port error (10).
		   HCA name: mlx4_0, port num: 2
rtrs_client L3326: Handling event: port error (10).
		   HCA name: mlx4_0, port num: 1

Signed-off-by: Kim Zhu <zhu.yanjun@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 +++++--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 49249cc24152..dcf5704366eb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -3179,8 +3179,11 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt_sess *clt,
 void rtrs_clt_ib_event_handler(struct ib_event_handler *handler,
 			       struct ib_event *ibevent)
 {
-	pr_info("Handling event: %s (%d).\n", ib_event_msg(ibevent->event),
-		ibevent->event);
+	struct ib_device *idev = ibevent->device;
+	u32 port_num = ibevent->element.port_num;
+
+	pr_info("Handling event: %s (%d). HCA name: %s, port num: %u\n",
+			ib_event_msg(ibevent->event), ibevent->event, idev->name, port_num);
 }
 
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index dfe38ffc2e38..301edaadfb1a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -2349,8 +2349,11 @@ static int check_module_params(void)
 void rtrs_srv_ib_event_handler(struct ib_event_handler *handler,
 			       struct ib_event *ibevent)
 {
-	pr_info("Handling event: %s (%d).\n", ib_event_msg(ibevent->event),
-		ibevent->event);
+	struct ib_device *idev = ibevent->device;
+	u32 port_num = ibevent->element.port_num;
+
+	pr_info("Handling event: %s (%d). HCA name: %s, port num: %u\n",
+			ib_event_msg(ibevent->event), ibevent->event, idev->name, port_num);
 }
 
 static int rtrs_srv_ib_dev_init(struct rtrs_ib_dev *dev)
-- 
2.43.0


