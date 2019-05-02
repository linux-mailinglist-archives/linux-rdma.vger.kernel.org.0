Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F297111BC2
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 16:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEBOtv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 2 May 2019 10:49:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbfEBOtv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 May 2019 10:49:51 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42EnmRw047147
        for <linux-rdma@vger.kernel.org>; Thu, 2 May 2019 10:49:50 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s81df40er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 02 May 2019 10:49:49 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 2 May 2019 14:48:40 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.158) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 2 May 2019 14:48:31 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019050214482889-601129 ;
          Thu, 2 May 2019 14:48:28 +0000 
In-Reply-To: <20190426210718.GB6705@mtr-leonro.mtl.com>
Subject: Re: [PATCH v8 00/12] SIW: Request for Comments
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 2 May 2019 14:48:27 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190426210718.GB6705@mtr-leonro.mtl.com>,<20190426131852.30142-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-LLNOutbound: False
X-Disclaimed: 37743
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19050214-6059-0000-0000-00000E71E86F
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.388783; ST=0; TS=0; UL=0; ISC=; MB=0.001729
X-IBM-SpamModules-Versions: BY=3.00011035; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197540; UDB=6.00628112; IPR=6.00978396;
 BA=6.00006295; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026696; XFM=3.00000015;
 UTC=2019-05-02 14:48:39
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-02 08:27:48 - 6.00009875
x-cbparentid: 19050214-6060-0000-0000-00007A52FFD3
Message-Id: <OF26004ADE.E173C131-ON002583EE.00515728-002583EE.0051572F@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 04/26/2019 11:07PM
>Cc: linux-rdma@vger.kernel.org
>Subject: Re: [PATCH v8 00/12] SIW: Request for Comments
>
>On Fri, Apr 26, 2019 at 03:18:40PM +0200, Bernard Metzler wrote:
>> This patch set contributes version 8 of the SoftiWarp
>> driver, as originally introduced to the list Oct 6th, 2017.
>> SoftiWarp (siw) implements the iWarp RDMA protocol over
>> kernel TCP sockets. The driver integrates with the
>> linux-rdma framework.
>>
>> The only purpose of this patch set is to rebase the driver
>> to the current code base of the 'rdma/for-next' branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
>>
>> There are no functional changes wrt. version 7, except one
>> bug fix in the fast MR registration path, where an application
>> provided, changed IO address was not taken into account.
>>
>> As said, the current patch set is based on rdma/for-next.
>> For convenience, it is also maintained at
>>
>https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_zrlio
>_softiwarp-2Dfor-2Dlinux-2Drdma.git&d=DwIBAg&c=jf_iaSHvJObTbx-siA1ZOg
>&r=2TaYXQ0T-r8ZO1PP1alNwU_QJcRRLfmYTAgd3QCvqSc&m=s8kBzxPaiWgkYRMQ4GYI
>r7PWqYcD_iXi93ILDWO7c7E&s=XVI0RTnHzvzg_hoLQv66acO8xfIn3HchSRrxZ0Z4ySE
>&e=
>> within branch 'siw-for-rdma-next-v8'.
>>
>> Thanks very much for your time and help!
>>
>> Bernard.
>>
>> Bernard Metzler (12):
>>   iWarp wire packet format
>>   SIW main include file
>>   SIW network and RDMA core interface
>>   SIW connection management
>>   SIW application interface
>>   SIW application buffer management
>>   SIW queue pair methods
>>   SIW transmit path
>>   SIW receive path
>>   SIW completion queue methods
>>   SIW debugging
>>   SIW addition to kernel build environment
>>
>>  MAINTAINERS                              |    7 +
>>  drivers/infiniband/Kconfig               |    1 +
>>  drivers/infiniband/sw/Makefile           |    1 +
>>  drivers/infiniband/sw/siw/Kconfig        |   17 +
>>  drivers/infiniband/sw/siw/Makefile       |   12 +
>>  drivers/infiniband/sw/siw/iwarp.h        |  379 ++++
>>  drivers/infiniband/sw/siw/siw.h          |  733 ++++++++
>>  drivers/infiniband/sw/siw/siw_cm.c       | 2107
>++++++++++++++++++++++
>>  drivers/infiniband/sw/siw/siw_cm.h       |  121 ++
>>  drivers/infiniband/sw/siw/siw_cq.c       |  109 ++
>>  drivers/infiniband/sw/siw/siw_debug.c    |   91 +
>>  drivers/infiniband/sw/siw/siw_debug.h    |   40 +
>>  drivers/infiniband/sw/siw/siw_main.c     |  712 ++++++++
>>  drivers/infiniband/sw/siw/siw_mem.c      |  464 +++++
>>  drivers/infiniband/sw/siw/siw_mem.h      |   53 +
>>  drivers/infiniband/sw/siw/siw_qp.c       | 1354 ++++++++++++++
>>  drivers/infiniband/sw/siw/siw_qp_rx.c    | 1520 ++++++++++++++++
>>  drivers/infiniband/sw/siw/siw_qp_tx.c    | 1291 +++++++++++++
>>  drivers/infiniband/sw/siw/siw_verbs.c    | 1826
>+++++++++++++++++++
>>  drivers/infiniband/sw/siw/siw_verbs.h    |   83 +
>>  include/uapi/rdma/rdma_user_ioctl_cmds.h |    1 +
>>  include/uapi/rdma/siw_user.h             |  186 ++
>
>To make our life easier, that file should be named like all
>other files: siw-abi.h.
>
>Thanks

Hi Leon,

I just saw your several responses to my last RFC for
siw (version 8). Thank you very much for your help.
Sorry for not acting on it earlier. Since Friday
night last week I am on a vacation trip with very
limited time to work on it. I will be back next week
and reply asap.

Again, many thanks!

Bernard.
>
>>  22 files changed, 11108 insertions(+)
>>  create mode 100644 drivers/infiniband/sw/siw/Kconfig
>>  create mode 100644 drivers/infiniband/sw/siw/Makefile
>>  create mode 100644 drivers/infiniband/sw/siw/iwarp.h
>>  create mode 100644 drivers/infiniband/sw/siw/siw.h
>>  create mode 100644 drivers/infiniband/sw/siw/siw_cm.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_cm.h
>>  create mode 100644 drivers/infiniband/sw/siw/siw_cq.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_debug.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_debug.h
>>  create mode 100644 drivers/infiniband/sw/siw/siw_main.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_mem.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_mem.h
>>  create mode 100644 drivers/infiniband/sw/siw/siw_qp.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_qp_rx.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_qp_tx.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_verbs.c
>>  create mode 100644 drivers/infiniband/sw/siw/siw_verbs.h
>>  create mode 100644 include/uapi/rdma/siw_user.h
>>
>> --
>> 2.17.2
>>
>
>

