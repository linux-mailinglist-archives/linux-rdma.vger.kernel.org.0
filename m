Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBC9B1048
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbfILNrm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 09:47:42 -0400
Received: from mail-eopbgr150040.outbound.protection.outlook.com ([40.107.15.40]:22148
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731791AbfILNrl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 09:47:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsMlnE8I4y69ofQ+bww3gcIhDjvhPMpL0H0s4DkQt63eS+8jAZLoMtZKovD5c1jzFrSPlD7GlyL5FHRZcaNocf8Fhcahwr0erkz3pLhXDOtcRUO6YANWoUMhM5VWjcSfJQWqtkxCe5k7xDxOE5eDH9GkhSN7ygRs9sJFJiZQWfGJ8rWYuFCJFP2RDNoQfkH+6VLpDdLxq/T4Y5bEWh7K0F5cFhx59j7O+y+WG+TowOgOAP3lKDzGb6PPK8FZFPHAX2Jrf/AidUQ5hRgvENre3Mt8a9iL9q2tf2gX3SuM/hlYvYEYZDQPmnF9VjePWNCximdOJ5LCyH19retg8WNuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beQ2ixoiMFV8S1fh/naEBwOmLD+W/VJj0EMKmfOHUvs=;
 b=F+ENJyhdt2Shg83oiz8dZ1py04FxI0+NQpZA0U6Nkm1S3T1S1iXc3ArAvItZmEE4EKhXD0EPBQY+kFvWKVoHgiM0ztTxXfWuupjr92gFV+9rNGavEsh+DQpIagVARZsjc2UIMvZ/RvbN+v0aBfQW0SUMZn40IiWmes7T3PoLFraYA/Mpc4oyzG6t2ndvYjDfuzTRVypRfL/+PYqHmp6MLlYB6VihGmKmPPna/NeP/gvsMM6AXtuIUK38VDhC8Nv9Rk0KDcARN9G98eq9JqEsISJ2Iok3bTNfTf9XcntLivXnqcI7rpL+XT6OgcHvEaSo23rWzCboGI02A6iPx6/DFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beQ2ixoiMFV8S1fh/naEBwOmLD+W/VJj0EMKmfOHUvs=;
 b=QcbB8wjkuGJbMnbXOlJSu0BVU1Rk0BKYCi6Bouq4QQpfzCAYZSuGebm2ogsTKVGVckm7DJOqCVTAHWnVR0ye6GDxz4MZLKfCs534NStcEKHnw2OUopT3g9F+eveEH9GExp+HtUK8MWM/jhMkgKQcyhZoIbPhpi2pkl+ZbV4EuCo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4687.eurprd05.prod.outlook.com (20.176.3.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.14; Thu, 12 Sep 2019 13:47:38 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 13:47:38 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Parav Pandit <parav@mellanox.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kamal Heib <kamalheib1@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usnic: avoid overly large buffers on stack
Thread-Topic: [PATCH] usnic: avoid overly large buffers on stack
Thread-Index: AQHVaXCjw/Ut2E8kMkCNr8L8Y0rqrA==
Date:   Thu, 12 Sep 2019 13:47:37 +0000
Message-ID: <20190912134722.GA26019@mellanox.com>
References: <20190906155730.2750200-1-arnd@arndb.de>
In-Reply-To: <20190906155730.2750200-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:3:9a::14) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4d6389d-f3f4-4d99-10d3-08d73787c5ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4687;
x-ms-traffictypediagnostic: VI1PR05MB4687:|VI1PR05MB4687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB468735F7649FA05A5BC7D3CDCFB00@VI1PR05MB4687.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(8676002)(81166006)(86362001)(81156014)(14454004)(6916009)(256004)(305945005)(6486002)(7736002)(33656002)(2616005)(3846002)(54906003)(476003)(6116002)(25786009)(6506007)(26005)(386003)(6246003)(186003)(486006)(8936002)(446003)(53936002)(229853002)(6512007)(36756003)(52116002)(102836004)(11346002)(66066001)(76176011)(4744005)(478600001)(316002)(2906002)(1076003)(66946007)(64756008)(66446008)(66476007)(5660300002)(4326008)(99286004)(71200400001)(71190400001)(6436002)(7416002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4687;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1WItz+RTZg/Nu0iunuK7QWWH7MMUJkNnVnMIYWf/fuKthkwSA/1ACrKUSvCiirNc9PBEaAQJ26zVigssjbek6aHXNvDqwdEyeHB6TFpOVNIWjKhc5W7UlPJhe+6oze+t9tOPCW9qdfgimjKTg1/U3BKOeisYTQ5h2K6GZVJ6sCLpkAaRCirt7UCVJZSsVwIGkNQnRYv9jJh7zCxKj7+CMhhfKcULea+THOSx35hIHuLjdHTIzjf2patHf5VIDCr0q8j1bykiqYQbQZ5NIanMtcqRsV/LSq2ZCdKQeIec6jXQq1jyOgChtWL4K/VRhCjKOF1OKi2gbDpQ6pYDOoGaMMCaLkh9roQrXvgJdPIU1cSIfe6TyWWq1i+SfQ+7yy6wjIndZJMqC0F6iTk8FDhdpibJQQcvyvCmUe62ALtnZOo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93998CD44856FA42A74BA038E083679E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d6389d-f3f4-4d99-10d3-08d73787c5ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 13:47:38.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LeTZNFM5B3TFBrhY13011avW4EvC6NSumKXvAYxbhygp9F41/CzkgYtGvYGczhHjwHXXsmMreUg83s2earFkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4687
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 06, 2019 at 05:57:17PM +0200, Arnd Bergmann wrote:
> It's never a good idea to put a 1000-byte buffer on the kernel
> stack. The compiler warns about this instance when usnic_ib_log_vf()
> gets inlined into usnic_ib_pci_probe():
>=20
> drivers/infiniband/hw/usnic/usnic_ib_main.c:543:12: error: stack frame si=
ze of 1044 bytes in function 'usnic_ib_pci_probe' [-Werror,-Wframe-larger-t=
han=3D]
>=20
> As this is only called for debugging purposes in the setup path,
> it's trivial to convert to a dynamic allocation.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_main.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
