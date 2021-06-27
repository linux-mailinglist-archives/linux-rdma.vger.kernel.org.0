Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81153B538F
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jun 2021 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhF0OAF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Jun 2021 10:00:05 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:52768
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229820AbhF0OAE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Jun 2021 10:00:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0LU8TPmb+hsqic8maEHmBr3GL5Xcx2ItgYCVkvoUgsLPdftbRMHy+xt9imD/4+rru4hR2RbnV3xN+4ybkcjuP0zQYElhl34QITj49Aca3SUtIotsco+6072p8l4kAzYsQYerCgxFwJjuASjM3y7/av6BwTCHaNXBHL81Gp1JsarXujT64LZzznIjrJj2jNqyTVq8MgutWJVD54VrA8EShh49RPUTIawp7FHAHQpgRcOCxzW/OR0tT8wsRNKjFegAWhmq2XCVpMS7Qt0sPexNj9XnPO0KNWGZvrUkBw5kmXyhZTW5iet84Q0MPXf8jrHS1lGiPPAb2OuKcxZOaiV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjZOMPqMu7f7vsgffh9IdebVY3rqpnxmJ4CTZwiJlVQ=;
 b=noym6Qss9zfdAJtOywKB5uPv5ePGYPnopLXhTVpN1mcaD9fwrtJ9d6aMZdRdbOg31YZlHYm+k+4Xrpqh1ZVSRwjfc7uRnjcPsGI5YFw5PuWgveyLdjZBUIUGZ8q5ks6rdaVYSGCDUDq9smg3ybaCZ8aHqYg1x1jKXikoGWbpB/o0PRhSiCpKb3cQbYfBzkzN2+6E0nfNLkhU3QiAfrB7cCfDh+c2p4yyA+BsBgfgKl3gtzt8M5msLmGj9dYn+or8CkGWmFXmWkoW4USUGfTj6J7ASI2rZYgJdEk0HXUmzZarqyNNaOxkbLPnkk8+HychENPfhv+xMcBwB9u0KbtJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjZOMPqMu7f7vsgffh9IdebVY3rqpnxmJ4CTZwiJlVQ=;
 b=BSq/h21Mz5ADUXf3b5RM2c5cqJIEh6ECL2KFjNCqKp3hzccyar0baWlhP6LQEqHBf+YG3FIV/IPDaaxvi4Mhw0DttlHh15xJNyX80bgxHcTOKnS/QzKVWXMVDcni85aSbIPbZpFV6pfcXtwcAzuzFAGFMqZ7vR6OMgFuWe/gONLr8MKrU74SFgvXJyu+beCcvTs6tW6b16uowJ0Zt4wKUqYjU0FLj1+dFpTGpzeWYvfuazIl6bhdsjKMp75GhmPjmrQ5cQvchQMXqU8baC00Tasq4hlAyXwm6/gv3U8LvSeDW+CYJAU/2aDr7WZJec0DOdnLNcSmT8GEWR5WBGhIYw==
Received: from PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 by PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Sun, 27 Jun
 2021 13:57:39 +0000
Received: from PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::69d2:50d:3dae:77d2]) by PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::69d2:50d:3dae:77d2%8]) with mapi id 15.20.4264.026; Sun, 27 Jun 2021
 13:57:39 +0000
