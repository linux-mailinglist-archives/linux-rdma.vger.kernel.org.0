Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA4895A58A
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 21:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfF1T7I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 15:59:08 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57814 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727042AbfF1T7I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 15:59:08 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SJsWiZ020775;
        Fri, 28 Jun 2019 12:58:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=rc9YmUZs3mLD2IAXU/Jw2hap/cnuId6Fi6c/dpT6i4k=;
 b=BdEQ0IBwDgKbwceekVPeJ+j3p+ewyOj0dqeVOAZ7+zGRQqNiN7uLUP2Z4QrY0+G1zCeL
 5xmVmfhE/oOfiCYgNUon6diobG3q5RkS8NQzZKzwLucNwUuxZU+I4dFkITZ/28JmkwEC
 x02QunhxZ/L+3dzFx5tFaS2VtM3QK7F5sCHo7XvgZpF9pmtxi/+RD62XBoqSOZ9on0sT
 GipLg2gOsldj1GfkIoihV9a1+yJBK+KC4nfOuLOAlJ5RHoezr/Ac3iOeLv4SkWbK9Whs
 85x3uil17Q0ri6W75rAynDup7IpG4oV+mfP28wpToO+f/MqZrzGiTGkgCfi5jjhHHKb7 ZA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tdkg19arj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 12:58:42 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 28 Jun
 2019 12:58:40 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 28 Jun 2019 12:58:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rc9YmUZs3mLD2IAXU/Jw2hap/cnuId6Fi6c/dpT6i4k=;
 b=UDBwhGkzbQ4JNHQ1vDXPTFvWsi+xE2WrXWG1qoW2U9wUUW9+lX/xwwc+GgTm9M2yGN/mDPuaIFTmIGTA55MjfKUaETTWMmrkxzaFL14N0UfRB3CBKDAQKEalRjodJjTPFShDbygxcew3yrE3LCc94SfOveR095t47lKi1GBl8cM=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3293.namprd18.prod.outlook.com (10.255.237.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Fri, 28 Jun 2019 19:58:35 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9880:2b8b:52e5:b413%3]) with mapi id 15.20.2008.017; Fri, 28 Jun 2019
 19:58:35 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Topic: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Index: AQHVLPCe9cWnyNWtL0+HivI8Maeykaavn0KAgAAHdoCAAWOSgIAAcm4Q
