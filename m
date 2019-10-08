Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C04CFB8E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbfJHNrA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 09:47:00 -0400
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:1032
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfJHNrA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Oct 2019 09:47:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCuCEHO+NtBL4qb7AZs+JPzr5oA1dard/641v3LCxMccFfiaFJn0mLZYdfCmgo96E2aj05gFlBpFqtVzxGj2tftqOUHrtoZ2/vN3HaLZ7o3kb6A0X8kNxFECAO6WVQvn+u03qpZT6hxruYk+LRGUNSMBOP60xXVuk9hEP8EuL47oXWuyZIPBUXIIO7HH7lTNLe8Ox1XAle7796F4USaV86UFtQdtLs1KxYdaYTr+yEBKA+Vq5WSaoY52Am//7GahYeoU8hGcEPltt3DjSoUQZiOXVkdazuMHXKQQk4Q8ZobiYlTa5uZpq6GGlm2HMZZwzI4dbJ57p3Didpq7bdhqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ULosVtRolLe1KFOW/EaTgxc6eG1QVNr1fPiROlgzgA=;
 b=P3Dtvhp//s9IaIT32tIILffmu4iShVHTuQbG5QQJfml82RzwneW/XavGbhkbsT0oWPmcMklGqym2PrrhbfvJwWAYtvv49DliOAMvqY3FfnLNplov4oscfS3AUM5KlHQgKTgbZZJudlvJf+4CaUTPjEVWPUtAUA2selSfAFrrjCREZLfEQup9TrpoTx4z+r58YuWBk4DSgBL9GjbdQJo/pOS71uY0COS5342qFE2YWgII2gsIRCp00MCaQcJC0zhYoxf/uBIhgZzBuNg2IVfbfVbfcm8Yv3ms9iYlQo311xgUxcFG3kzWUaqzoRpQp0DBIlabIKzU5+dv80fIRsnNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ULosVtRolLe1KFOW/EaTgxc6eG1QVNr1fPiROlgzgA=;
 b=GX+dOc7SaX54hZ0OqI8eKboB0KodIGCr15OiFi+pyOrA/93xnLJ9SHGYO8tx3ryKA0diMcErHrD4lUtCEAmBq9duqIVcsNjCB9Bd6rEgtRwcQFN0wrWzfl197CpopB00lXabie00NZa3t1GY/O+rdn2HiniNn06Rh3GKZpQrDh4=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4691.eurprd05.prod.outlook.com (52.133.52.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 8 Oct 2019 13:46:55 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 13:46:55 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next 2/2] RDMA/core: Check that process is still
 alive before sending it to the users
Thread-Topic: [PATCH rdma-next 2/2] RDMA/core: Check that process is still
 alive before sending it to the users
Thread-Index: AQHVeR2KTkqdrwtqSUGNaztNqWaVTKdPjyMggADZNQCAAGJCEA==
Date:   Tue, 8 Oct 2019 13:46:55 +0000
Message-ID: <AM0PR05MB486603286C7264DE05978380D19A0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191002123245.18153-1-leon@kernel.org>
 <20191002123245.18153-3-leon@kernel.org>
 <AM0PR05MB4866CB24D8105C83B31988A3D19B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191008075210.GF5855@unreal>
