Return-Path: <linux-rdma+bounces-22065-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rFBFFIHsKGpHNwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22065-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:48:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51828665CE8
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:48:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=fmwnogZa;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22065-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22065-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26ED8302418D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2543612E0;
	Wed, 10 Jun 2026 04:47:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602B35F5E1
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:47:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066823; cv=none; b=Jxc9nc9fgaif/nGU5Iz6Quw63D9BryXFHsP5WAAzzWNBymHgMPD9EL/Z6tvZPCQGgnUcH8NomT6FGyzss46A2JBTqjixZt2pKXZ+PHeYp6afiBtHRk2jHXxIBncEinXJvLq74Oa1ofD4SH6fEdTOzND9LwvCXAtoNEYTZcbZe1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066823; c=relaxed/simple;
	bh=vdyMbV6HatAhLf1Xm5p+X7chMuthr+8p4XWXsPbMuz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TPIaKVZlmSrujRgp5ZC1A/QkP6F0LLGeu+yGy9ko4cU+Z8Bse13c7Ri4XHKfYysoW1Nqtxc+Iml8kD7pS/l4V2lrHiLoSTIbsE3+1eiUJ5FPv8c5h0hXsTu0D5XcroHqSpDoS6cXLvEVOcszO0xZ9GRCxCTWlyQTWEEofYyWwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fmwnogZa; arc=none smtp.client-ip=209.85.222.97
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-9638d15f871so2026573241.2
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066821; x=1781671621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbsY/3rgJvOcLk7hML33yFKFiI/FIBm17M2LVVUiNEI=;
        b=SyzdlGgOYFT11HavmPR1k+A5pZ7nBr5Zak77uvZKd9Lt9DInAqOM9295svTrm8JFyD
         kVO2Ztgn5gVbfa6YvTiwXdXMr4opGVDEfUKLvtiwGlwDZtaiEQUn74AHMP/9VEqw0+FT
         KXdHZKOdMuUkt72fm2bwpDiK8LijnNgENfApajvinN00gNOI8MG3QUgNrfjTbM/7XGzK
         VtcCANwVSzFkwhWsovdTFKE6vMGc99el6OWmw8ggSj43z/iywtMPfWYmLzZ6xNjTETC6
         H9MVpLq+BOOVNyiD1hRtkq9kKk0Yxyxx6ZMvKnNqJ0acQUYI+8kEPlXK5cqBtcctyjcA
         TSDw==
X-Gm-Message-State: AOJu0Ywg63nq8S47CoX0gKPBWwv7+yqxghXDE62Hd25wV/lVubspmhBd
	PMQbYzMg1/qWRDs1ZsVbWaarNFhpDEIfRFNg8Ir0k3SGJVDAR4bm0aFfcPmExWPqcVPUUl3xYFO
	ovGmBZ0Ys4BZ8F4MMRfrmYWkvt3wKmlJrru/hMWWtyt8GMc/K5mK+GG7sPz5hqtmoYFxBajO1zo
	xHJACNSD4qeXquFsElGqYiJHTkqt7srlu+KmtzY+jF6FU8tew0kJYAygZLt/K8Tfr0pwMXLzdL1
	yMYzKR2mul5N2dr+A==
X-Gm-Gg: Acq92OGlsSmEY0pnVFPFOo5p7hX0JRY3ZOrUE+edrFKzt6uncwKNC6ys94rEjWlEKqi
	surZIDOI7H7RCx8AMHQGs0ZgInLcrZnOzdnKFEus1ld9fujwV/Sc3pwY4yn10R1kIoOkfFv41Tj
	1WbFjxpv+zL60UmIYUXvdStaIsE9xE/TI8ZdskPkCpxwfS+cY5gjtUL4yRqUnwVbWcSDI1LBhcZ
	kkEVCXEqLXPMQsSQEry40IGSc78RiAqwt174teyRJHqes76ELIYO6JdZwf8VixaLSqPFNkDVwi6
	as1yBwOIGKv2sKNJ+d3avfIxZqYeRGjzmud3vH2ApXLg33D7FMOODxi2QJ0/kVv8mahdLMij2gO
	D7z+F2sGPRB13wkxyydeQcU/JQauoGLROYPPMW+7qeiwBZ2yUljr1fMYh39npIkDsxFcRw/xDI3
	DcwpoqU4UMuM1oZ54FnUHpFjJ/SrJSKXvot+/7UUZJTqVcCV7lUHEuAcOUvYUqEqcdZt/v
X-Received: by 2002:a05:6102:3ec8:b0:6e7:5c89:3fb3 with SMTP id ada2fe7eead31-6feef48d3b0mr12283555137.3.1781066821294;
        Tue, 09 Jun 2026 21:47:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-6eb54243686sm1348980137.2.2026.06.09.21.47.01
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:47:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8423f6247c6so7162170b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066820; x=1781671620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbsY/3rgJvOcLk7hML33yFKFiI/FIBm17M2LVVUiNEI=;
        b=fmwnogZaio/L+jGgnLAsAx9izLFD2KzRdoQbRYgMyjga3gQeICCMq+lAO68fzbxQ1e
         jEIOjZv8E7p1NDFtigkrxWXRPS4jZfeLMigk8kWGEEqNa3KsWOdq2Lrq4DHmgs+XKbjw
         0ZjYpRbdBPlyUr0dVdP/3imgyAng0BYXq8kIE=
X-Received: by 2002:a05:6a00:21ca:b0:823:d2c:b156 with SMTP id d2e1a72fcca58-842b0d83af6mr25248976b3a.5.1781066820163;
        Tue, 09 Jun 2026 21:47:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:21ca:b0:823:d2c:b156 with SMTP id d2e1a72fcca58-842b0d83af6mr25248961b3a.5.1781066819816;
        Tue, 09 Jun 2026 21:46:59 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:46:59 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 10/11] RDMA/bnxt_re: Fix the cleanup upon error during CQ create
Date: Wed, 10 Jun 2026 03:08:54 -0700
Message-Id: <20260610100855.64212-11-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260610100855.64212-1-selvin.xavier@broadcom.com>
References: <20260610100855.64212-1-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	DATE_IN_FUTURE(4.00)[5];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22065-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51828665CE8

Fix the failure path of SRQ create. Destroy the SRQ from HW and delete
from the hashlist if the page allocation fails. Also, add an explicit check
for NULL before calling free_page.

Fixes: e275919d9669 ("RDMA/bnxt_re: Share a page to expose per CQ info with userspace")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 3d5659442c29..dd1afa4a2b2c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3568,14 +3568,21 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	resp.phase = cq->qplib_cq.period;
 	rc = ib_respond_udata(udata, resp);
 	if (rc)
-		goto free_mem;
+		goto free_page;
 
 	return 0;
 
-free_mem:
-	free_page((unsigned long)cq->uctx_cq_page);
+free_page:
+	if (cq->uctx_cq_page)
+		free_page((unsigned long)cq->uctx_cq_page);
+
 destroy_cq:
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+		mutex_lock(&rdev->cq_hash_lock);
+		hash_del(&cq->hash_entry);
+		mutex_unlock(&rdev->cq_hash_lock);
+	}
 free_umem:
 	ib_umem_release(cq->umem);
 	return rc;
-- 
2.39.3


