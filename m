Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83A4BBF0F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 01:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391213AbfIWXta (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 19:49:30 -0400
Received: from mail-eopbgr820057.outbound.protection.outlook.com ([40.107.82.57]:44032
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729276AbfIWXta (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Sep 2019 19:49:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+VAA2Rkv44GZEDZ+wPJVZozfKJz+EnaiW4+q5fiDFcbbmC0mA11P+4QsNEQ1pDm2kKXTjFmZCmxCIAiUH3l+GI6RzCze99UgjLbFwsfzxdXXxQ0TTQ7Kyu3gBGRCqwEeLLIxKJ+/lTSfOfUAoPgsNK6e3CTqSXT1pLqikuvl++ciaKcehWsty6ZLjbWrnFYEEk6pMkxSX/46TUaHjd4ziIXGQiEuUXsvvc2XhWIVQlPZbbMgLzQ4iAF0aTuQ9zHPiNuxC+ToHk3rmutlCJXAOl6Bn58g5MF1op8CYphii3+0JFkvid2TrV0WVbfkP6m/Q4MVKWZYuz0ufWnCujHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG4oMcpBwSA2Fwx0Za8p3eMcP+cDPuce6TInDvtgE5k=;
 b=kqudZNqxTR6aGtReYlq3ONf8fT6kad71EFIWalQFNRnqdt2VjdbHJ3CUsPH6+uWGzMrKx3g6pX+Js/FstuXHPG4oKzXJPTk5Wb/HwyVDO9KlI1l2t1RVob1ZLIbYn/7DgwepOD3c8fqKvdJrYiPNyVFEqFK5rV1NrSadyi3dIKHADCZ5aJ4q53ix3h4ssxPvPHdCySvWIo+g0V2+TmWsXAo0N2EhD8Yh5e9tyNndIEUKgar4T2ggjWhZ9LXjzACZhfwZWHZRwnTB6oiQhMTc/Jgq+vzhGaHAmLRz5DSuAbaKYb9HKQu1p2acucTFi2BFmmbBjUMPwUS0gsr85d5SxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gG4oMcpBwSA2Fwx0Za8p3eMcP+cDPuce6TInDvtgE5k=;
 b=sMhtguAhpVrhRofuTiTz+nGDPdKelSUnmeIA6z8vILWW2kqTBHPoR+Emk9sV3+uDOPUsZuOks8tZVKfNGESg1jhPEhELj0zoXB7iW01CBMI7cQgjhyEqFhjbEsypII+MTQKPqEEvr43Xi2YhbX9imFq3ZN8RQGjPo3AmFkUpEpE=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB6680.namprd05.prod.outlook.com (20.178.235.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Mon, 23 Sep 2019 23:49:28 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03%5]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 23:49:28 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Adit Ranadive <aditr@vmware.com>
Subject: [PATCH rdma-core v2 0/2] vmw_pvrdma: Use physical resource ids from
 device
Thread-Topic: [PATCH rdma-core v2 0/2] vmw_pvrdma: Use physical resource ids
 from device
Thread-Index: AQHVcmmJyt9qRfc6yEudk4RWBK361g==
Date:   Mon, 23 Sep 2019 23:49:28 +0000
Message-ID: <cover.1569282124.git.aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::46) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 2.18.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3c07b7e-11a5-4e4c-0b49-08d74080abe0
x-ms-traffictypediagnostic: BYAPR05MB6680:|BYAPR05MB6680:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB66805D324DCBFD814141376CC5850@BYAPR05MB6680.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(54534003)(189003)(199004)(99286004)(2906002)(2501003)(14454004)(6116002)(14444005)(256004)(5660300002)(26005)(3846002)(186003)(6506007)(386003)(102836004)(71200400001)(71190400001)(52116002)(36756003)(966005)(7736002)(478600001)(86362001)(81156014)(6306002)(81166006)(50226002)(4326008)(476003)(486006)(6436002)(6512007)(6486002)(2616005)(316002)(8676002)(66066001)(66476007)(66446008)(64756008)(66946007)(66556008)(110136005)(25786009)(2201001)(107886003)(4744005)(305945005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6680;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZPVLdB2ktHAj3JuK8zOV96Dcuboeu8Ld1h5Ux6EFsI8m7MewbB/eU1PZLliNcjZmtLKKuzsz5Vz6DCNdYcNW1ePlm+jk76EOZo8J+79WKUw/SFJWlLM99/R8X8unN7SWySrrqZnx1pUpQ1Vw/Sodk8q/Nbz3MAmJwKuoOxaRWvJB1W2sWNU2EcOq+nIXsluSCLKitCLDrtsBRFnOmTkmA+T69tBVeoMbZoLWsHIogtKgKKJpmUUrG1dGieMFW5p5ZN9m9vj5UMFF6MYtlmFjKyqDgsBptaEYmn+baY03MgIkfo0XRSoAtOALQ8X0hAUhP7zy6LKM11w/fuMdo7/sdbhw+wdUrJUOd44sCUZsXOD3h9rb343QaMCZrLLatEO1QJnSw7o4iiDHUdK04Zu5EI2CFxIP6AePXaSO+hjX3xs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c07b7e-11a5-4e4c-0b49-08d74080abe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 23:49:28.2191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enoa1pxxFIJXDL5CC4acwidizLmWCef73fGupJdrZyOEmdtiBaaudu7un7GwePkVN7GAxxzcvG1IUDnwB0D7lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6680
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changelog:
v2:
 - Used kernel-headers/update script to generate headers commit
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
 - https://github.com/linux-rdma/rdma-core/pull/581

Thanks,
Adit

Adit Ranadive (1):
  Update kernel headers

Bryan Tan (1):
  vmw_pvrdma: Use resource ids from physical device if available

 kernel-headers/CMakeLists.txt        |  1 +
 kernel-headers/rdma/rvt-abi.h        | 66 ++++++++++++++++++++++++++++
 kernel-headers/rdma/vmw_pvrdma-abi.h | 13 ++++++
 providers/vmw_pvrdma/pvrdma-abi.h    |  2 +-
 providers/vmw_pvrdma/pvrdma.h        |  1 +
 providers/vmw_pvrdma/qp.c            | 24 +++++-----
 6 files changed, 95 insertions(+), 12 deletions(-)
 create mode 100644 kernel-headers/rdma/rvt-abi.h

--=20
2.18.1

