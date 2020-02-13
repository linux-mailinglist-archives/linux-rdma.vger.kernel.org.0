Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF3515C822
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 17:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgBMQUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 11:20:41 -0500
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:29934
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727772AbgBMQUl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Feb 2020 11:20:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk+z7HVIdNm4CT5PF9Ezgq2TsjuJZUPUAGXCB4jOOM0c4euKbnbkDGY0usImEBDumU+waaE4LRf853h3srZkEKJi8Nvym+sbgLUOUzXhcMXKSTEsYArZ3dVSREyqjebyled0/38B0VknYGJK2H6p7KQq0YXtnZkism01IWPSvu6ayDA4ldzownbb7FLxbfXS5PCTGOniL1lFjIxaSqMTv7qRrOK7UMcgKGDcDCVgruzTdNpaqeOtd7eIJZLGGMxpiuo3eAn/rwYmWF3LnCzAftQrWZejSJQO4CttRCHKxoboP1wSNX8J8EeZD3GWF5CEVbXn+fzw80WHcAwk9p71kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udPa4nMJJYMChtxVi11dleCGQ1FMdvvQoYBsVmKr0sQ=;
 b=Sh7Dgn5u3n5100C9MMhremej5tt/smValhQFGeD8saTbXkksZxSoBSGIHe4jclmrehLLa/rGvkawO5iyEJ1tLSRMmB+EDmoqjnlwdT0TGBh3v+AjouA/iDguN1vdvOSt1ieBvBMrPckCuFx9KpfQEYrXHTlNUbMJf3uEjVLVuSYxFLx2NPRBM1fy8/MJIrgXUISOOXO0gZGco+PFcrdPUp8mwm6VjHUH2/G706SfnaOnVq/gvXsxss2Nf4a8mkc8zZouxAb0BoASVzPI6ovdqTqTilkRXsb8Ru4xeb1q9h2wOSGzZKuY1f50cui3W6oYARvlFvfqUKQ0AjvmK9eZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udPa4nMJJYMChtxVi11dleCGQ1FMdvvQoYBsVmKr0sQ=;
 b=hw20Vu9P/3TktwjEeu3li/Qo+cbT2280st1M6BbtnBXIndpTsjBQzJAj+Qlf19ZOqVxO1AXQ+NP8hG3Z7e+aj51RqQs4aZ/xi4kM3WGMrw0czHs8lLrphbUN7oxI9vZdCFHm/4MRUJkmDr2nRuhm33r+BrQ7hZjehcTbZuxjyBs=
