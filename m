Return-Path: <linux-rdma+bounces-22248-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T0PLDKA1MGoOQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22248-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:25:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6BD688D67
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:25:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b="GD/Mzsiq";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22248-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22248-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 598E63010929
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190F6416D02;
	Mon, 15 Jun 2026 17:25:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD1413D8B
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:25:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544347; cv=none; b=oNf7C4fj0ZHsOMujv+9ryejAmpDQffqF+nafKPvx6t1EBGHEYps0+xYHJMa6E+r5js9gkVy0iKaefLvmoa1AbSEvpq32wat8J+zQ2OA0P9CSgzdQYGiT9Y5v+1yu2bSv7kSu9Lnl+h/4j6TfisqIT6LBpmMCzn1ct/z/XJb/rqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544347; c=relaxed/simple;
	bh=N2YMaBAWZMc4RuecJCR45RhqURjHcO9Kn8Kd+42+fAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pNNu7Fs8vr0DX7XBO2bPDx2Jhd7BYznorvpgASwcT9cfvp7bBj3Ll/CFcWq0KWQSWIW5AcsEpFO4Q8SsYGOhULfy9zcL7NrUv//w5lF7kPQfb+dWCx1TX80mA3h+Dbjp7PTdOQN1B1Wo7xw7Ai4r8gf5stkkuOF4/a++JiiRI4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GD/Mzsiq; arc=none smtp.client-ip=209.85.216.98
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-36da151a152so2570659a91.1
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544346; x=1782149146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmDOIsUWHRPTKIdO0SSKY7lygt5VPiszg9eunBaEqQw=;
        b=ZjTctdxw9h3p2HnqiLXaGuyGsG4AhlfBLoCmOC1AxiJY400Z1HspBy5SLKrmDVtc5W
         J5CXerRtNga45/XUSwDngA2uUgi9gAxzy1YE4T8gKyNX5YAcj15wGicreG40CQhJYxAq
         TqQzkU4R7jP/Erdr/3Z2NNjbDqkCeXfodpLNty4QRuXvsW3DJcSaOo6qifwuCfCyVAAO
         wLZ9xUs6OhB30z7F8jsRNIoG0FWpDg+lmES/O5nkKLNbqy6qDEH4aRuI2rYs3b7ImTaX
         FddUvKgrvwqQ2HrkvLHtt7o4JvKRzBbnj68hAo2+vIedEA18GXjAVxPFeIQA4UO866XL
         BN4A==
X-Gm-Message-State: AOJu0YxtrVZ8tgy5AppjaIZ7U6k+UbInozBUKWPx8kwFK8ZNyim55O1R
	q5VABPpgL/TDrfHgUvg83LLYzQbgZD/ufCPj/1d74PklXCM4bUTKj83mw/50zx5SfVhxLbMQZv1
	zCKwWkZ1B+gNhTVKSpcL+cW/Dt7Pe72/aMxPVFLZnmb8l6avWMywYLuhQR18GqrbVBuYKaSMrjx
	ofZZHNpSsCjDnUFpfi6BHF88vml8mKmvMkPWBgE7LIpquhdmv4cM84fJv1pXp6fzJCWUqn4Drai
	KJoKDVytuNUOL5mEw==
X-Gm-Gg: Acq92OFd4okC8v2iwk6tnkgVz3IZG516eowFJ+SEUPrhmNqulNleZjdCyTk3Or4l/O6
	vQHUSYDEWX/aRtgUmx6SXv8gIzdEKl98EjOfiTsruIpOCFYtX/kU0aBrSI1tg1fp7ZwgcknzcAF
	Q2yyZpUqBBrRqhg4ul2tT6WS9sAbr5KMDLYb4PezWXOZwKBZrg5Q6wJPsyaP3u22Yn2WLOTcVhE
	VZneNBwtTn5CIYRGuMZJEOc9uk/W8iZr/DcCj6z1R+OHHCANjPkzV0/3+CRuMQUHMtdPWGjtMOw
	tm4mWpQqy38QYdz587sP1xLArWj5akaMkkwvX/u6bleulHkmDLRynp98771fYWc9JH2cvdZ8uCI
	1jSxBWfyyXdRdhMI/tEHNekw95O7YM8FmMGlk5z8lNRbYHYNTl45p3wQEHKt7sb/idtRapOW92c
	umovwLzGLKtgvlNC9jhKAqPB8eQ6VlVgFkYVZ/n1Q0pwUdcoK0b9qwZxHgh9lO
X-Received: by 2002:a05:6a21:1fc3:b0:3b4:7b2a:6a0a with SMTP id adf61e73a8af0-3b7963f1b0cmr13422170637.35.1781544345957;
        Mon, 15 Jun 2026 10:25:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c8661b3f1d4sm652189a12.2.2026.06.15.10.25.45
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2026 10:25:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf160f7191so23378245ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781544344; x=1782149144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmDOIsUWHRPTKIdO0SSKY7lygt5VPiszg9eunBaEqQw=;
        b=GD/MzsiqaboO93/ItG978y8VTSkSZS+Xis1PDjsIDkyckdRuqHCw2pLvM+rhHC+rB3
         RKXBW/SUBXFsv2RRHDs4/KhwIJRx+DKx6XX8ZEzXCqxFnrWLT4e9dV4SWjrhdMh0gICu
         nKxmPaTQINY5zZ9eYF9ofe0ZGQeXgSiYeXdPc=
X-Received: by 2002:a17:903:15c8:b0:2c1:ef9:4516 with SMTP id d9443c01a7336-2c664227c1emr130103835ad.35.1781544344176;
        Mon, 15 Jun 2026 10:25:44 -0700 (PDT)
X-Received: by 2002:a17:903:15c8:b0:2c1:ef9:4516 with SMTP id d9443c01a7336-2c664227c1emr130103665ad.35.1781544343711;
        Mon, 15 Jun 2026 10:25:43 -0700 (PDT)
Received: from dhcp-10-123-156-114.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a43c9sm108289285ad.41.2026.06.15.10.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:25:43 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 06/15] RDMA/bnxt_re: Add ownership check while getting the CQ toggle page
Date: Mon, 15 Jun 2026 15:47:42 -0700
Message-Id: <20260615224751.232802-7-selvin.xavier@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22248-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF6BD688D67

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
 drivers/infiniband/hw/bnxt_re/uapi.c     | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 43a2aedc4819..13b18e4ae7cd 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3534,6 +3534,7 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		return -EINVAL;
 
 	cq->rdev = rdev;
+	cq->uctx = &uctx->ib_uctx;
 	cctx = rdev->chip_ctx;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 1456fdc3935b..7217b4692419 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -104,6 +104,7 @@ struct bnxt_re_qp {
 struct bnxt_re_cq {
 	struct ib_cq		ib_cq;
 	struct bnxt_re_dev	*rdev;
+	struct ib_ucontext	*uctx;
 	spinlock_t              cq_lock;	/* protect cq */
 	u16			cq_count;
 	u16			cq_period;
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index 1d7031a23b02..3f5ae1920aef 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -257,6 +257,11 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		if (!cq)
 			return -EINVAL;
 
+		if (cq->uctx != ib_uctx) {
+			bnxt_re_put_cq(cq);
+			return -EINVAL;
+		}
+
 		addr = (u64)cq->uctx_cq_page;
 		bnxt_re_put_cq(cq);
 		break;
-- 
2.39.3


