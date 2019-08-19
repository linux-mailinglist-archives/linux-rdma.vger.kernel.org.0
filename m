Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98BA9282E
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 17:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfHSPRf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 11:17:35 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:51268
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfHSPRf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 11:17:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGEBoXMUtAbKQViGbeCXBSGNFzjgETjOebub5wwSDnBb1rh6n9xwtneC4P48Y2fV0dxngqd2Wo+bj7mpDfctz9uXRFpHjQ46U6/2USmmGSvX4hXQOWCGubk5XEJK5xzoNYrnH0HoACtfxYoj5R/46I2WrDiwSbhrNkALz9YNLD9LlPeGllGjUEP7O/M2Pwwol84LF7fuWZjJxLB95tKIcdJzPXUmHl2EzMfqFPYOnOU3qntAo7IYcJMsoYSPP2ulBv11iqgkZrMEZbIfvpZQ1zmJ2gXETcvUAZQWFjC1KbYsi0fzl6sGSj8bGcwrLbiJof5lPFSGQQN/XBNFnc6/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n32YOQIdjC/ItkjSIFoDrbyY10muyYqyf8NzE97JxCY=;
 b=Rbdtt+aPXvJ59qxPZXNE0sttg2+TH+hgOL6ngnGPOwK1bHCSHP+FPvtt+6IrPbV7Lygs9IO0lAW0VgdNrZ92frfVswaDIej7LCa15egacVPQyBm0OTSqxoLGwoHfU2bKkLPiSbFuDMyPsdGMyeffubVfnCZC94oJN0BGa+0g7xRD+fjBO8dtyZQqo3bd0E4zO2RQsyqvKv5TbZ1gbUdp2BhkwseFl02W6BpWnZIUALKcexmckhTdoYH4zVQOm/He16em6DqhLMZ9Y5fGZ7+zxnsZ/3zQa4J612NOEHgPTQwkPplBdcS1SQilObV5odm+eNOr0ZY8ylaXu/0Xkce+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n32YOQIdjC/ItkjSIFoDrbyY10muyYqyf8NzE97JxCY=;
 b=DVEA3V/dd/P18Gdbzrj0EJ0HQdjmgdWR91qFl7BXwP/8Uf5qErczALgo3DJ/HlVwyHnBhbcLWVdE1MPEn2BEctdJDJtYVGim4EY0jlYUAr/OMYH0QPX/3xsTaJzL1f4KhZM6oOCgp6o1NGPAldWC8puL0hVG0NTbDkzbg+likQI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6368.eurprd05.prod.outlook.com (20.179.26.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Mon, 19 Aug 2019 15:17:29 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 15:17:29 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Hal Rosenstock <hal@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        oulijun <oulijun@huawei.com>
Subject: Re: [PATCH] RDMA/srpt: Filter out AGN bits
Thread-Topic: [PATCH] RDMA/srpt: Filter out AGN bits
Thread-Index: AQHVVoiim0GU9wq9dk64C5+GB9JNzqcCk6aAgAABrgA=
Date:   Mon, 19 Aug 2019 15:17:29 +0000
Message-ID: <20190819151722.GG5080@mellanox.com>
References: <20190814151507.140572-1-bvanassche@acm.org>
 <20190819122126.GA6509@ziepe.ca>
 <d2429292-be75-ee67-2cce-081d9d0aa676@acm.org>
In-Reply-To: <d2429292-be75-ee67-2cce-081d9d0aa676@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::49) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3952405-f748-46df-8b58-08d724b859bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6368;
x-ms-traffictypediagnostic: VI1PR05MB6368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6368262E3411545C0738DD17CFA80@VI1PR05MB6368.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(476003)(6506007)(86362001)(316002)(66476007)(229853002)(478600001)(386003)(66946007)(6246003)(5660300002)(52116002)(76176011)(6916009)(8936002)(6512007)(66556008)(81166006)(64756008)(66446008)(14444005)(81156014)(6486002)(256004)(71190400001)(486006)(36756003)(53936002)(71200400001)(7736002)(2906002)(3846002)(6436002)(53546011)(102836004)(186003)(6116002)(2616005)(66066001)(1076003)(54906003)(305945005)(8676002)(11346002)(26005)(25786009)(99286004)(4326008)(14454004)(33656002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6368;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Km9dgcq3sjXUCNMxYUCR0gO6VRiSBtR6YiPIsJst/7Id3jxSQEGNst+ad1XCjmpAHhBe8XrFtTuybt8i/Wht7x+qGdOQ/YeDMSk2c7iCiE0PYz6TqXbbR+k4Kv8gjGtuDmFpQoyw8o0aArbCwaylCxym89XWA5wjVkTlG1wmnkyEC3eTgrD86dbwek+D9haA77hpsA6cuYu6z3BxxBAnkTFcRsYNjqoDjlSnY74Ff3vQmNe1/UhHjGMhDu4rWCKDIaxEwIrfnlwatvOw7RFzuvwuob25EcLiAL0NY4SQV1s22JgPE6gGEsJKfykA1e7YI1My3IC+Ajs3xuQs5jabQCZwLd4wr23Q0kNZLfq5h+RKcRF1gR0nW9Giv5a1+MkdMG+sF42/873AfbBe8NQzTdRCzib34Om2wtiq8f+4KVE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <404D3B1236578B4D9DDB7A90E06FEB28@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3952405-f748-46df-8b58-08d724b859bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 15:17:29.5620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISyX8/pZwJWntlX0B3CEntRxWh8Yh/0Vu8W193xIAg2rpygPquUUt0IYbuCebVBclD42c2jTc6onR90Hs0h2Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6368
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 08:11:21AM -0700, Bart Van Assche wrote:
> On 8/19/19 5:21 AM, Jason Gunthorpe wrote:
> > On Wed, Aug 14, 2019 at 08:15:07AM -0700, Bart Van Assche wrote:
> > > The ib_srpt driver derives its default service GUID from the node GUI=
D
> > > of the first encountered HCA. Since that service GUID is passed to
> > > ib_cm_listen(), the AGN bits must not be set. Since the AGN bits can
> > > be set in the node GUID of RoCE HCAs, filter these bits out. This
> > > patch avoids that loading the ib_srpt driver fails as follows for the
> > > hns driver:
> > >=20
> > >    ib_srpt srpt_add_one(hns_0) failed.
> > >=20
> > > Cc: oulijun <oulijun@huawei.com>
> > > Reported-by: oulijun <oulijun@huawei.com>
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > >   drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniba=
nd/ulp/srpt/ib_srpt.c
> > > index e25c70a56be6..114bf8d6c82b 100644
> > > +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > > @@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *devi=
ce)
> > >   	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
> > >   	if (!srpt_service_guid)
> > > -		srpt_service_guid =3D be64_to_cpu(device->node_guid);
> > > +		srpt_service_guid =3D be64_to_cpu(device->node_guid) &
> > > +			~IB_SERVICE_ID_AGN_MASK;
> >=20
> > This seems kind of sketchy, masking bits in the GUID is going to make
> > it non-unique.. Should we do this only for roce or something?
>=20
> Hi Jason and Hal,
>=20
> The I/O controller GUID can be used in the srp_daemon configuration file =
for
> filtering purposes. The srp_daemon only supports IB networks.
>=20
> In the IBTA spec I found the following about the I/O controller GUID: "An
> EUI-64 GUID used to uniquely identify the controller. This could be the s=
ame
> one as the Node/Port GUID if there is only one controller."

Yes, and the CM uses a magic GUID to indicate service ID selection,
and it looks like that magic GUID was *very* poorly choosen. It also
looks like it is stealth ABI

> Does uniqueness of the I/O controller GUID only matter in InfiniBand
> networks or does it also matter in other RDMA networks?
>=20
> How about using 0 as default value for the srpt_service_guid in RoCE
> networks?

How does SRP connection management even work on RoCE?? The CM MADs
still carry a service_id? How do the sides exchange the service ID to
start the connection? Or is it ultimately overriden in the CM to use
an IP port based service ID?

Jason
