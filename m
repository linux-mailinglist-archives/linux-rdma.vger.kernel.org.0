Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0572044AC9F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Nov 2021 12:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245757AbhKILfU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Nov 2021 06:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbhKILfT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Nov 2021 06:35:19 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4F7C061764;
        Tue,  9 Nov 2021 03:32:33 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p8so16874851pgh.11;
        Tue, 09 Nov 2021 03:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GB9eKxjcBWCxwS/HtKqmjwwInWPDBMBcitrchXMAIUQ=;
        b=IvNLqajfGqrJ0qgsizV3KEbbplvjVdxPWkqrdE2iDY6VI/8FIUNqeIZFznTqvQNdHa
         QPLN7jq3KSrVZmezG/XUSXA8GgRV0DwBg0tpSunadET4fbtELRV88tvcOIaO02buZZk3
         ubewEQu8/6/KzuUNTyrr/lqX2/sqr51yHpGcnkJ8yPzyU02UDfWyEzb9VpzE2I6AR9KO
         kfLkzvnXIKwoHhgtdTETkONHJKpQC5IPEW/MRpCvpGlN708+nIaBVv3W/xk9LfvFdmc4
         Y350o3IjE5RPZvAtXU1rU4e0YoVraypmYMTUK+1bMGIHtP3Vx3JUQ+LdOzNf3yMzJ84K
         uV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GB9eKxjcBWCxwS/HtKqmjwwInWPDBMBcitrchXMAIUQ=;
        b=A7Ipd3Y9/IOjxbOMiyssLtsNjEIjsvjrNDXO3cwdDRiQec6a7r3+0OhxLJFjgchy5y
         QrbAG2ZaSJRweD5x0R9Om4WSfSWouGKLCa1x/KWiH4lHxLY9IUjRA4LUgH/M1NNpcGOk
         WuE3SwQgxVAr14HbwGrEjsF8+iTD8NoOI/n5MrJ0cRfB4ZbGE3C8IyPjaHNGRvgdw+8e
         /c25T7tN8C9FIspsqPgWusSFruVt09+J6MdGMTRgWZGGOIyW9isdb7o4MtXtv3zI+tbP
         0LUlehIBDHEnjOPXIdA9lMlu7XXJ8fITaRva1WviBoj8EAqrtyC9sqqB48j1wfWPxDWj
         MhDA==
X-Gm-Message-State: AOAM5328yyR0QjiyoqRNpk1XWJKBETFFCMlnaziDamzQnjUmjXsT572d
        I/WqehUIq06HDJ9ggpdUZBlsE+VOLLw=
X-Google-Smtp-Source: ABdhPJzPdn3gAAyafPOj0XavlF+c4x4kvNZffTHaIj7Te4ANaiTvZ6tWL00QM9CG+sBBAWVvdj2kCA==
X-Received: by 2002:a63:790e:: with SMTP id u14mr5559458pgc.478.1636457553410;
        Tue, 09 Nov 2021 03:32:33 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c1sm10504860pfm.77.2021.11.09.03.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 03:32:32 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     selvin.xavier@broadcom.com
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] RDMA/bnxt_re: remove unneeded variable
Date:   Tue,  9 Nov 2021 11:32:27 +0000
Message-Id: <20211109113227.132596-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
./drivers/infiniband/hw/bnxt_re/main.c: 896: 5-7: Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/infiniband/hw/bnxt_re/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 4fa3b14b2613..2ce0e75f7b2d 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -894,7 +894,6 @@ static int bnxt_re_srqn_handler(struct bnxt_qplib_nq *nq,
 	struct bnxt_re_srq *srq = container_of(handle, struct bnxt_re_srq,
 					       qplib_srq);
 	struct ib_event ib_event;
-	int rc = 0;
 
 	ib_event.device = &srq->rdev->ibdev;
 	ib_event.element.srq = &srq->ib_srq;
@@ -908,7 +907,7 @@ static int bnxt_re_srqn_handler(struct bnxt_qplib_nq *nq,
 		(*srq->ib_srq.event_handler)(&ib_event,
 					     srq->ib_srq.srq_context);
 	}
-	return rc;
+	return 0;
 }
 
 static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
-- 
2.25.1

