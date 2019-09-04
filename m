Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5602EA7C00
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 08:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfIDGuf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Sep 2019 02:50:35 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:8212 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbfIDGuf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Sep 2019 02:50:35 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x846jQGU014491;
        Tue, 3 Sep 2019 23:50:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=1tD4Qsk8sFPOvWmBd+m0Tl1UbPganJNSbQeLuUQx5kU=;
 b=ZEN6EiBYpsiDILCL2LDLk8nQiX9crzyRScuPb29R2YskGgA7HoNL2Bs1oxa9Nq0fAwYB
 XxBAGk7IGZN0PbPqiOZSupPUasCQKgDZ2Nk0r0Y+3cmec7oxMOzbZu/A8/DOLwOnOH65
 LlCf96nyCVIScIrrPYd9fNxqq9fXsdvuzsatQc+BYP36FtbiuO7lwwXo6DYleaHrCk5A
 eDJnjoaXUBtOlP2F+OAb1aLSGYjmcpWJJMdVR4rskeR5jyPc8UE/pYNNHWnrjbaI0mHc
 WGe4vu4dNcUUTjrxyRyoVrcXKvbfjPDIN8nvayyLJcNKFBYIkvll+9p3bjBpWmXFw1hn gQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdmcr30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 03 Sep 2019 23:50:27 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 3 Sep
 2019 23:50:25 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.57) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 3 Sep 2019 23:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZWvyg5gaD3EpqHDRTuk8mGqO9NcqKRsWcfP8zN2swaeJ14gRTnHbGmyFR+IMD+mp2hOelBEuZ8hUD62Z/aLlskAhzmdwkCbNv/2eJe75I+0dDvWrhNXGmohwTFNBOsQ20zBwDKhcEGK8DKP4VWZcx8BRoZ+lX9PVkwAfvXJKv45nW0udgD0k7mo9Upa5yewM+uarsTZfopyLFmR9JJwbV9WfaMno8vpDxK9fTH5DaujgUopfB00c5nHDfODH1/SVPSNG3NqQ//njssthCzNnfevBHiqvprvSN/eKCoVu2qwe3qamC75a7DowlD0JgM98uRPbtejvZdb1TijBPVM7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tD4Qsk8sFPOvWmBd+m0Tl1UbPganJNSbQeLuUQx5kU=;
 b=lIq0BMrc98wOr27qv8nqykoOgNQfY7iMFmMQF7EvjzcYBxXe1y4eDtY9r4zRPpxavKEV7+0Nq5An4WO7vSXOtk7IY4lKMnRb0Eo+zMX8JFQuPzqR1xHFRemcgWaDTXsX+jM1BLVqPsQVH/cVujzIJZeBECCdZqtS6DJycE6e5z3gXFH+w4sv7qM22cNJT9lumGEkvGnw+OTwsQFWMSCdZkuvT2WPA48GmfW364XNseisfwL6o1PRDSV3YYZUJVrP8LqLrNMKARMiimweqHqPMBftaRJgYPl7XRgapIvUeuK3xBN62Uw7HeepJU45XPjFq2EvxoBoVfEK6PSDEVJNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tD4Qsk8sFPOvWmBd+m0Tl1UbPganJNSbQeLuUQx5kU=;
 b=An92SRi2Ux0tFhhawYKTeFS6KMNFi1PqzkHzTo4om8dVsB6R/dpbl7FYG9fImb347UrcSIDfXblP0kkhYVsmTlFdZezxLGwxJbsAfkDWjL0dedLcD8mAfxmDbnkluW/nBk3buYt6IC1F07Wpau5S35MdGUo1D5/dbeqaFl9WOgM=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2397.namprd18.prod.outlook.com (20.179.80.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Wed, 4 Sep 2019 06:50:23 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2220.021; Wed, 4 Sep 2019
 06:50:23 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [EXT] Re: [PATCH v9 rdma-next 4/7] RDMA/siw: Use the common
 mmap_xa helpers
Thread-Topic: [EXT] Re: [PATCH v9 rdma-next 4/7] RDMA/siw: Use the common
 mmap_xa helpers
Thread-Index: AQHVYasFgSdPmda+4UKWs++Af78LsacaAMMAgAEVXuA=
Date:   Wed, 4 Sep 2019 06:50:22 +0000
Message-ID: <MN2PR18MB3182DB1681D23B4EC4B505F6A1B80@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190902162314.17508-5-michal.kalderon@marvell.com>,<20190902162314.17508-1-michal.kalderon@marvell.com>
 <OF42518E6C.4E8F9E06-ON0025846A.004B7E79-0025846A.004E54B7@notes.na.collabserv.com>
In-Reply-To: <OF42518E6C.4E8F9E06-ON0025846A.004B7E79-0025846A.004E54B7@notes.na.collabserv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24b8f33c-3810-48bc-a1da-08d7310428e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2397;
x-ms-traffictypediagnostic: MN2PR18MB2397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB239741669460D2A5032E3221A1B80@MN2PR18MB2397.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(86362001)(81166006)(476003)(99286004)(66946007)(81156014)(11346002)(76116006)(446003)(486006)(316002)(102836004)(8676002)(4326008)(25786009)(256004)(478600001)(33656002)(7736002)(2906002)(305945005)(8936002)(14454004)(26005)(71190400001)(66556008)(7696005)(6116002)(3846002)(76176011)(9686003)(55016002)(6506007)(52536014)(54906003)(5660300002)(53936002)(6436002)(107886003)(71200400001)(66476007)(6246003)(186003)(6916009)(64756008)(66446008)(66066001)(229853002)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2397;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pyw2e4a6uoGIb58GAvy9w1DcMtVI/cmeBJomQoROjFg9783qt4kDQV8euFd2k7fw0TjGaSoOaZXqZX5eOHVK09qmbAGlPnicwtiRfq7wka7cD8NrzO6cKx8oCEv7+a0qiZNilpNLEitXlSYrpnYjnTntmWezRKjfWgcjyMjQvCAJm/ufdjiURBM9mCoKuaMCvuGXHdZ4/UZ5AK1wyGn6cfWi7jboKNF9aGskqBBmsrN1+HvnlyJNMlREqJiOU8lhakx+PdM9g+u1UejbHwMTmfdPmEKocgMxw4dbgW3OiHreakpMeq/POYM7xWPXTGXKvIhGCqMsEpsP4Oc+f96hE0lC+VikAPsjRLS5vzUUpdaZSEFSnmyygWmqycvLOVzW++n4nf1jeQ2yEdvMEnmX1SVLazrRSzAU/LMjvAHxCzA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b8f33c-3810-48bc-a1da-08d7310428e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 06:50:22.9745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmAxhkeCf85Py6zeIGbAwdYED/1xZboCDG3kdHg3+0iAIFWknbEY9Ee77AFqObt1ju7f5/vAsa1LVOYX6wXfRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2397
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_01:2019-09-03,2019-09-04 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgU2VwdGVtYmVyIDMsIDIwMTkgNToxNiBQTQ0KPiANCj4gRXh0ZXJuYWwgRW1haWwNCj4g
DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0iTWljaGFsIEthbGRlcm9uIiA8bWljaGFsLmthbGRl
cm9uQG1hcnZlbGwuY29tPiB3cm90ZTogLS0tLS0NCj4gDQo+ID5UbzogPG1rYWxkZXJvbkBtYXJ2
ZWxsLmNvbT4sIDxhZWxpb3JAbWFydmVsbC5jb20+LCA8amdnQHppZXBlLmNhPiwNCj4gPjxkbGVk
Zm9yZEByZWRoYXQuY29tPiwgPGJtdEB6dXJpY2guaWJtLmNvbT4sDQo+IDxnYWxwcmVzc0BhbWF6
b24uY29tPiwNCj4gPjxzbGV5Ym9AYW1hem9uLmNvbT4sIDxsZW9uQGtlcm5lbC5vcmc+DQo+ID5G
cm9tOiAiTWljaGFsIEthbGRlcm9uIiA8bWljaGFsLmthbGRlcm9uQG1hcnZlbGwuY29tPg0KPiA+
RGF0ZTogMDkvMDIvMjAxOSAwNjoyNVBNDQo+ID5DYzogPGxpbnV4LXJkbWFAdmdlci5rZXJuZWwu
b3JnPiwgIk1pY2hhbCBLYWxkZXJvbiINCj4gPjxtaWNoYWwua2FsZGVyb25AbWFydmVsbC5jb20+
LCAiQXJpZWwgRWxpb3IiDQo+ID48YXJpZWwuZWxpb3JAbWFydmVsbC5jb20+DQo+ID5TdWJqZWN0
OiBbRVhURVJOQUxdIFtQQVRDSCB2OSByZG1hLW5leHQgNC83XSBSRE1BL3NpdzogVXNlIHRoZQ0K
PiBjb21tb24NCj4gPm1tYXBfeGEgaGVscGVycw0KPiA+DQo+ID5SZW1vdmUgdGhlIGZ1bmN0aW9u
cyByZWxhdGVkIHRvIG1hbmFnaW5nIHRoZSBtbWFwX3hhIGRhdGFiYXNlLg0KPiA+VGhpcyBjb2Rl
IGlzIG5vdyBjb21tb24gaW4gaWJfY29yZS4gVXNlIHRoZSBjb21tb24gQVBJJ3MgaW5zdGVhZC4N
Cj4gPg0KPiA+U2lnbmVkLW9mZi1ieTogQXJpZWwgRWxpb3IgPGFyaWVsLmVsaW9yQG1hcnZlbGwu
Y29tPg0KPiA+U2lnbmVkLW9mZi1ieTogTWljaGFsIEthbGRlcm9uIDxtaWNoYWwua2FsZGVyb25A
bWFydmVsbC5jb20+DQo+ID4tLS0NCj4gPiBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5o
ICAgICAgIHwgIDIwICsrKy0NCj4gPiBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWlu
LmMgIHwgICAxICsNCj4gPiBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jIHwg
MjE2DQo+ID4rKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ID4gZHJpdmVycy9p
bmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuaCB8ICAgMSArDQo+ID4gNCBmaWxlcyBjaGFuZ2Vk
LCAxMzEgaW5zZXJ0aW9ucygrKSwgMTA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID5kaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaA0KPiA+Yi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npdy5oDQo+ID5pbmRleCA3N2IxYWFiZjZmZjMuLmMyMGI0ZWUxY2I0YiAxMDA2
NDQNCj4gPi0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmgNCj4gPisrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmgNCj4gPkBAIC0yMjAsNyArMjIwLDcgQEAgc3Ry
dWN0IHNpd19jcSB7DQo+ID4gCXUzMiBjcV9nZXQ7DQo+ID4gCXUzMiBudW1fY3FlOw0KPiA+IAli
b29sIGtlcm5lbF92ZXJiczsNCj4gPi0JdTMyIHhhX2NxX2luZGV4OyAvKiBtbWFwIGluZm9ybWF0
aW9uIGZvciBDUUUgYXJyYXkgKi8NCj4gPisJdTY0IGNxX2tleTsgLyogbW1hcCBpbmZvcm1hdGlv
biBmb3IgQ1FFIGFycmF5ICovDQo+ID4gCXUzMiBpZDsgLyogRm9yIGRlYnVnZ2luZyBvbmx5ICov
DQo+ID4gfTsNCj4gPg0KPiA+DQo+IA0KPiBNaWNoYWwsIG1hbnkgdGhhbmtzIGZvciB0YWtpbmcg
Y2FyZSBvZg0KPiBpdCBmb3IgdGhlIHNpdyBkcml2ZXIhIE1heWJlIHdlIGNhbg0KPiByZW1vdmUg
dGhlIGtleSBzYW5pdHkgY2hlY2tzIGJlZm9yZSBjYWxsaW5nDQo+IHJkbWFfdXNlcl9tbWFwX2Vu
dHJ5X3JlbW92ZSgpLiBUaGF0J3MgbXkgb25seSBwb2ludCB3aXRoIHRoZSBjdXJyZW50DQo+IHBh
dGNoIC0gbm90aGluZyBmdW5jdGlvbmFsLCBhbmQgcHJvYmFibHkganVzdCBPSyBhcyBpcy4NCkFz
IEknbSBhbHJlYWR5IHNlbmRpbmcgYW5vdGhlciBzZXJpZXMgSSB3aWxsIHJlbW92ZSB0aGUgZG91
YmxlIHNhbml0eSBjaGVja3MuIA0KVGhhbmtzLg0KDQo+IA0KPiBJIHRlc3RlZCBpdCB3aXRoIGJv
dGggdXNlciBjbGllbnRzIChycGluZykgYW5kIGtlcm5lbCBjbGllbnRzIChudm1mIHRhcmdldCkg
YW5kIGl0DQo+IHdvcmtlZCBPSy4NCj4gDQpHcmVhdCB0aGFua3MuDQo+IA0KPiBSZXZpZXdlZC1i
eTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo+IFRlc3RlZC1ieTogQmVy
bmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQoNCg==
