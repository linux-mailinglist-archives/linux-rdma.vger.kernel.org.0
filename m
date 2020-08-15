Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A644245274
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgHOVvZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgHOVvW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:51:22 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7DDC0612B1
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:06 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h16so9263931oti.7
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ayZBf+VDszLARBRcSdBoT4Z20ZJ+0ZRAbW3EEZQYw4=;
        b=BU8x6KkNDaowY6cbAnVEsnCyMyLT9/G8wa36pVfqyVmrLDBCDnQUE/hJRv/Y9fY49j
         7HcmVDNBhGlFegyqmW1qzsFujoRqgtM1Q9G5vf4o/0yYBha3y2ihE3TqATP1cDASFgEc
         gqUQE2zRVeiEFcCzdnzavVgAVZDNTYLuKs1mpZtE/Ie3+jZkh9fasObySFz070NsHsl2
         9CTubjeIxoCDeTTIxMnDx3J9FQ1gx1bcU4XwpsF89JqkcUzA8oTkkrBspXL/Uv3JgZ/V
         os4McXzUuiNaBQKDD1EW1GFAZSxisa0NUj3CNTBbEc9gDPm5VgStyF8DgWqDQCLCya2b
         ZjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ayZBf+VDszLARBRcSdBoT4Z20ZJ+0ZRAbW3EEZQYw4=;
        b=PVwJJ83E3C1au0gphQdtuQE4sooIh9+wRB3PWLnO+EIJo5FN0IIwreHjrgKXrkQUsK
         rIqzt+gDlCvchXzWMTyHjpv7DHiMOEKplRLmTYVxDPozx9xz/cJs18hCzxvwYpboMH8o
         QOYBpv4X/5Y1537qiVok+2CV4/B/N0Ircn6HhSb0wrFP/44rOGpAG73U9z49Bue7XBeN
         cRDLyZCqSANsAERWKnjcd8XY9R45jkdfBipC0MZHGKbhzhEG6K6JQu4cksOrJATcm8ZQ
         yQBRD6NDgQkbHtIfpIhmkWn0kqI9c3m2gOA3xVCSug+bWnP5d+nBIcUBp1Ya0ZWRIeVR
         iWxg==
X-Gm-Message-State: AOAM531CN0tehaFiOZ+jfbb6IhqaSZ7Iq0qtskg/o1jLk8dqP64zh4m2
        +dFbqym527Kjxl+ugVadVTFZmdZJPz8FuQ==
X-Google-Smtp-Source: ABdhPJznVVUeb5czsQMypc2sil6PNz+Rx+s/TWjrM0tGUF59WnArDAdQ/vA9i8Q+sGGBS1TIynbisw==
X-Received: by 2002:a9d:7f89:: with SMTP id t9mr4399095otp.278.1597467605392;
        Fri, 14 Aug 2020 22:00:05 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id m8sm2195715oim.23.2020.08.14.22.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:05 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 14/20] Addresses an issue with hardened user copy
Date:   Fri, 14 Aug 2020 23:58:38 -0500
Message-Id: <20200815045912.8626-15-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Copying to user space from the stack instead of slab cache cured
a kernel oops that was toubling me.A

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/core/uverbs_std_types_qp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index 3bf8dcdfe7eb..2f8b14003b95 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -98,6 +98,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	struct ib_device *device;
 	u64 user_handle;
 	int ret;
+	int qp_num;
 
 	ret = uverbs_copy_from_or_zero(&cap, attrs,
 			       UVERBS_ATTR_CREATE_QP_CAP);
@@ -293,9 +294,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 	if (ret)
 		return ret;
 
+	/* copy from stack to avoid whitelisting issues */
+	qp_num = qp->qp_num;
 	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
-			     &qp->qp_num,
-			     sizeof(qp->qp_num));
+			     &qp_num, sizeof(qp_num));
 
 	return ret;
 err_put:
-- 
2.25.1

