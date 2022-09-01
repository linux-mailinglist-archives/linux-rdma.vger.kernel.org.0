Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44BC5A90A1
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 09:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiIAHmS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 03:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiIAHmR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 03:42:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E91090B1;
        Thu,  1 Sep 2022 00:42:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o4so16382290pjp.4;
        Thu, 01 Sep 2022 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Tx/ZqonWjTRNyHxqCfN+aNIf+SBTGqvK/IVfisx4Ops=;
        b=OlpRaO3btNemHo8Hy8MkXH11Gpg5gv+ND42di1JE7LK9uxDZPpGaJelBy1QsMT97dg
         ncNKpbYtnG36jID3aLritQq3/qzsEmLQa0Xju5TxsQwS+5Yn8w/Xyd5JOO5LXA+jbAnw
         pMCYwJjq5fB6NO8jbgYa52bZC5iyIlYO3fprRjLEMxfYD/wSk1mI7rjPuoih7lJxXcd+
         I3wbxx/W9n2l28LbSPWNPXLP85xDVpJ3+pWvfY0Z87eDQdff8aM5K80zfQI8nZfJizR7
         9VZRRz0r6673InjxUokrMoyuzJXtNCKASD8sUDR9FN0aicA4mEcDt0YD/p4wjjgSso+h
         GGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Tx/ZqonWjTRNyHxqCfN+aNIf+SBTGqvK/IVfisx4Ops=;
        b=LqcRj6FYwVGppI1oFyz2SocjbfN6QOGLc659GHQr1XC5EprSCO3TdW9nN5l+l8/53d
         tkO7n0+hUTp8h+Y5cfjVT1hf3ODxKSYOOu9rBmfMZq+gHJnJAvNOuSM9PKjdBGwZwA7w
         AetJiBWvZLeCMWr1W4sQthvOP+pgHNo8p1fgkYsUTZ2k4eYJE7xCUXZzEXNaH9iZ3VQb
         EY16cZfF/eljt7zQuiERfVA4T70TI+K8qSV6aOj/xrT+mOb060qwUOBKO1ocWWxDysgN
         4UP4BuSDUtGRrAM3pk/+710b+xiECk/aMRIuUSU4cTjdl8Yn1csL+dGx8X2IJ78DI6x7
         RSqQ==
X-Gm-Message-State: ACgBeo1rFvoF+CoK1oILnGdqO8hvvpBE07w8jNkg8EzV0o2om/pJkRbX
        Tc4+RUQBAD+VBEcp+YAsyfw=
X-Google-Smtp-Source: AA6agR6wFz9kjLdJW3z1+0nmMZRJ++jSq+yx5rR2d095iOJ1baUQr2WKV7HVOwiBWVbdVAyWkgG8Eg==
X-Received: by 2002:a17:90b:3c8f:b0:1fd:e29c:d8d8 with SMTP id pv15-20020a17090b3c8f00b001fde29cd8d8mr7419769pjb.5.1662018134321;
        Thu, 01 Sep 2022 00:42:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090ab39000b001fbb6d73da5sm2618732pjr.21.2022.09.01.00.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:42:13 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     jgg@ziepe.ca
Cc:     dennis.dalessandro@cornelisnetworks.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] RDMA/hfi1: Remove the unneeded result variable
Date:   Thu,  1 Sep 2022 07:42:09 +0000
Message-Id: <20220901074209.313004-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value set_link_state() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/infiniband/hw/hfi1/verbs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index ec4f316a28e1..e6e17984553c 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1447,12 +1447,10 @@ static int shut_down_port(struct rvt_dev_info *rdi, u32 port_num)
 	struct hfi1_ibdev *verbs_dev = dev_from_rdi(rdi);
 	struct hfi1_devdata *dd = dd_from_dev(verbs_dev);
 	struct hfi1_pportdata *ppd = &dd->pport[port_num - 1];
-	int ret;
 
 	set_link_down_reason(ppd, OPA_LINKDOWN_REASON_UNKNOWN, 0,
 			     OPA_LINKDOWN_REASON_UNKNOWN);
-	ret = set_link_state(ppd, HLS_DN_DOWNDEF);
-	return ret;
+	return set_link_state(ppd, HLS_DN_DOWNDEF);
 }
 
 static int hfi1_get_guid_be(struct rvt_dev_info *rdi, struct rvt_ibport *rvp,
-- 
2.25.1
