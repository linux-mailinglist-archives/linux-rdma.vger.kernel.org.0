Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443D71F7E03
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2020 22:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFLUUI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jun 2020 16:20:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:42446 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgFLUUH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jun 2020 16:20:07 -0400
IronPort-SDR: xsqYDBkZnFjxwC9MVHmnDdmakSM3d2LtInCHJXl3KepEPCwfn7qsu/rdA4utj5O8fzm8p6jdUm
 pcCypgeRdCUg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 13:20:07 -0700
IronPort-SDR: 4xilpdnf7ON93lxqV3VprOhe8x3XEw605cJ4dtj+hHSFWxNW/BS40ravYxfV1GsezB4R83EeKI
 oPmSn4JOwdXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; 
   d="scan'208";a="260005081"
Received: from lkp-server02.sh.intel.com (HELO de5642daf266) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2020 13:20:05 -0700
Received: from kbuild by de5642daf266 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jjq9k-000064-CP; Fri, 12 Jun 2020 20:20:04 +0000
Date:   Sat, 13 Jun 2020 04:19:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ariel Elior <ariel.elior@marvell.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH stable] RDMA/qedr: qedr_iw_load_qp() can be static
Message-ID: <20200612201903.GA57396@0a3611e7790e>
References: <202006130434.950ZY2zY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006130434.950ZY2zY%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Fixes: 8a69220b659c ("RDMA/qedr: Fix synchronization methods and memory leaks in qedr")
Signed-off-by: kernel test robot <lkp@intel.com>
---
 qedr_iw_cm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index 5e9732990be5c..a98002018f0ce 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -506,7 +506,7 @@ qedr_addr6_resolve(struct qedr_dev *dev,
 	return rc;
 }
 
-struct qedr_qp *qedr_iw_load_qp(struct qedr_dev *dev, u32 qpn)
+static struct qedr_qp *qedr_iw_load_qp(struct qedr_dev *dev, u32 qpn)
 {
 	struct qedr_qp *qp;
 
