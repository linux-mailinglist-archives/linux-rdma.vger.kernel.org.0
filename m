Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE37380C76
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhENPBu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 11:01:50 -0400
Received: from mail-bn1nam07on2138.outbound.protection.outlook.com ([40.107.212.138]:34798
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230143AbhENPBu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 May 2021 11:01:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1ejvF/6v6q1wiDRJ50KxqbkVLL7vTAqDLPtuPydZtDdH0i/CCZXnLVOmD9TTJRQopHRa8zGa44y19/COKEt/gHPI06HUxDLWmZ6MavIivRl9EMeYKeU3J4nEUOMvHBuR9YS8gFrX/qoVwDBgIRLE0o3e83EXEkzfV7gDXYXG+GtEXhuAt2OBhnb5fb03Mgx5XdBVVYOZ0AEk1iWo2NEj/xdJMn+39YOiTvTJak0UK9iSCF0CpRCD70QTQgkYus5gfeUvnGE5oouN64zAetszrUGvHWm3Pi/xb+/yf5sOL5E0XRsZrdASFACxDrvERa0/lAEuJ7ZKkiZtHIW6GgRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meFHjM5X2sqZesl9i9dZn5tTyUE4B90eleKCf3dDY0E=;
 b=EN7Gfzk0rKFAtAT5XaUo3DSuLOb1pvKbkrqUbLEqqrYvUIHPjZkjJtA3fSTIsRs6WzhqUEpfs7hXVLAH23QevXKK5Gp+1cLw+sFGJRlFRpDxzbtM9Qb+Mnf0OhVn33sHKOKPH4+LC846K9pqugEZffglDJ7XIYJfMHtPzbLfquIA2Q24pPIPXfwp0jW2NA5OtXTnmBmA7iVLfK8x/y404KPy4nUjX5Q4hwKO1ysbXkC/U5HVne8j1iOk2PZm7LgxjaUFoqJkwNlOsB4ruf17fyiwKwjzqkMYlqkggYIj88tzdFRtlJyO2ggvC0Z2k8lKUxKY88hfqF/G2HQt5gsIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meFHjM5X2sqZesl9i9dZn5tTyUE4B90eleKCf3dDY0E=;
 b=PgEqR8JE4/2cnEG3nWbRacyAO4VkKG9QmH3lRA1W4v4vv1CBthY+tQfxVNbMb/kVOLGKDxX2B65HDc1lpVCSiO0r9pjHw7cBq3VPmiqnqwSuf3TWOxpiiC2W/Htg58mgV9Ic32vpkROgv0FD5I1SN/GxIWs6yI9iPZUsb2uwzU0MivPNgHsTaYoA8IbL5APYu4E3Dcv3ZQfNUVxhTiLUvwh8HJ0+ypx5vRRVxgFRZDBzjG8IOMa50FSt15Y+t6VolCwig9kuU0jTYohokg7IsDkrP8kqPvZy2S52hhk09Hc14V7efO+C0KWWoIzw/nJeLRNs2RT7D1els/Ntp2elgw==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB7049.prod.exchangelabs.com (2603:10b6:610:10a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.24; Fri, 14 May 2021 15:00:37 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::7025:4451:d615:17f8]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::7025:4451:d615:17f8%5]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 15:00:37 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Topic: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Index: AQHXRlGKOHE6QFLZoEWMq90D8Um/dareNSqAgAACT4CAAY9wcIAABzCAgAH6poCAAANkgIAABHUAgAElpICAABIkgIAAB7MAgAAD0PA=
Date:   Fri, 14 May 2021 15:00:37 +0000
Message-ID: <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
 <YJp589JwbqGvljew@unreal>
 <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
 <YJvPDbV0VpFShidZ@unreal>
 <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
 <20210513191551.GT1002214@nvidia.com>
 <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
 <20210514130247.GA1002214@nvidia.com>
 <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
 <20210514143516.GG1002214@nvidia.com>
