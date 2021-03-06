Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AF532FAFA
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Mar 2021 14:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhCFN5A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Mar 2021 08:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCFN4e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Mar 2021 08:56:34 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6427C06174A;
        Sat,  6 Mar 2021 05:56:33 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h4so3310677pgf.13;
        Sat, 06 Mar 2021 05:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mP/fGr95eJFblYXshsxaEpdCW6F9kKfFIodDDJ+QLn0=;
        b=ufW8o25oqAIrj9gCsVPfgMlxe09TBHBtjCaflszArCK2qbJ3VvihRJQ4231BTleoQ1
         Bs1InY3v9BJC7yM7K3Ly4+/3LFnFNFha8iJILzc3FzRcPg3ZGmnzQbJzjMc9IzXhDUQ0
         012eUci+xtORmTmDs5l7G/idWuMA5/t7SCV6mzGHSR/jmHJ8TqTQJ0LFoHUhKkECRKE3
         WSJqtftPVjhkj1wY/VjvnGcgkk5U8X+Tg/b6kI7kBxLHTVE1LdNBwB93LPcKlKYaf2OV
         gk8NtNdQqeBsnOMHb8a35/3/PCs7fHPqx202LT+n3DON2gh4yb248fLDk7k52GDldqvT
         EYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mP/fGr95eJFblYXshsxaEpdCW6F9kKfFIodDDJ+QLn0=;
        b=nc48mFF9kz1A0nv/zTU//C9VElB3Wxq1p1JrsWHGviHT/PZ0cM3Co42wCIqxaBKS6Q
         1LO8BLwJoByD8OphlStjvBKYqPnW80eVD2hzNDj3OlsvaulXUnnpSN5SRAE9DicLa4cR
         B+TbZLJbvgs3wHMr+ebo4SEXpbQsIaK3K/8BNBti9msRnh9qovSOxocLKxBg2AH3fUlT
         waRFryCfN+JLXffnIx6d4B3EneB3n3bc8NMS0Oyp/nhjAYHWlDQ1glEd51/n8/eeFrJx
         Ykd0r/EwPwrUi/aADLqkVFFoFyqG5bhGRqpGxK3gq/BXMZljquMgtzxiEM+GqOtwrFGl
         FZqA==
X-Gm-Message-State: AOAM531yNFDz7qMkX46hjfY0uTYQMf1rH56cSfFBtOtD8LWn8rPMv1F3
        cCeFKGno68VuNs/X67LQlUWsCavQQus6sg==
X-Google-Smtp-Source: ABdhPJwvYVYfOkpoIcigU94RT5EBC07v2mu9pgglrwD7MIqu8o3+rT9JtVYx/Vy0f1hBjUbD9I+0ng==
X-Received: by 2002:a62:aa02:0:b029:1ee:3011:114e with SMTP id e2-20020a62aa020000b02901ee3011114emr13795578pff.39.1615038993225;
        Sat, 06 Mar 2021 05:56:33 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.66])
        by smtp.gmail.com with ESMTPSA id d7sm5364119pfh.73.2021.03.06.05.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 05:56:32 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     bharat@chelsio.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] infiniband: hw: cxgb4: fix error return code of close_listsrv_rpl()
Date:   Sat,  6 Mar 2021 05:55:48 -0800
Message-Id: <20210306135548.17939-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When ep is NULL, no error code of close_listsrv_rpl() is returned.
To fix this bug, close_listsrv_rpl() returns -EINVAL in this case.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 8769e7aa097f..94492d2dfdc7 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2400,7 +2400,7 @@ static int close_listsrv_rpl(struct c4iw_dev *dev, struct sk_buff *skb)
 
 	if (!ep) {
 		pr_warn("%s stid %d lookup failure!\n", __func__, stid);
-		goto out;
+		return -EINVAL;
 	}
 	pr_debug("ep %p\n", ep);
 	c4iw_wake_up_noref(ep->com.wr_waitp, status2errno(rpl->status));
-- 
2.17.1

