Return-Path: <linux-rdma+bounces-20393-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kO12LgnXAWryjwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20393-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 15:18:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2E50EB86
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 15:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DCBE308B786
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 13:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169483DBD55;
	Mon, 11 May 2026 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWAJ8vpW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB73B6BF1
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504952; cv=none; b=i5WBqAwOgJOQM5fYOlpjrYBwFCEABbT3hwg9a6P6bQcO+6lYf9mSyvna9q5j2lvXG6cUQtX6MgT1dt7od6lPcMoMa8GXLdrW5fLOVMF9lE1MqjWdnLrPUbNTB1G1cijgNYfKhKOzrFCNKEx8O5H/kHL5JBjeGv+HwMIrTS3GK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504952; c=relaxed/simple;
	bh=XWcofE4V55bO53CBZvGR/Dgd1hsKDCRCvsY5qQXKI6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IlUJXOCQ74LAA+CqAFJprXo5IdKF7LvBOBcrscBNhJWR23iKRunyv54sVjMObbGyj+xabV4fp/M6Utii868lCf0UnvFTG39/DrkoHyuSsu7x6JMyt1e5HnaE4zZKAYUvjCyH/Yy+rC3rGseGUAFXg/KE9AtHWacn8ihweO5Jhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWAJ8vpW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so3005892b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778504949; x=1779109749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7S/zPzUjbACO6a/KbjkmptJ3lgVoecfug/I/z6PqGMU=;
        b=TWAJ8vpWYiFYFzWheCTOsjzsAYjIZZNrZFgYC0CdYY23gnLauxXOeVD1csGWPcx4Gq
         ZEWnRk+Gb0ZiDm9AIfLPxE0zDz8b1HqWWsMEmGio8tZD3b1QADazeqgt5eXeAFD2jJml
         gES/7LIjxw+45eDP7lp03lT5hhP1VOb0gupRcNAxvhKq3ULQoKTlmt+EOM+ncTKoo4OG
         tFQtmPr3WTJ9MWERRahHBiwreQMBkSCTxz48MSXT5ddF3xehw6yDAEs9qDySsuueV38c
         opuYNePM7z+/xNscM3mZkkkcu2rwudTkDFApRtIz66SQs5fqXzqqaaEXhgfoTUGDkmTK
         EW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778504949; x=1779109749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7S/zPzUjbACO6a/KbjkmptJ3lgVoecfug/I/z6PqGMU=;
        b=YsB/FidzBkq9G/Q5RsW37kgBZw7CDuYoYc26xqTHUkgiBCpySEOvJxhXW1AG+FBvLW
         Ln/1U0BuqIRsfE3YqJgweITQG57uwOtyZEDcWRyO0QZ6mG6Vym1g0XSXlESMHUFhPwRy
         +GJvqO/+Hwsl8dn9di9Nl8vlUQMlBlivgNkfY4RoH4wujXfjPtYwI4z6HdP+CJTE+Xdb
         NkdVitxDaddlOPV4jPQ9d6xn3a2iVx4OJvrcvCJvHJSwjN+mq+E8F9048qboExZ6fgfM
         Mc0oXOoAarfMrCzsBUnLEch2WcHNCm3ZnIl/aJzjiQuQIYcuuvJRaVzANi46ZT/8sVq5
         jlGw==
X-Forwarded-Encrypted: i=1; AFNElJ+RJV4nDqrka1TyTjSQRYAEp6Bn8uUaHhDqeA5GjYfVkJSqbTNHGb7X4WF4NlYO2NROrL33L7iZRWhZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+b7jFfrx8YWFMx5C4+2AFmLIPR7daF6nOunugG22DUhlbpcw
	zQ5xoUqErnauM7dyYuKK43r6okh1KTK2Rgdy3+7dT/YJ6yJj3ACDxEEjE4OE67TmwT0=
X-Gm-Gg: Acq92OGWH95M2eYGbmH3e8xZZHUeR0Cy/qh+LfCnDoI1eSrHHNSfNweNFzsxhbDRCbY
	gxDgUb8GBHWn0S7zw4wdLwDrUok39WT5WGj1o8eyUGrxOmsqeQqnnR8AM63gq+eG6lhBNpzgo1L
	5BEVk3E4IFLQpVEbkDH52CKtVZyiBKBfPcE6xBlGbY5up66t7JkPP/D+fVv0K1M6iECC2cpwYl6
	tv/QsXGGY7NYT8ZvFu2wvyFiIV+OECBKAZIGmpDyk5L2KB0jJr//kNbH49Q6ZXF+Pqkb8TVZwYR
	JqY7Es7Qm7rBnINqXnG7CBeRsNfd+kCL3/EdIy/rfKCTowo+MmVRp/hyzNA1vYIyX9xZZZYv5ve
	siIpYAv956TDiaiQUnONnzDie5xLVhcav78bvanzJYnlBVtQ+K9UwjxhvX6Pe7r8r2IP14TGHwD
	w9VSAhYjOgImNkn0fLAWUa
X-Received: by 2002:a05:6a00:4503:b0:82f:8b20:9165 with SMTP id d2e1a72fcca58-83a5ea3ffafmr24130826b3a.44.1778504949428;
        Mon, 11 May 2026 06:09:09 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965c30ddasm25641973b3a.21.2026.05.11.06.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:09:09 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Vaishali Thakkar <vaishali.thakkar@ionos.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH v2] RDMA/rtrs: Fix use-after-free in path files cleanup
Date: Mon, 11 May 2026 21:08:04 +0800
Message-ID: <20260511130804.773204-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1FA2E50EB86
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
	TAGGED_FROM(0.00)[bounces-20393-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Once kobject_put() is called on srv_path->kobj, the release callback may be
triggered and srv_path may be freed. Therefore, srv_path must not be used
after kobject_put(&srv_path->kobj).

Both rtrs_srv_create_path_files() and rtrs_srv_destroy_path_files()
currently call rtrs_srv_destroy_once_sysfs_root_folders(srv_path) after
kobject_put(&srv_path->kobj). Although the call site only passes srv_path
as an argument, rtrs_srv_destroy_once_sysfs_root_folders() dereferences it
internally to access srv_path->srv. If kobject_put() has already freed
srv_path, this results in a use-after-free.

Move rtrs_srv_destroy_once_sysfs_root_folders() before kobject_put(), so
srv_path remains valid while the helper accesses it.

This issue was found by a static analysis tool I am developing.

Fixes: ae4c81644e91 ("RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path")
Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Clarify that the use-after-free happens inside
    rtrs_srv_destroy_once_sysfs_root_folders(), which dereferences srv_path
    after kobject_put() may have freed it.
  - No code changes.

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


