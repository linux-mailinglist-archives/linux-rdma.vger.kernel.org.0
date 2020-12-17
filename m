Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C5D2DD2D7
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 15:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgLQOUk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 09:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLQOUk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Dec 2020 09:20:40 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCD1C061257
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:25 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lt17so38115329ejb.3
        for <linux-rdma@vger.kernel.org>; Thu, 17 Dec 2020 06:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=995sngWFQB2h3MQ9SRxKgslkNwFLet34t3ZGVlvVkz0=;
        b=NNq6ry0dEqj1QHy+s5KSp15ReMY5q2MpDsuIpg1YlWhzEBvHMcFZ8LfxNQn6SU9PBf
         hCUXfIgh1sSAp/vxVFJz+nh4RCwB/TnJil2QNPwtxR5ZYpBAmoM44VdWP0KumhCsJAqS
         o20or60urEb2Jbmot+knhoLl43Nwd8qq0oQqOzPOSGfsFdcSUYEP5uJ9xUShksqq0yPc
         2wqHtnEH10EZ/An3/eOexxyEKS461HEyxd3xDV2TZIRS5QZOlABVeKizyAkWmjbLL/3i
         OuOiP72Sv10R+p/J9RtEaZRb++nPN3rJZ9XT1m7f2G+58/gHeQas3v0b+En5fBC/qyJ3
         PJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=995sngWFQB2h3MQ9SRxKgslkNwFLet34t3ZGVlvVkz0=;
        b=dPLdDJpty9pvmjF8ivxFh1fd+yPWSA5uXk6NhhPQTp8bimFqKxaTSIasKHRV5FhQW0
         jkuNJfbF7pi+jsezeBVXZ0SiCRNHjywxTITeZ3Ui233P5n6Y3H0BTL+L+O0GE/cNHFts
         3nnVs1vLN6FDpMe4Muq2wrjGEBjhSWaItgwqXPiTrLMZs+x/W00+tBEJ2q7AW220xWg+
         /M7+9llbgyNecF/kYEPPueyC15dlv9Vilp8eOTqAEvc5KID5fbNwVV4Xmw+nDyKsJ6Dh
         QHy/bPBFWUhYWwu/8E4F7yk8EXWu2v3NMcfGrLxVMQ05NSZea10JYWqmO+VFnXafWOSz
         Wafg==
X-Gm-Message-State: AOAM530rXjgi1lemp5/zbLc1FRkroPeIKlngL3wmYzVb5ozik8qS0eAd
        AWPyvWuCAzdPNiVe4+W1XvHbl9b3mgCUDg==
X-Google-Smtp-Source: ABdhPJx3v8oDv3/66PDAF5Foc1nOoYkSi5hqI9K5oGqnhmkQJDmhsHthgaUAvz7BnnxrvglNIBPIMw==
X-Received: by 2002:a17:906:3b8b:: with SMTP id u11mr34820735ejf.489.1608214763658;
        Thu, 17 Dec 2020 06:19:23 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4991:de00:e5a4:2f4d:99:ddc5])
        by smtp.gmail.com with ESMTPSA id b14sm18168969edu.3.2020.12.17.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 06:19:23 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCHv2 for-next 07/19] RDMA/rtrs: Call kobject_put in the failure path
Date:   Thu, 17 Dec 2020 15:19:03 +0100
Message-Id: <20201217141915.56989-8-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
References: <20201217141915.56989-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Per the comment of kobject_init_and_add, we need to free the memory
by call kobject_put.

Fixes: 215378b838df ("RDMA/rtrs: client: sysfs interface functions")
Fixes: 91b11610af8d ("RDMA/rtrs: server: sysfs interface functions")
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 2 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index ba00f0de14ca..ad77659800cd 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -408,6 +408,7 @@ int rtrs_clt_create_sess_files(struct rtrs_clt_sess *sess)
 				   "%s", str);
 	if (err) {
 		pr_err("kobject_init_and_add: %d\n", err);
+		kobject_put(&sess->kobj);
 		return err;
 	}
 	err = sysfs_create_group(&sess->kobj, &rtrs_clt_sess_attr_group);
@@ -419,6 +420,7 @@ int rtrs_clt_create_sess_files(struct rtrs_clt_sess *sess)
 				   &sess->kobj, "stats");
 	if (err) {
 		pr_err("kobject_init_and_add: %d\n", err);
+		kobject_put(&sess->stats->kobj_stats);
 		goto remove_group;
 	}
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index cca3a0acbabc..0a3886629cae 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -236,6 +236,7 @@ static int rtrs_srv_create_stats_files(struct rtrs_srv_sess *sess)
 				   &sess->kobj, "stats");
 	if (err) {
 		rtrs_err(s, "kobject_init_and_add(): %d\n", err);
+		kobject_put(&sess->stats->kobj_stats);
 		return err;
 	}
 	err = sysfs_create_group(&sess->stats->kobj_stats,
@@ -292,8 +293,8 @@ int rtrs_srv_create_sess_files(struct rtrs_srv_sess *sess)
 	sysfs_remove_group(&sess->kobj, &rtrs_srv_sess_attr_group);
 put_kobj:
 	kobject_del(&sess->kobj);
-	kobject_put(&sess->kobj);
 destroy_root:
+	kobject_put(&sess->kobj);
 	rtrs_srv_destroy_once_sysfs_root_folders(sess);
 
 	return err;
-- 
2.25.1

