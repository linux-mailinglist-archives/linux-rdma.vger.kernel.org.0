Return-Path: <linux-rdma+bounces-5326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C569C995D92
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 04:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A5DB240F4
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 02:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74FC131E2D;
	Wed,  9 Oct 2024 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IAVksPCX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5F55887;
	Wed,  9 Oct 2024 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439239; cv=none; b=t/HFCk3XTxIKhg5y9EK0AQHz6p6mUGe+iO2mNGauFsiYVEKOg9pYAwcyOdL/12GjcQWJrviYrYxCn1eVRODspxjZHhQYrse29A1HUtqhz17Gz64AtS1rF3M2nf4MWd0N6dBEwmicGBWig8ojaZmqWCNmoRjUmfBMTrLptVubU+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439239; c=relaxed/simple;
	bh=8rfGaGGiVz9TS52mA6uudohmzNLbJ1QmcssVA8YlEHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KBh01f2fd84uSxxK45ibI40Wq10UkJ/X090my8Doy0UhD0mSEm/lYXOz9/1spdu/h3CH/TpKg4kj2Cq6F4vWMo8TBDXvLcXEzGdS0MsbC/p76uGpV2NrahmF49ZbTypcpRBT3eoGmwIvGzEZtq4VFe1toxfQJ5jMtFuy8wuNFSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IAVksPCX; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1728439239; x=1759975239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rfGaGGiVz9TS52mA6uudohmzNLbJ1QmcssVA8YlEHg=;
  b=IAVksPCXRtqEHCSrMAz47CvWHYWfHJwlsaEvTK6Z0rP+RYd+EXETQUGs
   kRF3gtZRxZKbJIQeIg7n4UcTmxmZFUKiFYEMMpr7QE3agMSEiX+QUc622
   RJ+7DMutlML7kpXDTTE8IRvHkLfme+1JIXNCUZuWvcDwPeRbwQXmBBBt3
   RG8j9h5PzUG4fvEmqKKNzlgtFTLSxnqr2WvyLT7TzGlNwMvcdU0cGWECB
   gpxYxlPIdvQvoxRlyq1f0blNoaJKiOsoqpI7G0AFFqzHpKJ2ctRZlYUPO
   Zne3Jv3QYVieMTcI/cYop4SXNcjRJU5RZ3Ss9OPhDb6um9IA2dFGSmive
   g==;
X-CSE-ConnectionGUID: 62DxmlrCRkqQ6E54fsn0rg==
X-CSE-MsgGUID: F+fGgGIyRZ6pit+btmpXNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="176266738"
X-IronPort-AV: E=Sophos;i="6.11,188,1725289200"; 
   d="scan'208";a="176266738"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 10:59:27 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 30B0BC68E2;
	Wed,  9 Oct 2024 10:59:24 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 833DBCFA5B;
	Wed,  9 Oct 2024 10:59:23 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 57ACC2005356;
	Wed,  9 Oct 2024 10:59:23 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v8 2/6] RDMA/rxe: Move resp_states definition to rxe_verbs.h
Date: Wed,  9 Oct 2024 10:58:59 +0900
Message-Id: <20241009015903.801987-3-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

To use the resp_states values in rxe_loc.h, it is necessary to move the
definition to rxe_verbs.h, where other internal states of this driver are
defined.

Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe.h       | 37 ---------------------------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 37 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index d8fb2c7af30a..193f7caffaf2 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -100,43 +100,6 @@
 #define rxe_info_mw(mw, fmt, ...) ibdev_info_ratelimited((mw)->ibmw.device, \
 		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
 
-/* responder states */
-enum resp_states {
-	RESPST_NONE,
-	RESPST_GET_REQ,
-	RESPST_CHK_PSN,
-	RESPST_CHK_OP_SEQ,
-	RESPST_CHK_OP_VALID,
-	RESPST_CHK_RESOURCE,
-	RESPST_CHK_LENGTH,
-	RESPST_CHK_RKEY,
-	RESPST_EXECUTE,
-	RESPST_READ_REPLY,
-	RESPST_ATOMIC_REPLY,
-	RESPST_ATOMIC_WRITE_REPLY,
-	RESPST_PROCESS_FLUSH,
-	RESPST_COMPLETE,
-	RESPST_ACKNOWLEDGE,
-	RESPST_CLEANUP,
-	RESPST_DUPLICATE_REQUEST,
-	RESPST_ERR_MALFORMED_WQE,
-	RESPST_ERR_UNSUPPORTED_OPCODE,
-	RESPST_ERR_MISALIGNED_ATOMIC,
-	RESPST_ERR_PSN_OUT_OF_SEQ,
-	RESPST_ERR_MISSING_OPCODE_FIRST,
-	RESPST_ERR_MISSING_OPCODE_LAST_C,
-	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
-	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
-	RESPST_ERR_RNR,
-	RESPST_ERR_RKEY_VIOLATION,
-	RESPST_ERR_INVALIDATE_RKEY,
-	RESPST_ERR_LENGTH,
-	RESPST_ERR_CQ_OVERFLOW,
-	RESPST_ERROR,
-	RESPST_DONE,
-	RESPST_EXIT,
-};
-
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
 
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 3c1354f82283..e4656c7640f0 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -126,6 +126,43 @@ struct rxe_comp_info {
 	u32			rnr_retry;
 };
 
+/* responder states */
+enum resp_states {
+	RESPST_NONE,
+	RESPST_GET_REQ,
+	RESPST_CHK_PSN,
+	RESPST_CHK_OP_SEQ,
+	RESPST_CHK_OP_VALID,
+	RESPST_CHK_RESOURCE,
+	RESPST_CHK_LENGTH,
+	RESPST_CHK_RKEY,
+	RESPST_EXECUTE,
+	RESPST_READ_REPLY,
+	RESPST_ATOMIC_REPLY,
+	RESPST_ATOMIC_WRITE_REPLY,
+	RESPST_PROCESS_FLUSH,
+	RESPST_COMPLETE,
+	RESPST_ACKNOWLEDGE,
+	RESPST_CLEANUP,
+	RESPST_DUPLICATE_REQUEST,
+	RESPST_ERR_MALFORMED_WQE,
+	RESPST_ERR_UNSUPPORTED_OPCODE,
+	RESPST_ERR_MISALIGNED_ATOMIC,
+	RESPST_ERR_PSN_OUT_OF_SEQ,
+	RESPST_ERR_MISSING_OPCODE_FIRST,
+	RESPST_ERR_MISSING_OPCODE_LAST_C,
+	RESPST_ERR_MISSING_OPCODE_LAST_D1E,
+	RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
+	RESPST_ERR_RNR,
+	RESPST_ERR_RKEY_VIOLATION,
+	RESPST_ERR_INVALIDATE_RKEY,
+	RESPST_ERR_LENGTH,
+	RESPST_ERR_CQ_OVERFLOW,
+	RESPST_ERROR,
+	RESPST_DONE,
+	RESPST_EXIT,
+};
+
 enum rdatm_res_state {
 	rdatm_res_state_next,
 	rdatm_res_state_new,
-- 
2.43.0


