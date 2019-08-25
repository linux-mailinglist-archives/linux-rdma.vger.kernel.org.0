Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C19C297
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Aug 2019 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfHYIln (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Aug 2019 04:41:43 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:7254 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbfHYIln (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 25 Aug 2019 04:41:43 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7P8fGVL024307;
        Sun, 25 Aug 2019 01:41:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=bj3xqBbVAtE97WlFDOX2D2GjLxj7ItgVboOdaCxLnsE=;
 b=pdbxLve3fvKy3n6gr4y7KdHS/bLLdLgRjTkJc5uciiBcGVXaEzIyoxHr9sL2I66DNGKC
 gx9TUfKXX0fByc0KUN2Hoi3H+C5U2oOM6R0rRHC12iyzWA/OIvC0ZMix82tMRbkwWsy6
 Fr2C5wj2gw0UwFJk5DrSU9njyF52+21N5+degtU4oO/IXdfSaVTkX0wyxJlEPM4eRvpV
 2lTvSEDH6ZMRHeheo3+s5FwKDVx4rGs9IuqBKhRO7GYYeXqNcx2+vWf6GVdrz4XlPMTi
 8+Lv4/PFFJLkuGKYXnHXLOvPuK/rQeHbz5VWfWxF2AulFHOAfNynYgGEll/uFbTUdQDM VQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uk4rkan7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 25 Aug 2019 01:41:16 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 25 Aug
 2019 01:41:14 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.58) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 25 Aug 2019 01:41:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0h1xqUMTUxJfIUwx3ECSslfxWXFLzCZ2TZVWRMtKHnj2sK5BRsmdzmdM9WFBWu+wh946K47yL6SR7Mkco6XXcLqDPc1JEOgeiOX4YbNtAOSdjrn4DUk7jQEK6rwgWB8n+R2iRkDC3bxQk9avKdQx4jI269pLwmQI6Ge15TFGq4C6SMi/tJwX902/7uGfjPyw7LY0uLYXzl7O16D+IWFVleZ+98IR8U2pFULNOoRhfDkB1STH+OHwX+CTbr5Kn/TsikitHwsrShk8uXZ3r25VA7VlwNMxq2H1i7PFcoRihgSDvRE4So6FjNRwyDmm6iwZqmY1p9hwevZ5/mAMEIdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj3xqBbVAtE97WlFDOX2D2GjLxj7ItgVboOdaCxLnsE=;
 b=KQGVcByMtrbAKxkENF4+j5VqNzlq88jW9ilInMk34RrX/R+Idu8coKISX+LM4CoUs/Pa/Zl4ke8M3G/N1sXKQOBgggbhcNEcS1v6WEwoaD69U7qr3RaaAIDiyOoU+g3YCv1VV0QvJClQ/hO4QSe0CUb0EXXTaf1QoNs7eKm7bS0xnWhGoQeo2HM47jJWgJLjkjc9OdeGQ5LHA4aqm4mDHFO+Etr2/9pKzBVCRrGIkT4Uq5fbokffyis4lybbMqta4vebX9Tv9hCo9hI0usVoohpxM4PfxpRufPRqm6oelzezoutq7e18yvGN5t/s5MPIw3rLoVgEu4iJwg1eFY3vWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj3xqBbVAtE97WlFDOX2D2GjLxj7ItgVboOdaCxLnsE=;
 b=g4JRoRht9J+jlkYuXwO8bHL3xEmh94mNEJZofqzwMsifUFwQZUDRdatltc6jxxShKJgd0BEJ8gPayLws5QwGI/JvafgsO+xNcQwuocp0VdLpO5fd13a4uSvgxrPT8H0BMGUfbx6wTl8r7l/JgoyHVp4ijTghiA51H4u/MR7pIxc=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2879.namprd18.prod.outlook.com (20.179.22.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Sun, 25 Aug 2019 08:41:12 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2199.020; Sun, 25 Aug 2019
 08:41:12 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [PATCH v7 rdma-next 3/7] RDMA/efa: Use the common mmap_xa helpers
Thread-Topic: [PATCH v7 rdma-next 3/7] RDMA/efa: Use the common mmap_xa
 helpers
Thread-Index: AQHVV1G0UqvJfIfy/UuL/2jQOdB1iacHKZyAgARoUsA=
Date:   Sun, 25 Aug 2019 08:41:12 +0000
Message-ID: <MN2PR18MB3182C05D896D4FCA5CC86019A1A60@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-4-michal.kalderon@marvell.com>
 <6f524e9e-b866-d538-3dc9-322aa4e30b5f@amazon.com>
In-Reply-To: <6f524e9e-b866-d538-3dc9-322aa4e30b5f@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.178.37.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9813b531-c719-4550-1042-08d72937fc32
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB2879;
x-ms-traffictypediagnostic: MN2PR18MB2879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2879420161A97158279CDD96A1A60@MN2PR18MB2879.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01401330D1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(189003)(199004)(7736002)(64756008)(6436002)(7696005)(316002)(99286004)(107886003)(76176011)(446003)(186003)(14454004)(478600001)(33656002)(9686003)(476003)(6246003)(486006)(11346002)(54906003)(53546011)(6506007)(102836004)(66066001)(81156014)(53936002)(256004)(81166006)(8676002)(6116002)(3846002)(305945005)(66556008)(4326008)(66476007)(8936002)(25786009)(5660300002)(2906002)(66946007)(229853002)(66446008)(52536014)(6916009)(74316002)(26005)(76116006)(55016002)(71190400001)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2879;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iHUm29riawX+T/kia1Ov3yAfcuAF9EKb6wRD9rWtjJj6NhODe671AS43KiOvacjPaLRAun5cdSUnKGJ/gYyDXT9e78Y4sCrto+96LCZX24FKyN8nJsjNUu4dRbNPtSFaEWo05bdCZE+MrGigICxWVHfpQOum7XP/jCUTofUpg+jw2cOwS4Eba9t/hxNjTdwiAkJa8l9ucP2MULJqQZFL6eHN/UmndMXSTczYtRASuFtejEd317Q54wAiXNw6w9FoTpmNimdd5HnD6tyHZXKtal8aQyrBWfz5SyRlh2zWPbqxo/OjpNB9P8sfx6dXolvbBwF7lMwtWArddoiTpgc+lamahjT1WxI/LkGDbw6ET0q33rzTGzR7xNB/L18pFRJD5Kath62KUHy+BuYfE+WjQjLz1Kv+YPNamt5puNxxFEM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9813b531-c719-4550-1042-08d72937fc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2019 08:41:12.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLUfeaYrjQ6jD6lCC5i8TGM8HpM5cRrHGcdKNwFhKWZe7bd+Ebd0t7CH+v9XU2dWBwlr1fA2hYIq+p75lZ1SWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2879
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-25_07:2019-08-23,2019-08-25 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IEZyb206IGxpbnV4LXJkbWEtb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1yZG1hLQ0K
PiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBHYWwgUHJlc3NtYW4NCj4gDQo+
IE9uIDIwLzA4LzIwMTkgMTU6MTgsIE1pY2hhbCBLYWxkZXJvbiB3cm90ZToNCj4gPiAgaW50IGVm
YV9kZXN0cm95X3FwKHN0cnVjdCBpYl9xcCAqaWJxcCwgc3RydWN0IGliX3VkYXRhICp1ZGF0YSkg
IHsNCj4gPiArCXN0cnVjdCBlZmFfdWNvbnRleHQgKnVjb250ZXh0Ow0KPiANCj4gUmV2ZXJzZSB4
bWFzIHRyZWUgcGxlYXNlLg0Kb2sNCj4gDQo+ID4gIAlzdHJ1Y3QgZWZhX2RldiAqZGV2ID0gdG9f
ZWRldihpYnFwLT5wZC0+ZGV2aWNlKTsNCj4gPiAgCXN0cnVjdCBlZmFfcXAgKnFwID0gdG9fZXFw
KGlicXApOw0KPiA+ICAJaW50IGVycjsNCj4gPg0KPiA+ICAJaWJkZXZfZGJnKCZkZXYtPmliZGV2
LCAiRGVzdHJveSBxcFsldV1cbiIsIGlicXAtPnFwX251bSk7DQo+ID4gKwl1Y29udGV4dCA9IHJk
bWFfdWRhdGFfdG9fZHJ2X2NvbnRleHQodWRhdGEsIHN0cnVjdCBlZmFfdWNvbnRleHQsDQo+ID4g
KwkJCQkJICAgICBpYnVjb250ZXh0KTsNCj4gDQo+IENvbnNpZGVyIGluaXRpYWxpemluZyBvbiB1
Y29udGV4dCBkZWNsYXJhdGlvbi4NCm9rDQo+IA0KPiA+ICsNCj4gPiAgCWVyciA9IGVmYV9kZXN0
cm95X3FwX2hhbmRsZShkZXYsIHFwLT5xcF9oYW5kbGUpOw0KPiA+ICAJaWYgKGVycikNCj4gPiAg
CQlyZXR1cm4gZXJyOw0KPiA+DQo+ID4gKwlyZG1hX3VzZXJfbW1hcF9lbnRyeV9yZW1vdmUoJnVj
b250ZXh0LT5pYnVjb250ZXh0LCBxcC0NCj4gPnNxX2RiX21tYXBfa2V5KTsNCj4gPiArCXJkbWFf
dXNlcl9tbWFwX2VudHJ5X3JlbW92ZSgmdWNvbnRleHQtPmlidWNvbnRleHQsDQo+ID4gKwkJCQkg
ICAgcXAtPmxscV9kZXNjX21tYXBfa2V5KTsNCj4gDQo+IFRoZSBtbWFwIGVudHJpZXMgcmVtb3Zh
bCBzaG91bGQgaGFwcGVuIGJlZm9yZSBlZmFfZGVzdHJveV9xcF9oYW5kbGUuDQpvaw0KPiANCj4g
PiAgCWlmIChxcC0+cnFfY3B1X2FkZHIpIHsNCj4gPiAgCQlpYmRldl9kYmcoJmRldi0+aWJkZXYs
DQo+ID4gIAkJCSAgInFwLT5jcHVfYWRkclsweCVwXSBmcmVlZDogc2l6ZVslbHVdLA0KPiBkbWFb
JXBhZF1cbiIsIEBAIC01MDMsNg0KPiA+ICszOTIsMTAgQEAgaW50IGVmYV9kZXN0cm95X3FwKHN0
cnVjdCBpYl9xcCAqaWJxcCwgc3RydWN0IGliX3VkYXRhDQo+ICp1ZGF0YSkNCj4gPiAgCQkJICAm
cXAtPnJxX2RtYV9hZGRyKTsNCj4gPiAgCQlkbWFfdW5tYXBfc2luZ2xlKCZkZXYtPnBkZXYtPmRl
diwgcXAtPnJxX2RtYV9hZGRyLA0KPiBxcC0+cnFfc2l6ZSwNCj4gPiAgCQkJCSBETUFfVE9fREVW
SUNFKTsNCj4gPiArCQlyZG1hX3VzZXJfbW1hcF9lbnRyeV9yZW1vdmUoJnVjb250ZXh0LT5pYnVj
b250ZXh0LA0KPiA+ICsJCQkJCSAgICBxcC0+cnFfbW1hcF9rZXkpOw0KPiA+ICsJCXJkbWFfdXNl
cl9tbWFwX2VudHJ5X3JlbW92ZSgmdWNvbnRleHQtPmlidWNvbnRleHQsDQo+ID4gKwkJCQkJICAg
IHFwLT5ycV9kYl9tbWFwX2tleSk7DQo+IA0KPiBTYW1lLg0Kb2sNCj4gDQo+ID4gIAl9DQo+ID4N
Cj4gPiAgCWtmcmVlKHFwKTsNCj4gPiBAQCAtNTE1LDQ2ICs0MDgsNTUgQEAgc3RhdGljIGludCBx
cF9tbWFwX2VudHJpZXNfc2V0dXAoc3RydWN0IGVmYV9xcA0KPiAqcXAsDQo+ID4gIAkJCQkgc3Ry
dWN0IGVmYV9jb21fY3JlYXRlX3FwX3BhcmFtcw0KPiAqcGFyYW1zLA0KPiA+ICAJCQkJIHN0cnVj
dCBlZmFfaWJ2X2NyZWF0ZV9xcF9yZXNwICpyZXNwKSAgew0KPiA+ICsJdTY0IGFkZHJlc3M7DQo+
ID4gKwl1NjQgbGVuZ3RoOw0KPiA+ICsNCj4gPiAgCS8qDQo+ID4gIAkgKiBPbmNlIGFuIGVudHJ5
IGlzIGluc2VydGVkIGl0IG1pZ2h0IGJlIG1tYXBwZWQsIGhlbmNlIGNhbm5vdCBiZQ0KPiA+ICAJ
ICogY2xlYW5lZCB1cCB1bnRpbCBkZWFsbG9jX3Vjb250ZXh0Lg0KPiA+ICAJICovDQo+ID4gIAly
ZXNwLT5zcV9kYl9tbWFwX2tleSA9DQo+IA0KPiBOb3QgYSBiaWcgZGVhbCwgYnV0IG5vdyBpdCBt
YWtlcyBtb3JlIHNlbnNlIHRvIGFzc2lnbiBxcC0NCj4gPnNxX2RiX21tYXBfa2V5IGFuZCBhc3Np
Z24gdGhlIHJlc3BvbnNlIGxhdGVyIG9uLg0Kb2sNCj4gDQo+ID4gLQkJbW1hcF9lbnRyeV9pbnNl
cnQoZGV2LCB1Y29udGV4dCwgcXAsDQo+ID4gLQkJCQkgIGRldi0+ZGJfYmFyX2FkZHIgKyByZXNw
LT5zcV9kYl9vZmZzZXQsDQo+ID4gLQkJCQkgIFBBR0VfU0laRSwgRUZBX01NQVBfSU9fTkMpOw0K
PiA+IC0JaWYgKHJlc3AtPnNxX2RiX21tYXBfa2V5ID09IEVGQV9NTUFQX0lOVkFMSUQpDQo+ID4g
KwkJcmRtYV91c2VyX21tYXBfZW50cnlfaW5zZXJ0KCZ1Y29udGV4dC0+aWJ1Y29udGV4dCwgcXAs
DQo+ID4gKwkJCQkJICAgIGRldi0+ZGJfYmFyX2FkZHIgKw0KPiA+ICsJCQkJCSAgICByZXNwLT5z
cV9kYl9vZmZzZXQsDQo+ID4gKwkJCQkJICAgIFBBR0VfU0laRSwgRUZBX01NQVBfSU9fTkMpOw0K
PiA+ICsJaWYgKHJlc3AtPnNxX2RiX21tYXBfa2V5ID09IFJETUFfVVNFUl9NTUFQX0lOVkFMSUQp
DQo+ID4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4gLQ0KPiA+ICsJcXAtPnNxX2RiX21tYXBfa2V5
ID0gcmVzcC0+c3FfZGJfbW1hcF9rZXk7DQo+ID4gIAlyZXNwLT5zcV9kYl9vZmZzZXQgJj0gflBB
R0VfTUFTSzsNCj4gPg0KPiA+ICsJYWRkcmVzcyA9IGRldi0+bWVtX2Jhcl9hZGRyICsgcmVzcC0+
bGxxX2Rlc2Nfb2Zmc2V0Ow0KPiA+ICsJbGVuZ3RoID0gUEFHRV9BTElHTihwYXJhbXMtPnNxX3Jp
bmdfc2l6ZV9pbl9ieXRlcyArDQo+ID4gKwkJCSAgICAocmVzcC0+bGxxX2Rlc2Nfb2Zmc2V0ICYg
flBBR0VfTUFTSykpOw0KPiA+ICAJcmVzcC0+bGxxX2Rlc2NfbW1hcF9rZXkgPQ0KPiA+IC0JCW1t
YXBfZW50cnlfaW5zZXJ0KGRldiwgdWNvbnRleHQsIHFwLA0KPiA+IC0JCQkJICBkZXYtPm1lbV9i
YXJfYWRkciArIHJlc3AtDQo+ID5sbHFfZGVzY19vZmZzZXQsDQo+ID4gLQkJCQkgIFBBR0VfQUxJ
R04ocGFyYW1zLQ0KPiA+c3FfcmluZ19zaXplX2luX2J5dGVzICsNCj4gPiAtCQkJCQkgICAgIChy
ZXNwLT5sbHFfZGVzY19vZmZzZXQgJg0KPiB+UEFHRV9NQVNLKSksDQo+ID4gLQkJCQkgIEVGQV9N
TUFQX0lPX1dDKTsNCj4gPiAtCWlmIChyZXNwLT5sbHFfZGVzY19tbWFwX2tleSA9PSBFRkFfTU1B
UF9JTlZBTElEKQ0KPiA+ICsJCXJkbWFfdXNlcl9tbWFwX2VudHJ5X2luc2VydCgmdWNvbnRleHQt
PmlidWNvbnRleHQsIHFwLA0KPiA+ICsJCQkJCSAgICBhZGRyZXNzLA0KPiA+ICsJCQkJCSAgICBs
ZW5ndGgsDQo+ID4gKwkJCQkJICAgIEVGQV9NTUFQX0lPX1dDKTsNCj4gPiArCWlmIChyZXNwLT5s
bHFfZGVzY19tbWFwX2tleSA9PSBSRE1BX1VTRVJfTU1BUF9JTlZBTElEKQ0KPiA+ICAJCXJldHVy
biAtRU5PTUVNOw0KPiA+IC0NCj4gPiArCXFwLT5sbHFfZGVzY19tbWFwX2tleSA9IHJlc3AtPmxs
cV9kZXNjX21tYXBfa2V5Ow0KPiA+ICAJcmVzcC0+bGxxX2Rlc2Nfb2Zmc2V0ICY9IH5QQUdFX01B
U0s7DQo+ID4NCj4gPiAgCWlmIChxcC0+cnFfc2l6ZSkgew0KPiA+ICsJCWFkZHJlc3MgPSBkZXYt
PmRiX2Jhcl9hZGRyICsgcmVzcC0+cnFfZGJfb2Zmc2V0Ow0KPiA+ICAJCXJlc3AtPnJxX2RiX21t
YXBfa2V5ID0NCj4gPiAtCQkJbW1hcF9lbnRyeV9pbnNlcnQoZGV2LCB1Y29udGV4dCwgcXAsDQo+
ID4gLQkJCQkJICBkZXYtPmRiX2Jhcl9hZGRyICsgcmVzcC0NCj4gPnJxX2RiX29mZnNldCwNCj4g
PiAtCQkJCQkgIFBBR0VfU0laRSwgRUZBX01NQVBfSU9fTkMpOw0KPiA+IC0JCWlmIChyZXNwLT5y
cV9kYl9tbWFwX2tleSA9PSBFRkFfTU1BUF9JTlZBTElEKQ0KPiA+ICsJCQlyZG1hX3VzZXJfbW1h
cF9lbnRyeV9pbnNlcnQoJnVjb250ZXh0LQ0KPiA+aWJ1Y29udGV4dCwgcXAsDQo+ID4gKwkJCQkJ
CSAgICBhZGRyZXNzLCBQQUdFX1NJWkUsDQo+ID4gKwkJCQkJCSAgICBFRkFfTU1BUF9JT19OQyk7
DQo+ID4gKwkJaWYgKHJlc3AtPnJxX2RiX21tYXBfa2V5ID09DQo+IFJETUFfVVNFUl9NTUFQX0lO
VkFMSUQpDQo+ID4gIAkJCXJldHVybiAtRU5PTUVNOw0KPiA+IC0NCj4gPiArCQlxcC0+cnFfZGJf
bW1hcF9rZXkgPSByZXNwLT5ycV9kYl9tbWFwX2tleTsNCj4gPiAgCQlyZXNwLT5ycV9kYl9vZmZz
ZXQgJj0gflBBR0VfTUFTSzsNCj4gPg0KPiA+ICsJCWFkZHJlc3MgPSB2aXJ0X3RvX3BoeXMocXAt
PnJxX2NwdV9hZGRyKTsNCj4gPiAgCQlyZXNwLT5ycV9tbWFwX2tleSA9DQo+ID4gLQkJCW1tYXBf
ZW50cnlfaW5zZXJ0KGRldiwgdWNvbnRleHQsIHFwLA0KPiA+IC0JCQkJCSAgdmlydF90b19waHlz
KHFwLT5ycV9jcHVfYWRkciksDQo+ID4gLQkJCQkJICBxcC0+cnFfc2l6ZSwNCj4gRUZBX01NQVBf
RE1BX1BBR0UpOw0KPiA+IC0JCWlmIChyZXNwLT5ycV9tbWFwX2tleSA9PSBFRkFfTU1BUF9JTlZB
TElEKQ0KPiA+ICsJCQlyZG1hX3VzZXJfbW1hcF9lbnRyeV9pbnNlcnQoJnVjb250ZXh0LQ0KPiA+
aWJ1Y29udGV4dCwgcXAsDQo+ID4gKwkJCQkJCSAgICBhZGRyZXNzLCBxcC0+cnFfc2l6ZSwNCj4g
PiArCQkJCQkJICAgIEVGQV9NTUFQX0RNQV9QQUdFKTsNCj4gPiArCQlpZiAocmVzcC0+cnFfbW1h
cF9rZXkgPT0gUkRNQV9VU0VSX01NQVBfSU5WQUxJRCkNCj4gPiAgCQkJcmV0dXJuIC1FTk9NRU07
DQo+ID4gKwkJcXAtPnJxX21tYXBfa2V5ID0gcmVzcC0+cnFfbW1hcF9rZXk7DQo+ID4NCj4gPiAg
CQlyZXNwLT5ycV9tbWFwX3NpemUgPSBxcC0+cnFfc2l6ZTsNCj4gPiAgCX0NCj4gPiBAQCAtNzc1
LDYgKzY3Nyw5IEBAIHN0cnVjdCBpYl9xcCAqZWZhX2NyZWF0ZV9xcChzdHJ1Y3QgaWJfcGQgKmli
cGQsDQo+ID4gIAkJCQkgRE1BX1RPX0RFVklDRSk7DQo+ID4gIAkJaWYgKCFycV9lbnRyeV9pbnNl
cnRlZCkNCj4gDQo+IE5vdyB0aGF0IHdlIHN0b3JlIHRoZSBrZXlzIG9uIHRoZSBRUCBvYmplY3Qg
d2UgY2FuIHJlbW92ZSB0aGUNCj4gcnFfZW50cnlfaW5zZXJ0ZWQgdmFyaWFibGUgYW5kIHRlc3Qg
Zm9yICFxcC0+cnFfbW1hcF9rZXkuDQpvaw0KPiANCj4gPiAgCQkJZnJlZV9wYWdlc19leGFjdChx
cC0+cnFfY3B1X2FkZHIsIHFwLT5ycV9zaXplKTsNCj4gPiArCQllbHNlDQo+ID4gKwkJCXJkbWFf
dXNlcl9tbWFwX2VudHJ5X3JlbW92ZSgmdWNvbnRleHQtDQo+ID5pYnVjb250ZXh0LA0KPiA+ICsJ
CQkJCQkgICAgcXAtPnJxX21tYXBfa2V5KTsNCj4gDQo+IE90aGVyIGVudHJpZXMgbmVlZCB0byBi
ZSByZW1vdmVkIGFzIHdlbGwsIG90aGVyd2lzZSB0aGUgcmVmY291bnQgd29uJ3QNCj4gcmVhY2gg
emVyby4gVGhpcyBlcnJvciBmbG93IHNob3VsZCBub3cgYmUgc2ltaWxhciB0byBlZmFfZGVzdHJv
eV9xcC4gSSB0aGluaw0KPiB0aGF0IG1lYW5zIGxvc2luZyB0aGUgZnJlZV9wYWdlc19leGFjdCB0
b28uDQpOb3Qgc3VyZSBJIHVuZGVyc3RhbmQsIGhvdyBjYW4gd2UgbG9vc2UgdGhlIGZyZWVfcGFn
ZXNfZXhhY3QgPyBpZiB0aGUgZW50cnkgd2FzbuKAmXQgDQpJbnNlcnRlZCBpbnRvIHRoZSBtbWFw
X3hhIHdoYXQgZmxvdyB3aWxsIGZyZWUgdGhlIHBhZ2VzID8gDQoNCj4gDQo+ID4gIAl9DQo+ID4g
IGVycl9mcmVlX3FwOg0KPiA+ICAJa2ZyZWUocXApOw0KPiANCj4gUHJldHR5IG11Y2ggdGhlIHNh
bWUgY29tbWVudHMgZm9yIHRoZSBDUSBwYXJ0cyBhcyB0aGUgUVAuDQpvaw0K
