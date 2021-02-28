Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E15F32755A
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 00:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhB1XsO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Feb 2021 18:48:14 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:46982 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231307AbhB1XsL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 28 Feb 2021 18:48:11 -0500
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11SNhVdY027690;
        Sun, 28 Feb 2021 23:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=o0IDdKPKXCesm+K+B4xFeUA/rcfyE9GMIZiBwc54ubo=;
 b=BWHSGhIw8Pi4FD+OvPeBQ8d8aLUJmz3Qcqb9dEZ7qcVgm1Fx0Pb1MbRowgt6dxSzsPFE
 a4vZymbY2M5DGpxPiXEiINsXFKOyWVzS0+1EujCQog+8vedzIOxlbKPG2CdthQRTwJnD
 Mcm6Xfwz2Bag89OHZjeclcQt0YJr7b4v3bZMNquzNNoxmADPYfg8OZeSGWs4/PhtmpiS
 SArqhVb16lSpL5eVDiuu6e05qpF0kaUr7pPwBPUD/5Kdq1HPecd7Ctrcvne4Sk1GY0s4
 HdIMtvPufbpjaL8gRbkubTc4IkQCOoK+717A2XFUFZ9VjfKzFyicQoRbiK2DvV/3HGfl ew== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 36yd701qh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Feb 2021 23:47:23 +0000
Received: from G9W8456.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id C15546D;
        Sun, 28 Feb 2021 23:47:22 +0000 (UTC)
Received: from G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) by
 G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Sun, 28 Feb 2021 23:47:22 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W8454.americas.hpqcorp.net (16.216.161.4) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Sun, 28 Feb 2021 23:47:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7/VCd6vUX7sA1cOigXhtvUp1cXH1dEapK4K8+YiMLBd6L1qwT+cpvjjF/SNfEXOjRJwuOnk28pgk02lqHMAPmHMcKznF5ASOy/d2/A/rnMm1VohxekYrEIkvcGI5gbn6GS5NTGqo4SLpbEuQfaDducFeXYiqAR8m/gLxx+IcEkpL1xXgmlwBQ/HWsEy7gFHbclh30ySU9YtgQ3HlN9v2kqthhSAi6M5fIhFBePgY3Bo5GwTH/IwTIEz7Dqe3zC9rkwXNdyjJ0QwoWzgmd2jNZ/ANhNcbzDq0YL4UhvDBqegQiJDg4rsxI0eLvzR2NvOXtdkjgolQRxN8AmkqyxD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0IDdKPKXCesm+K+B4xFeUA/rcfyE9GMIZiBwc54ubo=;
 b=Bj5Gac7bK21WjMhKI9VtZWR4tKKsgMTwyFHeorSQ6ZQvo8We6BVLdctwD8A4mq0lcEoZghZbG4BFN54/jxhHafcUy4wM/05ifxc/Lq0tvCC1LoXzDygmMK1vXp6eaEQc+iFH4kdOfna7cqduhdqctKOFJDF9nUy/ElR0Ft/aL9zMYq8X2kUEJLsm8hPIDOHMqkFZnizp3waFszK879I6//AZYHg1KgqIoaDbAwbJH3l57xACWIAek56QSfYhnIL0YZhgck52i+7ftlr7+mT+c3K9Cic2GhObAJtFtlRE/ew3i5oNSpXCgo/X5xvWuiA5KGEviBupXztMtD6RsFF5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB0823.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Sun, 28 Feb
 2021 23:47:21 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8%5]) with mapi id 15.20.3890.028; Sun, 28 Feb 2021
 23:47:21 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>, "Yi Zhang" <yi.zhang@redhat.com>
