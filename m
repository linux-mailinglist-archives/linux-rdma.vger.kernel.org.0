Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5B4164AE7
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 17:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSQrn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 11:47:43 -0500
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:7171
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbgBSQrm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 11:47:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6yZWyNDjsYapLszFMQRoryeqEWFwgu6INvWsu/Jbm6PqbslCzbkpSHos5KTfX1/49XbtiUMpwmzObJBWOxH2qD7ym+33rSdGVSHjrOpDEe+MV4zOiIaMyN6i657EWdeFCh5t+VSw52QY1cJrHbRUcWP4MxscQwiWLnqykD8Dc+Yri6nrPuFmv5RIBB/HeXEZ+ROcfdI0FTPsBA2PsRZnhRrbUBjXQV6b5vjVcUa+TjE2XT0JgTO0DXM/09V4L2rfqHTAyhlr3Ewn1rGQKxHIq5aQuQMIzVuuNarVkL2r3OhxkrWjYtIHyHq4ewbUWY3Bbu4AoEiNzeFQVkSVZ5ygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxZCqQIs0nqGdcuRE9JB910uAHEXtIW/sES7UbUl0T4=;
 b=VlwM5SSwj9txQpgikHGMiRRolxAN/f2GTDUH2r5uB97ZNhAUeNW8Ut9/bN3qI1tdFED0Ik08UCMZHUMngiL9WMe4ybtw7Mea2dEj7/rTiviT+xFy2ZRURiLIgn2XOaVKdrMEayOZTYAgd7gWzthfp6oSXMaCXepWAwwgeC6w3ilGuSZroGUIcptOhJv7h1ZR67QVFym7+SR21MlgTphQc2BOlj4/1yiz+gGqm3bLo1FSsDP4KrkJVNJZYAwWokAL3/TQw4M9QFUqjLkt8J/gY0DbQYViLZlo9dpp4qurZuzMxOO2lG2VIE5e0KdBurGtSHk15Jmni/sYmI+ggjoRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxZCqQIs0nqGdcuRE9JB910uAHEXtIW/sES7UbUl0T4=;
 b=ZntcitfFnRmB0T5edfl+SE9bM8jDWn6fu9rfsHlEMStw0uk35vu/TsS8dxtoBCp9ViFPPbHfXZB14+IKA+G63Jq69BVtVQWR0fBq//fW1xtXxWb2Iv4T0KLoXAGFIQIYoaChQu4A5rv7zthGRQlwQS5NBTiIfaanspVojmN+VQ4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3488.eurprd05.prod.outlook.com (10.170.239.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 19 Feb 2020 16:47:39 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 16:47:39 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR0102CA0016.prod.exchangelabs.com (2603:10b6:207:18::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 16:47:39 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j4SVb-00051N-UR; Wed, 19 Feb 2020 12:47:35 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/1] RDMA/rw: map P2P memory correctly for signature
 operations
Thread-Topic: [PATCH 1/1] RDMA/rw: map P2P memory correctly for signature
 operations
Thread-Index: AQHV5zs66H1tqb7myUWFP8qGIjLOzqgiuhyA
Date:   Wed, 19 Feb 2020 16:47:39 +0000
Message-ID: <20200219164735.GK23930@mellanox.com>
References: <20200219154142.9894-1-maxg@mellanox.com>
In-Reply-To: <20200219154142.9894-1-maxg@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0016.prod.exchangelabs.com
 (2603:10b6:207:18::29) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 109ae7de-412e-47ab-188c-08d7b55b6e5d
x-ms-traffictypediagnostic: VI1PR05MB3488:|VI1PR05MB3488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB348854D13B774935541662D3CF100@VI1PR05MB3488.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(2616005)(9786002)(71200400001)(9746002)(86362001)(6636002)(81156014)(8676002)(8936002)(52116002)(36756003)(4744005)(4326008)(6862004)(81166006)(5660300002)(26005)(37006003)(54906003)(186003)(66476007)(316002)(66446008)(66556008)(66946007)(64756008)(33656002)(2906002)(478600001)(1076003)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3488;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nm6UkjcTBnyQutnBr0ScmUUMnDgZ+IeTAajdpmyXmbhSZ2ygGH8D81Haw8ejCMMsPYhfvw/SJxDD4GhMAA1Zro3OMu6ahVkiff7K935tBKrX/CD4CA++uGKu203PfbSghMz1OorvhMg3xFPjlZm9awjyMtAHDgBJiTWDLp4rwnQpKNzkNS5ksgYaI7Gi8EE8PprFPTKPvhsqAP25B/1jdmr3pOehbcMWmRcl7GZoW0zqsifdC29jZVOIwh9+DgJnly1GOvvFwSgfGskOdcNdusIyWsqwK+yohHjEuDqpQYB9d0OvRGfmk6Cl0F1HiwlcaB3J73Usrvg8LURHI5i9xF0uVlFDddcttDe2bY9K/8INbgFIdoQawW90im4w8Gwt+a6TXrUZrh8N1sHJ8L2VJ8UEQkTFuyvHO3KrI0fIoCIWcSXwEKOAlMDadKru0+9lnCC5hCxxtYtpF/o49QqvNmUiG7UazTMopkGZiwgQ7NRdfY21dsbERY8e7usjSLeA
x-ms-exchange-antispam-messagedata: /Og44A7y+Iofc9VMv96aJwk20Dz2+0yGwX3b4vaoGfYExWiptMYi7XlbsAW2gDchJCWLLf4V/ArG6OiLEdT8M8DWZThwOw82Sf91QnjDVWHHA1he/8LfqIjmmsFK3hgsA+0l+FNRho5L84NbKkOk5w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <454211F0B45F5741B31656DA8FE54C3F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109ae7de-412e-47ab-188c-08d7b55b6e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 16:47:39.6579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6+GuRyRTsFh+5TTEuuSBsYyhSnZAk8VCPFuf1//NJhk3wI7T2BdnlODFoHPB7EuMrRx0JLijqW46bfAhu1G8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3488
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 05:41:42PM +0200, Max Gurtovoy wrote:
> Since RDMA rw API support operations with P2P memory sg list, make sure
> to map/unmap the scatter list for signature operation correctly. while
> we're here, fix an error flow that doesn't unmap the sg list according
> to the memory type.
>=20
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>  drivers/infiniband/core/rw.c | 44 +++++++++++++++++++++++++++-----------=
------
>  1 file changed, 27 insertions(+), 17 deletions(-)

Can you split the bug fix out please?

Jason
