Return-Path: <linux-rdma+bounces-19878-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBosGsEo92lLdAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19878-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 12:51:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3E04B52B1
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 12:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AC1F3008D07
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 10:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F69289367;
	Sun,  3 May 2026 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qc5833WV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C01239FD4
	for <linux-rdma@vger.kernel.org>; Sun,  3 May 2026 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777805500; cv=none; b=G1kvis2KEL3CisBQrD3DH9nT5o3mtpC6I4T+3zCcT1MHOdh95ek0GEXasjTjn2ADRKLTsp5mmX1NJ5mS2weI8W0nSv2WPIxpkXT4iMc5sV+mTkEunYKY3S0ZUzIhAxaPhsqe7+7DUyUTEawf3h5FhXezepKperxPMIWPg4mPkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777805500; c=relaxed/simple;
	bh=ebQ5pJnjeVOOmyegc8sE30bbLmSEDfksjekArMGx3Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHWbvRZBzLWfVt7jTsbhMrNBogvyg68jVQHvPnAbOHwsgTY89rdmLH4DGKuxH8/T1inp0FRqkt9GfQoVUDj7C5X9YaOAAXgnZVRyiSmEnxS7J7/+ZMCdhTxgyrf3yqh5pblSTMEPXbp7/c3DJ4Um7Jr4FQTKsci/zbYtF+K9Xj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qc5833WV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so1283778b3a.0
        for <linux-rdma@vger.kernel.org>; Sun, 03 May 2026 03:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777805498; x=1778410298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/NvlMTCImyNEl4xNArV1+Dv1U/3HZRUjh14CvseZ8Po=;
        b=qc5833WV4CgWI2+/zwcGE1qT6uiEi9G7ORkm8BV85tSY3P9GRz4eP7U2Cv45m5NSTk
         0hkHQ5cYL9dQ0aErjUSovwh8+UUAfEW4hK/cTMzRQtLPLTOP+n+D2kHg4IVjiZYacazZ
         /OSwzw+ZIdxn95HXtrwnLX+kpDLQGuFVEnUdVv57IuCtDQ8FY6Y93OhIUfys6qugg8of
         /3jZe5AW0i9MJC6e98QgiPap1LdtSi0heTrvqIjpnxkobJRaAO4fnpFAY6bvfwHAHqkM
         MXvWlW4Axb/7kDMGymXFNLjHrAlTopov1ayNw/HV4p8ckX9Z9F2eP42RaQOWsjyylJcM
         wlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777805498; x=1778410298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NvlMTCImyNEl4xNArV1+Dv1U/3HZRUjh14CvseZ8Po=;
        b=la5FaJysL36DokvTUyTFCkxvwco9bN4lAx/u23VmoZ6fLGvyJsjtdROgmwQCEGi5t/
         ZNTxMbNJ2NyiDZMhUOiyw8wbS/YeaROj5/98JNQnFpUr0wapSyXv8lshrKucrlSzeTXi
         kws0k0JZ2n/JkYyqS0DtCEj66GJUzMj/f6LGztczmthn/IdL9MAwJku7545tUOveo6XU
         dVjKvAzDkHwXN+1/yYEqu0pGRA07PMtENNdRbKeQYBWntYKIbfOxzTMbuZuj2d4weZOy
         H0RMZjt0dR1jIRiA9j+nIhroD6rNoiutmLsax2JNghe1aCozZNYeOGdOrfPFgcy+/KEP
         Jzkg==
X-Forwarded-Encrypted: i=1; AFNElJ+ULtclMe8TyL2HFFo1RU2TK04oP9qWZX99GmZ03cBIw0XbpB445j+nwlNKLZgAxb849exAJ36o2Aja@vger.kernel.org
X-Gm-Message-State: AOJu0YwGofA9b9IILNWOWMPi9fgRiDAUK1J+4omORqLOm+nezqT2lG73
	au9zAW4/Jyyy+HqNqFJTIBfucap/x6lhYVhlCh7VRED0jbEqeD3bpdix
X-Gm-Gg: AeBDieuek8kEEtUPTteql9/ERrkeTzlWmgzx7MuSOJr7XSpSaeD2rvXANOY2TBQrR1k
	HdXURDyTfSleGQPzryIpz7aTiJLuSwSDxv9YCMa14moM7/IasDckcBcQAZVwnzXVFaCj9FlEFTS
	bC4CkNRhc9A6cfvVYBaBr9Barmr6UpW7xk14qo5Az3GkdbzrGbT/3weaUgFRSU9QLogJ5F5yeJn
	NfX2zKaLo+3jHV+ttlx+vjBjzSV8Bqgop73hBqPHPSFMqzpzioE772KB1W6BhtuRQlFYzKLX33U
	ym5cOcstuEHi1AmQ+C89KSo/Po9dsPeWBvVUGUNwiFKgFJqP0+ztOdjP/jmUY0RxoEYYdU/dMm6
	USUV2BldeLNmKs8Ghy2TWMCGOUqyMEhpdSceoRHsRjTEiuHx9TQqAYE9b7KMVTN1xSeaUVR6cbT
	6/9sM5dzzvoy9OSbOpoMZdvtIFrLS7hL3HB6jjq691m2QWV1VhCRfm/uw=
X-Received: by 2002:a05:6a00:802:b0:836:bff4:fa5c with SMTP id d2e1a72fcca58-836bff50279mr589688b3a.45.1777805498396;
        Sun, 03 May 2026 03:51:38 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([115.99.189.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8353f8b0228sm2840114b3a.15.2026.05.03.03.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 03:51:37 -0700 (PDT)
From: "shaikh.kamal" <shaikhkamal2012@gmail.com>
To: "shaikh.kamal" <shaikhkamal2012@gmail.com>,
	Roland Dreier <rolandd@cisco.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com
Subject: [PATCH] RDMA/ucma: Fix use-after-free in ucma_create_uevent
Date: Sun,  3 May 2026 16:21:25 +0530
Message-ID: <20260503105125.16368-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD3E04B52B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cisco.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19878-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaikhkamal2012@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,a6ffe86390c8a6afc818];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email]

ucma_create_uevent() dereferences event->param.ud.private_data
as a struct ucma_multicast for multicast events. However,
this pointer may refer to memory that has already been freed,
leading to a use-after-free.

Fix this by avoiding dereferencing private_data for multicast
events and instead using ctx for uid and id, which has a
well-defined lifetime.

Tested by running the reproducer under KASAN with slub_debug
enabled for several hours with no crashes observed.

Reported-by: syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
Fixes: c8f6a362bf3e ("RDMA/cma: Add multicast communication support")

Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
---
 drivers/infiniband/core/ucma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 6e700b974033..8eef10352af7 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -270,10 +270,12 @@ static struct ucma_event *ucma_create_uevent(struct ucma_context *ctx,
 	switch (event->event) {
 	case RDMA_CM_EVENT_MULTICAST_JOIN:
 	case RDMA_CM_EVENT_MULTICAST_ERROR:
-		uevent->mc = (struct ucma_multicast *)
-			     event->param.ud.private_data;
-		uevent->resp.uid = uevent->mc->uid;
-		uevent->resp.id = uevent->mc->id;
+		/*
+		 * event->param.ud.private_data may point to a ucma_multicast
+		 * that has already been freed, so use ctx instead.
+		 */
+		uevent->resp.uid = ctx->uid;
+		uevent->resp.id = ctx->id;
 		break;
 	default:
 		uevent->resp.uid = ctx->uid;
-- 
2.43.0


