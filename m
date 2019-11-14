Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFA2FCB5E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 18:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfKNREG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 12:04:06 -0500
Received: from mail-eopbgr20050.outbound.protection.outlook.com ([40.107.2.50]:59006
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfKNREE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Nov 2019 12:04:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvD3ddzINKY0saAMJxaSg3AvATZ4C3oNrARecxrVEXeeJAeLJ3HE0oxYNkF0tRkwfDX5ENaStpf6iHu7ZJlRJMA9FktUXkYkOXBHVX6z5SHceKTaBf3FAjQkrO5/0t0r3YJ8rLxF+YUSHvrVBMtRe6efjSfviM+C8IDOQ8Rb71yAPzpnktCuRuxypJxakY+flOQYpSraU6TbijMxlassdaQFh4VVlt25lazm6jKpNXnmWP6PkeBvEamSyPpUueZwwx4FiR4pn/pVXEU5r7p+i4YTbn2L9n40nKf5jeuwR89801pASRp1r6Vch+axEUyUzkJ5I9jwbc0Qq9izg4FcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW96u36lBPTDoliDwh38MXjP/jnb0pZhZahdn/X3bDk=;
 b=dUDoS3eBmEVZmVUgQhLN6b+bT1OEE0gM6NqJP+EUjf2RiZvrGnG6+AU6xdU4AASoVuLlXvfHzuPZ/vwxceRqzbIVDmPoUoOaxli3Uaw7VZTbPVwQeG3re2DGoHSBTq6M/U8B6Fja5EKm8J2fy8VtZJbKC8oLtySm/8F406wWP3gKgWz8KBfX8Ti3y6vwz3qDviZny6VsZlXXEWO3lg870gq8p4nLjk+zmY4FcFARtFzxiTSGwnN4FwzjN5OhDR0r+H3EPJ/Tn11lOAgQxf404YP/vd0rS0ZJ72EQ5jMLCzfxjI4ADdFuLCO0lmpkYfC07GvPNsvfoEZdrmiWk1aFBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW96u36lBPTDoliDwh38MXjP/jnb0pZhZahdn/X3bDk=;
 b=c9Ld2sowY/hc1op/RY44L6ZycOXKa/UdcXx2TqkLLMGyzCWYJWhMmIFM1Wy80nbpnwLKHB7Fm8AVFocKKrIowWkGzgfmvq52waZDfadJBBIrDQ6wuxY8JBcAQhuFGp70zuiqBap5z86/4rG3IVLHtQR8J0rXZsvOqoFop3STleA=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5645.eurprd05.prod.outlook.com (20.178.120.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 14 Nov 2019 17:04:01 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 17:04:01 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Edward Srouji <edwards@mellanox.com>
CC:     Noa Osherovich <noaos@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Daria Velikovsky <daria@mellanox.com>
Subject: Re: [PATCH rdma-core 1/4] pyverbs: Add memory allocation class
Thread-Topic: [PATCH rdma-core 1/4] pyverbs: Add memory allocation class
Thread-Index: AQHVms8rzs2wkDxYSUeydp5vKVoinaeKqqeAgAA20ECAAAPqAA==
Date:   Thu, 14 Nov 2019 17:04:01 +0000
Message-ID: <20191114170356.GW21728@mellanox.com>
References: <20191114093732.12637-1-noaos@mellanox.com>
 <20191114093732.12637-2-noaos@mellanox.com>
 <20191114133345.GS21728@mellanox.com>
 <AM6PR05MB41529E366C190E52B0C58518D7710@AM6PR05MB4152.eurprd05.prod.outlook.com>
In-Reply-To: <AM6PR05MB41529E366C190E52B0C58518D7710@AM6PR05MB4152.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0148.namprd05.prod.outlook.com
 (2603:10b6:803:2c::26) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fb1e522-6421-468e-fdcc-08d76924a554
x-ms-traffictypediagnostic: VI1PR05MB5645:|VI1PR05MB5645:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB564507E2367A54110338440ECF710@VI1PR05MB5645.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(33656002)(4744005)(54906003)(6436002)(316002)(7736002)(6512007)(229853002)(305945005)(37006003)(476003)(256004)(6486002)(5660300002)(36756003)(446003)(11346002)(86362001)(6636002)(2616005)(486006)(66066001)(6862004)(25786009)(66476007)(64756008)(66446008)(102836004)(4326008)(66556008)(8676002)(8936002)(478600001)(1076003)(66946007)(3846002)(26005)(81166006)(6506007)(99286004)(2906002)(186003)(52116002)(71190400001)(76176011)(107886003)(386003)(14454004)(6246003)(81156014)(6116002)(71200400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5645;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKj3yYMq5ks446pAuWzWGUrhopvbzO7FkQU77cAkG15SS6/Y6N4kWiEpDd0JyQDHnxu8tac84zyIxIJ68SktQTHV5j5VUDNkd1ggjcTAzZg5PgIjdBVtj7f68s8N9b3PCD2ThG2Pzq0PiEhFPtspY7Y1eGpQY7eFWTe6Y8G6vOr2HuY0meV1aG/gwYq54JcQA/H+EEfiFrhKyg8VaNVJ2n6P8WKPZqez2vTyYoqgTNfWZgy44aF11SwW2ncBT/5Sw+GaYsHLrvDWFMmwx80oOdyxUenTNUn3r99xh5xSnyYvK6uiGpwAw5AVBHJe+QdoV9nHr+K1vn8b8Y2GJTVIhDTa4MuzjyvAVTG+fuFEJPREQoM5XQVnwWFQK/hL1qKdPFgjZeW54NnP1ExbI1FD87uTH+dNCTzWFKtbDLnr446qE+lJF0/WF90hmJ4ftnv9
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D6CB8A6302F2A4CB8A47CCCFCCF41FB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb1e522-6421-468e-fdcc-08d76924a554
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 17:04:01.1223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRmzR/tb3+M3hipDGwlDvF18BMLpgE5/35BCK9PT2t9S38gUAUAfUWnMCGJ9J8y1qIoIQHspAV9XPhElqJjt+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5645
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 14, 2019 at 05:00:00PM +0000, Edward Srouji wrote:
> I put the memory related functions under MemAlloc for multiple reasons:
> - The methods won't be confused with the C functions
> - The class is extensible with more memory related methods and functional=
ity
>=20
> I think the other option would be defining them in another, separate, mod=
ule (outside "base" module - which I less preferred)

It is an improper way to use a class

Jason
