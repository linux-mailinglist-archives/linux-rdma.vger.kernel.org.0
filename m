Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AB52D2F4C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 17:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgLHQR2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 11:17:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbgLHQR2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Dec 2020 11:17:28 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8G5WJN153147
        for <linux-rdma@vger.kernel.org>; Tue, 8 Dec 2020 11:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=kKdjM+P7clPx+vX2O/GKZgio4Y9dDlN40kAHekr1JXg=;
 b=VbsspHUUfuFqi04Ba7W8+ghEia5lI7a6Nlu85pjb7cgQZmIkFZet68qKD0mHjPPVqwu3
 7QwGRAQytr2zNwSGvsjfw9bk16L5Ro/5XbwavqnjHZkha7HYcR14pTDS5of899Ak9GV3
 JTm8wLCgVjh+LTYbm060ztr2qNloLha/SSIwRUDOb14E8O+dlc3O47lGxd53ygz1fep7
 FK1uuHqFyOkOXxUI5t8NdHPoy8niZjQZY/oUbthmd5NP9WGvvzPG2lRA0h+4mO/vTTp5
 GwGeLsinXoiSY0otYkuKFRO4vM0lygfMTp+BdKt+Tv5TCL8XakJ9b1IMvo0eLTmED74L Og== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359d5q04rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 08 Dec 2020 11:16:47 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 8 Dec 2020 16:16:46 -0000
Received: from us1a3-smtp04.a3.dal06.isc4sb.com (10.106.154.237)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 8 Dec 2020 16:16:43 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp04.a3.dal06.isc4sb.com
          with ESMTP id 2020120816164232-536483 ;
          Tue, 8 Dec 2020 16:16:42 +0000 
In-Reply-To: <3086f623-3c2a-e1f2-b6a1-d892604f7c74@talpey.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Tom Talpey" <tom@talpey.com>
Cc:     "Jason Gunthorpe" <jgg@nvidia.com>,
        "Kamal Heib" <kamalheib1@gmail.com>,
        "linux-rdma" <linux-rdma@vger.kernel.org>,
        "Doug Ledford" <dledford@redhat.com>
