Return-Path: <linux-rdma+bounces-22061-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HEoVC9rsKGpbNwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22061-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B03665D01
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=fFa0Bqv6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22061-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22061-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F333830E6911
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D9935DA42;
	Wed, 10 Jun 2026 04:46:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3E2DA749
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:46:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066810; cv=none; b=S0wgAC4pNtTqThr9t88rs45f1Z1j+XnJpDMtKu5AksOWHT5IqWESTO2Bv3G1RTMlSoVY0GAxf+uLKFYPdeEaXiDmOLt0qRbiesMjyMrg/CdEMiGFGnSUKt14rHGDr1gfLmqYUxMrwS8HJ0N1IVDNprqei3Q2gm/RukSRky1cjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066810; c=relaxed/simple;
	bh=jGgCHCZrl19ac/zk+96OfC/5qJI4fH+xaGgIbb48cFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKCyes8CfxZQzFB56ajXAnGdKEYkVRyU1tMryK3d+hjSLYFt2KrJ7fmgdvf6TmqPLHoIlg1yKqDKyhOvj3vrwdU63aDEyp3MFYSglkev2k9DPUoORLeeuESLA60wiJXAJT/B0sQyKFX9BC24zbdZlVlgXHNu5f3Nev9m46zOP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fFa0Bqv6; arc=none smtp.client-ip=209.85.128.226
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-7e8833c99fcso70448157b3.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066808; x=1781671608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPRn9GC3oJ3eRTiV4q9LpejtlwI5WrH7/FNR+E+uV48=;
        b=B5dKPUTywc4SaPnxJJNzJunl75q5LQ6qj6d+ZXN2dwZ6tjVRDKBqjeIFq+YA024Td7
         j+i4J/r+kMQpCe7ohjTpYBGKe+yWH0H9lOne+q67mDZuqmD1QM9ANMYdg2nfRjhzs/X3
         TbQh+EcAu953He4uvSDsS/vLotLe81hhNXk3jUQV5c3jYcvkFiuZmIr5tjliuh90N4yY
         4pYL7EJSxKB7CwSgl8bAbfa+U5zHznZqS2q0WzFEAChRGaW980BfVUVQF+qtrxLnkwLL
         UQm0g6dF+qRVUYZPeygfFp5pINdapAqpl2+6UE4rXduixOWfgo6Of8tWD2Zvr0VYN2ZC
         WnlA==
X-Gm-Message-State: AOJu0Ywbc098owQEvyC3LQIu6FT/WziHBKBLXIRnmBvZIVztGCii5Hm2
	oNUXZULCcWWhTU+s/3Kmd3iMEa6ZsZiJkiDE82Tq1thv0Jr8ehxrbup9AuN0vQ+iBx3cvq3AqX0
	Q36qlBXgP5Mv7x/4tJx7dOXrdZrHhZJ5SRsQ/Q9J3uC7qf6Si9rfdJl6D9QcwE3Pv5CA3FXbP7C
	3J1PaOFDL4CH9rxkvogT/kFdPeq7lKUrhPMEtB7DHBkV+Qin9e8+9ZhrWQRHKd/anYbHzouLw/8
	tAaQxE+/P7DgEHJHw==
X-Gm-Gg: Acq92OGmjHGl2z6dgHhIgRl7EWc68/i6CI5chm/sKypzDSiYlFsRe8J+mvmau7mXfjF
	dRTKjSCinEC8ZaZIjW4uxrVvPBAZ2gBBkGEKPoCVeH0q6eDyl0olO3Ujfbq+Zn6zvW6qZopC+KM
	8UYktnr/5a1V2i09BAWaK4x6AcyDH/owWigahYHOzanKec0rjHGlD+8MnYev0uD424ztSay/CPO
	A3jNQug5pFJJme08ZzKJE5EHuzdxFZxIe685SYLoVJr257qSTticmspNKVsaTYg0+jh+zABnpjA
	HfXB1Mmru5gFExRh5RGlxXao+gwaQ2wn8O7/Sji0OTpuFLeLGb881Y7GLEl/ofVwCCtNZj05s2n
	lrs13u7zy7GGIKWeGygLTZSeKlusd6vvQ7f8pruPQ45TkSISxKN4JU0NbyFjlrB720pDdPWVp6X
	zSIKTmas9CEFuDgKhO+uQNtkId7wAxSUoJloQd6NSobWHUtx0ajI+xDqTCnlheg9ZBjha2+vI=
X-Received: by 2002:a05:690c:dc8:b0:7e8:6d46:a17a with SMTP id 00721157ae682-7ed0d5bd548mr239716247b3.14.1781066807924;
        Tue, 09 Jun 2026 21:46:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7ea2358dd81sm17399937b3.13.2026.06.09.21.46.47
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:46:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8422f987f2eso9814592b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066806; x=1781671606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPRn9GC3oJ3eRTiV4q9LpejtlwI5WrH7/FNR+E+uV48=;
        b=fFa0Bqv6nCR14zOECI+YrqrXHXkY/MMUkJbGb8Bm32GqkSAAThXWXrm2wnnHJxlUz/
         4uRgePhzd7utXPEjQssgEIBBXNF40NbfpBnGykvkySM79+lDewLYSUIN6UojMoKmx01w
         6sydAa2ioF1gip/Qs0hmR5RbtiTPOrz0O4ZP8=
X-Received: by 2002:a05:6a00:21c8:b0:842:5564:2e2c with SMTP id d2e1a72fcca58-842b0c08407mr25427656b3a.5.1781066806584;
        Tue, 09 Jun 2026 21:46:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:21c8:b0:842:5564:2e2c with SMTP id d2e1a72fcca58-842b0c08407mr25427624b3a.5.1781066806133;
        Tue, 09 Jun 2026 21:46:46 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:46:44 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 06/11] RDMA/bnxt_re: Avoid repeated requests to allocate WC pages
Date: Wed, 10 Jun 2026 03:08:50 -0700
Message-Id: <20260610100855.64212-7-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260610100855.64212-1-selvin.xavier@broadcom.com>
References: <20260610100855.64212-1-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[selvin.xavier@broadcom.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22061-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,m:selvin.xavier@broadcom.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: B5B03665D01

Applications can request for allocating multiple WC pages
for the same ucontext. As of now, supporting only 1 WC page
per ucontext. Adding a check to fail the repeated requests.

Fixes: eee6268421a2 ("RDMA/bnxt_re: Move the UAPI methods to a dedicated file")
Fixes: 360da60d6c6e ("RDMA/bnxt_re: Enable low latency push")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/uapi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 0fceaf52bf4d..abd8f90ca0fb 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -99,6 +99,9 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *
 	switch (alloc_type) {
 	case BNXT_RE_ALLOC_WC_PAGE:
 		if (cctx->modes.db_push)  {
+			/* already allocated — one WC page per context */
+			if (uctx->wcdpi.dbr)
+				return -EEXIST;
 			if (bnxt_qplib_alloc_dpi(&rdev->qplib_res, &uctx->wcdpi,
 						 uctx, BNXT_QPLIB_DPI_TYPE_WC))
 				return -ENOMEM;
-- 
2.39.3


