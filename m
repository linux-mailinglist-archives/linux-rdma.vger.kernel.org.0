Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0DC95F54
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 15:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfHTNAu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 09:00:50 -0400
Received: from mail-eopbgr30043.outbound.protection.outlook.com ([40.107.3.43]:14451
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbfHTNAu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 09:00:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th6Rf1irq3rE5bCs2Xz4axK+i+6bnE1CtXGfoDZWxuAKur4U4j3rIt8m+jyH+pKHcvW6plMSXlgeQuINnNLPg9a8HBhDDcQP2KjerQOkaZ8QwSQkKbVZkbv4qk4dfCKCCVRudNWF20qvyyRwjZsEEELz3qEIzi7UO1OV807P6GqAWn3iq60UTCn4CJS49EfWkq4aRzFrsafv1En8ELA6xInpeemuYiNG8PBk20F3hS3ZgKsC3/76IkzHWLeShpMhr35YubosyrzCl64mYt60h27Qc3ujdoj8tUFJ9HmDtjAAC94M1dm0Y6sZ9d485jsfEcdRR+y1KWwk0W/IzSFe8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW+/FjHMZi/M5mf1Ux4a5BqsyIm/G45Gx3mvCnxdaOw=;
 b=Fcg5Gpe18japJ/zBiDUoR2ZKCevepo9ONYd2WnFceFBUmu+5KPy+ZUCobfsl3WMJcK6SSq2bTf5ek6BWzxlmctawreoZnGlDpRu+JizarDHhruQG2pB1YyzTRoEB5D2t7Gr0BXFvGlr+YE2pM8DqGEXzeySH+b7osi2pm9L23z/1P4e0TGpsSqcn6QGZRDLMcrBEO1gWkFxBhUyQy7hpX7ghtPoFPK1o+meyRlVCOo15HuHLVxtS2mtVVWWygCDvUF+xxbqfPAb+BHf8uTEBN96WKDHqrElx4AK0FxTNgO3Bf1O0EHjQ5ENfEA+BFE9ry77JjDV/5q9ar0kpMH0j1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW+/FjHMZi/M5mf1Ux4a5BqsyIm/G45Gx3mvCnxdaOw=;
 b=k6ErY0lKtssunmqRD6dPlpOF1zCHjJmS09XVn7av6UME+phE6D9Faplp2MR8oKc1mH7CPe0W3dLQ+y0PGGRVQ/ItgUiVrn40Hrtt1ICf7SJF7+vMJM/zG2E79EmVCaeLXxcfw1ZIfhMhm2g3g68nCGF7B/RX/opCVVqB4dlwbKE=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB4456.eurprd05.prod.outlook.com (52.135.162.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 13:00:47 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::c14e:4a4a:7bf5:3e2d]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::c14e:4a4a:7bf5:3e2d%7]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 13:00:47 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Topic: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Index: AQHVVluKi/1wMEsI4UWSJliEROGNkacCfWOAgAGEcwA=
Date:   Tue, 20 Aug 2019 13:00:47 +0000
Message-ID: <2ac30209-2c89-15ef-3907-98d3cd552f4d@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
 <20190819065827.26921-4-noaos@mellanox.com>
 <20190819135019.GF5080@mellanox.com>
In-Reply-To: <20190819135019.GF5080@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0115.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::31) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fee0cbf3-b12d-44cc-3df7-08d7256e6b1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB4456;
x-ms-traffictypediagnostic: AM6PR05MB4456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB445659CC9CD275936DA38D13D9AB0@AM6PR05MB4456.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(14454004)(229853002)(6862004)(7736002)(305945005)(558084003)(6116002)(6486002)(6636002)(36756003)(86362001)(31696002)(6246003)(6512007)(2616005)(486006)(11346002)(5660300002)(6506007)(386003)(71200400001)(71190400001)(53546011)(476003)(6436002)(256004)(26005)(81166006)(81156014)(8936002)(186003)(446003)(4326008)(25786009)(31686004)(478600001)(37006003)(54906003)(99286004)(52116002)(102836004)(76176011)(2906002)(66066001)(8676002)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(53936002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4456;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KPRqUtuQIeEtG6HVMwvouQPECNThzqat2eiMsg+GB1l2eQNqpMa4l752XNoCGuLPnnEUvJ5dX6PaXSv2yj/4uAM78oX8ClrDmyDOhJ3t+DoKlvwysnfpK6U44KCIdbFzIfC3huuZnGkhlVdJz7kyKC1qae9wEMMEfOK77mVVRU3bBrAkJL1P+4DDhkZrlrGh0zTxjIKPTAa7em+Do400BJW9mPNMbItfNgFt/lhdin4UgHO1JXfsNPQEAzc7mhIuXB8ehPc2CWdG2ifN2aD2q6L7nHIVmgOCjjgVl5JAk4jSy/4IPmVhkTWT71/8RkCI/xseW0vpBiGZr7eqZrZhxKf1V6JNtW4I8BdDmteJGjav1ZAn7IN0elifjw2/u1WNUhRNy25zait59SbE/P7eG/FcdsCqwnsPPFSYEKoCaaI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C31B5492523E34384074F7792BFB185@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee0cbf3-b12d-44cc-3df7-08d7256e6b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 13:00:47.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyiCU2nXxrYvTL11+fiwzilbm3udyFC0MoUTtB8I7nL8k8KVTPfj2sPPJskWIngRzajR5VJ+FBhslNFdPfa0NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4456
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gOC8xOS8yMDE5IDQ6NTAgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCg0KPiBJJ2QgcHJl
ZmVyIHJ1bl90ZXN0cyB0byBiZSBpbiB0aGUgdGVzdHMgZGlyZWN0b3J5Li4NCj4NCj4gSmFzb24N
Cg0KUFIgd2FzIHVwZGF0ZWQNCg0KVGhhbmtzLA0KTm9hDQoNCg==
