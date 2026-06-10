Return-Path: <linux-rdma+bounces-22057-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id URO0Fc3sKGpYNwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22057-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3C7665CF4
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 06:49:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=JfOYUjwC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22057-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22057-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42AFF30BB524
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 04:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702F2DA749;
	Wed, 10 Jun 2026 04:46:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7961FFE
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 04:46:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066797; cv=none; b=k2wgbf0mfwfkqZmnA1bux9ONx/P/4ul0n2o6a5FMsG+ER2pB6OgtHP2OHZbHQZRJ1bvXziJEvRSNfWa9NXy8t+PXUY7UAMfSY6LXE2Gy8LNw5Plw8jI1YLSWtZFcjPjJb9I1T/C4m5SYxhNKXQpqRT3ieqKh5dlalVBsw6eQqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066797; c=relaxed/simple;
	bh=mg1goxCGs3dMeE4ua5UT5oyYmU34I8cDTTizaLECgzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XSSsb880i+f1qop32gc8n5Rjmo/HJd5lZoZluqscQ1+aaVG47oL5oj7bvmsAyjSAxc7mAxfIEjVCPs9euOAiPYzShtxfW1Wg05bu1Lb5dj5d4zJCkcNkXDPGsOl62rCQMLQk8Je8hqquIqTnLd+N2aw4xFsWSLmygqB+rrHmqCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JfOYUjwC; arc=none smtp.client-ip=209.85.215.225
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c85ba774551so2281855a12.0
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781066795; x=1781671595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XuPAPA3CTH/GnLbKWUVh/FMscdWIdgkvt4MILjcJggg=;
        b=PU/NTrqEBAeebBP2lT/9aBJSMPHZR5fHODFEcS0qaGpeX41xwBAPP6ASPTFFcsvTrw
         ktfJmZHs38XB87nG9Y1uUwTxmj9/Q+7B3kReW6LtuMHhatoflnrjIqRnDbealRMX80WI
         EyVi9TJ+54+P7B4jZwI2l/VU6dOsJCXoop3mNlRsTIMeyRrvTSilTrqNr6RU2LvWXsnV
         giHAblkakgmR+oyOU2uor1Z4sv4E4bTsbO7Y2oDlDBxx54MT2JjB3b+ayDpUv5UKPx4e
         ITDeisw6e3zoEvj0rNkEhnEAWJymgIBZ5uuvH4nB96DBGzJjvcDvnKsA1VNzFNS5TIL7
         tJJQ==
X-Gm-Message-State: AOJu0Yy1M72Vys77CMTY1c9iCbKnc5kNi+/UW5t8VryUL/b225UEFevC
	K7nVtVwj+qI2dAkaqzNGGKDLx9JxpzUrTOvVXu5/UyZIGt2Z3pUFoh2B6orMU/1+vX33/rZrCzz
	eHRL20WUmShdzvOK9AiF4rs+sqSrTxVuYhFzO/gGWq9tWt8rWgdBwzD4jZtz/s0JOSoqqyj9OM4
	XXSwR2bAU+roXosNF9j3XKJ3gszclxp474h/DXX2BFZFKdasH8EtW2BXVsp/wloERO7NFXGSwp1
	c2vIH9GGHqOjjT7VQ==
