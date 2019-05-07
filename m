Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A9A16403
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 14:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfEGMv6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 08:51:58 -0400
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:36892
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbfEGMv5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 May 2019 08:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scv6aBE4cy+G1xDMp+B+zdZdLlfkdNit6H6/dqbWNjc=;
 b=WAGv6bvBeIwkWtr/Pn9zilKvxMTg5fuhulpYYtjfsDR6/NmPByKv0NFYBRpVJQqkoFazxiwe6NBiyPU+/nkGUfmYVypJ2q/2ssTQhjm1IroxJGBoaffisjL8nP8S65xVJrtiXJ4aa/6DuvHyp9mhQ7xiUYC4fMeFJLU+Sp9Erqg=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5565.eurprd05.prod.outlook.com (20.177.202.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 7 May 2019 12:51:51 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 12:51:51 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v6 08/12] RDMA/efa: Implement functions that
 submit and complete admin commands
Thread-Topic: [PATCH for-next v6 08/12] RDMA/efa: Implement functions that
 submit and complete admin commands
Thread-Index: AQHVAO6oZKZjenSic02yv/P2+LA/d6ZZJbWAgAAtrQCAAt2FAIAAS6+AgAGnBgCAAE5JAIABL7+AgAADwAA=
Date:   Tue, 7 May 2019 12:51:51 +0000
Message-ID: <20190507125146.GS6186@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-9-git-send-email-galpress@amazon.com>
 <20190502135505.GA21208@mellanox.com>
 <639fc272-e2bf-9fb3-2599-0e4884c7546c@amazon.com>
 <20190503122042.GC13315@mellanox.com>
 <bbc3ff2b-797e-1b63-0c4c-2f74d782e0fd@amazon.com>
 <20190505123657.GB30659@mellanox.com>
 <04fa3da6-4661-e319-61e3-a7083b81af62@amazon.com>
 <20190506183112.GM6186@mellanox.com>
 <68f9242d-f2c2-a92d-270e-ad1af8f02d9f@amazon.com>
