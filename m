Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CCF36ACE6
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 09:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhDZH1a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 03:27:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231989AbhDZH13 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Apr 2021 03:27:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13Q74HbZ005349
        for <linux-rdma@vger.kernel.org>; Mon, 26 Apr 2021 03:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=HtXloDZ38JnKKbC6QD1UeOxDeLycabWHFLqjAzM9I9g=;
 b=Ouae7rTOIx7SQ9RSM/1jL+hQYa/wsTCh0OBWwbAlichDENoJA5zHFs21OmWqLKymThM4
 BWCEqog0m04iqHL5TmqVOPcFuHMOEKKumnru/TP1iMV0FSnvtJxcvppq+7PWIxVNesCJ
 TBclJM1KG4INoBLp7FiwWcJzet2AGUg2LNN/8IJfaMl0fcgmw8SP09DTBwtwyRdLWzKF
 g6vzXA9gvaaM8MeA00gyfXKBEGRjwL0yvLCKHoWl8ZMQvS02tQOQfHXPUvBXuZwr4sn1
 wlWYV7dZoXPttl9p+uG4pL/GQ3W1fiksapoqqcVDzPaSezCA1CJxxV0dCl4pUgXMUaf6 1w== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385puk38rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 26 Apr 2021 03:26:48 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 26 Apr 2021 07:26:48 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
        by smtp.notes.na.collabserv.com (10.122.47.50) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 26 Apr 2021 07:26:45 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp02.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021042607264488-116828 ;
          Mon, 26 Apr 2021 07:26:44 +0000 
In-Reply-To: <20210426011647.3561-1-lyl2019@mail.ustc.edu.cn>
Subject: Re: [PATCH v2] rdma/siw: Fix a use after free in siw_alloc_mr
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Lv Yunlong" <lyl2019@mail.ustc.edu.cn>
Cc:     "dledford" <dledford@redhat.com>, "jgg" <jgg@ziepe.ca>,
        "linux-rdma" <linux-rdma@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>, leon@kernel.org
Date:   Mon, 26 Apr 2021 07:26:45 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20210426011647.3561-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: EDD7FB92:558D79F3-002586C3:0028E6C4;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 52767
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21042607-1059-0000-0000-000003C53746
X-IBM-SpamModules-Scores: BY=0.060901; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.018379
X-IBM-SpamModules-Versions: BY=3.00014940; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01526391; UDB=6.00825164; IPR=6.01308321;
 MB=3.00036522; MTD=3.00000008; XFM=3.00000015; UTC=2021-04-26 07:26:46
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-23 12:31:21 - 6.00012377
x-cbparentid: 21042607-1060-0000-0000-00008A6F4D88
Message-Id: <OFEDD7FB92.558D79F3-ON002586C3.0028E6C4-002586C3.0028E6CD@notes.na.collabserv.com>
X-Proofpoint-ORIG-GUID: Rmoq1Y7bFYVGKE719XACAMzD_rDDqzoH
X-Proofpoint-GUID: Rmoq1Y7bFYVGKE719XACAMzD_rDDqzoH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-25_11:2021-04-23,2021-04-25 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Lv Yunlong" <lyl2019@mail.ustc.edu.cn> wrote: -----

>To: bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca
>From: "Lv Yunlong" <lyl2019@mail.ustc.edu.cn>
>Date: 04/26/2021 03:17AM
>Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, "Lv
>Yunlong" <lyl2019@mail.ustc.edu.cn>
>Subject: [EXTERNAL] [PATCH v2] rdma/siw: Fix a use after free in
>siw=5Falloc=5Fmr
>
>Our code analyzer reported a uaf.
>
>In siw=5Falloc=5Fmr, it calls siw=5Fmr=5Fadd=5Fmem(mr,..). In the
>implementation
>of siw=5Fmr=5Fadd=5Fmem(), mem is assigned to mr->mem and then mem is freed
>via kfree(mem) if xa=5Falloc=5Fcyclic() failed. Here, mr->mem still point
>to a freed object. After, the execution continue up to the err=5Fout
>branch
>of siw=5Falloc=5Fmr, and the freed mr->mem is used in
>siw=5Fmr=5Fdrop=5Fmem(mr).
>
>My patch moves "mr->mem =3D mem" behind the if (xa=5Falloc=5Fcyclic(..)<0)
>{}
>section, to avoid the uaf.
>
>Fixes: 2251334dcac9e ("rdma/siw: application buffer management")
>Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
>---
> drivers/infiniband/sw/siw/siw=5Fmem.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fmem.c
>b/drivers/infiniband/sw/siw/siw=5Fmem.c
>index 34a910cf0edb..96b38cfbb513 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fmem.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fmem.c
>@@ -106,8 +106,6 @@ int siw=5Fmr=5Fadd=5Fmem(struct siw=5Fmr *mr, struct
>ib=5Fpd *pd, void *mem=5Fobj,
> 	mem->perms =3D rights & IWARP=5FACCESS=5FMASK;
> 	kref=5Finit(&mem->ref);
>=20
>-	mr->mem =3D mem;
>-
> 	get=5Frandom=5Fbytes(&next, 4);
> 	next &=3D 0x00ffffff;
>=20
>@@ -116,6 +114,8 @@ int siw=5Fmr=5Fadd=5Fmem(struct siw=5Fmr *mr, struct
>ib=5Fpd *pd, void *mem=5Fobj,
> 		kfree(mem);
> 		return -ENOMEM;
> 	}
>+
>+	mr->mem =3D mem;
> 	/* Set the STag index part */
> 	mem->stag =3D id << 8;
> 	mr->base=5Fmr.lkey =3D mr->base=5Fmr.rkey =3D mem->stag;
>--=20
>2.25.1
>
>
>
Lv Yunlong, many thanks for catching, and thanks to
Leon for improving it.

Reviewed-by: Bernard Metzler <bmt@zurich.ihm.com>

