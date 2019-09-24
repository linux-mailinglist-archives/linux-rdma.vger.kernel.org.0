Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88051BC3F7
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 10:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394847AbfIXISk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 04:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388712AbfIXISk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Sep 2019 04:18:40 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1FD020872;
        Tue, 24 Sep 2019 08:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569313119;
        bh=rnCAtftnGL3kBQV26i0k36PgqjOXmRa0OiGDW0kpya4=;
        h=From:To:Cc:Subject:Date:From;
        b=Y1ngDdpSwf4372Z6B2HsLONa89rYdTg7LvlcFKQI8FVroI1Ci3IFyTad5eQzK+yu8
         dpvlozLg7+Wd7qhUeWZfUuc7WrVbRlDfVWzcWfReOM+ezm3DDTBKd0gwp97TWNT1wn
         z4PBqrkQn5ftbqECASfAz2idWqEo7qAPjqeSRHWw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-core] ibdiag: Remove wrongly added ibtypes.py file
Date:   Tue, 24 Sep 2019 11:18:34 +0300
Message-Id: <20190924081834.16511-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

ibtypes.py was not supposed to be added from the beginning, hence remove it.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 ibtypes.py | 61 ------------------------------------------------------
 1 file changed, 61 deletions(-)
 delete mode 100644 ibtypes.py

diff --git a/ibtypes.py b/ibtypes.py
deleted file mode 100644
index 119a023e5..000000000
--- a/ibtypes.py
+++ /dev/null
@@ -1,61 +0,0 @@
-import re
-import sys
-
-def global_ln(ln):
-    g = re.match(r"^#define\s+(\S+)\s+CL_HTON(\d+)\((.*)\)",ln)
-    if g:
-        print("#define %s htobe%s(%s)"%(g.group(1),g.group(2),g.group(3)))
-        return global_ln
-    g = re.match(r"^#define\s+(\S+)\s+\(CL_HTON(\d+)\((.*)\)\)",ln)
-    if g:
-        print("#define %s htobe%s(%s)"%(g.group(1),g.group(2),g.group(3)))
-        return global_ln
-    g = re.match(r"^#define\s+(\S+)\s+(0x\w+)",ln)
-    if g:
-        print("#define %s %s"%(g.group(1),g.group(2)))
-        return global_ln
-    g = re.match(r"^#define\s+(\S+)\s+\((0x\w+)\)",ln)
-    if g:
-        print("#define %s %s"%(g.group(1),g.group(2)))
-        return global_ln
-    g = re.match(r"^#define\s+(\S+)\s+(\d+)",ln)
-    if g:
-        print("#define %s %s"%(g.group(1),g.group(2)))
-        return global_ln
-    g = re.match(r"^#define\s+(\S+)\s+\((\d+)\)",ln)
-    if g:
-        print("#define %s %s"%(g.group(1),g.group(2)))
-        return global_ln
-
-    g = re.match(r"^typedef\s+(union|struct)\s+_\S+\s+{",ln);
-    if g:
-        print("typedef %s {"%(g.group(1)));
-        return in_struct;
-
-    print(ln,file=FO);
-    return global_ln
-
-def in_struct(ln):
-    g = re.match(r"^}\s+PACK_SUFFIX\s+(\S+);",ln);
-    if g:
-        print("} __attribute__((packed)) %s;"%(g.group(1)));
-        return global_ln;
-    g = re.match(r"^}\s+(\S+);",ln);
-    if g:
-        print("} %s;"%(g.group(1)));
-        return global_ln;
-
-    ln = ln.replace("PACK_SUFFIX","__attribute__((packed))");
-    ln = ln.replace("ib_gid_prefix_t","__be64");
-    ln = ln.replace("ib_net64_t","__be64");
-    ln = ln.replace("ib_net32_t","__be32");
-    ln = ln.replace("ib_net16_t","__be16");
-    ln = ln.replace("boolean_t","bool");
-    print(ln)
-    return in_struct;
-
-mode = global_ln
-with open(sys.argv[1]) as FI, open(sys.argv[2],"wt") as FO:
-    for ln in FI:
-        ln = ln.rstrip();
-        mode = mode(ln);
-- 
2.20.1

