Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF6DDD68
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfJTI7d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 04:59:33 -0400
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:50426
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfJTI7d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 04:59:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObnN5LWNV759zf2Gm3k+GfJoKGqt5kfjc7ZCnJSSuahYmL6yRyGGwKURLjV5AGPlwwg6JwA/aNWiW5pZkkHOkDqePuFUGGdyGHIi+3NAajwTHLF+5w5LAHUcGJOx/x1feZ3aSHsp06VwcFIdB9XCa7aD3gIq8xS4ifxZXowcKKfHHcu2G0raFyZOKzN5AUrk0k2J9+2/SddkRridKsBkPME+7cejjhjQ/Ol3IerUjQsW0lQx3XwmfSjO2RN9a9/hrc34fKX2WT1sqklBVChAm9yR5nz59hn5xJUKNidd7gbGOag8SvyW1VpSs5mCp4Y7M1oZw78aEc797RIjz4Q7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEhrCUKjFJVS7DOh9mwqzdDvzFhFk9lM5linpuJdKSQ=;
 b=WDQY4VU1XT0F20/+IHonm5gofOtVThInqJUrhcuXJmCyxTOjFV0ehvPZJml5W8Due57ZH9GNeYJNNShanhTEUjY4l0YbOksSyyW1p9QbAUVLWX2AuSLbt7rK3dMb1tHxS+NMgN/OaVsrnw8ci+xH2gZjOQcoCYjTXSfpjzlB6zW/2fhdF6o64OkM0epp2CPIAo7CDJX125YuuaafAdxkyKJu7B4/yQCcpFx/Pv1cyHimA3o1hpFXxE33KwigyHB5q63QN5n5UvOq+X4/8hi9NN8mlkucqtBFUwGndUpwkj+icznLm+51Xr+qs4vZP0NRUi/zHw7l1xyUuKLIi4PnEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEhrCUKjFJVS7DOh9mwqzdDvzFhFk9lM5linpuJdKSQ=;
 b=GY5up/wL18CFmxM0BPX35RAEKNEgipxgEuNHinBRyll/NPs/PfzPitiQTBuUPrO4iFGKrBqJXg3SeWmWRnwZoZ8F6UhJGDgCLNpIE8F4s0EJLmfq8plbIWgmxEiztd3Wd7vwwKns+55FJeyJcDiqHvlkE1yvUGdziNr8cl6jNBA=