In-Reply-To: <20210514143516.GG1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-originating-ip: [70.15.25.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d6ad6fc-b464-49c1-ee4a-08d916e90865
x-ms-traffictypediagnostic: CH0PR01MB7049:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB70498B3D0153D04D2F634089F2509@CH0PR01MB7049.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xfGfOjv0ZU0GToOJZhdAg87RMQYSjv1SFzzZTDCg7mdk/mG1Wl7MKVy5aXnJABe1D8LN0xoUSArPnm3SoqX8QrU8eizIZLum5D6tvyxc5B164L4xxQ6JhOba57Chl6AB1LRC0o/QrD4jlHm3IIoeUqGK32TeMqsAoLtDC3OU7zVLe1TcJj/IraEmz+XLubvv+aN++UAnHKQVJOpgISYHMjwPsndVL1CyHuXXdMSQV98ZVF19bFAF8hwSvP0WyX7ZJ2IDnokT+bgGNL3NA6ZspqT1IHoy1ccj0qt61JwBApxuYwbFmPkXg5x1bccndqlC3ZGrr4yJ6kRsWxBQCeDta0fAFKSya/6i4pSz0M2svk8rnSQQLOi4BGksBIluKKhZxTT0jKeAB8KNw790askBos0bbzSmBmR8uHxKWPv3EL9B9zfb+MCxMchMAS3ulRi9PAomR+UyOi0o0s2BrjaVghJJWeYqB8pVI8RT1EJNR5PjDm6JgQ3nJcXuAEtFQPnlR1o2pqFy6xmKfJOPoCO+wtJrIs3YB+wVzENWz41gIy8e/Ddd3GRszCmgmdWb4XAfJLgwxcsQVDnKBjAkHC0zVopOmpKVHNrQeaqiHnjZPAw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39830400003)(376002)(346002)(110136005)(4744005)(55016002)(4326008)(76116006)(122000001)(38100700002)(8676002)(26005)(33656002)(52536014)(66946007)(5660300002)(186003)(7696005)(66556008)(6506007)(6636002)(9686003)(54906003)(2906002)(64756008)(66476007)(71200400001)(8936002)(86362001)(66446008)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TeEqkpprI7jO5C0BtnAnI3KuCQX3IdjwKQYmsSfl7ZyMbsNrfUe+JdN0yE6b?=
 =?us-ascii?Q?kT/Ac1YfRkL51WUjRPAQNiZAb5UR6haSBrrfASE3Cjy5+tf6dOYRfvZLOnFv?=
 =?us-ascii?Q?r0xrSPZlj6lqA27fCe06Lcleia0za9/q562GcpByZi5hizWaBUEfzaNy/iH+?=
 =?us-ascii?Q?MSd3yjLLPSdsZsK1qbcbf0czGvsNv7wfD/1OesBrmJksF4FfjBoMgcAig91v?=
 =?us-ascii?Q?JSuwJduGZhIczE+FASycukc6NujJgxmEeCeNIOlK/KCudBwEAQ3dd6LstcVc?=
 =?us-ascii?Q?4p3B4si1EPLEL+6V3xtAxbk5r7BGGZBEF+KaSZiru1Latea8+wyBV2C4B+eh?=
 =?us-ascii?Q?E6LLvU9A6eDw1hW99zrvX3h0CsihVQvy2V54wybRXfPNYfMQ7OE0c4wsRsDM?=
 =?us-ascii?Q?beyqt5/cR23DeE134PCUmkPwgwg+hfsvzIhi6N1z7215vkT5Ba/jXC85ZjEh?=
 =?us-ascii?Q?e46FmZJ/qPOfZg5k+acbTX+YI+hufq4ffQh1FG13xzCOhRiL967KvwRyPbfh?=
 =?us-ascii?Q?fTNIobnYe3LbuOs5PQ2gkGmrEGG51nF8y9Rcb0FBYaYSzI3HMBu94W2FG+te?=
 =?us-ascii?Q?xd7E9UaeRGuRI2HRWJYK+a/0eqrdc9IzbZ7cCQ9YHhOtSgdR9902geWuaHSD?=
 =?us-ascii?Q?FMzmYvQ4FO2TShkM9ozoZTxgEYzWr0obwKnVzD3+sRUWHe18+F0EBKXUjLzi?=
 =?us-ascii?Q?4NNYqY9yMUOMDlwvGk47LjyH672H6L2uytpPtMZTUPdBDMpLacD8RWZdHGh9?=
 =?us-ascii?Q?n9lhfdUuJ9dcEjuEBMW27Y/ZCQF9CCjbI+C0D1hn9S0AuBkxslXRn9SsR0KB?=
 =?us-ascii?Q?alYKvYmPGZfTxPziWHj1LlLuOmvFht3VYz91Pi26I/h2wZp7aeJQI7fUDCEh?=
 =?us-ascii?Q?B2H6UmjuuUlwfBSUbd5R0HxTmaF2oWe/SQmmCsMljk9noiKvnjcS8ViA56IW?=
 =?us-ascii?Q?/lR9a3/W/+bgPQqZ1T/2EvaZ/5WxWWP4IDUDJESirrYMstGrDG8zckBmkBg/?=
 =?us-ascii?Q?+BzBeH2YtANCYEdwKFD+1PdG0qYR45/Ac7xwZZQhWwlp8vFv2qqEHW5Z4bMe?=
 =?us-ascii?Q?Clb4R+gaP+fkb0rMsCJW3ro8WD6UoOqlkZ2aqtI04hSt9x2PSs4Y4JQXjXef?=
 =?us-ascii?Q?DIb8rRn/oPwR1gTb3kD6WSzd13QVpGbK2ESj6lARjUpelNU1Wo54pbBEmOdz?=
 =?us-ascii?Q?4dz3X0d83+Bli0JXiBbtTKIh2zx70utzqNokSwS30YU6ClcubfAApf05XsNt?=
 =?us-ascii?Q?LCJz5ZsL7iSJQmWOL3QsqCetaDhMQg+uIv6X0HVR0CBcoJGg1Knf9UstaUQt?=
 =?us-ascii?Q?4pY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6ad6fc-b464-49c1-ee4a-08d916e90865
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 15:00:37.1982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Hq5P8C/aq09iEto4dVoadjKMei/KdMceKxcIkOFyUs7N2UcKncakXeJHtS9GHlp6GKJYIoJ4LpgdEK1RixLoa1HlJxq9vCaYNCKiw11uSGSGtljE9XdCBSnwwOExzry
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7049
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> The core stuff in ib_qp is not performance sensitive and has no obvious n=
ode
> affinity since it relates primarily to simple control stuff.
>=20

The current rvt_qp "inherits" from ib_qp, so the fields in the "control" st=
uff are performance critical especially for receive processing and have his=
torically live in the same allocation.

I would in no way call these fields "simple control stuff".    The rvt_qp s=
tructure is tuned to optimize receive processing and the NUMA locality is p=
art of that tuning.

We could separate out the allocation, but that misses promoting fields from=
 rvt_qp that may indeed be common into the core.

I know that we use the qpn from ib_qp and there may be other fields in the =
critical path.

Mike




