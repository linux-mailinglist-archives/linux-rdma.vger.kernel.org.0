Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B43E06EA
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfJVPB5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 11:01:57 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:49931
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727152AbfJVPB5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 11:01:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mm85OUkDNj+EIYO1+SM3f3L4mMG3Qtzj6ScTZulXgMOURy8Mf8g4e25IIckHjySU0jY/u2zQ6JjNb2UgqYfjoyKYZSSca0LyNPyNi1oxAk3WqL44s9yKSjJYqFricP/B3mYSekTlO3tySYl6tD5abXFjxeZVGFlyhERVmlB/IIgkW4Cw0J2ZDvQiYDhyn/L3NVDbcbM4qjvow0U2Pb+tYFm99hv6hKcyGzAFL3Pntv33Y21ip6nbgqPpBEllb84JrNCWzOiIf4XkJh5fuSoVFdbbJxId8KlB92DBudZj12GKoVlHu2mzVDf4ZlcS/MHkZw1oTtoWSVy39ueL7BFMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA/GX8228kJgvWv7+hujYpprLyjBUIYS4AnDJs1IXe8=;
 b=f35c1tyAjeOSjfy/Urj2rAXIM/8BruRIvOZkuW1Os5yLHDSXi0ddA88n33eGwMS7ZZ8W4CoDCfx4wgFhy3zo2srmb8Uc2goAU/Gp4i9yrKtZETC9Nnjcj3W7A5aaKaCShS3Cj/aAFFxV2rAzZYQ39tWWIFfBMgsmj9KA2TZOTupGcRU4SKbh7wZFIROMCEpAwAwfZOWAaXiPX6vfXlgyvwqn6CwT4fJmCWQHnugIotUJVZ04pwPXX7u1wnmyy1L2e7id4janSc2EqXjCbSPrw9veWLzYaDg5bTQnHh9SBKUpjaw4Y9K1nCfrZum64CjMD0UIC3IFA93LoKcPR1uYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA/GX8228kJgvWv7+hujYpprLyjBUIYS4AnDJs1IXe8=;
 b=GCZ+CEdRJoUiqqIefzbhgHxWGgXlqN0Mu7Ip4E1EvRiUiHN17S9vj8E0FrsLLZPJWks+2TGA0TiKp02lWFWj0Rx9R9qmIoLETs8CqYWQfP8N9E79LMoSJHJcH+02pU63ijtXJXLwSCF3fcgx7SmfPT3Gg91/5vbwsq1LvbUSNr0=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3232.eurprd05.prod.outlook.com (10.170.238.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 22 Oct 2019 15:01:13 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 15:01:13 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Topic: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Index: AQHVg4Sqa7CCxCToXEeTrrYAqVQVhqdc+JgAgAB3OACAARovgIAAficAgAAF3YCAAdJKAIACvAUAgAGLqgCAAAilAIAADDUAgAEY24CAAHZYgA==
Date:   Tue, 22 Oct 2019 15:01:13 +0000
Message-ID: <20191022150109.GF22766@mellanox.com>
References: <20191016160444.GB3430@mellanox.com>
 <2df298e2-ee91-ef40-5da9-2bc1af3a17be@gmail.com>
 <2046e0b4-ba05-0683-5804-e9bbf903658d@amd.com>
 <d6bcbd2a-2519-8945-eaf5-4f4e738c7fa9@amd.com>
 <20191018203608.GA5670@mellanox.com>
 <f7e34d8f-f3b0-b86d-7388-1f791674a4a9@amd.com>
 <20191021135744.GA25164@mellanox.com>
 <e07092c3-8ccd-9814-835c-6c462017aff8@amd.com>
 <20191021151221.GC25164@mellanox.com>
 <20191022075735.GV11828@phenom.ffwll.local>
In-Reply-To: <20191022075735.GV11828@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR15CA0008.namprd15.prod.outlook.com
 (2603:10b6:408:c0::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6eba0954-182b-48f3-dfd0-08d75700ae30
x-ms-traffictypediagnostic: VI1PR05MB3232:
x-microsoft-antispam-prvs: <VI1PR05MB3232EB9BE7E6F210BA678F51CF680@VI1PR05MB3232.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(99286004)(256004)(2616005)(110136005)(7416002)(86362001)(14454004)(476003)(8936002)(36756003)(52116002)(305945005)(14444005)(478600001)(2501003)(76176011)(7736002)(11346002)(446003)(3846002)(102836004)(386003)(6506007)(6116002)(186003)(81166006)(229853002)(1076003)(6486002)(8676002)(6512007)(33656002)(25786009)(66946007)(316002)(2201001)(66476007)(66446008)(64756008)(66556008)(71200400001)(71190400001)(6246003)(486006)(66066001)(26005)(2906002)(5660300002)(81156014)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3232;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6UIcX35492dkSb5Qs7UCCOOF7qT8N4gw2PsUdg+cRDwDbwrrDk5xHeFDmvPiaPKTmcxLqrmKCFubNJ5PgUxgCunZ5EZyXh6X43oSvLKFJ+4etUX5dFfw+LgcQqXqGAL4faflQmSMBJM2B5D6ZJoShGOErgebZ0xOcXNuA25RYSEausLjIHeoHWo+qgwp6fGZMrA2B5Ax40krcJ8MHzct2/ZdtAsk7lbqR7vvJWdKykKIakT2CyyGFs602uXBBBopowy/rWO5c81+shJPFZMqhoFiOH9EiHECjilXtOHMf0gI/+7bDlv5nAX3ztGrrMGZDG5Re3M5m1Y/iMt40L+9oe0FZKWUGihhYZZC+vLRgGXfHANwxvlhyGo1HZaAC/tJS30vPsI8qIFFL8uleKH8gM4nOynwDR8fNFHV4OE77Bs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B4FF14CACF6CD7439A8D2A6BCF779D62@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eba0954-182b-48f3-dfd0-08d75700ae30
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 15:01:13.2568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awV1s2V3uIzuO1TcgScktyRmOIaNKyEQtk3FWunu6TrcHCgkol2gwamtZts1FFT1vXch753M5F/mL/upPMSztw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3232
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 09:57:35AM +0200, Daniel Vetter wrote:

> > The unusual bit in all of this is using a lock's critical region to
> > 'protect' data for read, but updating that same data before the lock's
> > critical secion. ie relying on the unlock barrier to 'release' program
> > ordered stores done before the lock's own critical region, and the
> > lock side barrier to 'acquire' those stores.
>=20
> I think this unusual use of locks as barriers for other unlocked accesses
> deserves comments even more than just normal barriers. Can you pls add
> them? I think the design seeems sound ...
>=20
> Also the comment on the driver's lock hopefully prevents driver
> maintainers from moving the driver_lock around in a way that would very
> subtle break the scheme, so I think having the acquire barrier commented
> in each place would be really good.

There is already a lot of documentation, I think it would be helpful
if you could suggest some specific places where you think an addition
would help? I think the perspective of someone less familiar with this
design would really improve the documentation

I've been tempted to force the driver to store the seq number directly
under the driver lock - this makes the scheme much clearer, ie
something like this:

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index 712c99918551bc..738fa670dcfb19 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -488,7 +488,8 @@ struct svm_notifier {
 };
=20
 static bool nouveau_svm_range_invalidate(struct mmu_range_notifier *mrn,
-                                        const struct mmu_notifier_range *r=
ange)
+                                        const struct mmu_notifier_range *r=
ange,
+                                        unsigned long seq)
 {
        struct svm_notifier *sn =3D
                container_of(mrn, struct svm_notifier, notifier);
@@ -504,6 +505,7 @@ static bool nouveau_svm_range_invalidate(struct mmu_ran=
ge_notifier *mrn,
                mutex_lock(&sn->svmm->mutex);
        else if (!mutex_trylock(&sn->svmm->mutex))
                return false;
+       mmu_range_notifier_update_seq(mrn, seq);
        mutex_unlock(&sn->svmm->mutex);
        return true;
 }


At the cost of making the driver a bit more complex, what do you
think?

Jason
