Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0063337A664
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhEKMRE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:17:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231519AbhEKMRE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:17:04 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BC32ZH105311
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=lHptgvKTu4fFSGYLUbCzN42rtg4BHEKAhKaEt22My7s=;
 b=SIstR8FilkWd2ra7R/bJq4YO5E7/UAnQHgMBD0E1ZBibTYBJFcfN/5OLe62bD20TAJs6
 SKiUKYr3cTyp5pxhTxm833WiQPiQHAvQQGQLRtooot02SbSL02sjBeeBDfUzO/ofV/Gy
 MVw2TOdIa4qH1/l9dsocOc8ddjQ1XTk3Y4KgJk1sLY4vfTO0h2xn8+XKB71tBRy3S6eM
 LxT+nqmb5yaXLwFptdx/7bxVWC8t2kPS3ky3fjo6xCQ8A3DP5XLXZx/2Al7ocOwEHD9d
 yOpe4ywT4L7Oj70PQ2eidKaBPEjY7j2OfdM4jntzR+0foBvQNIkO8GmiF1NYh9DchEsG JQ== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.66])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fq6yn4uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:15:57 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:15:57 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.127) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:15:54 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2021051112155408-372219 ;
          Tue, 11 May 2021 12:15:54 +0000 
In-Reply-To: <a382dd6f7560b1a311484c656216fcdb9de56ff6.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 15/31] rdma/siw: create a temporary copy of private data
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:15:53 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <a382dd6f7560b1a311484c656216fcdb9de56ff6.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 61671
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-4409-0000-0000-0000051F1544
X-IBM-SpamModules-Scores: BY=0.060929; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.002629
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00838383; IPR=6.01330255;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:15:55
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:49:15 - 6.00012377
x-cbparentid: 21051112-4410-0000-0000-0000A7FD156A
Message-Id: <OFE0F002D2.9EB6BAA4-ON002586D2.00432FD9-002586D2.00435F80@notes.na.collabserv.com>
X-Proofpoint-GUID: B1RLnaJi12ZIAtoAbb_6iG83oDylQGkA
X-Proofpoint-ORIG-GUID: B1RLnaJi12ZIAtoAbb_6iG83oDylQGkA
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
>Subject: [EXTERNAL] [PATCH 15/31] rdma/siw: create a temporary copy
>of private data
>
>The final patch will implement a non-blocking connect,
>which means that siw=5Fconnect() will be split into
>siw=5Fconnect() and siw=5Fconnected().
>
>kernel=5Fbindconnect() will be the last action
>in siw=5Fconnect(), while the MPA negotiation
>is deferred to siw=5Fconnected().
>

While it adds complexity, I really like the non-blocking
connect(). It would be much easier to review if a single
patch would introduce that on top of the previous work.

>We should not rely on the callers private data
>pointers to be still valid when siw=5Fconnected()
>is called, so we better create a copy.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 16 ++++++++++++++--
> 1 file changed, 14 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 027bc18cb801..41d3436985a6 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1519,13 +1519,25 @@ int siw=5Fconnect(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
> 	}
> 	memcpy(cep->mpa.hdr.key, MPA=5FKEY=5FREQ, 16);
>=20
>+	cep->mpa.pdata =3D kmemdup(params->private=5Fdata, pd=5Flen, GFP=5FKERNE=
L);
>+	if (IS=5FERR=5FOR=5FNULL(cep->mpa.pdata)) {
>+		rv =3D -ENOMEM;
>+		goto error;
>+	}
>+	cep->mpa.hdr.params.pd=5Flen =3D pd=5Flen;
>+
> 	cep->state =3D SIW=5FEPSTATE=5FAWAIT=5FMPAREP;
>=20
>-	rv =3D siw=5Fsend=5Fmpareqrep(cep, params->private=5Fdata, pd=5Flen);
>+	rv =3D siw=5Fsend=5Fmpareqrep(cep, cep->mpa.pdata,
>+				cep->mpa.hdr.params.pd=5Flen);
> 	/*
> 	 * Reset private data.
> 	 */
>-	cep->mpa.hdr.params.pd=5Flen =3D 0;
>+	if (cep->mpa.hdr.params.pd=5Flen) {
>+		cep->mpa.hdr.params.pd=5Flen =3D 0;
>+		kfree(cep->mpa.pdata);
>+		cep->mpa.pdata =3D NULL;
>+	}
>=20
> 	if (rv >=3D 0) {
> 		rv =3D siw=5Fcm=5Fqueue=5Fwork(cep, SIW=5FCM=5FWORK=5FMPATIMEOUT);
>--=20
>2.25.1
>
>

