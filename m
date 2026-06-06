Return-Path: <linux-rdma+bounces-21907-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dIx5M9t8JGqK7AEAu9opvQ
	(envelope-from <linux-rdma+bounces-21907-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 22:02:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E7764E323
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 22:02:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UdmBrRWE;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21907-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21907-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84F753014BD2
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 20:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B2F3793AA;
	Sat,  6 Jun 2026 20:02:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461AE26ED3C
	for <linux-rdma@vger.kernel.org>; Sat,  6 Jun 2026 20:02:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776122; cv=none; b=RP7mrXsBttTRYMYAdiBJgqwR7htzcCmVj7giNL9UOL4kq+UrpP3jMt3DDQtor4ROoxE0vdKXyz/C+T93Dlix9TuAtcd8RZADyM55fysXvy0BvsQCxk0iLI2oyH/8zxl9YQxTjNb/rfTZpP7tivXJgRbAgsWgugVkPrlvcZl+eBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776122; c=relaxed/simple;
	bh=UOHxgAF8eZ5R1jJ5qHXlGxP4p63cxPu0NB/XWI5KxNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbh3aBSa0RfjxJ3k7jDRnXEbW/WTdI7nHT4LF0vNjMbYUKswsrGkZypqDx7n9TeXFYsk3yyKF10/R/D8nVVhMnW7zi1TSuaqvWI1L6oiZmvpS7S8zYd0axdI5buw+zXBJLy/A89b+xf9plPqQwN7x1wdHZBnwpWdHFltCx3AxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdmBrRWE; arc=none smtp.client-ip=209.85.222.53
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9639b1ef167so1026716241.2
        for <linux-rdma@vger.kernel.org>; Sat, 06 Jun 2026 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780776120; x=1781380920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpNv6A+DNZ1EjUzABqGpmlmVejxr2D6SXF7qHtjHT7A=;
        b=UdmBrRWE5gLSI8arSFmBFB7RXgzL1tw+/OFjoqBkI8q4y181RLG5mPVOGB8oiIkqpN
         qB68rTjGfiU8onWXgd5x7U2Jjrxzr5ZR7lICISQ4Fsnz8ZRaNWKaOtNaH1CnWnXb86Ss
         3T5NEWJBpfaVrNjkdvvybzBYC/suLwNpC+9zB3j1XdNp76RpOQex8Qs2L74juQ+qkcpl
         L4iCHS7gCgG8CLXHks2Ge3X/Ffd45Hs4qykdUH9G90XRiaefctRbBfNKjS6kMXl+TbuA
         jfq18C7JJxU32ntiFvqaIi3bVVKGgYJ6qeOj6NzR8eDAPYS/TqApvfm0sX/TiRG7cCnb
         HC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780776120; x=1781380920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OpNv6A+DNZ1EjUzABqGpmlmVejxr2D6SXF7qHtjHT7A=;
        b=hrwDCpL7v4sS8oqwHuRiwx7JuTSPwvQFtf4S3iTRpEKjYJNViL9X499Lr3We3y1rgR
         PBqz9xYrI8WeLYgdpz+c2vzkhJdWjTkJVI18XmvnvU83sWFTRRGhPJtMceHpB6Kjcn+V
         aLRefuyxSRLbc1FIV+lUtSUrkliT9M/dtLcsfdFZPJtbTLgJfQdPGIiJo68CkdS2QMI2
         xWBmw4mE15WcKxM26V3af/9cHIx50a5dSpwKbnSrXoq2q+3ntH5VRKMWH90dtoxfOlp5
         /4G7hLJm7gjtSuMSjHu+Lt7toadbgKqmffbN+BHHbQMXclrsW9cjsjoi6DEdJ5Qx1bAN
         Ydeg==
X-Gm-Message-State: AOJu0YwqMouruvZRHWIjPBaOCT84mO25GtVYsfN+lBpeF7h4FZv+Tfx1
	R6h1852It1ZTkhnYm7eVJWgUuVEH/S02VA3ZxsBUO/5Adpeje6P/kmjz
X-Gm-Gg: Acq92OGYrCGGu76tkVEAXkjL9aIFfogmyf5wsoDkYnVMwkV2PezCBTNqqw2V02Zqra3
	rg/1L/QYoDIkxx8mdHbdL3Bp3eVIn8F2+7Z4qA9CSMr0Inaiu+AB8OxqO2e91hhN9IdavYJf64Z
	/foIM1PiOEB8yndDBDdVk+YrILxnQw97O7eplT6PppFjthhLFT9Mq31VN7mnihwX3GT2llyRMhw
	vZvmxtiKD2nPEJVabOsEdyGT1Gf5Jqn48ijmXDsAzs2by3Vrt6apMxhIQJ33PezT8O3Youlnah4
	6GNdCzs1vWVZsHrjM0BRqqJjP3qifJdJsBISZRCnWUYJG2vhizpT39rzRXDA6v3lJDUnPb/hqT/
	kjKblTdl7RAyg+JjHBj2eYq6gDOPuCXbFmbmkFTFcMXYRO7yUJzoIDt6mTTN5AzNCxlT3ICAlNh
	iw40QGu9oFhDnb8XUfnpD0rA0CqWgN21cfVJrfeMQds6v/WhIpsS0ngC2EFAapYdB69/krz0d4P
	8wJ+1LNpa18gYKvFPP4WyrKVSsJCNuzyO8YIUPcvQ==
X-Received: by 2002:a05:6102:2923:b0:631:4580:6a42 with SMTP id ada2fe7eead31-6ff05674bfcmr4385697137.22.1780776120001;
        Sat, 06 Jun 2026 13:02:00 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d2384sm1240898485a.39.2026.06.06.13.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 13:01:59 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Bob Pearson <rpearsonhpe@gmail.com>,
	Sean Hefty <shefty@nvidia.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v3] IB/mad: drop unmatched RMPP responses before reassembly
