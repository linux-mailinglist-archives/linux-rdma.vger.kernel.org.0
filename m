Return-Path: <linux-rdma+bounces-4277-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33F94D0F4
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C040FB21901
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E27A1957F9;
	Fri,  9 Aug 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="BJuNNMUm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C11953BB
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209360; cv=none; b=fbvGYNiNJcPU+yzPXjdm1p5cT/r7NtM11sIjRnZnE7YpWM3DWPnvFVLbNcxN6nhWAVyoBFHKjerZQgjh5Ym+q1Vx0yeIo3Wcvv5eSdWwmkkPUR1LVK9hp3HwmZWwLSDWB30pLeaCwmN8+sMw+HPgSEXEtTD9q0zhU1/iaLA3EL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209360; c=relaxed/simple;
	bh=wSG8mJWVwK1/KFG56H2h9FYqiJNGfBvw1cfDruXjyG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BpZNvxVLaO3NYJD1cWY6Eb2WLcnCRLOL0qvutb5GqKOZW4SUVzCNngeRWUvmi4oSiIZkqxyzD+enKjfEIQt3Lmc1YN1aP/Qn/0EBXmMdkg1Vaaa4T0K+nY677bsNUecFf6bWKuJDUUVY1U+polNr8atarugwrgbIGayYoDZj0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=BJuNNMUm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so1020627f8f.3
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209357; x=1723814157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fjw2Ta8LUJKcy0S2Y9A72sgh/iD12aMXAxb+1vnFQ4=;
        b=BJuNNMUmRGk04kapXi6OxBEPLMcPPjOr2LEAbhh2nRO1gxhH3IV9y5gvpv+MckI4qD
         plbqX/XlpdnhInjCukAPi7TWM5Hd58D7dUEPKBexypM+poyZYdgtcnF39+r7Uqo+vf5W
         MmeMya8pT+zpGuAN/2DNvGyBDS0V+xh3jsnbM0b9jHNIuhMPPfAVJZFacw77VP8kt1Nq
         qY++wQsrbpMk1x2Vvd+yz2tQeuH1zB0pKfGUxYr6dYSGUTBbcKaAtc4o6kZQA6syO+nF
         b6Oi5JDQmKPSY8llEXpAwfeYVP1ijUuQWw8K3p+/bBvd5/yOmVPFT8eSzGb9jyVS8eGn
         2ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209357; x=1723814157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fjw2Ta8LUJKcy0S2Y9A72sgh/iD12aMXAxb+1vnFQ4=;
        b=FwAO7PKEBcqz2FJfq0yuPAwiKilGrsXHgGRQRwZywwofa5jWBG95xrIi2Q1ydLPsdW
         fJpqXE+CVlW3fQCu4eDAJDKd5fYeOgwGSRs6x7eHg94LbH/AYI4LdkqAInNnAjlrBsib
         Ea4B34wWwVdeuvAjEt3DTgvSHnFc237jVLBKrO5vbi1iGB9Kk68yKc051oWzZ/3jcA3d
         QuTfeH/elrp+ByVMqAy42jk/DL4EtzjREGxP2yzZ4OC7CI4bqnnJxI1GtF99632WvvZ1
         36iPqsFGc4iH3yFTjX3RzG4CGqw6eX9gZSEGOx64ZziUrd+716Ms371tSgnH1A9qTCXl
         eCHQ==
X-Gm-Message-State: AOJu0YyK3s2sl/oyQwcLF1USOaahgoEQXNTFPFV1rdLLU2TEnUgWPPlq
	ybKiWPt/XyYqZ2anUpPtKXg/vc60UcNpLg5yLBbQN4aCL3RKKckBuvYPdAYWUKLUeg3c2UvSaFv
	ZHDk=
X-Google-Smtp-Source: AGHT+IH8u9UzHXh++14Gi2rWpw8AwEymQjk+lTqtXiCxSLQqgU0I2s8aFQyVjyk17RUcKUOmVtmQNw==
X-Received: by 2002:adf:f349:0:b0:368:664a:d4f9 with SMTP id ffacd0b85a97d-36d5eb08646mr1274872f8f.28.1723209357248;
        Fri, 09 Aug 2024 06:15:57 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:15:56 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 05/13] RDMA/rtrs-clt: Rate limit errors in IO path
Date: Fri,  9 Aug 2024 15:15:30 +0200
Message-Id: <20240809131538.944907-6-haris.iqbal@ionos.com>
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

On network errors, a large number of these logs are printed due to all the
inflight IOs, rate limit them so they do not clutter kernel log.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index d09018c11ece..b34eb4908185 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -331,7 +331,7 @@ static void rtrs_clt_fast_reg_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 
 	if (wc->status != IB_WC_SUCCESS) {
-		rtrs_err(con->c.path, "Failed IB_WR_REG_MR: %s\n",
+		rtrs_err_rl(con->c.path, "Failed IB_WR_REG_MR: %s\n",
 			  ib_wc_status_msg(wc->status));
 		rtrs_rdma_error_recovery(con);
 	}
@@ -351,7 +351,7 @@ static void rtrs_clt_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 
 	if (wc->status != IB_WC_SUCCESS) {
-		rtrs_err(con->c.path, "Failed IB_WR_LOCAL_INV: %s\n",
+		rtrs_err_rl(con->c.path, "Failed IB_WR_LOCAL_INV: %s\n",
 			  ib_wc_status_msg(wc->status));
 		rtrs_rdma_error_recovery(con);
 	}
@@ -419,7 +419,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 			refcount_inc(&req->ref);
 			err = rtrs_inv_rkey(req);
 			if (err) {
-				rtrs_err(con->c.path, "Send INV WR key=%#x: %d\n",
+				rtrs_err_rl(con->c.path, "Send INV WR key=%#x: %d\n",
 					  req->mr->rkey, err);
 			} else if (can_wait) {
 				wait_for_completion(&req->inv_comp);
-- 
2.25.1


