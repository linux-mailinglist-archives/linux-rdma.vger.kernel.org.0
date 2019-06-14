Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D445FBE
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 16:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfFNN6F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 09:58:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728592AbfFNN6C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 09:58:02 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EDmuSv014265
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2019 09:58:01 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t4bv53dhw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jun 2019 09:57:59 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Fri, 14 Jun 2019 14:57:56 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 14:57:54 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5EDvrYG58327120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 13:57:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFAD842047;
        Fri, 14 Jun 2019 13:57:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC60242042;
        Fri, 14 Jun 2019 13:57:52 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jun 2019 13:57:52 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v2 00/11] SIW: Software iWarp RDMA (siw) driver
Date:   Fri, 14 Jun 2019 15:57:39 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19061413-0028-0000-0000-0000037A5223
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061413-0029-0000-0000-0000243A4F57
Message-Id: <20190614135750.15874-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=962 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140118
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set contributes the SoftiWarp driver rebased for
rdma for-next. SoftiWarp (siw) implements the iWarp RDMA
protocol over kernel TCP sockets. The driver integrates with
the linux-rdma framework.

Many thanks for reviewing and testing the driver, especially to Leon,
Jason, Steve, Doug, Olga, Dennis, Gal. You all helped to significantly
improve the driver over the last year.

Please find below a list of changes and comments, compared to older
versions of the siw driver.

Many thanks!
Bernard.


CHANGES:
========

v2 (this version)
-----------------

- Changed recieve path CRC calculation to compute CRC32c not
  on target buffer after placement, but on original skbuf.
  This change severely hurts performance, if CRC is switched
  on, since skb must now be walked twice. It is planned to
  work on an extension to skb_copy_bits() to fold in CRC
  computation.

- Moved debugging to using ibdev_dbg().

- Dropped detailed packet debug printing.

- Removed siw_debug.[ch] files.

- Removed resource tracking, code now relies on restrack of
  RDMA midlayer. Only object counting to enforce reported
  device limits is left in place.

- Removed all nested switch-case statements.

- Cleaned up header file #include's

- Moved CQ create/destroy to new semantics,
  where midlayer creates/destroys containing object.

- Set siw's ABI version to 1 (was 0 before)

- Removed all enum initialization where not needed.

- Fixed MAINTANERS entry for siw driver

- This version stays with the current siw specific
  management of user memory (siw_umem_get() vs.
  ib_umem_get(), etc.). This, since the current ib_umem
  implementation is less efficient for user page lookup
  on the fast path, where effciency is important for a
  SW RDMA driver. 
  It is planned to contribute enhancements to the ib_umem
  framework, wich makes it suitable for SW drivers as well.


v1 (first version after v9 of siw RFC)
--------------------------------------

- Rebased to 5.2-rc1

- All IDR code got removed.

- Both MR and QP deallocation verbs now synchronously
  free the resources referenced by the RDMA mid-layer.

- IPv6 support was added.

- For compatibility with Chelsio iWarp hardware, the RX
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

- The siw kernel abi file got renamed from siw_user.h to siw-abi.h.
Bernard Metzler (11):
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
  SIW addition to kernel build environment

 MAINTAINERS                              |    7 +
 drivers/infiniband/Kconfig               |    1 +
 drivers/infiniband/sw/Makefile           |    1 +
 drivers/infiniband/sw/siw/Kconfig        |   17 +
 drivers/infiniband/sw/siw/Makefile       |   11 +
 drivers/infiniband/sw/siw/iwarp.h        |  380 ++++
 drivers/infiniband/sw/siw/siw.h          |  745 ++++++++
 drivers/infiniband/sw/siw/siw_cm.c       | 2072 ++++++++++++++++++++++
 drivers/infiniband/sw/siw/siw_cm.h       |  133 ++
 drivers/infiniband/sw/siw/siw_cq.c       |  101 ++
 drivers/infiniband/sw/siw/siw_main.c     |  687 +++++++
 drivers/infiniband/sw/siw/siw_mem.c      |  460 +++++
 drivers/infiniband/sw/siw/siw_mem.h      |   74 +
 drivers/infiniband/sw/siw/siw_qp.c       | 1322 ++++++++++++++
 drivers/infiniband/sw/siw/siw_qp_rx.c    | 1455 +++++++++++++++
 drivers/infiniband/sw/siw/siw_qp_tx.c    | 1268 +++++++++++++
 drivers/infiniband/sw/siw/siw_verbs.c    | 1752 ++++++++++++++++++
 drivers/infiniband/sw/siw/siw_verbs.h    |   91 +
 include/uapi/rdma/rdma_user_ioctl_cmds.h |    1 +
 include/uapi/rdma/siw-abi.h              |  185 ++
 20 files changed, 10763 insertions(+)
 create mode 100644 drivers/infiniband/sw/siw/Kconfig
 create mode 100644 drivers/infiniband/sw/siw/Makefile
 create mode 100644 drivers/infiniband/sw/siw/iwarp.h
 create mode 100644 drivers/infiniband/sw/siw/siw.h
 create mode 100644 drivers/infiniband/sw/siw/siw_cm.c
 create mode 100644 drivers/infiniband/sw/siw/siw_cm.h
 create mode 100644 drivers/infiniband/sw/siw/siw_cq.c
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

