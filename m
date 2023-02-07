Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0AC68CECD
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Feb 2023 06:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBGFUK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Feb 2023 00:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBGFUJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Feb 2023 00:20:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB331E9DF;
        Mon,  6 Feb 2023 21:20:07 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KDsTQ003917;
        Tue, 7 Feb 2023 05:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KqecSfQVPsOM4Ad/D4Y1ra+CXdzVmXVDrlOrslfLdlg=;
 b=kAbOlmGMzUSuKrEBDBFxsn7xsYMs2uAJit/uPWqotRKw8v3y4nA8fBLrlNPptUGm3wlf
 S814TMyC3FlJdi1TulifzTidU8MK8Caw7RBl+2ScmmlmkHZAtp/XtNuXb3rHa3qy/UNH
 QkWhahotuGVVRmoXuTAxkiiK14WHslLkLsUlmS0MupQDUhgpzfkC070EWlG43Pt94b5N
 k4oOTBnIl8wUHg/mHE5u8ousI1QM6FOKpwWn5iYklwiceI4AkXNEAmU9FvNk+x+Yw5F+
 otgKycBr3UAX8rqE77H+344mH4sNEblwwrUjvXDnRCmQbQnnD+qVd5MJfAiW1+AjHc5g tA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheytvmvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 05:20:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3174WFSS037016;
        Tue, 7 Feb 2023 05:20:01 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtbc5n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 05:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuSRvL9oIQtOddzQRtpsUV7dVmtIJSDxf73OAKFDm5AWaimFRz9FMM3mkkl2jFrEz2WxFdzeoWt6fc9/M8HoI7sM/Dba11BxhR7kbrAZzDBAh/l8keFb0sUXxWfRuF9reXfDh9xT/5rpiQHfbBSTEMVFoVOCY47WHW2sH9MohyDYhi+vbvO3S0m29Xw9DngNWKfSNbbiHATbWHXM7BxUyPamdh88i+I5wQm70/zB+sxvA50ji+gSp/Dp8XlzNTm4JYqqW0L6N47hTQ4opPZ8H7qiwcdByaGESizwxXaFlqVhJ36zPqS4AzzYwYFKgVSJyy0hFmVgK2su5OT9UgtZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqecSfQVPsOM4Ad/D4Y1ra+CXdzVmXVDrlOrslfLdlg=;
 b=oED+iT7KKMrovtyQjnoXwZW4yKV0uFPcjjxzdXQTMMLGTkjI2WvcV5vK+bOVYBNLfNYq9FoDR3zT0n0QbNOWlcqkKV/Xcb8B6ngiAcF5tO87e5RmoVFfWcx4E+5o2seCwy93tdQMwh/bUmw+HiaKp8QoLZFOEngLSGn5uOajd44obrxUCOyvmRF9bWO6K140poU707RAuy4t6YRglgS7vxLdp1Uaya92KwwVituizsiUrKA/rXwd6JGMH7blmkAbIaE0u4ybkhI1ddA5/d2D6LXQ6+9rxo6caPqcQHx96B/+JjbosbP6/95Nc0zvvAQno4/qqGYptIEZdtyARwqmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqecSfQVPsOM4Ad/D4Y1ra+CXdzVmXVDrlOrslfLdlg=;
 b=xKdaYMFDcpSDXiuOKugvs1ap/84bpQDpUwDrTSpDu8RWUYejxYtOK+tvhbwGWE9RfkWvt7XGAJvdEjIP1kUqWFkjzLCDJVeK4CWTuvBHKluQGGgtJRX+e7dz8eaw0rE1ZtS8ce4vsPIxITKjTrmZTcZnB2o4BGcic7P/hOAfNAg=
Received: from CO6PR10MB5635.namprd10.prod.outlook.com (2603:10b6:303:14a::6)
 by IA0PR10MB7253.namprd10.prod.outlook.com (2603:10b6:208:3de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.14; Tue, 7 Feb
 2023 05:19:59 +0000
Received: from CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::1048:7257:2877:b3c4]) by CO6PR10MB5635.namprd10.prod.outlook.com
 ([fe80::1048:7257:2877:b3c4%8]) with mapi id 15.20.6064.017; Tue, 7 Feb 2023
 05:19:59 +0000
