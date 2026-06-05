Return-Path: <linux-rdma+bounces-21831-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T2stLmWnImo6bgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21831-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:39:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F766476B1
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:39:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=cz8euOCu;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21831-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21831-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51DD3303F71D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893384183B2;
	Fri,  5 Jun 2026 10:31:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2294413620;
	Fri,  5 Jun 2026 10:31:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655514; cv=none; b=T98XXpRET0sijmgrljQ60CxkfmLziyaja5XM9z9OswEy39zn88/qGqWsY1pyH7zzAzK4J4B/SgNRcgJu9Jfcs8Wl3WHuFUGHpGGEZB42ZjxcGZ7dTAMm03HsW3aeVT8WJTtHXpEEAcTLSyRhkdKxaTKoTrM7hpCsxtCwAE6MxpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655514; c=relaxed/simple;
	bh=OBWY16znzlumIDuXmPxKShpN9lmCjAmAY1x0RdDphkY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tFMN44HBfuZqrLl0lNZ4gkTkl2EEKO8t7PMKBvnw61K9gIqHssdQQBGMmJAo+L2xswxzz2dng9oFfJB55uDgdSktxMjfm23YzkAwJJr9GKzbJqWKza0azV37TtQmDSsN2KbvAUq/8kSs6+R9oav6OIW2WixCZh0Zfh1AiPh52F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cz8euOCu; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=9PTu3Vb3Lt5Y6lB5ku3B8N33RivQCs3vrjjJ3i7UYOE=; b=cz8euOCueZ5KDpiTRs6xTITzWd
	yZfuWCEbPh1lvm6FGWe+T0sGbRISl8uB1YrKkq3XFRk7rE9C6lXq921pVQwv0txzRoRLrw6sHWCZ6
	i+tpnlV3j52OCDEaCciMlCpW8XY4pLeXDDFfqQmwNfv1UiBjkTsaWqCzO6glTrA4UkfWNd+YiNu7h
	dDxU47CAUtMMGnsH/LtY8kSz0Vw4eddQcuuGkD/BiJAAIJ7J55n4gfEKT2yUwrU/6O/rd0lp8nqY0
	uDL37y1QtQAWXuxkDCUhj2tLIuzLIxsHtweIzFioU4tJTGeUsWyH666RZBF/qhvDAZ10QdQ7icP+e
	TeY40D4w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVRq5-005EEp-1d;
	Fri, 05 Jun 2026 10:31:45 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/3] net: rds: convert rds to getsockopt_iter
Date: Fri, 05 Jun 2026 03:31:37 -0700
Message-Id: <20260605-getsock_more-v2-0-80f38cdb8706@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAImlImoC/23NQQqDMBRF0a2ENzYlahpSR91HkaLJVz+lSUmCW
 MS9Fxx3fOHcHZkSU0YndiRaOXMM6ERTCbhlCDNJ9ugEGtUYZVQrZyo5utfzHRNJbUayvnZXM3l
 UAp9EE28n90CgIgNtBX0lsHAuMX3Pz1qf/T+51lJJ3Y7Wa+Ws1be7p5GHcIlpRn8cxw8p9zmys
 wAAAA==
