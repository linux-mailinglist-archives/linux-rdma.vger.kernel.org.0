Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE30825B4C8
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 21:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBTxm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 15:53:42 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52656 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726285AbgIBTxl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 15:53:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 082JqZss015458;
        Wed, 2 Sep 2020 12:53:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=ZVZRdVFbS9gSu8VaiwW6fBPO0voalpLOMjniUNbqZK8=;
 b=StaW2GRu+soSyENNpzTKK3yv5OLOw/5NbSjFAwS4wfHMlJRc933+00O1hSOdrl0ovzAR
 KVwu3pdX/RI1d6xgoHocOZuPeKYmL6nwMoQJ4N5U01JbzNgonnoZj8/p3EgtFARb3efi
 DyEWd3bCZ5OqIC8G6Nm0iQ3sjmQLLppPshB8AkaCwjQKefDWhJiLJqf+50xaMlGbymgJ
 cRpj7M0ha6WSsZafD43C6hVM8xqGdHvRVGZoVax3LdjJf27M9mGhtbo1nflreGn1JQng
 0Qs+vBDGpxZOWNacUU24kfQYXvvE93G6bkqryYzYUXrAc4SQsaxjXSKGi14v36ahpyr3 Xw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 337phq88pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 12:53:38 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Sep
 2020 12:53:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 2 Sep 2020 12:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bke/qijo6Cy0H34FZBWyGK2Tw6VhjIUeGKE/RU/ieQii0PVz/5HGJdh4BXdN92iz4jLy3Hl1kUtesVsnuoFh/S4MxDsE+eb6k7DlKs0AQ6XpDT5UbPGUWh2D59ojjyPg50+AGs08sr1oEcPgMLw0Dx6SNEDv5F/qzjcC6jyCyHoIqy4TULFbCb+tGQwCCQPQOrrTFRTk1aELJ3rwRaXSUt8ZtwszJhadDTQpHjDw/NxRwshZkgvwT4VTCSHo90hhGSNvQuxQLASnt4fZ1ySzKru3NcuWVB8VQq8kEOIE1ZF9viOzlBB0X2eDScZeGfWQdDf1fu+GHyHvQA92/NsQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVZRdVFbS9gSu8VaiwW6fBPO0voalpLOMjniUNbqZK8=;
 b=DmQJoexJxCEs3ZUkbgTjeVll6uHfEGefn9QeNIcX7qihC7f21sn8t54d7vSnTd5H6666jUrxP4+X2klYs4eI8D2CaTemiFoCjTH6rQUwIJjJApbDhAGw0QfjSM4D5tI84PoOfE01h6rfZ50swWOkVZQCzr441+w6KmMzN92tPg7zovcQmWwr6c8mIi+f4khxQsbwiFKA7tnob+m0o9YF1703qs9mKzC0vTWJoOSCjdCq+Rt/pLbYV1L+8D4kcjw8ocTBUamyop8++XiJqQys1f4oEIx3u+cyRc52zHwwtMs+L8JCbJwAxVYHC9cJ9yaq55d1VKY5zuU9Fc6v/UTJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVZRdVFbS9gSu8VaiwW6fBPO0voalpLOMjniUNbqZK8=;
 b=X7PwZdEL+eGY8RZGterZTu3NeKkMP3JtcqF84gKriHnHCJumXZgYfwRbq2mOiHVMUFKLWpMlI5SEtPm1Nfzbg896LRvMYOwzrXE6ARna1/qyCgnGDdD3fAdN+ZHGV90gVptH4Mv58VrgznXQcwcPfo20K/c45nl9QJsuPl1GgWg=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by BL0PR18MB2164.namprd18.prod.outlook.com (2603:10b6:207:48::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 2 Sep
 2020 19:53:35 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::649c:380b:2191:867c%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 19:53:35 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] [PATCH 07/14] RDMA/qedr: Use rdma_umem_for_each_dma_block()
 instead of open-coding
Thread-Topic: [EXT] [PATCH 07/14] RDMA/qedr: Use
 rdma_umem_for_each_dma_block() instead of open-coding