Date: Sat,  6 Jun 2026 16:01:55 -0400
Message-ID: <3170ff3bc389a930bb1641f2caa394a0b2241579.1780774907.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520154715.1457495-1-michael.bommarito@gmail.com>
References: <20260520154715.1457495-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21907-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:vdumitrescu@nvidia.com,m:ohartoov@nvidia.com,m:rpearsonhpe@gmail.com,m:shefty@nvidia.com,m:kees@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22E7764E323

Kernel-handled RMPP receive processing starts reassembly for active
DATA responses before the response is matched to an outstanding send.
The normal match happens later, after ib_process_rmpp_recv_wc() has
either assembled a complete message or consumed the segment.

That ordering lets an unsolicited response that routes to a kernel
RMPP agent by the high TID bits allocate or extend RMPP receive state
before the full TID and source address are checked against a real
request. A reordered burst can therefore reach the receive-side
insertion path even though the response would not match any send.

For kernel-handled RMPP DATA responses, require the existing
ib_find_send_mad() match before entering RMPP reassembly. The matcher
already checks the full TID, management class and source address/GID
against the agent wait, backlog and in-flight send lists. If there is
no match, drop the response without creating RMPP state.

This leaves the RMPP window behavior unchanged and only rejects
responses that have no corresponding request.

Fixes: fa619a77046b ("[PATCH] IB: Add RMPP implementation")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Impact: a fabric peer that can send QP1 GMP RMPP DATA responses to a
kernel RMPP agent can create receive-side RMPP reassembly work before
the response is matched to an outstanding send, delaying other MAD
processing on that port.

I tested this on v7.1-rc6 under x86_64 QEMU/KVM with rxe plus
debug-only patches that host the in-kernel SA agent on soft-RoCE. A
descending F=1024 burst to the SA agent hi_tid reached RX/MAD completion
(1023 packets) but, with this patch, did not enter RMPP receive
processing or the insertion walker: walks=0 and no continue_rmpp samples.
There are no in-tree selftests for QP1 GMP RMPP reassembly in
tools/testing/selftests/rdma.

Changes in v3:
- Replace the RMPP window cap with a pre-reassembly response match.
- Leave the accepted RMPP reordering window unchanged.

 drivers/infiniband/core/mad.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 8d19613179e3e..e0b3b36b8b149 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2031,6 +2031,24 @@ void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr)
 		change_mad_state(mad_send_wr, IB_MAD_STATE_EARLY_RESP);
 }
 
+static bool is_kernel_rmpp_data_response(struct ib_mad_agent_private *agent,
+					 struct ib_mad_recv_wc *mad_recv_wc)
+{
+	const struct ib_mad_hdr *mad_hdr = &mad_recv_wc->recv_buf.mad->mad_hdr;
+	struct ib_rmpp_mad *rmpp_mad;
+
+	if (!ib_mad_kernel_rmpp_agent(&agent->agent) ||
+	    !ib_response_mad(mad_hdr) ||
+	    !ib_is_mad_class_rmpp(mad_hdr->mgmt_class))
+		return false;
+
+	rmpp_mad = (struct ib_rmpp_mad *)mad_recv_wc->recv_buf.mad;
+
+	return (ib_get_rmpp_flags(&rmpp_mad->rmpp_hdr) &
+		IB_MGMT_RMPP_FLAG_ACTIVE) &&
+	       rmpp_mad->rmpp_hdr.rmpp_type == IB_MGMT_RMPP_TYPE_DATA;
+}
+
 static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 				 struct ib_mad_recv_wc *mad_recv_wc)
 {
@@ -2050,6 +2068,18 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 	}
 
 	list_add(&mad_recv_wc->recv_buf.list, &mad_recv_wc->rmpp_list);
+	if (is_kernel_rmpp_data_response(mad_agent_priv, mad_recv_wc)) {
+		spin_lock_irqsave(&mad_agent_priv->lock, flags);
+		mad_send_wr = ib_find_send_mad(mad_agent_priv, mad_recv_wc);
+		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+
+		if (!mad_send_wr) {
+			ib_free_recv_mad(mad_recv_wc);
+			deref_mad_agent(mad_agent_priv);
+			return;
+		}
+	}
+
 	if (ib_mad_kernel_rmpp_agent(&mad_agent_priv->agent)) {
 		mad_recv_wc = ib_process_rmpp_recv_wc(mad_agent_priv,
 						      mad_recv_wc);
-- 
2.53.0

