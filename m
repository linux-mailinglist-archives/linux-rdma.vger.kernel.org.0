Return-Path: <linux-rdma+bounces-22058-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hp3+L9DsKGpZNwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22058-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E12665CF9
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=Jxtmx6Kk;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22058-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22058-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3328D30CD8A6
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60A72DA749;
	Wed, 10 Jun 2026 04:46:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF412E92BA
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:46:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066800; cv=none; b=j2/0Ju1+vWd8cmIxsXJYFqIvXkh9VXkeBbilUDSPckcmWQfeChYswQl9ArKNx3kslmNhBc00w1AwbK1Kgo4EvMC2yy6UfdCB1xgIDE9TVpht7lkhI+6meGtdi0aTEZj8r7yJAT44UEBQMdC/MYsDnjEdl5TPUcB5tyRVwvuimEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066800; c=relaxed/simple;
	bh=2WM0XySqpcccB+U8x7Z4TTg0yu8nTZ+kEYOPYguoXTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdK8YOqB7dlkxFFogRvZeOVNFl7rgdgo16+jhrVenSYrwnSLYLjSoQqs4Gs8tpHxAAi8fwUY6rtSGD/OQ/QOUxmTMD/qHo3EagVPGkQLKWc7MksYE+BW7joIqXRpZgrp7lXGV4AYyzlfxOASTcjguVhesTl6xKPM0fAlKXLIkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jxtmx6Kk; arc=none smtp.client-ip=74.125.224.99
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-6604df9ba4eso4842600d50.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066798; x=1781671598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYqj/m9uimi9jO6U8gC/PIM/j0UsbLezL4pCe+9z/+s=;
        b=dRxEDgdBHRRCyapfXP93KF0+EnYZIVwvBWlOnc4jRVECNn3ajt30h5JidX5pA51B0F
         snr7jURgyrxFrOj/phtpczzgMt6js1MI9lXBfa0hlgf5d6b+lj6+8jK6KXuu9Y2uVSFS
         SQ4ZG4rfLu+E/fK4zMZVetLHfBCMky1OMhuSfpKI64N2VHFFp3qU8tVH+tX1MUb3OXaa
         P/AwttFkRL6HMXneiR/xifAz2aCqz5TKIkiPsWzAS+B4XqNNHBPDhXoBK1ZTmy8oTor3
         FDw1+ZcbqC57z5oPTgEkGDbA94R9poftOVpcQkthEcZA8x5XzeKjKzgIg8b/CXFlrOVC
         kXhQ==
X-Gm-Message-State: AOJu0Ywtn+I+DN0yjAM/ti4wuZ7hviFOynRLm0ArgS+E2nU2MluXDMKb
	mGGKVYOaIJfB5l+WXoE13Oo3VclQu3muJZ0vm+jfQ3zjJ/ZaC6Yubkwxp9L8iK8TLjQ6VBQ+++Q
	wTH/+GRacN1GqUKCGR/ozOfh/ypFKPI9eX+BIrH+F2QV196R/Wxx0h03oFBG0UV7cqOVNrgkHXh
	9YGwMH5L61kKZDj1IYWkFlkps5n5uEc5Mtw/DE4K1ckBgpCTgJi4Ap5pBT2eQgD50KPuE3GAD+O
	YA4mSyQnp/QEJgyvA==
