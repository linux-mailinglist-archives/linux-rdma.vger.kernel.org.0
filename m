Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADE0241DB7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 09:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391200AbfFLH2x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 03:28:53 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:16667 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389710AbfFLH2x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 03:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560324534; x=1591860534;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D04Ngx1nd+JP0FBTOZtn+KFnQrwJA+znHOwQVSNqrvc=;
  b=lkh9U8Ktf+AQU7+dhrM1o9sf316ozvkf9+c5ANcgeDAI8SHEOn8q4hVa
   tNAb8KyhWPFSzoHgJOyLlENCsQdAVSjjHkpBeQyW2C3hgTOlTlCrsuQQT
   eGlDQFMlHwk+7655VeVHSAdgJXu9yxHnJ3Y2ZJBGEWQWlFSNy6cSXsJBV
   0=;
X-IronPort-AV: E=Sophos;i="5.62,363,1554768000"; 
   d="scan'208";a="400367605"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 12 Jun 2019 07:28:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id 03029A1E4A;
        Wed, 12 Jun 2019 07:28:50 +0000 (UTC)
Received: from EX13D19EUA002.ant.amazon.com (10.43.165.247) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 07:28:50 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D19EUA002.ant.amazon.com (10.43.165.247) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 07:28:49 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.132) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 12 Jun 2019 07:28:47 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-rc 0/2] EFA fixes 2019-06-12
Date:   Wed, 12 Jun 2019 10:28:40 +0300
Message-ID: <20190612072842.99285-1-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

This submission introduces two bug fixes for the EFA driver.

Patch #1 handles flows which mistakenly return success in case of
error.
Patch #2 handles cases where the 32 bits mmap key overflows on xarray
insertions.

Thanks,
Gal

Gal Pressman (2):
  RDMA/efa: Fix success return value in case of error
  RDMA/efa: Handle mmap insertions overflow

 drivers/infiniband/hw/efa/efa_com_cmd.c | 24 ++++++++++++++++++------
 drivers/infiniband/hw/efa/efa_verbs.c   | 21 ++++++++++++++++-----
 2 files changed, 34 insertions(+), 11 deletions(-)

-- 
2.22.0

