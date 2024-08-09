Return-Path: <linux-rdma+bounces-4279-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 251BD94D0F6
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA171F2211A
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46DE195803;
	Fri,  9 Aug 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QlKnVfX/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F7194C9E
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209362; cv=none; b=rQK3BtsaytpJYJQACDmzp6SoyiqZJ9K1CiSsc5R6YkVJqTSI71ahK6tVcKRXrLh9GCKwwuHBcZowen/RCNtMdx51dg0qd3NtAnfrmReImXLNdvCVoanNKPsBnTebCcMbWD+GTEqdmltAZZi2fyhcSRfgJRAaUNUMLXFMaRDCxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209362; c=relaxed/simple;
	bh=r4XLSg/aoYdYcbzTL1SRlVWjZce8no+6qF2vTB5o4I8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jkWusQDgprt2kNTt9Ep7/CI6EALGqKnzT/Fk2IOpFq0MuR/74Ro/iqLKTmM79So2pO3DEHsnhnhqENeCyv0bdLSC4YbA9F/Mn5YJCdBIhR2sQTboI8T0s4/Md1yZdmUvY13Pk15VErPmgaTKI/Gl6fimrgoAd7DNlHytEOHq2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QlKnVfX/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so26283421fa.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209359; x=1723814159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx7gqp5M1vTXN5tlxGBDKn1NzWyNR+YNEd/cHoZlL1U=;
        b=QlKnVfX/GWU51VDNjkCHvl1yG+rvD/rhReOZWLLEe8UB7Z2/Za1EGQG7UgVAyFWn6V
         gLvt5HG3OI4EbmD8Be2Ek1O/k3kP/kiLUN90pUOAbMm7xp1e3kB/f1o3eRPgTXD2WPnz
         WxirIKTwNVH2F1FVEqyStAiCSW0+KTpnKNc08z1IOI3uB302yGGxu210TmXtAwpDwSCE
         FqR927qYzeMu2HFhjQxrJcHVjHkT96fVfa/IPs4FX1jjToE3/6JpsKAArbv4sfnOcxYh
         e9NGTWbU/xJz2fqwP6jRHmKf4rJschaDTsr6lLt8LKgFjTd7zfTCye4uZfqQ9dNM2C18
         7GQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209359; x=1723814159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fx7gqp5M1vTXN5tlxGBDKn1NzWyNR+YNEd/cHoZlL1U=;
        b=mO6cuj+nb2Dkgk2tc0jleIWvSQTdDSLouW9WnWEhQpDP7JErL5RVJEFtzWVlrjhmmc
         3m86sAsB/akRGL9Vtkc7JrbflyGKoQzALfRGklAu//aZknZSZ3Ed5XMCuSa7U4R/VUhh
         v4Cp3mBzBhdJMceBU3aplzRRLFhKHRqiZ9f22nnrGM8JRIVQ7oHGCFuG9TTnKLlHcbfE
         SHvsQhrMkk1rmCkLqJfciuah5WKJZfQ5sZmqUcy10DawrxgGNyEIot4M2RB3Ty4PW25X
         qoY8Z5hyCv2U2wxHgtGonMgTO/AbRfdg90JagHCym44/vdpou7XjbOvvNliu/fKBp1sk
         xD1g==
X-Gm-Message-State: AOJu0YyQj3rCEDW4H0piz9hpkkE3q1QxV3ziqHHnKP/eKLOFuE/xG8CC
	ACHL6frW55aGnjdYXiKUpCs0EfW1ea61U0oCajGfjcWcqxp/j+Ghhx0cjAkdsTqo5GKf7WLWjwF
	EbIg=
X-Google-Smtp-Source: AGHT+IHO70Sk0c5LS7d0WqZAUkebEsmEGtfT7vZG+YoMiRmlorb8zoe+yJ6xdIWIfxTQV7KLHbo/2g==
X-Received: by 2002:a2e:bd13:0:b0:2f1:8624:a4c with SMTP id 38308e7fff4ca-2f1a6d037b8mr14594661fa.47.1723209358500;
        Fri, 09 Aug 2024 06:15:58 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:15:58 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 07/13] RDMA/rtrs-clt: Reuse need_inval from mr
Date: Fri,  9 Aug 2024 15:15:32 +0200
Message-Id: <20240809131538.944907-8-haris.iqbal@ionos.com>
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


