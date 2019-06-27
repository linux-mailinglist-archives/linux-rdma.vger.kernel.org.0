Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD9758407
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0OAS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 10:00:18 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:62864 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726663AbfF0OAR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 10:00:17 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RDtGjJ001389;
        Thu, 27 Jun 2019 06:59:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=cEY4BF82XOFZw/kR9kEtjHXCCWJyAicpHPs7XaYuwhE=;
 b=BQnJVKQB6dmivaSjjiosfN2r6n0BiYQJJxlzrJ+902EZ2xBQ6N4qazBq7em/jl4ZeXFI
 yqeIJ0cV62O3bOBQoodqR0t8Zra6Nag74LhpCO3fYiDRY1NkWr8CDIyhrVAHXg1lbRZH
 lrz52U49rS+PET+U5qUlSPoVQG7jb4ORDgUUpYfgY78ziuVWhjHE7AYTYInNrUh0my42
 oKWBKjUYZhkJNa6LNSHfL9TGekFtZb/3bzfhjRp/uTLQyGqch5i0ei6QIpzCuuI9EqSl
 mqTnzUWSGy0/1Qzr28C5usWMNCoGT8ICYtlxwL2QwQQaLOe/3ZUMsjn2EgUn9R596ZRa vA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tcvrs8kd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 06:59:55 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 27 Jun
 2019 06:59:54 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 27 Jun 2019 06:59:54 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id 619903F7041;
        Thu, 27 Jun 2019 06:59:52 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <galpress@amazon.com>, <jgg@ziepe.ca>, <dledford@redhat.com>,
        <leon@kernel.org>, <sleybo@amazon.com>,
        <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: [RFC rdma 0/3] Add a common mmap API
Date:   Thu, 27 Jun 2019 16:58:22 +0300
Message-ID: <20190627135825.4924-1-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_08:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series moves all mmap related function from efa driver to
ib_core. The code is copied almost as is with some minor
changes not to use efa specific structures. 
Functions and structures were renamed to have rdma_user_mmap
prefix instead of efa. 

The efa driver and qedr driver are modified to use the common
API. 

This code change is preliminary and requires testing, sent as
an RFC to see if it is acceptable to go in this direction. 
Michal Kalderon (3):
  RDMA/core: Create a common mmap function
  RDMA/efa: Use the common mmap API
  RDMA/qedr: User the common mmap API

 drivers/infiniband/core/rdma_core.c   |   1 +
 drivers/infiniband/core/uverbs_cmd.c  |   1 +
 drivers/infiniband/core/uverbs_main.c | 177 ++++++++++++++++++++++++
 drivers/infiniband/hw/efa/efa.h       |   2 -
 drivers/infiniband/hw/efa/efa_main.c  |   2 +-
 drivers/infiniband/hw/efa/efa_verbs.c | 248 +++++-----------------------------
 drivers/infiniband/hw/qedr/main.c     |   2 +-
 drivers/infiniband/hw/qedr/qedr.h     |  13 --
 drivers/infiniband/hw/qedr/verbs.c    | 125 ++---------------
 drivers/infiniband/hw/qedr/verbs.h    |   1 -
 include/rdma/ib_verbs.h               |  29 ++++
 11 files changed, 249 insertions(+), 352 deletions(-)

-- 
2.14.5

