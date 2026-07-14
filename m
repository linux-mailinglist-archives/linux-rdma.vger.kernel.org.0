Return-Path: <linux-rdma+bounces-23197-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lHZ6NbhHVmr52gAAu9opvQ
	(envelope-from <linux-rdma+bounces-23197-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 16:29:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B91755CE4
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 16:29:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HEFHowfB;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23197-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23197-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD087302F028
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6FD47DF88;
	Tue, 14 Jul 2026 14:29:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCD47D940
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 14:29:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039343; cv=none; b=oofsZ6nQtUFlC12ETfstKJP9UEbfa/OXUkCK5Z8223J/xmaTbTq5tMTg8RJqQYH75VxGOuly++A/VQ4jOU09uP9Nv2wfshyMo6Q6eXa17O3zcdJoyB72NZBXxiYPJPRnw0GR500sWoG7L0WrLVXqZ6B34dt3OYyiottwo7WXZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039343; c=relaxed/simple;
	bh=gd/r9grCRZ+6cnWU0NBYM0b7O3OAbQA7ZZ0KgEAgfS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMLzWNVXSeFQA3r5Ieu325iBeIOgsK2OXEwonklWlNWccMyPHjrh9rBQ3gJsCbNlkdsjo4xeIYLyReCLfZ9wmIoX2JXaWj9aEAk8Va6JYKl173ann/1WTxTDysUHwsptdTcyCzYtaCIflIS4w5XZmpi+zI13frGVcjQ2Ask4CTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEFHowfB; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso4604160a91.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 07:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784039339; x=1784644139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hIKCPPeciFzVG42F3e4RduFJQxgzqZmRFzkNVetv/mw=;
        b=HEFHowfBbrxvuAfg69NPIMhlnkYqqVcAEdXhtkGezYAxjAC6Gh4vZRNYobVqbVhrjy
         3uwxd0pFNabKGmvX/jHtlH1NLqhCjVA/NUmzH5pKv8llCNNj2u86TgVyF24YQqABhBQ3
         42jLDX6IZP4KaaGvx/0oTkIiiyPjcZNRgi4zUfRyeLmXAURQQ0QIDnsveMqiDc9WtHQF
         vByqvbcXcFsl2Rg89Wquas8PUE3hzjDk6D1+JNaqtHm7OgCrol2pScU6orkDsyNnWKdr
         bjs3ARSdawlHFCvwVr9DMkjLlLKfkafsEbA/xFu9zbMoWGwNC4VMN3YqqXQ3PWxC4i6n
         ZgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039339; x=1784644139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hIKCPPeciFzVG42F3e4RduFJQxgzqZmRFzkNVetv/mw=;
        b=WrWxxinupTMjCN+6YdejAn30uT1DH5YZ+wgLTQqyKhVjcFLZNMkuSMh/4xtba9XxZS
         iHAcyRHc1q051XdGB5RCYtZs3cdK89yLV3VKlNBAKTqDINjVQYZT6DmP03n82GrT5N1Q
         kEa6xw56EQeO/mbykw2CKe4GuJglduiv+1RieEQMv3przrsRKL+1ubLGYDc3eDlm5Y/8
         cFFqXhZmbo2/i2tFmHoTC2OGAzYIBCvgOfsS7pQnZcLjXNM+ovhQSKfzxjzp630rYoAJ
         Htmc/4BYxhgRjRH9XPM8cZDlcGHBikVxmyCAl40gQeydlD9NZrszmrjlLC9plFwlqYdr
         H+/g==
X-Forwarded-Encrypted: i=1; AHgh+Rqn0vmZU0Ie7KiLIDYaIH3SQ8c5Ung0S+hwT/tisugv5YPHb+4Aetlt5DFO1wbipkLbwE4s7FXZLI+Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8d9/M6otTTMITsFhA17iuY5m/m86TEYYoDPLw7LKpovMQOK8V
	7BPk9sSw7hcKqT9b+6eXyGa1hKSaVfAwnHcivDLS+mdwl4CA9iPQYBzL
X-Gm-Gg: AfdE7cn3lUNio7E61ZQ/5vnOwHAC4VCNxNg1Jwoj6/euOR2fPW83enKlz1X42PF0iWy
	ci+pvN2gl6NbKoMzIFTjN7S4HUKbCU2EA4GgwWVgGFZxW8aisvrEIQNUAGtSkJ2I5KC9CXgm35e
	QxpxdLwS//aQdI0YYhmdgr9mDfjkeOwdavmZ5WXabQ+90C4AuUZ8Y2vGYnUzMQ6imt/6P9YLYYY
	ja/a3LTLf3z8tgisL7gOT8TtZcUoOEdaMcm20pd0YXQ4FMdSZFK3+ult8GvdHMQQOAxSC/LfHDp
	gvzGYqTvfDJM2cLoxCkEpi1cpIp0m4P3Qtd/OleL9sYXqOhgt1J0N4EFurtdxF9kX0t0DykBM7f
	DGhXH5V/FTEnM6etbdLl5hXoQlK5X/dmocOToHQIbW+2k3gnbTnoSQKKB8NlQOYF0Knu7CU6K1S
	l04bTczX/LSQ==
X-Received: by 2002:a17:90b:58cd:b0:37f:9cdf:f0af with SMTP id 98e67ed59e1d1-38e17e675fcmr3279564a91.30.1784039338846;
        Tue, 14 Jul 2026 07:28:58 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172b6d37sm1569813a91.2.2026.07.14.07.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:28:58 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Gioh Kim <gi-oh.kim@cloud.ionos.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] RDMA/rtrs-clt: Fix double free on path sysfs failure
