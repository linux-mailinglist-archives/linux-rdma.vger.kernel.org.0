Return-Path: <linux-rdma+bounces-11530-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A9EAE37B8
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 10:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B46B1894376
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 08:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545D2135C5;
	Mon, 23 Jun 2025 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zAnM7djq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC762101AE;
	Mon, 23 Jun 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750665815; cv=none; b=Dxub1y4z0RjIT/S6Toz+m3xEt/n6295X/ZLzAEdVRf1jotW7HH3WM/Y3mI8TFUEpQlo2MwkLTrJpqPkS29n3wWnag/reO6WpUtA+0kU5x2Att9WvCCe4RK8OIARyQ5/Vwg+Gzx7agYxFidxyztTwPDnFvLJqR80IBKuuhs4IoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750665815; c=relaxed/simple;
	bh=e0ktP2iwVr4FvXesAqg1Sk7r9UahGrfTEMU18baZE6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2+GVWJbDNHY5dnKxmftqv5JU0C0W92Sbcn1pmN4RPEpGb6Z0+vmNmq9F1oXbFNqxNxp9rjrDYPar9A3wnhMnuqrr9twS/g6SR0phgmC1l0sP5It9W/IDBEmhbGVhRHBM7+NlPxqC5qaS6avbq7+phAdojrOkgY1mn7FshaTj2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zAnM7djq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=eTsxtf4UZCnslU6UBLjKAuF8MnH+LixRASR1F/VfA9k=; b=zAnM7djquzUYezeWaUbyOn6dJM
	UZK5tKTrNOFN9jb9+gVqpPFEq0LAQMLy3nPezOW/Qu4XtoJhCLWSgpFO1BA90NGZiLg0jEvIYzHjk
	CPy4oDI32iIyCvhr4/GzPZJdDwacGUlAZQEt4NATjFv+ds2To+cNRJkGfTaN+NSiS0waQpoTEZ2Sv
	wuESEBG3kKnv0wvRebDSu1sZeIGaUtFyXbeLqdBKRcMyz+WPdVCiB+MUzEGQ7QiYhDG6CcE8dI5Pe
	w5InQSXxJdDkfpVArOUWDqTL12A5kc0PRZv8NysohxX7TFElfn/UNSJQoeIQXN0xQ67kd7PBtADqi
	q4p/GnJA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTc9K-00000001wxz-0Glg;
	Mon, 23 Jun 2025 08:03:30 +0000
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
Subject: fix virt_boundary_mask handling in SCSI
Date: Mon, 23 Jun 2025 10:02:52 +0200
Message-ID: <20250623080326.48714-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series fixes a corruption when drivers using virt_boundary_mask set
a limited max_segment_size by accident, which Red Hat reported as causing
data corruption with storvsc.  I did audit the tree and also found that
this can affect SRP and iSER as well.

Note that I've dropped the Tested-by from Laurence because the patch
changed very slightly from the last version.

Diffstat:
 infiniband/ulp/srp/ib_srp.c |    5 +++--
 scsi/hosts.c                |   20 +++++++++++++-------
 2 files changed, 16 insertions(+), 9 deletions(-)

