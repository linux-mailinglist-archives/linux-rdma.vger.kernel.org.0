Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFE737A5DC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 13:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhEKLh0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 07:37:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230501AbhEKLhY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 07:37:24 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BBYefb101977
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=wRc58SLgPnRflFFHbgC5VlQ1lKRsWetUoN9wOgXgN20=;
 b=jPrzWgYzcRtJCiRyPUL0aoVbfQNPy3XzgUVcMV9sqJiGu29Qq7VHlxMrOJQu9qLHX5be
 9ckxQqud9A4Psfy9Nt2VLoYx+JFA13wj9bmuE9Wdy+ibTLYs8ejGqajxFEkOr8yGCd1W
 PPbrgg1K4eSH6clGscuVqiv70BsAjCkbRFQ52ioNm5lm0Fx+6O+neYPQFv8hCcRXiYlU
 tDc5IDtWUTCrt9pe5cEUlXroRCUI8dl3CWu2R4Y3aR4xFhIambpaH8aTEkY6oJE4Mf2o
 uoaI5XhitYnbGvvGubd/Cq7HRmaUmb3YHva588CWHF9evlgmisu3fEILetKRwePtXYwj 0w== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38fmxwyksg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:36:17 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 11:36:16 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
        by smtp.notes.na.collabserv.com (10.122.47.39) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 11:36:15 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp02.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021051111361536-334462 ;
          Tue, 11 May 2021 11:36:15 +0000 
In-Reply-To: <cb0c051ce8001ec125c74148e172bfba2be831be.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 05/31] rdma/siw: make use of kernel_{bind,connect,listen}()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 11:36:14 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <cb0c051ce8001ec125c74148e172bfba2be831be.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 45F20966:563ABCA3-002586D2:003F9A08;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 40607
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051111-6283-0000-0000-000004BE05D2
X-IBM-SpamModules-Scores: BY=0.245521; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000012
X-IBM-SpamModules-Versions: BY=3.00015164; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01526391; UDB=6.00836696; IPR=6.01330096;
 MB=3.00036913; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 11:36:15
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:37:40 - 6.00012377
x-cbparentid: 21051111-6284-0000-0000-000004BE05DD
Message-Id: <OF45F20966.563ABCA3-ON002586D2.003F9A08-002586D2.003FBE34@notes.na.collabserv.com>
X-Proofpoint-GUID: KaAlChXYGW6Drgfo16CRX6e7LTGq9gs-
X-Proofpoint-ORIG-GUID: KaAlChXYGW6Drgfo16CRX6e7LTGq9gs-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
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
=20

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 05/07/2021 01:37AM
>Cc: linux-rdma@vger.kernel.org, "Stefan Metzmacher" <metze@samba.org>
>Subject: [EXTERNAL] [PATCH 05/31] rdma/siw: make use of
>kernel=5F{bind,connect,listen}()
>
>That's nicer than dereferencing socket structures.
>
>This prepares making rdma=5Fconnect()/siw=5Fconnect() non-blocking
>in order to avoid deadlocks in the callers.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 145ab6e4e0ed..e21cde84306e 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1319,11 +1319,11 @@ static int kernel=5Fbindconnect(struct socket
>*s, struct sockaddr *laddr,
> 			return rv;
> 	}
>=20
>-	rv =3D s->ops->bind(s, laddr, size);
>+	rv =3D kernel=5Fbind(s, laddr, size);
> 	if (rv < 0)
> 		return rv;
>=20
>-	rv =3D s->ops->connect(s, raddr, size, flags);
>+	rv =3D kernel=5Fconnect(s, raddr, size, flags);
>=20
> 	return rv < 0 ? rv : 0;
> }
>@@ -1787,8 +1787,8 @@ int siw=5Fcreate=5Flisten(struct iw=5Fcm=5Fid *id, i=
nt
>backlog)
> 		if (ipv4=5Fis=5Fzeronet(laddr->sin=5Faddr.s=5Faddr))
> 			s->sk->sk=5Fbound=5Fdev=5Fif =3D sdev->netdev->ifindex;
>=20
>-		rv =3D s->ops->bind(s, (struct sockaddr *)laddr,
>-				  sizeof(struct sockaddr=5Fin));
>+		rv =3D kernel=5Fbind(s, (struct sockaddr *)laddr,
>+				 sizeof(struct sockaddr=5Fin));
> 	} else {
> 		struct sockaddr=5Fin6 *laddr =3D &to=5Fsockaddr=5Fin6(id->local=5Faddr);
>=20
>@@ -1805,8 +1805,8 @@ int siw=5Fcreate=5Flisten(struct iw=5Fcm=5Fid *id, i=
nt
>backlog)
> 		if (ipv6=5Faddr=5Fany(&laddr->sin6=5Faddr))
> 			s->sk->sk=5Fbound=5Fdev=5Fif =3D sdev->netdev->ifindex;
>=20
>-		rv =3D s->ops->bind(s, (struct sockaddr *)laddr,
>-				  sizeof(struct sockaddr=5Fin6));
>+		rv =3D kernel=5Fbind(s, (struct sockaddr *)laddr,
>+				 sizeof(struct sockaddr=5Fin6));
> 	}
> 	if (rv) {
> 		siw=5Fdbg(id->device, "socket bind error: %d\n", rv);
>@@ -1826,7 +1826,7 @@ int siw=5Fcreate=5Flisten(struct iw=5Fcm=5Fid *id, i=
nt
>backlog)
> 			rv, backlog);
> 		goto error;
> 	}
>-	rv =3D s->ops->listen(s, backlog);
>+	rv =3D kernel=5Flisten(s, backlog);
> 	if (rv) {
> 		siw=5Fdbg(id->device, "listen error %d\n", rv);
> 		goto error;
>--=20
>2.25.1
>
>
Yes, thanks.

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

