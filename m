Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC6A508CC6
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 18:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380254AbiDTQJE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379895AbiDTQJD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 12:09:03 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF0821804
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 09:06:16 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KFTLdN011114;
        Wed, 20 Apr 2022 16:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=42XhnDwiGKEEvd7VKh+KNLXcy/CnkZ7MuqKWOYHxwF4=;
 b=RjgRWFx3LMCVa0py/b2MoR0Ic/xIs4QcV93INA/Kwrg/LnUnIM0Wq8JnKDcSFTXPlbdB
 z5OoqbQuPMGtzjqd4tG71BkiSaksvnVGSvuGS5UcEvYq/RpANfW6MOcoO3u8njqOA/tP
 ntd5nCmxYsgoZB4yK083XeYzuGFpIXogo2RXkAUWVhvoCfn4k0Vpql0OMSVofO3gdwnp
 xawXv3VM75IkMei8uHreCOBlGXKSwikxkzQdyuPFOMT6Avbh9lM4i1Q8Y7bRkYIqPMN3
 69LfpfALL5+S+nevrkjBi6TRhhOhrUkTsUhz9vEpYqhTN97KmpHsyjIaRz7iiWQs/RX2 /g== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjmv3gb5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 16:06:13 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 20DFB13091;
        Wed, 20 Apr 2022 16:06:13 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 04:06:12 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 20 Apr 2022 04:06:12 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 16:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1cuOYp30rU3FbR6NZ4GExcJ8KcIe9ZYezqPYF3yi7vO1n6dnNJfZmiIR6t+ohhHtii2mC928D01B9rJlR3FPDNAPj/kqsbOBgboHdloQVL7ZceIktJMR6tfYk6QPICWlkrWPsFQwN6mGYmVV8cl9hxh2slbZIemYWnmSMS+z/j+o+kgxSZms/AsVvSFAK0VjCzgM6TQKvqL+oXjEkr1J3j00tIM6gt6o1G7aghgeLGt6e8XrRn3TmX0FgO2M1rDlr++HF90w3y8m+qBO2WayBBW3P+f+TrOYdeVbDT/EPasi/orvfcL3SbkUH+xxuk653PeqIStPse/+z+BDS+2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42XhnDwiGKEEvd7VKh+KNLXcy/CnkZ7MuqKWOYHxwF4=;
 b=XlJIeHaZyuTEVoevkSbYqKwKC/SMrbg+XUy4bPTPP/j1YVutW29wRXUySuFf5m5INyAhn2dDan30KuM7FviChPYixqPtoyrW2S03vw13NjiuswXIftKuqeh2pILwFI4umNJxDlNxsH49tvtcWbWmc8Sfx4wR/art6m8aC2MbazCLImldzUXfTr3bOYO5XUWe8D+8T5ICzWbUrMeIG80blfV5YKby5xEoXMR/oNI2MkAn5WRWTYl3LbssdH1XN3+XY6/Uuj/BlK6cu98VB+9oAwo/KeRN+cwAzsqOhE0h0Gem8+5/ydnnfF34ussexZzCeJ6spAXJXp+tZomgfMPXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by PH0PR84MB1503.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 16:06:10 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40%5]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 16:06:10 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v2] RDMA/rxe: Fix "Replace mr by rkey in
 responder resources"
Thread-Topic: [PATCH for-next v2] RDMA/rxe: Fix "Replace mr by rkey in
 responder resources"
Thread-Index: AQHYU0vE3lZ2myKE6UWSR2QzXLf97Kz49uIAgAADmRA=
Date:   Wed, 20 Apr 2022 16:06:10 +0000
Message-ID: <MW4PR84MB2307654EDA4ADAE97B51251DBCF59@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220418174103.3040-1-rpearsonhpe@gmail.com>
 <20220420155312.GA1432137@nvidia.com>
