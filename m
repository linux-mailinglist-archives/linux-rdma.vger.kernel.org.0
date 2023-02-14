Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D195C696BD8
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 18:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjBNRhz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 12:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjBNRhy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 12:37:54 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF877A86
        for <linux-rdma@vger.kernel.org>; Tue, 14 Feb 2023 09:37:52 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EHLTT4025618;
        Tue, 14 Feb 2023 17:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=/RLOmUwHHuCEhN/OJRO9cwD6iiXPxEwLxZOpeggchPA=;
 b=TDx4gHe3ZXRrwOgS32dp5A3XsH+L676ezBpIXJIdygBxZgybZagCnxbSHQo+BwAlF05A
 9m4zOeMwCs08eAxlV6e6uDcneivdM0E5M/nPJmTK8jMMIIJ19iUb2pNUQfTazmFLrnJM
 HiCy+zSv1pNqNYOdwqFcoUvJoorPSW60WQJy+I2dih2hWKJK8OnjwJWrdsagU9qJeM4a
 2fsKT5ms/YgBoGclkOXto5ouwAcKaS9GB0SMwM5G2F5+5zr6CxjkCSoPb6UntEoUBpTY
 ve/+mNLDqofX5GKnBMwnXZCUzrlLhCfNXiKlNZ6mi+WYRhrQhUpPw3/l/lzXNM9MIdg8 Rw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3nremm0ajp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 17:37:40 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 9CBB312EA7;
        Tue, 14 Feb 2023 17:33:46 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 05:33:46 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Tue, 14 Feb 2023 05:33:46 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 05:33:41 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjxJOGQKs4n5tvpDpKB6CPp86RuumGpu/q4KrdFPhkjtoRA63UnWRfzpQStwxtWt5XH33CWzi9O59aNVFFFMgYPXeVNOja1+HO9p6lxu2R4LRQK0LRWDRJ4Cj35n7JjpfJx46xPaPxzxabUuEqrR1iKx679Tl8RoXGX20NNKlVverlFKZUAIm9vcGgnzvSxZt5v+ESByNqperTQNg/svibW8fyUvPnONcj184a/8CzKJDqezGXAjy5EhA9dBrhqJ10SGrgTiqJAippJbeV6g5wiP1CPQx+1zh+BHXScWRUV2PRu7avb4vgZsr84gB7r5zC/HEhixR93slek9X/g8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RLOmUwHHuCEhN/OJRO9cwD6iiXPxEwLxZOpeggchPA=;
 b=UVPBO+V9qVgPzQpoVoJcFn28xkSISb6k2Xz1ycYv79QmCdirU+0AIYEuKdaJsGEmg6Rj8+E81wuwLGUu/Io7T7P2U8AXuoJKNEDEd58L8TIW8ltMk2iojFB8AU8sSvzugTQBrLGsORM/M/3sRd6670nfY6M5gmqvQRBMyes+NZdwxl6IJ0VPqYAC4n6DlktcBokx+cRdVLwEZ+4u6wNDs4UhNZtlcnrJ0+OGO+7tflFwCYivagN0eVNgeJzsuc/5J60OdWFqrmlg0JbQLM1AuW/qJiYydnV1LWZ4JDtTiLhnJF49M72JXETlaGrxqj7qUtdsjJNR6LkAvUIofwrvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by MW4PR84MB1801.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 17:33:40 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ae3c:4589:53f5:b70f]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ae3c:4589:53f5:b70f%9]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 17:33:38 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Devesh Sharma <devesh.s.sharma@oracle.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/rxe: Remove rxe_alloc()
Thread-Topic: [PATCH for-next] RDMA/rxe: Remove rxe_alloc()
Thread-Index: AQHZP/8GswMIVyQCNEexdQv9bTVSI67N1eeAgADe7JA=
Date:   Tue, 14 Feb 2023 17:33:38 +0000
Message-ID: <MW4PR84MB2307467DCD4EA00B432A3659BCA29@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230213225551.12437-1-rpearsonhpe@gmail.com>
 <CO6PR10MB5635D2C3386321B57BCE70ACDDA29@CO6PR10MB5635.namprd10.prod.outlook.com>
