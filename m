Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9FF17CEE
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfEHPQK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 8 May 2019 11:16:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbfEHPQJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 May 2019 11:16:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48F7VnN070823
        for <linux-rdma@vger.kernel.org>; Wed, 8 May 2019 11:16:07 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sc0tsjwtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2019 11:16:07 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 8 May 2019 15:16:06 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 8 May 2019 15:16:00 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp02.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019050815155995-615187 ;
          Wed, 8 May 2019 15:15:59 +0000 
In-Reply-To: <20190508142530.GE6938@mtr-leonro.mtl.com>
Subject: Re: iWARP and soft-iWARP interop testing
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>,
        "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Wed, 8 May 2019 15:15:59 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190508142530.GE6938@mtr-leonro.mtl.com>,<49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
 <20190507161304.GH6201@ziepe.ca> <20190508062600.GV6938@mtr-leonro.mtl.com>
 <20190508133028.GB32282@ziepe.ca> <20190508140644.GB6938@mtr-leonro.mtl.com>
 <20190508141841.GD32282@ziepe.ca>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-KeepSent: 5AD65D44:561F332B-002583F4:0050EC64;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 41043
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19050815-9695-0000-0000-0000063479CC
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.394266; ST=0; TS=0; UL=0; ISC=; MB=0.163511
X-IBM-SpamModules-Versions: BY=3.00011071; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01200398; UDB=6.00629841; IPR=6.00981285;
 BA=6.00006304; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026792; XFM=3.00000015;
 UTC=2019-05-08 15:16:04
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-08 12:40:21 - 6.00009900
x-cbparentid: 19050815-9696-0000-0000-000067568E86
Message-Id: <OF5AD65D44.561F332B-ON002583F4.0050EC64-002583F4.0053DCBB@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 05/08/2019 04:25PM
>Cc: "Doug Ledford" <dledford@redhat.com>, "linux-rdma"
><linux-rdma@vger.kernel.org>, "Bernard Metzler" <BMT@zurich.ibm.com>
>Subject: Re: iWARP and soft-iWARP interop testing
>
>On Wed, May 08, 2019 at 11:18:41AM -0300, Jason Gunthorpe wrote:
>> On Wed, May 08, 2019 at 05:06:44PM +0300, Leon Romanovsky wrote:
>> > On Wed, May 08, 2019 at 10:30:28AM -0300, Jason Gunthorpe wrote:
>> > > On Wed, May 08, 2019 at 09:26:00AM +0300, Leon Romanovsky
>wrote:
>> > > > On Tue, May 07, 2019 at 01:13:04PM -0300, Jason Gunthorpe
>wrote:
>> > > > > On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford
>wrote:
>> > > > > > So, Jason and I were discussing the soft-iWARP driver
>submission, and he
>> > > > > > thought it would be good to know if it even works with
>the various iWARP
>> > > > > > hardware devices.  I happen to have most of them on hand
>in one form or
>> > > > > > another, so I set down to test it.  In the process, I ran
>across some
>> > > > > > issues just with the hardware versions themselves, let
>alone with soft-
>> > > > > > iWARP.  So, here's the results of my matrix of tests.
>These aren't
>> > > > > > performance tests, just basic "does it work" smoke
>tests...
>> > > > >
>> > > > > Well, lets imagine to merge this at 5.2-rc1?
>> > > >
>> > > > Can we do something with kref in QPs and MRs before merging
>it?
>> > > >
>> > > > I'm super worried that memory model and locking used in this
>driver
>> > > > won't allow me to continue with allocation patches?
>> > >
>> > > Well, this use of idr doesn't look right to me:
>> > >
>> > > static inline struct siw_qp *siw_qp_id2obj(struct siw_device
>*sdev, int id)
>> > > {
>> > > 	struct siw_qp *qp = idr_find(&sdev->qp_idr, id);
>> > >
>> > > 	if (likely(qp && kref_get_unless_zero(&qp->ref)))
>> > > 		return qp;
>> > >
>> > > kref_get_unless_zero is nonsense unless used with someting like
>rcu,
>> > > and there is no rcu read lock here.
>> > >
>> > > Also, IDR's have to be locked..
>> > >
>> > > It probably wants to be written as
>> > >
>> > > xa_lock()
>> > > qp = xa_load()
>> > > if (qp)
>> > >    kref_get(&qp->ref);
>> > > xa_unlock()
>> > >
>> > > But I'm not completely sure what this is all about.. A QP
>cannot
>> > > really exist past destroy - about the only thing that would
>make sense
>> > > is to leave some memory around so other things can see it is
>failed -
>> > > but generally it is better to wipe out the QP from those other
>things
>> > > then attempt to do reference counting like this.
>> >
>> > No, no,, no, it is still not enough. I need to be sure that
>destroy path
>> > always successes and kref_get(&qp->ref) doesn't guarantee that.
>> >
>> > The good coding pattern can be seen in rdmavt
>> >
>https://urldefense.proofpoint.com/v2/url?u=https-3A__elixir.bootlin.c
>om_linux_latest_source_drivers_infiniband_sw_rdmavt_cq.c-23L316&d=DwI
>BAg&c=jf_iaSHvJObTbx-siA1ZOg&r=2TaYXQ0T-r8ZO1PP1alNwU_QJcRRLfmYTAgd3Q
>CvqSc&m=W8K4_QR3oPmfyY52_46Q1ICeIMJr5MSNJIsPe9AgVBM&s=sWDpPSRP82Q7pD_
>Q0fUJl44yuL42iMKHv0AKta4KGUo&e=
>> > They krefing and releasing extra structure outside of user
>visible object.
>>
>> In some respects I would rather the core code put a proper memory
>kref
>> in every object. We wanted this anyhow for the netlink restrack
>> stuff, and used properly it is pretty useful.
>
>We can do it and for sure will do it, but in meanwhile I would prefer
>do not
>see additions of krefs in drivers.
>

Without questioning the concept here, moving allocation and freeing
of core resources to the mid layer may induce complex changes at
driver level. Especially for a SW driver, which references those
objects on the fast path. Following the approach rdmavt takes,
that results in a split of objects between driver and mid layer.
So we abandon the idea of folding driver state and mid layer
state into one object.
I can think of such a thing for memory objects. What is the time
line for those changes to the mid layer? Will it be part of 5.2?

I guarantee I'll do those changes when really needed, but I'd
leave a rather stable current state. I am not saying I am reluctant
to do so.


Thanks,
Bernard.

