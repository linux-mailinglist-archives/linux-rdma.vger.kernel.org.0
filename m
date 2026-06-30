Return-Path: <linux-rdma+bounces-22600-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QWIFMRnlQ2rClAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22600-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 17:47:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 612466E616B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 17:47:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=PHtvIA+K;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22600-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22600-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2657303CC49
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B2A4534A7;
	Tue, 30 Jun 2026 15:47:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE545BD7C
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 15:47:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834452; cv=none; b=KGlpjqnsIYQGfVxwiIExBMXrqxdkj6eRKkBzCSR6zRWecRGS9xFNGEed+RntpSl1NxYUFn9otuRR0otYAmRT48pbavcrEBY44IebMNUXYqMRsbcBHV2kTcQJN4eVmW0gHDQomD7rfSH9RpZ1/dwfDCl+n7jCz+Eqm8I4T8cIzdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834452; c=relaxed/simple;
	bh=P3Nqh8wnbMBfTY2M0Mt9hSmrJ36sjq4asgHdNENPck4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IYAY3FwWUCpkMgFj/AQvHxwYSKFTM/L5lba6ofDDPZ40mkmHc3wN/YlUNXpZIvRoMRTpwvtD6JztZNHLMsg7hKLZfu+qa9pJb6zRVpdeSCcWD/zBkcE08nUrBMpawNgyorq3BS2X2mfNhdUuj1GTiCsQ3dn/pxeDc8gBHY1ms0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHtvIA+K; arc=none smtp.client-ip=74.125.224.74
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-662f741fe3bso6468335d50.2
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 08:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782834450; x=1783439250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=baPGGZ83tN4mj2gPgeil8r508KQAmb3G89QcFSzqNks=;
        b=PHtvIA+K5V/2iNySpG5swXUAiRu6PrglPQj93FZ3o8jvr4cDoCEL0+Ec4wCfYGn38j
         ADUsgDm9Wqu2STv3Mgqhu6zMjpiO8Q3xUawZ09AgOgHLToiM4JrjH4Kuny9qLjuPIs0V
         wQ5Az/9LX/iTg5eSCdDG3GwbqodpFaSavI7CIBLN5UApld/kIkB0x+I6k9mOwd6Ju9xx
         IHXNBQUNJvotppBVbhw+ig0GSZRsBQqywC2iJ8VxnOr897F55kGunCISzXLOp4mEVUsL
         hJkaJ+sPd5/Ct0RbYFB/0K0pd/BqURN3KtYJw5H65fdAih0rhXBREhjnAnIuS1GM8VhB
         EU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834450; x=1783439250;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=baPGGZ83tN4mj2gPgeil8r508KQAmb3G89QcFSzqNks=;
        b=WuvgCTYGg16qbSo2QbbggM6/u0PZ7Q40uAsh9moF9SZSkE+J2RduLptae9xVuzD4Rq
         L60GLzhco3m6V/xu0bVyrMRD+u8zKJPsKDW+X4N87ZgLckpmNbZ4jD9Tkf/acIElKfPn
         DdWiNQwwMi8SaiVcsOe2aNoJMUHaxSSsVLf0gj6lGZxpUsOocjutABkie3fzKVgAm8kY
         q9XDhmEyI1Pld3Eebr/rsa77A/LWXpxXX0cYym972eAqD/J8Cm6rCRkLuuzEClrB4q8x
         gEKJq0dPdj54bzOuH3qiSppxv1goTP4MUm5GbvVasgM0mIbIFyhpA6xDWNTAeKetV2w0
         Vk0A==
X-Gm-Message-State: AOJu0YyFKjRYx3wjNBtkG8nUk3ztUWYMRnidWEFKxZr1Nq1Ymc+pM7J1
	eDwrjo564RM8vZWpnQCq5DjlFjW94EeDsiPSGVqpFtyoCKjem9dE4Mk0cE/SdLh5KLJKRthQaCj
	9lEfwX5JWaw==
X-Received: from yxab20-n2.prod.google.com ([2002:a05:690e:1594:20b0:664:a0f9:940e])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:1182:b0:665:e31:fd95
 with SMTP id 956f58d0204a3-6650e32147amr1375637d50.54.1782834449790; Tue, 30
 Jun 2026 08:47:29 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:47:19 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630154720.1647530-1-jmoroni@google.com>
Subject: [PATCH] RDMA/irdma: Check for null udata during reg_user_mr
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22600-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 612466E616B

The irdma driver requires udata for reg_user_mr. Previously,
it was assuming that it was always non-null, but it can actually
be null if the user intentionally triggers the UVERBS_METHOD_REG_MR
ioctl.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index cb54c7c8fcd..3bcac68a612 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3519,6 +3519,9 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (!udata)
+		return ERR_PTR(-EINVAL);
+
 	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
 		return ERR_PTR(-EINVAL);
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


