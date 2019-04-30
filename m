Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B400F1A7
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 09:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfD3HvT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 03:51:19 -0400
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:27108
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbfD3HvT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Apr 2019 03:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI0J3zYsltL8yl7zcLVUxuXUOiUH2dFcmqJK+wYaoWo=;
 b=fto22zzKv08oH0brxls96w/iMP8K6D3a61oWQDzYXUD4kRC5KAzB3QcDnKaQM9/gKygCILA2hmhoEuhRiB5g1UtorfPd1cdelICrrEOmKawhyBRkNTECKvPWOokFRxpa2uXYpP8GbOVGfFlHutnttuyQViD/f4W7NdCxuqBYHaU=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.36.17) by
 AM6PR05MB6165.eurprd05.prod.outlook.com (20.178.94.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 07:51:16 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::acbd:8441:a63a:8463]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::acbd:8441:a63a:8463%3]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 07:51:16 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 0/4] pyverbs: General improvements
Thread-Topic: [PATCH rdma-core 0/4] pyverbs: General improvements
Thread-Index: AQHU/qP1/4fbrnC0l0KMDXDmUXVoD6ZTbhoAgADnlIA=
Date:   Tue, 30 Apr 2019 07:51:16 +0000
Message-ID: <788ae890-7e1b-25da-6ea1-60eabb12eadf@mellanox.com>
References: <20190429155513.30543-1-noaos@mellanox.com>
 <20190429180219.GY6705@mtr-leonro.mtl.com>
In-Reply-To: <20190429180219.GY6705@mtr-leonro.mtl.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::49) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:10::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.29.201.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd1d32a7-3a5d-478b-6035-08d6cd409fd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB6165;
x-ms-traffictypediagnostic: AM6PR05MB6165:
x-microsoft-antispam-prvs: <AM6PR05MB61654BD5E4DAA766CFE8CE30D93A0@AM6PR05MB6165.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:39;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(136003)(346002)(396003)(189003)(199004)(71190400001)(71200400001)(73956011)(4326008)(66946007)(64756008)(66556008)(26005)(11346002)(66446008)(54906003)(66476007)(86362001)(25786009)(186003)(5660300002)(37006003)(256004)(6486002)(97736004)(53936002)(6506007)(305945005)(102836004)(76176011)(558084003)(316002)(7736002)(6246003)(68736007)(53546011)(2906002)(31696002)(386003)(52116002)(81166006)(6862004)(229853002)(81156014)(6436002)(8676002)(99286004)(8936002)(6512007)(478600001)(6636002)(3846002)(6116002)(36756003)(71446004)(446003)(476003)(2616005)(486006)(31686004)(66066001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6165;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xNDz7RiMmMi2yxMD8D8zZWIj3grBEOh0u7+P4yjYClrWl3rnriauw+fxcokDbKY1nU8FfI4j4s/Geg4bfXcF6pLnXScivKq55L29RdRG6UdYiIZZDrq/yUt53kpp5BqXo3wzCiVt4q8DXcrGg3KvEtmRAQua7gX3lXdjyUO9OnpOVBotLSIiSg/EQex6IewPjrUPYvuXncurLUWd9Yr32RgWbh6H2SEY3LczIr1yFsZpjwQ6AMmRg8V1nd2oBw7coVS86mCzyHhup2hX3T/8LmATSwJ6HkIuW8HmOm6TEThdYYZcG7tYwaHQSNtGYp1HTzlj6OaafUEa0ykGbSHDv5PhE8OCXFF3AFjXlmOEEMRbTY1x0eF4IY7pQNKjyckJnE7bwEVc9E4HRs6YaUg2mThlWF+eiK+mzgikvleLiQk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B8025E930E60844B740B9E83B975666@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1d32a7-3a5d-478b-6035-08d6cd409fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 07:51:16.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6165
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gNC8yOS8yMDE5IDk6MDIgUE0sIExlb24gUm9tYW5vdnNreSB3cm90ZToNCg0KPiBOb2EsDQo+
DQo+IFBsZWFzZSByZW1vdmUgQ2hhbmdlLUlEIHRyYXNoIGZyb20geW91ciBjb21taXQgbWVzc2Fn
ZXMgYW5kIHJlZnJhaW4gZnJvbQ0KPiB1c2luZyBwb3dlciBwb2ludCBzdHlsZSBpbiBjb21taXQg
bWVzc2FnZXMuDQo+DQo+IFRoYW5rcw0KDQpQUiB3YXMgdXBkYXRlZCwgdGhhbmtzLg0KDQo=