From:   Devesh Sharma <devesh.s.sharma@oracle.com>
To:     Dan Carpenter <error27@gmail.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] RDMA/mlx5: check reg_create() create for errors
Thread-Topic: [PATCH] RDMA/mlx5: check reg_create() create for errors
Thread-Index: AQHZOjkC2mM4YMf92UOoyEZs2JhQw67C8HlA
Date:   Tue, 7 Feb 2023 05:19:59 +0000
Message-ID: <CO6PR10MB5635CF50A814C07512F884BDDDDB9@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <Y+ERYy4wN0LsKsm+@kili>
In-Reply-To: <Y+ERYy4wN0LsKsm+@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR10MB5635:EE_|IA0PR10MB7253:EE_
x-ms-office365-filtering-correlation-id: f27a81b4-5808-49c5-6869-08db08caf53a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 456YnbFLONtsbc1KfLc+4Lv2cvY47FUEU90Ira+e5yYmEAaa5s3Yz3s7X+o2pNoDiR1LgelMjglpkvf/0CQqlB9NhekRMousm6QwAObm8E2jrflj9RdrwC+CtFTUaF4GMmRcW2XYUHBklu5mZtTMutP9KSg4MHtCyGM/3DQCWOZ38IkzJEggDXTf9/o3eGL0RS6GKgcrMxLgTpnUfJhVswRufZ5H0BmGrjmiB1I4e+qsYISP6bjNYJvIin7nul1WnifFxi4yCgrBZk34h6PppowBykSl+QCan+57VIC+qTyswrOnqpL8WBDzwqfdAcJZRVwZWtg+dKag2h7jkLPWlPJGMvi71wi3ef2/yK+XElVBd8auY6n697jqsivm9ruLpr3tEztuGtAi7C6f2N8yDWAvku3roWkHx90lVnodX3SHfq/FciOS0eVd4OTJE6aroGW0dlVXtB4HzDmCluazzrh0IIVRika6gb1cRauzzUNEJXkTAmCDW72Hkr9811NFGRfAl2CEPIvq5DQ5ivXGuv3P6qZp4e1EIhUonqIYKHuSos/pLARpWgd8tISnDbpnb7LYHnIiuuq9Nrfnv0N6lpA70TwmmsBabd10Fkl8sRa9ZCcHcjsz21+jNemdBDpbSLea/csUYsw1LNC0dTPMwM459MFFpWlOps723DeIeCGhpAulrSQTexEO2sq9wblCoVpcg32s4F/NItQmer4ptw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5635.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199018)(54906003)(110136005)(316002)(33656002)(38100700002)(86362001)(478600001)(55016003)(38070700005)(122000001)(83380400001)(26005)(55236004)(6506007)(186003)(9686003)(8936002)(53546011)(7696005)(71200400001)(41300700001)(4326008)(2906002)(52536014)(66556008)(5660300002)(66446008)(76116006)(8676002)(66946007)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jg2cPTzk7XTJHHDJ0hypgp2zTyKjZu+gGUz4qG++g6BC8WL+mRiBXQo4Sw2H?=
 =?us-ascii?Q?R0zPh2d+UsUg2+DsQFcxHLiOR4ECIxZ7bKgGkC9Ofnl5OrE0HbIOl/o1DyS3?=
 =?us-ascii?Q?FY2syuig87rHg7Z3oCCq/oxpG5K2Eg1Ce46KIHZsAq1I/xqzixFL3vZF5Ttj?=
 =?us-ascii?Q?sERjCcuCWSVo75KsfpukqLQgyDt8HZCZMHd+om8jez/CEtv++Uz0w1V14yh8?=
 =?us-ascii?Q?1skVsrQPDYsJ7nQLKdKMsAMdF0inTg/GC8MJWNDpU1fTn+TE7p4vNUOroJBp?=
 =?us-ascii?Q?SWRKI3sirhJsuuZrS8nyFFivCaaRWW0M2438MhJ4+ykekVGrculnVyidGXDb?=
 =?us-ascii?Q?i8VCDtoSbckwe8weABHhcUWny6O9Qkfg42azW+FQWXCd5jogwNPO/eybRjQk?=
 =?us-ascii?Q?sMqeLL/1M+QrQDKKi7yVjFLrWJ+Tljmay22jRBZd/p0TfIsdeSFGjzucWnn2?=
 =?us-ascii?Q?vDXWtqy0tyx2u4N0c8b7lWpaAJaDPMWfS6yZF+nN1iK/OMk9srCqzQPfgtMb?=
 =?us-ascii?Q?tf61eg9ItgjHbUfTWyl2+zB8872vPglWDoGMwmvwdIdSScu5mZgXoUnDA9uk?=
 =?us-ascii?Q?ZTpFkPjwYvHoctO/59ITioH7b/KcXfB2cV+jye9VlvfDam6E6/amER18RNFO?=
 =?us-ascii?Q?EyUyEmmJfQBtbbskCxMm8is3KBBGUc5AIBsLqEd/pyiFJFAfdYxaM9Mcy9Sv?=
 =?us-ascii?Q?eU5gPm6AKEQaNDnqVzfeA4hqjXSifBcRhR37R8axaVjWcUDPy2jL79UGJHL2?=
 =?us-ascii?Q?8YnzjX1hc1+CJHi7xs/Utq0f9KXohPgJlRC4AH/0SRAE4MnOE6zbL2KiyxqS?=
 =?us-ascii?Q?Dp2rfko81tOuQeQbvOORx1nS7JES5oyDPMsOEk8o5pBG2S7wnQX6se4vZbTR?=
 =?us-ascii?Q?PuyZQnU/m1pD2Q8JutR88GU8DnYWeNpF+3lRELjkOBYH7XvMVvZOCSiURRdq?=
 =?us-ascii?Q?Tvs0+8m66SjtuK5IYMQYLZDzzbBO1BXBK4Yid66G18k8k0PML0HcMOtMBffo?=
 =?us-ascii?Q?u2em+9AteqMi2gKjpz2dT0m8NgpHeVfaRbLFkLyE7+pZK2ngixTR8FpqKjG+?=
 =?us-ascii?Q?BQfo0vQSj3Vy8CQVfS3H6iiAiffnlBdq7uKyh3OCA1/JXQSak27f/lJAUq1w?=
 =?us-ascii?Q?19uPia4uwkAQ6crX7nRaiYtdettX98HKpGjsvQmrb1iP4XwREc71+SlQbtuS?=
 =?us-ascii?Q?CBVrROmEn6wOoXNUjYzM5z3qZyhkW2vHLI8WM93uo33xDBqw2CnmPcgpZPh+?=
 =?us-ascii?Q?HsFs6qXiWxGSDtpj22GLHrE7ln+sYHOdTF5Jr3bEiET/QHZgljBlFb34dOtT?=
 =?us-ascii?Q?pjQ5i6WfnmMGp1+Xmtid9rWxOvB5Djk6avqAqkQf7bZlwKcLMwaNKJ9quuPu?=
 =?us-ascii?Q?KiRgKX+Y7ll6bk0N5XRAR7YPO/4CN04l+ZlCA7mTNVZYfikxnCfm7sEc3MJ2?=
 =?us-ascii?Q?t9UqpTbM7lDYNdt2JSK1Yi+9IvW176NGLLhVmClcnZJCGsQtfT+6bl1bhhR3?=
 =?us-ascii?Q?ataZRITa01S3IxpBwp7OiEtqe/1zgWC98TCim3kw4GCXWHiGpRhisjp150dI?=
 =?us-ascii?Q?L2nsEYKpjIzekEnX85yXeFW+8QmzYLITqjX+df/CkYxQqqHCu4A97B7gnCQa?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G3IKf3AdWiHaukADz/olHmQPs1scm5ghzgABotQcpEEQiwrrrwlmW80tXOd39T8lB3OuT8EbR5W0Qmg8VGu8JeOKP+PyIH1vhp83HLRSrrkSqI99AgwXcUZeEOs0tX1Sl7ctJcn5yiBWiTD4XufaLHMD8a/AWEjEhDsAxBjTL+GIfNtpaemtFEAo/HuwZnNa4RjZ0o0pHUkN67waBdsn63hvOe/09Tr0qhqocQDJyU01q5SOqpijvIINcVO6rdahtx0olua/W2Vcas9xGEakEp9FEPAONmJiILYqURSnNGNLm/z5Krs3ui4QGNAWCLq/bPMUkauwmat1959yIHmA/tIZk9Mn9CiDtvoSbPm/V8MncSWd5lyDGkKgBfm0M5dQxBuHOvHwJVJrJN1QhA0lF73eYGURpR/AZcqiS0AipRc/svty1pwcDeLO1rLUnt/8Re8TfZV1m/m0lIlRoGgWTkV+lKehhPpaFm8P4IiE0nvynupohcEsAgsBLkKgtFb/qnzwLAtJM2XkHtJzd1056zsPn/t066IHO+1IADVrKUoB+bxA1Nht2L0oJld3aM/HtrCEPCBa4Y8UIb+OGPKCSzK5udrOu+cUkm5ygSTkmyVDh4zd+BRp5Se9FrWhW3fZv+NVHDfg7j088k10LPmsbbLp7TGRbELGL6a66BSGRgn3Y7vXBMtFStiyO4Z75bHBNLoXv/KgVDyKU2GERRO9ka//k6f2c8QpxCDRB+wZn4ZaruAJYsuwSGxo9uIrwjzF2Jm7OkQV572zavk11RFSz8tZygtXVYsJEEbx/R77izp/BvvgX3oBRzMqSwZ5I/gSJ7rq75ANXpl7MdTG4VVGxuGb+E92aDd5xyOdkoMMpsbiucFxYud7y4CKNpSSdio0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5635.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27a81b4-5808-49c5-6869-08db08caf53a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 05:19:59.3562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aU/4ps24qSxny8f1fbdFLEzlFZCqqqqqiB/ZvMRhrkxUZXyfVb/MhpoB6z4SIAVi8QKrTQMSSpWVt+AK1e6SG39LagNr8Kx2YqbRXtzOb8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070047
