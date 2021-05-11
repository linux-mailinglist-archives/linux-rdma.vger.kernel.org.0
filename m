Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AF137A6F9
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhEKMo5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:44:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21760 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbhEKMo5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:44:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BCYEks152883
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=tmmrIQOBwY9C8OPGjP2+WbZL3UzK1Qtt8F9vlWWdPhw=;
 b=Pz6kYiHSvfWawecIAfnbenNq81TFEoszJZOYhu6zfN9gCEfDQIatf8tYP7DqxJXnx6Sp
 C19LdWwCh2TalrOt28b/7KilEJPdQx/yzxXaidDDsAB8S8IY1eyQ0Sh1e0LjkGuGxZXZ
 OcBcHJZiRjL1yGyJ6R2lmLFHjJtEbqopQWaCAu9xD0V1ohKETO5t6DP5wpsx6FaLItIj
 CEPZdo34DIlei9HA0b4/L9cQgGg8BtwaPSju5p7jr70a1pX6UABAgVJbA4X1kV2ubYzX
 ZUaFs4vsRt1N1sSqSOp+e3fGg4fEeYAnU2crWdr35CK2abVBIQhkbT/p0EOkjbYNE02p 7g== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fs07269n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:43:50 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:43:49 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:43:48 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2021051112434840-398582 ;
          Tue, 11 May 2021 12:43:48 +0000 
In-Reply-To: <bf2e457f30108e0872f517e7ac585bb956a291a7.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 23/31] rdma/siw: make use of __siw_cep_close() in siw_accept()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:43:48 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <bf2e457f30108e0872f517e7ac585bb956a291a7.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 29763
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-8877-0000-0000-00000602212D
X-IBM-SpamModules-Scores: BY=0.062874; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548292; UDB=6.00838382; IPR=6.01330253;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:43:49
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:42:53 - 6.00012377
x-cbparentid: 21051112-8878-0000-0000-0000F6252171
Message-Id: <OF471C5B96.F83A72D2-ON002586D2.0045EDD8-002586D2.0045EDDF@notes.na.collabserv.com>
X-Proofpoint-GUID: ah8XckxcNghxXyQ6g3SOipQ4U4yJEeLx
X-Proofpoint-ORIG-GUID: ah8XckxcNghxXyQ6g3SOipQ4U4yJEeLx
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
>Subject: [EXTERNAL] [PATCH 23/31] rdma/siw: make use of
>=5F=5Fsiw=5Fcep=5Fclose() in siw=5Faccept()
>
>This is basically the same just that the code in
>=5F=5Fsiw=5Fcep=5Fclose() common, it skips elements which
>are still NULL. Before it was really hard to prove
>that we don't deference NULL pointers.
>
>While developing my smbdirect driver, I hit so much
>crashes and deadlocks, so we better have code that's
>understandable.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 18 +-----------------
> 1 file changed, 1 insertion(+), 17 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 09ae7f7ca82a..7fd67499f1d3 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1833,23 +1833,7 @@ int siw=5Faccept(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
>=20
> 	return 0;
> error:
>-	siw=5Fsocket=5Fdisassoc(cep->sock);
>-	sock=5Frelease(cep->sock);
>-	cep->sock =3D NULL;
>-
>-	cep->state =3D SIW=5FEPSTATE=5FCLOSED;
>-
>-	if (cep->cm=5Fid) {
>-		cep->cm=5Fid->rem=5Fref(id);
>-		cep->cm=5Fid =3D NULL;
>-	}
>-	if (qp->cep) {
>-		siw=5Fcep=5Fput(cep);
>-		qp->cep =3D NULL;
>-	}
>-	cep->qp =3D NULL;
>-	siw=5Fqp=5Fput(qp);
>-
>+	=5F=5Fsiw=5Fcep=5Fclose(cep);
> 	siw=5Fcep=5Fset=5Ffree(cep);
> 	siw=5Fcep=5Fput(cep);
>=20
>--=20
>2.25.1
>
>
OK, makes life easier.

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

