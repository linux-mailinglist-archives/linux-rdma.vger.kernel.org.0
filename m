Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B576B77F1E6
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Aug 2023 10:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348746AbjHQIO1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Aug 2023 04:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348779AbjHQIOB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Aug 2023 04:14:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DDB2112
        for <linux-rdma@vger.kernel.org>; Thu, 17 Aug 2023 01:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ED9164B9C
        for <linux-rdma@vger.kernel.org>; Thu, 17 Aug 2023 08:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DDBC433C8;
        Thu, 17 Aug 2023 08:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692260039;
        bh=wO91H5RA4KceTvtg5KPSjJCtTGNXOMXSK7pecLLr8R0=;
        h=From:To:Cc:Subject:Date:From;
        b=bOL2FJZ9+TsLu9M9XN/wDztJtQBDFSs7swgML5OBw46kdJsbR9U75r/R/qLaGO6EE
         tdbsIyej5H2txdbQjCQiJ5JfEfYTPSIjlWstcZym5oBNiJnVgYuD2AGEXC+wIqsfbF
         olCvYOn2dpDv+HZYf102WUt9zp/X4kfRuNetFt52+U37WrFtd48Iqp3wP/6Tb9p6/N
         eChv1FRN/BTPVbK5oX1KW6reu57sncD4BnVKl8XAplvntCtbvDwC9AjgUxoCTbI0vH
         VdMPq91T3JPLsx/E3VUbnFwfrVokzw8su1BqxwogDb48vXJaJ/F0UY7Da5lclgl6zS
         b9VLSxpscDZVw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        kernel test robot <lkp@intel.com>,
        linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Sindhu Devale <sindhu.devale@intel.com>,
        Youvaraj Sagar <youvaraj.sagar@intel.com>
Subject: [PATCH rdma-next] RDMA/irdma: Add missing kernel-doc in irdma_setup_umode_qp()
Date:   Thu, 17 Aug 2023 11:13:53 +0300
Message-ID: <2c9bcd2b773c400a1699bd7973e22bfba1e4b379.1692260011.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Fix the following warning reported by kbuild:

drivers/infiniband/hw/irdma/verbs.c:584: warning: Function parameter
            or member 'udata' not described in 'irdma_setup_umode_qp'

Fixes: 3a8498720450 ("RDMA/irdma: Allow accurate reporting on QP max send/recv WR")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308171620.m4MNACWz-lkp@intel.com/
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 660be7f13060..6cffe21558fe 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -573,6 +573,7 @@ static void irdma_setup_virt_qp(struct irdma_device *iwdev,
 
 /**
  * irdma_setup_umode_qp - setup sq and rq size in user mode qp
+ * @udata: udata
  * @iwdev: iwarp device
  * @iwqp: qp ptr (user or kernel)
  * @info: initialize info to return
-- 
2.41.0

