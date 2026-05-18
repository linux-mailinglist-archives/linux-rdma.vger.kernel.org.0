Return-Path: <linux-rdma+bounces-20937-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA65JgGKC2p1IwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20937-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 23:52:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C765741E2
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 23:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E1963035A9A
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 21:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A339B486;
	Mon, 18 May 2026 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8nUuXHn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B339A050
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141116; cv=none; b=GNGxaoFgY9v9KlU22/sjkOO/53XGVIkIkipdL6gzlXwIyqP/n7S52tuzPwCiJKi9x6ig3bjk2XcsUgtR2BviTrvk0QersMVbcpQukjMhvKlsxLz6QFKYeE4dyGwXm7R/hNsIQWWHgsnBojXE4g08haLiLBBSN5syt5ccJR/bQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141116; c=relaxed/simple;
	bh=Ppm4sd0A+tCAczYckVpUNHwlVkDp9o+G1IlWGqlNo8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvAVqDJz5gvheAfZq1MnUsfNtF7f59TPFY9m17IFVMhpJ0MNs5KvTj6/bDXVYxUTmSRhW0oNFnj0EyxDHr+AL0guBhP2Be109nZDYq7tKc+DLO7f0UUUjyXt6ib9jZE/cXxDKIsgPGoLCct4eU52T3KGpkIXAsdIwOBpSX2EPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8nUuXHn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso27396335e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141113; x=1779745913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+uhDtSIfS3AblNM9PMy7cn0ddrvu3ccYTrC1bkH+lQ=;
        b=f8nUuXHnB/QPebo9vpFsFoG5QrfSlw7GCnKGYCBW3EOkqpsdJkPq7M5UqS3b7XZp65
         4TfLUuVvPS3JQ9nQGVC1AK/cNEoVG4V01FjwFnv3c5MEFT9wSlbG6N/BW0FAS7nUD21A
         O/fialRWrXjcTiPa+r8QxpaCfz92itnuQMCV6mvWNJEwBI918ZHt0F6ESlRquf4cd2QC
         Bz+TgcpnPMDQ3VEBNMBLd0nVT4CZ+kHzBRaENPvVLprz0618WX8dfeLxe4FCRw8jQ4ML
         V6AIj91j302ZL0mW5dMrkrzI4q2zcD+DsJzALxPmdtlx05/JmFxrU0lj1usZmKjmhm2P
         JEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141113; x=1779745913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M+uhDtSIfS3AblNM9PMy7cn0ddrvu3ccYTrC1bkH+lQ=;
        b=HCkAzz6555jpF6fTK0uOB7GSIMM3ZseoxRJ0R4e1wOyrOHToWzdHXMh8db/ddXIC9t
         +WFiD8K0znrdRtadPVVRWKfOuBp8NUBA9cwk9eqrNUn1eF3YNXssGCfSOvaNbfFhezYi
         gSEs92M1xeuPc+AHHYs5pD55PT3fFFjDIhBoZ1/F1BkCuoxU8GOO2krM/+KDoQJEnRXM
         +NMeC67O/gdwCTRkGsf62QmrQSH8LtYGIqVirdeJggkiLb0VtHxjaEjPJadnqoBKdldB
         udPUgZjfdjLD7J7ClfUlaOrr/7nUEukpn3Whd/C1Lci2KGaNPT6RSQaZi9L1JV9Qen/u
         eloA==
X-Forwarded-Encrypted: i=1; AFNElJ/CvsBKR0YE78/6QbN5Y8paG8C87OWcONPqalJvM+oaGvRhQwSweBX2VT0ljYNWHJqPOCcSqh9CEEnS@vger.kernel.org
X-Gm-Message-State: AOJu0YzBnsIkv1UQQPBwSwt3m8HpUdpQiyPWDT0TqbfQ/Yx5ZEUcONag
	m0BpGMMaidAZf7/FHkhCEcj2MfPGNh17S74xfvTSH8b6pMl6XzF1NfAkKfca
X-Gm-Gg: Acq92OGfFsAnH6STV+BYiSSrMNR4BZ46qkCR6OK/ykZbBiEx3Ist7iqnrSqUptlMAj1
	977NVm5NwkLmF+jcmZTQDh2mPAX5m0SdP4qFsDV5RYWKOldSyB1n1AUeX+NfMAz8UsMXFH6iPMA
	B7r8yMWZIJi9EK39/OLxOCHj9I7od/ivzSww6Y9jzMfo8kBkBNW2quBZrkvZ65c9QlejywXg7WM
	7MEL9TOEixnt8sUz74WkSBTLfmPSufdAhFX4N58AdTP+qX43J3g4tAr6WhN+5+IvsxY/91e73cV
	o8vJM620VWCW19ja/C+YXvrcbdkcvWXC6gicJPq2Kq0D59/5ld1M7P0SITZUJu23Y2rzNw3Wepr
	G4yo2pgz3eRkSS3xnE1gJSVFtthkXeiTFjGtAHxAH+ll6dfjLOdjKVK+OLMiOhTkeD5Hnb23aLY
	/AYbc+qW7+Ka0N50Nw
X-Received: by 2002:a05:600c:628d:b0:490:1642:3d4d with SMTP id 5b1f17b1804b1-49016423dd1mr52914425e9.22.1779141113267;
        Mon, 18 May 2026 14:51:53 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53767ecsm255138905e9.10.2026.05.18.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:51:52 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 1/2] RDMA/rxe: fix TOCTOU heap overflow in get_srq_wqe
Date: Mon, 18 May 2026 21:50:39 +0000
Message-ID: <20260518215040.1598586-2-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518215040.1598586-1-tristan@talencesecurity.com>
References: <20260518215040.1598586-1-tristan@talencesecurity.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20937-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 19C765741E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_srq_wqe() reads wqe->dma.num_sge from the shared receive queue
buffer, which is mapped into userspace. It validates num_sge against
max_sge, but then re-reads the same field to calculate the memcpy
size. A concurrent userspace thread can modify num_sge between
validation and use, causing a heap buffer overflow when copying the
WQE into qp->resp.srq_wqe.

Read num_sge into a local variable and use it for both the bounds
check and the size calculation.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 9cb2f6f..8a0a973 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -264,6 +264,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 	struct rxe_recv_wqe *wqe;
 	struct ib_event ev;
 	unsigned int count;
+	unsigned int num_sge;
 	size_t size;
 	unsigned long flags;
 
@@ -279,12 +280,13 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 	}
 
 	/* don't trust user space data */
-	if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
+	num_sge = wqe->dma.num_sge;
+	if (unlikely(num_sge > srq->rq.max_sge)) {
 		spin_unlock_irqrestore(&srq->rq.consumer_lock, flags);
 		rxe_dbg_qp(qp, "invalid num_sge in SRQ entry\n");
 		return RESPST_ERR_MALFORMED_WQE;
 	}
-	size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
+	size = sizeof(*wqe) + num_sge * sizeof(struct rxe_sge);
 	memcpy(&qp->resp.srq_wqe, wqe, size);
 
 	qp->resp.wqe = &qp->resp.srq_wqe.wqe;
-- 
2.47.3


