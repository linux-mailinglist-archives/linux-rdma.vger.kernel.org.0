Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2633B9096
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jul 2021 12:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhGAKoH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jul 2021 06:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbhGAKoH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jul 2021 06:44:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE493C061756;
        Thu,  1 Jul 2021 03:41:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o33-20020a05600c5121b02901e360c98c08so6502214wms.5;
        Thu, 01 Jul 2021 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EQAiXStN+NAwtAQGIBI4DpNyAUz4C0kqmJ94HQNVbn4=;
        b=e5nWXds+Lc0+UH6cWYsDNgTUpiySRZOdJ77EF5hPSvdGslF32E2R78I31vH9vCJ26Z
         1NPIYonwhdGnfeJqNenpNanKThK1XkbI0vIWBrVU2rc5DyqhNPZxEiNwS/VKXO1D5lyi
         JjNJcRFgOuo5ummcjGhbXNRSyS1gRglBVp7SnZzdcHPB3Hj4XwlcMu+9y0bv5OZD2ArT
         BbXnt31cL4ZIf5QtZtP3b+QkTIkx4uEVCBe5snZAXv47sGq/GnYq05DOLdUPaiKJ4rrQ
         SBZURGNY06aO7eQGTzqQB/4k3XThHmsFnNrbvM8tkXhZoQuD1Jq3oup9NSx+C6qJ9DCq
         uFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EQAiXStN+NAwtAQGIBI4DpNyAUz4C0kqmJ94HQNVbn4=;
        b=k6AYEzSPOFjgCHCvDezzqX29ljk4T84SMzEGu98TSQ06FspQ2HDVj3stZs5bysbtUE
         Q+YG1u5cIbDmVupW5pMld04Wa4BtoMYXfpn9lQY2hT0qXwpZwmFX9SXBanodg6z/U6hX
         zT31LVA/eEIOSWRYbWl1Y81nnSXDJpPaqTJGFcBIbbsDUIIml3EqS9UN8pcfaPjuipVv
         OqBLGB6PkWYiUT5DaPApQdIkexj/THnH1DhyEM7SISG3hMg8uBSZsI1nTtTzMLLAfOqm
         DSRTjX4/ZfmLTlR8VdR/4ElIazk/xKqDOC4r3kY6wtRkxuiiDCNA1c8hM4YYCIGC6mXJ
         1YYQ==
X-Gm-Message-State: AOAM530EW5VtAWjAyxhlmXrPykpxfUWW8uOfmxAKAKS9kscMA2S/ngJx
        7rrv1RRzboaZFU80JSlqxys=
X-Google-Smtp-Source: ABdhPJxPo/pFh7bjhc4fKdAOUkpvvFb6kMWEbjR6Gcm7qaT1OLULcy8hQ46Xl+35L7cuLeR1UrdoLw==
X-Received: by 2002:a1c:1f8a:: with SMTP id f132mr9194922wmf.56.1625136095246;
        Thu, 01 Jul 2021 03:41:35 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:3e00:21:6759:f8f2:826e])
        by smtp.gmail.com with ESMTPSA id r1sm9344287wmn.10.2021.07.01.03.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 03:41:34 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] RDMA/irdma: make spdxcheck.py happy
Date:   Thu,  1 Jul 2021 12:41:27 +0200
Message-Id: <20210701104127.1877-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 48d6b3336a9f ("RDMA/irdma: Add ABI definitions") adds
./include/uapi/rdma/irdma-abi.h with an additional unneeded closing
bracket at the end of the SPDX-License-Identifier line.

Hence, ./scripts/spdxcheck.py complains:

  include/uapi/rdma/irdma-abi.h: 1:77 Syntax error: )

Remove that closing bracket to make spdxcheck.py happy.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210701

Mustafa, Shiraz, please ack.
Jason, please pick this minor non-urgent patch into your rdma tree.

 include/uapi/rdma/irdma-abi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/rdma/irdma-abi.h b/include/uapi/rdma/irdma-abi.h
index 26b638a7ad97..a7085e092d34 100644
--- a/include/uapi/rdma/irdma-abi.h
+++ b/include/uapi/rdma/irdma-abi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB */
 /*
  * Copyright (c) 2006 - 2021 Intel Corporation.  All rights reserved.
  * Copyright (c) 2005 Topspin Communications.  All rights reserved.
-- 
2.17.1

