Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529B55CF50
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2019 14:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfGBMWt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 08:22:49 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:26092 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbfGBMWt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jul 2019 08:22:49 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62C9sJs023533;
        Tue, 2 Jul 2019 05:22:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=DALVT1fgOZq31a5tPH2FXiEv5lSR+fTdCkKgxqji3qg=;
 b=V1cg0xNWv3ctaRywii7DqbcQ+/n6UheRfDwKFkHnK2OD9s6Dy2cspwkFkU/qDChucOT0
 X87rd6JUsrfaJhB4GPtZeY/z5k9Pc31NCrPj/UA/PG4v2vi4DW+DJgi3E1Z4zxrNmaQJ
 0rAIHTckxTsKnV6P8EaKAo3ONHLR65XYCM83kUA+FHRdDUqSxlvtZ+Jb3CE/sGC9skTy
 +fbQ0W5MGATwfh9tXSDLGO+WlbeYZ23akKMZFkTPl2mm7hLfWlHGNvuZL586wG1fNC7P
 ocuWujOfUAmeE5/ytFlR4Yll0pPy/+2CsEodwdyKun0wH/3LQ2zUNnDLKIMaxX4HZXGn Ww== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tg5730dcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 05:22:29 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 2 Jul
 2019 05:22:28 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.58) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 2 Jul 2019 05:22:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DALVT1fgOZq31a5tPH2FXiEv5lSR+fTdCkKgxqji3qg=;
 b=kpEvbhcsGt4t5O2dtJOnIo4QZiqWKSC8cCtSINDlX5Nt4xskxdignfLK3uXJOcoGYkmtgMdAL+32IcKLGQxi+LBGcKqnFP4AOJ4qJS4B1uGuL9SjzPEEaN6K+DVOAjtzuVpYb6lZXqKfqAwdrkbV/O4JaGxMv7LjhNfMRgzc0x0=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3421.namprd18.prod.outlook.com (10.255.239.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 12:22:26 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::8cb3:f7d7:8bb2:c36e%6]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 12:22:26 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Michal Kalderon <mkalderon@marvell.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Topic: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Thread-Index: AQHVLPCe9cWnyNWtL0+HivI8Maeykaavn0KAgAAHdoCAAWOSgIAAcm4QgAXEuKA=
