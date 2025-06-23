Return-Path: <linux-rdma+bounces-11531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3173AAE37BD
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 10:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF801888773
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 08:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A8D1FE46D;
	Mon, 23 Jun 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PkCA/KIj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61BB1F873B;
	Mon, 23 Jun 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750665819; cv=none; b=KOGZkwSYe/g4Swr0g2in8SrOKY4XqiRtWpg+mgY7o7rRwdhQCALRCE1KFuFs7wB+++Y6Bahcnn8vr9Kc0Nw5M7er0f9XI7y8jVmYwc2EZ4lvFRTVUe0Rpb0OuaFyYr8XcdpvZi418SwDLE7lF1mF4gqE8xXSYwXHGRrCaE8YkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750665819; c=relaxed/simple;
	bh=RryDxMP6phDoHxOFe7njIFJUFEt+81x4OCWvS7YI6tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhLRiJzBS44wjd84V6Kq31twU4+L3OIVaAUy9g8Cdz+T4SKNAsdxoL15/xUS25/3FuiXJ8/L9dNOxzSSimTpHKpmCcSsO8URMHVktu4Nr/XQu4yqJ2cfLd+Vp7pNVJLNmrLiYidw409B1DVLXrX0NjYGPuMw78XxGZ2Jix5VYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PkCA/KIj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4KXgel8fCtzMQNCq58h1yqjjwTpBLjsS8T72jqNXmaI=; b=PkCA/KIjRagfSaE/9Pf9deAEYj
	2wY0IbTURSoAyixidSTH+yYyBsWQ5VeFJjWvge4qDVfe5CzfJslCHp03LnZ9nqqMVASKK7Fh9rfV8
	ukV94sNbU7QHR4johtpbH28AdY7Zg9RvG5H//zkUy0ZXeYn3YrEpxkSHOH6ipPWJlEWSIhQ1/j/3C
	RFl+5c9r+N2AalqeHXI6RcLYL1ygPVPSoiis3s5K+MgBd/Yi4LjJd5tbSiAx5+WI8C2NZVgISVeYI
	45wyPmDKaaNBVapRxXmPfjiPZch2B1JbnyhYORT67iJE3niCIisHjPzB7Cltbf9r6k/xHyfTHJTaZ
	nTgEG/3g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTc9M-00000001wy7-2E3O;
	Mon, 23 Jun 2025 08:03:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"Ewan D. Milne" <emilne@redhat.com>,
	Laurence Oberman <loberman@redhat.com>,
	linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] RDMA/srp: don't set a max_segment_size when virt_boundary_mask is set
Date: Mon, 23 Jun 2025 10:02:53 +0200
Message-ID: <20250623080326.48714-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250623080326.48714-1-hch@lst.de>
References: <20250623080326.48714-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

virt_boundary_mask implies an unlimited max_segment_size.  Setting both
can lead to data corruption, and we're going to check for this in the
SCSI midlayer soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 1378651735f6..23ed2fc688f0 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3705,9 +3705,10 @@ static ssize_t add_target_store(struct device *dev,
 	target_host->max_id      = 1;
 	target_host->max_lun     = -1LL;
 	target_host->max_cmd_len = sizeof ((struct srp_cmd *) (void *) 0L)->cdb;
-	target_host->max_segment_size = ib_dma_max_seg_size(ibdev);
 
-	if (!(ibdev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG))
+	if (ibdev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
+		target_host->max_segment_size = ib_dma_max_seg_size(ibdev);
+	else
 		target_host->virt_boundary_mask = ~srp_dev->mr_page_mask;
 
 	target = host_to_target(target_host);
-- 
2.47.2


