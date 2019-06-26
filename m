Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B91AD56E59
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 18:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfFZQIz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 12:08:55 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:28230
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfFZQIz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Jun 2019 12:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQuKfqHGiLMyEUR2BO77xak5ziwhrEC9XHDesHrqY3s=;
 b=BeVC/YP+Dcjq/mLE1LGLuYdYXP65a5zMrgebvzBsMz7JSGzt6QUEwMzUe1k2hd5AKO2tc2wWZ3Gsm4tlw7LhusZvhKX4H6Ed8bRFp5nZanVJi8ilxRR5///J20mkyBwP+UUb35uAVwo+X/I4XhQ3o6T+os+75g5tc8XqEasBI2o=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4255.eurprd05.prod.outlook.com (52.133.12.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.15; Wed, 26 Jun 2019 16:08:50 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2008.014; Wed, 26 Jun 2019
 16:08:50 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v4 0/3] Clean up and refactor some CQ code
Thread-Topic: [PATCH for-next v4 0/3] Clean up and refactor some CQ code
Thread-Index: AQHVK3vdFO1ecOcGo0ymGtnUdjnt0qauGbMAgAACL4A=
Date:   Wed, 26 Jun 2019 16:08:50 +0000
Message-ID: <20190626160843.GA8420@mellanox.com>
References: <20190614162435.44620.72298.stgit@awfm-01.aw.intel.com>
 <20190625173144.GA27947@mellanox.com>
 <1e0ba685-5ae8-d97d-1555-e4832258cc91@intel.com>
In-Reply-To: <1e0ba685-5ae8-d97d-1555-e4832258cc91@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::47) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.199.206.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 909880ad-0f34-42fd-86a5-08d6fa5093bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4255;
x-ms-traffictypediagnostic: VI1PR05MB4255:
x-microsoft-antispam-prvs: <VI1PR05MB425551ED155C4AA148271072CFE20@VI1PR05MB4255.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(54534003)(446003)(256004)(6512007)(11346002)(486006)(1076003)(4744005)(6436002)(476003)(71200400001)(71190400001)(4326008)(14454004)(229853002)(2616005)(86362001)(102836004)(26005)(33656002)(6506007)(53546011)(7736002)(68736007)(6486002)(386003)(6116002)(305945005)(186003)(316002)(14444005)(3846002)(36756003)(66066001)(478600001)(66446008)(8936002)(54906003)(25786009)(5660300002)(81156014)(81166006)(64756008)(99286004)(8676002)(6916009)(2906002)(6246003)(66556008)(66946007)(53936002)(73956011)(66476007)(52116002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4255;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Z2vPnAKVG021A2F596BGDCXRExxcoHqAPoNk79NCKSlWgw9No/64wzIcYMbo+nj7fafUGcsV1U3mzuGj19L/qEfTaJ0WTOMzT2GRCf2vM30uiFKRy7SCU9UdcA18SAMmAS+ilE3SIYp9Eyofo6k9MjQ0Z1uaJDtqzk9CLULAEg6LArSjrqk/vnjyhYfpO+nKnA1yTYf0+3lDYQ/7neYwy+rECtrEbmOxCv4UBeUZY7WnBvClqB9DkLGveNc7eMdyEgqWSmRITW2grzeGI9EvTZFWbb2LuXpwU7/Qhg0L5B1OK434vAXrjcTJp9E2I29uXWapsnbxMsQtkPJsOaMdfiLUnzlc69lMR49cXdEOOYsiJGfxSnKMXWo6VMI2L8NEMERpkdFawz32byQtStD2afNkFJVBnGwuRIZryKm5kk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FADB5AEDA6353F48A6DD5539F54CC951@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909880ad-0f34-42fd-86a5-08d6fa5093bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 16:08:50.4780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4255
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 26, 2019 at 12:00:54PM -0400, Dennis Dalessandro wrote:
> On 6/25/2019 1:31 PM, Jason Gunthorpe wrote:
> > On Fri, Jun 14, 2019 at 12:25:28PM -0400, Dennis Dalessandro wrote:
> > > This is really a resubmit of some code clean up we floated a while ba=
ck. The
> > > main goal here is to clean up some of the stuff which should be in th=
e uapi
> > > directory vs in in the driver directory. Then to break the single loc=
k for
> > > recv wqe processing.
> > >=20
> > > The accompanying user bits should already be in a PR on GitHub.
> > >=20
> > > Change log documented below each commit message.
> >=20
> > The conflicts with other hfi patches are too big for me, please respin
> > this on wip/for-testing and resend.
> >=20
> > Thanks,
> > Jason
> >=20
>=20
> Jason, can you pull in f56044d ("IB/rdmavt: Add new completion inline") a=
nd
> 4a9ceb7 ("IB/{rdmavt, qib, hfi1}: Convert to new completion API") from
> Doug's wip/dl-for-next branch?

This was already done

Jason
