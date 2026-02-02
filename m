Return-Path: <linux-rdma+bounces-16334-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFuCEhWpgGmeAAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16334-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 14:39:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A21A6CCDF6
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 14:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079D730649FD
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BFE369226;
	Mon,  2 Feb 2026 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hc/2Fzzd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6B19E819
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039126; cv=none; b=sKemqAed8apqY34sTFRtGYPo+F5RpnnPa+36N6ZDv0xLribmd1fius3oh5oIyc4a9Kvf5tUL7JCGdnQfPaMH95TqsysSZrI8z85MgT1LAHyOrGQTHlMOVH83tKG7pNmlVAEDkU2cyJaYRPz64uAkOjxvQC9L1+KyUz8krDQ/G64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039126; c=relaxed/simple;
	bh=r2TIpfuTp14pc0lk1Ay4wEFTQ7reAzTn6BdBxZbRAD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0Ax9b0VkubR2Zkc8fYBg/7mAXo+AKwkiqCeOZRUR8dcTAVCE9avZUCjf4gsYbcAfcm1bkwAfKgEc2bT/8c/1oJjdmkeKK3r+L5DYz4lShKQzeFjuRFgrVyH8uhmK1GpIq9FaKlRtKltzXkU8688LtLryipeR0p5Uk8zgOyN4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hc/2Fzzd; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a0c09bb78cso36876465ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 05:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770039125; x=1770643925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LEe7e9LSCBQTmJHZsAUM2RL44l4Rxg5zALT27wQHdBY=;
        b=gQcw2ULrcc0rhyxmRZXnQtyiB75q8QU28X+YJonW8fGL4Km++XvvF8wXRrsRUAqlz7
         i0h9DoxVJOkJOOpqJmzGxbK6rHfdwiJ6I9uCHr7W3U1SkZR0o+nh1JUn11Y38dttz0ix
         RgAQg7RrXF2DADsI15VS5INxcYaIDR8mfHWyjdbUeYJXj8LmUrvNQuZGfQD25aDwxDJm
         zT+vIl4eGOcliI8QW7jfASbMnAXq4j/8NuOqGwWvkr+iH+VttvnZNMgJhLMB6cW+27yq
         QWYBBOozWfqX6Fatw8Mc4S9P2Tw6WkHLZSJemi9E+AKhrG114yuw4vi1yS3UhYFEzphM
         sfyw==
X-Gm-Message-State: AOJu0YywTKKEuFQT6CX75O0Cxpsw+48M3WENdQMfy8kEFUUcj3Aj4lSD
	f4l22/FmzENmanwuhdXaJeeh8flwAt3IV3giPevWABXwx1c7/D9E5yEE1wJlpI4eUlm68Yi/SvX
	oA4bTw08wGvyA+39s1BJsiRDpEDxopBDwr0/gAZQAKQaLRxdHDIhDyUV3XmtyfvoKscQvwFFckY
	Ms9FAva096T2iy171AfGNg7SftZrfYDahm4k11CKMSEtJWCJ7K1BqW/DVTXimbnMpqCemQOY9zm
	2rbY41ovV6AzMWJGNkfMD+IXwwiPQ==
X-Gm-Gg: AZuq6aISLzKPASYyttcScE4mySJuqs2hPZkPW1A1Io+PX16oqlVnUbhiLqk1vo6I8K4
	AmiLt+UvWBEAekCDigdtdwpGdAeNSim9pAy29QSzdpvF+s36yTJyz4XO8JEsrOyfUfdStktEwE+
	Um8ntb0R7ieGcT3QLnBFwezMhi7xbfs3lb+6ApuuBSF82U8gnnxnUQJrF/S2DueOQfFI9N+6QgD
	6PSJM3NZvIqAr8yYoSM/CBuNGfHlxmTFqcX/KWd/sMDWvA/IBCtmxwTjPog9vd1gH9ySD5OBDd8
	Z2h3//JA17b6Xnr0GRulN5QuY3HwMKsbhgxWVi1qnsoXu+ay9OzMlltdeHyo4/wXTlLb3hzY0DX
	toBH3jIvFQjiBu1XXtPq06195HPvT1/HFAipV27ac8XhPdKdb0bDwODHwhGZcsEaFtPBhQJzKsR
	/Qg8rOlJPbbJPtX6QMxlcjpD4uirHuSkVfLVsLFQaQX526YRlLU40qcv0=
