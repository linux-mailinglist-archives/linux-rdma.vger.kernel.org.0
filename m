Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC433B1171
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfILOu1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 10:50:27 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:8067
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732732AbfILOu1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 10:50:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu/ZfWTHS4WEB0kMwX/k8aZz779ZRXAMcJQMVxjPZbfWbY0crqrsHzxmizN6i8rFXWTDfjb+TxyfPzz9lLoIlkVYG/oXDFtYCGDwUEwPEYzc5FXb2SKrxVECAftH/PhOdnGxlQ8eGWvGN1RIyECGgqXaVTciuOpuFUTvlA1b+8waJgBb+kLuljoW9iJFgS895iqqxLzl2eAFcRKbF6UdiThY0o5N1HrCPeAp9Ml8UeAmt0StaMd5sl7BkgkMZk+PitG2abfUzNKqmHGQgqBDivUtt1GNkWCroUy0HAttxywwGL9Iiw/Pk8Zu2uoVTdPaucaLVKURnolVDYZjQOhuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Vcd7xFRxXUttg1i7j3ZZfnYux5t8w8UiBfnqcKijY=;
 b=EsqMPFRAF4wox3hHj8z9yLSl2nx+rIYer2SqmPRFAKinIW2i2qa6SE/3TMqz6UYPhSeKnMYk6nZXw3+UXKaDrJ7lmk04c6gJYVE8gpU1s0swPaZ/tEPT259cvvxOqseYzEWFWMW5SBf7KmpV1woQEolLfcparUhT3g3D4s8NG6SHC6RPKGNCkazgiwrBY6k15y0usjudfK+fo/uTuATEXVUH6qVg7PHLxJN3u4c2seVxlHyCkOe3SORJqd5JhDlKvtu76Ph5mRIz2OJc0t4YZRE3AFyzVIXWUTpRWXakOm7ZzMYTp4dxW+OQxYJIkpv/ng1f68GFhjP571TGEUiHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Vcd7xFRxXUttg1i7j3ZZfnYux5t8w8UiBfnqcKijY=;
 b=qDejNkyaq5CjcrzmotWNSjCkRAI65xGwwi3Xzn2Ajc2jXyBznlrMltFtqazRfQyIUn3BX2Pm3pMAJTi6NWWhhlKNnW36lFJ5BP30RXR7lMhcQYJrkxnJcni5zuy6zrLhacXjk/fujp8TizU/bAFcd668C3AYX6KSA7HKmRLv820=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5967.eurprd05.prod.outlook.com (20.178.126.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Thu, 12 Sep 2019 14:50:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 14:50:24 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "krishna2@chelsio.com" <krishna2@chelsio.com>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH v1 for-rc] RDMA/siw: Fix page address mapping in TX path
Thread-Topic: [PATCH v1 for-rc] RDMA/siw: Fix page address mapping in TX path
Thread-Index: AQHVaXlohnWhDIBRVUyzJfbEC8ov4Q==
Date:   Thu, 12 Sep 2019 14:50:24 +0000
Message-ID: <20190912145009.GA8524@mellanox.com>
References: <20190909132427.30264-1-bmt@zurich.ibm.com>
In-Reply-To: <20190909132427.30264-1-bmt@zurich.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM6PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:5:a8::16) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8eca86f-d540-45c0-e229-08d737908ad2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5967;
x-ms-traffictypediagnostic: VI1PR05MB5967:
x-microsoft-antispam-prvs: <VI1PR05MB5967BB40C9920C66F41E8C89CFB00@VI1PR05MB5967.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(81166006)(99286004)(52116002)(36756003)(71190400001)(71200400001)(1076003)(6916009)(229853002)(6486002)(5660300002)(86362001)(54906003)(316002)(4744005)(6512007)(256004)(6436002)(2906002)(66066001)(53936002)(478600001)(8936002)(25786009)(102836004)(3846002)(386003)(26005)(2616005)(476003)(446003)(14454004)(6246003)(186003)(486006)(4326008)(66946007)(76176011)(66446008)(305945005)(66556008)(7736002)(66476007)(64756008)(6506007)(6116002)(33656002)(8676002)(81156014)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5967;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v63h0HnqDUS4NTh1asEz5Lah78KzhteAYquZwP9jI88EozKT/IKf1CIUCBXX/axhqY/tfDlwpSLgDEYgsAYIxCUxXNnQ+cy+0sN7mh4Fg1/SNhFPsTUYspZR8bHCQYF7Fy8M2BLw/Vm5SwfFkx24PXoX/bGBnvAP+oNYZy+cTgmt0H6QS5sxSjKreOOUrYqIJbXLYrK/X++NJyVMzvM7lSagQeHZW4+qqom7U7aXXyDn0WTNkUVpGXXuKQAHsjrG4hxP5gqj1y0ELj8k1RVIn6+pQOu1cDKIYC86Nzn231BvzT4iOtyfpgJdPWq60hhki3aXFix15RWjv+LszW/BLv7rqBH2tUjcu4rZSZa/cAS6hmEv5NyhEad/cegl9ItLmFzyCvh0Au9VVCz9DGLW8US7ZOqyAGjNq8B2jwJJtvg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBBD75D58D4FAA428D7B6F8B7D9B4890@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8eca86f-d540-45c0-e229-08d737908ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 14:50:24.2177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YCSK8xTEbE8DJS+j+2LmtG+rU8A4lpN0/iM4X6AFmsk9nog2BnC/7xxpzzuNynfxASf30AQt5ivaSGOKdIVXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5967
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 09, 2019 at 03:24:27PM +0200, Bernard Metzler wrote:
> Use the correct kmap()/kunmap() flow to determine page
> address used for CRC computation. Using page_address()
> is wrong, since page might be in highmem.
>=20
> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Fixes: b9be6f18cf9e rdma/siw: transmit path
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
