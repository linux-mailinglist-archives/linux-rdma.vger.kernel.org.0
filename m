Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF74E37666C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 15:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhEGNxZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 May 2021 09:53:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234081AbhEGNxY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 May 2021 09:53:24 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147DlwN7071976
        for <linux-rdma@vger.kernel.org>; Fri, 7 May 2021 09:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=DOMRk1cVCFOfhkc+QUQ4ejEbauZOx3EM34JJ3tfpn3E=;
 b=aJTxE/vCdv6gqZweBiKIlOMWNyBeoYyqMjaUHU4Iaz4Gsta+laOyqP7fhkow1o5xcnZC
 0u+0TcWuS4gh6xU31eS93c0eVQmvV/8TIfu+v82/Zhp+GTV9cHVXTnnoHMC/DLqdxn04
 0Kcvg81QdFIsPOo74T+oO4AbC1HDL/GlzemfBPHCm7fduIb9SL2N1CzHDY9QPqpPhzxE
 Lnjq0spTxVyqls40QEQ5hMNl1c7OJMeZg4pXdSWU+Kdhv+EWO9q9fXRFPUGocOSJRGdO
 +zfT3O+MucfVcin4BSF43uRu9H4ftwCmAEUIE4iaC3adJmF4ja5EHXEaraLUqS++TQZA fA== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38d6rj823x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 07 May 2021 09:52:23 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 7 May 2021 13:52:23 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.47.48) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 7 May 2021 13:52:22 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021050713522213-330261 ;
          Fri, 7 May 2021 13:52:22 +0000 
In-Reply-To: <66dd3e80886db4a9fe1795ecd906330255923625.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 03/31] rdma/siw: remove superfluous siw_cep_put() from
 siw_connect() error path
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Fri, 7 May 2021 13:52:21 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <66dd3e80886db4a9fe1795ecd906330255923625.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: B6BD179F:592A1F43-002586CE:004C3481;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 12151
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21050713-1429-0000-0000-000003C71A0C
X-IBM-SpamModules-Scores: BY=0.06224; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000057
X-IBM-SpamModules-Versions: BY=3.00015161; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01526390; UDB=6.00825164; IPR=6.01308223;
 MB=3.00036901; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-07 13:52:23
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 13:55:12 - 6.00012377
x-cbparentid: 21050713-1430-0000-0000-00003A631D04
Message-Id: <OFB6BD179F.592A1F43-ON002586CE.004C3481-002586CE.004C3486@notes.na.collabserv.com>
X-Proofpoint-GUID: S9BRcBlEfCMlMP6Zc5rTCCdDL4K0hyvF
X-Proofpoint-ORIG-GUID: S9BRcBlEfCMlMP6Zc5rTCCdDL4K0hyvF
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
>Subject: [EXTERNAL] [PATCH 03/31] rdma/siw: remove superfluous
>siw=5Fcep=5Fput() from siw=5Fconnect() error path
>
>The following change demonstrate the bug:
>
>    --- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>    +++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>    @@ -1507,6 +1507,9 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
>            if (rv >=3D 0) {
>                    rv =3D siw=5Fcm=5Fqueue=5Fwork(cep,
>SIW=5FCM=5FWORK=5FMPATIMEOUT);
>                    if (!rv) {
>    +                       rv =3D -ECONNRESET;
>    +                       msleep=5Finterruptible(100);
>    +                       goto error;
>                            siw=5Fdbg=5Fcep(cep, "[QP %u]: exit\n",
>qp=5Fid(qp));
>                            siw=5Fcep=5Fset=5Ffree(cep);
>                            return 0;
>
>That change triggers the WARN=5FON() in siw=5Fcep=5Fput().
>
>As there's no siw=5Fcep=5Fget() arround id->add=5Fref()
>I removed the siw=5Fcep=5Fput() following id->rem=5Fref().
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 7a5ed86ffc9f..da84686a21fd 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1494,7 +1494,6 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
>=20
> 		cep->cm=5Fid =3D NULL;
> 		id->rem=5Fref(id);
>-		siw=5Fcep=5Fput(cep);
>=20
> 		qp->cep =3D NULL;
> 		siw=5Fcep=5Fput(cep);
>--=20
>2.25.1
>
>

Thanks, good catch!

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

