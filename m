Return-Path: <linux-rdma+bounces-20351-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XWfNMqBYAWqSVwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20351-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 06:18:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1251A507CAC
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 06:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 702673009155
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 04:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58EA23E330;
	Mon, 11 May 2026 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0ooR6TO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC241684BE
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 04:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473112; cv=none; b=uswwUO3KvLoLxPZLS21eK2Detit159F513JvdXJX19YWHyUtrPt2rRf+jXJ0n+VcSxhAt5GpN2FscBFV1ZlTW1ACgnPA+d+VIkZ470Vmg19usn0Cb91GW8yZJ0I8q0EtyR4bBJ5RhkgU8pHU/Q/tqNVOIPHMlWb/OPRC3sMsZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473112; c=relaxed/simple;
	bh=GzDBdO7Mp3oPEM8yFLGA/A2Bx3aZbV9XkMWYzloX1v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hnZxCurOnFCMnAn/TsMUMLrhFpw/yC1GKrMaEmdOwd3g8eTKvMjHkOnLUWxlA5DPeY2OjVafUfQJy3ZPoeM2WCJe6W7d/byxV3FaR6G05PEKD8gl2+mqHoDoZP+cFsKCqd5ScDDVvLVnmNo385D8VGh4LBQ2HtAMimCmsz0FLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0ooR6TO; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c80291e6237so2625000a12.0
        for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 21:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778473110; x=1779077910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6BCQ7qOuFvI6WhevaP4A6Cx/p5unX86RC6LvwJNRnw=;
        b=M0ooR6TOiZw33UDT+MWt3nh9uxciJKqq3ZUjBRsnuo/6QBGBz/7sXjku9LrjthOLyr
         jtgaDijL+N+iIwWtfqwKdLTcoigfdEMN8O3qzHQHf6CRzxM96cLQBHccQk36WcADd6qE
         s8xg8JkecwK3S2HnIEG86kLISBR85dekyjWthUTy8FI+vR/miGDM4RBQO5RQLzEVcz+j
         aDpQPlIwWrZglDpBo2RK23VBl5+mp4+mb2ftXPie0NssHQQNBRLIcPLjRdI6zMaZpN/p
         ElTl4xGTeBJVeMkumtS8rt20m7ZR7Svn1GcLSvRoUnc6KV2jyJdoA8q5QvWez9Reur3X
         cbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778473110; x=1779077910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6BCQ7qOuFvI6WhevaP4A6Cx/p5unX86RC6LvwJNRnw=;
        b=Gi3ngDshmSdzZBDlTwNIEVA5hi8z0qFpn5i0t+vXcI8ugyH6gTt7ncp5NHfM52RBWi
         zW39w69BDB69rBv+nOA2cTWs2F9qKv3VZPojx6jbYY+mTn0gSEvegHeYt9R1BXyOPT0u
         obiSV7Tm1XIL+RcoN+BRzXKz9bXiSukc4/LDoDpq8Epo/vsIizZ8KUrpOqvxlNLNOMa2
         y4XW1Ypz0WWzJW1V+Q22CPH6em/Ew/CWhru0T8Ae9PawV2j2VHDf6W/gzuYAZUb7Vo81
         4xYCwRWiphDiy1c+utCpH3SSbdnFfesnWwOoqLLNdzu4G6nx9wGApmIfktM8UCLfWk6k
         tNgw==
X-Gm-Message-State: AOJu0Ywm816qkAUvDNiGNj1+dtReBPrDwHnbfCwj6anSGBLVcjJigxz6
	gWNnpQORTM+984NS1ydCUn+6wNSz4RfW/JPFyFj+me/ZKPwre1M7O+SDnYsPl2uk
X-Gm-Gg: Acq92OH++RvW5StHKjZ52viXYgXDqkttvO+vt1LPvXnS0eMxrg5gGZEaOmAigjWBR+g
	orU9/4PdESrwDmnuILRdm3Vc0eDyxb+gieusWqSpQzd3nlU0qDd48kfiQN4O1M38j+WVj63h3KJ
	a+WYfXsiLKhTfr/OXnQNETj3ck8zmfjWNdmZhrS0mIRL3eXKDy2UbfmwRHOrwwbOYQMizQaEAYE
	6VadtYHgBtQofvSq9nbuAgTfBH9L5NBJ6L02rKxNQ723yloCCHBpLoW4x/ZAK2CITeYvald4EZd
	gGmZgutRnNse7XAGaOg7iX1hAcglgh7vQBNIKSsuWdY4qKf6J+c30zDtlHu68v8u95FMOH3+9O1
	QJtvdFChzHWQDlM+oQ73ssK/A21e7FAH7IdMa9aZ82fcqv7uqEgZ2iyaot+6KGRKy4lY7hA3HRg
	P5Qu1Ho35TuNuZwe8KPhZtjmdeleHihpLAAkH1zKaHNKzMFNnc6/SaA69Nuk9naGBXpyuEfVoD3
	RflocVXMLt3xF8HIEHOQQciLjzSHgvzU/2plPEcSOfgXA==
