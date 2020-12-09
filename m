Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C72D470B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgLIQrJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgLIQrI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:47:08 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB9EC06138C
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:45:55 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id lt17so3090606ejb.3
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81PSqEKTzeewp1eFw0SkbXHJmtuB6a/3wq15G2WR/5g=;
        b=dVeOT5AN38neXJXE5Q5P2egreXighdeMV857uiJff3y0FdZ7wW76rcXrQzQcqqRyqo
         ubuQCcR9aOZanCa+DAwJ0QABHPqJ19FmBBlOdSyPATjU0z4S2NohuIELX5zsY7KY+vWt
         FAYksWCargftoNqxZSiV+J579acLbYMREMgd88EJW0+PgeCegTOOqXxCyN289ScIwRzZ
         OVFop1D7dGUJT4aIj57IOB/HMerHwU5YcByzPqshkJCQAucSiHvkf2E8Zf1txa7icnbe
         GZGmr1tY8Apwprh5x4wV2h91xhwqOA2DcT+sRT3zKnOXk+sXdRdNy/Yq0eDvW36JlGG5
         SqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81PSqEKTzeewp1eFw0SkbXHJmtuB6a/3wq15G2WR/5g=;
        b=MBSY9nVFQ+5uEvb8kh2NfVoU0s7m+F9c0LwGY52aoNKfduMjwa+TkS7Jir+NOjiP8d
         b7qYAoesiPpdNSPUuD3phUApVsLL0aSmbdOfVhFMgnKPoeraEBRqUyUIX4VcqdXsdUIN
         wSUnVtiZUYUs7spmPyLip9rYdQj/w1NUmpMukBtpi33jjmOoYP82i3Y/7N2oDyoVdoqT
         SK91xYa+Kj0EHhe/9SJCbcKzZeHDwFprwsAXaAK2Jr0xNnD9TsUfLHZzykhTwMF1wBfl
         bcE7gOWaPp0lhRrE4GOPqDb5Td78yw/+TiYEiK7FoDsif5CDECG1ym6lSxulXXhQtN2H
         MNig==
X-Gm-Message-State: AOAM5321kwbwuV/ytvlNOSQ3z6CvhIOl1hbOwhJq4dXZRHS7LMJ/LACa
        QrzHSVcABxaplRcWVRkulNsVjR9PnpfmgQ==
X-Google-Smtp-Source: ABdhPJyL8THNDBIjQ3FttuMY6h9Qv/HgRwtfAbYIsSRZWY4PSPUxQUm/t1+AltBiC2b8Xg9YX3tAQA==
X-Received: by 2002:a17:906:c087:: with SMTP id f7mr2812726ejz.492.1607532354434;
        Wed, 09 Dec 2020 08:45:54 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:53 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-next 08/18] RDMA/rtrs-clt: Consolidate rtrs_clt_destroy_sysfs_root_{folder,files}
Date:   Wed,  9 Dec 2020 17:45:32 +0100
Message-Id: <20201209164542.61387-9-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Since the two functions are called together, let's consolidate them in
a new function rtrs_clt_destroy_sysfs_root.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 9 +++------
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 6 ++----
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 3 +--
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index ad77659800cd..b6a0abf40589 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -471,15 +471,12 @@ int rtrs_clt_create_sysfs_root_files(struct rtrs_clt *clt)
 	return sysfs_create_group(&clt->dev.kobj, &rtrs_clt_attr_group);
 }
 
-void rtrs_clt_destroy_sysfs_root_folders(struct rtrs_clt *clt)
+void rtrs_clt_destroy_sysfs_root(struct rtrs_clt *clt)
 {
+	sysfs_remove_group(&clt->dev.kobj, &rtrs_clt_attr_group);
+
 	if (clt->kobj_paths) {
 		kobject_del(clt->kobj_paths);
 		kobject_put(clt->kobj_paths);
 	}
 }
-
-void rtrs_clt_destroy_sysfs_root_files(struct rtrs_clt *clt)
-{
-	sysfs_remove_group(&clt->dev.kobj, &rtrs_clt_attr_group);
-}
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b3fb5fb93815..99fc34950032 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2707,8 +2707,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		rtrs_clt_close_conns(sess, true);
 		kobject_put(&sess->kobj);
 	}
-	rtrs_clt_destroy_sysfs_root_files(clt);
-	rtrs_clt_destroy_sysfs_root_folders(clt);
+	rtrs_clt_destroy_sysfs_root(clt);
 	free_clt(clt);
 
 out:
@@ -2725,8 +2724,7 @@ void rtrs_clt_close(struct rtrs_clt *clt)
 	struct rtrs_clt_sess *sess, *tmp;
 
 	/* Firstly forbid sysfs access */
-	rtrs_clt_destroy_sysfs_root_files(clt);
-	rtrs_clt_destroy_sysfs_root_folders(clt);
+	rtrs_clt_destroy_sysfs_root(clt);
 
 	/* Now it is safe to iterate over all paths without locks */
 	list_for_each_entry_safe(sess, tmp, &clt->paths_list, s.entry) {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index b8dbd701b3cb..a97a068c4c28 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -243,8 +243,7 @@ ssize_t rtrs_clt_reset_all_help(struct rtrs_clt_stats *stats,
 /* rtrs-clt-sysfs.c */
 
 int rtrs_clt_create_sysfs_root_files(struct rtrs_clt *clt);
-void rtrs_clt_destroy_sysfs_root_folders(struct rtrs_clt *clt);
-void rtrs_clt_destroy_sysfs_root_files(struct rtrs_clt *clt);
+void rtrs_clt_destroy_sysfs_root(struct rtrs_clt *clt);
 
 int rtrs_clt_create_sess_files(struct rtrs_clt_sess *sess);
 void rtrs_clt_destroy_sess_files(struct rtrs_clt_sess *sess,
-- 
2.25.1

