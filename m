Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB87425152
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 12:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbhJGKp0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 06:45:26 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:3078 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240800AbhJGKpZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 06:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1633603412; x=1665139412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NNoJ2JFFRziHZiTbB/PCsJ4bfqbQfqXZ170Oox+pA2I=;
  b=RXVJj24tWBGv7yhk3UwT8fGRA4OoVyNKyDFe8XGiXapmsAN7zOer8jl5
   6AtXxHOFD2Pe/GEHJUOWLLInQGP3fsHgJjDxkXRddnCjPHiyM882S+iSc
   iEBRgWYh24Z24mdiz/J2116ovOP95E5Sbn5D81VWdJLVTjjzqW2wGHrou
   g=;
X-IronPort-AV: E=Sophos;i="5.85,354,1624320000"; 
   d="scan'208";a="165371252"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 07 Oct 2021 10:43:22 +0000
Received: from EX13D19EUB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-4ba5c7da.us-east-1.amazon.com (Postfix) with ESMTPS id 73C5F8D8DB;
        Thu,  7 Oct 2021 10:43:18 +0000 (UTC)
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUB002.ant.amazon.com (10.43.166.78) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 7 Oct 2021 10:43:17 +0000
Received: from 8c85908914bf.ant.amazon.com.com (10.1.213.27) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Thu, 7 Oct 2021 10:43:10 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Firas Jahjah <firasj@amazon.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [RFC PATCH 0/2] EFA dmabuf memory regions
Date:   Thu, 7 Oct 2021 13:42:58 +0300
Message-ID: <20211007104301.76693-1-galpress@amazon.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey all,

This is a followup to my previous RFC [1], which now makes use of the
dynamic attachment API implemented in the RDMA subsystem, but calls
dma_buf_pin() in order to make sure that the move_notify callback will
not be used, as suggested by Christian.
As explained in the previous RFC, move_notify requires the RDMA device
to support on-demand-paging (ODP) which is not common on most devices
(only supported by mlx5).

While the dynamic requirement makes sense for certain GPUs, some devices
(such as habanalabs) have device memory that is always "pinned" and do
not need/use the move_notify operation.

The first patch changes the dmabuf documentation to make it clear that
pinning does not necessarily mean the memory must be moved to system
memory, it is up to the exporter to decide.

The motivation of this RFC is to use habanalabs as the dmabuf exporter,
and EFA as the importer to allow for peer2peer access through libibverbs.

[1] https://lore.kernel.org/linux-rdma/20210818074352.29950-1-galpress@amazon.com/

Thanks

Gal Pressman (2):
  dma-buf: Fix pin callback comment
  RDMA/efa: Add support for dmabuf memory regions

 drivers/infiniband/hw/efa/efa.h       |   4 +
 drivers/infiniband/hw/efa/efa_main.c  |   1 +
 drivers/infiniband/hw/efa/efa_verbs.c | 166 +++++++++++++++++++++-----
 include/linux/dma-buf.h               |   4 +-
 4 files changed, 142 insertions(+), 33 deletions(-)

-- 
2.33.0

