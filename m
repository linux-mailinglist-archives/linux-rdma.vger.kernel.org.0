Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F72C37A63A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhEKME7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:04:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230225AbhEKME7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:04:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BC2fDC030677
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=/GhrQ7LLOWi2ZlQyRag1v7TIW4KEBTmhJoK5pC6BwWU=;
 b=idmJlWOUbNlRRDAfh+/UWMd4ZHFDL/fsjEEzOg3bgSn65EmgVa3VI01oGnIxEZkj89+F
 0GYsbE1gVRN4A9xWwDAXA3qI24D0Ta/AY5gRjXd04QQZ9dJwaL8K7XLJAQZI4XaDRVJi
 GqfAIBhF6sZD8v8Lo4WoyE6eghCfWvPx8u5UFL+TnkS7AT++JuITk8e49pLdB9ABcL4N
 KYGZoSTfJ9TRKuiZYXF4J2yMmSc6+1abEvQZp2/8/bNAYERmwUO9x8elHCefxSVeAZac
 f4oaDF3+JHS3HlHPq3E3jTmDl+oo9vlTw8ReD7DXRSPmQdeCSiAtxP/elZp/OjZ1Tl5g 9w== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38fmxx0c15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:03:51 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:03:51 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:03:50 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2021051112035015-342858 ;
          Tue, 11 May 2021 12:03:50 +0000 