In-Reply-To: <68f9242d-f2c2-a92d-270e-ad1af8f02d9f@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::28) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 353d4ad7-c14b-48f3-520a-08d6d2eac67d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5565;
x-ms-traffictypediagnostic: VI1PR05MB5565:
x-microsoft-antispam-prvs: <VI1PR05MB5565D9C70029A1425736F835CF310@VI1PR05MB5565.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(102836004)(99286004)(6916009)(6116002)(71200400001)(71190400001)(26005)(476003)(14444005)(256004)(2616005)(486006)(186003)(53936002)(2906002)(305945005)(36756003)(33656002)(6246003)(11346002)(6512007)(446003)(7416002)(54906003)(7736002)(68736007)(8936002)(66946007)(8676002)(52116002)(66476007)(66556008)(64756008)(66446008)(73956011)(3846002)(81166006)(81156014)(229853002)(1076003)(6486002)(5660300002)(6436002)(316002)(86362001)(6506007)(53546011)(478600001)(386003)(25786009)(76176011)(4326008)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5565;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UMUfQNuY4itgOvkDzLQ8i/vzJWsgWUt74OpJOAsISdUERVYYGZMRWYGfiqeKMsMTkWSzdrJt6h9Kh6iK8AHdomU//dM2RofgyXpKTiPeyMvpGYbM5yBH0peF8SjbmfIx4lj8Bjuqt9IajsdZ9Za8a9b8E0zfiwdcRPf4fSs+ymDINql0tTj+mWqx+SH0bIjdbDjuzFODfUEyL3sZT+uE3I2OFP4CVIEofDM3FRu511b5oJqYUWVcqIferlsIfZD3iW7gFl6utHL6Z7Rf9Va3orFY790GFSFINwN3WNMeFn6G5IA1T4DM/vgtrSxvkyWuLzETYgJjjyp95KrhdlluwRPG1idx05/Oc2doQPFclh/Dp4/E9BJ0gfGtj/znb8vLT4J+vmafrAcq3X2khqBDpquSpo1G+l7HK2Jk5pgFiBs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B0ECCD45AF9964AB182234CFE4FEB61@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353d4ad7-c14b-48f3-520a-08d6d2eac67d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 12:51:51.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5565
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 03:38:21PM +0300, Gal Pressman wrote:
> On 06-May-19 21:31, Jason Gunthorpe wrote:
> > On Mon, May 06, 2019 at 04:51:00PM +0300, Gal Pressman wrote:
> >>>>>>>> +static void efa_com_admin_flush(struct efa_com_dev *edev)
> >>>>>>>> +{
> >>>>>>>> +	struct efa_com_admin_queue *aq =3D &edev->aq;
> >>>>>>>> +
> >>>>>>>> +	clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
> >>>>>>>
> >>>>>>> This scheme looks use after free racey to me..
> >>>>>>
> >>>>>> The running bit stops new admin commands from being submitted, cle=
arly the exact
> >>>>>> moment in which the bit is cleared is "racy" to submission of admi=
n commands but
> >>>>>> that is taken care of.
> >>>>>>
> >>>>>> The submission of an admin command is atomic as it is guarded by a=
n admin queue
> >>>>>> lock.
> >>>>>> The same lock is acquired by this flow as well when flushing the a=
dmin queue.
> >>>>>> After all admin commands have been aborted and we know for sure th=
at
> >>>>>> no new
> >>>>>
> >>>>> The problem is the 'abort' does nothing to ensure parallel threads =
are
> >>>>> no longer touching this memory,=20
> >>>>
> >>>> Which memory? The user threads touch the user allocated buffers whic=
h are not
> >>>> being freed on admin queue destroy.
> >>>
> >>> The memory the other thread is touching is freed a few lines below in
> >>> a devm_kfree. The apparent purpose of this code is to make the other
> >>> thread stop but does it wrong.
> >>
> >> Are we talking about the completion context/completion context pool?
> >> The user thread does use this memory, but this is done while the avail=
_cmds
> >> semaphore is down which means the wait_for_abort_completion function i=
s still
> >> waiting for this thread to finish.
> >=20
> > We are talking about
> >=20
> >      CPU 0                                          CPU 1
> > efa_com_submit_admin_cmd()
> >   	spin_lock(&aq->sq.lock);
> >=20
> >                                          efa_remove_device()
> >                                              efa_com_admin_destroy()
> >                                                efa_com_admin_flush()
> >                                                [..]
> >                                           kfree(aq)
> >=20
> >=20
>=20
> As long as efa_com_submit_admin_cmd() is running the semaphore is still "=
down"
> which means the wait function will be blocked.

It is a race, order it a little differently:

      CPU 0                                          CPU 1
 efa_com_submit_admin_cmd()
                                          efa_remove_device()
                                              efa_com_admin_destroy()
                                                efa_com_admin_flush()
                                                efa_com_wait_for_abort_comp=
letion()
                                                [..]
   	spin_lock(&aq->sq.lock);
=20
                                           kfree(aq)

Fundamentally you can't use locking *inside* the memory you are trying
to free to exclude other threads from using that memory. That is
always a user after free.

Which is why when I see someone write something like:

	spin_lock(&aq->sq.lock);
	if (!test_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state)) {
		ibdev_err(aq->efa_dev, "Admin queue is closed\n");
		spin_unlock(&aq->sq.lock);

it is almost always a bug

And when you see matching things like:

[..]
	set_bit(EFA_AQ_STATE_POLLING_BIT, &edev->aq.state);
        kfree(edev)

You know it is screwed up in some way.

> > So, either there is no possible concurrency with the 'aq' users and
> > device removal, in which case all the convoluted locking in
> > efa_com_admin_flush() and related is unneeded
> >=20
> > Or there is concurrency and it isn't being torn down properly, so we
> > get the above race.
> >=20
> > My read is that all the 'admin commands' are done off of verbs
> > callbacks and ib_unregister_device is called before we get to
> > efa_remove_device (guaranteeing there are no running verbs callbacks),
> > so there is no possible concurrency and all this efa_com_admin_flush()
> > and related is pointless obfuscation. Delete it.
>=20
> You're right, the "abort" flow was overcautious as there shouldn't be any
> pending threads after ib_unregister_device.
> I will remove this flow.

Send a follow up patch

Jason
