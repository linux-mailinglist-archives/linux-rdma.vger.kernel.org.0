Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09700B826A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 22:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404645AbfISU05 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 16:26:57 -0400
Received: from mail-eopbgr710068.outbound.protection.outlook.com ([40.107.71.68]:21083
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404644AbfISU04 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Sep 2019 16:26:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgiM1B0o433KYUNZX0tYiupuu6cxSSFCuErNNSh94sQV0WXvw/Wl9Om0vC2Faey9I5voBWHiZ2k2IejNhfI92AkGlf+pqvRbBJK5i3BqBZI7OuloNJDJauCNyS/aBVMpYFmHN9jpj9QJ6snUKmkiHe3oQA2S11AX9jc61uqUmQpiWuz4OCck5WfxNWN59AyGfRWXNxibFrDqQHYefJzhIkY/idsgwqP9RvYGQP9PF/UD46HRGAzMVn9EOIQCIgA3mkc72t8HBk7aLagnRdATCqfARsrGO0emzZHeNLLHHt7TfIpm8NxIkzOru2KATck0NRMSTGqh1u7PvQLJZpYTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROwjnEN1XItw9hZG/4bTNVIzdaF1JrNFvHTTWc7O7n4=;
 b=VND9O4D6EWTnCbn/eJ2vnxsOmLSOA63xnVOE74awDokYuF+VvBt+lvGVe07LcA5IxMLcPDC4jrnOCZ7xZCC9y4kcxaTfDnWs5fbBUE29rsxbINW9xxB2Zv/FwGPxqDjSOUqHOVEzsrk0EfpuQ4La2l9zKxSLcf96rdvkAAzsOmvZBNq9yO3kTe0uJAt8qtZYE7Ha03Ui2so4sbCSrFihQonmQdaEjaseihnM3l1nu8aSStc2hDqufqYKSgTBSO1SNg1G9qieGgs1eHtcsexFEmXS5HKdYwoVAyohD/o3Rfem+zRKcTPv26FpUprSRFCm5olOt8ihxRe3+rWsrHnsEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROwjnEN1XItw9hZG/4bTNVIzdaF1JrNFvHTTWc7O7n4=;
 b=F2jsqMrLFv9DhMm5UHR9132et9nGHkQK6rRmlRpTEnxBGDWvHD2teY5cJWC2ZBxdd1+XNQjXOEVLhP0nVXVNbLagrDLXUvA0CkAPt0kZl4X+BoYoCuiSFC49Cnp2f0StvMJdASIuKoeimuAd4s1Xhi+qOODPds4Zgj4FIclTK1I=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB4005.namprd05.prod.outlook.com (52.135.197.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.5; Thu, 19 Sep 2019 20:26:52 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03%5]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 20:26:52 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "jgg@mellanox.com" <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Adit Ranadive <aditr@vmware.com>
Subject: [PATCH rdma-core v1 1/2] vmw_pvrdma: Update kernel header for QP
 handle/num
Thread-Topic: [PATCH rdma-core v1 1/2] vmw_pvrdma: Update kernel header for QP
 handle/num
Thread-Index: AQHVbyiS3xatLwJE5kmx+HdyZAskkw==
Date:   Thu, 19 Sep 2019 20:26:52 +0000
Message-ID: <1f4ae51eb133941303009e1257d4ac1d8aae5dcc.1568923914.git.aditr@vmware.com>
References: <cover.1568923914.git.aditr@vmware.com>
In-Reply-To: <cover.1568923914.git.aditr@vmware.com>
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
x-ms-office365-filtering-correlation-id: ef33023a-cc74-4134-6cc6-08d73d3fb49e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4005;
x-ms-traffictypediagnostic: BYAPR05MB4005:|BYAPR05MB4005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4005E21BBE4BDDB2234D5596C5890@BYAPR05MB4005.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(199004)(189003)(6512007)(52116002)(107886003)(2501003)(25786009)(71200400001)(256004)(316002)(6116002)(110136005)(2906002)(3846002)(71190400001)(2201001)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(50226002)(118296001)(305945005)(7736002)(4326008)(81166006)(8676002)(81156014)(4720700003)(36756003)(99286004)(6486002)(8936002)(66066001)(6436002)(11346002)(446003)(5660300002)(476003)(26005)(2616005)(186003)(102836004)(14454004)(386003)(6506007)(76176011)(486006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4005;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J56Wz+i5ARhJJlw5L77rTTPWw6PE72iOsZlRHRoMp0a8QKANBmPHoSs2eRAhPKIyB1mAGbSmUWkEh5bmtt/KmqMvS5mXWX7+D48dCqLi32uxSiGQgpI67ElOLGtH8Oktxt0eVmI1nLQnYC2OqZnwFYMqIpIAtP80a85QZEvvbN7lwvIR4FdaioNEclAuP/SPLBDBUVAJncLZUaT7F1U2oihl27lOoMcRNYEbFL8DQQ7qG2of4CbfHdJ/EwcoBv2r+W4fSuIMU4ivvHHVExvjmPGlm1kApKhsEh18yO7Cefx4rsQskrTF06+oXbFyHwU9lWKLGZwnvV5L9xu1zLW47nAGkz9CPQB6qxb9eTY0/GlFn7xG/oFAvEzrtCsn3XQRnaKRXg9hAsNa4M+PCpiXoxQVxCtJrMRJX0nbuw79acQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef33023a-cc74-4134-6cc6-08d73d3fb49e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 20:26:52.0718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEPc5yKeOVrznOyHMP94BJ97SDhKJxU3DAtn83P/oBhbB9eoXlhcm2VdCMuCCB8BM5HxSeG/+ARF1YGNMggcAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4005
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support in the kernel header to reflect back different qp
handle and/or qp number to userspace.

Reviewed-by: Bryan Tan <bryantan@vmware.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Adit Ranadive <aditr@vmware.com>
---
 kernel-headers/rdma/vmw_pvrdma-abi.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel-headers/rdma/vmw_pvrdma-abi.h b/kernel-headers/rdma/vmw=
_pvrdma-abi.h
index 6e73f0274e41..1d339285550e 100644
--- a/kernel-headers/rdma/vmw_pvrdma-abi.h
+++ b/kernel-headers/rdma/vmw_pvrdma-abi.h
@@ -133,6 +133,10 @@ enum pvrdma_wc_flags {
 	PVRDMA_WC_FLAGS_MAX		=3D PVRDMA_WC_WITH_NETWORK_HDR_TYPE,
 };
=20
+enum pvrdma_user_qp_create_flags {
+	PVRDMA_USER_QP_CREATE_USE_RESP	=3D 1 << 0,
+};
+
 struct pvrdma_alloc_ucontext_resp {
 	__u32 qp_tab_size;
 	__u32 reserved;
@@ -177,6 +181,15 @@ struct pvrdma_create_qp {
 	__u32 rbuf_size;
 	__u32 sbuf_size;
 	__aligned_u64 qp_addr;
+	__u32 flags;
+	__u32 reserved;
+};
+
+struct pvrdma_create_qp_resp {
+	__u32 qpn;
+	__u32 qp_handle;
+	__u32 qpn_valid;
+	__u32 reserved;
 };
=20
 /* PVRDMA masked atomic compare and swap */
--=20
1.8.3.1

