Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044F03DB3E3
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 08:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbhG3GuU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 02:50:20 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:12252 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237687AbhG3GuU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Jul 2021 02:50:20 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U6f0nW030245;
        Thu, 29 Jul 2021 23:50:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=jf4jx9feS5JLVSQtUFLtFd13zUfLS7ZvQ+g/bRGe8yM=;
 b=RS8H+mJSmaUBGFWIU+u9d5H+yr9BBhpPL/Nmsd6BX5akDNxBpz8o6S4yHPwLXMQGhCUU
 Wr/kVOx+kzr5caUJYvmwIFYI5SkNlDAmlJW2tSu8MXJ3fWX/BS4ttF4g+iPHM+qnh1kT
 F9DZwjbPtOl3w/SRIP82/ik8Rc5yptq0YiaWSn+alh1VrZVtEq51faP4YuV+qC/ZMuCw
 5lUCpyJ2jJdixddH3bl/Ac1Vi6jQLi3jkp79GsqpPFH2sB+BAe4nIQ2ePnbl5kY3y9Mg
 kQsHhMyTFWJnkkQYrGrr9ZeFDEmhlCWoq7CUePkqg74W51JN0BswuJLstyH2bR15S0kB tA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3a456ts8gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 23:50:09 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 29 Jul
 2021 23:50:07 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Thu, 29 Jul 2021 23:50:05 -0700
From:   Shai Malin <smalin@marvell.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <mkalderon@marvell.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
        <aelior@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH for-next 0/3][v2] qedr: consider dscp prio for vlan tag and update tos
Date:   Fri, 30 Jul 2021 09:49:58 +0300
Message-ID: <20210730065001.805-1-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: tfLxf-cLhMC7X9lA127nrqtXK91zGxop
X-Proofpoint-ORIG-GUID: tfLxf-cLhMC7X9lA127nrqtXK91zGxop
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_04:2021-07-29,2021-07-30 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Prabhakar Kushwaha <pkushwaha@marvell.com>

Add functions to check get/set dscp priority in qed and these functions
are further used in deciding vlan priority based on dscp state.

Also update RDMA CM TOS.

Changes for v2:
	- incorporated Leon Romanovsky's comments

Prabhakar Kushwaha (3):
  qed: add get and set support for dscp priority
  qedr: Consider dscp priority for vlan priority
  qedr: Use grh layer traffic_class as RDMA CM TOS

 drivers/infiniband/hw/qedr/qedr_roce_cm.c  | 13 +++-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c | 71 ++++++++++++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_dcbx.h | 10 +++
 drivers/net/ethernet/qlogic/qed/qed_rdma.c | 25 ++++++++
 include/linux/qed/qed_if.h                 |  6 ++
 include/linux/qed/qed_rdma_if.h            |  7 +++
 6 files changed, 130 insertions(+), 2 deletions(-)

-- 
2.24.1