Received: from AM0PR05MB5010.eurprd05.prod.outlook.com (20.177.41.151) by
 AM0PR05MB4657.eurprd05.prod.outlook.com (52.133.57.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Sun, 20 Oct 2019 08:59:28 +0000
Received: from AM0PR05MB5010.eurprd05.prod.outlook.com
 ([fe80::44d0:79ba:971b:8eed]) by AM0PR05MB5010.eurprd05.prod.outlook.com
 ([fe80::44d0:79ba:971b:8eed%7]) with mapi id 15.20.2347.028; Sun, 20 Oct 2019
 08:59:28 +0000
From:   Rafi Wiener <rafiw@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bodong Wang <bodong@mellanox.com>,
        Oleg Kuporosov <olegk@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: RE: [PATCH rdma-rc] RDMA/mlx5: Clear old rate limit when closing QP
Thread-Topic: [PATCH rdma-rc] RDMA/mlx5: Clear old rate limit when closing QP
Thread-Index: AQHVeRlSsirclJxr1UiNmJPbJSINfKdfXBYAgAMYHtA=
Date:   Sun, 20 Oct 2019 08:59:26 +0000
Deferred-Delivery: Sun, 20 Oct 2019 06:00:00 +0000
Message-ID: <AM0PR05MB501046FE02320C485CD37CA8CE6E0@AM0PR05MB5010.eurprd05.prod.outlook.com>
References: <20191002120243.16971-1-leon@kernel.org>
 <cca910c4040961729f0f4d0ad248b6b5684c80eb.camel@redhat.com>
In-Reply-To: <cca910c4040961729f0f4d0ad248b6b5684c80eb.camel@redhat.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rafiw@mellanox.com; 
x-originating-ip: [79.183.45.218]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39bb105d-c093-4e78-0259-08d7553bd0af
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR05MB4657:|AM0PR05MB4657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB4657AFD1F45AFF9B1F13531ECE6E0@AM0PR05MB4657.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0196A226D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39850400004)(396003)(366004)(346002)(13464003)(199004)(189003)(186003)(74316002)(6246003)(316002)(107886003)(71200400001)(7736002)(305945005)(53546011)(26005)(9686003)(71190400001)(33656002)(52536014)(5660300002)(99286004)(229853002)(6506007)(14444005)(6436002)(54906003)(55016002)(4326008)(102836004)(110136005)(256004)(25786009)(486006)(76116006)(81156014)(81166006)(3846002)(6636002)(8676002)(6116002)(2906002)(476003)(66946007)(66446008)(64756008)(66556008)(66476007)(11346002)(76176011)(7696005)(478600001)(86362001)(446003)(14454004)(8936002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4657;H:AM0PR05MB5010.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z9JG+vh39WtM6JCz4cWxlELFW/Q2Qrk4n14d6Corf7suAoAVQfMvhwHFneM+iFJMCNgDD8ZG/BPzA3DVTBDCUwcUxyd4Io8KdrCPHH6+wanybMvuv00qIpDSvWVWTX+cYZTHdb85POSSSiBJnspGZF78bt8xytF1pfFOix/2kVhJbxrjoXcrbN+y5QcI7nPON/cuJHq0DPUZq1o6vC4o6+Deca340/yAn2D6NiP/mWOqZPSYYuqbzG61BucS3Zs2xlBSTpp98xJpkv7lNPIl0fom1C8QEoaZodaGlvKMGq6cIsYA+eMDuITpsGEg8wkry+6j6CQo+a+XZcLwcOcEJji97oRECLF1lshc/rn0RjtOs341ymzRxSLokwFf9jCukZ+yI2+zEPtq34jKFnAdoZMnCyUTlJe8p//bKbmG/XLyYwmuFy9maWtZgSqR/Zsk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bb105d-c093-4e78-0259-08d7553bd0af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2019 08:59:28.7556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5lIGgYcxIQlciwOXrxs3WOG9mvu4vzyqsrWdeD6Ew4uCVqDTMLwdAnjmeRHd2bMtnLlCdSugB2gAAd+3zuxIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4657
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Doug,
The issue is when you have a few QPs with the same rate limit you remove th=
e rate twice from the table instead of once. This causes issue, no racing o=
r stressing occurs.
Rafi=20

-----Original Message-----
From: Doug Ledford <dledford@redhat.com>=20
Sent: Thursday, October 17, 2019 11:12 PM
To: Leon Romanovsky <leon@kernel.org>; Jason Gunthorpe <jgg@mellanox.com>
Cc: Rafi Wiener <rafiw@mellanox.com>; RDMA mailing list <linux-rdma@vger.ke=
rnel.org>; Bodong Wang <bodong@mellanox.com>; Oleg Kuporosov <olegk@mellano=
x.com>; Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Clear old rate limit when closing Q=
P

On Wed, 2019-10-02 at 15:02 +0300, Leon Romanovsky wrote:
> From: Rafi Wiener <rafiw@mellanox.com>
>=20
> Before QP is closed it changes to ERROR state, when this happens the=20
> QP was left with old rate limit that was already removed from the=20
> table.
>=20
> Fixes: 7d29f349a4b9 ("IB/mlx5: Properly adjust rate limit on QP state
> transitions")
> Signed-off-by: Rafi Wiener <rafiw@mellanox.com>
> Signed-off-by: Oleg Kuporosov <olegk@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

If you are in the process of closing the queue pair, does this solve some s=
ort of multi-close race, or is it just being pedantic before freeing the qp=
 struct?

I took it regardless, just curious.

--
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