In-Reply-To: <20191008075210.GF5855@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec82:1c00:b118:4cc8:3ca3:9ca8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62ec8af9-bb7b-4241-1e5b-08d74bf5fb95
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM0PR05MB4691:|AM0PR05MB4691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB4691E9CD1A447669B3F10D92D19A0@AM0PR05MB4691.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(189003)(13464003)(71200400001)(14454004)(54906003)(8936002)(478600001)(66946007)(305945005)(5660300002)(8676002)(81166006)(7736002)(64756008)(81156014)(66476007)(66446008)(76116006)(74316002)(71190400001)(52536014)(25786009)(6116002)(6506007)(76176011)(99286004)(53546011)(33656002)(186003)(14444005)(4326008)(102836004)(256004)(316002)(7696005)(6246003)(86362001)(6916009)(9686003)(229853002)(11346002)(2906002)(6436002)(476003)(446003)(486006)(55016002)(46003)(66556008)(26730200005)(19860200003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4691;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ka7JbENaX0pVesQa3YJNHVizdGhJYNiyzxNLKQ51yrJExV48Oxu0Kn3G9NRVHYxdgf6H0w1h1557jQBv0S2Gs9mEFCgaNsa1wFZLLufBVIq9RmoPzrkcAQ0BMy4k2JAghYz05jQumibHRSg69iFwjZj/L5WpD3qE62yZVZiNzAUfqfAzjVZLDSXtN6Sqo6A0SMne0q4OawLSeMVbp9hiFz63YwicIz5UG7VSyvSo2XroUpYvLPu5RrgVq17SAc7eLwHpZnCtRnrfAganCoU8PgoUF+/dAU9Ao2bvLt7Zupa47gH/wgMoP2L9UXbp2ewi2ua41hzaTyHac31itDGmE7ILZEOwDH7ig66dLFpHwTA5pBipwn/jl41A8WXVbkktfY8OJmvfiSELHiHSrkBTBtbnPKb4jvAWghkBd2Oo1ug=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ec8af9-bb7b-4241-1e5b-08d74bf5fb95
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 13:46:55.3660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4v493FRyINu5DaQSaoQwliLXwJpDPDV5c48bUxaKMNiZSA/zPqnezXQiurv3cTOPafl8bSU9Euv9eD6Lwu4vTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4691
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, October 8, 2019 2:52 AM
> To: Parav Pandit <parav@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> <jgg@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>
> Subject: Re: [PATCH rdma-next 2/2] RDMA/core: Check that process is still
> alive before sending it to the users
>=20
> On Mon, Oct 07, 2019 at 06:58:13PM +0000, Parav Pandit wrote:
> >
> >
> > > -----Original Message-----
> > > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > > owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> > > Sent: Wednesday, October 2, 2019 7:33 AM
> > > To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe
> > > <jgg@mellanox.com>
> > > Cc: Leon Romanovsky <leonro@mellanox.com>; RDMA mailing list <linux-
> > > rdma@vger.kernel.org>
> > > Subject: [PATCH rdma-next 2/2] RDMA/core: Check that process is
> > > still alive before sending it to the users
> > >
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > The PID information can disappear asynchronically because task can
> > > be killed and moved to zombie state. In such case, PID will be zero
> > > in similar way to the kernel tasks. Recognize such situation where
> > > we are asking to return orphaned object and simply skip filling PID
> attribute.
> > >
> > > As part of this change, document the same scenario in counter.c code.
> > >
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > ---
> > >  drivers/infiniband/core/counters.c | 14 ++++++++++++--
> > >  drivers/infiniband/core/nldev.c    | 31 ++++++++++++++++++++++------=
--
> > >  2 files changed, 35 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/counters.c
> > > b/drivers/infiniband/core/counters.c
> > > index 12ba2685abcf..47c551a0bcb0 100644
> > > --- a/drivers/infiniband/core/counters.c
> > > +++ b/drivers/infiniband/core/counters.c
> > > @@ -149,8 +149,18 @@ static bool auto_mode_match(struct ib_qp *qp,
> > > struct rdma_counter *counter,
> > >  	struct auto_mode_param *param =3D &counter->mode.param;
> > >  	bool match =3D true;
> > >
> > > -	/* Ensure that counter belongs to the right PID */
> > > -	if (task_pid_nr(counter->res.task) !=3D task_pid_nr(qp->res.task))
> > > +	/*
> > > +	 * Ensure that counter belongs to the right PID.
> > > +	 * This operation can race with user space which kills
> > > +	 * the process and leaves QP and counters orphans.
> > > +	 *
> > > +	 * It is not a big deal because exitted task will leave both
> > > +	 * QP and counter in the same bucket of zombie process. Just ensure
> > > +	 * that process is still alive before procedding.
> > > +	 *
> > > +	 */
> > > +	if (task_pid_nr(counter->res.task) !=3D task_pid_nr(qp->res.task) |=
|
> > > +	    !task_pid_nr(qp->res.task))
> > >  		return false;
> > >
> > >  	if (auto_mask & RDMA_COUNTER_MASK_QP_TYPE) diff --git
> > > a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > > index 71bc08510064..c6fe0c52f6dc 100644
> > > --- a/drivers/infiniband/core/nldev.c
> > > +++ b/drivers/infiniband/core/nldev.c
> > > @@ -399,20 +399,35 @@ static int fill_res_info(struct sk_buff *msg,
> > > struct ib_device *device)  static int fill_res_name_pid(struct sk_buf=
f
> *msg,
> > >  			     struct rdma_restrack_entry *res)  {
> > > +	int err =3D 0;
> > > +	pid_t pid;
> > > +
> > >  	/*
> > >  	 * For user resources, user is should read /proc/PID/comm to get th=
e
> > >  	 * name of the task file.
> > >  	 */
> > >  	if (rdma_is_kernel_res(res)) {
> > > -		if (nla_put_string(msg,
> > > RDMA_NLDEV_ATTR_RES_KERN_NAME,
> > > -		    res->kern_name))
> > > -			return -EMSGSIZE;
> > > -	} else {
> > > -		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID,
> > > -		    task_pid_vnr(res->task)))
> > > -			return -EMSGSIZE;
> > > +		err =3D nla_put_string(msg,
> > > RDMA_NLDEV_ATTR_RES_KERN_NAME,
> > > +				     res->kern_name);
> > > +		goto out;
> > >  	}
> > > -	return 0;
> > > +
> > > +	pid =3D task_pid_vnr(res->task);
> > > +	/*
> > > +	 * PID =3D=3D 0 returns in two scenarios:
> > > +	 * 1. It is kernel task, but because we checked above, it won't be
> > > possible.
> > Please drop above comment point 1. See more below.
> >
> > > +	 * 2. Task is dead and in zombie state. There is no need to print
> > > +PID
> > > anymore.
> > > +	 */
> > > +	if (pid)
> > > +		/*
> > > +		 * This part is racy, task can be killed and PID will be zero
> right
> > > +		 * here but it is ok, next query won't return PID. We don't
> > > promise
> > > +		 * real-time reflection of SW objects.
> > > +		 */
> > > +		err =3D nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID, pid);
> > > +
> > > +out:
> > > +	return err ? -EMSGSIZE : 0;
> > >  }
> >
> > Below code reads better along with rest of the comments in the patch.
> >
> > if (kern_resource) {
> > 	err =3D nla_put_string(msg, RDMA_NLDEV_ATTR_RES_KERN_NAME,
> > 			     res->kern_name);
> > } else {
> > 	pid_t pid;
> >
> > 	pid =3D task_pid_vnr(res->task);
> > 	if (pid)
> > 		err =3D nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PID, pid); }
>=20
> Why do you think that nested "if" reads better?
>=20
Because pid access is required only for non-kernel resource.
Hence it shouldn't be called for kernel resource; it doesn't matter it retu=
rn zero or not.
