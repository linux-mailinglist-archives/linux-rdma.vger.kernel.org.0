Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE06A37A62A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhEKL6u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 07:58:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231327AbhEKL6u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 07:58:50 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BBYepN101977
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=d9WoXOpe16H9hfslnrxouhVBtUHtBaQUXCgTFhIz2cA=;
 b=Zz5qjytHNP6Q1Pqv79tRyLRW//xGA9+0rUZc/06U7GKQ0bKy4v/TBZ/ZxP1eSFkJtT8X
 Tr/1jiz7WADPTVI+NaO9ivN47Xw7DDTGeiQfQu2mn/0XvVS4X4Fv+g3mlMSHksoXhPtZ
 CJyCx8KNg5ytJxa2lzkHZNCUPPflpyb3ReuCfSDYm9z9IFHSEfRnkXS2a3aPM2NfMo2x
 gtAMeMuFyYrfY+0A3c8GvSxgwwHLzQWrZjnvIQ+iSfnyFXAsnxP43Gh4fjrmJ894fjjF
 2Cv5umVgukgKsM0y+u3acJFJd3DDMo2vcgSW8z7BX+T1kwcAg/4Mz+NzIthDIiij4m3X tw== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38fmxx058m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:57:43 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 11:56:52 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 11:56:49 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021051111564927-319974 ;
          Tue, 11 May 2021 11:56:49 +0000 
In-Reply-To: <c4ad39d9a5c7b22e60fbbfd43dc2f8b068e2eea9.1620343860.git.metze@samba.org>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 11:56:48 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <c4ad39d9a5c7b22e60fbbfd43dc2f8b068e2eea9.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: B6D97A4E:9D507059-002586D2:0041A009;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 52987
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051111-3017-0000-0000-0000048F0A3D
X-IBM-SpamModules-Scores: BY=0.06188; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00015182; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00825223; IPR=6.01330096;
 MB=3.00036941; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 11:56:50
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 14:10:42 - 6.00012377
x-cbparentid: 21051111-3018-0000-0000-000070520A6C
Message-Id: <OFB6D97A4E.9D507059-ON002586D2.0041A009-002586D2.0041A00D@notes.na.collabserv.com>
X-Proofpoint-GUID: 2i5QfTduNjQIFgHbMNh5hZFiWaKQvD0p
X-Proofpoint-ORIG-GUID: 2i5QfTduNjQIFgHbMNh5hZFiWaKQvD0p
Subject: Re:  [PATCH 08/31] rdma/siw: use __siw_cep_terminate_upcall() for indirect
 SIW_CM_WORK_CLOSE_LLP
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
>Subject: [EXTERNAL] [PATCH 08/31] rdma/siw: use
>=5F=5Fsiw=5Fcep=5Fterminate=5Fupcall() for indirect SIW=5FCM=5FWORK=5FCLOS=
E=5FLLP
>
>Both code paths from siw=5Fqp=5Fcm=5Fdrop() should use the same logic.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 6 +-----
> 1 file changed, 1 insertion(+), 5 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index c91a74271b9b..b7e7f637bd03 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1071,11 +1071,7 @@ static void siw=5Fcm=5Fwork=5Fhandler(struct
>work=5Fstruct *w)
> 		/*
> 		 * QP scheduled LLP close
> 		 */
>-		if (cep->qp && cep->qp->term=5Finfo.valid)
>-			siw=5Fsend=5Fterminate(cep->qp);
>-
leave that there.

>-		if (cep->cm=5Fid)
>-			siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCLOSE, 0);
>+		=5F=5Fsiw=5Fcep=5Fterminate=5Fupcall(cep, -EINVAL);
>=20
> 		release=5Fcep =3D 1;
> 		break;
>--=20
>2.25.1
>
>

