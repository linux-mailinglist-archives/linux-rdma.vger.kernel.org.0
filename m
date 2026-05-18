Return-Path: <linux-rdma+bounces-20938-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOnbG0aKC2p1IwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20938-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 23:53:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1273F5741F8
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 23:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 654A53017EC2
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 21:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084939B48E;
	Mon, 18 May 2026 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF55wqz8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C73321BD
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141187; cv=none; b=Y1jNU8AecOO8rhsJ0kbL0z+vUaLyS3G4TOLTFFykJkVW5Vb/1KuE+IbWnMHkNXuN7ZW+Wgi4AYduRQlZOF0BzmOy/cBlpenWJXKyTUW59R56efHoa9ubgpM6kEReiDTGRc5ZzcmZYrEQqxsaNseBLq+8SyQZ3uz/hoDNknEj8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141187; c=relaxed/simple;
	bh=fNF/eG12mZflCPhJl7YWSYL8fxy08MhOJtCIscmjfo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICV5GEG+MDNGc3kkGbmm27wXpli/hjI9F6+ghHz6HekMoZX9amN6hFvs5VkpBOrhqwhYkbuGtUrIXfgOOM4okefUCYJ3QDnejLhvry2HJ6Mj+m7Aol2KaB0gGWb7nnd46Q+MniidNgdII6xd0RoMKNEqt2L86C7t7slLBXrwp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF55wqz8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ad135063so21277085e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 14:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141185; x=1779745985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWB9OPwTXi9II8Vwewr4Kwcezr/Nqlq7ndCB4RZmloc=;
        b=kF55wqz8SwBGkB0FUInh5mkMW25j1L9MDv3U5WNPPIkB2sTIBUh8MmhtCQaxPRyqD4
         ULWTkTqnrG2TDgNuHsu4UzJWIMTMp6DvyyVKVBoQ0v+MAuLq7jrO70gEf5xGsKBufepL
         CBuY7cU1MsvoLRB5hPh7j0nxeO5V2YftBdo0B3uYQUfBcZ8lvGZln6boWkG52O8XxmlB
         kDQ6q0KfV+vN7t85C9Ur7DkQ5knAAiCE2IzCQM1xLZ4pTZHVR/zBJmozizMdtHrlGPy7
         sbf82PDaKKwfTeJZ3FY/CPRFdkPin+6OUfPrvJZm0koVCVxGttg+eAnNfCRl2MxapDJj
         qqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141185; x=1779745985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWB9OPwTXi9II8Vwewr4Kwcezr/Nqlq7ndCB4RZmloc=;
        b=CUyN/P16DuHYXWd0zPFpfLEPDGev3wMEUBa5txYXXNtbWdWVv7/lzLLV6hTVMy9/2N
         ahmDG+9szkXGj6S+7PxqOj1eB0hjKeROd8dY1ZS+alK01Sf/wzHoHKH9fjhDcT9c9u3q
         4JjG1sjU8t3+Se7tTckM+U8T3A/C0I/vfsvAb3wR+nepr0Vl1LAUeYLdZYfbV7nNtQ+q
         9uDvHfGZK6kLvRSR9BAlhXoulwE9aoML3jaf7daOVW9hK+vHeiiRP99CenaPtNntLl5t
         iQNWClU4xp+5LZPKkRPKZT7Qqb3s90PFpEV0vGtR1ulEVnR7lYhAL0d5LFIC/lo/GIbh
         HzPw==
X-Forwarded-Encrypted: i=1; AFNElJ8WFaynB4vjArIljWeNLUQSf8EOlSLQQCMswqiwm9IkYtbS/j7FKl9z0L/iI8HRgz9De1VAcsZVT6X+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwrjd8Ms6QziIzG+CnU43Qzh9WLpPNsTJCwwY+beElY7r7pm8G
	SAexJsGOhDavcOTX/1Hid8Qp8FouD57gA/4C87zH5yd7lTmWe5eHEpg=
