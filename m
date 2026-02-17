Return-Path: <linux-rdma+bounces-16961-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MUmF6axlGlbGgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16961-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 19:21:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0114F028
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 19:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAF39300E26D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E0436C5A5;
	Tue, 17 Feb 2026 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDmEA0zX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD76372B2B
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352481; cv=none; b=czV5IFSAX1Z/vIW6TwYGGi2Xk8KWl5607GbQLY4MMjWZV3CY7LC1Hs8PC3AZdAGDPnEXdmfdVCwr6IzsuefaQL2K6VgwZYNew4b8kQn5B9A7czCutWthd0oeg/Kgz551kdWiPllKZCu8dTBuDbueinZEZj8SsmF9XlTkz2q4jM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352481; c=relaxed/simple;
	bh=tkW2t/emyMtEnA0bff0sfxbh9fp7KLe78Qrb5CP0dEY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sZJyDABUn9qM3nRnC7NKaxb0WamVCZBS4Dr1wp8jmldSBeJxXQm8UezHhEwjbY6LKK6ar15FRFvYG2pst06t4T6L9uvvZh2atnTQAbROR7k/Uc/94cxbz7b38VfeRiemREIJ9svZPeIrlp9H+3n3hnuWtKUsnVvJoUWMA+nhWBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDmEA0zX; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-506ae021853so260122591cf.1
        for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 10:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771352479; x=1771957279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Hgz8BnhPcwy9lGGJG2HDF6wOO7DpKVWOdghnr69lDM=;
        b=zDmEA0zXvuKS2BLirXyXx+vq3r9XXnuxPYosP0BqnhVnmHNjaorsF+MaJp5bvGZljm
         dWQ6FYD2QQWy6amlyFtVQr6n4hcrR4/Px9qRHBZVZ45OiTvb0DohsZtJHL14/ugM5PMl
         W2STdZqIshnU8HIciPPvK7WFalZR9cOChDsrf1ncNbcacJ1TCwK1dQD/kbygGaYDVyYE
         LLijbUiVoDAS0Zylon+ijbGqgIMVBV1ijxKn8/LWU9wqObXhxO98dmDnd486rIvlt1ss
         puWo3vT+yYXXIqgpDFmS33N9ukEkDpbxaTa/i11GmortefEM0o8Wz0usUGdQDv5NPApP
         GVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771352479; x=1771957279;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Hgz8BnhPcwy9lGGJG2HDF6wOO7DpKVWOdghnr69lDM=;
        b=pJjvzR4SIm9OOuqgFOnV6ddcfVgQKyrsDAy24m21AYwHxehS77qAjBmUpNy1o7J/is
         CsnUZ7a6s2ix2vcOnJTAGrmD+u6GfhumgaOSjbap7NjJHsTvmmK0YGm/j8ixQsU6n5aB
         DfYS2xokBSppzJYvgWEEM6F2dEgY1+OC9e7ZrMVv4DD3RN4Y7g0GYp/7EyOm17De5beB
         BW2PuqQvhZmnrPPptl1TPQWwxOlH8l+k9ISJzlBrmRGWyXA2rL79kmF7HHoBAc7tUalP
         1Uc5s81ORBelU0aSNqjLYTRCvdkKzAhWsivLvt62KLxPq2wilcXXBddZL7a8+ifLWZR8
         /sjQ==
X-Gm-Message-State: AOJu0YyRWC2/LIB/scVD3z7qxQofWk1y6SsDn176Fn+x0RUrFJY4FQcQ
	H0RSlT/zSe9P3oBvqkL2unx0bVjrlgwPBkRfpnIEDq7acTH4YSdFw0WIUF8OFzAUcVw6jod6L+r
	oxsvzlHq1RA==
X-Received: from qtku10.prod.google.com ([2002:a05:622a:17ca:b0:502:b163:10cd])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:5994:0:b0:4ed:aeaa:ec4d
 with SMTP id d75a77b69052e-506a8379f4dmr206169251cf.77.1771352478224; Tue, 17
 Feb 2026 10:21:18 -0800 (PST)
Date: Tue, 17 Feb 2026 18:21:15 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217182116.1726438-1-jmoroni@google.com>
Subject: [RFC] RDMA/irdma: Add support for revocable dmabuf import
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16961-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0E0114F028
X-Rspamd-Action: no action

