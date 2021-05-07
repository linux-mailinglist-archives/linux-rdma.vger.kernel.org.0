Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412863764E5
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 14:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhEGMKD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 May 2021 08:10:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7962 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235823AbhEGMKD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 May 2021 08:10:03 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147C4HmX145202
        for <linux-rdma@vger.kernel.org>; Fri, 7 May 2021 08:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=Q9xkT4IbXK1LUbgsMdacLRB7+NfnMxCLMuoLTz/czGw=;
 b=m8HKW5dY6gMqP7YcJ6gbOOj1HeM342E7F/nK/7Gk+pQCjW7A71eDD6voef7kPWs4TldQ
 F1PzjzPd7CcVAKNel7lwhMXsc17JnSWJKxSxHG9B08iiHFfH53qF8PBrqZlrNQat3vzX
 9oBSUqtylm1C0hUbDeikT4CncUoKyp6qFetQttE1WWB303m1E4Xbnqbim/h/jedeYCH8
 6oxPipjFiCzSFWq7dWTHDjxQWfog/94S7cBkDXYY2BLsbfmG9XEVJn3gQRi0ukVrTqjC
 61vjjUO/ayIFpIhNHuIWd4gWz3JnNz6lxzYIfdaTsBwze44pF8kJDcequlSkfNxpLVuJ 2w== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38d42msyg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 07 May 2021 08:09:03 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 7 May 2021 12:09:02 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 7 May 2021 12:08:59 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021050712085930-255065 ;
          Fri, 7 May 2021 12:08:59 +0000 
In-Reply-To: <cover.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 00/31] rdma/siw: fix a lot of deadlocks and use after free bugs
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Fri, 7 May 2021 12:08:59 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 63068FA7:7F9E2E59-002586CE:0041A961;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 4747
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21050712-3017-0000-0000-0000048B0A6D
X-IBM-SpamModules-Scores: BY=0.06032; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.003847
X-IBM-SpamModules-Versions: BY=3.00014940; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01546296; UDB=6.00825223; IPR=6.01308221;
 MB=3.00036522; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-07 12:09:00
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 14:10:42 - 6.00012377
x-cbparentid: 21050712-3018-0000-0000-0000704A0ACD
Message-Id: <OF63068FA7.7F9E2E59-ON002586CE.0041A961-002586CE.0042BDA1@notes.na.collabserv.com>
X-Proofpoint-ORIG-GUID: SzhFBfcCrAjG-dESRB0D6Ax3WoyMrq1q
X-Proofpoint-GUID: SzhFBfcCrAjG-dESRB0D6Ax3WoyMrq1q
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_04:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 05/07/2021 01:37AM
>Cc: linux-rdma@vger.kernel.org, "Stefan Metzmacher" <metze@samba.org>
>Subject: [EXTERNAL] [PATCH 00/31] rdma/siw: fix a lot of deadlocks
>and use after free bugs
>
>Hi Bernard,
>
>while testing with my smbdirect driver I hit a lot of
>bugs in the siw.ko driver. They all cause problems where
>the siw driver was not able to unload anymore and I had to
>reboot the machine.
>
Hi Stefan,

Much appreciated!
These are quite some patches, and I will need some time
to go through. Would bee nice if those would be broken
down into smaller bundles (introduce non-blocking connect,
=5Fsiw=5Fcep=5Fclose() subroutine, fixing cep reference counting,
smp=5Fmb() after STag invalidation, ..). Anyway, many
thanks for the effort, it will improve the driver!

First comments:

A non blocking connect does really makes sense as you
are pointing out. I hope it doesn't complicate the CM
code even further.

I think we agreed upon not using BUG() and BUG=5FON(),
so please don't introduce it.

'I hit a lot of bugs' is not very helpful, but just
a statement.

Thanks very much!
Bernard.


