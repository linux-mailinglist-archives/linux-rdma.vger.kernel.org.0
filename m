Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88E2153A7
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 20:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfEFSbY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 14:31:24 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:32999
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfEFSbX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 14:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSgGAo5oFm9tC/zboOwQyTvaMrE//jIpalCwLw/F0pA=;
 b=jQ+PcWAcbGE3HlxS41N8wQiBY+VMZK9qFLqJDtyAk8qyd3g4hhyNHbM2zkkqjzo7N3MIMyfjOhjYxBwDJJ7A/b1oTb6DkkmTI+RDIm91E5IY8hNbYvh9N2unWxaUqakwAeRsYV/t6WQQmbtvghYHeoHMO3ZWrt2600X9hq53/6o=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6352.eurprd05.prod.outlook.com (20.179.25.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Mon, 6 May 2019 18:31:17 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 18:31:17 +0000
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
Thread-Index: AQHVAO6oZKZjenSic02yv/P2+LA/d6ZZJbWAgAAtrQCAAt2FAIAAS6+AgAGnBgCAAE5JAA==
Date:   Mon, 6 May 2019 18:31:17 +0000
Message-ID: <20190506183112.GM6186@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-9-git-send-email-galpress@amazon.com>
 <20190502135505.GA21208@mellanox.com>
 <639fc272-e2bf-9fb3-2599-0e4884c7546c@amazon.com>
 <20190503122042.GC13315@mellanox.com>
 <bbc3ff2b-797e-1b63-0c4c-2f74d782e0fd@amazon.com>
 <20190505123657.GB30659@mellanox.com>
 <04fa3da6-4661-e319-61e3-a7083b81af62@amazon.com>
In-Reply-To: <04fa3da6-4661-e319-61e3-a7083b81af62@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::42) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a621d6ac-d25d-4221-2595-08d6d25106e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6352;
x-ms-traffictypediagnostic: VI1PR05MB6352:
x-microsoft-antispam-prvs: <VI1PR05MB6352FE059892B77E770D1BA4CF300@VI1PR05MB6352.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(71190400001)(4326008)(71200400001)(186003)(476003)(25786009)(33656002)(99286004)(81166006)(2616005)(486006)(478600001)(6512007)(52116002)(81156014)(76176011)(86362001)(6246003)(11346002)(14444005)(8936002)(6506007)(386003)(68736007)(446003)(5660300002)(26005)(53936002)(1076003)(36756003)(6486002)(6436002)(6916009)(256004)(229853002)(66066001)(2906002)(305945005)(73956011)(7416002)(7736002)(54906003)(6116002)(3846002)(66946007)(64756008)(66446008)(66476007)(66556008)(8676002)(316002)(102836004)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6352;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X/10hpqxkJATFFNU6T/NOSkGxorHc6og+9ixLUsYXwXyZGuTaE0cBkestp90+nDgc2JB66NYctyutDjhWsm3JgosiXHqPRqblok2plxoYjgyV2nPf87hyblQGbQKSpc5jrf0qAu23F9tGjsuSMTw0iWfMIwykN+nkzufnY/quxU2cnKTcXmKiuGhd+fT2cZ2H9gc3F1PKlK2yvzMsJQGm9PwsLigNoX7k2fJyin6td9nhqmIClGZENaJb0yXRvLgxmcJurbtdyv7Xp5cFT42Jde1SB9NaljN+LOPT83iDSkAnYETQskDHZi5j6P0VaEqBKs7HYQBIEiwp3RH+OycpW9XFK4CwpGR45eTKVyb0qCQUPFDxiZcZoboCAA+GbEfn9z2Jy4i/nF99Rn+PdBjtxV3ALnhgl7IF1rMcRwvKsg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4448475613F544BA089BBDD164839AE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a621d6ac-d25d-4221-2595-08d6d25106e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 18:31:17.3636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6352
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 06, 2019 at 04:51:00PM +0300, Gal Pressman wrote:
> >>>>>> +static void efa_com_admin_flush(struct efa_com_dev *edev)
> >>>>>> +{
> >>>>>> +	struct efa_com_admin_queue *aq =3D &edev->aq;
> >>>>>> +
> >>>>>> +	clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
> >>>>>
> >>>>> This scheme looks use after free racey to me..
> >>>>
> >>>> The running bit stops new admin commands from being submitted, clear=
ly the exact
> >>>> moment in which the bit is cleared is "racy" to submission of admin =
commands but
> >>>> that is taken care of.
> >>>>
> >>>> The submission of an admin command is atomic as it is guarded by an =
admin queue
> >>>> lock.
> >>>> The same lock is acquired by this flow as well when flushing the adm=
in queue.
> >>>> After all admin commands have been aborted and we know for sure that
> >>>> no new
> >>>
> >>> The problem is the 'abort' does nothing to ensure parallel threads ar=
e
> >>> no longer touching this memory,=20
> >>
> >> Which memory? The user threads touch the user allocated buffers which =
are not
> >> being freed on admin queue destroy.
> >=20
> > The memory the other thread is touching is freed a few lines below in
> > a devm_kfree. The apparent purpose of this code is to make the other
> > thread stop but does it wrong.
>=20
> Are we talking about the completion context/completion context pool?
> The user thread does use this memory, but this is done while the avail_cm=
ds
> semaphore is down which means the wait_for_abort_completion function is s=
till
> waiting for this thread to finish.

We are talking about

     CPU 0                                          CPU 1
efa_com_submit_admin_cmd()
  	spin_lock(&aq->sq.lock);

                                         efa_remove_device()
                                             efa_com_admin_destroy()
                                               efa_com_admin_flush()
                                               [..]
                                          kfree(aq)


=20
So, either there is no possible concurrency with the 'aq' users and
device removal, in which case all the convoluted locking in
efa_com_admin_flush() and related is unneeded

Or there is concurrency and it isn't being torn down properly, so we
get the above race.

My read is that all the 'admin commands' are done off of verbs
callbacks and ib_unregister_device is called before we get to
efa_remove_device (guaranteeing there are no running verbs callbacks),
so there is no possible concurrency and all this efa_com_admin_flush()
and related is pointless obfuscation. Delete it.

Jason
