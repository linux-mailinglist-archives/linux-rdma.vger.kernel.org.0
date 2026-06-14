Return-Path: <linux-rdma+bounces-22215-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qc3UOpWnLmp11gQAu9opvQ
	(envelope-from <linux-rdma+bounces-22215-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 15:07:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA4E681137
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 15:07:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SRq9tpH1;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22215-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22215-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3051E3005EA9
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5127A39FCBF;
	Sun, 14 Jun 2026 13:07:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46413B7AE
	for <linux-rdma@vger.kernel.org>; Sun, 14 Jun 2026 13:07:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442451; cv=none; b=KGXbRS4EBdyuGJFiz5x8rVgvG/X9dCpN71ONt87hn1XvzM+su7qXHysmpoAzrbkBgFMgXxhF6H67uY3O6B17ptZ0rN9LMcEM/OtrPYV0I+LeUiJespenQ7KW4hwpJrLmkv9HjZJR/ORY5hNx1W0HjYMztiNR9igGw8rlgcyiDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442451; c=relaxed/simple;
	bh=SuilZbGlVZJOlat7J9MD/fOJwXfgtdW+5rL59Mett0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vkn3vMRp1NKNZD/Um1TbZkduO+g0q4UMdqbzU+5tBF7XMHQ/y2Vyg7CxFzfIqFnn/aWqtzup7d52O3EPFinX/6P9aYU+xAxCzm4acAGCIAkqJlUhqQNVB2DqyPk2qQOjq99NecO4nKJq0p9Q5J11C1+mGRYaY8O/Xb5oKs7Rmpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRq9tpH1; arc=none smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so29068716d6.2
        for <linux-rdma@vger.kernel.org>; Sun, 14 Jun 2026 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781442449; x=1782047249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbG/GGGyFndF/9JwUnN3ANh2Jf2/Fs6WVVXGFaUozYY=;
        b=SRq9tpH1hzQGGj3HZ7QNN4clizj8IxdKxwTMKleKLIK1MJT3hd2hYNMdXrYhXoJu5f
         5JDsA/ohexG+RD4SYQbO98TPc3jhhHrlt/qdTFZmnxyHZZeuSe2Oxf9OFhHeN0VV+4ml
         zTuu3FF967968bNrhlXUHLfu4FyG4rPOq1L0/jPiYtnsIxfkNwX12/RNLbKap6qUSZUY
         5s3/bglicpeiY0MHeYHBwWFdLpcTCMfqDHsrBrrAfVlilHP64KH5uwEGgZiNaTs63ELT
         vs0EgESJauBuA13lsq/n/PU/pblXF4/drP4LQ6JGutx6zO4a7FzKaOoTt852+Jq3DXlj
         G1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781442449; x=1782047249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbG/GGGyFndF/9JwUnN3ANh2Jf2/Fs6WVVXGFaUozYY=;
        b=Pt0xDiNjLJJ55IbbLoarw6sVFmL0mSQyVbkJH6NEzDYuV6ixKjziXAG76m6ZNjh+zI
         3pg3w9uyQgasL7alsoKVeNo5Ay+20LgfiCMzMSeCfJkmxuhWXtRBTzAE0tc3Jwq+W6pG
         nVrRRouk6viMtFNT+wliq8o9ColiZb7c31ZovhYCiTqBGJ36SuvcF/ByIE4Os65YBQRT
         7eE1k4DTjQKh0yocXNgZ15QC3fRI6w8xnQ03+iKnXSzLcj0yTZ08Nkg9kkHxNq+43Luq
         Ju3R+sRH79WuTVltgi18m1Vie6Jvxt9uSsaC0BZxnb7iBSAf0yENmBklTcpviZVf10fT
         Vzmw==
X-Forwarded-Encrypted: i=1; AFNElJ96oAHGKcP2KNQVkwuvuEEzpRq/W/aTzM3/Q4FQM2OhGOCp6PxtzcxhQlM0ytn3bJgecvOmVpM5y7Iq@vger.kernel.org
X-Gm-Message-State: AOJu0YxKqBbcMxtNrqXMoHvL8ChaAIAzLx4ZS9D2y0HD8awLy28DbA3L
	ntE/aoKPVepS4YZrG7XHejmBPjg89JtozX1m401M1z9I/4oDtfux5X/5
X-Gm-Gg: Acq92OH5eYhJWFZdpcppp3L+ekho01S7vyI3yshOXaVsqVrErveL8c+k7mvXIHpMSg6
	UVxYdEOcuX7NV4ZZGYIoExX6AWz92GMvNq021yoiWVybH8dSh5nKyefE5e5y8x7rwwrpKlc46AN
	BTJPY1JbALbgjScK1xuIj3vhUZunvW3gjEws9eB5I2Oj1NokjTaf3sBrH3cWwRk4Q0gJ7q/dU0j
	eRzilGRF3DINo0tvv3tPWjDnEbzBNwebCebPuPi/Etij+hBvsnMHujETXVgUZWLLjyXpU8bTTMn
	seHvjiOt97xAIaAZnLPvVWm/yz3IoKam08g9a0/fT5KGTd5tyBme3r9C547mqHJCvPu77ZWyxeU
	ehparOiURCfwBD3nkFvufC3mVkGdeaYey4bsCxWfwaCR291AfobLp6MiVcLpdO/AVpQmCNWYG+1
	SfbqvpwPa2uMk/kU5WbA0RlhafXQEC9F4UcFX2BrRXWWuMf2ZJFEbyG8IFOm6745KW4QOC6GKNm
	t3Wo2HHusTcCsp9er7CzTpkJgp/RXcLJEi0uRXO9Co=
X-Received: by 2002:a05:6214:2e43:b0:8cc:f0e0:f90b with SMTP id 6a1803df08f44-8d45087b9a9mr125364426d6.40.1781442448883;
        Sun, 14 Jun 2026 06:07:28 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30570c305sm77413366d6.48.2026.06.14.06.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:07:28 -0700 (PDT)
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
Subject: [PATCH net] net: rds: check cmsg_len before reading rds_rdma_args in size pass
Date: Sun, 14 Jun 2026 09:07:25 -0400
Message-ID: <20260614130725.2520842-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22215-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CA4E681137

For RDS_CMSG_RDMA_ARGS, rds_rm_size() calls rds_rdma_extra_size() after
only CMSG_OK(), without checking that cmsg_len covers struct
rds_rdma_args. rds_rdma_extra_size() reads args->local_vec_addr and
args->nr_local, so a short control message reads past the copied control
buffer. The value bounds an allocation count, so this is an
out-of-bounds read in the kernel, not a leak to user space, and an
unprivileged AF_RDS socket can trigger it with one short cmsg.

The two later RDS_RDMA passes (rds_cmsg_rdma_args() and the rdma-bytes
loop in rds_sendmsg()) already reject cmsg_len < CMSG_LEN(sizeof(struct
rds_rdma_args)); only this size pass does not. Reject it the same way.

Reproduced under KASAN on QEMU via a KUnit driving the real
rds_rm_size(); the out-of-bounds read is gone after this change.

Fixes: ff87e97a9d70 ("RDS: make m_rdma_op a member of rds_message")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
A short RDS_CMSG_RDMA_ARGS placed at a page boundary makes
rds_rdma_extra_size() read the args fields past the allocation:

  BUG: KASAN: slab-out-of-bounds in rds_rdma_extra_size

an 8-byte read. On stock it faults; patched it returns -EINVAL with no
report. Controls (well-formed args; a short cmsg with args still in
bounds) drive the same pass cleanly on both trees.

No in-tree selftest exercises rds_rm_size(); I can send the KUnit suite
as a separate net-next patch if wanted, kept out so the fix is not held.

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

