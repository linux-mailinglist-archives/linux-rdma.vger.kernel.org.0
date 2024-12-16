Return-Path: <linux-rdma+bounces-6529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3909F2D7F
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 10:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6373718854E7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EC5202F76;
	Mon, 16 Dec 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RrP+Yr1L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73D202C21
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342966; cv=none; b=rFTl0sMPeBvWIq4/gQAJS0n0oTy/tzMIPrTLwePkFjb7T/SuprU1xTXRpcdU/OZAErQkOxASvYpY5/78Jq0nLXBKxZGN0WEAdrqRW3XiUV8FKpwDkIiF9nmrmg0PBTNQNXFleoGbR0msw0PBb0bP5SZW4skHk6ujo0cf9rtQouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342966; c=relaxed/simple;
	bh=5P1uqXyO4EerMfJMg5b6+ZEycfMz4MOJsVkFcXjJvCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0HwHGRAe7yRM/AWK+wz6S/hYVIWOo/ZqiFaAjXWAR7EBCnkDqHXBEjmhR34IKHZFX2D8UFAccQZnmCR+O1GKiWCO9ayh+VLeaXJF9frfS1CKicC/A2Olddj9s7eBYJH/ySIBoMbDAx3IQRPBY+7IGvl3tfCyF1q4qTUDndFBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=RrP+Yr1L; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6pHO0018658
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 01:56:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=X
	F5WtkBONmd+8r9yLmklM/sXmsTbxQzH7Qh2X2Sk4Zo=; b=RrP+Yr1LRubVDm2Ud
	lnNI/6thSJP4K/pTCg4xrH0mQrhxpe83oMQ9n0hNMCJ/cOZ38tgDHaTPli9NdmyB
	HSOIkRMO/GvhfvQLX0UGL43Ikq9kPYNMWDtJ0LDshc3hELIesDcUjyiA04R87V9X
	ZDV1BjN6ZOdIR/TQY+fIALxnn8=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43jfa28tc0-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 01:56:03 -0800 (PST)
Received: from twshared60378.16.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 16 Dec 2024 09:56:01 +0000
Received: by devvm12370.nha0.facebook.com (Postfix, from userid 624418)
	id D61BA10A1F006; Mon, 16 Dec 2024 01:55:55 -0800 (PST)
From: Wei Lin Guay <wguay@fb.com>
To: <alex.williamson@redhat.com>, <dri-devel@lists.freedesktop.org>,
        <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC: <jgg@nvidia.com>, <vivek.kasireddy@intel.com>, <dagmoxnes@meta.com>,
        <kbusch@kernel.org>, <nviljoen@meta.com>,
        Wei Lin Guay <wguay@meta.com>
Subject: [PATCH 2/4] dma-buf: Add dma_buf_try_get()
Date: Mon, 16 Dec 2024 01:54:16 -0800
Message-ID: <20241216095429.210792-3-wguay@fb.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241216095429.210792-1-wguay@fb.com>
References: <20241216095429.210792-1-wguay@fb.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jthse0yx-k6De40oJQkd80F1BxvIQwHh
X-Proofpoint-ORIG-GUID: jthse0yx-k6De40oJQkd80F1BxvIQwHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Jason Gunthorpe <jgg@nvidia.com>

Summary:
Used to increment the refcount of the dma buf's struct file, only if the
refcount is not zero. Useful to allow the struct file's lifetime to
control the lifetime of the dmabuf while still letting the driver to keep
track of created dmabufs.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Wei Lin Guay <wguay@meta.com>
Reviewed-by: Dag Moxnes <dagmoxnes@meta.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Nic Viljoen <nviljoen@meta.com>
---
 include/linux/dma-buf.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 36216d28d8bd..9854578afecd 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -614,6 +614,19 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags);
 struct dma_buf *dma_buf_get(int fd);
 void dma_buf_put(struct dma_buf *dmabuf);

+/**
+ * dma_buf_try_get - try to get a reference on a dmabuf
+ * @dmabuf - the dmabuf to get
+ *
+ * Returns true if a reference was successfully obtained. The caller mus=
t
+ * interlock with the dmabuf's release function in some way, such as RCU=
, to
+ * ensure that this is not called on freed memory.
+ */
+static inline bool dma_buf_try_get(struct dma_buf *dmabuf)
+{
+	return get_file_rcu(&dmabuf->file);
+}
+
 struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
 					enum dma_data_direction);
 void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_tab=
le *,
--
2.43.5