In order to import a dmabuf from VFIO, the importer must support
revocation. This is achieved by providing a move_notify callback
that will cause the region to be invalidated in hardware prior to
calling ib_umem_dmabuf_unmap_pages. The mkey and data structures
are not freed until the user explicitly deregisters the region,
but the HW will no longer access the memory (any attempt would
result in an AE for the QP just like a normal dereg mr).

Tested with VFIO by triggering a VFIO_DEVICE_RESET while the
region is registered to ensure the callback is executed.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 78 ++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index cf8d19150..157e1413d 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
+#include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 
 /**
  * irdma_query_device - get device attributes
@@ -3590,6 +3592,44 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	return ERR_PTR(err);
 }
 
+static int irdma_hwdereg_mr(struct ib_mr *ib_mr);
+
+static void irdma_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
+{
+	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
+	struct irdma_mr *iwmr = umem_dmabuf->private;
+	int err;
+
+	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
+
+	if (!iwmr)
+		return;
+
+	/* Invalidate the region in hardware, but do not release the key yet.
+	 * This will either invalidate the region or issue a reset. Either way,
+	 * the HW will no longer touch the region after. If successful, the
+	 * region is marked as invalidated so that the real dereg MR later ends
+	 * up skipping the HW request.
+	 */
+	err = irdma_hwdereg_mr(&iwmr->ibmr);
+	if (err) {
+		struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
+
+		ibdev_err(&iwdev->ibdev, "dmabuf mr invalidate failed %d", err);
+		if (!iwdev->rf->reset) {
+			iwdev->rf->reset = true;
+			iwdev->rf->gen_ops.request_reset(iwdev->rf);
+		}
+	}
+
+	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+}
+
+static struct dma_buf_attach_ops irdma_dmabuf_attach_ops = {
+	.allow_peer2peer = 1,
+	.move_notify = irdma_dmabuf_invalidate_cb,
+};
+
 static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 					      u64 len, u64 virt,
 					      int fd, int access,
@@ -3599,7 +3639,7 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 	struct irdma_device *iwdev = to_iwdev(pd->device);
 	struct ib_umem_dmabuf *umem_dmabuf;
 	struct irdma_mr *iwmr;
-	int err;
+	int err = -1;
 
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -3607,31 +3647,43 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
-	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd, access);
+	umem_dmabuf = ib_umem_dmabuf_get(pd->device, start, len, fd, access,
+					 &irdma_dmabuf_attach_ops);
 	if (IS_ERR(umem_dmabuf)) {
 		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%pe]\n",
 			  umem_dmabuf);
 		return ERR_CAST(umem_dmabuf);
 	}
 
+	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
+
+	err = ib_umem_dmabuf_map_pages(umem_dmabuf);
+	if (err)
+		goto err_map;
+
 	iwmr = irdma_alloc_iwmr(&umem_dmabuf->umem, pd, virt, IRDMA_MEMREG_TYPE_MEM);
 	if (IS_ERR(iwmr)) {
 		err = PTR_ERR(iwmr);
-		goto err_release;
+		goto err_alloc;
 	}
 
 	err = irdma_reg_user_mr_type_mem(iwmr, access, true);
 	if (err)
 		goto err_iwmr;
 
+	umem_dmabuf->private = iwmr;
+
+	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
+
 	return &iwmr->ibmr;
 
 err_iwmr:
 	irdma_free_iwmr(iwmr);
-
-err_release:
+err_alloc:
+	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+err_map:
+	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 	ib_umem_release(&umem_dmabuf->umem);
-
 	return ERR_PTR(err);
 }
 
@@ -3923,7 +3975,19 @@ static int irdma_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 		goto done;
 	}
 
-	ret = irdma_hwdereg_mr(ib_mr);
+	if (iwmr->region && iwmr->region->is_dmabuf) {
+		struct ib_umem_dmabuf *udb = to_ib_umem_dmabuf(iwmr->region);
+
+		dma_resv_lock(udb->attach->dmabuf->resv, NULL);
+		/* Could have already been invalidated, but it's okay. */
+		ret = irdma_hwdereg_mr(ib_mr);
+		ib_umem_dmabuf_unmap_pages(udb);
+		udb->private = NULL;
+		dma_resv_unlock(udb->attach->dmabuf->resv);
+	} else {
+		ret = irdma_hwdereg_mr(ib_mr);
+	}
+
 	if (ret)
 		return ret;
 
-- 
2.53.0.310.g728cabbaf7-goog


