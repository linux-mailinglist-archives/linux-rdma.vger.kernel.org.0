Return-Path: <linux-rdma+bounces-21906-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v869L0J0JGoP6wEAu9opvQ
	(envelope-from <linux-rdma+bounces-21906-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 21:25:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0E64E20C
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 21:25:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="KgJe/ENs";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21906-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21906-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80BD33028ECB
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 19:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B03BED59;
	Sat,  6 Jun 2026 19:25:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334A279334
	for <linux-rdma@vger.kernel.org>; Sat,  6 Jun 2026 19:25:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780773907; cv=none; b=pX+MWbE1PboOeiE9yjuRIF26ZE9lyB8J1ykz9OZq5bWrFpbfMMUeUc/XkMjRNZDo4p9cepJYkNUIx3E72Xjpr2e/YcfLHWmgyiopyh+FQO4Ny+P5/4jj46yIN9yl9r4fnTAdScoJWrFjLK83XEgdcGh5M6D2iBIADVwMzKl5Y2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780773907; c=relaxed/simple;
	bh=y5wuQ5FGu/JYPCAfXh73OjdWlBn1nATmgzaWr3HSqEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSnxPOg4HnP1tRtCsg+qXYH/8I7Y/pc6Qz9SNvsQp7Bb8qvEkdd5P2T+GptDZDRbUng91B4lnepFATNnfycWE+mhBrmkzuxDZQAZA6qax6PoCcv6YVY3eH0eGZg63pu79sfPBsFkq5KO6TFtR6JdR5ajrLoMmGsf21vA8lOWqoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgJe/ENs; arc=none smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137dd3af345so2782539c88.0
        for <linux-rdma@vger.kernel.org>; Sat, 06 Jun 2026 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780773904; x=1781378704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnkJolxtd5rAJytJ9EsXkQf5QMe7HOUmxtNIvHoQhdQ=;
        b=KgJe/ENsn+3pMoKpQL7x0kqTUUP9/fNrrkyGJ/wcba9wSlzFAic59MwTYQb3gl7fHP
         yTGZIzBTHUXYGepnY00l/agYZnimH8udb+JWdceygjO80qOXbZ9om8XrXE7VlGtMPnyG
         CBe6ji1JumJlF2+rNHHvFHzLDHyUvsIXfTwlckm0392cOkd3jDbX+VvhiN1Ofa8jfGV6
         3G1/4A3TPFTjUUhUkwb/oAgdUxcWKrWupYwPkBDlEOUY8L/jnTbG0QNPBf6gzdJywalK
         EjNGSB75ZxFJngLfSjjcgEu1GzcfDp9U8H15ac2QT0fYC5CpCcTc1fXmB9vQN6ZylO9D
         MoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780773904; x=1781378704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnkJolxtd5rAJytJ9EsXkQf5QMe7HOUmxtNIvHoQhdQ=;
        b=gIiBJntaoQbQgOkE0SAdUUo3pPxKsKFjoonMQt8z9cJx17eB++PcUNRAJpAuL6zzP6
         UnM+IKa4+cNkHd/ug/n0MX0kT3mVviJICfN1wQCob3bnY2rHADeeqhKyksp0EPP9B8v1
         T7vANGjvOHtEaRVZT3UnPWETqAopFoWUYIVxsc0ZfkUA51sHSfsqVfu6kus5UVLk6blR
         chp7Pt12TJ9W+waWA01h/kyz/2ZcjWRH9E9nSHu8QqEyCVSswirURwfdcvS4xZziqfxM
         1SoM0iwqEMq2jwqcu1nWNeocWWJJRgFCBWChPFGXCD+wnbXTf4qRceHZ0N7FtKNBvWp8
         TFVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6aKCrjYjh0n2v8v78xzYBA/syJ0tvK1d6t+w7unQLLoRC8mGZdmQ0+BrF/TkiZGspXZafsrWsDFaX@vger.kernel.org
X-Gm-Message-State: AOJu0YzGB/d2b4SBJOmfym0PwYWVQ3U4y5yHd1FQh0Z/uB2iRpcyp/4G
	YVA6Agk4MVZ2Ze5pGlJRPX3LxW3uKLyuJxkPffp8Y2bvYqigBhRRETxK
X-Gm-Gg: Acq92OGx667Jbttuu5niqOhbUGpezJQJ8V+0e171zkX/AtChU7a1QL7w9ysBMjNQbce
	xVZowhQhFCq6OiHaZG1/20ETK2nVyBKN3FV2LHXXXOAO/ciB0fRY+stsgldtCPvnEWUPvZaktQG
	P4h/lqaZt0Q9d4wEf6ToClfGI+UhNIXIs/ltYgDaOrBpk4/pqIG5gcL7NXUU//X4FgV7onEP98c
	vS5fHRACLg3VOKhAFsCpazrlf0aXx29j2iv3KhW63g8b/+wYWWpkBEdB1QlqrdjhFjRiADFh6Uq
	eV6JvJpnl9RLvkecIFh+WjNYqWlnWbBm8OM9MQ+pwO7EOVxcjuswGrCS7+F7wPfVhK+1rHF0sZ6
	ZAJiHcL8ta831v33DIW8Kxro4WKaROBGLO413K7XSaqv68K3OUdHmyVdZtN8b/GNOH0xsTcZd+W
	d4KD409N0sxFhimKeNlfkt77Iy5vNaX72Eo/SoSbh/XcCj6f1iHA9mzEKdKp61tN4Q9Jdpc5AQU
	brIkLc=
X-Received: by 2002:a05:7022:2382:b0:136:5c88:d928 with SMTP id a92af1059eb24-138066fc59bmr4276828c88.19.1780773904304;
        Sat, 06 Jun 2026 12:25:04 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-138173e5b47sm1328121c88.8.2026.06.06.12.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:25:03 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: netdev@vger.kernel.org
Cc: Allison Henderson <achender@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] net/rds: fix NULL deref in rds_ib_send_cqe_handler() on masked atomic completion
Date: Sat,  6 Jun 2026 12:24:48 -0700
Message-ID: <20260606192447.1179255-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,vger.kernel.org,oss.oracle.com,asu.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21906-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:achender@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DF0E64E20C

