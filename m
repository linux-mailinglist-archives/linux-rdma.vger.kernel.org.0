Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C78C3D0B8
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404885AbfFKPZf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 11 Jun 2019 11:25:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404781AbfFKPZf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 11:25:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BFPU6k071073
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 11:25:34 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2dxmup08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 11:25:32 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 Jun 2019 15:24:50 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.158) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 Jun 2019 15:24:47 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019061115244711-766156 ;
          Tue, 11 Jun 2019 15:24:47 +0000 
In-Reply-To: <20190610073647.GK6369@mtr-leonro.mtl.com>
Subject: Re: [PATCH for-next v1 12/12] SIW addition to kernel build environment
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 11 Jun 2019 15:24:46 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190610073647.GK6369@mtr-leonro.mtl.com>,<20190526114156.6827-1-bmt@zurich.ibm.com>
 <20190526114156.6827-13-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 30575
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19061115-1335-0000-0000-000000313576
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.421684; ST=0; TS=0; UL=0; ISC=; MB=0.036826
X-IBM-SpamModules-Versions: BY=3.00011247; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216481; UDB=6.00639616; IPR=6.00997580;
 MB=3.00027264; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 15:24:49
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-11 11:19:12 - 6.00010036
x-cbparentid: 19061115-1336-0000-0000-000000BF574F
Message-Id: <OF3442D549.6E2B5272-ON00258416.0054AA82-00258416.0054AA88@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



---
Bernard Metzler, PhD
Tech. Leader High Performance I/O, Principal Research Staff
IBM Zurich Research Laboratory
Saeumerstrasse 4
CH-8803 Rueschlikon, Switzerland
+41 44 724 8605

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 06/10/2019 09:37AM
>Cc: linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH for-next v1 12/12] SIW addition to
>kernel build environment
>
>On Sun, May 26, 2019 at 01:41:56PM +0200, Bernard Metzler wrote:
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
>> +M:	Bernard Metzler (bmt@zurich,ibm.com)
>
>As Gal said "." in email and it should be <bmt@zurich.ibm.com>
>and not (bmt@zurich,ibm.com)
>
right.

>> +L:	linux-rdma@vger.kernel.org
>> +S:	Supported
>> +F:	drivers/infiniband/sw/rxe/

ummh, and this shall be sw/siw ;)

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
>> --
>> 2.17.2
>>
>
>

