Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25E93495A1
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhCYPdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhCYPdW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF54C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o19so2914648edc.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HhVx1qvpKQuOED1dbX7QsOSHog9nYZgq9x8tGGtbok=;
        b=CGdxfiJA0/NZDSv69bHhrpYkaSLF7F+C8GJ7Qa1Aq4uJ3BgRnBxPdbTfakgHqKTNYE
         kBAca/nG3cwIHuCwKRd9WYSIz499ajHauhhnVC88Xg2tjXbwdXmiPR6zYZfUdb1nthmp
         R+qkmpueXXbyjWTqx/qvPYHLxqOq/d0mkGbTr2P1Hx20Dk1miHkxG2sVbcTIuLaP7QKL
         Ke7lvDVwDIidzodNVgg3WiB+92dpHJvi14WtunQyS7DeVlgBAhIe3pyty1hDKMZKI19/
         QuAjrxLONk+WT9aU043lln+EYdSXnzuxLM9S7HpWZ/e3HUOw7kJuy2EA4XxeXuNVbkQf
         ffvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5HhVx1qvpKQuOED1dbX7QsOSHog9nYZgq9x8tGGtbok=;
        b=fzDPmK73LRkEwB/ws0vfBhnpVSfIqTjHuuNAzp8aoH+gb0K6qgyS6k8AyA8rkFHqdi
         UZDEs1wy9hSyeES1fedsgUOpyIHOKhqd4qrF8/0qaB8uj0GDJBLbXHAJZ/FPw0Vha2Mj
         hLTIO89Mr4q3IPZMA+jToBeUlqwIc/+Y/3Cr5FxyBZE1wdU69SnbsIhD5aIeGcGXbH5E
         XmfAokP7bAMmM3tyA+YZ9UM4nYKpMJEWbxmXDzsU0hxpP9vylwVo/P/zV5o/8B7++mrX
         CH63X+Nm2MfftSBIQ6jkPXk75XCLHHqtRrTutQbYi57KZbAZbheXuoPwKOsmMtzKKGkJ
         eL+g==
X-Gm-Message-State: AOAM532TpIo7GgJ9FQFWcYoJ0AyEn8lic99mdbjv6CZxZVUOzdoTDR0y
        678MgpM16T6CVIIf8944gSZenOgJ1mUZaoIR
X-Google-Smtp-Source: ABdhPJwXFZQbv6c+s0JtrT/HCNVtl9v41YEw1FNL20/KMhTvD++5xweTBZicLU3p1Sm0SbzL1AUsnA==
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr9688671edv.300.1616686400466;
        Thu, 25 Mar 2021 08:33:20 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:20 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCH for-next 09/22] RDMA/rtrs: Remove sessname and sess_kobj from rtrs_attrs
Date:   Thu, 25 Mar 2021 16:32:55 +0100
Message-Id: <20210325153308.1214057-10-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

The two members are not used in the code, so remove them.

Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>
Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 --
 drivers/infiniband/ulp/rtrs/rtrs.h     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index dd841121dc2c..124197e3162f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2912,8 +2912,6 @@ int rtrs_clt_query(struct rtrs_clt *clt, struct rtrs_attrs *attr)
 
 	attr->queue_depth      = clt->queue_depth;
 	attr->max_io_size      = clt->max_io_size;
-	attr->sess_kobj	       = &clt->dev.kobj;
-	strlcpy(attr->sessname, clt->sessname, sizeof(attr->sessname));
 
 	return 0;
 }
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index 8738e90e715a..a7e9ae579686 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -110,8 +110,6 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
 struct rtrs_attrs {
 	u32		queue_depth;
 	u32		max_io_size;
-	u8		sessname[NAME_MAX];
-	struct kobject	*sess_kobj;
 };
 
 int rtrs_clt_query(struct rtrs_clt *sess, struct rtrs_attrs *attr);
-- 
2.25.1

