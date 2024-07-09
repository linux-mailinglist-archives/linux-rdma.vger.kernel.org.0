Return-Path: <linux-rdma+bounces-3772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B7E92BDB1
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 17:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54CC1C219AD
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D7A19D896;
	Tue,  9 Jul 2024 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="C/tML7au"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E91C19D890
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jul 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537289; cv=none; b=ESnuFPAgpL2UXxbFBn4pMXdmGxsYUweyjlnLTIG42PQzX8qBkRdeqwAnXdmeUKAVIUBUmP+5+2vrc0mM+dnGiw3YaTlASPFi84e0YRi0OmzVZby+yzzN6EHVTmXcWn4uPFnrEdrN2xOouLYYQPPD5F+3g0Abr8RG0tBFPXiPf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537289; c=relaxed/simple;
	bh=FW6fIdGit+pyP1OewBZblyVS76v/fNq0887mMCejRwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tV2l14k0N1Qs3iyd/tvccVUwo0FzWvC8IhMCAUafpuZ5F6gc1x9t5ej5D/yr1GiWGLlm43zDqQrK58GHR9xtFqkPbqQ5FEVpjISl8nS0sFn8cqzm5u7kf9ij6XoEiAwJfEMYQovPYeErILkwG0Q8sUSSdXbdM8liW9ptm+Tqc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=C/tML7au; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58bac81f419so6974878a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jul 2024 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1720537284; x=1721142084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBqw8jE35wR5me+P1Q3829kCDIv4M/IogxwaM5m70tg=;
        b=C/tML7audLB7jXMRa/fOhbo5V1KRVaRPJVHDNwna8zMRa3dbMGvkR7Dqn5oYxT2w9c
         UqN8Iu6wzb+AoCQZpOZoFodMeb681Ac+6pfrAxAY/qiT7WSKunW65zGJ77T+gBRYPLR9
         Y1s61AkUgUsgDUdjjq5yYLQ9jb0KZfQS5kOdISkyAFV4OjVzhUNeeVaQlIWLd5Om+pcj
         D0GZ3JBVNeIM6ToW9nrAKYL+kk7MoHw+h9KFcVWh/ityR/AggpZvuXHGWkh1JwpF6hiv
         sV9ONjWbxKrzio47ewP799n0+IS2cdOMRHemHaljzhD/Nh5MTvN2SqG1t5CmZoH/tlRg
         rp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720537284; x=1721142084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBqw8jE35wR5me+P1Q3829kCDIv4M/IogxwaM5m70tg=;
        b=DVtrM89U7VLRdduc+WX/KLvskMxyT8QaVn/Ph12aDXlA1rzotLqarKOAqgXymxbq69
         fj6RISzruCpXR91z+Kpab6PpcW4S3gluPwEKj/bi1UmKXglcWrmVk94q6iJ8S5lRVdaW
         i6GNiqeAh/Qpu+/BYKMOJgkykFFwqdEofQA5stv4vFoxDo6s1Y+7K9kz0nUDjTWFCOQg
         JcJ/zkJqeIdzM0joCEy9Jh7+C/XkiDlFRgR5mhXbRq1MyRSu4ndlL6UUKQhgW8poZIQB
         sq2ry0ohWBPX9kse7osnm8/G1G3yBuTd6Vnwtfssil1AoFQH5zxPKgpDje8EeSNQO4LR
         1Vpw==
X-Gm-Message-State: AOJu0Yymb0eyA7WO4gZNSEJbIwfAwQjPZOXG7IYa4Mj1F6ialc+jbSe+
	WzdjdFOD7dPQC8MBg4VKV+zsW8OQ9cHCJjuAU6i+VUgs04d6vIy78WffN1iIYB16ALoxNHESS5f
	a
X-Google-Smtp-Source: AGHT+IFfv+v12ijQeCSAGiop1O2oF8oiE2Qrai/EXIpvbGLWRPUybiOojHqNPrRP7f26faqbejZVoA==
X-Received: by 2002:a05:6402:33ce:b0:58e:dbd:65cd with SMTP id 4fb4d7f45d1cf-594bc7c7e1amr1849928a12.26.1720537284156;
        Tue, 09 Jul 2024 08:01:24 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:1436:4f00:2ca:d136:a29a:bb96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc4e80c6sm1166172a12.46.2024.07.09.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 08:01:23 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	selvin.xavier@broadcom.com,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Subject: [PATCH for-next 2/2] bnxt_re: Fix inv_key endianness
Date: Tue,  9 Jul 2024 17:01:19 +0200
Message-Id: <20240709150119.29937-3-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709150119.29937-1-jinpu.wang@ionos.com>
References: <20240709150119.29937-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar like previous patch, this change the endianness for inv_key,
hw expect LE, so change the type accordingly.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 6 +++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index c5080028247e..cdc8ebcf3a76 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2483,7 +2483,7 @@ static int bnxt_re_build_send_wqe(struct bnxt_re_qp *qp,
 		break;
 	case IB_WR_SEND_WITH_INV:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_SEND_WITH_INV;
-		wqe->send.inv_key = wr->ex.invalidate_rkey;
+		wqe->send.inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
 		break;
 	default:
 		return -EINVAL;
@@ -2513,7 +2513,7 @@ static int bnxt_re_build_rdma_wqe(const struct ib_send_wr *wr,
 		break;
 	case IB_WR_RDMA_READ:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_RDMA_READ;
-		wqe->rdma.inv_key = wr->ex.invalidate_rkey;
+		wqe->rdma.inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
 		break;
 	default:
 		return -EINVAL;
@@ -2563,7 +2563,7 @@ static int bnxt_re_build_inv_wqe(const struct ib_send_wr *wr,
 				 struct bnxt_qplib_swqe *wqe)
 {
 	wqe->type = BNXT_QPLIB_SWQE_TYPE_LOCAL_INV;
-	wqe->local_inv.inv_l_key = wr->ex.invalidate_rkey;
+	wqe->local_inv.inv_l_key = cpu_to_le32(wr->ex.invalidate_rkey);
 
 	if (wr->send_flags & IB_SEND_SIGNALED)
 		wqe->flags |= BNXT_QPLIB_SWQE_FLAGS_SIGNAL_COMP;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 1fcaba0f680b..813332b2c872 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -165,7 +165,7 @@ struct bnxt_qplib_swqe {
 		struct {
 			union {
 				__le32	imm_data;
-				u32	inv_key;
+				__le32	inv_key;
 			};
 			u32		q_key;
 			u32		dst_qp;
@@ -183,7 +183,7 @@ struct bnxt_qplib_swqe {
 		struct {
 			union {
 				__le32	imm_data;
-				u32	inv_key;
+				__le32	inv_key;
 			};
 			u64		remote_va;
 			u32		r_key;
@@ -199,7 +199,7 @@ struct bnxt_qplib_swqe {
 
 		/* Local Invalidate */
 		struct {
-			u32		inv_l_key;
+			__le32		inv_l_key;
 		} local_inv;
 
 		/* FR-PMR */
-- 
2.34.1


