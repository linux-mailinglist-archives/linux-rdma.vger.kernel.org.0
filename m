Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373CB4EE95F
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Apr 2022 09:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242922AbiDAH4P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Apr 2022 03:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241860AbiDAH4O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Apr 2022 03:56:14 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0B419894D;
        Fri,  1 Apr 2022 00:54:25 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id bp39so1543134qtb.6;
        Fri, 01 Apr 2022 00:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+u9zqczQO+VO7jrn2VLlynTKy/bzO3BVuchdr9Nikuo=;
        b=nj2sbGZvbWTjn9mYX46I9W9yoLP0Ke6pKI1xrZ3pM8/rzhatGBYNMxEOq9z5CubKTV
         cdNRSFToM6VsVIqYxR5gGtPPql08FEd+TzXe3zAGtlH4i9VhQJPlYrDDmNLtXuQlTder
         VNSRbmk+hFZAxCZWOLilUVn8nD/OCrjwiW1qnGSrWfed/2WFGj9hNQjMTea0qJ5hUk5I
         CVOPVfIXRbekP7JXEfp97PjGPufYEzHHCNBg+BOKqocSrJbUPDuUi5YIJ6F54iL1Xx9M
         pnjA1PD2MwTk+6ievCg1iuYvLWXIaa3ZZoNs027Ly10EowaIAh87hqEAlsSbdUZEhEmf
         NWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+u9zqczQO+VO7jrn2VLlynTKy/bzO3BVuchdr9Nikuo=;
        b=TX9CPA3LZK0Bc2lxP12LEX++ubh1TPQOn0HAb4Jex3beN2WtaZQ5nLEyJFTGJ0G0xa
         zuzVbtzmAw0ZrbZXAIJm+nlkbDP3iWMqSE1JzTZalm9CGxQIdHKC8q9FYCIn8Iarax0W
         ZrAO8QvUA3isbBwpBo74L+jVON34drVrWWCHFaXxEoPqnvmNqTXC3wqFFpqSDV1J5gHn
         ETBV4ms9rMYqs3+EoUMBAJJAQwsrLKqpqc1ez7+1mUCmWDIoacAYyDlQjVnKPGBdIgmp
         0VrMIS12JUvZkdYzOxCIbTG0Ot4+fEOshnJ/U2ZIs1cx5ll7K4bzfV6iRIrbQpRMVawL
         dOkw==
X-Gm-Message-State: AOAM530q7uJOSFghugO0n2cCqme9X4JgBp6kexNSUhRwmgiZ7C4pQ9Hn
        Yy9nypD6xdij1WLDyY0n2+xaLGuEnTg=
X-Google-Smtp-Source: ABdhPJwfuKc7yJpGenp1uWYpSA05RK1BUQFniGAYsaa1t2YAt0LFACJa0wze7ujeexNgmG9sxfT/sQ==
X-Received: by 2002:ac8:5b87:0:b0:2e1:fe79:d65d with SMTP id a7-20020ac85b87000000b002e1fe79d65dmr7571238qta.480.1648799664556;
        Fri, 01 Apr 2022 00:54:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w22-20020ac87e96000000b002eb8e71950csm1334551qtj.71.2022.04.01.00.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 00:54:23 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mike.marciniszyn@cornelisnetworks.com
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] RDMA: Replace zero-length array with flexible-array member
Date:   Fri,  1 Apr 2022 07:54:06 +0000
Message-Id: <20220401075406.2407294-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases. The older style of one-element or zero-length arrays should
no longer be used[2].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/infiniband/hw/hfi1/mad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index 4146a2113a95..09fe0eb87884 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -2437,7 +2437,7 @@ struct opa_port_data_counters_msg {
 			__be64 port_vl_xmit_wait_data;
 			__be64 port_vl_rcv_bubble;
 			__be64 port_vl_mark_fecn;
-		} vls[0];
+		} vls[];
 		/* array size defined by #bits set in vl_select_mask*/
 	} port[1]; /* array size defined by  #ports in attribute modifier */
 };
@@ -2470,7 +2470,7 @@ struct opa_port_error_counters64_msg {
 		u8 reserved3[7];
 		struct _vls_ectrs {
 			__be64 port_vl_xmit_discards;
-		} vls[0];
+		} vls[];
 		/* array size defined by #bits set in vl_select_mask */
 	} port[1]; /* array size defined by #ports in attribute modifier */
 };
-- 
2.25.1

