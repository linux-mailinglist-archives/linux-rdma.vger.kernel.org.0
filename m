Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E641433A506
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Mar 2021 14:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhCNNjj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 14 Mar 2021 09:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhCNNjN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 14 Mar 2021 09:39:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2A3564EB0;
        Sun, 14 Mar 2021 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615729153;
        bh=sdiXA0KYYraSLxE7VTLkLPUIZscWPeTDAs76unz0GVo=;
        h=From:To:Cc:Subject:Date:From;
        b=twhIaG7RGEkbwO6aZxPg9sYO+9SKKT12JzR1ECfY8v9xuApKGnMeBFaGa7L8gD0o6
         /9gQ0nilkD6eS22mzi1NSq6oFtDHSflfTRAkd27Ugns9pPuAgrbJ3wcpLD52UCLLyb
         DKh1ZCd635riMTlPluUrU1UGXdVcsel5HslL3zRHYAVEzBqEwvBVsAwqYMed13EyMX
         zS62I1Ki65mkSOLrUM/PCn5gR4j/cwHl5nJR6xh/X2GDZCOuMx0E3od2p/Ix5v58bO
         JPQApYmgl0O6rBXf+4ofkkvwTNWMBRPNVBsIeFcXwzoSDFa3JxS0FlLzuaYd3/NY0P
         kWPuncMtjlnWg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: [PATCH rdma-next 0/2] Spring cleanup
Date:   Sun, 14 Mar 2021 15:39:06 +0200
Message-Id: <20210314133908.291945-1-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Bunch of cleanup in RDMA subsystem.

Leon Romanovsky (2):
  RDMA: Fix kernel-doc compilation warnings
  RDMA: Delete not-used static inline functions

 drivers/infiniband/hw/cxgb4/iw_cxgb4.h        | 11 ------
 drivers/infiniband/hw/cxgb4/t4.h              | 33 -----------------
 drivers/infiniband/hw/hfi1/chip.c             |  4 +--
 drivers/infiniband/hw/hfi1/chip.h             |  5 ---
 drivers/infiniband/hw/hfi1/driver.c           |  2 +-
 drivers/infiniband/hw/hfi1/exp_rcv.c          |  6 ++--
 drivers/infiniband/hw/hfi1/hfi.h              |  6 ----
 drivers/infiniband/hw/hfi1/init.c             |  3 +-
 drivers/infiniband/hw/hfi1/msix.c             | 12 +++----
 drivers/infiniband/hw/hfi1/netdev_rx.c        |  2 +-
 drivers/infiniband/hw/hfi1/sdma.c             |  2 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.h      |  5 ---
 drivers/infiniband/hw/i40iw/i40iw.h           |  9 -----
 drivers/infiniband/hw/i40iw/i40iw_cm.c        |  4 +--
 drivers/infiniband/hw/i40iw/i40iw_hmc.c       |  4 +--
 drivers/infiniband/hw/i40iw/i40iw_main.c      |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_osdep.h     | 22 ------------
 drivers/infiniband/hw/i40iw/i40iw_puda.c      |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_utils.c     |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  4 +--
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c  |  2 +-
 drivers/infiniband/hw/qib/qib.h               | 26 --------------
 drivers/infiniband/hw/qib/qib_common.h        |  7 ----
 drivers/infiniband/hw/qib/qib_file_ops.c      |  5 +--
 drivers/infiniband/hw/qib/qib_iba6120.c       |  2 +-
 drivers/infiniband/hw/qib/qib_iba7220.c       |  4 +--
 drivers/infiniband/hw/qib/qib_iba7322.c       |  4 +--
 drivers/infiniband/hw/qib/qib_init.c          |  2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h     | 10 ------
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  |  2 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   | 35 -------------------
 drivers/infiniband/sw/siw/iwarp.h             | 13 -------
 drivers/infiniband/sw/siw/siw_mem.h           |  5 ---
 33 files changed, 36 insertions(+), 221 deletions(-)

--
2.30.2

