Return-Path: <linux-rdma+bounces-15212-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 377AECDD6A3
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 08:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC7BE30014FC
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 07:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A41A2E1758;
	Thu, 25 Dec 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X8c/cIni"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAA20468E
	for <linux-rdma@vger.kernel.org>; Thu, 25 Dec 2025 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647248; cv=none; b=fMARiFxe3vjYbI3oTR1QawI9rx089K4QE3arlaEYVGhUWKWUXruH5sSKNTeqqqjSwx7x5VI0qKlqcsCmzTvNWYAC+UyhcrwMdwejI40PzhdKKriMpzlW+vcu5BsEFrQXWmMhXqYUCVoStmxIjcG2MxOioEmy//VNsmwN1qlfBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647248; c=relaxed/simple;
	bh=cHRQFTHJip4q3kK2oSWFLMTeaZikNem0UHViQ25n+AU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cm7Ah5eLl84xhUpiUg6WOQUtt8tOsznoh+MlHCcoMaTNZ/FgDmfB41q2tQ2yEGruu/KnfoOpoStm3cAlmcUbhPWodMOMOeXMpVy0NvpzNXMutqFDnTfhKwUdc6HaYLkhB+Sxi9jCn9EhVPAyRj4f3kgNm6gPjJTESLA5IR2/7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X8c/cIni; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766647233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m/k2fTrIZFyEa3LOW07+7UcFmuSQvr1Ei6oTX9Qt9so=;
	b=X8c/cIniQXTHfyFjQgCE5H43Qiqyq1C2Cg4rBXQBEOaBm11t4GRU9qM/xE2ZMi2IRfON0Y
	QSpZw0ucdJAHHAT460MCJFI7bT9mwPfo8pwjd8l1E1/TH5dX/VcTFyejA4LMESeZDzj/Pc
	J2PWOb2WmhAjkj4VsIv2OC7paVbLOxs=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rxe: Align struct rxe_sge and struct ib_sge
Date: Thu, 25 Dec 2025 02:19:59 -0500
Message-Id: <20251225071959.3037-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace struct ib_sge with struct rxe_sge in struct rxe_resp_info.
No functional changes.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index fd48075810dd..f1f6dda22b70 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -222,7 +222,7 @@ struct rxe_resp_info {
 	/* SRQ only */
 	struct {
 		struct rxe_recv_wqe	wqe;
-		struct ib_sge		sge[RXE_MAX_SGE];
+		struct rxe_sge		sge[RXE_MAX_SGE];
 	} srq_wqe;
 
 	/* Responder resources. It's a circular list where the oldest
-- 
2.39.5


