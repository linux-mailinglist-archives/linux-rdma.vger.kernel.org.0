Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8480483577
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbfHFPjr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 11:39:47 -0400
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]:55361
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728156AbfHFPjq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 11:39:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlH+OcQXXbw9Dd4ZqHpzDW38/z27Ey/875moJf6+5tuAjsunabgLNfqm3/XbIxrNsNlfKqPAJ1WkaFNqYGjr3HwOD78lfwyL+/OYgZzGe1eqp38Hvm4vVCczOv47HXs4HTB7T0uvp/HHvwjWzqqrCXrLXswRSrZAhbsfYW/k9nUq5nynVv6eyRQUiWWIhjC0KB5pXcesK69igz42ELmTVoqhJtYYsrPlwOZT+elifz6kejVo1ts9e2RG40V+e/C9pK0Mz/StZ6fe03CIMWCcMa+FylaRy+2Ky9oFYfnkS0ufMjkj5LxafZasysqpXz3uFU86tVpPlEoXEQIGNsAP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYVBT8Nw1UOE6/MpTh5HGjsss4PwZJ9jlA+jwvrrC+I=;
 b=HwyW1+N4c1yP9YTI4ErnF7ZGcy+ukB4Do/hGiOlCMJj9zKMouj1T4L3N8UBP5XKtD18M3E/+reBlPcltvZfPiCHHf15VlDbKsbLXM9OTvoggFUxe0HPVbBlZXbVRkoILhKpX855D+BCbvcYqbXqKCoGy+bYuzpbx+CBji6m1IgaN60wKXghON2El+rW0o1Qf5CXc5zZ8LofmJIaCSXNZFxYeGOnNHT+3aOzuBsBK52Y3ukW7APRikIDA/8kiBGiymqxivBbHYUlYhKiD76PNJviVbP91e6o8vTGzPDSA1CJV2SmBW4/bS8lL5I1KNDYfS2HmYREiUSt41Q4hnz6geQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYVBT8Nw1UOE6/MpTh5HGjsss4PwZJ9jlA+jwvrrC+I=;
 b=JmNMiXGQnr7iuUuDjXZkuwCWj7Q6aBFG+lDoJaVqm8xwZTcJY/V17ojDcF0eNkhSoJc9GaVRLdAcNj0+ksKfU5vGGZjxSWpwOA33gA4IWZIh1zzDo9q9yNUfumfOsqDkSeRKqrtN+GMxWq8+GH7njpqCk7FCHAtKj9ijPdqsJ7A=
Received: from VI1PR05MB3152.eurprd05.prod.outlook.com (10.170.237.145) by
 VI1PR05MB5168.eurprd05.prod.outlook.com (20.178.10.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.20; Tue, 6 Aug 2019 15:39:43 +0000
Received: from VI1PR05MB3152.eurprd05.prod.outlook.com
 ([fe80::c407:16fe:412b:9809]) by VI1PR05MB3152.eurprd05.prod.outlook.com
 ([fe80::c407:16fe:412b:9809%5]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 15:39:43 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next 0/2] Enable QUERY_LAG over DEVX
Thread-Topic: [PATCH rdma-next 0/2] Enable QUERY_LAG over DEVX
Thread-Index: AQHVR5S9Ls7mwhFI+0WkYc2JIL3DkabqrhwAgAOOUwCAAA65AA==
Date:   Tue, 6 Aug 2019 15:39:43 +0000
Message-ID: <20190806153940.GY4832@mtr-leonro.mtl.com>
References: <20190731114014.4786-1-leon@kernel.org>
 <20190804082848.GF4832@mtr-leonro.mtl.com>
 <20190806144653.GM11641@mellanox.com>
In-Reply-To: <20190806144653.GM11641@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0222.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::18) To VI1PR05MB3152.eurprd05.prod.outlook.com
 (2603:10a6:802:1b::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.137.115.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58a8bad7-2cdf-4035-4f3d-08d71a844d43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5168;
x-ms-traffictypediagnostic: VI1PR05MB5168:
x-microsoft-antispam-prvs: <VI1PR05MB51680EFDB341C9FF2836E02BB0D50@VI1PR05MB5168.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(102836004)(6506007)(26005)(6862004)(3846002)(5660300002)(8676002)(76176011)(386003)(81156014)(107886003)(33656002)(81166006)(53936002)(7736002)(6486002)(229853002)(6246003)(6436002)(6512007)(9686003)(446003)(54906003)(305945005)(486006)(476003)(316002)(8936002)(52116002)(11346002)(186003)(99286004)(6636002)(68736007)(6116002)(256004)(71190400001)(71200400001)(66556008)(64756008)(4326008)(66446008)(66476007)(14454004)(4744005)(66946007)(86362001)(2906002)(66066001)(1076003)(25786009)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5168;H:VI1PR05MB3152.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6JEPD3pe3Dv60+ejifi8Qz5YQ/Y4AbFLRkGt0HncUHBql6XPML15+3gRUb7M85ghdO8iuxPXvvU6aWSCHV2OttqMsm6BZg6a2TtkRCpDyW9yo39mQI9LaVtWgm4ZhQiDf8NPe5fQlkf2ZNneRz5NDTqsWzvUrjAtSrzBaW7BWDOz+6BhZ2IYUkjZJdF0GpFlj9PmDV1j9iMnUTAbvCKEqtcMHbtqot1HcoihvXRUTMi2/rj9Fw16zyC0wFYcYC5MgGoW2AqsDuCS/JbEtEDo2+8J4jF5l2ERpxP6Dd7XzaP2YFLz95hq/+M8so0mwVjHfbDCZWMcCRgeXxUota+AWhH45GJ6YIrJ/OvjO1m/4jgcPToo4toMRvRlDWHtocH3l/Kr6QNUuJRyQmt59FNJngjoxWzz8d/jLAlt9yYvFWM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30D66381930FA94A8DF5130A5504CB93@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a8bad7-2cdf-4035-4f3d-08d71a844d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 15:39:43.1486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonro@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5168
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 02:46:58PM +0000, Jason Gunthorpe wrote:
> On Sun, Aug 04, 2019 at 05:28:50AM -0300, Leon Romanovsky wrote:
> > On Wed, Jul 31, 2019 at 02:40:12PM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > Hi,
> > >
> > > Enable QUERY_LAG command over DEVX. That command was added to the mlx=
5_core,
> > > but were not used and hence has wrong HW spec layout which is fixed i=
n
> > > first patch. The second patch actually makes this command available f=
or
> > > DEVX users.
> > >
> > > Thanks
> > >
> > > Mark Zhang (2):
> > >   net/mlx5: Fix mlx5_ifc_query_lag_out_bits
> > >   IB/mlx5: Support MLX5_CMD_OP_QUERY_LAG as a DEVX general command
> >
> > Both patches are applied to mlx5-next.
>
> Why the second one?

It was one-liner patch and I preferred to save work from you.

Thanks

>
> Jason
