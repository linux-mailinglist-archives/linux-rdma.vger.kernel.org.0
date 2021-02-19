Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5B331FAC4
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 15:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhBSO3v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 09:29:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230113AbhBSO27 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Feb 2021 09:28:59 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JE1i1i070121
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 09:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=BzdcPbbNZP4sWjO06T4ddECPAmXCw1lAU7kgbiC/vhE=;
 b=Ozc97QNxvTgSHulIpZ+poqJ11472g9qpoMJEHjiyIxPF+LgEA8x07FlLHOiOvAQ4rwen
 sq1PNQntrK9SNMkRahyqK2YGs88jYEh+a295sO5W0pr+HasT7rf3mStupS0aqOQ6KPhW
 2YhJQm4yeFFvjg5ybCy8bUeA/T6RgIMNHriRM6cs3O3EOD5zi014Cx7uSPZlBbyFt4sl
 rLpYCo4R6u6cNVnWhe7ZpNAyIZ5wU0XieBOi8SWOwj3eTz9m+mBMAEexFenmjGcoMnaW
 4TzmCPfTImzth1cY4H9UaKbFIS1+D+IamndOrrS+dn+FXdEdO1HQ1fNpQ2rxi0BFvh14 mw== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tenqh6f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 19 Feb 2021 09:28:17 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 19 Feb 2021 14:28:16 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 19 Feb 2021 14:28:14 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2021021914281477-395641 ;
          Fri, 19 Feb 2021 14:28:14 +0000 
In-Reply-To: <20210219140254.1022-1-bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA/iwcm: Allow AFONLY binding for IPv6 addresses.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "linux-rdma" <linux-rdma@vger.kernel.org>
Cc:     jgg@ziepe.ca, "Chuck Lever" <chuck.lever@oracle.com>,
        "Benjamin Coddington" <bcodding@redhat.com>
Date:   Fri, 19 Feb 2021 14:28:13 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20210219140254.1022-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 9079
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21021914-2475-0000-0000-00000518395A
X-IBM-SpamModules-Scores: BY=0.057188; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.026302
X-IBM-SpamModules-Versions: BY=3.00014759; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01510088; UDB=6.00815469; IPR=6.01292612;
 MB=3.00036183; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-19 14:28:15
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-19 10:55:46 - 6.00012314
x-cbparentid: 21021914-2476-0000-0000-0000DC1B4E32
Message-Id: <OFDFEABE2B.5487835D-ON00258681.004F7D17-00258681.004F7D1F@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_05:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry I have to resend this patch, since I mistyped Jason's address.
Please don't reply to the first send.

Sorry and thanks
Bernard.

-----"Bernard Metzler" <bmt@zurich.ibm.com> wrote: -----
To: linux-rdma@vger.kernel.org
From: "Bernard Metzler" <bmt@zurich.ibm.com>
Date: 02/19/2021 03:05PM
Cc: gg@ziepe.ca, "Bernard Metzler" <bmt@zurich.ibm.com>, "Chuck Lever" <chu=
ck.lever@oracle.com>, "Benjamin Coddington" <bcodding@redhat.com>
Subject: [EXTERNAL] [PATCH] RDMA/iwcm: Allow AFONLY binding for IPv6 addres=
ses.

Binding IPv6 address/port to AF=5FINET6 domain only is provided
via rdma=5Fset=5Fafonly(), but was not signalled to the provider.
Applications like NFS/RDMA bind the same port to both IPv4
and IPv6 addresses simultaneously and thus rely on it working
correctly.

Tested-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/core/cma.c      |  1 +
 drivers/infiniband/sw/siw/siw=5Fcm.c | 19 +++++++++++++++++--
 include/rdma/iw=5Fcm.h               |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index c51b84b2d2f3..046d42c1f8f3 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2466,6 +2466,7 @@ static int cma=5Fiw=5Flisten(struct rdma=5Fid=5Fpriva=
te *id=5Fpriv, int backlog)
=20
 	id->tos =3D id=5Fpriv->tos;
 	id->tos=5Fset =3D id=5Fpriv->tos=5Fset;
+	id->afonly =3D id=5Fpriv->afonly;
 	id=5Fpriv->cm=5Fid.iw =3D id;
=20
 	memcpy(&id=5Fpriv->cm=5Fid.iw->local=5Faddr, cma=5Fsrc=5Faddr(id=5Fpriv),
diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c b/drivers/infiniband/sw/s=
iw/siw=5Fcm.c
index 1f9e15b71504..8bd0d0785433 100644
--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
@@ -1300,7 +1300,7 @@ static void siw=5Fcm=5Fllp=5Fstate=5Fchange(struct so=
ck *sk)
 }
=20
 static int kernel=5Fbindconnect(struct socket *s, struct sockaddr *laddr,
-			      struct sockaddr *raddr)
+			      struct sockaddr *raddr, bool afonly)
 {
 	int rv, flags =3D 0;
 	size=5Ft size =3D laddr->sa=5Ffamily =3D=3D AF=5FINET ?
@@ -1311,6 +1311,12 @@ static int kernel=5Fbindconnect(struct socket *s, st=
ruct sockaddr *laddr,
 	 */
 	sock=5Fset=5Freuseaddr(s->sk);
=20
+	if (afonly) {
+		rv =3D ip6=5Fsock=5Fset=5Fv6only(s->sk);
+		if (rv)=20
+			return rv;
+	}
+
 	rv =3D s->ops->bind(s, laddr, size);
 	if (rv < 0)
 		return rv;
@@ -1371,7 +1377,7 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct iw=
=5Fcm=5Fconn=5Fparam *params)
 	 * mode. Might be reconsidered for async connection setup at
 	 * TCP level.
 	 */
-	rv =3D kernel=5Fbindconnect(s, laddr, raddr);
+	rv =3D kernel=5Fbindconnect(s, laddr, raddr, id->afonly);
 	if (rv !=3D 0) {
 		siw=5Fdbg=5Fqp(qp, "kernel=5Fbindconnect: error %d\n", rv);
 		goto error;
@@ -1786,6 +1792,15 @@ int siw=5Fcreate=5Flisten(struct iw=5Fcm=5Fid *id, i=
nt backlog)
 	} else {
 		struct sockaddr=5Fin6 *laddr =3D &to=5Fsockaddr=5Fin6(id->local=5Faddr);
=20
+		if (id->afonly) {
+			rv =3D ip6=5Fsock=5Fset=5Fv6only(s->sk);
+			if (rv) {
+				siw=5Fdbg(id->device,
+					"ip6=5Fsock=5Fset=5Fv6only erro: %d\n", rv);
+				goto error;
+			}
+		}
+
 		/* For wildcard addr, limit binding to current device only */
 		if (ipv6=5Faddr=5Fany(&laddr->sin6=5Faddr))
 			s->sk->sk=5Fbound=5Fdev=5Fif =3D sdev->netdev->ifindex;
diff --git a/include/rdma/iw=5Fcm.h b/include/rdma/iw=5Fcm.h
index 91975400e1b3..03abd30e6c8c 100644
--- a/include/rdma/iw=5Fcm.h
+++ b/include/rdma/iw=5Fcm.h
@@ -70,6 +70,7 @@ struct iw=5Fcm=5Fid {
 	u8  tos;
 	bool tos=5Fset:1;
 	bool mapped:1;
+	bool afonly:1;
 };
=20
 struct iw=5Fcm=5Fconn=5Fparam {
--=20
2.17.2


