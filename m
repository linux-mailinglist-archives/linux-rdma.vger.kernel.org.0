Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA40F94B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 14:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfD3MxU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 08:53:20 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:42374
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726166AbfD3MxT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Apr 2019 08:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cXZxkeqlrc+0MIWbtdKEt/JanUvYMZ9uByXHEKHdec=;
 b=bwvnz3kfCkC4NI4BVq3Ek+bLJlWiNKeGGfCaupqGxFqdqqxdetJ/P1mVZAz3p5wERZM7n1H+0wYki6bRZidVKbhXX+cPHspHXkP2Wa74APmsTiEBLP22to/HOJ6zCqDYXsmaS+VpMOVYUxLwDB9M28d4GgmPPASRxV0HDUnbD8Q=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4478.eurprd05.prod.outlook.com (52.133.13.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Tue, 30 Apr 2019 12:53:16 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 12:53:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHU/bjRDQW4dOHvME6ENVPTZDYrA6ZRzCoAgABydYCAAAV2AIACZ80A
Date:   Tue, 30 Apr 2019 12:53:16 +0000
Message-ID: <20190430125310.GH3562@mellanox.com>
References: <20190428115207.GA11924@ziepe.ca>
 <CAHk-=wj4ay=jy6wuN4d9p9v+O32i0aH9SMfu39VKP-Ai7hKp=g@mail.gmail.com>
 <20190428234935.GA15233@mellanox.com>
 <CAHk-=whWh+5-jGmgw2HPM8XhzXzvGcLo19UGLtqYe_teJsRgRA@mail.gmail.com>
In-Reply-To: <CAHk-=whWh+5-jGmgw2HPM8XhzXzvGcLo19UGLtqYe_teJsRgRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:c0::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8442cdd-39ab-4c34-7412-08d6cd6acffb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4478;
x-ms-traffictypediagnostic: VI1PR05MB4478:
x-microsoft-antispam-prvs: <VI1PR05MB447840273811B28C7569B2EDCF3A0@VI1PR05MB4478.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(396003)(39850400004)(346002)(199004)(189003)(8936002)(1076003)(6486002)(4326008)(446003)(316002)(8676002)(36756003)(52116002)(81156014)(33656002)(6436002)(71200400001)(76176011)(256004)(71190400001)(93886005)(6512007)(7736002)(81166006)(305945005)(66556008)(6246003)(25786009)(64756008)(66476007)(66446008)(2616005)(11346002)(66066001)(476003)(14454004)(68736007)(54906003)(53936002)(478600001)(66946007)(6506007)(102836004)(5660300002)(73956011)(26005)(3846002)(86362001)(2906002)(99286004)(6116002)(6916009)(186003)(53546011)(386003)(229853002)(97736004)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4478;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uon7XC8e+C7DFgq0ePAvSy1d8as9FgvZntTzFDgTSMSFzLRuZqbMfZp2DbharRjxuLtbXUOq4tLhqCDZ+N75iKlIxFbnTiREkPPiQx7f84Q+tcID+A5qh2L7Phln5D1JSm6phl5kt1ghKs560psafHg8yjlcX5WuWCI4PIy6hXqTbtaG0p437aa7coG6dvm5EVo2p3KzlBSATFJG7oAq7z4lbG9+XKivQ9u+Y6VilyYBvcaJEPhAmwz7UAHt1N2pVu8TpS73LmHlK0lmT2fy7MfaZ7GzavqmGHN8iz2wyKu+WAzkJ/HHbfVRvzvtRcOxTPHM8cfjDRJfRAnk5PO/jg1UyUClpsjEdEFePL3R8p3yqLB2lbx0uuUrYjpDpXWCezfBOBLyLJWDob6jVGjxhlbBHBOibUYxabyB70ly1oU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <550815CEF2E54F45B18ADB0FA7963199@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8442cdd-39ab-4c34-7412-08d6cd6acffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 12:53:16.1556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4478
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 28, 2019 at 05:09:08PM -0700, Linus Torvalds wrote:
> On Sun, Apr 28, 2019 at 4:49 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > It is for high availability - we have situations where the hardware
> > can fault and needs some kind of destructive recovery. For instance a
> > firmware reboot, or a VM migration.
> >
> > In these designs there may be multiple cards in the system and the
> > userspace application could be using both. Just because one card
> > crashed we can't send SIGBUS and kill the application, that breaks the
> > HA design.
>=20
> Why can't this magical application that is *so* special that it is HA
> and does magic mmap's of special rdma areas just catch the SIGBUS?
>=20
> Honestly, the whole "it's for HA" excuse stinks. It stinks because you
> now silently just replace the mapping with *garbage*. That's not HA,
> that's just random.

This should only used in cases where user space only writes to the BAR
page (it is an interrupt to the device essentially), so it doesn't
care that the pages are now garbage, we just need to redirect the
writes away from the bar.

However I think someone later on added a readable counter BAR pages to
one of the devices :( So even that ideal wasn't respected.

> Wouldn't it be a lot better to just get the SIGBUS, and then that
> magical application knows that "oh, it's gone", and it could - in its
> SIGBUS handler - just do the dummy anonymous mmap() with /dev/zero it
> if it wants to?

This does sound more appealing, and probably should have been done
instead. All this VMA stuff has been a big pain in the long run

Thanks,
Jason
