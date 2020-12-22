Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BAF2E04D0
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Dec 2020 04:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgLVDlN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Dec 2020 22:41:13 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:13633 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725962AbgLVDlN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Dec 2020 22:41:13 -0500
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="102804810"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Dec 2020 11:40:26 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 0C3844CE5CF8;
        Tue, 22 Dec 2020 11:40:21 +0800 (CST)
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 22 Dec 2020 11:40:20 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local ([fe80::65fd:3cfa:6c39:98a3])
 by G08CNEXMBPEKD06.g08.fujitsu.local ([fe80::65fd:3cfa:6c39:98a3%14]) with
 mapi id 15.00.1497.010; Tue, 22 Dec 2020 11:40:20 +0800
From:   "Yang, Xiao" <yangx.jy@cn.fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyXSBsaWJyZG1hY206IE1ha2Ugc29tZSBmdW5jdGlv?=
 =?gb2312?Q?ns_report_proper_errno?=
Thread-Topic: [PATCH v2] librdmacm: Make some functions report proper errno
Thread-Index: AQHW04/wkUpdvjlZ6UGG4SbEeUQ+n6n49OUAgAABIoCAB01fAIAArBmAgAGOfwA=
Date:   Tue, 22 Dec 2020 03:40:20 +0000
Message-ID: <0d87d07d653d4c9da64532ac322ab4d8@G08CNEXMBPEKD06.g08.fujitsu.local>
References: <20201216092252.155110-1-yangx.jy@cn.fujitsu.com>
 <5FD9D8B2.1020208@cn.fujitsu.com> <20201216095549.GC1060282@unreal>
 <5FDFF9CA.1060109@cn.fujitsu.com> <20201221114231.GB3128@unreal>
