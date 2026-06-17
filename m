Return-Path: <linux-rdma+bounces-22296-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XuB6MTMHMmqVtwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22296-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 04:32:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67906696257
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 04:32:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SZTkG+Dn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22296-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22296-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CD51302AD2C
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC392309EE7;
	Wed, 17 Jun 2026 02:32:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77854306743
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 02:31:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663520; cv=none; b=FZQ8rbjtc9vSg60JEFR+N/sbgpTV7hob0GQYW87Lx2hExwJs5nuxDsFHCfpMcZz5d5g7+SyGbap9GCMazY7D5rub+8a/0b6oIXJtQzuF1pLSQ5vSTegURktlOgkH3BUOrChQDbytN3r+Ipqrq6vqymJNrhv8JXR0sEvAl43wdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663520; c=relaxed/simple;
	bh=gI6fuoOtfgNxRQeV5MldXtG1ofvIZjXTUr99fjt2T6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVGbG9wJwX9UmyJtyJeqhDoioBoKekv/W7BziBNoJIe/arlO8ve87QPXO4EryRfKm84NLaVRDaLDRZNzlXezCCDB+Osh6zE16fkEXTu1o0Gja07SRLP4U4i+73WXi31zsTfZDVpRkY+joFY+TRch6VOVZgPcUM9YGhkJH0qSfbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZTkG+Dn; arc=none smtp.client-ip=209.85.219.43
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ced8f44da0so57341666d6.2
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 19:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781663518; x=1782268318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WyvBBywOIL3cYLr1Vmd6dlHjxJOx7q5S/Lp3StPlWN8=;
        b=SZTkG+DntHf+wW565y4p4gP8OJk+Nwq8qyLhN2by/m6RWUkfQxBSBIA/YpvlDIJ4/M
         xl52iqnOB7LmvOMRHNMIEhHUs71obU/oB9RnXQNkOh1tZU6oSHusULHhZrIFZuqxT1W9
         ZQxLBqr/gDagKYtex44HBhOM69QoQitJ0eFur0w27WB3C3X4eSTrgjfKiP28T4LM/Hjp
         +V3HwuFlRuMBJUA/6pHRj4ijo0EixLk+GgvCIAdqKYtCVoXJI4shBWOlpnNj8gBAUC8m
         olDpjFG81B+iUeWxMgJa2SDvpQYj5yRLnogaUgbFHnofhDMqjZT3inw7H3Y8qE9ZMqAC
         Yb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781663518; x=1782268318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyvBBywOIL3cYLr1Vmd6dlHjxJOx7q5S/Lp3StPlWN8=;
        b=BV/1PNaVA63TgPRMFMFt4a4t2dOdFHe7ZQL5BlM8k8OAyxaMTKyYq8J7n9PBfNNEEu
         5q3aXOZusqjQeS4ZvFHajn+cHLtM2yiabjaFK2iy5qd57cNU9HO8x+cDF6QtFqWUgnfe
         NIRcDzorPoq9aUtATmNV+3u9s4kLolBkYLyBK9LIHO+1YL/JJ4K9B0axy6QB3M2G05yq
         xN5IQ/wieyANRMeuAeFnpKbFUseqR0H0wuxddYISiUyhp0queCFdfEDAnAcbyj+xSQ0k
         1ntbERt8W0qI3wSJC+h9a8BTe9666JxinwytUXUw3iozJU/7rO2L4dUGehHBIASTsSee
         BAZg==
X-Forwarded-Encrypted: i=1; AFNElJ8qsgYXLHDr+17/hP5a5OIxMQfdODCGHkEVCipz6YR699/tzkaa2c/Gq1Rna4wQkMepeJvKAEehKKEt@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyHZaatJ8ohGu/liZoXdigVtABFcW7GoUg4p6aKPNGhOH7Va/
	cZAitIuv8kG1QBk1Ml3Dlst7VtVmhRzfXmj+mO3hmw/2NQOlFJfqJ7ne
