Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C361257ED
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 21:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfEUTBa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 15:01:30 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36489 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbfEUTBa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 15:01:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id c14so11775037qke.3
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TG0vukPzfqbBb9w/D0tpRsAOxrMfEJlD8AP5D5Ww8s=;
        b=I0IXhEPRJGOQhRpunZa4ATmrb5McO04u9dImUm4dX3pubuve6ULz2N9QNeND1XGjKH
         AvEOAgUjWRZBS3IPoZpoD7H/Gu/vpVl+yivrsH/Shnj0NFsHnlqBKkBqHHFDFhyNZNwo
         8YnUMep8bxF/b13TeHTELCKAbd7gS+pjVvX0ZQxslqflp0IJbwRtc32AfxKbs6Uw+Poo
         qhAF3zbl55U8GtfRxUenoUa/niJbFrGxVWdFFTiQYG+YmhKeiBzgZdb1uWAzwkQiv2jb
         HAea1XLo5TfZKmefOZ0XjQvuChlecjD7M7C5EscfShNaviCe5JJCaf/yEfuUH2a3oomv
         mlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TG0vukPzfqbBb9w/D0tpRsAOxrMfEJlD8AP5D5Ww8s=;
        b=Scbk5qf8Vrqxy0AH92c6rt4euW5ZE4UC4c7xTI6G2LRqs8t0UBlwPU5MSW16FYeSke
         kkRgpLiZgBN3Bvsma9Mz4fzHFfq5wgfgIyXZM1yTPgBAqMj4h6grR6Qp4y4BS6ZDLn7d
         mDwn6lg+K31stk2qGcZN4THIyiNBi2RTF/vkWqVupiZb158B5r5RLkVY7BCHDRyQ881Q
         NiuZUnZwWsBcFD5AcGTydYiWNHw5QTwdHe1b7oYzRYx1IdCI+iPsyLccBHhT6k1wAYrU
         eVARmWsBSxKuP4TNhaVSKfdePVezy5gi+QeAw6f3G+E0JLr1JmTTx4yHu19SHfeZGjzc
         AegQ==
X-Gm-Message-State: APjAAAXj8bCOgPWCtnEOlXJgYITppndJbqfGPlgxECgWI5G54irJuiBT
        JyQmwD2GAVIivdIN0cxV782Khs6dObI=
X-Google-Smtp-Source: APXvYqyQGLiJ9yFWvqijAx0nCY2w0vIeQq8A9HbM6+Y3OhMRSng7RxkPAELWod2WHKAJVh/L+Mqmbw==
X-Received: by 2002:a37:480e:: with SMTP id v14mr45074560qka.344.1558465289168;
        Tue, 21 May 2019 12:01:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v48sm5713278qth.46.2019.05.21.12.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 12:01:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTA0t-0007Ce-U9; Tue, 21 May 2019 16:01:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 0/7] More fixes for building
Date:   Tue, 21 May 2019 16:01:17 -0300
Message-Id: <20190521190124.27486-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Various small mistakes I noticed while updating the CI build to run on a
bionic based container.

This is a github PR:

https://github.com/linux-rdma/rdma-core/pull/532

Jason Gunthorpe (7):
  ibacm: Fix format string warning on 32 bit compile
  hns: Remove unneeded malloc.h
  build: Use the system PYTHON_EXECUTABLE for gen-sparse
  build: Support glibc 2.27 with sparse
  build: Revise how gen-sparse finds the system headers
  cbuild: Do not require yaml to always be installed
  build: Expose the cbuild machinery to build the release .tar.gz

 CMakeLists.txt                                |  30 ++---
 buildlib/RDMA_Sparse.cmake                    |   3 +-
 buildlib/cbuild                               |  58 +++++++--
 buildlib/gen-sparse.py                        |  45 +++++--
 buildlib/github-release                       |   7 +-
 .../sparse-include/27/bits-sysmacros.h.diff   |  24 ++++
 buildlib/sparse-include/27/netinet-in.h.diff  | 121 ++++++++++++++++++
 buildlib/sparse-include/27/stdlib.h.diff      |  23 ++++
 buildlib/sparse-include/27/sys-socket.h.diff  |  11 ++
 ibacm/src/acm_util.c                          |   3 +-
 providers/hns/hns_roce_u_hw_v1.c              |   1 -
 providers/hns/hns_roce_u_hw_v2.c              |   1 -
 12 files changed, 279 insertions(+), 48 deletions(-)
 create mode 100644 buildlib/sparse-include/27/bits-sysmacros.h.diff
 create mode 100644 buildlib/sparse-include/27/netinet-in.h.diff
 create mode 100644 buildlib/sparse-include/27/stdlib.h.diff
 create mode 100644 buildlib/sparse-include/27/sys-socket.h.diff

-- 
2.21.0

