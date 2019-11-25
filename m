Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59211085F8
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 01:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfKYAhS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Nov 2019 19:37:18 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11554 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfKYAhS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Nov 2019 19:37:18 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddb22410000>; Sun, 24 Nov 2019 16:37:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 24 Nov 2019 16:37:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 24 Nov 2019 16:37:17 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 00:37:17 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 00:37:17 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 25 Nov 2019 00:37:17 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ddb223c0000>; Sun, 24 Nov 2019 16:37:16 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/2] mm/gup + IB: allow FOLL_FORCE for gup_fast and use in IB
Date:   Sun, 24 Nov 2019 16:37:13 -0800
Message-ID: <20191125003715.516290-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574642241; bh=o2tsnwufqtiAaAcjzWDmAxcwkNpfpLpA2IYDm85B8JI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=irB0tCRUPHupwE4qwQoe5I0D8UvNcIkF7OLhCOorIQ9dnOPnV+qVaNEyXYup3lWxM
         rMe0WefT5a2SiudyNQnKo80GoU2hF8iECplAr2GsIm9LnBCyDlgP57SqC7J+kGjpuE
         aKP84FMBOdxKX1wQ62yFd68qS8HNZl+w/kRJrNasjqGCWf7UhJTZ7AxMVvXv6g5YXL
         zZyrmQiMVpGlaKn2UVerD1YATlHryBWkZCDoxY/+MrD7U/DC6xTreI05Ii/6FXGAyo
         Vq25DeXZpGwhJm+VzLYtyuhWPl2PcN9PKa0pb5lRL2a5/UEL8/48zrdawePmyxSCE7
         tH5r/fbVLTHqQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon, Jason, Christoph,

Maybe I'm overlooking something, but as I wrote in patch 1, it looks
like we can simply allow FOLL_FORCE to be passed to gup_fast().

This should fix Leon's reported RDMA failure [1]  when using patch 2 by
itself. (I've compile- and boot-tested these, and also did short LTP
and fio with direct IO tests, but I don't have an Infiniband runtime
setup that exercises the umem.c code.)

[1] https://lore.kernel.org/r/20191124100724.GH136476@unreal

John Hubbard (2):
  mm/gup: allow FOLL_FORCE for get_user_pages_fast()
  IB/umem: use get_user_pages_fast() to pin DMA pages

 drivers/infiniband/core/umem.c | 17 ++++++-----------
 mm/gup.c                       |  3 ++-
 2 files changed, 8 insertions(+), 12 deletions(-)

--=20
2.24.0

