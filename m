Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3A352FC93
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfE3NoG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 30 May 2019 09:44:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbfE3NoG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 09:44:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UDgWrI087178
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 09:44:05 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.75])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2stfsasugu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 09:44:05 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 30 May 2019 13:44:04 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.123) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 30 May 2019 13:43:59 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2019053013435935-618425 ;
          Thu, 30 May 2019 13:43:59 +0000 
In-Reply-To: <20190530130316.GF6251@mtr-leonro.mtl.com>
Subject: Re: [PATCH for-next v1 00/12] SIW: Software iWarp RDMA (siw) driver
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Steve Wise" <larrystevenwise@gmail.com>
Date:   Thu, 30 May 2019 13:43:59 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190530130316.GF6251@mtr-leonro.mtl.com>,<20190526114156.6827-1-bmt@zurich.ibm.com>
 <OF83D2F2C7.9DE43FAF-ON00258409.0055DE83-00258409.00579C96@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP53 May 15, 2019 at 09:15
X-LLNOutbound: False
X-Disclaimed: 64575
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19053013-3815-0000-0000-00000B935DD9
X-IBM-SpamModules-Scores: BY=0.074236; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.359140
X-IBM-SpamModules-Versions: BY=3.00011184; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210760; UDB=6.00636143; IPR=6.00991794;
 BA=6.00006323; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027119; XFM=3.00000015;
 UTC=2019-05-30 13:44:03
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-30 10:59:08 - 6.00009987
x-cbparentid: 19053013-3816-0000-0000-0000100E7947
Message-Id: <OFD1365998.C6867D01-ON0025840A.004B704B-0025840A.004B7050@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 05/30/2019 03:03PM
>Cc: linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>,
>"Steve Wise" <larrystevenwise@gmail.com>
>Subject: [EXTERNAL] Re: [PATCH for-next v1 00/12] SIW: Software iWarp
>RDMA (siw) driver
>
>On Wed, May 29, 2019 at 03:56:57PM +0000, Bernard Metzler wrote:
>> -----linux-rdma-owner@vger.kernel.org wrote: -----
>>
>> >To: linux-rdma@vger.kernel.org
>> >From: "Bernard Metzler"
>> >Sent by: linux-rdma-owner@vger.kernel.org
>> >Date: 05/26/2019 01:42PM
>> >Cc: "Bernard Metzler" <bmt@zurich.ibm.com>
>> >Subject: [EXTERNAL] [PATCH for-next v1 00/12] SIW: Software iWarp
>> >RDMA (siw) driver
>> >
>> >This patch set contributes the SoftiWarp driver rebased for
>> >Kernel 5.2-rc1. SoftiWarp (siw) implements the iWarp RDMA
>> >protocol over kernel TCP sockets. The driver integrates with
>> >the linux-rdma framework.
>> >
>> >With this new driver version, the following things where
>> >changed, compared to the v8 RFC of siw:
>> >
>> >o Rebased to 5.2-rc1
>> >
>> >o All IDR code got removed.
>> >
>> >o Both MR and QP deallocation verbs now synchronously
>> >  free the resources referenced by the RDMA mid-layer.
>> >
>> >o IPv6 support was added.
>> >
>> >o For compatibility with Chelsio iWarp hardware, the RX
>> >  path was slightly reworked. It now allows packet intersection
>> >  between tagged and untagged RDMAP operations. While not
>> >  a defined behavior as of IETF RFC 5040/5041, some RDMA hardware
>> >  may intersect an ongoing outbound (large) tagged message, such
>> >  as an multisegment RDMA Read Response with sending an untagged
>> >  message, such as an RDMA Send frame. This behavior was only
>> >  detected in an NVMeF setup, where siw was used at target side,
>> >  and RDMA hardware at client side (during file write). siw now
>> >  implements two input paths for tagged and untagged messages
>each,
>> >  and allows the intersected placement of both messages.
>> >
>> >o The siw kernel abi file got renamed from siw_user.h to
>siw-abi.h.
>> >
>> >Many thanks for reviewing and testing the driver, especially to
>> >Steve, Leon, Jason, Doug, Olga, Dennis, Gal. You all helped to
>> >significantly improve the siw driver over the last year. It is
>> >very much appreciated.
>> >
>> >Many thanks!
>> >Bernard.
>> >
>> >Bernard Metzler (12):
>> >  iWarp wire packet format
>> >  SIW main include file
>> >  SIW network and RDMA core interface
>> >  SIW connection management
>> >  SIW application interface
>> >  SIW application buffer management
>> >  SIW queue pair methods
>> >  SIW transmit path
>> >  SIW receive path
>> >  SIW completion queue methods
>> >  SIW debugging
>> >  SIW addition to kernel build environment
>> >
>> > MAINTAINERS                              |    7 +
>> > drivers/infiniband/Kconfig               |    1 +
>> > drivers/infiniband/sw/Makefile           |    1 +
>> > drivers/infiniband/sw/siw/Kconfig        |   17 +
>> > drivers/infiniband/sw/siw/Makefile       |   12 +
>> > drivers/infiniband/sw/siw/iwarp.h        |  380 ++++
>> > drivers/infiniband/sw/siw/siw.h          |  720 ++++++++
>> > drivers/infiniband/sw/siw/siw_cm.c       | 2109
>> >++++++++++++++++++++++
>> > drivers/infiniband/sw/siw/siw_cm.h       |  133 ++
>> > drivers/infiniband/sw/siw/siw_cq.c       |  109 ++
>> > drivers/infiniband/sw/siw/siw_debug.c    |  102 ++
>> > drivers/infiniband/sw/siw/siw_debug.h    |   35 +
>> > drivers/infiniband/sw/siw/siw_main.c     |  701 +++++++
>> > drivers/infiniband/sw/siw/siw_mem.c      |  462 +++++
>> > drivers/infiniband/sw/siw/siw_mem.h      |   74 +
>> > drivers/infiniband/sw/siw/siw_qp.c       | 1345 ++++++++++++++
>> > drivers/infiniband/sw/siw/siw_qp_rx.c    | 1537 ++++++++++++++++
>> > drivers/infiniband/sw/siw/siw_qp_tx.c    | 1276 +++++++++++++
>> > drivers/infiniband/sw/siw/siw_verbs.c    | 1778
>++++++++++++++++++
>> > drivers/infiniband/sw/siw/siw_verbs.h    |  102 ++
>> > include/uapi/rdma/rdma_user_ioctl_cmds.h |    1 +
>> > include/uapi/rdma/siw-abi.h              |  186 ++
>> > 22 files changed, 11088 insertions(+)
>> > create mode 100644 drivers/infiniband/sw/siw/Kconfig
>> > create mode 100644 drivers/infiniband/sw/siw/Makefile
>> > create mode 100644 drivers/infiniband/sw/siw/iwarp.h
>> > create mode 100644 drivers/infiniband/sw/siw/siw.h
>> > create mode 100644 drivers/infiniband/sw/siw/siw_cm.c
>> > create mode 100644 drivers/infiniband/sw/siw/siw_cm.h
>> > create mode 100644 drivers/infiniband/sw/siw/siw_cq.c
>> > create mode 100644 drivers/infiniband/sw/siw/siw_debug.c
>> > create mode 100644 drivers/infiniband/sw/siw/siw_debug.h
>> > create mode 100644 drivers/infiniband/sw/siw/siw_main.c
>> > create mode 100644 drivers/infiniband/sw/siw/siw_mem.c
>> > create mode 100644 drivers/infiniband/sw/siw/siw_mem.h
>> > create mode 100644 drivers/infiniband/sw/siw/siw_qp.c
>> > create mode 100644 drivers/infiniband/sw/siw/siw_qp_rx.c
>> > create mode 100644 drivers/infiniband/sw/siw/siw_qp_tx.c
>> > create mode 100644 drivers/infiniband/sw/siw/siw_verbs.c
>> > create mode 100644 drivers/infiniband/sw/siw/siw_verbs.h
>> > create mode 100644 include/uapi/rdma/siw-abi.h
>> >
>> >--
>> >2.17.2
>> >
>> >
>>
>> Hi Jason, Leon, Steve, @all,
>>
>> What's next for getting siw merged? Please help me to
>> keep the ball rolling. I am currently running out of
>> issues I shall fix (which is not a bad feeling though ;)).
>> I see lots of other demanding stuff is going on
>> these days...
>
>Generally speaking, I think that it is ready to be merged.
>
>If Jason/Doug doesn't merge this merge before next week,
>I'll take an extra look and add my ROBs next week, but it is
>definitely not a blocker for acceptance.
>
>

Leon,

Many thanks for the heads-up!

Bernard. 

