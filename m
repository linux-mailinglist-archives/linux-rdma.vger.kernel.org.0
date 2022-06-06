Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCB853F155
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 23:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiFFVDo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbiFFVDE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 17:03:04 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9386007D
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 13:52:21 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256HILmI020379;
        Mon, 6 Jun 2022 20:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=N91nVcuyg6OsM8uugnBG1rrf4p7PSXVvVeEZhwwdL2U=;
 b=W7nQtWx+QQJRCG2ZmvuXVMsTRuhzX2WB5ih7zqBVWF/aVyZGE2h4Axw/UiWp1ikjtW82
 SuxH/wTzBYgBqCg1BlmW44rr1z6BlG4yS6LPCiFqjGg5tgWIuMQyuKHa8Z5D7JZ5r50S
 MY1XbCNUgpVDI+oCgRxmXYSOYVJ8fTmhL50vTkCoOqnMBp3xEO3cwX1cHFsSGPHzDDS8
 LHmr/dJokeEPVDmC8bvK9I8PB3zZlilhTcFlO1wrFOotvs19WKKLraz2ZlXBj6VDKBBl
 VFUv9uU+Hri45T1GNAd/+DLzij/kv10epRTx/dcYPaxvCdrP5im3hVvITZiWX9YpjwCC gQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3ghkxhu9sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 20:52:18 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E478D800252;
        Mon,  6 Jun 2022 20:52:17 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 6 Jun 2022 08:51:49 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 6 Jun 2022 08:51:49 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 6 Jun 2022 20:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHSr1GO1LyoXJYaXWP3UfIseen6YKOVKs+JU29oMqDryCcQlsLvSpTYhiCFmQ0477P8WhgDHsJSNI/tAXGvBWRtya2AGgtfjl6ZELcSLXE3CXJmSVRbNvnRJE3ERhePVrXk0dFpWuCS44VaL1sAV8bg9J85QsGVtYMkqAAhlIe9rapuTD8Z39cBo5jDQ1jaRwcvohbmu/ra5eECC6gkJtXIiWvSYZBmCqMvIUfIDyvznCxdEUmhGDgiT31eeILY3mKZEEo/VpntDZO1FASq1aAsdFKXy365wWpB2sL1ipphBu8G6Lpill9q4gjD9lEIfmzY3oDArTOtfNoBL1Mtdiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N91nVcuyg6OsM8uugnBG1rrf4p7PSXVvVeEZhwwdL2U=;
 b=c4DAYsHazXa8dIVZHeUkUIfbiP5VFpm2A7hIF7tEmFqF7Lbnz/Zt/MUg3LGZv6SNEzbF199LzLMPy/Fvl+15gXB7NEg00a91sA0tkznpwn875wA04YjETgxhGJ9mGNC93NI21mD13lMlPamoFPIgp0/ZpO/NwRIYwlB7fnv1VNOvXb/WgnfJ9dvONLjyRVifpsvOjUCXevm7SPZfLTWUT3YOmVDfAwkHv8rxOLeUe68eCOgEXOrDDE1squ3YFi+/FyjfIKhyJ2IB+q04KKvD/CNx4qhxf22FqkWm6W/WUsgrK3TwbNZo5A21kqHu9Svx6lM7Q1gsQnNAO2RLEQg27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by DM4PR84MB1975.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.19; Mon, 6 Jun 2022 20:51:47 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455%3]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 20:51:47 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Zago, Frank" <frank.zago@hpe.com>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>
Subject: RE: [PATCH for-next v15 2/2] RDMA/rxe: Convert read side locking to
 rcu
Thread-Topic: [PATCH for-next v15 2/2] RDMA/rxe: Convert read side locking to
 rcu
Thread-Index: AQHYebCIr5fQ4xX430iuKBUlkQtl/q1CnGsAgAA9y4A=
Date:   Mon, 6 Jun 2022 20:51:47 +0000
Message-ID: <MW4PR84MB23077599388360E85F49F195BCA29@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220606141804.4040-1-rpearsonhpe@gmail.com>
 <20220606141804.4040-3-rpearsonhpe@gmail.com>
 <20220606170728.GC1343366@nvidia.com>
