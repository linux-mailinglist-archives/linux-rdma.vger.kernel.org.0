Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1A5345FFB
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 14:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhCWNnP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 09:43:15 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35250 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhCWNms (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Mar 2021 09:42:48 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NDeK3R162349;
        Tue, 23 Mar 2021 13:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hrMMZ76xmzIQF9ErDtghwgH4VXWLAZYPlUYcvYT89dI=;
 b=Jbyu+Oy7RlP4Gghr82Xd3ssHLnHdcptu3awaDtG3Juf+eUqoJ2+Ri7BH4+fMJ94XWqmb
 XA8QCuEK+Hy4bF57HB1Y/AHB8RfqYxusBAhhNiUmkzs3mVuE2n1YcoduNH9pUeuDevNF
 oYJaEViuCwSe+7/PNQ9U2VAr6XInRJabT78TZYwGFSlihOiu1s93e7xqvfg94F+DjZWk
 YJl44XeV7p9iEkn3nUYYxM70wJHNJPluq2qfdEcUq4nzPcz60mrA4ZLBZJcO4QcExH6S
 Phj5aM/vvBHndGPmpEQ0taP+EpRKxm0e2vjoyja3lrG9cyoy+9oX2N+JbBN7F5QaE3Le cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37d6jbf4uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 13:42:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NDePsu171439;
        Tue, 23 Mar 2021 13:42:44 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        by aserp3020.oracle.com with ESMTP id 37dtxy8qy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 13:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npJFCDMaTab6UBR0C3t9c1M/palxRJBRbNOj2WvHkx2DbJCtfa5d+A6OzDC7UqtU8omx8RrPnjO/KX1Gtmz6l8hKHLspMmEs7SGfg5XrRi+CM5iF/XbwD9lCdaHR3tPru5wuxRt3Ln1asGNKrRfdifs87PFWEyCSY6qGOg1YFZSkiOCdXWFHJ2iOUZ8GcRcP/UA9LQ8qGmkb5PdAy4FFPkULKMjfK7jv+ehPWUyFzwxxZVYX5TQSTNzDMRQuyF7q10OYJU5fVTbr1sERlNWs748aqNivoT72JspaRamo8Nf2ndIvBWAeqrEM5Np/2Qh+/l7o1xBwEeAeQKy9GEDu/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrMMZ76xmzIQF9ErDtghwgH4VXWLAZYPlUYcvYT89dI=;
 b=TscIqoocAE2qCxu65G81xbCeN5MVDbNT/BbkrH81eKpOEIgnmo0I9Vl1J+4LhECPuvXhUn1bA30+QNgCgaWDaSB+OBWTDwWelLEbPjQ0AjI62tL6AHIIScMLgVo68u4KlnpyiYuVF2GczNeXmnxxoFntZIcjDvay95gGI1ivhcujgtr1r3MY30JZODrsLJHPSJOsqZ5KiEgHqIrwZ5WmbRSe/HdWseBnX6tJWcKkq0eMze7pkRc+m2DqL6IdTdFlNUzX391HBL95WG1M1ZslLHo1wubC1nUKCw0M+RmBxo1g0BqpimMEA/CrQpEMaa3HiaWSPVktIc6kKqNG121ZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrMMZ76xmzIQF9ErDtghwgH4VXWLAZYPlUYcvYT89dI=;
 b=OGMLjGalfNJRQhZMuhYWql8olfAl6fNZZ2frfjIFzWBA1fp4przZ3GLtPvO6HoaCU3XDbaSAMfjfEEHA6Tz7XLZFZi+LHHPTpIyUNSzwt9QKMKYHUooKLKpHEMNl1gR0N6J0miFB90hxnitCjc3bwVc64/aLY0GlOwgz3xHC84A=
Received: from CY4PR10MB1448.namprd10.prod.outlook.com (2603:10b6:903:27::12)
 by CY4PR10MB1239.namprd10.prod.outlook.com (2603:10b6:910:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Tue, 23 Mar
 2021 13:42:42 +0000
Received: from CY4PR10MB1448.namprd10.prod.outlook.com
 ([fe80::14d0:f061:b858:4c1]) by CY4PR10MB1448.namprd10.prod.outlook.com
 ([fe80::14d0:f061:b858:4c1%7]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 13:42:41 +0000
From:   Praveen Kannoju <praveen.kannoju@oracle.com>
To:     Praveen Kannoju <praveen.kannoju@oracle.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Jeffery Yoder <jeffery.yoder@oracle.com>
Subject: RE: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Thread-Topic: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Thread-Index: AQHXGmWJp8i+xPdCxUaGXGoNHWnqKKqRnxOA
Date:   Tue, 23 Mar 2021 13:42:41 +0000
Message-ID: <CY4PR10MB14483428B986BAF6CC6B89118C649@CY4PR10MB1448.namprd10.prod.outlook.com>
References: <1615900141-14012-1-git-send-email-praveen.kannoju@oracle.com>
In-Reply-To: <1615900141-14012-1-git-send-email-praveen.kannoju@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [103.203.175.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6029229-2d3a-408d-2dd4-08d8ee018827
x-ms-traffictypediagnostic: CY4PR10MB1239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB12396A4983836399D3F30EE48C649@CY4PR10MB1239.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: joKc6kWQeKQueN5Yfs5R86mw1F30n56vIKM7dUqS8K/HFYlskki77bdOrRaU3kxEvaU6V+fCrI6RQyDcxbcff0jrIFlj5sUyF2wbEMmbBofklQlexL7NbAh27axLkWNZ4+MpRuUE1DmwG33EUsJNU2L/qXlRtQG9RjlGgsk1ZFgY05RpuX0uq+RYafLqbJFoZpDHk52lYT4NYfLW2q78o1DkV/Jtuavmc+Aih6o5h+MNJy6RkG83a/3ZaV0JPaYUk2wWmomhsl2c15bv1IWs6dI1bUQfTDSz/EwwUg3bzlYAhU6pubXEahECBYYZLZARHeX/B0VP3SF2r2I/FYgTztKTWAhIsz7JydbtPNoSMQ+dM6CmCK16Yj2etVOgcgZ6CjE5hdIAg0fxolO0ag+XBs+3wTTuDKwmymHUqkYmOyqEQy8oRezl0XSksMJ8YjbKFgULAobyFd5bE3bkphLewhWSfmExcToRJWhpTcmgda+KKS0LCy4nsNOOfEZO+LZjtwfgl6ACQuBC0WdwHaTmOdOiye7t1FWoSZfwoSTZsOqQR8gKGDFK9GJiQCelbyfGFPkPpAMxLLrv7YnIv1FeKmy0GlYQUKdrkmBmz7I58/8MD1an3CH84bbv6JF6S/nsqdEIkPyV3VaqHdycONGo57T1I7EWHR2GJ+QO0fC/x40=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1448.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(136003)(396003)(376002)(86362001)(8936002)(478600001)(15650500001)(53546011)(186003)(54906003)(7696005)(26005)(33656002)(110136005)(8676002)(6506007)(316002)(2906002)(107886003)(66556008)(83380400001)(71200400001)(44832011)(4326008)(52536014)(38100700001)(66476007)(5660300002)(66446008)(9686003)(76116006)(55016002)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2osLUIWK2SXFQM6SOgSsgwN8Jrmr/Nl7Cwv3lYqi6p2VBUTsP3F3sxBvlPmc?=
 =?us-ascii?Q?gYySKin3TtQla7EMpH7MPgRFxZmreHAe00Cb8agI4DiQBSL9jUv6hyroKl5u?=
 =?us-ascii?Q?anJb/ECw9+6AgqrvZ6inUP6f9UAdFTWJn0yagB5Jx1sVKNVsTX46RjOEl39R?=
 =?us-ascii?Q?+RKIHg12U+LQ1bu6FsRshtv0LAKf6Xh9KHO2BwXJSHeTCpW/t20K8M9bfqzd?=
 =?us-ascii?Q?0aLrOurJLI6qXmgBmDZd52MsdNffrbVOIZKTsxBIXH8CD3GxThUbg7refymB?=
 =?us-ascii?Q?PlvrImVXG3VIawKluOK+Bz8lHmALl2lUZqTMx0c9o0gfsiN4i3uYMiVGBgfM?=
 =?us-ascii?Q?t15cyAFQBErWabO1XBSJqzs8J3PInMXTNxySNDAN/6z+0oQcBaZ9dg8FC8U6?=
 =?us-ascii?Q?KVZIgshegwJWEUP+PQawci6Oe3xAnFMbCCiXuNGWAkdvkyfYIddlInNgTUDv?=
 =?us-ascii?Q?7EW8zkMU9QRb1KQtGl9/f6c3DAsMEuu3LPOAiuGw/HUzTsHBKzC4cNHuxIIW?=
 =?us-ascii?Q?oUIEZmsiT2+BV3hGlILo8J8YPj817JIZVGLoOu9bvlLar+zgjFblgL9THYGV?=
 =?us-ascii?Q?ZYjXij4NNvrBeO/GrzEi1ubTmdRj3LkfkyyqYWyUPKMZ1dP0qx8pEjBl9U/X?=
 =?us-ascii?Q?QaXDCdgekE2kmSywvbeYz9UH7G42GPsuMsnO2NGPklQVVJBkxDPhdeDObAvY?=
 =?us-ascii?Q?rW+e5SQ8+1gMEMiBcrOzox2rT5wD5V2CtXPq4EOKdQbTg58LXg750p+A3/Sl?=
 =?us-ascii?Q?TsWC6vf+MQsONV2FZ2CN1bYB4qxHXJm5bo6dKa9i14IIRexhbLFFZKL8PYbz?=
 =?us-ascii?Q?SyEBjwgcz2+x8ILkBTgM0zCGiIJbRj6tYYvCEKOwVs2scRu9Kp80VeFE972S?=
 =?us-ascii?Q?54DCLSjyNvK19/wcOrXsw9c6H9dsdidhpFvlIPmggvnhdaDZuB+3Bdk17yg5?=
 =?us-ascii?Q?seyJH+rc2f4hKlnGESRaBVs706GnV9/ni7WvUxVEH/MrGxcG0/mXbjNh62lm?=
 =?us-ascii?Q?XqRw2KarMitvaL+6jBHs9k+KFAG5GsB1ywXYicatAM3yqSvuWoYRZon7/WV7?=
 =?us-ascii?Q?SzTD+Jp405RqlDibqFfPe9Au4hRLzW9/2GVRho+3ZjnT09fh0/ieG/24+5PF?=
 =?us-ascii?Q?JYXFwUzbtWBxSfD1agaKUGaVrszWMzAUb3208F31n9kSVz1FnJLrxLvAl4UC?=
 =?us-ascii?Q?GhmTG+oa24YN7iT+n8w0JU+ZGT0mkHbXmbtdXKLAGo/QwOMR3sdx71RRj1VB?=
 =?us-ascii?Q?l2tawI0pu4MEN4rTGtqjmQPH/qaDn+rAHtRMpdJ7a4SZf4knN1DC/3y13PsO?=
 =?us-ascii?Q?KAnSfROeegHHajqqAnH6RVxF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1448.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6029229-2d3a-408d-2dd4-08d8ee018827
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 13:42:41.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrY0naWUdtzOzM2AUBET4oemnDGskWJfhwtVsuVWHdb+YPFYdHzYWhjdek7X8rUTcUBb36JigHj/knHfr6T1RvzKOs0P0X8cTyUVdGbw46M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1239
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230101
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ping.
Request the reviewers to go through the patch and let us know if you have a=
ny queries with respect to it.

-
Praveen Kumar Kannoju.=20


-----Original Message-----
From: Praveen Kannoju [mailto:praveen.kannoju@oracle.com]=20
Sent: 16 March 2021 06:39 PM
To: leon@kernel.org; dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.ker=
nel.org; linux-kernel@vger.kernel.org
Cc: Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>; Ram=
a Nichanamatlu <rama.nichanamatlu@oracle.com>; Aruna Ramakrishna <aruna.ram=
akrishna@oracle.com>; Jeffery Yoder <jeffery.yoder@oracle.com>; Praveen Kan=
noju <praveen.kannoju@oracle.com>
Subject: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt u=
pdate

To update xlt (during mlx5_ib_reg_user_mr()), the driver can request up to
1 MB (order-8) memory, depending on the size of the MR. This costly allocat=
ion can sometimes take very long to return (a few seconds), especially if t=
he system is fragmented and does not have any free chunks for orders >=3D 3=
. This causes the calling application to hang for a long time. To avoid the=
se long latency spikes, limit max order of allocation to order 3, and reuse=
 that buffer to populate_xlt() for that MR. This will increase the latency =
slightly (in the order of microseconds) for each
mlx5_ib_update_xlt() call, especially for larger MRs (since were making mul=
tiple calls to populate_xlt()), but its a small price to pay to avoid the l=
arge latency spikes with higher order allocations. The flag __GFP_NORETRY i=
s used while fetching the free pages to ensure that there are no long compa=
ction stalls when the system's memory is in fragmented condition.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/m=
r.c index db05b0e..dac19f0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1004,9 +1004,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct i=
b_pd *pd,
 	return mr;
 }
=20
-#define MLX5_MAX_UMR_CHUNK ((1 << (MLX5_MAX_UMR_SHIFT + 4)) - \
-			    MLX5_UMR_MTT_ALIGNMENT)
-#define MLX5_SPARE_UMR_CHUNK 0x10000
+#define MLX5_SPARE_UMR_CHUNK 0x8000
=20
 /*
  * Allocate a temporary buffer to hold the per-page information to transfe=
r to @@ -1028,30 +1026,16 @@ static void *mlx5_ib_alloc_xlt(size_t *nents, =
size_t ent_size, gfp_t gfp_mask)
 	 */
 	might_sleep();
=20
-	gfp_mask |=3D __GFP_ZERO;
+	gfp_mask |=3D __GFP_ZERO | __GFP_NORETRY;
=20
-	/*
-	 * If the system already has a suitable high order page then just use
-	 * that, but don't try hard to create one. This max is about 1M, so a
-	 * free x86 huge page will satisfy it.
-	 */
 	size =3D min_t(size_t, ent_size * ALIGN(*nents, xlt_chunk_align),
-		     MLX5_MAX_UMR_CHUNK);
+		     MLX5_SPARE_UMR_CHUNK);
 	*nents =3D size / ent_size;
 	res =3D (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
 				       get_order(size));
 	if (res)
 		return res;
=20
-	if (size > MLX5_SPARE_UMR_CHUNK) {
-		size =3D MLX5_SPARE_UMR_CHUNK;
-		*nents =3D get_order(size) / ent_size;
-		res =3D (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
-					       get_order(size));
-		if (res)
-			return res;
-	}
-
 	*nents =3D PAGE_SIZE / ent_size;
 	res =3D (void *)__get_free_page(gfp_mask);
 	if (res)
--
1.8.3.1

