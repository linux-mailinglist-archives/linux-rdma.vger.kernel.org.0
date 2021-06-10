Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CF03A2BF8
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 14:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFJMx0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 08:53:26 -0400
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:41243
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230269AbhFJMxY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 08:53:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OY1XeHUnvbhKIfy16CuHnR8RuA+yWK0oE7C0QlmNv5jauoTfs20zgU97YiXrwNzjoFNGinCpgnwNCcQvuhzpF2XXgCgw2v4iUiSd7i3fLs77ajjShJ470utpRqJcigpPfUfy3NiC7XjiHNng2gKbBZR6UTTlx0Cp/JBdBxERuiUoyJakKwg+TxofZuLx7oSn0Ea8VZYdUz1DX9F/NX9ZZOiwW2kk1AeRLw9FwuldLKEw58rl45Vvcg0pGfx3feLgrtDKSqU18fS3X6IK1Qf0lfrK9b0oEQFxcELsvBBQ9vdrs+yxbTDDr6dM5RXMUPfv+m/9TUtqSt/MvJ/w/4BeXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+SHqGKzwAu83Fw7YmadPdwZMwwH+1tUzxNsmqnQ3jU=;
 b=gGaBpBC80iwOiDu88FzQ46i6WhPiIu6Fl3e50FwVybP96W5OS8lf2+xiu+5i/6pZR+DOYVTCMN3E1FvBI63VR2QaLFSFwNCnS0SQm5lMg/2JkF66DQkqO6JP0RVX9mc2ws7gN5jLswxiIOvFsKV65BYYZELy/eSBrunNsmrw09+U0nU12EfHyEGh7ho4STp0iL81KOGUa4vU1mtpsVhpRpWXV430zgcU+1G1+ok9q6sh6we5Bs6B8w7VzbLkZeJuwDXjwePlwZc0xQzJk17jpyHCJAIHF8n45iP7OhhlrCy4mxuRfoh4AjQGY415Stzli9bGVcBW45JDPIdTQgVBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+SHqGKzwAu83Fw7YmadPdwZMwwH+1tUzxNsmqnQ3jU=;
 b=loWvZzNrlIRzC4e9DpS2Nw/JRFT9+PAKuiXE2SSoV4JmUs6yLqSLGbCk8MSo0znpz894zH5dLGEVHF/GFS+HMnLQu2WrJziiEiZnUFiMLOA7q1uSJT4yhga/eylheWxnKToEgCMy8AGLs1BB6AasxXRG43UK5OCzVw8Wft9XnKgbZJRlLQ/8lxS2Osyirm+cTPyHIscp0waIKPKMHZMhzcO8MhC45nrJ9Io+Zvf8mx5oAPV2evKO0ZeAaCNwbvz2/92XrnwhM3v3+12fQDgM9TH4s7rtbIhwitdvft5lfJhnWePA21w8TWoQxG08pruEpiPhSsLlygw9zxmhP+qLOw==
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 12:51:26 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::69b8:2b8d:bce1:b1be]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::69b8:2b8d:bce1:b1be%7]) with mapi id 15.20.4219.023; Thu, 10 Jun 2021
 12:51:26 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>
Subject: RE: [PATCH rdma-core 2/4] mlx5: Implement
 ibv_query_qp_data_in_order() verb
Thread-Topic: [PATCH rdma-core 2/4] mlx5: Implement
 ibv_query_qp_data_in_order() verb
Thread-Index: AQHXXUiF9Vd16Zkce0ujUMuw4V15PqsMvpuAgABiMACAAAJbAIAAED2A
Date:   Thu, 10 Jun 2021 12:51:26 +0000
Message-ID: <BN9PR12MB50522EC7EC780D64612D9668C3359@BN9PR12MB5052.namprd12.prod.outlook.com>
References: <20210609155932.218005-1-yishaih@nvidia.com>
 <20210609155932.218005-3-yishaih@nvidia.com> <YMGoQ2ZmTjSun54y@unreal>
 <20210610114224.GJ1002214@nvidia.com> <YMH8mr6AWEuJceoj@unreal>
