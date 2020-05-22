Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28E11DEFB2
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgEVTH2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 15:07:28 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:54182 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730934AbgEVTHY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 15:07:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49TGFl468fz9vYjM
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 19:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MobzN3rSiX8Q for <linux-rdma@vger.kernel.org>;
        Fri, 22 May 2020 14:07:23 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49TGFl2Rtqz9vYj0
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 14:07:23 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49TGFl2Rtqz9vYj0
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49TGFl2Rtqz9vYj0
Received: by mail-il1-f197.google.com with SMTP id v14so9403116ilm.10
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 12:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GqvlCL3YCiisEEkN1nE+zCOiLTKK/vy+pKY1F1obogc=;
        b=Ub12prvPt5LliMcyXiag9XYSLrX8M4XDcymjJKBntdT4cjbA48Iob+DQdcEyhyL4YM
         GN2meZemz5wENrjSAdEjGRpuT6LBIwG55KeA3mKcF7GPr1XVytpcqswbegK+bPVZPTe6
         Ca4Xdp9uNRZYjEAurkBDwhumC2rNpc4nwwIwUYTX5bX70pTHUu1TUSPExhRwsUDNr01p
         xM7EQdLMT0Q6rRxMBvhpDWFogSoohx7RDaan2A7iwEXv8eneZDeaIiQHfOxWyM21Ei/F
         QBaY1JprIoXC0SYSSwGu4T8GpPyxAMmUjY8oKxEyVlzGRDRl0xZUPYNc6ueZ+B3/wOUZ
         CqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GqvlCL3YCiisEEkN1nE+zCOiLTKK/vy+pKY1F1obogc=;
        b=VoDYDPGmegorJtuDkikhL9ehFnZvPc8rC8lifcy/BSwzp13/9iJiJoxdkqqay/2PgN
         bxOEN/mxx36v5g0meVv0Dj7jmAiVvjAL99rCFRr2VSgzqzkWq+3P9WHlxSRta+HlHyU8
         omom0QbGJy1tj73twhavfX4fBJHWR7gub/9yydUpWZ7/wZ9ROcRWf8omAGlHejZYcEvo
         00dgkoEi/QoHtfmyUujxmROgnqJfEnA3H/qdQylGVzebGX+2tYByaxh/8pafe+/egH9O
         xEAmAEnkO0miYy5Zhg+7iZfYWJlSo5mZWk9clJY+yes7lLIX5udPEaXACLtRTQKS/Yax
         dhCA==
X-Gm-Message-State: AOAM531Rcfy+cVQ1SFgqHxb18uqD0WHNfERcE62BNx8xDZ+eabFJah7r
        VOcYhZ5dvyh01VwVPLUK98NEo9mPTWMENauXhWiIgSUMrH5oHdOtUhle0GmHca6MN8bmtv2B0uk
        oejKUMs7EZpbjf6gP0SR0Uxxmjg==
X-Received: by 2002:a02:cc45:: with SMTP id i5mr9861768jaq.28.1590174442902;
        Fri, 22 May 2020 12:07:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIFFNlgaU/eThYhW9DqhVOj6LZHR21fL4hjoeIBf5EJwZulCvNJ6ZQz7PbPCf047iwbuPoJw==
X-Received: by 2002:a02:cc45:: with SMTP id i5mr9861736jaq.28.1590174442518;
        Fri, 22 May 2020 12:07:22 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id a17sm4939092ilr.68.2020.05.22.12.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 12:07:21 -0700 (PDT)
From:   wu000273@umn.edu
To:     kuba@kernel.org
Cc:     tariqt@mellanox.com, davem@davemloft.net,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH v2] net/mlx4_core: fix a memory leak bug.
Date:   Fri, 22 May 2020 14:07:15 -0500
Message-Id: <20200522190715.29022-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function mlx4_opreq_action(), pointer "mailbox" is not released,
when mlx4_cmd_box() return and error, causing a memory leak bug.
Fix this issue by going to "out" label, mlx4_free_cmd_mailbox() can
free this pointer.

Fixes: fe6f700d6cbb ("net/mlx4_core: Respond to operation request by firmware")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/net/ethernet/mellanox/mlx4/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
index 6e501af0e532..f6ff9620a137 100644
--- a/drivers/net/ethernet/mellanox/mlx4/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
@@ -2734,7 +2734,7 @@ void mlx4_opreq_action(struct work_struct *work)
 		if (err) {
 			mlx4_err(dev, "Failed to retrieve required operation: %d\n",
 				 err);
-			return;
+			goto out;
 		}
 		MLX4_GET(modifier, outbox, GET_OP_REQ_MODIFIER_OFFSET);
 		MLX4_GET(token, outbox, GET_OP_REQ_TOKEN_OFFSET);
-- 
2.17.1