Date:   Tue, 2 Jul 2019 12:22:26 +0000
Message-ID: <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd94e5cf-73ee-4976-443d-08d6fee7f1b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3421;
x-ms-traffictypediagnostic: MN2PR18MB3421:
x-microsoft-antispam-prvs: <MN2PR18MB342135F65031614FD0AFF439A1F80@MN2PR18MB3421.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(43544003)(6506007)(99286004)(7696005)(53546011)(14444005)(76176011)(66066001)(256004)(81156014)(81166006)(8676002)(478600001)(7736002)(71190400001)(6116002)(74316002)(305945005)(3846002)(71200400001)(68736007)(14454004)(9686003)(86362001)(6246003)(66946007)(73956011)(66446008)(6436002)(52536014)(4326008)(66556008)(66476007)(55016002)(53936002)(25786009)(2906002)(5660300002)(64756008)(8936002)(33656002)(54906003)(102836004)(186003)(11346002)(446003)(110136005)(476003)(26005)(486006)(76116006)(316002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3421;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ize4rr9f8Tmx3w/+zeBL2uScC10yWM/7/x7gqqIRXmHmojyiabY0wOBXB1GethwTdN5M0XTKuxZTNX3riEYjkUWzd+xKnlIDoZuKJlTRrMPVWIPF/7gwDiBVaZ6lFFCd/UBghrx4lI/HRAt1yEYs0SIODf3LozsTLWXV2KDs7Z4JSMi0nDloof5r8scCK35uI0JUiQzK2pD5gp7JxQRK/G6dUbpIz/xgA3DiIK6yeOXwhP8GWgVj6mLUcH0UvDu7HWs6ZZrNzkJrw+gx2YrAAjc+nW+FlRr+awmeJSZN18HEBxl46Lzuctu/rRTSvixz/g1rrMIUuqouUMtn5nBJRMveX1P4lcXw1l91h34eq7nVBWYFplIOAS7kNE9GyuDXL+XfMIjK72w4jm2BbZ0BH0voIT40A3rbA/hLfhNDl6A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd94e5cf-73ee-4976-443d-08d6fee7f1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 12:22:26.4240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkalderon@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3421
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_06:,,
 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgTWljaGFsIEthbGRlcm9uDQo+IA0K
PiA+IEZyb206IGxpbnV4LXJkbWEtb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1yZG1hLQ0K
PiA+IG93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIEdhbCBQcmVzc21hbg0KPiA+
DQo+ID4gT24gMjcvMDYvMjAxOSAxODo1MiwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+ID4g
T24gVGh1LCBKdW4gMjcsIDIwMTkgYXQgMDY6MjU6MzdQTSArMDMwMCwgR2FsIFByZXNzbWFuIHdy
b3RlOg0KPiA+ID4+IE9uIDI3LzA2LzIwMTkgMTY6NTgsIE1pY2hhbCBLYWxkZXJvbiB3cm90ZToN
Cj4gPiA+Pj4gQ3JlYXRlIGEgY29tbW9uIEFQSSBmb3IgYWRkaW5nIGVudHJpZXMgdG8gYSB4YV9t
bWFwLg0KPiA+ID4+PiBUaGlzIEFQSSBjYW4gYmUgdXNlZCBieSBkcml2ZXJzIHRoYXQgZG9uJ3Qg
cmVxdWlyZSBzcGVjaWFsIG1hcHBpbmcNCj4gPiA+Pj4gZm9yIHVzZXIgbWFwcGVkIG1lbW9yeS4N
Cj4gPiA+Pj4NCj4gPiA+Pj4gVGhlIGNvZGUgd2FzIGNvcGllZCBmcm9tIHRoZSBlZmEgZHJpdmVy
IGFsbW9zdCBhcyBpcywganVzdCByZW5hbWVkDQo+ID4gPj4+IGZ1bmN0aW9uIHRvIGJlIGdlbmVy
aWMgYW5kIG5vdCBlZmEgc3BlY2lmaWMuDQo+ID4gPj4NCj4gPiA+PiBJIGRvbid0IHRoaW5rIHdl
IHNob3VsZCBmb3JjZSB0aGUgbW1hcCBmbGFncyB0byBiZSB0aGUgc2FtZSBmb3IgYWxsDQo+ID4g
ZHJpdmVycy4uDQo+ID4gPj4gVGFrZSBhIGxvb2sgYXQgbWx4NSBmb3IgZXhhbXBsZToNCj4gPiA+
Pg0KPiA+ID4+IGVudW0gbWx4NV9pYl9tbWFwX2NtZCB7DQo+ID4gPj4gCU1MWDVfSUJfTU1BUF9S
RUdVTEFSX1BBR0UgICAgICAgICAgICAgICA9IDAsDQo+ID4gPj4gCU1MWDVfSUJfTU1BUF9HRVRf
Q09OVElHVU9VU19QQUdFUyAgICAgICA9IDEsDQo+ID4gPj4gCU1MWDVfSUJfTU1BUF9XQ19QQUdF
ICAgICAgICAgICAgICAgICAgICA9IDIsDQo+ID4gPj4gCU1MWDVfSUJfTU1BUF9OQ19QQUdFICAg
ICAgICAgICAgICAgICAgICA9IDMsDQo+ID4gPj4gCS8qIDUgaXMgY2hvc2VuIGluIG9yZGVyIHRv
IGJlIGNvbXBhdGlibGUgd2l0aCBvbGQgdmVyc2lvbnMgb2YNCj4gPiA+PiBsaWJtbHg1DQo+ID4g
Ki8NCj4gPiA+PiAJTUxYNV9JQl9NTUFQX0NPUkVfQ0xPQ0sgICAgICAgICAgICAgICAgID0gNSwN
Cj4gPiA+PiAJTUxYNV9JQl9NTUFQX0FMTE9DX1dDICAgICAgICAgICAgICAgICAgID0gNiwNCj4g
PiA+PiAJTUxYNV9JQl9NTUFQX0NMT0NLX0lORk8gICAgICAgICAgICAgICAgID0gNywNCj4gPiA+
PiAJTUxYNV9JQl9NTUFQX0RFVklDRV9NRU0gICAgICAgICAgICAgICAgID0gOCwNCj4gPiA+PiB9
Ow0KPiA+ID4+DQo+ID4gPj4gVGhlIGZsYWdzIHRha2VuIGZyb20gRUZBIGFyZW4ndCBuZWNlc3Nh
cmlseSBnb2luZyB0byB3b3JrIGZvciBvdGhlcg0KPiA+IGRyaXZlcnMuDQo+ID4gPj4gTWF5YmUg
dGhlIGZsYWdzIGJpdHMgc2hvdWxkIGJlIG9wYXF1ZSB0byBpYl9jb3JlIGFuZCBsZWF2ZSB0aGUN
Cj4gPiA+PiBhY3R1YWwgbW1hcCBjYWxsYmFja3MgaW4gdGhlIGRyaXZlcnMuIE5vdCBzdXJlIGhv
dyBkZWFsbG9jX3Vjb250ZXh0DQo+ID4gPj4gaXMgZ29pbmcgdG8gd29yayB3aXRoIG9wYXF1ZSBm
bGFncyB0aG91Z2g/DQo+ID4gPg0KPiA+ID4gWWVzLCB0aGUgZHJpdmVyIHdpbGwgaGF2ZSB0byB0
YWtlIGNhcmUgb2YgbWFza2luZyB0aGUgZmxhZ3MgYmVmb3JlDQo+ID4gPiBsb29rdXANCj4gPiA+
DQo+ID4gPiBXZSBzaG91bGQgcHJvYmFibHkgc3RvcmUgdGhlIHN0cnVjdCBwYWdlICogaW4gdGhl
DQo+ID4gPiByZG1hX3VzZXJfbW1hcF9lbnRyeSgpIGFuZCB1c2UgdGhhdCB0byBrZXkgc3RydWN0
IHBhZ2UgYmVoYXZpb3IuDQo+ID4gSSBkb24ndCBmb2xsb3cgd2h5IHdlIG5lZWQgdGhlIHN0cnVj
dCBwYWdlPyBIb3cgd2lsbCB0aGlzIHdvcmsgZm9yIE1NSU8/DQo+ID4NCj4gPiA+DQo+ID4gPiBE
byB5b3UgdGhpbmsgd2Ugc2hvdWxkIGdvIGZ1cnRoZXIgYW5kIHByb3ZpZGUgYSBnZW5lcmljIG1t
YXAoKSB0aGF0DQo+ID4gPiBkb2VzIHRoZSByaWdodCB0aGluZz8gSXQgd291bGQgbm90IGJlIGhh
cmQgdG8gcHJvdmlkZSBhIGNhbGxiYWNrDQo+ID4gPiB0aGF0IGNvbXB1dGVzIHRoZSBwZ3Byb3Qg
ZmxhZ3MNCj4gPg0KPiA+IEkgdGhpbmsgYSBnZW5lcmljIG1tYXAgd2l0aCBhIGRyaXZlciBjYWxs
YmFjayB0byBkbyB0aGUgYWN0dWFsDQo+ID4gcmRtYV91c2VyX21tYXBfaW8vdm1faW5zZXJ0X3Bh
Z2UvLi4uIGFjY29yZGluZyB0byB0aGUgZmxhZ3MgaXMgYSBnb29kDQo+ID4gYXBwcm9hY2guDQo+
ID4NCj4gPiBJZiB0aGUgZmxhZ3MgYXJlIG9wYXF1ZSB0byBpYl9jb3JlIHdlJ2xsIG5lZWQgYW5v
dGhlciBjYWxsYmFjayB0byB0ZWxsDQo+ID4gdGhlIGRyaXZlciB3aGVuIHRoZSBlbnRyaWVzIGFy
ZSBiZWluZyBmcmVlZC4gVGhpcyB3YXksIGlmIHRoZSBlbnRyeSBpcw0KPiA+IGEgRE1BIHBhZ2Ug
Zm9yIGV4YW1wbGUgKHN0YXRlZCBieSB0aGUgZmxhZ3MpLCB0aGUgZHJpdmVyIGNhbiBmcmVlIHRo
ZXNlDQo+IGJ1ZmZlcnMuDQo+IA0KPiBJIHRoaW5rIHdlJ2xsIHN0aWxsIGVuZCB1cCB3aXRoIGEg
ZmFpciBhbW91bnQgb2YgZHVwbGljYXRlZCBjb2RlIGJldHdlZW4gYSBmZXcNCj4gZHJpdmVycy4N
Cj4gSG93IGFib3V0IGFuIG9wdGlvbmFsIGRyaXZlciBjYWxsYmFjayB0byBvdmVycmlkZSB0aGUg
ZGVmYXVsdCBvbmUgPw0KPiBXZSBjYW4gc3RhcnQgdGhlIG5ldyBmbGFncyBmcm9tIGEgbmV3IHJh
bmdlIHRoYXQgaXNuJ3QgdXNlZCBieSB0aGUgb3RoZXINCj4gZHJpdmVycywgSWYgdGhlIGZsYWcg
aXMgaW4gYSAiZHJpdmVyLXNwZWNpZmljIiByYW5nZSBhbmQgYSBkcml2ZXIgY2FsbGJhY2sgZm9y
IG1tYXANCj4gaXMgcHJvdmlkZWQgV2UnbGwgY2FsbCB0aGF0IGZ1bmN0aW9uLiBXZSBjYW4gYWxz
byBzdG9yZSBpbiB0aGUNCj4gcmRtYV91c2VyX21tYXBfZW50cnkgd2hldGhlciBUaGUgbWVtb3J5
IHdhcyBtYXBwZWQgdXNpbmcgZHJpdmVyDQo+IG9wYXF1ZSBmaWVsZHMgb3Igbm90LCBhbmQgY2Fs
bCB0aGUgZHJpdmVyIEZyZWUgYnVmZmVyIGZ1bmN0aW9ucyBhY2NvcmRpbmdseS4NCg0KSmFzb24s
IA0KDQpTZWVtcyBleGNlcHQgTWVsbGFub3ggKyBobnMgdGhlIG1tYXAgZmxhZ3MgYXJlbid0IEFC
SS4gDQpBbHNvLCBjdXJyZW50IE1lbGxhbm94IGNvZGUgc2VlbXMgbGlrZSBpdCB3b24ndCBiZW5l
Zml0IGZyb20gDQptbWFwIGNvb2tpZSBoZWxwZXIgZnVuY3Rpb25zIGluIGFueSBjYXNlIGFzIHRo
ZSBtbWFwIGZ1bmN0aW9uIGlzIHZlcnkgc3BlY2lmaWMgYW5kIHRoZSBmbGFncyB1c2VkIGluZGlj
YXRlIA0KdGhlIGFkZHJlc3MgYW5kIG5vdCBqdXN0IGhvdyB0byBtYXAgaXQuIA0KDQpGb3IgbW9z
dCBkcml2ZXJzIChlZmEsIHFlZHIsIHNpdywgY3hnYjMvNCwgb2NyZG1hKSBtbWFwIGlzIGNhbGxl
ZCBvbiBhZGRyZXNzIHJlY2VpdmVkDQpieSBrZXJuZWwgaW4gc29tZSByZXNwb25zZS4gTWVhbmlu
ZyBkcml2ZXIgY2FuIHdyaXRlIGFueXRoaW5nIGluIHRoZSByZXNwb25zZSB0aGF0IHdpbGwgc2Vy
dmUgYXMgdGhlIGtleSAvIGZsYWcuDQpPdGhlciBkcml2ZXJzICggaTQwaXcgKSBoYXZlIGEgc2lt
cGxlIG1tYXAgZnVuY3Rpb24gdGhhdCBkb2Vzbid0IHJlcXVpcmUgYSBtbWFwIGRhdGFiYXNlIGF0
IGFsbC4NCg0KQ3VycmVudCBFRkEgaW1wbGVtZW50YXRpb24gaXMgdmVyeSBnZW5lcmljLCB0aGUg
ZmxhZ3MganVzdCBpbmRpY2F0ZSBob3cgdG8gbWFwIHRoZSBhZGRyZXNzLCBpdCB1c2UNCnRoZSBh
ZGRyZXNzIGFzIGlzIHRoYXQgaXMgcGxhY2VkIGluIHRoZSByZG1hX3VzZXJfbW1hcF9lbnRyeS4g
DQpJZiBmdXR1cmUgZW5oYW5jZW1lbnRzIGFyZSByZXF1aXJlZCB3ZSB3aWxsIGJlIGFibGUgdG8g
ZWl0aGVyIGVuaGFuY2UgdGhlIGZsYWdzIHRvIGhhdmUgYSBkcml2ZXItc3BlY2lmaWMgbWFwDQpU
aGF0IHdlIGNhbiBjYWxsIGZyb20gcmRtYV91c2VyX21tYXAsIG9yIGEgZHJpdmVyLXNwZWNpZmlj
IGNhbGxiYWNrIGluc2lkZSB0aGUgcmRtYV91c2VyX21tYXBfZW50cnkgDQp0byBnZXQgdGhlIGFk
ZHJlc3MgdG8gbWFwLiANCkhhdmluZyBzYWlkIHRoYXQsIEknbSBvZiBjb3Vyc2UgYWxzbyBmaW5l
IHdpdGggb25seSBhZGRpbmcgdGhlIG1tYXBfeGEgZGF0YWJhc2UgaW50byBjb3JlIGFuZCBpdCdz
IGhlbHBlciBmdW5jdGlvbnMNCkZvciBpbnNlcnRpbmcsIGdldHRpbmcsIGZyZWVpbmcgdGhlIGVu
dHJpZXMuIA0KDQpQbGVhc2UgbGV0IG1lIGtub3cgd2hpY2ggZGlyZWN0aW9uIHRvIHRha2UuIA0K
VGhhbmtzLA0KTWljaGFsDQoNCg0KDQoNCg0KDQoNCg0KDQo=
