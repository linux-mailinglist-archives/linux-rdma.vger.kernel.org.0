Return-Path: <linux-rdma+bounces-4281-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3138894D0F7
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B1D1C21503
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73E195808;
	Fri,  9 Aug 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dQGgpISO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5B195B14
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209363; cv=none; b=FdxfLbunFkMuhiwMbErnwZTc8nwkGAYczvg3qVfTtF2nPU/jOhQd1VI2Zey1VucMKmc3EFQYoUhnOKx8PZn2QUHnILnCRcYCwnyzq1M+/R7YxkjcMBYnzLLoDLHKcRfQQ3WqzYJMLMapAnQfEZGqtV0YHYRX6JJN8B9+Disct4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209363; c=relaxed/simple;
	bh=E4Tkz+NNXf0Rqt+KeIW7YV0+OPjkqtWHuBsqB6QLKqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZhpPWh6dlq9cDb75RLD/dgJqV1PXvQfVTYSpEtOax0WNgWLAF3WojUcAU+yTTCSPoS45iR5y4PzWR54i/V6Y8LUNo1Ys0mvZAFYuwiLYuVn0Lttgg0BZxb4h/2VH5/omhNXp6tPV2ZMWDOIA3TF5Cr/kAQ9H+kIy0T0maTYadi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dQGgpISO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42819654737so14980215e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209360; x=1723814160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC3jHGsjdZENIhkaZnf9KhbQHlXlkHO+680dBNxyyNY=;
        b=dQGgpISOBVYhG21pCTlGvvG9W4gi2GC8NUUfAWX03NtxIECxc0Oo+mNt6mz757WSyi
         ErtLBkr+K+vtuBFMr7t2sruqfUbOyHXWrJ8B6NhCs0SHfXVIdnce8O+VvzAkLZdpDF+K
         NKoHJ7KmlgupjGhD6f9AZj9uCC+wBBCJM98OZ+ZWIXWIBcvTG3LIRLI9CgG51WNr4CAD
         lcRud9eo1vHmDzCftntK1h9X9do7xtnaxlq/UvXwhcOQRKSnwprfXfbzUMK1o4oQmWzF
         mP0nqxXAblt+RlpsnzvgWjYomlHsLAs4HeBvZ06CymS8/gR8CN+Js0bV/LvGc8fMzXgw
         XM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209360; x=1723814160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HC3jHGsjdZENIhkaZnf9KhbQHlXlkHO+680dBNxyyNY=;
        b=AvrhT7LRIR+k1sMi0X/Eu9MNnX2rwpqk1zrt3eKCOuWYR56KyufqWvKUAZXRhkTL1O
         jhh96Dd/APqHJ2BrtsY183wMmm8y3l2qJBETBb8UGS6WMNmjzXe3HVN7egpDdc34VbVK
         6KTq9tx30nq1TuMlE0rKTk9CdVPKmmFXfQ4opIJk6ecvw/PGINsrrWhrksGltt+tAA6J
         mwM3Hd8ia/rfLhhRfVutqql0/mfaTmr4ReZge+OvFdu7orMAai/QMj3tKuNout5ojim6
         8H45ovxN9x0gaQuxz6lpZtVdBYBiOcU/KzKtCIxv++Twgvi74b+7SAyIt2H7CTCY+JTc
         VMCw==
X-Gm-Message-State: AOJu0Yytq+dqR6BCbgXeGFMnOdHsoW6BzZvBP9T3jtoNYYT9EUP/w6mS
	siyAUbKzAYId+JFlHTlL+X+r2hK5k9NxJK6craKv5IJXH3QOvAa3Of6L2+PLbd94BgAc98Pe244
	SC9A=
X-Google-Smtp-Source: AGHT+IEc73iMrGKwQUVryFXUYxjrirSmpfWGiigM84auD1QPv2kqKCqJhr3GXkbxTx7DWUTv6ae4XA==
X-Received: by 2002:a05:600c:198a:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-429c3a19090mr11497105e9.4.1723209359798;
        Fri, 09 Aug 2024 06:15:59 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:15:59 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 09/13] RDMA/rtrs-clt: Print request type for errors
Date: Fri,  9 Aug 2024 15:15:34 +0200
Message-Id: <20240809131538.944907-10-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809131538.944907-1-haris.iqbal@ionos.com>
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@ionos.com>

Extend the output to print also the request type.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 777f8e52ed7c..7c6d40380638 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -439,8 +439,10 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	req->con = NULL;
 
 	if (errno) {
-		rtrs_err_rl(con->c.path, "IO request failed: error=%d path=%s [%s:%u] notify=%d\n",
-			    errno, kobject_name(&clt_path->kobj), clt_path->hca_name,
+		rtrs_err_rl(con->c.path,
+			    "IO %s request failed: error=%d path=%s [%s:%u] notify=%d\n",
+			    req->dir == DMA_TO_DEVICE ? "write" : "read", errno,
+			    kobject_name(&clt_path->kobj), clt_path->hca_name,
 			    clt_path->hca_port, notify);
 	}
 
-- 
2.25.1


