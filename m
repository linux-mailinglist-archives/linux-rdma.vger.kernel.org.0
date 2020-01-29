Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6983514D1BF
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2020 21:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgA2ULL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jan 2020 15:11:11 -0500
Received: from mail-eopbgr20040.outbound.protection.outlook.com ([40.107.2.40]:53121
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbgA2ULL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Jan 2020 15:11:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNiSvQpyg4FNqLU74B66OLoasmalINttNQnyFWRjBQ/lICoBbEFtjQfRHm8/Hw1YsAj1M8lKXeeV6XOYOWLUFOX0TDEUzD1Aa+A1qeS4k9ArvG7A9njXQp1iCcnkoGAwW87UVVahq6uetg1AexUOL69gcR6hzA2zLHVNNl2rYbxiDHyaZK5SzPVbTcOTdf1eMV460f059wMlOD0/uHJRHeIVDzezMXbqfba4dIIOV3gfuOv5T0oRlfg5xfOhbcMygW95aQ4Brem64IxmcSvyiOJQMkjsGDL6gVfRJXStgsEJQr1mQe/GZ6qiLmVKAnfCqb017sPFMAb08Otwmifbaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0jwXfRuTnTQm/xcaBY1b63S87fAUObgjqRp2dH0kGA=;
 b=MVLahvSNfsLQomXVnlaRZ1/J3Tesm8ZCkc6KYJHvyN5Nx9hiahfSppUi+n7A3gVzVMUcjrX9H9BufM7Sb1VWX+JYuiSzSVb0I3/T+P+ENABEr7UxLuJX1zCfTu9jtFrvB5gzG3U9OPSGvVIpTRVmT/IlRlRPOQ5crJOvQGkOSXZMIV1LmpBkof0dW2SYC7z+bqEsOT3UQGYiNBk+1EgnhsUzo7rkhK9hQ+1kTdCYp7rSZz81vlJDGLLXEsJfYKDDyIyfM1P8o6ygpFWnNkr/UJoQr8mMpaHKr8jOA+BPsgs/F0Zd7HuU7dalgEWK2zNKRmt/MpHuU0WXjjbgfwQcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0jwXfRuTnTQm/xcaBY1b63S87fAUObgjqRp2dH0kGA=;
 b=k/wTtWmNFoqTLmkgbgzLjS80qzsgsr+rYI+lcJndIi4L8hUtNrfpxW4FAaznl6gtCUUsWbp2AEV3zDO4OCbkmxHu319YphWQrJ85I6WY3HVd/FBsM1zCe6Dx4Lm6VmabGNgLIEFQfBL46DK2Me13Qc5YDIU58y8bjUXaJgX8PsI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4896.eurprd05.prod.outlook.com (20.177.49.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Wed, 29 Jan 2020 20:11:08 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 20:11:08 +0000
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR0102CA0020.prod.exchangelabs.com (2603:10b6:207:18::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.23 via Frontend Transport; Wed, 29 Jan 2020 20:11:07 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1iwtfy-0003DX-Nr; Wed, 29 Jan 2020 16:11:02 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix protection fault in
 get_pkey_idx_qp_list
Thread-Topic: [PATCH rdma-next] RDMA/core: Fix protection fault in
 get_pkey_idx_qp_list
Thread-Index: AQHV1GxKXhRsYS+mBkuHU7/B5yFOG6gBkCEAgAACYYCAAAgpgIAAfPEA
Date:   Wed, 29 Jan 2020 20:11:07 +0000
Message-ID: <20200129201102.GR21192@mellanox.com>
References: <20200126171553.4916-1-leon@kernel.org>
 <fceb1026-0fb1-5e4f-d617-01a0bcfa21f8@amazon.com>
 <35d59005-4bab-38dc-c6c1-a1e1f4cbd8be@mellanox.com>
 <a2028a8f-bf41-44cc-4b65-0df77ec3406c@amazon.com>
In-Reply-To: <a2028a8f-bf41-44cc-4b65-0df77ec3406c@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0020.prod.exchangelabs.com
 (2603:10b6:207:18::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.68.57.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07508cf3-0076-427f-b45a-08d7a4f7600c
x-ms-traffictypediagnostic: VI1PR05MB4896:|VI1PR05MB4896:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB489634056F9CDA9D2992D4F4CF050@VI1PR05MB4896.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(199004)(189003)(2906002)(53546011)(36756003)(86362001)(54906003)(2616005)(186003)(1076003)(316002)(478600001)(9746002)(26005)(6916009)(9786002)(81166006)(5660300002)(8936002)(8676002)(81156014)(107886003)(66446008)(64756008)(66476007)(66556008)(4326008)(33656002)(71200400001)(66946007)(52116002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4896;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YsodY6AAekp8PxvbFDrCb01ey3UUgmocJoFpPjHj/3kdbOxvzGvAq8oK+04ZB9L8lbeUwbi/qkWAcTfF0lu4nHXEiVvtQc6lcQPEQ+at+9g2bo/9Ynib9evdcXr2h8h2ruK1MeY9KakDLd/M6LJsIVZYqQYVrYxqDTh0Tjt6yHdRENvpt8YD2tUHBQqzf1FEvLMfpz60w5K+XLfY1LqLomfVmzzxb/X7tMQxv+fsVkZpm/fSV3a9dIoJg20pbeS9dYNy81DPWHKjqrdjAoAWQ7TuS5klhz/xoC1OCc1O3oAxPDNW9CbMiNEeHfCGd+ypnoz6zk+ZYA2DEtcqgxDENqOqqbVkGGi2tKKLZNKowV4bHWBHwvllGlW7x1pOLcXhM4BhNOKQdFyG3MJRGINjVoVcNwvSUpp426wd1k0O4HfZcd/kxI3INjc1WUT1Vpl8HxqZYhfzhM/nz4x58d8ussHDSKnE+4BoexmPMUaXQZYi0TgbwX3Y7g3WrkASYjJA
x-ms-exchange-antispam-messagedata: QyBmZfmJMhepH5Byz2puTTJ7gFjwx0077NuAvxOHuLSCWppmkM73v99adPxo1Hyo0yH2Xhru0ePnwgR8Fo1FmkgfXg7NDEehQhRBbhipPRKbFlegHzKUQLvCnbOYr0NffJIOrWAMN1cwVQ83KW7+ig==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95199BA9F03CAE478DF0973CCB56515A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07508cf3-0076-427f-b45a-08d7a4f7600c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 20:11:07.8223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MpoxogD2KLz8a3hD+JGkSfFZhzd8wwIW+Zese2haCpZszM5sdxdbTqSu3+toorSxbgjgVxHqr4V/yc3ed2D0xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4896
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 29, 2020 at 02:43:51PM +0200, Gal Pressman wrote:
> On 29/01/2020 14:14, Maor Gottlieb wrote:
> >=20
> > On 1/29/2020 2:06 PM, Gal Pressman wrote:
> >> On 26/01/2020 19:15, Leon Romanovsky wrote:
> >>> From: Maor Gottlieb <maorg@mellanox.com>
> >>>
> >>> We don't need to set pkey as valid in case that user set only one
> >>> of pkey index or port number, otherwise it will be resulted in NULL
> >>> pointer dereference while accessing to uninitialized pkey list.
> >> Why would the pkey list be uninitialized? Isn't it initialized as an e=
mpty list
> >> on device registration?
> >=20
> > It will try to access to list of invalid port / pkey, e.g. to list of=20
> > port 0. port_data is indexed by port number.
> > dev->port_data[pp->port_num].pkey_list
>=20
> Makes sense.
> Shouldn't there be a check in the (!qp_pps) section as well? We shouldn't=
 assign
> the field unless the mask is given.

Indeed, reading a qp_attr field without the corresponding bt in
qp_attr_mask set should be wrong.
=20
> Does this work correctly if the user issues two calls to modify_qp where =
the
> first one modifies the pkey index and the second the port number (if that=
's even
> possible)?
> Is it expected that the state would stay invalid?

Also sounds wrong

.. and then there is the confusing testing of state !=3D
IB_PORT_PKEY_NOT_VALID but nothing ever assigns
IB_PORT_PKEY_NOT_VALID.. Humm.

Jason
