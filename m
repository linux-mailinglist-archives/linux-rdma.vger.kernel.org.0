Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0FB298DC5
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422096AbgJZN0l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422079AbgJZN0l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:26:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E2F722281;
        Mon, 26 Oct 2020 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718800;
        bh=uUX/KcKjeg8opIAXLG2aprj4srsVJS6vz4APL9JfaRQ=;
        h=From:To:Cc:Subject:Date:From;
        b=V2+nvA9ykYf5mjabqZKTklSWPhVJAE9R10F1y3oeRx24tU5nmTR2oWvK6vHz/Gd7z
         a7pzQIe/bDbynFbePTTC7EvP3eV9hA/OHSQAHSPI8FbnDDS3OgTfrhB+asMC5OJcSV
         wBcF1tnIKfMwf4oX2Ek548rmYuS6kKvAnrNmwVvg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eli Cohen <eli@mellanox.com>,
        Haggai Abramonvsky <hagaya@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        "majd@mellanox.com" <majd@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Roland Dreier <roland@purestorage.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 0/6] Use ib_umem_find_best_pgsz() for all umems
Date:   Mon, 26 Oct 2020 15:26:29 +0200
Message-Id: <20201026132635.1337663-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

From Jason:

Move the remaining cases working with umems to use versions of
ib_umem_find_best_pgsz() tailored to the calculations the devices
requires.

Unlike a MR there is no IOVA, instead a page offset from the starting page
is possible, with various restrictions.

Compute the best page size to meet the page_offset restrictions.

Thanks

Jason Gunthorpe (6):
  RDMA/mlx5: Use ib_umem_find_best_pgsz() for devx
  RDMA/mlx5: Use ib_umem_find_best_pgoff() for SRQ
  RDMA/mlx5: Use mlx5_umem_find_best_quantized_pgoff() for WQ
  RDMA/mlx5: Use mlx5_umem_find_best_quantized_pgoff() for QP
  RDMA/mlx5: mlx5_umem_find_best_quantized_pgoff() for CQ
  RDMA/mlx5: Lower setting the umem's PAS for SRQ

 drivers/infiniband/hw/mlx5/cq.c      |  48 ++++++++---
 drivers/infiniband/hw/mlx5/devx.c    |  56 ++++++------
 drivers/infiniband/hw/mlx5/mem.c     | 115 +++++++++----------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  56 ++++++++++--
 drivers/infiniband/hw/mlx5/qp.c      | 124 ++++++++++++---------------
 drivers/infiniband/hw/mlx5/srq.c     |  27 +-----
 drivers/infiniband/hw/mlx5/srq.h     |   1 +
 drivers/infiniband/hw/mlx5/srq_cmd.c |  80 ++++++++++++++++-
 include/rdma/ib_umem.h               |  42 +++++++++
 9 files changed, 326 insertions(+), 223 deletions(-)

--
2.26.2

