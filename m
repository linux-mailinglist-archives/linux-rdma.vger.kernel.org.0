Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C775237A66C
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhEKMUD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:20:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231409AbhEKMUD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:20:03 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BC2ghJ030721
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=6HkyTegcjYQqWyGvfIzKZaIm+HkEOxmWxqKSCMFfC3A=;
 b=ITcNNRRuZ6NOch88Vbg0mW0If/mlRYN0O0RQGAzS/3h/qjOwSErIA62DjQabISTWgGki
 Xq13T1n17w1ogrRUmLzNbfaphOjhDwpYClpVln1RK48vuJR+6nuBpcnGoHoQkvr8o6bY
 Gq6cPG6F0IjYJO1HpIHFsH1VBE4N3t7QabJF/DwxeFu4m+2wZ6O2OyjcJSqCbhImmqCA
 8bjm+Vozkbugs9WUqRZee9IBLfEYIGQgbRxMnPtdMsOMFAvkO/DWFbvaAslSyGavOVAa
 zXtmbHKGjdAh8GtHOHbLsw94u+JOKghEig+S7g2q/fiDRox+X6ShsA3woALpFtoFDEuU 3A== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38fmxx0up6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:18:56 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:18:56 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:18:54 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2021051112185365-344982 ;
          Tue, 11 May 2021 12:18:53 +0000 
In-Reply-To: <3c43552c9b61a4d2352ae3680bfcacc25a9cc9b4.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 16/31] rdma/siw: use error and out logic at the end of
 siw_connect()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:18:53 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <3c43552c9b61a4d2352ae3680bfcacc25a9cc9b4.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 50479
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-8877-0000-0000-0000060219E9
X-IBM-SpamModules-Scores: BY=0.061607; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000001
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548292; UDB=6.00838382; IPR=6.01330253;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:18:55
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:42:53 - 6.00012377
x-cbparentid: 21051112-8878-0000-0000-0000F6251A21
Message-Id: <OF2112393D.C6667D3D-ON002586D2.0043A5AE-002586D2.0043A5B4@notes.na.collabserv.com>
X-Proofpoint-GUID: KqUFi8EpzuYEqzkdYoYiRs1VVwfW_qJo
X-Proofpoint-ORIG-GUID: KqUFi8EpzuYEqzkdYoYiRs1VVwfW_qJo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 05/07/2021 01:38AM
>Cc: linux-rdma@vger.kernel.org, "Stefan Metzmacher" <metze@samba.org>
>Subject: [EXTERNAL] [PATCH 16/31] rdma/siw: use error and out logic
>at the end of siw=5Fconnect()
>
>This will make the following changes easier.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 19 ++++++++++++-------
> 1 file changed, 12 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 41d3436985a6..ec6d5c26fe22 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1539,14 +1539,19 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
> 		cep->mpa.pdata =3D NULL;
> 	}
>=20
>-	if (rv >=3D 0) {
>-		rv =3D siw=5Fcm=5Fqueue=5Fwork(cep, SIW=5FCM=5FWORK=5FMPATIMEOUT);
>-		if (!rv) {
>-			siw=5Fdbg=5Fcep(cep, "[QP %u]: exit\n", qp=5Fid(qp));
>-			siw=5Fcep=5Fset=5Ffree(cep);
>-			return 0;
>-		}
>+	if (rv < 0) {
>+		goto error;
>+	}
>+
>+	rv =3D siw=5Fcm=5Fqueue=5Fwork(cep, SIW=5FCM=5FWORK=5FMPATIMEOUT);
>+	if (rv !=3D 0) {
>+		goto error;
> 	}
>+
>+	siw=5Fdbg=5Fcep(cep, "[QP %u]: exit\n", qp=5Fid(qp));
>+	siw=5Fcep=5Fset=5Ffree(cep);
>+	return 0;
>+
> error:
> 	siw=5Fdbg(id->device, "failed: %d\n", rv);
>=20
>--=20
>2.25.1
>
>
Okay

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