X-Received: by 2002:a05:6a21:999b:b0:39b:9644:6e93 with SMTP id adf61e73a8af0-3aa5a8310aamr24089558637.6.1778473110139;
        Sun, 10 May 2026 21:18:30 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826771c6ddsm7492741a12.23.2026.05.10.21.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:18:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] RDMA/rtrs: Use flexible array for client path stats
Date: Sun, 10 May 2026 21:18:12 -0700
Message-ID: <20260511041812.378030-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1251A507CAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20351-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Store the client path statistics in the RTRS client path allocation
instead of allocating them separately.

This ties the stats lifetime directly to the path and removes a separate
allocation failure path. Keep freeing the per-CPU stats data separately,
but do not free the embedded stats object from error paths or the stats
kobject release handler.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  2 --
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 13 ++-----------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  2 +-
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index 287e0ea43287..f8b833bd81ad 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -37,8 +37,6 @@ static void rtrs_clt_path_stats_release(struct kobject *kobj)
 	stats = container_of(kobj, struct rtrs_clt_stats, kobj_stats);
 
 	free_percpu(stats->pcpu_stats);
-
-	kfree(stats);
 }
 
 static struct kobj_type ktype_stats = {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index e351552733df..d34d7e5f34d6 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1536,7 +1536,7 @@ static struct rtrs_clt_path *alloc_path(struct rtrs_clt_sess *clt,
 	int cpu;
 	size_t total_con;
 
-	clt_path = kzalloc_obj(*clt_path);
+	clt_path = kzalloc_flex(*clt_path, stats, 1);
 	if (!clt_path)
 		goto err;
 
@@ -1552,10 +1552,6 @@ static struct rtrs_clt_path *alloc_path(struct rtrs_clt_sess *clt,
 	clt_path->s.con_num = total_con;
 	clt_path->s.irq_con_num = con_num + 1;
 
-	clt_path->stats = kzalloc_obj(*clt_path->stats);
-	if (!clt_path->stats)
-		goto err_free_con;
-
 	mutex_init(&clt_path->init_mutex);
 	uuid_gen(&clt_path->s.uuid);
 	memcpy(&clt_path->s.dst_addr, path->dst,
@@ -1583,7 +1579,7 @@ static struct rtrs_clt_path *alloc_path(struct rtrs_clt_sess *clt,
 
 	clt_path->mp_skip_entry = alloc_percpu(typeof(*clt_path->mp_skip_entry));
 	if (!clt_path->mp_skip_entry)
-		goto err_free_stats;
+		goto err_free_con;
 
 	for_each_possible_cpu(cpu)
 		INIT_LIST_HEAD(per_cpu_ptr(clt_path->mp_skip_entry, cpu));
@@ -1596,8 +1592,6 @@ static struct rtrs_clt_path *alloc_path(struct rtrs_clt_sess *clt,
 
 err_free_percpu:
 	free_percpu(clt_path->mp_skip_entry);
-err_free_stats:
-	kfree(clt_path->stats);
 err_free_con:
 	kfree(clt_path->s.con);
 err_free_path:
@@ -2863,7 +2857,6 @@ struct rtrs_clt_sess *rtrs_clt_open(struct rtrs_clt_ops *ops,
 			list_del_rcu(&clt_path->s.entry);
 			rtrs_clt_close_conns(clt_path, true);
 			free_percpu(clt_path->stats->pcpu_stats);
-			kfree(clt_path->stats);
 			free_path(clt_path);
 			goto close_all_path;
 		}
@@ -2873,7 +2866,6 @@ struct rtrs_clt_sess *rtrs_clt_open(struct rtrs_clt_ops *ops,
 			list_del_rcu(&clt_path->s.entry);
 			rtrs_clt_close_conns(clt_path, true);
 			free_percpu(clt_path->stats->pcpu_stats);
-			kfree(clt_path->stats);
 			free_path(clt_path);
 			goto close_all_path;
 		}
@@ -3166,7 +3158,6 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt_sess *clt,
 	rtrs_clt_remove_path_from_arr(clt_path);
 	rtrs_clt_close_conns(clt_path, true);
 	free_percpu(clt_path->stats->pcpu_stats);
-	kfree(clt_path->stats);
 	free_path(clt_path);
 
 	return err;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 986239ed2d3b..1305601a6251 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -142,12 +142,12 @@ struct rtrs_clt_path {
 	u32			flags;
 	struct kobject		kobj;
 	u8			for_new_clt;
-	struct rtrs_clt_stats	*stats;
 	/* cache hca_port and hca_name to display in sysfs */
 	u8			hca_port;
 	char                    hca_name[IB_DEVICE_NAME_MAX];
 	struct list_head __percpu
 				*mp_skip_entry;
+	struct rtrs_clt_stats	stats[];
 };
 
 struct rtrs_clt_sess {
-- 
2.54.0


