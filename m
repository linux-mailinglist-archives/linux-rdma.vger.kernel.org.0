Return-Path: <linux-rdma+bounces-6433-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D6D9EC8ED
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 10:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735C0188CC7C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E473211A09;
	Wed, 11 Dec 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Gkbykv5Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AD23368C;
	Wed, 11 Dec 2024 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908900; cv=none; b=FeO64Pm14yZ1/akaYf42aRxHkjP73kzTVRrMOKZ4E8WMlgw6CSuPP3GMytXcEIJurDHmwSXFjTcvZ7RcGSVQ2xgivylqQ+SuhmRAhV/Jepaokx2zRPodCnFNSjWasD5XihjTc9lUB85fIjxK8TABqsodoRg1x2n/j9NOccqTleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908900; c=relaxed/simple;
	bh=vusTrhM8DAefiS223HMLa0+Fd8AmRhkhA5xGXNXXRh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQEObOK6yUTewT0uyMmNYkj2YAgxPt2z4QCmwfWE2tqUu4ClzBb6EaY/TvGR29kKwTyLLAfXy/Sx7WKPKG32SWbo1jC0sYvn8R6oXmkKNZCFQ9ueQej6DQAdj90qTlAAfPy58NQRSpwwGUK9bsz8hqnOUdfT4aBK4qekw2inKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Gkbykv5Q; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733908895; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=oSj6m08arF0WtGw1YqlMHZqeKL2gyt5wpE7kA63B6RE=;
	b=Gkbykv5QhFlSM1XC8nXpJ2J3Lc4G3hHjwueJOkBOKy/ICmvJJ0NuvctBlrHxMzcgqlQ58Us7eaRVUseFyQ9ZC/btLclgAeLKaAD8IhLIUZkZDFxlL+QTDpvU8Idf19xRu52uYmnGKy4dfDvFxNVhJ+PevvRLKlKGSqfYxWkxQI8=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLHtOox_1733908894 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 17:21:34 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 5/6] net/smc: check smcd_v2_ext_offset when receiving proposal msg
Date: Wed, 11 Dec 2024 17:21:20 +0800
Message-Id: <20241211092121.19412-6-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241211092121.19412-1-guangguan.wang@linux.alibaba.com>
References: <20241211092121.19412-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When receiving proposal msg in server, the field smcd_v2_ext_offset in
proposal msg is from the remote client and can not be fully trusted.
Once the value of smcd_v2_ext_offset exceed the max value, there has
the chance to access wrong address, and crash may happen.

This patch checks the value of smcd_v2_ext_offset before using it.

Fixes: 5c21c4ccafe8 ("net/smc: determine accepted ISM devices")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c  | 2 ++
 net/smc/smc_clc.h | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index a795acaa0780..a1dafb88f3c0 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2147,6 +2147,8 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 	pclc_smcd = smc_get_clc_msg_smcd(pclc);
 	smc_v2_ext = smc_get_clc_v2_ext(pclc);
 	smcd_v2_ext = smc_get_clc_smcd_v2_ext(smc_v2_ext);
+	if (!pclc_smcd || !smc_v2_ext || !smcd_v2_ext)
+		goto not_found;
 
 	mutex_lock(&smcd_dev_list.mutex);
 	if (pclc_smcd->ism.chid) {
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 23afa4df862e..767289925410 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -400,9 +400,15 @@ smc_get_clc_v2_ext(struct smc_clc_msg_proposal *prop)
 static inline struct smc_clc_smcd_v2_extension *
 smc_get_clc_smcd_v2_ext(struct smc_clc_v2_extension *prop_v2ext)
 {
+	u16 max_offset = offsetof(struct smc_clc_msg_proposal_area, pclc_smcd_v2_ext) -
+		offsetof(struct smc_clc_msg_proposal_area, pclc_v2_ext) -
+		offsetof(struct smc_clc_v2_extension, hdr) -
+		offsetofend(struct smc_clnt_opts_area_hdr, smcd_v2_ext_offset);
+
 	if (!prop_v2ext)
 		return NULL;
-	if (!ntohs(prop_v2ext->hdr.smcd_v2_ext_offset))
+	if (!ntohs(prop_v2ext->hdr.smcd_v2_ext_offset) ||
+	    ntohs(prop_v2ext->hdr.smcd_v2_ext_offset) > max_offset)
 		return NULL;
 
 	return (struct smc_clc_smcd_v2_extension *)
-- 
2.24.3 (Apple Git-128)


