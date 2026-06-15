Return-Path: <linux-rdma+bounces-22254-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QtQ/E/o1MGoZQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22254-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:27:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6149688D94
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:27:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=aJWXN3P7;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22254-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22254-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35A743053FD2
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF2D416D0A;
	Mon, 15 Jun 2026 17:26:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3694416D05
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:26:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544367; cv=none; b=bg5PkmHvSZ7e7FPC5ZIQFn9on7SRNLAz3F1ncfilaA3Co7cLVO8uNPf1B10k4BnaVDDQYWrE65HSqp2jKbzdVGeUha2XqyViCjubS9zQyWjdiyf4YHElCrNh3igzVUeok0S+OPOi1IVTer7Lb1jWbfQau/nthjnk12mqF7237XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544367; c=relaxed/simple;
	bh=/bW5BY1aF8hIYtjCpVZ4AnsAZB7BdfWTnnChYEANTac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTIdnsN//u0ZgAYjXVJlj5QwTfNWRUXxPpSPtmmlMR52bGP73aV6YZYqcRfrIviiygdWiNKUO/eK/hojp1db+Hu867mmZN28WO5UiMSg7Wu6B0p8ulWY45du0qd3w9cf3vhh+DXb6fLXbQzgQ4jRo98Zn7Zg64VKSqtqpo8lugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aJWXN3P7; arc=none smtp.client-ip=209.85.160.99
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-43d3427401fso2548421fac.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544365; x=1782149165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6AM5TTqWP5/x+LFJAta7w2qXDWCwQlRQL810edAy88=;
        b=fXQuHEf9FIe9S/yYtpO429SkuWcGrMJUzomtbmdf+JhMnErpI4bmGmAFWKUjdAKX4i
         u8hV2spOSbrfow/rzwzP83Kyktl0qOydG8Ch0XGovkPFKIDUJDv1aa38YgRAPzwSE0UF
         pB7387MOkkF1H98/oBosPng+q9a8AIA1n0YlcNcqNfKvTj2a2O/PQg+6MHuphMAHZ+rz
         VNAKa+4MI6zWJ8JSw27yxpSy2OsO6uycgZc07DpOr2oZ98erbjl7DhIUqkoWXDDa/AjQ
         k0ZhIV0OVKdKBNwIISo+Gj4OuyM95nnbImjkXTusH7aTHHJA5jOtlBFfXRSt5yV2CqnO
         b57Q==
X-Gm-Message-State: AOJu0YwlgdmuNGIAJ1HBXZF0ewPZdmiHK5h4erD5I0myS+tNzvAdIq4T
	4l+O34Vlwi5keJzGCiD1WE5X5fpkwdvlTU0VLBDmR0eH7EaeRar+Ky4v8zUqPTe3hXGRMIx+cUp
	hDbjB/NSy7BUXeviLK7riUardA0GADgkUd+L9+7UBO1R7HeNsE3ImJzZ+uVAUplOnVm04ujG1X0
	JxjkmqhQhGmC7Mk7GBkffbvxV7ZJwSYRReMUL9nTBbhesjpr6VWKPuOYaxrePNWbFRqjXN5Wk7a
	orhJTXVkrlCbEhYkA==
X-Gm-Gg: Acq92OEQCBorcn9UuyiMARvLhDf8iwevERDjQHbL5U+UhQGgAnPT3AYQnaBxDA4Dz2z
	wPBUdwcXX4Q5W9XvZjjndDkCthFkaymVpuHaRTv13mfq4+lj3JFmHDFTzWQ2N7UbuKY0UjBqJsA
	mYdLNZjk8661L3TQ/LCvvtOk8jrkiFUiA/2jZ1LMkpM0X1ZFf4q5+mpE33FrX//Bs57HMCgQ16/
	qu8NSuMKok+QYIyBeDIWW0HmccFGXBIMcKO44oMQFFlzTr10xkuM6DxLapisJPROZc85wm3rWXX
	4NdgwhgHsR8NJ25ncD9OeJSvke3rJAHWqEBkINoE4wGhf1ExAzAEKOLIW8Et5Chi0ulGUgmvaEH
	rqXiayYDjwnnE3C329u0W3iLSO3ZygXCP+tOaJncc4cls2GiR+j4gbfar0FDs8dYO+yFpcUP7Gc
	V9DKBrzreqi/qPnM2QL9aV4Cjrki4BBAwG1+8hXzcSRkoIamzAzscH6LYV1Q==
