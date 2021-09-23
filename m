Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B48415C79
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbhIWLFk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 07:05:40 -0400
Received: from mail-mw2nam12on2102.outbound.protection.outlook.com ([40.107.244.102]:46049
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240448AbhIWLFj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 07:05:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxrxEB76oS1LY9EFFOzOIFpwrbVN4fHipTSgdHG3tlOYaiSBeHwRhYa6nlqE3hmoiSJeDBy/kyO//3Nd3b0nPYfPLxSBae+9YLw729J93sC2SF7L9uK9FStyNl8e4f/HYhQtdvisYPJbD6dn+3j/C/fdH+W6NNSUYo0OXqCFw3Iz1pYKHK7jR5uRO984U8enfr17t83zFSoYry2JMU06/jMTEjW3GDsc8FTimXi00r5nPx9cMw5zBCts0rtXJsvM5Z3TNIJp1xRCWvyzhaLhhk/Ka+aeBHJCj+vLu3CeSYvtl1msEBhZOLHFwIjrxPBZ0+F9yMPx22ehoyrQ1f5H0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CyKoOvkbgGuA6HmzM4H2DGmtV0/Pwu6yWs2H0cViYnM=;
 b=C5EmelbR0PuCFg5vZrOvqAN9QK0l7lEbV2eZ8jkzcOgT+2JgA9pehUntdgf+SUwpiB75uahitUIsWLg58kq4djyLUeqyGfUYRQafz7CcUwV2hL4wjweTlwnC1N+ulmX5veunoHttDGTrBpkiMiSLVHhCQNgLOr4bjAK1d9P1ZmC3vLaFESahjqeE//my5Qm0FzYs/Zk2z9YQ2BCkUEqotJCB1NVkCRrs5LpPINfoRQ3UaPMPnrTgcj0ImGMavmFWGm1eRaYUfxohT9mDDrfs1tPYoDogzJm6rhr1tk25WUFcPcSqM1UsRf7gu8g8+4MzXDI8fGmPuNkXTfizYkpmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyKoOvkbgGuA6HmzM4H2DGmtV0/Pwu6yWs2H0cViYnM=;
 b=YHP56Hy/guDzWE3PKJk09iaim6jtce6cFVsbx/l7JD64LOm0fpC6/ccABEYPgNjqb7IqgrVcV6vQvXPY4rVk0zFReO9dBehvzm4J9xn4qWpoIO9Ssy0z5gQ/5d3LqoaXEfTRzSRcGO+H0i9NqEVGaZi7Lu7bDsQ6MT0pt3ApLG/+WkOVrRG34wfK3onpHAZ4pWeizK31LuxBS9B0lA45uwJhkAeBXVrwPb2NvhiP51TBHv28frZOCigPPJStny4m/82qNIW9TpFCrEhDHi/+XQB2x19IZLbauVXC59veJXA89KGyrrOi0CTxpKNRfFeBJQhqdCUWCHahHVeSc4V2TQ==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB6923.prod.exchangelabs.com (2603:10b6:610:104::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Thu, 23 Sep 2021 11:04:03 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 11:04:03 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
CC:     Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Topic: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Index: AQHXr7imk55risfKAUmS2+aCDTMROauwTzmggAAKPwCAANRigIAAR+Ng
Date:   Thu, 23 Sep 2021 11:04:02 +0000
Message-ID: <CH0PR01MB7153E7BD0F3CFBA384EF97ACF2A39@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
 <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
 <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org> <YUwin2cn8X5GGjyY@unreal>
In-Reply-To: <YUwin2cn8X5GGjyY@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa153e5a-8b0f-42ab-dff7-08d97e81da80
x-ms-traffictypediagnostic: CH0PR01MB6923:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB69231E9BCA285371347C6EF0F2A39@CH0PR01MB6923.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gAtJv+G4biRDwrmjGUwBM6q6Uob3pMsy2FU2dQuY80GxIPFF0oV+LH4qm5ZmxuE0E7+Vf5VlLX+Jn4STBcV2mQzcTBnfjBxnB4/sASoaFa2ONYFzHtlV+pZExFBP/V609I5F5WjyRq33Hqnl04WMLdczkrqJjvI+lShS26V/zXkoVzcwMjnL2xLax8ewPIQL/lj9X0+GYO+aajTlODSttwXIgIy7v/sBf2zmIUsRRp2rj2zvlp3FM8jTZfGVv0Da2+Ec5sovIrNWA/jxvnUBEYzXmGJHlyeOBqsPx407LIRI1BBWU4zO2LBBYfIKAao9jsjCx4t2DkGa9XK4bdsyp8A0fXAVYj0Q7F2CxdKCg49X9T37dUDa50ZXrlpY/LG332vB0lCgkafx9QEHXG1tiaIdxxqdwRj/nIu1DhWjIjO1wR2hJoZ6uTMdzERrQJo+v61iYGXmGReyHJbRKsbXsLjdWxCr8kbzcbECZ7tyBJMjDrZcnFNB0tY7GMkBUwvsD1BH3EVLA5eVQFgwFoPgBEV4AV7mumiWbQF5IWGge1bDtYQxVsgCYQOzEC9i+bpz0LHvsVrb3xr8LJtFLtl8Fj9SliHqEVFlMckG0thgP8FSk+lC/6XiNfvzEXB22DO7FNBkAGlooM4k6ZmdaRA1MUn2uh4I3G462sS3wH13uOZZs4B3fNpzueOUaOE9t6yUJkhkZbleQwvXdnFIAKDcNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39840400004)(366004)(54906003)(2906002)(8936002)(76116006)(110136005)(55016002)(4326008)(66476007)(66446008)(9686003)(66946007)(122000001)(71200400001)(64756008)(38100700002)(5660300002)(52536014)(66556008)(316002)(8676002)(33656002)(508600001)(558084003)(38070700005)(7696005)(26005)(186003)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GZJ4wZcnz5PAaBxQYxbEiqdDjqgJHjtlPORu1ZEHUCv6gaD3oPbQi2/rvG/c?=
 =?us-ascii?Q?wVjq0M7cqqPueDYX0bAh3jfbGp49If4OGoPWrYGfX3xcWH/pKNrOvh7z/sh7?=
 =?us-ascii?Q?w2y66PE7BwCPxiieOiXcYl9Emn1O1iHj1HKUh3rLahsWH35aJ2A02zge7Qw6?=
 =?us-ascii?Q?fRIl8hgAjmOWjT1CWXmHk717fbR2Bx13CeQqfOPoUSHr/za6JkpmPfNzaTNC?=
 =?us-ascii?Q?VGRwchtSjxh82J//o5/gbSGeYqWb8Qo28AkevdLy7Qa6hvy9ZAGP1O1JPsn3?=
 =?us-ascii?Q?7qanlK0x/kcAwEsej0LuTM3jILPkLxk6+pFvvH0vw+WGW4xoc4V3JEQpdjbE?=
 =?us-ascii?Q?tdgLcRYsnc0A9j83upAwqVlTU2GDbv0dI/6lfEYTj3xIUmQfPiY6wI1ZQZD8?=
 =?us-ascii?Q?6wTe/tGZb7nEUHBNyQJWS2aZvOq8KyB3kDjXnvOzh1qXyT8GzctQDfVnltwW?=
 =?us-ascii?Q?3LzxmL5d3Cex978viBPAhdLrfQWDU0WaZJoX/0eh8/OxO8anvZGd2sU6nPo3?=
 =?us-ascii?Q?iaMArsjZY29kDHdQp4cYW92kIwW0ETj5pb9EpGX1oRSgoomJ2MDBfGdWAIFn?=
 =?us-ascii?Q?ysj2s9Em+usm0C/TeYwhRgkjIH5k0Gh5KjYjTkh2ofSjjIRSDg3xFCOunmeL?=
 =?us-ascii?Q?e9Oz1IGsNkbKpVs8a0CagIU7HjTTP8jntk67WtVAylJOifhrMXoZlLe/975W?=
 =?us-ascii?Q?EGkDL1Jc8wOB+K5zz6DI3BSRR1sEG6JkgLIalrvRDyu0MeJ/EPY72hm/8Uub?=
 =?us-ascii?Q?6P3GCq2d1pdDVViofV5MDXiGdn1Ummny3zyTlAPv5w+wXiq1yCWJabk5g9hP?=
 =?us-ascii?Q?tvOhl1c5wbpB6h/h5743gjrNEgQ0q+KDkfFjZQOyyf/ptqQE8Oj2R11BkgpJ?=
 =?us-ascii?Q?ZXUGrqzSIpq0STYPDrK6e3I9QTm+E6aCoL6vKEorWiiE+RUXRSAjg9dgsYJw?=
 =?us-ascii?Q?8G8kaokfAcPwsk7J9A8QDP16hvEw5h5VzGYYzD0ghT9yy0p8kuFV2r+vX1Mk?=
 =?us-ascii?Q?hO7i+TZeehEks6LW63SgA4nYtertYOODd7iNS1Y2ta2xN1GwfSA9b6IK4LcM?=
 =?us-ascii?Q?6gf3+8c9ubsrROpbS5BMhLkaJQvJNqnaEQ90WiizPPgVsS44CBrBJgXugTyX?=
 =?us-ascii?Q?uFJ8BX1O6DDGMQgMAnWVVuqNRmplw/8mnPFqdSydAEgjhIaLCysqzEWxpHp8?=
 =?us-ascii?Q?MN/vNdudS8oXnQJhccD2FkOld+czom9ZY7Cz3TZm3zDV6GjPMXltbk+1kBYG?=
 =?us-ascii?Q?mIiLt2uRSwB73uPBmtW3QmluXrjmM20gb+a2X6Vz3WF/h5uY6BX6nz2W3xtI?=
 =?us-ascii?Q?7sM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa153e5a-8b0f-42ab-dff7-08d97e81da80
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 11:04:02.9205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAXjVoaTs/OldnvLfUawvIQsHhUcYVLP5X6az+HDTTvjMip/Ewg6Uj0TePVpH8JsIbanvCHazJo0e66VsgbynTfZba3pzKAJwflfii7ZKOU2tTHvmkWOuH7gg66Jy7vd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6923
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>=20
> Isn't kptr_restrict sysctl is for that?
>=20

It doesn't look like that works in irqs, softirqs.

We have plenty of those.

Mike
