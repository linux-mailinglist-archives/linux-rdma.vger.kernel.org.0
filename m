Return-Path: <linux-rdma+bounces-21946-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NBuWHY2NJmqVYgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21946-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 11:38:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FF9654A7C
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 11:38:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=r++slE5y;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21946-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21946-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E058305D99D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE738397332;
	Mon,  8 Jun 2026 09:33:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821C2E739A;
	Mon,  8 Jun 2026 09:33:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911215; cv=none; b=puJ0PiD3XyyEF2ZQSQ6awnwrp1AytBSHD2rtwIwOmSMWT553nm3EFO2mbHdJ7huIa+8jJREV1K//yL5FxTE7/03RWGkGfQIdBE03FeByTQwxC83XF9hcBJSP5LQ/XDHADfFxaSQKKgmE1WsMw25bf8URXJoSjKLqiaAeAYl4Tzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911215; c=relaxed/simple;
	bh=jXSbK/y3T0J/qL0JEnlkmOmsA9DHD/x5LY8yfr0d2tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RMs4kkWC0Jbuhp9ONxuQz0onac6sbwS0IpIPunbvYxO1qEByWZNyK2TfILjsVv11q/hr5Q8cueadF2NBEYV3PbDeTptlwWY6576EXkgNRch1aWv6V2AI6eHmy5Bxpg2HVvsPmClKpfHHQXd1AaaQRuoMdNYL0wGASfJmQZlSfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=r++slE5y; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=2536z80i2F49JQxoJ45J3DmC1kfjJnuOkkcVHn/LwUM=; b=r++slE5yJ6HlROhA2wjJvn/IqW
	ux9pU135kG6+NXjKumcCvjRZ0m+XzmEo0fQ0DGYY9U+uyxfvQK6zQrJTH81EkCsrY3Q0/fu6EOSqh
	Cl8tSvjhCvZu1Y/rrze4Vai3YAe4WaLk8tAZkciI6e9Qe/U+vWDrVge3h8tFnLx8B7cxRgMBxIhD9
	0ovRodui0Lrt3D1Yd7TNEwEH+FDVhtBiYhlsw65hounOvf3M+MciIzZsae68ob5ri4mB5lLvhaO4e
	1pkfVRW5WgdzHKvf3uW47EddSfRenWcEIuppihAFGcPgUVas6ENTl52ByDfkESySuh3/anOhrO3lI
	s2howo8w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWWMJ-007WjY-1q;
	Mon, 08 Jun 2026 09:33:27 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 08 Jun 2026 02:32:05 -0700
Subject: [PATCH net] rds: mark snapshot pages dirty in
 rds_info_getsockopt()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-rds_fix-v1-1-006c88543408@debian.org>
X-B4-Tracking: v=1; b=H4sIABSMJmoC/x3MUQqAIBAFwKss7zvBJKy8SkRErrU/FhoRiHcPm
 gNMQeYknOGoIPEjWc4IR21D2I417qzEwxGMNlZbPajk8xLkVaPxduuD7gIbNIQrcZD3nyZEvjH
 X+gGpqihWXgAAAA==
X-Change-ID: 20260608-rds_fix-92d6c7f04fe2
To: Allison Henderson <achender@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andy Grover <andy.grover@oracle.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; i=leitao@debian.org;
 h=from:subject:message-id; bh=jXSbK/y3T0J/qL0JEnlkmOmsA9DHD/x5LY8yfr0d2tI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJoxjdwIHRloEIey/wH+093QB8dvjSgrE4ToW9
 f51Vho4aOiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaiaMYwAKCRA1o5Of/Hh3
 bXnrD/9Abi9ptLTHhISI6ZsdcLOArNcXEosMy6aGdfLb7IJ7aOMwLezl2Nyv91AxdO3/P8lg8Wv
 odoVcyADPuwPLR8uqGtjDRkxbW+AKascfYwacwNHDjhIeBFsl2nH54AKIog2IHFqxw5iVXItbyh
 Ujmkj0SofJ+IbWSiVLc70uUDcOe8X7nLLLGFZnitn+T/dSiaMEQifokCbv69WTIpd2Jhofa3NAV
 8Gq9nXo1+iNbJo70BOwavQOgpq0wmxG55Q1+DPtGyGtLYucXGXWiphynXXsuA4ZU++5cKubQ5SR
 IixYPkdM6P9L2HS9fc53OMOLv6oF+NAy1tePEixaJTbAQPFrmCGveJXZ572ZV5bv6X+CaN6RF4G
 E7+Fxpq0A3lk6ABkC3VOCXl3UKJIUQ2kT3JqyGqVSPLV/lu3kxF1qF653ypqj8VOOb6AlthxeNR
 eXS2F0QJN3FpYa/yPePEj/TFooOn2mT/pP7Ddjs8LgA3xYVbED8VRNV2rGQVLphUzYUCn+n5l5h
 MFObDdVzHMnBOaHt5j/2jpIYj31YpZa3BuD12acxg2Cyc5aW2+iW7pG6a5jCy5wPlGx0CJ8s8mX
 BAiOI6Y0pltXUVCb447axaSv61vdjSCeEAt19nwvRAlXOTUmSEubAwYJyTd+8anraWKXZOQ67XV
 7hEz4PF1YP0kInw==
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
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andy.grover@oracle.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:leitao@debian.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-21946-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1FF9654A7C

rds_info_getsockopt() pins the destination user pages with FOLL_WRITE and
the RDS_INFO_* producers memcpy the snapshot into them through
kmap_atomic(). Because that copy goes through the kernel direct map, the
dirty bit on the user PTE is never set, so unpin_user_pages() releases the
pages without marking them dirty. A file-backed destination page can then
be reclaimed without writeback, silently discarding the copied data.

Use unpin_user_pages_dirty_lock() with make_dirty=true so the modified
pages are marked dirty before they are unpinned.

Fixes: a8c879a7ee98 ("RDS: Info and stats")
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

---
base-commit: 9772589b57e44aedc240211c5c3f7a684a034d3a
change-id: 20260608-rds_fix-92d6c7f04fe2

Best regards,
-- 
Breno Leitao <leitao@debian.org>


