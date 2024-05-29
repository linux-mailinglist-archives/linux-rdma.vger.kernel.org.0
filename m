Return-Path: <linux-rdma+bounces-2664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 712AE8D3395
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 11:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF629284C76
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2B616EBFB;
	Wed, 29 May 2024 09:48:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559216EBF2
	for <linux-rdma@vger.kernel.org>; Wed, 29 May 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976097; cv=none; b=M+1LU+uL4CtL3cdySdmdfiN6HVN465iJn3nU+QDCYHFpa3+YZrT58LxxXuPmT+FEnYrmDD/ShQQIbRkN26we00X3OMD6B7tZvKeNK/cJdkyfYqvdNoObDhP/iBJk/sDiTvP2ckEaZcJAhlhlSTpRzyCmyFyEXllMyZ3yUz2OwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976097; c=relaxed/simple;
	bh=jC7oLcKSttSAZP3SGOB0EpCiPukTPrA2tLsZ61wNxyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cv12YTYXhm3IfNg46tQPVI/kz2kcVcrUpbgXkywsPtYVofdZZYsWq+KBPm2KP8FnBxPlffLW5LfN7ENFV2hnxrjcxkPg0/VsLTb5B29T6mnjgEIIu9T6F5/t9SbVM6Jwz2WVLscXT922H0vXsB9Jv9pOamHtQRQMt1/D1walxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Vq4HB0PMkzPnrs;
	Wed, 29 May 2024 17:44:54 +0800 (CST)
Received: from dggpeml100005.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id BCFAF18007E;
	Wed, 29 May 2024 17:48:03 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpeml100005.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 29 May 2024 17:48:03 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2507.035;
 Wed, 29 May 2024 17:47:58 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Jinpu Wang <jinpu.wang@ionos.com>
CC: Greg Sword <gregsword0@gmail.com>, Peter Xu <peterx@redhat.com>, Yu Zhang
	<yu.zhang@ionos.com>, Michael Galaxy <mgalaxy@akamai.com>, Elmar Gerdes
	<elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>,
	=?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, "Zhijian Li (Fujitsu)"
	<lizhijian@fujitsu.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
	Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, Cornelia Huck
	<cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, "Prasanna Kumar
 Kalever" <prasanna4324@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>, "devel@lists.libvirt.org"
	<devel@lists.libvirt.org>, Hanna Reitz <hreitz@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake
	<eblake@redhat.com>, Song Gao <gaosong@loongson.cn>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
	=?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Wainer dos Santos
 Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
	Pannengyuan <pannengyuan@huawei.com>, Xiexiangyou <xiexiangyou@huawei.com>,
	Fabiano Rosas <farosas@suse.de>, RDMA mailing list
	<linux-rdma@vger.kernel.org>, "shefty@nvidia.com" <shefty@nvidia.com>, Haris
 Iqbal <haris.iqbal@ionos.com>
Subject: RE: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Topic: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Thread-Index: AQHaib4eb+nVph6utEe7HatbjXSGr7FeBxGAgAD/kQCAAM0PAIAAcGaAgAC+EICAAZsBgIAAJisAgBwPpQCAAB5mAIABl4t9//+GhYCAAhAsgIAHeqWwgABddICAATP+EIAAcc0AgAKnDgCAAFgYAIAH7hYAgANI14CAAUekgIAG49qAgAqnmyD//+59gIABNomA//+dcAAAAzlpgAAVpXFA//+IYYD//3J0kA==
Date: Wed, 29 May 2024 09:47:57 +0000
Message-ID: <2665934438364f5e9e80ac4564cac2c3@huawei.com>
References: <Zjj0xa-3KrFHTK0S@x1n>
 <addaa8d094904315a466533763689ead@huawei.com> <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com> <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
 <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
 <Zk0c51D1Oo6NdIxR@x1n> <2308a8b894244123b638038e40a33990@huawei.com>
 <ZlX-Swq4Hi-0iHeh@x1n> <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com>
 <CAMGffEmGDDxttMhYWCBWwhb_VmjU+ZeOCzwaJyZOTi=yH_jKRg@mail.gmail.com>
 <CAEz=LcuNM-j=1txyiL4_A89vZLxTicOFHXLC0=piamvqF4gu0g@mail.gmail.com>
 <e0fa7fc42118407f8731c34f8c192fda@huawei.com>
 <CAMGffEna=8vNm89SkzRknLb7irTit0dBeciuC+_KMp+4U0PtQw@mail.gmail.com>
