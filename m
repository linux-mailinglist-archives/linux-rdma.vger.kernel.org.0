Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A104E37A746
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhEKNED (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 09:04:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3088 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229921AbhEKNEC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 09:04:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BD2X3b021198
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 09:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=9bLHI2myJ0/yqTA4cfyVMLQj8zQZJiIpgol4dDA5CSs=;
 b=i2FtWmv2Zh2S/R6It/c2tl8cx3gVFldDvpuUJXQ/K+YdvuTt9DF2FtGCE7uvl1rWhgzr
 tEQaGT/i45cCnLrt1RpvUH6+WLkK34BlSspciHt4l6AvfhYx5/rGwd5P/2nW0Hy/D+1f
 TK46zqKkjXSr0ZtYRMtYEN1ROKvmLtWFNNVMUWqsB+tVsxcPcUnuKttRMl4vR6NWVike
 i38CSmmJd2X2tCg9O4ttsBLn4H5JjJeKOXY6e1ztOBnmaoU8pQAiQSmyAEU+AnMnJmuj
 CqbXHW6gE9JQiSnZ7IhKSpCX5lYeKf1Vf/+stVWxQZTKHY1Bkgl36yOV6y+RG0zDejPf Pg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.75])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38frvuaxjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 09:02:54 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 13:02:54 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.123) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 13:02:53 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2021051113025248-402653 ;
          Tue, 11 May 2021 13:02:52 +0000 
In-Reply-To: <2a9916bda4eb2ec63fcbf8b01041723383c3f844.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 27/31] rdma/siw: fix the "close" logic in siw_qp_cm_drop()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 13:02:52 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <2a9916bda4eb2ec63fcbf8b01041723383c3f844.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 20727
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051113-6875-0000-0000-000005001E5F
X-IBM-SpamModules-Scores: BY=0.062948; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000069
X-IBM-SpamModules-Versions: BY=3.00015187; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01526391; UDB=6.00825223; IPR=6.01308321;
 MB=3.00036950; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 13:02:54
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:44:55 - 6.00012377
x-cbparentid: 21051113-6876-0000-0000-0000691C1E90
Message-Id: <OFC6430E6E.5E32C18A-ON002586D2.0047ACA7-002586D2.0047ACAD@notes.na.collabserv.com>
X-Proofpoint-ORIG-GUID: T8kCK8JTMFjhRIx15Ve0lwpf92T52057
X-Proofpoint-GUID: T8kCK8JTMFjhRIx15Ve0lwpf92T52057
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 05/07/2021 01:40AM
>Cc: linux-rdma@vger.kernel.org, "Stefan Metzmacher" <metze@samba.org>
>Subject: [EXTERNAL] [PATCH 27/31] rdma/siw: fix the "close" logic in
>siw=5Fqp=5Fcm=5Fdrop()
>
>cep->cm=5Fid->rem=5Fref(cep->cm=5Fid) is no reason to call
>siw=5Fcep=5Fput(cep), we never call siw=5Fcep=5Fget(cep) when
>calling id->add=5Fref(id).
>
>But the cep->qp cleanup needs to drop both references!
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 3dc80c21ac60..9f9750237e75 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -546,7 +546,6 @@ void siw=5Fqp=5Fcm=5Fdrop(struct siw=5Fqp *qp, int
>schedule)
> 		if (cep->cm=5Fid) {
> 			cep->cm=5Fid->rem=5Fref(cep->cm=5Fid);
> 			cep->cm=5Fid =3D NULL;
>-			siw=5Fcep=5Fput(cep);
> 		}
> 		cep->state =3D SIW=5FEPSTATE=5FCLOSED;
>=20
>@@ -559,8 +558,11 @@ void siw=5Fqp=5Fcm=5Fdrop(struct siw=5Fqp *qp, int
>schedule)
> 			cep->sock =3D NULL;
> 		}
> 		if (cep->qp) {
>+			BUG=5FON(cep->qp->cep !=3D cep);

Please no BUG() and friends

>+			cep->qp->cep =3D NULL;

That pointer should be handled by the qp code

>+			siw=5Fqp=5Fput(cep->qp);
> 			cep->qp =3D NULL;
>-			siw=5Fqp=5Fput(qp);
>+			siw=5Fcep=5Fput(cep);
> 		}
> out:
> 		siw=5Fcep=5Fset=5Ffree(cep);
>--=20
>2.25.1
>
>

