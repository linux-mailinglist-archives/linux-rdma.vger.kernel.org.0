Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA04EDF3B6
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 18:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfJUQ6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 12:58:37 -0400
Received: from mail-eopbgr10061.outbound.protection.outlook.com ([40.107.1.61]:3906
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbfJUQ6h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 12:58:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyqTDdJ5asdWm6rJcxDsCbJXWyrXfcAJkMwPQmRIbKiAop2WkdR38yJy2TTDw8v18ZtAixXaLR2D5+e0kK7zyXSMGMboVqU6ohl2s87o4+MHBgAXEE6KqFQvqYXZa7Ua8mGA8eVJpIkOURxX2RPfScGzgVgk993BLFAo70wnj1ESY0v7k/UGqaej+k37lZqoXTdYqF8mSPT8G0q/alfwixTNh4UQKBzzFc3O3ht9hChQvhD8dMtaoqWWhuxeF/cfkCf1kSgYB2FKHjyMFezuJ/kFEcIpGwRoiW5vVBmp+UPmMrHuDRIuvlCn37C//Rfz7ieKQrkPeXR5q72z9kl2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFlN5t3UGozcMevuLdzlZwjri0Hmv1gvskUCJgPfxEQ=;
 b=JCUElLHM9QD7lYtjSVhEEYN5k/C4TVMtjJbu1Ke6f+DA4oX6nC75LuE2z5p1dzW9fFVPkBI6C/p5x3e0ORViFXrIZfqM4ZrqeMyYUlzTBQyYVpdgWQ3NxOT6virUPoVAhQUonHmctxc7n1TlXFhS9tEeFgg2l986DXGmGOP1KP3jWJYgsG1/A64L+YhTVRi/xJqoyrBpNe9bwLZBkqSBFZaIXhXTXCo+oZ5KNPS2ny/WPpesipn4l2VbiRzPW8f/fk2RSXgN0OY6uu1QqL7ba19ZHe0WMei6VdEbfrKqA9ys3N06xz/IUOC9L5a2D4lU3mmBrOTAdSxbmA6i3NSfcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFlN5t3UGozcMevuLdzlZwjri0Hmv1gvskUCJgPfxEQ=;
 b=f8qJYOxs3ZUAdo7qGx9rPBymNiej4qbXjfgCQkb573Ido4mogR/amppl9vBBt6NmKsFbD9gieTDZYtkWLIVdGYaUemOwCOeab3SyppkGkPdLpRp9y+zCvYP6UPGJ6VxTAObcQLPPoNRI9BgXnlsa17jkP88ZamNZYp9kup+1PEU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4751.eurprd05.prod.outlook.com (20.176.5.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Mon, 21 Oct 2019 16:58:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::75ae:b00b:69d8:3db0%7]) with mapi id 15.20.2347.029; Mon, 21 Oct 2019
 16:58:31 +0000
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
Thread-Index: AQHVg4Sqa7CCxCToXEeTrrYAqVQVhqdlSPyAgAARfwA=
Date:   Mon, 21 Oct 2019 16:58:31 +0000
Message-ID: <20191021165828.GA6285@mellanox.com>
References: <20191015181242.8343-1-jgg@ziepe.ca>
 <5fdbcda8-c6ec-70aa-3f89-147fe67152f2@intel.com>
In-Reply-To: <5fdbcda8-c6ec-70aa-3f89-147fe67152f2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:208:15e::46) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bafb636-c336-48c8-cbde-08d75647e702
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR05MB4751:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB4751E3B605CD85B6453633F5CF690@VI1PR05MB4751.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(14454004)(11346002)(446003)(966005)(86362001)(33656002)(1076003)(25786009)(6916009)(81156014)(8936002)(8676002)(81166006)(478600001)(64756008)(66556008)(66446008)(66476007)(66946007)(486006)(66066001)(186003)(5660300002)(386003)(256004)(476003)(4744005)(2616005)(26005)(102836004)(53546011)(6506007)(71190400001)(76176011)(52116002)(99286004)(71200400001)(3846002)(7416002)(7736002)(305945005)(6116002)(6486002)(4326008)(6246003)(36756003)(229853002)(6306002)(6512007)(6436002)(2906002)(54906003)(316002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4751;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a2AscmFxZMvMh7umM9ml1xvkjD7/KAn9E+K4LuOt0mOmZV7uxAzKt91w/jzJOR0dJ7rjwcM1IvzQ+2rBTxOhYdsdHj20qeLHEtemH24Msiy463JaAOM8ejMmETPi5pk1Q9Sb8M+KpkluJN4bt6u1n/mIM/qd8+PC3reBSjcJeb7rBivYWz0FoojijxZyFPOUx310c3/q7oB6OqOtRctesumjSVEZkjOUhhfGKOODk7AsiQdWiFo3aXBEvwepkMIb2BEp2hurdTD/8iEOTvHonO//dqNZcTAQt9zjaAF0hg6zgj4w2bgd9Cj8q9Z+T1xAXbcJtXjOvwY3sUrARtTBS0cZ+j11d8xQir0NuGQrFi708TBNJU+CiuwvJM2g4nDmjk0F0pHG64k+oZ0gEhWs7QtiWupAlZJi4kgA4y/Efko6Un6BASLTFyq4YcGB+ah3/RiULbhPa3qcal8fD2GTZkcGN1NYssY6ipn+9VorzaQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BEC4912CF056E498EEC73DAB37D8D9B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bafb636-c336-48c8-cbde-08d75647e702
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 16:58:31.7439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtObhpIvyLXiMbHmlOTySSdn0phGLZ2o8sFLlU55MoazkmQyEt5eZmfp2X5HMXx6AgMrCY1k54+ECnSUsQNjDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4751
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 11:55:51AM -0400, Dennis Dalessandro wrote:
> On 10/15/2019 2:12 PM, Jason Gunthorpe wrote:
> > This is still being tested, but I figured to send it to start getting h=
elp
> > from the xen, amd and hfi drivers which I cannot test here.
>=20
> Sorry for the delay, I never seen this. Was not on Cc list and didn't
> register to me it impacted hfi. I'll take a look and run it through some
> hfi1 tests.

Hm, you were cc'd on the hfi1 patch of the series:

https://patchwork.kernel.org/patch/11191395/

So you saw that, right?

But it seems that git send-email didn't pull all the cc's together?

Jason
