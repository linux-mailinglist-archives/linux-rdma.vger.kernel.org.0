Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83FA7DA5B1
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2019 08:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390987AbfJQGlT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Oct 2019 02:41:19 -0400
Received: from mail-eopbgr730066.outbound.protection.outlook.com ([40.107.73.66]:5152
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbfJQGlT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Oct 2019 02:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUFU/zexuLX2R4y/jtk5kDfjqag288viUEjRsBsjs7V1qKmWrDQLnW3I2Jga7zGP/rrPVOQNB1xnVVCki2/aZoQYOemB+GyDTlLSBJYHYYnMvTqmheF5TpkG+8J3qcuiXgfy0x7FXjbYimgM0nXbtAqeNWpWDgsvfTFPk1Nqp8rzzGBKNfy1aa+zg7MRBmOvghqQuG7pcLYlY+8mfdoEIYBGYjSeXX4Z+Z5hxDNEhWZBsU0kzIaGYNGmUyMSsiWafy1oluqVqOIanYw6Ai3xB443Hjs35i5ElLL+h1UGJsgJ+Ld7lWojtllJiTuEuNXNcDH9Nl88mltjBxpi6xi1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxZdcKiowJsWI5xngoz8NsFuGwZVgrRySMcDq+MXszQ=;
 b=iL8MQ4HMyFmU8MhPj5NOP36homvNfeRNt9NiCkh5mEQFYcRlqPA3+ozkybsRJQ8apmYVd22IEzN1ntzdka3fJVlWm598lY94L6xqyN68cWCYuIC2vpXdF9Gl7mM/EggKHFq8vZwPK2bbbe5k89WtuxwU8syr8FqEX85DL+FuU2qIwoPX8QL4pMQq9Vz2pd11g5J4pg8hcpfkOHcBRTn68kBsQN+MjzbgJQ0qSeVzTsSdS/V4dDlX3Owlg/g8SzgsYL1SdkOyjczfsW1mfGNU7lVvSKczjVHVnJZkbsymaEIdjsRz771qjhuwHBlR2fuL/IdN4HR5V288xDQImLMeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxZdcKiowJsWI5xngoz8NsFuGwZVgrRySMcDq+MXszQ=;
 b=f+IfG4z9/oEAncstzeNsL7T+iPH85jqXxlEuxbaERRcvlbzg4KuCkzb88Jw4yz41gZNatn+VEu6y+wuuMjkKfaxl01I1TzYeX+TaWaDnuJv/ZCGSTwsKaEJb5Eb7IAkHbrVqt+kizdkeKFNWTFToLKaxUkiQAEWPWq0733//jTU=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB3974.namprd05.prod.outlook.com (52.135.197.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14; Thu, 17 Oct 2019 06:41:16 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::c992:3ec7:35ca:d345%7]) with mapi id 15.20.2367.014; Thu, 17 Oct 2019
 06:41:16 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>
Subject: Re: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
Thread-Topic: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
Thread-Index: AQHVet83k8TiyL5bNkG9ufrN+Z5Sr6deAKeA
Date:   Thu, 17 Oct 2019 06:41:16 +0000
Message-ID: <D4D8B4CD-CDA7-4587-BA10-E41A2DE89978@vmware.com>
References: <20190930074252.20133-1-bharat@chelsio.com>
 <20191004181154.GA20868@ziepe.ca>
In-Reply-To: <20191004181154.GA20868@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-originating-ip: [24.6.219.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7afaeb8e-bf92-46fd-f9f3-08d752cd02c5
x-ms-traffictypediagnostic: BYAPR05MB3974:
x-microsoft-antispam-prvs: <BYAPR05MB397403233D3B8A817D016CF9C56D0@BYAPR05MB3974.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(199004)(189003)(64756008)(66446008)(305945005)(6246003)(66476007)(229853002)(76116006)(66556008)(66066001)(316002)(7736002)(6512007)(4326008)(6486002)(3846002)(6116002)(25786009)(91956017)(66946007)(2616005)(2906002)(36756003)(6436002)(86362001)(5660300002)(256004)(446003)(14454004)(4744005)(476003)(76176011)(71200400001)(71190400001)(6506007)(102836004)(26005)(53546011)(11346002)(186003)(478600001)(33656002)(8936002)(81156014)(8676002)(110136005)(54906003)(81166006)(14444005)(486006)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3974;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gcKS9i0PjeKN6lH6+GbubsD/uqUzLB4UuFXy3iXmeGh1HnBqPlzZVAyoCj0uyWB/QUgNrnKjWJFcB6qdX2wtdJzmnrMop2sbzC7HFxunnKtL6WPQITqbIM8FHY1RfpgjMqIknU+q5FrpENVMLfLT1SQsXME2BQtx9c92bUHX5JqS9VzC6rpt/pu/ZsTczE/gM7IasEgZzBjBTC4ce1IFFzKlwVB0jZp7DA+bPchX5tFXYhnjZhhSAWUQCKMqP5A+wxveZ43bdvwLQjPJrMmcrUwSEnGHhTEYODPPHQu11lyUQoguSkLOfVMSO1ctseE54TgUiZ3E0z7X52ZwRE9RclKUqignfCPqa6Fu6BaRAIgXAGgUh7TdXgvWfkO9MCFFTke7LFo6VD5RgU83cK5Ep67QOGvZq6zXE0yqr/GXqss=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C83D42A5928EF44B93D0B82E146D685F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afaeb8e-bf92-46fd-f9f3-08d752cd02c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 06:41:16.2867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZuDf0rvgmRIEVG7euOiaK8GnSTpIauyOdZd+dqpR0Lm628xG7fU0ZLHOT35LEVej5nWbLLrwkLn/QtmxtEqZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3974
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTAvNC8xOSwgMTE6MTIgQU0sICJKYXNvbiBHdW50aG9ycGUiIDxqZ2dAemllcGUuY2E+IHdy
b3RlOg0KPiANCj4gT24gTW9uLCBTZXAgMzAsIDIwMTkgYXQgMDE6MTI6NTJQTSArMDUzMCwgUG90
bnVyaSBCaGFyYXQgVGVqYSB3cm90ZToNCj4gPiByZW1vdmUgaXdfY3hnYjMgbW9kdWxlIGZyb20g
a2VybmVsIGFzIHRoZSBjb3JyZXNwb25kaW5nIEhXIENoZWxzaW8gVDMgaGFzDQo+ID4gcmVhY2hl
ZCBFT0wuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUG90bnVyaSBCaGFyYXQgVGVqYSA8Ymhh
cmF0QGNoZWxzaW8uY29tPg0KPiANCj4gQXBwbGllZCB0byBmb3ItbmV4dA0KPiANCj4gUGxlYXNl
IGFsc28gc2VuZCBhIFBSIHRvIGRlbGV0ZSBjeGdiMyBmcm9tIHJkbWEtY29yZQ0KPiANCg0KSXMg
Q2hlbHNpbyBnb2luZyB0byBzZW5kIGEgUFIgZm9yIHRoZSBkZWxldGlvbj8gSXQgbG9va3MgbGlr
ZSBvdGhlcndpc2UNCnJkbWEtY29yZSBpcyBicm9rZW4gZm9yIG90aGVyIHByb3ZpZGVycyB3aGVu
IHJ1bm5pbmcgd2l0aCB0aGUgZm9yLW5leHQgYnJhbmNoLg0KDQpBbHNvLCBpdCBsb29rcyBsaWtl
IHRoZSBrZXJuZWwtaGVhZGVycy91cGRhdGUgc2NyaXB0IGluIHJkbWEtY29yZSBuZWVkcyB0byBi
ZQ0KdXBkYXRlZCB0byByZW1vdmUgYSBoZWFkZXIgaWYgcmVxdWlyZWQgZnJvbSB0aGUgcmRtYV9r
ZXJuZWxfcHJvdmlkZXJfYWJpDQpzZWN0aW9uLiBPciBpcyB0aGF0IGV4cGVjdGVkIHRvIGJlIG1h
bnVhbD8NCg0K