Date: Tue, 14 Jul 2026 22:28:38 +0800
Message-ID: <20260714142838.1723076-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-23197-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:gi-oh.kim@cloud.ionos.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lgs201920130244@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70B91755CE4

alloc_path() allocates clt_path before rtrs_clt_create_path_files()
initializes its embedded kobject.

If path sysfs creation fails, rtrs_clt_create_path_files() calls
kobject_put(). The final reference invokes rtrs_clt_path_release(),
which calls free_path() and frees clt_path for the first time.

After the helper returns, both rtrs_clt_open() and
rtrs_clt_create_path_from_sysfs() continue to access clt_path and call
free_path() again, resulting in a use-after-free and double free.

Let the sysfs helper undo the sysfs and stats setup while retaining the
path kobject reference. After removing the path and closing its
connections, release that reference with kobject_put() so
rtrs_clt_path_release() remains the sole owner of the final free.

This issue was found by a static analysis tool I am developing.

Fixes: 7ecd7e290bee ("RDMA/rtrs-clt: Fix memory leak of not-freed sess->stats and stats->pcpu_stats")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 20 +++++++++++++++-----
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 12 +++++++++---
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index f8b833bd81ad..3284f86c745e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -438,13 +438,12 @@ int rtrs_clt_create_path_files(struct rtrs_clt_path *clt_path)
 				   "%s", str);
 	if (err) {
 		pr_err("kobject_init_and_add: %pe\n", ERR_PTR(err));
-		kobject_put(&clt_path->kobj);
-		return err;
+		goto free_stats;
 	}
 	err = sysfs_create_group(&clt_path->kobj, &rtrs_clt_path_attr_group);
 	if (err) {
 		pr_err("sysfs_create_group(): %pe\n", ERR_PTR(err));
-		goto put_kobj;
+		goto del_kobj_free_stats;
 	}
 	err = kobject_init_and_add(&clt_path->stats->kobj_stats, &ktype_stats,
 				   &clt_path->kobj, "stats");
@@ -468,9 +467,20 @@ int rtrs_clt_create_path_files(struct rtrs_clt_path *clt_path)
 	kobject_put(&clt_path->stats->kobj_stats);
 remove_group:
 	sysfs_remove_group(&clt_path->kobj, &rtrs_clt_path_attr_group);
-put_kobj:
+del_kobj:
+	kobject_del(&clt_path->kobj);
+	return err;
+
+del_kobj_free_stats:
 	kobject_del(&clt_path->kobj);
-	kobject_put(&clt_path->kobj);
+free_stats:
+	free_percpu(clt_path->stats->pcpu_stats);
+	kfree(clt_path->stats);
+
+	/*
+	 * Leave the path kobject reference to the caller so it can tear
+	 * down the connections before rtrs_clt_path_release() frees it.
+	 */
 
 	return err;
 }
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index d34d7e5f34d6..633a3211c17a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2865,8 +2865,7 @@ struct rtrs_clt_sess *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		if (err) {
 			list_del_rcu(&clt_path->s.entry);
 			rtrs_clt_close_conns(clt_path, true);
-			free_percpu(clt_path->stats->pcpu_stats);
-			free_path(clt_path);
+			kobject_put(&clt_path->kobj);
 			goto close_all_path;
 		}
 	}
@@ -3150,9 +3149,16 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt_sess *clt,
 
 	err = rtrs_clt_create_path_files(clt_path);
 	if (err)
-		goto close_path;
+		goto put_path;
 
 	return 0;
+put_path:
+	rtrs_clt_remove_path_from_arr(clt_path);
+	rtrs_clt_close_conns(clt_path, true);
+
+	/* rtrs_clt_path_release() performs the final free_path(). */
+	kobject_put(&clt_path->kobj);
+	return err;
 
 close_path:
 	rtrs_clt_remove_path_from_arr(clt_path);
-- 
2.43.0


