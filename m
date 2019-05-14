Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4041B1E5E8
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 02:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfEOALL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 20:11:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34046 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfEOALK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 20:11:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id h1so1314181qtp.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 17:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KioAskpYCmmaTHobDhRzoq7PduNpGDh7K5Ixi39D51M=;
        b=QjG4t1/PqezqQ32qFU3fqTdQDC9BBDdq3af7nZbLdbHcOkan5hFtvhDYVickoStyj9
         +t1+YTs5XaHOeG3cA8qwG/WBfNQ6mhBESMX+iSU6B8cJXPxl8XsXx1PMmoR3NnVKHCjq
         GMigqoQ6AFgf8huJ0+QH1B2pafFagBxNGYZXl//gDDTLBj+cPZOPz5pwF0lurQxwqclD
         7wqTIJ0v4uOt+Vsg2lWW1+lPqJIDkV9GnJ1+FojHPhICypYQy1mtSMN8t1SmSsEBhcQ1
         mnRYI6CsG7+iCtnBWVrAl94nQGXogDJTsfxyQWCQ92heZFrGJ+GO2eCc4+PUC/F2/g/c
         Nr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KioAskpYCmmaTHobDhRzoq7PduNpGDh7K5Ixi39D51M=;
        b=LAcl8dFtWrS6EOZNF/bm1tS59jfWKbkOqB8mi5XW+UEculUoHTdh6j5tI04aNO1ck4
         /OyKMMcGciPGd796rR5kfDAYuDgU7gtgInwl1nFkm5MHBq3904cq0KSiI/bkl158Irda
         4R1d1PeyJ5EUMGJKd/aDFYlxwsOvKnltYzL5Crz75igRnBLl4FhmpQNOcgG1czeMPNZg
         WPA5PioOsoeXFSutlczfR/MK4SEuVbru9gIJluaH7m4eSn5YdV5bKMIwFQYE+jBIKANC
         doW8AuBxOgYlVw6uFaRJr2myZBMuQdFCA/n2viAvP0d80dHC+QMSMG2YsXvRV/vbRf45
         Q54w==
X-Gm-Message-State: APjAAAVq3WOZ+6rpnaEQYzwDZS426S+VFaklUikk73YdiaDwF1m5+D/V
        XsZYzSpqoPNiJ3XFFhDRGpc9200SUMo=
X-Google-Smtp-Source: APXvYqz5dSPF9rSNIsrQ92+HslghDsffKgaeEx8j4hlNdN+zjeuL81YUn9OKXRb4ZpUbJJud19fw1Q==
X-Received: by 2002:a0c:b0ea:: with SMTP id p39mr31312551qvc.242.1557879069970;
        Tue, 14 May 2019 17:11:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id c30sm414573qta.25.2019.05.14.17.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:11:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001Oa-Iw; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 20/20] ibdiags: Perform substitution on the RST include files as well
Date:   Tue, 14 May 2019 20:49:36 -0300
Message-Id: <20190514234936.5175-21-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514234936.5175-1-jgg@ziepe.ca>
References: <20190514234936.5175-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

These have @ directives but are not marked as .in so they never got
substituted. Rename them and run them through substitution and arrange
for rst2man to pick them up.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 infiniband-diags/man/CMakeLists.txt           | 48 ++++++++++++++++++-
 .../{opt_z-config.rst => opt_z-config.in.rst} |  0
 ...config-file.rst => sec_config-file.in.rst} |  0
 3 files changed, 46 insertions(+), 2 deletions(-)
 rename infiniband-diags/man/common/{opt_z-config.rst => opt_z-config.in.rst} (100%)
 rename infiniband-diags/man/common/{sec_config-file.rst => sec_config-file.in.rst} (100%)

diff --git a/infiniband-diags/man/CMakeLists.txt b/infiniband-diags/man/CMakeLists.txt
index 916a52dcab6cb0..3cc2c643c2287c 100644
--- a/infiniband-diags/man/CMakeLists.txt
+++ b/infiniband-diags/man/CMakeLists.txt
@@ -1,5 +1,49 @@
-# rst2man has no way to set the include search path
-rdma_create_symlink("${CMAKE_CURRENT_SOURCE_DIR}/common" "${CMAKE_CURRENT_BINARY_DIR}/common")
+# rst2man has no way to set the include search path and we need to substitute
+# into the common files, so subst/link them all into the build directory
+function(rdma_rst_common)
+  foreach(I ${ARGN})
+    if ("${I}" MATCHES "\\.in.rst$")
+      string(REGEX REPLACE "^(.+)\\.in.rst$" "\\1" BASE_NAME "${I}")
+      configure_file("common/${I}" "${CMAKE_CURRENT_BINARY_DIR}/common/${BASE_NAME}.rst" @ONLY)
+    else()
+      if (NOT CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_CURRENT_BINARY_DIR)
+	rdma_create_symlink("${CMAKE_CURRENT_SOURCE_DIR}/common/${I}" "${CMAKE_CURRENT_BINARY_DIR}/common/${I}")
+      endif()
+    endif()
+  endforeach()
+endfunction()
+
+rdma_rst_common(
+  opt_cache.rst
+  opt_C.rst
+  opt_diffcheck.rst
+  opt_diff.rst
+  opt_d.rst
+  opt_D.rst
+  opt_D_with_param.rst
+  opt_e.rst
+  opt_G.rst
+  opt_G_with_param.rst
+  opt_h.rst
+  opt_K.rst
+  opt_load-cache.rst
+  opt_L.rst
+  opt_node_name_map.rst
+  opt_o-outstanding_smps.rst
+  opt_ports-file.rst
+  opt_P.rst
+  opt_s.rst
+  opt_t.rst
+  opt_v.rst
+  opt_V.rst
+  opt_y.rst
+  opt_z-config.in.rst
+  sec_config-file.in.rst
+  sec_node-name-map.rst
+  sec_portselection.rst
+  sec_ports-file.rst
+  sec_topology-file.rst
+)
 
 rdma_man_pages(
   check_lft_balance.8.in.rst
diff --git a/infiniband-diags/man/common/opt_z-config.rst b/infiniband-diags/man/common/opt_z-config.in.rst
similarity index 100%
rename from infiniband-diags/man/common/opt_z-config.rst
rename to infiniband-diags/man/common/opt_z-config.in.rst
diff --git a/infiniband-diags/man/common/sec_config-file.rst b/infiniband-diags/man/common/sec_config-file.in.rst
similarity index 100%
rename from infiniband-diags/man/common/sec_config-file.rst
rename to infiniband-diags/man/common/sec_config-file.in.rst
-- 
2.21.0

