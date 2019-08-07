Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C02484AEF
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 13:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfHGLpA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 07:45:00 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:60289
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726860AbfHGLpA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 07:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdIIXbk5qLo/WzswsjyClAgW3CKlYf66ZbJ1flpwWw4Xg0Dfd4Fi+SSAJEu+dZhmAWOketvaOSulhGXoaIvEOrV9k9ZU1RjUjznwD2X2HEZ3YVEobTwpeDc7SKhBCbg1O8b7a41/51WonT66PNf+kXE4/V2CaFoA3sb/L72O9llxcaJijDEvecvFR72uEHkMnr7BJf1XzFH8xplQpMlvvEa/UYAw3DeatATf0cJ0uXYDmZU9Tuck56rcQ9Zxbj9YwxLm+lTP4RCxM4sBX/NsxBGBBVnfCRH9Zm8l5oyW44B0C+Vrk0nU0j/xU+LXQ5iGTp+ou5ZDB3O/681tD3b/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Izj5Py3DFZWs8a+cOlC4/S1f1IJisGXxe4Hjeor0xpA=;
 b=auzDZSKKXXPlmusZoihywFscIaxnnMgTimrQ06KrNQ+xr+w/+Jfuusx3rXmXoTDSTNo/CVFLynqI3IDVI4nvEizEWMQ62yjI+j3tj4JXrnSXAvAWKqnvp0qnG2WXyl1y3D+yMi7YzA0UWoK3rRKsF09Hba24OaBpjRBzL5UEqft1FdCOvkLaiAWb0W5qogm6qzWaXHqhsittTciNBYfyPOLRo9FmE3AgrZ2oQ7XjNhCa9mB5MlTrTXmBWnp6ZAjJTf0dtXc8soAC9n7FTRR4WBG2BIN0ZFrF4STss1jPJPtA4/C1YRqpnLftM4Xaoy8rwpkMSGPmNDvjSA3kkf563w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Izj5Py3DFZWs8a+cOlC4/S1f1IJisGXxe4Hjeor0xpA=;
 b=Bp0WgdVbKTqjD0wYwottV+45px5cRetize90RlH8GYI3HGX6BtWGjuROVZypoMezgErsbJ9BfJ++3sfwJQKn7PQtp7RQ7LVkkY9iZp3nDbL/oxzjOlhw3y32orK7vVfRr7IlJ9mHHUlM1Y99O13VervH7BMpTSeOLDhiFyF2NPY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4224.eurprd05.prod.outlook.com (52.133.12.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 7 Aug 2019 11:44:57 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 11:44:57 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next 2/6] RDMA/umem: Add ODP type indicator within
 ib_umem_odp
Thread-Topic: [PATCH rdma-next 2/6] RDMA/umem: Add ODP type indicator within
 ib_umem_odp
Thread-Index: AQHVTQurSLl8p2IgR0SgHRqdFJrlUKbvityAgAAGGQA=
Date:   Wed, 7 Aug 2019 11:44:57 +0000
Message-ID: <20190807114451.GD1571@mellanox.com>
References: <20190807103403.8102-1-leon@kernel.org>
 <20190807103403.8102-3-leon@kernel.org>
 <20441b80-b901-9e42-90e0-f1cf17ac6d5b@amazon.com>
In-Reply-To: <20441b80-b901-9e42-90e0-f1cf17ac6d5b@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37b56b87-04f7-415d-f023-08d71b2cabc7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4224;
x-ms-traffictypediagnostic: VI1PR05MB4224:
x-microsoft-antispam-prvs: <VI1PR05MB42242711DDE30970E97E420DCFD40@VI1PR05MB4224.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(186003)(446003)(478600001)(11346002)(7736002)(107886003)(14444005)(316002)(6246003)(33656002)(2616005)(476003)(71200400001)(71190400001)(4326008)(8676002)(256004)(2906002)(486006)(386003)(8936002)(6916009)(102836004)(6486002)(68736007)(99286004)(52116002)(305945005)(229853002)(26005)(54906003)(6506007)(53546011)(4744005)(3846002)(6116002)(81156014)(6512007)(66556008)(14454004)(36756003)(66066001)(1076003)(53936002)(81166006)(66476007)(76176011)(25786009)(5660300002)(6436002)(64756008)(66446008)(86362001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4224;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aFwk826T4uCfchvTv8REefE639+jI2vyoCTuHiaYOztYOaoyIsujc9NJJmzV1r8tbZpU448Qu3RU9lY083ytVIvw70AaEUa7oYdzTcL/L0f2OiDmGQFppiDUAaCTiwmbh82qV5jX6Ex3cEdpXO2PUpHlMlF9xebn0bYLmE8jW8N5XSXIrngjzcvE0zZsdvOjOYA0Rx18Coav1lmB/ec4sTpJovJjPAPpp4CY73AS2PGyKEJUplvEvJmRjSgebbvzdjkEE1bRv6cJm2CpfRJJqH5o5vfj4iW/OjO8WHQMqjsDzzqtv5HpBBr6xtc5cISRTeczagDyzKBRqtY1Q01gpNRg4Ackw/1y1o2z2RsaeWmf2wbO0bU1E3MFAFTCMWBWzCyJroez+a6GEYtAznE3QzF98+MHr74uqA+33FOHwh0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E55DA9D043F0934896285CC5CA523950@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b56b87-04f7-415d-f023-08d71b2cabc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 11:44:57.2221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4224
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 02:23:03PM +0300, Gal Pressman wrote:
> On 07/08/2019 13:33, Leon Romanovsky wrote:
> > +static inline void ib_umem_odp_set_type(struct ib_umem_odp *umem_odp,
> > +					unsigned long start, size_t end)
>=20
> Consider renaming 'end' to 'size'?
>=20
> > +{
> > +	if (!start && !end)
>=20
> According to the man pages, To create an implicit ODP MR, IBV_ACCESS_ON_D=
EMAND
> should be set, addr should be 0 and length should be SIZE_MAX.
> Why check end against zero?

Because that isn't how it works at the umem level. The driver detects
tha above and triggers a special umem creation flow that has a 0
length umem.

Jason
