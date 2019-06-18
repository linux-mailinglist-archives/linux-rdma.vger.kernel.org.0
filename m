Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB9614A2AD
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfFRNrX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 09:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfFRNrW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 09:47:22 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D9202133F;
        Tue, 18 Jun 2019 13:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560865641;
        bh=39H7OvFmgadhEVbxit8UQXkp40Q0FT/4s+W9sQZsOxo=;
        h=From:To:Cc:Subject:Date:From;
        b=EKHSkbIZfa1DsUhMaWehUy/aahP3e+5NPu4acU9TA6ckjVCSZj+Bkp2CYxA0H6SkI
         7XDl8PQ9HCT/rTNRpARmoiBeBjOZrYu5MCvbHFk8+uLxHgfvpw9rZHSDPzO/CgBJzv
         SR+ew8N9Q7C103jEJthE8HrxWeqvoklV836dEX/g=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH rdma-core] ibdiags: Fix linkage error on PPC platform due to typo
Date:   Tue, 18 Jun 2019 16:47:17 +0300
Message-Id: <20190618134717.8529-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Incorrect linkage type causes to linkage errors on PPC platform.

[267/395] Linking C executable bin/mcm_rereg_test
FAILED: bin/mcm_rereg_test
: && /usr/bin/cc  -std=gnu11 -Wall -Wextra -Wno-sign-compare -Wno-unused-parameter -Wmissing-prototypes -Wmissing-declarations
-Wwrite-strings -Wformat=2 -Wformat-nonliteral -Wredundant-decls -Wnested-externs -Wshadow -Wno-missing-field-i
nitializers -Wstrict-prototypes -Wold-style-definition -Wredundant-decls -O2 -g  -Wl,--as-needed -Wl,--no-undefined
infiniband-diags/CMakeFiles/mcm_rereg_test.dir/mcm_rereg_test.c.o  -o bin/mcm_rereg_test  ccan/libccan.a util/librdma_util
.a -lPRIVATE lib/libibumad.so.3.0.25.0 lib/libibmad.so.5.3.25.0 infiniband-diags/libibdiags_tools.a lib/libibumad.so.3.0.25.0
-Wl,-rpath,/tmp/rdma-core/build/lib &&
: /usr/bin/ld: cannot find -lPRIVATE
collect2: error: ld returned 1 exit status

Fixes: 58670e0a17ba ("ibdiags: Add cmake files for ibdiags components")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 infiniband-diags/CMakeLists.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/infiniband-diags/CMakeLists.txt b/infiniband-diags/CMakeLists.txt
index 6301e8e02..1fd9ef257 100644
--- a/infiniband-diags/CMakeLists.txt
+++ b/infiniband-diags/CMakeLists.txt
@@ -16,7 +16,7 @@ add_library(ibdiags_tools STATIC
 function(ibdiag_programs)
   foreach(I ${ARGN})
     rdma_sbin_executable(${I} "${I}.c")
-    target_link_libraries(${I} PRIVATE ${RT_LIBRARIES} ibumad ibmad ibdiags_tools ibnetdisc)
+    target_link_libraries(${I} LINK_PRIVATE ${RT_LIBRARIES} ibumad ibmad ibdiags_tools ibnetdisc)
   endforeach()
 endfunction()
 
@@ -44,6 +44,6 @@ ibdiag_programs(
   )
 
 rdma_test_executable(ibsendtrap "ibsendtrap.c")
-target_link_libraries(ibsendtrap PRIVATE ibumad ibmad ibdiags_tools)
+target_link_libraries(ibsendtrap LINK_PRIVATE ibumad ibmad ibdiags_tools)
 rdma_test_executable(mcm_rereg_test "mcm_rereg_test.c")
-target_link_libraries(mcm_rereg_test PRIVATE ibumad ibmad ibdiags_tools)
+target_link_libraries(mcm_rereg_test LINK_PRIVATE ibumad ibmad ibdiags_tools)
-- 
2.20.1

