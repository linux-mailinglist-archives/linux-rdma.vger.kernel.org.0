Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0691E5CA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfENXtq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35584 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfENXtp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id a39so1251289qtk.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnuszmVJpYoKs+2O/OG5JkuLiE0CY9pw5T7lQ8y9bYQ=;
        b=UGTIm9NaeshTH66soBwIbwQwx9udt1jRf2NdD8WGw68fk37YiFtHsYeA2hRuG+Nvnn
         JJjibLI2wv5Tf9CwZLkS0P34RjZnZvNCEzCEPIZca8fi8u7Zl3kr4JhcG1V+WtViJRQ3
         6nDQ5k04oJ2qL0qcAhgiOi4XILtM1tkFLpl3uhap1POyNUCZOKzIH7HEavbyqNjfKUXI
         A+kq1uxo9ea5ntf1o0qf8ArI3wE9pGMSwxrjgeJQ7Fk8+/I751naT+c5iYHOQLfIb4nI
         /Dk4OwfgC6SLdLPCFDYyAvMU40883VknLWsJODt0R5xGcqFAtQD0HfAnUEced+PuIH2L
         zfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnuszmVJpYoKs+2O/OG5JkuLiE0CY9pw5T7lQ8y9bYQ=;
        b=X1I/WRfFGl9zanWY2eeFi7t1+Ek6D8jiJJZGUDG+A5RkdTDmwQKBDjCmrS01xp7X1y
         5bGhTRpFO6zefKNdDTkwuQ657RUOmHTgl447gp+nXoqyawi3dBhGW1PdcfdFL8IHhRNQ
         ZX2U/6NHaRgWRVACZfQrEjtNAsz0+ZZp8TwPYDvvOXbVrtPDS5bmfNYiwUMTif+IW603
         0BWkmPAWgIBMgJ5ShCEUybP0ima1E8ztC3ULhlYih/KrDPuhXLkBxNytPGDmrt5tOgTO
         5QD3pBP12rl+BBQ1fssUoJcFdTPMOgYkIWed0Ef6Qd4NURECF2l3qwPp3K+cdU3zTTYQ
         uLJg==
X-Gm-Message-State: APjAAAVj2sEvWAFw7kzu/jGfGsHfmDzihHjodkJrEimpwD8alilFwSxK
        qBR5njC7Bm7qVJ6tlMttFdzAxR7Wj18=
X-Google-Smtp-Source: APXvYqwHvpnBgia8nrFFKWxPb07WkHM0ghmf3RxuPkpNn79s60xfGM6SZ6EOIdSMZbFTD04xb1BYIQ==
X-Received: by 2002:ac8:88f:: with SMTP id v15mr33206369qth.382.1557877784259;
        Tue, 14 May 2019 16:49:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id k54sm404553qtk.54.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001OO-Fr; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 18/20] ibdiags: Remove obsolete build system and related files
Date:   Tue, 14 May 2019 20:49:34 -0300
Message-Id: <20190514234936.5175-19-jgg@ziepe.ca>
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

