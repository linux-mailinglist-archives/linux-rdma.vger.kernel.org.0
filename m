Return-Path: <linux-rdma+bounces-4831-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E597194B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2670281A0A
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA75E1B78F8;
	Mon,  9 Sep 2024 12:28:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17321B81B1
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884880; cv=none; b=BAIYyf5AHPNJL1xe6o0QcoEYGkzVJnCuqIVLJ4D+D0eX5YHEQB5yjrYG3q5NPL8S+IRbbdg+YmEkRKvLeR8nim9AuPJfSI6m4OgURjYEPlT1nbHnTC1XpCuZOgGBS0Nc5D0KAz7aGFYOyDt0ZR7UNJufj09qbp4Z0curs/ertXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884880; c=relaxed/simple;
	bh=xcBuQB0Hbdv4WWggDI9Kz/I+K338/JTSeGCNtlBRGX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWRcSC+YiG/YGuRPStylMKzSqYh20gfRqC7PPz7sCsbgpFtMyQ3oWU4uqahS1lEJnM2vJ6cFT9UVpMJ3U54S3OUZABkPveVCEE6bWmxHKSwop94pxm0qibGXlXf8IHlcZeAn59ZiOYRncoJwFOYg2cRt5qxFsYI+ACwsKOdx8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X2QzD3Fqwzfby6;
	Mon,  9 Sep 2024 20:25:44 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A762140336;
	Mon,  9 Sep 2024 20:27:54 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 20:27:53 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <sagi@grimberg.me>, <mgurtovoy@nvidia.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<dennis.dalessandro@cornelisnetworks.com>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH v2 2/2] IB/qib: Remove unused declarations in header file
Date: Mon, 9 Sep 2024 20:14:08 +0800
Message-ID: <20240909121408.80079-3-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240909121408.80079-1-zhangzekun11@huawei.com>
References: <20240909121408.80079-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500003.china.huawei.com (7.202.181.241)

The definition of qib_rc_rnr_retry() has been removed since
commit b4238e70579c ("IB/qib: Use new rdmavt timers"). Also, the definition
of mr_rcu_callback() has been remove since commit 7c2e11fe2dbe ("IB/qib:
Remove qp and mr functionality from qib"). So, let's remove the unused
declartions.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/infiniband/hw/qib/qib_verbs.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_verbs.h b/drivers/infiniband/hw/qib/qib_verbs.h
index 07548fac1d8e..408fe1ba74b9 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.h
+++ b/drivers/infiniband/hw/qib/qib_verbs.h
@@ -303,8 +303,6 @@ int qib_check_send_wqe(struct rvt_qp *qp, struct rvt_swqe *wqe,
 
 struct ib_ah *qib_create_qp0_ah(struct qib_ibport *ibp, u16 dlid);
 
-void qib_rc_rnr_retry(unsigned long arg);
-
 void qib_rc_send_complete(struct rvt_qp *qp, struct ib_header *hdr);
 
 int qib_post_ud_send(struct rvt_qp *qp, const struct ib_send_wr *wr);
@@ -312,8 +310,6 @@ int qib_post_ud_send(struct rvt_qp *qp, const struct ib_send_wr *wr);
 void qib_ud_rcv(struct qib_ibport *ibp, struct ib_header *hdr,
 		int has_grh, void *data, u32 tlen, struct rvt_qp *qp);
 
-void mr_rcu_callback(struct rcu_head *list);
-
 void qib_migrate_qp(struct rvt_qp *qp);
 
 int qib_ruc_check_hdr(struct qib_ibport *ibp, struct ib_header *hdr,
-- 
2.17.1


