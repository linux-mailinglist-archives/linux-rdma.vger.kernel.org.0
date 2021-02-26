Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE84325FDF
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Feb 2021 10:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhBZJTw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Feb 2021 04:19:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230264AbhBZJR5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Feb 2021 04:17:57 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q93xrG146778
        for <linux-rdma@vger.kernel.org>; Fri, 26 Feb 2021 04:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : from : to
 : cc : date : mime-version : references : content-transfer-encoding :
 content-type : message-id : subject; s=pp1;
 bh=PotH5JG2MHJrOoczVTQTAqzpckFfWobxnwyEJO3Vjpk=;
 b=s41TMNVJ6kLaZ9KHcRK3pU+cUGC38FZMO+e2hPu8KJPdc7nka9dTew8ba138K5Zob8LX
 pHABIloUSzblVoQAkIYt6HeMSxg2RlWOVbxKqTDI9sYp1q6CrhElIC6ADXcrIMHQW3Y6
 4BnaNEKFNMCBTNQYZ45S51dM4lR88f9ywt6koMBFBO2e6DOy8UBzzjcQMLAgVO8gow4H
 vlNM+8dpJcxrDVrB4NFGYJMl4y7I4fPCiICBR8MZND0tzrLKkx++yWc7qpq/rTwf5Yt9
 FzwX5RuuD0YGySw9ViHM69LCDPyYCtdRE3HdcPEZUPxAq6dhEhYVBIjLnPUk4aUv+AFp eg== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.74])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36xvgy33n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 26 Feb 2021 04:17:10 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 26 Feb 2021 09:17:10 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.92) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 26 Feb 2021 09:17:08 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2021022609170854-204592 ;
          Fri, 26 Feb 2021 09:17:08 +0000 
In-Reply-To: <20210226075515.21371-1-dinghao.liu@zju.edu.cn>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Dinghao Liu" <dinghao.liu@zju.edu.cn>
Cc:     "kjlu" <kjlu@umn.edu>, "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "linux-rdma" <linux-rdma@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Feb 2021 09:17:07 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20210226075515.21371-1-dinghao.liu@zju.edu.cn>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-LLNOutbound: False
X-Disclaimed: 2983
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21022609-3165-0000-0000-000005880C6A
X-IBM-SpamModules-Scores: BY=0.05931; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.017918
X-IBM-SpamModules-Versions: BY=3.00014794; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01513339; UDB=6.00817410; IPR=6.01295862;
 MB=3.00036258; MTD=3.00000008; XFM=3.00000015; UTC=2021-02-26 09:17:09
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-02-26 08:29:56 - 6.00012332
x-cbparentid: 21022609-3166-0000-0000-0000CD7A0FDD
Message-Id: <OF56E5E5C1.78489712-ON00258688.0032E2EA-00258688.003301A1@notes.na.collabserv.com>
Subject: Re:  [PATCH] RDMA/siw: Fix missing check in siw_get_hdr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_02:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Dinghao Liu" <dinghao.liu@zju.edu.cn> wrote: -----

>To: dinghao.liu@zju.edu.cn, kjlu@umn.edu
>From: "Dinghao Liu" <dinghao.liu@zju.edu.cn>
>Date: 02/26/2021 08:56AM
>Cc: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] [PATCH] RDMA/siw: Fix missing check in
>siw=5Fget=5Fhdr
>
>We should also check the range of opcode after calling
>=5F=5Frdmap=5Fget=5Fopcode() in the else branch to prevent potential
>overflow.

Hi Dinghao,
No this is not needed. We always first read the minimum
header information (MPA len, DDP flags, RDMAP opcode,
STag, target offset). Only if we have received that
into local buffer, we check for the opcode this one time.
Now the opcode determines the remaining length of the
variably sized part of the header to be received.

We do not have to check the opcode again, since we
already received and checked it.

Best,
Bernard.

>
>Fixes: 8b6a361b8c482 ("rdma/siw: receive path")
>Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>---
> drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c
>b/drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c
>index 60116f20653c..301e7fe2c61a 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fqp=5Frx.c
>@@ -1072,6 +1072,16 @@ static int siw=5Fget=5Fhdr(struct siw=5Frx=5Fstream
>*srx)
> 		siw=5Fdbg=5Fqp(rx=5Fqp(srx), "new header, opcode %u\n", opcode);
> 	} else {
> 		opcode =3D =5F=5Frdmap=5Fget=5Fopcode(c=5Fhdr);
>+
>+		if (opcode > RDMAP=5FTERMINATE) {
>+			pr=5Fwarn("siw: received unknown packet type %u\n",
>+				opcode);
>+
>+			siw=5Finit=5Fterminate(rx=5Fqp(srx), TERM=5FERROR=5FLAYER=5FRDMAP,
>+					   RDMAP=5FETYPE=5FREMOTE=5FOPERATION,
>+					   RDMAP=5FECODE=5FOPCODE, 0);
>+			return -EINVAL;
>+		}
> 	}
> 	set=5Frx=5Ffpdu=5Fcontext(qp, opcode);
> 	frx =3D qp->rx=5Ffpdu;
>--=20
>2.17.1
>
>

