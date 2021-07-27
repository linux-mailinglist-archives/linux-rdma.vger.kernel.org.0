Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F223D7C3D
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 19:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhG0Rfv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 13:35:51 -0400
Received: from mail-mw2nam12on2119.outbound.protection.outlook.com ([40.107.244.119]:44115
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229593AbhG0Rfu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 13:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggds8nFhLfUEZMRUotkSuyih4EYFQtCKFHLFcvB6rfmGHmdE90i3Q0fGK4YKdIUVkbXIxX3Yg25OG6vfNo9XhXysSzgwTT6hjUpYn1voR0mLHOMqfG4BU5HqZ8y2Ig4v1qdvHP+Rd6+ZhRC9p7UOXK5lqrYrMtnrxHo4ABH+CMvRGQ8oWs1/3awkrL/Wkc9MC3S1Ttp8hXn8UT573HmDPXM8piS/JBLDiTsPNOTMqq5H3DBUO5saeiPoAnKNTZuQGvaFKzJ5maEy7fh6i8g58UDxjCbm0banSFCsk/Vn2nMUjmiQCO9ooL1tKUQG6lW+fx3CHjJk8U6KzlK27/mUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvMn7eaYwpstLUezBbBe/3gzop5lPOQXBkld9S8iMIM=;
 b=dB7YyNjjeMJ8fBXHdelxeaqMUHF33QAFHapmGntEjhz9Smj7xqubYGz6o3MQ4IKRO7Lxhspzb2GZI9Xutn/5LwJT8E89yhoTaHW3yj2Qou4hkNJOWNqB3QJY9HHHPZwJmrVYoY1h5S+esk1R8EezwNErjxttVf9UzEgVb7JfjK8Z6YJbxNq4DZCJsH6WJu0nEfAxyNxY0vi2B+L15N//YWZzpcwjAjmRMI5NDQlQHRjAlKRYd/WN2DjyL0erskceydLPrZapPQ+F6lV89AdF/zn+QUWoY2J5mFWOV0PEtzkbII7yguJARSnZIITV0ucTNQ6fsrlvJXR46j5cTKjEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvMn7eaYwpstLUezBbBe/3gzop5lPOQXBkld9S8iMIM=;
 b=YlZx0mQTkuw3SPTx54VZ1QMsT/KxDJmfE6PPXlA64lpexf3zZxLmDbfQjI1MB1fZ1RUbj9pnvWys302o86wiu/g4g/S8RRMfFCOtHuvJFa+z5Lq/FZrBat+wcnsEfqwpRQFHPnl9827cJNYtZThg5syHbiSlD4ExzMDn36NdjQr/Ml4QUvKV/YqtbU8op/NL0c3flvrbVFke8BpJMA0da83U+CHlp0DOCvaqGfo5O8H5Utp6nqFtKX1bds+vbMzK2v3YHXhJBQrKXJqMihEnXnY4UrXqp/zfKlX1bdH+06ll5WPYRPrBKDU+JSdquXcCKZPs9RGhSt2Ci41YWdXgPw==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5928.prod.exchangelabs.com (2603:10b6:610:3d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.29; Tue, 27 Jul 2021 17:35:46 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34%5]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 17:35:46 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: RE: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAHw3HQAACUb4AAAE5b4A==
Date:   Tue, 27 Jul 2021 17:35:46 +0000
Message-ID: <CH0PR01MB7153DE8406A68B049FC81EB6F2E99@CH0PR01MB7153.prod.exchangelabs.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB7153166CD64AE0097B72608CF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CA7DAB52-ED96-4B47-A49D-88C3B8C6F052@oracle.com>
In-Reply-To: <CA7DAB52-ED96-4B47-A49D-88C3B8C6F052@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76bfd6de-3c16-4f89-53bb-08d95124f7ce
x-ms-traffictypediagnostic: CH2PR01MB5928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB59287A2B8F4A6BF24C6C18F7F2E99@CH2PR01MB5928.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AtrVX3SsBqSzkpWpDhaFm4MITYcUCiij3YW8op/aiKEwilg/JlKW/0XfYC8gTawmxHZoQ/8BVcxjm+9O0vg6Tave3kCsIQZyLc2xDOOM56C3p/iYR5cuqbiJPheC02vPaPR2LBOVwJs+zUM6wataHhqNAUhswVkwSSBhAIOfgmidM0NWUc0HQfWNT2k8aGWQGJdXTsyWIXZoriyWZRy5xzut8xd0x/Gl7qlagNdQz/SEw3PBqtoGGWUIvoTXgYVTWxrNPuKxU3ku6KuaLMEhFNxypdcph2OYK+gQvpHRIIPQi2QvPwVD3wcCLZlB+RTIaYpgh0zwmtkDCPfs0fxbvRwmvtMIDHDQWEKNhz86fNBie99vS13jcJ9bHb9KTiNn0SCiQIy27A5qAlJolJtfWHaswehaM1+fuTVz7u2LaYRRABuvIhbTqSVRjR9q8euuij4XU/SiRln1GWLUS3RmyBod5GbAYmXvW3Uebvadlmkc0z7EeIsJWW+7gk7wBQUnMhxcw6FShKH53g2WiWFS9SzRFWu+x+jXiiXItokhIPw/FJrIOJvnas2dMrz5CM6CEx/h8DzG9M+FK5IG0FsIZNI6tkMp7iwchDXIh0rptstiSv14iMXp3nflwQ85xyF0IqOmfef7nHPA9cNGkNtPEXDod1REohYMMNNr1VMXfM5hWSnBUkGJCBh3hW8UH42QR/vIebpJuZ69JFfJhLah8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39840400004)(366004)(136003)(478600001)(7696005)(66946007)(4744005)(76116006)(26005)(86362001)(71200400001)(8676002)(53546011)(8936002)(122000001)(2906002)(55016002)(6506007)(66446008)(5660300002)(4326008)(316002)(38100700002)(186003)(52536014)(64756008)(66556008)(66476007)(9686003)(110136005)(54906003)(33656002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zrxFGVMC7W37+ZmcecI//0e6S9YDqCCiUANXtTx3YW/TGIZgxb+VriY0KgQf?=
 =?us-ascii?Q?xqllssWUGiYM2w6t/WZlHAhcGOUbwLSNjLByFZZxtMxNZWj5EaByk24djJ9m?=
 =?us-ascii?Q?2DihVAIexUM7ka7eWgZsEkhmxPreCAR5os/De36CzIXXSlzUAYRbAh4zftpi?=
 =?us-ascii?Q?KOacamjo/4VZMpb2Dp85qMDw8mQxkV0XcbI9AauJnsVbUVvU8HXGAWqbEHle?=
 =?us-ascii?Q?LL4LdIIfWgzkVWhsENUJZTKkkjr+ofH9zTcuvVBEgo7B9tzVqXpIoWf1GBRE?=
 =?us-ascii?Q?lcF1CV7P5xadA9icoWar1fm9c0RTMafzHW1JRmPn8TwPjo0gUoMpCeX17pst?=
 =?us-ascii?Q?7LDKj7ziSekfquiO4QVgFsbRrd94h1MHESlW/B8uvp78/JAr+0KcEB6R/Ro3?=
 =?us-ascii?Q?hGv4fwJWi6Y8GG5BFf+CWyy5Vyr2QKHnAE15hfBNilfy3bna1zY0p3H3CCht?=
 =?us-ascii?Q?MT0NAQGCspmtIHwQjKzupcMmCuBzBqNt3wd5KAFA5I4bk1GQAhoL9h+12pM2?=
 =?us-ascii?Q?bzUMfs6n3ethotjNtugCTpSIZNebMldqlzj/FobgZ2x8cLzHtOkZBsJ1kL/e?=
 =?us-ascii?Q?tUT2zoU2fPFn+D19VE4+KkCWxH6aUNpcpxcFl7WnBlFQxgV5dTetCdlPKKwt?=
 =?us-ascii?Q?nQI9snNxfgcJahLmNHdECl/MB0fdEjzDENF+8xEt47oDSv2EkJILB8b7wEdR?=
 =?us-ascii?Q?c+GayCbfb9LfUp1QOBPfGvsS+OkG7nuviNj02sDnF0jTma4jVzKH55YufLS2?=
 =?us-ascii?Q?pTtcAfmSRvM1xpQva34kbN+ye0ruiOVlTSvxz+uqg1wJOLiFpzpVwV4S4P1J?=
 =?us-ascii?Q?5BMXD6TBWCggmwlp6hmg1Ka0mHNMM60FGiXLqT/UgW68ip3lJhWwD6vA9mSi?=
 =?us-ascii?Q?qTFvO4qYkG6VydSW4N3jTVevbkJ3Y3MkhTFwp/MAxpf4ev3b0UfwXXI9b5xK?=
 =?us-ascii?Q?Z0nZKuvx7MbkpjU076uTzRH4QZg9Nq7oRe4rOKpAXrnl+eI20t9hDKdLUFaJ?=
 =?us-ascii?Q?33YQ3QnTlvMk/ilKqp652ZMHRPxsNpY4d+beLVZJSAsZnqoeyDAKaSoq4SKd?=
 =?us-ascii?Q?Z6vJlg6I/iGrzIV+1qfH0bgOJBi3pQ8qABRtCSibQczhh3Jl+z0UBvhYahzX?=
 =?us-ascii?Q?U+A/E6/6FnnP9PE2PFRDASu8jUq0RGzXoNavLG7RlMiphGCqW+gcHO0U083M?=
 =?us-ascii?Q?/tTPdhVkkzwF5S6MR3KjVBINYX+R4tCOILvv8VA7RrU8hwqwteOPhZukVTNx?=
 =?us-ascii?Q?AdxeCon9ktOpCXilNEaWDVm5VZE//7f2heqUEmC/dReT+ISLf/JrudF+c2HJ?=
 =?us-ascii?Q?BtY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bfd6de-3c16-4f89-53bb-08d95124f7ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 17:35:46.6159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNZ9ejAy9jeCLO/RsXrVQrogZaQFeWFn3lnaQrCWcVWCp6raeVJPMTb3kordFXV8b4QrX9rngqaINp4s1zmNkOV7SeB+Mev754ZUKQz+w4c3EKbbGcacL4r7cNv4+1v6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5928
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > On Jul 27, 2021, at 1:14 PM, Marciniszyn, Mike
> <mike.marciniszyn@cornelisnetworks.com> wrote:
> >
> >> I suspect the patch needs to be reverted or NFS RDMA needs to handle
> >> the transition to INIT?
>=20
> If I'm reading nvmet_rdma_create_queue_ib() correctly, it invokes
> rdma_create_qp() then posts Receives. No
> ib_modify_qp() there.
>=20
> So some ULPs assume that rdma_create_qp() returns a new QP in the
> IB_QPS_INIT state.
>=20
> I can't say whether that is spec compliant or even internally documented.
>=20

This from the spec:

C10-20: A newly created QP/EE shall be placed in the Reset state.

Mike