X-Received: by 2002:a05:6871:7241:b0:43d:d0c:ac30 with SMTP id 586e51a60fabf-4430ae26e39mr274974fac.0.1781544364634;
        Mon, 15 Jun 2026 10:26:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-44308a358bcsm40339fac.2.2026.06.15.10.26.04
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:26:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf32fb7cb2so26518655ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544363; x=1782149163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6AM5TTqWP5/x+LFJAta7w2qXDWCwQlRQL810edAy88=;
        b=aJWXN3P7rxdrUVt7up8M2/rMFr0SosMbHUc3zFWe9EJVGoKXctEkza8cj43AQ1nGOQ
         xp1W6fSuELQTnDdbImhVJRzI/c4EN5Mf4b9k17Wg6ynkT1WSgon7B9+5r5KOlWzawsvr
         3RMYu9R8jmvW3o4Z4N31IFz36fcbB33THvTYc=
X-Received: by 2002:a17:902:f54a:b0:2c0:a746:7aff with SMTP id d9443c01a7336-2c69a186b1amr1633675ad.24.1781544363266;
        Mon, 15 Jun 2026 10:26:03 -0700 (PDT)
X-Received: by 2002:a17:902:f54a:b0:2c0:a746:7aff with SMTP id d9443c01a7336-2c69a186b1amr1633485ad.24.1781544362817;
        Mon, 15 Jun 2026 10:26:02 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:26:02 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 12/15] RDMA/bnxt_re: Fix the cleanup upon error during SRQ create
Date: Mon, 15 Jun 2026 15:47:48 -0700
Message-Id: <20260615224751.232802-13-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260615224751.232802-1-selvin.xavier@broadcom.com>
References: <20260615224751.232802-1-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22254-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6149688D94

Fix the failure path of SRQ create. Destroy the SRQ from HW and delete
from the hashlist if the page allocation fails. Wait for any concurrent
bnxt_re_search_for_srq() caller to release the pointer before the RDMA
core frees the object. Also add an explicit check for NULL before calling
free_page.

Fixes: 181028a0d84c ("RDMA/bnxt_re: Share a page to expose per SRQ info with userspace")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index dc546308b46e..33f212bab544 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2293,6 +2293,8 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 			srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
 			if (!srq->uctx_srq_page) {
 				rc = -ENOMEM;
+				bnxt_qplib_destroy_srq(&rdev->qplib_res,
+						       &srq->qplib_srq);
 				goto fail;
 			}
 			resp.comp_mask |= BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT;
@@ -2312,6 +2314,19 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	return 0;
 
 fail:
+	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT && srq->uctx) {
+		mutex_lock(&rdev->srq_hash_lock);
+		hash_del(&srq->hash_entry);
+		mutex_unlock(&rdev->srq_hash_lock);
+		/* Drop the creator's reference and wait for any concurrent
+		 * bnxt_re_search_for_srq() caller to release the pointer
+		 * before the RDMA core frees the object.
+		 */
+		kref_put(&srq->srq_ref, bnxt_re_srq_release);
+		wait_for_completion(&srq->srq_destroy_comp);
+		if (srq->uctx_srq_page)
+			free_page((unsigned long)srq->uctx_srq_page);
+	}
 	ib_umem_release(srq->umem);
 exit:
 	return rc;
-- 
2.39.3


