Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E966437A6F5
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhEKMnQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:43:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbhEKMnQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:43:16 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BCXwnT000810
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=Epk2hrAUZ9grKY9PimZUrjsDtTSSYzMfAWZ1HR4sENI=;
 b=n0b2Q78P/uqIUb5helurB+6J6cttUS7qk7UCIQGvvfoH9jHDX/NMYXd3aJPjpGsJlv7w
 WODYco3sxGH90VibxJ+bIEvHH4CGPJjeKKzHM8d92z/uM/lxaHi3b5PzCvIOEID12RQO
 r3KT35SGBQweRIOuJHcirO37TDE+7zPG3qoA8tdTzBxpBUpHQUNaBr+IdK42wDxcUSP/
 Mk+Cz82qpoLu1rux2FSR5znpI6G58ytW3edICsMAT0IX6QTRMN8EYq9xoZ3q3ln8lVdY
 gjXypxk6Adhm3+PxIjHO2pfsiwngvcTQTot1Lcp1e3RtGtJIjBrvfKs5yM4qlM8Jx2Bn 8w== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fsugrjyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:42:09 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:42:08 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:42:07 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2021051112420753-352223 ;
          Tue, 11 May 2021 12:42:07 +0000 
In-Reply-To: <33abff2233b36a51e468d691cb4327d0294d2734.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 22/31] rdma/siw: let siw_listen_address() call siw_cep_set_inuse()
 early
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:42:07 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <33abff2233b36a51e468d691cb4327d0294d2734.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 14135
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-2475-0000-0000-0000112E1C38
X-IBM-SpamModules-Scores: BY=0.2642; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0; SC=0;
 ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00015182; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01546696; UDB=6.00825223; IPR=6.01308321;
 MB=3.00036941; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:42:08
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 14:28:52 - 6.00012377
x-cbparentid: 21051112-2476-0000-0000-0000DD031CB2
Message-Id: <OFF4E3D691.BA740A43-ON002586D2.0045C64B-002586D2.0045C652@notes.na.collabserv.com>
X-Proofpoint-GUID: Y-fYCtIF7bDH0Mr_6gRSQmt4U5cPTkMc
X-Proofpoint-ORIG-GUID: Y-fYCtIF7bDH0Mr_6gRSQmt4U5cPTkMc
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
>Subject: [EXTERNAL] [PATCH 22/31] rdma/siw: let siw=5Flisten=5Faddress()
>call siw=5Fcep=5Fset=5Finuse() early
>
>We should protect the whole section after siw=5Fcep=5Falloc().
>
>Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>Signed-off-by: Stefan Metzmacher <metze@samba.org>
>Cc: Bernard Metzler <bmt@zurich.ibm.com>
>Cc: linux-rdma@vger.kernel.org
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index fe6f7bb4d615..09ae7f7ca82a 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1920,6 +1920,8 @@ int siw=5Fcreate=5Flisten(struct iw=5Fcm=5Fid *id, i=
nt
>backlog)
> 	if (!cep)
> 		return -ENOMEM;
>=20
>+	siw=5Fcep=5Fset=5Finuse(cep);
>+
> 	rv =3D sock=5Fcreate(addr=5Ffamily, SOCK=5FSTREAM, IPPROTO=5FTCP, &s);
> 	if (rv < 0) {
> 		siw=5Fdbg(id->device, "sock=5Fcreate error: %d\n", rv);
>@@ -2014,13 +2016,12 @@ int siw=5Fcreate=5Flisten(struct iw=5Fcm=5Fid *id,
>int backlog)
>=20
> 	siw=5Fdbg(id->device, "Listen at laddr %pISp\n", &id->local=5Faddr);
>=20
>+	siw=5Fcep=5Fset=5Ffree(cep);
> 	return 0;
>=20
> error:
> 	siw=5Fdbg(id->device, "failed: %d\n", rv);
>=20
>-	siw=5Fcep=5Fset=5Finuse(cep);
>-
> 	if (cep->cm=5Fid) {
> 		cep->cm=5Fid->rem=5Fref(cep->cm=5Fid);
> 		cep->cm=5Fid =3D NULL;
>--=20
>2.25.1
>
>
Agreed, makes it easier to read.

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

