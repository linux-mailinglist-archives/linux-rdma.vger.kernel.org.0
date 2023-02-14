Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0876957D2
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 05:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBNEPj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Feb 2023 23:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjBNEP3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Feb 2023 23:15:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929181968E
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 20:15:26 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DMOQvL026449;
        Tue, 14 Feb 2023 04:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=IFdal68hYbVRU81lZb+oLy5PMQRVcO5b34YkXvJ43O4=;
 b=cDHud6wwhS+tD2VUUQKi+7ECKBMGcE6wGHz6BBaY1McQnSash4c+05rRTRcy04GwYIDq
 XUjdYJUmr9184GtmXr/z5iGwhcbcMKBD3hWwk0urt7PsDeXxmKZ2YIa9w5W88aKJXQEF
 IYIRPC+qLIdbj8jEexQZ2KGWwHa+eeXIAleqzLGCCngr/9OqllvjzBhItuvDmuWOw671
 2HaOWTpzhkCImlUzibCMYMuybErqdTvLjVXTkx9oRSPyosD7DPLRW496B2BMuglfZ53B
 ugBm+VYpjCoLyv/VDs/vKjgicg4YezKIzb0wrZnYOzbdde9s3vU3Bq1BOeFgI7RuWvj4 iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np32ccd76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 04:15:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31E2tsbH028775;
        Tue, 14 Feb 2023 04:15:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f50pfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 04:15:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsEFXFyM6/IXGBy68Rkhf4NsbPdZwM7M/56PD5vnz16/OE63Y16ok2mRyVGkAUC4ISrTEP3k37QAY9TyGPnG3aNqQdDKiRZ+tE0AKxDfbPcf8+BbPN9KlG5OfSSapmhUWcdTLdnNXDCTLtXpcAYQFkPMW3+EfCPnZ6s+5HW5lD3OuO4G7enXdPcPL1RC64hT0ndB3qarNexQV/bYEAkUwjER+uA/B0tSuXw70yxgTcXn1hJSQnZdn+3h5fJULPK292nPFj+oHww84aeEmOXNNuPJHyCE4eKk4rvEd2tL/vfPAkFESUwFRrjgcpZ0AwcSzhGA8VXdYjSKFOuQtKwOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFdal68hYbVRU81lZb+oLy5PMQRVcO5b34YkXvJ43O4=;
 b=gQAL0zLgorsnz1E9B5i/LnwcFLxbKur0AlIcE3Xy5N+7QIw5knRsUtyf8Hw+DnEpHE18QiZ4S+fbvOmzXW7Qct4uUvJvwbxCRWEb/naKu87F7OcVHhk2aYZnd+qH8ca2KScz5DVhh+Zgt99fltEsZrACjGA4Nl+Y+5/0a9WLoaxdBv8803oiXKcbcYvp4QiI1coCKPU/wP4Ji6gOIDbb8R3xGrrbchnSfNx5Ni4qHvZblo7y0zoNajy7Lnh+YUZ9k89BrX/AxiqCgOAqxAGRE5PZ5a0W2tsGqd0QzbaAH1Cc/5x29PUrSsvAfYzM5DcbCkYSr7hjk2LELmcQqoBflQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFdal68hYbVRU81lZb+oLy5PMQRVcO5b34YkXvJ43O4=;
 b=h6EWjjwX1DzHBhBawSKDkV7E2R1jHoU028uYIaeSyvlJWqkaUK/4WWUmxtI5wthwh8VjwuOJ2nj8j9U762xajUNTwUT9sUkOuq2uKtatdZHdlbyQw/St6a9JwiCPQuqdxE6TmGCauerOStYRe28kt6bhnd2pOiLkZ4D9/YAWh4E=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by BLAPR10MB5249.namprd10.prod.outlook.com (2603:10b6:208:327::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Tue, 14 Feb
 2023 04:15:19 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::1048:7257:2877:b3c4]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::1048:7257:2877:b3c4%7]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 04:15:19 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "rpearson@hpe.com" <rpearson@hpe.com>
