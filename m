Return-Path: <linux-rdma+bounces-4278-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12094D0F3
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B681C21E87
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC6195F0D;
	Fri,  9 Aug 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hb8ofc3s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF0194C86
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209361; cv=none; b=J0h4M4iKQn2+SVp+hyfW0XOJH04SGroPGtgT1qEhiEfa+MmMzR8lm/gph8N7yE1OyP27sBhWgT2t1meEgbD9dI+nLI4VTw/lIx4WlyDacQJv5VdSZekYy1fgnnKD/qvodSpWqK/zgGJXKttOcauUcGc9dT0/yROk8TLWylLVzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209361; c=relaxed/simple;
	bh=mKmt/dUi7HOvG9hMniQLGyjZyDjxEOHIIhmOdSb5+Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hkUGVeBwd+4aDRuZGpew6g3dgRTlHJSZKUmCdzKnumEqFwh0foPkCP0LGok8DphKR/T75RlxTDiAf/YLWsazImYiGhi8cucxEJ/9iH/nGz/B9gmrofFgc5OqLvR2DssZsjHFe/7hjYu2TnTlUaq9auTvf4i0n37YfF+ZI6ynREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hb8ofc3s; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42816ca782dso15158305e9.2
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209358; x=1723814158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHI7eUFb+AIheGv9VgUZkWaCMRJAb04OZNzPB+16rtY=;
        b=hb8ofc3szKIIzok/EuBS13RjgzqR/aKoAUkDDLdotiPQPIoLW7j9OxTa0bQCgJ2y0l
         G36UCZ7pHx1Ugn2ucyOu4NxujcPHL/mzYOamv4PekLwIFg0JpNaIvlm9GSUJHz2PBYUz
         CPIy1InYwbIQ7K9y37kQldxapauTtuNH/T8NEOLiA8/ErMU+Af3nUpGWFqVhRwQjc1zi
         bgRpIVFg+Nd5KKDBvDdq1//IotSNu5QPikPi6QKZz0Zch31a1fckPhi7jn/DCKCoGKkn
         fmua0fM6r544ee3JBy+M+nmrVp6jZZEkCjDhAjP55Rl7EKE+jKgZLy77PvR5EynI/JJq
         QzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209358; x=1723814158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHI7eUFb+AIheGv9VgUZkWaCMRJAb04OZNzPB+16rtY=;
        b=VbK28HYrirsbw/FUe1JkfPWEZDZGB05dxTkjqMB2aHfpJDogmEwnbyc5AOA+/sEK8K
         ol8bbcvCfmgcV1mPYVYIYXNmaYV0TxEsFtXFvqCVMe5cHZF+qU316KOaNKovNBa519sp
         PrJXCY3nnf2zFF2p6L8f9O2oyqr3TwBertmHDRLyLgd0MjtoMkrXJq3Sz7Tj2ah067PX
         LR7jmxdTjXsSGgSRdPgCmgYZYOR1WDo5nagLELB+MEmlV1KKx97+bQls0P9UqAqa/vJj
         +R5wqHaXBAZYJzX/Hv/mfNkgBnlG+D+5BFr0zXRvmJ0OQuraczc5kzEYJgvcD378n0Rj
         ov7w==
X-Gm-Message-State: AOJu0YwIlTJtLOHNhr68z+hlrd1ZeMP890UEOGGi0H0y52eIo4ZXN5Cl
	65VGsVC/x3+P/9Gw6pEpbMeZCJL1v6hvp3Jjbq8QuuxkU+2u6qsWJGwfjxzHPLAF/plmSiMdg4g
	SuQc=
X-Google-Smtp-Source: AGHT+IFkLlK92Fs26CagIKRdvS+zJzllhMVfBdQSkqbECQQHmdqsnyIxMrIlXpPP5JJhFySPcKADrQ==
X-Received: by 2002:a05:600c:468b:b0:426:55a3:71af with SMTP id 5b1f17b1804b1-429c3a5b3c1mr10755915e9.33.1723209357867;
        Fri, 09 Aug 2024 06:15:57 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:15:57 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 06/13] RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer
Date: Fri,  9 Aug 2024 15:15:31 +0200
Message-Id: <20240809131538.944907-7-haris.iqbal@ionos.com>
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

Reset hb_missed_cnt after receiving traffic from other peer, so
hb is more robust again high load on host or network.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 ++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b34eb4908185..c1bca8972015 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -619,6 +619,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		 */
 		if (WARN_ON(wc->wr_cqe->done != rtrs_clt_rdma_done))
 			return;
+		clt_path->s.hb_missed_cnt = 0;
 		rtrs_from_imm(be32_to_cpu(wc->ex.imm_data),
 			       &imm_type, &imm_payload);
 		if (imm_type == RTRS_IO_RSP_IMM ||
@@ -636,7 +637,6 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 				return  rtrs_clt_recv_done(con, wc);
 		} else if (imm_type == RTRS_HB_ACK_IMM) {
 			WARN_ON(con->c.cid);
-			clt_path->s.hb_missed_cnt = 0;
 			clt_path->s.hb_cur_latency =
 				ktime_sub(ktime_get(), clt_path->s.hb_last_sent);
 			if (clt_path->flags & RTRS_MSG_NEW_RKEY_F)
@@ -663,6 +663,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		/*
 		 * Key invalidations from server side
 		 */
+		clt_path->s.hb_missed_cnt = 0;
 		WARN_ON(!(wc->wc_flags & IB_WC_WITH_INVALIDATE ||
 			  wc->wc_flags & IB_WC_WITH_IMM));
 		WARN_ON(wc->wr_cqe->done != rtrs_clt_rdma_done);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index e6885c88fa41..c7aec40d4934 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1233,6 +1233,7 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		 */
 		if (WARN_ON(wc->wr_cqe != &io_comp_cqe))
 			return;
+		srv_path->s.hb_missed_cnt = 0;
 		err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
 		if (err) {
 			rtrs_err(s, "rtrs_post_recv(), err: %d\n", err);
-- 
2.25.1