X-Gm-Gg: AfdE7clOAcQiLinX1jhJpj6h8ZV196P8uvh+nmyxOsvcciXHEpV6qEuvUivyaW2fLk8
	GCno+5o7qtlajoDl0QE+qG6a6wnZtSLAJOsqrQGCix9Nj8xwZEzSEi6Qqkm8Aw+79D2lZjTwTok
	08zW5eczmi/Mp/P3pwCOuMjZgyc3WJpbgh/vfNAnxrRqcP/m3n50mhQ8x1/0VTdceHxdLGY4IRD
	vC9vT5xSPULjqsjcD6nX13YkDJhXNDqqVsS+RgpmApetAZ1KezytSSL2+2yg9bZ3hoyw07SLPXQ
	LdoebGK/bRs0FqCT/joJ8zynwKjT92FnuR+2EOOwIy6mjxqLA1dhDUHMW5XdFHGnjtKAHmz/QNo
	g4IB9ll0X0R5d4uP19R4jraD1nllPWbKcR8Q+zsneezf7RT6MGuxZiLHXMFtKr8Uqmv9qK/ajxP
	iH6wPmsJZEsGEbAt+pWUzhNamT5EGB7bb6y71SFvg3nU6LV1p0aoBzb8vmAgDiY8SLuUR6wJQLy
	8yZHVKW/31/IxkFCABbe30WnPW2e72H
X-Received: by 2002:a05:6214:6013:b0:8db:c2e3:66a1 with SMTP id 6a1803df08f44-8dbc2e36896mr11272466d6.16.1781663518377;
        Tue, 16 Jun 2026 19:31:58 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f47408besm51083746d6.28.2026.06.16.19.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 19:31:57 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: rds: check cmsg_len before reading rds_rdma_args in size pass
Date: Tue, 16 Jun 2026 22:31:46 -0400
Message-ID: <20260617023146.2780077-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22296-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67906696257

rds_rm_size() handles RDS_CMSG_RDMA_ARGS after only CMSG_OK() and then
calls rds_rdma_extra_size(), which reads args->local_vec_addr and
args->nr_local without first checking that cmsg_len covers struct
rds_rdma_args. The other two RDS_CMSG_RDMA_ARGS consumers already guard
this: rds_rdma_bytes() in rds_sendmsg() and rds_cmsg_rdma_args() in
rds_cmsg_send() both reject cmsg_len < CMSG_LEN(sizeof(struct
rds_rdma_args)). Add the same check to rds_rm_size() so all three RDMA
args passes are consistent.

This is a consistency and hardening change with no behavioral effect for
well-formed senders and no reachable bug today: rds_rdma_bytes() runs
before rds_rm_size() in rds_sendmsg() and already rejects a short
RDS_CMSG_RDMA_ARGS, so the size pass is not reached with an undersized
cmsg. But rds_rm_size() reads the args independently of that earlier
pass, and nothing in rds_rm_size() itself records or enforces the
precondition, so a reader or a future refactor of the size pass cannot
tell the cmsg has already been length-checked. Applying the same
cmsg_len guard in all three RDS_CMSG_RDMA_ARGS consumers keeps that
invariant local to each and robust to reordering.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
 - Re-target net-next and drop the Fixes: tag and the stable Cc. This
   is a consistency/hardening change, not a reachable bug: as Allison
   Henderson noted, rds_rdma_bytes() runs before rds_rm_size() in
   rds_sendmsg() and already rejects a short RDS_CMSG_RDMA_ARGS, so a
   user cannot reach the rds_rm_size() read through sendmsg.
 - Corrected the changelog: the two sibling guards are rds_rdma_bytes()
   in rds_sendmsg() and rds_cmsg_rdma_args() in rds_cmsg_send(); the
   former runs before, not after, rds_rm_size().
 - Dropped the KASAN/AF_RDS reachability framing. No code change from v1.
 - v1: https://lore.kernel.org/all/20260614130725.2520842-1-michael.bommarito@gmail.com/

 net/rds/send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rds/send.c b/net/rds/send.c
index d8b14ff9d366b..6ca3192b1d8af 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -967,6 +967,8 @@ static int rds_rm_size(struct msghdr *msg, int num_sgs,
 
 		switch (cmsg->cmsg_type) {
 		case RDS_CMSG_RDMA_ARGS:
+			if (cmsg->cmsg_len < CMSG_LEN(sizeof(struct rds_rdma_args)))
+				return -EINVAL;
 			if (vct->indx >= vct->len) {
 				vct->len += vct->incr;
 				tmp_iov =

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
-- 
2.53.0


