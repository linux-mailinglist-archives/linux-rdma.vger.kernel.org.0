Return-Path: <linux-rdma+bounces-20689-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULKmC9G0BWqeZwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20689-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:41:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3EE5411D5
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52686303A533
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8817039A058;
	Thu, 14 May 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlB2KeMb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6F23D7DC
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778758862; cv=none; b=pg0m4BpToo8QrYDhEi1qmUgXskdcqisyobTNY2NW0Wm9TtBrFJ8MWAl48p0tIb1VvIVYNpew7oknPXVk1eXydt7sIITmf7GxQr1jUTa7umZaEEGlsATumb5rLQEHumJQOGecqjlpGzWX+HzQA80qzqCmeplXuCIca+kavjMURSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778758862; c=relaxed/simple;
	bh=LJr59c/55DJC4Wsxi9rV58L2pCVOazI/rRq+AeCTc9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5sBpIYqSYcVVR6dy0Kcwvj0xkqtGVqsCT8tnhqY5a0eowzuCjxnEo8hdlBjcuBxI3XxoujvUtmxrM2VPCLRsEWYuXt4koForLh/ANo99Th5TFCIWa2kf1OI/MZuOEC2/rtwl1L4uHY4ZzN3zF0r9q9G3Nwdxhf20W+YY1PS/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlB2KeMb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-834f1075805so5481821b3a.2
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778758860; x=1779363660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FckyD5Kv4+O1B9NLxmiPkGiYd0Izvn80A7tr//y55g4=;
        b=VlB2KeMb3xw0jFmkuy5IdF4L911jT7GSSQLDKjuDrbp1qhIb6Gid5ZgV8bNQhAnetV
         d5mjENFIyWDkzwPeB8u9yJwORFwChHhARwLp2y2gYPeNtyfEuDQo5XHL85Y3aHILvXn6
         WVQOQlRZZmuiiSbnLT95oLB58On2qgkAmjf0nld0ylXWhFQ3iW9h4bU3ggtnZX55EBC4
         HtyJzkzonae5awTDDbJKWgl4Im2urq5kPKrv5LsTZhfPN6j6joF3f+ZzK3RCFw9pNEyC
         4mkW4r39scK6TeRRzOz+Xnc38XkQNMvobsIeYrjyEH4NZfKVVrVT8itlSDz0R/bMNA0s
         Qhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778758860; x=1779363660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FckyD5Kv4+O1B9NLxmiPkGiYd0Izvn80A7tr//y55g4=;
        b=oD+QwC7x1Pb15b2HAsdDiPYC+lNmdjKgoRnQlkuE1jGdLkv2OW/w95rnKwXValjTke
         2b2h52O1vVDrH3eA4iGHhdzuqrpUbR3vXssRHEhMUTsMm8vCpHyhi/RXa/BGUVoS8eGe
         rcQfBKqsv/FQOr4lAVL7l8HThlSDAmiaFfzCZqOfQ9bYDw5CfhHGALpQHWBD+/JqMZ+0
         YnaHwrHrhtbVYlL3WwTTF/e9p0XbM6Xi4g88xVY0aT6f8CiCRyfAlFD0b6KR/8HnvZs2
         4je7tQxChcrB5ej29ApdAXuAgsvQilEETeSlziPvqmNXItASpG2pIZSnZVg1UBmlQJxY
         cVmg==
X-Forwarded-Encrypted: i=1; AFNElJ+hfvgAbGYte/L5cIga8yiKQLkcZ/m5tfzjp6M7Gu3njW/YQen/tQN4YquvhA8UqhtxWS9HSZm16610@vger.kernel.org
X-Gm-Message-State: AOJu0YztZREP2bJahxf7VcmmBGCAEKMJKoz4BX+fFB7WyWRw8AkooxbH
	l6HrxbM2IHSZATzQqcMjAjS0DHHsLSTs4AA1W/tmeVuI94S8xyLOzNop
X-Gm-Gg: Acq92OE5Z1PHoudp/8JGXKTFCHeaDliXGkt0a7YdQ14tqTWa9lTMnAO/xD8HKTa5tcN
	zyYIDdTx2cGq3MVlsxfLcFWjrGIESsun17PEfYt5QmMQXYMWimXiRksepAUuaJRazhA01dteIis
	XBFKWkRWtQRuPfkKBMz52TcaDzjsKwWfclgtgxxrFVDvthgm0MdadM8SKVkRZPDqarAAblv1klX
	eEuhO0iOZ7n3gooyOfQEyLdchv8vHWWxXhgDJJd5C9XaTt5+ddE6Hif/HPqUWLjrnXne9GWeF1G
	ckcF7muQTqrHSXBZ9qhRq4JEEWpTbfgaB2VkyWiTTVPxnwB4XGQC8pzvbEkVHQiA6DcPaUUR3ZI
	nVT5nB/Uj71OgFYC9BYiX0xLoj3Izwlge3pYtMiWOQzacF+beMNlB3fK5mzW0J6F1g7M8Kn97Dz
	MmevRnxA==
X-Received: by 2002:a05:6a00:3a1c:b0:83a:4846:90bf with SMTP id d2e1a72fcca58-83f05ae4d10mr7150460b3a.43.1778758860102;
        Thu, 14 May 2026 04:41:00 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7f202sm2415974b3a.43.2026.05.14.04.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:40:59 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Vaishali Thakkar <vaishali.thakkar@ionos.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v3] RDMA/rtrs: Fix use-after-free in path file creation cleanup
Date: Thu, 14 May 2026 19:38:34 +0800
Message-ID: <20260514113834.865530-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F3EE5411D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20689-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In the error path of rtrs_srv_create_path_files(), the sysfs root folders
may already have been created and srv_path->kobj may already have been
initialized. If a later step fails, the cleanup currently calls
kobject_put(&srv_path->kobj) before
rtrs_srv_destroy_once_sysfs_root_folders(srv_path).

kobject_put() may drop the last reference to srv_path->kobj and invoke the
release callback, rtrs_srv_release(), which frees srv_path. The following
call to rtrs_srv_destroy_once_sysfs_root_folders(srv_path) then
dereferences srv_path internally to access srv_path->srv, resulting in a
use-after-free.

This failure path is reached before rtrs_srv_create_path_files() returns
success, so the successful-path lifetime handling is not involved.

Fix this by destroying the sysfs root folders before calling
kobject_put(&srv_path->kobj), so srv_path is still valid while the helper
accesses it.

This issue was found by a static analysis tool I am developing.

Fixes: ae4c81644e91 ("RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - Clarify that the use-after-free is in the
    rtrs_srv_create_path_files() error path.
  - Explain that this path is before the function returns success, so the
    successful-path lifetime handling is not involved.
  - Drop the rtrs_srv_destroy_path_files() change.

v2:
  - Clarify that rtrs_srv_destroy_once_sysfs_root_folders() dereferences
    srv_path internally.
  - No code changes.

 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 51727c7d710c..9dd9141c86a5 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -295,8 +295,8 @@ int rtrs_srv_create_path_files(struct rtrs_srv_path *srv_path)
 put_kobj:
 	kobject_del(&srv_path->kobj);
 destroy_root:
-	kobject_put(&srv_path->kobj);
 	rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
+	kobject_put(&srv_path->kobj);
 
 	return err;
 }
-- 
2.43.0