Subject: RE: Regression in rdma_rxe driver?
Thread-Topic: Regression in rdma_rxe driver?
Thread-Index: AQHXDiFiov2eA+HLe0eFeYdx4y6NrKpuO14Q
Date:   Sun, 28 Feb 2021 23:47:21 +0000
Message-ID: <CS1PR8401MB082170091CFEF3F5349A2A95BC9B9@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <7aabe495-e844-df77-05ff-491f53963816@acm.org>
In-Reply-To: <7aabe495-e844-df77-05ff-491f53963816@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [165.225.216.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66c47c04-7ea2-475d-e52d-08d8dc4330f0
x-ms-traffictypediagnostic: CS1PR8401MB0823:
x-microsoft-antispam-prvs: <CS1PR8401MB08232C967C72CECCBA05ADE8BC9B9@CS1PR8401MB0823.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qxFaKswJz6zSo359tV+M/eNHKInqhf5PhADZOrz0NzpZA0iH1zwVRbyFAsSDRf/y+QkyuQZeHYZvcIP19Iw8fELDOXceHnW1vY/39OjvhKyHx8b7gIXLWx0roPpnsSvM3BZmcU2X33+/0seZkjjlxnaQl+dsxMoPbgkejKCWRmAHVbGJLy+6XTMoiij5E8bwCeONYAanH4oXiQP7gOrkPkkeXvOG/mEvjhTt5Nl2VjAL6hz1SOdi+h78UL8uSIEbavwIV1M0/gslf4lz8dyF/VICbJAMZW28FtiFgbyzs2ZPD7QYfLIhS3MMBnXoQpP47jJOTSyWxo5S8McgqJXSbU9BV4u92VGwdZRGM3hrphuT67/pSZJDgUNNKjr4KJ+t36e99nJlg8g58L60eGtfEVF4zGAGv5LieUdhRFa2hcgUFyVlGMKn1uduEmtqcaqODJ04t09XBLNCHTFOX1El5LCAH9b8wzGWfTDwgde0E398zsCJauarZwPvC6XW7q7AXRzWp7Oi9lIbbP0FRCYAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39860400002)(136003)(396003)(366004)(346002)(66556008)(66476007)(66946007)(6506007)(64756008)(76116006)(66446008)(53546011)(55236004)(478600001)(71200400001)(86362001)(52536014)(8676002)(5660300002)(33656002)(4326008)(83380400001)(7696005)(55016002)(26005)(316002)(9686003)(186003)(54906003)(8936002)(110136005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UGtZMHlMbTNhcXNHQk4rQ2kzT0pUWkYrcEc4MGYyTDRGRnNybksrdWlTRWNP?=
 =?utf-8?B?aUFBN3Fic3lMcU9ydnUzVzNPMjhPdU5hQzV0WmFHekJWNVlHemV5bHpiZnFK?=
 =?utf-8?B?N1JLR3EyRkxySDJhK3FuMW1CVlFHUkdCZEw4L0pid2NKb2dXMk5BQ3ZjZkly?=
 =?utf-8?B?OVl3Ykw0eVZrRVNwa2lYM3JnV0lnY0szeFRtNjIybVZnNU1JcGJEeWtCbTdi?=
 =?utf-8?B?T0psRXFZMVg4d1l1L1VNOVhtdVFudjNMMG5LS2xmU25RRTE2OGJvSElIS1lP?=
 =?utf-8?B?NkZNdFNma0YzSTZybGtPcGk0YTZ5YzJKK3QrcGVHRllsYktpZFptejMvZzYw?=
 =?utf-8?B?SVE4VVpQeUU2NXpJTFllSVFhMVlDQ3ZFVkJUTlhBcnVzQWxoL1dIS1dTcnhL?=
 =?utf-8?B?N1NGY1R6M1ZXanpxbGxaT2tPMnNkTVVOQmRVb2ducnFremhrbmxMTm1UY3ZV?=
 =?utf-8?B?S1MxWUlCMklGTGhod2NDaGJGL0Q4N1ZXT3BkTU5vcnBqeFJZQklIWUFqdTFq?=
 =?utf-8?B?WUNzcUhKd2gxQ3Y1NGVWSWFIK1JsSTVKZ01aakJMUlpjWHF4S2xXSzRQV2pp?=
 =?utf-8?B?eGNTYkw0ZTQ5YjRJMnlTbURiSk10bjlLZ2pHLzd1WHIzSDdldHdrSW91Sm5W?=
 =?utf-8?B?Y0pNbXdReTZaQWdIYWlzV0FrbFB1N2o4SkdZejl1ZXRFcUNIODhGVVk4YUx5?=
 =?utf-8?B?Vy9FNlhxVnVqdDdac1VwOHUwNTUxZ0ZZRjdWWWFMYW9MVHRGQjU5RWRzVFFO?=
 =?utf-8?B?QVgvc212ME54RUNTUkVLNHpZTXhIc1FmaUM3TVlLMlA0UTdZcnh6VDAvSnZM?=
 =?utf-8?B?RXU2cENtK1ByZGw2cUVReFZZRGdGMWw1TTdNaXVFVXFPRlVtT25PUEYvWkoz?=
 =?utf-8?B?T1JicGxJb1dlKzN0TkdHWFA4WG1SSFBGUlJrQ1U4bEg5M01tUzdoUCttVUJt?=
 =?utf-8?B?blRubHoxemJvZ0JkZ0RGMWhhKytPaGhJYkxKL1NzUy9PU04zWHpXbGpNTU1W?=
 =?utf-8?B?L0I5eXZOYU5DNmZqQ2cwM3hibFBRbE5IMG43WXhpSWZXSzY3VWtFWEx5WTJS?=
 =?utf-8?B?V1ZkU2NudHFXM0xYZStwb0NEZ3VBUjEzdk9aTGUvQTh5eUZaY1RoelZCdHg0?=
 =?utf-8?B?T0lvOCt2Z0Yra3MyK0dlajZxajEwVDVJYVgvKzZOQmlUV3RnMG1GVmVFVGdG?=
 =?utf-8?B?Tnp5NGtVUXJhZVRNbWNja1NMRUlOeGEwYWtaYlg4ZVpkSXRxbkRHTXB1Mmdw?=
 =?utf-8?B?TmJBdXFUemJrYVM3QnZzRVh2eDQ2RnlnZm5KVnAwSCtkc29aeVMvWXM0TVM4?=
 =?utf-8?B?dVNhWlV0MmpoSlRhWnBRc1Nza1ZHOEFlcUlWeEU5WGFaT3VjYlFRTm13Z0E0?=
 =?utf-8?B?WlE4TUpSNkR6ZkdsRmNaTnZIY3RsK0d6MVZIdkZ2aDJPSE5yOTF5bTNkMTM4?=
 =?utf-8?B?aEhvVmoxZ0NKbXlKcWNjcTBVaEk0MjdrVmlyRCtKSlZRRUNxT01UUzJvZm9X?=
 =?utf-8?B?YktiUFZIa3BReXBCc0NwOXhBZVlxcTBhSTk4VktzQm5kd1dVd1B4cVRyYS8v?=
 =?utf-8?B?YjJLVVdqU1JkdVdQWVFlWkFtbmUzWnozekNVT1d1TGlpVkhlNnRpaXNmMmlr?=
 =?utf-8?B?a2ZiSFNmNHZyQ1A2Q3JZOXRwNkFLMzc3ODg2S0IzUHR3MTE2SjBHT3RDRFZz?=
 =?utf-8?B?RXd1d1E2K3p2NjZub0xZWXpxSUlnODZibFYzSVplL2tBQjd4cWx3QXRmWVJZ?=
 =?utf-8?Q?TP+iFKwCVOnsxONfsU+PyFn0EBJ2F7lV6fhE4Aq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c47c04-7ea2-475d-e52d-08d8dc4330f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2021 23:47:21.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hbwn+E7UY8MVyb10t+58R33orcEdTqCOxM6aCBcAhqwbo09Vu9g3w5aZtjzDwJ0IoUQurxiQB8y7jICVPb2zoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0823
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-28_10:2021-02-26,2021-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102280205
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhpcyBsb29rcyBsaWtlIHRoZSBpYl9kZXZpY2UgcmVmIGNvdW50IGJ1ZyB3ZSBhcmUgdHJ5aW5n
IHRvIHJlc29sdmUuIEkgYW0gaW4gYSB0dXNzbGUgd2l0aCBMZW9uIGFib3V0IHN0eWxlLiBTaG91
bGQgZ2V0IGZpeGVkIHZlcnkgc29vbi4NCg0KYm9iDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4gDQpTZW50OiBT
dW5kYXksIEZlYnJ1YXJ5IDI4LCAyMDIxIDQ6MjkgUE0NClRvOiBsaW51eC1yZG1hQHZnZXIua2Vy
bmVsLm9yZw0KQ2M6IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+OyBqZ2dAbnZp
ZGlhLmNvbTsgWWkgWmhhbmcgPHlpLnpoYW5nQHJlZGhhdC5jb20+DQpTdWJqZWN0OiBSZWdyZXNz
aW9uIGluIHJkbWFfcnhlIGRyaXZlcj8NCg0KSGksDQoNCklmIEkgcnVuIHRoZSBmb2xsb3dpbmcg
Y29tbWFuZDoNCg0KKGNkIH5iYXJ0L3NvZnR3YXJlL2Jsa3Rlc3RzICYmIC4vY2hlY2sgLXEgc3Jw
LzAwMSkNCg0KYWdhaW5zdCB0aGUgZm9yLW5leHQgYnJhbmNoIG9mIHRoZSBSRE1BIGdpdCByZXBv
c2l0b3J5IChjb21taXQNCjdmYWQ3NTFjMjA2MiAoIlJETUEvc3JwOiBBcHBseSB0aGUgX19wYWNr
ZWQgYXR0cmlidXRlIHRvIG1lbWJlcnMgaW5zdGVhZCBvZiBzdHJ1Y3R1cmVzIikgdGhlbiB0aGUg
Zm9sbG93aW5nIGFwcGVhcnMgaW4gdGhlIGtlcm5lbCBsb2c6DQoNCkZlYiAyOCAxNDoyNDowNCB1
YnVudHUtdm0ga2VybmVsOiBXQVJOSU5HOiBDUFU6IDUgUElEOiA4NCBhdA0KZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jOjc2MSByeGVfY29tcGxldGVyKzB4ZGM1LzB4MTBkMCBb
cmRtYV9yeGVdIEZlYiAyOCAxNDoyNDowNCB1YnVudHUtdm0ga2VybmVsOiBDYWxsIFRyYWNlOiBb
IC4uLiBdIEZlYiAyOCAxNDoyNDowNSB1YnVudHUtdm0ga2VybmVsOiBXQVJOSU5HOiBDUFU6IDUg
UElEOiAzOSBhdA0KbGliL3JlZmNvdW50LmM6MjggcmVmY291bnRfd2Fybl9zYXR1cmF0ZSsweDE1
NC8weDE2MA0KRmViIDI4IDE0OjI0OjA1IHVidW50dS12bSBrZXJuZWw6IENhbGwgVHJhY2U6IFsg
Li4uIF0gRmViIDI4IDE0OjI0OjExIHVidW50dS12bSBrZXJuZWw6IFdBUk5JTkc6IENQVTogNSBQ
SUQ6IDE0NzEgYXQNCmxpYi9yZWZjb3VudC5jOjE5IHJlZmNvdW50X3dhcm5fc2F0dXJhdGUrMHhh
OC8weDE2MCBGZWIgMjggMTQ6MjQ6MTEgdWJ1bnR1LXZtIGtlcm5lbDogQ2FsbCBUcmFjZTogWyAu
Li4gXSBGZWIgMjggMTQ6MjQ6MTcgdWJ1bnR1LXZtIGtlcm5lbDogV0FSTklORzogQ1BVOiA2IFBJ
RDogMTUwMSBhdA0KZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvZGV2aWNlLmM6NjcxIGliX2RlYWxs
b2NfZGV2aWNlKzB4MTA0LzB4MTEwIFtpYl9jb3JlXSBGZWIgMjggMTQ6MjQ6MTcgdWJ1bnR1LXZt
IGtlcm5lbDogQ2FsbCBUcmFjZTogWyAuLi4gXSBGZWIgMjggMTQ6MjQ6MTggdWJ1bnR1LXZtIGtl
cm5lbDogV0FSTklORzogQ1BVOiA0IFBJRDogMTcwIGF0DQpkcml2ZXJzL2luZmluaWJhbmQvY29y
ZS9kZXZpY2UuYzo0OTMgaWJfZGV2aWNlX3JlbGVhc2UrMHhkMy8weGUwIFtpYl9jb3JlXSBGZWIg
MjggMTQ6MjQ6MTggdWJ1bnR1LXZtIGtlcm5lbDogQ2FsbCBUcmFjZTogWyAuLi4gXQ0KDQpJcyB0
aGlzIGEga25vd24gaXNzdWU/DQoNClRoYW5rcywNCg0KQmFydC4NCg==