In-Reply-To: <20201221114231.GB3128@unreal>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.167.220.69]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-yoursite-MailScanner-ID: 0C3844CE5CF8.AD9C1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBMZW9uIFJvbWFub3Zz
a3kgPGxlb25Aa2VybmVsLm9yZz4gDQq3osvNyrG85DogMjAyMMTqMTLUwjIx
yNUgMTk6NDMNCsrVvP7IyzogWWFuZywgWGlhby/R7iDP/iA8eWFuZ3guanlA
Y24uZnVqaXRzdS5jb20+DQqzrcvNOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0K1vfM4jogUmU6IFtQQVRDSCB2Ml0gbGlicmRtYWNtOiBNYWtlIHNv
bWUgZnVuY3Rpb25zIHJlcG9ydCBwcm9wZXIgZXJybm8NCg0KT24gTW9uLCBE
ZWMgMjEsIDIwMjAgYXQgMDk6MjY6MzRBTSArMDgwMCwgWGlhbyBZYW5nIHdy
b3RlOg0KPiBPbiAyMDIwLzEyLzE2IDE3OjU1LCBMZW9uIFJvbWFub3Zza3kg
d3JvdGU6DQo+ID4gT24gV2VkLCBEZWMgMTYsIDIwMjAgYXQgMDU6NTE6NDZQ
TSArMDgwMCwgWGlhbyBZYW5nIHdyb3RlOg0KPiA+ID4gSGkgTGVvbiwNCj4g
PiA+DQo+ID4gPiBUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmVwbHkuIDotKQ0K
PiA+ID4gSSBoYXZlIGRvbmUgdGhlIHNhbWUgY2hhbmdlIG9uIHRocmVlIA0K
PiA+ID4gZnVuY3Rpb25zKHVjbWFfZ2V0X2RldmljZSx1Y21hX2NyZWF0ZV9j
cXMsIHJkbWFfY3JlYXRlX3FwX2V4KS4NCj4gPiA+DQo+ID4gPiBPbiAyMDIw
LzEyLzE2IDE3OjIyLCBYaWFvIFlhbmcgd3JvdGU6DQo+ID4gPiA+IFNvbWUg
ZnVuY3Rpb25zIHJlcG9ydHMgZml4ZWQgRU5PTUVNIHdoZW4gZ2V0dGluZyBh
bnkgZmFpbHVyZSwgc28gDQo+ID4gPiA+IGl0J3MgaGFyZCBmb3IgdXNlciB0
byBrbm93IHdoaWNoIGFjdHVhbCBlcnJvciBoYXBwZW5zIG9uIHRoZW0uDQo+
ID4gPiA+DQo+ID4gPiA+IEZpeGVzKHVjbWFfZ2V0X2RldmljZSk6DQo+ID4g
PiA+IDJmZmRhN2YyOTkxMyAoImxpYnJkbWFjbTogT25seSBhbGxvY2F0ZSB2
ZXJicyByZXNvdXJjZXMgd2hlbiANCj4gPiA+ID4gbmVlZGVkIikNCj4gPiA+
ID4gMTkxYzkzNDZmMzM1ICgibGlicmRtYWNtOiBSZWZlcmVuY2UgY291bnQg
YWNjZXNzIHRvIHZlcmJzIA0KPiA+ID4gPiBjb250ZXh0IikNCj4gPiA+ID4g
Rml4ZXModWNtYV9jcmVhdGVfY3FzKToNCj4gPiA+ID4gZjhmMTMzNWFkOGQ4
ICgibGlicmRtYWNtOiBtYWtlIENRcyBvcHRpb25hbCBmb3IgcmRtYV9jcmVh
dGVfcXAiKQ0KPiA+ID4gPiA5ZTMzNDg4ZThlNTAgKCJsaWJyZG1hY206IGZp
eCBhbGwgY2FsbHMgdG8gc2V0IGVycm5vIikNCj4gPiA+ID4gRml4ZXMocmRt
YV9jcmVhdGVfcXBfZXgpOg0KPiA+ID4gPiBkMmVmZGVkZTExZjcgKCJyNDAx
OTogQWRkIHN1cHBvcnQgZm9yIHVzZXJzcGFjZSBSRE1BIGNvbm5lY3Rpb24g
DQo+ID4gPiA+IG1hbmFnZW1lbnQgYWJzdHJhY3Rpb24gKENNQSkiKQ0KPiA+
ID4gPiA0ZTMzYTQxMDlhNjIgKCJsaWJyZG1hY206IHJldHVybnMgZXJyb3Jz
IGZyb20gdGhlIGxpYnJhcnkgDQo+ID4gPiA+IGNvbnNpc3RlbnRseSIpIDk5
NWViMGM5MGMxYSAoInJkbWFjbTogQWRkIHN1cHBvcnQgZm9yIFhSQyBRUHMi
KQ0KPiA+ID4gRm9yIGV2ZXJ5IGZ1bmN0aW9uLCBJIGFtIG5vdCBzdXJlIHdo
aWNoIG9uZSBpcyBhbiBleGFjdCBjb21taXQgc28gDQo+ID4gPiBqdXN0IGF0
dGFjaCBhbGwgcmVsYXRlZCBjb21taXRzIGlkcy4NCj4gPiBObyBwcm9ibGVt
LCBJJ2xsIHRyeSB0byBzb3J0IGl0IG91dCBub3cuDQo+IEhpIExlb24sDQo+
DQo+IFNvcnJ5IHRvIGJvdGhlciB5b3UuDQo+IElzIHRoZXJlIGFueXRoaW5n
IGJsb2NraW5nIHRoZSBwYXRjaD8gOi0pDQoNCk5vdGhpbmcsIHdlIGFyZSBp
biB0aGUgbWlkZGxlIG9mIENocmlzdG1hcyB2YWNhdGlvbiBoZXJlLCBzbyBl
dmVyeXRoaW5nIHRha2VzIG1vcmUgdGltZSB0aGFuIHVzdWFsLg0KDQpUaGFu
a3MNCg0KSGkgTGVvbiwNCg0KR290IGl0LiAgVGhhbmtzIGZvciB5b3VyIHJl
cGx5Lg0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCg0KPg0KPiBCZXN0
IFJlZ2FyZHMsDQo+IFhpYW8gWWFuZw0KPiA+IFRoYW5rcw0KPiA+DQo+ID4N
Cj4gPiAuDQo+ID4NCj4NCj4NCj4NCg0KDQoKCg==
