Return-Path: <linux-rdma+bounces-20525-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMvKGkiKA2pN7AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20525-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 22:15:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBAF529016
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 22:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D610304ABDC
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D31D379C38;
	Tue, 12 May 2026 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmvlaV2u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A73AD510
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616902; cv=none; b=lzBixCea+mnIaN7xMdhQMCXbjF1pmyoe4qg9dInaFBmcipZpEJ3UCW7v0sCIfDPNV5pJM7jvMyItjqnCvgV9ruy/dlVtho5w7odY6mAbqar3X25R3Dy9zSHq2Izgl+haViqyv7kRtrMUQWnG67GhS0cbIuZAypqXQolr6fP++no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616902; c=relaxed/simple;
	bh=8kHr0NefDA2dlaT3y5dqzTIYYbJn4F1y60zDQYCkWAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=orN68KvYnEYbOZ2WI3XMWRBXCkYysXoOHtW2z3Iy3CXoS1RKFhbHRnOTQCNYYNxm+lR0/xB/0+YqK+/tE8HX28EiRn9R0RiscyMBNe2nm/vLyZPVfe9KAefWijqJPAY5rH3yMj95kWgF0mPVGe5SE5AEffY147aKjs+5EzrJgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmvlaV2u; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479aa2dbea2so2512015b6e.0
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778616898; x=1779221698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dioyv0+aPVduc+oc9wHweER/3L8mbYHLU3brEzPYmYg=;
        b=SmvlaV2ujri4fOugY1DTmYA5qQq5XEPP6QfVZXEGvBpkUFKQ75duTsD7fz4iwM+kNF
         5BJwzHXbJr5PMuCkP924BYwF8TB62sj9xTGsOOF/fgIWikXF1SrssNhJWy9FeSBW1JSl
         2RyjHnYwS6O71GdkuA5O/dk3kMMyMGsT5e5xsrlBACPdE43okSyOGal334yKg4fZs3D4
         Do82b44fAEZrUmEjq+YaM+QPr+uH7ooZOr4wdDnilHDnYzl1xhw+h1U6Gs7s0OkyAecZ
         JGVuKBi5AWIWAtzSkHe2mF3X7/vwsRSXn1CxJVAe2+DqHqBeFdfjI8Izdhw4Jqp2HtuS
         IjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616898; x=1779221698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dioyv0+aPVduc+oc9wHweER/3L8mbYHLU3brEzPYmYg=;
        b=LcwjE1NU5wGLxwRSOHy1aTn/naWZHGGJOOt3TDZldGNkmF7H22jWfBuowqmIQiHV7F
         1b/MTTPEj0ntf0y3gqgMB0UGcvQCa43i1mN2vmvQ0MhbKE8D1qBn6j6lIEdoExCSxdX1
         PggIY8N2MS9+eVqK3eV4fSzq272nNl70o8e543ackIjxnD2WHkPpXmGbbD/Qa59gzv1c
         EoCdl0xg7d33JCsvKnAKTJ9EBAXy2yEhDaSKR4Y+6LOWj/jiRS6pOuUVFf2TlHeYv5cK
         X037WSa87J3OUevSHbRaIgw+ceycUpA7YNhW8ly2lgGjUgI0kfTuoPvQ6OatxkTIeHCv
         uZ+A==
X-Gm-Message-State: AOJu0YwIoSy9NQaXtp7Ot5m37/2OdZ0OfSSlcvRXhBWRwEeVV+Zza2It
	7vyzaMxpVivfNxeVqsDgfXQNEN2Is/VljxCpqgMbrxKCQBrrTX1BYnb3WJYX/g==
X-Gm-Gg: Acq92OFytRQ6q5+0R8SMJ3xXwVxZl3NvUyrW3/5t5XDz7x+Xyp5y8uG7ta9ut0GtXe5
	k2Vb3LpGrVjQPYQr3usJIcxjo59rZqDY4/uzFlXuVrPLpqxr1IwDM/jCOh37I9JcC7pPSLYUyCq
	BFKtZaSTTzQavl4/SIv7CIA9fwfrjLDjHEfFtDpQSAgnXdCcQueb+cW84GlLvP3ct7WK9mh2d0C
	ZJIobE/bQ4PTsWg1pbpjir4qan5wNRc6Dsvadb26KeVsQSDJ+jFqdIB78whIZFEBFbe3XimWG1v
	BcK7Rlt0HRU/c7rfwureC01uV3jTFUxCtb2yq+XeONwJNBt8oq5p53cNx606nfc2HAT1mHTKfvC
	bSlUfGEsBHWlqZa677ms0osO9JPlvbq19776NShrTsHQF4Tz4jR20sZypkEH26IdQv8zOKRbhJp
	AFBjvC4gZZQl6TJTAh7qD+iPdun1JAG/2jFqeblCst9b91tDbi6UvG15IV
X-Received: by 2002:a05:6808:2e48:b0:467:1941:1f0d with SMTP id 5614622812f47-482b28a7400mr470374b6e.11.1778616898591;
        Tue, 12 May 2026 13:14:58 -0700 (PDT)
Received: from localhost.localdomain ([2600:1014:b0b0:a3c6:a82b:c292:fd90:24d0])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76935904sm22800623b6e.11.2026.05.12.13.14.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 May 2026 13:14:58 -0700 (PDT)
From: Liibaan Egal <liibaegal@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH rdma-next 2/2] RDMA/rxe: advertise IB_ODP_SUPPORT_IMPLICIT for local access
Date: Tue, 12 May 2026 15:14:53 -0500
Message-Id: <20260512201453.21156-3-liibaegal@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260512201453.21156-1-liibaegal@gmail.com>
References: <20260512201453.21156-1-liibaegal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2BBAF529016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20525-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[liibaegal@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Now that the implicit ODP registration and local SGE fault paths are
in place, advertise IB_ODP_SUPPORT_IMPLICIT in general_odp_caps so
userspace can probe the support via ibv_query_device.

The advertised support is intentionally scoped to local access:
remote rkey access on implicit MRs is rejected at registration time,
and the atomic, flush, and atomic-write paths reject implicit MRs at
the top of each helper.

Question for reviewers: is IB_ODP_SUPPORT_IMPLICIT the right
capability bit to advertise for this local-access-only operation
matrix, or should capability exposure wait for broader operation
coverage? The cap-flip is kept in its own patch so the policy
decision is separable from the implementation.

Signed-off-by: Liibaan Egal <liibaegal@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index b0714f9abe..581313591d 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -94,8 +94,13 @@ static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
 		rxe->attr.kernel_cap_flags |= IBK_ON_DEMAND_PAGING;
 
-		/* IB_ODP_SUPPORT_IMPLICIT is not supported right now. */
 		rxe->attr.odp_caps.general_caps |= IB_ODP_SUPPORT;
+		/* IMPLICIT is gated to the local-access subset. The fault path
+		 * in rxe_odp.c rejects remote-access implicit forms at
+		 * registration time. Per-transport caps below stay unchanged:
+		 * they describe explicit ODP MR semantics and remain accurate.
+		 */
+		rxe->attr.odp_caps.general_caps |= IB_ODP_SUPPORT_IMPLICIT;
 
 		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_SEND;
 		rxe->attr.odp_caps.per_transport_caps.ud_odp_caps |= IB_ODP_SUPPORT_RECV;
-- 
2.43.0


