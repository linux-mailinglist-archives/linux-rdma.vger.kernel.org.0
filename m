Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9CE37A5C9
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 13:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhEKLcs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 07:32:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231273AbhEKLcq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 07:32:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BB3jqx043213
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=KhpYRtmyelazy8Eos0WodZ+IAoK3i3d4mYv90whYYVM=;
 b=pVL30N3WIK9q2Z3lN41KbGPDsUjk2ODo8OXt8gUMWIoEQ71bFBANoJ2/JNQq7M2R8uYZ
 6J9WaYuZYYIGVFGV82GUgKqXmgSIVTKNZI9H3/sS1ADAAzJaEi+mjHz1eyU2uXdUzKBK
 A4DzaJBDZq2w6PlwEKrHV4waQNr5Qbl+RlnO0dPwyR3knjyr4XNt6XGnN/Yw2PhZ0I1W
 oBf9GXHuEbPzzyXw966r+vIclgRa4P6bbYJ1rnnWd72HwRg1frDqAS/197aOuN45x6Nq
 +JGGe5HaJH3zUoALYDLeCDxn7o3ZR0heChmZkzbjYSI1iFvFleKGM4qDaPggYs+tlw3L UQ== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.113])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38frees7fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:31:40 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 11:31:39 -0000
Received: from us1b3-smtp03.a3dr.sjc01.isc4sb.com (10.122.7.173)
        by smtp.notes.na.collabserv.com (10.122.47.56) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 11:31:37 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp03.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021051111313601-322799 ;
          Tue, 11 May 2021 11:31:36 +0000 
In-Reply-To: <04384dc3dd5396ae770aebf5434810f489605c63.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 02/31] rdma/siw: call smp_mb() after mem->stag_valid = 0 in
 siw_invalidate_stag() too
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 11:31:36 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <04384dc3dd5396ae770aebf5434810f489605c63.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 5DFDFE2F:BA7CFD59-002586D2:003F5185;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 64959
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051111-7691-0000-0000-00000EC701CA
X-IBM-SpamModules-Scores: BY=0.060797; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000244
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00838382; IPR=6.01330255;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 11:31:38
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:35:41 - 6.00012377
x-cbparentid: 21051111-7692-0000-0000-00003017018E
Message-Id: <OF5DFDFE2F.BA7CFD59-ON002586D2.003F5185-002586D2.003F518B@notes.na.collabserv.com>
X-Proofpoint-GUID: I1yb5IXZvz46pm_JpX1Y_m6f3Tqr6zo5
X-Proofpoint-ORIG-GUID: I1yb5IXZvz46pm_JpX1Y_m6f3Tqr6zo5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Stefan Metzmacher" <metze@samba.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Stefan Metzmacher" <metze@samba.org>
>Date: 05/07/2021 01:37AM
>Cc: linux-rdma@vger.kernel.org, "Stefan Metzmacher" <metze@samba.org>
>Subject: [EXTERNAL] [PATCH 02/31] rdma/siw: call smp=5Fmb() after
>mem->stag=5Fvalid =3D 0 in siw=5Finvalidate=5Fstag() too
>
>We already do the same in siw=5Fmr=5Fdrop=5Fmem().
>
>Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fmem.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fmem.c
>b/drivers/infiniband/sw/siw/siw=5Fmem.c
>index 61c17db70d65..8596ce1ef5a3 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fmem.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fmem.c
>@@ -309,6 +309,8 @@ int siw=5Finvalidate=5Fstag(struct ib=5Fpd *pd, u32
>stag)
> 	 * state if invalidation is requested. So no state check here.
> 	 */
> 	mem->stag=5Fvalid =3D 0;
>+	/* make STag invalid visible asap */
>+	smp=5Fmb();
>=20
> 	siw=5Fdbg=5Fpd(pd, "STag 0x%08x now invalid\n", stag);
> out:
>--=20
>2.25.1
>
>
makes sense, thanks.

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

