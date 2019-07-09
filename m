Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4594363142
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 08:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfGIGzz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 02:55:55 -0400
Received: from mail-eopbgr40056.outbound.protection.outlook.com ([40.107.4.56]:36942
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfGIGzz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jul 2019 02:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIUjEujFDOoxyp3RWH4uMqWFmZ5doLkEVu1GdGL8dcA=;
 b=by2ujJwDp42mqjZwBeiz16rJ5zFw2o058uB7lAPIQhalK/Ymzv0u63+8zgwhCSvLYsy1joRzxrPCqJF946cdcFGg+atRoijMkMLJHyfX802ccOozcAfE8wl9U6s9JhQCMtFyoagF6D7n5IKPH/puztSPw0hZ07s+5VOT4zswP7M=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4276.eurprd05.prod.outlook.com (52.134.92.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Tue, 9 Jul 2019 06:55:49 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::217d:2cd7:c8da:9279]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::217d:2cd7:c8da:9279%5]) with mapi id 15.20.2052.020; Tue, 9 Jul 2019
 06:55:49 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Steve Wise <swise@opengridcomputing.com>
Subject: RE: [PATCH rdma-next 2/2] IB: Support netlink commands in non
 init_net net namespaces
Thread-Topic: [PATCH rdma-next 2/2] IB: Support netlink commands in non
 init_net net namespaces
Thread-Index: AQHVMmj7S+Z6BGQrhUmYcI4HuIX2fqbBMFKAgACxdBA=
Date:   Tue, 9 Jul 2019 06:55:48 +0000
Message-ID: <AM0PR05MB4866E83599497C01169719AED1F10@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20190704130402.8431-1-leon@kernel.org>
 <20190704130402.8431-3-leon@kernel.org> <20190708202023.GA8020@ziepe.ca>
In-Reply-To: <20190708202023.GA8020@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [122.172.186.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca5497c8-2f5f-434c-7177-08d7043a798d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB4276;
x-ms-traffictypediagnostic: AM0PR05MB4276:
x-microsoft-antispam-prvs: <AM0PR05MB4276E779B5F9DABC2758FEA8D1F10@AM0PR05MB4276.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(13464003)(76116006)(7736002)(5660300002)(52536014)(64756008)(8676002)(66066001)(256004)(14454004)(446003)(11346002)(8936002)(73956011)(66476007)(66556008)(186003)(110136005)(99286004)(76176011)(486006)(66446008)(71190400001)(7696005)(26005)(6506007)(53546011)(55236004)(66946007)(25786009)(55016002)(305945005)(4326008)(102836004)(229853002)(6246003)(54906003)(81166006)(33656002)(86362001)(476003)(478600001)(71200400001)(6436002)(2906002)(3846002)(4744005)(81156014)(53936002)(316002)(68736007)(74316002)(9686003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4276;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QvnjOL6WARZY8zqluPe3tdmTPdn1kfbDqI6828k2kYABI9pcsgLg8BtvusNRULPmt6gtjlHljNJ6URT1nCTML4nE4nLU6PMMJHviWitxJ28Hm38sTnyVEuS+PQUciqLC09BxyaGixfcGwIq2v6V5YuoZYIqsP6V/v5TV86zwSrGgiUoBTvvU2ePV4Sq7ux6MGD0vpiCfPazSgQ/VqGnLnHgHIQGuq02nOI9lFMI/7MKYAiIp1x+sBHInnKGy4cmBvkN0Uxh2O2sdLJ4FdYp2Xerl6ZzAL9MylJ2Co7L+pD4Rq5FGUh9nK3RUIo6JoHgmEspl8wjRc9Ci4BfMn/zrE8uNll0zHF35J+EmsyF9rYTlnc1J79ucsZNnk5DHjMFdBG+3jljSZ2gXbjgLDg0xUECa2jp0CjJl6gS2K/fPPnc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5497c8-2f5f-434c-7177-08d7043a798d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 06:55:48.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: parav@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4276
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, July 9, 2019 1:50 AM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Doug Ledford <dledford@redhat.com>; Leon Romanovsky
> <leonro@mellanox.com>; RDMA mailing list <linux-rdma@vger.kernel.org>;
> Parav Pandit <parav@mellanox.com>; Steve Wise
> <swise@opengridcomputing.com>
> Subject: Re: [PATCH rdma-next 2/2] IB: Support netlink commands in non
> init_net net namespaces
>=20
> On Thu, Jul 04, 2019 at 04:04:02PM +0300, Leon Romanovsky wrote:
> > -int rdma_nl_unicast(struct sk_buff *skb, u32 pid)
> > +int rdma_nl_unicast(struct net *net, struct sk_buff *skb, u32 pid)
> >  {
> > +	struct rdma_dev_net *rnet =3D net_generic(net, rdma_dev_net_id);
>=20
> This should be a proper type safe accessor in all places
>=20
Adding it.

> > -void rdma_nl_exit(void)
> > +void rdma_nl_net_exit(struct rdma_dev_net *rnet)
> >  {
> > -	int idx;
> > -
> > -	for (idx =3D 0; idx < RDMA_NL_NUM_CLIENTS; idx++)
> > -		rdma_nl_unregister(idx);
>=20
> There should be a WARN_ON during the module unload that no NL clients are
> still registered
>=20
Adding it.

> Thanks,
> Jason