From:   Tamir Ronen <tamirr@nvidia.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [ANNOUNCE] ibsim 0.11 release
Thread-Topic: [ANNOUNCE] ibsim 0.11 release
Thread-Index: AddrXFazyd+O/SBBQjSxNyrBgCmJ9Q==
Date:   Sun, 27 Jun 2021 13:57:39 +0000
Message-ID: <PH0PR12MB5402470A310ECC82496F4A8FB9049@PH0PR12MB5402.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [2a00:a040:199:82fb:64a3:35c4:319b:b80a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 168f5ca4-ec44-4633-813b-08d93973870d
x-ms-traffictypediagnostic: PH0PR12MB5451:
x-microsoft-antispam-prvs: <PH0PR12MB5451F18CB4B6FD06D5A24501B9049@PH0PR12MB5451.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tPfd7X/7xK8FxsLK5H4GmEiweXx1cXfShf3HSM3phw+7XS7Zi5O37Lesvgr69TWRdyx3MluYesofyKAop4z8AAiQLCepQrVg6iccyjpG1uXBW2eg63auBI47LZVGSitURm4D7llUtUfN7EjwUdjQpppUG6SqVyRl1DI79FuFQsBEdgPjkRtJx7coiqYigoM4NVa63B+w1z+joOtuklwDjLi7GjCbXoU0+0WUdhg69C1sofB6ajeAcAuRLPgPKaGx3MZFn0avh7mInqA8iRGjYWUxM17P7GnL0IWJaYyLt30/YViNbezZ5igb+jViIYHYeqDrK9AcKJYcWyrZGsvUny+HRpz4exfkL1eVcKRen5eL9E1ur7K2vklQ+Rka771jnEPW09Vcus69yOidqFCBqmr7vCTkHCXwI/CMLKHOZZr1XT1Ysl8zYi2Qibmd9mTvaGHLlERP5hpK4ugq/elk5/25AH6/q1YAM5HKtNQWRTsyVHoMee3TgEz/hev9qcipsgNd7xBzfPb2kRv+tavnRozNhLtuZx2BKwv3egiGgkG2eFLRSAr/XgBcniqorYrpHi4yB22CDgXcldf7NHacZOdQ78hGgZ2TFssDnMMwDad2zn5+pfG3Ji/x6IT5ShkTPcfOR3cEItUeYzJ6q163pG1AcqWB/2rplrlYq/AZqUfdJ6vzPjBc3YqrhrH4x48GoYyxgQTKE2FuDO4A44XLF9V3iC25E27IxuFFt+2NJ15FqcIwpk6KS40dtwaxZ5u9uHpg0fTqLcTyRfkA+5KnVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5402.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(83380400001)(66476007)(66556008)(5660300002)(76116006)(71200400001)(122000001)(38100700002)(52536014)(66946007)(64756008)(66446008)(86362001)(2906002)(33656002)(7696005)(6506007)(316002)(8676002)(55016002)(966005)(9686003)(478600001)(186003)(6916009)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eGPtOoSxdVLDiboHe1OtxTATj4yp1gqsOj/O2kAQ8cgBYbu6alQKAgwNQN5M?=
 =?us-ascii?Q?eHr/1MCsggH32Nn9fBzz467jIoD1UYV/j2m0a2+QAJ4MlipwAe7BZNxDMu8U?=
 =?us-ascii?Q?JQ5BhaOfY4Q8ZUkMj9KSUkwAhh61zdUXX1hv2nZxkrRqnWl6dhvHqx4589Oh?=
 =?us-ascii?Q?6sBW/EH5JMIeDWYaIdH53wM2rMBdqBbtJ3kj/8WJ2GsobY8BBGiQ58wm9TAv?=
 =?us-ascii?Q?ykKah54OIQMxqN4g0fdBnL4g8/4zluc0XswLYWE4w+gY5grOkC3al5uEXI04?=
 =?us-ascii?Q?MB5qSGtT1t6GXh0SX01BVsLb1cZ0u4cV6xyUA5k7pifUK5VFqJEyRLjjM8kn?=
 =?us-ascii?Q?qLh5IKPNTVlGVyeFv6bQtk0w8QYPtVNYmGm0C1pZYqdRKcEo1dF7tRHVDRV7?=
 =?us-ascii?Q?Pjr8jtWXnDAWf6EIkzMOzDsCn3j3Z/3Os6N5Uhq09h3kfmsY/fnXwfAm28Qj?=
 =?us-ascii?Q?L0rGKxF9q6s+MveTS0hfgCCpp1FRXPap4m6PyOR60SOYek20jH4N9awVULA1?=
 =?us-ascii?Q?myUyUH6wSGjCaAazRSStCKdejY3t0QmkOC5gJUxmBb3m1mz3ohw7Y31aC6bZ?=
 =?us-ascii?Q?ol0sTxkFPmj3TTeApwZWzL+gCmUcPohDDpmn7Bs2TCrt0ONl0NQpK1YVJYwC?=
 =?us-ascii?Q?Rv1ZAMnTs+ItigZknDEK7LqerQ1q1Y6XM869RO82MaIaGBxsjsHza7sEMPBG?=
 =?us-ascii?Q?wlYERXZ85opiKryHoXU6zTSSzJCPY7itNaFSLWAMGojV2LlMkJpGG1mpOFP0?=
 =?us-ascii?Q?vmH1mDSYSHGmazEOiG/0Sh+/6kRfYaT4FfOAWBkTISqgU/tQswpFjYByOh2R?=
 =?us-ascii?Q?HM7Nj336ukKhduqneyTqigAbHRJgK+HqIy5bBzclmWw5K7EnWuxvIpAPSTlH?=
 =?us-ascii?Q?rBNhatI0JCyB8+Q8VhqvIVKXkdhV3HIH1yhBFlw44goSFoAXRG7eR0ToC6Ri?=
 =?us-ascii?Q?KAsK+LQkG8UM9mXP5yQat+U6EPV/fZ4eLpKWDXyT5QWysfJSt6t4oX2bAXvr?=
 =?us-ascii?Q?ZufAbqnkgOG/bJsbV0IqVrPif+i089FWMRSUkfLRluZIq78IjqVafUr1Yq26?=
 =?us-ascii?Q?ccaEi/fRDjJia+LddrpSlBuyry1JXZCeu/z5jgTOZHvlVuIfx10p3dY0mchB?=
 =?us-ascii?Q?4FOedjjhlfvljiZoMuBNo4dMmc8yj0fYFbeLvS5jEpExpspcN+PotGoaPBvX?=
 =?us-ascii?Q?f4gRvz5Glsev5aSZR/JixE8rT+nI2epILREgEmFkSAn+XrtdXdPmtdK5rRYK?=
 =?us-ascii?Q?AQlM/y0PHOreHCrj3K91vlHIIK3ZqczmOuldcy3BBPKDX/vDyaywb7dOT3rg?=
 =?us-ascii?Q?IusHkvCVzLNUqH5uMTP69FZQ4PKdD2rIiQfTttAf4Tsq07MCqdIQfsSM4pKg?=
 =?us-ascii?Q?kf16Y4CKTfFFh56FKY1GXRCYr9jS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5402.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168f5ca4-ec44-4633-813b-08d93973870d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2021 13:57:39.8073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qba2JttaRBN+/pDO9zE10csi8oSk3ZPQO6Mlq6bM9V42pHPx5yh+meOz+f3r+DNJaV7jzD27uZdVWFnTDI3mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a new 0.11 release of ibsim.

https://github.com/linux-rdma/ibsim/releases/tag/ibsim-0.11

New features since 0.10:
Add support for NDR link speed

All component versions are from recent master branch. Full list of changes =
is below.

Tzafrir Cohen (8):
      typo: scrips
      clean all bins, not just progs (including tests)
      dist.sh: Add ibsim-run.in and spec.in to dist files
      make distcheck: Check that dist tarball builds
      dist.sh: update version in debian/changelog as well
      spec: add ibsim-run to list of files
      make distcheck: use latest dist tarball
      make distcheck: delete checkdir when done

tamirronen (5):
      Merge pull request #28 from tzafrir-mellanox/distcheck
      Merge pull request #27 from vladko1974/compilation_fix
      Merge pull request #29 from tzafrir-mellanox/spec-ibsim-run
      Merge pull request #31 from gregoryl-mlnx/ndr
      Merge pull request #32 from haimbo/disable_IsVendorClassSupported

Leon Romanovsky (2):
      Merge pull request #26 from tzafrir-mellanox/ibsim_run_clean_fix
      Merge pull request #30 from tzafrir-mellanox/del_checkdir

Daniel Klein (1):
      ibsim/sim_net.c: Remove IsVendorClassSupported capability bit from HC=
As

Gregory Linschitz (1):
      ibsim:Initial NDR support

Tamir Ronen (1):
      ibsim/ibsim.c: Bump version to 0.11

Vladimir Koushnir (1):
      ibsim.c: Fix compilation warning
