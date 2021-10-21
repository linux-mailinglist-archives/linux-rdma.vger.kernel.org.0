Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38F2436388
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhJUN5N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 09:57:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230361AbhJUN5M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 09:57:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LDk4hc000349;
        Thu, 21 Oct 2021 09:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : content-transfer-encoding :
 content-type : mime-version : references; s=pp1;
 bh=b0GDfLCSxaRLA8++FGanCP6cC2uM4sy/dCjpZsm7Uk0=;
 b=C1+XgBnE25Jbg7nn9IlJdbYS3R6Tu3SDYWMfn8y4hSZPnnQGtY9p6DMdzci0Hszh16PE
 MmAfS3aa/ckGAl2vKkb8tpJ+ryiHRJQKPZ0L1A9YNNpLhmrMeF7fBg7op+TWKB54s7j8
 R8lJ+S7Y9v6MsJwo/rLnX5PkMtTFgZOOITJpWwOj9sPTqswWBBPXMUfizqwOYR+dy8bk
 VBjY7QZx4lzNlNeDnCJ460c99YOJfPY9QgQZrNKQLBPS5NJceraakLJMJlhYoLTb844h
 oBZ9YZ4MtF5+6mb9DAeQTOkPTmC/YEq5i/Cbai91DL0Pvh0K370Mo3uGzG0nPma6lsHg Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu7neb0hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 09:54:33 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LClLEO007740;
        Thu, 21 Oct 2021 09:54:32 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu7neb0hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 09:54:32 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LDrfgx003567;
        Thu, 21 Oct 2021 13:54:31 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3bqpcdny7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 13:54:31 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LDsVMr17039752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 13:54:31 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04C9228059;
        Thu, 21 Oct 2021 13:54:31 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9AA72805C;
        Thu, 21 Oct 2021 13:54:30 +0000 (GMT)
Received: from mww0301.wdc07m.mail.ibm.com (unknown [9.208.64.45])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Oct 2021 13:54:30 +0000 (GMT)
In-Reply-To: <20211021120135.3003-1-caihuoqing@baidu.com>
Subject: Re: [PATCH 0/6] kthread: Add the helper macro kthread_run_on_cpu()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Cai Huoqing" <caihuoqing@baidu.com>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Josh Triplett" <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "Lai Jiangshan" <jiangshanlai@gmail.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Daniel Bristot de Oliveira" <bristot@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rcu@vger.kernel.org>
Date:   Thu, 21 Oct 2021 13:48:15 +0000
Message-ID: <OFACD03FD5.99AACE16-ON00258775.004BD474-00258775.004BD47C@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20211021120135.3003-1-caihuoqing@baidu.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF117   October 6, 2021
X-MIMETrack: Serialize by http on MWW0301/01/M/IBM at 10/21/2021 13:48:16,Serialize
 complete at 10/21/2021 13:48:16
X-Disclaimed: 62867
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uXTDd9u8R3DaG1IPx2wa5gq0UTbf0HJt
X-Proofpoint-GUID: mPWH0683gmvegmcFOIctDtY8ugTXegVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_04,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210072
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Cai Huoqing" <caihuoqing@baidu.com> wrote: -----

>To: <caihuoqing@baidu.com>
>From: "Cai Huoqing" <caihuoqing@baidu.com>
>Date: 10/21/2021 02:02PM
>Cc: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Davidlohr
>Bueso" <dave@stgolabs.net>, "Paul E. McKenney" <paulmck@kernel.org>,
>"Josh Triplett" <josh@joshtriplett.org>, "Steven Rostedt"
><rostedt@goodmis.org>, "Mathieu Desnoyers"
><mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
><jiangshanlai@gmail.com>, "Joel Fernandes" <joel@joelfernandes.org>,
>"Ingo Molnar" <mingo@redhat.com>, "Daniel Bristot de Oliveira"
><bristot@kernel.org>, <linux-rdma@vger.kernel.org>,
><linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
>Subject: [EXTERNAL] [PATCH 0/6] kthread: Add the helper macro
>kthread=5Frun=5Fon=5Fcpu()
>
>the helper macro kthread=5Frun=5Fon=5Fcpu() inculdes
>kthread=5Fcreate=5Fon=5Fcpu/wake=5Fup=5Fprocess().
>In some cases, use kthread=5Frun=5Fon=5Fcpu() directly instead of
>kthread=5Fcreate=5Fon=5Fnode/kthread=5Fbind/wake=5Fup=5Fprocess() or
>kthread=5Fcreate=5Fon=5Fcpu/wake=5Fup=5Fprocess() or
>kthreadd=5Fcreate/kthread=5Fbind/wake=5Fup=5Fprocess() to simplify the cod=
e.

I do not see kthread=5Fbind() being covered by the helper,
as claimed? rcutorture, ring-buffer, siw are using it in
the code potentially being replaced by the helper.
kthread=5Fbind() is best to be called before thread starts
running, so should be part of it.

Thanks,
Bernard.
>
>Cai Huoqing (6):
>  kthread: Add the helper macro kthread=5Frun=5Fon=5Fcpu()
>  RDMA/siw: Make use of the helper macro kthread=5Frun=5Fon=5Fcpu()
>  ring-buffer: Make use of the helper macro kthread=5Frun=5Fon=5Fcpu()
>  rcutorture: Make use of the helper macro kthread=5Frun=5Fon=5Fcpu()
>  trace/osnoise: Make use of the helper macro kthread=5Frun=5Fon=5Fcpu()
>  trace/hwlat: Make use of the helper macro kthread=5Frun=5Fon=5Fcpu()
>
> drivers/infiniband/sw/siw/siw=5Fmain.c |  7 +++----
> include/linux/kthread.h              | 22 ++++++++++++++++++++++
> kernel/rcu/rcutorture.c              |  7 ++-----
> kernel/trace/ring=5Fbuffer.c           |  7 ++-----
> kernel/trace/trace=5Fhwlat.c           |  6 +-----
> kernel/trace/trace=5Fosnoise.c         |  3 +--
> 6 files changed, 31 insertions(+), 21 deletions(-)
>
>--=20
>2.25.1
>
>