In-Reply-To: <CAMGffEna=8vNm89SkzRknLb7irTit0dBeciuC+_KMp+4U0PtQw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+DQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FNR2ZmRW4tREtwTVo0dEE3MU1KWWR5ZW1nMFpkYQ0K
PiA+ID4gPiA+ID4gMTUNCj4gPiA+ID4gPiA+ID4gPiB3VkFxazgxdlh0S3p4LUxmSlFAbWFpbC5n
bWFpbC5jb20vDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBBcHByZWNpYXRlIGEg
bG90IGZvciBldmVyeW9uZSBoZWxwaW5nIG9uIHRoZSB0ZXN0aW5ncy4NCj4gPiA+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiA+ID4gSW5maW5pQmFuZCBjb250cm9sbGVyOiBNZWxsYW5veCBUZWNo
bm9sb2dpZXMgTVQyNzgwMA0KPiA+ID4gPiA+ID4gPiA+ID4gRmFtaWx5IFtDb25uZWN0WC01XQ0K
PiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IHdoaWNoIGRvZXNuJ3QgbWVldCBv
dXIgcHVycG9zZS4gSSBjYW4gY2hvb3NlIFJETUEgb3IgVENQDQo+ID4gPiA+ID4gPiA+ID4gPiBm
b3IgVk0gbWlncmF0aW9uLiBSRE1BIHRyYWZmaWMgaXMgdGhyb3VnaCBJbmZpbmlCYW5kIGFuZA0K
PiA+ID4gPiA+ID4gPiA+ID4gVENQIHRocm91Z2ggRXRoZXJuZXQgb24gdGhlc2UgdHdvIGhvc3Rz
LiBPbmUgaXMgc3RhbmRieQ0KPiA+ID4gPiA+ID4gPiA+ID4gd2hpbGUgdGhlIG90aGVyDQo+ID4g
PiBpcyBhY3RpdmUuDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gTm93IEkn
bGwgdHJ5IG9uIGEgc2VydmVyIHdpdGggbW9yZSByZWNlbnQgRXRoZXJuZXQgYW5kDQo+ID4gPiA+
ID4gPiA+ID4gPiBJbmZpbmlCYW5kIG5ldHdvcmsgYWRhcHRlcnMuIE9uZSBvZiB0aGVtIGhhczoN
Cj4gPiA+ID4gPiA+ID4gPiA+IEJDTTU3NDE0IE5ldFh0cmVtZS1FIDEwR2IvMjVHYiBSRE1BIEV0
aGVybmV0IENvbnRyb2xsZXINCj4gPiA+ID4gPiA+ID4gPiA+IChyZXYNCj4gPiA+ID4gPiA+ID4g
PiA+IDAxKQ0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IFRoZSBjb21wYXJp
c29uIGJldHdlZW4gUkRNQSBhbmQgVENQIG9uIHRoZSBzYW1lIE5JQw0KPiA+ID4gPiA+ID4gPiA+
ID4gY291bGQgbWFrZSBtb3JlDQo+ID4gPiA+ID4gPiA+ID4gc2Vuc2UuDQo+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiBJdCBsb29rcyB0byBtZSBOSUNzIGFyZSBwb3dlcmZ1bCBub3cs
IGJ1dCBhZ2FpbiBhcyBJDQo+ID4gPiA+ID4gPiA+ID4gbWVudGlvbmVkIEkgZG9uJ3QgdGhpbmsg
aXQncyBhIHJlYXNvbiB3ZSBuZWVkIHRvIGRlcHJlY2F0ZQ0KPiA+ID4gPiA+ID4gPiA+IHJkbWEs
IGVzcGVjaWFsbHkgaWYgUUVNVSdzIHJkbWEgbWlncmF0aW9uIGhhcyB0aGUgY2hhbmNlDQo+ID4g
PiA+ID4gPiA+ID4gdG8gYmUgcmVmYWN0b3JlZA0KPiA+ID4gdXNpbmcgcnNvY2tldC4NCj4gPiA+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IElzIHRoZXJlIGFueW9uZSB3aG8gc3RhcnRlZCBs
b29raW5nIGludG8gdGhhdCBkaXJlY3Rpb24/DQo+ID4gPiA+ID4gPiA+ID4gV291bGQgaXQgbWFr
ZSBzZW5zZSB3ZSBzdGFydCBzb21lIFBvQyBub3c/DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gTXkgdGVhbSBoYXMgZmluaXNoZWQgdGhlIFBvQyByZWZhY3Rv
cmluZyB3aGljaCB3b3JrcyB3ZWxsLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBQcm9n
cmVzczoNCj4gPiA+ID4gPiA+ID4gMS4gIEltcGxlbWVudCBpby9jaGFubmVsLXJkbWEuYywgMi4g
IEFkZCB1bml0IHRlc3QNCj4gPiA+ID4gPiA+ID4gdGVzdHMvdW5pdC90ZXN0LWlvLWNoYW5uZWwt
cmRtYS5jIGFuZCB2ZXJpZnlpbmcgaXQgaXMNCj4gPiA+ID4gPiA+ID4gc3VjY2Vzc2Z1bCwgMy4g
IFJlbW92ZSB0aGUgb3JpZ2luYWwgY29kZSBmcm9tIG1pZ3JhdGlvbi9yZG1hLmMsIDQuDQo+ID4g
PiA+ID4gPiA+IFJld3JpdGUgdGhlIHJkbWFfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uIGFuZA0K
PiA+ID4gPiA+ID4gPiByZG1hX3N0YXJ0X2luY29taW5nX21pZ3JhdGlvbiBsb2dpYywgNS4gIFJl
bW92ZSBhbGwgcmRtYV94eHgNCj4gPiA+ID4gPiA+ID4gZnVuY3Rpb25zIGZyb20gbWlncmF0aW9u
L3JhbS5jLiAodG8gcHJldmVudCBSRE1BIGxpdmUNCj4gPiA+ID4gPiA+ID4gbWlncmF0aW9uIGZy
b20gcG9sbHV0aW5nIHRoZQ0KPiA+ID4gPiA+ID4gY29yZSBsb2dpYyBvZiBsaXZlIG1pZ3JhdGlv
biksIDYuICBUaGUgc29mdC1Sb0NFIGltcGxlbWVudGVkDQo+ID4gPiA+ID4gPiBieSBzb2Z0d2Fy
ZSBpcyB1c2VkIHRvIHRlc3QgdGhlIFJETUEgbGl2ZSBtaWdyYXRpb24uIEl0J3Mgc3VjY2Vzc2Z1
bC4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gV2Ugd2lsbCBiZSBzdWJtaXQgdGhlIHBh
dGNoc2V0IGxhdGVyLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoYXQncyBncmVhdCBuZXdz
LCB0aGFuayB5b3UhDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+IFBl
dGVyIFh1DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBGb3IgcmRtYSBwcm9ncmFtbWluZywgdGhlIGN1
cnJlbnQgbWFpbnN0cmVhbSBpbXBsZW1lbnRhdGlvbiBpcw0KPiA+ID4gPiA+IHRvIHVzZQ0KPiA+
ID4gcmRtYV9jbSB0byBlc3RhYmxpc2ggYSBjb25uZWN0aW9uLCBhbmQgdGhlbiB1c2UgdmVyYnMg
dG8gdHJhbnNtaXQgZGF0YS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IHJkbWFfY20gYW5kIGlidmVy
YnMgY3JlYXRlIHR3byBGRHMgcmVzcGVjdGl2ZWx5LiBUaGUgdHdvIEZEcw0KPiA+ID4gPiA+IGhh
dmUgZGlmZmVyZW50IHJlc3BvbnNpYmlsaXRpZXMuIHJkbWFfY20gZmQgaXMgdXNlZCB0byBub3Rp
ZnkNCj4gPiA+ID4gPiBjb25uZWN0aW9uIGVzdGFibGlzaG1lbnQgZXZlbnRzLCBhbmQgdmVyYnMg
ZmQgaXMgdXNlZCB0byBub3RpZnkNCj4gPiA+ID4gPiBuZXcgQ1FFcy4gV2hlbg0KPiA+ID4gcG9s
bC9lcG9sbCBtb25pdG9yaW5nIGlzIGRpcmVjdGx5IHBlcmZvcm1lZCBvbiB0aGUgcmRtYV9jbSBm
ZCwgb25seQ0KPiA+ID4gYSBwb2xsaW4gZXZlbnQgY2FuIGJlIG1vbml0b3JlZCwgd2hpY2ggbWVh
bnMgdGhhdCBhbiByZG1hX2NtIGV2ZW50DQo+ID4gPiBvY2N1cnMuIFdoZW4gdGhlIHZlcmJzIGZk
IGlzIGRpcmVjdGx5IHBvbGxlZC9lcG9sbGVkLCBvbmx5IHRoZQ0KPiA+ID4gcG9sbGluIGV2ZW50
IGNhbiBiZSBsaXN0ZW5lZCwgd2hpY2ggaW5kaWNhdGVzIHRoYXQgYSBuZXcgQ1FFIGlzIGdlbmVy
YXRlZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFJzb2NrZXQgaXMgYSBzdWItbW9kdWxlIGF0dGFj
aGVkIHRvIHRoZSByZG1hX2NtIGxpYnJhcnkgYW5kDQo+ID4gPiA+ID4gcHJvdmlkZXMgcmRtYSBj
YWxscyB0aGF0IGFyZSBjb21wbGV0ZWx5IHNpbWlsYXIgdG8gc29ja2V0IGludGVyZmFjZXMuDQo+
ID4gPiA+ID4gSG93ZXZlciwgdGhpcyBsaWJyYXJ5IHJldHVybnMgb25seSB0aGUgcmRtYV9jbSBm
ZCBmb3IgbGlzdGVuaW5nDQo+ID4gPiA+ID4gdG8gbGluaw0KPiA+ID4gc2V0dXAtcmVsYXRlZCBl
dmVudHMgYW5kIGRvZXMgbm90IGV4cG9zZSB0aGUgdmVyYnMgZmQgKHJlYWRhYmxlIGFuZA0KPiA+
ID4gd3JpdGFibGUgZXZlbnRzIGZvciBsaXN0ZW5pbmcgdG8gZGF0YSkuIE9ubHkgdGhlIHJwb2xs
IGludGVyZmFjZQ0KPiA+ID4gcHJvdmlkZWQgYnkgdGhlIFJTb2NrZXQgY2FuIGJlIHVzZWQgdG8g
bGlzdGVuIHRvIHJlbGF0ZWQgZXZlbnRzLg0KPiA+ID4gSG93ZXZlciwgUUVNVSB1c2VzIHRoZSBw
cG9sbCBpbnRlcmZhY2UgdG8gbGlzdGVuIHRvIHRoZSByZG1hX2NtIGZkDQo+IChnb3R0ZW4gYnkg
cmFjY2VwdCBBUEkpLg0KPiA+ID4gPiA+IEFuZCBjYW5ub3QgbGlzdGVuIHRvIHRoZSB2ZXJicyBm
ZCBldmVudC4NCj4gSSdtIGNvbmZ1c2VkLCB0aGUgcnNfcG9sbF9hcm0NCj4gOmh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC1yZG1hL3JkbWEtY29yZS9ibG9iL21hc3Rlci9saWJyZG1hY20vcnNvY2tl
dC5jIw0KPiBMMzI5MA0KPiBGb3IgU1RSRUFNLCBycG9sbCBzZXR1cCBmZCBmb3IgYm90aCBjcSBm
ZCBhbmQgY20gZmQuDQo+IA0KDQpSaWdodC4gQnV0IHRoZSBxdWVzdGlvbiBpcyBRRU1VIGRvIG5v
dCB1c2UgcnBvbGwgYnV0IGdpbGIncyBwcG9sbC4gOigNCg0KDQpSZWdhcmRzLA0KLUdvbmdsZWkN
Cg0K

