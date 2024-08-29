Return-Path: <linux-rdma+bounces-4642-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A03964AB8
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 17:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F3E1C24607
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623D21B3758;
	Thu, 29 Aug 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BoG46FeW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289361B1D7F
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946911; cv=none; b=QNEO4QH6ppfYu85qqb5Jb7NgwltpBBw3bxG+UEjb4gqf0Ci6nnPt/Kep8hYUr93diQMC4i1hZZx4bZCMcgb+L6a+TpOgervYeN0Cek611fzSBTKKt6sI22AKGvTUWHa9eYHhlsbfrPCw45JV1XOAeo9XIY9FLoZEveu5/XXeQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946911; c=relaxed/simple;
	bh=L221gx8TMVtgUhpzyJXv+niB3Ixc62z7WLWBuVAmB1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p/E+Nkgrkkq8wpYREo/1iW1KaLXnB19vWAaqVN1k0vlEqjP7ahDFw1ZIVXsw+i7nBhM5ISnnezoG2211H+sfVQ0BmmRURXbMlosjKflnkaCYvVdK1mVq9XybsL8MXqCoC+T7NrzQMtSw9vuc3jwek0tk5ogguybrWZldqvByjsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BoG46FeW; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5dcd8403656so549324eaf.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724946908; x=1725551708; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66WM3UKiAkh51wtV1SpgB1n6RvJTxOU2qjO0gblS3oo=;
        b=BoG46FeWKecoqGSIAWUOFpTu+OpNMzH8QCZ3fJr0lWy51hHeF5uPctg8wvnobNpoEf
         oj/VWngq2DN2TNBnl6u+YzLwrQ0vaFM8gJzF5dRmjMa1yt+1UL1ovvOYJmXRa3sUCjem
         44kfb3kIduTg3ipvMUeWsLOC/AXe4uJmTNynI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946908; x=1725551708;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66WM3UKiAkh51wtV1SpgB1n6RvJTxOU2qjO0gblS3oo=;
        b=K0L/QxRK68pCrrRIfXhgA0UDSSedvZHxL47hQ7BDgwkhTsgMj1K7xA0hDBDzx5/ID4
         Xa1GTPQgPzequvh5hOpN6zQ3P5l/YqNpcCxVrMCab7xbCRohFWFbCgyhCnkf83OksACl
         /bIEUsPGX/4whQ9umfJG2FSgCrXK3DLiAmAQvula/63KhGZBzJaNmFoBf9qfTm6C625k
         7tuhkOn22m19ezd2phj/cQhKXY8966mscnIgdxExkB4iswGhL/W1aPuSJcGSnHg/sIAG
         gRxZm4V0Y8BnPisosL1IX1x9nNMKd0f2G8/VTFiPCNtp4OKQxtj7Fp80wlp2cjGhe4KU
         5/jQ==
X-Gm-Message-State: AOJu0YyHQs+/0I3s5Rc2h3L8mLvmt1exaib8VlGCSkxGqwCmvXYLxV4b
	QtDmX3J7CgJtoabkYruHxU6I6+reWUdM8uWS5LjwgFfDh6C37UtzYwTx1Ty2LA==
X-Google-Smtp-Source: AGHT+IHwtgASzziiFNYhFFV5N8cyl8+K+/7meuN3ZCgSR2fN+h184jzWDUn5QgNPe1tyavuyP8vpsw==
X-Received: by 2002:a05:6358:61c2:b0:1b1:a810:85a5 with SMTP id e5c5f4694b2df-1b603c29ee4mr440469255d.12.1724946907997;
        Thu, 29 Aug 2024 08:55:07 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be627sm1396735a12.57.2024.08.29.08.55.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 08:55:07 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	chandramohan.akula@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 2/3] RDMA/bnxt_re: Refactor the BNXT_RE_METHOD_GET_TOGGLE_MEM method
Date: Thu, 29 Aug 2024 08:34:04 -0700
Message-Id: <1724945645-14989-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1724945645-14989-1-git-send-email-selvin.xavier@broadcom.com>
References: <1724945645-14989-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Refactor the code in this function to have common code.
This is used in subsequent patches.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 43a68e7..1e76093 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4494,12 +4494,12 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 	struct bnxt_re_ucontext *uctx;
 	struct ib_ucontext *ib_uctx;
 	struct bnxt_re_dev *rdev;
+	u32 length = PAGE_SIZE;
 	struct bnxt_re_cq *cq;
 	u64 mem_offset;
+	u32 offset = 0;
 	u64 addr = 0;
-	u32 length;
-	u32 offset;
-	u32 cq_id;
+	u32 res_id;
 	int err;
 
 	ib_uctx = ib_uverbs_get_ucontext(attrs);
@@ -4512,21 +4512,17 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 
 	uctx = container_of(ib_uctx, struct bnxt_re_ucontext, ib_uctx);
 	rdev = uctx->rdev;
+	err = uverbs_copy_from(&res_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
+	if (err)
+		return err;
 
 	switch (res_type) {
 	case BNXT_RE_CQ_TOGGLE_MEM:
-		err = uverbs_copy_from(&cq_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
-		if (err)
-			return err;
-
-		cq = bnxt_re_search_for_cq(rdev, cq_id);
+		cq = bnxt_re_search_for_cq(rdev, res_id);
 		if (!cq)
 			return -EINVAL;
 
-		length = PAGE_SIZE;
 		addr = (u64)cq->uctx_cq_page;
-		mmap_flag = BNXT_RE_MMAP_TOGGLE_PAGE;
-		offset = 0;
 		break;
 	case BNXT_RE_SRQ_TOGGLE_MEM:
 		break;
-- 
2.5.5