In-Reply-To: <YMH8mr6AWEuJceoj@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0ddb069-eb93-49ce-0655-08d92c0e757c
x-ms-traffictypediagnostic: BN9PR12MB5145:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB514538BC73EB7B3C58FAD3F3C3359@BN9PR12MB5145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: en7ZTHJWv/ouhGW5Y0HoiY+aeyPeszW6kigGIK35UdOP10PU2Ncd9F3QRjgSsnpSTY6U2EVcLSs1M3rbspGOODBXjT/+L/ebf95n6ei6wLsmy30fwjmsZullOft5A59ui/+83waMe5J3qb7CtoMRMHWK19/GL8JagP8XYBgA58HM3h/lk1KbGRXJYL4nTW4LXO5IB9OQcZkts+9KtpdcVEJm/rJ7+HCVJ9PnHs4grcusAd8nXwpG5r0Ss/QZv34YhvO22r4CVId2eE7QINQv6ox1z3YADS3Wx9iXSyl7pGOSNawLafYvHEIq3P5w/kF+0O8P5DUvwXbkdq2uYlg3YDem+X/kMI0Td7j2RLOgbmzj76xTjwLpDmJgLxLrL0qjoUp+aDziNbaS1h74HIeWUnnUQMmEivtM1H7QhuSNu5YDefaHzhVL2v9LPxShzPsBmQMXxZ3CNxNBCUFOEtT37uHBQegYgfhEbt4HRSkfVou1CjWYoM14NqkePOf+xwSExI4f6ZC07OR+zfGIHm53xy+x8bE1ttuQvlSziqZveD2R5ByvseADAtdxAot4V3eod992ujKIICHpW36nRLqisfaeSA6kg5gR8i9hk5zx4eAmg/Q7w4RnGm7KeFhJoFTcMFwDqP1XF6UE+UzSx+jsv2ax7kwe48tdkGKhsyPuQiGT+f+hwWO0Y/a1LNEaze+c/qNc0MA6PN/XeFc/GbnQzYG8X9qZ0J0yI4vDMwK+SBU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(8676002)(26005)(38100700002)(110136005)(6506007)(122000001)(33656002)(4326008)(9686003)(558084003)(2906002)(316002)(71200400001)(54906003)(55016002)(8936002)(86362001)(107886003)(76116006)(66946007)(83380400001)(52536014)(478600001)(7696005)(66476007)(6636002)(64756008)(66446008)(66556008)(5660300002)(966005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oAFMGtmVn3N13tCl1GYTD5X2mHCr6L+ZdoCWV+EX1Cmjj+d1FgOBV50b+ebv?=
 =?us-ascii?Q?zLGsXk0E2DIxjS3T0jojB+458myKHlDoWVD3K8N3gd6TL5MbaSl8stLELRyZ?=
 =?us-ascii?Q?C/S9qYf3bGeGt3S9jWacQ1juaUGE82tuOuLCno6GI/nkmt29LEk42d34ewux?=
 =?us-ascii?Q?VhgB7m8pZ0P+3mFzQZbqHWaREV5hXJrIueHH/S1itIQwWX43nzlZzOjRr6Wg?=
 =?us-ascii?Q?IApHyZiVacCAQ824qNbSYFdruepdLeNrWW6TeXoHRk9pkBLFlmUWgpaQbV2N?=
 =?us-ascii?Q?OvqwY2Zr1+4Ad7tG/IoWqN1sbO1xgNNzRVbEnncjn9lPMrJVa5zGXBOmz4Gk?=
 =?us-ascii?Q?O++BPW+HwEwzyacskUDJjuADNWA5uY4wMCJf0eWuRyCHPHDrdUNV1lretK2c?=
 =?us-ascii?Q?vd0C7LMmRPJkfRC03bWi2qkiXOerv3i4Znqj2izU+QtSUx2ySqzybBKRBTPF?=
 =?us-ascii?Q?pokvBP5UOYXGC93RyZ/W7ZdtyK8Fm5aNc5Id076OiT/HfbYHmF1TPC/bz8/D?=
 =?us-ascii?Q?tq7dIg7518Q3p/2z6TFCF9D/yCsqB10+25deqoo/9278U4jQK+B+gfUd2R20?=
 =?us-ascii?Q?VIz022CPd7ulSR/Q4nRtqLXsqS7Oap8sphpW/c/bRB3fNk7N8TL83feZJn89?=
 =?us-ascii?Q?p3emzj7bZztHzvKNAPTrsSrO/+tbSv1KED8dZBGJ5VUZ5Mn32bMy+qJWQe8Y?=
 =?us-ascii?Q?1GCJWXD3Y1XRHG4/5T4FnqnN5M+Wv/IHSEvQMKbMXGo0/svJ9Ifjlu0oKbtB?=
 =?us-ascii?Q?ZvWu4hQ/F9Ort7Cl2JIBfhOLsoc6OxiI0FoeKhinHddWTTJ4Ef29GZ7p8uI4?=
 =?us-ascii?Q?UZEkNsBVI3d3wDQk5u8VfuKeFjtJukhMqc7thPSKT/00i3Yxw9R84QeUF0c3?=
 =?us-ascii?Q?KJK7AXCZFH1sLvMiaOHIHJJDpu1WOZ7ZmNv17M7XbqtLJHw8A72SFWSb9b29?=
 =?us-ascii?Q?dHhV0sb3gAYGNKacXySyGAxk6iC21/Oh7IueHXGroQuLSChbSFnKNWbvnOff?=
 =?us-ascii?Q?cqysDOli1X3B4LCxsDtROfbqJ4tXRQOyGYJi1TDNs/b57UL/pIla5je8rEls?=
 =?us-ascii?Q?Y80GNMG2MTvMNir6QcWk4aVGCO9oqJexPeVzvL91JnhzRt2u/QY5O3a4cdeh?=
 =?us-ascii?Q?ah47hGW384mKWW3iKVE11WnYlzTkhYcHhsn/f5n87FfW9zzuWp4heNzKb+n4?=
 =?us-ascii?Q?zmqN5ZLkPBmMjshQR+2l55QlQdZaZ5amMbGwXtO3SxmyH/SCOZa6v3G3Hnqw?=
 =?us-ascii?Q?+9vOQSsbETKjKT7GPL6V1+4TfGM3zL/X3HgnlTi97gfDNdiw1URwOC7s2fWo?=
 =?us-ascii?Q?hTG/dURu+w/NAjkIc21UDyVU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ddb069-eb93-49ce-0655-08d92c0e757c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 12:51:26.0647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APjL5axWqyTOrLRZs88MDabAwCH85ekUXScfspcWWMfs8NfPwuZfI0qIzPBWK9+RrKf7l7QP1PVwIrifbO8nMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Leon Romanovsky <leon@kernel.org>

<>

> > We should probably put the above in the core code anyhow
>=20
> Agree, it makes sense.
>=20

Thanks, the PR was updated accordingly.
https://github.com/linux-rdma/rdma-core/pull/1009

Yishai
