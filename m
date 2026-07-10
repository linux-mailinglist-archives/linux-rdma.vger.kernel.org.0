Return-Path: <linux-rdma+bounces-22981-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5tPuF4hIUGpVwAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22981-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 03:19:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D447367EF
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 03:19:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=khSezX9m;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22981-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22981-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4813E3024165
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 01:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50882E54AA;
	Fri, 10 Jul 2026 01:18:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C03033E1
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 01:18:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783646311; cv=none; b=YUSz3Z9vXZrw9tLuKH8/5dzQNKrAz0zYIlNFVAO4BncAFZuKzucBousQEWZpfSMMLi7egnyI63iHcQ1zQjovuoQ1wO4Gx7GJWNqmgPxxyCZ/sXSNR+U4YchzHuIwKdTt1HGvod8+vqb6XcGbl4EhMEKjA0BWdV2zQWPe89nC/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783646311; c=relaxed/simple;
	bh=4oU5vwBqC2s/OF/BgDvlhZIxT9V5eYNC6nP5Ld7hIpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoJhKc/Z2r08MVJc2uRVW9gkOce+2UBA6G750un+IkQ6QbDWYJV4q9/LqWxElnyB2nozU5HUKf9JqwP89N0Z07aCK81u2MS27X8o71JgRvCB6B7qCyV39dnt3LojcwVaFHSB6AerlKm953td2JsElTOvrt3kP3eM4dgRY38YwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=khSezX9m; arc=none smtp.client-ip=91.218.175.179
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783646305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0mFihgDhXIZEpH6Gz5fyyFppsNsRX070ZVmoxYxoXc=;
	b=khSezX9mxT1dvLQrVF/nfpINDSPPZ+noeph3jah3gfEfin+kveWaON0pZ21M89l59Km9/x
	sXQSqw/8SMO46YwETViqU6A3wvkzPi0FZcQjvRQ1lMk/8ECXJlMqlJwx/PP8SCLBpNoukh
	bRPVwI/ooCrz41IOtNWV8zY/6066m9I=
From: Tao Cui <cui.tao@linux.dev>
To: dsahern@kernel.org,
	leonro@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn
Subject: [PATCH iproute2-next v5 2/2] rdma: display resource limits in curr/max format
Date: Fri, 10 Jul 2026 09:17:59 +0800
Message-ID: <20260710011759.378893-3-cui.tao@linux.dev>
In-Reply-To: <20260710011759.378893-1-cui.tao@linux.dev>
References: <20260710011759.378893-1-cui.tao@linux.dev>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22981-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:cui.tao@linux.dev,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3D447367EF

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
 rdma/res.c   | 21 ++++++++++++++++++++-
 rdma/utils.c |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

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


