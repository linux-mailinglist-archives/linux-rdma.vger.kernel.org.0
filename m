Return-Path: <linux-rdma+bounces-4456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97935959A7E
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC01E1C21703
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23421C4EF4;
	Wed, 21 Aug 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="igy5NGVZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FDB1C4ECE
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239403; cv=none; b=OwFDuEyfxPQySSOTXckmAovI9EPybNnPKjsPXnhnbRZ0sqMOgR1LsY0gGK4TtALm6WhXH+yb28KdApDiJ1IxsqMb1t1l+DFui0Gjj+6viqJY7nLhIPKsEgCy0JDV89GK3X3DH4Tyo7Xgxk2JJzmehVfZEfXXXQ7xdoH7qouK5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239403; c=relaxed/simple;
	bh=r4XLSg/aoYdYcbzTL1SRlVWjZce8no+6qF2vTB5o4I8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDK7luUb6rHzQ7iguV+16Sz6mJuZiE62uthTYwCX3vcUaMEIUjZhW3/dz8pbTsLCVNsha1koeppwSbWatzzzUbn87H0tLeMgZibGKuwL8VAzZ8dtiIerC47/ML+uNGIF1n3kp6rrKw2av1zW1CM5Mxuy/VhMBb/P8Q0FD4RX4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=igy5NGVZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7aa086b077so682958766b.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239400; x=1724844200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx7gqp5M1vTXN5tlxGBDKn1NzWyNR+YNEd/cHoZlL1U=;
        b=igy5NGVZlTzB7eYg0d3C8EOwaUkOx3H+5YvVmsw3cha9Nobj7KdWKhRPQF/Hrj6qNm
         N3dvkw9qnrVnpDL3lCHrUNzQhleDxVGRoPyQ8wpbn77OnLBfpFBPk8HZm0cn/ONkOZ6o
         T0rNBYG3R7GJu/YLNdiJ5wikSQxZHTD3swhGF4NV/sb6Z46WtD1D3KKntvApoc+aguI6
         ia0HdEGcuMW6AdLWj2z3O/FVbXZf9maYaan3OPe6YA9LDwizFzUZvfrRKiDLp7LRAWr6
         SBsiA4pO7TNxncG+ihgcmhaYIpskr9XvaS1Qb4c17CKHXSedrx3Szk+GHYKNAU2K9xWV
         6ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239400; x=1724844200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fx7gqp5M1vTXN5tlxGBDKn1NzWyNR+YNEd/cHoZlL1U=;
        b=WqSJV0BUYC9JrYe+lAyVj2cM7pcCtM7BUrBP7dDyDavdP6crDIIt9NtypDF8Ncpk3C
         CEYN0yyuAiuxrqEz6bjXMBM5nNXhfFrARcms5LR04Qe2H0FaNzuhlyGzi15bZWiRX75B
         /dS6LbYN+obvnJbgZw6iSHTblLH1VQu+helTAeUNwu3rC/LM/6a30QR7DIkOobjWeraG
         0+gN6u19YEkGpmHdzZyoBYackFVp41zHfRn5LZwH3EnIgHmbRAYIvCr8wsc091gpkW8u
         psmH2s3ODiY+Gr3zuJSlKxpGCIXVtKZfcQU6LqsrTmSClY6VYzZJWtiln0tHqK/6NZ4n
         DdlA==
X-Gm-Message-State: AOJu0YxLC2QSlA7vcj/mxUeV197M8ICsjWsQsRvJqCxjGdTTGJMkw/zC
	w2nqaG/oBOodlpy2DSkz/5BseJrBjLucBLx8GQVU+Lm0Fn3r/URspOy1eFFQpuNHcwPxTWs0PEf
	5frc=
