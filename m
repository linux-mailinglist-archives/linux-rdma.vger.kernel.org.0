Return-Path: <linux-rdma+bounces-22219-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OzaoKzRJL2pr+AQAu9opvQ
	(envelope-from <linux-rdma+bounces-22219-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 02:37:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A763682A28
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 02:37:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=hJ6z6a+4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22219-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22219-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CBFB300139C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 00:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB3D194C98;
	Mon, 15 Jun 2026 00:37:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA905165F16
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 00:37:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483823; cv=none; b=uLZAdB8QjmMX/QPrrf/WkKCyRKpeHpbCT87DWOZAFjhbg4b6/KNcREZa9tVh1IuhOyqnez2WiybKoZoBaghVvYo1NR7XKOF7S8VdnEkq+5I+N9o9ciMah+LUQIrl9r1+5MIkJKozHFNpNlevgUddLTI+MssVyQ9J/3REqgGZZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483823; c=relaxed/simple;
	bh=uYpJx2U0vCdNb1rff1Yo0l4w3sT0stEPBI/sg3KzqLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEALshV/avAMDl0gTYEdCKJytxYRMWydA+ysRBd06h6YfsdNI7ww3L30SIs0IKQS16sm5cwPYFBH625k1tu5OOtYIpiBRYlSd69M3IL+eudpg7FdwWJOrE8w/wJuFe/xoTTW/r2YBBKrhl3bUpRwa4gHUya4IKmkOGrqW+q7Xag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hJ6z6a+4; arc=none smtp.client-ip=91.218.175.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781483819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NZ9wFol78sbVBYkXFd1/n6K3XKJJPJ5Zf/dJVilJYEg=;
	b=hJ6z6a+4P01QxGuSd+tppFDjZk4IbzLq3vG8nh+4ESAoJyqLxwT2BhwgVHkPtb7eXyyNIb
	1KoCiRmqqmCmkSiQiVQFoV/ZvuUhvW7jQYv3RdL/KVa9SV5zvq5MUlLuw6pQZ23WN3qpcv
	doM6PSC3hPjnX+nQ6HsSxZ4FHdqj+KE=
From: Tao Cui <cui.tao@linux.dev>
To: leon@kernel.org,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next v3] RDMA/nldev: add resource summary max values for usage display
Date: Mon, 15 Jun 2026 08:36:46 +0800
Message-ID: <20260615003646.168704-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22219-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A763682A28

From: Tao Cui <cuitao@kylinos.cn>

Add RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX netlink attribute to expose
device resource limits (max_qp, max_cq, max_mr, max_pd, max_srq) in
the resource summary alongside the existing current count. This allows
userspace tools like iproute2's rdma to display resource usage in
curr/max format.

Expected output from "rdma resource show":
  Before: 0: mlx5_0: qp 123  cq 45  mr 200  pd 10
  After:  0: mlx5_0: qp 123/131072  cq 45/65536  mr 200/1000000  pd 10/32768

In JSON output, both "curr" and "max" fields will be provided so that
scripts can compute percentages if needed.

The new attribute is optional and backward compatible - old userspace
tools will simply ignore it.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>

--
Changes in v3:
- Omit RES_SUMMARY_ENTRY_MAX for resources without an upper bound (cm_id,
  ctx) rather than advertising 0, and leave rendering to userspace.
---
 drivers/infiniband/core/nldev.c  | 29 ++++++++++++++++++++++++++---
 include/uapi/rdma/rdma_netlink.h |  5 +++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 02a0a9c0a4a6..bf6ce2b8db6a 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -188,6 +188,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY] = { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX]	= { .type = NLA_U64 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -413,7 +414,7 @@ static int fill_port_info(struct sk_buff *msg,
 }
 
 static int fill_res_info_entry(struct sk_buff *msg,
-			       const char *name, u64 curr)
+			       const char *name, u64 curr, u64 max)
 {
 	struct nlattr *entry_attr;
 
@@ -427,6 +428,9 @@ static int fill_res_info_entry(struct sk_buff *msg,
 	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR, curr,
 			      RDMA_NLDEV_ATTR_PAD))
 		goto err;
+	if (max && nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX, max,
+			      RDMA_NLDEV_ATTR_PAD))
+		goto err;
 
 	nla_nest_end(msg, entry_attr);
 	return 0;
@@ -450,7 +454,7 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
 	};
 
 	struct nlattr *table_attr;
-	int ret, i, curr;
+	int ret, i, curr, max = 0;
 
 	if (fill_nldev_handle(msg, device))
 		return -EMSGSIZE;
@@ -463,7 +467,26 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
 		if (!names[i])
 			continue;
 		curr = rdma_restrack_count(device, i, show_details);
-		ret = fill_res_info_entry(msg, names[i], curr);
+		switch (i) {
+		case RDMA_RESTRACK_QP:
+			max = device->attrs.max_qp;
+			break;
+		case RDMA_RESTRACK_CQ:
+			max = device->attrs.max_cq;
+			break;
+		case RDMA_RESTRACK_MR:
+			max = device->attrs.max_mr;
+			break;
+		case RDMA_RESTRACK_PD:
+			max = device->attrs.max_pd;
+			break;
+		case RDMA_RESTRACK_SRQ:
+			max = device->attrs.max_srq;
+			break;
+		default:
+			max = 0;
+		}
+		ret = fill_res_info_entry(msg, names[i], curr, max);
 		if (ret)
 			goto err;
 	}
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index aac9782ddc09..3af946ecbac3 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -604,6 +604,11 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
 
+	/*
+	 * Resource summary entry maximum value.
+	 */
+	RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX,		/* u64 */
+
 	/*
 	 * Always the end
 	 */
-- 
2.43.0


