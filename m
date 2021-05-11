Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7157A37A69D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhEKM05 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:26:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231640AbhEKM0s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:26:48 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BCKQ9A143927
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=de+xTVCYLt2TzCjAmg4AOmz02CYRMXTdKpJx8fnzSjE=;
 b=UkNABHVG6AfbvBA0UyQrk8SFaYs14NrqTy9YnNLPEWkJOkCKkT/4E+BpTjjoU72bypZu
 JUHJbFjoOBQgYgmb1mJ64qRv+6gwAaMpnpszISXYOuc8LoAxQ8s6P7VF3ErlOAZDSIpz
 TUkDySBLmTBmEnpaAW6imvz755FmgCMN4rIny/JHGG+YnORnobYNmaLMMcOI6GRwOSE1
 U8N+H4xC1brZLDF4VAQd2L8JdJzsaXtBf+xiErG9pDaZi7XywHqsHTEnIV5Dmrw/YgJn
 Byw5AvdGPOiD1l8eViw2HNm2u312GwLjQxz/lV6k27dq37zcylQZl7b5kUvIPrz8OR3b 5w== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.67])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fsugr34f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:25:41 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:25:40 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.16) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:25:37 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2021051112253748-384749 ;
          Tue, 11 May 2021 12:25:37 +0000 
In-Reply-To: <8f68ab650c2ecac55075d07a4256eff7b1735324.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 19/31] rdma/siw: split out a __siw_cep_close() function
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:25:36 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <8f68ab650c2ecac55075d07a4256eff7b1735324.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 63107
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-7279-0000-0000-0000052F1734
X-IBM-SpamModules-Scores: BY=0.061586; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00015199; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548696; UDB=6.00825164; IPR=6.01308321;
 MB=3.00036968; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:25:38
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:44:16 - 6.00012377
x-cbparentid: 21051112-7280-0000-0000-0000CE8E1751
Message-Id: <OF98AC74E9.587F3E67-ON002586D2.00444348-002586D2.0044434D@notes.na.collabserv.com>
X-Proofpoint-GUID: MndK84bMar10XOQN8sEKq9sjIPyDMXky
X-Proofpoint-ORIG-GUID: MndK84bMar10XOQN8sEKq9sjIPyDMXky
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
>Subject: [EXTERNAL] [PATCH 19/31] rdma/siw: split out a
>=5F=5Fsiw=5Fcep=5Fclose() function
>
>This can be used in a lot of other places too.
>And can be the code path that we can easily adjust
>without forgetting other places.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 48
>++++++++++++++++++++----------
> 1 file changed, 33 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 009a0afe6669..cf0f881c6793 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -220,6 +220,34 @@ static void =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall(stru=
ct
>siw=5Fcep *cep,
> 	}
> }
>=20
>+/*
>+ * The caller needs to deal with siw=5Fcep=5Fset=5Finuse()
>+ * and siw=5Fcep=5Fset=5Ffree()
>+ */
>+static void =5F=5Fsiw=5Fcep=5Fclose(struct siw=5Fcep *cep)
>+{
>+	cep->state =3D SIW=5FEPSTATE=5FCLOSED;
>+
>+	if (cep->sock) {
>+		siw=5Fsocket=5Fdisassoc(cep->sock);
>+		sock=5Frelease(cep->sock);
>+		cep->sock =3D NULL;
>+	}
>+
>+	if (cep->cm=5Fid) {
>+		cep->cm=5Fid->rem=5Fref(cep->cm=5Fid);
>+		cep->cm=5Fid =3D NULL;
>+	}
>+
>+	if (cep->qp) {
>+		BUG=5FON(cep->qp->cep !=3D cep);

Don't (re)introduce BUG()into the driver.


>+		cep->qp->cep =3D NULL;
>+		siw=5Fqp=5Fput(cep->qp);
>+		cep->qp =3D NULL;
>+		siw=5Fcep=5Fput(cep);
>+	}
>+}
>+
> static void siw=5Frtr=5Fdata=5Fready(struct sock *sk)
> {
> 	struct siw=5Fcep *cep;
>@@ -1559,27 +1587,17 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
> 	if (cep) {
> 		siw=5Fcancel=5Fmpatimer(cep);
>=20
>-		siw=5Fsocket=5Fdisassoc(s);
>-		sock=5Frelease(s);
>-		cep->sock =3D NULL;
>-
>-		cep->qp =3D NULL;
>+		s =3D NULL;
>+		qp =3D NULL;
>=20
>-		cep->cm=5Fid =3D NULL;
>-		id->rem=5Fref(id);
>-
>-		qp->cep =3D NULL;
>-		siw=5Fcep=5Fput(cep);
>-
>-		cep->state =3D SIW=5FEPSTATE=5FCLOSED;
>+		=5F=5Fsiw=5Fcep=5Fclose(cep);
>=20
> 		siw=5Fcep=5Fset=5Ffree(cep);
>=20
> 		siw=5Fcep=5Fput(cep);
>-
>-	} else if (s) {
>-		sock=5Frelease(s);
> 	}
>+	if (s)
>+		sock=5Frelease(s);
> 	if (qp)
> 		siw=5Fqp=5Fput(qp);
>=20
>--=20
>2.25.1
>
>