X-Received: by 2002:a17:903:1211:b0:294:8c99:f318 with SMTP id d9443c01a7336-2a8d96cb3bdmr110299325ad.3.1770039124923;
        Mon, 02 Feb 2026 05:32:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b6e5c65sm21347395ad.44.2026.02.02.05.32.04
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 05:32:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6366048135so3287336a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 05:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770039123; x=1770643923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEe7e9LSCBQTmJHZsAUM2RL44l4Rxg5zALT27wQHdBY=;
        b=Hc/2FzzdIIOJfblezfQRxVlbN8boJ9+nYWtS7AmiTXufcqbPKB/KVOsQiljUv8arIl
         DFYAQ7g1zC9KRPFcTfp7Xd926v3TfLlKFhZysUTRTpPDnRFUzcJoJ5j5XHbOeOk3iVvt
         z/4RIkj1MJWa0B3tKeAFZn18Vg3538nagK6aI=
X-Received: by 2002:a17:90b:4d8c:b0:352:be45:1063 with SMTP id 98e67ed59e1d1-35429ac7eebmr14445363a91.10.1770039123451;
        Mon, 02 Feb 2026 05:32:03 -0800 (PST)
X-Received: by 2002:a17:90b:4d8c:b0:352:be45:1063 with SMTP id 98e67ed59e1d1-35429ac7eebmr14445342a91.10.1770039122991;
        Mon, 02 Feb 2026 05:32:02 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61e0007sm18859382a91.12.2026.02.02.05.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:32:02 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH rdma-rext V4 3/5] RDMA/bnxt_re: Report QP rate limit in debugfs
Date: Mon,  2 Feb 2026 19:04:11 +0530
Message-ID: <20260202133413.3182578-4-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260202133413.3182578-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260202133413.3182578-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16334-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A21A6CCDF6
X-Rspamd-Action: no action

Update QP info debugfs hook to report the rate limit applied
on the QP. 0 means unlimited.

Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index 88817c86ae24..e025217861c2 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -87,25 +87,35 @@ static ssize_t qp_info_read(struct file *filep,
 			    size_t count, loff_t *ppos)
 {
 	struct bnxt_re_qp *qp = filep->private_data;
+	struct bnxt_qplib_qp *qplib_qp;
+	u32 rate_limit = 0;
 	char *buf;
 	int len;
 
 	if (*ppos)
 		return 0;
 
+	qplib_qp = &qp->qplib_qp;
+	if (qplib_qp->shaper_allocation_status)
+		rate_limit = qplib_qp->rate_limit;
+
 	buf = kasprintf(GFP_KERNEL,
 			"QPN\t\t: %d\n"
 			"transport\t: %s\n"
 			"state\t\t: %s\n"
 			"mtu\t\t: %d\n"
 			"timeout\t\t: %d\n"
-			"remote QPN\t: %d\n",
+			"remote QPN\t: %d\n"
+			"shaper allocated : %d\n"
+			"rate limit\t: %d kbps\n",
 			qp->qplib_qp.id,
 			bnxt_re_qp_type_str(qp->qplib_qp.type),
 			bnxt_re_qp_state_str(qp->qplib_qp.state),
 			qp->qplib_qp.mtu,
 			qp->qplib_qp.timeout,
-			qp->qplib_qp.dest_qpn);
+			qp->qplib_qp.dest_qpn,
+			qplib_qp->shaper_allocation_status,
+			rate_limit);
 	if (!buf)
 		return -ENOMEM;
 	if (count < strlen(buf)) {
-- 
2.43.5


