Return-Path: <linux-rdma+bounces-22253-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y1bVHPY1MGoYQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22253-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:27:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2020688D91
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:27:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=RMjUznam;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22253-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22253-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64EC1304F147
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115AB416D0C;
	Mon, 15 Jun 2026 17:26:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8714440242B
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:26:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544363; cv=none; b=S5LHobFICI50HXj/3x55GET2itFdQdoPhTKa485gxXliscAJzn+rNBOs7Ip3m2sHQ4s3bWH0IRBufq3Dgh1Oo5oy7sYYeHHPOfVMBn+sfJsiBz1VOSfsfCaNiwatOO9Z9KjwWdaGea93UYYn1SAxRs2xCEMzCXVKJ34pgqOKxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544363; c=relaxed/simple;
	bh=a8SuFItsIzEe9SnzjvxJuPE4/pMSeBnVMrlCecXmsdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeTElIFTaid8tcDMu5nx3UFlGfRIQdpaxgrxsPGZV82M2CyfvhjyBb2fqQVoA2qo7NvBG29qp3Kr1aH4oluPF3kfCXAmHLmPSpvg4+Eo2eje2Q4WiS//b+XfENIW/n0HC7d0lGUhjLs0g6Zd0JLnBhz02Lug1qkCxLI8T6DaVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RMjUznam; arc=none smtp.client-ip=209.85.128.227
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-7defee656dcso21829857b3.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544361; x=1782149161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/BPBJXvOrqLYF1yGzgexsntmBrTmrIuYARzfLvinS4=;
        b=TGTQJk+l0Jp3DQ7r4ykxwqQGOy38R14oJMnln1Y9ZhrqHimMAX9FfH089kq7NYe10G
         3zP+XY4HOMFnR+vBlOQnzva2BEiOnZtmCu8pMOlcAgzJMBzQHbmDWf5Fuqvtk0VQAQd9
         9CWD0XA+fMjVxL9B1tlUR/J4+MNwgkbnqy/GWXu1yp/SVPQCDAnKnAqixv2mob2gIJfx
         V0Qh20bRhrX/E7nBtZmITplyFzfN4fCTASvkv9FmH/aqRevJ6sLanWiWpFAKOlxuLBQ3
         i3NoYnJcFx9rxFa40otXRcZyQ74Fy6KJfR4GjK43opPgqDbFvz2X8btwq5NwbH1SI5CF
         uIHg==
X-Gm-Message-State: AOJu0Yz9LX8S2lH13LbNl9mvGB/ihG8RCwoNpvnGII/1p4mE3IFANbW/
	V9fqGIEK4uPcKsidvLtx8lzKm6Qjic+Gnov5AceRwa0CUi49LQ9KACl0rWx0tfNmQqmCICPf919
	mXwTkN5ToFcUfARxdd12GUB8rJfyZPl/IMjM59FjxH1nt5eUW/LiA/lk0VNZel1wALU9K8XALbx
	kJ6JBLHGaIj+tg4zHCSErgzNGzsF3kUoESkghnihwSyARGwvI+PLCw4mpj7VHItjUHoJ3TlEPLE
	uo7KHRoJ+RfkAZK9A==
X-Gm-Gg: Acq92OHLIBgOSkmzALJP5+dHWBA+2pUuIN0m/1cz4JWpne37g7tNk8Uk5jjA8ro/72F
	UAmDGG9JMEFIJwblemn2Y8yrTlY8PpJurwqdSJesEBoluWSSdSGSSkOnSG6l8j46vNkqNC9NIcD
	ZM6xhMpt4lF/LUfOtTQl/s4bxP5nTe2zZ8u9FATIUWG1t6ADwKzSzdFAQEv5HQsymPo475VGy+7
	w+CFqFd/vx0BxvbHoaKfmUOrTlOMrvRhzyCv1rTTuXcf0nLPBoVRvYSSfQf0o4RPtuifXrp9gxZ
	GwpJVJWxaKSZg5lwVKAPVyIB2g+hm5DW6IX5D8e2/HV56cfMHtfwaB0F9fGnWAQijUPtL/jcvR4
	lfOCcd9Q0ioWvYwxAdscQj+0okUPMuX8CP7MenfktpkStnEs6/cIjY76BCTZG10AupxE5DcACHP
	Ra76PsAUFTf1Bg6Yo8v9FDloMIis9UpMPC+h1Ih4EOXJmkDT+sU9G3C3N8qVoM
X-Received: by 2002:a05:690c:25c4:b0:7db:f1b4:15d0 with SMTP id 00721157ae682-7f8c37d28d1mr117898337b3.33.1781544361381;
        Mon, 15 Jun 2026 10:26:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7fcd03cf295sm271007b3.9.2026.06.15.10.26.01
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:26:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c2b64850easo21386365ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544360; x=1782149160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/BPBJXvOrqLYF1yGzgexsntmBrTmrIuYARzfLvinS4=;
        b=RMjUznamts0gJnqzmPZhdiqKuyAYfZScJ1m6pJU6u1yARKjEOaiDoLraOfU3STjB7i
         F7p8R9UtVclRv+Pa4LnevAiT/im+3l/Zf4SVxuRcJfUProkxhQpdsztHy2dZp62oPFjp
         +IDV4mk5dEnLgPfBv/YbDpXQrkS3LHOvFC7Sc=