X-Google-Smtp-Source: AGHT+IFHmMTOF93YmzhXM3930QSYwL2ehrLDW7HclzipsPwBFtzXLRh+iLKrgKGe61pw28WC6nRg3A==
X-Received: by 2002:a17:907:7212:b0:a7a:b070:92cc with SMTP id a640c23a62f3a-a866f8f45bfmr110236366b.45.1724239399656;
        Wed, 21 Aug 2024 04:23:19 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:19 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 05/11] RDMA/rtrs-clt: Reuse need_inval from mr
Date: Wed, 21 Aug 2024 13:22:11 +0200
Message-Id: <20240821112217.41827-6-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821112217.41827-1-haris.iqbal@ionos.com>
References: <20240821112217.41827-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wang <jinpu.wang@ionos.com>

mr has a member need_inval, which can be used to indicate if
local invalidate is needed, switch to it and remove need_inv
from rtrs_clt_io_req.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 18 +++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 -
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index c1bca8972015..e1557b0cda05 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -355,7 +355,7 @@ static void rtrs_clt_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 			  ib_wc_status_msg(wc->status));
 		rtrs_rdma_error_recovery(con);
 	}
-	req->need_inv = false;
+	req->mr->need_inval = false;
 	if (req->need_inv_comp)
 		complete(&req->inv_comp);
 	else
@@ -391,7 +391,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	clt_path = to_clt_path(con->c.path);
 
 	if (req->sg_cnt) {
-		if (req->need_inv) {
+		if (req->mr->need_inval) {
 			/*
 			 * We are here to invalidate read/write requests
 			 * ourselves.  In normal scenario server should
@@ -494,7 +494,7 @@ static void process_io_rsp(struct rtrs_clt_path *clt_path, u32 msg_id,
 
 	req = &clt_path->reqs[msg_id];
 	/* Drop need_inv if server responded with send with invalidation */
-	req->need_inv &= !w_inval;
+	req->mr->need_inval &= !w_inval;
 	complete_rdma_req(req, errno, true, false);
 }
 
@@ -961,7 +961,7 @@ static void rtrs_clt_init_req(struct rtrs_clt_io_req *req,
 	req->dir = dir;
 	req->con = rtrs_permit_to_clt_con(clt_path, permit);
 	req->conf = conf;
-	req->need_inv = false;
+	req->mr->need_inval = false;
 	req->need_inv_comp = false;
 	req->inv_errno = 0;
 	refcount_set(&req->ref, 1);
@@ -1140,8 +1140,8 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 		};
 		wr = &rwr.wr;
 		fr_en = true;
-		req->need_inv = true;
 		refcount_inc(&req->ref);
+		req->mr->need_inval = true;
 	}
 	/*
 	 * Update stats now, after request is successfully sent it is not
@@ -1159,8 +1159,8 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 			    clt_path->hca_port);
 		if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&clt_path->stats->inflight);
-		if (req->need_inv) {
-			req->need_inv = false;
+		if (req->mr->need_inval) {
+			req->mr->need_inval = false;
 			refcount_dec(&req->ref);
 		}
 		if (req->sg_cnt)
@@ -1236,7 +1236,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 		msg->desc[0].len = cpu_to_le32(req->mr->length);
 
 		/* Further invalidation is required */
-		req->need_inv = !!RTRS_MSG_NEED_INVAL_F;
+		req->mr->need_inval = !!RTRS_MSG_NEED_INVAL_F;
 
 	} else {
 		msg->sg_cnt = 0;
@@ -1269,7 +1269,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
 			    clt_path->hca_port);
 		if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&clt_path->stats->inflight);
-		req->need_inv = false;
+		req->mr->need_inval = false;
 		if (req->sg_cnt)
 			ib_dma_unmap_sg(dev->ib_dev, req->sglist,
 					req->sg_cnt, req->dir);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index f848c0392d98..45dac15825f4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -115,7 +115,6 @@ struct rtrs_clt_io_req {
 	struct completion	inv_comp;
 	int			inv_errno;
 	bool			need_inv_comp;
-	bool			need_inv;
 	refcount_t		ref;
 };
 
-- 
2.25.1