In-Reply-To: <20220420155312.GA1432137@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6094aca0-7061-4e64-d4e4-08da22e7afa0
x-ms-traffictypediagnostic: PH0PR84MB1503:EE_
x-microsoft-antispam-prvs: <PH0PR84MB150367C73EA83B80B4D16403BCF59@PH0PR84MB1503.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h37yRzN8LdQw+3VFrRWBTNTgzw7meVn8UYwNlodEBy2U0V6qtkzvfIYfKeq+5PWL0vNI0CnMaYGsm7Etb1Py27QU84ofA0dM3OXNX8YfjhDNri2tyhoOImOkNOlvdhvAfrAdzGdt8Q2NgtgvOUEW1+ZV5QIVDexK4K6URrqETonusYZx+7FNTU5MjAw8kBIc0IA2GVDIL4Y7LzNCf8GOZcWy8Qld/8b+n1YNG5NGbNO0V826W4C5BUIsq3HGyeNhrf9HCzVnN6wLMICVc9P7Hhr4MHpztz/yux7uVtOjxE+KkBU2gl+lrEbX+ezWnNfYczmg3JvW2ftdcj+4dXJUvZfQ7PRSMLI7DbrlTcv0KFbnUdvZzEhQ3rmRpbIC3I9zTy724ULIsgpsPVsMwr7jZecTr17CS2IHm/5CXPDAurd3FZsuWXt4SSFZ6CYjKQGya/rZmZ9FEkxVZ4KZkatQv9D00wnzBZsJqVtq4vAwCxb07vT/h6HpSTu1vDAGR5rFRpukQHr/ti96bv/WpAu2Ixpsadrn7oO9IbSZmrYhojvEfLpcLP4Rjdv7tEQnQutlqBCgLO6v719qdXwEG0uLJm+5zmII1v+ZjzGSKY7zci2o/YPDNIJt8kQ5bVqO9PETIkIbPe+Qg7CcdcrfLzc9P6+1ovidmNU7xRbtKwG9ADDy5/8h5POY0p6SHnPGK1EdNey9cAriViF9dvy/ddg8o3gJ2wL+2TWtIHS2fvxIJbaUANXn7kN1E/o+cHX+5RjRzPJyCrFuUC0A7XTx7WuFc4OLT82O2heqejESznVk3mg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(316002)(508600001)(82960400001)(38070700005)(66446008)(66946007)(66476007)(66556008)(71200400001)(966005)(7696005)(5660300002)(86362001)(55016003)(8936002)(52536014)(4326008)(64756008)(8676002)(76116006)(55236004)(6506007)(53546011)(9686003)(122000001)(83380400001)(110136005)(54906003)(33656002)(186003)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0+s3kF62QEiD+Cf75nF7lmChhEaY+1Aon0HnMvJ9PNuiGP+K8WuC5463OsXd?=
 =?us-ascii?Q?7ZsXaVGncYfAFJBDDqGLfMBR4FUn2e5mTWpkbu2jzOHz9KW+UWjtWNvtm/6q?=
 =?us-ascii?Q?SXMk9v3tW+YDol1O6D1Y36M6gts7yPkw+5Jo3WM8WSMniL4zaEv/vC33jZIb?=
 =?us-ascii?Q?XYIGjd3wgrDUAW5zjAqww80O0DjVpUXkjtHTXIHsKNVRUqtdd5lJnmWMNvxS?=
 =?us-ascii?Q?knNc1S58gkAO+83t3b0teku8qjnk8BqcY3jnk3H4d8xjrlTs5zoj6WhN8xAx?=
 =?us-ascii?Q?H7LyzTa6v+QhutGUQowiNw7nggwdjv/KvOgSTJybApRP6s4Gf/+VDU1Kakvj?=
 =?us-ascii?Q?j/5thtPJkpfsk1GXZe8Jz9ceuZjMAx9LkIX4zIZrTDUoj/WbamUmfyxKv6gM?=
 =?us-ascii?Q?8CuFI7UJoNWY9C3mGiqzBfKC/lquc0zVztsFDTflWo6vbcWkQz5Kn22HS1ll?=
 =?us-ascii?Q?ZLRKh0jKOz2wAttNoCzlJXYrVernuWzd7JdVzpRR1/BG/OtRQ1gtaUjQnPav?=
 =?us-ascii?Q?RSJpL+GptUMZt2gt4GlGDMD5VoQhfnNBz7A7JbFt5tQJoXJZyy8NJClCMWIl?=
 =?us-ascii?Q?S0JlZ6e2sCGTYjnOzoBFi5WzarEmcbGMc29g+ybRYzS8cRbyjDQBI+XsVCxy?=
 =?us-ascii?Q?flda4dN0prDuKAPgkD9Pd3F8PLOYORZo4rUQp2L+nZjdGSro9g2VmN3kpN4L?=
 =?us-ascii?Q?GnrA8uD1Ll6Xjyt+kfvzkfurTA/gVgB/nrlP6kD5td5D27l9P3GnMPN3bpdW?=
 =?us-ascii?Q?GPySDQU/shiBEcU53xXh+jNi2cMBKBJDeEtuc2bsP2zknl9he/9ixBRLfSCB?=
 =?us-ascii?Q?gTFxWRms3a7kiZqIne8h09NtUTNYrgN/9G4qOGznkORRJrft8FxAgl5mQT4G?=
 =?us-ascii?Q?Br9wS5/+jlNjk92vx35KaBLuNWLc0jJhkqK9u2cK+RUPILha6/L7T1rWzqLN?=
 =?us-ascii?Q?vR+79kmTL550xQTSKwVcqpQs0OJL3CzxFpqziTuTVPL/AG/T7y+iZ3Pnuq/+?=
 =?us-ascii?Q?q84PbdOLqRqq2p/H7+Ct8T6l+AjgT9bhfAAIzTBGxlh0Z1JdXOlsSY9FeD9t?=
 =?us-ascii?Q?6UpqgYUqPtkeuGvCEK7r0NWEOHGiOI3O6XkvvUoBwXjTPDnaRiJbBVMXWS5y?=
 =?us-ascii?Q?bY7CVS+aPUwvRr535x+Xnev2Y1zJgGN1icJ5DTk0SvoPNMKVYSVzfRYUmLaB?=
 =?us-ascii?Q?rdpisJHs/rPKZ3nXjZut/3Sj5jsN/fWPwy50L5TvJ9jENIEooOOauS7kxVIO?=
 =?us-ascii?Q?XTJ1CHbMaY163KoyD+yZ1IMsGTh9/AeeBpdUDGXLsJhGYYyksp7gDz1dfCtr?=
 =?us-ascii?Q?raWOr2Sesss5ZLY4/9hLHlv4GXyMMRH0BM4kocA4aQo1b1nvkg4ptCnjfdOS?=
 =?us-ascii?Q?eNUjdxJljzS2FaJaVwO7zZBWJAZFTfYbOsBTKqlHQjtPoaQ8ABJoXEVfCPop?=
 =?us-ascii?Q?PIV1ZjmVAhpoJylcayo1eVFkpZrDftFWeXytojph0cJkPaTVgzl3hptMFu2S?=
 =?us-ascii?Q?EVRmZRopZq+SDgChmCCTsJiqPDfaQodvu0HIf+DZakUXgOTFsdmcBtCuUulU?=
 =?us-ascii?Q?WrU9aNHsI37f1/9iPn6Fs8CesrEHBV+P5UM4HtfPsn/MGqFANC97UE2V1m02?=
 =?us-ascii?Q?OTdjye++eGReBzwIh8DDP52a7i4gddLDUkUmU4Gu2WWto9SDI6bcXnnlNlD8?=
 =?us-ascii?Q?5jQK60kBPwNnfuBaKz+wpp6atuDvZl0loestONakeq9p3zxQEAIovryr4+2Z?=
 =?us-ascii?Q?petehL0sOg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6094aca0-7061-4e64-d4e4-08da22e7afa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 16:06:10.5376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68YclR4Wy5ATOLKfeuPI8HoeY91CRcPEbUEO1A5/G1IaIl78jimJul1ji5e+1gEBlqL7MLGO78pd3zPZh4I7mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1503
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: JL8Bn78cuLSRsosh5DpPotFQL6D-8njP
X-Proofpoint-ORIG-GUID: JL8Bn78cuLSRsosh5DpPotFQL6D-8njP
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=773 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200096
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

thanks

-----Original Message-----
From: Jason Gunthorpe <jgg@nvidia.com>=20
Sent: Wednesday, April 20, 2022 10:53 AM
To: Bob Pearson <rpearsonhpe@gmail.com>
Cc: zyjzyj2000@gmail.com; linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix "Replace mr by rkey in respo=
nder resources"

On Mon, Apr 18, 2022 at 12:41:04PM -0500, Bob Pearson wrote:
> The rping benchmark fails on long runs. The root cause of this failure=20
> has been traced to a failure to compute a nonzero value of mr in rare=20
> situations.
>=20
> Fix this failure by correctly handling the computation of mr in
> read_reply() in rxe_resp.c in the replay flow.
>=20
> Fixes: 8a1a0be894da ("RDMA/rxe: Replace mr by rkey in responder=20
> resources")
> Link:=20
> https://lore.kernel.org/linux-rdma/1a9a9190-368d-3442-0a62-443b1a6c120
> 9@linux.dev/
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2
>   Renamed commit
>   Changed fixes line to correctly ID the bug
>   Added a link to the reported mr =3D=3D NULL issue
>=20
>  drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