>I implemented:
>- a non blocking connect
>- fixed a lot of bugs where siw=5Fcep=5Fput() was called too often.
>- fixed bugs where siw=5Fcm=5Fupcall() confused the core IWCM logic
>
>I have some more changes to follow, but I wanted to send them
>finally out after having them one and a half year sitting in some
>private branch...
>
>Stefan Metzmacher (31):
>  rdma/siw: fix warning in siw=5Fproc=5Fsend()
>  rdma/siw: call smp=5Fmb() after mem->stag=5Fvalid =3D 0 in
>    siw=5Finvalidate=5Fstag() too
>  rdma/siw: remove superfluous siw=5Fcep=5Fput() from siw=5Fconnect() error
>    path
>  rdma/siw: let siw=5Faccept() deferr RDMA=5FMODE until EVENT=5FESTABLISHED
>  rdma/siw: make use of kernel=5F{bind,connect,listen}()
>  rdma/siw: make siw=5Fcm=5Fupcall() a noop without valid 'id'
>  rdma/siw: split out a =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall() function
>  rdma/siw: use =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall() for indirect
>    SIW=5FCM=5FWORK=5FCLOSE=5FLLP
>  rdma/siw: use =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall() for
>SIW=5FCM=5FWORK=5FPEER=5FCLOSE
>  rdma/siw: use =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall() for
>SIW=5FCM=5FWORK=5FMPATIMEOUT
>  rdma/siw: introduce SIW=5FEPSTATE=5FACCEPTING/REJECTING for
>    rdma=5Faccept/rdma=5Freject
>  rdma/siw: add some debugging of state and sk=5Fstate to the teardown
>    process
>  rdma/siw: handle SIW=5FEPSTATE=5FCONNECTING in
>    =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall()
>  rdma/siw: let siw=5Fconnect() set AWAIT=5FMPAREP before
>    siw=5Fsend=5Fmpareqrep()
>  rdma/siw: create a temporary copy of private data
>  rdma/siw: use error and out logic at the end of siw=5Fconnect()
>  rdma/siw: start mpa timer before calling siw=5Fsend=5Fmpareqrep()
>  rdma/siw: call the blocking kernel=5Fbindconnect() just before
>    siw=5Fsend=5Fmpareqrep()
>  rdma/siw: split out a =5F=5Fsiw=5Fcep=5Fclose() function
>  rdma/siw: implement non-blocking connect.
>  rdma/siw: let siw=5Flisten=5Faddress() call siw=5Fcep=5Falloc() first
>  rdma/siw: let siw=5Flisten=5Faddress() call siw=5Fcep=5Fset=5Finuse() ea=
rly
>  rdma/siw: make use of =5F=5Fsiw=5Fcep=5Fclose() in siw=5Faccept()
>  rdma/siw: do the full disassociation of cep and qp in
>    siw=5Fqp=5Fllp=5Fclose()
>  rdma/siw: fix double siw=5Fcep=5Fput() in siw=5Fcm=5Fwork=5Fhandler()
>  rdma/siw: make use of =5F=5Fsiw=5Fcep=5Fclose() in siw=5Fcm=5Fwork=5Fhan=
dler()
>  rdma/siw: fix the "close" logic in siw=5Fqp=5Fcm=5Fdrop()
>  rdma/siw: make use of =5F=5Fsiw=5Fcep=5Fclose() in siw=5Fqp=5Fcm=5Fdrop()
>  rdma/siw: make use of =5F=5Fsiw=5Fcep=5Fclose() in siw=5Freject()
>  rdma/siw: make use of =5F=5Fsiw=5Fcep=5Fclose() in siw=5Flisten=5Faddres=
s()
>  rdma/siw: make use of =5F=5Fsiw=5Fcep=5Fclose() in siw=5Fdrop=5Flistener=
s()
>
> drivers/infiniband/sw/siw/siw=5Fcm.c    | 537
>+++++++++++++++-----------
> drivers/infiniband/sw/siw/siw=5Fcm.h    |   3 +
> drivers/infiniband/sw/siw/siw=5Fmem.c   |   2 +
> drivers/infiniband/sw/siw/siw=5Fqp.c    |   3 +
> drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c |   2 +-
> 5 files changed, 316 insertions(+), 231 deletions(-)
>
>--=20
>2.25.1
>
>