Everything we need to keep was moved out of ibdiags, so just delete
the directory.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 ibdiags/.gitignore                            |  66 ---
 ibdiags/AUTHORS                               |   4 -
 ibdiags/COPYING                               | 379 --------------
 ibdiags/ChangeLog                             | 470 ------------------
 ibdiags/Makefile.am                           | 157 ------
 ibdiags/NEWS                                  |   2 -
 ibdiags/README                                |  62 ---
 ibdiags/autogen.sh                            |   8 -
 ibdiags/configure.ac                          | 252 ----------
 ibdiags/doc/README.rst                        | 105 ----
 ibdiags/doc/generate                          |  45 --
 ibdiags/doc/man/check_lft_balance.8.in        |  67 ---
 ibdiags/doc/man/dump_fts.8.in                 | 235 ---------
 ibdiags/doc/man/ibaddr.8.in                   | 214 --------
 ibdiags/doc/man/ibcacheedit.8.in              |  79 ---
 ibdiags/doc/man/ibccconfig.8.in               | 195 --------
 ibdiags/doc/man/ibccquery.8.in                | 192 -------
 ibdiags/doc/man/ibfindnodesusing.8.in         | 126 -----
 ibdiags/doc/man/ibhosts.8.in                  | 184 -------
 ibdiags/doc/man/ibidsverify.8.in              |  79 ---
 ibdiags/doc/man/iblinkinfo.8.in               | 316 ------------
 ibdiags/doc/man/ibnetdiscover.8.in            | 399 ---------------
 ibdiags/doc/man/ibnodes.8.in                  | 176 -------
 ibdiags/doc/man/ibping.8.in                   | 174 -------
 ibdiags/doc/man/ibportstate.8.in              | 259 ----------
 ibdiags/doc/man/ibqueryerrors.8.in            | 339 -------------
 ibdiags/doc/man/ibroute.8.in                  | 290 -----------
 ibdiags/doc/man/ibrouters.8.in                | 184 -------
 ibdiags/doc/man/ibstat.8.in                   | 117 -----
 ibdiags/doc/man/ibstatus.8.in                 |  72 ---
 ibdiags/doc/man/ibswitches.8.in               | 184 -------
 ibdiags/doc/man/ibsysstat.8.in                | 183 -------
 ibdiags/doc/man/ibtracert.8.in                | 314 ------------
 ibdiags/doc/man/infiniband-diags.8.in         | 451 -----------------
 ibdiags/doc/man/perfquery.8.in                | 287 -----------
 ibdiags/doc/man/saquery.8.in                  | 374 --------------
 ibdiags/doc/man/sminfo.8.in                   | 214 --------
 ibdiags/doc/man/smpdump.8.in                  | 206 --------
 ibdiags/doc/man/smpquery.8.in                 | 309 ------------
 ibdiags/doc/man/vendstat.8.in                 | 217 --------
 ibdiags/include/ibdiag_version.h.in           |  39 --
 ibdiags/infiniband-diags.spec.in              | 334 -------------
 ibdiags/libibmad/ChangeLog                    |  88 ----
 ibdiags/libibmad/Makefile.am                  |  34 --
 ibdiags/libibmad/README                       |   7 -
 ibdiags/libibmad/libibmad.ver                 |   9 -
 ibdiags/libibnetdisc/Makefile.am              |  54 --
 ibdiags/libibnetdisc/libibnetdisc.ver         |   9 -
 ibdiags/libibnetdisc/man/ibnd_debug.3         |   2 -
 .../libibnetdisc/man/ibnd_destroy_fabric.3    |   2 -
 ibdiags/libibnetdisc/man/ibnd_find_node_dr.3  |   2 -
 .../libibnetdisc/man/ibnd_iter_nodes_type.3   |   2 -
 ibdiags/libibnetdisc/man/ibnd_show_progress.3 |   2 -
 ibdiags/man/dump_lfts.8                       |   2 -
 ibdiags/man/dump_mfts.8                       |   2 -
 ibdiags/perltidy.sh                           |  68 ---
 ibdiags/tests/check_shells.sh                 |  14 -
 57 files changed, 8656 deletions(-)
 delete mode 100644 ibdiags/.gitignore
 delete mode 100644 ibdiags/AUTHORS
 delete mode 100644 ibdiags/COPYING
 delete mode 100644 ibdiags/ChangeLog
 delete mode 100644 ibdiags/Makefile.am
 delete mode 100644 ibdiags/NEWS
 delete mode 100644 ibdiags/README
 delete mode 100755 ibdiags/autogen.sh
 delete mode 100644 ibdiags/configure.ac
 delete mode 100644 ibdiags/doc/README.rst
 delete mode 100755 ibdiags/doc/generate
 delete mode 100644 ibdiags/doc/man/check_lft_balance.8.in
 delete mode 100644 ibdiags/doc/man/dump_fts.8.in
 delete mode 100644 ibdiags/doc/man/ibaddr.8.in
 delete mode 100644 ibdiags/doc/man/ibcacheedit.8.in
 delete mode 100644 ibdiags/doc/man/ibccconfig.8.in
 delete mode 100644 ibdiags/doc/man/ibccquery.8.in
 delete mode 100644 ibdiags/doc/man/ibfindnodesusing.8.in
 delete mode 100644 ibdiags/doc/man/ibhosts.8.in
 delete mode 100644 ibdiags/doc/man/ibidsverify.8.in
 delete mode 100644 ibdiags/doc/man/iblinkinfo.8.in
 delete mode 100644 ibdiags/doc/man/ibnetdiscover.8.in
 delete mode 100644 ibdiags/doc/man/ibnodes.8.in
 delete mode 100644 ibdiags/doc/man/ibping.8.in
 delete mode 100644 ibdiags/doc/man/ibportstate.8.in
 delete mode 100644 ibdiags/doc/man/ibqueryerrors.8.in
 delete mode 100644 ibdiags/doc/man/ibroute.8.in
 delete mode 100644 ibdiags/doc/man/ibrouters.8.in
 delete mode 100644 ibdiags/doc/man/ibstat.8.in
 delete mode 100644 ibdiags/doc/man/ibstatus.8.in
 delete mode 100644 ibdiags/doc/man/ibswitches.8.in
 delete mode 100644 ibdiags/doc/man/ibsysstat.8.in
 delete mode 100644 ibdiags/doc/man/ibtracert.8.in
 delete mode 100644 ibdiags/doc/man/infiniband-diags.8.in
 delete mode 100644 ibdiags/doc/man/perfquery.8.in
 delete mode 100644 ibdiags/doc/man/saquery.8.in
 delete mode 100644 ibdiags/doc/man/sminfo.8.in
 delete mode 100644 ibdiags/doc/man/smpdump.8.in
 delete mode 100644 ibdiags/doc/man/smpquery.8.in
 delete mode 100644 ibdiags/doc/man/vendstat.8.in
 delete mode 100644 ibdiags/include/ibdiag_version.h.in
 delete mode 100644 ibdiags/infiniband-diags.spec.in
 delete mode 100644 ibdiags/libibmad/ChangeLog
 delete mode 100644 ibdiags/libibmad/Makefile.am
 delete mode 100644 ibdiags/libibmad/README
 delete mode 100644 ibdiags/libibmad/libibmad.ver
 delete mode 100644 ibdiags/libibnetdisc/Makefile.am
 delete mode 100644 ibdiags/libibnetdisc/libibnetdisc.ver
 delete mode 100644 ibdiags/libibnetdisc/man/ibnd_debug.3
 delete mode 100644 ibdiags/libibnetdisc/man/ibnd_destroy_fabric.3
 delete mode 100644 ibdiags/libibnetdisc/man/ibnd_find_node_dr.3
 delete mode 100644 ibdiags/libibnetdisc/man/ibnd_iter_nodes_type.3
 delete mode 100644 ibdiags/libibnetdisc/man/ibnd_show_progress.3
 delete mode 100644 ibdiags/man/dump_lfts.8
 delete mode 100644 ibdiags/man/dump_mfts.8
 delete mode 100755 ibdiags/perltidy.sh
 delete mode 100755 ibdiags/tests/check_shells.sh

