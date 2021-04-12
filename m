Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E542535BC59
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 10:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbhDLIki (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 04:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbhDLIkh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Apr 2021 04:40:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E459FC061574
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 01:40:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a7so18936415eju.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQtGaElbeCwCBcuE2Oz71cXsOc2pbKv6F4mBG+/n82c=;
        b=d3ce5uHb943PRm0fkoxlMR121BKoz4E42y2mdr59E1AUn7PaqJ8YfZD/JyLdy7CMwJ
         ydczkkxaBWZVSXP66uIRVDir/0IMZDOBQxGJa3xoeqxOnqO1HzroFtN9yrvn5Ikrve3h
         P4jOR2rOrHjiKhRb6qPvkjuN9uzwYy/bQsizE+oXuqu37WMOeMoIyGTzCsBOumP8n35F
         lL9pbUYQ8wtVV/roDKZOVXcOugZZGUrjlK0EluezuicJda6WoDdlb7S+54bjJTWms/lE
         ySEe+l6EutfjDMt04SaU2l96bMRmCMvdXFQkY32Pu/l8GrvqQ+PZgOUz1TjY1lnImJn2
         9ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQtGaElbeCwCBcuE2Oz71cXsOc2pbKv6F4mBG+/n82c=;
        b=nIfvSlZbiHlrVbCvzruZxIbDyizDSHtfQa+TNOYYtjxbT2W8teupoABAudGw0wXNp5
         lwkTGmmsiS4MTP8K+ieU6yOOpDZx7xPRLGOhgTgpFwnQGAM4HFPS4yyr8somR4GhMY/I
         Ay4E2wgkXNUUFvXrhGAADaRcHOEsb5NJJ0RrW/ezQ2xa5WkOQYhfMqVTkrbYJgUcHjBj
         keyhkz1tZ4RQ4xs7ZrtgMUOo+BdEqwBIlTNlOmPMnc8BZmO4egPXGNsgezpMMEA11ipY
         7/MvWpg9JiDuNwysWQsLHCv8kMzPHBdF4YSSusdO7S86kZI9lw9fyyJBfvRho9slRdxf
         olSQ==
X-Gm-Message-State: AOAM533qWobnf1Q5z9xuFDZvn2kzz8MAb2hrm/yxzEGKv4wCWNgQ90K+
        At2X7L8z5aqRpNU1aFOXwkgHvcTcgOIjUg==
X-Google-Smtp-Source: ABdhPJx7H/1CUn8x7LyVlX/OEuhbL53v/3KIOyDSAHN874302E3Pj4jOMbP9S4GzpCk614kMJJSESA==
X-Received: by 2002:a17:906:5203:: with SMTP id g3mr25626868ejm.95.1618216818434;
        Mon, 12 Apr 2021 01:40:18 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id h15sm6018890edb.74.2021.04.12.01.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 01:40:18 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next] RDMA/rtrs-clt: destroy sysfs after removing session from active list
Date:   Mon, 12 Apr 2021 10:40:02 +0200
Message-Id: <20210412084002.33582-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

A session can be removed dynamically by sysfs interface "remove_path"
that eventually calls rtrs_clt_remove_path_from_sysfs function.
The current rtrs_clt_remove_path_from_sysfs first removes the sysfs
interfaces and frees sess->stats object. Second it removes the session
from the active list.

Therefore some functions could access non-connected session and
access the freed sess->stats object even-if they check the session
status before accessing the session.
For instance rtrs_clt_request and get_next_path_min_inflight
check the session status and try to send IO to the session.
The session status could be changed when they are trying to send IO
but they could not catch the change and update the statistics information
in sess->stats object, and generate use-after-free problem.
(see: "RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading
its stats")

This patch changes the rtrs_clt_remove_path_from_sysfs to remove
the session from the active session list and then destroy the sysfs
interfaces.

Each function still should check the session status because closing
or error recovery paths can change the status.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 96029d4ec26f..cbcabc893c46 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2861,8 +2861,8 @@ int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_sess *sess,
 	} while (!changed && old_state != RTRS_CLT_DEAD);
 
 	if (likely(changed)) {
-		rtrs_clt_destroy_sess_files(sess, sysfs_self);
 		rtrs_clt_remove_path_from_arr(sess);
+		rtrs_clt_destroy_sess_files(sess, sysfs_self);
 		kobject_put(&sess->kobj);
 	}
 
-- 
2.25.1

