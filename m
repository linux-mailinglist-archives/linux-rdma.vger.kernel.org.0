Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463EB37A5E9
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhEKLnn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 07:43:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230501AbhEKLnm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 07:43:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BBXlBH152116
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=+/M3ziS9rThbLlabp2j0Gsrf0bKSutWADW5DYdBAM+Y=;
 b=h+3rlEQrBs3Es1q8kt0UyOibdzD/nhQlnDAvn5N9V6p6sTKJpiMDrmnIdFxNnBlX4afb
 9YuBpI0y05WtYLWOOGyS+ECKtrqVDhy3Z+4QyMZibVnkmb+Pb+7x7TlGB/YadzED1p4P
 NHmQ2YKU1qInN+6dFNAYuAiu2Gn2yS/kspM0mP4NPpTZbVk8N+k+y/tEN+regWhB/qZ+
 Q5zgDkyiJtjnr7jw/pttAprK/INPC7THWK3AQUbYJCIa8s/+Cjbmc0yFxyW2yktcnMKy
 +XvdHAZ2WL+6W35kwoF7Isni4tFnJrEo/4YLEyMrIkMEvF4ekx/oeX/xbEhj5DjA8bew KA== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38freesfvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 07:42:36 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 11:42:35 -0000
Received: from us1b3-smtp05.a3dr.sjc01.isc4sb.com (10.122.203.183)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 11:42:33 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp05.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021051111423281-322812 ;
          Tue, 11 May 2021 11:42:32 +0000 
In-Reply-To: <3a85c3d589b8fd86193c871c84ae4c4e0a60bf4a.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 06/31] rdma/siw: make siw_cm_upcall() a noop without valid 'id'
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 11:42:32 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <3a85c3d589b8fd86193c871c84ae4c4e0a60bf4a.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: 4A2B95CE:9258E66F-002586D2:004051C4;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 33327
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051111-3017-0000-0000-0000048F08C7
X-IBM-SpamModules-Scores: BY=0.060427; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000021
X-IBM-SpamModules-Versions: BY=3.00015182; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00825223; IPR=6.01330096;
 MB=3.00036941; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 11:42:34
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 14:10:42 - 6.00012377
x-cbparentid: 21051111-3018-0000-0000-0000705208EF
Message-Id: <OF4A2B95CE.9258E66F-ON002586D2.004051C4-002586D2.004051CC@notes.na.collabserv.com>
X-Proofpoint-GUID: 0FRn2eDCC8K8ImqGaBQaT-Lcd7zIWyLP
X-Proofpoint-ORIG-GUID: 0FRn2eDCC8K8ImqGaBQaT-Lcd7zIWyLP
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
>Subject: [EXTERNAL] [PATCH 06/31] rdma/siw: make siw=5Fcm=5Fupcall() a
>noop without valid 'id'
>
>This will simplify the callers.
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index e21cde84306e..2cc2863bd427 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -324,6 +324,9 @@ static int siw=5Fcm=5Fupcall(struct siw=5Fcep *cep,
>enum iw=5Fcm=5Fevent=5Ftype reason,
> 	} else {
> 		id =3D cep->cm=5Fid;
> 	}
>+	if (id =3D=3D NULL)
How can this happen?

>+		return status;

better return 0 ?
>+
> 	/* Signal IRD and ORD */
> 	if (reason =3D=3D IW=5FCM=5FEVENT=5FESTABLISHED ||
> 	    reason =3D=3D IW=5FCM=5FEVENT=5FCONNECT=5FREPLY) {
>--=20
>2.25.1
>
>

