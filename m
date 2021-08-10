Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15183E7BC0
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Aug 2021 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242013AbhHJPJy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Aug 2021 11:09:54 -0400
Received: from mail-co1nam11on2098.outbound.protection.outlook.com ([40.107.220.98]:38336
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242094AbhHJPJx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Aug 2021 11:09:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6xebBTeb9Ei0+QOSronHuNe5ymLvI/na4vEwN8TA+uX5cfo96binlvF5xu/Z0cA4jJ4PdrtqMtlQxpe4d4d3QyZNbDaRgGkRaN5WpDZGlcwfeSKNwan3pWtqSNe/4TjBUarFPlAYevaAgYznj7fiMSBvQpHdkz2jkuzHoiYyg1G4DXOVv8+4Mdgd70IUgtASiccSTnPF41CT9cBtatv8nKfSDQxycAxXjco2NHdJ231hfCQa+kTMfRWE8y+t32JCgH9II95We4XBEAaN7JhZqfUEO17VwbJADuk8D5GCwLZszsg8LQ5M9tvfHo8tB8p+3LYHvnyFX93IkLBavXLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGhmc+CtWnRicLDGMCSWQjVy6Iw8kyzIgMfKed/39yM=;
 b=hW81oIKW7wJWVe7tLMflaeQWzH0rnJa/fUvIu30arCMjBZvBVQ+AHtGSDdzEwU+Qej7wHI30QfL3N2PMvH2DcO7PUHjc0MaOs5sfrvjfBfPWVVW55qroY8POuEsGRIsswTZR047ovxOs9d57xGlLTE8r8s8ztJyMDVxte5i4e8KyLmePTf9cPcfpDXAX0v2+ehVld2MVnTRYv/wcgWzBUeBrvbNrIeZmkuOiC/P4PAWkWMwq7wKcXG3JvtPejDtd10JgXxkKMb0TVQBvc9TCIvlEjicQ+KvTIl3hMXouGxniZ49muKLfcH0nAo677sDvRyJxLx7SqAbXjCBzO6URqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGhmc+CtWnRicLDGMCSWQjVy6Iw8kyzIgMfKed/39yM=;
 b=nJImuE3mdAZDX3fxgsSLJGLEIMKO3XemW/hEns4PaUgNUr+tpdWQFsiYuGUpWCQDjLYZUUrOTwQ+dJvGbaKgZ7IwziBYcQYmL2TAimBBJyHKk5kAbls5KQkNQH1D9/5K28X1kilfKdgnny1/Md0bJ+5iVsRGKTjtVKJsGQSHeAU8N6ZkuAISjXxjFQBcD0xRbd0aSG1l785HA1wL00amP/Mov3WGFqFD29DaXoc2Vn75gZvTcyI4VIaeqeVNf2D91sGWUFG3CvizQj0qf1htfGlP1iOdYL8ynYx5B5pQFysm/L+glFEkzzhqNpHZVMk7FReLKeYJ4lIFwLWBO4bL7w==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB7033.prod.exchangelabs.com (2603:10b6:610:107::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17; Tue, 10 Aug 2021 15:09:30 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745%8]) with mapi id 15.20.4415.014; Tue, 10 Aug 2021
 15:09:30 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: RE: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAOO93QACMdPeAACJMjAAA1KQDwAh8caQAAAL6WgAA0kOaA
Date:   Tue, 10 Aug 2021 15:09:29 +0000
Message-ID: <CH0PR01MB71539D5F84B81DBCAA2053D1F2F79@CH0PR01MB7153.prod.exchangelabs.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB715358BA093A504AED855CCBF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB71535949BACC7C43261EDAD2F2EA9@CH0PR01MB7153.prod.exchangelabs.com>
 <20210728170540.GA2316423@nvidia.com>
 <CH0PR01MB7153AC0E62FCE1E9C4C82AD6F2EB9@CH0PR01MB7153.prod.exchangelabs.com>
 <A3297641-63BA-4DF1-886A-3620E2A40BA3@oracle.com>
 <3DF0B3EC-4E95-47C6-BFAC-3313E147F5BD@oracle.com>
