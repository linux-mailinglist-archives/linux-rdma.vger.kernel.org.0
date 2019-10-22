Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4381E0D01
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbfJVUGA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 16:06:00 -0400
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:10926
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733005AbfJVUF7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 16:05:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM5GF5EbjkkAOkxuo3tp49FdLWb3BY+4ANGs51bpASvQjoV2CaMITjTq7ytnLcOLOgODnMDvfHG0Z+ywrf/4tQiovHIZErxo2xXePZCQExZy6TKNLYTLdMK0l8Q6O68jI8KIK6RuKoRwx2gnBva4ZhOJZArEfdvf7i4HZEVvxLJGXSPD/axV+Xc3N8v56e34hFEKq6pHolPlyBWrpy+BTu3eYnQ5PNKXxwPVtVywHW2hqiiCZuPcTPQYAxyhnVKaV82HtfZz6I8M3rVYo7Sm1qyUQYwKser/EzZ6cyUlQ1KcGiqNtJjWeU7utcr9zZoBoMhINIZJl090JePZKlzqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63LCgOirOwLCQAYQuEc5nAE2y+XVC7CsUoHUrqTVn7M=;
 b=LHdKOCS6QLDXtoSzoRm0nALSmlCXlK+pFk5VZhn9MebbrN2couM/bs2OJ24dPzFTuGHymMdhp5v6IBPgYBGTwRGBFbnxn4b4Dna7g+7QsAbNAWqinrQDZhPAfLpo5+2qeiHCm3F5PRFBZa9RLRIAgx46WWEs52CF3I/syrCEWytqtKmSweWD7EDNFpt0S796715Ir83+f1F+afrw4NuZtRTBjkBomD8Gdk5fy3NaQC7VOn+pZnCPzna1suM2zQH4aBYup17E+4yn9A3cdLsfZbVtUENiTQ9j8XFRZYFY+IhFcWDsaVN63R+dGiEU/+o260B5wpsAvY77RkeGSE++qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63LCgOirOwLCQAYQuEc5nAE2y+XVC7CsUoHUrqTVn7M=;
 b=w6TmVzDMOikMAVVoBHSiQVUa0VrHsx5fnz4wuS2jffPKcsXvaJLSabIGIQIfAlrEgW3bdZpKcCeZ0f4dImPSvseKTcye7RxDh4q+hquAAqka3E4E/q7OTYh+wrqAqZNbbg8Z4jf2JOrTwqShVY5sdJELCkls4mKIJrxh6WNzkSw=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB5173.namprd05.prod.outlook.com (20.177.229.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.14; Tue, 22 Oct 2019 20:05:57 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345%7]) with mapi id 15.20.2387.016; Tue, 22 Oct 2019
 20:05:57 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Adit Ranadive <aditr@vmware.com>
Subject: [PATCH rdma-core v3 2/3] kernel-headers: Remove cxgb3-abi.h
Thread-Topic: [PATCH rdma-core v3 2/3] kernel-headers: Remove cxgb3-abi.h
Thread-Index: AQHViRQd3oZInVL2Jk+oou7mWT8orQ==
Date:   Tue, 22 Oct 2019 20:05:56 +0000
Message-ID: <1dbb166d74d71f5968ae695c42d96d6acfefe3f3.1571774292.git.aditr@vmware.com>
References: <cover.1571774291.git.aditr@vmware.com>
In-Reply-To: <cover.1571774291.git.aditr@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
x-mailer: git-send-email 2.18.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ac500b8-490d-4aec-50b7-08d7572b3fe4
x-ms-traffictypediagnostic: BYAPR05MB5173:|BYAPR05MB5173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB517385A53001DA6A075DF33AC5680@BYAPR05MB5173.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(199004)(189003)(71200400001)(110136005)(26005)(4744005)(6116002)(7736002)(66066001)(6512007)(2501003)(71190400001)(52116002)(2906002)(102836004)(99286004)(6506007)(305945005)(76176011)(386003)(3846002)(6486002)(186003)(5660300002)(486006)(6436002)(476003)(2616005)(11346002)(446003)(14444005)(8676002)(66446008)(64756008)(66556008)(66476007)(66946007)(4326008)(81166006)(81156014)(8936002)(50226002)(316002)(256004)(36756003)(86362001)(25786009)(2201001)(118296001)(478600001)(107886003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5173;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rl01qBLXuSta4/K6eZwRu6L0KQ/TIKWbVXNXh5VdWMhjJQqiXLtmmuTt/GI1IpqeFmGk/sPa9D09Jxz2YEVcqUIrcrgzQdQAJqWIssmhvlVnQHzeC67E/OBhXWZkqgLCj/H261mNGD8b1GTNqyu4KfD1fLyyJ3JHyQMmDSMx8cpoXsanb/p+FB5iegv8BiXFxrRZ4YRwuF6UwYcSlgcdJ+o/x+XeQT7+AOXX/q08okoXcZeBsn7OuZx1mjFTM90uTR8jP4y1IMnoedknV4FNMEicquispzmXJ65NcAK2fNsVXCg5rQrmV4WtN27QTvnng3I4zX/ItAfvsuNHUEc5bNcAHx35yJVxHS840G9T/wp+iiJV0n94AqSyMkJkJZa6EpJ/HhByKmvw7bI7XVEK5moUUvucaejGbg0IHJhDb0C5J3SILtKXf4fQEbiOwYMh
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac500b8-490d-4aec-50b7-08d7572b3fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 20:05:57.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBpIe0Ai/x2JT1t+uixfTCAFigcLlSe2guEurerO4DBpLxbFjlFhzY17UQ7GszmHsfMGwZFmLIiOhuV9pyRAsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5173
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Driver is removed from kernel. Also, update cmake to not build library.

Signed-off-by: Adit Ranadive <aditr@vmware.com>
---
 CMakeLists.txt                | 1 -
 kernel-headers/CMakeLists.txt | 1 -
 2 files changed, 2 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index fc17ef36cf24..cdc8d5444e70 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -616,7 +616,6 @@ add_subdirectory(librdmacm/man)
 # Providers
 if (HAVE_COHERENT_DMA)
 add_subdirectory(providers/bnxt_re)
-add_subdirectory(providers/cxgb3) # NO SPARSE
 add_subdirectory(providers/cxgb4) # NO SPARSE
 add_subdirectory(providers/efa)
 add_subdirectory(providers/efa/man)
diff --git a/kernel-headers/CMakeLists.txt b/kernel-headers/CMakeLists.txt
index 543e0ea1408a..c4464c579320 100644
--- a/kernel-headers/CMakeLists.txt
+++ b/kernel-headers/CMakeLists.txt
@@ -59,7 +59,6 @@ endfunction()
 # Transform the kernel ABIs used by the providers
 rdma_kernel_provider_abi(
   rdma/bnxt_re-abi.h
-  rdma/cxgb3-abi.h
   rdma/cxgb4-abi.h
   rdma/efa-abi.h
   rdma/hns-abi.h
--=20
2.18.1

