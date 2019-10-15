Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F20AD8151
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 22:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbfJOUs0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 16:48:26 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11357 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfJOUs0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Oct 2019 16:48:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da6309e0002>; Tue, 15 Oct 2019 13:48:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Oct 2019 13:48:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Oct 2019 13:48:25 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Oct
 2019 20:48:25 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Oct
 2019 20:48:20 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 15 Oct 2019 20:48:20 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da630940000>; Tue, 15 Oct 2019 13:48:20 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 0/3] HMM tests and minor fixes
Date:   Tue, 15 Oct 2019 13:48:11 -0700
Message-ID: <20191015204814.30099-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571172510; bh=rS+xTIAGRfJcOcX7xmaAy1sXD189JENoPg3WT4zZ3w8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=JUfM0oRXJ8VmwTsQA6KDwdNIZaJidSiZmSCnw1rZ9ronfzybgAMf+04OCMtnpi7MV
         +2ozGnL2BM3HcJOL27YpXF4TAno8j0ND0seWl98OYz1unFEp5d9k4JZTinyhOUX2e8
         V1WNlc5+uZuxiN/YroFRiNaAlnsrwzAY1ooHy55oqAas5BGpyw//Hz6Li5knxDG4HM
         n7h8LDD8Q3fD4wUSpwiS1/1be6Rw13gkLSg9t0GLb5teM7iCY9n9Sm4zfprGB+utsD
         uGkUITMXRiBpgMnll8nUryEHmdVfPfhPGN+GCVBwyHa3GY8NE4jRUJhoQoeZLTNpmr
         /M7B+W4tjkjPQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These changes are based on Jason's rdma/hmm branch (5.4.0-rc1).
Patch 1 was previously posted here [1] but was dropped from that orginal
series. Hopefully, the tests will reduce concerns about edge conditions.
I'm sure more tests could be usefully added but I thought this was a good
starting point.

Changes since v1:
Rebased to Jason's rdma/hmm branch (5.4.0-rc1).
Cleaned up locking for the test driver's page tables.
Incorporated Christoph Hellwig's comments.

[1] https://lore.kernel.org/linux-mm/20190726005650.2566-6-rcampbell@nvidia=
.com/

Ralph Campbell (3):
  mm/hmm: make full use of walk_page_range()
  mm/hmm: allow snapshot of the special zero page
  mm/hmm/test: add self tests for HMM

 MAINTAINERS                            |    3 +
 drivers/char/Kconfig                   |   11 +
 drivers/char/Makefile                  |    1 +
 drivers/char/hmm_dmirror.c             | 1574 ++++++++++++++++++++++++
 include/Kbuild                         |    1 +
 include/uapi/linux/hmm_dmirror.h       |   74 ++
 mm/hmm.c                               |  147 ++-
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    3 +
 tools/testing/selftests/vm/hmm-tests.c | 1311 ++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |   97 ++
 13 files changed, 3178 insertions(+), 64 deletions(-)
 create mode 100644 drivers/char/hmm_dmirror.c
 create mode 100644 include/uapi/linux/hmm_dmirror.h
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

--=20
2.20.1

