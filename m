Return-Path: <linux-rdma+bounces-15353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79316CFEDEF
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 17:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCB0B3031D48
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737603612EE;
	Wed,  7 Jan 2026 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="U3x1jH8s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC834DCCF
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802537; cv=none; b=VShsP9X0XTCIDR809oT/QVZjX2gopPpMtmrLycTrz8cT5jyD4V5SOLhM6XcJspMCuUhtVWqFmljY4N+5xTppZQAY9vjjEi1HqgniZvrXZUsyo5yWXw8ILAd8wWAv20TxI5O0MehfPBRUX+yTLuE70xsVFgc4ALzftZ9Jpka6WMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802537; c=relaxed/simple;
	bh=DK82sq0YRZo4I5tAWysebNR04APRa5cQa1GanigY60M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoWAm8UBz+mEMdESOEa/7Rtg8L8TqYUGjjJGk2u4SsmnjtSejGsRcgGrJXlOFmJwJR3dpadcZsNNzEuKiYRCjRByzVfg6DWLDOZCii8R9o3gEsiW0cFEF4ZUyL8+XRLEp1B8uTnGjBdFDRjQx/JKv3xIq1NLzx1TMsL3lvB8z4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=U3x1jH8s; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6505cbe47d8so3592268a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767802525; x=1768407325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmK4ukXEO2k1OkIznCc8rzjpQm/5o1nT/zdBVsjdN4w=;
        b=U3x1jH8sYdCM+Hgz+4spo8DWkdO5xktrAzyL/wCkUCh9pMvZaYlj49kvUiMqfF2fSl
         eX3SEQTSlpEtHG2NkjyBBpr/fhH7sx9pSVmlYqrJdhgX2soV2mZeejtpyldHidC/s5o1
         B8yc15dmj0JL28bLWLE6tFqYspqrt0GY2sXvO9zr57T1uCAE/sLwwNkzoKZqB/ZCSSQW
         gTKk0J8Gn8+N+ddwVoZRdofiWuJTJPJ4qLY+dnCyF7SbH7USNC8WTClZI59Fvnq5EQqU
         Fzau/vg/L1hx/sEnOB44yQn3eWPj/Ta4ZnbkMi5q4uCE2HoKg0q/EB9Deil7z9plQp5s
         iYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802525; x=1768407325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmK4ukXEO2k1OkIznCc8rzjpQm/5o1nT/zdBVsjdN4w=;
        b=FkRjHzYf4/Syvvv8le0o5zojIpGh6K5dn4aj9CSoXpdveO6CXI++9NuY+ufN5/N1lQ
         QmHdpTPiNfDo5JUqN8ECtuTWRAue5tK8/tczdInwAxg8oFYc7UoCXOfxxKOriRQe3tWn
         skGF4F+K6T12NidSyY1RRWa1YG2QhDS6g0Bu9c4WVbgd97WqD9FcSTXklNSSEb0wmQcx
         aRT8FPQ5RWSQ0tScTYt0FqGRrYZoEiu3F8+CUSX2NovNIktzuJ8bAPcJi9Dojpcyo8ia
         diIBR3ggOvXfhSJcx2OSgaS38qeKdErnU+jaM8iiKwQE/AeoRhTNZ0upsF1w/nFJDWn1
         mkjw==
X-Gm-Message-State: AOJu0YyO0hLE7Wks+1LE0IGUUuvsd2LieGTB3GxJfBwFATC/camh0WWa
	knhnFSOtkJrivihVlVzA2JVdqszU5OCxK7aHt+PvHlj9HUg047PpF4tqwWPzZ8BUFTkCrYllSrd
	SxMEw
X-Gm-Gg: AY/fxX7Z+oJszBj3K8qhCfYzzL1nZoyYq94ay42CCtwezMZ9TMQoyKnkAMiPYVgUCZ0
	Wu1fzREIrbQ4vZr5Gh4u56I7hSBCk04D/nOdgjrBODxDWnxKLSx3PrO8AgUgsNkne6g1Uz02q2m
	RcmcovJowaSgKFlV0dbjzB2DdilJ/V87gGLbKEw7cmKzOPSVKAxiQPl/y3aY4HnKNV1rpg4SfGC
	rsrD6kDel5Pj0/DP+jqkv8QD157VTAcs7Hr0fMxTDc3Jz9/mGM6Uz2NaoXdyI2DbwR944QwrXp/
	Rs8FQylnzlEqQPdfaBxljI1amltlxxyS3yJ0F8cp4HhKNBvmWTGhixEyGAFKLjvWcEAYC4rORTY
	AvddJAleyl7AHZLnPX4RQeBA5yHWZf5+YWSccBTuK/efrsyqZAITkhV9MoKQqB1P35y9Y16vLkj
	SGGbmT9zq2bNMV6wF2bwgwrFpnsTTVfZwyuFwHMIPkwmJxk7Csaim2u6KEZ7P9CwT/5hUuagNFx
	IA61h2zQHFCx/Tf+6KYoVg=
X-Google-Smtp-Source: AGHT+IF0nSXB9cfWcpsBvybyHoPksyTY/hIXcDSgg5UixgB/9sfsmD671zDuW0HD7upiZVgqcsf1Ow==
X-Received: by 2002:a05:6402:26c5:b0:64d:498b:aefd with SMTP id 4fb4d7f45d1cf-65097dcdce6mr2724803a12.5.1767802525113;
        Wed, 07 Jan 2026 08:15:25 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4864773a12.10.2026.01.07.08.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:15:24 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: [PATCH v2 07/10] RDMA/rtrs-srv: Rate-limit I/O path error logging
Date: Wed,  7 Jan 2026 17:15:14 +0100
Message-ID: <20260107161517.56357-8-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107161517.56357-1-haris.iqbal@ionos.com>
References: <20260107161517.56357-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kim Zhu <zhu.yanjun@ionos.com>

Excessive error logging is making it difficult to identify the root
cause of issues. Implement rate limiting to improve log clarity.

Signed-off-by: Kim Zhu <zhu.yanjun@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 4e49c15fa970..d5189f12d2f7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -184,7 +184,7 @@ static void rtrs_srv_reg_mr_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_srv_path *srv_path = to_srv_path(s);
 
 	if (wc->status != IB_WC_SUCCESS) {
-		rtrs_err(s, "REG MR failed: %s\n",
+		rtrs_err_rl(s, "REG MR failed: %s\n",
 			  ib_wc_status_msg(wc->status));
 		close_path(srv_path);
 		return;
-- 
2.43.0


