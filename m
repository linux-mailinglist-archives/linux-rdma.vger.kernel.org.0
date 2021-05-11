Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2F37A709
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhEKMsn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:48:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbhEKMsn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:48:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BCXZGE175189
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=Zozj28znZnCUrt7yAPdR/qd/Xp0/ISCAoYhi1aG72xQ=;
 b=WMRDbryRL06P5QvLZ1VzwGVJ6M06gd2cijyRZ/oXM0PwKRa1L5VJyve5ft3b5qKpml2R
 gVTrCPXFSQHzbJ3xkAjoND4gELxPSTP20Lhz2Gl3C3jbCEAWpp2hYIpkV8syuM25KNP3
 apKw8WU8XRZ+06bWvJ7NN/SWWqhElo3oT41HPYFDBXzj2fQbOAkhei4EZZYcsIFeyIJG
 WOGkLcXMvCtc+sETHv7pzCNj9pmY8D9PM1YtAywf3kE/4Wx/JOdhCJCI9B9gGm/3aLqK
 Fv3s0PIuSNTA6+KDP/7iOTLx6px1JVu9s+gYZiYBxv018hu+zsGUbHduBUYxORanfIlt cg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38frea3cmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:47:36 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:47:36 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:47:34 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2021051112473388-395299 ;
          Tue, 11 May 2021 12:47:33 +0000 
In-Reply-To: <05e4a83a1b65d0cf47f4d0501f6dd081bce75602.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 24/31] rdma/siw: do the full disassociation of cep and qp in
 siw_qp_llp_close()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:47:33 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <05e4a83a1b65d0cf47f4d0501f6dd081bce75602.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 62715
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-9463-0000-0000-000005BA2087
X-IBM-SpamModules-Scores: BY=0.061259; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000442
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00838381; IPR=6.01330253;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:47:34
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:44:38 - 6.00012377
x-cbparentid: 21051112-9464-0000-0000-0000615820D5
Message-Id: <OF446FEF33.CA1CDB10-ON002586D2.0046458C-002586D2.00464593@notes.na.collabserv.com>
X-Proofpoint-ORIG-GUID: fKqm5lDt22AP4Xo9qbHP-H-34etkTxJh
X-Proofpoint-GUID: fKqm5lDt22AP4Xo9qbHP-H-34etkTxJh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 05/07/2021 01:39AM
>Cc: linux-rdma@vger.kernel.org, "Stefan Metzmacher" <metze@samba.org>
>Subject: [EXTERNAL] [PATCH 24/31] rdma/siw: do the full
>disassociation of cep and qp in siw=5Fqp=5Fllp=5Fclose()
>
>It's much clearer to drop the references on both sides and reset the
>cross referencing pointers in one place. I makes the caller much
>saner
>and understandable.

I think it is cleaner if the qp code does not alter
cep private pointers as it is in the current code.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 2 --
> drivers/infiniband/sw/siw/siw=5Fqp.c | 3 +++
> 2 files changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 7fd67499f1d3..31135d877d41 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1240,10 +1240,8 @@ static void siw=5Fcm=5Fwork=5Fhandler(struct
>work=5Fstruct *w)
> 			siw=5Fcep=5Fset=5Ffree(cep);
>=20
> 			siw=5Fqp=5Fllp=5Fclose(qp);
>-			siw=5Fqp=5Fput(qp);
>=20
> 			siw=5Fcep=5Fset=5Finuse(cep);
>-			cep->qp =3D NULL;
> 			siw=5Fqp=5Fput(qp);
> 		}
> 		if (cep->sock) {
>diff --git a/drivers/infiniband/sw/siw/siw=5Fqp.c
>b/drivers/infiniband/sw/siw/siw=5Fqp.c
>index ddb2e66f9f13..badb065eb9b1 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fqp.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fqp.c
>@@ -166,8 +166,11 @@ void siw=5Fqp=5Fllp=5Fclose(struct siw=5Fqp *qp)
> 	 * Dereference closing CEP
> 	 */
> 	if (qp->cep) {
>+		BUG=5FON(qp->cep->qp !=3D qp);

Don't introduce BUG()

>+		qp->cep->qp =3D NULL;

Only the CM code should change that pointer.

> 		siw=5Fcep=5Fput(qp->cep);
> 		qp->cep =3D NULL;
>+		siw=5Fqp=5Fput(qp);
> 	}
>=20
> 	up=5Fwrite(&qp->state=5Flock);
>--=20
>2.25.1
>
>

