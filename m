Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F6CB826C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404646AbfISU07 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 16:26:59 -0400
Received: from mail-eopbgr710068.outbound.protection.outlook.com ([40.107.71.68]:21083
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404644AbfISU07 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Sep 2019 16:26:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+sDCIWeJ/pNGgjrOddLbQLPPu3bWYUOIvBo0swwj+eVHjEApPkkC0nwPQOwiaZOc0wrTL8bqm5YVh1rTYDFd/uhoKuEZODNP+LyX2+xaMYvxVJLeqVbA7hJ9wKrUJYqdifZYj8VVumsUzG+e90/7KBgpzhlSfhmwHLc7ZFT+8ydg5LWVLtEO1iS6joS8sHdR1t/RfA0+wDK7zMNEKmYPFrjYGXlNdG1Yi+t7vH2iNNZgZXf/SiHHJejP/27zAd1eBk5HMCC9pfexHcXkG96TLS9JJ9pODVYyqt94lKfpZzt1+TWB98cMXmTiF5ccMjDtrEELYURM1T0mRpHWLnllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhT6Bf07NwsSGjZVFnYTKVuZHKcu8RtwWRV7nU7dsxo=;
 b=Up4Ofv0Rbksbd1LH0Tvr5z8mEpnJUas+LWzuXzv1Aem21y9FZUphKBx/7KTBV5H4ZhJGGQRB3ZKy4A+HfszrxDtA114J1T7HVZuqtlR8tI44c5VDCH7VKzrXRYVzOX2WabZInEKULr4TKdt88XFoou8GghLWbQ/tj4jNm8HE72Tk8SfRpBHweZjPoSN5sOh2WQCSozS3kJsjPmExgcSXS86yVjwP4g1vKTWtpYQVd+uY285cFOzZAJibw6HyWh/vCXiE12AjrhJ+5N/7TPgB8L0AoRsVqVowJjDHRcxv5UNrn7w3wOhaZCaA2IOpEacmb7sVCPG1QUmGwfNrScY74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhT6Bf07NwsSGjZVFnYTKVuZHKcu8RtwWRV7nU7dsxo=;
 b=0bdCxNXRWEKnSqCl8rYqE2RdcjM84E2ss9/wm2jQ/VBYkfvETzKkfIbcW5pEK1hYWaoWfEkcZKkFisa9eSkjHeJaqNKKecRLGAT3BETaZVHi5WLZjS15tH9Jp2fxCWMoXhDQ1TyAWy+JmTWpLWcMXeCkkQ8FSi5q3AxoAd1qE+A=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB4005.namprd05.prod.outlook.com (52.135.197.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.5; Thu, 19 Sep 2019 20:26:51 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03%5]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 20:26:51 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Adit Ranadive <aditr@vmware.com>
Subject: [PATCH rdma-core v1 0/2] vmw_pvrdma: Use physical resource ids from
 device
Thread-Topic: [PATCH rdma-core v1 0/2] vmw_pvrdma: Use physical resource ids
 from device
Thread-Index: AQHVbyiSaZw6/FhF8UaHZH++A73A4g==
Date:   Thu, 19 Sep 2019 20:26:51 +0000
Message-ID: <cover.1568923914.git.aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 1.8.3.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b277e687-402f-4a1d-dc96-08d73d3fb46c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4005;
x-ms-traffictypediagnostic: BYAPR05MB4005:|BYAPR05MB4005:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB400525AB895E94F180BB3CC9C5890@BYAPR05MB4005.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(54534003)(6512007)(52116002)(107886003)(2501003)(25786009)(71200400001)(256004)(14444005)(316002)(6116002)(110136005)(2906002)(3846002)(71190400001)(2201001)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(50226002)(6306002)(305945005)(7736002)(4744005)(4326008)(81166006)(8676002)(81156014)(4720700003)(36756003)(99286004)(6486002)(8936002)(66066001)(6436002)(5660300002)(476003)(26005)(2616005)(966005)(186003)(102836004)(14454004)(386003)(6506007)(486006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4005;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AlAcCSZtnc5qX58DqajyWRQclsrbGOKp9gRbzrmX/qiHw0MhRhGX7ZNxg7YFPNk1gQpDQMk59TwjkSc14PEhn6P6nsJAqeZUaJWut7utsvsFq3HM4rWXJ9ZV6y5qJPEop6s3TL07JQKDEinROVoeATWdFuEH3i+Dfw+g9a80ohmUb/F2AcvyZhmNK9SNRWrTlK620ahCB0gj7IS5wU1R9JfXL0VssImcSeK2LgsDjecLcelADDlRB5jgV3rIH5Q+NnGcFWxMBlPBjFY3gJBu9z5B/5CR9SxcX5/YQhYOVoJRuacaEPNe4T7v6sIOMU2i7oMVRgYnvNOuKNB3hbkIr5soRUrRuXf6rU3EG8XBZTchR8s9tjPQhQjaprTn4JsJpNxdwKSLHYVXWpdmGmUUWD1QP5/1HZHF5I2Bqv2/Gy0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b277e687-402f-4a1d-dc96-08d73d3fb46c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 20:26:51.7490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8LYu7aoTKFiolK7o7e5Jsi/S0GUUBYDSzXYh0h/oqDvoxzh/FAyhKPUn4+2hTTopIekhqEx2MLyhT6Dxgx3q6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4005
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changelog:
v1:
 - Added a separate patch for the kernel header
 - Dropped the ABI version check
 - Added a create qp flag and an in-band check to indicate support
v0:
 - https://patchwork.kernel.org/patch/10946987/

Hi,

Here is a patchset for enabling exposing physical resource ids for vmw_pvrd=
ma
userspace provider.

rdma-core PR:
 - https://github.com/linux-rdma/rdma-core/pull/581=20

Thanks,
Adit

Adit Ranadive (1):
  vmw_pvrdma: Update kernel header for QP handle/num

Bryan Tan (1):
  vmw_pvrdma: Use resource ids from physical device if available

 kernel-headers/rdma/vmw_pvrdma-abi.h | 13 +++++++++++++
 providers/vmw_pvrdma/pvrdma-abi.h    |  2 +-
 providers/vmw_pvrdma/pvrdma.h        |  1 +
 providers/vmw_pvrdma/qp.c            | 24 +++++++++++++-----------
 4 files changed, 28 insertions(+), 12 deletions(-)

--=20
1.8.3.1

