Return-Path: <linux-rdma+bounces-18463-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHsQEpRlvWlF9gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18463-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 16:19:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E545B2DC86E
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 16:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F68F302E130
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3513C73EC;
	Fri, 20 Mar 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GryPzZWY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312CC3B961D;
	Fri, 20 Mar 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019732; cv=none; b=N71FkIJlF6XcYsFIp2p/wgOV4RptNn7fOk5cu2cgDNdCtfaK9SxAnn0VU89AZ+mk5tJtXDpVSNzmvFrfvKNAytoucYFSjMu0paf9H//vRUNe8S9yiKyPMVPRZn4CBpCsy+h5QCfyuj85AscwNF48NJ2fjaw4wkteCoKciX+xep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019732; c=relaxed/simple;
	bh=hpDZ5j56hWihlvr2tldSS67Y7hr7VWN/4PiY5cUG6/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S79LY/HdehDzYnoRhP2vDQIpp1KcNt2anhgdBcql5Tpa9uaQnK7wXOdLG2Q0PMo5T2swPL/jJe62kbpePMJIvPoTV2CeKu/WSp0YaXmaVpL3gUb1onNVBmYmRWWU9RQmCOs7Ii7Ya22Xql2Ute+FAQpiWtgW6Ame1PAvfuLoggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GryPzZWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37DDC4CEF7;
	Fri, 20 Mar 2026 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019731;
	bh=hpDZ5j56hWihlvr2tldSS67Y7hr7VWN/4PiY5cUG6/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GryPzZWYs7Qj37CDjggwK3lIORT1CR0SvYmuqmE0+poZa9rIdQ1jxORpe9d6AtBpc
	 N9MR+0eiQ/MpRzZl6n1w6I8dyKC4/fpvK6T8U54O+Z6TVLnimqZ8I6KwLSUZ49/xKk
	 CY9knn+kQnRW8jc+3u5wBqUaUyI9/8XjR5G9jYNtZ3aHFrFZQI4nUGXl4Hu24+QbBR
	 3u9DDyV7N/mUdlSxMj+XQLK4KHlo8507OkOXvpKTXdPJRGqElN9PRFeVIJswWglusf
	 cjU6ZKy4vhM1D5POCPgKCNqKJo2Gl1ll69Gah+SDQOR6RmRH5HfEdFT3w0stnr58TA
	 DpmUfHdb+8jVQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Doug Ledford <dledford@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Ingo Molnar <mingo@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/3] RDMA/hfi1, rdmavt: open-code rvt_set_ibdev_name()
Date: Fri, 20 Mar 2026 16:12:38 +0100
Message-Id: <20260320151511.3420818-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260320151511.3420818-1-arnd@kernel.org>
References: <20260320151511.3420818-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,google.com,suse.com,kernel.org,vger.kernel.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-18463-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.953];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: E545B2DC86E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

clang warns about a function missing a printf attribute:

include/rdma/rdma_vt.h:457:47: error: diagnostic behavior may be improved by adding the 'format(printf, 2, 3)' attribute to the declaration of 'rvt_set_ibdev_name' [-Werror,-Wmissing-format-attribute]
  447 | static inline void rvt_set_ibdev_name(struct rvt_dev_info *rdi,
      | __attribute__((format(printf, 2, 3)))
  448 |                                       const char *fmt, const char *name,
  449 |                                       const int unit)

The helper was originally added as an abstraction for the hfi1 and
qib drivers needing the same thing, but now qib is gone, and hfi1
is the only remaining user of rdma_vt.

Avoid the warning and allow the compiler to check the format string by
open-coding the helper and directly assigning the device name.

Fixes: 5084c8ff21f2 ("IB/{rdmavt, hfi1, qib}: Self determine driver name")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/hfi1/init.c | 13 ++++++++++++-
 include/rdma/rdma_vt.h            | 20 --------------------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 8b5a5b32b0fa..fb0a8325a43d 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1206,6 +1206,7 @@ static struct hfi1_devdata *hfi1_alloc_devdata(struct pci_dev *pdev,
 					       size_t extra)
 {
 	struct hfi1_devdata *dd;
+	struct ib_device *ibdev;
 	int ret, nports;
 
 	/* extra is * number of ports */
@@ -1227,7 +1228,17 @@ static struct hfi1_devdata *hfi1_alloc_devdata(struct pci_dev *pdev,
 			"Could not allocate unit ID: error %d\n", -ret);
 		goto bail;
 	}
-	rvt_set_ibdev_name(&dd->verbs_dev.rdi, "%s_%d", class_name(), dd->unit);
+
+	/*
+	 * FIXME: rvt and its users want to touch the ibdev before
+	 * registration and have things like the name work. We don't have the
+	 * infrastructure in the core to support this directly today, hack it
+	 * to work by setting the name manually here.
+	 */
+	ibdev = &dd->verbs_dev.rdi.ibdev;
+	dev_set_name(&ibdev->dev, "%s_%d", class_name(), dd->unit);
+	strscpy(&ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
+
 	/*
 	 * If the BIOS does not have the NUMA node information set, select
 	 * NUMA 0 so we get consistent performance.
diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index 7d8de561f71b..7ffc83262a01 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -438,26 +438,6 @@ struct rvt_dev_info {
 	struct rvt_wss *wss;
 };
 
-/**
- * rvt_set_ibdev_name - Craft an IB device name from client info
- * @rdi: pointer to the client rvt_dev_info structure
- * @name: client specific name
- * @unit: client specific unit number.
- */
-static inline void rvt_set_ibdev_name(struct rvt_dev_info *rdi,
-				      const char *fmt, const char *name,
-				      const int unit)
-{
-	/*
-	 * FIXME: rvt and its users want to touch the ibdev before
-	 * registration and have things like the name work. We don't have the
-	 * infrastructure in the core to support this directly today, hack it
-	 * to work by setting the name manually here.
-	 */
-	dev_set_name(&rdi->ibdev.dev, fmt, name, unit);
-	strscpy(rdi->ibdev.name, dev_name(&rdi->ibdev.dev), IB_DEVICE_NAME_MAX);
-}
-
 /**
  * rvt_get_ibdev_name - return the IB name
  * @rdi: rdmavt device
-- 
2.39.5


