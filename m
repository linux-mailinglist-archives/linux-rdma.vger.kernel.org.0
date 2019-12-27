Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1499612B43E
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Dec 2019 12:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfL0Lg2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Dec 2019 06:36:28 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37943 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfL0Lg1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Dec 2019 06:36:27 -0500
Received: by mail-pj1-f67.google.com with SMTP id l35so4801417pje.3
        for <linux-rdma@vger.kernel.org>; Fri, 27 Dec 2019 03:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5o6xy4w9KqWAzHR2B5q4KywrORiGxCxx72uqlsPOoG4=;
        b=jY47e1Kf0npiBUk6SHB5+l2EQyZYzJvgZoH1d9zAtsdGKiY589AbUWPKyYpZKAUO1f
         0JSS2tp85bmtbOG3Ittp7Bn7TOi2hWFwrv2++99J9t9B1imPN7V4XQRLpVwPwGebUQjX
         UP7oYF7SWnjmu6Oh8i36ZgkEc/u6FNNOEtapqn0SzgmdsrL9+/9EGavhmcu6+65kPDaa
         tOO14A2CAfihMfnZUHyu7QNBssambKKFhDrJrcex36InwnsSQvuOsaY2eWvZUhrzTMPw
         tZFIfTWlIj930YJmZH/v9RPOZNyNGxkwYVsLlDUtkE5WXdJTHj4BHcGklZrFgTluB50c
         mwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5o6xy4w9KqWAzHR2B5q4KywrORiGxCxx72uqlsPOoG4=;
        b=K0mM8F6SiRRwarnOeZll+Ka3lh4q9beyLTn8a122S8bIIz7u5bqQ+6l6w7fsxjp8Pv
         A7zFHKoFCJsXh5sJ3jt8xR/WAYPWhtq8m9oBU7jIcSWlHzCxvzIrEUqsrgpkLggTqRxz
         bgpInEYW2rxI59t2HxyQ8KS+JyPvBjl8OeNaZ+TZ2CxACDJOPv87SeM9hDG4ZF8HohSS
         wCRO9MNuxBkOni/8WOIxNm23DSaKiwzppaeg5gfy7oundaHvJACEe5zSI4GS3EMgkVTY
         GuA+V2LDJRlOF6oGcWAf4bnGwISnUozlvzzLfq2cFa8y1MV1LUZTLIOrbviIQ+N+3xGw
         r21Q==
X-Gm-Message-State: APjAAAVpBNmW0ikP0F4FPiFk8wtHLEhpRzNJMkvFMjkBTGd0DMEa9CqW
        u4tvov6qaL8nmNrXCmB7tFk6tJy3B5sPGQ==
X-Google-Smtp-Source: APXvYqyqyTg7t+qL90A/qMlJf55nH5sibVX39P52Tj9zRFNmAEHCJ0Ea5IlNRkUBokTz77rolzrpXg==
X-Received: by 2002:a17:90a:8008:: with SMTP id b8mr25654957pjn.37.1577446587075;
        Fri, 27 Dec 2019 03:36:27 -0800 (PST)
Received: from localhost.localdomain (199.168.142.16.16clouds.com. [199.168.142.16])
        by smtp.gmail.com with ESMTPSA id c19sm42229439pfc.144.2019.12.27.03.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 03:36:26 -0800 (PST)
From:   Jiewei Ke <kejiewei.cn@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     monis@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        Jiewei Ke <kejiewei.cn@gmail.com>
Subject: [PATCH] RDMA/rxe: Fix error type of mmap_offset
Date:   Fri, 27 Dec 2019 19:36:13 +0800
Message-Id: <20191227113613.5020-1-kejiewei.cn@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The type of mmap_offset should be u64 instead of int to match the
type of mminfo.offset. If otherwise, after we create several thousands
of CQs, it will run into overflow issue.

Signed-off-by: Jiewei Ke <kejiewei.cn@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 95834206c80c..92de39c4a7c1 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -408,7 +408,7 @@ struct rxe_dev {
 	struct list_head	pending_mmaps;
 
 	spinlock_t		mmap_offset_lock; /* guard mmap_offset */
-	int			mmap_offset;
+	u64			mmap_offset;
 
 	atomic64_t		stats_counters[RXE_NUM_OF_COUNTERS];
 
-- 
2.11.0

