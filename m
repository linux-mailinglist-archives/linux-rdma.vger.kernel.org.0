Return-Path: <linux-rdma+bounces-6552-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCBB9F3CA7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 22:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BD57A7EAE
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257B51D45FC;
	Mon, 16 Dec 2024 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iVKTxRc4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574781B5EB5;
	Mon, 16 Dec 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383963; cv=none; b=Yn5t8l/kGXsrmlrM2UnCJqL8OeSMW7lpA5akLzgFRiVKTG24fnnAwmMcyPp0MEv+Nu/ErhAY6quhnGYR9CrLbJz8zKlsipgMS8jtsiWVQwJpSon+fXbOtj8PjZyz3rf9iEpi6QcGzDCmwVdC2Yxnpyv4WkYro58kwXWq5M6nK90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383963; c=relaxed/simple;
	bh=1nhXJ5KR/yqRrlRTaymdLomWAV3IQ9Qgd46JpGK+wB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdpW7d5DvFOSIC1TF4mL30NBMn0HsD1I8lC6OZl8ZkM7SqmOFMAJh9d21WAPogkhN0vRbbwHPiCCIZpdujPC6gX9UT4aM+xKOzsQcvtcq4XtEHo9Q2ROzUUWui04YXVReSBPg2ILo55xdLdag2Rp5LqkAXkDFN08x+ghH4xdwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=iVKTxRc4; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=KZ8RLwvQSUqYxNGe0zdY3CCvUeDrMnmYqOGejkbMIWY=; b=iVKTxRc4FAyCFl7X
	ANL6jtqTxgalo5H0VpV+75IxSTOpTR9//GqaVGW2wIjGuKK1QcLZx/hPaMZbMfQE/5yek29IItX04
	C0JrhUdx5ndD9Yfiizh/CDxCbdP6J9fQlS0dD1/Ih8tdNYai6mUeST9ZWn5VfCeWUhF8SfjFRCw6l
	Ta8YmdlN0Cozvgom80vLdOdRX+wEcxfj9HyW8yez361tGVlz9d8FplFu5hYlzSYYCbe/jOrzKP232
	YsfcePb+RCpxXCCoNoY2O6afwLqvHGUGn+sLGsW0V7l8Nf1BodoDsy1ln1e6VqhinCXE3xKAOSHJu
	qdK8Rvokdnq56MnuIg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tNIUl-005ixH-0n;
	Mon, 16 Dec 2024 21:19:15 +0000
From: linux@treblig.org
To: dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] IB/hfi1: Remove unused hfi1_format_hwerrors
Date: Mon, 16 Dec 2024 21:19:14 +0000
Message-ID: <20241216211914.745111-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

hfi1_format_hwerrors() was added in 2015 by
commit 7724105686e7 ("IB/hfi1: add driver files")
but never used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/infiniband/hw/hfi1/hfi.h  | 14 --------------
 drivers/infiniband/hw/hfi1/intr.c | 31 -------------------------------
 2 files changed, 45 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index eb38f81aeeb1..cb630551cf1a 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -2339,20 +2339,6 @@ static inline u64 hfi1_pkt_base_sdma_integrity(struct hfi1_devdata *dd)
 	dev_err(&(dd)->pcidev->dev, "%s: port %u: " fmt, \
 		rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), (port), ##__VA_ARGS__)
 
-/*
- * this is used for formatting hw error messages...
- */
-struct hfi1_hwerror_msgs {
-	u64 mask;
-	const char *msg;
-	size_t sz;
-};
-
-/* in intr.c... */
-void hfi1_format_hwerrors(u64 hwerrs,
-			  const struct hfi1_hwerror_msgs *hwerrmsgs,
-			  size_t nhwerrmsgs, char *msg, size_t lmsg);
-
 #define USER_OPCODE_CHECK_VAL 0xC0
 #define USER_OPCODE_CHECK_MASK 0xC0
 #define OPCODE_CHECK_VAL_DISABLED 0x0
diff --git a/drivers/infiniband/hw/hfi1/intr.c b/drivers/infiniband/hw/hfi1/intr.c
index 3737f632d62a..d8dd1a599631 100644
--- a/drivers/infiniband/hw/hfi1/intr.c
+++ b/drivers/infiniband/hw/hfi1/intr.c
@@ -47,37 +47,6 @@ static void add_full_mgmt_pkey(struct hfi1_pportdata *ppd)
 	hfi1_event_pkey_change(ppd->dd, ppd->port);
 }
 
-/**
- * format_hwmsg - format a single hwerror message
- * @msg: message buffer
- * @msgl: length of message buffer
- * @hwmsg: message to add to message buffer
- */
-static void format_hwmsg(char *msg, size_t msgl, const char *hwmsg)
-{
-	strlcat(msg, "[", msgl);
-	strlcat(msg, hwmsg, msgl);
-	strlcat(msg, "]", msgl);
-}
-
-/**
- * hfi1_format_hwerrors - format hardware error messages for display
- * @hwerrs: hardware errors bit vector
- * @hwerrmsgs: hardware error descriptions
- * @nhwerrmsgs: number of hwerrmsgs
- * @msg: message buffer
- * @msgl: message buffer length
- */
-void hfi1_format_hwerrors(u64 hwerrs, const struct hfi1_hwerror_msgs *hwerrmsgs,
-			  size_t nhwerrmsgs, char *msg, size_t msgl)
-{
-	int i;
-
-	for (i = 0; i < nhwerrmsgs; i++)
-		if (hwerrs & hwerrmsgs[i].mask)
-			format_hwmsg(msg, msgl, hwerrmsgs[i].msg);
-}
-
 static void signal_ib_event(struct hfi1_pportdata *ppd, enum ib_event_type ev)
 {
 	struct ib_event event;
-- 
2.47.1


