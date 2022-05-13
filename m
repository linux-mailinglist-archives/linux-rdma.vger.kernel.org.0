Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0873B525D35
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 10:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378015AbiEMIQ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 04:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378152AbiEMIQz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 04:16:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA23AA51;
        Fri, 13 May 2022 01:16:51 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g184so6863658pgc.1;
        Fri, 13 May 2022 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QphxsuF1+5UCD6DLtCeutdc7OVl7QRJxGkoHeWbl8C0=;
        b=IvvwMGEsMqcGPmx/CBghMFa7TubJxwo4TK2BvVGxEZaWITJ3iatoM8Fn/Z4IJ+ZxHC
         uvNBtnfOMiOjVdL91H1I6LCWKDaqNMzajjxgqgOoyT1EFtDpnZyGOVjYUI8C+hYRodBi
         Et3Z2kH4Oqnb2qCDHKQGvyp4HW3ATOKZ82XcD/XSdBmDrpU1oVy1DQZGLgWCdyaLwNzN
         wfVw0Vd9aAhBfEOkmtHq+Q6ZUVkN3jaWtaZ5eJ2w8GDqCewReuAPacFkelKctgOTswVb
         TUVsveYPypjxf7vcKrCEgwxGetM08rCKUBYEuexekfeEL5AGE2FSCBKCZKe+1t1MgphH
         FIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QphxsuF1+5UCD6DLtCeutdc7OVl7QRJxGkoHeWbl8C0=;
        b=zjqlI7gh0achFYy7r04Th5oIg71tLCmVkYCoZV8kXPfd0m8K3PdBlb4o5JhrluSlgS
         XuIv6wTDGyzbJy+sMg3puJeb5BkQAGv2GA0GHZHoeCrMtylZhZj3wcVyR7MOt7T5/1SF
         YXzlo36pVo5/Z+2G1Kd+c65BLt+qSLoVwVzJVWc8tSM29wYg+SLrw75VqbS6MEyczNvz
         EJbCbuxhbWVlo9qO5YsRl0RmeaXYf6Fka+JPHes0prpDzwEvPcjolVj0pUhM0eKUJVjW
         PzwOxyQOB8xxEkanl+WlwJQAQK1qoqigmL4EOzdlYIlS/QERFlaulrUftasGf5Wo2uWH
         CruA==
X-Gm-Message-State: AOAM530sc/nsMEFmxtdNjKqgc455mbfbMHsocVbiQFGEmBAWof0y/oKe
        myjqNkqLxiLeTSEjloojaCY=
X-Google-Smtp-Source: ABdhPJzYQtZFlhQlqMAo7DzNiAgXMXd5lf1HIt+f4KLvFJHnUpD/ji6eDJ8gNQ2gFBO63f50w5oHnw==
X-Received: by 2002:a62:fb0f:0:b0:4f2:6d3f:5ffb with SMTP id x15-20020a62fb0f000000b004f26d3f5ffbmr3335776pfm.55.1652429811253;
        Fri, 13 May 2022 01:16:51 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0015e8d4eb21fsm1221141pll.105.2022.05.13.01.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 01:16:50 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     mkalderon@marvell.com
Cc:     aelior@marvell.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] qedr: Remove unnecessary synchronize_irq() before free_irq()
Date:   Fri, 13 May 2022 08:16:47 +0000
Message-Id: <20220513081647.1631141-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Calling synchronize_irq() right before free_irq() is quite useless. On one
hand the IRQ can easily fire again before free_irq() is entered, on the
other hand free_irq() itself calls synchronize_irq() internally (in a race
condition free way), before any state associated with the IRQ is freed.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/infiniband/hw/qedr/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 65ce6d0f1885..5152f10d2e6d 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -500,7 +500,6 @@ static void qedr_sync_free_irqs(struct qedr_dev *dev)
 		if (dev->int_info.msix_cnt) {
 			idx = i * dev->num_hwfns + dev->affin_hwfn_idx;
 			vector = dev->int_info.msix[idx].vector;
-			synchronize_irq(vector);
 			free_irq(vector, &dev->cnq_array[i]);
 		}
 	}
--
2.25.1


