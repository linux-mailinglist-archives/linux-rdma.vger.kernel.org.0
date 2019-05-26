Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BD2AA8F
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2019 17:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfEZP5d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 26 May 2019 11:57:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726744AbfEZP5d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 May 2019 11:57:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4QFuZCL038609
        for <linux-rdma@vger.kernel.org>; Sun, 26 May 2019 11:57:32 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sqk4y74tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Sun, 26 May 2019 11:57:31 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Sun, 26 May 2019 15:57:31 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Sun, 26 May 2019 15:57:27 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2019052615572757-327308 ;
          Sun, 26 May 2019 15:57:27 +0000 
In-Reply-To: <a6373742-6d27-ad4b-ff6d-61f00db663d4@amazon.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Gal Pressman" <galpress@amazon.com>
Cc:     <linux-rdma@vger.kernel.org>
Date:   Sun, 26 May 2019 15:57:27 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <a6373742-6d27-ad4b-ff6d-61f00db663d4@amazon.com>,<20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-13-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-LLNOutbound: False
X-Disclaimed: 303
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19052615-9951-0000-0000-00000CA6361A
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.032659
X-IBM-SpamModules-Versions: BY=3.00011167; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01208918; UDB=6.00635017; IPR=6.00989921;
 BA=6.00006318; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027059; XFM=3.00000015;
 UTC=2019-05-26 15:57:29
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-26 12:56:54 - 6.00009971
x-cbparentid: 19052615-9952-0000-0000-00003CB23854
Message-Id: <OF76C58353.DE6402CC-ON00258406.0057A85B-00258406.0057A861@notes.na.collabserv.com>
Subject: Re:  Re: [PATCH for-next v1 12/12] SIW addition to kernel build environment
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-26_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Gal Pressman" <galpress@amazon.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>,
><linux-rdma@vger.kernel.org>
>From: "Gal Pressman" <galpress@amazon.com>
>Date: 05/26/2019 02:13PM
>Subject: [EXTERNAL] Re: [PATCH for-next v1 12/12] SIW addition to
>kernel build environment
>
>On 26/05/2019 14:41, Bernard Metzler wrote:
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  MAINTAINERS                        |  7 +++++++
>>  drivers/infiniband/Kconfig         |  1 +
>>  drivers/infiniband/sw/Makefile     |  1 +
>>  drivers/infiniband/sw/siw/Kconfig  | 17 +++++++++++++++++
>>  drivers/infiniband/sw/siw/Makefile | 12 ++++++++++++
>>  5 files changed, 38 insertions(+)
>>  create mode 100644 drivers/infiniband/sw/siw/Kconfig
>>  create mode 100644 drivers/infiniband/sw/siw/Makefile
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5cfbea4ce575..3b437abffc39 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14545,6 +14545,13 @@ M:	Chris Boot <bootc@bootc.net>
>>  S:	Maintained
>>  F:	drivers/leds/leds-net48xx.c
>>  
>> +SOFT-RDMA DRIVER (siw)
>
>SOFT-RDMA or SOFT-IWARP RDMA?

Yes, thanks, sure, it is SOFT-IWARP. 
>
>> +M:	Bernard Metzler (bmt@zurich,ibm.com)
>
>Should be a dot between zurich and ibm?
>
Of course....

Thanks a lot!
Bernard


>> +L:	linux-rdma@vger.kernel.org
>> +S:	Supported
>> +F:	drivers/infiniband/sw/rxe/
>> +F:	include/uapi/rdma/siw-abi.h
>> +
>>  SOFT-ROCE DRIVER (rxe)
>>  M:	Moni Shoua <monis@mellanox.com>
>>  L:	linux-rdma@vger.kernel.org
>> diff --git a/drivers/infiniband/Kconfig
>b/drivers/infiniband/Kconfig
>> index cbfbea49f126..2013ef848fd1 100644
>> --- a/drivers/infiniband/Kconfig
>> +++ b/drivers/infiniband/Kconfig
>> @@ -107,6 +107,7 @@ source "drivers/infiniband/hw/hfi1/Kconfig"
>>  source "drivers/infiniband/hw/qedr/Kconfig"
>>  source "drivers/infiniband/sw/rdmavt/Kconfig"
>>  source "drivers/infiniband/sw/rxe/Kconfig"
>> +source "drivers/infiniband/sw/siw/Kconfig"
>>  endif
>>  
>>  source "drivers/infiniband/ulp/ipoib/Kconfig"
>> diff --git a/drivers/infiniband/sw/Makefile
>b/drivers/infiniband/sw/Makefile
>> index 8b095b27db87..d37610fcbbc7 100644
>> --- a/drivers/infiniband/sw/Makefile
>> +++ b/drivers/infiniband/sw/Makefile
>> @@ -1,2 +1,3 @@
>>  obj-$(CONFIG_INFINIBAND_RDMAVT)		+= rdmavt/
>>  obj-$(CONFIG_RDMA_RXE)			+= rxe/
>> +obj-$(CONFIG_RDMA_SIW)			+= siw/
>> diff --git a/drivers/infiniband/sw/siw/Kconfig
>b/drivers/infiniband/sw/siw/Kconfig
>> new file mode 100644
>> index 000000000000..94f684174ce3
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/siw/Kconfig
>> @@ -0,0 +1,17 @@
>> +config RDMA_SIW
>> +	tristate "Software RDMA over TCP/IP (iWARP) driver"
>> +	depends on INET && INFINIBAND && CRYPTO_CRC32
>> +	help
>> +	This driver implements the iWARP RDMA transport over
>> +	the Linux TCP/IP network stack. It enables a system with a
>> +	standard Ethernet adapter to interoperate with a iWARP
>> +	adapter or with another system running the SIW driver.
>> +	(See also RXE which is a similar software driver for RoCE.)
>> +
>> +	The driver interfaces with the Linux RDMA stack and
>> +	implements both a kernel and user space RDMA verbs API.
>> +	The user space verbs API requires a support
>> +	library named libsiw which is loaded by the generic user
>> +	space verbs API, libibverbs. To implement RDMA over
>> +	TCP/IP, the driver further interfaces with the Linux
>> +	in-kernel TCP socket layer.
>> diff --git a/drivers/infiniband/sw/siw/Makefile
>b/drivers/infiniband/sw/siw/Makefile
>> new file mode 100644
>> index 000000000000..ff190cb0d254
>> --- /dev/null
>> +++ b/drivers/infiniband/sw/siw/Makefile
>> @@ -0,0 +1,12 @@
>> +obj-$(CONFIG_RDMA_SIW) += siw.o
>> +
>> +siw-y := \
>> +	siw_cm.o \
>> +	siw_cq.o \
>> +	siw_debug.o \
>> +	siw_main.o \
>> +	siw_mem.o \
>> +	siw_qp.o \
>> +	siw_qp_tx.o \
>> +	siw_qp_rx.o \
>> +	siw_verbs.o
>> 
>
>

