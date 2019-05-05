Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C133F13F6D
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2019 14:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfEEMhN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 May 2019 08:37:13 -0400
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:19775
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbfEEMhN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 5 May 2019 08:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha+Ecsv7dqpnzDX9mGD3i5ONYzIAMp7f6qOfkhY0hXk=;
 b=HbAy1w/AokwY/wUGfWVFS7pGISWe0sUzdHpxrhP3d6KtZ95UEeod0oR0iL3alaZjDiAo55BGQKkT5Wxoyjw1ivX0T4JgJNvU6LDNyI41qCUVEC4iCCLlP605qRWUz52jo/vSx24MnvTq9mBuul8SjchoQAtQpQcqP0L9alNn7LU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4848.eurprd05.prod.outlook.com (20.177.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Sun, 5 May 2019 12:37:03 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 12:37:03 +0000
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
Thread-Index: AQHVAO6oZKZjenSic02yv/P2+LA/d6ZZJbWAgAAtrQCAAt2FAIAAS6+A
Date:   Sun, 5 May 2019 12:37:03 +0000
Message-ID: <20190505123657.GB30659@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-9-git-send-email-galpress@amazon.com>
 <20190502135505.GA21208@mellanox.com>
 <639fc272-e2bf-9fb3-2599-0e4884c7546c@amazon.com>
 <20190503122042.GC13315@mellanox.com>
 <bbc3ff2b-797e-1b63-0c4c-2f74d782e0fd@amazon.com>
In-Reply-To: <bbc3ff2b-797e-1b63-0c4c-2f74d782e0fd@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::31) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0575c94-1198-4d1c-83f3-08d6d1566013
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4848;
x-ms-traffictypediagnostic: VI1PR05MB4848:
x-microsoft-antispam-prvs: <VI1PR05MB48486DAE58D99337BFBC6E74CF370@VI1PR05MB4848.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(54906003)(2616005)(5660300002)(26005)(256004)(25786009)(14444005)(53936002)(6246003)(6436002)(6916009)(1076003)(6486002)(81156014)(81166006)(8936002)(71190400001)(68736007)(2906002)(229853002)(71200400001)(3846002)(6116002)(7416002)(6512007)(33656002)(8676002)(86362001)(486006)(66066001)(316002)(14454004)(73956011)(305945005)(7736002)(102836004)(99286004)(446003)(478600001)(186003)(11346002)(52116002)(476003)(76176011)(64756008)(66446008)(66556008)(66476007)(66946007)(36756003)(386003)(6506007)(53546011)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4848;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KVrgvelx8TiUqu7xFY9n5nRARwasNX1+yWx695uydBmfSJc+i3fKbDWn8efha9bdJf4CxYTRR/PKnxaVHR1l72J3RqkIT1vl51wfpXsGaEp5A02SlQ1v9iHyAxeQBd8p+WRxwMzgapXG2Pp020X6GOoiMtOg0YwxIcTu7ce/xvYELp0lx42duM0nFAw7Gptge9kM6M2f/f7j6ydqlE7Zj3ni8aiIx33ZPurCT0SLb1ZoDJ5QEqiztqky5bKq3TVvmWwYcL1+ZIWfquse0ruMjxMXswXIHgPoSf8PNovsbWCBz4clnPk+mElzpSX8gRGV0XmK+33Nt5g5c1+94/CS202jymCu2EVmgg8d/vuzlzIky9x4pOpDNfrMf3OsXQ6lR3QHAcZzRatGJpw0GUAUkH2KZ0HUipTvR6TqTm7FH/8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <729D7E59502C5C47A93905325331885C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0575c94-1198-4d1c-83f3-08d6d1566013
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 12:37:03.1500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4848
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 05, 2019 at 11:06:04AM +0300, Gal Pressman wrote:
> On 03-May-19 15:20, Jason Gunthorpe wrote:
> > On Fri, May 03, 2019 at 12:37:13PM +0300, Gal Pressman wrote:
> >> On 02-May-19 16:55, Jason Gunthorpe wrote:
> >>> On Wed, May 01, 2019 at 01:48:20PM +0300, Gal Pressman wrote:
> >>>
> >>>> +static struct efa_comp_ctx *efa_com_submit_admin_cmd(struct efa_com=
_admin_queue *aq,
> >>>> +						     struct efa_admin_aq_entry *cmd,
> >>>> +						     size_t cmd_size_in_bytes,
> >>>> +						     struct efa_admin_acq_entry *comp,
> >>>> +						     size_t comp_size_in_bytes)
> >>>> +{
> >>>> +	struct efa_comp_ctx *comp_ctx;
> >>>> +
> >>>> +	spin_lock(&aq->sq.lock);
> >>>> +	if (!test_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state)) {
> >>>> +		ibdev_err(aq->efa_dev, "Admin queue is closed\n");
> >>>> +		spin_unlock(&aq->sq.lock);
> >>>> +		return ERR_PTR(-ENODEV);
> >>>> +	}
> >>>> +
> >>>> +	comp_ctx =3D __efa_com_submit_admin_cmd(aq, cmd, cmd_size_in_bytes=
, comp,
> >>>> +					      comp_size_in_bytes);
> >>>> +	spin_unlock(&aq->sq.lock);
> >>>> +	if (IS_ERR(comp_ctx))
> >>>> +		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
> >>>> +
> >>>> +	return comp_ctx;
> >>>> +}
> >>>
> >>> [..]
> >>>
> >>>> +static void efa_com_admin_flush(struct efa_com_dev *edev)
> >>>> +{
> >>>> +	struct efa_com_admin_queue *aq =3D &edev->aq;
> >>>> +
> >>>> +	clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
> >>>
> >>> This scheme looks use after free racey to me..
> >>
> >> The running bit stops new admin commands from being submitted, clearly=
 the exact
> >> moment in which the bit is cleared is "racy" to submission of admin co=
mmands but
> >> that is taken care of.
> >>
> >> The submission of an admin command is atomic as it is guarded by an ad=
min queue
> >> lock.
> >> The same lock is acquired by this flow as well when flushing the admin=
 queue.
> >> After all admin commands have been aborted and we know for sure that
> >> no new
> >=20
> > The problem is the 'abort' does nothing to ensure parallel threads are
> > no longer touching this memory,=20
>=20
> Which memory? The user threads touch the user allocated buffers which are=
 not
> being freed on admin queue destroy.

The memory the other thread is touching is freed a few lines below in
a devm_kfree. The apparent purpose of this code is to make the other
thread stop but does it wrong.

I can't make sense of what this is supposed to be. Either there are
other threads running in parallel and it is just the wrong way to
barrier threads or there are no other threads at this point and this
code doesn't do anything..

Jason
