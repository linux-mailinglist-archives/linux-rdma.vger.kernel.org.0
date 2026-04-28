Return-Path: <linux-rdma+bounces-19649-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOt8FLOW8GmrVQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19649-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 13:14:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B841448377F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 13:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5A4A309F1DC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 11:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405013F20FE;
	Tue, 28 Apr 2026 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmBXG4bK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6DF27A916
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373851; cv=none; b=ntgo9n4xw89EmPpDtKl+A3cKcf7XE2j14h37rMLlvicbOlw6oMQ1a4CG7K6CDYUT9Ti2pWbbXUpoTqNSohf86OMNJ7oFQDJ2pbhSpb4LNY5IfqyzxzqSI25+bKvhdSZEnEdRgei+OyKyRwsIQSReia0fldr10m9mh3OkQ+G52M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373851; c=relaxed/simple;
	bh=XPDEKmRKpnRmqwnunZpLbAozc/7TKvBCKxnJaxi8csM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZ4zsadHuEMmIM/ZEUGZfHJ1flh8Ab7Pt7BVSMjK0Kd9gVWOfo/cCLkWjuQXAMfjHSuuE3y/MBr+v49jauTvr5Ao0D9eEk9wYS1kiZAoH/EmdZmTz5IAv1aEvlv1W5a6XISuJFXRW3EMbOrPjYo0PxwqE3+cV29JzOZUIKI0ajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmBXG4bK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35d965648a2so10108641a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 03:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777373849; x=1777978649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vB1ukiFG/haF8qLZdd1jpoy3usndGdcFKuCQLa+zrcg=;
        b=DmBXG4bKRkkFlcKHDwJisBZWpAf2E3X68pwiQZ0rvLz9OMB92MZhO8ZRp60OWBxg3H
         Za4xXl/eS1kpaSGiT5NOntd67vqWtXU2EmS3DkuOqqEHPIoBWGZH0R+XNP9XAathgyCm
         zHWqCzmqzJDBehUuXKfPkfwPwutnlq/YdL8WuqS1JI8H4OoaHzhA7srzkD53vFOsT4Q4
         FDC0Ww/sal8a8OD6ZhVRzzmvUQ6ZMzUKmdNWdV2ihDG+5tAZdTqWcRqTWVhM+jLuhpOG
         8maJgNC/P0szoUFOljbRkyDX9tCP/YXeWYgxweAbYtYN9KqGLxO5IFz/UTYbB0gWSuki
         N+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777373849; x=1777978649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB1ukiFG/haF8qLZdd1jpoy3usndGdcFKuCQLa+zrcg=;
        b=irqtDM7icBiUNrkvvEN5A/8Sms8it1fAHcqGbs3nf5E+n0/JAYVRkRcKsqfzrXaDyb
         8PJmo0eulE2zPqgadsOoeNLUxGsTD1h7sa0IFe3od33CItOUJRspYjHlx9ycnLBuLVBv
         +Q/eqOTxQuycef3DUGiGjP9GYAR/EDX+kNuhxQKZAXsqeNz8Gfzy2nX83EHekX/NwQsO
         4o5fP8SGQfOUOcdMNfLT0KqrQOteIbfSJ7chM0LeRoYa6+cCB9eGTMjSji6wq36Nt4Wx
         MjRwb9OJx2nkpVbBHPFMVAHqqH7V+3aEJjJj47sRIBIcEPmGshVSFY73tfE98tKkXg1x
         axvw==
X-Forwarded-Encrypted: i=1; AFNElJ8Aax6f/g22WHNM6EJildRfjgHflbn64Pb3BCmMxVVs0nJIl+18WUJohbTnWBqxgb9LnxXzBCGxq4hG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vCYoCLUydXW4RAeH3RsQTlK1756EbKafoVLq5uZtj+iSxhVa
	1A8hZq4f8fsOCm+ILFKToyctl5DHSSuJoU75zA+BnVM+B4nCZlqgGyXnYksR4cVvvQBmrQ==
X-Gm-Gg: AeBDiestAklmiB+2TSHI7elCwEFDRc2LvbJIvz5e1ssGJOEtl8d8fb+E3psEC52Mt+p
	ImJlCMgsJTWuaDW5EeFhVhS6bJJ2UY/q6LR0X1oEn9mR+ZDq57076B9Y2jm3KObHbgEvxNWoPmg
	TnqcLB10t/4GWMMJ5WlKZKEnQeI67tmpGWr42wOARbIaDIYke5CyxiKd0Su0DgsyW4Q3oOR3VW0
	UDMzSsOyUis1Ik2xbw2/O+p3P+D+bDIsz2stgk3ElILI/fkWWBwiesqTBbOGJmBgHUO4rAzS2JG
	d9vU+Ed0J0JBOLOxipj9A33sOPC73SeafKeqn0Nw+75QWcsC3Sl2I77oOOce5PGBdC0ZWUIHb98
	3ZoTC4fm13xrUf3ZbQq4re0YlSoYTEVswuQzYP4HeI0X+o8N16VBr456BvRDQldCwBRxDWWfLRm
	c2NJ4W1IqDRHFEK49c
X-Received: by 2002:a17:90b:5203:b0:35f:b784:d3bf with SMTP id 98e67ed59e1d1-36491f6d2f3mr2798541a91.1.1777373849107;
        Tue, 28 Apr 2026 03:57:29 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::5a26])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490f9a30fsm2924319a91.12.2026.04.28.03.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 03:57:28 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Vaishali Thakkar <vaishali.thakkar@ionos.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] RDMA/rtrs: Fix use-after-free in path files cleanup
Date: Tue, 28 Apr 2026 18:55:15 +0800
Message-ID: <20260428105515.362051-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B841448377F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-19649-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Once kobject_put() is called on srv_path->kobj, the release callback may
be triggered and srv_path may be freed. Therefore, srv_path must not be
dereferenced after kobject_put(&srv_path->kobj).

However, both rtrs_srv_create_path_files() and
rtrs_srv_destroy_path_files() call
rtrs_srv_destroy_once_sysfs_root_folders() after
kobject_put(&srv_path->kobj). The helper dereferences srv_path to get
srv_path->srv, which can lead to a use-after-free.

Fix this by calling the sysfs root folder cleanup helper before
kobject_put(&srv_path->kobj), so srv_path is still valid when the helper
accesses it.

This issue was found by a static analysis tool I am developing.

Fixes: ae4c81644e91 ("RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 51727c7d710c..c9ba9d2d0eb3 100644
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
@@ -312,8 +312,8 @@ void rtrs_srv_destroy_path_files(struct rtrs_srv_path *srv_path)
 
 	if (srv_path->kobj.state_in_sysfs) {
 		sysfs_remove_group(&srv_path->kobj, &rtrs_srv_path_attr_group);
-		kobject_put(&srv_path->kobj);
 		rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
+		kobject_put(&srv_path->kobj);
 	}
 
 }
-- 
2.43.0


