Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99245B8C7
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Nov 2021 12:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbhKXLGk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Nov 2021 06:06:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241690AbhKXLGf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:35 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOAkSrb001197;
        Wed, 24 Nov 2021 11:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=in-reply-to : subject :
 from : to : cc : date : message-id : content-transfer-encoding :
 content-type : mime-version : references; s=pp1;
 bh=Qhupj6R5q1SzdOmJ14/su+z56EatbC97bsuf59WW2zU=;
 b=NsKQAXHcvyUHxji1Pv8n7HnkD0M0K+f7Ml6grTdQY3dEc7YexLmV0cUbIIhY+756Zxpe
 4CerrQZx+p38ox4XYH/co5L/FvO4GhavNl3Oy0wSNqshyXw8GAoR5ye9CxvbYWbIsXH8
 wbSqjLtBDsammhG8NuJjNrSlHhQclFj5CLX81SJbc/FQCMP6vYCLR1/k3EPlM9OObqHj
 NUiNDXkD/hRsgxr0YZKxY5aTDJ1qB6exk/5OATfOBs1hWPghroPQAkc3FrNI81JOZxnz
 oO6AIVZl8d4RUWS9csibJPmZaM63gKSqq1HXraFnwqfUwS/P7rZpv7XnNdWAHxep+mud xA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3chkxggb51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 11:03:25 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AOB2ubu012718;
        Wed, 24 Nov 2021 11:03:24 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3cggnfu92k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 11:03:24 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AOB3L2s54460814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 11:03:21 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC478112062;
        Wed, 24 Nov 2021 11:03:21 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E7B0112064;
        Wed, 24 Nov 2021 11:03:21 +0000 (GMT)
Received: from mww0301.wdc07m.mail.ibm.com (unknown [9.208.64.45])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Nov 2021 11:03:21 +0000 (GMT)
In-Reply-To: <20211124102336.427637-1-kamalheib1@gmail.com>
Subject: Re:[PATCH for-next] RDMA/siw: Use helper function to set sys_image_guid
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Kamal Heib" <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, "Jason Gunthorpe" <jgg@ziepe.ca>
Date:   Wed, 24 Nov 2021 11:03:19 +0000
Message-ID: <OF68D6939C.29A969ED-ON00258797.003C2DE4-00258797.003CBA99@ibm.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20211124102336.427637-1-kamalheib1@gmail.com>
X-Mailer: Lotus Domino Web Server Release 11.0.1FP2HF117   October 6, 2021
X-MIMETrack: Serialize by http on MWW0301/01/M/IBM at 11/24/2021 11:03:19,Serialize
 complete at 11/24/2021 11:03:19
X-Disclaimed: 17183
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D6LEGPr_UcmO5-D1bVZoq84rJc7CfVVi
X-Proofpoint-GUID: D6LEGPr_UcmO5-D1bVZoq84rJc7CfVVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_04,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240062
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Kamal Heib" <kamalheib1@gmail.com> wrote: -----

>To: linux-rdma@vger.kernel.org
>From: "Kamal Heib" <kamalheib1@gmail.com>
>Date: 11/24/2021 11:24AM
>Cc: "Bernard Metzler" <bmt@zurich.ibm.com>, "Jason Gunthorpe"
><jgg@ziepe.ca>, "Kamal Heib" <kamalheib1@gmail.com>
>Subject: [EXTERNAL] [PATCH for-next] RDMA/siw: Use helper function to
>set sys=5Fimage=5Fguid
>
>Use the addrconf=5Faddr=5Feui48() helper function to set the
>sys=5Fimage=5Fguid,
>Also make sure the GUID is valid EUI-64 identifier.
>
>Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
>---
> drivers/infiniband/sw/siw/siw=5Fverbs.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw=5Fverbs.c
>b/drivers/infiniband/sw/siw/siw=5Fverbs.c
>index 1b36350601fa..d15a1f9c59f0 100644
>--- a/drivers/infiniband/sw/siw/siw=5Fverbs.c
>+++ b/drivers/infiniband/sw/siw/siw=5Fverbs.c
>@@ -8,6 +8,7 @@
> #include <linux/uaccess.h>
> #include <linux/vmalloc.h>
> #include <linux/xarray.h>
>+#include <net/addrconf.h>
>=20
> #include <rdma/iw=5Fcm.h>
> #include <rdma/ib=5Fverbs.h>
>@@ -155,7 +156,8 @@ int siw=5Fquery=5Fdevice(struct ib=5Fdevice *base=5Fde=
v,
>struct ib=5Fdevice=5Fattr *attr,
> 	attr->vendor=5Fid =3D SIW=5FVENDOR=5FID;
> 	attr->vendor=5Fpart=5Fid =3D sdev->vendor=5Fpart=5Fid;
>=20
>-	memcpy(&attr->sys=5Fimage=5Fguid, sdev->netdev->dev=5Faddr, 6);
>+	addrconf=5Faddr=5Feui48((u8 *)&attr->sys=5Fimage=5Fguid,
>+			    sdev->netdev->dev=5Faddr);
>=20
> 	return 0;
> }
>--=20
>2.31.1
>
>

Thanks, Kamal!

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>

