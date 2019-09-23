Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD90BB187
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405796AbfIWJh3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 05:37:29 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:24568 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406212AbfIWJh2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Sep 2019 05:37:28 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8N9aBbe000955;
        Mon, 23 Sep 2019 02:37:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=0vn/6xi40WPd0QnRlxvMSgyzq57lShzcCAbpmSq+94A=;
 b=I5ljcV8l9NUmeKERvA/NtZKsOevA0hLKCYuoTCiXWEo4vhdCqZZKQQwFVFcPOkRIt00X
 NvfxugCViBNn8E1o8rGo4vp9QQLv60t88bVdQhi9j/2fcA1FUOZKLl/55vLdeA902ZiJ
 3GQdWbfoGKKnTW/mApM2BXLIxeXb9XpDan/pST60f0Bt5pV0L7r+mt4p8jr0vPOHf48X
 loazVR5BPq/8TW0+cnPUHlXaoxIjxnmRqO+YQBfNfRAqvqV2/9AocqHkLrrP97HfGp0X
 iKiQ7QfcOaiEN2BmYFDDwksJgrCPrpMzLeh8mFoFEZiNFwkMa4XkMhpYmtVsgoPVlhD6 PQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2v5h7qdvsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 02:37:26 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 23 Sep
 2019 02:37:25 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.55) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Sep 2019 02:37:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epM5hdP508wX4DYRuLmZk9d6qsu4chbOYGGFoxOawSDWlDovlCjxXYitmAJjHEmvI4LrxgHyq+pb+LyQKqYutITYhhum/Y2fz2x50BwksTVdUzgKfJArsN9dhd/6R0jf7pjp4dB3yS3ie5UR1dFrx96HiJ9urn62oaiegpDxNJ02LZSG+j9Ck4vVKryxf4pgz3w6xnyjSTXx/R5hEeIm3c9A4RBkvRoMZgyLBySxsYtOqTkcorVLCoFuxVA42ttUdlYI/CMRaTMDSHr/HQrrK+adRdsQXE0W9fQt+inqy7QAcPrJkKxGuKRf/Ux6hwNLJs5Rc0J9CcxgX2cIKNnsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vn/6xi40WPd0QnRlxvMSgyzq57lShzcCAbpmSq+94A=;
 b=aPyaUdYC/VvrOHVNXxPLwetuZtqf8PXVp68ASubazozFie1eizZHwVAq5q7eMbof+U3QoflyD+lwdz/Y+K++QvJ7yFw6Txfhl/QtX5pfunPGM48czSE2wzOcopr3J2xwJbXuRu8X/TUTIg/DXZ3vr3qOSZPaz53mbkocZ5vVwIJIDqHA2kq94W4N1E4IEl0H2KsE2ty/sT9Cs6aIRr3iCinNuRQJt95FBjihB4fI+eFMkno17dqs1LfRLJdwTgDSJFyvrhVMc119nuaxKIS9iqqjxzR2KMZ975fQ4PiNLZEJ9jfALrN8xRk6wagHYLFi/qLbDwfQ0ftMRsCxr4bsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vn/6xi40WPd0QnRlxvMSgyzq57lShzcCAbpmSq+94A=;
 b=UKSlJIvxfBnk+KJP5wHHfyNv4aAY9JjxuqNbOQRqG1dGYeeeshn/aQW+y/eIxQJ4yhtgswEIRWg/VwAC0OCRk39V0VdWehGMgX5umGDjVqm/KedryUrswqDGAn9WSr08tFAOz7ufFv+d11/3OUe2L6ntjhj/6Hc43vi35xS6gyM=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3344.namprd18.prod.outlook.com (10.255.238.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 23 Sep 2019 09:37:23 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 09:37:23 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell overflow
 recovery support
Thread-Topic: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell overflow
 recovery support
Thread-Index: AQHVb7v6X4FO+ik660mnSjiQy5xfTac5BWHg
Date:   Mon, 23 Sep 2019 09:37:23 +0000
Message-ID: <MN2PR18MB318282190B33DD8DEF5E0F2CA1850@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-7-michal.kalderon@marvell.com>
 <20190919180224.GE4132@ziepe.ca>
 <a0e19fb2-cd5c-4394-16d6-75ac856340b4@amazon.com>
 <20190920133817.GB7095@ziepe.ca>
 <82541758-3e72-d485-6923-cf3336a4297a@amazon.com>
In-Reply-To: <82541758-3e72-d485-6923-cf3336a4297a@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 307bb0ea-f151-4efc-e40c-08d74009a38a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3344;
x-ms-traffictypediagnostic: MN2PR18MB3344:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3344E1EBCBD01F7A183BB60CA1850@MN2PR18MB3344.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39850400004)(366004)(346002)(396003)(376002)(199004)(189003)(14454004)(256004)(9686003)(54906003)(66946007)(81156014)(66446008)(64756008)(66556008)(66476007)(52536014)(81166006)(8936002)(2906002)(99286004)(110136005)(5660300002)(229853002)(6436002)(8676002)(55016002)(186003)(7696005)(33656002)(74316002)(6116002)(4326008)(25786009)(478600001)(53546011)(316002)(6246003)(76176011)(305945005)(102836004)(6506007)(66066001)(3846002)(71200400001)(11346002)(71190400001)(7736002)(86362001)(486006)(26005)(446003)(476003)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3344;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TT3JmPwpneX2OKMYFZdOYubAdCSS25zAV+u3hZ2JCCtMR4mNcxm8Cwkx6wM9+bsfjKgxBYc4sXQY1Y7iRd8zMmRr6853N7KO7zQJsL/aFYjMg/5sQy4DBntJPGITBJDEqDSr4e8EdGPIYYiiEjrg4qBIT5T7UlXPzvoWTE5sTLFUPujpz9m6ms8z4fvREtq3YDcexaHMCQRygsRt16iOCxS8OgiP2nZs48zyyvxiNJTnqEs2jJyv7JYUpeuc78DldzeVyoF38q5e/MnyPl+3dtJhW1Y8Zn1HntdOUnYvPCs13gWde09uYQKyC/F6MqmqvZw1/2p9q/ZvIyaCA9pzISOfLsmPAFAJ7olabV/eNhWcSx8zHQS/XOY1aymO1Cur1GISC77osEZ+MTu6ty3M8GOCLEtbamRu263nU7Sc+KU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 307bb0ea-f151-4efc-e40c-08d74009a38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 09:37:23.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4h62vLVguPW71+OmBfspcEkoKPEc/AD3YmIbbbNhLoxSj5VHk9gfcbg+4BwzZFW0H0ZdcFeT4mV1fHJeowV4bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3344
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-23_03:2019-09-23,2019-09-23 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgR2FsIFByZXNzbWFuDQo+IA0KPiBP
biAyMC8wOS8yMDE5IDE2OjM4LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gRnJpLCBT
ZXAgMjAsIDIwMTkgYXQgMDQ6MzA6NTJQTSArMDMwMCwgR2FsIFByZXNzbWFuIHdyb3RlOg0KPiA+
PiBPbiAxOS8wOS8yMDE5IDIxOjAyLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4+PiBPbiBU
aHUsIFNlcCAwNSwgMjAxOSBhdCAwMTowMToxNlBNICswMzAwLCBNaWNoYWwgS2FsZGVyb24gd3Jv
dGU6DQo+ID4+Pg0KPiA+Pj4+IEBAIC0zNDcsNiArMzYwLDkgQEAgdm9pZCBxZWRyX21tYXBfZnJl
ZShzdHJ1Y3QNCj4gcmRtYV91c2VyX21tYXBfZW50cnkNCj4gPj4+PiAqcmRtYV9lbnRyeSkgIHsN
Cj4gPj4+PiAgCXN0cnVjdCBxZWRyX3VzZXJfbW1hcF9lbnRyeSAqZW50cnkgPQ0KPiA+Pj4+IGdl
dF9xZWRyX21tYXBfZW50cnkocmRtYV9lbnRyeSk7DQo+ID4+Pj4NCj4gPj4+PiArCWlmIChlbnRy
eS0+bW1hcF9mbGFnID09IFFFRFJfVVNFUl9NTUFQX1BIWVNfUEFHRSkNCj4gPj4+PiArCQlmcmVl
X3BhZ2UoKHVuc2lnbmVkIGxvbmcpcGh5c190b192aXJ0KGVudHJ5LT5hZGRyZXNzKSk7DQo+ID4+
Pj4gKw0KPiA+Pj4NCj4gPj4+IFdoaWxlIGl0IGlzbid0IHdyb25nIGl0IGRvIGl0IHRoaXMgd2F5
LCB3ZSBkb24ndCBuZWVkIHRoaXMNCj4gPj4+IG1tYXBfZnJlZSgpIHN0dWZmIGZvciBub3JtYWwg
Q1BVIHBhZ2VzLiBUaG9zZSBhcmUgcmVmY291bnRlZCBhbmQNCj4gPj4+IHFlZHIgY2FuIHNpbXBs
eSBjYWxsIGZyZWVfcGFnZSgpIGR1cmluZyB0aGUgdGVhcmRvd24gb2YgdGhlIHVvYmplY3QNCj4g
Pj4+IHRoYXQgaXMgdXNpbmcgdGhlIHRoaXMgcGFnZS4gVGhpcyBpcyB3aGF0IG90aGVyIGRyaXZl
cnMgYWxyZWFkeSBkby4NCj4gPj4NCj4gPj4gVGhpcyBpcyBwcmV0dHkgbXVjaCB3aGF0IEVGQSBk
b2VzIGFzIHdlbGwuICBXaGVuIHdlIGFsbG9jYXRlIHBhZ2VzDQo+ID4+IGZvciB0aGUgdXNlciAo
Q1EgZm9yIGV4YW1wbGUpLCB3ZSBETUEgbWFwIHRoZW0gYW5kIGxhdGVyIG9uIG1tYXANCj4gdGhl
bQ0KPiA+PiB0byB0aGUgdXNlci4gV2UgZXhwZWN0IHRob3NlIHBhZ2VzIHRvIHJlbWFpbiB1bnRp
bCB0aGUgZW50cnkgaXMNCj4gPj4gZnJlZWQsIGhvdyBjYW4gd2UgY2FsbCBmcmVlX3BhZ2UsIHdo
byBpcyBob2xkaW5nIGEgcmVmY291bnQgb24gdGhvc2UNCj4gPj4gZXhjZXB0IGZvciB0aGUgZHJp
dmVyPw0KPiA+DQo+ID4gZnJlZV9wYWdlIGlzIGtpbmQgb2YgYSBsaWUsIGl0IGlzIG1vcmUgbGlr
ZSBwdXRfcGFnZSAoc2VlDQo+ID4gX19mcmVlX3BhZ2VzKS4gSSB0aGluayB0aGUgZGlmZmVyZW5j
ZSBpcyB0aGF0IGl0IGFzc3VtZXMgdGhlIHBhZ2UgY2FtZQ0KPiA+IGZyb20gYWxsb2NfcGFnZSBh
bmQgc2tpcHMgc29tZSBnZW5lcmljIHN0dWZmIHdoZW4gZnJlZWluZyBpdC4NCj4gPg0KPiA+IFdo
ZW4gdGhlIGRyaXZlciBkb2VzIHZtX2luc2VydF9wYWdlIHRoZSB2bWEgaG9sZHMgYW5vdGhlciBy
ZWZjb3VudCBhbmQNCj4gPiB0aGUgcmVmY291bnQgZG9lcyBub3QgZ28gdG8gemVybyB1bnRpbCB0
aGF0IHBhZ2UgZHJvcHMgb3V0IG9mIHRoZSB2bWENCj4gPiAoaWUgYXQgdGhlIHNhbWUgdGltZSBt
bWFwX2ZyZWUgYWJvdmUgaXMgY2FsbGVkKS4NCj4gPg0KPiA+IFRoZW4gX19wdXRfcGFnZSB3aWxs
IGRvIHRoZSBmcmVlX3VucmVmX3BhZ2UoKSwgZXRjLg0KPiA+DQo+ID4gU28gZm9yIENQVSBwYWdl
cyBpdCBpcyBmaW5lIHRvIG5vdCB1c2UgbW1hcF9mcmVlIHNvIGxvbmcgYXMNCj4gPiB2bV9pbnNl
cnRfcGFnZSBpcyB1c2VkDQo+IA0KPiBUaGFua3MsIEkgZGlkIG5vdCBrbm93IHRoaXMsIGl0IHNp
bXBsaWZpZXMgdGhpbmdzLg0KPiBJbiB0aGF0IGNhc2UsIG1heWJlIHRoZSBtbWFwX2ZyZWUgY2Fs
bGJhY2sgaXMgcmVkdW5kYW50Lg0KDQpXZSBzdGlsbCBuZWVkIGl0IHRvIGZyZWUgdGhlIGVudHJ5
IHRob3VnaCAtIHJpZ2h0ID8gDQpHYWwsIHdoZXJlIGRvIHlvdSBmcmVlIHlvdXIgaGFyZHdhcmUg
cmVzb3VyY2VzID8gDQo=
