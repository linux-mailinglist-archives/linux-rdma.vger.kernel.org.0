Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FF3466312
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Dec 2021 13:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbhLBMKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 07:10:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241798AbhLBMKm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 07:10:42 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2BUMGo019468;
        Thu, 2 Dec 2021 12:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : content-transfer-encoding :
 content-type : mime-version : references; s=pp1;
 bh=/cBpo1bPMw63YrNeQlOUwy+lPR+yqdHCJnTgUl87cKU=;
 b=JayXMBriBQeYIqa3l0VC+nx/B7Nhlx8a658sRwL67A7zdXutgLqGadPZNXtB9AWuSF5p
 yIH7OWJzL8LTK/PCXhYHIwHcym97CwllbEXww10cinRDizCWt+t+0fegQzvh6FfdItA4
 r8YmUhznX9EU4ukYckG6B76P7GTxNCZYloJfEcK9dZEo0ul5KifHMJGDvqH8heQ559Gn
 I91lurcObTqxZlAB6X0UzKGGE/XbwqLW6Q74DyThMrSDKNyFxx83u4PpJ0ZM0HzL9L3W
 /LEeaz8MmmBPbW+BPhCn/jvc8sqIXU1LCBn3Ug1TBbu5Ww64mxoYzdVddGzp8kHRZ7zD GA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cpuct39e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 12:07:18 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2BvPVG016705;
        Thu, 2 Dec 2021 12:07:17 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3cnne3239r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 12:07:17 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2C7GpZ29229398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 12:07:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 891F3B205F;
        Thu,  2 Dec 2021 12:07:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 633CBB2064;
        Thu,  2 Dec 2021 12:07:16 +0000 (GMT)
Received: from mww0301.wdc07m.mail.ibm.com (unknown [9.208.64.45])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Dec 2021 12:07:16 +0000 (GMT)
In-Reply-To: <1638439679-114250-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] RDMA/siw: Use max() instead of doing it manually
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jiapeng Chong" <jiapeng.chong@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 2 Dec 2021 12:07:14 +0000
Message-ID: <OF03100A62.8FDD44EE-ON0025879F.00427DFD-0025879F.004294C9@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <1638439679-114250-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF117   October 6, 2021
X-MIMETrack: Serialize by http on MWW0301/01/M/IBM at 12/02/2021 12:07:14,Serialize
 complete at 12/02/2021 12:07:14
X-Disclaimed: 40247
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2LA_gj7mIzdW-mbDsZFU95nwPTRQWTSY
X-Proofpoint-ORIG-GUID: 2LA_gj7mIzdW-mbDsZFU95nwPTRQWTSY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-12-02_07,2021-12-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112020077
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jiapeng Chong" <jiapeng.chong@linux.alibaba.com> wrote: -----

>To: bmt@zurich.ibm.com
>From: "Jiapeng Chong" <jiapeng.chong@linux.alibaba.com>
>Date: 12/02/2021 11:08AM
>Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
>linux-kernel@vger.kernel.org, "Jiapeng Chong"
><jiapeng.chong@linux.alibaba.com>
>Subject: [EXTERNAL] [PATCH] RDMA/siw: Use max() instead of doing it
>manually
>
>Fix following coccicheck warning:
>
>./drivers/infiniband/sw/siw/siw=5Fverbs.c:665:28-29: WARNING
>opportunity
>for max().
>
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>---
> drivers/infiniband/sw/siw/siw=5Fverbs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fverbs.c
>b/drivers/infiniband/sw/siw/siw=5Fverbs.c
>index d15a1f9..a3dd2cb 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fverbs.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fverbs.c
>@@ -662,7 +662,7 @@ static int siw=5Fcopy=5Finline=5Fsgl(const struct
>ib=5Fsend=5Fwr *core=5Fwr,
> 		kbuf +=3D core=5Fsge->length;
> 		core=5Fsge++;
> 	}
>-	sqe->sge[0].length =3D bytes > 0 ? bytes : 0;
>+	sqe->sge[0].length =3D max(bytes, 0);
> 	sqe->num=5Fsge =3D bytes > 0 ? 1 : 0;
>=20
> 	return bytes;
>--=20
>1.8.3.1
>
>
Looks good, thanks!

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
