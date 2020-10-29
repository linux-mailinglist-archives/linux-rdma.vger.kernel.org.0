Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34429E3D7
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 08:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgJ2HVz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 03:21:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbgJ2HVy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Oct 2020 03:21:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09T72fqE183929
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 03:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=e9AbA2MOQSRGcZqh94Fj46yOVNsLm4Ozf3x+u+p2WDM=;
 b=WvA4Q/gDJdujVBNeli3KvBM8wokRFlYdllh9Cc6KezCz+TcFXBcuw2NTPVwmfcRu0UQU
 gbnmRRPmnBob4MYFBE0MVig4nwN2ktUw10tvrtvXX3dsX7z9p6F3GLBAKSL+uSA29NNG
 RSqXTLtEA7Ew0PZ1k3UF5Lw2s16aJ0gmttMLdi3BQ6OBJcD50TNWCd6if8vq4WtA7CFp
 QFH/+XavYiNSXMDAZfc8u06HPMuWdOYLOajfz1rOwcSEtDRCu7TgGubORKXIMvTITCBW
 493+NTiRv5vVMYcndhgA45e4pHxF8l2bWGH1PhjH+TcawI0VPFWrzhG+Nb8GzjKqsdi5 KQ== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34fd2e56tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 03:21:52 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 29 Oct 2020 07:21:51 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 29 Oct 2020 07:21:49 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2020102907214933-110631 ;
          Thu, 29 Oct 2020 07:21:49 +0000 
In-Reply-To: <20201028122509.47074-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] RDMA/siw: fix wrong judgment in siw_cm_work_handler
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Zhang Qilong" <zhangqilong3@huawei.com>
Cc:     <dledford@redhat.com>, <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>
Date:   Thu, 29 Oct 2020 07:21:49 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20201028122509.47074-1-zhangqilong3@huawei.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 48891
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 20102907-9463-0000-0000-000004852CE7
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00014097; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01456055; UDB=6.00783273; IPR=6.01238735;
 MB=3.00034754; MTD=3.00000008; XFM=3.00000015; UTC=2020-10-29 07:21:50
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-10-29 04:34:15 - 6.00012010
x-cbparentid: 20102907-9464-0000-0000-00005F39375D
Message-Id: <OF43CFF7BE.1D4C49D7-ON00258610.00287315-00258610.0028731D@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_01:2020-10-29,2020-10-29 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Zhang Qilong" <zhangqilong3@huawei.com> wrote: -----

>To: <bmt@zurich.ibm.com>, <dledford@redhat.com>, <jgg@ziepe.ca>
>From: "Zhang Qilong" <zhangqilong3@huawei.com>
>Date: 10/28/2020 10:44PM
>Cc: <linux-rdma@vger.kernel.org>
>Subject: [EXTERNAL] [PATCH] RDMA/siw: fix wrong judgment in
>siw=5Fcm=5Fwork=5Fhandler
>
>The rv cannot be 'EAGAIN' in the previous path, we
>should use '-EAGAIN' to check it. For example:
>
>Call trace:
>->siw=5Fcm=5Fwork=5Fhandler
>	->siw=5Fproc=5Fmpareq
>		->siw=5Frecv=5Fmpa=5Frr
>
>Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
>---
> drivers/infiniband/sw/siw/siw=5Fcm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fcm.c
>b/drivers/infiniband/sw/siw/siw=5Fcm.c
>index 66764f7ef072..1f9e15b71504 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fcm.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fcm.c
>@@ -1047,7 +1047,7 @@ static void siw=5Fcm=5Fwork=5Fhandler(struct
>work=5Fstruct *w)
> 					    cep->state);
> 			}
> 		}
>-		if (rv && rv !=3D EAGAIN)
>+		if (rv && rv !=3D -EAGAIN)
> 			release=5Fcep =3D 1;
> 		break;
>=20
>--=20
>2.17.1
>
>

Thanks Zhang, good catch!

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

