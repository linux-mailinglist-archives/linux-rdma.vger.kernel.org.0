Return-Path: <linux-rdma+bounces-11875-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709E3AF7ECF
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D966E17B70F
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 17:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430D2289E0E;
	Thu,  3 Jul 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="K7zadbu1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E428934E
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751563649; cv=none; b=erTR9vbzAjdltvE4ib4E2+tAH90u/+nzdMKFjdWoQOWorjJBcE+igSbIC0vQUz9/rGJLRJbuTKDt9LVFUworqedR0LQwd4bsi2aj8huwW1UUO7ronYklhh1JDqB2/dcqRHWHu0/ZI345cGs4HrJe2O1Ol5MHGSvPVOYNmaUi57M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751563649; c=relaxed/simple;
	bh=3fhhSBiiRs3g9VcaJ6tt5B9BAqANjhQsI7XjOKgWHvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qhTZhOjAjc76sJr618shRkiimBNflNrJE+i+BXrQEFa5NYQL9q+eW/uJRFpzBlRZ+ehnc+wXN40P2V4GL7bJkg5AbJ9DtSrXqgpMf8uvVgdWVvdIsWAEQMBg4ocI/WDQx21TinCNo4SQIV269RcP7EWeJ3pGIfKoEGttaNNW8zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=K7zadbu1; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-Id:Date:Cc:To:From;
	bh=QPHIPWOHkJj8sCfB0e4MLn72QnrnHt8sXU6jd2evGRQ=; b=K7zadbu1WeABoJkdaMv4XBYR3q
	cJpayIbFq38fBPkCG0sSXEpW5UcvIyqoa9Sy5a1WsyQZlC2PkkyTwXSf1zwcERUJP2aln6oJc/rim
	i2FN5EiWkO+g1Rs8bmUgzVFXIHajTI1+NoznDJxq8B2Te8eND/S4w4wUiW3MuS/3bYQPwu/9c2rkc
	Ez3bkbla5va2o1bLB5bvzKyrIK39MWA2TcF9X/70PAA/ZH316OUvpDu5eXT+e7rskVdjAXNvzXlFy
	Ki9d8q/P1nz/KKXm+CnwsS0wqVePUl0YgN4lKbBJulhRTwYqLyZDhHuie3TjdTKe9FIKaoSidML6l
	djg6cUyxo0gPWUq+V4i6kONOoNfLa7umaVv6dDO0DYoVTZBYkPIVK3Ic5WS5jLzZpOWcHLjSJNDac
	OoSRXt9eoy0iN7MMgQWQwBtXYBvY8RYnnMmJ3b0C2a2y+UQrVw62GgGYE8ILEaRLSpkJ7t2mfOCEa
	2bdsoYjSZX+RuT4u639iEoUV;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uXNiW-00Dp2s-2p;
	Thu, 03 Jul 2025 17:27:24 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 5/8] RDMA/siw: combine global options into siw_default_options
Date: Thu,  3 Jul 2025 19:26:16 +0200
Message-Id: <6621eb195b07810df5163d577fad04f24d1f044c.1751561826.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1751561826.git.metze@samba.org>
References: <cover.1751561826.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/sw/siw/siw.h      |  8 ----
 drivers/infiniband/sw/siw/siw_main.c | 61 ++++++++++++++++------------
 2 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index b38e78909c06..4d8e1f857099 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -498,14 +498,6 @@ struct siw_user_mmap_entry {
 	void *address;
 };
 
-/* Global siw parameters. Currently set in siw_main.c */
-extern const bool zcopy_tx;
-extern const bool try_gso;
-extern const bool mpa_crc_required;
-extern const bool mpa_crc_strict;
-extern const bool siw_tcp_nagle;
-extern const u_char mpa_version;
-extern const bool peer_to_peer;
 extern struct task_struct *siw_tx_thread[];
 
 extern struct iwarp_msg_info iwarp_pktinfo[RDMAP_TERMINATE + 1];
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index bbec1442dfa1..954990278256 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -29,32 +29,45 @@ MODULE_AUTHOR("Bernard Metzler");
 MODULE_DESCRIPTION("Software iWARP Driver");
 MODULE_LICENSE("Dual BSD/GPL");
 
-/* transmit from user buffer, if possible */
-const bool zcopy_tx = true;
-
-/* Restrict usage of GSO, if hardware peer iwarp is unable to process
- * large packets. try_gso = true lets siw try to use local GSO,
- * if peer agrees.  Not using GSO severly limits siw maximum tx bandwidth.
- */
-const bool try_gso;
+static const struct siw_device_options siw_default_options = {
+	/*
+	 * transmit from user buffer, if possible
+	 */
+	.zcopy_tx = true,
 
+	/*
+	 * Restrict usage of GSO, if hardware peer iwarp is unable to process
+	 * large packets. try_gso = true lets siw try to use local GSO, if peer
+	 * agrees.  Not using GSO severly limits siw maximum tx bandwidth.
+	 */
+	.try_gso = true,
 
-/* We try to negotiate CRC on, if true */
-const bool mpa_crc_required;
+	/*
+	 * We try to negotiate CRC on, if true
+	 */
+	.crc_required = false,
 
-/* MPA CRC on/off enforced */
-const bool mpa_crc_strict;
+	/*
+	 * MPA CRC on/off enforced
+	 */
+	.crc_strict = false,
 
-/* Control TCP_NODELAY socket option */
-const bool siw_tcp_nagle;
+	/*
+	 * Control TCP_NODELAY socket option
+	 */
+	.tcp_nagle = false,
 
-/* Select MPA version to be used during connection setup */
-const u_char mpa_version = MPA_REVISION_2;
+	/*
+	 * Selects MPA P2P mode (additional handshake during connection
+	 * setup, if true.
+	 */
+	.peer_to_peer = false,
 
-/* Selects MPA P2P mode (additional handshake during connection
- * setup, if true.
- */
-const bool peer_to_peer;
+	/*
+	 * Select MPA version to be used during connection setup
+	 */
+	.mpa_version = MPA_REVISION_2,
+};
 
 struct task_struct *siw_tx_thread[NR_CPUS];
 
@@ -324,13 +337,7 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
 	/* Disable TCP port mapping */
 	base_dev->iw_driver_flags = IW_F_NO_PORT_MAP;
 
-	sdev->options.zcopy_tx = zcopy_tx;
-	sdev->options.try_gso = try_gso;
-	sdev->options.crc_required = mpa_crc_required;
-	sdev->options.crc_strict = mpa_crc_strict;
-	sdev->options.tcp_nagle = siw_tcp_nagle;
-	sdev->options.peer_to_peer = peer_to_peer;
-	sdev->options.mpa_version = mpa_version;
+	sdev->options = siw_default_options;
 
 	sdev->attrs.max_qp = SIW_MAX_QP;
 	sdev->attrs.max_qp_wr = SIW_MAX_QP_WR;
-- 
2.34.1


