Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B12E8D7D32
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2019 19:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfJORQq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Oct 2019 13:16:46 -0400
Received: from mail-eopbgr820043.outbound.protection.outlook.com ([40.107.82.43]:39568
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbfJORQp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Oct 2019 13:16:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGAl/ZxwZLiWurOfmCvSO7eYyazCAB23QxSfWIlD8CUECmNCxdewqKEII2HqsmNzDQVjfzT3buu3wYhLStrUxwsbvTdLWCJqDzEooIt/gMSB2lmkZaYktSlswEyvBDuOZAjWnOo2v4+sxULqDZxAW8qX0KUdTDWd5sJqNs9if/37pX0cEloZC6MbNNuPLJTMa4sq7W6gQGTYb2Ph/9UvpTf/+tPOPqRcN3vMp5EIMFe6jAIZGZh6m8LIemnxDvoEcEE6y78Gudw66UDSMyPgjYsYCYbMeumGqJ4moysZ1uzW7/u7TeS9AujUCn3b1vq4apKnvKynjwHXXE1UHIS/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tloNoNzBXTvx7gk5p1RrNSdktX0NpOYJZTOOc1KmifY=;
 b=Fgy2xlsH2hdz9CwrbGull1CIQHK3679leDe3Z88254F7DhBE4CaO4NDXa+umJtWhdNMUJOO54Lj81TI5pJYDCobxPHJR+OfqlmrcVq872j1wOtDcIuNJdiAXCgGdI06xat78gUMpuORGueK3wGs4igb7I68ET4vWnHLEFShMkkJ8V69uPJM9x2zavHln3vag0LdWarRUN/KPRV09TSvUwGS/4qb5IzDr/t2uA1R5ICfR8BkjH1Z8nsB2+vAr3D0QBpgQPAvDbJ39E/va2ctRvkKUTJaawUi+Mr8oA9PFrLdnqTpPSzUU1WfS3oPfuhO8USJoUe5EORQvFiXTq5ahww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tloNoNzBXTvx7gk5p1RrNSdktX0NpOYJZTOOc1KmifY=;
 b=T9/IcnA8YJHoPp38rprMQKSXmT9C7gY2HktgiT37aqG6zWqrnQ8J34v5TThZMQtDyGhcTvOYOVor/8dBoO8QQf/MF5bRknXpKcU/uAMPQXZrVYXlVCwG9VnFZRgH1Exvyj+kI3jT7tT4/z66/WKqZv9y/VGJBHs5UVKuJlYBW4M=
Received: from BL0PR05MB5505.namprd05.prod.outlook.com (10.167.235.222) by
 BL0PR05MB6738.namprd05.prod.outlook.com (10.167.234.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.15; Tue, 15 Oct 2019 17:16:41 +0000
Received: from BL0PR05MB5505.namprd05.prod.outlook.com
 ([fe80::30b6:4137:a371:2151]) by BL0PR05MB5505.namprd05.prod.outlook.com
 ([fe80::30b6:4137:a371:2151%3]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 17:16:41 +0000
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
Thread-Index: AQHVbyhNYSy/DHAt80igdHIsy3KW2qdRKnwAgAUYRQCABdSggIAAAuGA
Date:   Tue, 15 Oct 2019 17:16:41 +0000
Message-ID: <2c8753e6-7fbd-84ce-4268-b88de4f5068a@vmware.com>
References: <1568924678-16356-1-git-send-email-aditr@vmware.com>
 <20191008181544.GA2880@ziepe.ca>
 <8F02F753-B71A-4F73-83D8-D6224D6C4F6B@vmware.com>
 <20191015170613.GC5444@ziepe.ca>
In-Reply-To: <20191015170613.GC5444@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::38) To BL0PR05MB5505.namprd05.prod.outlook.com
 (2603:10b6:208:6a::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25c374cd-0605-4be9-4d47-08d7519371cd
x-ms-traffictypediagnostic: BL0PR05MB6738:|BL0PR05MB6738:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR05MB673893F8040C82630BDEB787C5930@BL0PR05MB6738.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(199004)(189003)(52116002)(3846002)(53546011)(81166006)(6116002)(81156014)(8676002)(99286004)(478600001)(7736002)(486006)(476003)(26005)(186003)(102836004)(316002)(14454004)(31686004)(305945005)(4326008)(2616005)(11346002)(8936002)(386003)(6506007)(6512007)(446003)(31696002)(76176011)(36756003)(66556008)(66476007)(66946007)(66446008)(14444005)(86362001)(229853002)(25786009)(64756008)(4744005)(6916009)(54906003)(6486002)(6246003)(71190400001)(71200400001)(107886003)(5660300002)(66066001)(6436002)(2906002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB6738;H:BL0PR05MB5505.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KaOMk4QImbUEc9A93G+DM9l4NJFAZVqWNhtJmBGJCEVErThUCz1KRmfe5wQdXJlVtph9ID6md1i8apxllRX5oHXvwbRtEUXGvWQvkO5287cMaaVE9nsBez0KAowbbvKHA7zfxFxtCdIwczOrvEcHENPcF0wV0nb2EBI+KjT4OFSLVNsTW1ihMogDtCcCh7UoB4Px73EDHszYE7lWmFLUtY8atVBV2+s4CqOecJU7r+ecJSgj6MXU+2jau2t9rIuMu0tzarOezV/nCYYxYgKpN+gFkgi0JJyzKsc6ubdtXCXQ39+u0B2aqrODw1/ytSnZ/+QZn0a+NO06f5D9tdep8IMwH6YxLrixBrPvhyVBuaoz62ArK2JvT1kx6yapWWyPZ/Dp8AqvNdS/+PeIIlyQgTAzmQ+LVYRUJ16Q7Zq6BNs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5524DCF494D726468DDD11F552BC17B7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c374cd-0605-4be9-4d47-08d7519371cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 17:16:41.2923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ga2IdtZLB67AKoH6lSzCvqZEOl2welSEA72I0wvC2KW2yx11AqHORjjF50joMCOEfOp/Ka/8c+PKxyLrGh2GVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB6738
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTAvMTUvMTkgMTA6MDYgQU0sICJKYXNvbiBHdW50aG9ycGUiIDxqZ2dAemllcGUuY2E+IHdy
b3RlOg0KPiBPbiBTYXQsIE9jdCAxMiwgMjAxOSBhdCAwNzowMzo1NUFNICswMDAwLCBBZGl0IFJh
bmFkaXZlIHdyb3RlOg0KPj4gT24gMTAvOC8xOSwgMTE6MTUgQU0sICJKYXNvbiBHdW50aG9ycGUi
IDxqZ2dAemllcGUuY2E+IHdyb3RlOg0KPj4+DQo+Pj4gT24gVGh1LCBTZXAgMTksIDIwMTkgYXQg
MDg6MjQ6NTZQTSArMDAwMCwgQWRpdCBSYW5hZGl2ZSB3cm90ZToNCj4+Pg0KPj4+PiAgDQo+Pj4+
ICsJaWYgKCFxcC0+aXNfa2VybmVsKSB7DQo+Pj4+ICsJCWlmICh1Y21kLmZsYWdzID09IFBWUkRN
QV9VU0VSX1FQX0NSRUFURV9VU0VfUkVTUCkgew0KPj4+DQo+Pj4gV2h5IGRvZXMgdGhpcyBmbGFn
IGV4aXN0PyBEb24ndCBvbGQgdXNlcnNwYWNlcyBwYXNzIGluIGEgMCBsZW5ndGg/DQo+Pj4gSnVz
dCB1c2UgdGhlIGxlbmd0aCB0byBzaWduYWwgbmV3IHVzZXJzcGFjZT8NCj4+DQo+PiBJIGRpZCBo
YXZlIHRoYXQgaW4gYW4gZWFybGllciB2ZXJzaW9uIGJ1dCB3ZSBkZWNpZGVkIGl0IHRvIG1ha2Ug
aXQgbW9yZQ0KPj4gZXhwbGljaXQuIEl0IHdvdWxkIGJlIGVhc2llciB0byBhZGQgYW5vdGhlciBm
bGFnIGxhdGVyIG9uIGlmIHJlcXVpcmVkDQo+PiB0aGFuIHRvIGNoZWNrIHRoZSBsZW5ndGggKHdo
aWNoIG1pZ2h0IGJlIHNhbWUpLg0KPiANCj4gWW91IHNob3VsZCBhZGQgYSBmbGFnIGlmIGVpdGhl
ciB0aGUgbGVuZ3RoIG9yIGRldGVjdGluZyB2YWx1ZSA9PSAwIGlzDQo+IG5vdCBzdWZmaWNpZW50
IHRvIGRldGVjdCB0aGUgbmV3IHN1cHBvcnQuIE5vIHJlYXNvbiB0byBhZGQgdGhpbmdzDQo+IHVu
dGlsIHRoaXMgc2l0dWF0aW9uIGNvbWVzIHVwDQo+IA0KPiBKYXNvbg0KPiANCg0KSXQgc2VlbWVk
IGEgYml0IGhhY2t5IHRvIG1lIGJ1dCBpZiB0aGF0J3MgYmV0dGVyIGZvciBub3csIHRoZW4gc3Vy
ZS4NCldpbGwgc2VuZCBhIHYyIGZvciBib3RoLg0KDQpUaGFua3MsDQpBZGl0DQo=