In-Reply-To: <CO6PR10MB5635D2C3386321B57BCE70ACDDA29@CO6PR10MB5635.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR84MB2307:EE_|MW4PR84MB1801:EE_
x-ms-office365-filtering-correlation-id: 34aadd5c-13c4-4390-3004-08db0eb19bc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2BH4yt8Np5+AQjpxrieHC9DoAq1eVOTEUm7uSXXF6UW0R9A1D/NfNwBHbHUUHX9A66Vjos638rBEfLWvDCvMhja5u9TCspJWj3bvQoSk/d1bpUNwj+JrbGNHDu64HQcx0hTPUZLDk/Ao7f8Qy5DsI20bhs/lvkAC5taEqLrVdCcRGkEeSFTDplEquu4Ed467dC0/QXphk6cjIQGsFF5J96I2oP8/+Dwt57mk5gbtU8R+MS1jDzcMtObKpCAD3vjrx4O57IpjQkSdKtKCi+Gz5D6Lj0B8DscM0mFTgR3QiL0mDRWGlazFxUXZ3BTXOamXy5nkmuLcoFI5Pn0kiMpApPUU4jm9vHcOmeSLSCJALbPb8rIRVNyWEnpgbl4S/ss9vNYlWV79blwpXGmghtuGDGQhIS9QRcfjyN2Lw4SH6kddaHxEmnadHdmsUqS85dnx0Xzda0oVM0Oo1Mk2oEhGqxfJ/x87vOsWerHCGs6uQob/FJHdozELfibmmq21MhT+fmazvf6uSLoeB+Z4zVwIxurhq+kMX+joVaMkuVr2KOv4pflOJVGNmQhsO5xnl1zGyU8MM6MRljE04AVnXquyyTc5zPqf1hfXwrqFQSt2chpMX9hnSkwJkADhZPzoJJQyO1ih8nPdjRch2TGz0WxaKOl9Qgk4ffY1Ij62QaVZxhUwqsApoWgfCCFj9rPRPfKDFlc6P7k/7XUXxAlSbxIAJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199018)(7696005)(478600001)(71200400001)(316002)(66476007)(66556008)(66946007)(76116006)(66446008)(64756008)(110136005)(8676002)(53546011)(41300700001)(9686003)(26005)(5660300002)(6506007)(186003)(52536014)(8936002)(2906002)(83380400001)(55016003)(122000001)(38100700002)(82960400001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fmFx6f6PdIDrRPNAHjPD5+KqBmyW9Mjzkjn2j6fTsli43zmffHBcMTNfB0hr?=
 =?us-ascii?Q?Jzef26HkQWUFX6U/ZhwDCf68Z0lBd653WRna9YZvi79yVLz9hvzF2vg0UA58?=
 =?us-ascii?Q?dAqxbD/2+lDAeqb9futRo2xP1jH3QGn5yoFe48mZ0DFcZqzRRukRj/5ePNSa?=
 =?us-ascii?Q?Kxo6JQJ8Y3ZQLU1dWO/2SE0WqgAcOnEMpoQmwCXIaF0dyLk7LhHAYQ+qpQ1Y?=
 =?us-ascii?Q?yUODDAEkpVYOTFAGUBiJxT3mUvpMiB9ygTIbyLpunxUHadbUFgNF+8AJn4G8?=
 =?us-ascii?Q?LYhvuAKBWDhV/rdVdLwhyJ5CtwVzsIRQum8l4ZG5NKfnUXL0M3V3IG7Myrzy?=
 =?us-ascii?Q?ZMB+b4Ozd1T1L/kfGVvsobf8uWqm1qeS3N8Zoi/Kw0gaX0Kl6eJsWUnUVFhg?=
 =?us-ascii?Q?u47dVMpbBAuU2F+T3pmsxDginesPJRw6lhaCzOenNvCysb4ySvdIGqbezGnF?=
 =?us-ascii?Q?4eSa8rBI+fq031O88CRyGWDZBz7G+k+TyDlrjPpR81Mfg+xcAlmBndrOYQY5?=
 =?us-ascii?Q?EIjKD8dUag2hitYk63xdPTf6+BTAj4eRfXDeEnrZwPWjhpWbpamD//rWwm2q?=
 =?us-ascii?Q?T/E4AbvcYQ859J6vlxBmQVxJx1WJUWMqULeX8hGXAW97CGEVZYSSxJG0/Sez?=
 =?us-ascii?Q?3gkUmC+3ViHQbn1BRNxIEbtFB7KdVx3L2o8Q6lcu39MDzovIIyMGdShpgRYx?=
 =?us-ascii?Q?+8KE0faGRtqPULpWd4qW0xRzSm5m87A7F5C+t0W4KMaAAnRvFkeycbhNgJ0b?=
 =?us-ascii?Q?axL6RlmY7NkLKnKapEG0nozu/vXYK/9X0nnhyPRivhVqUskexmikDrzHI5aS?=
 =?us-ascii?Q?kMzVKvpduL0MkBUAO1kQvDfcamyG82G12U6rxHh02D2dNjpe6rLRyavzDfxZ?=
 =?us-ascii?Q?eB3tRpwttl5vuYnnIC6qvsoiZLiYiwcJuXyMuTqiN3cl2HTjoQG9mVfAn1et?=
 =?us-ascii?Q?Fgocg8YQ7twXOl93NKtNEMASAzFKSkmicAM1nWObawXw/sycR+f6GVkb9M1h?=
 =?us-ascii?Q?6FnzNtpxF2FPjFchxOx7Jz5T452f6m2Cs5KrHtdQ0jeLMBF5kBhoVCerLIIr?=
 =?us-ascii?Q?R8Gk375W6rkGdiHQ48N5HT4JwhflddN5pnxZ+UvRntUs5evPVTrvT1Vo5EUl?=
 =?us-ascii?Q?pmSuD+j5jdE7u44maJaYVHwPwYhoRCFmnzButr/3NzLMA3qR0K1X75LEFxKU?=
 =?us-ascii?Q?6I7YNINlspe0SmUg4iYAygQGJOZiEmlE/Zt6XmtMwSDvMbMmeH6gxBwK3cXG?=
 =?us-ascii?Q?C7hNu5dN9lF6b7+gYanNC1JSet2o2nBe+Xmz+9yX3lml4OTqdv4PzA1pMKpg?=
 =?us-ascii?Q?Q9STQJ5WNkWOUGbCUlCTHzeOnHBv8lCvTr+c79mpayJnOrkUXT5At1X4nnNV?=
 =?us-ascii?Q?j/f1jQIAydye6LUH3AR18z/BQoejHdqsp6/BitZs+eMBjNvKdbKZbpLixuXL?=
 =?us-ascii?Q?+WuZiLUzj2WKbCXjC2NGHxOVnncAn1D1RSNy843QJ6n8elHuUe/3gGZ5E1MY?=
 =?us-ascii?Q?zO0nyxTm57g/pGBXd6rYAslXKKtwgyg8U/Q5WdL+ZwRMwbND02QJhLtDLXZw?=
 =?us-ascii?Q?BKKARydyhApHRkOqiw1ozuUzQ+QZWA8XZAvx9LIr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 34aadd5c-13c4-4390-3004-08db0eb19bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 17:33:38.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdWgxPLA3CEUkm1KPPcjRyWbiMKJhVGgY2p9iRqgsodWdq1SxNeV9ujyhU4VfaXuetlTUKJ/CUJ3Z6LYZ/tFwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1801
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: wgHmciqOrSPgith6QCf1tE4JMn6FaiLQ
X-Proofpoint-GUID: wgHmciqOrSPgith6QCf1tE4JMn6FaiLQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 spamscore=0 clxscore=1011 phishscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140150
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Devish. - Bob

-----Original Message-----
From: Devesh Sharma <devesh.s.sharma@oracle.com>=20
Sent: Monday, February 13, 2023 10:15 PM
To: Bob Pearson <rpearsonhpe@gmail.com>; jgg@nvidia.com; zyjzyj2000@gmail.c=
om; linux-rdma@vger.kernel.org
Cc: Pearson, Robert B <robert.pearson2@hpe.com>
Subject: RE: [PATCH for-next] RDMA/rxe: Remove rxe_alloc()

> -----Original Message-----
> From: Bob Pearson <rpearsonhpe@gmail.com>
> Sent: Tuesday, February 14, 2023 4:26 AM
> To: jgg@nvidia.com; zyjzyj2000@gmail.com; linux-rdma@vger.kernel.org
> Cc: Bob Pearson <rpearsonhpe@gmail.com>; rpearson@hpe.com
> Subject: [PATCH for-next] RDMA/rxe: Remove rxe_alloc()
>=20
> Currently all the object types in the rxe driver are allocated in=20
> rdma-core except for MRs. By moving tha kzalloc() call outside of the=20
> pool code the
> rxe_alloc() subroutine can be eliminated and code checking for MR as a=20
> special case can be removed.
>=20
> This patch moves the kzalloc() and kfree_rcu() calls into the mr=20
> registration and destruction verbs. It removes that code from=20
> rxe_pool.c including the
> rxe_alloc() subroutine which is no longer used.
>=20
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
>  drivers/infiniband/sw/rxe/rxe_pool.c  | 46 --------------------=20
> drivers/infiniband/sw/rxe/rxe_pool.h  |  3 --=20
> drivers/infiniband/sw/rxe/rxe_verbs.c | 61 +++++++++++++++++++--------
>  4 files changed, 45 insertions(+), 67 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
> b/drivers/infiniband/sw/rxe/rxe_mr.c
> index c80458634962..c79a4161a6ae 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -724,7 +724,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct=20
> ib_udata
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
> -void *rxe_alloc(struct rxe_pool *pool) -{
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
> @@ -54,9 +54,6 @@ void rxe_pool_init(struct rxe_dev *rxe, struct=20
> rxe_pool *pool,
>  /* free resources from object pool */  void rxe_pool_cleanup(struct=20
> rxe_pool *pool);
>=20
> -/* allocate an object from pool */
> -void *rxe_alloc(struct rxe_pool *pool);
> -
>  /* connect already allocated object to pool */  int=20
> __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>  				bool sleepable);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c
> b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 7a902e0a0607..268be6983c1e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -869,10 +869,17 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd=20
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
> @@ -880,8 +887,12 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd=20
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
>  static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, @@ -895,9=20
> +906,15 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
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
> @@ -905,14 +922,16 @@ static struct ib_mr *rxe_reg_user_mr(struct=20
> ib_pd *ibpd,
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
> @@ -927,24 +946,32 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd=20
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