In-Reply-To: <b6d45ce73a6d67748723175b2e2a3cbedf2efe57.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 11/31] rdma/siw: introduce SIW_EPSTATE_ACCEPTING/REJECTING for
 rdma_accept/rdma_reject
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:03:49 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <b6d45ce73a6d67748723175b2e2a3cbedf2efe57.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 25091
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-8877-0000-0000-00000602154D
X-IBM-SpamModules-Scores: BY=0.057299; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000004
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548292; UDB=6.00838382; IPR=6.01330253;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:03:50
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-25 10:42:53 - 6.00012377
x-cbparentid: 21051112-8878-0000-0000-0000F6251579
Message-Id: <OF76ED18BF.27B9E5AA-ON002586D2.004244CE-002586D2.004244D4@notes.na.collabserv.com>
X-Proofpoint-GUID: 7FqLNMxwFOm4ucz8LJfFw6CcuycyaOZZ
X-Proofpoint-ORIG-GUID: 7FqLNMxwFOm4ucz8LJfFw6CcuycyaOZZ
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
>Subject: [EXTERNAL] [PATCH 11/31] rdma/siw: introduce
>SIW=5FEPSTATE=5FACCEPTING/REJECTING for rdma=5Faccept/rdma=5Freject
>
>When we received the MPA Request, we set SIW=5FEPSTATE=5FRECVD=5FMPAREQ
>and port IW=5FCM=5FEVENT=5FCONNECT=5FREQUEST to the IWCM layer.
>
>In that state we expect the caller to reacted with rdma=5Faccept() or
>rdma=5Freject(), which will turn the connection into
>SIW=5FEPSTATE=5FRDMA=5FMODE
>or SIW=5FEPSTATE=5FCLOSED finally.
>
>I think it much saner that rdma=5Faccept and rdma=5Freject change the
>state
>instead of keeping it as SIW=5FEPSTATE=5FRECVD=5FMPAREQ in order to make
>the logic more understandable and allow more useful debug messages.
>
>In all cases we need to inform the IWCM layer about that error!
>As it only allows IW=5FCM=5FEVENT=5FESTABLISHED to be posted after
>IW=5FCM=5FEVENT=5FCONNECT=5FREQUEST was posted, we need to go through
>IW=5FCM=5FEVENT=5FESTABLISHED via IW=5FCM=5FEVENT=5FDISCONNECT to
>IW=5FCM=5FEVENT=5FCLOSE.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 31
>++++++++++++++++++++++++++++--
> drivers/infiniband/sw/siw/siw=5Fcm.h |  2 ++
> 2 files changed, 31 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index d03c7a66c6d1..3cc1d22fe232 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -146,10 +146,35 @@ static void =5F=5Fsiw=5Fcep=5Fterminate=5Fupcall(str=
uct
>siw=5Fcep *cep,
>=20
> 	case SIW=5FEPSTATE=5FRECVD=5FMPAREQ:
> 		/*
>-		 * Wait for the ulp/CM to call accept/reject
>+		 * Waited for the ulp/CM to call accept/reject
> 		 */
>-		siw=5Fdbg=5Fcep(cep, "mpa req recvd, wait for ULP\n");
> 		WARN(!suspended, "SIW=5FEPSTATE=5FRECVD=5FMPAREQ called without
>suspended\n");
Please remove all that WARN(!suspended, ..)

>+		siw=5Fdbg=5Fcep(cep, "mpa req recvd, post
>established/disconnect/close\n");
>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FESTABLISHED, 0);
>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FDISCONNECT, 0);
>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCLOSE, 0);
>+		break;
>+
>+	case SIW=5FEPSTATE=5FACCEPTING:
>+		/*
>+		 * We failed during the rdma=5Faccept/siw=5Faccept handling
>+		 */
>+		WARN(!suspended, "SIW=5FEPSTATE=5FACCEPTING called without
>suspended\n");
>+		siw=5Fdbg=5Fcep(cep, "accepting, post
>established/disconnect/close\n");
>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FESTABLISHED, 0);
>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FDISCONNECT, 0);
>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCLOSE, 0);
>+		break;
>+
>+	case SIW=5FEPSTATE=5FREJECTING:
>+		/*
>+		 * We failed during the rdma=5Freject/siw=5Freject handling
>+		 */
>+		WARN(!suspended, "SIW=5FEPSTATE=5FREJECTING called without
>suspended\n");
>+		siw=5Fdbg=5Fcep(cep, "rejecting, post
>established/disconnect/close\n");
>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FESTABLISHED, 0);
>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FDISCONNECT, 0);
>+		siw=5Fcm=5Fupcall(cep, IW=5FCM=5FEVENT=5FCLOSE, 0);
> 		break;
>=20
> 	case SIW=5FEPSTATE=5FAWAIT=5FMPAREQ:
>@@ -1563,6 +1588,7 @@ int siw=5Faccept(struct iw=5Fcm=5Fid *id, struct
>iw=5Fcm=5Fconn=5Fparam *params)
>=20
> 		return -ECONNRESET;
> 	}
>+	cep->state =3D SIW=5FEPSTATE=5FACCEPTING;
> 	qp =3D siw=5Fqp=5Fid2obj(sdev, params->qpn);
> 	if (!qp) {
> 		WARN(1, "[QP %d] does not exist\n", params->qpn);
>@@ -1743,6 +1769,7 @@ int siw=5Freject(struct iw=5Fcm=5Fid *id, const void
>*pdata, u8 pd=5Flen)
> 	}
> 	siw=5Fdbg=5Fcep(cep, "cep->state %d, pd=5Flen %d\n", cep->state,
> 		    pd=5Flen);
>+	cep->state =3D SIW=5FEPSTATE=5FREJECTING;
>=20
> 	if (=5F=5Fmpa=5Frr=5Frevision(cep->mpa.hdr.params.bits) >=3D MPA=5FREVIS=
ION=5F1)
>{
> 		cep->mpa.hdr.params.bits |=3D MPA=5FRR=5FFLAG=5FREJECT; /* reject */
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.h
>b/drivers/infiniband/sw/siw/siw=5Fcm.h
>index 8c59cb3e2868..4f6219bd746b 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.h
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.h
>@@ -20,6 +20,8 @@ enum siw=5Fcep=5Fstate {
> 	SIW=5FEPSTATE=5FAWAIT=5FMPAREQ,
> 	SIW=5FEPSTATE=5FRECVD=5FMPAREQ,
> 	SIW=5FEPSTATE=5FAWAIT=5FMPAREP,
>+	SIW=5FEPSTATE=5FACCEPTING,
>+	SIW=5FEPSTATE=5FREJECTING,
> 	SIW=5FEPSTATE=5FRDMA=5FMODE,
> 	SIW=5FEPSTATE=5FCLOSED
> };
>--=20
>2.25.1
>
>

