Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 057DD149705
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2020 18:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgAYRrl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 12:47:41 -0500
Received: from mail-eopbgr10055.outbound.protection.outlook.com ([40.107.1.55]:7643
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbgAYRrk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 Jan 2020 12:47:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcOayp7FC/ZPa1Y7yjW31XO0SySdMrM2+pQ3szkUtEgLUzQPdYxdNRT3KNLkGv9s1fC6YoyT75RqYA3J6lQ+E/WUcBC20rJmi2831RbqAL3q2juZDyGG3//f+Qb5/lnCjOAfZCVNw6BN1M7XE60ne1SZsR4VO0xtFEtQd6+qCe5LoLQOuleSbsZTpEP7quwvFgGQaAzUzlXcEdmXzuwj8HYqgw8nKvrZFNi0Buv1cVDuF6SGElS+dn9SesjL7h2RNcNg46Dhwq4LRg8N5RLtdEytF28WlggoXQBNzmlgm8KYocRb+UMcmH02cKObwbSAAOnMQBnn5VgEG92slUQEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdgw9pNcoHs6aRypynbaJjezu+DGwzJ8T1EOKK1o4TM=;
 b=FDOeqah3pCr+p22Uns2AxiCpDU2slKoE79cv+jex8s/V7/1DfTXsAeRg8kMximOFexkjJOjqbh85glP+45xRbwKThNun+E8quj0mzuhcqO9Y3Ii+gyHCjV7ih9dl6GqyCrXBBQRGGCEbzCGvH28Uc7W6u5c8ds1AW8C7PEgyIt8WlzRE/CaJ2c0LJGmdbuzTFzEHtnRKk6FopRzOXWd/G0p3L+WjSiNUETEN/kBtO4UafSbjSsjAe9vYGxoP81+X30QkVdsTeAsQ0/9i3bqOc+d19GCT2x00Mixm9HNp+22YBO2aq8tDQkg5KeB1jONusZPfLIlTlUsuFFNDaHdz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdgw9pNcoHs6aRypynbaJjezu+DGwzJ8T1EOKK1o4TM=;
 b=sq49AytdxEVs5ofVjXyG5WWLZ64dKu70+EY9zgsaFJYmZNYKi3PKxJwvH/QFHHCdFX7//BtpUKvR2cWtMQrOg9gf7CrjSYPkYa44jmtfFC+QIqiODMnC56909aiRDch5KJhwawpst9arFTWdOlWZJUneZTvw8hJ3WPM/kpJm4Ns=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5533.eurprd05.prod.outlook.com (20.177.201.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Sat, 25 Jan 2020 17:46:54 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2665.017; Sat, 25 Jan 2020
 17:46:54 +0000
Received: from mlx.ziepe.ca (199.167.24.140) by CH2PR20CA0010.namprd20.prod.outlook.com (2603:10b6:610:58::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Sat, 25 Jan 2020 17:46:54 +0000
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)    (envelope-from <jgg@mellanox.com>)      id 1ivPW9-0001Om-2Y; Sat, 25 Jan 2020 13:46:45 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation
 code
Thread-Topic: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation
 code
Thread-Index: AQHV0nqI8Sur4+WGwUOpidOClB9ataf7qdyA
Date:   Sat, 25 Jan 2020 17:46:54 +0000
Message-ID: <20200125174645.GC4616@mellanox.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
In-Reply-To: <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:610:58::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0cde108-3f82-4e21-a91c-08d7a1be90b9
x-ms-traffictypediagnostic: VI1PR05MB5533:
x-microsoft-antispam-prvs: <VI1PR05MB5533BF9BDE795BBAD660DFD6CF090@VI1PR05MB5533.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0293D40691
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(8936002)(52116002)(478600001)(316002)(81156014)(81166006)(71200400001)(8676002)(5660300002)(36756003)(54906003)(6666004)(9746002)(9786002)(186003)(1076003)(86362001)(66946007)(6916009)(4326008)(2906002)(33656002)(64756008)(66446008)(26005)(2616005)(66476007)(66556008)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5533;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vJW4pFyniJTQtzKVkqPklHnqC95iaW0rFf7eKYJOik5BUr8EAuKSgDzLH8W7Tj5kHjNJ5TWXuVHPQPES9iGIW3tC+uJvvGgtFxmYXRyAFoIoeoKofdaUpNN0sx6aye37WSxYQqE2zaIKesA8NiiZQ+sSuWFhFcSUrfq/hP0fNCrEWXOU6Amgl94/VbRgvDbVWyoY6kJD8LQzfeMG+ItO0byaT+Rv6O/J7d87HcFjSaqUR0PIC+JW12HcGTSho8x4vxnyaeQywRaofUaLXPJR59qklmx/VUqrh9fV04ZcqxHcqzNjPDB6km8Sfnri8kRO2M0vchG02ytMesOWT3KalBUVnoOTOWSmwEJ9/qZb8ZeLgM9l9s+brmr1P8Kh+FAY3+5YxyPxUhKZ0EYIy/vcstVLI10ap46YPPZF+L4oXHxQ8MH0QGOgY+CkkMd7HgBxvBtZgPLLD39pJb2Yd+MwoQcEZmI5QDVF0pNIcKwpxFKWwq29a2QX4sJKVpWPvgo
x-ms-exchange-antispam-messagedata: D6PebN9dlR1uAoBgKdBhxsqLrPwem+olFUoQ6VOEwnEcar4rVjFHVFhzRfFjeCIKhuzJZboiy0BE5ZQ4bkzh6Gmcy/n3sZFc+UAQWI3CFV0ThWvPFoHI83pELfTuBPgPjh8xDicwWCNPDC6MGYqrXw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ABE614888DED034DA1B4DE409EC8E17A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cde108-3f82-4e21-a91c-08d7a1be90b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2020 17:46:54.2268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAIKZ0hQ/yvhZF2+KoxV/KPK8gnN1FmylIGUu330cIPm0YC2G7D9D2bi59Z4oW2F6UH5mFFVqKi0OaH0xJjMMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5533
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 24, 2020 at 12:52:39AM -0500, Devesh Sharma wrote:
> +static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
> +{
> +	struct bnxt_re_qp *gsi_sqp;
> +	struct bnxt_re_ah *gsi_sah;
> +	struct bnxt_re_dev *rdev;
> +	int rc =3D 0;
> +
> +	rdev =3D qp->rdev;
> +	gsi_sqp =3D rdev->gsi_ctx.gsi_sqp;
> +	gsi_sah =3D rdev->gsi_ctx.gsi_sah;
> +
> +	/* remove from active qp list */
> +	mutex_lock(&rdev->qp_lock);
> +	list_del(&gsi_sqp->list);
> +	atomic_dec(&rdev->qp_count);
> +	mutex_unlock(&rdev->qp_lock);
> +
> +	dev_dbg(rdev_to_dev(rdev), "Destroy the shadow AH\n");
> +	bnxt_qplib_destroy_ah(&rdev->qplib_res,
> +			      &gsi_sah->qplib_ah,
> +			      true);
> +	bnxt_qplib_clean_qp(&qp->qplib_qp);
> +
> +	dev_dbg(rdev_to_dev(rdev), "Destroy the shadow QP\n");
> +	rc =3D bnxt_qplib_destroy_qp(&rdev->qplib_res, &gsi_sqp->qplib_qp);
> +	if (rc) {
> +		dev_err(rdev_to_dev(rdev), "Destroy Shadow QP failed");
> +		goto fail;
> +	}
> +	bnxt_qplib_free_qp_res(&rdev->qplib_res, &gsi_sqp->qplib_qp);
> +
> +	kfree(rdev->gsi_ctx.sqp_tbl);
> +	kfree(gsi_sah);
> +	kfree(gsi_sqp);
> +	rdev->gsi_ctx.gsi_sqp =3D NULL;
> +	rdev->gsi_ctx.gsi_sah =3D NULL;
> +	rdev->gsi_ctx.sqp_tbl =3D NULL;
> +
> +	return 0;
> +fail:
> +	mutex_lock(&rdev->qp_lock);
> +	list_add_tail(&gsi_sqp->list, &rdev->qp_list);
> +	atomic_inc(&rdev->qp_count);
> +	mutex_unlock(&rdev->qp_lock);
> +	return rc;

This error unwind approach looks racy. destroy is not allowed to
fail, so why all this mess?

>  /* Queue Pairs */
>  int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
>  {
> @@ -750,10 +797,18 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct =
ib_udata *udata)
>  	unsigned int flags;
>  	int rc;
> =20
> +	mutex_lock(&rdev->qp_lock);
> +	list_del(&qp->list);
> +	atomic_dec(&rdev->qp_count);
> +	mutex_unlock(&rdev->qp_lock);
>  	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
>  	rc =3D bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
>  	if (rc) {
>  		dev_err(rdev_to_dev(rdev), "Failed to destroy HW QP");
> +		mutex_lock(&rdev->qp_lock);
> +		list_add_tail(&qp->list, &rdev->qp_list);
> +		atomic_inc(&rdev->qp_count);
> +		mutex_unlock(&rdev->qp_lock);
>  		return rc;
>  	}

More..

Jason
