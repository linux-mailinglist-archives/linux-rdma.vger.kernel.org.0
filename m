Return-Path: <linux-rdma+bounces-18134-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF/9JWl3s2mwWgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18134-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 03:33:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 131E927CCBF
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 03:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6326830BAF15
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 02:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E9E33FE15;
	Fri, 13 Mar 2026 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kODeGAVD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8C3093B5
	for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2026 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369082; cv=none; b=Q/7OBwQzc0Hs5g7LDH6pynCJ7qRHhJhcA/uYlEmEh+IlNlBe4leaRALykpdF4U04JlhIxuBlPBw1jD26q2kHqWPpjZ8occ6nrgV+FCd4z0/gic4M2qkIZ0GVNarhRPTkM83AdgR2vrxF9k1t1ObRwi7TFRqRHCgJU4VhdipXiqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369082; c=relaxed/simple;
	bh=MjhzSUnW7QuPXSOSOOjc4YdqOrupO4fp1c1hrWwAQhM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G051QCOg9bCd1HNOYLO9jYvzApa7Re5uMza0i3NT6g+yfopuOjlxwokQ7YCpa1uYYqJghGlTN4e91RqjUTjwXetgeqvYPqI6F4dGzQd0qFH1fg9yRFBJFc4m1OEGchn1l0fnpCbiYMM7wp7/vX6Gantu3YuytguDyPpgrzcLnX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kODeGAVD; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773369079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucuY1kJMi04rn99th+m8qYyAprjnP3jLIkbC8k947eE=;
	b=kODeGAVDq1qAby/oVBpmfUsrvred9po2DNc3QghX80E826g/nsqB3EBazYd+2uz8yJ6Sl9
	W8yGwB1KxNKervRaexnVpWukpUwmMuwmMFa1OHyDEvCzC8H/q1fEjng5VKZS/A6W0blk/B
	+lmpV2IcSp7ZBtZK/5XOzJAIIYuaBqA=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	yanjun.zhu@linux.dev,
	dsahern@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 1/4] RDMA/nldev: Add dellink function pointer
Date: Thu, 12 Mar 2026 19:30:55 -0700
Message-ID: <20260313023058.13020-2-yanjun.zhu@linux.dev>
In-Reply-To: <20260313023058.13020-1-yanjun.zhu@linux.dev>
References: <20260313023058.13020-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,gmail.com,linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18134-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 131E927CCBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a dellink function pointer to rdma_link_ops to
allow drivers to clean up resources created during
newlink.

Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/core/nldev.c | 12 ++++++++++++
 include/rdma/rdma_netlink.h     |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 2220a2dfab24..dbf2eea078e9 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1824,6 +1824,18 @@ static int nldev_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
+	/*
+	 * This path is triggered by the 'rdma link delete' administrative command.
+	 * For Soft-RoCE (RXE), we ensure that transport sockets are closed here.
+	 * Note: iWARP driver does not implement .dellink, so this logic is
+	 * implicitly scoped to the driver supporting dynamic link deletion like RXE.
+	 */
+	if (device->link_ops && device->link_ops->dellink) {
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


