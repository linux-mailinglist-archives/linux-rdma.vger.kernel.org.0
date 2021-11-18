Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC094563FA
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Nov 2021 21:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhKRUYb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Nov 2021 15:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbhKRUYa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Nov 2021 15:24:30 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AE5C061574
        for <linux-rdma@vger.kernel.org>; Thu, 18 Nov 2021 12:21:30 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id m14so7173196pfc.9
        for <linux-rdma@vger.kernel.org>; Thu, 18 Nov 2021 12:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NPtDKY3zQHIrhlifOBQrVsDaP/5HgYzaYhUSwrSVsRg=;
        b=nAdORjdK6MXlng6B14U7W9bMVwCkxUdc44HjUZYWokmn+o9Fruy78RMIi0EuKfh2fr
         yH3U186Qu019Tlr4jlAH0fAQKcXKSMASCHYYuzbcryaNN5yDg9zCprj+9pXNQOovUn0Q
         L3r3jbL/ZztL2IWiGyK2BjW+l4wBxDpJICc+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NPtDKY3zQHIrhlifOBQrVsDaP/5HgYzaYhUSwrSVsRg=;
        b=doOZTJiqJ7GV2DHN2tJzM4UlCIa7LApk3SpOoIrZ3XQRkHKVkW1d710nQx7tt+25Gj
         O9eGUBj2SGaRM79uqbszqO0TBS12LbLeqj/QlcWigAagsgbE3dsefHvXMznVOGvYKPwJ
         8XX2lPY7ZUgjbD2R1zShnlme0JPHBnHj9Dnjyq0rHOyNMgc5N+RIvkgJqx5LuUSWUF3P
         iTXpnUF8TAVBevDyufhsd17Z7CS0W3UHeaHKJQRpJA+LC9PYcV1dlYMJKJ6cuDaEmRul
         DFbbMsBLdocLbzRZdtKeAf3vYXQysbzfzIuobKESeNrFGr8Z+lrdwFz1isxk8L0sDsG7
         K6EA==
X-Gm-Message-State: AOAM533VRVGWDMNz8pACYNaNQGkW00eP3Ok3eOps2lgyHAcHp8vEEMAu
        yekgLfzTyrNOxeQHugoPdWuhyQ==
X-Google-Smtp-Source: ABdhPJyKrWvKRcJ3pyV+ombqFhaMRamBg42UFc7f5jzTlmLWTdD9qb1CTIEAY3Xyim7RVp2/+p4T5A==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr58477427pfj.15.1637266889691;
        Thu, 18 Nov 2021 12:21:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u2sm429035pfi.120.2021.11.18.12.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:21:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] IB/mthca: Use memset_startat() for clearing mpt_entry
Date:   Thu, 18 Nov 2021 12:21:26 -0800
Message-Id: <20211118202126.1285376-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; h=from:subject; bh=2Oxvu1fYS+Nd7p7Top4F6FCD5kXJlWjbh4cJzd7nFgI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlrXFiwg0OSPG9eDsUlPRIabyANFH36YdFsJ8apQT R6jmUeiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZa1xQAKCRCJcvTf3G3AJvS6EA Cuybx5qm56ctjo8osQI7GQCDUkeL1CwbycpT/pu+c6lmOxuL8ilwqtEdsZMe1VHwAmD+7GbThsnn/y aSNRhNH1099AO6aDrK8VpLgGjwtlun1KfxWsnLqaNPjSWTjMQIfGpc2v34/v5g2Cl0Q/Xjk5S+MnSA y/gVw0FLU/WHM47DoxRSkhj1hpEGFmktOETdfw9e4j6Jktf+6d4r5DYvQoobVwaovIt9jlcx4c89d1 Yi3wD+VbjUj2aYwRirNv2vravL2GJBicutD2nD3dX6oBgnL/FBhNECzhg6ipA9do73z8x4LdUaX3D5 Cv9G0DrfWU62UfdU/56LPpq0mVKLkEsgJJaocRSXsRuscU11pT3xIWnjZS6/AaXQJqvJF0WKVp1JQM W333vNY9X9AkZonl0bB3d3GozsNYnrDNpL2jhZHYuKlG8mX46SPy0AbFt5kfj029g++JpLVpcRjIhj eFbu/1PR9/9e/eYzJA0dXurbFP19rZDS0ORYe1rBsefFDs1+SFwZ2gvGoImPTKFI3POjQfvlN8s152 neY+IqfUBXBmjAOUSPf6ZR+8C/CYeAy3QRBUai4BrPvM5l1S57LWmHLzrMDx6WPZcTSDMyzg5RpANw GYkPX7DWOAtbubOJrAYLZv3uWtpH8IiA7F5psyETzFcGK4ognxCBcHCHoH+A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/mthca/mthca_mr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_mr.c b/drivers/infiniband/hw/mthca/mthca_mr.c
index ce0e0867e488..1208e92ca3d3 100644
--- a/drivers/infiniband/hw/mthca/mthca_mr.c
+++ b/drivers/infiniband/hw/mthca/mthca_mr.c
@@ -469,8 +469,7 @@ int mthca_mr_alloc(struct mthca_dev *dev, u32 pd, int buffer_size_shift,
 	mpt_entry->start     = cpu_to_be64(iova);
 	mpt_entry->length    = cpu_to_be64(total_size);
 
-	memset(&mpt_entry->lkey, 0,
-	       sizeof *mpt_entry - offsetof(struct mthca_mpt_entry, lkey));
+	memset_startat(mpt_entry, 0, lkey);
 
 	if (mr->mtt)
 		mpt_entry->mtt_seg =
-- 
2.30.2

