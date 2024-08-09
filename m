Return-Path: <linux-rdma+bounces-4284-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96B294D0FB
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B99B21EAD
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75197194AEE;
	Fri,  9 Aug 2024 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cUb83A4r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A7C195B37
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209365; cv=none; b=VRbfohT4qFTSQsu9BWm4dJ4DpRXt1kriY/IcB+OBG/kxyIjfU9jwr2nPEXUmWEbJ18WfIXX8TxZGqsBberT5QPG+Y1Xu4VtaL9exd9lun10ZGpCjy+IjGv492usC3PBhmxMnB5y4ET33NMOL0HV4eTQYGJ8/6wfk+k5YVCk1MvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209365; c=relaxed/simple;
	bh=xLcPXGIQYb8rDHlaDSABgBgt2ojUJwEMbr395zl0B7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PUyckA+4WLZICKmkWkKl1QEgkkDCnqbskZF56TgA496op5yiTSCTgYTcshiWf0/iNITMIk8wG+FHdkJurkNC6xM5kJ8Llgw9iElLHDOT6LW6DsNhRquY3uE26/MsRadfVqZcF5Zp1qtZj0MKx+JwP5UDGOJpkskSz5u/FX0Lwik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cUb83A4r; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428243f928fso19943135e9.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209362; x=1723814162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQMKt+Z6oU8k718oVYzHw1t/snarDjAZbdeYqhgVzX8=;
        b=cUb83A4rAOiQm508KwkecCsqgkqjNglwgH+U0ZOKuCMDpTDoWsLRXfSKjjPPFb4lHD
         A2sZXbyGrBabdnWtsvqOt5qx+cMGjhGASMP/puAKKNlEr4xqIer4NjjL6QwbNKlP3/Vs
         f+uEo8uXAb4b+wo/kdgf7wj8oRRzM6BZJLW4icUa/Yj1wisDSvLfPQXQIwv5MTGPtlA1
         HLHvW9Fux7ZgMdsMpbuNHz1+E6Px7eiLYYfYgXOq7lhmfqn6WGeXblvtrYbEq5r7CjIW
         aqXQx47q5p7oq4ZeAOoz/7JJso0Ky4tUvE+3esidn3l0ZWHr+q26799OAT7m0gfC3XyM
         3Hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209362; x=1723814162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQMKt+Z6oU8k718oVYzHw1t/snarDjAZbdeYqhgVzX8=;
        b=IzM39PxKyAOBCkmtcEjXFJXhE9h4EbcE62DJ66u2/aSxgPkJFegWML24vfKibX4hv3
         r08xlrbPE1zhE2iAHgGAdb6Dts2TEHQQ6PROLrrL44tMnNQYgAFttnTS1fgB8l9cSpeF
         KQURsMcWUBFbg5AaArThozM72lVhtQeNRJsvA0qUb02CkVekX6Na9dnVTPfpodOkL6W6
         ecnd1CFF02bcAhEOm03m5pCNgz893nYdheMZbPCgBX5zG9x3ZR7msfjshTuZuTjyO+D5
         n7r0/0UZRKME/kwyvfQLaoStiLv7vdFYZk1z0oXiLONuA7KAfEDRz5e9Cbq1U9vofmus
         Hsvg==
X-Gm-Message-State: AOJu0YwlTp5cDo59e/repJE5a7ppcc12xbX7YYFkzTgV9GYagjecR2Rh
	8VTzdcBzCoECl8yuw9K6aNXcyPCVkWX9rjOOPPF3biCQg2iBuPR7FWOVsv04oXNmdnRCmCgiIdf
	vYK8=
X-Google-Smtp-Source: AGHT+IG5/72HG33wWaeikkhgssEOQf1p+F7W/WPJQ+UU2bS7uNGoCmvWcSHFgvMBB+NONFW/g3fKRA==
X-Received: by 2002:a05:600c:1d1d:b0:426:6ed5:fcb with SMTP id 5b1f17b1804b1-429c3a178fcmr14742575e9.4.1723209361795;
        Fri, 09 Aug 2024 06:16:01 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:16:01 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 12/13] RDMA/rtrs-clt: Do local invalidate after write io completion
Date: Fri,  9 Aug 2024 15:15:37 +0200
Message-Id: <20240809131538.944907-13-haris.iqbal@ionos.com>
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

Switch local invalidate after write io completion avoid the
chain usage of WR, this fixed the local protection error on
LOCAL INVALIDATE WR.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 230e5f6c8c90..fb548d6a0aae 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -395,9 +395,9 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 			/*
 			 * We are here to invalidate read/write requests
 			 * ourselves.  In normal scenario server should
-			 * send INV for all read requests, we do chained local
-			 * invalidate for write requests, but
-			 * we are here, thus two things could happen:
+			 * send INV for all read requests, we do local
+			 * invalidate for write requests ourselves, but
+			 * we are here, thus three things could happen:
 			 *
 			 *    1.  this is failover, when errno != 0
 			 *        and can_wait == 1,
@@ -405,6 +405,9 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 			 *    2.  something totally bad happened and
 			 *        server forgot to send INV, so we
 			 *        should do that ourselves.
+			 *
+			 *    3.  write request finishes, we need to do local
+			 *        invalidate
 			 */
 
 			if (can_wait) {
@@ -1085,7 +1088,6 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 	int ret, count = 0;
 	u32 imm, buf_id;
 	struct ib_reg_wr rwr;
-	struct ib_send_wr inv_wr;
 	struct ib_send_wr *wr = NULL;
 	bool fr_en = false;
 
@@ -1126,13 +1128,6 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 					req->sg_cnt, req->dir);
 			return ret;
 		}
-		inv_wr = (struct ib_send_wr) {
-			.opcode		    = IB_WR_LOCAL_INV,
-			.wr_cqe		    = &req->inv_cqe,
-			.send_flags	    = IB_SEND_SIGNALED,
-			.ex.invalidate_rkey = req->mr->rkey,
-		};
-		req->inv_cqe.done = rtrs_clt_inv_rkey_done;
 		rwr = (struct ib_reg_wr) {
 			.wr.opcode = IB_WR_REG_MR,
 			.wr.wr_cqe = &fast_reg_cqe,
@@ -1142,7 +1137,6 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 		};
 		wr = &rwr.wr;
 		fr_en = true;
-		refcount_inc(&req->ref);
 		req->mr->need_inval = true;
 	}
 	/*
@@ -1153,7 +1147,7 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 
 	ret = rtrs_post_rdma_write_sg(req->con, req, rbuf, fr_en, count,
 				      req->usr_len + sizeof(*msg),
-				      imm, wr, &inv_wr);
+				      imm, wr, NULL);
 	if (ret) {
 		rtrs_err_rl(s,
 			    "Write request failed: error=%d path=%s [%s:%u]\n",
-- 
2.25.1


