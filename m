Return-Path: <linux-rdma+bounces-21431-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOrIFqRGGGr5iAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21431-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 15:44:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A62955F2EB5
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 15:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20FD30207D4
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 13:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682C3F4DE5;
	Thu, 28 May 2026 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he/bhHKb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6F93E0758
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975496; cv=none; b=tuhoCpUdcTo2wNej+Zcr2LmK0f6cD+giGaY1kzhskdUU6Ffir4d6YoZSFQZj+tNX4X6qcAS6/QPK62O5efLieP5sqIFmBFG24CngJYKNRDXC/P46gnn/zw3OLU2NJIinBi0A9DwuQpeJxwc38+umySkzBIxhHkTdopCEvfRWL+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975496; c=relaxed/simple;
	bh=1f9GNGnxqHYMYTUVEWPshCybn7EU+s4/PHdaM2twDos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOMHKFBDg4+wzWx3Tgj6+Pkr+JRTo8YfApmq6FAoOz9vCsxc1UtWE+DWwsLmIQLBiXAjQgWZi9d4Ro+4FPnev+lQuZVW9gPOJr4xezny7+KEWG2FlN1zXPnakG5b0Ympw+71Pt9QA2lzsqWn9r3iyxnFYvvLHdNBebhh963Omq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=he/bhHKb; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-90fbf21d9d3so1910095085a.1
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779975494; x=1780580294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lf5y1emthCXYhd+dZebItKHK8eGGD+WMbJr9hkUNC5Q=;
        b=he/bhHKb52dlzIKSS/qoQnMCp+bIV/P6Kfd/DutyqA2qCtkbfOdelWxywSey4I70nq
         b8GbujTw0L3s3z0qvJxw8qrEQz6IckPW3DqtR7y2IKVob23NzvmpH+MYwZYFCC9i36TA
         FchpjhonFch6XtKzByNNhgfdv0yOIWKoUA7N2qqJK+5sCblF6heRmQXaNLXL/6UvBFlJ
         DClGsS2X9E1vgEkl60drotkh+Y+CcDTNtHGhovlrkA/01kSzvx1/T/xCh9rr3rDMPThO
         2Q/alQPRprvJFdDK30/y3YfsD1rpWffBn8k94H7cvON73ijtDEwJUHvZxZfHbqX5EZ1z
         qbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975494; x=1780580294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lf5y1emthCXYhd+dZebItKHK8eGGD+WMbJr9hkUNC5Q=;
        b=S+3NGJbEXa4J4UsStDhVhfiMhUhxmQi9AllTfgrrgJOIG6LVe8AbPWwMtSamALbHSI
         hdaedz5YwBMaDbrSKec2+3cxnmsOMaeGCfQmFnfRrsiFGfG6fLcXubDlbpiCqhfrEdB6
         a1mdT47XQMUqHVqopjztGEv8CsfBK7uvl9G6iysok5zEd1LAMOG6zVuqHRJwl19VF1bo
         8FgneKNawqGkCw9vpaDqQWtbCeLN48AijjYBzOoboHbPv+ryADmn8liTq6cIA+Jcm62R
         1+T3pdMq0TQySFIwk5/3pQjCJaseucp7YI+/9GLz0o6XGKLUKwY8lf7i8C9XdBkSwRuE
         bpjw==
X-Gm-Message-State: AOJu0YzGXNHYP2zEXghNOcNJdqhs8kLcXW8WC8eAgLIGVqgY1QKLjtuq
	1rnR+WPGkyEEbUYucPaiQFllNwcx6+n7ponI0CqnEXn9QWdvEZ3/CNWV
X-Gm-Gg: Acq92OEEvY5gffQeBsQbVSCz8DWALvJ8M+neyn/JpMQ88LbNVxhIVVtkt8qE4g0ZsZh
	06LkuzEbwYwhQ65P1UPr0Y9CykQDbLpkYd/7w0+rxRWcpTxhfFcOv9BcxUN0sIGGBFtElRKWIgA
	4kJz2JaCiFXnhX/rgU9ps4KXMP9dxZCDw7jeCSkTFuLYFPLTbvAJVn8yKIBwgKIqkv/uvPvj3Sz
	mBBu71vjzgavzKBzKJ9Un0c+ruKij6hrPvHDYHmYOz5U/kOJ8YMsXgius1yy90YZvW0vDt7ACLH
	dPlmSCyKW9jqp++XKgVJea7Do1f/8hZYWkOCVfaZk2zJAe+caKn7OwAwVu2efIMoVsXbkWbPZ99
	Vk6a4StQYxpXxg+l0y771TfceFEqTG1OHbpYOfu6tK45cOxTYeiq1I5G0dudVZNzBItWmGds+bd
	ca1YcYaxW5JdYbfljTdWauAGG8ochlCFaJtvJ3uMb4hS2hsvyufZotXTJbZSYaVvKuIc4wJFPMi
	34uGRGOxjRjSry3QTDJST5QHt3FY5DNNdgRSPgsaQ==
X-Received: by 2002:a05:620a:4151:b0:908:8470:4e98 with SMTP id af79cd13be357-914b496b6ffmr3627640685a.30.1779975494312;
        Thu, 28 May 2026 06:38:14 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87d1a90sm877659585a.27.2026.05.28.06.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:38:13 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Haakon Bugge <haakon.bugge@oracle.com>,
	Mark Haywood <mark.haywood@oracle.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ibacm: Check for source space in resolve requests
Date: Thu, 28 May 2026 09:37:53 -0400
Message-ID: <20260528133753.3952087-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21431-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A62955F2EB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If a resolve request omits the source address, acm_svr_verify_resolve()
uses the next endpoint slot as a scratch source address. A full request
can already contain all eight endpoint slots. In that case there is no
scratch slot, and the current code writes past the fixed message buffer.

Reject a source-less request when there is no endpoint slot left for the
selected source address.

Fixes: 5cf79fbad67a ("ibacm: resolve source address if not given")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 ibacm/src/acm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ibacm/src/acm.c b/ibacm/src/acm.c
index f13617c40..125b660e0 100644
--- a/ibacm/src/acm.c
+++ b/ibacm/src/acm.c
@@ -1044,6 +1044,10 @@ static uint8_t acm_svr_verify_resolve(struct acm_msg *msg)
 	}
 
 	if (msg->hdr.src_out) {
+		if (i >= ACM_MSG_DATA_LENGTH / ACM_MSG_EP_LENGTH) {
+			acm_log(0, "ERROR - no room for source address\n");
+			return ACM_STATUS_EINVAL;
+		}
 		msg->hdr.src_index = i;
 		memset(&msg->resolve_data[i], 0, sizeof(struct acm_ep_addr_data));
 	}
-- 
2.53.0


