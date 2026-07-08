Return-Path: <linux-rdma+bounces-22901-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gq/9JahTTmoSKwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22901-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 15:42:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54874726E5A
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 15:42:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=IyRbqlxO;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22901-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22901-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83054303048F
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3DA3806B0;
	Wed,  8 Jul 2026 13:41:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7224CB5B
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2026 13:41:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518078; cv=none; b=k5RT4lTi50iTjxm1195dygc4XpDXhHCBSFme8jUl1CIi1yAyZXmiI/uR2dkCBDpHD8M7rjL1hqhkjH2smC0Oqppm+GPawRx+AmjuJZhh4yzzdOdse/6OgMzg85Y2hrR8xD0R4PH70g3yVrZSL5p0GaJWWD2Q3h4ARS5XkOVRjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518078; c=relaxed/simple;
	bh=yahR6VV4oId4ke2EcTPSLUBVRa8Wq4PuIKySjS6Aa6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=duJi7t9S2sv6wBjzExpKuB2AXr5xthswvXRuLbayF+BtEL92PsdI9TKq5SqvdN0YonYt0OAlmoTAPPyOuxfDa8LYvX7/82VZAIqHJs6R8q9RxQ6JRm2UkciUMh15NKIMa70tOtE+9vlZYaQJJbu8uZqvIX7DCGV75qXwa/UpbrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IyRbqlxO; arc=none smtp.client-ip=91.218.175.174
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783518065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JIjKdwSo1SvNGAxUxkPye4smNHCYoCTZEiX1YoURXjw=;
	b=IyRbqlxOYa1pYEWPtoUM+QP3xxmtOIfHAB2guWgAqjCxjDOpmKok+2sNtNtWv9vr2p1ZCP
	r6Rlpz7EaxDyis5GD+KjvHlCfSF+3eHm3V9d1Uc52EYfkr1YcfpOtpTb2sJc4rLhxXiJ6w
	rtsSdh0r4aqIPO46mEDWvQGtRIXgVbM=
From: Tao Cui <cui.tao@linux.dev>
To: dsahern@kernel.org,
	leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn
Subject: [PATCH iproute2-next v4] rdma: display resource limits in curr/max format
Date: Wed,  8 Jul 2026 21:40:03 +0800
Message-ID: <20260708134003.85505-1-cui.tao@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22901-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:cui.tao@linux.dev,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54874726E5A

From: Tao Cui <cuitao@kylinos.cn>

Parse the new RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX netlink attribute
to show resource limits alongside current counts in curr/max format:

  Before: 0: mlx5_0: qp 123  cq 45  mr 200  pd 10
  After:  0: mlx5_0: qp 123/131072  cq 45/65536  mr 200/1000000  pd 10/32768

JSON output provides both current and max fields per resource type
(e.g. "qp": 123, "qp-max": 131072). Backward compatible: no output
change when kernel lacks the new attribute.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Link: https://lore.kernel.org/all/20260615003646.168704-1-cui.tao@linux.dev/
---
Changes in v4:
- Add Link to the kernel patch that introduces the new uapi attribute.
---
 rdma/include/uapi/rdma/rdma_netlink.h |  5 +++++
 rdma/res.c                            | 21 ++++++++++++++++++++-
 rdma/utils.c                          |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index 4356ec4a..e5b8b065 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
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
diff --git a/rdma/res.c b/rdma/res.c
index 062f0007..046935e2 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -55,7 +55,26 @@ static int res_print_summary(struct nlattr **tb)
 
 		name = mnl_attr_get_str(nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_NAME]);
 		curr = mnl_attr_get_u64(nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
-		res_print_u64(name, curr, nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
+		if (nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX]) {
+			uint64_t max;
+			char max_name[64];
+
+			max = mnl_attr_get_u64(
+				nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX]);
+			snprintf(max_name, sizeof(max_name), "%s-max", name);
+			print_u64(PRINT_JSON, name, NULL, curr);
+			print_u64(PRINT_JSON, max_name, NULL, max);
+			if (!is_json_context()) {
+				char buf[64];
+
+				snprintf(buf, sizeof(buf), "%s %" PRIu64 "/%" PRIu64 " ",
+					 name, curr, max);
+				pr_out("%s", buf);
+			}
+		} else {
+			res_print_u64(name, curr,
+				      nla_line[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_CURR]);
+		}
 	}
 	return 0;
 }
diff --git a/rdma/utils.c b/rdma/utils.c
index 87003b2c..90ea1c55 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -480,6 +480,7 @@ static const enum mnl_attr_data_type nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_EVENT_TYPE] = MNL_TYPE_U8,
 	[RDMA_NLDEV_SYS_ATTR_MONITOR_MODE] = MNL_TYPE_U8,
 	[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED] = MNL_TYPE_U8,
+	[RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX] = MNL_TYPE_U64,
 };
 
 static int rd_attr_check(const struct nlattr *attr, int *typep)
-- 
2.43.0


