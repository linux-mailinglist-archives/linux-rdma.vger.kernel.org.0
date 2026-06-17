Return-Path: <linux-rdma+bounces-22309-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UZOlMx+FMmqy1QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22309-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 13:29:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 346CB699168
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 13:29:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=impsSVEH;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22309-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22309-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D7FE3222825
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 11:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54893E0092;
	Wed, 17 Jun 2026 11:21:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6E3DD85A
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 11:21:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695274; cv=none; b=YevH5bjZsN6o3rrUV8nUw7Bm3Dyb2SSyL4RXcxFBBi4j0g5HlTB1OZYssIYLsLQ6r6k4IEcxZli8XbZO0sRU4GWvCQZOeQxbGfz0PiQ5e1s8s4eRsJNRjnV2pI/BEK+lyfvuSv60hDh6Ob0awA8wOwy1WPm95AfliKfMtrnx95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695274; c=relaxed/simple;
	bh=xSvqGI2aK/ZudkDmdvMFNYy1XEYLlAlf3Pn7qlQVz3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NzRrndimYnfa8lEZpW2sL1bLvimWmdIRkIu1LZiM63YGL9WM3/98IQFBgqNGRY8r2hkF4ak49ua0hDQEOrDQbaB4+DG6EXsCkeHdokszfrpehmRtlBgf0YAZqO0MgEBXQA7gglFkZN0RQCNwF40V/KEkI+FEylAEnJLvI+nTagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=impsSVEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63C6BC2BCB4;
	Wed, 17 Jun 2026 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781695274;
	bh=xSvqGI2aK/ZudkDmdvMFNYy1XEYLlAlf3Pn7qlQVz3M=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=impsSVEHbzPrbnxgMYGsc3TTMxeCBAAEX9iso1wrQhOiNgzI+oxZxxjoAZ0C637BJ
	 mRQYeaFmzlvL6y/BAgks9dY82dcgKjcas34eS/ENjjzO5uZI6/8dpYmCNpCyTyAaml
	 j3/mIqjtuYaznIXZM6ufbYO/C0cz+w7Cu5wX5FE4QaVRXg8MuwARgF2uSmXDKEhsI8
	 CCeW2TcE8swHYyC8djKawU7bfdPQQDARSW2H1LWcF28Mt97JGgNk3Ay1SwXjhvFhhq
	 eo+aQeUnRBEtn97TXnnCnFzRbUcHn5GNG1BolXehuN94maPU7ldjMWa1wtB3lnjGiu
	 KniCNBzHZb9UQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A391CD98E4;
	Wed, 17 Jun 2026 11:21:14 +0000 (UTC)
From: Or Gerlitz via B4 Relay <devnull+ogerlitz.ddn.com@kernel.org>
Date: Wed, 17 Jun 2026 14:21:05 +0300
Subject: [PATCH] RDMA/cma: Fix hardware address comparison length in
 netevent callback
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-fix-cma-ipoib-v1-1-03f869344304@ddn.com>
X-B4-Tracking: v=1; b=H4sIACCDMmoC/x2MQQqAIBAAvxJ7bkGFzPpKdDBbaw+ZKEQg/j3pO
 DAzBTIlpgxzVyDRw5nv0ED2HbjThoOQ98aghNJCyxE9v+guixxv3pC0NZsnOUzeQGtioib8v2W
 t9QNPEWSSXwAAAA==
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Mark Zhang <markzhang@nvidia.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org, 
 Or Gerlitz <ogerlitz@ddn.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781695275; l=1464;
 i=ogerlitz@ddn.com; s=20260617; h=from:subject:message-id;
 bh=Eul/kAmRxSqGsEJ0XdQgVAd1WB0lVIsCRtMGHfKU1no=;
 b=kOS53BKFaY/FyQaD+n3SK5eJq5/rIgdmG6ymtW+l0nEHqFAWXMq9RKIMUiXCOE9ISguq8aGOC
 7ydJIoPU8k+DxMrZoDv+XdHJPD5gEtgKSWwR3LvBLn1q7v4Kcdrk2rO
X-Developer-Key: i=ogerlitz@ddn.com; a=ed25519;
 pk=BoS0g+wKx47O0XreZWOYeg+RkV6n1KWInCJyT9csyic=
X-Endpoint-Received: by B4 Relay for ogerlitz@ddn.com/20260617 with
 auth_id=826
X-Original-From: Or Gerlitz <ogerlitz@ddn.com>
Reply-To: ogerlitz@ddn.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22309-lists,linux-rdma=lfdr.de,ogerlitz.ddn.com];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:markzhang@nvidia.com,m:phaddad@nvidia.com,m:linux-rdma@vger.kernel.org,m:ogerlitz@ddn.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ddn.com:replyto,ddn.com:email,ddn.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[ogerlitz@ddn.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 346CB699168

From: Or Gerlitz <ogerlitz@ddn.com>

The cited commit hardcoded the hardware address comparison len to ETH_ALEN.

This breaks IPoIB, which uses 20-byte addresses. By truncating the
memcmp, the CMA may incorrectly assume the target address is
unchanged and fails to abort the stalled connection.

Fix this by replacing ETH_ALEN with the dynamic neigh->dev->addr_len
to correctly evaluate the full address regardless of the link layer.

Fixes: 925d046e7e52 ("RDMA/core: Add a netevent notifier to cma")
Signed-off-by: Or Gerlitz <ogerlitz@ddn.com>
---
I caught this while reviewing the RoCE netevent callback, 
the patch is compile-tested only..
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 9480d1a51c11..e88d3efb967b 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -5270,7 +5270,7 @@ static int cma_netevent_callback(struct notifier_block *self,
 
 	list_for_each_entry(current_id, &ips_node->id_list, id_list_entry) {
 		if (!memcmp(current_id->id.route.addr.dev_addr.dst_dev_addr,
-			   neigh->ha, ETH_ALEN))
+			   neigh->ha, neigh->dev->addr_len))
 			continue;
 		cma_id_get(current_id);
 		if (!queue_work(cma_wq, &current_id->id.net_work))

---
base-commit: 4b99990cdf9560e8a071640baf19f312e6ae02f4
change-id: 20260617-fix-cma-ipoib-e6a8bfe159f8

Best regards,
-- 
Or Gerlitz <ogerlitz@ddn.com>



