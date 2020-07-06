Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9D82156FE
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 14:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgGFMEW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 08:04:22 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:52998 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFMEV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 08:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594037061; x=1625573061;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y/PIIs/vC+z/31HpfEFQfy8mSRAqh8hnzcN+FHFqxjs=;
  b=dSNkjQnEtwnEt2zz+5Il+1zHCyt1LCdbegT1uVlOmfaC+KwBjO6fBluy
   KUhJTtFyXvk+f7gY9DfWOjLQqFzjyyZs/NfP80RNQHoFD98ITqpJGpXvE
   hAVcCk6oQbaxcIT7MtTeRe1LaA3gEA8xgfmapieZ3NxqgIGtGXuUGSkbx
   0=;
IronPort-SDR: XlT3uPjBaFGOdcqZuesWvDE1OeCEYVi6zjk1vvwqfr109QFMiTy4dl66A7eSDwe/WQHFQs/wUx
 E0YjykOEoWNA==
X-IronPort-AV: E=Sophos;i="5.75,318,1589241600"; 
   d="scan'208";a="56360705"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 06 Jul 2020 12:04:19 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 92274A2350;
        Mon,  6 Jul 2020 12:04:17 +0000 (UTC)
Received: from EX13D40UWC004.ant.amazon.com (10.43.162.175) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:04:17 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D40UWC004.ant.amazon.com (10.43.162.175) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 12:04:17 +0000
Received: from 8c85908914bf.ant.amazon.com (10.1.213.24) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 6 Jul 2020 12:04:09 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Adit Ranadive <aditr@vmware.com>,
        "VMware PV-Drivers" <pv-drivers@vmware.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        "Bernard Metzler" <bmt@zurich.ibm.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 0/3] Allocate MR cleanups
Date:   Mon, 6 Jul 2020 15:03:40 +0300
Message-ID: <20200706120343.10816-1-galpress@amazon.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The allocate MR functionality is limited to kernel users, there is no
reason to pass a redundant udata parameter.
In addition, a small cleanup was added to the MR allocation function to
keep the main flow unindented.

Gal Pressman (3):
  RDMA/core: Check for error instead of success in alloc MR function
  RDMA/core: Remove ib_alloc_mr_user function
  RDMA: Remove the udata parameter from alloc_mr callback

 drivers/infiniband/core/verbs.c               | 36 +++++++++----------
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  2 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  2 +-
 drivers/infiniband/hw/cxgb4/mem.c             |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c       |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  3 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |  2 +-
 drivers/infiniband/hw/mlx4/mr.c               |  2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |  2 +-
 drivers/infiniband/hw/mlx5/mr.c               |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |  2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h   |  2 +-
 drivers/infiniband/hw/qedr/verbs.c            |  2 +-
 drivers/infiniband/hw/qedr/verbs.h            |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c  |  2 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   |  2 +-
 drivers/infiniband/sw/rdmavt/mr.c             |  2 +-
 drivers/infiniband/sw/rdmavt/mr.h             |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c         |  2 +-
 drivers/infiniband/sw/siw/siw_verbs.c         |  2 +-
 drivers/infiniband/sw/siw/siw_verbs.h         |  2 +-
 include/rdma/ib_verbs.h                       | 12 ++-----
 24 files changed, 43 insertions(+), 50 deletions(-)

-- 
2.27.0

