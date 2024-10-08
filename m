Return-Path: <linux-rdma+bounces-5317-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3269C995459
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D729B1F21E53
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3681E0DD6;
	Tue,  8 Oct 2024 16:25:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.qrator.net (mail.qrator.net [178.248.233.8])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB781E0DBF;
	Tue,  8 Oct 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.248.233.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404715; cv=none; b=eFH/yBpsC86LokJ2o+/rNlETAnIjn2uDGCe2kwHCAAnVzAXFEYLXHI0d2zbiFZOeYvIxdggbVzcabL2zN/0ozTomqJrQ0q7/SRQ211N5vdVgwLbi3tRSN5IGhJlVtZiSCf2jHL6db3wAtwyObqXh/u+sfe9JnkulHHRmWfjj49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404715; c=relaxed/simple;
	bh=7pgNhZBvfXc3wbG0Sp9K8Qy2J/CP6yQS2O5ZoGMt4Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIV+oiBI2ZocO9ePjwaGsVoQ3d8qQGmOgeuTV4ZImy78dnD678CEn25tlCKrjZmBvgXX6j7/DfbJjvYhAMhbUj25OjwkxyLg3cWjIldEWYQwvMTY657pj5lhKBu1yximWrF0Vnym/IkqUfmhxPvibu6wir0YTTGn9SuQIigRzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; arc=none smtp.client-ip=178.248.233.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Received: from localhost.localdomain (unknown [10.0.0.0])
	by mail.qrator.net (Postfix) with ESMTP id 8A26F88024B9;
	Tue,  8 Oct 2024 19:19:15 +0300 (MSK)
From: Alexander Zubkov <green@qrator.net>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	green@qrator.net
Subject: [PATCH] Fix misspelling of "accept*" in infiniband
Date: Tue,  8 Oct 2024 18:19:13 +0200
Message-ID: <20241008161913.19965-1-green@qrator.net>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is "accept*" misspelled as "accpet*" in the comments.
Fix the spelling.

Signed-off-by: Alexander Zubkov <green@qrator.net>
---
 drivers/infiniband/hw/irdma/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 36bb7e5ce638..ce8d821bdad8 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -3631,7 +3631,7 @@ void irdma_free_lsmm_rsrc(struct irdma_qp *iwqp)
 /**
  * irdma_accept - registered call for connection to be accepted
  * @cm_id: cm information for passive connection
- * @conn_param: accpet parameters
+ * @conn_param: accept parameters
  */
 int irdma_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 {
-- 
2.46.0


