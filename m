Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916973C87E8
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jul 2021 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhGNPsO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jul 2021 11:48:14 -0400
Received: from mail-bn8nam12on2117.outbound.protection.outlook.com ([40.107.237.117]:25984
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232318AbhGNPsO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Jul 2021 11:48:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMNgFJbDhJm/KN/du4QerPFPEE0Tjd95hyZggEOBotGCwxNtgz9x0U5wAG1fbzj0q/tIAHXM7BlFCiwq1UqzHMvC69DT3QFsaKFDUtT4BGQQp+wjcxJ86SwsBy+2n1G2ugOfXDZ+8bmYo5jzWNMX/CtA/3NxB5UexO/tWhOMDXK/AozOoEPYdeR2ArBx7uvA293BosWbXZGaVNaPYWwGok/ghjzM6Fvz3AlifqXBo6jZYGzw9gzItpZgFcgD/StOEJb1w/LzW5wmgDPyGavCmAFfvyE3w7VABhquuYCcldFyuOX3vYD+C9NPbURxluUamUnCwdMlmQcM+LgxvP3T0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gwYLe9guXKQvacR1L4h/zfQ2uKw41sMYxJWJT1Z1G0=;
 b=WhyuTl/5oiAHvPTU+BfCd4moQAW9zsfMnZgricqTUGeARAlUxDwzQOqnD6EfFdAGhBwrZtMAWirnaMK0f4qRtjdppski3e8Ou/2dTvvK6kIBQ+EmzY15ce76dGGT9aMZhqUHugkepsloNrSQSdfGYlhGn425nEs4eOxNdzlDxGComgJUlUIAYKGkM4Lvx16WmDyPUkcq9zvvP2o50wmJ5K0GbEwe6leqM6yQyj3o1Fdh/wvPn58FVJABBKzuAU59Bu6+g85tyEUVIhbhhpei08E0MDN0D1dGkJn1wt5svmyhKa96S17JvUyZDUHbbu1wTI2xLO1FNXwufqgGhrLGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gwYLe9guXKQvacR1L4h/zfQ2uKw41sMYxJWJT1Z1G0=;
 b=NTKH98CNGs1FqmSP4qJk2OsGMNHDaIq7zlBBL/FFmTz4ZK/SoGYw5gNg+s7oOrT5+QHbzaF6pIPMgZ+E7vmDC/JjTHGTv+ZZNexGoXkLnxsVbrrb1qQM4y7SgehcV0XMVg8UXc3/J+6eDy9jhj0JAhI5E7XgaK852gU/yqgqGuZ2QIMQ9+trIgKeNijuCyqepbqsFxOgesyGjW40+Q6/fJl+azxaFS7h+V9Wxb/Gc1gwyr4eV4QLqzV6vBjJKb5PAzySSR7SosqrdqXbGs7OAlkaCuNAZePwgOTeHj57JR0PoHiMkMyVJXmiuOIxQ2pGAfZmxWXWrL7cGnwIGNTK6w==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB7062.prod.exchangelabs.com (2603:10b6:610:10a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Wed, 14 Jul 2021 15:45:19 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34%5]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 15:45:19 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-rc or next 1/2] IB/hfi1: Indicate DMA wait when txq is
 queued for wakeup
Thread-Topic: [PATCH for-rc or next 1/2] IB/hfi1: Indicate DMA wait when txq
 is queued for wakeup
Thread-Index: AQHXcouvK/fDA4yqlk+iY78jiND9l6s/pWgAgAMDfcA=
Date:   Wed, 14 Jul 2021 15:45:19 +0000
Message-ID: <CH0PR01MB71532E69F268CCF0FE32D074F2139@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210706171942.49902.72880.stgit@awfm-01.cornelisnetworks.com>
 <20210706172345.49902.10221.stgit@awfm-01.cornelisnetworks.com>
 <20210712174214.GA259846@nvidia.com>
