Return-Path: <linux-rdma+bounces-14410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF4C50B67
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 07:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50EC73B5DEC
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 06:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3DD2D9EC4;
	Wed, 12 Nov 2025 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZQG0qpQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D3320FAAB;
	Wed, 12 Nov 2025 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928958; cv=none; b=E4jREeujFrr5alZ0d/9KsfeHvQvr/2MTJKsgbfBHmesU19EPSLPiFqEEBkAPD1xBlXKZcCfMvb8tJGPGIjrQQZLlODn/2Hr/E9V0VDI4t5R77ta1/WNnSDHtpkowH90/AHjW0ydHwqhMPWXNJiFqdwnbknn7u4BZgl45fw59SFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928958; c=relaxed/simple;
	bh=JG9x+e5n7R2dZhtSVSqiTD2CUBvVVGzeebp+BBYllpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAANrBDKGIcbTq9dCBRnpgpGtPA4Y9ajQVEGbmsrW3rKulVyTTTVttuka+Ld0uuS4aOrrwp67mk/WTF/wla13L+1v/FHLK+uUn9ePT2WsLntmkbc/rOA4fMu9g0mlGDSP/C1q+1+mix6sZSpKWAD9C4umBSpjn3P+0v9zUAGcxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LZQG0qpQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+qa8gFmdR8BIIHF8YjhgDKCxqeddRDsKLTr6w3bjkdY=; b=LZQG0qpQ2v5DOOTQZJozyvmzz9
	+h4rzynKsI99YJaxQ8Jm74fTWcvCA4eDxD1s3Z9G06ODLoib+qgkuLge3EN6azbyTEWiOwm9h12NF
	WKqhXPFUb/5mGNFG5mXbJG0zeWzrww9aat6S/ldmIcFRqGN8taHcS4p4N7j2z4455rJiDhimd6uey
	2I5c0T2ZxvkdoYg1LniLMGm3IaHGQ/PdC5z5jdOILIAPIFJyy8e/Ps4xvcG1no+qcKotl80wDzawl
	xthpdDszDEQvsJvYNulVHQ9c2zqsaltbD7dc7v6FTIv4oH5B+j0ZW1+TCPQ/miPDbPITvnBM2CtCM
	WSlS41qw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4Lt-00000008COO-22C1;
	Wed, 12 Nov 2025 06:29:09 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/cm: correct typedef and bad line warnings
Date: Tue, 11 Nov 2025 22:29:08 -0800
Message-ID: <20251112062908.2711007-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In include/rdma/ib_cm.h:

Correct a typedef's kernel-doc notation by adding the 'typedef' keyword
to it to avoid a warning.
Add a leading " *" to a kernel-doc line to avoid a warning.

Warning: ib_cm.h:289 function parameter 'ib_cm_handler' not described
 in 'int'
Warning: ib_cm.h:289 expecting prototype for ib_cm_handler().  Prototype
 was for int() instead
Warning: ib_cm.h:484 bad line: connection message in case duplicates
 are received.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
---
 include/rdma/ib_cm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20251110.orig/include/rdma/ib_cm.h
+++ linux-next-20251110/include/rdma/ib_cm.h
@@ -271,7 +271,7 @@ struct ib_cm_event {
 #define CM_APR_ATTR_ID		cpu_to_be16(0x001A)
 
 /**
- * ib_cm_handler - User-defined callback to process communication events.
+ * typedef ib_cm_handler - User-defined callback to process communication events.
  * @cm_id: Communication identifier associated with the reported event.
  * @event: Information about the communication event.
  *
@@ -482,7 +482,7 @@ int ib_send_cm_rej(struct ib_cm_id *cm_i
 
 /**
  * ib_prepare_cm_mra - Prepares to send a message receipt acknowledgment to a
-     connection message in case duplicates are received.
+ *   connection message in case duplicates are received.
  * @cm_id: Connection identifier associated with the connection message.
  */
 int ib_prepare_cm_mra(struct ib_cm_id *cm_id);

