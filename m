Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8C85E0691
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 16:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfJVOhd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 10:37:33 -0400
Received: from mail-eopbgr10057.outbound.protection.outlook.com ([40.107.1.57]:10630
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJVOhd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 10:37:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2Pb4vf5coUBHKVAtBtHqYqDJxB15aqzqbwlOK+fuo1KDlzLtqn0zpf34DAqzFuj0S3wzsIVhgHv3vuxpQizFmIzbOnTUgfe6b3snLEVemcVWhT1+BeBVWNw5K0ilMmnTOo/iD4nmZpnkckLuszTJ5PsUbx5KMVKe2AUIwG+bYTmBSIgOa3TBM5vNcpywjb7odhtEMdVwqC/J7l1zEEOZH/f2hOJGcPpkKq0o+Zh/WGX4PEcHLUYZUq0sVUsB9ve3x1DF3azLkRSlnSOepNh5ITIouLfPmX69DZbdgesHIuxq0VIYd4loBkeMFyMIgAO3K+Bmp/D1+8REWgJ5kZbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGQ3o+N4Z6FmwJKoyiSVkCzhKkI0EPOWvnU7J7z6ek4=;
 b=Pze6S1d+2D/l2i1imHuT3iNwZJ2H58kZ4x+bTi+8+Qpz5gHbYLfKssTy4ud54P98vaOkc0EHf+7YDs96Yx0khACXR3pYtV92OhK5cd+kswacpaTQyGoSy8JpPgkPPSSveYMtS4utWBAHVIwRASeCrsWurbYVLEfMF9fQtcjyxaQXOZgSxffhesCOJX8/P5iBqRg03x6iRoLvOXuOTry04X2A8jvC2xtHN85qRsOQ6Zi6ltoVLdLJ2wmtXqu0xZCvJLQzWu3QodB05Ow7WRhPBbWIJF8ge2isFFJ3cHZiwP6IHDE1TS/pDVAS/fNZxNKp7jJshIq7BhjUMYFNYRa2Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGQ3o+N4Z6FmwJKoyiSVkCzhKkI0EPOWvnU7J7z6ek4=;
 b=JJuZmSgQ28+kStmWyoTOhC12jQwta3K2AZvu2zESpbiZpU6zCi1kiXc+pyiLoQ5CJEYyaDLV50oWeetrR6HaER/LDZV6Rj48M7vEEkOS+MhHw56IsUAPowGMC0zbxZZ3JwkSMfANAANx16EAX6JHgP1NHevkr2pPIq1DTRfhE4U=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6224.eurprd05.prod.outlook.com (20.178.124.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 14:37:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 14:37:28 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Topic: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Thread-Index: AQHVg4Sqa7CCxCToXEeTrrYAqVQVhqdlSPyAgAARfwCAAT3hAIAALQoA
Date:   Tue, 22 Oct 2019 14:37:28 +0000
Message-ID: <20191022143724.GD22766@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <5fdbcda8-c6ec-70aa-3f89-147fe67152f2@intel.com>
 <20191021165828.GA6285@mellanox.com>
 <35d803f3-a24a-8a5f-745b-52c2f9876b7c@intel.com>
In-Reply-To: <35d803f3-a24a-8a5f-745b-52c2f9876b7c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0095.namprd02.prod.outlook.com
 (2603:10b6:405:60::36) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cae1c0fd-476f-44c4-68a6-08d756fd5cd9
x-ms-traffictypediagnostic: VI1PR05MB6224:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR05MB6224F99570787AABFF6966CCCF680@VI1PR05MB6224.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(4326008)(86362001)(1076003)(102836004)(305945005)(6246003)(54906003)(26005)(11346002)(8936002)(7736002)(486006)(2616005)(446003)(229853002)(33656002)(6116002)(66476007)(66556008)(64756008)(66446008)(316002)(36756003)(66066001)(3846002)(66946007)(186003)(7416002)(5660300002)(386003)(6506007)(53546011)(81166006)(478600001)(81156014)(14454004)(6512007)(256004)(8676002)(99286004)(71200400001)(71190400001)(6486002)(25786009)(2906002)(476003)(6306002)(6436002)(6916009)(76176011)(966005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6224;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tvqE1W1SXc92efsbTpJO1cx1soAur+L+EtFtqN7LlkkfLlMW3/aohWOePoQZcjn9E+77EOTtF1uglR2id28SHCBqxWfSRN8+HVLtJEyhvu3be0gAiPdPCdpbNa55KlTB57NNk+YFDvcxR3GUFYFNFwtZEiz0hwIEQQ3mczB2nwmmf3p4VobDMN3lzYPSfMsZJEMZCiah/CjFoS60sCQug0apth6XDdj69fqqI7oVYnrx9x2wfryDpYrGzV0X6Tjmf4EJnpJJkpq1K4uyXf19w65+xhgI8v+2vxYoe8A7YLM9x2DIirMwvtjX4Wp1bTulgUbAKkqGo8noMvUBmvEmi0fQmdPzt0LGuyB9XiKGto9EBl1Fb/O8qNd5XQd3GQojFwwMSOZqS3AZGXiHNoG2weCj3e1lQYfmSj3qvNpcL/LfStr9XVxBRs5c4ZwKedotsyyb/jZNBDuxnq93WZrjhD5OO5E08ExeC4+n8XBBE6U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89B2B12146ECCE40A22BE95FBC8684FE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae1c0fd-476f-44c4-68a6-08d756fd5cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 14:37:28.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4SdPp13xb+lmlF3hPuJDKVnQXJ5NTCZpbqxepAk97rcVF5daripJveQogQJXNbSoEUPXOc/YRS8wzIwhEdLew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6224
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 22, 2019 at 07:56:12AM -0400, Dennis Dalessandro wrote:
> On 10/21/2019 12:58 PM, Jason Gunthorpe wrote:
> > On Mon, Oct 21, 2019 at 11:55:51AM -0400, Dennis Dalessandro wrote:
> > > On 10/15/2019 2:12 PM, Jason Gunthorpe wrote:
> > > > This is still being tested, but I figured to send it to start getti=
ng help
> > > > from the xen, amd and hfi drivers which I cannot test here.
> > >=20
> > > Sorry for the delay, I never seen this. Was not on Cc list and didn't
> > > register to me it impacted hfi. I'll take a look and run it through s=
ome
> > > hfi1 tests.
> >=20
> > Hm, you were cc'd on the hfi1 patch of the series:
> >=20
> > https://patchwork.kernel.org/patch/11191395/
> >=20
> > So you saw that, right?
>=20
> I do now.
>=20
> > But it seems that git send-email didn't pull all the cc's together?
>=20
> I don't know. I thought it did, at one time I recall trying to get it *no=
t*
> to do that, when preparing some internal reviews. Haven't used it for a l=
ong
> time though, I've been using stgit.
>=20
> At any rate can you give me a SHA or branch this applies on top of? I hav=
e
> pulled rdma/hmm, rdma/wip/jgg, linus/master but seem to have conflicts.

Here is a full tree:

https://github.com/jgunthorpe/linux/commits/mmu_notifier

It needs the ODP series on the mailing list to apply

Thanks,
Jason