X-Gm-Gg: Acq92OGXLhEyDYuJ4IjpToW8/tzGmzUm9aVm5YEnGxLK78BeAcb/7G6rIH01ebE7wAh
	3zZ4VTF01v9A6N+sXtvMB5sI517d+5op/I3B92OnNX9Q+9cBKTSjHqDQZjwoFJ4loEnsVoz+r4s
	TDs8LZxOhpklpEodlU6foeCexFXnSFcvRj4hF+3xQSn39w845wOkBmistF/7UrF8xbfT9Wpd0Go
	x6CAKeUHlXyWRdJVTJqxXmfyhkdzA1UaAKred+Or06A8VDnqo2VFVgoNWWYRXXKA7P8BYawozky
	pDijTiHh89nfdY5NlN1AwVCSg+UeWtxYV0iuiS9tXDzJqb4CKXa2w3FDt5c/+acUHNeuBKZYnvI
	bLZ3YtSxmZjuVZ4kUjBb6pZnsNKkNEE0G5nFZ3z8p/2NfZmaBWtyUcEXUUkkCdWXDEtrkQQKddx
	qwYhdYHB5SV+xe917QsZfqBjHmbKFcKsOGW8gRCIs9FJmW7I7SI/MIIy2cbqWCnSk6sIKOnMQ=
X-Received: by 2002:a05:6a00:c91:b0:842:6ec3:2359 with SMTP id d2e1a72fcca58-842b0fe10ffmr23724826b3a.45.1781066795321;
        Tue, 09 Jun 2026 21:46:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-842825e716asm1590317b3a.5.2026.06.09.21.46.34
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 21:46:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c858e0cbca3so3330509a12.2
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 21:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781066793; x=1781671593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuPAPA3CTH/GnLbKWUVh/FMscdWIdgkvt4MILjcJggg=;
        b=JfOYUjwCE9FPe3eoDKs3nyGRNhGl1A8NnIswoSJ8F7fwQqLA19WerBJIY+E2/d4+us
         LH8cMSxrE01DdTRY9vy5B2xLRsgyXcCVPrYsMHKwdI0eMQhHiOZ+Ud+yTH2xrbYI2Lx8
         ZQTTwxU/aVoPVMbBStBMzR+uLhBlDvHDFOxjk=
X-Received: by 2002:a05:6a00:c91:b0:842:4327:6cfb with SMTP id d2e1a72fcca58-842b0feb656mr23982946b3a.46.1781066793429;
        Tue, 09 Jun 2026 21:46:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:c91:b0:842:4327:6cfb with SMTP id d2e1a72fcca58-842b0feb656mr23982927b3a.46.1781066792967;
        Tue, 09 Jun 2026 21:46:32 -0700 (PDT)
Received: from dhcp-10-123-65-43.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282375f2dsm24532821b3a.19.2026.06.09.21.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 21:46:32 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 02/11] RDMA/bnxt_re: Add ownership check while getting the CQ toggle page
Date: Wed, 10 Jun 2026 03:08:46 -0700
Message-Id: <20260610100855.64212-3-selvin.xavier@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-22057-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF3C7665CF4

The cq resource id provided by user-space is used for
searching the driver CQ structure. Validate if the context
currently issuing the request is same as the context
created the resource.

Fixes: eee6268421a2 ("RDMA/bnxt_re: Move the UAPI methods to a dedicated file")
Fixes: e275919d9669 ("RDMA/bnxt_re: Share a page to expose per CQ info with userspace")
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.h | 1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b1c489867fc7..239eeb019550 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3489,6 +3489,7 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		return -EINVAL;
 
 	cq->rdev = rdev;
+	cq->uctx = &uctx->ib_uctx;
 	cctx = rdev->chip_ctx;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 4d6d1259a795..0ef8a8b20430 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -102,6 +102,7 @@ struct bnxt_re_qp {
 struct bnxt_re_cq {
 	struct ib_cq		ib_cq;
 	struct bnxt_re_dev	*rdev;
+	struct ib_ucontext	*uctx;
 	spinlock_t              cq_lock;	/* protect cq */
 	u16			cq_count;
 	u16			cq_period;
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index b9922360f11b..09026ef0441e 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -251,6 +251,9 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		if (!cq)
 			return -EINVAL;
 
+		if (cq->uctx != ib_uctx)
+			return -EINVAL;
+
 		addr = (u64)cq->uctx_cq_page;
 		break;
 	case BNXT_RE_SRQ_TOGGLE_MEM:
-- 
2.39.3


