Return-Path: <linux-rdma+bounces-17578-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOvgEaaPqml0TQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17578-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 09:26:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB3221D0BD
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 09:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC893022F9F
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 08:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C92836AF;
	Fri,  6 Mar 2026 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l3UIuYv1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9C378D70
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785554; cv=none; b=bd9hAkPdJ4bFu+WDaBZ9gQyrJaD/uuuFeE2+XZuI8ClllR4lNHgL+iILY7NTKlIbclkIcHTokLBxw3w4reKy5FnwUJbHe0gpHtzGNGM54pFk/0Nbucw0a+GBwVZE15nNQTrgaW2IIOE3UDSc9TBfcTQfoQWgtSsMBYxxMLSqr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785554; c=relaxed/simple;
	bh=vgs6OvFfhn6LgRJBXvD8e7DncJV6JvlCX+BURozjQ2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pF8gfPK5O9bj8NhwN1ZfG5oJiiXpWw4MXebUCnWxQwXctGUthI3JPmUuhOohrFzmm9HEB/Un39RdjAWqqc6vWPQJsDNCgdPtOHBAVx81JqLU2xukjH9ADfErc8rjwA+hD13nzwdlZjj3OK2lESVo8M/oTwCQtP8OvcKIOlXRHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l3UIuYv1; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772785551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUMKZd8SUAnYq8W0a6TH01hT+Tx21DpSkFW2LXP37DM=;
	b=l3UIuYv106BuXj3MFtGh6JFLrKZW0zC22amxdMBfrKGuEkXyUSeccKXZnLRDraxfRGOwPs
	Llu1WysskJEwfJaRU64HoiNUIzBWTgWl+pekS504688Xn6HO9In9FuU0jGijc737bqnXPc
	X/aK5ivRtwZHZFtJJk3urmdQ5drvVY4=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	yanjun.zhu@linux.dev,
	dsahern@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/4] RDMA/nldev: Add dellink function pointer
Date: Fri,  6 Mar 2026 00:24:50 -0800
Message-ID: <20260306082452.1822-3-yanjun.zhu@linux.dev>
In-Reply-To: <20260306082452.1822-1-yanjun.zhu@linux.dev>
References: <20260306082452.1822-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: BFB3221D0BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17578-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The newlink function pointer is added. And the sock listening on port 4791
is added in the newlink function. So the dellink function is needed to
remove the sock.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/core/nldev.c | 6 ++++++
 include/rdma/rdma_netlink.h     | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 2220a2dfab24..48684930660a 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1824,6 +1824,12 @@ static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
+	if (device->link_ops) {
+		err = device->link_ops->dellink(device);
+		if (err)
+			return err;
+	}
+
 	ib_unregister_device_and_put(device);
 	return 0;
 }
diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
index 326deaf56d5d..2fd1358ea57d 100644
--- a/include/rdma/rdma_netlink.h
+++ b/include/rdma/rdma_netlink.h
@@ -5,6 +5,7 @@
 
 #include <linux/netlink.h>
 #include <uapi/rdma/rdma_netlink.h>
+#include <rdma/ib_verbs.h>
 
 struct ib_device;
 
@@ -126,6 +127,7 @@ struct rdma_link_ops {
 	struct list_head list;
 	const char *type;
 	int (*newlink)(const char *ibdev_name, struct net_device *ndev);
+	int (*dellink)(struct ib_device *dev);
 };
 
 void rdma_link_register(struct rdma_link_ops *ops);
-- 
2.52.0