Received: from VI1PR0502MB3888.eurprd05.prod.outlook.com (52.134.6.21) by
 VI1PR0502MB3839.eurprd05.prod.outlook.com (52.134.6.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 16:20:38 +0000
Received: from VI1PR0502MB3888.eurprd05.prod.outlook.com
 ([fe80::9daa:2732:c24b:482c]) by VI1PR0502MB3888.eurprd05.prod.outlook.com
 ([fe80::9daa:2732:c24b:482c%7]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 16:20:38 +0000
From:   Tamir Ronen <tamirr@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "ewg@lists.openfabrics.org" <ewg@lists.openfabrics.org>
Subject: [ANNOUNCE] ibsim 0.9 release
Thread-Topic: [ANNOUNCE] ibsim 0.9 release
Thread-Index: AdXihyssewF2470vTFKzsqPqmzHnUA==
Date:   Thu, 13 Feb 2020 16:20:38 +0000
Message-ID: <VI1PR0502MB38882E575220E8D7B9D5DFF2B41A0@VI1PR0502MB3888.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tamirr@mellanox.com; 
x-originating-ip: [2a00:a040:199:924c:3c6f:d156:ddf9:7e0c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87a7f187-f117-4013-2380-08d7b0a0a9ba
x-ms-traffictypediagnostic: VI1PR0502MB3839:
x-microsoft-antispam-prvs: <VI1PR0502MB38396C3F3424315326444B18B41A0@VI1PR0502MB3839.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(199004)(189003)(2906002)(9686003)(64756008)(76116006)(66556008)(66946007)(966005)(66446008)(66476007)(478600001)(55016002)(110136005)(6506007)(316002)(81166006)(52536014)(186003)(5660300002)(33656002)(81156014)(71200400001)(8936002)(8676002)(7696005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3839;H:VI1PR0502MB3888.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Dbb7zTA2kNcnbWbYxTb5Y1QYJ8CdhXdPdJaFKgo8o5pxbAy+RH9uAUkSKxqLNou1Rzeb9tAj4/AeIthzKLN5dRymN82M9Qqk4tANgHfDUE/dqAzg9XKDvW3aYAKhai/Z58/792kvZrbYIfyGkqH1oakTEQXaEK+ZXTS9K1zETvhu0VXz5NqXOQOZgRqAPd/XKLZtQ2/qE6rQZOVEBY27bY1vkZbHWzdCo/nkq/v18Xuzvgqme4eFpJ5niR2LXVAD48/UUOBBOobVYC/Stfqrq18S3xdyBLVMA68TrJaH/Pb9PHRvhPVvibiEStG0aJLfONZqYqdTRfKJ9HqtLqAQ2SI8o7UgfPocNtYDccLJ+KYLHvTQIQGbmMjaAx/Mmft5lhQyoBqG5tiedbBN35FzJiR8hgrKH/tidBzRJGP3F3oc6W7OnLZC4nMVkoLVmcLtN6IyqBgT3kE7Ds6SE+xAvO/bCXIQSreKeCqmnaFw9qHfbCzM4lp4Wu+N82XJW6nI4Bndy4xriV3zoQ7iVt7Lw==
x-ms-exchange-antispam-messagedata: Gn9FpnrQVBKn37AvnUQD+C/YVMgawkAHHTA1SytTnoBrIiAbtPYiMcM45smr0tfngT3L6YPKtKMkcBo0IzfoXp9egUu4cVKEkQ+06aJVg8KcrCh4Vwa1eppD9qzOPWjJ6DzvCCE7HN0KlO2TJ2hEerFcTg5qJZIH6fh75sYTG6VrhsmgyKfHafKlURXyPW5VCaYsJPpltdQCqKQwuNCYig==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a7f187-f117-4013-2380-08d7b0a0a9ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 16:20:38.3469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIzKROkQVSxCDesXbZmGbtbTh8kNokkcvpaXZZW4nPobURPxsi6FzmauO7D1jHoMGFlq6rYRwZYxZEde/YWL5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3839
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a new 0.9 release of ibsim.

https://github.com/linux-rdma/ibsim/releases/tag/ibsim-0.9

New features since 0.8:
Add --no-console option
Support GID/subnet prefix field in the PortInfo attribute

All component versions are from recent master branch. Full list of
changes is below.

Nicolas Morey-Chaisemartin (18):
      umad2sim: Do not use umad.h deprecated functions
      Use NULL instread of 0 in all places where it used as a pointer
      Cleanup extern declarations
      Add missing static keywords
      Add travis validation
      travis: add patch check
      tests: Do not use umad.h deprecated functions
      .gitignore: Add tests binaries
      tests: Use NULL instread of 0 in all places where it used as a pointe=
r
      tests: make function declaration ANSI
      tests: Fix signed vs unsigned comparisons
      tests/subnet_discover.c: Fix stack overflow
      tests/mcast_storm.c: Make sure dbg macro is never empty
      Makefile: Add tests to all targets
      scripts/travis-build: Keep last build so we can run tests
      ibsim.c: Add --no-console option
      scripts: Add travis-runtest script to run tests
      travis: Enable running tests during travis build

Hal Rosenstock (3):
      ibsim.spec.in: Updated for move to github
      ibsim.spec.in: Revert previous commit to Move 'COPYING' file into the=
 license tag
      README: Update maintainer

Honggang Li (3):
      ibsim.spec.in: Move 'COPYING' file into the license tag
      Fix multiple definition of `simverb'
      Replace UMAD_DEV_DIR with string "/dev/infiniband"

Cyrille Verrier (1):
      Makefile: Exclude tests folder from install target

Leon Romanovsky (1):
      Merge pull request #11 from Honggang-LI/gcc-10

Tamir Ronen (1):
      ibsim/ibsim.c: Bump version to 0.9

Vladimir Koushnir (1):
      Support GID/subnet prefix field in the PortInfo attribute
