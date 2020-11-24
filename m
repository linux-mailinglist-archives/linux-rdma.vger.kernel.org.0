Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C589C2C34F9
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 00:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgKXXwY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 18:52:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:19164 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgKXXwX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 18:52:23 -0500
IronPort-SDR: 5BxE5a9yCS4+Mmnwd08zAKP9oe5nbSCsp91vHr2KLNLlv20nQN8fTjEwYIMaMO0oAyT7leRnku
 S/t0rnJmAVTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="236173478"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="236173478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 15:52:22 -0800
IronPort-SDR: N0BpXHo3R1kFo6GEQwQSPDxGgx8B1nwP9M8KppbouYliikmpHXTOFJuzOf4PIV1vKp0RplPvxE
 OzcV5+4fEtdw==
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="478697783"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.134.32])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 15:52:22 -0800
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, stable@kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v1 0/2] Fix an mmap exploit and remove push in i40iw
Date:   Tue, 24 Nov 2020 17:51:01 -0600
Message-Id: <20201124235102.1745-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

i40iw_mmap is vulnerable to an mmap exploit due to its manipulation on
vma->vm_pgoff done for the push feature, and its subsequent use in
remap_pfn_range without validation.

Patch #1 fixes the mmap exploit in i40iw_mmap and can be backported to stable if acceptable.

Patch #2 removes the push feature from the driver

v0-->v1:
* Add missing cc and reported by tags in Patch #1

Shiraz Saleem (2):
  RDMA/i40iw: Address an mmap handler exploit in i40iw
  RDMA/i40iw: Remove push code from i40iw

 drivers/infiniband/hw/i40iw/i40iw.h        |    1 -
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c   |   52 +------------
 drivers/infiniband/hw/i40iw/i40iw_d.h      |   35 +++-----
 drivers/infiniband/hw/i40iw/i40iw_main.c   |    5 -
 drivers/infiniband/hw/i40iw/i40iw_status.h |    1 -
 drivers/infiniband/hw/i40iw/i40iw_type.h   |   18 ----
 drivers/infiniband/hw/i40iw/i40iw_uk.c     |   41 +--------
 drivers/infiniband/hw/i40iw/i40iw_user.h   |    8 --
 drivers/infiniband/hw/i40iw/i40iw_verbs.c  |  123 ++--------------------------
 9 files changed, 25 insertions(+), 259 deletions(-)

