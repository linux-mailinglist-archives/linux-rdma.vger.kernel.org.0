Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1B03495A2
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhCYPdu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhCYPdV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:21 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD1BC06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id dm8so2912397edb.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kOr9kGJe5yLIYaBTtvOp2p92U46YKCKuZT+6G1NEbmQ=;
        b=Ret8obhVP2rpmrc1tigy/Y8dScwB3RX1wC+0onbITjIKA1ei/coJNZLqqxfM1i8TAB
         ZhreLTCSE4JDIHWhq6DfHF2JgKth3RCsp/HRRlQcepkxMTs5yP/vA6k/mrslz2mMiIWT
         9kbLg0a5eV/hbEWH1LVU3Z0EvqRSmsmfQhTgh4chcSSaS40QKOd8lzECd2qKBDmkXVYv
         mzLBNSHYTwtfpWOxDW7CrSrm20y6F4lcGF+rj/4P67rYtr8ov5f41b3e865dui5hVCL8
         3L5u7KgOKnLGtZ/y5JdFZWTrmM5ylrZOPfIkByIfvzMpUKN6GOz9Dc7BNQdOGiSKLXLn
         Oh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOr9kGJe5yLIYaBTtvOp2p92U46YKCKuZT+6G1NEbmQ=;
        b=lmoUyHej9edhmVOfV1YScqyt9lhXoEd+Dtdl08DHn58K7x0uGPDPunyD28n+k9YOVT
         L5Rj77YktxDlT4RYMgF9CtpnLqSOWGEpC+tRVpt7rfv4Cu1oCom67DwDDDqAuv/uSMGk
         /JhW9bhPfCiGetwN6wFlsXh7vNT2qh+OCl1KtZ7rYUXD9JlCOQMDZz2NCjdJlI+ZlxLt
         dKQHjAA5VXyAn7qMUcYzyW58CZT0HJRahP+IPUR1NoAOmJJCiclQChtwihZRUopNtezy
         UcZDns5NGzdeYFGN03tiNoi3eiubx8ltlszh9ZVEVop7VtzZkORE58Xd7l0itDAwOiXQ
         zXoA==
X-Gm-Message-State: AOAM533BswLr4pWALa0tL00ZJwuFX+ymlQDZybeByHPacVrPHWP/j2PV
        Xwev1p9WbZK+5baM85PsJgmVPNMH4o50vVji
X-Google-Smtp-Source: ABdhPJxvoFf4oDwrn73jX+ArDoffwYreBab5BobdW5MZ4GFmiW+Om3JLHU2oQjeNztnKRpUt5Azi2Q==
X-Received: by 2002:a50:e80c:: with SMTP id e12mr9816673edn.229.1616686399664;
        Thu, 25 Mar 2021 08:33:19 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:19 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 08/22] RDMA/rtrs: Kill the put label in rtrs_srv_create_once_sysfs_root_folders
Date:   Thu, 25 Mar 2021 16:32:54 +0100
Message-Id: <20210325153308.1214057-9-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

We can remove the label after move put_device to the right place.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index 7ac3fe884409..309693434870 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -176,7 +176,8 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
 	err = device_add(&srv->dev);
 	if (err) {
 		pr_err("device_add(): %d\n", err);
-		goto put;
+		put_device(&srv->dev);
+		goto unlock;
 	}
 	srv->kobj_paths = kobject_create_and_add("paths", &srv->dev.kobj);
 	if (!srv->kobj_paths) {
@@ -188,10 +189,6 @@ static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_sess *sess)
 	}
 	dev_set_uevent_suppress(&srv->dev, false);
 	kobject_uevent(&srv->dev.kobj, KOBJ_ADD);
-	goto unlock;
-
-put:
-	put_device(&srv->dev);
 unlock:
 	mutex_unlock(&srv->paths_mutex);
 
-- 
2.25.1

