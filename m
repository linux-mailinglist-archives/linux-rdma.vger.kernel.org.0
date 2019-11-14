Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B11FCB14
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 17:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfKNQue (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 11:50:34 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:3886
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726474AbfKNQue (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 11:50:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy+loRXqI+XA8qiBxlQq+ZVXUF6MFVV3ErKm3Iv3hrmKyFWX5FgWxzgl6cDrwEvU0YIBPsBis99lxhT6ZS4aJuK2WL4a13nqhiKbDZndhvlD7IP/+IIK0NeWXE/yEva+skeECCQP8eX0kuwCTIOVlf8+y07qyDaOfWV+EtnaMTDHSCx20mWea59ROAJBxWkSuLmbX7tRrJk47cICPZf1FgvUy9qL9KQOssmaDgn7DeMrh15e/4smdn/Gg9Y/BJgwtS5X0ArmCB/4oJA7mQpskmlARVSt1R0oVuL0pY7dMoHtzagpx9ofdi3W7TyUBOESW+zw7bYwS/wbvg07bSU7gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoAhUNiUrHXLzIzHlF3+Dsoc12KlIRyPngSyEBoIgwk=;
 b=EvkQeViuQnTOgyKkLAfHNSCva7gzF2YBHgUeOoCzDaBZ9IFD6eGlsAlZ58pIKMFIJu0C0/Z0dEm0pY9XHnCDBqlvAjeUBq+kfRdC/HynyGzu68PIzeQTlMRZLFfk+onRukASBx3hNBpovKDjDC/AfLQNM0Tgw3PoLB8b1hBEipt85bOg72c5SM0s7qrW+aMTjss2XNqewArwvc6QTisfIsAVv/dlO6KvM9GdFH1WAmftCJZFDOWKfm0M7bCneQ8LBOQuUXWh3gxEmYn1DHGXavpiGofnH9LdWSr9Wi7DfRIif5/72/w0pzlPGnRzuTdoy6u4W2kuIYbduNjyK+FtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoAhUNiUrHXLzIzHlF3+Dsoc12KlIRyPngSyEBoIgwk=;
 b=XU0j+hvcEOuLV21WbeAWIVaRuPZOxH3ak74jzEB5eAgV+BK+mGl5FlaOQimIxkFfkYyneN6uT4lAAjps7DDpuV14io5pjiNoRTaDITptaWgkzPxxhG2+33P2pZuqXXuAv5Qbr9lJZXjsQveG90C+Rz++fz5Ql3CqD22YE4JLTUg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6110.eurprd05.prod.outlook.com (20.178.204.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 16:50:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 16:50:28 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Edward Srouji <edwards@mellanox.com>
CC:     Noa Osherovich <noaos@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Daria Velikovsky <daria@mellanox.com>
Subject: Re: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain class
Thread-Topic: [PATCH rdma-core 2/4] pyverbs: Introduce ParentDomain class
Thread-Index: AQHVms8sIZmxpJN9xEuBJbuwT+tiy6eKrF8AgAA1FACAAAAmAA==
Date:   Thu, 14 Nov 2019 16:50:28 +0000
Message-ID: <20191114165024.GU21728@mellanox.com>
References: <20191114093732.12637-1-noaos@mellanox.com>
 <20191114093732.12637-3-noaos@mellanox.com>
 <20191114133954.GT21728@mellanox.com>
 <AM6PR05MB41527769B215FA0089CEBA90D7710@AM6PR05MB4152.eurprd05.prod.outlook.com>
In-Reply-To: <AM6PR05MB41527769B215FA0089CEBA90D7710@AM6PR05MB4152.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:408:60::36) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1332753-c42d-4841-05ed-08d76922c116
x-ms-traffictypediagnostic: VI1PR05MB6110:|VI1PR05MB6110:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB61104C4FB834AC5A347A99F5CF710@VI1PR05MB6110.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(136003)(396003)(346002)(366004)(376002)(199004)(189003)(99286004)(71200400001)(476003)(102836004)(486006)(7736002)(3846002)(305945005)(86362001)(81156014)(81166006)(1076003)(64756008)(66556008)(8676002)(66946007)(6116002)(66476007)(2906002)(6636002)(52116002)(6506007)(386003)(66446008)(5660300002)(2616005)(76176011)(33656002)(6512007)(558084003)(26005)(6246003)(6862004)(446003)(71190400001)(8936002)(478600001)(66066001)(14454004)(36756003)(256004)(6486002)(37006003)(316002)(4326008)(11346002)(229853002)(107886003)(186003)(6436002)(54906003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6110;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n64yzb11MLRgvea/D2SIoABWFnzfZxSMwWEDoWn8WwkQfg+qarlzEMf5quNNTxoBnE6MIUR1NjBloczgDWkbFEhmu6FMhI57GpUaaHyX6HL9gRgcldf/mf3qLt1xJtx14RsXTqBzA9T4jqHM3cbFFe5EyD93F9JCJRu1S1sDQZfzdV+neWovNAaTy1sq5ZpDJtYxWWeyxmE9SzL4dtMrM1OpVJwmYcFToptqWHnRkeytjWZEpdDSZa4eVmxQfhqPhg95fWrs9JBuQ/UxmrKaMCZ2toXV8l0UuWUdjHABCCKoqHpbt0GgiVuFBJC9FyPDglE8QsrFaG4cA3RivGZ1bN3Hs6a8TCorSxdMolHvRFZU6PSq+qFqAs2qGZYuAqsLvHE7C6wTEEtCYRQPL419RVkU8HrtBaj+t0M+O8iDWnWdfrP74goQioD5V2DfVPSZ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0EF3D5692A8A3C46899F1BB3F73A568B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1332753-c42d-4841-05ed-08d76922c116
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 16:50:28.7493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PR7lIPdYCioFBYxJZLyY/fe6ZKJazOerfsuoW6iaAkMjzQ5VHwjMEQbQstYVLI8rKTy6zic2+tE+ARSQRoVEzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6110
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 14, 2019 at 04:49:52PM +0000, Edward Srouji wrote:
> They are defined in mlx5dv with #define and not enums.
> I will change to cpdef though.

It is a mistake they are #define

Jason
