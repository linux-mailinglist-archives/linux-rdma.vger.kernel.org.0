Return-Path: <linux-rdma+bounces-22601-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1pskIhnpQ2rHlQoAu9opvQ
	(envelope-from <linux-rdma+bounces-22601-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 18:04:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D716E63D1
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 18:04:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=TMEzVclt;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22601-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22601-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8550F30FC032
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 15:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572B43546F2;
	Tue, 30 Jun 2026 15:55:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40BD3469E7
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 15:55:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834909; cv=none; b=JmKH2n9NskXkwazgqbDnOGJ5z9fy82ZKSWUiHsJt/XiTpuyjMIeNsYRpMdbQGY7VIxtRAVnCPxKfrOhTrBOIX4Y6ubq0+Oyzd5eWiLbPjAiAlVdb+1GxkTQyUMrYgR6WIlTR+lme9Ps2W3nIKIA/2qksltcqDY8hwj7OgxUY/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834909; c=relaxed/simple;
	bh=hpE1qd60nSvYqbT58JQmyFCtsPJovKEQNy9fFOTzjco=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GO85KXk8wnWdVub1OYlzNHdpaSYiRQE9H0ihPkugEmw8Gn+YwVp8hZLAfyEPC3AVeFsK+SEsKRMdhfnEBhb6mlCk0nMDEdrkYLzbU80f4jOAVACJqcQWcXa+M1gfCZcyon5RND09tflYc5Hrwavz8pdN9YGWFZKvGv40liXoyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TMEzVclt; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-91931144870so1020368285a.1
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 08:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782834907; x=1783439707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NHDCiOLfLa6C7sUWe34+IV/lFLM2TnuwmY4WSN2nh5E=;
        b=TMEzVcltRWnp5NzyCBGhyMM1QNgPs9r/hYpVz9gtuIZceYDOqZZiWkue5dh6LdVICr
         HJrHfkZ9IhbXXnFktq+hVMtoJPTbbuUeQRcvmK0zDyqZbe4mV2pw7qo/pMl4rwJy6QqE
         XENsXyzQE02LdRXtoiwtredPnzd1Y5ArUlLCqXOlHTPiBL6fa4EzQ8RKHUGwl4jrIhH+
         DSCzhTEo25FQo8N8XUf49TEPbCNZCvj67KeBpfIP27IsEKT5uC5xhKDnFyUa5LXqNffW
         lIZtGdVNiP5CkxXtq1hat/IlG8z+cEbjAxUNM1avgRLRP1a0vK8x7DK2Q7gNf1ogR5yZ
         M98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834907; x=1783439707;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHDCiOLfLa6C7sUWe34+IV/lFLM2TnuwmY4WSN2nh5E=;
        b=Ge7s2N5Wec8y9baKWd3ek5qeJBhTtS9tyW/M2SqzwkW1pvo7V1FqFGEd0w+tFd2vXu
         Yfr/c1Ra2FsFoauf73gZn/owVXRqhgCEcSAzSOWU1MQTqRIQO6vC509aGfGSXHfq4sox
         FzG6VT7uvkj5SDJFAo33NTLnkkL4X2BKQOGbshIpLlrskDhbAfVZoZxGkGamdjvd2SM1
         igAIrVVXQ6uh9u6jh+iECdxQnzXi+O1dVObB0rybQmm30eqTQhuyKDrTEsvkRZArpvCa
         F4vnkcmjVZWPI42uAk6qQpTvQowCa7ibuGVKt3sB8XtdX9TA5W5AHcnvn1W7ywioIHdX
         gYyQ==
X-Gm-Message-State: AOJu0YzKd0TGA+1pe0d3YNCPTjVO8zFrnUEaVF5obrXoHIoD/HoZDb3W
	jRQutOx0V+UMgh/mfcqhlcDXNyvteSSgdLdpPZj/6q1l0MFHl8BPJxrXaOmaasW3Z1MLGENEeR9
	JN2x/RmEWhA==
X-Received: from qknvm6.prod.google.com ([2002:a05:620a:7186:b0:92e:6dfa:48a6])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:a190:20b0:92e:6e55:cc66
 with SMTP id af79cd13be357-92e6e55e500mr121127185a.47.1782834906470; Tue, 30
 Jun 2026 08:55:06 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:55:05 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630155505.1707193-1-jmoroni@google.com>
Subject: [PATCH] RDMA/mthca: Check for null udata during reg_user_mr
From: Jacob Moroni <jmoroni@google.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22601-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20D716E63D1

The mthca driver was unconditionally checking udata->inlen,
but udata could be null if the user intentionally triggers
the UVERBS_METHOD_REG_MR ioctl. Prevent the potential null
deref by adding a check.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/mthca/mthca_provider.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index f90f67afc8f..6005ed40665 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -863,6 +863,9 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (!udata)
+		return ERR_PTR(-EINVAL);
+
 	if (udata->inlen < sizeof ucmd) {
 		if (!context->reg_mr_warned) {
 			mthca_warn(dev, "Process '%s' did not pass in MR attrs.\n",
-- 
2.55.0.rc0.799.gd6f94ed593-goog