X-Gm-Gg: Acq92OHFEjzTdKbGIHOH8UtdE40xhCPpKjys6/ZvdCJLm3om/T0u+p90oPhPr5IuqDA
	thVs6EkICVhvJBa/VXA22lQ16VapeWD3HjY06uUjKBpn1x6EMkT569PcvEqGfhhQZLrKCciityF
	TN3VPmJMb6tnz/4QzXcl9A2T1zCE1+90pibqrlPQy2lIw6e8TnGb/AkUjokp3d6SkOU4QR8BgKi
	xVX8yDRr0kltJrCw49n8ddT/18mshHxkRZ92AJYpHmT0Nmau+aABMU9R98aS2hd8kKDfDdZqUTS
	ZHvojCZliFiOAIHkW3CEfkXUWUvjlPMFdA6+QTPHaJM9CxvRyquwOVCIjAUMrwH5kSqLvCndyd6
	lsVSdSHo00mm7Jj4lZfV7stiZtpc7sbvag4aggFWVv77Ww5cQ9yLnPKHEa002w5y14iTCM8oQIE
	nPdC8I7BB9vQXr7TIh
X-Received: by 2002:a05:600c:8707:b0:48f:fddb:dcd9 with SMTP id 5b1f17b1804b1-48ffddbf75emr177414395e9.27.1779141184445;
        Mon, 18 May 2026 14:53:04 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feb8d838dsm93371945e9.1.2026.05.18.14.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:53:03 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 2/2] RDMA/rxe: copy WQE to local buffer in non-SRQ receive path
Date: Mon, 18 May 2026 21:50:40 +0000
Message-ID: <20260518215040.1598586-3-tristan@talencesecurity.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20938-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,talencesecurity.com:mid,talencesecurity.com:email]
X-Rspamd-Queue-Id: 1273F5741F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For non-SRQ QPs, the responder reads WQE fields directly from the
shared queue buffer mapped into userspace. This allows a malicious
user to modify fields like num_sge or sge entries while the kernel
is processing the WQE, leading to out-of-bounds reads in
rxe_resp_check_length() and copy_data().

Introduce get_recv_wqe() that validates num_sge and copies the WQE
to a kernel-local buffer before processing, matching the approach
already used for SRQ WQEs in get_srq_wqe(). The srq_wqe buffer is
reused since SRQ and non-SRQ paths are mutually exclusive per QP.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 8a0a973..43e8d86 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -310,6 +310,29 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
 	return RESPST_CHK_LENGTH;
 }
 
+static enum resp_states get_recv_wqe(struct rxe_qp *qp)
+{
+	struct rxe_queue *q = qp->rq.queue;
+	struct rxe_recv_wqe *wqe;
+	unsigned int num_sge;
+	size_t size;
+
+	wqe = queue_head(q, QUEUE_TYPE_FROM_CLIENT);
+	if (!wqe)
+		return RESPST_ERR_RNR;
+
+	num_sge = wqe->dma.num_sge;
+	if (unlikely(num_sge > qp->rq.max_sge)) {
+		rxe_dbg_qp(qp, "invalid num_sge in recv WQE\n");
+		return RESPST_ERR_MALFORMED_WQE;
+	}
+	size = sizeof(*wqe) + num_sge * sizeof(struct rxe_sge);
+	memcpy(&qp->resp.srq_wqe, wqe, size);
+
+	qp->resp.wqe = &qp->resp.srq_wqe.wqe;
+	return RESPST_CHK_LENGTH;
+}
+
 static enum resp_states check_resource(struct rxe_qp *qp,
 				       struct rxe_pkt_info *pkt)
 {
@@ -330,9 +353,7 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 		if (srq)
 			return get_srq_wqe(qp);
 
-		qp->resp.wqe = queue_head(qp->rq.queue,
-				QUEUE_TYPE_FROM_CLIENT);
-		return (qp->resp.wqe) ? RESPST_CHK_LENGTH : RESPST_ERR_RNR;
+		return get_recv_wqe(qp);
 	}
 
 	return RESPST_CHK_LENGTH;
-- 
2.47.3


