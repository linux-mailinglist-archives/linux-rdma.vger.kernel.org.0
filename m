Return-Path: <linux-rdma+bounces-3451-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C043691532C
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 18:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F13B23943
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702719D8AB;
	Mon, 24 Jun 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GyfBdnSC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA419DF58
	for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245421; cv=none; b=q0NMyUrTVKlBe/eDETx788zSK+8xhwDT36jweyNDEgfFj+rRYe0Ady7O1pyI6und9z7BmNZ7/RHVnqZiOeBJZbUNanPQ2URukWiXcpRgQiRD2I/UVu4f7Q3dwRHwUPVBetpRqrH1vmk3RExg5SPQVF1EKpE/yp1cWcIg+D6Ud/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245421; c=relaxed/simple;
	bh=IWlLiawu5tGMzm2/6X7LyAG28dhMKaSTlSYYwUQQfGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o22nvyIGV2dEpESE89Y/7fPHaVGjnqkU/VMFihX4U4seX7V/NDFxQqxXvSnJ/2gWysJ3KMntbtSRwVVoOz88ZKnaONRuPex9Se1C8Pl1NRi7B+7CWm3i85kFYsDbvW+4ww5WK0gzM9V62o0qAa10+aaHvcFtmbAN8zEM96Hhd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GyfBdnSC; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719245420; x=1750781420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l/JasX8qkbDdeYZ3JLL00arLOXOjQmeIBMCfYPDXjV0=;
  b=GyfBdnSCzWWTWS9XszqcdHnoGJmMLxhC8lfcao/0AYCzfliGKoJkY3is
   1MVOcXdom9m4/xHB1ILE2b7nG/1+uM0JwFVlIFghpAvZZLg8bh7pGC9zv
   ueYehQvbhG3teqZr3aMxrYIgBFPE7Ztc1i4TBW/MDaZ4rZa34Phpu7tbm
   M=;
X-IronPort-AV: E=Sophos;i="6.08,262,1712620800"; 
   d="scan'208";a="415408816"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:09:26 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:41962]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.61:2525] with esmtp (Farcaster)
 id 4adeb5e0-f8f1-441a-86ee-398ba8e45a94; Mon, 24 Jun 2024 16:09:24 +0000 (UTC)
X-Farcaster-Flow-ID: 4adeb5e0-f8f1-441a-86ee-398ba8e45a94
Received: from EX19D019EUA002.ant.amazon.com (10.252.50.84) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:24 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D019EUA002.ant.amazon.com (10.252.50.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 24 Jun 2024 16:09:24 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.252.134.102) with Microsoft
 SMTP Server id 15.2.1258.34 via Frontend Transport; Mon, 24 Jun 2024 16:09:23
 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
	"Yonatan Nachum" <ynachum@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: [PATCH for-next 3/5] RDMA/efa: Validate EQ array out of bounds reach
Date: Mon, 24 Jun 2024 16:09:16 +0000
Message-ID: <20240624160918.27060-4-mrgolin@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240624160918.27060-1-mrgolin@amazon.com>
References: <20240624160918.27060-1-mrgolin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Yonatan Nachum <ynachum@amazon.com>

When creating a new CQ with interrupts enabled, the caller needs to
specify an EQ index to which the interrupts will be sent on, we don't
validate the requested index in the EQ array.
Validate out of bound reach of the EQ array and return an error.

This is not a bug because IB core validates the requested EQ number when
creating a CQ.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index cd1f735d08a7..9c3e476e3f9c 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1046,7 +1046,7 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 static struct efa_eq *efa_vec2eq(struct efa_dev *dev, int vec)
 {
-	return &dev->eqs[vec];
+	return vec < dev->neqs ? &dev->eqs[vec] : NULL;
 }
 
 static int cq_mmap_entries_setup(struct efa_dev *dev, struct efa_cq *cq,
@@ -1173,6 +1173,11 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	params.set_src_addr = set_src_addr;
 	if (cmd.flags & EFA_CREATE_CQ_WITH_COMPLETION_CHANNEL) {
 		cq->eq = efa_vec2eq(dev, attr->comp_vector);
+		if (!cq->eq) {
+			ibdev_dbg(ibdev, "Invalid EQ requested[%u]\n", attr->comp_vector);
+			err = -EINVAL;
+			goto err_free_mapped;
+		}
 		params.eqn = cq->eq->eeq.eqn;
 		params.interrupt_mode_enabled = true;
 	}
-- 
2.40.1


