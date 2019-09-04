Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB85AA819E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfIDL4A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Sep 2019 07:56:00 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49766 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbfIDLz7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Sep 2019 07:55:59 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x84BthYZ012356;
        Wed, 4 Sep 2019 04:55:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=SIurpt1370yTBLrirJcFjABK8CkaWnxcF9rU4bnesx0=;
 b=v9kImd88RZs4jCnRdh/ME0YdFLCNxF+CcfxOlpJl8R6iENZG5Nh8viibVtUP8X7mQOBW
 zvWyx1Ov1Kw3Wh16+3e19Of9lQO9daN6bNoO6LbePN7dfcs/nUVBM9iWu6Igk6BSHpXj
 5/NIKw6QtBNIIGaPp/3g0HB7jyD++Y2oSbVR0OzDzlqjniRczdVt5DMfOhC5egFJecJM
 F7luirnPxRGk/TTzkx7/jmmoh4xkjj0TpyAcPBzv5XkX6PEyLuegbTdQKmB7UMqY3mtK
 Mk9ZFomsbC8dt3cTmtXCDFZqJbVVHSe00mBrKcxNzewqzOXTzud/cMdH8JGyGl3WWyR6 xA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uqrdmdnng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 04 Sep 2019 04:55:52 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 4 Sep
 2019 04:55:49 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.52) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 4 Sep 2019 04:55:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj0R+j/1PyRdlTkyCM3cKRvIYsKaWhGkZy6qFsJunjCyvoG8TGwTM0Mb2bBxpSCd3zdQAs8ci5qhuCgxdWdXtes8ygyQgalG9UVRy9GYlDFWBuj7yzOGryGOTcgPRDzSm7iWcn6tdGI1m32GTrgQ7cNGerDaXcD4AG2zZp9Thd/H82/YTn22iUG7MsqVYUhlbhHzCQI3p9vuTq3X8YUCaVp+lg8ub4YV5SrhZEWR9P/mVnINhCywzHAZ0Mc5KbtV8gaF+K0DAhV3phXimnb9ag6w+YCGknwY2dl2FT549Iex9A+AbpCdu3MqOYf56MkERp5pzS/f+nWLKJqrm26hUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIurpt1370yTBLrirJcFjABK8CkaWnxcF9rU4bnesx0=;
 b=VNU2vuL+PFMeiwtVIDTzIboMRv7CRR3U0+i20H3rZ7sgbUdYRsAmWagy9rQ8WqVk28hMwzoN2OzWsZX1oiYRlty/SM1S2ceurwUr4h21A/S06Qy3a2Xqp0VErGxdE4z20P/mSQfBfL1COktHvYTH/V8yoieomHpornjZA4B8wMJGqxnyoN8o3Y6fo/eI3tEqyEraT7VXMD2XjmcVGpmi73uSpzcSdpnW1ldQW8h1glVWzPNK0vVwcANAFnMP8D8RDSGb6Suc0H1ogu1niwrbO6oNn4qNf8tDQkuWlQyHV6W/xKJ/+NOOh7QXUYnf0byMb9dpnrWh10J22wPoHxH/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIurpt1370yTBLrirJcFjABK8CkaWnxcF9rU4bnesx0=;
 b=I2hrOEsr/RjIe3wZY7cIOICpzdcEKU4BBUdK5TDl8JQW0Vw9CMafPHoc2dj5UqJAMozoueek6U4jT7MU3KqC9WSnew1X8ZMvCQrc22uYYeuZ+2jf+cn5OrcKZZmxqqo6gB24tylmjy0qU+RIQLNxRLF5c6IttSVD4vqXgEpyq0A=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3119.namprd18.prod.outlook.com (10.255.86.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.22; Wed, 4 Sep 2019 11:55:47 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2220.021; Wed, 4 Sep 2019
 11:55:47 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [EXT] Re: [PATCH v10 rdma-next 4/7] RDMA/siw: Use the common
 mmap_xa helpers
Thread-Topic: [EXT] Re: [PATCH v10 rdma-next 4/7] RDMA/siw: Use the common
 mmap_xa helpers
Thread-Index: AQHVYvDJBigAH6H4mUeJpjiDj3Sl6KcbXHgAgAAMujA=
Date:   Wed, 4 Sep 2019 11:55:47 +0000
Message-ID: <MN2PR18MB3182C70E4A0C585DFC2AFCF3A1B80@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190904071507.8232-5-michal.kalderon@marvell.com>,<20190904071507.8232-1-michal.kalderon@marvell.com>
 <OFD907BD76.FDE3591C-ON0025846B.003CB6DE-0025846B.003D43A6@notes.na.collabserv.com>
In-Reply-To: <OFD907BD76.FDE3591C-ON0025846B.003CB6DE-0025846B.003D43A6@notes.na.collabserv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bd34c67-a2b3-4d58-42b3-08d7312ed2ed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3119;
x-ms-traffictypediagnostic: MN2PR18MB3119:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB31197E5FEA6E80BF3387B587A1B80@MN2PR18MB3119.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(229853002)(2906002)(66946007)(446003)(66446008)(64756008)(66556008)(66476007)(11346002)(33656002)(66066001)(14444005)(476003)(486006)(6436002)(9686003)(186003)(6916009)(76116006)(102836004)(316002)(6506007)(3846002)(6116002)(99286004)(26005)(71190400001)(71200400001)(53936002)(478600001)(107886003)(54906003)(81156014)(76176011)(8936002)(8676002)(81166006)(52536014)(7696005)(305945005)(4326008)(256004)(74316002)(86362001)(7736002)(25786009)(55016002)(14454004)(5660300002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3119;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u7NGwKRZUtrHq4+bLlC+Sf0/aCU3HFgSEnNUGMf8ry9r8gDvJm22sOgWvExz8LwRny5Rfo6ClFncnmKgExgB3HPrgQaldoxq9U93zE3bUutySlrZDFDTB4G32Q4jjz4L7Ehjk5YUAvtQU7jPMhqDLaS0V0vItMDYKLsxOKPEN+8ZqNTte+pLaxzgftDnYnTRN7Nc8OxfV9trJcEU4NTBHmNm3sDjG0LhaXFzb9JZIbKVJ1FA27W2+D8Gg+aE9LRdw0M03+tWhRtuNDSyT5brkJdmijCNYaF/kFeMVRqU8FaFgJ4JfsJHab5hdPNQPefupdvAfSYTa1qzetYbaJuOZUcy0x7coFRpm3f6Y5al0ElwpXSPlqda4j56LG7inPvH9nxOtHm6rKiU9rH130sIhgVRksQViu6gE/jrHHiJRlI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd34c67-a2b3-4d58-42b3-08d7312ed2ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 11:55:47.2146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JBcIxZ57eB2D3b0XkSS0BSEYCySVBLWyg8F28Jv53uDHwzw7CeL/BZ/MW1qO91wGsEUTrj6Ka37MU6mCNqF/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3119
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_03:2019-09-03,2019-09-04 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBTZXB0ZW1iZXIgNCwgMjAxOSAyOjA5IFBNDQo+IEV4dGVybmFsIEVtYWlsDQo+IA0K
PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4NCj4gPiAJaWYgKHFwKSB7DQo+ID4tCQlpZiAocXAtPnhhX3Nx
X2luZGV4ICE9IFNJV19JTlZBTF9VT0JKX0tFWSkNCj4gPi0JCQlrZnJlZSh4YV9lcmFzZSgmdWN0
eC0+eGEsIHFwLT54YV9zcV9pbmRleCkpOw0KPiA+LQkJaWYgKHFwLT54YV9ycV9pbmRleCAhPSBT
SVdfSU5WQUxfVU9CSl9LRVkpDQo+ID4tCQkJa2ZyZWUoeGFfZXJhc2UoJnVjdHgtPnhhLCBxcC0+
eGFfcnFfaW5kZXgpKTsNCj4gPi0NCj4gPisJCXJkbWFfdXNlcl9tbWFwX2VudHJ5X3JlbW92ZSgm
dWN0eC0+YmFzZV91Y29udGV4dCwNCj4gcXAtPnNxX2tleSk7DQo+ID4rCQlyZG1hX3VzZXJfbW1h
cF9lbnRyeV9yZW1vdmUoJnVjdHgtPmJhc2VfdWNvbnRleHQsDQo+IHFwLT5ycV9rZXkpOw0KPiAN
Cj4gVW5mb3J0dW5hdGVseSwgbm93IHdlIG5lZWQgYSBjaGVjayBpZiAndWN0eCcgaXMgdmFsaWQu
DQo+IEZvciBhIGtlcm5lbCBjbGllbnQncyBRUCwgaXQgaXMgbm90LiBJbiBzaXdfZGVzdHJveV9x
cCgpIGJlbG93LCBpdCBpcyBoYW5kbGVkDQo+IGNvcnJlY3RseS4uLg0KPg0KT2ssIEknbGwgc2Vu
ZCB5b3UgYSBmaXhlZCBwYXRjaCwgcGxlYXNlIHJldmlldywgb25jZSB5b3UgYWNrIEknbGwgcmVs
ZWFzZSBhbm90aGVyIHNlcmllcw0KV2l0aCB0aGUgZml4ZWQgYW5kIGFja2VkIHBhdGNoLiANClRo
YW5rcywgDQoNCiANCj4gDQo+ID4gCQl2ZnJlZShxcC0+c2VuZHEpOw0KPiA+IAkJdmZyZWUocXAt
PnJlY3ZxKTsNCj4gPiAJCWtmcmVlKHFwKTsNCj4gPkBAIC02MjAsMTAgKzYyNCwxMCBAQCBpbnQg
c2l3X2Rlc3Ryb3lfcXAoc3RydWN0IGliX3FwICpiYXNlX3FwLCBzdHJ1Y3QNCj4gPmliX3VkYXRh
ICp1ZGF0YSkNCj4gPiAJcXAtPmF0dHJzLmZsYWdzIHw9IFNJV19RUF9JTl9ERVNUUk9ZOw0KPiA+
IAlxcC0+cnhfc3RyZWFtLnJ4X3N1c3BlbmQgPSAxOw0KPiA+DQo+ID4tCWlmICh1Y3R4ICYmIHFw
LT54YV9zcV9pbmRleCAhPSBTSVdfSU5WQUxfVU9CSl9LRVkpDQo+ID4tCQlrZnJlZSh4YV9lcmFz
ZSgmdWN0eC0+eGEsIHFwLT54YV9zcV9pbmRleCkpOw0KPiA+LQlpZiAodWN0eCAmJiBxcC0+eGFf
cnFfaW5kZXggIT0gU0lXX0lOVkFMX1VPQkpfS0VZKQ0KPiA+LQkJa2ZyZWUoeGFfZXJhc2UoJnVj
dHgtPnhhLCBxcC0+eGFfcnFfaW5kZXgpKTsNCj4gPisJaWYgKHVjdHgpDQo+ID4rCQlyZG1hX3Vz
ZXJfbW1hcF9lbnRyeV9yZW1vdmUoJnVjdHgtPmJhc2VfdWNvbnRleHQsDQo+IHFwLT5zcV9rZXkp
Ow0KPiA+KwlpZiAodWN0eCkNCj4gPisJCXJkbWFfdXNlcl9tbWFwX2VudHJ5X3JlbW92ZSgmdWN0
eC0+YmFzZV91Y29udGV4dCwNCj4gcXAtPnJxX2tleSk7DQo+ID4NCj4gPiAJZG93bl93cml0ZSgm
cXAtPnN0YXRlX2xvY2spOw0KPiA+DQo+ID5AQCAtOTkzLDggKzk5Nyw4IEBAIHZvaWQgc2l3X2Rl
c3Ryb3lfY3Eoc3RydWN0IGliX2NxICpiYXNlX2NxLCBzdHJ1Y3QNCj4gPmliX3VkYXRhICp1ZGF0
YSkNCj4gPg0KPiA+IAlzaXdfY3FfZmx1c2goY3EpOw0KPiA+DQo+ID4tCWlmIChjdHggJiYgY3Et
PnhhX2NxX2luZGV4ICE9IFNJV19JTlZBTF9VT0JKX0tFWSkNCj4gPi0JCWtmcmVlKHhhX2VyYXNl
KCZjdHgtPnhhLCBjcS0+eGFfY3FfaW5kZXgpKTsNCj4gPisJaWYgKGN0eCkNCj4gPisJCXJkbWFf
dXNlcl9tbWFwX2VudHJ5X3JlbW92ZSgmY3R4LT5iYXNlX3Vjb250ZXh0LA0KPiBjcS0+Y3Ffa2V5
KTsNCj4gPg0KPiA+IAlhdG9taWNfZGVjKCZzZGV2LT5udW1fY3EpOw0KPiA+DQo+ID5AQCAtMTAz
MSw3ICsxMDM1LDcgQEAgaW50IHNpd19jcmVhdGVfY3Eoc3RydWN0IGliX2NxICpiYXNlX2NxLCBj
b25zdA0KPiA+c3RydWN0IGliX2NxX2luaXRfYXR0ciAqYXR0ciwNCj4gPiAJc2l6ZSA9IHJvdW5k
dXBfcG93X29mX3R3byhzaXplKTsNCj4gPiAJY3EtPmJhc2VfY3EuY3FlID0gc2l6ZTsNCj4gPiAJ
Y3EtPm51bV9jcWUgPSBzaXplOw0KPiA+LQljcS0+eGFfY3FfaW5kZXggPSBTSVdfSU5WQUxfVU9C
Sl9LRVk7DQo+ID4rCWNxLT5jcV9rZXkgPSBSRE1BX1VTRVJfTU1BUF9JTlZBTElEOw0KPiA+DQo+
ID4gCWlmICghdWRhdGEpIHsNCj4gPiAJCWNxLT5rZXJuZWxfdmVyYnMgPSAxOw0KPiA+QEAgLTEw
NTcsMTYgKzEwNjEsMTYgQEAgaW50IHNpd19jcmVhdGVfY3Eoc3RydWN0IGliX2NxICpiYXNlX2Nx
LCBjb25zdA0KPiA+c3RydWN0IGliX2NxX2luaXRfYXR0ciAqYXR0ciwNCj4gPiAJCXN0cnVjdCBz
aXdfdWNvbnRleHQgKmN0eCA9DQo+ID4gCQkJcmRtYV91ZGF0YV90b19kcnZfY29udGV4dCh1ZGF0
YSwgc3RydWN0DQo+IHNpd191Y29udGV4dCwNCj4gPiAJCQkJCQkgIGJhc2VfdWNvbnRleHQpOw0K
PiA+KwkJc2l6ZV90IGxlbmd0aCA9IHNpemUgKiBzaXplb2Yoc3RydWN0IHNpd19jcWUpICsNCj4g
PisJCQlzaXplb2Yoc3RydWN0IHNpd19jcV9jdHJsKTsNCj4gPg0KPiA+LQkJY3EtPnhhX2NxX2lu
ZGV4ID0NCj4gPi0JCQlzaXdfY3JlYXRlX3VvYmooY3R4LCBjcS0+cXVldWUsDQo+ID4tCQkJCQlz
aXplICogc2l6ZW9mKHN0cnVjdCBzaXdfY3FlKSArDQo+ID4tCQkJCQkJc2l6ZW9mKHN0cnVjdCBz
aXdfY3FfY3RybCkpOw0KPiA+LQkJaWYgKGNxLT54YV9jcV9pbmRleCA9PSBTSVdfSU5WQUxfVU9C
Sl9LRVkpIHsNCj4gPi0JCQlydiA9IC1FTk9NRU07DQo+ID4rCQlydiA9IHNpd191c2VyX21tYXBf
ZW50cnlfaW5zZXJ0KCZjdHgtPmJhc2VfdWNvbnRleHQsDQo+ID4rCQkJCQkJY3EtPnF1ZXVlLCBs
ZW5ndGgsDQo+ID4rCQkJCQkJJmNxLT5jcV9rZXkpOw0KPiA+KwkJaWYgKHJ2KQ0KPiA+IAkJCWdv
dG8gZXJyX291dDsNCj4gPi0JCX0NCj4gPi0JCXVyZXNwLmNxX2tleSA9IGNxLT54YV9jcV9pbmRl
eCA8PCBQQUdFX1NISUZUOw0KPiA+Kw0KPiA+KwkJdXJlc3AuY3Ffa2V5ID0gY3EtPmNxX2tleTsN
Cj4gPiAJCXVyZXNwLmNxX2lkID0gY3EtPmlkOw0KPiA+IAkJdXJlc3AubnVtX2NxZSA9IHNpemU7
DQo+ID4NCj4gPkBAIC0xMDg3LDggKzEwOTEsNyBAQCBpbnQgc2l3X2NyZWF0ZV9jcShzdHJ1Y3Qg
aWJfY3EgKmJhc2VfY3EsIGNvbnN0DQo+ID5zdHJ1Y3QgaWJfY3FfaW5pdF9hdHRyICphdHRyLA0K
PiA+IAkJc3RydWN0IHNpd191Y29udGV4dCAqY3R4ID0NCj4gPiAJCQlyZG1hX3VkYXRhX3RvX2Ry
dl9jb250ZXh0KHVkYXRhLCBzdHJ1Y3QNCj4gc2l3X3Vjb250ZXh0LA0KPiA+IAkJCQkJCSAgYmFz
ZV91Y29udGV4dCk7DQo+ID4tCQlpZiAoY3EtPnhhX2NxX2luZGV4ICE9IFNJV19JTlZBTF9VT0JK
X0tFWSkNCj4gPi0JCQlrZnJlZSh4YV9lcmFzZSgmY3R4LT54YSwgY3EtPnhhX2NxX2luZGV4KSk7
DQo+ID4rCQlyZG1hX3VzZXJfbW1hcF9lbnRyeV9yZW1vdmUoJmN0eC0+YmFzZV91Y29udGV4dCwN
Cj4gY3EtPmNxX2tleSk7DQo+IA0KPiBzYW1lIGNvbW1lbnQgYXMgYWJvdmUgLSB3ZSBoYXZlIHRv
IGNoZWNrIGlmICdjdHgnIGlzIHZhbGlkLg0KPiANCj4gPiAJCXZmcmVlKGNxLT5xdWV1ZSk7DQo+
ID4gCX0NCj4gPiAJYXRvbWljX2RlYygmc2Rldi0+bnVtX2NxKTsNCj4gPkBAIC0xNDkwLDcgKzE0
OTMsNyBAQCBpbnQgc2l3X2NyZWF0ZV9zcnEoc3RydWN0IGliX3NycSAqYmFzZV9zcnEsDQo+ID4g
CX0NCj4gPiAJc3JxLT5tYXhfc2dlID0gYXR0cnMtPm1heF9zZ2U7DQo+ID4gCXNycS0+bnVtX3Jx
ZSA9IHJvdW5kdXBfcG93X29mX3R3byhhdHRycy0+bWF4X3dyKTsNCj4gPi0Jc3JxLT54YV9zcnFf
aW5kZXggPSBTSVdfSU5WQUxfVU9CSl9LRVk7DQo+ID4rCXNycS0+c3JxX2tleSA9IFJETUFfVVNF
Ul9NTUFQX0lOVkFMSUQ7DQo+ID4gCXNycS0+bGltaXQgPSBhdHRycy0+c3JxX2xpbWl0Ow0KPiA+
IAlpZiAoc3JxLT5saW1pdCkNCj4gPiAJCXNycS0+YXJtZWQgPSAxOw0KPiA+QEAgLTE1MDksMTUg
KzE1MTIsMTUgQEAgaW50IHNpd19jcmVhdGVfc3JxKHN0cnVjdCBpYl9zcnEgKmJhc2Vfc3JxLA0K
PiA+IAl9DQo+ID4gCWlmICh1ZGF0YSkgew0KPiA+IAkJc3RydWN0IHNpd191cmVzcF9jcmVhdGVf
c3JxIHVyZXNwID0ge307DQo+ID4rCQlzaXplX3QgbGVuZ3RoID0gc3JxLT5udW1fcnFlICogc2l6
ZW9mKHN0cnVjdCBzaXdfcnFlKTsNCj4gPg0KPiA+LQkJc3JxLT54YV9zcnFfaW5kZXggPSBzaXdf
Y3JlYXRlX3VvYmooDQo+ID4tCQkJY3R4LCBzcnEtPnJlY3ZxLCBzcnEtPm51bV9ycWUgKiBzaXpl
b2Yoc3RydWN0DQo+IHNpd19ycWUpKTsNCj4gPi0NCj4gPi0JCWlmIChzcnEtPnhhX3NycV9pbmRl
eCA9PSBTSVdfSU5WQUxfVU9CSl9LRVkpIHsNCj4gPi0JCQlydiA9IC1FTk9NRU07DQo+ID4rCQly
diA9IHNpd191c2VyX21tYXBfZW50cnlfaW5zZXJ0KCZjdHgtPmJhc2VfdWNvbnRleHQsDQo+ID4r
CQkJCQkJc3JxLT5yZWN2cSwgbGVuZ3RoLA0KPiA+KwkJCQkJCSZzcnEtPnNycV9rZXkpOw0KPiA+
KwkJaWYgKHJ2KQ0KPiA+IAkJCWdvdG8gZXJyX291dDsNCj4gPi0JCX0NCj4gPi0JCXVyZXNwLnNy
cV9rZXkgPSBzcnEtPnhhX3NycV9pbmRleDsNCj4gPisNCj4gPisJCXVyZXNwLnNycV9rZXkgPSBz
cnEtPnNycV9rZXk7DQo+ID4gCQl1cmVzcC5udW1fcnFlID0gc3JxLT5udW1fcnFlOw0KPiA+DQo+
ID4gCQlpZiAodWRhdGEtPm91dGxlbiA8IHNpemVvZih1cmVzcCkpIHsgQEAgLTE1MzYsOCArMTUz
OSw5IEBADQo+IGludA0KPiA+c2l3X2NyZWF0ZV9zcnEoc3RydWN0IGliX3NycSAqYmFzZV9zcnEs
DQo+ID4NCj4gPiBlcnJfb3V0Og0KPiA+IAlpZiAoc3JxLT5yZWN2cSkgew0KPiA+LQkJaWYgKGN0
eCAmJiBzcnEtPnhhX3NycV9pbmRleCAhPSBTSVdfSU5WQUxfVU9CSl9LRVkpDQo+ID4tCQkJa2Zy
ZWUoeGFfZXJhc2UoJmN0eC0+eGEsIHNycS0+eGFfc3JxX2luZGV4KSk7DQo+ID4rCQlpZiAoY3R4
KQ0KPiA+KwkJCXJkbWFfdXNlcl9tbWFwX2VudHJ5X3JlbW92ZSgmY3R4LQ0KPiA+YmFzZV91Y29u
dGV4dCwNCj4gPisJCQkJCQkgICAgc3JxLT5zcnFfa2V5KTsNCj4gPiAJCXZmcmVlKHNycS0+cmVj
dnEpOw0KPiA+IAl9DQo+ID4gCWF0b21pY19kZWMoJnNkZXYtPm51bV9zcnEpOw0KPiA+QEAgLTE2
MjMsOSArMTYyNyw5IEBAIHZvaWQgc2l3X2Rlc3Ryb3lfc3JxKHN0cnVjdCBpYl9zcnEgKmJhc2Vf
c3JxLA0KPiA+c3RydWN0IGliX3VkYXRhICp1ZGF0YSkNCj4gPiAJCXJkbWFfdWRhdGFfdG9fZHJ2
X2NvbnRleHQodWRhdGEsIHN0cnVjdCBzaXdfdWNvbnRleHQsDQo+ID4gCQkJCQkgIGJhc2VfdWNv
bnRleHQpOw0KPiA+DQo+ID4tCWlmIChjdHggJiYgc3JxLT54YV9zcnFfaW5kZXggIT0gU0lXX0lO
VkFMX1VPQkpfS0VZKQ0KPiA+LQkJa2ZyZWUoeGFfZXJhc2UoJmN0eC0+eGEsIHNycS0+eGFfc3Jx
X2luZGV4KSk7DQo+ID4tDQo+ID4rCWlmIChjdHgpDQo+ID4rCQlyZG1hX3VzZXJfbW1hcF9lbnRy
eV9yZW1vdmUoJmN0eC0+YmFzZV91Y29udGV4dCwNCj4gPisJCQkJCSAgICBzcnEtPnNycV9rZXkp
Ow0KPiA+IAl2ZnJlZShzcnEtPnJlY3ZxKTsNCj4gPiAJYXRvbWljX2RlYygmc2Rldi0+bnVtX3Ny
cSk7DQo+ID4gfQ0KPiA+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3
X3ZlcmJzLmgNCj4gPmIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuaA0KPiA+
aW5kZXggMTkxMDg2OTI4MWNiLi4xYTczMTk4OWZhZDYgMTAwNjQ0DQo+ID4tLS0gYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5oDQo+ID4rKysgYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd192ZXJicy5oDQo+ID5AQCAtODMsNiArODMsNyBAQCB2b2lkIHNpd19kZXN0
cm95X3NycShzdHJ1Y3QgaWJfc3JxICpiYXNlX3NycSwgc3RydWN0DQo+ID5pYl91ZGF0YSAqdWRh
dGEpOyAgaW50IHNpd19wb3N0X3NycV9yZWN2KHN0cnVjdCBpYl9zcnEgKmJhc2Vfc3JxLCBjb25z
dA0KPiA+c3RydWN0IGliX3JlY3Zfd3IgKndyLA0KPiA+IAkJICAgICAgY29uc3Qgc3RydWN0IGli
X3JlY3Zfd3IgKipiYWRfd3IpOyAgaW50IHNpd19tbWFwKHN0cnVjdA0KPiA+aWJfdWNvbnRleHQg
KmN0eCwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpOw0KPiA+K3ZvaWQgc2l3X21tYXBfZnJl
ZShzdHJ1Y3QgcmRtYV91c2VyX21tYXBfZW50cnkgKnJkbWFfZW50cnkpOw0KPiA+IHZvaWQgc2l3
X3FwX2V2ZW50KHN0cnVjdCBzaXdfcXAgKnFwLCBlbnVtIGliX2V2ZW50X3R5cGUgdHlwZSk7ICB2
b2lkDQo+ID5zaXdfY3FfZXZlbnQoc3RydWN0IHNpd19jcSAqY3EsIGVudW0gaWJfZXZlbnRfdHlw
ZSB0eXBlKTsgIHZvaWQNCj4gPnNpd19zcnFfZXZlbnQoc3RydWN0IHNpd19zcnEgKnNycSwgZW51
bSBpYl9ldmVudF90eXBlIHR5cGUpOw0KPiA+LS0NCj4gPjIuMTQuNQ0KPiA+DQo+ID4NCg0K
