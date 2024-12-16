Return-Path: <linux-rdma+bounces-6535-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9299F2D9C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 11:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE1A18845D4
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D639202C4E;
	Mon, 16 Dec 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Unc6/rem"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D2202C47
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343195; cv=none; b=aiR+OmcM+eFgYP7XP/sZZnSQTPpyh4gPh0kF/N+hKP4I9bHHcOwTGRtrk+TgON83LDDq+gb7rwT8nm3sHP6HBRkAHvDtwkNbHvweYUo5n5ZPT7va4oaLRTJ8wiXItMYmQ76Vf6EpiZXAwqZNsC+4s45Gq5H/cAHjUwZjK76xpos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343195; c=relaxed/simple;
	bh=Kz2Cz4xXyqqOVI8c2RbvbXyNjFWqxi9UxkpAys98eIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+jKCv74gNuH+p/vRRQ07v2IAPtXtctrCdnwrM/9wfUU/XTz7WxV31HcfA7QQZJmf0/wZRuuR8iDipLyywrfHtxaPrkh4TqfOW6LWIB4XCNTVyENeYkRDms+kQD7M5V+FrQuY23uZ8ovL39oQX7l8PJCQTDymUM+QWhjUFgAVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=Unc6/rem; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6qAF9020773
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 01:59:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=facebook; bh=f
	0d7e7vgSwFquFJynHv37WoE8Ih8RaPc8Rz59bR6mwY=; b=Unc6/remm63njyGu+
	jvXAH/eC6QlxeDqvT4mzSWtw5al3moX2Llllk0Aovi9s7cewco6JGQgL4GQNu7qs
	0B7JdPrcB6JWWhGbQT/ZqcuRx4OU4SuUOWsraHjPpJ19aN3QlCxGbgB7o9EWD+NA
	w2DmC2vtNGVJ5R8JurvBo7I2nE=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43jfa28u1a-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 01:59:53 -0800 (PST)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 16 Dec 2024 09:59:39 +0000
Received: by devvm12370.nha0.facebook.com (Postfix, from userid 624418)
	id C682310A1F701; Mon, 16 Dec 2024 01:59:27 -0800 (PST)
From: Wei Lin Guay <wguay@fb.com>
To: <alex.williamson@redhat.com>, <dri-devel@lists.freedesktop.org>,
        <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC: <jgg@nvidia.com>, <vivek.kasireddy@intel.com>, <dagmoxnes@meta.com>,
        <kbusch@kernel.org>, <nviljoen@meta.com>,
        Wei Lin Guay <wguay@meta.com>
Subject: [PATCH 1/4] vfio: Add vfio_device_get()
Date: Mon, 16 Dec 2024 01:59:15 -0800
Message-ID: <20241216095920.237117-2-wguay@fb.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241216095920.237117-1-wguay@fb.com>
References: <20241216095920.237117-1-wguay@fb.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: H2dMckEVUj5XI1_6bbJ0hVGgO7VAoQZ1
X-Proofpoint-ORIG-GUID: H2dMckEVUj5XI1_6bbJ0hVGgO7VAoQZ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Jason Gunthorpe <jgg@nvidia.com>

Summary:
To increment a reference the caller already holds. Export
vfio_device_put() to pair with it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Wei Lin Guay <wguay@meta.com>
Reviewed-by: Dag Moxnes <dagmoxnes@meta.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Nic Viljoen <nviljoen@meta.com>
---
 drivers/vfio/vfio_main.c | 1 +
 include/linux/vfio.h     | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index a5a62d9d963f..7e318e15abd5 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -171,6 +171,7 @@ void vfio_device_put_registration(struct vfio_device =
*device)
 	if (refcount_dec_and_test(&device->refcount))
 		complete(&device->comp);
 }
+EXPORT_SYMBOL_GPL(vfio_device_put_registration);

 bool vfio_device_try_get_registration(struct vfio_device *device)
 {
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 000a6cab2d31..d7c790be4bbc 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -279,6 +279,12 @@ static inline void vfio_put_device(struct vfio_devic=
e *device)
 int vfio_register_group_dev(struct vfio_device *device);
 int vfio_register_emulated_iommu_dev(struct vfio_device *device);
 void vfio_unregister_group_dev(struct vfio_device *device);
+void vfio_device_put_registration(struct vfio_device *device);
+
+static inline void vfio_device_get(struct vfio_device *device)
+{
+	refcount_inc(&device->refcount);
+}

 int vfio_assign_device_set(struct vfio_device *device, void *set_id);
 unsigned int vfio_device_set_open_count(struct vfio_device_set *dev_set)=
;
--
2.43.5