In-Reply-To: <20220606170728.GC1343366@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9113caa4-54cb-4637-1b78-08da47fe5f49
x-ms-traffictypediagnostic: DM4PR84MB1975:EE_
x-microsoft-antispam-prvs: <DM4PR84MB1975DB06912ED54ED61949F6BCA29@DM4PR84MB1975.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sXg87Lv22qGygtn0WMShiGgRHX5ZFRtjT5fMxHvgFls80FerYWtWNm6NE+lHNqF1uCefqyr/wca2CTkzn2wekwoPjVaDqRBnH6bOzwAml8BYyqsBXnSaaWMmLr3PUUFLXhOm/UKEaHKn+kAwmZZojyHzxVHVP2/edGyL61dO2Wqb0mevv1W3qsM9gklzmd4qps92tiPtYXtFRRfm7i6klcLO0zKaabqM9XJTwTUEXB1L2jjrflBRXDTQ9gR02U2m8G/eGPlYPAWmIO4tpuJepFvpIPEajgobvNmMfa3fyPwFEYoXhO5mG56h6VJ4i/TtRKKlC0izqHbSIxg462zZVZxJszSrfEhm3EgtP0CvqTxOsN9VNIsAxxdRLbd89wzypmOe24ulEOYll5YgOrv31lEajNOVnwrgJkemCqE6z8DViua1okk29tKu0Vn99iIAVW9Ocp7QMdHYBKQX0Q4J8FoAZbrlwz/MxM0bDx0RL2jJITej6x8g9HUcWABcnKLhWXhTMJjCgVcBRVu01QCLSbW+p/WMrj2v4WFkgV/ubkfr0VK+OE++1QEBGrswVK9923OpD/7idhSbhTpR6yPO6TXgjHJ3kE8vwELSxDsh5xhz1t4JBj5hzd63dyF0N18zMdf+NV4oyev38MI3pBmH08v1Q9zrMaIba7IRuM55qvLp214B0NzAT9TZAyRQscEVZYUbrTe6nQXCyD51vL72qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(316002)(38070700005)(26005)(83380400001)(53546011)(186003)(86362001)(8936002)(54906003)(9686003)(110136005)(55016003)(71200400001)(52536014)(508600001)(2906002)(38100700002)(7696005)(6506007)(122000001)(82960400001)(5660300002)(8676002)(4326008)(66446008)(76116006)(66946007)(66556008)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MMdC1jR8keESA3zRr/5GuXUbLxmbQvtBWfOL70Hn23uJoAEiICQXofr9v39o?=
 =?us-ascii?Q?xh5/iRDH5qLRMzfF6jp4i7f46xxabCB62FktqCwJQcyZdJ3a+xITgqixg/px?=
 =?us-ascii?Q?xCuqyIjiSZjHrtrVG+2veN8ZoSFe+DV5x4Ki9a8IQ7J73MBINR12+GPWdEy+?=
 =?us-ascii?Q?WP+qklBQ5t+Dc8XV+sRMwr7m8Si5roaZ3EyZlb35bWqEO40eVf6Ekg3xBFHT?=
 =?us-ascii?Q?YtkUj/J+mY4LwrPUwuK74VMLWXpjD63ozfS9bnq0Tq0gxCPn6hV5IJq+mpVH?=
 =?us-ascii?Q?xpLw+2H8ieEtJzP9l23LI0AWzvsBZd9/3JbxlFvXi5KlwUg31cWgVrvU8cZr?=
 =?us-ascii?Q?M+KX7+TfQ6MrwYcCyNCh3AS8hcLXhSt/69PfYUC+EC+0rRTlXeQAGWX/QFUY?=
 =?us-ascii?Q?4zg1y0rQhO/RkCXh23JgBsI6eufdnsiXGI25EeaJxbNSskpv7/a4ZQxzU4hT?=
 =?us-ascii?Q?HoJAvMz0OL4aNwqWrLAFf2MSfnsldhQcIlWEW3DqnDhIVDnno07NbrjTwLvq?=
 =?us-ascii?Q?RhuTlS5g1ucNIgHGKYInzxZFwQzLRsA4Wu63KFXdzKbf1iVaLmlzBUkVUz5R?=
 =?us-ascii?Q?ClNoQVBXKq5qRLt03TXi/KRpf4a8e+seWZS3p83FhzifVSAMQS7M3Fw1X8Rx?=
 =?us-ascii?Q?BQ4HZlbyYmjiixKQaqQvC7aI9UMrBU0zOey+du7pEnx8r6we54YHWPcQxNz6?=
 =?us-ascii?Q?VqvWKwufthlSK35OlbW8fcFRnE9UecXw5VEjd6r9/CrrlibRlODa0d5j8Z1r?=
 =?us-ascii?Q?8UYfIkrPG4wHTu0+++nBc2sdMo8BMpU7izJFVzOnjLBrdLNmeCkGEFkEWwZ9?=
 =?us-ascii?Q?IBVIIcPSg67AovqW27B0nEYmHqh+E20G6fFj1E71POSNMXZlti8sEvWT3/JF?=
 =?us-ascii?Q?17qxTfnNbqYm1nCETkRSeXUVpEZ5HCWqWsCEwJTNykLuC8nuHyfQVCbXSMKb?=
 =?us-ascii?Q?zxBy1AKEzkKK07rBfDt6kZBGjFkM3a4glCDQA8qzWNvVWYmQl+sRJwGjw9nY?=
 =?us-ascii?Q?GuhpP/lCmoZMBHFZB3iX26iHuW34R7mU8SiwRt+fFugGerfScZ/430a43L0+?=
 =?us-ascii?Q?T6kDPkuSbsLyiJYP6kr3aNM3l11D2ZjpS9er8N/deLf08Dn4ifjriGz9/n5B?=
 =?us-ascii?Q?TlgsbOHffAjjRoIUVbGhWyl/TmVbI4sS+GU+m6hISEGva2INrgO2SUsxKBWT?=
 =?us-ascii?Q?B+vUaafjb8d/Tr2d5ZVluJui9NEi13U+1JAhwtNVGSTT5hMjPr3+TUSAHH2+?=
 =?us-ascii?Q?JenKK/WOAHZkppGKr5VvaEOz0sQi9foQ6MXTnhsJUKeRAUrVakKt14wCDzJL?=
 =?us-ascii?Q?ZEYFWeuLDrOcFIQos8XBh7YVPC2qyFQKGv0Bmisvky9lbRA10XAJRqsBc6qj?=
 =?us-ascii?Q?qqgEW702v+FdNpwUApOuHxi52kN7e34usaL4gAmhyEflV5chXp6TvsfwMTEA?=
 =?us-ascii?Q?acFDxWw4/OiE+N8nhZN3xhK45uwIhNOec5HjT0fYHQqdyBNPqjFTD/H9TCMS?=
 =?us-ascii?Q?zHkyBdpYDmVCQdoks5EqJWoRtKloOCCgJTA9dGU6ifr1xQfSr+kHa7uhfsm/?=
 =?us-ascii?Q?KpJ2AqVw4zYQbfKXhnqgslC1xqoJBzQ4EhXpdw/Exle/956keP3rPJNClHJx?=
 =?us-ascii?Q?PpdibnbBin2P83Ye1909oAUtwlAK2l+qY2jelg6ESuZ+go/jvLUBa9t1m/Jh?=
 =?us-ascii?Q?qgHwALToC10lnRLXRdpGBdrvZoRO2yIre2oWEC2NGL5sbszydeXI/+Fu8d4D?=
 =?us-ascii?Q?a0FZkK45cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9113caa4-54cb-4637-1b78-08da47fe5f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 20:51:47.1613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Pu2R+ZMpBcgJKpWlQHy7BHmcuQMuk+q4Czb3wH+mKSa/CQe1mmipyy9U4sPHDkFXep4UVxoqnDG8VMah4db8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1975
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: ggeUwmn3Almkt0F8FSHhvWrccxrRBMx8
X-Proofpoint-ORIG-GUID: ggeUwmn3Almkt0F8FSHhvWrccxrRBMx8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_06,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=961 adultscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060083
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Monday, June 6, 2022 12:07 PM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: zyjzyj2000@gmail.com; bvanassche@acm.org; linux-rdma@vger.kernel.org; Z=
ago, Frank <frank.zago@hpe.com>; Hack, Jenny (Ft. Collins) <jhack@hpe.com>
Subject: Re: [PATCH for-next v15 2/2] RDMA/rxe: Convert read side locking t=
o rcu