Date:   Fri, 28 Jun 2019 19:58:35 +0000
Message-ID: <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
In-Reply-To: <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.178.10.114]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a006b5e8-b338-4054-e035-08d6fc030126
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3293;
x-ms-traffictypediagnostic: MN2PR18MB3293:
x-microsoft-antispam-prvs: <MN2PR18MB329371F356CAD7AE26B15B1FA1FC0@MN2PR18MB3293.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39850400004)(396003)(346002)(376002)(43544003)(199004)(189003)(6246003)(52536014)(256004)(14444005)(4326008)(68736007)(305945005)(7736002)(9686003)(229853002)(8676002)(6436002)(55016002)(8936002)(25786009)(81166006)(71200400001)(71190400001)(53936002)(81156014)(86362001)(99286004)(478600001)(76176011)(6506007)(54906003)(53546011)(316002)(486006)(102836004)(186003)(7696005)(33656002)(74316002)(476003)(446003)(26005)(11346002)(14454004)(2906002)(66556008)(66446008)(64756008)(73956011)(66476007)(110136005)(66946007)(76116006)(5660300002)(66066001)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3293;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TYxR3ohszzflr8OifettzgCc0S2vjWWb8IuC+e63j8AG6fwj95FeYxx8lWJGv3TumU3I9oQDpKx+b4NSTh1Jc85xBRK6jMBr7GHbWSSsiaAol/PQIx8HRJUKKOJGYRADf9/48ekaHnFSFjLwujg//NbcxbSnGTy6WZ5kPpnA3g4KCQEd+QpLb0MsKhgkFnMDIl4eM62mRUzsBZ+Km54v42MecO7SyNmwa2JZu8d8qCU88Hm4Q5xOwBAk75M4MiWXc3f+n/rnp3efGfVsyla2xbutEGUnLUjUhDnAkcizfbYJ+CfOhyeZ5LmiPXS/9ctvBcG1ldKUc7mLygOxZJQltlQ39qjQkucTwx5x6SKnw4xol0+UdGZo+dzgw+9lfDPRDxPWMY37ELiNEmv/A/KC13LIDuZGPhV+J1fXNscbFWU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a006b5e8-b338-4054-e035-08d6fc030126
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 19:58:35.2481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3293
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_09:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgR2FsIFByZXNzbWFuDQo+IA0KPiBP
biAyNy8wNi8yMDE5IDE4OjUyLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVGh1LCBK
dW4gMjcsIDIwMTkgYXQgMDY6MjU6MzdQTSArMDMwMCwgR2FsIFByZXNzbWFuIHdyb3RlOg0KPiA+
PiBPbiAyNy8wNi8yMDE5IDE2OjU4LCBNaWNoYWwgS2FsZGVyb24gd3JvdGU6DQo+ID4+PiBDcmVh
dGUgYSBjb21tb24gQVBJIGZvciBhZGRpbmcgZW50cmllcyB0byBhIHhhX21tYXAuDQo+ID4+PiBU
aGlzIEFQSSBjYW4gYmUgdXNlZCBieSBkcml2ZXJzIHRoYXQgZG9uJ3QgcmVxdWlyZSBzcGVjaWFs
IG1hcHBpbmcNCj4gPj4+IGZvciB1c2VyIG1hcHBlZCBtZW1vcnkuDQo+ID4+Pg0KPiA+Pj4gVGhl
IGNvZGUgd2FzIGNvcGllZCBmcm9tIHRoZSBlZmEgZHJpdmVyIGFsbW9zdCBhcyBpcywganVzdCBy
ZW5hbWVkDQo+ID4+PiBmdW5jdGlvbiB0byBiZSBnZW5lcmljIGFuZCBub3QgZWZhIHNwZWNpZmlj
Lg0KPiA+Pg0KPiA+PiBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBmb3JjZSB0aGUgbW1hcCBmbGFn
cyB0byBiZSB0aGUgc2FtZSBmb3IgYWxsDQo+IGRyaXZlcnMuLg0KPiA+PiBUYWtlIGEgbG9vayBh
dCBtbHg1IGZvciBleGFtcGxlOg0KPiA+Pg0KPiA+PiBlbnVtIG1seDVfaWJfbW1hcF9jbWQgew0K
PiA+PiAJTUxYNV9JQl9NTUFQX1JFR1VMQVJfUEFHRSAgICAgICAgICAgICAgID0gMCwNCj4gPj4g
CU1MWDVfSUJfTU1BUF9HRVRfQ09OVElHVU9VU19QQUdFUyAgICAgICA9IDEsDQo+ID4+IAlNTFg1
X0lCX01NQVBfV0NfUEFHRSAgICAgICAgICAgICAgICAgICAgPSAyLA0KPiA+PiAJTUxYNV9JQl9N
TUFQX05DX1BBR0UgICAgICAgICAgICAgICAgICAgID0gMywNCj4gPj4gCS8qIDUgaXMgY2hvc2Vu
IGluIG9yZGVyIHRvIGJlIGNvbXBhdGlibGUgd2l0aCBvbGQgdmVyc2lvbnMgb2YgbGlibWx4NQ0K
PiAqLw0KPiA+PiAJTUxYNV9JQl9NTUFQX0NPUkVfQ0xPQ0sgICAgICAgICAgICAgICAgID0gNSwN
Cj4gPj4gCU1MWDVfSUJfTU1BUF9BTExPQ19XQyAgICAgICAgICAgICAgICAgICA9IDYsDQo+ID4+
IAlNTFg1X0lCX01NQVBfQ0xPQ0tfSU5GTyAgICAgICAgICAgICAgICAgPSA3LA0KPiA+PiAJTUxY
NV9JQl9NTUFQX0RFVklDRV9NRU0gICAgICAgICAgICAgICAgID0gOCwNCj4gPj4gfTsNCj4gPj4N
Cj4gPj4gVGhlIGZsYWdzIHRha2VuIGZyb20gRUZBIGFyZW4ndCBuZWNlc3NhcmlseSBnb2luZyB0
byB3b3JrIGZvciBvdGhlcg0KPiBkcml2ZXJzLg0KPiA+PiBNYXliZSB0aGUgZmxhZ3MgYml0cyBz
aG91bGQgYmUgb3BhcXVlIHRvIGliX2NvcmUgYW5kIGxlYXZlIHRoZSBhY3R1YWwNCj4gPj4gbW1h
cCBjYWxsYmFja3MgaW4gdGhlIGRyaXZlcnMuIE5vdCBzdXJlIGhvdyBkZWFsbG9jX3Vjb250ZXh0
IGlzIGdvaW5nDQo+ID4+IHRvIHdvcmsgd2l0aCBvcGFxdWUgZmxhZ3MgdGhvdWdoPw0KPiA+DQo+
ID4gWWVzLCB0aGUgZHJpdmVyIHdpbGwgaGF2ZSB0byB0YWtlIGNhcmUgb2YgbWFza2luZyB0aGUg
ZmxhZ3MgYmVmb3JlDQo+ID4gbG9va3VwDQo+ID4NCj4gPiBXZSBzaG91bGQgcHJvYmFibHkgc3Rv
cmUgdGhlIHN0cnVjdCBwYWdlICogaW4gdGhlDQo+ID4gcmRtYV91c2VyX21tYXBfZW50cnkoKSBh
bmQgdXNlIHRoYXQgdG8ga2V5IHN0cnVjdCBwYWdlIGJlaGF2aW9yLg0KPiBJIGRvbid0IGZvbGxv
dyB3aHkgd2UgbmVlZCB0aGUgc3RydWN0IHBhZ2U/IEhvdyB3aWxsIHRoaXMgd29yayBmb3IgTU1J
Tz8NCj4gDQo+ID4NCj4gPiBEbyB5b3UgdGhpbmsgd2Ugc2hvdWxkIGdvIGZ1cnRoZXIgYW5kIHBy
b3ZpZGUgYSBnZW5lcmljIG1tYXAoKSB0aGF0DQo+ID4gZG9lcyB0aGUgcmlnaHQgdGhpbmc/IEl0
IHdvdWxkIG5vdCBiZSBoYXJkIHRvIHByb3ZpZGUgYSBjYWxsYmFjayB0aGF0DQo+ID4gY29tcHV0
ZXMgdGhlIHBncHJvdCBmbGFncw0KPiANCj4gSSB0aGluayBhIGdlbmVyaWMgbW1hcCB3aXRoIGEg
ZHJpdmVyIGNhbGxiYWNrIHRvIGRvIHRoZSBhY3R1YWwNCj4gcmRtYV91c2VyX21tYXBfaW8vdm1f
aW5zZXJ0X3BhZ2UvLi4uIGFjY29yZGluZyB0byB0aGUgZmxhZ3MgaXMgYSBnb29kDQo+IGFwcHJv
YWNoLg0KPiANCj4gSWYgdGhlIGZsYWdzIGFyZSBvcGFxdWUgdG8gaWJfY29yZSB3ZSdsbCBuZWVk
IGFub3RoZXIgY2FsbGJhY2sgdG8gdGVsbCB0aGUNCj4gZHJpdmVyIHdoZW4gdGhlIGVudHJpZXMg
YXJlIGJlaW5nIGZyZWVkLiBUaGlzIHdheSwgaWYgdGhlIGVudHJ5IGlzIGEgRE1BIHBhZ2UNCj4g
Zm9yIGV4YW1wbGUgKHN0YXRlZCBieSB0aGUgZmxhZ3MpLCB0aGUgZHJpdmVyIGNhbiBmcmVlIHRo
ZXNlIGJ1ZmZlcnMuDQoNCkkgdGhpbmsgd2UnbGwgc3RpbGwgZW5kIHVwIHdpdGggYSBmYWlyIGFt
b3VudCBvZiBkdXBsaWNhdGVkIGNvZGUgYmV0d2VlbiBhIGZldyBkcml2ZXJzLiANCkhvdyBhYm91
dCBhbiBvcHRpb25hbCBkcml2ZXIgY2FsbGJhY2sgdG8gb3ZlcnJpZGUgdGhlIGRlZmF1bHQgb25l
ID8gDQpXZSBjYW4gc3RhcnQgdGhlIG5ldyBmbGFncyBmcm9tIGEgbmV3IHJhbmdlIHRoYXQgaXNu
J3QgdXNlZCBieSB0aGUgb3RoZXIgZHJpdmVycywNCklmIHRoZSBmbGFnIGlzIGluIGEgImRyaXZl
ci1zcGVjaWZpYyIgcmFuZ2UgYW5kIGEgZHJpdmVyIGNhbGxiYWNrIGZvciBtbWFwIGlzIHByb3Zp
ZGVkDQpXZSdsbCBjYWxsIHRoYXQgZnVuY3Rpb24uIFdlIGNhbiBhbHNvIHN0b3JlIGluIHRoZSBy
ZG1hX3VzZXJfbW1hcF9lbnRyeSB3aGV0aGVyDQpUaGUgbWVtb3J5IHdhcyBtYXBwZWQgdXNpbmcg
ZHJpdmVyIG9wYXF1ZSBmaWVsZHMgb3Igbm90LCBhbmQgY2FsbCB0aGUgZHJpdmVyDQpGcmVlIGJ1
ZmZlciBmdW5jdGlvbnMgYWNjb3JkaW5nbHkuDQoNCg==
