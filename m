Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F048DE2376
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 21:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390417AbfJWTzY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 15:55:24 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13559 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfJWTzX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 15:55:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db0b02f0000>; Wed, 23 Oct 2019 12:55:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 23 Oct 2019 12:55:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 23 Oct 2019 12:55:22 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Oct
 2019 19:55:17 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 23 Oct 2019 19:55:17 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5db0b0250003>; Wed, 23 Oct 2019 12:55:17 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v3 0/3] HMM tests and minor fixes
Date:   Wed, 23 Oct 2019 12:55:12 -0700
Message-ID: <20191023195515.13168-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571860527; bh=pKsqywyqkPUWdC01GQUc5JE3JAYljHqFpxxgzuwg5Ig=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=VzM9m/nRhsUN+U0kVN1J6xlUJ+TUD0ZT40vMiAjmyzZQKCCfLs6vn3GbAgUDkcEZQ
         0rLM2QdgwPTibNN38mym9vKUICrJ0g/hjQDEFEMuMM/QRULteFtF9YBC9NiRGWMrY/
         gZWTikGFvoXHp6TctNP+dkKMQIxHcR7usLwoW+MepWuGUlmFhTajxDw9OP8N6FKfc4
         b9hB9lWTb8oBcdukIeua+CWrtoWhD9F9S1EEcmRBlbomo5VO2eyLpiQDVvMVg8nyNY
         617gBwTBE6cZMwx4FH9LPQeGJgT0vrmqdNyWCqRFgkmMbvfh9D2WIq6nZcPnkw75pD
         AJz33oCCmeh7A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These changes are based on Jason's rdma/hmm branch (5.4.0-rc1).
Patch 1 was previously posted here [1] but was dropped from that orginal
series. Hopefully, the tests will reduce concerns about edge conditions.
I'm sure more tests could be usefully added but I thought this was a good
starting point.

Changes since v2:
patch 1:
Removed hmm_range_needs_fault() and just use hmm_range_need_fault().
Updated the change log to include that it fixes a bug where
hmm_range_fault() incorrectly returned an error when no fault is requested.
patch 2:
Removed the confusing change log wording about DMA.
Changed hmm_range_fault() to return the PFN of the zero page like any other
page.
patch 3:
Adjusted the test code to match the new zero page behavior.

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
 drivers/char/hmm_dmirror.c             | 1566 ++++++++++++++++++++++++
 include/Kbuild                         |    1 +
 include/uapi/linux/hmm_dmirror.h       |   74 ++
 mm/hmm.c                               |  136 +-
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    3 +
 tools/testing/selftests/vm/hmm-tests.c | 1311 ++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |   97 ++
 13 files changed, 3158 insertions(+), 65 deletions(-)
 create mode 100644 drivers/char/hmm_dmirror.c
 create mode 100644 include/uapi/linux/hmm_dmirror.h
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

--=20
2.20.1

