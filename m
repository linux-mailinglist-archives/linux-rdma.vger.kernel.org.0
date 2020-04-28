Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BAB1BB42F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 04:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD1Cxg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 22:53:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:24665 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgD1Cxg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 22:53:36 -0400
IronPort-SDR: 1f1KlkdY7z3/5L0DSG0Ti0Fzenz+L/xLOXTZRQ/hAkinaTbFIze6wIJZMZETcMQLZmkuvnm2Yj
 di0ka8lfE6Mg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 19:53:35 -0700
IronPort-SDR: +9zSd6UVwMBdTb8xVjFgeOUPBac7UZKfuWnfxAy2QqeNYk9nUNhbI6jcjw0i0ZnInusFSC+4dA
 oG6uFCDHNbZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,326,1583222400"; 
   d="scan'208";a="459082784"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 19:53:33 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jTGNJ-0009Sk-96; Tue, 28 Apr 2020 10:53:33 +0800
Date:   Tue, 28 Apr 2020 10:52:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     kbuild-all@lists.01.org, leon@kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: [RFC PATCH] RDMA/hns: hns_roce_mr_free() can be static
Message-ID: <20200428025237.GA10142@41ada6197895>
References: <1587883377-22975-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587883377-22975-2-git-send-email-liweihang@huawei.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Signed-off-by: kbuild test robot <lkp@intel.com>
---
 hns_roce_mr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index be8656846bcb4..312f59b6b3385 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -372,7 +372,7 @@ static void free_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 	hns_roce_mtr_destroy(hr_dev, &mr->pbl_mtr);
 }
 
-void hns_roce_mr_free(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
+static void hns_roce_mr_free(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
