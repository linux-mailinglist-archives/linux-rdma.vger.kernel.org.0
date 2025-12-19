Return-Path: <linux-rdma+bounces-15096-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EC3CCE6DE
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 05:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5292301A1BF
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 04:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9562475E3;
	Fri, 19 Dec 2025 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b="N7t43T6q";
	dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b="IIPoLd59"
X-Original-To: linux-rdma@vger.kernel.org
Received: from cvsmtppost105.wmail.worksmobile.com (cvsmtppost105.wmail.worksmobile.com [125.209.209.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE976026
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=125.209.209.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766118324; cv=none; b=ECpYxFadmimcBW0Oz7Se+YolSWCBOEXBuLUHBKXV2Gut4ts+Pkg+j1D+t81H9Jt7fmoC55sDlcJOkklNHNKp410rgyA8aevfN8grQNEXRT5ckJSy3OozXYRQmt2YzjhdaqIZScfd/r92mjNlEt4j6JDTBQJa6iDkddkuEFX6fHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766118324; c=relaxed/simple;
	bh=uARGzBY1AtW/PeYPQSthrejwhnJAeiPRkhbdYrR1piw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rc528eEjTeT2rQYmI7IKR7RNqoRtcgCmWBut2r1ineeJfDiKcFJyR3QB2oY9m+sCAW76t8jykkX65ZrSHv5cQNE2FU8KMg5TFV/5CKzZ09R1yCcU1FVPlKCDFlEKmvEKiRk7tcS6O6Faxj81zR+67PWtHmX4nvXhPvClISzMPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr; spf=pass smtp.mailfrom=korea.ac.kr; dkim=pass (2048-bit key) header.d=worksmobile.com header.i=@worksmobile.com header.b=N7t43T6q; dkim=pass (1024-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.b=IIPoLd59; arc=none smtp.client-ip=125.209.209.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1766117710;
	bh=uARGzBY1AtW/PeYPQSthrejwhnJAeiPRkhbdYrR1piw=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=N7t43T6qsMjCdxW8AcqXtmn/ey7ynZoHVrHN0kUDJR8G3K9C9mAwzfKB88IJtz4lS
	 Lhek4gNwbjpRzgdCOCL8Rt2pMU4qeyt4//HAmVaCRqc/fuSGdu8qCssXZ5wvFHKNlL
	 d6AkCBUghLYSxQxgIE2ffzloucGzCCaR5ZahtX7BaSVKYOoAflOzBbMFH0HmrIPXSM
	 2r+zh3/MIswinMqLPoqUHOlx5GPXzv+Z10LAX4C0ciqSgwNzZQDke5qGa41ImD0Jqt
	 wQu0mnds8M5UMBF4EbXWwZAfTkRGmKnHsVvX/9FZ7eT4ioOKKlL6b+KPg28Pgy6UWC
	 LJHYMYhiYHPkA==
Received: from cvsendbo004.wmail ([10.113.20.173])
  by cvsmtppost105.wmail.worksmobile.com with ESMTP id OCtfJzQ3QeGxbZXQNdXvPw
  for <linux-rdma@vger.kernel.org>;
  Fri, 19 Dec 2025 04:15:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1766117710;
	bh=uARGzBY1AtW/PeYPQSthrejwhnJAeiPRkhbdYrR1piw=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=IIPoLd59FVgCS94H+iPrNJ4kCV1mg5tdPFEMwj2OGvr9GJ/XX7Z6SqzyM8TVTKmhB
	 N8caVmkXGLAmJUTm18ggXggbjnWmKSxtIUogWHaOl6IHRvjfsE80ZwI1dhUFE9lpkx
	 nbQTdoVhujQ8K5vLRLqMORCBP58EKfyuYEt/0oOo=
X-Session-ID: FnlQwr6rTTiZJA6hB9nI4A
X-Works-Send-Opt: kendjAJYjHm/FqM9FqJYFxMqFNwYjAg=
X-Works-Smtp-Source: Yqb/KAMrFqJZ+HmlKAK9+6E=
Received: from s2lab05.. ([163.152.163.130])
  by jvnsmtp403.gwmail.worksmobile.com with ESMTP id FnlQwr6rTTiZJA6hB9nI4A
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Fri, 19 Dec 2025 04:15:09 -0000
From: Jang Ingyu <ingyujang25@korea.ac.kr>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jang Ingyu <ingyujang25@korea.ac.kr>
Subject: [PATCH] infiniband/core: Fix logic error in ib_get_gids_from_rdma_hdr()
Date: Fri, 19 Dec 2025 13:15:08 +0900
Message-Id: <20251219041508.1725947-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix missing comparison operator for RDMA_NETWORK_ROCE_V1 in the
conditional statement. The constant was used directly instead of
being compared with net_type, causing the condition to always
evaluate to true.

Signed-off-by: Jang Ingyu <ingyujang25@korea.ac.kr>
---
 drivers/infiniband/core/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 11b1a194d..ee3909285 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -738,7 +738,7 @@ int ib_get_gids_from_rdma_hdr(const union rdma_network_hdr *hdr,
 				       (struct in6_addr *)dgid);
 		return 0;
 	} else if (net_type == RDMA_NETWORK_IPV6 ||
-		   net_type == RDMA_NETWORK_IB || RDMA_NETWORK_ROCE_V1) {
+		   net_type == RDMA_NETWORK_IB || net_type == RDMA_NETWORK_ROCE_V1) {
 		*dgid = hdr->ibgrh.dgid;
 		*sgid = hdr->ibgrh.sgid;
 		return 0;
-- 
2.34.1