In-Reply-To: <20210712174214.GA259846@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c0bfd88-11c4-4802-0b90-08d946de622e
x-ms-traffictypediagnostic: CH0PR01MB7062:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB70625F44607BC1279E23F798F2139@CH0PR01MB7062.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KmtbgisrwghJUVKD25famnznRI17Y9F99CqTRN+m5pjQW6G0sEIKlyDJcUKY8jjDM7aI03+v43YgekjAnBgHhiSf+C2ep7856jvPiq+gOBy2WnS5AkBh5WtmyST/mLLOgAB0gTuIu1SgOzFg9SA6fugZQ9xUguZMIuo/3whdtCroL7+lDkXYSrJEq5pgf1CXDO+YOC5C3mBDpIc5O25tgnoEUaz8ZiopRFYVVg/5d5b9lMo0FbnSLta+lcLTH5xLwjIe0DYVHx0uuYzIZ5yETeceK8MeRYL2xf+NGbfk2JNKwx7UmT8GSW4NLlP1t+pobT8L6AuGx84hQyHdWqIhlZMzHLe75IJgLoihvJTRMysTmSjLuJHoTUFGhmfACtlE7Jt4M5s0gu6ZBVVSXtmBWjeINNdSZuM+63WgBly4z/2QThD0r75M4wzQ7HdQqjQzDmsN2QK83pLHS6ix9yJVGpskKXcpIa32YLrdFyqBKFc/TU6Aw55UtSQhfThi8pLKKAjvYLduPYmP6X/pWla16v61e1YN5ZncQ/HTC/j0SDX2IX6JY/f0yJZ/JbnCwGxChNHCUDZgS/rCK5RR5W0BVcGeZT3yZiUAQY6dLT69kQS1pYyKd9I6h//QeU3E1/MMi6kh9/ZTnoYBU7bczVEGaUxf3vMG0UX0LeiPcFtcY9pp0869C2tfTFxN0c9+i2El2aPz86QZXIek1YPd2SkCWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(366004)(136003)(346002)(376002)(64756008)(66556008)(4326008)(66446008)(52536014)(38100700002)(66476007)(8676002)(6636002)(316002)(71200400001)(2906002)(5660300002)(4744005)(8936002)(54906003)(110136005)(7696005)(478600001)(186003)(66946007)(6506007)(76116006)(33656002)(9686003)(86362001)(55016002)(26005)(122000001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2zidbBU0SmasBAQg1k1a8vb3GyZffad6Ma5ik9qkfhZz/C4paHYMU9PlYpOn?=
 =?us-ascii?Q?1ZOU6lvGPeyJLeNll6rvmGGduWEtSSUcQxMh2oRiMmAYam+pByQ7pOovOsFn?=
 =?us-ascii?Q?j5xJauTUhLtZBE6KRqogl1OZvKpMWOZ0VvlcaUTMsRG7HGOgJV8FPkkL+vFJ?=
 =?us-ascii?Q?t2rXCeRnbCwvRVdXVVco98EqgXwknJgkEvmh4R24MxVsndZ9yjbUiAXSz2r+?=
 =?us-ascii?Q?Zk5/pOgZfRNxL4SCsHjsxZ5085pZw4sRhtqCk3nLl9yYfBjfiYD2lRSvRLFP?=
 =?us-ascii?Q?b4UtzpSg3GLBIeuUYckOIrPOsbr/lGZ1vOc4LvLRsVIeGNHvJ25TSgbcwIcQ?=
 =?us-ascii?Q?vQH0DVwYjzDE02UzjAePn9YmV0yx/8jQoX3LOuY3F/k3mCmp8hNReHT1KmpV?=
 =?us-ascii?Q?eus6NpQqQ3p2ESWnGPjv50RDso+9pLfeUzAxPY3yyATeqpUiUGBtHR/D3DD6?=
 =?us-ascii?Q?IvCqeB3mhvK6mi1GsqtrvmyuNtEB+k5W12myyoNBXQ88fchgeK4eSQ4VM0ty?=
 =?us-ascii?Q?kI3TIRolz9cH0iVWQOw5UPR+1G8nnbtBBNSwoCZp6BBajET80gOEisMVSYKh?=
 =?us-ascii?Q?fAY/YFD2y8J4rP4hdHWtGwY1AyRT2opk2iIrutx7uTZfkVhj2jjrBTkVciIv?=
 =?us-ascii?Q?4u17jnbbWYG3H9RjexiLDGZ64hhIIfIWea83slmW7+S+QKL3Lqx1rba/byC3?=
 =?us-ascii?Q?1oimDH/ayAN4FLt4yBQ/qAr2eCmT8NpxEvatyaSpHQbPsMOhphMGAj4tK9T3?=
 =?us-ascii?Q?V64VlM3HqNvm9EsGRYOVjkKWsXWGri3AKodrIX+d1WVSqapAe9VRyDceLXM6?=
 =?us-ascii?Q?12LCC/Hv412/cv7gCyUOQ+cPCwLIOnb8KKtTmA2UFKm5M07u5L3O+19wQClC?=
 =?us-ascii?Q?Iwe7/gfEW9mV/dmsNM1L3cJq/ZT407Yv9FaAPZ1hE7apFZTBd0P5lEVFr8mU?=
 =?us-ascii?Q?w3erz4hyysVvVqrmyWTCFybIl5uQ6LTycPAMzAsr63UVvmLQ+xVQ9cZUHFlA?=
 =?us-ascii?Q?iRpsaLY2nE7/k2tjAsVGwz2qW1XtaB+j3zn+ZZprU0qP3vK/kps1AB67OQnJ?=
 =?us-ascii?Q?cnxYUDSbi+OmIzZx8lKe3vjQ7b787UL5c+q3blOvz0lk2r56eZ2v8rz0omZ4?=
 =?us-ascii?Q?8PYi9PD/Lk5+o8q8czxbNBWEETiDO1vm0/2Sm5QnhtqqGUNe8c3ppKxsmiR4?=
 =?us-ascii?Q?UXf/vTJGBkA9nCfqJcwJ8lGu5jsiGqZLOLDvRkOE50Gjl31Dn+N4T0B/TEIJ?=
 =?us-ascii?Q?WMs89rK0XwR/ayT0puDpYpK9Jtk0A0QoibSsnnfYDih7jls45yMhwpYIlvdc?=
 =?us-ascii?Q?DSY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0bfd88-11c4-4802-0b90-08d946de622e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 15:45:19.2339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PoMbXQzBtqDLVBlIvwTkkzwUht3tKQO305KMm/AVr5v/4vqcujhxJ8uBgYdbLpaMIds0zOCYJkf+NIgvtwXLGfqW254AH7hu8Q1hnEWLn02d0WJJYTa4s4lAThYTBaDb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7062
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> >
> > Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram
> > ipoib packets")
> > Fixes: c4cf5688ea69 ("IB/hfi1: Indicate DMA wait when txq is queued
> > for wakeup")
>=20
> Neither of these fixes lines are correct, please resend it with correct f=
ixes
> lines.

d99dc602e2a5 is ok and is clearly there and adds the file itself:

commit d99dc602e2a55a99940ba9506a7126dfa54d54ea
Author: Gary Leshner <Gary.S.Leshner@intel.com>
Date:   Mon May 11 12:05:48 2020 -0400

    IB/hfi1: Add functions to transmit datagram ipoib packets

The second one is just the patch itself.   Not sure what happened there, bu=
t Denny is going to resubmit.

Mike
