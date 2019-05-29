Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495442E1C1
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfE2P5I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 29 May 2019 11:57:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726240AbfE2P5I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 May 2019 11:57:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TFtRKs105492
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2019 11:57:06 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.81])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ssvmxsd56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2019 11:57:06 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 29 May 2019 15:57:04 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.88) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 29 May 2019 15:56:57 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2019052915565655-804091 ;
          Wed, 29 May 2019 15:56:56 +0000 
In-Reply-To: <20190526114156.6827-1-bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next v1 00/12] SIW: Software iWarp RDMA (siw) driver
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Steve Wise" <larrystevenwise@gmail.com>,
        "Leon Romanovsky" <leon@kernel.org>
Cc:     "Bernard Metzler" <BMT@zurich.ibm.com>
Date:   Wed, 29 May 2019 15:56:57 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-LLNOutbound: False
X-Disclaimed: 27879
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19052915-7093-0000-0000-00000B82EAF0
X-IBM-SpamModules-Scores: BY=0.075217; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.333408
X-IBM-SpamModules-Versions: BY=3.00011180; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210329; UDB=6.00635881; IPR=6.00991360;
 BA=6.00006323; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027104; XFM=3.00000015;
 UTC=2019-05-29 15:57:03
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-29 10:41:21 - 6.00009983
x-cbparentid: 19052915-7094-0000-0000-000072950872
Message-Id: <OF83D2F2C7.9DE43FAF-ON00258409.0055DE83-00258409.00579C96@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----linux-rdma-owner@vger.kernel.org wrote: -----

>To: linux-rdma@vger.kernel.org
>From: "Bernard Metzler" 
>Sent by: linux-rdma-owner@vger.kernel.org
>Date: 05/26/2019 01:42PM
>Cc: "Bernard Metzler" <bmt@zurich.ibm.com>
>Subject: [EXTERNAL] [PATCH for-next v1 00/12] SIW: Software iWarp
>RDMA (siw) driver
>
>This patch set contributes the SoftiWarp driver rebased for
>Kernel 5.2-rc1. SoftiWarp (siw) implements the iWarp RDMA
>protocol over kernel TCP sockets. The driver integrates with
>the linux-rdma framework.
>
>With this new driver version, the following things where
>changed, compared to the v8 RFC of siw:
>
>o Rebased to 5.2-rc1
>
>o All IDR code got removed.
>
>o Both MR and QP deallocation verbs now synchronously
>  free the resources referenced by the RDMA mid-layer.
>
>o IPv6 support was added.
>
>o For compatibility with Chelsio iWarp hardware, the RX
>  path was slightly reworked. It now allows packet intersection
>  between tagged and untagged RDMAP operations. While not
>  a defined behavior as of IETF RFC 5040/5041, some RDMA hardware
>  may intersect an ongoing outbound (large) tagged message, such
>  as an multisegment RDMA Read Response with sending an untagged
>  message, such as an RDMA Send frame. This behavior was only
>  detected in an NVMeF setup, where siw was used at target side,
>  and RDMA hardware at client side (during file write). siw now
>  implements two input paths for tagged and untagged messages each,
>  and allows the intersected placement of both messages.
>
>o The siw kernel abi file got renamed from siw_user.h to siw-abi.h.
>
>Many thanks for reviewing and testing the driver, especially to
>Steve, Leon, Jason, Doug, Olga, Dennis, Gal. You all helped to
>significantly improve the siw driver over the last year. It is
>very much appreciated.
>
>Many thanks!
>Bernard.
>
>Bernard Metzler (12):
>  iWarp wire packet format
>  SIW main include file
>  SIW network and RDMA core interface
>  SIW connection management
>  SIW application interface
>  SIW application buffer management
>  SIW queue pair methods
>  SIW transmit path
>  SIW receive path
>  SIW completion queue methods
>  SIW debugging
>  SIW addition to kernel build environment
>
> MAINTAINERS                              |    7 +
> drivers/infiniband/Kconfig               |    1 +
> drivers/infiniband/sw/Makefile           |    1 +
> drivers/infiniband/sw/siw/Kconfig        |   17 +
> drivers/infiniband/sw/siw/Makefile       |   12 +
> drivers/infiniband/sw/siw/iwarp.h        |  380 ++++
> drivers/infiniband/sw/siw/siw.h          |  720 ++++++++
> drivers/infiniband/sw/siw/siw_cm.c       | 2109
>++++++++++++++++++++++
> drivers/infiniband/sw/siw/siw_cm.h       |  133 ++
> drivers/infiniband/sw/siw/siw_cq.c       |  109 ++
> drivers/infiniband/sw/siw/siw_debug.c    |  102 ++
> drivers/infiniband/sw/siw/siw_debug.h    |   35 +
> drivers/infiniband/sw/siw/siw_main.c     |  701 +++++++
> drivers/infiniband/sw/siw/siw_mem.c      |  462 +++++
> drivers/infiniband/sw/siw/siw_mem.h      |   74 +
> drivers/infiniband/sw/siw/siw_qp.c       | 1345 ++++++++++++++
> drivers/infiniband/sw/siw/siw_qp_rx.c    | 1537 ++++++++++++++++
> drivers/infiniband/sw/siw/siw_qp_tx.c    | 1276 +++++++++++++
> drivers/infiniband/sw/siw/siw_verbs.c    | 1778 ++++++++++++++++++
> drivers/infiniband/sw/siw/siw_verbs.h    |  102 ++
> include/uapi/rdma/rdma_user_ioctl_cmds.h |    1 +
> include/uapi/rdma/siw-abi.h              |  186 ++
> 22 files changed, 11088 insertions(+)
> create mode 100644 drivers/infiniband/sw/siw/Kconfig
> create mode 100644 drivers/infiniband/sw/siw/Makefile
> create mode 100644 drivers/infiniband/sw/siw/iwarp.h
> create mode 100644 drivers/infiniband/sw/siw/siw.h
> create mode 100644 drivers/infiniband/sw/siw/siw_cm.c
> create mode 100644 drivers/infiniband/sw/siw/siw_cm.h
> create mode 100644 drivers/infiniband/sw/siw/siw_cq.c
> create mode 100644 drivers/infiniband/sw/siw/siw_debug.c
> create mode 100644 drivers/infiniband/sw/siw/siw_debug.h
> create mode 100644 drivers/infiniband/sw/siw/siw_main.c
> create mode 100644 drivers/infiniband/sw/siw/siw_mem.c
> create mode 100644 drivers/infiniband/sw/siw/siw_mem.h
> create mode 100644 drivers/infiniband/sw/siw/siw_qp.c
> create mode 100644 drivers/infiniband/sw/siw/siw_qp_rx.c
> create mode 100644 drivers/infiniband/sw/siw/siw_qp_tx.c
> create mode 100644 drivers/infiniband/sw/siw/siw_verbs.c
> create mode 100644 drivers/infiniband/sw/siw/siw_verbs.h
> create mode 100644 include/uapi/rdma/siw-abi.h
>
>-- 
>2.17.2
>
>

Hi Jason, Leon, Steve, @all, 

What's next for getting siw merged? Please help me to
keep the ball rolling. I am currently running out of
issues I shall fix (which is not a bad feeling though ;)).
I see lots of other demanding stuff is going on
these days...

Thanks very much!
Bernard

