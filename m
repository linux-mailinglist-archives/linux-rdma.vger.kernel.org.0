Return-Path: <linux-rdma+bounces-21835-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UPVVIEq/ImpwdAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21835-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 14:21:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AB4648105
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 14:21:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=NiHLFiC0;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21835-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21835-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B933302A51D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3654DB552;
	Fri,  5 Jun 2026 12:13:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF54D8D99;
	Fri,  5 Jun 2026 12:13:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661624; cv=none; b=PVBBBKDQovktw9M0v1sNY8BolW7T0VGtjVoJn+9WCWx+tUss6pkwR3n0TqUXNoJR33s4RSgLXQHMoXEamMuXyiuPaj74LDvQfjVvbgABRuyO8HyWqlEWxZ/MdGlXyRB6bG+RbQffMdeNAcBdgVXuisFKzlPD4fffxromNkaLx0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661624; c=relaxed/simple;
	bh=wlGIJYU/dDzvU9MAE0TjTNh5imcqVaypnxxCgiS9lvU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JqN15x78oMR+2kvFq47aVTACD0cTtvLYjj6QQLEnLpuc2/Khi9KmyHajR07Byovr9df0zd8hIcuh35YnpBSFBDaV4Buk87PL1U15d6Y0UFQNPynMuJG730fbBKoyYGOdPFw5R2HRfN8XjGdPiCv5nsM7iH4qkKScZqCTIQbN1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NiHLFiC0; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=MByAqnkLEXLPVdCrzdTSFRkXWavhWm2hvRfXpDldUXA=; b=NiHLFiC0YnU2X2Q9D8HU8xS+k2
	8DoJu4eyvuFQhwJPTNmYwGM9CjJcfexW8xEVjmwlHI5eA/SzVAo1LhZatqGlihPa+WQLHdB6PGyWw
	CLF0nCa/48/1G3FYP5W7DOnKw7tLU4NYAqQPGULld0Cmcdl8WIGUNXrSAs8mh5P/QOl8LY2mhtJs0
	ta9St5z8IOaa1l5+j5DqjFmARhytWcLOsXE86YCezyTEIYLtLcBxgxLmUF9MXjoQOIqADBKa2CQA1
	qCjvlsVDgK8470irHDOHvQHLJ1WDDmamHLWUKuWHvJUNR6GsZhjW4iTGk4kZdqQR58h7aeyyeqjPD
	izM33evg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVTQc-005HW2-1Y;
	Fri, 05 Jun 2026 12:13:34 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net/smc: convert getsockopt to
 getsockopt_iter
Date: Fri, 05 Jun 2026 05:13:24 -0700
Message-Id: <20260605-getsockopt_smc-v1-0-65da62fa44c4@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGS9ImoC/x3M4QqCMBQG0Fe5fL8dzCGz9ioRYfPLRrTJ7ghBf
 PfA8wBnh7ImKoLsqPwlTSUjSN8J4nvKC02aEQTOOm+9HczCpiV+ytoe+o2GbprH/jpcPJ/oBGv
 lK21neENmM5lbw/04/vmWExRqAAAA
