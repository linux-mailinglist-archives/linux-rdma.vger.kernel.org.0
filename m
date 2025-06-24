Return-Path: <linux-rdma+bounces-11584-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8599CAE6589
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BB44C166A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C4299AAA;
	Tue, 24 Jun 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IA3Uemvt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63E5298CA3;
	Tue, 24 Jun 2025 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769565; cv=none; b=IyivDFRXbPQNIXZV0j/x6ayx2ZH3K2oxTiQsscZSRvXo9em3ijcH3GkC0iCutQULyZRaInVNTBGfSNwhrJyjuAlXV5EDs82sz5koXhGkfx+jX62mtKo/mhnFVClpxsTaaLKobWMrO7an2GsrfKVyHDnw/b4xbn5XSlz3Xz1qKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769565; c=relaxed/simple;
	bh=A3iIGJBT3X1+DuMnN95D4/NqCwhqBq742CYeJ+B+xxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuHJlYcX4mI3n47c1MsQ10qwuWXjlxBkb7CK2b0kacye4Ob8zIgx1Q03sZnNqh+R91ruWSek+DV5hAqU15GRHq97ABzAOHu4ESBoyQ+Pj3XwCDd8UkV5CnFTYnjyTUK+bTGHoMvmDHtC1/Kawb5NZSvDIzRqmHdywYDnN0ZqLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IA3Uemvt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bc/HWfWkhZSMC2qiF4fhIz4VvrFHhX9An+Rp3Ek3+ew=; b=IA3UemvtpnD0PItXfgJQVkya/e
	g4Nv+71ruNdaI/2iCUbQtYVE7c1OUGs5SK/KWcgGRAPZXlApgDiHW4EG4pi4gYPCihb4G2Jn+2eNg
	Ck26H6spUMMTkwe+qNnRTHV4qel/cTDBErIXyuhm/3FiKzsxm5yvLdca99X/me3wGi1VbeNeiFXuJ
	8SuDnNXJRbbeZ6pZKQ/lvg4UB+BSURf/djvXDcQBm6+tnlX8BVKNkcu97UIKECSHBurplUXcRWiZy
	IuzBTubJZmIbVocEK2oqfQpOn7SRHRGjWRypx6+Fya2+Z78cX9WZu3PXhAwHBWbu4ihpnraSkXKy0
	6aB7RSKw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU38h-00000005dtz-2ssk;
	Tue, 24 Jun 2025 12:52:40 +0000
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
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] RDMA/srp: don't set a max_segment_size when virt_boundary_mask is set
Date: Tue, 24 Jun 2025 14:52:27 +0200
Message-ID: <20250624125233.219635-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250624125233.219635-1-hch@lst.de>
References: <20250624125233.219635-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

virt_boundary_mask implies an unlimited max_segment_size.  Setting both
can lead to data corruption because __blk_rq_map_sg() can split requests
so that the virt_boundary_mask is not respected if max_segment_size is
not UINT_MAX.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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


