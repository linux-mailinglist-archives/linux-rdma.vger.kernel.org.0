Return-Path: <linux-rdma+bounces-5114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4E19875B4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963CB1C212B7
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830C752F88;
	Thu, 26 Sep 2024 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MS96yr1u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314D85258;
	Thu, 26 Sep 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361293; cv=none; b=d9nN+CtHEcHfnwQmCmUOvZ74Q3FIKf/76yAcbp58qZ+x2T0trzPyMdHmUo7Robhg3qn1PJqq2Qt4zUjle44S2Sk10gSYwSxXdxtjQS7gF3/KFpUdDI+abdOusJRSpiIA9ugF/PdpTKLDEd3Y27rDVVLs3K/FXZymuslJGov5XDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361293; c=relaxed/simple;
	bh=e8R5NerFQ4bdBFU7rQ6doUTlD56D/uE0QeprlM2KSLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X+FZxTxtJ/zcAqQ5My2nxLZjI6PPkr2mDX+0ogL1mqm53lNCQIyGsVvsvlUNAr0G0whEvH+7NouW9r0UTjtZqTDEx6/QLc4mRW3y2pZEP0URkAPTuVwazLGHJQX2rfp9hQOVj+tbHw3z/kyV3VjhO9hMe6SmCG2aNy8D75gQN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MS96yr1u; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WmtTR
	u/sjzCUNIaVfsp+mEPZ2ONe5Ut8ELM2dv9RZvI=; b=MS96yr1uVZxoHY5hYIeHs
	7ogGL19PxcFW0Yk3KGHeoJsb8hXUJgNIcsPMbg2RzP6ZjwMdnSmaaU+HmbrKA9t8
	eR8zgDqqEGKPD+MITAzqZp2yX23EqT8BF5bZN4IBRKIsEo/0Q15rBChlyfI0sqH9
	5O1tTsL8G/tgfwx6IxEYGM=
Received: from iZbp1asjb3cy8ks0srf007Z.. (unknown [120.26.85.94])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wDXXxrqcPVmPPxVPA--.63953S2;
	Thu, 26 Sep 2024 22:34:19 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] RDMA/nldev: Fix NULL pointer dereferences issue in rdma_nl_notify_event
Date: Thu, 26 Sep 2024 22:34:03 +0800
Message-Id: <20240926143402.70354-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXXxrqcPVmPPxVPA--.63953S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWruFWrtF4DGF4UZw47Arb_yoW3GrX_Kr
	y0gFykJr1jkr1Skwn5Ar13Xryvqw1Fv3Z5uanrtryrtry2vFZ0qwn2vFyDZw1UGFs7KFy7
	J3y3uw4ruay8GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjByIUUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLx1mamb1VC9cDgABsF

nlmsg_put() may return a NULL pointer assigned to nlh, which will later
be dereferenced in nlmsg_end().

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/infiniband/core/nldev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 39f89a4b8649..7dc8e2ec62cc 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2816,6 +2816,8 @@ int rdma_nl_notify_event(struct ib_device *device, u32 port_num,
 	nlh = nlmsg_put(skb, 0, 0,
 			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_MONITOR),
 			0, 0);
+	if (!nlh)
+		goto err_free;
 
 	switch (type) {
 	case RDMA_REGISTER_EVENT:
-- 
2.34.1


