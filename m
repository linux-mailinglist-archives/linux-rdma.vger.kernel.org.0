Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1345DE72D4
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 14:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbfJ1Npi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 09:45:38 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:46553
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfJ1Npi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 09:45:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLlHHt3bVMPWYhhrmUP+FrNUJo06StIr9Ap/KpXqldcFw4tDpFQvmxg1WuvS0EHICnuqIjiTO5qNlhcDbGHsVyCfDJweWPbaVfcO0ugG5PPbpztXWrCqi0YQ+C8ORqvxrQvfGdQJOYhk/vRchLHeRb5eN/O+DIzXsUzr9HO9YFs4aKy3h6VILJhYBccBTu4c7suv/FRIH0fnrvx1GEFMJk/yDaGPcfWVlcW8Qdra/dSHutERUcqGREb2U2uoj7bQIpy3IjbhrEa3hTKSHcWAMrDIZ1TSPizjunuBAKG3kIVYRb3hLhZ5oMBOIv5n4EhevSG5g3MRkdohHYZWdmTPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl/tpSFI6eqPeMx+22HAU6qgN8RV3qgA0repV5E8oxQ=;
 b=U2+aSd0bbY/QDrezLamY4BskQFJV5ZLYdZFC+N6UN4hN8ZcjDFKqItwIpim0nN0fRubGFL9VN9JfqjP4rFwPobmR2NuNkgNdsnfZmGwQB6G6bP5igfexcNcRl5zM5n5iEvxaxgqwZwuNyssMKRRqO+KfSGiosvGkfusESq8gmnXug5arkGYfpx+ONgnbSpRLwNN4xaf56I4ruFhNmnqN+wG/02s63O2GGg5MKSWXR0+yveKUdUEecZAcf4YR+XP/zVbdYUxrzckL6yUBrQ8daRLHqrOLFPXDrSv1BfO7vndp/2MQwTHeq7EdLLAs8YU50k+JBbjzmF8ZHuQPPNetBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xl/tpSFI6eqPeMx+22HAU6qgN8RV3qgA0repV5E8oxQ=;
 b=hb6J99xUdxL8spdcbnXZ0uOax3C9qRQvK4lnKDJsBmYgTgDhUiVr2rdIM0LFCKd5jgyh5LclB5bnyTVan2S2f4vhqULVVr9NmuPAHb7/32bfObz3dr1NdDOum0N8kahKAthv+XhpvWyEa0yNWPvrur2s71PImbsjbnJGWyh0IAI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5279.eurprd05.prod.outlook.com (20.178.11.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Mon, 28 Oct 2019 13:45:33 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 13:45:33 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next] RDMA/ucma: Protect kernel from QPN larger than
 declared in IBTA
Thread-Topic: [PATCH rdma-next] RDMA/ucma: Protect kernel from QPN larger than
 declared in IBTA
Thread-Index: AQHVjZXhNNwE2U1aM0m21YzB8gYYzadwEL4A
Date:   Mon, 28 Oct 2019 13:45:33 +0000
Message-ID: <20191028134528.GW22766@mellanox.com>
References: <20191028134444.25537-1-leon@kernel.org>
In-Reply-To: <20191028134444.25537-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:805:de::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f63d3f3f-fd8f-4a53-da8a-08d75bad1ae7
x-ms-traffictypediagnostic: VI1PR05MB5279:|VI1PR05MB5279:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5279752E0712D0644CB4423FCF660@VI1PR05MB5279.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(26005)(1076003)(386003)(76176011)(102836004)(305945005)(8676002)(6506007)(71200400001)(71190400001)(81156014)(81166006)(486006)(478600001)(8936002)(11346002)(446003)(2616005)(7736002)(86362001)(229853002)(476003)(256004)(66066001)(14444005)(33656002)(186003)(3846002)(6116002)(2906002)(66946007)(66476007)(66556008)(64756008)(66446008)(36756003)(316002)(4326008)(54906003)(4744005)(52116002)(6436002)(6246003)(14454004)(6486002)(25786009)(6916009)(99286004)(6512007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5279;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z54a+HyG9GsLIc5pskCVAPJ9EM166xXLaVhfzn2J1WNkxypdf2gGsOW2A4BPavG4wJIvC6PQPBtrPNawtRSGgdiZNJzXgxdh0rMbKdZB33fsybW5NjbGfvLGgqceMvDXAFPJxfLkdG8i9uojQew/K576KcOTh33dESg/No88QEfLAIAeSF5vWbG2Ua0wrGEatNWZ8cCBXI+Pjr27uEZYm/V7dkY/TafUxZbYTmWOPBg3JPjiCrFzOE3Kq5RAxde00nSI+ODPiV13yvIQGWMw9ggoiMNGlWbABPo5OYkaBlRh8pxAU6jyaPrDzoQ+pSIzKOToVqDVJxxdHOu5Snxr9JeTjTrIJYzVuiocwJ541fR4APR+DlrB+xoAjpeiwH44ZIwkXR8Hw/Z54yCT6cnNCa3AR+QlMX3ru1kM103neqkzMLpypf0GPZ3BRpAgpFGf
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7178BFAF16225A47AE5E1B2DD31E3AA0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63d3f3f-fd8f-4a53-da8a-08d75bad1ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 13:45:33.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywZ2MUOG+AFiaQXMWz3vwYFT1blSngu465KVVFHpj0oEhMAUdhsXBSCb8OoYUusuNgyQPlGIRhprbMBSGj05+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5279
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 03:44:44PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> IBTA declares QPN as 24bits, mask input to ensure that kernel
> doesn't get higher bits.
>=20
> Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  * Not fully tested yet, passed sanity tests for now.
>  drivers/infiniband/core/ucma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucm=
a.c
> index 0274e9b704be..57e68491a2fd 100644
> +++ b/drivers/infiniband/core/ucma.c
> @@ -1045,7 +1045,7 @@ static void ucma_copy_conn_param(struct rdma_cm_id =
*id,
>  	dst->retry_count =3D src->retry_count;
>  	dst->rnr_retry_count =3D src->rnr_retry_count;
>  	dst->srq =3D src->srq;

srq too?

Jason