X-Proofpoint-GUID: I8gy6Zooga8681ywjn4O-BLpHnnRfMtD
X-Proofpoint-ORIG-GUID: I8gy6Zooga8681ywjn4O-BLpHnnRfMtD
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
> From: Dan Carpenter <error27@gmail.com>
> Sent: Monday, February 6, 2023 8:11 PM
> To: Michael Guralnik <michaelgur@nvidia.com>; Leon Romanovsky
> <leon@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>; linux-rdma@vger.kernel.org; kernel-
> janitors@vger.kernel.org
> Subject: [PATCH] RDMA/mlx5: check reg_create() create for errors
>=20
> The reg_create() can fail.  Check for errors before dereferencing it.
>=20
> Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg
> MR flow")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mlx5/mr.c
> b/drivers/infiniband/hw/mlx5/mr.c index c396b942d0c8..2feab0818a76
> 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1164,6 +1164,8 @@ static struct mlx5_ib_mr
> *alloc_cacheable_mr(struct ib_pd *pd,
>  		mutex_lock(&dev->slow_path_mutex);
>  		mr =3D reg_create(pd, umem, iova, access_flags, page_size,
> false);
>  		mutex_unlock(&dev->slow_path_mutex);
> +		if (IS_ERR(mr))
> +			return mr;


Looks good
Reviewed-by: Devesh Sharma <devesh.s.sharma@oracle.com>

>  		mr->mmkey.rb_key =3D rb_key;
>  		return mr;
>  	}
> --
> 2.35.1