Subject: RE: [PATCH for-next] RDMA/rxe: Remove rxe_alloc()
Thread-Topic: [PATCH for-next] RDMA/rxe: Remove rxe_alloc()
Thread-Index: AQHZP/7zKATxJ+5zdE26B4v5whw+Wa7N1aiQ
Date:   Tue, 14 Feb 2023 04:15:19 +0000
Message-ID: <CO6PR10MB5635D2C3386321B57BCE70ACDDA29@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <20230213225551.12437-1-rpearsonhpe@gmail.com>
In-Reply-To: <20230213225551.12437-1-rpearsonhpe@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR10MB5635:EE_|BLAPR10MB5249:EE_
x-ms-office365-filtering-correlation-id: 0e52a5ba-47ce-43b8-df84-08db0e4215b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 75gF+qFRC55VcJNGA0Hgf+vhKgKNBRhs2uVwq+fzIhJEnAuvvQ6BlOORTCjuB2TJvkfC96/T6gRQSV6WtwTdxu+r6XtRRpuX0msd+YIbvKxTk5osjJ7InaBrwEP/BGiNiMbdbCE10IWM+/Ae1DMN5/+UUKusifcUKmze41UXuoE5Ccw2j4Ad1GRfl85iWePPo7CpcHoKFTWC+Eiryc1p9iCruQblKz9if0Y8yKhi8egizbFYsigMdOhlHjDytpkrH2PpxuX5ErQPJsXeFNsuvR9MgwuEX2+AAyPpYP49/nvpc8gHfLprUlwtBybFPN8ZK3SffNLnHXZWft5enEFvJh7nyXcWd3dyGaiFNZWAxUSfbOr/m8k2PV4oK0GeMDII1wKS8sMtLdWcZC60uy4ln4KfJff3slssb+iRjGUSN+h/b3wfTz8G3nYqac2DC8kpoGwJuVYFhYcHxYjOFrfTmTrt2OLOng9whGogDOS1tDwbcyD0vxuz9SZ+9ZxmKL2E6DT9dYUr/L2l/DC1bq6sp2NbtchqwLnAhHzjPFtJac6UQBmdPfHBGImhOqD4P08yTIpNGnr2ajUAfhYTTeyv42JbRwooxtyiUrb7jjPxtqWc/CZkNrX9MYZsy3QqpDyAE/M4BdukOfXQlDTlE5FhEQMa/lRkIFkSYOXzAsz/H+Na5y0Vx0Vzpm3CiAbs2cug5gH6OPHcLBA/4sgxSpacQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199018)(110136005)(316002)(66556008)(66446008)(8676002)(66946007)(4326008)(66476007)(76116006)(64756008)(41300700001)(52536014)(8936002)(5660300002)(6506007)(2906002)(71200400001)(478600001)(55236004)(122000001)(9686003)(7696005)(186003)(26005)(53546011)(55016003)(83380400001)(33656002)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hWPBMhrScuPnpFTJ7snMC+0E5bpYUzuEMFGFRcM092prlX/p20VQKIjQGYFI?=
 =?us-ascii?Q?h8FK6S65+zsCoHlXQHZzodg2RkfTYaeBYYCuC93QTRtchkKDXsaajX4dAJbx?=
 =?us-ascii?Q?kcgkhO4M2DULIds4D+AGr+aenStxUhggY9K0UPcrYkjEx3PgaXoqRsakLtPA?=
 =?us-ascii?Q?TF6tWuJap69pC8teE3vAmjfh0FarWYiNnXIq5KL1YGzPdFKz+TtejoTI4ed0?=
 =?us-ascii?Q?nFQc1VxKY4oFTWX2esjnO45rX6NaDduYmzNPPOeF+oVb2CU2PYL2C+G6vgZU?=
 =?us-ascii?Q?WyGPTvLfVtGlbjcRS3Kk1rc0XRCaww7HpK/6usiu6La0MdBo5wI/HIOO2tmQ?=
 =?us-ascii?Q?mrcRMjR1muE3xFDBcfOKYcKXDeGrXkCn76zfj2dQqoKJlrJNF9j1NzUy6RJK?=
 =?us-ascii?Q?BIKs0STmNcfwgfADgT8WWcRGcSPKaadWFyHAI9hZ5WG3zmmNGdcjZFdFMdpu?=
 =?us-ascii?Q?EhIYomPejA9/DzWGFE33vqT4EpjAKOZHxL3Hw6HP7zmb9Pu8JF5zn/tMY57+?=
 =?us-ascii?Q?GGw7qVW7FuSb1a6u2yG/0RzfSl3nboCZPNLWIY0cmMDfyRdgN6YobqH/pVqf?=
 =?us-ascii?Q?jhMKa2ACpcjW9WT7kvGkkqELI08J3c55tbzAytk3WZuFrGuctPEPJFSRvSZD?=
 =?us-ascii?Q?y3qNAdvc27Xn2tryygvJy79ZT9YeAhTy/UazZwmBMDxJQoD4kmqczOFwcdvf?=
 =?us-ascii?Q?caU8RMei9CSM1pMQ6tldLbVxq9iY5iQApMEgvlwitqz/bONzrNTqzLI67dSS?=
 =?us-ascii?Q?AUSPA9lVf9COdKZ7BC3/xBuick2KY3vZapUFVR8gHOOIdIoTQShMWKthF5Tb?=
 =?us-ascii?Q?ds8G8AOzH/UhRqFhgbYDmwt1OadrZPx7El0qJOcOKFKC6IyYXozT5hDwggVO?=
 =?us-ascii?Q?lx9issNpBcHFu76Yf7XqkcqYKui27rGaIBtNw4Tj2VftEsmV79ZWA5Rr0X7q?=
 =?us-ascii?Q?TfC8aQzMHt97RAF/OV3Iux1IAUFOQTl+B7xvKCnYsiqcCj+MAZ001B6rq0r3?=
 =?us-ascii?Q?a1IIFVRB6dc2jVQiYUvqkKhDbarFq4+Sq4iNNLd4o8+sObBjshoOE0DW2Mlt?=
 =?us-ascii?Q?HPEs4OlneHmnb/+0J48zGUGuRmrkJItCliDShfuDV4lkwqpiZozX51xAt5g8?=
 =?us-ascii?Q?R3olOw/Y/slnZN4HNeE5ClUVzrNgGwzJbjxm3c4YqbhGu24a8QmZ6t9DppKu?=
 =?us-ascii?Q?oA74xS0xlNUTx0HnubVpnnT/AwPW054n3cISUmh9TJxk3ai5k4f+yeQ78a8k?=
 =?us-ascii?Q?w0FQ3vUF9aRRlWAxNwDf0vsVPqj/pCDI3EMDg8aDTMd8K87Lw6wuMsDM60R5?=
 =?us-ascii?Q?W+q9oXc6acCc9NGaQW07TA84ao88ccQpST8iqQHzURWNQpjGZJsu/LHMpqNm?=
 =?us-ascii?Q?cKVbDXRvB/RthDfaIWSrfnAIP+BUsuMosjpUBGKqpjQKPN4U6rXZf6jdC2Mg?=
 =?us-ascii?Q?90Vzk2RFE0d7DenEambUddhFlTw+PPD5ELLbMH7ZYMMs/vMmi9O3jRO4pBEG?=
 =?us-ascii?Q?uP8OBDKghoXAaBD+dlkkfmFJRM6MYh/AqW9W+xvTvGsBaMh2j6DwkpUrWaSx?=
 =?us-ascii?Q?kBtDzpkMW5USyN8QSJ17HOWkZt8VGCqc3dvW27/Bb+cKPxY3mZZ4xTZByOcD?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R42YSteumZeM2m9UxQ/rlMl/D1LCf76nT+PW2YGcEn22nIGw8D5CaXf4SFRrYb/ZfSfaxn74bav4jEWSYXFyOw2dQ1Pk7twsEV0YU/fQj241NNw6upIduGKdRi9vdkWqwlURiGFChnx/6vCDl8q4GVljuoN6p3wBmdl7mVrXqrSYt55iEZ+gMpkXM5N9SkKObD/Ny9TrKESKwSnrbEQJH515zRfVWYsokosP9fbaxvp+SvTgS99KXIZTFdd0UQ7k+THVV/xGpgWCXJnu6J7IgCXKhaz4TfmmBxZ9mMOCVFK05kDEd57vG26fdVUGD/paFQxmXHqw7KK1rFRtm/qC9UeqALyKADIj9B0rf/qoWJIhwbOFBLU/NdE3vP2I9XpKl4pg3gOaDJw0jQGPt1GF2N1yLPQBdeZUbQyxuK02ZfC/1Lp+PK8kMu/Mww0PLjcRcIeqgmHhRhB3bjFQSH7H01Rx0yKrF26cv6CQBiLfENexpY4h4vuOPUAd7JgwsA3OyGcNfIHYXXHJTZhP00nmadtVL2fE0bejpRfnYm0515z7u40hAx+daxmRnkdyUzOAhtsp882oRlb9XpbCI5oqgep1MJxDNBDAPuffD04Q27TPM//PfSLjcDHBXlzT/10u0Ygo0YGgaIwka//rQrIRaJMOIgRavrvjIKHv3n4KBgu6ghrlOTEXGf8WxJ5VQIHg8p98s4SxpMtqGqvI0FsQbMgAtV8OXxyyhcU3t56YLO94NMcmX8sklOUvNOmdLaBBz+4ca4qr5+aX87tqbIygSOe7xFqyj6gqAf0T7c/HuRSBfQBdS8iV7zd9NlATOt87bjdxRyaAr/veNqx5+O1dOA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e52a5ba-47ce-43b8-df84-08db0e4215b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 04:15:19.7328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibQJLhgM59MDdlfQXJ4eSct3k84i78uCBqrqphYFOpgS0FLpbEzZZkqIXLiBigB1BITn/coD9f6kwJvIeV3M9JFJFi1Ltoh1AZ+XRZ8qFJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_02,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302140033
