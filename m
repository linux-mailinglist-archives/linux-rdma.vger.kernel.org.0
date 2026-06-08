Return-Path: <linux-rdma+bounces-21947-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i+P1BGuPJmoCYwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21947-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 11:46:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D74654B5D
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 11:46:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=QH+yS7L3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21947-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21947-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84AC03004CAB
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2143B635F;
	Mon,  8 Jun 2026 09:46:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28E337B81;
	Mon,  8 Jun 2026 09:46:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911969; cv=none; b=XZ4JhorEcH2cvGyYa+/Ti2e0UKafEI8Zd5R4RYzDScCBXHLd8p8KZK2+JHVSmJoK6XlPMtmsfjw/H/RXP4HfnnbxJliaLXP5Q7NBsuX+ylVFNhFVSISU8Ww6L2QaVCIJ+cVEgUgQs5cfxf2mzq/3BPOJfpcKM+m58cjcLOsrRtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911969; c=relaxed/simple;
	bh=ZNqXIOMQx/9Cei0fmz4inEdM2L/JL2wYYV5+cGQyfdE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cpJ3QsaIoA4bVuAlNNZi2ESWCGR9yMNsnhY53/ZZwm94+sYxh+R5/RZCg9PxdY3cPnJ6Scmf5tNj+L34b3iDlvhpBmk2keW26VwKYkVJRkwvWqjamg+wW83oKYtaP31h6BUtbF37kXd8hFFNSVJG/gmnO775d8QWcKZvOf+YIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QH+yS7L3; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=GBAWpq3VWx9yVC9Jpc9XHimo01iW/tVjM3UeU3rQ7bM=; b=QH+yS7L3gJ03MjrME5DH0eTMvg
	APKNQzww04jRBj9S7AoW61CO599tEik6vctHB1kVkairmOuoTrZkxQeZqZiP++ARDnmUoBMMP7wx4
	Ubz6SFLDax/ZC+RHdyFtKS1WmF7VRMZDDb1oGfEGKiWMNKookzhb+PKttPA7wBd1dHeZzs/7RHsd2
	B3lmeTh5m5slc0vzdRmYFviPBgCPWxfeiQDj2HWFtfuhQTnqZXGY59eyTCKEZDBz8lTG7YDMpzNnp
	5OF/Xk2FdM/EXpnIkNj2DvgSpGtQL3upKjPbQd0sDN13YBrwpQ0bHp0aclE0CiSuK1EAov1mi/5xS
	MkMCHIIw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWWYS-007XFC-0f;
	Mon, 08 Jun 2026 09:46:00 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/2] net: rds: convert rds to getsockopt_iter
Date: Mon, 08 Jun 2026 02:44:56 -0700
Message-Id: <20260608-getsock_more-v3-0-706ecf2ea332@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABiPJmoC/23N0QrCIBiG4VuR/3iGU2e2o+4jIqb+2yTSUBmLs
 XsPPKro+ON5vw0yJo8ZerJBwsVnHwP0RDQE7DyECal30BPgjCummKATlhzt/faICalUBrVrbad
 GBw2BZ8LRrzV3gYCFBlwLXBsCs88lplf9Wdq6/08uLWVUCqOdZFZreTo7NH4Ih5imWlr4p+5+N
 KeMajYKbZ3RR6a+9L7vb9Gf9N3xAAAA
X-Change-ID: 20260603-getsock_more-46be8d1c56fd
To: Allison Henderson <achender@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Andy Grover <andy.grover@oracle.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2524; i=leitao@debian.org;
 h=from:subject:message-id; bh=ZNqXIOMQx/9Cei0fmz4inEdM2L/JL2wYYV5+cGQyfdE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJo9Utu600ILqdENVlMGn3XjTeq22GF+fzocyn
 xERVNUMnweJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiaPVAAKCRA1o5Of/Hh3
 bZhqD/9e5mw9Fr8hTfzJexYQxGpVuPNPn8f9rETxJ2dyxAlufWTbY6DhsTPmBP4aXodVkA/kWm/
 gp0+V8tR2DsiJZf5VebMRI91S+DLBzZQzdNEp5L0zHSWjOAXzv7a1D+wAQAWNyNDSPnnH/oAvbV
 piSv9I9UeP8P+GuKq+xPgMBBxsGo3AAehyWzO49onqZtg4L/KiCMQnDGIoCdkgX4aYOcShKZY8w
 muSYkdpo7N7wcWQP9q7cvgmlujMZYWnhulJ1cWDcOKyLaaCCQlK7WKgg7XOxcxRkndpYj2XtSXJ
 lfkylTjnOmb8aa7H3MdXZYTJgQl1N+KJVYW1baBwMK/Qo3SvURmomRp7Qh/x85cWTlAOqqQjLb6
 1G3k0b/xV36gsvGhDbnIwwTmBEViNXJ1LlUCrB6oDZA4hKm7tCACjCgzZbs2rGthOqCJJP5SCkk
 dzgtzq4/SfxwVGd5hyb+DZqJnIQmpQqh2M+8bO5ePKaLJ9CnlbgTeQjSH1iQn4izsR/eRrGjLdZ
 hto72g/CUG90fPyuoGSdL7zq66vbue+S71Vn9wmbCMUztqgvtcMD5aEH2rLHYJNOrt7MFc6hhcQ
 18MqxAkBhx8AZPX3nC3B+OA8r/7lEf5gdTUrGLxvY3Zcom0E+NJi4kKTaUWUrTaRp4tXo+5jmSn
 lGEEFVHdpeehrNQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:andy.grover@oracle.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21947-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14D74654B5D

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
Changes in v3:
- Resolved the conflict with net-next
- Added additional tags (assisted-by and reviewes)
- Link to v2: https://lore.kernel.org/r/20260605-getsock_more-v2-0-80f38cdb8706@debian.org

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
Breno Leitao (2):
      selftests: net: rds: add getsockopt() conversion test
      rds: convert to getsockopt_iter

 net/rds/af_rds.c                             |  36 ++---
 net/rds/info.c                               |  76 +++++-----
 net/rds/info.h                               |   3 +-
 tools/testing/selftests/net/rds/.gitignore   |   1 +
 tools/testing/selftests/net/rds/Makefile     |   4 +
 tools/testing/selftests/net/rds/getsockopt.c | 208 +++++++++++++++++++++++++++
 6 files changed, 278 insertions(+), 50 deletions(-)
---
base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
change-id: 20260603-getsock_more-46be8d1c56fd

Best regards,
-- 
Breno Leitao <leitao@debian.org>


