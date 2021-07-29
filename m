Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C01C3DA460
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbhG2Nbc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 09:31:32 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:3624 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237459AbhG2Nbc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 09:31:32 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TDU4kG018980;
        Thu, 29 Jul 2021 06:31:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=j8xEPaO+RYnhsykO/LxX63htO6JkthZH2M3FEulbfD8=;
 b=e7QDIXSW8Wl57f2hFt6rO/e6Pgmj9SWfbyB3uoOAosZLr9ygUkBRggsDcPUe0ft7qq1b
 lPFLB+RhD5hfmDlpW/6aQ4o0aYAoRDqb+MFqczJb8q3caf0fKn/x9tmoCW1EohnEdf0K
 kr7FF4Rm/SXWpxzRNTwUprVEgi29UesMef5uSSj9yr3aD98tLA4NKKOH83Cg6b7YXbl5
 1BItvyP4cTrpRS8NE8Mp64DlD4KZr7oNhkxhxJvNWNf9nsi0YBd9G5121Al+tNGJujiN
 6I1qKaGqbrQkdTXYTI8Adu4R9DgWp0Xqtc34tBdUkvNQkSluYKvFi1btza6q+Dsk6Ayr dg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3a3w5kr1ug-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 06:31:23 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 29 Jul
 2021 06:30:37 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Thu, 29 Jul 2021 06:30:34 -0700
From:   Shai Malin <smalin@marvell.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <mkalderon@marvell.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
        <aelior@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH for-next 0/3] qedr: consider dscp prio for vlan tag and update tos
Date:   Thu, 29 Jul 2021 16:30:29 +0300
Message-ID: <20210729133032.26278-1-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: fQrPXQN5c37f-5OLexFVzEk8wRz5le5X
X-Proofpoint-ORIG-GUID: fQrPXQN5c37f-5OLexFVzEk8wRz5le5X
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Prabhakar Kushwaha <pkushwaha@marvell.com>

Add functions to check get/set dscp priority in qed and these functions
are further used in deciding vlan priority based on dscp state.

Also update RDMA CM TOS.

Prabhakar Kushwaha (3):
  qed: add get and set support for dscp priority
  qedr: Consider dscp priority for vlan priority
  qedr: Use grh layer traffic_class as RDMA CM TOS

 drivers/infiniband/hw/qedr/qedr_roce_cm.c  | 13 +++-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c | 72 ++++++++++++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_dcbx.h | 10 +++
 drivers/net/ethernet/qlogic/qed/qed_rdma.c | 26 ++++++++
 include/linux/qed/qed_if.h                 |  6 ++
 include/linux/qed/qed_rdma_if.h            |  7 +++
 6 files changed, 132 insertions(+), 2 deletions(-)

-- 
2.24.1

