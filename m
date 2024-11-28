Return-Path: <linux-rdma+bounces-6144-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E389DB74D
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 13:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226DC163CCD
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6422819D8BE;
	Thu, 28 Nov 2024 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TMCoBMvu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9F19B5A9;
	Thu, 28 Nov 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796096; cv=none; b=O+ZKKvhk2le6T8+bi72c+2VMDOKY7w/BfTyHO5U47lCdQ/kenWGcva/Fgc5itqtqt0wY0OkuSiaONkm9xf9uDPb4xyUTDyuNtkJLiDP0GYZLt7WOipftNKtQailCG3UXEhkWyb0PV4CXSX/lcDat6VUchSgWU0ESIUgAVDW1aI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796096; c=relaxed/simple;
	bh=7c0Nhvi6vc0F7OgxUSpaJTqu1EPsj8EHqZOl/cvsuJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kMs0SE/7DU1qkyBBu36Il1Xmk9lu9Zl3MkFGa3xIAqzA1T0qTpxPHHfFOHU1krhGZTdbsf7IdLnQ8gomCCLDAMLaFe0TdN6rrxwpkP0fo8TxduuL7UaC6kOLseW0uPOiAn7a83SohdSCHUYZqvTQg28QpKvwex8rmEFzBGNmtps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TMCoBMvu; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732796090; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=m7Ap01of/SWdOcpc6kwOr0rKDR3Sq0y6oRpXpK79GAA=;
	b=TMCoBMvuKPejELGwB80L2pcvpdrSNLjrEm4qK4feTgR1UlAzfAqUoE7W1MnH20xpA+9nr7Pl7USeGq9uya0uzDWK6UnAwo9A0if8Zk6Jvec6af51lEDPlgp2xvxwLAgj9H53yTW3gO1d9aZRJm7YW24A6fBVz98Uwo5deKk1yp0=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKQ-9UE_1732796089 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 20:14:49 +0800
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
Subject: [PATCH net 5/6] net/smc: check smcd_v2_ext_offset when receiving proposal msg
Date: Thu, 28 Nov 2024 20:14:34 +0800
Message-Id: <20241128121435.73071-6-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
References: <20241128121435.73071-1-guangguan.wang@linux.alibaba.com>
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
index 5bfd38eaee3a..ef4e0ff6beed 100644
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