Date:   Tue, 8 Dec 2020 16:16:42 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <3086f623-3c2a-e1f2-b6a1-d892604f7c74@talpey.com>,<20201207202756.GA1798393@nvidia.com>
 <20201207093728.428679-1-kamalheib1@gmail.com>
 <OFA6B3AA67.4315DE52-ON00258638.00350498-00258638.003B2C04@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 18075
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 20120816-8877-0000-0000-000005185E75
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.008752
X-IBM-SpamModules-Versions: BY=3.00014335; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01475170; UDB=6.00794631; IPR=6.01257806;
 MB=3.00035410; MTD=3.00000008; XFM=3.00000015; UTC=2020-12-08 16:16:44
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-12-08 08:25:36 - 6.00012122
x-cbparentid: 20120816-8878-0000-0000-0000F477945A
Message-Id: <OFCFB6C08C.2D1EEA1C-ON00258638.00591772-00258638.00596BC8@notes.na.collabserv.com>
Subject: RE: [PATCH for-rc] RDMA/siw: Fix shift-out-of-bounds when call
 roundup_pow_of_two()
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_11:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Tom Talpey" <tom@talpey.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Jason Gunthorpe"
><jgg@nvidia.com>
>From: "Tom Talpey" <tom@talpey.com>
>Date: 12/08/2020 04:19PM
>Cc: "Kamal Heib" <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
>"Doug Ledford" <dledford@redhat.com>
>Subject: [EXTERNAL] Re: [PATCH for-rc] RDMA/siw: Fix
>shift-out-of-bounds when call roundup=5Fpow=5Fof=5Ftwo()
>
>On 12/8/2020 5:46 AM, Bernard Metzler wrote:
>> -----"Jason Gunthorpe" <jgg@nvidia.com> wrote: -----
>>=20
>>> To: "Kamal Heib" <kamalheib1@gmail.com>
>>> From: "Jason Gunthorpe" <jgg@nvidia.com>
>>> Date: 12/07/2020 09:29PM
>>> Cc: <linux-rdma@vger.kernel.org>, "Bernard Metzler"
>>> <bmt@zurich.ibm.com>, "Doug Ledford" <dledford@redhat.com>
>>> Subject: [EXTERNAL] Re: [PATCH for-rc] RDMA/siw: Fix
>>> shift-out-of-bounds when call roundup=5Fpow=5Fof=5Ftwo()
>>>
>>> On Mon, Dec 07, 2020 at 11:37:28AM +0200, Kamal Heib wrote:
>>>> When running the blktests over siw the following
>>> shift-out-of-bounds is
>>>> reported, this is happening because the passed IRD or ORD from
>the
>>> ulp
>>>> could be zero which will lead to unexpected behavior when calling
>>>> roundup=5Fpow=5Fof=5Ftwo(), fix that by blocking zero values of ORD or
>>> IRD.
>>>>
>>>> UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
>>>> shift exponent 64 is too large for 64-bit type 'long unsigned
>int'
>>>> CPU: 20 PID: 3957 Comm: kworker/u64:13 Tainted: G S
>5.10.0-rc6
>>> #2
>>>> Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.1.5
>>> 04/11/2016
>>>> Workqueue: iw=5Fcm=5Fwq cm=5Fwork=5Fhandler [iw=5Fcm]
>>>> Call Trace:
>>>>   dump=5Fstack+0x99/0xcb
>>>>   ubsan=5Fepilogue+0x5/0x40
>>>>   =5F=5Fubsan=5Fhandle=5Fshift=5Fout=5Fof=5Fbounds.cold.11+0xb4/0xf3
>>>>   ? down=5Fwrite+0x183/0x3d0
>>>>   siw=5Fqp=5Fmodify.cold.8+0x2d/0x32 [siw]
>>>>   ? =5F=5Flocal=5Fbh=5Fenable=5Fip+0xa5/0xf0
>>>>   siw=5Faccept+0x906/0x1b60 [siw]
>>>>   ? xa=5Fload+0x147/0x1f0
>>>>   ? siw=5Fconnect+0x17a0/0x17a0 [siw]
>>>>   ? lock=5Fdowngrade+0x700/0x700
>>>>   ? siw=5Fget=5Fbase=5Fqp+0x1c2/0x340 [siw]
>>>>   ? =5Fraw=5Fspin=5Funlock=5Firqrestore+0x39/0x40
>>>>   iw=5Fcm=5Faccept+0x1f4/0x430 [iw=5Fcm]
>>>>   rdma=5Faccept+0x3fa/0xb10 [rdma=5Fcm]
>>>>   ? check=5Fflush=5Fdependency+0x410/0x410
>>>>   ? cma=5Frep=5Frecv+0x570/0x570 [rdma=5Fcm]
>>>>   nvmet=5Frdma=5Fqueue=5Fconnect+0x1a62/0x2680 [nvmet=5Frdma]
>>>>   ? nvmet=5Frdma=5Falloc=5Fcmds+0xce0/0xce0 [nvmet=5Frdma]
>>>>   ? lock=5Frelease+0x56e/0xcc0
>>>>   ? lock=5Fdowngrade+0x700/0x700
>>>>   ? lock=5Fdowngrade+0x700/0x700
>>>>   ? =5F=5Fxa=5Falloc=5Fcyclic+0xef/0x350
>>>>   ? =5F=5Fxa=5Falloc+0x2d0/0x2d0
>>>>   ? rdma=5Frestrack=5Fadd+0xbe/0x2c0 [ib=5Fcore]
>>>>   ? =5F=5Fww=5Fmutex=5Fdie+0x190/0x190
>>>>   cma=5Fcm=5Fevent=5Fhandler+0xf2/0x500 [rdma=5Fcm]
>>>>   iw=5Fconn=5Freq=5Fhandler+0x910/0xcb0 [rdma=5Fcm]
>>>>   ? =5Fraw=5Fspin=5Funlock=5Firqrestore+0x39/0x40
>>>>   ? trace=5Fhardirqs=5Fon+0x1c/0x150
>>>>   ? cma=5Fib=5Fhandler+0x8a0/0x8a0 [rdma=5Fcm]
>>>>   ? =5F=5Fkasan=5Fkmalloc.constprop.7+0xc1/0xd0
>>>>   cm=5Fwork=5Fhandler+0x121c/0x17a0 [iw=5Fcm]
>>>>   ? iw=5Fcm=5Freject+0x190/0x190 [iw=5Fcm]
>>>>   ? trace=5Fhardirqs=5Fon+0x1c/0x150
>>>>   process=5Fone=5Fwork+0x8fb/0x16c0
>>>>   ? pwq=5Fdec=5Fnr=5Fin=5Fflight+0x320/0x320
>>>>   worker=5Fthread+0x87/0xb40
>>>>   ? =5F=5Fkthread=5Fparkme+0xd1/0x1a0
>>>>   ? process=5Fone=5Fwork+0x16c0/0x16c0
>>>>   kthread+0x35f/0x430
>>>>   ? kthread=5Fmod=5Fdelayed=5Fwork+0x180/0x180
>>>>   ret=5Ffrom=5Ffork+0x22/0x30
>>>>
>>>> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>>>> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>>>>   drivers/infiniband/sw/siw/siw=5Fcm.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>>> b/drivers/infiniband/sw/siw/siw=5Fcm.c
>>>> index 66764f7ef072..dff0b00cc55d 100644
>>>> +++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>>>> @@ -1571,7 +1571,8 @@ int siw=5Faccept(struct iw=5Fcm=5Fid *id, struct
>>> iw=5Fcm=5Fconn=5Fparam *params)
>>>>   		qp->tx=5Fctx.gso=5Fseg=5Flimit =3D 0;
>>>>   	}
>>>>   	if (params->ord > sdev->attrs.max=5Ford ||
>>>> -	    params->ird > sdev->attrs.max=5Fird) {
>>>> +	    params->ird > sdev->attrs.max=5Fird ||
>>>> +	    !params->ord || !params->ird) {
>>>>   		siw=5Fdbg=5Fcep(
>>>
>>> Are you sure this is the right place for this? Why not higher up?
>It
>>> looks like the other iwarp drivers have the same problem
>>>
>>> Jason
>>>
>> 1) Good question. Do we want to allow applications to zero-size
>> rdma READ capabilities? Maybe we want, if it is recognized as a
>> security feature?
>
>Do you mean zero-size RDMA Read, as in, an RDMA Read of zero bytes?
>This is a valid operation specifically mentioned in the protocols.
>
>Although it transfers no data, it does require a region protection
>check at the responder, and it's something that requesting
>applications
>may issue.
>
>OTOH, if you mean is a zero IRD or ORD valid, yes, that too is true.
>

Yes, that's what I meant. I think so too, this should be allowed.
One side might for example want to forbid the peer to send READ
requests, since it does not want to expose any buffer for remote
reading, so it want to set IRD to zero.

I don't know what other providers are doing, but let me fix that
for siw.


>The NFS/RDMA client actually did this, because the rpcrdma protocol
>permits only the server to issue RDMA operations. Therefore to reduce
>resources, the client would set IRD to zero, and ORD to some small
>number. The server would do the opposite (IRD=3Dn and ORD=3D0)
>
>> 2) In any case, siw currently does not correctly handle the case
>> of zero sized ORD/IRD. If we want to go with 1), some fixes to siw
>> are to be done. If we do not want 1), Kamal's patch is half of the
>> story. It handles the response side only. Initiator would have to
>> be fixed as well.
>>=20
>> I'd propose allowing 1). I'd fix siw accordingly. Opinions?
>
>Definitely allow both aspects of #1, and fix #2.
>
>Tom.
>

