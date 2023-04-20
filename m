Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8247F6E9CA4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Apr 2023 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjDTTsP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Apr 2023 15:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbjDTTsM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Apr 2023 15:48:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED0559E;
        Thu, 20 Apr 2023 12:48:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso1946626b3a.3;
        Thu, 20 Apr 2023 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682020090; x=1684612090;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Qxsza7eP5IF7aASEaN+RdsPVmgqdGGjin9oWqF5Ql3Q=;
        b=eosjcBqu8qenDXqG8JVkAV6RuT26VO8FXqn6JkY+c1g1/+KZfuWtAOBfzdP7TssKhj
         bfZJmCkghv0C5rqsJ3jDRUKHL1EM/ULcy58LbsOPhHQmlcuehmLjX+i1/KWWL8Pb+PHy
         gMStuXNW0PuofEQKN7kUvFsmx0toYqyTp4OvkGmrthvjnNrvjFmq0RIySYbif4dxKWY6
         SHdgMsUsFbUA736IVayjRkO/gQGRDZjBGmCW053lAhBuvV38kznT6z2WGXnmAgixGqPa
         BSuDo5O+K9qNHFDqwCtL6qLzatjKtpXayCAwA3l6+Who/Puy0QP6xeWtyY06/SD9K1ME
         5I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682020090; x=1684612090;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qxsza7eP5IF7aASEaN+RdsPVmgqdGGjin9oWqF5Ql3Q=;
        b=USXWpz+eoCdLl8uT5u/Efu1GOQXl91vU4td3qUCSd0WSQxjyEWSnUBTjj868LMJLM5
         p7sk35HLbmmV/nd9+gIOHTNbYOjKYhW3vWsad9aQ3q++hmYyDFCY6F1FI4J+gMdzN0an
         vwLp1JhaLSLC8XOSebJ9U8LTVAYm89T7Q8VbyJh/KitF4GdnIfiEpD4CfbWSEtSWCl5V
         adZ09zCu/szmhmFPWlzMJfATjlZ4Z473bgoQ6wbu+Mg0raU/RT1DBexV/9icuFaeshid
         28jXgr6o8Dfm/1/ZmPvfbu1P1EZeBFeJcmYyWWcmQR10/eaA7MujYy5GBAqN4lNJL98n
         zeOA==
X-Gm-Message-State: AAQBX9f2SYntGmcYcUWofIAlc8iJhh8+2FG7XJtLeAGLMTLbZUvjnw0h
        2Avm7XpylTYOoRAkIwv3dFCSDCmPJDU=
X-Google-Smtp-Source: AKy350YtxYs4cgPUeKgeZGeQh8HwriDGoWgkOyu2OI2D+/s2NwlX1Ozb2RajHWZmm/WHXDz9glToRw==
X-Received: by 2002:aa7:8896:0:b0:63c:6485:d5fd with SMTP id z22-20020aa78896000000b0063c6485d5fdmr3044041pfe.2.1682020089663;
        Thu, 20 Apr 2023 12:48:09 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id fa39-20020a056a002d2700b0056d7cc80ea4sm1606761pfb.110.2023.04.20.12.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:48:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 Apr 2023 09:48:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] RDMA/irdma: Drop spurious WQ_UNBOUND from
 alloc_ordered_workqueue() call
Message-ID: <ZEGW-IcFReR1juVM@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Workqueue is in the process of cleaning up the distinction between unbound
workqueues w/ @nr_active==1 and ordered workqueues. Explicit WQ_UNBOUND
isn't needed for alloc_ordered_workqueue() and will trigger a warning in the
future. Let's remove it. This doesn't cause any functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/infiniband/hw/irdma/hw.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1901,8 +1901,8 @@ int irdma_ctrl_init_hw(struct irdma_pci_
 			break;
 		rf->init_state = CEQ0_CREATED;
 		/* Handles processing of CQP completions */
-		rf->cqp_cmpl_wq = alloc_ordered_workqueue("cqp_cmpl_wq",
-						WQ_HIGHPRI | WQ_UNBOUND);
+		rf->cqp_cmpl_wq =
+			alloc_ordered_workqueue("cqp_cmpl_wq", WQ_HIGHPRI);
 		if (!rf->cqp_cmpl_wq) {
 			status = -ENOMEM;
 			break;
