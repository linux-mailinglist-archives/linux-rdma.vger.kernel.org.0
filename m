Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212E43D2F0D
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 23:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhGVUnI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 16:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhGVUnH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jul 2021 16:43:07 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D09C061757
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id z6-20020a9d24860000b02904d14e47202cso150999ota.4
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HQ31i/pqFNTDrQ+NUGSeG0oHZz1HpEMJc3Rnl4Gn9E=;
        b=px0l3XWMBT7+nbJLJYtlz7W/LGhoJcILrlTeC5xJOkGnGaDqGDcogRrtOtW3rwrYhN
         v4LZl1/8sTdKxPpNWF/MbvHeTICyHc7J+86WiljJkECeQDU8hVrR6Tkm9RAbC0SVqI92
         BzNQgPZY0jpi/PYlUuv4p8DigCbdVNP8wNARk/zvXuCvX/3IlahGpZRvW0c0IiBjDihq
         AbInLE1TdnpCYa0jTbbxocF7ePw2vhQUgCO9Mfyd5l9JvNbK1xwuvwxWz1Su7kebBqbc
         JUs/0FA9TKkG9q4h9UtH8qwildW2Wk3ZmVVRcv614xXzvlNT2/tCuP5Ij8+i5qwqqTwT
         0MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HQ31i/pqFNTDrQ+NUGSeG0oHZz1HpEMJc3Rnl4Gn9E=;
        b=C+oHAPNTXWTAw5rLBYU6xcOU/iPja3uDYkIp6+MlUmJ8SEGCjh6dhuahn8XVtMEkJT
         42PBjl53ID8WVsjxOzS/ISQJqyU66W+u+Sj4+LJLfsIYqX9Alno2cReiQ8IZJg4eIezW
         sTBDp4O3L9vkLWoWfE4h4tX66fGFDq4RQpRZlrGY8+KeenkiVSngX3msTyZkhp8YOmJj
         whQfXw19Q8Q75+QVI7rApm4Xy9Z9R6ALLKISIlwnKSWaayB3erkbadRHMvnGYTij/BkY
         o+WaIrXAQDRiGEzqKJRKq/9Me3FnK1FT60usdJM73rd1caYKYVFXE05eDcI21ZUwIo6z
         zJ5w==
X-Gm-Message-State: AOAM530bshHQNItO0ils8l8NQonNlMbmz0o2cgUo6kK3Yk+KnFVb0AiX
        sXhd/YoMiXRbRgXjtvtG0nQ=
X-Google-Smtp-Source: ABdhPJyDShMBK/4WFKwWZ2gE3ncHOa361QfAdKluzdt67D9k29FnkoD2b0b1qeCItgJkNyiZ/DuqkQ==
X-Received: by 2002:a05:6830:1e34:: with SMTP id t20mr1132403otr.166.1626989020802;
        Thu, 22 Jul 2021 14:23:40 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-d50d-298a-08dc-a5ed.res6.spectrum.com. [2603:8081:140c:1a00:d50d:298a:8dc:a5ed])
        by smtp.gmail.com with ESMTPSA id p186sm2699937oif.49.2021.07.22.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:23:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v3 4/6] RDMA/rxe: Replace ah->pd by ah->ibah.pd
Date:   Thu, 22 Jul 2021 16:22:43 -0500
Message-Id: <20210722212244.412157-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722212244.412157-1-rpearsonhpe@gmail.com>
References: <20210722212244.412157-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The pd field in struct rxe_ah is redundant with the pd field in the
rdma-core's ib_ah. Eliminate the pd field in rxe_ah and add an inline
to extract the pd from the ibah field.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 500c47d84500..6e48dcd21c5f 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -46,7 +46,6 @@ struct rxe_pd {
 struct rxe_ah {
 	struct ib_ah		ibah;
 	struct rxe_pool_entry	pelem;
-	struct rxe_pd		*pd;
 	struct rxe_av		av;
 	bool			is_user;
 	int			ah_num;
@@ -486,6 +485,11 @@ static inline u32 mr_rkey(struct rxe_mr *mr)
 	return mr->ibmr.rkey;
 }
 
+static inline struct rxe_pd *rxe_ah_pd(struct rxe_ah *ah)
+{
+	return to_rpd(ah->ibah.pd);
+}
+
 static inline struct rxe_pd *rxe_mw_pd(struct rxe_mw *mw)
 {
 	return to_rpd(mw->ibmw.pd);
-- 
2.30.2