diff --git a/ibdiags/.gitignore b/ibdiags/.gitignore
deleted file mode 100644
index b9079bb5a2ff83..00000000000000
diff --git a/ibdiags/AUTHORS b/ibdiags/AUTHORS
deleted file mode 100644
index e9057589e55ea9..00000000000000
diff --git a/ibdiags/COPYING b/ibdiags/COPYING
deleted file mode 100644
index 3fb45142d5f233..00000000000000
diff --git a/ibdiags/ChangeLog b/ibdiags/ChangeLog
deleted file mode 100644
index 6add52adf79097..00000000000000
diff --git a/ibdiags/Makefile.am b/ibdiags/Makefile.am
deleted file mode 100644
index 19ed7c4ecea620..00000000000000
diff --git a/ibdiags/NEWS b/ibdiags/NEWS
deleted file mode 100644
index 84c99e711b3032..00000000000000
diff --git a/ibdiags/README b/ibdiags/README
deleted file mode 100644
index f1910f86a28bc9..00000000000000
diff --git a/ibdiags/autogen.sh b/ibdiags/autogen.sh
deleted file mode 100755
index 3745b11d3e120e..00000000000000
diff --git a/ibdiags/configure.ac b/ibdiags/configure.ac
deleted file mode 100644
index dd85f8ca3c4ae9..00000000000000
diff --git a/ibdiags/doc/README.rst b/ibdiags/doc/README.rst
deleted file mode 100644
index 5c74eda845d430..00000000000000
diff --git a/ibdiags/doc/generate b/ibdiags/doc/generate
deleted file mode 100755
index b1339f88e3b7bc..00000000000000
diff --git a/ibdiags/doc/man/check_lft_balance.8.in b/ibdiags/doc/man/check_lft_balance.8.in
deleted file mode 100644
index 174e6c77a49a9d..00000000000000
diff --git a/ibdiags/doc/man/dump_fts.8.in b/ibdiags/doc/man/dump_fts.8.in
deleted file mode 100644
index 3a0db751573feb..00000000000000
diff --git a/ibdiags/doc/man/ibaddr.8.in b/ibdiags/doc/man/ibaddr.8.in
deleted file mode 100644
index 5458b17670a9dd..00000000000000
diff --git a/ibdiags/doc/man/ibcacheedit.8.in b/ibdiags/doc/man/ibcacheedit.8.in
deleted file mode 100644
index 64db5da9d33124..00000000000000
diff --git a/ibdiags/doc/man/ibccconfig.8.in b/ibdiags/doc/man/ibccconfig.8.in
deleted file mode 100644
index 51106a592006bc..00000000000000
diff --git a/ibdiags/doc/man/ibccquery.8.in b/ibdiags/doc/man/ibccquery.8.in
deleted file mode 100644
index 752c67687d3708..00000000000000
diff --git a/ibdiags/doc/man/ibfindnodesusing.8.in b/ibdiags/doc/man/ibfindnodesusing.8.in
deleted file mode 100644
index 33dc302453fa33..00000000000000
diff --git a/ibdiags/doc/man/ibhosts.8.in b/ibdiags/doc/man/ibhosts.8.in
deleted file mode 100644
index 511250297ee472..00000000000000
diff --git a/ibdiags/doc/man/ibidsverify.8.in b/ibdiags/doc/man/ibidsverify.8.in
deleted file mode 100644
index 7b891431f2b0d8..00000000000000
diff --git a/ibdiags/doc/man/iblinkinfo.8.in b/ibdiags/doc/man/iblinkinfo.8.in
deleted file mode 100644
index 19b350f156d7e1..00000000000000
diff --git a/ibdiags/doc/man/ibnetdiscover.8.in b/ibdiags/doc/man/ibnetdiscover.8.in
deleted file mode 100644
index 78e7e52648af35..00000000000000
diff --git a/ibdiags/doc/man/ibnodes.8.in b/ibdiags/doc/man/ibnodes.8.in
deleted file mode 100644
index f19c99003cda8b..00000000000000
diff --git a/ibdiags/doc/man/ibping.8.in b/ibdiags/doc/man/ibping.8.in
deleted file mode 100644
index a4aa95c7d3e3f4..00000000000000
diff --git a/ibdiags/doc/man/ibportstate.8.in b/ibdiags/doc/man/ibportstate.8.in
deleted file mode 100644
index aed6b7f7fedff1..00000000000000
diff --git a/ibdiags/doc/man/ibqueryerrors.8.in b/ibdiags/doc/man/ibqueryerrors.8.in
deleted file mode 100644
index 5d4d25e9c31946..00000000000000
diff --git a/ibdiags/doc/man/ibroute.8.in b/ibdiags/doc/man/ibroute.8.in
deleted file mode 100644
index c2ec1def35ee73..00000000000000
diff --git a/ibdiags/doc/man/ibrouters.8.in b/ibdiags/doc/man/ibrouters.8.in
deleted file mode 100644
index abd6e7a72e7727..00000000000000
diff --git a/ibdiags/doc/man/ibstat.8.in b/ibdiags/doc/man/ibstat.8.in
deleted file mode 100644
index 8d297fd9fbcc61..00000000000000
diff --git a/ibdiags/doc/man/ibstatus.8.in b/ibdiags/doc/man/ibstatus.8.in
deleted file mode 100644
index b8e2489b3f9a54..00000000000000
diff --git a/ibdiags/doc/man/ibswitches.8.in b/ibdiags/doc/man/ibswitches.8.in
deleted file mode 100644
index 235c1481df44e7..00000000000000
diff --git a/ibdiags/doc/man/ibsysstat.8.in b/ibdiags/doc/man/ibsysstat.8.in
deleted file mode 100644
index 57e0c966ffbb37..00000000000000
diff --git a/ibdiags/doc/man/ibtracert.8.in b/ibdiags/doc/man/ibtracert.8.in
deleted file mode 100644
index 5c3aff97c591e9..00000000000000
diff --git a/ibdiags/doc/man/infiniband-diags.8.in b/ibdiags/doc/man/infiniband-diags.8.in
deleted file mode 100644
index 107202eaa0c08a..00000000000000
diff --git a/ibdiags/doc/man/perfquery.8.in b/ibdiags/doc/man/perfquery.8.in
deleted file mode 100644
index c078fc0d3de74d..00000000000000
diff --git a/ibdiags/doc/man/saquery.8.in b/ibdiags/doc/man/saquery.8.in
deleted file mode 100644
index b596a505d8299f..00000000000000
diff --git a/ibdiags/doc/man/sminfo.8.in b/ibdiags/doc/man/sminfo.8.in
deleted file mode 100644
index e0d3484337e439..00000000000000
diff --git a/ibdiags/doc/man/smpdump.8.in b/ibdiags/doc/man/smpdump.8.in
deleted file mode 100644
index 08422a741c27c7..00000000000000
diff --git a/ibdiags/doc/man/smpquery.8.in b/ibdiags/doc/man/smpquery.8.in
deleted file mode 100644
index 0ca72b51ba5d13..00000000000000
diff --git a/ibdiags/doc/man/vendstat.8.in b/ibdiags/doc/man/vendstat.8.in
deleted file mode 100644
index 58a23c1282702f..00000000000000
diff --git a/ibdiags/include/ibdiag_version.h.in b/ibdiags/include/ibdiag_version.h.in
deleted file mode 100644
index 62430c57d9a8bc..00000000000000
diff --git a/ibdiags/infiniband-diags.spec.in b/ibdiags/infiniband-diags.spec.in
deleted file mode 100644
index dd774d8c3da8b6..00000000000000
diff --git a/ibdiags/libibmad/ChangeLog b/ibdiags/libibmad/ChangeLog
deleted file mode 100644
index 0c4c337ee34e4b..00000000000000
diff --git a/ibdiags/libibmad/Makefile.am b/ibdiags/libibmad/Makefile.am
deleted file mode 100644
index 6654490cbda5bd..00000000000000
diff --git a/ibdiags/libibmad/README b/ibdiags/libibmad/README
deleted file mode 100644
index 768201c2596e7d..00000000000000
diff --git a/ibdiags/libibmad/libibmad.ver b/ibdiags/libibmad/libibmad.ver
deleted file mode 100644
index 4578eaf3ae0ce9..00000000000000
diff --git a/ibdiags/libibnetdisc/Makefile.am b/ibdiags/libibnetdisc/Makefile.am
deleted file mode 100644
index eeded5c51a4f3a..00000000000000
diff --git a/ibdiags/libibnetdisc/libibnetdisc.ver b/ibdiags/libibnetdisc/libibnetdisc.ver
deleted file mode 100644
index 59fca19df02031..00000000000000
diff --git a/ibdiags/libibnetdisc/man/ibnd_debug.3 b/ibdiags/libibnetdisc/man/ibnd_debug.3
deleted file mode 100644
index a4076fca4d525a..00000000000000
diff --git a/ibdiags/libibnetdisc/man/ibnd_destroy_fabric.3 b/ibdiags/libibnetdisc/man/ibnd_destroy_fabric.3
deleted file mode 100644
index 8fe20ae7c0b173..00000000000000
diff --git a/ibdiags/libibnetdisc/man/ibnd_find_node_dr.3 b/ibdiags/libibnetdisc/man/ibnd_find_node_dr.3
deleted file mode 100644
index 612e5015c584fb..00000000000000
diff --git a/ibdiags/libibnetdisc/man/ibnd_iter_nodes_type.3 b/ibdiags/libibnetdisc/man/ibnd_iter_nodes_type.3
deleted file mode 100644
index dc3ac8fdd21649..00000000000000
diff --git a/ibdiags/libibnetdisc/man/ibnd_show_progress.3 b/ibdiags/libibnetdisc/man/ibnd_show_progress.3
deleted file mode 100644
index 280af31a3156c2..00000000000000
diff --git a/ibdiags/man/dump_lfts.8 b/ibdiags/man/dump_lfts.8
deleted file mode 100644
index a3d1fdd36a789a..00000000000000
diff --git a/ibdiags/man/dump_mfts.8 b/ibdiags/man/dump_mfts.8
deleted file mode 100644
index 0566aa98227f20..00000000000000
diff --git a/ibdiags/perltidy.sh b/ibdiags/perltidy.sh
deleted file mode 100755
index 16cf552d30955b..00000000000000
diff --git a/ibdiags/tests/check_shells.sh b/ibdiags/tests/check_shells.sh
deleted file mode 100755
index e39f42fae43406..00000000000000
-- 
2.21.0