Thread-Index: AQHWgMIjpy44HnG6jkqC41uhwO9HWalVe88ggAA07YCAABMPYA==
Date:   Wed, 2 Sep 2020 19:53:35 +0000
Message-ID: <MN2PR18MB3182C5FAFEB96197E61D4857A12F0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <7-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <MN2PR18MB3182083A47A868B1FB781F44A12F0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20200902184445.GG24045@ziepe.ca>
In-Reply-To: <20200902184445.GG24045@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.57.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a607e301-b62f-41d7-98a1-08d84f79e0be
x-ms-traffictypediagnostic: BL0PR18MB2164:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR18MB216404DD547D3C87A5F553D9A12F0@BL0PR18MB2164.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GaP6A7MOafmJ0y1sQSOSjDkAyHE/qswe2SIhbqtVto9ag1yC8s0+8Of6/msZ3F1jR1li588n9KenM4El9ZxiZGF5FUg4XFp8/ZHqHyV7BMJ7oqs0nRp9lhF7bwdVaJfFOeeNVJBGCPprh9Iv8OxpqI/kUxEXp/t+bByv9qEceFYlfejQRnJUURrKBBd5sOTIhgoX5a4S+Q3bLLYVf5uMbkck1H11B9taK0U1x3yJ3+pk1HMWwfZi58A84S4jC2GBoEGTXo9QVda2fxwA86SLwKAwefavh3A26xHxih3gN6Pu9dWxKWu1xccF4XLhGJwTA5ZJyEJcZMHfHrOjwo76qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB3182.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39850400004)(396003)(55016002)(52536014)(6506007)(8676002)(4744005)(26005)(6916009)(4326008)(186003)(66946007)(66446008)(86362001)(8936002)(71200400001)(66556008)(2906002)(7696005)(5660300002)(66476007)(316002)(76116006)(9686003)(64756008)(33656002)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1haJzyTSmxRqBU7pFJsB12U/J+Wl67zRkYFXmnUATdHRy0FC+MOTeut3yLaGfUkEZ6L7rvBWZr63TbJzGko7gB4cNf+7hsAUPsI3dKCf/xrzUCc39fZRplH/5I28lV7Rx8USM/adZU584Y4Ye4I2ZpDyP5oIy0Gpi7vTMWQaKz/geE36r8G2rMkOSQdWd3Up5Xv2QlUlGBQL6ReU1dA6GBm6ERogL0YAXPccf5x7vCP4tDvuw+Jz4vC2nD65S2rDfcSARxWtfPEvs3g28CGAczxdsD+KO46BoGxp5KP/TFd4u1b+1qB18IZSa6zL8Hvv30jvz2XIOwF0a2ICLZIjgk/YJIkRoPekhYenE0TgFRFMtDQG2/BVyzp+mTnBj2Oy3PGfSym33WxL6Teq+uxSWeQQqpmyq2eMRupgHZJ+qYru4Z01Ln2TKQnwnLHSy9+H+JJRI6tFBYAFzcXMBWYXikJXCtM/sM5dInoO5tQ2O3DsFxgeRWFZstOcQcSMyV8RO2Y1sMWIWWBSbxihoXSh+kQ1v7NFwtVLcc7t1LGYWd7eJsV1ijzwhSxDCRuOYs+J2TTRQXR8O1rAsyPL6utQyfhc0r5ZKE5RfPyjUKZtU1d6psyOesLC8kWOEIW3qJ+ECVNjW2ovj0VLPffsWP3XMg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB3182.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a607e301-b62f-41d7-98a1-08d84f79e0be
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 19:53:35.2050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbYV65YyQTW/69kV4STDtGxwXv7rApe3EMMWQjeOlPs4CqjHLaihr54j6VYfqiQgwP7bTKT380Sg3flk10BHOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2164
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_14:2020-09-02,2020-09-02 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgSmFzb24gR3VudGhvcnBlDQo+IA0K
PiBPbiBXZWQsIFNlcCAwMiwgMjAyMCBhdCAwMzozNjowMFBNICswMDAwLCBNaWNoYWwgS2FsZGVy
b24gd3JvdGU6DQo+ID4gPiArCQkvKiBJZiB0aGUgZ2l2ZW4gcGJsIGlzIGZ1bGwgc3RvcmluZyB0
aGUgcGJlcywgbW92ZSB0byBuZXh0IHBibC4NCj4gPiA+ICsJCSAqLw0KPiA+ID4gKwkJaWYgKHBi
ZV9jbnQgPT0gKHBibF9pbmZvLT5wYmxfc2l6ZSAvIHNpemVvZih1NjQpKSkgew0KPiA+ID4gKwkJ
CXBibF90YmwrKzsNCj4gPiA+ICsJCQlwYmUgPSAoc3RydWN0IHJlZ3BhaXIgKilwYmxfdGJsLT52
YTsNCj4gPiA+ICsJCQlwYmVfY250ID0gMDsNCj4gPiA+ICAJCX0NCj4gPiA+ICAJfQ0KPiA+ID4g
IH0NCj4gPg0KPiA+IFRoYW5rcyzCoCBsb29rcyBnb29kIQ0KPiANCj4gQWZ0ZXIgdGhpcyBzZXJp
ZXMgeW91IHNob3VsZCB0cnkgYWRkaW5nIGliX3VtZW1fZmluZF9iZXN0X3Bnc3ooKSB0byBxZWRy
LCBpdA0KPiBsb29rcyBwcmV0dHkgc2ltcGxlIG5vdy4uDQpTdXJlLCB3aWxsIHRha2UgYSBsb29r
Lg0KVGhhbmtzLA0KTWljaGFsDQoNCj4gDQo+IEphc29uDQo=