On Mon, Jun 06, 2022 at 09:18:04AM -0500, Bob Pearson wrote:
> Use rcu_read_lock() for protecting read side operations in rxe_pool.c.
>=20
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com> =20
> drivers/infiniband/sw/rxe/rxe_pool.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c=20
> b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 7a5685f0713e..103bf0c03441 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -195,16 +195,15 @@ void *rxe_pool_get_index(struct rxe_pool *pool,=20
> u32 index)  {
>  	struct rxe_pool_elem *elem;
>  	struct xarray *xa =3D &pool->xa;
> -	unsigned long flags;
>  	void *obj;
> =20
> -	xa_lock_irqsave(xa, flags);
> +	rcu_read_lock();
>  	elem =3D xa_load(xa, index);
>  	if (elem && kref_get_unless_zero(&elem->ref_cnt))
>  		obj =3D elem->obj;
>  	else
>  		obj =3D NULL;
> -	xa_unlock_irqrestore(xa, flags);
> +	rcu_read_unlock();
> =20
>  	return obj;
>  }
> @@ -221,16 +220,15 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool =
sleepable)
>  	struct rxe_pool *pool =3D elem->pool;
>  	struct xarray *xa =3D &pool->xa;
>  	static int timeout =3D RXE_POOL_TIMEOUT;
> -	unsigned long flags;
>  	int ret, err =3D 0;
>  	void *xa_ret;
> =20
> +	WARN_ON(!in_task());

I think this should just be

if (sleepable)
    might_sleep();


?

It all seems OK, any chance the AH bit can be split to its own patch or is =
it all interconnected? It would be easier for rc this way.

I can't not do anything about AH because it throws kernel splats. I'd rathe=
r not break the driver
even for one patch. If one says this won't work unless you apply all of the=
m you may as well just have
one patch.

Bob

Jason
