Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE17C149712
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2020 19:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgAYSEU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 13:04:20 -0500
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:32676
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbgAYSET (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 Jan 2020 13:04:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW161WOTCDsjS15ppWGbVa7IA79Z8/I1+NVUeETygtT98dFDEieDTWD5/yYPt9wZFsjBhf7nS/0iPBRsbrjunWo1NmEzdDjd6/AkFfFg36uTk5MlSRIIpM0iEJFZwKSCW0uxyhDdRhi2wlvv13hTtrl033WS6ZdGEx76i9aXJBZ31AxndYsSzPav1CvQvDLr5lY5QlBJZ3HnV8e9bmY4Vlsotk65pSQXTrezJUN/nZvx7xxPwYelHOPEamnIQhqrwEvvpaQfz0wXc3xHlcjZ1DhjZhBoMROEdmmIhyTbqGAK3O6iArr/cPHy8siWB5B6RqPPDv0I2gxvlMKRkpDFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4RkKlfDfmFRBNGwg/WfA2XpbKIzUk3ZGVgW5Y/akwM=;
 b=F4rJeMI7p7ZtyiudV6GVqmRcMYeFnvOj1fou6Bcl4oXAxHg2ESlAwUb8g3t+PIwh6oAxVezfAGK77R6NqA5wbPyihDx1a+WK0wb57PV19uDjpElDlCPEuCP+O7neVYaXNXF0AoJFvvcM1SY1EL5SqCPumiNg0BetKIkC1Gg1k1RUikGj02N6qrHsZjJaJ+WJxWesZGnJhVh4j7Hkes6JhV6XcUADurDbDJ5QM5CxV1T0LZ1XnZbex7NsTY5MwWKsdBfryLUE+Dp5f1d7Hng1XVfQH0LC/LEnULE/j76radplFmq38Qi5MiFd1NBDowFsB3xC+CplEN0fRGj5gsdzQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4RkKlfDfmFRBNGwg/WfA2XpbKIzUk3ZGVgW5Y/akwM=;
 b=UpRiaALI8CDoTjzVnF+GCzwNdU3KZS/rKukyY1REpR8jtOSuq1x792LtV6UpisxyFL4w/QpnFYVN2tQEiumzAvB8FFjwFEx1JX6ZaJkffPGLHryRho1iVxN1qJd1VvurPQ0YgDx1NF5tkBvk6Iu+/R/OtHumHkkhxHrbrq2WOUE=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6813.eurprd05.prod.outlook.com (10.186.162.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Sat, 25 Jan 2020 18:04:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2665.017; Sat, 25 Jan 2020
 18:04:16 +0000
Received: from mlx.ziepe.ca (199.167.24.140) by CH2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:610:51::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend Transport; Sat, 25 Jan 2020 18:04:16 +0000
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)    (envelope-from <jgg@mellanox.com>)      id 1ivPml-0001fN-Eo; Sat, 25 Jan 2020 14:03:55 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH for-next 0/7] Refactor control path of bnxt_re driver
Thread-Topic: [PATCH for-next 0/7] Refactor control path of bnxt_re driver
Thread-Index: AQHV0nqG3Roo+NUdzkGaoWX6ZHFfSKf7rqiA
Date:   Sat, 25 Jan 2020 18:04:16 +0000
Message-ID: <20200125180355.GE4616@mellanox.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
In-Reply-To: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:610:51::30) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da44b262-10db-4d24-ee23-08d7a1c0fdec
x-ms-traffictypediagnostic: VI1PR05MB6813:
x-microsoft-antispam-prvs: <VI1PR05MB6813CBFE0FBDB67A2B5F7C1ECF090@VI1PR05MB6813.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0293D40691
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(66556008)(66476007)(66446008)(64756008)(66946007)(186003)(26005)(5660300002)(478600001)(2906002)(6666004)(6916009)(52116002)(1076003)(316002)(86362001)(71200400001)(54906003)(2616005)(9786002)(9746002)(33656002)(8936002)(81166006)(81156014)(8676002)(36756003)(4326008)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6813;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0EW9DnJIvs5kpq+NShZHq8P1U7oWqcooRaoypmci4cUZ4pFGKvSuxKbYNI46OlKTBZPhWZn+vhpEnziGz22e0qhtVxRcX861/JGMookV2g6895+rSYz1uh4U8eS0J8/GUiPJGK/x+w7lTbQeC+BHiaG10ceHg16LAxz2S2ahVmmkHGymRZQPV8GLO/XEs7fDlR4CPjnZy4IeKDICkWmt/HxfcGkxJLvAsBnlCPeDEj4mohRPldyeul+MNnCTS/2vS+y/HeCzWFfmUx751r4QWOFefTB5lnZJvQaT8FOkZusJ1tp8Q8mzUNVw15RVDDasazWdGv0uwmK3lMd798Dn4cyvc+EZLBvK9UbDybHdhA5GZCzgsz4DLpljnvUcgflk/M+EA+Jtx9tKRsQh9CPHLQpBLfA5/R2F1+1XqIlzCin1tGnoGsA5Kjuzes+BtvViZc0WD+AjOLVJ5/U+LAIQOUVaX6bSLJrvRlB/8iQG9lQZ9XXCDNvkVVnmu/05ygSt
x-ms-exchange-antispam-messagedata: LxXLttZ6JJ0TqAZ3NWPVEzLKZM+QlZjfCspDxqXSvCyaF+iMImYlcU994LU8xNBMMj0E1ejvjHOadbtn8amZMZg8d3XmFQcdYKSEg6V3zhhpe1J1wjcM6bDxJBcKSFBfvfMisXxmO/rpl3upOyY+iw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F4F77692AF1A5468744A2804C93204B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da44b262-10db-4d24-ee23-08d7a1c0fdec
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2020 18:04:16.5008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rG90NfudJG0py0Y5Gq4IQJ9H6orOKv1JjDaNwXOLMiESxM63H6Gnky8rWUKUW1Be+GPXi4DBTBrohdpjyRimPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6813
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 24, 2020 at 12:52:38AM -0500, Devesh Sharma wrote:
> This is the first series out of few more forthcoming series to refactor
> Broadcom's RoCE driver. This series contains patches to refactor control
> path. Since this is first series, there may be few code section which may
> look redundant or overkill but those will be taken care in future patche
> series.
>=20
> These patches apply clean on tip of for-next branch.
> Each patch in this series is tested against user and kernel functionality=
.
>=20
> Devesh Sharma (7):
>   RDMA/bnxt_re: Refactor queue pair creation code
>   RDMA/bnxt_re: Replace chip context structure with pointer
>   RDMA/bnxt_re: Refactor hardware queue memory allocation
>   RDMA/bnxt_re: Refactor net ring allocation function
>   RDMA/bnxt_re: Refactor command queue management code
>   RDMA/bnxt_re: Refactor notification queue management code
>   RDMA/bnxt_re: Refactor doorbell management functions
>=20
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  24 +-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 670 +++++++++++++++++++----=
------
>  drivers/infiniband/hw/bnxt_re/main.c       | 134 +++---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 423 +++++++++---------
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  94 ++--
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 474 ++++++++++++--------
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  85 ++--
>  drivers/infiniband/hw/bnxt_re/qplib_res.c  | 475 ++++++++++++--------
>  drivers/infiniband/hw/bnxt_re/qplib_res.h  | 145 ++++++-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  52 ++-
>  10 files changed, 1579 insertions(+), 997 deletions(-)

Usually when you 'refactor' something the code gets smaller, not
larger. What is going on here?

Jason
