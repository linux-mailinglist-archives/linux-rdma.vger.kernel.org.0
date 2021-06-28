Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0E3B6AA6
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jun 2021 23:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhF1WCS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 18:02:18 -0400
Received: from mail-mw2nam12on2098.outbound.protection.outlook.com ([40.107.244.98]:61665
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233976AbhF1WCR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Jun 2021 18:02:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JP9bNpqBCbte+d4WG0/6kd1/1DP6wdC9iWmlIikfyinpVuScE1HJ8RVajcegAw0oH0rb5nBTJmY0F/nfYp3nSGP/xKvuCaBeBeD5AMurWIa2GeOfNV10eijq7ZNOn/gm3Pea4pmVVJNHmQeYLVVtmJ9cgvHElJsUmBW5OdQ/gbiTQYMBEzJ5tNyFEUvFTRWXJrPxorngNgaqVGg+tEJiEdZwBBp8p9x34Y5AcKTjgjuKiie5AdiUOuiOJN0eeZH1re8gbkAL+B2nTUd4S7OyZCvD4jZMxTQrx4vXvX/fWfas475KzdX85iIaunLnJqP/sIaQgp/iOIXEc4inhfHVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qS1+v/dW/z3Y/FyJMt0Bc2Vi++EusNY+AkJvRBIrow=;
 b=nt5Deue3DN+xDFA1rUKlJvELCMBDm0m4Ai9RkYxtIl6S/6+EA0GwXaLOb86TatdNDyJH9HSEUxOjJ4qLeQWq9EBUfssUh32YHhOLGZcnVr7Ph15nvi94WmoYMkWh2kkwyhforwCfp6ueEeo/LaUokwE0DU+aiGsNBl+3A24UoHXndYGrv2vp0gfZbTk8OJIlcnbCVOSmY7tD5DReSDczPLAJdOBwMFNYgeo6GRhn8L/z1TDH3RYRZXqEUujcPtqlRbnKJRAlX4nUY231ePTqRXsnY2hstXrgCNtw+H7pCWEmvS/b2ES2ZnucXSFk5Bzet4UzMdXTc9cuuG/eLYYizQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qS1+v/dW/z3Y/FyJMt0Bc2Vi++EusNY+AkJvRBIrow=;
 b=OBq35/gKCqD9fx9maTax7Z1yVrtVrpibvHDu8lhDWDwfUugYsBfd485PjWJJMWwKpny1kTQLmXnwUuinbxID8NLcyWHUrzYXnak3o2LGqpNyQ8nn6bPiwUpnVxV7PChstd0HzFAiGxqJrNKyvJfkVzqqUhQugd4/fAE8D2pJ/UkzfK+jBNRzWH+aXkMNhG8YVz+WEJfdLpYQV8SMonCZI+0vGOySD/SvmOZXlxr+QfkzYvIuFm0qhlzrEvghxnsUA0ti5Et1+DIXOpQkudGO+2jXwNau3idJ0FQ7ecUNyNuRUpJG1Np+Pkv2Z2o0M0Y6kLb1t6lj0ZVlLyGsMv50NA==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5976.prod.exchangelabs.com (2603:10b6:610:43::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Mon, 28 Jun 2021 21:59:48 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::81f3:3a8:e00f:92ec]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::81f3:3a8:e00f:92ec%9]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 21:59:48 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Pine, Kevin" <kevin.pine@cornelisnetworks.com>
Subject: RE: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Topic: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Index: AQHXRlGKOHE6QFLZoEWMq90D8Um/dareNSqAgAACT4CAAY9wcIAABzCAgAH6poCAAANkgIAABHUAgAElpICAABIkgIAAB7MAgAAD0PCAAAPUgIAHYuMAgABExwCAAG3ZgIAAFk6AgAAKTYCAAa0WgIAHSBYAgAAP4ICAAALMAIA12+PQ
Date:   Mon, 28 Jun 2021 21:59:48 +0000
Message-ID: <CH0PR01MB7153F90EA5FAD6C18D361CC4F2039@CH0PR01MB7153.prod.exchangelabs.com>
References: <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com> <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
 <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
 <20210519202623.GU1002214@nvidia.com>
 <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
 <20210525131358.GU1002214@nvidia.com>
 <4e4df8bd-4e3a-fe35-041d-ed3ed95be1cb@cornelisnetworks.com>
 <20210525142048.GZ1002214@nvidia.com>
