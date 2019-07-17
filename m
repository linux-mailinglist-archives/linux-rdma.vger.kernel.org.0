Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE1B6B813
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 10:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfGQIVI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 04:21:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40094 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQIVI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 04:21:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so11549160pla.7;
        Wed, 17 Jul 2019 01:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukX3X8BRlmR//HwESuIDPD9A7bwWL5k5RN/PdnrF+7c=;
        b=jn5ZE20XLizqfHuZvh1GR/0Vb7SWdayObV9Htzl/BkbTOqbg0W+7QFoJIZxyA8oisf
         ub7IPEkAXW9Ms/q6+wmNHjyyin7WDdVgXlvk01urEO2GPm0PCaJCPEoKkQFPc91QuVPP
         muiDZ7Hs9RVNqa2AU+GQ6ljzTFzuOV8zVOjnUNcPzoT9xmaErPuPEJiQ9aqNSmxc64q0
         SpJSTaCCwzye9fBQkUiJ6gjxCmbC8tXBKAfGuhGfEyNImJSP0W7IbKlfNrtpTlLbAaok
         qg/AeW7/L67AqbmG8nUaLwtTTUCF1zt7ZqU6gpOYHO0b1GA3C3POtuTvQM0kynxMXrUk
         iBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukX3X8BRlmR//HwESuIDPD9A7bwWL5k5RN/PdnrF+7c=;
        b=nen97rZI7sTDszVHwl6ef05wzhJR12+V8Te6Z0tlGHxwzJijZePENV2Rb3v5jOsYVy
         JMOwjSUCHMnFZW7vxMvXzmTux3FYrkzGp8bJz5TebCGrC3njKscYBFii9moUcR0RgT4x
         X0Tn08ozcqElt4NVJadnkNuj2FTG5ZC1ppUkNgwXkN8uOOXaW4SNTRjpc555Ka8aLhcp
         +HtzCit5orMtnMiNYygTy+Nwh3UcuslmYj+V12SCV1Wr460SQDcgeBpq8rR+EalJik78
         2P6+y9QOJ4rOarHD8xdQMWnNt9VgCEzg0vH6YhMQR9Wof/NN+IaiBnAXDtu8ylM8WrOk
         mKYQ==
X-Gm-Message-State: APjAAAUSTj8BBAbo6Ch2bzC9nU9kMgloZZXEo6+zr6sreqiHFRRBmPWS
        7WRtgt5RzmRIPEEEiViBpwrMkO/5eBY=
X-Google-Smtp-Source: APXvYqykTSlhQOSKNw5mHZfzwq6N10owDSgGGDbZSWEvVhka6bdL8xOstcLiMbxvuo3Sai44hpxjHA==
X-Received: by 2002:a17:902:b186:: with SMTP id s6mr41487960plr.343.1563351667968;
        Wed, 17 Jul 2019 01:21:07 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id p187sm34516844pfg.89.2019.07.17.01.21.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 01:21:07 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] IB/mlx5: Replace kfree with kvfree
Date:   Wed, 17 Jul 2019 16:21:01 +0800
Message-Id: <20190717082101.14196-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Variable allocated by kvzalloc should not be freed by kfree.
Because it may be allocated by vmalloc.
So replace kfree with kvfree here.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 5b642d81e617..ea4b41b260b3 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1813,7 +1813,7 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 	if (valid_req)
 		queue_work(system_unbound_wq, &work->work);
 	else
-		kfree(work);
+		kvfree(work);
 
 	srcu_read_unlock(&dev->mr_srcu, srcu_key);
 
-- 
2.20.1

