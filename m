Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE46D4DD5
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Oct 2019 09:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfJLHEA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Oct 2019 03:04:00 -0400
Received: from mail-eopbgr740057.outbound.protection.outlook.com ([40.107.74.57]:62173
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbfJLHEA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 12 Oct 2019 03:04:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8nn314BT/rvX7fORSSJp6yzyZ7KHgon/sPEKFxiOsAZ2LQbhLa/JVseyR+L+kQ9YYTbCzIwKRQ6c7dpYYqPjYqAgA8L91tm1t4PCd55mM96KtIzi4iqe8MYXvPyi5vdVdBLwM7MgXHNkwj/NbTFO/kWH958TQBrZk4kOnF+9PTMFTbgFKCfr0qkI4Fx0pjqK5sI0nHHEZje02yQ8pahMgZvXDTlAmv4vGbf1tR0VrfUENgA+TWQjQsoU51T1PrlrnskVioZKo0872A9hkmxhFAsUVA9SIsyZSZyi49m3Ep8FbTyMgFYhxgkPchEpTQMWEUIoI5z4IxQRCbJ40Qf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JviqO0HAGom6y4SIEdWLwbh4VbgSjgYhQY96kjYWpzQ=;
 b=LrlUwiTS6CZhjNzHmxRFLt0rxzLY9j8GWkRw+fyQL4o4jOsYw4KQ8z7XeqJwLrvvMNnqMABbMIO5oornZ1MWXXnSuK21UsGj8q+B0XhYwaZ4Malh4E9XoyqqxNFvlQs2Mw215Ws8glwoxCTQs1e9M0WtTU+isF0PZUJ0cSs3k8d7Pxvs1AFOMmG8seL3JwQNhDP+qxV9K0TWFdLqp1Ye7b/qGIyOD8nTwnzITbAVWAMr+8lH/iDFgtbxLQjDy1GnXkTosricU9uhfx5ymvaxtR5e5sTBBK7zmbyhB2V8vKF/KTHwNLXvLd1SFJNHQhfxz3G8JHR3hIQgZuNJZwXchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JviqO0HAGom6y4SIEdWLwbh4VbgSjgYhQY96kjYWpzQ=;
 b=zcTnw49mA3fO80SMGHZfrDrXdNFacjuIt96/Y1OMiREgW3mNbEdxgjLK+ob5IKgE53TjWJZaZTjgwp3StY15dqKQ/ScqBNncl7kVC35M/xPzgaM1hlnMMraIE0vUVA1OG1XGfY5SIdLU6jgdP7hhwypdHTiKjILRpW7yolIBPas=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB4758.namprd05.prod.outlook.com (52.135.232.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Sat, 12 Oct 2019 07:03:56 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::81ed:73c3:bc95:7d03%5]) with mapi id 15.20.2347.021; Sat, 12 Oct 2019
 07:03:56 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH for-next v1] RDMA/vmw_pvrdma: Use resource ids from
 physical device if available
Thread-Topic: [PATCH for-next v1] RDMA/vmw_pvrdma: Use resource ids from
 physical device if available
Thread-Index: AQHVbyhNYSy/DHAt80igdHIsy3KW2qdRKnwAgAUYRQA=
Date:   Sat, 12 Oct 2019 07:03:55 +0000
Message-ID: <8F02F753-B71A-4F73-83D8-D6224D6C4F6B@vmware.com>
References: <1568924678-16356-1-git-send-email-aditr@vmware.com>
 <20191008181544.GA2880@ziepe.ca>
