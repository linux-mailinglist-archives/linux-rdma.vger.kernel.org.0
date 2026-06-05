Return-Path: <linux-rdma+bounces-21830-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O8lFGGqnImo7bgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21830-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:39:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F36B6476B4
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:39:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=qy2Po5Ez;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21830-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21830-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3B4E30C0C3E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD5C4183AF;
	Fri,  5 Jun 2026 10:31:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712141363B;
	Fri,  5 Jun 2026 10:31:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655514; cv=none; b=CJjn3DcTcAEEMQP8s9w3NBJmqyyEzmnoaL/HEEBUaZ0rzlpp4gTf0bGM08GAbcmpLCZ26LyywI9VyZZ3Y1h02LscYHd2oRw5k0oJv1qWCAsVHGi797gADY34cKtLg/y+foUZ51e+fhvJgfCbN3Oj2xYklDAHTRULvSnxC0nWwbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655514; c=relaxed/simple;
	bh=00hwPSZA8fZYcFj+RYCIxpnKtgT+aRtEfaPpoZFZJBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n3OKoYKMbUTV0foRfxtMN+83UL6Nf4Jyykue/5WMwZz0xuH8YF5O6kgQkeO7kT5t8B2F1lrnrfGo/RxWfF8ZH650iaF6+LQL8EFowwsDVMCFo02v1j6Hx2TmmXqbs7LMye7sAdj0XS/xW8OV3liKpNoC1gjxVTJ8R2PX3FEYZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qy2Po5Ez; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=8DmfM0emdEXvHwwBK/UWoQtQdiUcoSMtiKrMc4myUNY=; b=qy2Po5EzFtqBVmaUj5pARa+sAb
	5Gcdae7s3vwdeTUvF4A0iXn6EbxMpcydwhIOL1XgdABvEUbvs8BiYDr7hrdJwLe8qZiojWAMAh44l
	rwMVScrutwrmzFDX4DVm21m4XCAYYGuwvStuxYet4x2iECzK+FK04i2+dl1XKc4DVh3HnvPk+yPkQ
	Zo+b8ifcaw1AnwUrA94/R4wGYxHWAeQ7KsB63caW4IZO9OlsQ8yoPBSkfjjzgw+h5vlrXBD6CPOKZ
	xGFfeZXp1LuM9yToRcD/twQOrp6WEXnVOuZqp4nIbv+AYQ4FL+uN1WlTd+kyGpSU+dZ9g9hKc6wth
	8b3Py7FA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVRq9-005EEs-2h;
	Fri, 05 Jun 2026 10:31:50 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Jun 2026 03:31:38 -0700
Subject: [PATCH net-next v2 1/3] rds: mark snapshot pages dirty in
 rds_info_getsockopt()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-getsock_more-v2-1-80f38cdb8706@debian.org>
References: <20260605-getsock_more-v2-0-80f38cdb8706@debian.org>
In-Reply-To: <20260605-getsock_more-v2-0-80f38cdb8706@debian.org>
To: Allison Henderson <achender@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=leitao@debian.org;
 h=from:subject:message-id; bh=00hwPSZA8fZYcFj+RYCIxpnKtgT+aRtEfaPpoZFZJBY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqIqWNcVYIIJISvcnN7cwAbA0w5GLVZG8jfwZ4Q
 BxzYfinR9WJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiKljQAKCRA1o5Of/Hh3
 bcWKEACuD3qtWXMRs/X/KxwjB9YhpiCScdOL1ayjmDKa76/qXeVdgQpiS8ufbjI9rEY+mL63N84
 XpRle9/j5uLr6KkRrbcP+xOuBdFEvHA1jd3jC6imnxdOnF3JpJGDO1Ct7ZvOR3d/QOuzmjbCgvc
 /Uy6BF9GcLbEJLKhoZ+L4CC8RLEDAWrPQsuwPNMMOsjNd/liGEbNP2H8MKgfmBhRX5egLEJlM3b
 9LegD3FHsR33fZ2DEUF+ru3drqi/aVxF8LaLKGX15YwmHe1kZHKX9ILG+Avjc8HbIw2g8pX1b2C
 okXGPcsaqO7I2OedE1jpAqnC/W+AEg3yYZb6qu5tD6w208Z/Qgtdk3vi4hV6XGwFcK5Umqg7QYF
 CEeKqtxZo2Zml5P/e1ecIKHk84IJDn/WMad3xVA4H2H6zMrArR+x/XV7mQ36xwXv3mxsECTIZxg
 XjrE7Y3n/tmvnnGidXQDOKY42Sk2tj0rSqrwWXiz+++YsgB8KBCJRF50FGniLGhtx2sIWRi0Gid
 hR8/6K8NsDDc1Co70/85VIvYqAqpDrZXrmcsvVtjAu5NbPhDIQ6WyeVFmBWOSE84D6pvRidte/v
 xwea8h4aTyJvZmSFQQFKXu1NXT0zOh0KkpchhnT/0fA0nnth3LJYsVXvzNJ/rmj0bZxE+51afx7
 co8JzalAEf26YIQ==
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
	TAGGED_FROM(0.00)[bounces-21830-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 0F36B6476B4

rds_info_getsockopt() pins the destination user pages with FOLL_WRITE and
the RDS_INFO_* producers memcpy the snapshot into them through
kmap_atomic(). Because that copy goes through the kernel direct map, the
dirty bit on the user PTE is never set, so unpin_user_pages() releases the
pages without marking them dirty. A file-backed destination page can then
be reclaimed without writeback, silently discarding the copied data.

Use unpin_user_pages_dirty_lock() with make_dirty=true so the modified
pages are marked dirty before they are unpinned.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/rds/info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/info.c b/net/rds/info.c
index f1b29994934a..17061f6ff74e 100644
--- a/net/rds/info.c
+++ b/net/rds/info.c
@@ -235,7 +235,7 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
 
 out:
 	if (pages)
-		unpin_user_pages(pages, nr_pages);
+		unpin_user_pages_dirty_lock(pages, nr_pages, true);
 	kfree(pages);
 
 	return ret;

-- 
2.53.0-Meta


