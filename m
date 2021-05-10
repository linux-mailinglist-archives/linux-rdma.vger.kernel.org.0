Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACC1377E17
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEJI0r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 04:26:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230118AbhEJI0p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 04:26:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14A8E6RY065806
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 04:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : mime-version : references :
 content-transfer-encoding : content-type : message-id; s=pp1;
 bh=M4nbHpNduBbkXCBtSRwSgHEfT5WV3iEJzRsV73/7kIo=;
 b=cr7TxUK3b3Okdfu5SrGYCd8QuT/tT4t0DZxzLUYt8FkcifrEbZpSqDzzR6h06+SDS9/b
 m7oNqVFEVTaZVa4iwmVcf4ZQOXcTi6zTrZYt9VXmPyXMfdQF7XCRMPLBWN/MNOILJVKd
 VuwYg8lUsmBRzPIoxgDs7fwJwn+HrsXpWLn8MdhhzUvtTxG9GjVMGytXX7ogNp8VW4X6
 J33bgAJYDQCRWINPc9ssgRa7erHsG1t5DHawg8G1LLiTWUNUc/Gn8dJay5efTEAr7wOV
 ndj++P2glx4DaKUbRHDicUJav6F+IpDaauMyPSuIMjrL2n7mK0WnPNzW3PHI9ViqOvl2 8A== 
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38f14tg8q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 04:25:31 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 10 May 2021 08:25:30 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 10 May 2021 08:25:28 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2021051008252792-166522 ;
          Mon, 10 May 2021 08:25:27 +0000 
In-Reply-To: <f070b59d5a1114d5a4e830346755c2b3f141cde5.1620560472.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/siw: Release xarray entry
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "Leon Romanovsky" <leonro@nvidia.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-rdma" <linux-rdma@vger.kernel.org>
Date:   Mon, 10 May 2021 08:25:27 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <f070b59d5a1114d5a4e830346755c2b3f141cde5.1620560472.git.leonro@nvidia.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP130 January 13, 2021 at 14:04
X-KeepSent: CA0BD73F:A7CD6605-002586D1:002E4672;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 9127
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
x-cbid: 21051008-3017-0000-0000-0000048D3D9B
X-IBM-SpamModules-Scores: BY=0.059455; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0; ST=0; TS=0; UL=0; ISC=; MB=0.000180
X-IBM-SpamModules-Versions: BY=3.00015182; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000296; SDB=6.01546296; UDB=6.00825223; IPR=6.01329096;
 MB=3.00036941; MTD=3.00000008; XFM=3.00000015; UTC=2021-05-10 08:25:29
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2021-03-22 14:10:42 - 6.00012377
x-cbparentid: 21051008-3018-0000-0000-0000704E4D33
Message-Id: <OFCA0BD73F.A7CD6605-ON002586D1.002E4672-002586D1.002E467F@notes.na.collabserv.com>
X-Proofpoint-ORIG-GUID: G1WP_r9UYngM2XL963QRVbPAR0rDNa_i
X-Proofpoint-GUID: G1WP_r9UYngM2XL963QRVbPAR0rDNa_i
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_02:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Doug Ledford" <dledford@redhat.com>, "Jason Gunthorpe"
><jgg@nvidia.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 05/09/2021 01:41PM
>Cc: "Leon Romanovsky" <leonro@nvidia.com>, "Bernard Metzler"
><bmt@zurich.ibm.com>, linux-kernel@vger.kernel.org,
>linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] [PATCH rdma-rc] RDMA/siw: Release xarray entry
>
>From: Leon Romanovsky <leonro@nvidia.com>
>
>The xarray entry is allocated in siw=5Fqp=5Fadd(), but release was
>missed in case zero-sized SQ was discovered.
>
>Fixes: 661f385961f0 ("RDMA/siw: Fix handling of zero-sized Read and
>Receive Queues.")
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---
> drivers/infiniband/sw/siw/siw=5Fverbs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fverbs.c
>b/drivers/infiniband/sw/siw/siw=5Fverbs.c
>index 917c8a919f38..3f175f220a22 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fverbs.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fverbs.c
>@@ -375,7 +375,7 @@ struct ib=5Fqp *siw=5Fcreate=5Fqp(struct ib=5Fpd *pd,
> 	else {
> 		/* Zero sized SQ is not supported */
> 		rv =3D -EINVAL;
>-		goto err=5Fout;
>+		goto err=5Fout=5Fxa;
> 	}
> 	if (num=5Frqe)
> 		num=5Frqe =3D roundup=5Fpow=5Fof=5Ftwo(num=5Frqe);
>--=20
>2.31.1
>
>
Thanks Leon!

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

