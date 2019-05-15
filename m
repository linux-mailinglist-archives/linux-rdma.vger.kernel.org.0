Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37DD1F027
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 13:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbfEOLlT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 07:41:19 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:4590
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731601AbfEOLlT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 07:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzhiE7UmR7DDHR12f49T5bA/39s0zA8xpvLrZBBFX7Q=;
 b=AYWCO//I0cky4KV8Q3eV5b2EtzIJXcyqFrJ+HkU2MI6aQuBuLrBXGA4gAWjDIZH/9OLz+uTqkG1FwdeEWjAJt0p6Hof67h2WXkaCxa9mMVJcq8tgTI17eFoQPTX9xjE10ybe4XNXh5w6SLzIclDGGV2eC78QMWzsWK/XUwHW5oY=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5550.eurprd05.prod.outlook.com (20.177.201.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Wed, 15 May 2019 11:41:15 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 11:41:15 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH rdma-next] RDMA/srp: Don't cache device name as part
 of sysfs name
Thread-Topic: [RFC PATCH rdma-next] RDMA/srp: Don't cache device name as part
 of sysfs name
Thread-Index: AQHVCwOde59qVchumkuEXD+Oyf6aTaZsAgEAgAAFiAA=
Date:   Wed, 15 May 2019 11:41:15 +0000
Message-ID: <20190515111020.GA30771@mellanox.com>
References: <20190515095013.8141-1-leon@kernel.org>
 <20587db8-fd08-534b-56d6-98d261c41914@acm.org>
In-Reply-To: <20587db8-fd08-534b-56d6-98d261c41914@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: QB1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1563d365-f56d-4d5a-5a98-08d6d92a3ced
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5550;
x-ms-traffictypediagnostic: VI1PR05MB5550:
x-microsoft-antispam-prvs: <VI1PR05MB555009921C36E88EF354FD21CF090@VI1PR05MB5550.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(53936002)(6486002)(7736002)(33656002)(14454004)(66446008)(66556008)(446003)(66066001)(2616005)(508600001)(2906002)(486006)(476003)(6512007)(11346002)(66946007)(64756008)(73956011)(66476007)(25786009)(4326008)(305945005)(53546011)(81156014)(81166006)(6246003)(8936002)(26005)(6116002)(5660300002)(316002)(102836004)(99286004)(386003)(76176011)(6916009)(52116002)(54906003)(36756003)(68736007)(1076003)(8676002)(186003)(229853002)(6436002)(71190400001)(71200400001)(86362001)(3846002)(256004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5550;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /gMeNlHinF6GuW3oikxywQjKVhPEimFuNtCqVEUKsuH2491TJDZA+7WZylP7S3cc8oUl2vtEWgGD9PqfbmnWMK7JeWp9REbcjPkY1eQduGYvMNpSo5QJZY+9iCUOZI3c6+2xcEdWQd7SzSxOnmeY/nmv//OnJ0yyvDEkOaH/SnOCpqgLL+2+O8kqj5BpQ/a3G9l6Vakjhr3U1e769aQXWX7uBmJKzvlfE7/i2N1pCxvOSv5+CYm/corGSWAFhple+fUkxPCn1ZD+C3q04e4CxZallOoWlG7B7fNOPKkx+HsRGTJt8azV6j9+gU7AJwYVxv8B/YeYX5Hw+GKQLiH7JTg7uQbsWzKU/2SKTdN77ONsOEy4a5Vo9VqcMM13wKyaSe0hIbyHPZ3+5ZlXr46CYVYWBgKK4s/t4kEr1617TbM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FBC78C51780B954598B70BBC309F3C7E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1563d365-f56d-4d5a-5a98-08d6d92a3ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 11:41:15.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5550
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 12:50:32PM +0200, Bart Van Assche wrote:
> On 5/15/19 11:50 AM, Leon Romanovsky wrote:
> > @@ -4089,11 +4093,15 @@ static struct srp_host *srp_add_port(struct srp=
_device *device, u8 port)
> >=20
> >  	host->dev.class =3D &srp_class;
> >  	host->dev.parent =3D device->dev->dev.parent;
> > -	dev_set_name(&host->dev, "srp-%s-%d", dev_name(&device->dev->dev),
> > -		     port);
> > +	devnum =3D find_first_zero_bit(dev_map, SRP_MAX_DEVICES);
> > +	if (devnum >=3D SRP_MAX_DEVICES)
> > +		goto free_host;
> > +	set_bit(devnum, dev_map);
> > +	host->devnum =3D devnum;
> > +	dev_set_name(&host->dev, "srp%d", devnum);
> >=20
> >  	if (device_register(&host->dev))
> > -		goto free_host;
> > +		goto free_num;
> >  	if (device_create_file(&host->dev, &dev_attr_add_target))
> >  		goto err_class;
> >  	if (device_create_file(&host->dev, &dev_attr_ibdev))
>=20
> Hi Leon,
>=20
> Thank you for having root-caused this issue. However, this patch
> modifies the ABI between kernel and user space and hence breaks at least
> srp_daemon and blktests. Are you aware it is considered completely
> unacceptable in the Linux community to break user space? You may have
> noticed that the SRP sysfs ABI has been documented in
> Documentation/ABI/stable/sysfs-driver-ib_srp.

We will need dynamic renaming of these things in srp then.

Jason