rds_ib_xmit_atomic() always programs a masked atomic opcode
(IB_WR_MASKED_ATOMIC_CMP_AND_SWP or IB_WR_MASKED_ATOMIC_FETCH_AND_ADD)
for every RDS atomic cmsg.  But the completion-side switch in
rds_ib_send_unmap_op() only handles the non-masked opcodes, so a masked
atomic completion falls through to default and returns rm == NULL while
send->s_op is left set.  rds_ib_send_cqe_handler() then dereferences the
NULL rm via rm->m_final_op, oopsing in softirq context.  An unprivileged
AF_RDS sendmsg() of an atomic cmsg over an active RDS/IB connection
triggers it; on hardware that natively accepts masked atomics (mlx4,
mlx5) no extra setup is needed.

  RDS/IB: rds_ib_send_unmap_op: unexpected opcode 0xd in WR!
  Oops: general protection fault [#1] SMP KASAN
  KASAN: null-ptr-deref in range [0x0000000000000190-0x0000000000000197]
  RIP: rds_ib_send_cqe_handler+0x25c/0xb10 (net/rds/ib_send.c:282)
  Call Trace:
   <IRQ>
   rds_ib_send_cqe_handler (net/rds/ib_send.c:282)
   poll_scq (net/rds/ib_cm.c:274)
   rds_ib_tasklet_fn_send (net/rds/ib_cm.c:294)
   tasklet_action_common (kernel/softirq.c:943)
   handle_softirqs (kernel/softirq.c:573)
   run_ksoftirqd (kernel/softirq.c:479)
   </IRQ>
  Kernel panic - not syncing: Fatal exception in interrupt

Handle the masked atomic opcodes in the same case as the non-masked
ones: they map to the same struct rds_message.atomic union member, so
the existing container_of()/rds_ib_send_unmap_atomic() body is correct
for them.

Fixes: 20c72bd5f5f9 ("RDS: Implement masked atomic operations")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/rds/ib_send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
index fcd04c29f543..d6be95542119 100644
--- a/net/rds/ib_send.c
+++ b/net/rds/ib_send.c
@@ -170,6 +170,8 @@ static struct rds_message *rds_ib_send_unmap_op(struct rds_ib_connection *ic,
 		break;
 	case IB_WR_ATOMIC_FETCH_AND_ADD:
 	case IB_WR_ATOMIC_CMP_AND_SWP:
+	case IB_WR_MASKED_ATOMIC_FETCH_AND_ADD:
+	case IB_WR_MASKED_ATOMIC_CMP_AND_SWP:
 		if (send->s_op) {
 			rm = container_of(send->s_op, struct rds_message, atomic);
 			rds_ib_send_unmap_atomic(ic, send->s_op, wc_status);
-- 
2.43.0


