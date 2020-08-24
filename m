Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7135F250BAE
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 00:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHXWaP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 18:30:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42898 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXWaP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 18:30:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OMPNks126034;
        Mon, 24 Aug 2020 22:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Zt9yvl0vvvZR2oW6M/gJOz2CZMoJuB1GqweqMPWR6nc=;
 b=dNGJhwTEZyIbgFQNOkHBT+zTSHM+onA7NfawTCpayOGGl/hLscf6pEtZyVrkI4gaFODF
 Y9r26u07iXFQeUAaNU19zClzV9PxHLlH6fTfAOZvwzWW19ZV+soQ+CJo9aiRwf4j3w/N
 JOd8Qi27YnElwezb0dCCp5x5vmL4YDIPhIcQbw9zo+h6lEPCpe/VfXxVnScJp3teD/LS
 VpUxj8ff90q2R70auE6w87eZY5abu9V3ZA3Jdxh6pftHG2CzHwKs682ls7StB29HRg/P
 S+DaMH7ETDIv1324OL9EOM/crJX4I9o2RIPsvtQxBYW0rkwan6xfbtB0OEIdOYKRT1Ip qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 333w6tns4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 22:30:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OMLGTC076446;
        Mon, 24 Aug 2020 22:30:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 333r9hu0w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 22:30:12 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07OMUBbI022368;
        Mon, 24 Aug 2020 22:30:12 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 15:30:11 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v3 0/3] IB CM tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200824215611.GM1152540@nvidia.com>
Date:   Mon, 24 Aug 2020 18:30:11 -0400
Cc:     linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <18BBE137-A534-493A-827F-7E30736793C6@oracle.com>
References: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
 <20200824174213.GA3256703@nvidia.com>
 <5C1EC1AC-8385-4E08-9C4A-97B04AF3763B@oracle.com>
 <20200824215611.GM1152540@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008240177
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Aug 24, 2020, at 5:56 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>=20
> On Mon, Aug 24, 2020 at 02:24:40PM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Aug 24, 2020, at 1:42 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>=20
>>> On Mon, Aug 17, 2020 at 09:53:05AM -0400, Chuck Lever wrote:
>>>> Oracle has an interest in a common observability infrastructure in
>>>> the RDMA core and ULPs. Introduce static tracepoints that can also
>>>> be used as hooks for eBPF scripts, replacing infrastructure that
>>>> is based on printk. This takes the same approach as tracepoints
>>>> added recently in the RDMA CM.
>>>>=20
>>>> Change since v2:
>>>> * Rebase on v5.9-rc1
>>>>=20
>>>> Changes since RFC:
>>>> * Correct spelling of example tracepoint in patch description
>>>> * Newer tool chains don't care for tracepoints with the same name
>>>> in different subsystems
>>>> * Display ib_cm_events, not ib_events
>>>=20
>>> Doesn't compile:
>>>=20
>>> In file included from drivers/infiniband/core/cm_trace.h:414,
>>>                from drivers/infiniband/core/cm_trace.c:15:
>>> ./include/trace/define_trace.h:95:42: fatal error: ./cm_trace.h: No =
such file or directory
>>>  95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>>>     |                                          ^
>>> compilation terminated.
>>=20
>> I am not able to reproduce this failure.
>>=20
>> gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)
>=20
> Yep, using gcc 10 too
>=20
> Start from a clean tree?

Always.


>> What if you edit drivers/infiniband/core/cm_trace.h and
>> change the definition of TRACE_INCLUDE_PATH from "." to
>> "../../drivers/infiniband/core" ?
>=20
> It works
>=20
> It is because ./ is relative to include/trace/define_trace.h ?

Yes.

It appears that the many instances of "#define TRACE_INCLUDE_PATH ."
already in the kernel are each accompanied by Makefile magic to make
that work correctly. I neglected (again) to add that.

But now that I've read the instructions in include/trace/define_trace.h,
I prefer using a full relative path instead of "."-with-Makefile.

Do I need to send a v4?

--
Chuck Lever