X-Received: by 2002:a17:902:ea0b:b0:2c2:1982:527a with SMTP id d9443c01a7336-2c6641c2ad0mr119871045ad.16.1781544360127;
        Mon, 15 Jun 2026 10:26:00 -0700 (PDT)
X-Received: by 2002:a17:902:ea0b:b0:2c2:1982:527a with SMTP id d9443c01a7336-2c6641c2ad0mr119870795ad.16.1781544359625;
        Mon, 15 Jun 2026 10:25:59 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:25:59 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 11/15] RDMA/bnxt_re: Avoid repeated requests to allocate WC pages
Date: Mon, 15 Jun 2026 15:47:47 -0700
Message-Id: <20260615224751.232802-12-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260615224751.232802-1-selvin.xavier@broadcom.com>
References: <20260615224751.232802-1-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	DATE_IN_FUTURE(4.00)[5];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22253-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2020688D91

Applications can request multiple WC pages for the same ucontext.
As of now, only 1 WC page per ucontext is supported. Add a lock to
avoid concurrent access and a check to fail repeated requests.
Also, if the mmap entry insert fails for the WC, free the Doorbell
page index mapped for the WC page.

Fixes: eee6268421a2 ("RDMA/bnxt_re: Move the UAPI methods to a dedicated file")
Fixes: 360da60d6c6e ("RDMA/bnxt_re: Enable low latency push")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     | 33 +++++++++++++++++++-----
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 1626bbdd0d68..dc546308b46e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4801,6 +4801,7 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		goto fail;
 	}
 	spin_lock_init(&uctx->sh_lock);
+	mutex_init(&uctx->wcdpi_lock);
 
 	resp.comp_mask = BNXT_RE_UCNTX_CMASK_HAVE_CCTX;
 	chip_met_rev_num = rdev->chip_ctx->chip_num;
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index ff3148340fd3..882cc17711db 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -149,6 +149,7 @@ struct bnxt_re_ucontext {
 	struct bnxt_re_dev	*rdev;
 	struct bnxt_qplib_dpi	dpi;
 	struct bnxt_qplib_dpi   wcdpi;
+	struct mutex		wcdpi_lock;	/* serialises WC DPI alloc/free */
 	void			*shpg;
 	spinlock_t		sh_lock;	/* protect shpg */
 	struct rdma_user_mmap_entry *shpage_mmap;
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index ae8f46ab6961..b5e4cf62b63e 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -104,14 +104,23 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *
 
 	switch (alloc_type) {
 	case BNXT_RE_ALLOC_WC_PAGE:
-		if (cctx->modes.db_push)  {
+		if (cctx->modes.db_push) {
+			mutex_lock(&uctx->wcdpi_lock);
+			/* already allocated — one WC page per context */
+			if (uctx->wcdpi.dbr) {
+				mutex_unlock(&uctx->wcdpi_lock);
+				return -EEXIST;
+			}
 			if (bnxt_qplib_alloc_dpi(&rdev->qplib_res, &uctx->wcdpi,
-						 uctx, BNXT_QPLIB_DPI_TYPE_WC))
+						 uctx, BNXT_QPLIB_DPI_TYPE_WC)) {
+				mutex_unlock(&uctx->wcdpi_lock);
 				return -ENOMEM;
+			}
 			length = PAGE_SIZE;
 			dpi = uctx->wcdpi.dpi;
 			addr = (u64)uctx->wcdpi.umdbr;
 			mmap_flag = BNXT_RE_MMAP_WC_DB;
+			mutex_unlock(&uctx->wcdpi_lock);
 		} else {
 			return -EINVAL;
 		}
@@ -134,8 +143,15 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *
 	}
 
 	entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mmap_offset);
-	if (!entry)
+	if (!entry) {
+		if (mmap_flag == BNXT_RE_MMAP_WC_DB) {
+			mutex_lock(&uctx->wcdpi_lock);
+			bnxt_qplib_dealloc_dpi(&rdev->qplib_res, &uctx->wcdpi);
+			uctx->wcdpi.dbr = NULL;
+			mutex_unlock(&uctx->wcdpi_lock);
+		}
 		return -ENOMEM;
+	}
 
 	uobj->object = entry;
 	uverbs_finalize_uobj_create(attrs, BNXT_RE_ALLOC_PAGE_HANDLE);
@@ -166,11 +182,16 @@ static int alloc_page_obj_cleanup(struct ib_uobject *uobject,
 
 	switch (entry->mmap_flag) {
 	case BNXT_RE_MMAP_WC_DB:
-		if (uctx && uctx->wcdpi.dbr) {
+		if (uctx) {
 			struct bnxt_re_dev *rdev = uctx->rdev;
 
-			bnxt_qplib_dealloc_dpi(&rdev->qplib_res, &uctx->wcdpi);
-			uctx->wcdpi.dbr = NULL;
+			mutex_lock(&uctx->wcdpi_lock);
+			if (uctx->wcdpi.dbr) {
+				bnxt_qplib_dealloc_dpi(&rdev->qplib_res,
+						       &uctx->wcdpi);
+				uctx->wcdpi.dbr = NULL;
+			}
+			mutex_unlock(&uctx->wcdpi_lock);
 		}
 		break;
 	case BNXT_RE_MMAP_DBR_BAR:
-- 
2.39.3


