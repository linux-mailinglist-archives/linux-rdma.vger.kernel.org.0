Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9088737A73D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhEKM7z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:59:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229921AbhEKM7z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:59:55 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BCXGfD146409
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=J6/Lrw1LGXxhnVVh5YHlnWEo4wWW8b4vLKxEN0rWKiE=;
 b=KURs+iijWObtyneL9Na8J7sFeibNvwid1HYrirI4v6HRKqXOxopPJ8CM/JP1oQc0Y12F
 xWJpBkp/UmUC/McCDBbnxjqJPnlgjgDw5T/W6nhOthvpKvpG3k9K0p/IbYDq5oXpBW9g
 Q7bLxH8ggdrnzqPJ40w/blF/3JajTQX0bAxyZ4/ZwHsIJyDebdSHUqIdVR2kbJ9KopTp
 Ii++VDVuOrr81M7o2okvTYul5knBakODYRil9XrGmArenQtwAfgcbyc5sOoFyEw2lL76
 IlUGUzPyLMNNCT3QKT8qPjfodDleWQc7cSZu/k0J+B3Ki3/OETy/aBjYiIy9WaLJIphQ 8g== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.90])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fsyw8rds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 08:58:49 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 11 May 2021 12:58:48 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.141) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 11 May 2021 12:58:47 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2021051112584678-373386 ;
          Tue, 11 May 2021 12:58:46 +0000 
In-Reply-To: <5f9dda492f0ff3ff0f858c9ee604f7ca8f179336.1620343860.git.metze@samba.org>
Subject: Re: [PATCH 25/31] rdma/siw: fix double siw_cep_put() in siw_cm_work_handler()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Stefan Metzmacher" <metze@samba.org>
Cc:     "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Tue, 11 May 2021 12:58:46 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <5f9dda492f0ff3ff0f858c9ee604f7ca8f179336.1620343860.git.metze@samba.org>,<cover.1620343860.git.metze@samba.org>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 47855
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051112-3649-0000-0000-0000058C1ECE
X-IBM-SpamModules-Scores: BY=0.063159; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.004469
X-IBM-SpamModules-Versions: BY=3.00015193; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01548293; UDB=6.00838381; IPR=6.01330255;
 MB=3.00036958; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-11 12:58:47
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 13:42:56 - 6.00012377
x-cbparentid: 21051112-3650-0000-0000-0000D0511F31
Message-Id: <OF7828508F.60D648D6-ON002586D2.00474C5D-002586D2.00474C64@notes.na.collabserv.com>
X-Proofpoint-ORIG-GUID: cpbdCLod6FZQrXcKZlHNN-Q4JAW4Sz9K
X-Proofpoint-GUID: cpbdCLod6FZQrXcKZlHNN-Q4JAW4Sz9K
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
>Subject: [EXTERNAL] [PATCH 25/31] rdma/siw: fix double siw=5Fcep=5Fput()
>in siw=5Fcm=5Fwork=5Fhandler()
>
>We never do an additional siw=5Fcep=5Fget(cep) when calling
>id->add=5Fref(id),
>there's no reason to call siw=5Fcep=5Fput(cep) when calling
>cep->cm=5Fid->rem=5Fref(cep->cm=5Fid)!
>
>I saw this happening quite often while testing my smbdirect driver
>and the peer already reseted the tcp connection.
>

Uhh...you got a WARN()?=20
Thanks!


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
>index 31135d877d41..a2a5a36370af 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1252,7 +1252,6 @@ static void siw=5Fcm=5Fwork=5Fhandler(struct
>work=5Fstruct *w)
> 		if (cep->cm=5Fid) {
> 			cep->cm=5Fid->rem=5Fref(cep->cm=5Fid);
> 			cep->cm=5Fid =3D NULL;
>-			siw=5Fcep=5Fput(cep);
> 		}
> 	}
> 	siw=5Fcep=5Fset=5Ffree(cep);
>--=20
>2.25.1
>
>

