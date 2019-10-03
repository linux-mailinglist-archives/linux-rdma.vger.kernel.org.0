Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 901C4C99F2
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 10:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfJCIeB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 04:34:01 -0400
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:4827
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfJCIeB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 04:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxjBYXsySxCYiAinD/46SoUoZB//iR3coxVGVHarv/Pejmyc90E5HYvdoAWIt73x4TJN+tupkmocbgbMjLUEKtGr6xFVLF86YuTPujrwFAmPbPqMfRKh1ce8SVUCX56qaUpA1+QWkDb4S3q8POeRp7vSkJU2Xr0h5tatpL1kpV4DWnBylVZ0mqAzssfFYvXhQIrw4IqIn196ZSSfg019Nq+8CqsnrlRBSD4PUeonr/TOeyZDl/J34NhiT+t0AzRrEvRHg89GC22czVg8n7zDoZCXJh3K3mXko+qI3yI/l6QfZKudiNgCQx0A6Dold9CElE75PtMQ77/6s9Dqj1sALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXDFYXSb4r66Sz5q+W4VwPDQ1+ivN0thiDvP3wo/EM0=;
 b=O1l51MWi9hHqpza7+9FcWjQHfGR1snKngJ7ZDnu0xjnLlPJ7rH55xItCHJwLBPnqygW0wsa91j3Pw0V40FS1NeY4jYcUpixmCy/lHVRWolCBP++nqQ7+YJiYzH/mztikjbB5B+7WuhT0L7bnyGKzo4uHc4opgUuq3QyPRRNXLmcbwgY02x5N/2NUH+NMFdrZmQg1BtQa1ZhyrZm30JWJfjXkTXqzAMpprqQ19Cid2HOBQIO14kDPdmmmeu27M2X18dBT8oPdbQypJSOmFhSRISheuE2uFkFXWzu0VwOSvll2ETg6twct9iv3d8mF3bQmEUQuv3TNOlSHL3LX2HcKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXDFYXSb4r66Sz5q+W4VwPDQ1+ivN0thiDvP3wo/EM0=;
 b=lE+Ek56ade0PGPlqj7EC57DOoFHblRiPBSz7BzM+wtJdxvIaqzT+fUieuww5Vm5xFo0GAm+prH7N1LA07myLeS8xwf19mXgvsJqnowiDOJ6DDSszMdbVGJ1RG7kjeq88GbNbid+TwOSyMuT7rCLzERGuWq/N8iXbRHtkBcsrM8c=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3220.eurprd05.prod.outlook.com (10.171.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 08:33:56 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df%7]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 08:33:56 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH 09/15] RDMA/srpt: Fix handling of SR-IOV and iWARP ports
Thread-Topic: [PATCH 09/15] RDMA/srpt: Fix handling of SR-IOV and iWARP ports
Thread-Index: AQHVeUGULXr3SasrikuaPt/02/0RcqdHmesAgAAFgoCAAPikAA==
Date:   Thu, 3 Oct 2019 08:33:56 +0000
Message-ID: <20191003083354.GM5855@unreal>
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-10-bvanassche@acm.org>
 <20191002141451.GA17152@ziepe.ca>
 <cb5c838a-4a0e-7cac-cc0a-ae218b34d50f@acm.org>
 <20191002165100.GF17152@ziepe.ca> <20191002172416.GJ5855@unreal>
 <8518f1f1-1a1f-0157-b5cf-9b7f0fcfc7b9@acm.org>