X-Change-ID: 20260604-getsockopt_smc-e2ad719486eb
To: "D. Wythe" <alibuda@linux.alibaba.com>, 
 Dust Li <dust.li@linux.alibaba.com>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; i=leitao@debian.org;
 h=from:subject:message-id; bh=wlGIJYU/dDzvU9MAE0TjTNh5imcqVaypnxxCgiS9lvU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIr1pIS/x43wPjjvzmWbNsm0G32tzbhQbfSiEm
 PL7boVHQOOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiK9aQAKCRA1o5Of/Hh3
 bf4KD/90AFrq2jSuXAh/UBfgxKhd7Y2dGik959DyxgVa2mVHbHLRFXqw/eoVDuxa1EV2ftr/ClW
 fRuMTe9bEETot5BDjsznnuuSxkbBCklvz4m5RLxeO/etQyBw+RZxm7WXU8GMFiPzXXre6WCUzS0
 sRWLah6Xqp9W4/2SZ/Lm26JQg+/Kc8XZiwZ7Qc6tDWSATy9l1Tnurpb2/5eTr2yVmq0DMMKr9Fv
 5nQk8gp2hvJ/p66qv6jP1YQkqlf1OX3l1rdpbXTVnxGPi0JFcWmTvxr0Ezz4FvTTfwh9EjNPMBi
 Z7aJ2BzSS1+XssFo9JkZEl8kxiDnhicsjJqWzs9XIaqccVcJFKzX6NKhzB97lW9Siuv77hsa/l3
 CKwbDSEDYJVVSKCak5Bj+xxPAy93WI3my5r7nO0wFT2gGH2x051zcslspcBsoXN3bgqu16R4C7N
 RF/WSGHab/MCjHkhRnw5Tw/yaUL1OG0bC9jIvaiTUTs10fQll1o6tzQ391kd7bGY7Sck41CU3qw
 57grUjoNhi40Fxvn+YrL8mvj3FZQPL/2XuMezLlY8BZH8VDwg6SyG14Cze2Ni2HaYK9Ll+yPtUy
 D8DSSAr3Rskh5GK+G1KvAwXejNmlQxm+zcF62YLfOcCmswhx34I8yxnDlJhRZoCHmmSVdECa4Bx
 gARgSCi81/xSsFg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-21835-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0AB4648105

SMC is the last protocol to be converted to getsockopt_iter(). As soon
as this series lands, and all the other outstanding conversion patches
land, getsockopt_iter() will be renamed back to getsockopt() and the
first part of the conversion will be complete.

This series converts SMC's getsockopt() to the new getsockopt_iter()
callback, which hands protocols a sockopt_t that abstracts the optval
buffer as an iov_iter and the option length as a plain int instead of
raw (char __user *optval, int __user *optlen) pointers. This is part of
the broader effort to move getsockopt() off __user pointers so that
kernel-backed callers (e.g. io_uring) can issue socket options.

SMC is a proxy socket: only the SOL_SMC level is handled locally, while
every other level is forwarded to the underlying CLC (TCP) socket. That
sub-socket's getsockopt() still operates on __user buffers, so the
pass-through cannot simply forward the sockopt_t. Instead it reconstructs
optval from a user-backed iter_out, forwards the preserved user optlen
pointer (kept in sockopt_t by the base patch), and mirrors the length
reported by the clcsock back into opt->optlen.

Because of that, the SOL_SMC level is fully converted and works with any
iov_iter type, but the CLC pass-through is intentionally limited to
user-backed iters (ubuf) and returns -EOPNOTSUPP otherwise. This is a
deliberate, temporary restriction: SMC will continue to operate on ubuf
only until the underlying protocols (TCP/IP) grow their own
getsockopt_iter() callbacks. Once that generic callback path is enabled,
the pass-through can forward the sockopt_t directly and drop the ubuf
restriction, supporting all iov_iter types.

The series contains:

  1) smc: convert getsockopt to getsockopt_iter / sockopt_t.

  2) selftests: net: I've vibe coded a kselftest exercising both the
     SOL_SMC path and the CLC pass-through, including the
     oversized-buffer writeback.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      smc: convert to getsockopt_iter
      selftests: net: add SMC getsockopt_iter conversion test

 net/smc/af_smc.c                             |  41 +++++--
 net/smc/smc.h                                |   2 +-
 net/smc/smc_inet.c                           |   4 +-
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/getsockopt_smc.c | 175 +++++++++++++++++++++++++++
 5 files changed, 208 insertions(+), 15 deletions(-)
---
base-commit: 0a8b288e2248cb62a62f748bc095c2136acf22b2
change-id: 20260604-getsockopt_smc-e2ad719486eb

Best regards,
-- 
Breno Leitao <leitao@debian.org>


