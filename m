Return-Path: <linux-rdma+bounces-22329-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P1yNMU3rMmqY7gUAu9opvQ
	(envelope-from <linux-rdma+bounces-22329-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 20:45:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F76D69BFD1
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 20:45:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JFJIougb;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22329-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22329-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9F6B319E1B6
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 18:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3C3559E1;
	Wed, 17 Jun 2026 18:37:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA2316905
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 18:37:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721452; cv=none; b=hJVgg26nkJl+EnnOmhdZKx1GPSMES+FMSjz4GjI8qSJfHF9dFVfcHkNEyjOA75IgMrCsSrV1nIwCfY9t2p80iBG/L6kwZekjTgS74mON/ryceeC/Y8COUzvCgSziZAnn0vPjZRdtWvq+YJS9HRf8QFpcT0UVG0C2NWHUwP1GDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721452; c=relaxed/simple;
	bh=n6yjf+jzRT88Ko/+2TxSm4uQKWC5X/X0wo/7MHD5YjE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Edk/eWXriVihiQj/f05IyVPVfXauKKLjkeNOqsYkAi3k8LCBtyyi0LUdfaPJ/+6JHSG+ovEiq4uX71WOwzEdWeTSGyr4hIuyLLQkiTzZphxUa2j1neu5bg7LMsEpV77OcVEom7r00CnprvAUnpc6lRqncK+GCsx2Oo1YFm2GmuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFJIougb; arc=none smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-845397d1221so24079b3a.1
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781721450; x=1782326250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj6v6fAhbVQaBm5zuPKFBx2OOszBQ/tmX7c/3lOM+H4=;
        b=JFJIougbw12DsJBCsSOZk7dDpWyESgL4tQzvM101fzuqxhxfKjs3Y58kbx+Vh/kScU
         Hl+wkI09pWI8J9Iwcxd2m49rkpjolVIfUGYX3qvqczQjT58pB0MyVS9QMuqCJWPZNXnx
         RmWMagz3Kug+9b7m7jFt99oUbsmQZjkTmyZYBz35G9rifeAxqEbyZSik2PGXGMdeqwtC
         6phx9FbVIUo5HIQzyP+nFyHQtzCVuCf2MH9zNjbNGK+V6iRSMjKpMqQp86+V3GFilIKf
         AF7SIrwx0cDPWcw4mvm3dztmCYPkB8jkmiir4fuxKB5f2vNL2ghh8j63cezu4Swk1++M
         cn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781721450; x=1782326250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qj6v6fAhbVQaBm5zuPKFBx2OOszBQ/tmX7c/3lOM+H4=;
        b=rovJoz0Nv+zTICrsQGzFQBD3fLsZp7hLn80DhvNvyBvx2P8M2JFZOXQBZydkjcnaxG
         JnnMuVZpP9WSVa1MgeASeeUZNhF0VNdi2LHPw699QNSxkVnyzi+VVjXJHgFn4clWRgV7
         0wT44DzwFRGA9u7Iu5azBXmqwjq87YTvlyEjpCVlIgWmTNmAVIobvosGctaRiufD2Pv3
         fDBP/WikHOA1qsx/52STscoromdeGhnMaDIdI4ySy/Kv5l7vg5aui9FC705vHHYEOpUB
         aJATVmeiTSZk97/udUMjhQNyfjOA4kEuvN5EhYNF4fJc5KjwTbzMqUFBMa5OZa5a8Rwp
         hlWw==
X-Forwarded-Encrypted: i=1; AFNElJ+Zwp3lFWwcX24Sb+bVANWCPmyjLcXC+A90KxNhaX9VEjBl3p/9O4B7KaGC6qdfh7c69rA32Qw7dZQO@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZ070fO0YV6H6mQ46FU/DOy2YKfXKUMcPS+fIg8OGI+q7Yr8L
	yG7mEQ/Xo4IkELUI3MzivbeCGG/FSbvRZ2x3qnIs0/XWU9TzcFHKQmIq
X-Gm-Gg: AfdE7cm0XlK1OVP7Och28tKgv0BNLqQhN1B4k2YOXjIG7fTzzodZu72n+ESF+P079QN
	VvWY+QlzWtRX8oS9AwXxR8AS418rlPfPDlfV3kUngMbtxNKpm6zMNzb+IxG7NtZG0dB6gV7odot
	u5fYF31IOu1ezeHEgN0c4h5dxB+LF9Jzb+4kEr6SRiz4BSW+NpUFpzI1nowEs7GXaP46pUZxaeH
	DSUQpfsG3Hx4p8GBDiK45/kCmnU0VGdbY2dr6GO9oLGEk0nmUmpHIFvxFtHUu7gtUyj2b+NsSCX
	bv9B0ghVP6582dwpOi0fb4BCjNhgD+u28A3v/3zHqpXFmFCc7dtEzpAvkXKfJZLx8x26N6vk6oE
	rriy48HjljI2zPm9hE/VgmDgtOBomTBEZXJZ8DwO+Hz+esVJg0mSD9Revoip+xp6dW+y0msw+wr
	YUBfjjkXa/yiCqu9D6SHWzBEbvx6uxSoyV
X-Received: by 2002:a05:6a00:66c5:b0:845:31a6:d84d with SMTP id d2e1a72fcca58-84531a6df5bmr2288451b3a.7.1781721450361;
        Wed, 17 Jun 2026 11:37:30 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:1886:6b7a:3e78:272c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9dc96sm16851836b3a.6.2026.06.17.11.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 11:37:30 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA: initialize return values for empty work request lists
Date: Thu, 18 Jun 2026 02:37:24 +0800
Message-ID: <20260617183724.1099387-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22329-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F76D69BFD1

erdma_post_recv() and mana_ib_post_send() both return their loop status
variable after walking a work request list. If the caller passes an empty
list, the loop is skipped and the variable is not assigned. Initialize
the return value to 0 for the empty-list success path.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/infiniband/hw/erdma/erdma_qp.c | 2 +-
 drivers/infiniband/hw/mana/wr.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 25f6c49aec779..e002343832f74 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -734,7 +734,7 @@ int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
 	const struct ib_recv_wr *wr = recv_wr;
 	struct erdma_qp *qp = to_eqp(ibqp);
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&qp->lock, flags);
 
diff --git a/drivers/infiniband/hw/mana/wr.c b/drivers/infiniband/hw/mana/wr.c
index 1813567d3b16c..36a1d506f08f6 100644
--- a/drivers/infiniband/hw/mana/wr.c
+++ b/drivers/infiniband/hw/mana/wr.c
@@ -144,7 +144,7 @@ static int mana_ib_post_send_ud(struct mana_ib_qp *qp, const struct ib_ud_wr *wr
 int mana_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		      const struct ib_send_wr **bad_wr)
 {
-	int err;
+	int err = 0;
 	struct mana_ib_qp *qp = container_of(ibqp, struct mana_ib_qp, ibqp);
 
 	for (; wr; wr = wr->next) {
-- 
2.51.0