In-Reply-To: <3DF0B3EC-4E95-47C6-BFAC-3313E147F5BD@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f138c0dd-10fb-4743-2c0d-08d95c10da42
x-ms-traffictypediagnostic: CH0PR01MB7033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB70338E96BE5B137433A636F4F2F79@CH0PR01MB7033.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hpnRJFck614/KcJGVFHEQiG3bTnEmkHRzqKgbrkA4ZVrfoobe/xFMfkq/EfDfWkcEdwo8VVQIAOkg7Kt5QKi2nDgRrlt84XJy2ssQBWzEXFjAUnSxm4HRSqGUdaJl691s+WU5yfOdPD0bL8vj91oDD2YuJgv2hVv6dI9ZNOWnQTUVKa2egD3Ts2srH//Y40z8gPPfJOhEYtJOEWHDIvMyR6k6ktkf/9HkqdjTaqsiRKCviVsmopU1k4jpAhb98LMbHM4QI02Is7MiskFII355ZJVRe2Y9pjHuZyMmbI/YVhdQtORmx/EdqZMWpO73cYjG9nlWV8jXoTc4fQLEiTw3ZbMJUp6rFz/k2mgFPZAySWYKwX8PwVFEKPPWmnEdOCdCecCCoeMkpQjk8rS7ieS/jsBR7MRHiACnnYHDK4uOssa1nwWDAa6Izp5AgMhveEhu4+s0y356H8AYQnWRVnMDP0KmYnd0lj+jw9AVMb2kBr/9njg1vlS4eqAjfJ3bG3WX2iL37qbro4reTHTsuebo5fICbUyE/knW/RQ6XSa7/EUD+E55N6HFbB2WJZZU63cqU/LsFshPbgjDGZOA7vY2DfrnpNL6RouNDt2cwkmM1bnF0pKLOkOH/KlHBU+wdAHB1jL+QnfKV9r/R7ekV8gLwzcWT8v8e2XdqwXfdESbUBlxLhXxHvI+3p6qlB1+FY9fx2QiFgSJigcE6ZbJOwUVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39840400004)(366004)(4326008)(316002)(83380400001)(110136005)(66946007)(86362001)(54906003)(76116006)(8676002)(66556008)(66476007)(33656002)(9686003)(64756008)(55016002)(66446008)(122000001)(4744005)(7696005)(478600001)(186003)(8936002)(71200400001)(2906002)(6506007)(5660300002)(26005)(52536014)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W0RvaIf+BA1VOWG/7B869vQd3BGqogs1gOp9VbE8+4T/2SB2euJosZGqESg2?=
 =?us-ascii?Q?lh6mIt6mPG3GoRCpCvWLnHiG2buCAhWwYtNhIQXGZq3Rd7Z+Aoc4oa6B2SlS?=
 =?us-ascii?Q?XFizOxbYAo0JSJN9eRUyfoTWjSDMxAq2FJfABQgQe+Sd2X8Cn5WUcKnNg7Or?=
 =?us-ascii?Q?CH0l//lX8YV/AZUUUcSA7hvbYAizjUXjO//y/Z17+VQBoiBPzmD7C2Z+MFic?=
 =?us-ascii?Q?BUfiDoDrED3xdKEzv3IFPp2TWaflP/f5b6Xua7axwlYYgBC2srnx8Ge2lwCv?=
 =?us-ascii?Q?rAymCXH2tsUZfPRvyelv4/ti0+e8Gvlzp454PUcGIl7ndbY7Em6lZ3FA9RM6?=
 =?us-ascii?Q?u9yUJHnKxLtYh+LJPTeVaXDu87pApik98wvs6XQbrxFg5D1RAbpl6mTlZCwk?=
 =?us-ascii?Q?YZjHBV43y3l7WUn5xq/sa0aVNqh1xu/GnLj7YvpCATM62L3Q8ysIEuYqxdhL?=
 =?us-ascii?Q?Z4Shu1tyZ3fEVQwOFBOV9FTOXsNomVbVvmKr8/IUlctdH4OCPMurG2xfJVrU?=
 =?us-ascii?Q?WjX48ZejefGc8PDOJwjCMXggMnjVzeTn+dWpKB7LwyJIWat40d3dfHOcVPFo?=
 =?us-ascii?Q?ojay22ymKT478g5+/yvZ9e1oD1Z4M7qMJtD51z+YoB5a5n3OJWiX835KXVKq?=
 =?us-ascii?Q?5JaEvGtXnE7eMOLOfMiREPqInOyZR2q6+5o8kdjmEORNScf2fyfSSC2bBNh/?=
 =?us-ascii?Q?36D7taVRZEJOWsx54awK/0T2oS5SYSc1MBgTfeGbObXaur653L348v1JXay6?=
 =?us-ascii?Q?J4Gtt6POQ6177LjRlpWryYn5Tb7h9dVhg7Q/c3PNxWOcM985Cg7IbnNk2EDf?=
 =?us-ascii?Q?RUgm1f+AsKZZy97JyiIQj5mp7RXccE2ZV/3EeXYLzeLZV+8PQbJ8hBddADrF?=
 =?us-ascii?Q?5cOMlGVvoGyLJnETsNYyV4bOHRooJ7rTbuh3xFybKgmaRkUiu9ZKCIPVxq+H?=
 =?us-ascii?Q?OsDeEQIcItLQGec2niV7fns1LcX4MtYxejjpz/8/ZSwbzI5Cjg7REh2KFdUh?=
 =?us-ascii?Q?qnqnQAnAM2ME1YH1DTUmvTRnJCZQol2NFC4d7aHUd72mvUi+TpVlU7WFKOCH?=
 =?us-ascii?Q?JV4ZC6EWLrJdMcV5TpDOl0DuiRoKtXxvKcO0Ovy2sZoCrVHd5OIf/bDYsVXf?=
 =?us-ascii?Q?P2/PuY6qkUYEtjcDg1IOr+FGcLnneeqOgDAPkvwVbzgja9ItN67c1xXzkhk2?=
 =?us-ascii?Q?c+xEYMHZxtCTj0LFXYtAZiry5xViqYdmrb++uZbE29GAQkqIAj+c+ucdXV39?=
 =?us-ascii?Q?m69wr79wIXtZpqze/y67SVrVGMk3LFpp9eBXFkN9TWm8xZPj3b4J3j1IH9EO?=
 =?us-ascii?Q?r+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f138c0dd-10fb-4743-2c0d-08d95c10da42
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2021 15:09:29.9373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBu1rpmiFXOJ9CI7fYQZOvDf+8uFJPLGevmfeUlC2GSH9A8ASnW5Y4uNEVVmol2n9daDTJgLWBIeGlQBtQWszJ/6w+f4xpZpjTr+CRah4hRo/AofZzyBNyDW+QYZRiAj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7033
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> I don't have a philosophical position on exactly how rdma_create_qp()
> should work going forward, but I agree that ULPs have depended on the
> current behavior and will need to be updated if the QPs returned by
> rdma_create_qp() are not in INIT state. I stand ready to fix things up in=
 the
> RPC/RDMA consumers should that be needed.
>=20
> In fact it looks like some consumers might already assume the corrected C=
MA
> behavior. Maybe the RPC/RDMA consumers can safely be modified now?
> Let me know how to proceed if this is the case.
>=20

I haven't done the same ULP audit as Chuck, but I do know that the cma.c pa=
tch caused failures on both iSer and NFS/RDMA.

The revert fixed ALL the issues.

Let me know how to help test any successor patch.

Mike