X-Change-ID: 20260603-getsock_more-46be8d1c56fd
To: Allison Henderson <achender@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2386; i=leitao@debian.org;
 h=from:subject:message-id; bh=OBWY16znzlumIDuXmPxKShpN9lmCjAmAY1x0RdDphkY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIqWNpaqMrV3mAFG2swCP5DiCM43NEpny5JPBV
 SSDRY+wuKiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiKljQAKCRA1o5Of/Hh3
 bZ9NEACGKK+YVIXxYig46rW39uHzWqMyUyo1SJQZkp2r62/SBjCo9ppZI3Ht6bQBXUOV+pvzdpw
 mQ/H3yOT08alSIWnFmTOvDfBngcUDKmoRRn0BmsDeGa/c4Ymo+MIkP80w+6CjcKvqediH6bnRvE
 v5E6AxNMb2DK5FFeq9lAINIZnsUp7/CQ6lNzBEn9UFqrNdV++bq1RnzvxcrLbaiB4kh5C9A796d
 EdYh5bmFFTMBZoX9h+2uRWa4dsGJ0SmR7BGZ1xJNAs4/ZZz/K1edNcuaoGac1XY3qTRe2qSxJRt
 mk7ynPZVDTO3KUxCZiA+Owhzl/G2qiUHByBG2gySDLHx3ZKBd2FgZZrBJA+JskRnLqa+HuM9hOO
 1KIiJekE7IsCMaA1RX2EnEuL2st8fh6tFa4A4hFdAotOaHgVjvs8iKP7P8pEg9tz/5IhgvWzvJF
 +4X0ywWZEq5acbwpxM+XSLRxMS0Lo7uSoEAFUedG+4BW6YmnMdhmX2H0IPxsLwfV7h5FaaFl/Jw
 wSOiCyaBx+0B3NK97vhzUet3VMQh8/BZjvCJznJnADmi5eO3rBJC3ovDYLMgnB2w7CMGcZBeiGz
 FETKSxE92/PTjbfgDDHgwKRHXg0KPasHDp8rzzmw0gcChnwLj7NwAQ2wuPNGBmZk2OmavCuFHzm
 gmpuk18U2WhRk9g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-21831-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32F766476B1

This series continues the conversion of the remaining proto_ops getsockopt
callbacks to the new getsockopt_iter callback introduced in commit
67fab22a7adc ("net: add getsockopt_iter callback to proto_ops"), this time
for RDS.

RDS is a little more involved than the protocols converted so far, because
the RDS_INFO_* options snapshot kernel state directly into the destination
buffer: the info producers memcpy into the pages under a spinlock via
kmap_atomic() and so must not fault.

The conversion preserves that model — it obtains the same page array and
starting offset from opt->iter_out with iov_iter_extract_pages(),
preallocating the array so the iterator fills it in place, and leaves
the rds_info_iterator / rds_info_copy machinery and all producer
callbacks unchanged; kernel (ITER_KVEC) buffers remain unsupported on
the RDS_INFO path, as before.

I've vibe-coded a kselftest exercising both the simple options and the
RDS_INFO_* snapshot path, feel free to drop it in case this is not
useful.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- rds: reject non-user-backed buffers with !user_backed_iter() instead of
  iov_iter_is_kvec() on the RDS_INFO path (Allison Henderson)
- rds: gate the page unpin on iov_iter_extract_will_pin() and comment the
  implicit pin (Allison Henderson)
- selftest: size the snapshot mmap from the probed length instead of a fixed
  two pages (Allison Henderson)
- Add a new patch to fix a concern raised by Sashiko.
- Link to v1:
https://lore.kernel.org/r/20260603-getsock_more-v1-0-43b8d40c8849@debian.org

---
Breno Leitao (3):
      rds: mark snapshot pages dirty in rds_info_getsockopt()
      selftests: net: rds: add getsockopt() conversion test
      rds: convert to getsockopt_iter

 net/rds/af_rds.c                             |  36 ++---
 net/rds/info.c                               |  78 +++++-----
 net/rds/info.h                               |   3 +-
 tools/testing/selftests/net/rds/.gitignore   |   1 +
 tools/testing/selftests/net/rds/Makefile     |   4 +
 tools/testing/selftests/net/rds/getsockopt.c | 208 +++++++++++++++++++++++++++
 6 files changed, 279 insertions(+), 51 deletions(-)
---
base-commit: b7bee4ca5688e30ca50fbc87b1b8f7eed7006c17
change-id: 20260603-getsock_more-46be8d1c56fd

Best regards,
-- 
Breno Leitao <leitao@debian.org>