In-Reply-To: <20210525142048.GZ1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-originating-ip: [70.15.25.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23939d01-7c57-4160-49be-08d93a800c69
x-ms-traffictypediagnostic: CH2PR01MB5976:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB5976DE5ECC715CCC44F7B3EDF2039@CH2PR01MB5976.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FrTp6FvvRyRYkvlI1+JPhScTTvvdhfclgR59p8E3CgqTZn4q7hDyI5E+eF1D5jO0l4JRVwB8HoVdm1ShO8Ed5o099N7TEoSPgrhjz61YNFD41S9PF1/Mj7ZIOx1PqcM6LzC0u25vYGvUYhOO4OwN2AQ3K99bGZvb1i7tW+CapSvDVw8PF+69uXUsEnKSlbl1AqTmty2Lm1Qwh+Yw2HS2HMNnjnmzRbWh/suXpkWyptI1vOYF3p2GnbsWz9oRctRh89lN+HNeMvIGZBTKlc79c3LbsLHe/10MB9jF9PPVbvJnbanJWjqiz2u1LF1MMR0KFD28z693wkIafWvd4FfMBB1H/W7rJrOmOLwT56kfj8ip6DRZnCub1eOpR2i6HvqYSHzi6coY9NsxN921bvkw7emlQKt8fIKUYWqE4frOLyRv+kI7eBsqlXX5I9JqkG3aB5XEVzFfkRV4G0Q2MH7tbuV2bdyjiRLPetpDfXFF47lzc7a6/hro4iqJ8LbMmQCNaCWwveH8EB/TrXOimeiVdpgXRif1nyGGqrUO8fmpskZ+au1PViTsKhWCvRhzk+2o0ntF/JacfFEtYfzPvxKizoxV4fIw+ZglJErpxdnqTgxNgd0iF/1CWqlg3nfVkH69hn1K46iiWR+7MKe3cP+4GQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(39840400004)(396003)(376002)(7696005)(5660300002)(6636002)(478600001)(2906002)(64756008)(66476007)(66446008)(66556008)(86362001)(8936002)(66946007)(8676002)(6506007)(76116006)(26005)(9686003)(52536014)(316002)(4326008)(54906003)(71200400001)(110136005)(122000001)(38100700002)(55016002)(186003)(107886003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1cARKdzX14eMI52mt8PeDcuoEnMDR2UBZSdZkuGDt+FsVp77l2dhCW/ib1oe?=
 =?us-ascii?Q?eEILCg79syZDXwUBYrX3GMOBdIqA4OKRFu9aUDbLy7XtYcHT7Ojl+GgNFZVA?=
 =?us-ascii?Q?L0W/P8u2yEh5YsPXOmIkCIHFa3wNksIbkqCUVLS9h/UsxH/oayOT/cxuPksQ?=
 =?us-ascii?Q?FV0Y03mWdIpkXRKfUXD0staForYzvoxRn8qVsKjLJ61T0uHIT+hW8xlR1fDu?=
 =?us-ascii?Q?UdSobMkbKectvJ5vCjsu3nfm69+r69CiEacJRYpKYLiNPTum4MLOzb4xiIwa?=
 =?us-ascii?Q?3G1/6bds9t/Zq1+5Q1rhrzAgMxr6azuU+hjNKQ4a1cTVLe5G9zOnbBVC92qW?=
 =?us-ascii?Q?cCHtyVI79lvxAhOkWPR7ftIdtwz31l8kW76mmtzC4Y9aNPmcUOPyeQlWN4ie?=
 =?us-ascii?Q?snXEnSk8py3Ou/S09uD19FWruaiYlK/KU0uhpkvp+jzFFxDFmxrqpkcp0gq6?=
 =?us-ascii?Q?IMHaUmqCwMr1Va/m7Ix2Japr/uA6jfYC62VNLXs0pKGfXJzvWvFNIX47hvN5?=
 =?us-ascii?Q?XiN7WSE+VMZeTECXRLPfPQavozoazaCYDshza5gcWtaZfyu+VvWx+XPfHPGz?=
 =?us-ascii?Q?lRoY2B5y5Rir9mtrQZdGyW5+MPTNWCkkyXbasCgi4gD0WcNhZTjtmZGS6aHm?=
 =?us-ascii?Q?ywDFh+gVaLt5QOa3RtNJAHlJ26j1BuJHiutK/gD6UXYO+V/cIYjvicABGnzV?=
 =?us-ascii?Q?23l0bW0FxE53WnsavThUdyJwkMAS1JPNP0jsZia5bxGKVkYyZM0zAluEjp+T?=
 =?us-ascii?Q?WfFIQKT/yWuQDojM6uFshH4CrkeFuaON9+XEpyJW5gp+rGFbDw/wsH2NkjD7?=
 =?us-ascii?Q?TjiWyhy4iQUQMfgSZTsYhG0RGnUn/4B1pfzlI5EYlDuQ+VfSuR98QmQZKYKr?=
 =?us-ascii?Q?HOb4FXXeTgnw0G4AUhXLa1heHznzlcilfTMQIRSolR9gq5VT1N0x2L5VWnEF?=
 =?us-ascii?Q?vLjArYN7/twTBwLxIORyJretGwwgyplUbgYud4MdL4E5qU3pBNFLuZ0yz6DG?=
 =?us-ascii?Q?EqlyshwcZV3oi0RVuwSV7qsaxMBgClUFEBWGkMgqnCKmDWVMPJQ6YYhCd9Nl?=
 =?us-ascii?Q?LBxSix0u/KCuYJCZcVoegu91zVbCyIDon5PDUHcqr4xuOuKqm36qVbzB8loQ?=
 =?us-ascii?Q?F4V1V7OFXgRA64YDH8wGvy0LPYU+vwmjJTBZucwk5NdgzsmlAmKPkvFLgjKW?=
 =?us-ascii?Q?x15OzxkgFIWnZsSn1zAZ7vw+KhnF8usWVHFp3mTQEZwg2jJhNvQRmWY91wto?=
 =?us-ascii?Q?MEe0ew8XOfZnPBguMhKKmySq8bjTnrTiLWs1HL6N1hqd6Xr1ampyBxUuiSKH?=
 =?us-ascii?Q?reI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23939d01-7c57-4160-49be-08d93a800c69
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 21:59:48.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P45iFKH0kx848llIx421V4gImHWPEJ5YYZiKMQQsjhAgvIMx9+c0m04B/bHiS2PyUfa8PMx+yIdn9PwR/89tcMt4c2nohrWDzzmcr9So/Ye5RnJlaaJG7W1J5PuCW0/R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5976
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>
> Fine, but the main question is if you can use normal memory policy settin=
gs, not
> this.
>
> Jason

Our performance team has gotten some preliminary data on AMD platforms.

I prepared a kernel that will using allocate the QP using the "local" numa =
node (as currently done) and an allocation that intentionally allocates on =
the opposite socket based on a module parameter and our internal tests were=
 executed with progressively larger queue pair counts.

In the second case on 64 core/socket AMD platforms, we are seeing with the =
intentionally opposite allocation, latency dropped ~6-7% and BW dropped ~13=
% on high queue count perftest.

SKX impact is minimal if any, but we need to look at legacy Intel chips tha=
t preceded SKX.   We are still reviewing the data and expanding the test to=
 older chips.

Our theory is the hfi1 interrupt receive processing is fetching cachelines =
between the sockets causing the slowdown.   The receive processing is criti=
cal for hfi1 (and qib before that).    This is a heavily tuned code path.

To answer some of the pending questions posed before, the mempolicy looks t=
o be a process relative control and does not apply to our QP allocation whe=
re the struct rvt_qp is in the kernel.  It certainly does not apply to kern=
el ULPs such as those created by say Lustre, ipoib, SRP, iSer, and NFS RDMA=
.

We do support comp_vector stuff, but that distributes completion processing=
.  Completions are triggered in our receive processing but to a much less e=
xtent based on ULP choices and packet type.    From a strategy standpoint, =
the code assumes distribution of kernel receive interrupt processing is vec=
tored either by irqbalance or by explicit user mode scripting to spread RC =
QP receive processing across CPUs on the local socket.

Mike
External recipient
