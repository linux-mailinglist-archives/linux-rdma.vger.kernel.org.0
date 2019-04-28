Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6255DD9F8
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 01:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfD1Xtp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Apr 2019 19:49:45 -0400
Received: from mail-eopbgr30065.outbound.protection.outlook.com ([40.107.3.65]:3380
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbfD1Xtp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Apr 2019 19:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt07+4O0RX5Qhvic6+yNOfJzpEJvucjwxXbyvZECQW4=;
 b=LmPJs1v1uEssXPRZYYNIT45q3ZuzyLYTV18PqdypfrazelDpdfQMeBlB21gBySOS0FXfLclytsBnPCri/6xTBfTYiynPrcm5Pd+XqwnEiho9EqysRpxvdGstlbfZKEImcXaPESeZWiaOWmvZ3lPU50U3LBNw12nQKU/KG1diy0I=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6142.eurprd05.prod.outlook.com (20.178.205.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sun, 28 Apr 2019 23:49:40 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1835.018; Sun, 28 Apr 2019
 23:49:40 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHU/bjRDQW4dOHvME6ENVPTZDYrA6ZRzCoAgABydYA=
Date:   Sun, 28 Apr 2019 23:49:40 +0000
Message-ID: <20190428234935.GA15233@mellanox.com>
References: <20190428115207.GA11924@ziepe.ca>
 <CAHk-=wj4ay=jy6wuN4d9p9v+O32i0aH9SMfu39VKP-Ai7hKp=g@mail.gmail.com>
In-Reply-To: <CAHk-=wj4ay=jy6wuN4d9p9v+O32i0aH9SMfu39VKP-Ai7hKp=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::36) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93058b68-179e-43b5-8115-08d6cc342daa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6142;
x-ms-traffictypediagnostic: VI1PR05MB6142:
x-microsoft-antispam-prvs: <VI1PR05MB6142B9E40D7287400A454FE7CF380@VI1PR05MB6142.eurprd05.prod.outlook.com>
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(6916009)(6512007)(99286004)(66946007)(53936002)(73956011)(66556008)(52116002)(3846002)(36756003)(478600001)(66446008)(2906002)(66476007)(6116002)(6246003)(76176011)(316002)(54906003)(5024004)(8676002)(81156014)(81166006)(86362001)(8936002)(97736004)(256004)(14444005)(68736007)(64756008)(71190400001)(71200400001)(11346002)(446003)(5660300002)(2616005)(476003)(229853002)(26005)(66066001)(6506007)(102836004)(386003)(53546011)(4326008)(7736002)(1076003)(305945005)(25786009)(6486002)(186003)(486006)(14454004)(33656002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6142;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EOqeBteptntUvH9L/zSdnlH9TK1KBYgETpNqig7/6EnslPowqQYCYfDnBO7PBbwdiUjfREAeqXDpvlPRXDSej/CJl6F4XB7E16TEC3Qjb5IDrG46y04bM1hsoUn9CVhEQZXixXG8vRQ7Dvo2qEzR7sKokgKHA1pGy9mca7ez/h+uMOeYLzqh6ZLRxhZMnmqLDN4AkB4fc0M7eMjPX0UqgArF9P1gdvzlGvbx4N2R6iUTG3aMdMlt1UAUeKhl3o2t/03p/4Hc+7P9DkR4o5f6luUwM2rLMdWVBjKhTqsYAPxzCEIIIX504wGjQjbV6AyKF8hpMr77nyW6AaIzfVWsiXOa9eUGhUVYBaaEJER9yNWtjp/FE4QAtroQCsvPIUZA09LHJ3+lXoXwxZ6LXGsUAUk9/HnA2CKpR136VX1dKwU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <964490D7667EE94E9117C4919E79FD6C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93058b68-179e-43b5-8115-08d6cc342daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 23:49:40.1912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6142
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 28, 2019 at 09:59:56AM -0700, Linus Torvalds wrote:
> On Sun, Apr 28, 2019 at 4:52 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > Nothing particularly special here. There is a small merge conflict
> > with Adrea's mm_still_valid patches which is resolved as below:
>=20
> I still don't understand *why* you play the crazy VM games to begin with.
>=20
> What's wrong with just returning SIGBUS? Why does that
> rdma_umap_fault() not just look like this one-liner:
>=20
>         return VM_FAULT_SIGBUS;
>=20
> without the crazy parts? Nobody ever explained why you'd want to have
> that silly "let's turn it into a bogus anonymous mapping".

There was a big thread where I went over the use case with Andrea, but
I guess that was private..

It is for high availability - we have situations where the hardware
can fault and needs some kind of destructive recovery. For instance a
firmware reboot, or a VM migration.

In these designs there may be multiple cards in the system and the
userspace application could be using both. Just because one card
crashed we can't send SIGBUS and kill the application, that breaks the
HA design.

So.. the kernel makes the BAR VMA into a 'dummy' and sends an async
notification to the application. The use of the BAR memory by
userspace is all 'write only' so it doesn't really care. When it sees
the async notification it safely cleans up the userspace side of
things.

An more modern VM example of where this gets used is on VM systems
using SRIO-V pass through of a raw RDMA device. When it is time to
migrate the VM then the hypervisor causes the SRIO-V instance to fault
and be removed from the guest kernel, then migrates and attaches a new
RDMA SRIO-V instance. The user space is expected to see the failure,
maintain state, then recover onto the new device.

The only alternative that has come up would be to delay the kernel
side until the application cleans up and deletes the VMA, but people
generally don't like this as it degrades the recovery time and has the
usual problems with blocking the kernel on userspace.

When this was created I'm not sure people explored more creative ideas
like trying to handle/ignore the SIGBUS in userspace - unfortunately
it has been so long now that we are probably stuck doing this as part
of the UAPI.

I've been trying to make it less crufty over the last year based on
remarks from yourself and Andrea, but I'm still stuck with this basic
requirement that the VMA shouldn't fault or touch the BAR after the
hardware is released by the kernel.

Thanks,
Jason
