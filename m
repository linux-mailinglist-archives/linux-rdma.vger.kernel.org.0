Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA3312D6E
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2019 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfECMUx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 May 2019 08:20:53 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:38102
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727032AbfECMUx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 May 2019 08:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KL5qXJcBobDk+85/rnCYS95OrAopt5jM2l8gqybosI=;
 b=S5acJlD0zXTSxLWvS+anTN3Lm0pgT9Vx1iM+h3R4X/YEtjRuFo5/C3C0jNGF0JFpCCZil1ky1EhsnrKzFw0PFGqWlj+XpwfbOR0bt+mSAsoUQvPm0CLRDntbK70qGtxf7pZ2JWdolvwhTjB51HZws0bXKnO4gZuJ6BSriR/haZM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4958.eurprd05.prod.outlook.com (20.177.51.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Fri, 3 May 2019 12:20:47 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Fri, 3 May 2019
 12:20:47 +0000
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
Thread-Index: AQHVAO6oZKZjenSic02yv/P2+LA/d6ZZJbWAgAAtrQA=
Date:   Fri, 3 May 2019 12:20:47 +0000
Message-ID: <20190503122042.GC13315@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-9-git-send-email-galpress@amazon.com>
 <20190502135505.GA21208@mellanox.com>
 <639fc272-e2bf-9fb3-2599-0e4884c7546c@amazon.com>
In-Reply-To: <639fc272-e2bf-9fb3-2599-0e4884c7546c@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR1001CA0022.namprd10.prod.outlook.com
 (2603:10b6:405:28::35) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [65.23.217.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf722769-8464-4191-551e-08d6cfc1c58f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4958;
x-ms-traffictypediagnostic: VI1PR05MB4958:
x-microsoft-antispam-prvs: <VI1PR05MB4958BF05EE6A6D71BF434D94CF350@VI1PR05MB4958.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(366004)(376002)(189003)(199004)(36756003)(386003)(6916009)(6116002)(3846002)(446003)(76176011)(73956011)(66446008)(53936002)(6512007)(4326008)(1076003)(66066001)(86362001)(8936002)(81166006)(81156014)(66946007)(64756008)(99286004)(8676002)(7416002)(66556008)(33656002)(71200400001)(71190400001)(5660300002)(66476007)(14454004)(11346002)(52116002)(305945005)(7736002)(6506007)(476003)(6436002)(486006)(53546011)(186003)(102836004)(26005)(2616005)(478600001)(229853002)(14444005)(256004)(2906002)(316002)(6246003)(6486002)(68736007)(25786009)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4958;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ogfl+IOEWg/8RKwUlG7M49s/NgGjkw55/7Xjz3Wdi2aXK1GWI2BzH6kapMUfug/d9K/8m0F2jM/KRG679c1CL7rs2a2Cv76wuFEZL9VvzCvx0h85crH8WtB0mg7puOqaszB1tB/baca1a4/CArV4mIlaTAelj/UOAZKa+Yw4bWZQC7oACXNiRmme8yd4JpBsJWWJl0iL7+EyeWogb3+I7QtVp+q27Qb4zdDktqnkqNooUo21LhRDgHs2pdwKL5eN+CpuU3hwcBDdneEkuZY5VdLFQJQYwcL9KREUO8ATmlxFBoAz1+bBuNVatAMUSKHVGZ+mf1cZu6ut4u26QYZ1pAh8FgYgxKLCBAPPQ6QVm1gsKzmPlpsLQYlzf+nlci3FxazXuS8ZuGqssqdof5HajpTcDlFo81fvsTw13W4xzJM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF0376C16028C54793A2454CB7BF2E79@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf722769-8464-4191-551e-08d6cfc1c58f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 12:20:47.2278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4958
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 03, 2019 at 12:37:13PM +0300, Gal Pressman wrote:
> On 02-May-19 16:55, Jason Gunthorpe wrote:
> > On Wed, May 01, 2019 at 01:48:20PM +0300, Gal Pressman wrote:
> >=20
> >> +static struct efa_comp_ctx *efa_com_submit_admin_cmd(struct efa_com_a=
dmin_queue *aq,
> >> +						     struct efa_admin_aq_entry *cmd,
> >> +						     size_t cmd_size_in_bytes,
> >> +						     struct efa_admin_acq_entry *comp,
> >> +						     size_t comp_size_in_bytes)
> >> +{
> >> +	struct efa_comp_ctx *comp_ctx;
> >> +
> >> +	spin_lock(&aq->sq.lock);
> >> +	if (!test_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state)) {
> >> +		ibdev_err(aq->efa_dev, "Admin queue is closed\n");
> >> +		spin_unlock(&aq->sq.lock);
> >> +		return ERR_PTR(-ENODEV);
> >> +	}
> >> +
> >> +	comp_ctx =3D __efa_com_submit_admin_cmd(aq, cmd, cmd_size_in_bytes, =
comp,
> >> +					      comp_size_in_bytes);
> >> +	spin_unlock(&aq->sq.lock);
> >> +	if (IS_ERR(comp_ctx))
> >> +		clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
> >> +
> >> +	return comp_ctx;
> >> +}
> >=20
> > [..]
> >=20
> >> +static void efa_com_admin_flush(struct efa_com_dev *edev)
> >> +{
> >> +	struct efa_com_admin_queue *aq =3D &edev->aq;
> >> +
> >> +	clear_bit(EFA_AQ_STATE_RUNNING_BIT, &aq->state);
> >=20
> > This scheme looks use after free racey to me..
>=20
> The running bit stops new admin commands from being submitted, clearly th=
e exact
> moment in which the bit is cleared is "racy" to submission of admin comma=
nds but
> that is taken care of.
>=20
> The submission of an admin command is atomic as it is guarded by an admin=
 queue
> lock.
> The same lock is acquired by this flow as well when flushing the admin qu=
eue.
> After all admin commands have been aborted and we know for sure that
> no new

The problem is the 'abort' does nothing to ensure parallel threads are
no longer touching this memory, it just plays with locks in a racy way
for the above.

Jason
