Return-Path: <linux-rdma+bounces-21692-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Be3CmZVIGpV1QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21692-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 18:25:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98369639B2A
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 18:25:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=wQVRqAAn;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21692-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21692-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 245CB3028E86
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 16:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2A13ED3A9;
	Wed,  3 Jun 2026 16:11:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5393E9F60;
	Wed,  3 Jun 2026 16:11:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503117; cv=none; b=SCQOjuXf9nVcgj+ys/iSRIJG62vBojdHluCx+TRAEBpZ0Fh7NjlZiRHQdAraz4IS74Q6fkYMS0Dv2KEi4MG9UsATuQoerU/bAqsUxGTZI3t20mNLEviD8+d3tOY3cXWlz0gR7YAXDLOHJaFJUixQX+7S3L92SGh4CUXzMVGl0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503117; c=relaxed/simple;
	bh=HmlL0qqvpijOQOD4o02HHmq3QAAGEgH16ErPWKOs/L0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R/242AJeell6bXw5Mk5eLG4MCJ3h2y7yE2iICpT1tCZhYNipzbIzwDzN9ZF8Elq2+CnYRRGqfOU3NP4a3erbtOuNv4Su0l6Nu6TLI273FrdjtcDqL+CTIFSEJMfdrmZfl1NEkmV6NTv+jrR06ea3MlAuM8wuSjPmKNVDysHvELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wQVRqAAn; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=yIRToXVv0wy1zHveiEYfzvdmIu/DuGuO9ho2KecgFfA=; b=wQVRqAAnifklIHxfTOQkMEd28U
	v3NwSzgZn9GWiGICtFLOWepo3nA4l2zE6kdFEgoZWEOZeajnLAqtycnIKs/zk73dN1Q4Q0HNIxDOC
	iR8x2Kxk8IF/3f0z9YraTHhdVGmu7DZkLHH1EEtbE8jC+c+U5/PoHeZ63nU9mi8HVFiYEj0ehm+kk
	gIUpFPdyoJvSOySmTnz2yJyHoH+SvxeKpzpzcDcXjACjBtk27HU/KEHcwYOWYFm2ZNsLVN+l9Xawk
	fD0i88WoJIn21mJgW10drB/GqSsNilcZIMULzyosfzDbh1YqIjKdJ+/jpmNdyDq9u9lw+Pe7G0tem
	lw32mQqw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUoBy-003rAE-2h;
	Wed, 03 Jun 2026 16:11:43 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net: rds: convert rds to getsockopt_iter
Date: Wed, 03 Jun 2026 09:11:32 -0700
Message-Id: <20260603-getsock_more-v1-0-43b8d40c8849@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADRSIGoC/x3M4QqCMBQG0Fe5fL8dTKsRexWRqO3TLuEm2whBf
 Peg8wDnQGVRVng5UPjVqjnBS98JwvuZFhqN8ILBDs46ezELW83h81hzobm6F++xDzc3R3SCrXD
 W/d+NSGwmcW+YzvMHzZDXEmgAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=leitao@debian.org;
 h=from:subject:message-id; bh=HmlL0qqvpijOQOD4o02HHmq3QAAGEgH16ErPWKOs/L0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIFI5ZoRcBI802SNhhD4Qtl7B9Gb+BaV35ApYR
 NytHROiXVeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiBSOQAKCRA1o5Of/Hh3
 bSfwD/9fzBka2YgDbRozYUD7ERcASa44D7I8AD9R45kYwVqXs808ZIpQU8YMmEmde0CD1Rmh6T0
 KEHFyZy+XvEKez4iQOd6pvdd+UnRS6lS6i0m2IMJAncaEA+ALQSMNF9ajzqjGHTQnmIS0YsWgzA
 wIA31vlRw4/jTpOqt+QDUWI3/aHpwGTuD1SiOjQIDE/IOAKIdouP71RU60v2HE5AbQ88bSRUvWE
 D9GP6x+KWbCCY8WdAITJ9Imshs33nN0/PA17C9oINE/KM/dep4g8RLzrX3TNGKFuYPlcRmmrulb
 53W9Ewz0BsZp+RXufCPNq5EJ0v9m2nKoKEL+GugqSm14GLX/+U/0j5fmcN5anUZIYaJHzjIWnce
 F+F7CCgJFDkqBDUoeU3c04wM5RWjXOrVi6IJwUAa0kwN2Q4Ta0fNvvJ8M4EqnSdC48OXUO9ekwO
 jir5rxBh82Kje5mj2/jKdNLTwqQwhAZVuKG6o55Dw69Kut9R9c3vMjgy618B++vWsjce3Zpbffl
 crQsWTauqRhYTLyO4vHZh0R/kjFz3L4ATKLZEpcyO1yUsB5rKHmvMGcbAXnnhfB73rBdl7/UqjP
 bw27JY0LcryLW/VfxV4hY2RmF5WjQ3tg6eaI+hd8WsoRbaR5tcIWVHfc5d7lBtRkigTCihIi0iQ
 jghN6dIcXLckfdw==
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
	TAGGED_FROM(0.00)[bounces-21692-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 98369639B2A

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
Breno Leitao (2):
      rds: convert to getsockopt_iter
      selftests: net: rds: add getsockopt() conversion test

 net/rds/af_rds.c                             |  36 ++---
 net/rds/info.c                               |  70 +++++-----
 net/rds/info.h                               |   3 +-
 tools/testing/selftests/net/rds/.gitignore   |   1 +
 tools/testing/selftests/net/rds/Makefile     |   4 +
 tools/testing/selftests/net/rds/getsockopt.c | 201 +++++++++++++++++++++++++++
 6 files changed, 266 insertions(+), 49 deletions(-)
---
base-commit: b7bee4ca5688e30ca50fbc87b1b8f7eed7006c17
change-id: 20260603-getsock_more-46be8d1c56fd

Best regards,
-- 
Breno Leitao <leitao@debian.org>


