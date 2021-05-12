Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7BA37BC76
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhELM01 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 08:26:27 -0400
Received: from mail-mw2nam10on2097.outbound.protection.outlook.com ([40.107.94.97]:25845
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231909AbhELM01 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 May 2021 08:26:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FueKi/JfMGwi5M3A01f4FpLDfW+od1m1paaTAr7Gu7UJrKDa6/F/ooshlHIhQAC2DOLfAck4t5bndsQtliKByfSbzX/MkaOm62Li2v/hs/jFvneM2kKw1ZHg7To6M8iM0Rh/AibOkwKWuHPtbRPlXNXv40dxaB0/odl1rZD2jpevzk4rmsKS6d5gbu4fUtJCQbMbJ/nQDksftw26D1zCw9tb9G0lO0BZcs7mnzn4QekSibmeLSfDs41gUkWzErTCU06Su4BIuSKMag1TZCTUYCuA30HTCaeEZEtlr2cnMSi5Ve7sQkRSs94WOE7e3+s0TJI++pAYPXLrXaukxcu0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbdeXCfLdi7jFU7xCy1lpq95mDcZCvb8/quL6hgtDsE=;
 b=BJoexaOeON5c9tEcZLnqVg5Cx6YTe+HKwFSReKckJ7NRqrnUeuQzF/wYiDI22zjwunIlk19TueOEK46vaTbPv6KuNAzNIPQo9aMiRnlIUlnGUasPVNFUbWK9J8Ka4mQaWBZ6AFlf4BGU+Q84r3V5kWYJzYIfQ29OhKG+QQD1RzFxYpEWSdDObHTLzegY75kDlTzR4J9AoCPcu/A2x5YBFlx9eOMEqxAjSk4wHOVt8IoFjgsg6P4TOkjQnPupfCPvPeTYqNaRrC8l8Q/CEYiyCxO0ClX9pglUUN2tVV45w4QUxa/NAh170qvaYxEiDxUTtYDVHIKvY3kc1T8M2kGZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbdeXCfLdi7jFU7xCy1lpq95mDcZCvb8/quL6hgtDsE=;
 b=MwKw+3I18JfAR1XwrxFDUPV82K7UX9UISIeCu1wRLehasLTQMCCYaXVUTi2RQmiynZHU0GP1srT7IJ4i0S9vtf47FIu9yIIhAwclM+gZrZlUR0cv0kZUuo2FqRXZq20cEFNn41p7Fs05FfD0gQUTm6mS37F+h9ZSsM28jpfMM5TUTTpCwTy9f71A4NCVdPFigyQLcK1H5O+OsmJ6ctGH/3RyQeIGfTRHNe/oVqwy2HrLdXkkPpui2Iqn52oMty8RlPWtdTsrCgJVVoqjQL05Q2E6PHFfl3ZGcWhCDs6WmTOP+E/WrIUZZ46BkXukbgNzcZ0AqIHGvTyqlrFLH8zj8w==
Received: from BYAPR01MB3816.prod.exchangelabs.com (2603:10b6:a02:88::20) by
 BYAPR01MB4678.prod.exchangelabs.com (2603:10b6:a03:88::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Wed, 12 May 2021 12:25:15 +0000
Received: from BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::d145:208f:691f:1ba4]) by BYAPR01MB3816.prod.exchangelabs.com
 ([fe80::d145:208f:691f:1ba4%6]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 12:25:15 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Leon Romanovsky <leon@kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Topic: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Index: AQHXRlGKOHE6QFLZoEWMq90D8Um/dareNSqAgAACT4CAAY9wcA==
Date:   Wed, 12 May 2021 12:25:15 +0000
Message-ID: <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
 <YJp589JwbqGvljew@unreal>
In-Reply-To: <YJp589JwbqGvljew@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-originating-ip: [70.15.25.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36d284ab-1178-4963-7677-08d91540ff7f
x-ms-traffictypediagnostic: BYAPR01MB4678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR01MB46787CEF0BE0745B27FDD755F2529@BYAPR01MB4678.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R8ETJFkINTs4MjRtnHBL+HK3EmV3LCtFHn1/vQ3IflxLjRGZT5aAsg5SSdkdhf90hHks0bCbUFG7EtqbBroMAXZTu3Ji8RE1YmHoz6qIvbu37SeOkFCs90OcLouO4T2P1PaGAV7Yw9cBhJIr2Vl4l9lxpDZAVVyzVw2t4DuxyZpHvqjhTFN6OPYrnvHYpz7udNFcMhBn6xyTGT1eu6Ry4vje+tjTAEYOMu8oejHwtb2Si1uXVEsqueDOAVhCnahV2xr0L/9cSIuzA82sg9gE71ZXFkAXh7/aTiZtR8pfvHENEf492ViPYejPo3JWjtdIB/Rpdy4oSWg0cULs/kfkHQvwvWZXuG4U9AW3J7R9xZFHjpoC+aaL8qMHmGna/ZKPCjY1VH4GzTe1K+DtJYTAY4hx8ceqHc+waWWcG/o26XiHKp/WNCSsIxzs0R4abMYubB/e1bZyEhwc+OHl8HY473rqohqAg0VNDM7+vWWLNNEVr5LgMLKFYPMwDU51nmlb6vsoiyx+7sC/Mt/w2BZ8tDJATpFnwILbqmIHrDFhuyEtfHYRovjBhOisK0gWSxhjAUeQ6caZB2rtUxrUPmA4n/HHMxULa1dfrpk5uwhp1tY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3816.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39840400004)(366004)(376002)(396003)(6506007)(316002)(54906003)(52536014)(71200400001)(110136005)(66446008)(86362001)(33656002)(558084003)(4326008)(122000001)(6636002)(478600001)(26005)(2906002)(186003)(5660300002)(38100700002)(8676002)(7696005)(76116006)(8936002)(66556008)(66946007)(66476007)(55016002)(9686003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vhKFgeqI7FNMQcFZ3w1AfneAu9gJsHXRnriiR2wo016TbDdfT1PlBRQszJSd?=
 =?us-ascii?Q?9bmbB9EakLNGoo11L2Qt7V7DrZ5byFLooLJX4TYQGDtny2DqZ71WP5+UHAl9?=
 =?us-ascii?Q?7DmPdKs4sS2+5lgid0TB82yyumrycrReuqMs+YWiUau2/IONaqumE4dcl+IL?=
 =?us-ascii?Q?IvzdPxng/qDjsI7ObumoYUL2KRhfCocTMTsyJKk94ki2o6Hot3vfJ+Yrm/j2?=
 =?us-ascii?Q?U4GWPwOUw3HK8Per4nFhZleC1t7FcGcY0yFkOrdFSyhVYQxd+gkJL/+NcZ5k?=
 =?us-ascii?Q?dhTO4AucKYF60gG//y0XAhkmRb0KtIpiFNmYD6KJ+OjQkKKPFkyQ/8ENBWJS?=
 =?us-ascii?Q?T9SM53PNbv/ifbjVYYm1TE/h3UnbikkQIVZq0r9FrVqm8fMLEO/E1Mw1rkiS?=
 =?us-ascii?Q?zVM/oJtvYpOM8lYBN95iU5dPvzPSHyTzvd0GiRbCd6laFt7oaYJQiCs8biDN?=
 =?us-ascii?Q?IsTpzjjAz5IM5gRCbkEqeiwpawBGPmm40hI2ItfkAN7RdOXpGAG+VVVxnVrR?=
 =?us-ascii?Q?H+ab6it60dVxrKsjej4JmzOZsqIcYBgDFUnLiEwodZruOrzs8IqXrf5ZCss0?=
 =?us-ascii?Q?n15aubbwevDisAlzZRIW888xI6E8OAfj1vUB/QYU2ygQtBI0QUb9SZcxyuSm?=
 =?us-ascii?Q?nDoSL94d6AXv0Aa92xG4lO2G8bA9tECZJe47UO7yV+/Rb6q5yzn1bRJXlU+5?=
 =?us-ascii?Q?kWedhpqyQ9ufQjo2Sl6AMk3Rw3iFVQZLi7Pdk3eF+e84LWq+quFSXCe8ntT9?=
 =?us-ascii?Q?ynhgW0HLFbQnUK+Yot0+sOKANQZZQTvOcHSLXG9Ej71dNTc8Zb/Z8kf7TZAz?=
 =?us-ascii?Q?IRe9uz0mm6rRKM3d5EDkGTDfaYvVzYlF4MrAyrE7vANOd+3X4ilvJ3d4ANRC?=
 =?us-ascii?Q?uCr0f0oaufRVGyVej17aQ5w8MykgnpFS39cWMOUHlC8wK7QxGLp8p8r6xMKX?=
 =?us-ascii?Q?+Lg8yhnV4fMcCqdESVcrIQ5uvPtNUnCWSLgpSawQChYKb6B/gsFurt1RNNmS?=
 =?us-ascii?Q?QptTFgJPWyhj0jGqO+u1DB6aM4vc/tAYj0CCTaoVC0wXSt/tA3S4emTwdNo8?=
 =?us-ascii?Q?TNTojPPdAnVifNfWBH5kQfUl7dvcYDEgizNH5RaZ369cQEvuKOQizXm4oMOk?=
 =?us-ascii?Q?LlbmDXK094G33LoR62qRLDQjgWdYL4zEM04WWQG7muPSt3f9F881n72/KVsU?=
 =?us-ascii?Q?TQoNG7TyoR1WjwuqQy3yoTWosWJlQDXE9yF0Dj7+UQas/r6WW/ywDqT0WRN1?=
 =?us-ascii?Q?JtiIVbgOlC7wEZLzs8+0T5JZ6JloW4hb+ms3T4nu4YhWoG/2n5Hxsr5BuQIq?=
 =?us-ascii?Q?bSw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3816.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d284ab-1178-4963-7677-08d91540ff7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 12:25:15.5781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 508Yz27ErnT50YZqiobg9KJyaL1uUN/rgKSk3+P/6+evZmz+xfOSt5iINfcXBce25fxBh08ietMe0tvPwPPEqgRdKNM31ArECmU7ytP37Xn83AkQedY176oPHt1iihjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4678
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > Thanks Leon, we'll get this put through our testing.
>=20
> Thanks a lot.
>=20
> >

The patch as is passed all our functional testing.

Mike
