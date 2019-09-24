Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA09BC448
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 10:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfIXIuF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 04:50:05 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:4389 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIXIuF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Sep 2019 04:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1569315004; x=1600851004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zmbCWZ7mkSoGQgXIsEiCBKmVFdjFZZW38kLydlm/p2I=;
  b=qJocJzinVk92xNRttqjje7MbwBoccD4UpyHUhenAmlL+q0RbLvCsOizM
   ZczNzM+INwgCO/c470SbvXbb66XwB6Tc3k38y9tp7BqiVpyxTOMLHufog
   FvdWzMLi3bvdGAkGh0IqwXSKkHFo7CJGOxX0pmARLYDT5srvJRNc9lex4
   4=;
X-IronPort-AV: E=Sophos;i="5.64,543,1559520000"; 
   d="scan'208";a="423182441"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 24 Sep 2019 08:50:02 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 14AECA07B1;
        Tue, 24 Sep 2019 08:50:00 +0000 (UTC)
Received: from EX13D13EUB002.ant.amazon.com (10.43.166.205) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 24 Sep 2019 08:50:00 +0000
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13D13EUB002.ant.amazon.com (10.43.166.205) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 24 Sep 2019 08:49:59 +0000
Received: from EX13D19EUB003.ant.amazon.com ([10.43.166.69]) by
 EX13D19EUB003.ant.amazon.com ([10.43.166.69]) with mapi id 15.00.1367.000;
 Tue, 24 Sep 2019 08:49:59 +0000
From:   "Pressman, Gal" <galpress@amazon.com>
To:     Michal Kalderon <mkalderon@marvell.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Thread-Topic: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Thread-Index: AQHVY9F112/Hqya3nkOS7EjBcc9JJaczX0oAgAF87QCABDy/gIABiXyA
Date:   Tue, 24 Sep 2019 08:49:59 +0000
Message-ID: <4A66AD43-246B-4256-BA99-B61D3F1D05A8@amazon.com>
References: <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-ID: <55A9282DB2AEE945AB09EE217879123A@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IE9uIDIzIFNlcCAyMDE5LCBhdCAxODoyMiwgTWljaGFsIEthbGRlcm9uIDxta2FsZGVyb25A
bWFydmVsbC5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+PiANCj4+IEZyb206IGxpbnV4LXJkbWEt
b3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1yZG1hLQ0KPj4gb3duZXJAdmdlci5rZXJuZWwu
b3JnPiBPbiBCZWhhbGYgT2YgR2FsIFByZXNzbWFuDQo+PiANCj4+PiBPbiAxOS8wOS8yMDE5IDIw
OjU1LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4gSHVoLiBJZiB5b3UgcmVjYWxsIHdlIGRp
ZCBhbGwgdGhpcyB3b3JrIHdpdGggdGhlIFhBIGFuZCB0aGUgZnJlZQ0KPj4+IGNhbGxiYWNrIGJl
Y2F1c2UgeW91IHNhaWQgcWVkciB3YXMgbW1hcGluZyBCQVIgcGFnZXMgdGhhdCBoYWQgc29tZSBI
Vw0KPj4+IGxpZmV0aW1lIGFzc29jaWF0ZWQgd2l0aCB0aGVtLCBhbmQgdGhlIEhXIHJlc291cmNl
IHdhcyBub3QgdG8gYmUNCj4+PiByZWFsbG9jYXRlZCB1bnRpbCBhbGwgdXNlcnMgd2VyZSBnb25l
Lg0KPj4+IA0KPj4+IEkgdGhpbmsgaXQgd291bGQgYmUgYSBiZXR0ZXIgZXhhbXBsZSBvZiB0aGlz
IEFQSSBpZiB5b3UgcHVsbGVkIHRoZQ0KPj4+IA0KPj4+ICAgIGRldi0+b3BzLT5yZG1hX3JlbW92
ZV91c2VyKGRldi0+cmRtYV9jdHgsIGN0eC0+ZHBpKTsNCj4+PiANCj4+PiBJbnRvIHFlZHJfbW1h
cF9mcmVlKCkuDQo+Pj4gDQo+Pj4gVGhlbiB0aGUgcmRtYV91c2VyX21tYXBfZW50cnlfcmVtb3Zl
KCkgd2lsbCBjYWxsIGl0IG5hdHVyYWxseSBhcyBpdA0KPj4+IGRvZXMgZW50cnlfcHV0KCkgYW5k
IGlmIHdlIGFyZSBkZXN0cm95aW5nIHRoZSB1Y29udGV4dCB3ZSBhbHJlYWR5IGtub3cNCj4+PiB0
aGUgbW1hcHMgYXJlIGRlc3Ryb3llZC4NCj4+PiANCj4+PiBNYXliZSB0aGUgc2FtZSBiYXNpYyBj
b21tZW50IGZvciBFRkEsIG5vdCBzdXJlLiBHYWw/DQo+PiANCj4+IFRoYXQncyB3aGF0IEVGQSBh
bHJlYWR5IGRvZXMgaW4gdGhpcyBzZXJpZXMsIG5vPw0KPj4gV2Ugbm8gbG9uZ2VyIHJlbW92ZSBl
bnRyaWVzIG9uIGRlYWxsb2NfdWNvbnRleHQsIG9ubHkgd2hlbiB0aGUgZW50cnkgaXMNCj4+IGZy
ZWVkLg0KPiANCj4gQWN0dWFsbHksIEkgdGhpbmsgbW9zdCBvZiB0aGUgZGlzY3Vzc2lvbnMgeW91
IGhhZCBvbiB0aGUgdG9waWMgd2VyZSB3aXRoIEdhbCwgYnV0DQo+IFNvbWUgYXBwbHkgdG8gcWVk
ciBhcyB3ZWxsLCBob3dldmVyLCBmb3IgcWVkciwgdGhlIG9ubHkgaHcgcmVzb3VyY2Ugd2UgYWxs
b2NhdGUgKGJhcikNCj4gaXMgb24gYWxsb2NfdWNvbnRleHQgLCB0aGVyZWZvcmUgd2Ugd2VyZSBz
YWZlIHRvIGZyZWUgaXQgb24gZGVhbGxvY191Y29udGV4dCBhcyBhbGwgbWFwcGluZ3MNCj4gd2Vy
ZSBhbHJlYWR5IHphcHBlZC4gTWFraW5nIHRoZSBtbWFwX2ZyZWUgYSBiaXQgcmVkdW5kYW50IGZv
ciBxZWRyIGV4Y2VwdCBmb3IgdGhlIG5lZWQNCj4gdG8gZnJlZSB0aGUgZW50cnkuIA0KPiANCj4g
Rm9yIEVGQSwgaXQgc2VlbWVkIHRoZSBvbmx5IG9wZXJhdGlvbiBkZWxheWVkIHdhcyBmcmVlaW5n
IG1lbW9yeSAtIEkgZGlkbid0IHNlZSBodyByZXNvdXJjZXMNCj4gYmVpbmcgZnJlZWQuLi4gR2Fs
Pw0KDQpXaGF0IGRvIHlvdSBtZWFuIGJ5IGh3IHJlc291cmNlcyBiZWluZyBmcmVlZD8gVGhlIEJB
UiBtYXBwaW5ncyBhcmUgdW5kZXIgdGhlIGRldmljZeKAmXMgY29udHJvbCBhbmQgYXJlIGFzc29j
aWF0ZWQgdG8gdGhlIGxpZmV0aW1lIG9mIHRoZSBVQVIuDQo=
