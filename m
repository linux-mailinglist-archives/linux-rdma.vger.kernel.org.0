Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 911CCA1CAE
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2019 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfH2O2A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Aug 2019 10:28:00 -0400
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:47428
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbfH2O2A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Aug 2019 10:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUW2+aSFB0SvC3sfUeYPNaMhjz4emA7rkLAgzXHmKfbfWmGjghkge6Ps0N3DU20GlPUq5QgfN1oOBaD0+l1rneMvo2aPBPKWGknVYa0Jrv1ukET0Yl+L/TPKjLKDX3pfDxWZQwZ0kLgu+hOB4lwJT6Y9VyV29H5Y22d/Fa/f5+0fYWWpJcb2m1qSl1oBnQf4vHDrbNy5ooOnUQ85juWQ3zE+FGbrRbr+Bpk3jMPvfnh2QAYwpB/3LdpbXgQm1CtvRAlU3svf2Cu+a1K7i3z/U6iwarXafipQxGepWqL0A/wI9iyA6XkV4YiqmZkyoXLtOJl/JkHU9/kKniIG7GF8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTFVCfx5njWtXStqmJg3If+nfp0248wgwHmlw3dgU10=;
 b=JPEiKYbSxq9rvJqlxDfayBO+wy8QzeYj1c9v2WPAG1wr6aLFcY1Fl7s59NqTv67uRqvxbL1c1U/2NJUHLTWJx67bnF6v89nvOK0GW51IldtadoDfnNQLwXqmPb/v8Cfa3yOWm9jItzGt/8a2jbH/8Rbq3Li0eRYHptql1hdcru4dMuoSqb+ZKnKX6/wsHGs8+j3PTddrMJnOazlJNzSJY30l9oCBX2eM8Beb9T6cDYH/UcrVI/+RcT8wLtEFcSS392e2xT0yX/qApyTXaWKzYoDjxLZeWfo2xuOprtV1Xv3xjnYfeJJuSRD8kD6CyI2TYQU4MDzZezEw4EU5Bo5MWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTFVCfx5njWtXStqmJg3If+nfp0248wgwHmlw3dgU10=;
 b=MkaYYpigSIT8gbOXufNRgMpP+Qe3FAQmhuIabNFKjbM5OoaDLaapc2Dt67rWG3dyo7CXjjUsV3CPHIOSIywbAyXqZsogBV+w7YZy4DqLszXq0WlQp7C5qcOLRl5/ivnvOL//aB47vHxL0uCcrLc7sCTJLPTS0z/vtWYGgTISKX4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6350.eurprd05.prod.outlook.com (20.179.25.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 14:27:13 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 14:27:13 +0000
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
Thread-Index: AQHVXYFEn/7D2acVzkGMw1QsYEJ+MqcQlNSAgABU1wCAAAjPAIAAxOiAgAB5SAA=
Date:   Thu, 29 Aug 2019 14:27:13 +0000
Message-ID: <20190829142708.GD17101@mellanox.com>
References: <20190828091533.3129-1-yuval.shaia@oracle.com>
 <20190828091533.3129-6-yuval.shaia@oracle.com>
 <20190828135307.GH914@mellanox.com> <20190828185645.GA4799@lap1>
 <20190828192818.GR914@mellanox.com> <20190829071303.GA3339@lap1>
In-Reply-To: <20190829071303.GA3339@lap1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.216.168]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f63e267-0fba-465d-2cdb-08d72c8cfc14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6350;
x-ms-traffictypediagnostic: VI1PR05MB6350:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6350E7D23068F1C607722517CFA20@VI1PR05MB6350.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(316002)(6246003)(2906002)(54906003)(52116002)(4326008)(478600001)(66066001)(8936002)(6506007)(1076003)(36756003)(6512007)(53936002)(66476007)(66946007)(64756008)(66446008)(71200400001)(71190400001)(386003)(76176011)(66556008)(6116002)(3846002)(99286004)(102836004)(81156014)(81166006)(229853002)(25786009)(26005)(33656002)(6436002)(5660300002)(305945005)(7736002)(8676002)(6486002)(186003)(256004)(7416002)(446003)(486006)(2616005)(86362001)(11346002)(476003)(6916009)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6350;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qIV2SkswOhiXOr6fOGrl/N3RTj7JT48tpi11M+V9tivwlyFcq7RC8SFhR8+41vFOAx+vSs4yhOszOa/xuDDXKANgVqDNrXeUrID6qWkijSqohFfhWrZKjlLHJGGF9/f0frBq5ddprz0wmNPe/vZEYf5qHDYh4+F0PkRLoL35/lTJTGOxz7QIBmMKvCXPg1/6VowmSggZt7lYlywLMoVpstJjW0b70BY64OjTYWTi56DhC0qVaOJxoVVE5BTU1ci6S1s8drMDy4NsVMn4gh+Sp4NH9YVx1oFMRia8hTGGJfyaNz8p97jvDopdkTAlCzZhyZrLn3+taBvs/5YmIZSUjVRdodWZK+eDODj4yFGiDVM2h/oX3uktSN9ybgtHoolZecc9w9doGpjVUISjfoEoKsiw/Cvm3EgLa7b5/5M/VEs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9379576F1BB53E48B57104B94D99E62B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f63e267-0fba-465d-2cdb-08d72c8cfc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 14:27:13.4677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVDIFvNqBXEUqjNI87WcO/akihJ3OmuSYCJVENJEvP+k+POVxAbosc02jh/uL+Hm846yW8eqFPKsWMxko2BwLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6350
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 29, 2019 at 10:13:03AM +0300, Yuval Shaia wrote:
> On Wed, Aug 28, 2019 at 07:28:23PM +0000, Jason Gunthorpe wrote:
> > On Wed, Aug 28, 2019 at 09:56:46PM +0300, Yuval Shaia wrote:
> > > On Wed, Aug 28, 2019 at 01:53:12PM +0000, Jason Gunthorpe wrote:
> > > > On Wed, Aug 28, 2019 at 12:15:33PM +0300, Yuval Shaia wrote:
> > > > >  static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_n=
et_admin,
> > > > >  			     struct rdma_restrack_entry *res, uint32_t port)
> > > > >  {
> > > > >  	struct ib_pd *pd =3D container_of(res, struct ib_pd, res);
> > > > >  	struct ib_device *dev =3D pd->device;
> > > > > +	struct nlattr *table_attr =3D NULL;
> > > > > +	struct nlattr *entry_attr =3D NULL;
> > > > > +	struct context_id *ctx_id;
> > > > > +	struct context_id *tmp;
> > > > > +	LIST_HEAD(pd_context_ids);
> > > > > +	int ctx_count =3D 0;
> > > > > =20
> > > > >  	if (has_cap_net_admin) {
> > > > >  		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_LOCAL_DMA_LKEY,
> > > > > @@ -633,10 +709,38 @@ static int fill_res_pd_entry(struct sk_buff=
 *msg, bool has_cap_net_admin,
> > > > >  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
> > > > >  		goto err;
> > > > > =20
> > > > > -	if (!rdma_is_kernel_res(res) &&
> > > > > -	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > > > > -			pd->uobject->context->res.id))
> > > > > -		goto err;
> > > >=20
> > > > How do earlier patches compile?
> > >=20
> > > They did not
> >=20
> > That is not OK
>=20
> Sorry, i probably misunderstood you, what patches are you referring to?

Just make sure every patch in the series compiles.

Jason
