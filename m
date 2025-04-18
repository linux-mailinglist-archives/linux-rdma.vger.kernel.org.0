Return-Path: <linux-rdma+bounces-9592-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2C3A93B82
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 18:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3C51B63211
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A23217654;
	Fri, 18 Apr 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="TQuw6YfR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827661DED51;
	Fri, 18 Apr 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995540; cv=none; b=KyQnKL3vDyiF5qv3fmkuccOxpKbq/GXg2Hnv1roNWEJIMh1D/VW+i21nH/yd9ZyMbf8PQtSaO9oUuqzyVxtadU8CjjFeAkJ6L2xoK0hlYD9+pPH535GpQ3IBZcqH8nVEunKQG2LGDdr8OJfU5AdWepdWfEfeo1I25g5ckxYiL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995540; c=relaxed/simple;
	bh=YuieveFQEJfb2rcfvgxQOFP+2Ifx7N0h6QGFaucg3y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/eAtoeMywB1m2dFspw8Myxl8t0OWOAYp62R0C4aIyGb3TyUhtEeRSDAZTmHxfJpZN8Eyi+mSFJ58Nc1lYBIvzPYeW57IJ4O1yIGqjpzZaF6meh4gB9ZEUCP/C226BPVZXLfLIxP4wRCf60mdusyJ1MjGW63juKLUzTDnt5iaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=TQuw6YfR; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=/OgtTc412tjBo6QhgpjDnYCLoiKFP5p333DRr7idVO8=; b=TQuw6YfRDeyhwnlP
	sTYM8Y34XBM+UbZGH5QCxUvG/Ahhls1WvC7iOb2PdzwPTNDe5G3xKj5LuWSdFspRfpkhzzaTaAKxw
	3GadZFz2xQEA24M/+zknCmpvQoq0/FjpU0nTTFHAQEy1l5Ntm8iB5gJF8wXrHIpIjxumHiSqwGAg/
	JMeCTEx8T/pFt5VNMhMMhrWUGfsJNgPd9u+kB30q0Tyovc2hY6nkiBQF/Un1MigDJywnPPyGL2mhX
	074CX/637VcoUwCKR91AzhDobixDKHdcPggqIA61MPPYDs2vTkShpO0sJOzZLR1FiDn1y0SfqKYzn
	Oq+pcyZFRI0aLDrQTQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u5p3A-00CYD3-23;
	Fri, 18 Apr 2025 16:58:48 +0000
From: linux@treblig.org
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] RDMA/cma: Remove unused rdma_res_to_id
Date: Fri, 18 Apr 2025 17:58:48 +0100
Message-ID: <20250418165848.241305-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of rdma_res_to_id() was removed in 2020 by
commi t211cd9459fda ("RDMA: Add dedicated CM_ID resource tracker function")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/infiniband/core/cma.c | 13 -------------
 include/rdma/rdma_cm.h        |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index ab31eefa916b..e6cc289fd859 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -146,19 +146,6 @@ struct iw_cm_id *rdma_iw_cm_id(struct rdma_cm_id *id)
 }
 EXPORT_SYMBOL(rdma_iw_cm_id);
 
-/**
- * rdma_res_to_id() - return the rdma_cm_id pointer for this restrack.
- * @res: rdma resource tracking entry pointer
- */
-struct rdma_cm_id *rdma_res_to_id(struct rdma_restrack_entry *res)
-{
-	struct rdma_id_private *id_priv =
-		container_of(res, struct rdma_id_private, res);
-
-	return &id_priv->id;
-}
-EXPORT_SYMBOL(rdma_res_to_id);
-
 static int cma_add_one(struct ib_device *device);
 static void cma_remove_one(struct ib_device *device, void *client_data);
 
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 8a8ab2f793ab..d1593ad47e28 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -388,6 +388,5 @@ void rdma_read_gids(struct rdma_cm_id *cm_id, union ib_gid *sgid,
 		    union ib_gid *dgid);
 
 struct iw_cm_id *rdma_iw_cm_id(struct rdma_cm_id *cm_id);
-struct rdma_cm_id *rdma_res_to_id(struct rdma_restrack_entry *res);
 
 #endif /* RDMA_CM_H */
-- 
2.49.0


