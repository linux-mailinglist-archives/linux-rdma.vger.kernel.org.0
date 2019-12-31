Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D862312D74F
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Dec 2019 10:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfLaJTz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Dec 2019 04:19:55 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:29969
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbfLaJTz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Dec 2019 04:19:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnzmvsNkvZzVVlPTAQPH50c0hcaxzlshOVlLkmu4j5zzrM0T8IJNdYoul/PFdK8mqBWspB23B6HDFRqXY2RmWDeY1xnsvwYMlHfHTrxZsI63AKPdHMw+5RbOuxFmNmgQYoHNs2UZSJeav9K9m3GVony3qbhEUp5YLyPMDE7v3jZUjtneRbEkLJnsr3mNxArxll6c97gD+9tXfzHzCvYm+HUlb00+FtCso7YrxM4dOvSkEX0aOwrdMxBbECFvqySt7Fg+jpSZrKvWgI7a1oAil89QoRb4R1d4LJjAFELfiTx60NV3W3nwl6FjaAEan3RyBQoXd6iarO9ypmFt/OzPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYrEbfCn+BPrJhYlC1E5t4mnIjQ2PAqw46AwzZTO0vU=;
 b=RcD1XEojb1dxsEoiePAAkym6daXlB0P3LrRnW7BfcAqoutsBtW9FyK/me0/BTkjL+912GKEcsucLv09dojSRoRRhqT9X0PMdV6DsfBlmpgZ3hLY5/3YivM4hZ2UdswX01j5gwOb9vnlNrdJBWz6uZulEmSkUDlO2quvl9USVDcpuf5Ap+Tp+HfzDhMLHlKoF1pfBrrIwbhZSWL5QCQa/rnmAiZ8flNsyEcR1Huj1S4tp9apjpVHOLiWSYYcQ9isqEgnbYqrfnSgJ38FVAjmKco8m6mdNCSTUBSDI/l+9daiT368aBztXoBRvbtmokG6lpyYD3G/n/faZyWLYOSUMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYrEbfCn+BPrJhYlC1E5t4mnIjQ2PAqw46AwzZTO0vU=;
 b=XR/x/qOu8ULuvz0loEB+AsSmGPSJQF37KYoY6BpnqUjcLP5tYEDMENvZOdLb/MPxbJ5z0aPtY2xBDzjoOEPQmEFXdMduNaIapUxldJIjEfJNrvn8qI/kOvC9X56Mpb72d0z7XJniEGZ/XFrkeQ6xwbkGYXFbGQh0V6kheZhGlb4=
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com (10.175.21.136) by
 VI1PR0502MB3742.eurprd05.prod.outlook.com (52.134.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Tue, 31 Dec 2019 09:19:32 +0000
Received: from VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427]) by VI1PR0502MB3006.eurprd05.prod.outlook.com
 ([fe80::b9ec:a465:4659:7427%5]) with mapi id 15.20.2581.013; Tue, 31 Dec 2019
 09:19:32 +0000
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (94.188.199.18) by AM0PR0102CA0016.eurprd01.prod.exchangelabs.com (2603:10a6:208:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.11 via Frontend Transport; Tue, 31 Dec 2019 09:19:31 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Noa Osherovich <noaos@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: [PATCH rdma-core 5/8] pyverbs: Expose MR's length property
Thread-Topic: [PATCH rdma-core 5/8] pyverbs: Expose MR's length property
Thread-Index: AQHVv7tpCfkwx/JEZUq7n8ueMP93RA==
Date:   Tue, 31 Dec 2019 09:19:31 +0000
Message-ID: <20191231091915.23874-6-noaos@mellanox.com>
References: <20191231091915.23874-1-noaos@mellanox.com>
In-Reply-To: <20191231091915.23874-1-noaos@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: AM0PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::29) To VI1PR0502MB3006.eurprd05.prod.outlook.com
 (2603:10a6:800:b2::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.188.199.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4d315cc-bbe4-4265-1484-08d78dd28b64
x-ms-traffictypediagnostic: VI1PR0502MB3742:|VI1PR0502MB3742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3742C3A571514AE513E10391D9260@VI1PR0502MB3742.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:305;
x-forefront-prvs: 0268246AE7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(1076003)(316002)(107886003)(36756003)(6636002)(2616005)(956004)(110136005)(478600001)(52116002)(71200400001)(66476007)(4326008)(66946007)(81156014)(81166006)(6506007)(64756008)(86362001)(5660300002)(2906002)(8676002)(186003)(66446008)(8936002)(6486002)(66556008)(16526019)(4744005)(26005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3742;H:VI1PR0502MB3006.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7aPFGZh5df0XC6wKXbRteqCDnjj7ZXqM3ad6NH94RtHn86ZhdQXDxThWRVVzVwets952/1qWIdwHNKjarrguhbmzwK2MYFEtOj9GnyGhwowdjqsexKV3xkNG1xrVVD4+tPCMxFYIplaAxynr0oqmrNEWJu/JQnSeU4+ORVclVIe7LZkF2pYHLiXMDIVoCMV1vgdttjNoQmA8/CxWL6L87nnIeMNcN6R/bb9SobaNISM1tCV2CCYnK1khSotahMhD8KURg/KTRXfYJzqV0c+my3udv7d34NB7WugUKzSpBCtUw1zu03Rfc7uexld/dX3usK9xfDtNu5S743giVemcreEzrHu1vs5zpmB4xvUNBOUVNHp+u6hcK1/xeLnt1D7FHkcgakLPwF+C47tSEPF08CpfPpXgqgcI4H+cYxtBpoR3W9NJMwyX5GP11WN/0FRJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d315cc-bbe4-4265-1484-08d78dd28b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2019 09:19:32.0243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hKcp6S7ExL4HqVTSaNOdawb6xAiBVKv8E3th9RNHwFhW4jrLQbCtdUEZoS6XC94/qu/MaIHVkxz4CjXEAAzIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3742
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

MR's length is needed for testing purposes.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Reviewed-by: Edward Srouji <edwards@mellanox.com>
---
 pyverbs/mr.pyx | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/pyverbs/mr.pyx b/pyverbs/mr.pyx
index 9b1277f0882f..234e864209a2 100644
--- a/pyverbs/mr.pyx
+++ b/pyverbs/mr.pyx
@@ -116,6 +116,10 @@ cdef class MR(PyverbsCM):
     def rkey(self):
         return self.mr.rkey
=20
+    @property
+    def length(self):
+        return self.mr.length
+
=20
 cdef class MWBindInfo(PyverbsCM):
     def __init__(self, MR mr not None, addr, length, mw_access_flags):
--=20
2.21.0

