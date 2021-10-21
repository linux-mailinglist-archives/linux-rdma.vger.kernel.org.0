Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3F44363DE
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhJUOR0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 10:17:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231206AbhJUORZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 10:17:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LEC0EL009673;
        Thu, 21 Oct 2021 10:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : content-transfer-encoding :
 content-type : mime-version : references; s=pp1;
 bh=PBUpBgQG1ihopG41zAX4JDk/NFFh4GdrZaKJzCGzAuY=;
 b=ohxF8dKOIJs5CWEfprq7xvs/t0SqufXxQdDetKYPCJGO/+uS/WGyw+RV3WqF9CMdbY+x
 Hj7lYLeTeO+0Pkn2lO1Zx35gVs+Gf3AoZ6timPBOWGfKvPD8f+JSFCEFwi5TcHv6Zj2Z
 ySykdjxcAO7nxDK98SffUcLtAse6GDFJLOMZYxhvIsmg+unBpsvGuA+Vm66a0B6xpEJA
 9Aa20mQlbEj0b+jSoWhvRQp4eGNNS6HQPH1YOkUKATQ2hLm71vuFy/4LINYMZURgF4Fe
 WqW5vi0IQNZNo/OSPkzv8i4EGBavS74HsrxNyCzZxhEBMMMczEBrFkOexj0cKiaE/sC8 Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu8h8a67v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 10:14:44 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LECf4f013699;
        Thu, 21 Oct 2021 10:14:43 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu8h8a679-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 10:14:43 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LE88qF020843;
        Thu, 21 Oct 2021 14:14:41 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 3bqpccx3k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 14:14:41 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LEEfHa37355946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 14:14:41 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51552112062;
        Thu, 21 Oct 2021 14:14:41 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AD0B112066;
        Thu, 21 Oct 2021 14:14:41 +0000 (GMT)
Received: from mww0301.wdc07m.mail.ibm.com (unknown [9.208.64.45])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Oct 2021 14:14:41 +0000 (GMT)
In-Reply-To: <20211021140755.GA3448@LAPTOP-UKSR4ENP.internal.baidu.com>
Subject: Re: Re: [PATCH 0/6] kthread: Add the helper macro kthread_run_on_cpu()
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
Date:   Thu, 21 Oct 2021 14:14:39 +0000
Message-ID: <OFA768FC6A.4B984E4E-ON00258775.004E3F00-00258775.004E3F06@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20211021140755.GA3448@LAPTOP-UKSR4ENP.internal.baidu.com>,<20211021120135.3003-1-caihuoqing@baidu.com>
 <OFACD03FD5.99AACE16-ON00258775.004BD474-00258775.004BD47C@ibm.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF117   October 6, 2021
X-MIMETrack: Serialize by http on MWW0301/01/M/IBM at 10/21/2021 14:14:39,Serialize
 complete at 10/21/2021 14:14:39
