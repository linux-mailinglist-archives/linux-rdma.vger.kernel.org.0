Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30F6F2A96F
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2019 13:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfEZLmd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 May 2019 07:42:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727621AbfEZLmc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 May 2019 07:42:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4QBb9an041102
        for <linux-rdma@vger.kernel.org>; Sun, 26 May 2019 07:42:31 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sqk4y24t5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Sun, 26 May 2019 07:42:30 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Sun, 26 May 2019 12:42:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 26 May 2019 12:42:26 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4QBgPag59965538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 May 2019 11:42:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EF4AA405F;
        Sun, 26 May 2019 11:42:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BD7DA4054;
        Sun, 26 May 2019 11:42:25 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 26 May 2019 11:42:25 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH for-next v1 00/12] SIW: Software iWarp RDMA (siw) driver
Date:   Sun, 26 May 2019 13:41:44 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19052611-0012-0000-0000-0000031F8BFF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052611-0013-0000-0000-000021584C95
Message-Id: <20190526114156.6827-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=643 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905260083
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set contributes the SoftiWarp driver rebased for
Kernel 5.2-rc1. SoftiWarp (siw) implements the iWarp RDMA
protocol over kernel TCP sockets. The driver integrates with
the linux-rdma framework.

With this new driver version, the following things where
changed, compared to the v8 RFC of siw:

o Rebased to 5.2-rc1

o All IDR code got removed.

o Both MR and QP deallocation verbs now synchronously
  free the resources referenced by the RDMA mid-layer.

o IPv6 support was added.

o For compatibility with Chelsio iWarp hardware, the RX
  path was slightly reworked. It now allows packet intersection
  between tagged and untagged RDMAP operations. While not
  a defined behavior as of IETF RFC 5040/5041, some RDMA hardware
  may intersect an ongoing outbound (large) tagged message, such
  as an multisegment RDMA Read Response with sending an untagged
  message, such as an RDMA Send frame. This behavior was only
  detected in an NVMeF setup, where siw was used at target side,
  and RDMA hardware at client side (during file write). siw now
  implements two input paths for tagged and untagged messages each,
  and allows the intersected placement of both messages.

o The siw kernel abi file got renamed from siw_user.h to siw-abi.h.

Many thanks for reviewing and testing the driver, especially to
Steve, Leon, Jason, Doug, Olga, Dennis, Gal. You all helped to
significantly improve the siw driver over the last year. It is
very much appreciated.

Many thanks!
Bernard.

Bernard Metzler (12):
  iWarp wire packet format
  SIW main include file
  SIW network and RDMA core interface
  SIW connection management
  SIW application interface
  SIW application buffer management
  SIW queue pair methods
  SIW transmit path
  SIW receive path
  SIW completion queue methods
  SIW debugging
  SIW addition to kernel build environment

 MAINTAINERS                              |    7 +
 drivers/infiniband/Kconfig               |    1 +
 drivers/infiniband/sw/Makefile           |    1 +
 drivers/infiniband/sw/siw/Kconfig        |   17 +
 drivers/infiniband/sw/siw/Makefile       |   12 +
 drivers/infiniband/sw/siw/iwarp.h        |  380 ++++
 drivers/infiniband/sw/siw/siw.h          |  720 ++++++++
 drivers/infiniband/sw/siw/siw_cm.c       | 2109 ++++++++++++++++++++++
 drivers/infiniband/sw/siw/siw_cm.h       |  133 ++
 drivers/infiniband/sw/siw/siw_cq.c       |  109 ++
 drivers/infiniband/sw/siw/siw_debug.c    |  102 ++
 drivers/infiniband/sw/siw/siw_debug.h    |   35 +
 drivers/infiniband/sw/siw/siw_main.c     |  701 +++++++
 drivers/infiniband/sw/siw/siw_mem.c      |  462 +++++
 drivers/infiniband/sw/siw/siw_mem.h      |   74 +
 drivers/infiniband/sw/siw/siw_qp.c       | 1345 ++++++++++++++
 drivers/infiniband/sw/siw/siw_qp_rx.c    | 1537 ++++++++++++++++
 drivers/infiniband/sw/siw/siw_qp_tx.c    | 1276 +++++++++++++
 drivers/infiniband/sw/siw/siw_verbs.c    | 1778 ++++++++++++++++++
 drivers/infiniband/sw/siw/siw_verbs.h    |  102 ++
 include/uapi/rdma/rdma_user_ioctl_cmds.h |    1 +
 include/uapi/rdma/siw-abi.h              |  186 ++
 22 files changed, 11088 insertions(+)
 create mode 100644 drivers/infiniband/sw/siw/Kconfig
 create mode 100644 drivers/infiniband/sw/siw/Makefile
 create mode 100644 drivers/infiniband/sw/siw/iwarp.h
 create mode 100644 drivers/infiniband/sw/siw/siw.h
 create mode 100644 drivers/infiniband/sw/siw/siw_cm.c
 create mode 100644 drivers/infiniband/sw/siw/siw_cm.h
 create mode 100644 drivers/infiniband/sw/siw/siw_cq.c
 create mode 100644 drivers/infiniband/sw/siw/siw_debug.c
 create mode 100644 drivers/infiniband/sw/siw/siw_debug.h
 create mode 100644 drivers/infiniband/sw/siw/siw_main.c
 create mode 100644 drivers/infiniband/sw/siw/siw_mem.c
 create mode 100644 drivers/infiniband/sw/siw/siw_mem.h
 create mode 100644 drivers/infiniband/sw/siw/siw_qp.c
 create mode 100644 drivers/infiniband/sw/siw/siw_qp_rx.c
 create mode 100644 drivers/infiniband/sw/siw/siw_qp_tx.c
 create mode 100644 drivers/infiniband/sw/siw/siw_verbs.c
 create mode 100644 drivers/infiniband/sw/siw/siw_verbs.h
 create mode 100644 include/uapi/rdma/siw-abi.h

-- 
2.17.2