In-Reply-To: <8518f1f1-1a1f-0157-b5cf-9b7f0fcfc7b9@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::35) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36dbfbbe-db0d-4cec-3c0d-08d747dc6e3d
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM4PR05MB3220:|AM4PR05MB3220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3220B74C068646FB7A661FD5B09F0@AM4PR05MB3220.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(136003)(396003)(39850400004)(346002)(376002)(51444003)(199004)(189003)(54906003)(316002)(186003)(66556008)(6436002)(33716001)(229853002)(2906002)(81156014)(6116002)(3846002)(8676002)(9686003)(6486002)(81166006)(446003)(6512007)(8936002)(486006)(71190400001)(53546011)(6916009)(386003)(11346002)(7736002)(476003)(33656002)(25786009)(99286004)(66446008)(478600001)(64756008)(66476007)(76176011)(305945005)(71200400001)(6506007)(6246003)(102836004)(86362001)(52116002)(14454004)(26005)(66066001)(66946007)(1076003)(256004)(5660300002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3220;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h3M4Y4gnQ8Kf3kWtA9Yk6TEN4SV/nbs5qFVDKGtTvnsg7JKqC0UrgcCHcSdK04cMes8SOr+pOdpnGhVnASqcc0+yguBY/38Du93GSPZnk1avidYW9vMIR3+G2b2qBC3YBAcupN+cjzPWppWxeXSRzt8pAZv7eV/By3YFd1GnPhR8uyZuMQmU+GzCLigiGJuSK3WzHbf7634krf7C/ZRMaHh3qwB14f0uM8qwkpX8KlwD81jwIpCONbGbOC4qYoNQLHf1bMlUjpzaRUUi/C0InDoyDOI1DGI/1AT/+VOowjRCa/0FlVkqIV/qaBerySoLXFY9gerbaWDV/FIj04hwtKxgdPjSk9CtsQZcAYhopHAPK0wEWtAkj5RvoIyj1iWEn7O+xQkAmgTV7mu/kF/ZmWb6RT6LoeIo86ky2KiGfwE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4E1B18DE1476F479D46BC0EB8B65DE6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dbfbbe-db0d-4cec-3c0d-08d747dc6e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 08:33:56.6277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kSGuh4SbjyoYS68/UEuVD4iRIQzf/+aXxkfw2hydOG9/5OI3sClm2c5HIulhimOW/hotkPA1XXiaJDxCYYhRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3220
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 10:43:59AM -0700, Bart Van Assche wrote:
> On 10/2/19 10:24 AM, Leon Romanovsky wrote:
> > On Wed, Oct 02, 2019 at 01:51:00PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Oct 02, 2019 at 08:21:45AM -0700, Bart Van Assche wrote:
> > > > On 10/2/19 7:14 AM, Jason Gunthorpe wrote:
> > > > > On Mon, Sep 30, 2019 at 04:17:01PM -0700, Bart Van Assche wrote:
> > > > > > Management datagrams (MADs) are not supported by SR-IOV VFs nor=
 by
> > > > > > iWARP
> > > > >
> > > > > Really? This seems surprising to me..
> > > >
> > > > Hi Jason,
> > > >
> > > > Last time I checked the Mellanox drivers allow MADs to be sent over=
 a
> > > > SR-IOV VF but do not allow MADs to be received through such a VF.
> > >
> > > I think that is only true of mlx4, mlx5 allows receive, AFAIK
> > >
> > > I don't know if registering a mad agent fails though. Jack?
> >
> > According to internal mlx5 specification, MAD is fully operational for
> > every Virtual HCA used to connect such virtual devices to IBTA
> > virtualization spec.
> >
> >   "Each PCI function (PF or VF) represents a vHCA. Each vHCA virtual po=
rt
> >    is mapped to an InfiniBand vport. The mapping is arbitrary and deter=
mined
> >    by the device, as the InfiniBand management is agnostic to it (the
> >    InfiniBand specification has no notion of hosts or PCI functions)."
> >
> > Most probably the observed by Bart behaviour is related to the fact tha=
t
> > vport0 has special meaning to allow legacy SMs to connect.
>
> Hi Jason and Leon,
>
> Is it essential that we figure out which HCAs support MADs for VFs or is =
it
> perhaps sufficient that I change the description of this patch such that =
it
> mentions that device management and MAD support is not guaranteed to be
> available?

I have no idea, sorry.

>
> Thanks,
>
> Bart.
>
