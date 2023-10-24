Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B0E7D54AE
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 17:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjJXPHn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 11:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJXPHn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 11:07:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C425F93
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 08:07:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD26C433C7;
        Tue, 24 Oct 2023 15:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698160060;
        bh=7CjvFOEcC16xK9G5i4Mw/hMFF+U18bDDblXDnGcuO1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=ESCcHKoq/rdvmb366O2U5id1j78Qe3aEZ9qjvB7HTlP8mo7vlZEn7GSiwSAOCUOn8
         Qa+A6QBeytlZ+JGFD+SkG1kgDHjbsPWEexb2S1+VZMMKc9ugLVA024QjTcu4uvek/w
         nY/FVzeiqhz4OSmv+ZmxA06LEuUVO9M1OhXqILdVLBH/ARfRWsfOl0IjqWD/KV+K9u
         88kIuLqCjsu1VGoDqH8vg8crO6ePrbGos7waiYLIXNPjCi226h1esl33cyv/wTOtQT
         X8CUEm4OC3y1cS2v/Jrp0+3kRCTOeiW2gYR1rUe44fYw9DxJzIMtqdYGFB3eWBAkfZ
         KaNMBIEO9SSqA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Easwar Hariharan <easwar.hariharan@intel.com>,
        linux-rdma@vger.kernel.org,
        Sebastian Sanchez <sebastian.sanchez@intel.com>
Subject: [PATCH rdma-next] RDMA/hfi1: Workaround truncation compilation error
Date:   Tue, 24 Oct 2023 18:07:31 +0300
Message-ID: <238fa39a8fd60e87a5ad7e1ca6584fcdf32e9519.1698159993.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Increase name array to be large enough to overcome the following
compilation error.

drivers/infiniband/hw/hfi1/efivar.c: In function ‘read_hfi1_efi_var’:
drivers/infiniband/hw/hfi1/efivar.c:124:44: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  124 |         snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
      |                                            ^
drivers/infiniband/hw/hfi1/efivar.c:124:9: note: ‘snprintf’ output 2 or more bytes (assuming 65) into a destination of size 64
  124 |         snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/hfi1/efivar.c:133:52: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  133 |                 snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
      |                                                    ^
drivers/infiniband/hw/hfi1/efivar.c:133:17: note: ‘snprintf’ output 2 or more bytes (assuming 65) into a destination of size 64
  133 |                 snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:243: drivers/infiniband/hw/hfi1/efivar.o] Error 1

Fixes: c03c08d50b3d ("IB/hfi1: Check upper-case EFI variables")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/hfi1/efivar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/efivar.c b/drivers/infiniband/hw/hfi1/efivar.c
index fb06e86da608..9ed05e10020e 100644
--- a/drivers/infiniband/hw/hfi1/efivar.c
+++ b/drivers/infiniband/hw/hfi1/efivar.c
@@ -112,7 +112,7 @@ int read_hfi1_efi_var(struct hfi1_devdata *dd, const char *kind,
 		      unsigned long *size, void **return_data)
 {
 	char prefix_name[64];
-	char name[64];
+	char name[128];
 	int result;
 
 	/* create a common prefix */
-- 
2.41.0

