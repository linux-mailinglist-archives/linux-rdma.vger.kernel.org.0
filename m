Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E7EC8FD4
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 19:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJBRYZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 13:24:25 -0400
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:53172
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728865AbfJBRYX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 13:24:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDGxs7wBvxRmxgi+YvU+hOzR/z+XJOQeQGlyMYVub98e9oKvdpWrLsmLCv1o4OsNpXuQEkPl+osWh2NmDEPkqlVt3UEVVhTHobIBmrJUstad9vkj+Oi07cHGOK9SA1+954F/KAOJCgAzHrfebBf6rGmE5+s9Y4nCx0s1wOlvT2hJshZSYj1bUZQ4kPS5f3MIbzDy4+VsZTCPjcWCnfSfWTbDaENzpKS51q2C6KPNOHH8l7eVIWx35o/Frpr8b+yeak7VSpWFhdKXmoxfVWNF57SP2Nmk9IfTPnFsIqJO316qzLe4rIcamCGSWk0m8GSBj5EvhJTU8bq2xP9SiVsfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOCLq+nGNIIAwU4oLxnN4unMGsCzAcBUSwuN/v6/EKU=;
 b=OwaJ/kVzRRgJG5zrxfnanFv3KSsXIqIr5CNhYOVKermq7U14eyqqd3tOzg2U20HggQXy5Sd6zXps/iJsszIUAXtyeDLL/roFHCwdcCbJ33avf69Q50NVY7Po86L0yklohnOD4RLxVQ19FqhdaAhrf8/51mPE8tm7ymzaf53l5I/bPTk3pKIgwNV32EmmRNfxR0CeesFu7FLtZZXyvZCUufEVEfVgdPE1Rsm+y1dgvbU/I3rJPyeuEBoW6XNaCCTlosLcy6ywfYQaVLw9vlD2TIRHF+CWTp9yN0YfPURwh7p71TcsFRdqwGYR9af2SPmaSnZdGlKhCPs17/yWPDrWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOCLq+nGNIIAwU4oLxnN4unMGsCzAcBUSwuN/v6/EKU=;
 b=O9x0KFgP+8iijYxR9xBJzs7JpWcKa8AXQJF/BRXqA84f6HB5hggBTxhwN1EawRWTgluWYQgOA/jv2CRbrP5loqMIu7/6Tb6f/vACcA7u6IVITGEzGJUKjFpaXqEmK8J5CI3ng8gOaynzt/mp78tcxtl7aLJb4NY1wnC0AsWUIGQ=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3476.eurprd05.prod.outlook.com (10.171.187.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 17:24:20 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::dde1:60df:efba:b3df%7]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 17:24:20 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH 09/15] RDMA/srpt: Fix handling of SR-IOV and iWARP ports
Thread-Topic: [PATCH 09/15] RDMA/srpt: Fix handling of SR-IOV and iWARP ports
Thread-Index: AQHVeUGULXr3SasrikuaPt/02/0RcqdHmesA
Date:   Wed, 2 Oct 2019 17:24:20 +0000
Message-ID: <20191002172416.GJ5855@unreal>
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-10-bvanassche@acm.org>
 <20191002141451.GA17152@ziepe.ca>
 <cb5c838a-4a0e-7cac-cc0a-ae218b34d50f@acm.org>
 <20191002165100.GF17152@ziepe.ca>
In-Reply-To: <20191002165100.GF17152@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::21) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.137.89.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d67a9935-cfc3-4957-d21e-08d7475d5c80
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM4PR05MB3476:|AM4PR05MB3476:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3476699BB14430A267444607B09C0@AM4PR05MB3476.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(51444003)(199004)(189003)(5660300002)(305945005)(26005)(478600001)(7736002)(6916009)(25786009)(71190400001)(71200400001)(33656002)(99286004)(66946007)(66066001)(66476007)(66556008)(64756008)(66446008)(33716001)(256004)(1076003)(386003)(53546011)(6506007)(4326008)(102836004)(476003)(8936002)(3846002)(2906002)(54906003)(14454004)(316002)(6486002)(76176011)(486006)(11346002)(446003)(6246003)(186003)(6116002)(229853002)(52116002)(8676002)(6436002)(9686003)(6512007)(81156014)(81166006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3476;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E9dydyUBbL0eKhT6Tt6S5zzjfmdQ4k4QxcGA4oUzJJywZAMj1dbRWUtBDZAp5JWPRMZkXJL4Sh+M1UlearwHzYIrbP2VC8dOOFGrWa3/SZF2s13PyACcn2QcRAFRraoJ6IacJOtGboe00PpgdKcgPDqr8qwET+NQflkAyIQkMFEB7yWoM7oNGh8djMCsAB80skHZ3d72HJx5HS66NQ8adjcgWCFNsOp9IEblqbsdgTEiAoo7ajFd2oQpsa7+432pn2LgnkfiW0kfRFiFksjNnsU3k9gfrpgcB3OcGhVNFokn3jK/d91XRuMhQNyoApjV+jG1qQrf7bTMzkpDcptmYKv1dh6gCbi7eWmnlHX2IS1GQV2yT9KNr034nF+cZWvCHFYoY1Iklfxmxk5NhaK6fFb6nRNr5sy433RiHCaxsZA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0432D25884AD334AAFB8895AD21B0662@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67a9935-cfc3-4957-d21e-08d7475d5c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 17:24:20.7290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxKz/8ikjmBbAcBS/sO/btYGYziFDV9FuaOJdvjGn9Yje8fpiAPDGnnSfSzwt+TnJu8h7kvKZBv2coLu6Ah1Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3476
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 01:51:00PM -0300, Jason Gunthorpe wrote:
> On Wed, Oct 02, 2019 at 08:21:45AM -0700, Bart Van Assche wrote:
> > On 10/2/19 7:14 AM, Jason Gunthorpe wrote:
> > > On Mon, Sep 30, 2019 at 04:17:01PM -0700, Bart Van Assche wrote:
> > >> Management datagrams (MADs) are not supported by SR-IOV VFs nor by
> > >> iWARP
> > >
> > > Really? This seems surprising to me..
> >
> > Hi Jason,
> >
> > Last time I checked the Mellanox drivers allow MADs to be sent over a
> > SR-IOV VF but do not allow MADs to be received through such a VF.
>
> I think that is only true of mlx4, mlx5 allows receive, AFAIK
>
> I don't know if registering a mad agent fails though. Jack?

According to internal mlx5 specification, MAD is fully operational for
every Virtual HCA used to connect such virtual devices to IBTA
virtualization spec.

 "Each PCI function (PF or VF) represents a vHCA. Each vHCA virtual port
  is mapped to an InfiniBand vport. The mapping is arbitrary and determined
  by the device, as the InfiniBand management is agnostic to it (the
  InfiniBand specification has no notion of hosts or PCI functions)."

Most probably the observed by Bart behaviour is related to the fact that
vport0 has special meaning to allow legacy SMs to connect.

Thanks

>
> > I haven't been able to find any reference to management datagrams in th=
e
> > iWARP RFC. Maybe that means that I overlooked something?
>
> Iwarp makes sense
>
> Jason