X-Gm-Gg: Acq92OH5EphRlHavRNxMgeQVwKVpAS4tAATruRvOuFQF0flNsRLBrN0qmhPQVosJ0Ls
	ReOqvSpKEg6rCJ0QvBVSSuTXjR9Q8WqtYifEy3FSW46mN2LjgQXkzKMlW1nWYLtHiAe5aLXcSTs
	Ku/6/2z02R17LF4A181HvhxGUyOxwXW72MLqirAXjrP3Ju0ASfcIvwHsgOxGDGBL0F2ZjCczycF
	ApbQcqC7htCVIwgaOB3pq0UrW/86aA13n25XZs2yuyklucLFfrR2JomKtAtlM3SKr5V7gbQ0RwF
	sIawGoB/CWPx/3YORj2z245eeABTrbmLHttxRnW2ZVvzCoonZ6zdrmQ2Wh9LMyLa6h3HXHHMFVc
	a3zMRbVWU11u245seFmO4jQ6rH+c0rvvLZo/HWuWTimJEN1vbrPFXWz7ohGZWHiXKZMyGT0xzD+
	tsizKmXDY6THJAgYCSzlSqhLRUIY2aTPmvrNmwuNLy8tz/aknyS/kJVFmBveHT5EO3NLnu0Ko=
X-Received: by 2002:a05:690c:620a:b0:7db:d527:b8c5 with SMTP id 00721157ae682-7ed527ede34mr159288767b3.16.1781066798372;
        Tue, 09 Jun 2026 21:46:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7ea20eaa995sm16531527b3.6.2026.06.09.21.46.38
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:46:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-842cb4c62f9so2929692b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066797; x=1781671597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYqj/m9uimi9jO6U8gC/PIM/j0UsbLezL4pCe+9z/+s=;
        b=Jxtmx6Kk/VTDcNQADlnHcuLk6yc7HOj8o3KmFZUEiidraBVrsUd1Qz+xQ69h96ZAFS
         p5dEd3Xx6ecyqPyXnMsF/Tz5TIGRxwoMP/l7e2znFrMlU/ZWLbn7TKEIarOdOUjrGzVU
         IyBzAAUj3eGng+cSLKg7KXABFbE/IfrgGnsv4=
X-Received: by 2002:a05:6a00:811:b0:835:51fd:b7ea with SMTP id d2e1a72fcca58-842b6764824mr17694699b3a.19.1781066797044;
        Tue, 09 Jun 2026 21:46:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:811:b0:835:51fd:b7ea with SMTP id d2e1a72fcca58-842b6764824mr17694664b3a.19.1781066796081;
        Tue, 09 Jun 2026 21:46:36 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:46:35 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 03/11] RDMA/bnxt_re: Add ownership check while getting the SRQ toggle page
Date: Wed, 10 Jun 2026 03:08:47 -0700
Message-Id: <20260610100855.64212-4-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22058-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45E12665CF9

The SRQ resource id provided by user-space is used for
searching the driver SRQ structure. Validate if the context
currently issuing the request is same as the context
created the resource.

Fixes: eee6268421a2 ("RDMA/bnxt_re: Move the UAPI methods to a dedicated file")
Fixes: 181028a0d84c ("RDMA/bnxt_re: Share a page to expose per SRQ info with userspace")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.h | 1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 239eeb019550..eed918b9cdf1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2225,6 +2225,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 
 	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	srq->rdev = rdev;
+	srq->uctx = udata ? &uctx->ib_uctx : NULL;
 	srq->qplib_srq.pd = &pd->qplib_pd;
 	srq->qplib_srq.dpi = &rdev->dpi_privileged;
 	/* Allocate 1 more than what's provided so posting max doesn't
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 0ef8a8b20430..f81978797e48 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -73,6 +73,7 @@ struct bnxt_re_ah {
 struct bnxt_re_srq {
 	struct ib_srq		ib_srq;
 	struct bnxt_re_dev	*rdev;
+	struct ib_ucontext	*uctx;
 	u32			srq_limit;
 	struct bnxt_qplib_srq	qplib_srq;
 	struct ib_umem		*umem;
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 09026ef0441e..0fceaf52bf4d 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -261,6 +261,9 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		if (!srq)
 			return -EINVAL;
 
+		if (srq->uctx != ib_uctx)
+			return -EINVAL;
+
 		addr = (u64)srq->uctx_srq_page;
 		break;
 
-- 
2.39.3