X-Disclaimed: 43643
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rdaui_dDQj1rHp2A99r3bdTCha09_jUJ
X-Proofpoint-ORIG-GUID: au9D6ywHx9lIErgJ2kfG4r11-dLiCFju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_04,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210076
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Cai Huoqing" <caihuoqing@baidu.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Cai Huoqing" <caihuoqing@baidu.com>
>Date: 10/21/2021 04:08PM
>Cc: "Doug Ledford" <dledford@redhat.com>, "Jason Gunthorpe"
><jgg@ziepe.ca>, "Davidlohr Bueso" <dave@stgolabs.net>, "Paul E.
>McKenney" <paulmck@kernel.org>, "Josh Triplett"
><josh@joshtriplett.org>, "Steven Rostedt" <rostedt@goodmis.org>,
>"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
><jiangshanlai@gmail.com>, "Joel Fernandes" <joel@joelfernandes.org>,
>"Ingo Molnar" <mingo@redhat.com>, "Daniel Bristot de Oliveira"
><bristot@kernel.org>, <linux-rdma@vger.kernel.org>,
><linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
>Subject: [EXTERNAL] Re: [PATCH 0/6] kthread: Add the helper macro
>kthread=5Frun=5Fon=5Fcpu()
>
>On 21 10=E6=9C=88 21 13:48:15, Bernard Metzler wrote:
>> -----"Cai Huoqing" <caihuoqing@baidu.com> wrote: -----
>>=20
>> >To: <caihuoqing@baidu.com>
>> >From: "Cai Huoqing" <caihuoqing@baidu.com>
>> >Date: 10/21/2021 02:02PM
>> >Cc: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
>> ><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
>"Davidlohr
>> >Bueso" <dave@stgolabs.net>, "Paul E. McKenney"
><paulmck@kernel.org>,
>> >"Josh Triplett" <josh@joshtriplett.org>, "Steven Rostedt"
>> ><rostedt@goodmis.org>, "Mathieu Desnoyers"
>> ><mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
>> ><jiangshanlai@gmail.com>, "Joel Fernandes"
><joel@joelfernandes.org>,
>> >"Ingo Molnar" <mingo@redhat.com>, "Daniel Bristot de Oliveira"
>> ><bristot@kernel.org>, <linux-rdma@vger.kernel.org>,
>> ><linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
>> >Subject: [EXTERNAL] [PATCH 0/6] kthread: Add the helper macro
>> >kthread=5Frun=5Fon=5Fcpu()
>> >
>> >the helper macro kthread=5Frun=5Fon=5Fcpu() inculdes
>> >kthread=5Fcreate=5Fon=5Fcpu/wake=5Fup=5Fprocess().
>> >In some cases, use kthread=5Frun=5Fon=5Fcpu() directly instead of
>> >kthread=5Fcreate=5Fon=5Fnode/kthread=5Fbind/wake=5Fup=5Fprocess() or
>> >kthread=5Fcreate=5Fon=5Fcpu/wake=5Fup=5Fprocess() or
>> >kthreadd=5Fcreate/kthread=5Fbind/wake=5Fup=5Fprocess() to simplify the
>code.
>>=20
>> I do not see kthread=5Fbind() being covered by the helper,
>> as claimed? rcutorture, ring-buffer, siw are using it in
>> the code potentially being replaced by the helper.
>> kthread=5Fbind() is best to be called before thread starts
>> running, so should be part of it.
>Hi,
>kthread=5Fbind() is already part of kthread=5Fcreate=5Fon=5Fcpu which is
>called by kthread=5Frun=5Fon=5Fcpu() here.
>

Indeed! Thanks, Bernard.

>Thanks,
>Cai.
>>=20
>> Thanks,
>> Bernard.
>> >
>> >Cai Huoqing (6):
>> >  kthread: Add the helper macro kthread=5Frun=5Fon=5Fcpu()
>> >  RDMA/siw: Make use of the helper macro kthread=5Frun=5Fon=5Fcpu()
>> >  ring-buffer: Make use of the helper macro kthread=5Frun=5Fon=5Fcpu()
>> >  rcutorture: Make use of the helper macro kthread=5Frun=5Fon=5Fcpu()
>> >  trace/osnoise: Make use of the helper macro kthread=5Frun=5Fon=5Fcpu()
>> >  trace/hwlat: Make use of the helper macro kthread=5Frun=5Fon=5Fcpu()
>> >
>> > drivers/infiniband/sw/siw/siw=5Fmain.c |  7 +++----
>> > include/linux/kthread.h              | 22 ++++++++++++++++++++++
>> > kernel/rcu/rcutorture.c              |  7 ++-----
>> > kernel/trace/ring=5Fbuffer.c           |  7 ++-----
>> > kernel/trace/trace=5Fhwlat.c           |  6 +-----
>> > kernel/trace/trace=5Fosnoise.c         |  3 +--
>> > 6 files changed, 31 insertions(+), 21 deletions(-)
>> >
>> >--=20
>> >2.25.1
>> >
>> >
>
