Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2735D377F6F
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 11:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhEJJet (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 05:34:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhEJJet (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 05:34:49 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14A9Wr5I186239
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 05:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=JcpoMnIRkTOkvZvjAuMBKUtTrT4EQeLnaMMW2qU1SYU=;
 b=AHQ0Y5BY7GyJJEXf+71kXcG1IM10zatNvaSnlNnwyU4S93tARkoTJQgReGptbANdz4Yw
 TlQ0DmAH/SQswgfbbsmc5L26WGeFFEg6TjJ599nYCz5EyuBoUxfOnVG/SRMtvh6rL5qp
 4yYvFf/U8IpDOZ2xKbMySEFNJWLvvm6n5z9XM8MvO/XRhGVoCRQke9U6pFPgSRtRmoeP
 g85587LZYZxtP2vawcX616DDsI2qdt1662pCNmUElGIK07DNK1vXgQEt+E3lON0edkof
 qhsQOVdJcXQ+q6EsbPgVvQEnv0GvyHPsnRtwWQvZXGH1vh6/L1TBSdFemP9gBeSki7ko Fg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38f215rgr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 05:33:44 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 10 May 2021 09:33:44 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.158) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 10 May 2021 09:33:42 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2021051009334187-213731 ;
          Mon, 10 May 2021 09:33:41 +0000 
In-Reply-To: <a7535a82925f6f4c1f062abaa294f3ae6e54bdd2.1620560310.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/siw: Properly check send and receive CQ pointers
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "Leon Romanovsky" <leonro@nvidia.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Mon, 10 May 2021 09:33:42 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <a7535a82925f6f4c1f062abaa294f3ae6e54bdd2.1620560310.git.leonro@nvidia.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 36103
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051009-1335-0000-0000-0000066E777D
X-IBM-SpamModules-Scores: BY=0.057812; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.001860
X-IBM-SpamModules-Versions: BY=3.00015164; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01526391; UDB=6.00825163; IPR=6.01326296;
 MB=3.00036913; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-10 09:33:43
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:37:47 - 6.00012377
x-cbparentid: 21051009-1336-0000-0000-00004291841A
Message-Id: <OF3A0AA228.38D2DA2D-ON002586D1.0034863E-002586D1.00348647@notes.na.collabserv.com>
X-Proofpoint-ORIG-GUID: MxSPoD2DF2kQ7fN6DxaRztetE3AZHvN4
X-Proofpoint-GUID: MxSPoD2DF2kQ7fN6DxaRztetE3AZHvN4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_04:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Doug Ledford" <dledford@redhat.com>, "Jason Gunthorpe"
><jgg@nvidia.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 05/09/2021 01:39PM
>Cc: "Leon Romanovsky" <leonro@nvidia.com>, "Bernard Metzler"
><bmt@zurich.ibm.com>, linux-kernel@vger.kernel.org,
>linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] [PATCH rdma-rc] RDMA/siw: Properly check send and
>receive CQ pointers
>
>From: Leon Romanovsky <leonro@nvidia.com>
>
>The check for the NULL of pointer received from container=5Fof is
>incorrect by definition as it points to some random memory.
>
>Change such check with proper NULL check of SIW QP attributes.
>
>Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---
> drivers/infiniband/sw/siw/siw=5Fverbs.c | 9 +++------
> 1 file changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fverbs.c
>b/drivers/infiniband/sw/siw/siw=5Fverbs.c
>index d2313efb26db..917c8a919f38 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fverbs.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fverbs.c
>@@ -300,7 +300,6 @@ struct ib=5Fqp *siw=5Fcreate=5Fqp(struct ib=5Fpd *pd,
> 	struct siw=5Fucontext *uctx =3D
> 		rdma=5Fudata=5Fto=5Fdrv=5Fcontext(udata, struct siw=5Fucontext,
> 					  base=5Fucontext);
>-	struct siw=5Fcq *scq =3D NULL, *rcq =3D NULL;
> 	unsigned long flags;
> 	int num=5Fsqe, num=5Frqe, rv =3D 0;
> 	size=5Ft length;
>@@ -343,10 +342,8 @@ struct ib=5Fqp *siw=5Fcreate=5Fqp(struct ib=5Fpd *pd,
> 		rv =3D -EINVAL;
> 		goto err=5Fout;
> 	}
>-	scq =3D to=5Fsiw=5Fcq(attrs->send=5Fcq);
>-	rcq =3D to=5Fsiw=5Fcq(attrs->recv=5Fcq);
>=20
>-	if (!scq || (!rcq && !attrs->srq)) {
>+	if (!attrs->send=5Fcq || (!attrs->recv=5Fcq && !attrs->srq)) {
> 		siw=5Fdbg(base=5Fdev, "send CQ or receive CQ invalid\n");
> 		rv =3D -EINVAL;
> 		goto err=5Fout;
>@@ -401,8 +398,8 @@ struct ib=5Fqp *siw=5Fcreate=5Fqp(struct ib=5Fpd *pd,
> 		}
> 	}
> 	qp->pd =3D pd;
>-	qp->scq =3D scq;
>-	qp->rcq =3D rcq;
>+	qp->scq =3D to=5Fsiw=5Fcq(attrs->send=5Fcq);
>+	qp->rcq =3D to=5Fsiw=5Fcq(attrs->recv=5Fcq);
>=20
> 	if (attrs->srq) {
> 		/*
>--=20
>2.31.1
>
>
Thanks Leon!

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