In-Reply-To: <20191008181544.GA2880@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-originating-ip: [24.6.219.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3745249b-a699-4004-9d96-08d74ee25957
x-ms-traffictypediagnostic: BYAPR05MB4758:|BYAPR05MB4758:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4758F177B47C7C776744350CC5960@BYAPR05MB4758.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0188D66E61
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(186003)(99286004)(33656002)(4744005)(54906003)(6512007)(26005)(7736002)(8936002)(25786009)(6486002)(229853002)(6506007)(53546011)(2906002)(76176011)(6436002)(102836004)(305945005)(11346002)(256004)(8676002)(14444005)(446003)(6916009)(36756003)(4326008)(107886003)(478600001)(81156014)(81166006)(86362001)(2616005)(66556008)(64756008)(66446008)(66066001)(76116006)(316002)(66946007)(66476007)(476003)(14454004)(5660300002)(486006)(6116002)(3846002)(6246003)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4758;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7CjZ0TB1MU1/Tgco820EZHWRIWsvKaN4O6nqbAZjPD/V0vmEfNZqtifRzL+2sg2Bb8eW1gl4tCx3sLmBXIpbTV1Gib/aTTl8zxHGoVQML4urckrXvZCkKZSZxOdRI6j2sMaiBWHVz4/vii7PGUb2+7Tteuvbj5iOYLyID3bXxkyYZk/6RgfRt9KpNQz5WyoZVNjmLBQAbnfv6HzqqYFQrj+EMQI6lSc2NhWQumsoFZIP6DC2jBOt2vh6wUSoQZ0/SPWtQVhHr1RYoYVKPhMDjObvqg/+itu9HMu1Bj+QNOQgcu1xUnl623tqpiK+4lJp3JHnjt6Ho0J/nXRapDQ2eMDlGMrkDlZWnCeDMdxuYK3nS6ZMZAaxGFQSIBX+L6MiCA5JwWb6ZR6TeEi65T6p8+RuzqyYUWjZKSj0b+/f3A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E063ABB69376648B68318A3D45FC8C4@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3745249b-a699-4004-9d96-08d74ee25957
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2019 07:03:56.1665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ikR34E9btoeucq48QFb4SBQa20gIt3gTHTC906LfeZLWBCCSJPjbT2i4N3w+Dy3JeFUUcRkMmsivP9ajbNDt7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4758
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTAvOC8xOSwgMTE6MTUgQU0sICJKYXNvbiBHdW50aG9ycGUiIDxqZ2dAemllcGUuY2E+IHdy
b3RlOg0KPiANCj4gT24gVGh1LCBTZXAgMTksIDIwMTkgYXQgMDg6MjQ6NTZQTSArMDAwMCwgQWRp
dCBSYW5hZGl2ZSB3cm90ZToNCj4gDQo+ID4gIA0KPiA+ICsJaWYgKCFxcC0+aXNfa2VybmVsKSB7
DQo+ID4gKwkJaWYgKHVjbWQuZmxhZ3MgPT0gUFZSRE1BX1VTRVJfUVBfQ1JFQVRFX1VTRV9SRVNQ
KSB7DQo+IA0KPiBXaHkgZG9lcyB0aGlzIGZsYWcgZXhpc3Q/IERvbid0IG9sZCB1c2Vyc3BhY2Vz
IHBhc3MgaW4gYSAwIGxlbmd0aD8NCj4gSnVzdCB1c2UgdGhlIGxlbmd0aCB0byBzaWduYWwgbmV3
IHVzZXJzcGFjZT8NCg0KSSBkaWQgaGF2ZSB0aGF0IGluIGFuIGVhcmxpZXIgdmVyc2lvbiBidXQg
d2UgZGVjaWRlZCBpdCB0byBtYWtlIGl0IG1vcmUNCmV4cGxpY2l0LiBJdCB3b3VsZCBiZSBlYXNp
ZXIgdG8gYWRkIGFub3RoZXIgZmxhZyBsYXRlciBvbiBpZiByZXF1aXJlZA0KdGhhbiB0byBjaGVj
ayB0aGUgbGVuZ3RoICh3aGljaCBtaWdodCBiZSBzYW1lKS4NCg0KPiANCj4gPiArCQkJcXBfcmVz
cC5xcG4gPSBxcC0+aWJxcC5xcF9udW07DQo+ID4gKwkJCXFwX3Jlc3AucXBfaGFuZGxlID0gcXAt
PnFwX2hhbmRsZTsNCj4gPiArCQkJcXBfcmVzcC5xcG5fdmFsaWQgPSBQVlJETUFfVVNFUl9RUF9D
UkVBVEVfVVNFX1JFU1A7DQo+ID4gKw0KPiA+ICsJCQlpZiAoaWJfY29weV90b191ZGF0YSh1ZGF0
YSwgJnFwX3Jlc3AsDQo+ID4gKwkJCQkJICAgICBzaXplb2YocXBfcmVzcCkpKSB7DQo+IA0KPiBU
aGlzIHNob3VsZCBsaW1pdCB0aGUgY29weSBzaXplIHRvIHRoZSBsZW5ndGggb2YgdGhlIHVzZXIg
YnVmZmVyDQoNClByb2JhYmx5IHNob3VsZCBiZSBtaW4oc2l6ZW9mKHFwX3Jlc3ApLCB1ZGF0YS0+
b3V0bGVuKT8NCg0K
