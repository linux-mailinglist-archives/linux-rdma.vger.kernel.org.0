Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E086C1786EA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 01:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgCDAOI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 19:14:08 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15449 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgCDAOH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Mar 2020 19:14:07 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5ef2c10000>; Tue, 03 Mar 2020 16:13:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 03 Mar 2020 16:14:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 03 Mar 2020 16:14:07 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Mar
 2020 00:14:03 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Mar 2020 00:14:03 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e5ef2ca0004>; Tue, 03 Mar 2020 16:14:03 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <dri-devel@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <nouveau@lists.freedesktop.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v3 2/4] nouveau/hmm: check for SVM initialized before migrating
Date:   Tue, 3 Mar 2020 16:13:37 -0800
Message-ID: <20200304001339.8248-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304001339.8248-1-rcampbell@nvidia.com>
References: <20200304001339.8248-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583280833; bh=0xBoXNdw36zdi+oexlXq9iRpMr1fMPzGbKsYihdGgx4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=XfgFUH9Tk+atQQftWclcctJpBwUAfYF2j5ty2Mea930/qWVISDDiPyGXHOvllUFWm
         3zdlYDJdKrexCxDldPaXaHUi9gRo1hEo7IbYXL9tEBQDyjDS3Sl/Q8TO0jay+txNRb
         abqKn+TRhne7BH8nIteK4k5Lk1+2XnU6ImnwQpcL7pnwBC81ehYlsFA5ySq+QNHQ57
         RtDeEPZ5BsbXbedgwtxKaYcso7iVPkc6b8xR5REsaz8PWDsVl/b9fWb5aexJWEodP2
         S15s0I6xbAI7Ze1SGlGmbnc1CmAt0RlumY7vtL0MTmjFKYsMGuFwvhzP90O9Az8DJe
         RaDjBgcYvnL1g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When migrating system memory to GPU memory, check that SVM has been
enabled. Even though most errors can be ignored since migration is
a performance optimization, return an error because this is a violation
of the API.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index 169320409286..c567526b75b8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -171,6 +171,11 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
 	mm =3D get_task_mm(current);
 	down_read(&mm->mmap_sem);
=20
+	if (!cli->svm.svmm) {
+		up_read(&mm->mmap_sem);
+		return -EINVAL;
+	}
+
 	for (addr =3D args->va_start, end =3D args->va_start + size; addr < end;)=
 {
 		struct vm_area_struct *vma;
 		unsigned long next;
--=20
2.20.1