X-Proofpoint-GUID: jOpYBMqtv_71W-oXHJQ50qtrEYsFHlng
X-Proofpoint-ORIG-GUID: jOpYBMqtv_71W-oXHJQ50qtrEYsFHlng
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Bob Pearson <rpearsonhpe@gmail.com>
> Sent: Tuesday, February 14, 2023 4:26 AM
> To: jgg@nvidia.com; zyjzyj2000@gmail.com; linux-rdma@vger.kernel.org
> Cc: Bob Pearson <rpearsonhpe@gmail.com>; rpearson@hpe.com
> Subject: [PATCH for-next] RDMA/rxe: Remove rxe_alloc()
>=20
> Currently all the object types in the rxe driver are allocated in rdma-co=
re
> except for MRs. By moving tha kzalloc() call outside of the pool code the
> rxe_alloc() subroutine can be eliminated and code checking for MR as a
> special case can be removed.
>=20
> This patch moves the kzalloc() and kfree_rcu() calls into the mr registra=
tion
> and destruction verbs. It removes that code from rxe_pool.c including the
> rxe_alloc() subroutine which is no longer used.
>=20
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
>  drivers/infiniband/sw/rxe/rxe_pool.c  | 46 --------------------
> drivers/infiniband/sw/rxe/rxe_pool.h  |  3 --
> drivers/infiniband/sw/rxe/rxe_verbs.c | 61 +++++++++++++++++++--------
>  4 files changed, 45 insertions(+), 67 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
> b/drivers/infiniband/sw/rxe/rxe_mr.c
> index c80458634962..c79a4161a6ae 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -724,7 +724,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata
> *udata)
>  		return -EINVAL;
>=20
>  	rxe_cleanup(mr);
> -
> +	kfree_rcu(mr);
>  	return 0;
>  }
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c
> b/drivers/infiniband/sw/rxe/rxe_pool.c
> index f50620f5a0a1..3f6bd672cc2d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -116,55 +116,12 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
>  	WARN_ON(!xa_empty(&pool->xa));
>  }
>=20
> -void *rxe_alloc(struct rxe_pool *pool)
> -{
> -	struct rxe_pool_elem *elem;
> -	void *obj;
> -	int err;
> -
> -	if (WARN_ON(!(pool->type =3D=3D RXE_TYPE_MR)))
> -		return NULL;
> -
> -	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
> -		goto err_cnt;
> -
> -	obj =3D kzalloc(pool->elem_size, GFP_KERNEL);
> -	if (!obj)
> -		goto err_cnt;
> -
> -	elem =3D (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
> -
> -	elem->pool =3D pool;
> -	elem->obj =3D obj;
> -	kref_init(&elem->ref_cnt);
> -	init_completion(&elem->complete);
> -
> -	/* allocate index in array but leave pointer as NULL so it
> -	 * can't be looked up until rxe_finalize() is called
> -	 */
> -	err =3D xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
> -			      &pool->next, GFP_KERNEL);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return obj;
> -
> -err_free:
> -	kfree(obj);
> -err_cnt:
> -	atomic_dec(&pool->num_elem);
> -	return NULL;
> -}
> -
>  int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>  				bool sleepable)
>  {
>  	int err;
>  	gfp_t gfp_flags;
>=20
> -	if (WARN_ON(pool->type =3D=3D RXE_TYPE_MR))
> -		return -EINVAL;
> -
>  	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>  		goto err_cnt;
>=20
> @@ -275,9 +232,6 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool
> sleepable)
>  	if (pool->cleanup)
>  		pool->cleanup(elem);
>=20
> -	if (pool->type =3D=3D RXE_TYPE_MR)
> -		kfree_rcu(elem->obj);
> -
>  	atomic_dec(&pool->num_elem);
>=20
>  	return err;
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h
> b/drivers/infiniband/sw/rxe/rxe_pool.h
> index 9d83cb32092f..b42e26427a70 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
> @@ -54,9 +54,6 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool
> *pool,
>  /* free resources from object pool */
>  void rxe_pool_cleanup(struct rxe_pool *pool);
>=20
> -/* allocate an object from pool */
> -void *rxe_alloc(struct rxe_pool *pool);
> -
>  /* connect already allocated object to pool */  int __rxe_add_to_pool(st=
ruct
> rxe_pool *pool, struct rxe_pool_elem *elem,
>  				bool sleepable);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
> b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 7a902e0a0607..268be6983c1e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -869,10 +869,17 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd
> *ibpd, int access)
>  	struct rxe_dev *rxe =3D to_rdev(ibpd->device);
>  	struct rxe_pd *pd =3D to_rpd(ibpd);
>  	struct rxe_mr *mr;
> +	int err;
>=20
> -	mr =3D rxe_alloc(&rxe->mr_pool);
> -	if (!mr)
> -		return ERR_PTR(-ENOMEM);
> +	mr =3D kzalloc(sizeof(*mr), GFP_KERNEL);
> +	if (!mr) {
> +		err =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	err =3D rxe_add_to_pool(&rxe->mr_pool, mr);
> +	if (err)
> +		goto err_free;
>=20
>  	rxe_get(pd);
>  	mr->ibmr.pd =3D ibpd;
> @@ -880,8 +887,12 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd
> *ibpd, int access)
>=20
>  	rxe_mr_init_dma(access, mr);
>  	rxe_finalize(mr);
> -
>  	return &mr->ibmr;
> +
> +err_free:
> +	kfree(mr);
> +err_out:
> +	return ERR_PTR(err);
>  }
>=20
>  static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, @@ -895,9 +906,=
15
> @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
>  	struct rxe_pd *pd =3D to_rpd(ibpd);
>  	struct rxe_mr *mr;
>=20
> -	mr =3D rxe_alloc(&rxe->mr_pool);
> -	if (!mr)
> -		return ERR_PTR(-ENOMEM);
> +	mr =3D kzalloc(sizeof(*mr), GFP_KERNEL);
> +	if (!mr) {
> +		err =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	err =3D rxe_add_to_pool(&rxe->mr_pool, mr);
> +	if (err)
> +		goto err_free;
>=20
>  	rxe_get(pd);
>  	mr->ibmr.pd =3D ibpd;
> @@ -905,14 +922,16 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd
> *ibpd,
>=20
>  	err =3D rxe_mr_init_user(rxe, start, length, iova, access, mr);
>  	if (err)
> -		goto err1;
> +		goto err_cleanup;
>=20
>  	rxe_finalize(mr);
> -
>  	return &mr->ibmr;
>=20
> -err1:
> +err_cleanup:
>  	rxe_cleanup(mr);
> +err_free:
> +	kfree(mr);
> +err_out:
>  	return ERR_PTR(err);
>  }
>=20
> @@ -927,24 +946,32 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd
> *ibpd, enum ib_mr_type mr_type,
>  	if (mr_type !=3D IB_MR_TYPE_MEM_REG)
>  		return ERR_PTR(-EINVAL);
>=20
> -	mr =3D rxe_alloc(&rxe->mr_pool);
> -	if (!mr)
> -		return ERR_PTR(-ENOMEM);
> +	mr =3D kzalloc(sizeof(*mr), GFP_KERNEL);
> +	if (!mr) {
> +		err =3D -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	err =3D rxe_add_to_pool(&rxe->mr_pool, mr);
> +	if (err)
> +		goto err_free;
>=20
>  	rxe_get(pd);
>  	mr->ibmr.pd =3D ibpd;
>  	mr->ibmr.device =3D ibpd->device;
>=20
>  	err =3D rxe_mr_init_fast(max_num_sg, mr);
> -	if (err)
> -		goto err1;
> +	if (err)
> +		goto err_cleanup;
>=20
>  	rxe_finalize(mr);
> -
>  	return &mr->ibmr;
>=20
> -err1:
> +err_cleanup:
>  	rxe_cleanup(mr);
> +err_free:
> +	kfree(mr);
> +err_out:
>  	return ERR_PTR(err);
>  }
>

LGTM
Reviewed-by: Devesh Sharma <devesh.s.sharma@oracle.com>
=20
>=20
> base-commit: 9cd9842c46996ef62173c36619c746f57416bcb0
> --
> 2.37.2

