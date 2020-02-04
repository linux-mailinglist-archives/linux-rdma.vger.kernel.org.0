Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFADA151C3C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 15:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgBDObu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 09:31:50 -0500
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:58842
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727238AbgBDObt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 09:31:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn5T8qY2GF03pAP5hf+NFAZSgnOYCySWsOMzwM8YPU374/CcD6xburDc6PakKpJ2gBGTmmnTbI271BI2ykNgPdtpGLEJZ71StczLWHH7v+6FsoouvpG1dlTt1sqHH6bcnoyLEW+eGP2pbTcm2LxVnozzZPWv3w5JDE9tDUlgObH0TJwBOTXNmGaUSJjHMfEpkwpg3QdJsZXDEW2whiMdwtbcfcpMH28yfWp13vmyT/bSv2rzfprhbP3BzQ6/t/j4mx6ZbBkUjW4GvR3Y+DKVAcXHvjFFF27fWBFqqsuIqeslzg64ndvX/M7BRpX24ug/EQ/mjN4BS5FzfWKYMmB2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Sv79uJ4tZ4EdNoyolp9Rgbyn6gYL2UZ89Vv7cKpuUs=;
 b=UNHq10UaZZOqvjRyPXbtlQFIO9cacWJ+RqsJwMR38/MZ1qYdfZv57iPUWn2OSl5LpVbhrdWuxoPA2Kijsl4fKAGWtL9hE93Qt6YTuIkjN+7GJ4EdJkh9MWoIYNWfT7KkwHskaFxrCXQiFRMg5tAz939qsboIzv62hfG/vdVNSJDxmvQrZIQZS6nJ4UlwTX2v+ENANuUWcOStLB1Ioi9cnJPH5OrwXJNgmBdeyjGleyq/avjd5cCsM0w/JWzAaILwc6WopMuvnrRL5Ia901h8tsA8AI4/Eo1TkhySbyTGFcCi5G4wi/z5mPkbxgYVyVVrjSrkTH6mBIjg1Vyis77CnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Sv79uJ4tZ4EdNoyolp9Rgbyn6gYL2UZ89Vv7cKpuUs=;
 b=oe7jXP4kzyEcqJt3+SHjMz8eh+/rBx7uqDQDI4kkDI4BlMnCXjeQRd+3vRTcJFppGWLWNO6Ii3ov/DIxKmDwq8y8q4VZerB/eveS85kfDKUqTQQ1ZxPyi/cSpdAoYnWAomPl1enf9scKTrteCj0dufvv3WduNP7gzKKqca65zr8=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5972.eurprd05.prod.outlook.com (20.178.119.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.33; Tue, 4 Feb 2020 14:31:44 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 14:31:43 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: RE: [PATCH v6] libibverbs: display gid type in ibv_devinfo
Thread-Topic: [PATCH v6] libibverbs: display gid type in ibv_devinfo
Thread-Index: AQHV20AkNG2x7dW7SE2P1OkP/pE1WqgLGGfw
Date:   Tue, 4 Feb 2020 14:31:43 +0000
Message-ID: <AM0PR05MB4866F91551DAE20160D39235D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1580809644-5979-1-git-send-email-devesh.sharma@broadcom.com>
In-Reply-To: <1580809644-5979-1-git-send-email-devesh.sharma@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.31.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44cd62d1-64b2-4b4e-e699-08d7a97ef517
x-ms-traffictypediagnostic: AM0PR05MB5972:|AM0PR05MB5972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB59724A74B5C6544431423AD5D1030@AM0PR05MB5972.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(189003)(199004)(4744005)(2906002)(55016002)(316002)(8936002)(9686003)(5660300002)(66446008)(64756008)(76116006)(66476007)(66556008)(52536014)(66946007)(7696005)(86362001)(110136005)(6506007)(81166006)(55236004)(33656002)(71200400001)(478600001)(8676002)(186003)(81156014)(26005)(4326008)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5972;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J1AqisJt6v9TERQ6YKjG/mjRBaxZaIVJTqalY18cA/4A+n/cbzidYGSMknRBlKybkxi6gQFmmeED2OT4RkHT6eLBA3uCOHo3uqYjegf0dDIWKRnqvhEaJlbssnHL79isrg7yyijNLxTT0mPVUMUSlv+baVfWoE2uzYevQ2WMAlmowBxjtzcTMQ/mlJ8V2mYKmgOAsMTqbeG3F2DU/VOj9iaOseAiuC5u3Hz4gBiXekAXgalXNfT4p82dMZuAPoApU8mhdDt6YiHiJ+PScyG1iOU4X8ga6Xszk86pjYlf4B/ap7VB0pv5jYwYnzGcC00tnviuCbTGEtb7fEnAAhmmjaiBRL//JmKZ4DRS2DKTyN0NH4AgfV0oxFR686wZiEwDpGvjaBanOd4azd1NKBvj0pKi5j0HhEaMvOnrg7plFgdzW8cgf5UQFag4o4EQu+Bv
x-ms-exchange-antispam-messagedata: AWlU7OBaAGgbU9EvEdZtwLBxHjgp07uxMGR49tax+Mki7vyoFQxOuFVDl6g7+DmMUxp43c/1pUmn8lAui02iyDvbQV5i3ONUWYu2H/w7+YYPaJTox6xMxjwOxHmZhSZgAdrZ/g7b7LaxOfwi217tzw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cd62d1-64b2-4b4e-e699-08d7a97ef517
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 14:31:43.6733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTAiSjDQBVQYJVl7om3N0+rSUg+Yaa6lyP3IEli8VZYcEcQN8aC1yKawg55NvqS2CPOHdfTLZlBDsvToc4gNMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5972
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Devesh,

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Devesh Sharma
> 	phys_state:     LINK_UP (5)
> 	GID[  0]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
> 	GID[  1]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
> 	GID[  1]:       fe80::b226:28ff:fed3:b0f0
Showing two entries as individual raw like this is surely confusing to user=
.
Either all content should be in single raw or as Leon said just single diff=
erent format for RoCEv2 is fine.

> 	GID[  2]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
> 	GID[  3]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v2
> 	GID[  3]:       ::ffff:192.170.1.101
