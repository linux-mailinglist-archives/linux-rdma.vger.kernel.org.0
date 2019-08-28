Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF21A0A75
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfH1T23 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 15:28:29 -0400
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:7652
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbfH1T23 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 15:28:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4MKA6N1oEB6DMMtk6gnQ88XAKu55WOSQn390TZg24Zse/m9hBCrtYgFhzK278Nn23o3t084jrxgOUPjyZOI+cOe85Q/LIhegeuiT7Cfl7eHqtPAuFhd+3WoSor+oexs45GKC61WnsXjv9YLfrp8RY0PpAR6/WjboXpmSIJhhIeDRDX5GrWYMbwvO/V+j4vGp67JQIaB/YOPBM/U/dCXxS3YcqA64Ut0h+pJ3+oZ5PIRcYd/NWToSMMXmD5UTxDl3DTbFX/t7Nea4QNz2KQA14bPnnK8aSDSyf3oEg9zUyJE7XZlx69o1NIoCN9JlswNZO2M61bh2w2G5BfmUPM1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsCtbke7+QXvKzE+Y9KKV1CgOltSbOEGfKdcS/WEv+Y=;
 b=TgBr+wIJQhu3NJHQbhM2C0wxzatZxzBYHmTfBYPIw5RDPzNbpB5/AwJoLKsvr0fGDFhjvt1VS3KZTs0pVZ2kV2+Uch2dgF9qsXx4D2lxPwCVDwdP75tI5bjf/aISMAYeikDU+PVh+Do8rcE2YbD5JCiVx8/eWofyLUIVZmOk7OUlN098DIQ+uvHmKnd/UdKH2YEqLYBF0qF2ko1FOiKF8fo5Y/xGHGmJDrSj2bEZUOEdG73SxO63OMKE02p3xpg5kNsqSFeu1QYCjV3v+0dfqB3JQdISmci4tolvBQDtiA2oya9G2UqjbI6DC6KmsTHTU0jzIF3ULfiI43HDfWvlXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsCtbke7+QXvKzE+Y9KKV1CgOltSbOEGfKdcS/WEv+Y=;
 b=HDWR7q9xpWEuZZzbZdXlgXgrhYBaxAOvmmyyS5eSSbwT8vhHDvKlhsA3Z1A/PfRxu8uOwi/oAQfrFdb54vOAfjntbkxyfIEmLhqZh2JdnnMVfOk5C8tteUvTQWj5s8MjvkeL8HpzoaHCoIvRLmAltzoth7o4DRkdcDete5FeAYw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5966.eurprd05.prod.outlook.com (20.178.126.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 19:28:23 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 19:28:23 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "oulijun@huawei.com" <oulijun@huawei.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Israel Rukshin <israelr@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        Erez Alfasi <ereza@mellanox.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "srabinov7@gmail.com" <srabinov7@gmail.com>,
        "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH v1 5/5] RDMA/nldev: ib_pd can be pointed by multiple
 ib_ucontext
Thread-Topic: [PATCH v1 5/5] RDMA/nldev: ib_pd can be pointed by multiple
 ib_ucontext
Thread-Index: AQHVXYFEn/7D2acVzkGMw1QsYEJ+MqcQlNSAgABU1wCAAAjPAA==
Date:   Wed, 28 Aug 2019 19:28:23 +0000
Message-ID: <20190828192818.GR914@mellanox.com>
References: <20190828091533.3129-1-yuval.shaia@oracle.com>
 <20190828091533.3129-6-yuval.shaia@oracle.com>
 <20190828135307.GH914@mellanox.com> <20190828185645.GA4799@lap1>
In-Reply-To: <20190828185645.GA4799@lap1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.216.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87ad9960-c488-441f-3001-08d72bede44e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5966;
x-ms-traffictypediagnostic: VI1PR05MB5966:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5966DF438B34F9302FE8B906CFA30@VI1PR05MB5966.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(189003)(199004)(1076003)(7736002)(86362001)(3846002)(486006)(476003)(6916009)(14454004)(36756003)(2616005)(53936002)(66476007)(64756008)(66556008)(6116002)(256004)(66066001)(66946007)(66446008)(4326008)(8936002)(8676002)(6246003)(81156014)(81166006)(25786009)(54906003)(71190400001)(33656002)(102836004)(26005)(2906002)(7416002)(99286004)(186003)(5660300002)(305945005)(6512007)(52116002)(478600001)(229853002)(446003)(11346002)(6486002)(6436002)(386003)(76176011)(316002)(71200400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5966;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y8FsL/W4+RaCV1yyuPB8O0rec2al46F/Trj/O1wc2O+YM3yAuMF4Nu8gwIQW3dQPv3zjuGl34fC7rdLMLfkaI0S78BlkARNx6AKzdcV7FYSIaLHwoAYZgzjmWvoG2sG12rxlsEhmYi4yBU703Iv5xj0oA4a1KkiWMSfR44PgK5BD4r2KqwdpihgfkbnDPyTUmXA/dVzt8pxDxEBRVtzI0/FvWh41FrhRjEZTb5XBPlNpdwzFl6Uzd8sOrJi+mgHRSd75NYgeEu+DRgVifJQFMwWzrhJqPcLwBcRbtZQOMEEWdNt2xqQSS+pU2WWiEfsSyZ6x0npRKal2hbEFt6JGyLxmkIvITGxsWr4VrWitzHfyaNxRMgZ31XzvToAszYXuwv/ScKvHkzaXn8roWrd80F3AahE1gk+fr+Au0ESuLqI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87F0F86829F63442863B9ED90EC93B7D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ad9960-c488-441f-3001-08d72bede44e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 19:28:23.5996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d36xY/L6uHu5P5aFRPcGyiHlBzK7+LqV7vX0hbxX4111aNQszB4NxQ75QzcdFCfiNz0un+j/YprH5yU7zCCSZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5966
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 28, 2019 at 09:56:46PM +0300, Yuval Shaia wrote:
> On Wed, Aug 28, 2019 at 01:53:12PM +0000, Jason Gunthorpe wrote:
> > On Wed, Aug 28, 2019 at 12:15:33PM +0300, Yuval Shaia wrote:
> > >  static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_a=
dmin,
> > >  			     struct rdma_restrack_entry *res, uint32_t port)
> > >  {
> > >  	struct ib_pd *pd =3D container_of(res, struct ib_pd, res);
> > >  	struct ib_device *dev =3D pd->device;
> > > +	struct nlattr *table_attr =3D NULL;
> > > +	struct nlattr *entry_attr =3D NULL;
> > > +	struct context_id *ctx_id;
> > > +	struct context_id *tmp;
> > > +	LIST_HEAD(pd_context_ids);
> > > +	int ctx_count =3D 0;
> > > =20
> > >  	if (has_cap_net_admin) {
> > >  		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY,
> > > @@ -633,10 +709,38 @@ static int fill_res_pd_entry(struct sk_buff *ms=
g, bool has_cap_net_admin,
> > >  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
> > >  		goto err;
> > > =20
> > > -	if (!rdma_is_kernel_res(res) &&
> > > -	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > > -			pd->uobject->context->res.id))
> > > -		goto err;
> >=20
> > How do earlier patches compile?
>=20
> They did not

That is not OK

Jason
