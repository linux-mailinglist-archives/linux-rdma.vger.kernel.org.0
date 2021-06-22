Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550C33AFCF1
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 08:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFVGQ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 02:16:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:63359 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhFVGQx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 02:16:53 -0400
IronPort-SDR: Z6S05p7pLJ2ptLOyTatItj2LIh4mlQnOgENWZMiiJJDODGKo5Qq9oPI+C34NX8F3lpKBnT5NkU
 AgOeowe5KQ1w==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="194131560"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="194131560"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 23:14:32 -0700
IronPort-SDR: dUxdZGhfZb6+NVPzyfJSt0om/nnqEWmkNKCMT9DRTUIv8WKzgU+ZSQWeUCN8RYRKTxAfqGY1Dd
 290YzY5zx30g==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="486783249"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 23:14:25 -0700
From:   ira.weiny@intel.com
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Remove use of kmap()
Date:   Mon, 21 Jun 2021 23:14:18 -0700
Message-Id: <20210622061422.2633501-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap() is being deprecated and will break uses of device dax after PKS
protection is introduced.[1]

These kmap() usages don't need to be global and work fine as thread local
mappings.

Replace these kmap() calls with kmap_local_page() which is more appropriate.

The only final use of kmap() in the RDMA subsystem is in the qib driver which
is pretty old at this point.  The use is pretty convoluted and I doubt systems
using that driver are using persistent memory.  So it is left as is.  If this
is a problem I can dig into converting it as well.

[1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/

Ira Weiny (4):
  RDMA/hfi1: Remove use of kmap()
  RDMA/i40iw: Remove use of kmap()
  RDMA/siw: Remove kmap()
  RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()

 drivers/infiniband/hw/hfi1/sdma.c      |  4 +--
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 10 +++---
 drivers/infiniband/sw/siw/siw_qp_tx.c  | 47 +++++++++++++++-----------
 3 files changed, 34 insertions(+), 27 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

