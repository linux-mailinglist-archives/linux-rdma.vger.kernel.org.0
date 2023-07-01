Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9774C744595
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jul 2023 02:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGAAbG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jun 2023 20:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGAAbF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jun 2023 20:31:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8457C3;
        Fri, 30 Jun 2023 17:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RBpz2fZC/U366DIwH0YEibiccdS5Co/IeF/YPHR6Roc=; b=1ZGT2PWzzLcXtNg6Yf0k41fEEN
        Ho6yyaJ71YXbaqonH7Wqzihipz34Ev976je8vJ/XBJpPk5aOhIWNIB++Yopqg1eOt6O/V9r6D3CwN
        pSrf96W09M9gujktOEhjLrIe6jINRM64yBH5XhINEV8HMP0tE5fUKCUAZotLv6zvuGjaN6dvbGbhi
        4OArSgW44OM9HpseJ/6FNLcrKuubFc4EhJfX/HePaOLclqlPwYpAUHBcTbT6iHrEi2M6UqNTBR6Q1
        7zwYIWyCzxirhrbCeM4RYzj2EmwxHSJtvHLWrUpADIERqfoxceBCyIPgMPwAxjkT6B4OWK9skPCd0
        /Q3p2sQw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qFOVw-004qJP-1w;
        Sat, 01 Jul 2023 00:31:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH] RDMA/bnxt_re: fix verbs undefined build errors
Date:   Fri, 30 Jun 2023 17:30:59 -0700
Message-ID: <20230701003059.23064-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When INFINIBAND_USER_ACCESS is not set, the bnxt_re driver has
build errors:

ERROR: modpost: "uverbs_idr_class" [drivers/infiniband/hw/bnxt_re/bnxt_re.ko] undefined!
ERROR: modpost: "ib_uverbs_get_ucontext_file" [drivers/infiniband/hw/bnxt_re/bnxt_re.ko] undefined!
ERROR: modpost: "uverbs_destroy_def_handler" [drivers/infiniband/hw/bnxt_re/bnxt_re.ko] undefined!

Handle this case by making the driver depend on INFINIBAND_USER_ACCESS.

Fixes: 592e8b3226a2 ("RDMA/bnxt_re: Add bnxt_re driver build support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Cc: Devesh Sharma <devesh.sharma@broadcom.com>
Cc: Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: Doug Ledford <dledford@redhat.com>
---
 drivers/infiniband/hw/bnxt_re/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/infiniband/hw/bnxt_re/Kconfig b/drivers/infiniband/hw/bnxt_re/Kconfig
--- a/drivers/infiniband/hw/bnxt_re/Kconfig
+++ b/drivers/infiniband/hw/bnxt_re/Kconfig
@@ -3,6 +3,7 @@ config INFINIBAND_BNXT_RE
 	tristate "Broadcom Netxtreme HCA support"
 	depends on 64BIT
 	depends on INET && DCB && BNXT
+	depends on INFINIBAND_USER_ACCESS
 	help
 	  This driver supports Broadcom NetXtreme-E 10/25/40/50 gigabit
 	  RoCE HCAs.  To compile this driver as a module, choose M here:
