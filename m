Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949CF39BBC6
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFDP1L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 11:27:11 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:12512 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhFDP1K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Jun 2021 11:27:10 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 154FDILZ024821;
        Fri, 4 Jun 2021 15:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=JsB8cs7NApkyUs+TgkIToSOGUFBito9cYrVD/FbwO58=;
 b=TiV2J/mPaj91mW8NRqISYytZTh5vmYXDFQiCN7WbAxcZTuCE/PUSNXjoGPF1q7PA0dA7
 nykwmvP69tXX7u9k7hQQCGFn2Qa3/Ruv/y1+Mqozmfo7wA5Ss2eUGa1qCHlO1Jc01fVU
 dqQm+ma1+HBNfXOeymtf2/spGhJc6Ri395r1GzALIXw7nxhWo5e32ggk7dWGF3j2giXV
 fS5bwArNWOZrmQqY9F0bt0IXHOjEcmmyu2JeHoinsfpJltknb+sF1ijLvSjBiQopz5P5
 TEROGG2p346UMClEvdnCltgmM1m5PYM1TQG1vougaDJ1lUKsDdkw4G130Op9g0Xp9wDi sA== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 38y987e2vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Jun 2021 15:25:22 +0000
Received: from G4W9119.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.20.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 8A4D2A1;
        Fri,  4 Jun 2021 15:25:21 +0000 (UTC)
Received: from G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) by
 G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 4 Jun 2021 15:25:21 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W9121.americas.hpqcorp.net (16.210.21.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 4 Jun 2021 15:25:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIugXWA/kPzNOMkDYVybfCaiWLU6tVNMRDv0Je+7JO2VclAwguo5R1Se2csL9eNG1PZYqipxBedr0v9jp71n7D2g5p8dPiCyK4a9Uy7y/kkvdZtxIJF69GeaIhw96xDXfgQbV7G8FyqY/wTjL5/6EvBohQ5Z1wLNUPf1cyAoevahVuhgi4ZjI7LArg5MxyB9BC7x1acZjj06wBLYV8N28xezOIXTc1Uu/Ogis5hpmWP3tEnj2s3L8isetQ5uI65E+AYfLQL48H2LkDUdlQwU4okw7RXCIIp/DmUbCHIZk3IhnDCnFRIW/blZJr9DdEKR5ch5Xrjo2zuijibP40YIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsB8cs7NApkyUs+TgkIToSOGUFBito9cYrVD/FbwO58=;
 b=Q8+qrV9wc/kWSVUQUP36WbHDKFJJO1/0MIOA8mSETjtM3jdx3f5lEGZV8+GDHoax016+t7dh4TDZ7ji4ldT+61oS99PEWQipMDdelggu2ANFRq1VDGfIp+ECd1uTunvuNoGFt8aJT2ogS5fBaLpYzByBqjARykv8Of5zCPTpXAxsxFa7KojgndKpExvjzMEvz7o4eXJ/sWOIQwnYD6yF3a8SajKm8YGgrUFMNnubfIavtovrENBt0lyLs2bj7n7PEfNq/9ySPYiPy9rU0q2/mI7qXXYrn9FBvDRQQUCKUukHVgqt6BX7iTJ7hPWcYrCqQPSwfjuLuvDHcfaxqdjanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::16) by CS1PR8401MB0855.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7511::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 15:25:20 +0000
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8803:b4cb:5033:b30f]) by CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8803:b4cb:5033:b30f%7]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 15:25:20 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        "zyj2000@gmail.com" <zyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v8 00/10] RDMA/rxe: Implement memory windows
Thread-Topic: [PATCH for-next v8 00/10] RDMA/rxe: Implement memory windows
Thread-Index: AQHXUa5WfdeiAaughEGx6vAxAOkfIasCsWcAgACyugCAAKQD4A==
Date:   Fri, 4 Jun 2021 15:25:20 +0000
Message-ID: <CS1PR8401MB10965BBB17FCB8A1ABCC2376BC3B9@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
 <20210603185804.GA317620@nvidia.com>
 <CAD=hENeqZrtLbJF2J-HuetJec8MNfAVDHmcwkWmMNAfeX4-vng@mail.gmail.com>
In-Reply-To: <CAD=hENeqZrtLbJF2J-HuetJec8MNfAVDHmcwkWmMNAfeX4-vng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:81b6:accf:d415:6279]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66fef0d0-029e-4398-b405-08d9276cf6e4
x-ms-traffictypediagnostic: CS1PR8401MB0855:
x-microsoft-antispam-prvs: <CS1PR8401MB08554AF89B543625D8497488BC3B9@CS1PR8401MB0855.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MURS7jGD9zICR42amp7q1Ba5hfi30x0gK48gBQTvt44n9thxgyfmHO5M03pUei/QaKyHR+q+54u7RI/h4aGc7EPMK7UCUYa2qcoLGQRWe+9hzhvkJzZlTCwsXB3TP1Re/GiQAmzxLIfTOhAcu8WXEB6pdpR5ghxf153XBieqQ7/bewg22iXJh28mJOKTIRK31pQISVCc1aSI7hArNIW5LY9VePYoXQnGqTNQyRj4BTW+A6wXcibOUapW+0+XH63YdneowNGCijuZM2oqAoZ4yQa46JY6wLY55CN7rCjgbFWTIKgGoYSsrLf5cA5W4FYGSY4Vs7NYgRfOgaOKhZZYznl91HbfVoX5xJhXzcJHCH/I+dqCwDgwYbff7CgrQqg4PAct2usKkIOsJ4oKlpM/zldAGgdKbq1acpRhAQZpts7zIYWgiRb/zj/nNyOV+Dvlxoph/1FPoIoMArNSYXBV/rjJJbNpiBExF6RS64yl6aLi/ntZdoNEZaMCyUUCwrffIVRWy5sYq2NgWmqYVAnlGA0t8E19EDcU1iDqy6Bh2ijz6h3mTNqgXynUJ2Rr3IFkbjqPSNV59zzHHGMOtHNjKrwtiZJ6n0kVrGmVhmGg+hs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(66476007)(66556008)(86362001)(8936002)(9686003)(110136005)(66446008)(64756008)(52536014)(54906003)(66946007)(55016002)(83380400001)(38100700002)(478600001)(76116006)(2906002)(8676002)(6506007)(7696005)(5660300002)(186003)(122000001)(33656002)(316002)(71200400001)(4326008)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QjNCd1ExM1lDc2M1dUZqeS9ZZGZQU3hiN3QzaG8wWVk5ZXlaQTBxalJidWgw?=
 =?utf-8?B?d1NHdjA2TEJNOVVPdFFwNm50bm1sVlJTd3E4a3h3QWFqQmRwSmc3alNNekF0?=
 =?utf-8?B?MmxvMnpNYmpEeTZaaGUwbUlYczZHWTZybmY3ZnJMNDN5Q0JUK0RpU0kyN2Uv?=
 =?utf-8?B?YjNYbzNLR3FueW93NG12RWpmZXJTRDVhMjdjVkNXQVo4aFo3KytGU2l5OWlE?=
 =?utf-8?B?ekF6SHkyb1gxTXBtTEZuVlZTYmVHci93ajZRZUVFVlJvb24wTE4yQ1o0bWQ1?=
 =?utf-8?B?TlcrdzhyY2RCcXhBY1gzSmU5cnVxVzVhWUtORThSSzRZdzhJTVZNT090a2dy?=
 =?utf-8?B?c3VKSGRueE02bVoxcUZzNjFiWGFiVWZWbkNac1hLWjBHQ0lvdTI0N1ZjRllV?=
 =?utf-8?B?aElNMFk4TWRuMVkwbkl4MCtpZDBLeTUvcWxQaytZd0lpdWlTditqTXg1MGg1?=
 =?utf-8?B?V2hpWVp1czAvdzQ2NENzejBiYjNpbDBDN0RBS3NQaTAxQ0ZOcWlSTlBXTjY3?=
 =?utf-8?B?eEhhYkdyMXdkYjZUTXlCdkxSbHBpTmw3aFBTc3p1NU9idEo3Z21SdnBaT0JO?=
 =?utf-8?B?cE9hL1V5eFpMUXJYSWZ6Rm42QVVaR3BDKzN0cFRSc2I0dHBkaGFFeFk4WXB2?=
 =?utf-8?B?WjkweDh1bjd5dzY0dmpLeWpoZ1ZYOHhMajNZb3dOc0NLZ3lzZWlyOHdQQWpr?=
 =?utf-8?B?Y1dReVFSUUhFREpqZFVWKzZqdndaQUwrdWQ4aWFxWnB6S2d2K1lRdDJNSk9o?=
 =?utf-8?B?WjhtSk1WcjY5NUxNaUZQVE5nL20vOEswbS9NK3VkUjUzYUJ6elFrT3FnOXZE?=
 =?utf-8?B?bWw3bUVGTWxvcGJqalM2S2gyUHVaOEpqWFpHZmUvalNGeVVycEx6NmMyR0FF?=
 =?utf-8?B?NDBGUUpBM1pCNjkxMFFDbmJiS1J3N29DUVJaZnp0d2xpanRTS2Z3OHhFR0ox?=
 =?utf-8?B?clNzQy9veno3Y1NSTDVEWVdzS2RIc2VuTFRRUTdYQXF1L1dOajUxRlFYQmhj?=
 =?utf-8?B?S2xVSHZRSCs1cjNlZTM2ekhXMHVMckp5a3NqVVRPUmVwVUcxaWgwZ0ZBVDlr?=
 =?utf-8?B?Um95dTRmMXk3V0F3Q24wRmMzNUNnMm1tQ2lNOU1RVmhYWGEwSlFQWU5pRmR3?=
 =?utf-8?B?ZzRaY0VkaDhKTXE2QUdsM2NBaFpaVitVK1dkbTJBK2JOeXVmNlMrT0NBZlZU?=
 =?utf-8?B?bmFUZlBpM241cE1iRjBqVUdtd05FZmFDNEs4eDZZVHp4eXNYcVI4aGVCRFEv?=
 =?utf-8?B?K3pmR3NUMnFOTkthV3MwQ3dqZ2xQU2g3c3VTYTgxZitld0tSYS9sazJpcjlS?=
 =?utf-8?B?L3VkWWFFbnl0eWpwdnRUVW5jMmNFMEl6R0x6UGJNTGFJNVRLOVVvVWh1YW1F?=
 =?utf-8?B?TWJxNGF0Q1U3VlJoT3EyS0hSZFUvNDlHVG9haVYwcWRMQ1E2cHVHQzlOSVo2?=
 =?utf-8?B?K1hZOVJ5eUpkTHprT2FvNWc2Q215b1d0NTlaVTUvOVExVk8yVS9YbWt1MFNt?=
 =?utf-8?B?dnVuVVM0d2FTV3BCQ1JlWE9UdzArU2trLzdpOGFUUVVuS0JtTTBXK2x1V2p0?=
 =?utf-8?B?OW8raHVSblE4YUxHOWt0TFV1aUxVRWVSSlcvckdLcEorWG5ic3BBdnVnSG55?=
 =?utf-8?B?dmw1T1g5ZWFyR0Z0MEY1UERXT2hWMTJCaE1XNjF0Rm5GVVRvNVhVanJFMTRp?=
 =?utf-8?B?cnZrTXQ3QjhaVCt2Wm1JazJ6bEhYMFM0OUY3a2tHZE1DenpUQS9IanR2YlQ1?=
 =?utf-8?B?ODFhdXVwbmZRMUtoVHVTYXRhTlozbm5PQXpoMWw2eUUvTktrOHR1ZkpqY0Jy?=
 =?utf-8?B?cUlhNStqT1NsdTZXb2lDeUw5d3E1WTM0VE1xL05LMzVDakk5NExWUUFISDgr?=
 =?utf-8?Q?cKQ+gmKzQvWmb?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fef0d0-029e-4398-b405-08d9276cf6e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 15:25:20.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syp4BNQ/TCJ1EAnqjcJ40xoE7+0RgDaRD3YNzTz2rNc/Ihb9QA7gTVyhwmrCIjYkAJbsvEiRaGkNcM8/asbxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0855
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: A3A1sNtqQcpu5roXjJMDpCaeGaKG5gUk
X-Proofpoint-ORIG-GUID: A3A1sNtqQcpu5roXjJMDpCaeGaKG5gUk
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_08:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040113
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhlcmUgaXMgcHJvYmFibHkgYSByZWZlcmVuY2UgdG8gdGhlIFBEIGhhbmdpbmcgYXJvdW5kLiBJ
J2xsIGxvb2suIC0tIEJvYg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogWmh1
IFlhbmp1biA8enlqenlqMjAwMEBnbWFpbC5jb20+IA0KU2VudDogRnJpZGF5LCBKdW5lIDQsIDIw
MjEgMTI6MzggQU0NClRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KQ2M6IEJv
YiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+OyB6eWoyMDAwQGdtYWlsLmNvbTsgUkRN
QSBtYWlsaW5nIGxpc3QgPGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogUmU6
IFtQQVRDSCBmb3ItbmV4dCB2OCAwMC8xMF0gUkRNQS9yeGU6IEltcGxlbWVudCBtZW1vcnkgd2lu
ZG93cw0KDQoiDQpbIDEwNDEuMDUxMzk4XSByZG1hX3J4ZTogbG9hZGVkDQpbIDEwNDEuMDU0NTM2
XSBpbmZpbmliYW5kIHJ4ZTA6IHNldCBhY3RpdmUgWyAxMDQxLjA1NDU0MF0gaW5maW5pYmFuZCBy
eGUwOiBhZGRlZCBlbnAwczggWyAxMDg2LjI4Nzk3NV0gcmRtYV9yeGU6IGNxZSgzMjc2OCkgPiBt
YXhfY3FlKDMyNzY3KSBbIDEwODYuMzExNTQ2XSByZG1hX3J4ZTogY3FlKDEpIDwgY3VycmVudCAj
IGVsZW1lbnRzIGluIHF1ZXVlICg2KSBbIDEwODYuMzk5ODI2XSByZG1hX3J4ZTogY3FlKDMyNzY4
KSA+IG1heF9jcWUoMzI3NjcpIFsgMTA5MC4yMzI3ODVdIHJkbWFfcnhlOiBjcWUoMzI3NjgpID4g
bWF4X2NxZSgzMjc2NykgWyAxMDkwLjI1NTk4NV0gcmRtYV9yeGU6IGNxZSgxKSA8IGN1cnJlbnQg
IyBlbGVtZW50cyBpbiBxdWV1ZSAoNikgWyAxMDkwLjM0NTQyN10gcmRtYV9yeGU6IGNxZSgzMjc2
OCkgPiBtYXhfY3FlKDMyNzY3KSBbIDEwOTQuMDI0MzIyXSByZG1hX3J4ZTogY3FlKDMyNzY4KSA+
IG1heF9jcWUoMzI3NjcpIFsgMTA5NC4wNDc1NjldIHJkbWFfcnhlOiBjcWUoMSkgPCBjdXJyZW50
ICMgZWxlbWVudHMgaW4gcXVldWUgKDYpIFsgMTA5NC4xMzYxMDNdIHJkbWFfcnhlOiBjcWUoMzI3
NjgpID4gbWF4X2NxZSgzMjc2NykgWyAxMDk4Ljk4OTM0NF0gcmRtYV9yeGU6IGNxZSgzMjc2OCkg
PiBtYXhfY3FlKDMyNzY3KSBbIDEwOTkuMDE1MDY1XSByZG1hX3J4ZTogY3FlKDEpIDwgY3VycmVu
dCAjIGVsZW1lbnRzIGluIHF1ZXVlICg2KSBbIDEwOTkuMTEyOTcwXSByZG1hX3J4ZTogY3FlKDMy
NzY4KSA+IG1heF9jcWUoMzI3NjcpIFsgMTEwMy4wNDAwNzZdIHJkbWFfcnhlOiBjcWUoMzI3Njgp
ID4gbWF4X2NxZSgzMjc2NykgWyAxMTAzLjA2MjgzMV0gcmRtYV9yeGU6IGNxZSgxKSA8IGN1cnJl
bnQgIyBlbGVtZW50cyBpbiBxdWV1ZSAoNikgWyAxMTAzLjE1MTE1N10gcmRtYV9yeGU6IGNxZSgz
Mjc2OCkgPiBtYXhfY3FlKDMyNzY3KSBbIDExMTYuMTIxNzcyXSByZG1hX3J4ZTogY3FlKDMyNzY4
KSA+IG1heF9jcWUoMzI3NjcpIFsgMTExNi4xNDQ5NTFdIHJkbWFfcnhlOiBjcWUoMSkgPCBjdXJy
ZW50ICMgZWxlbWVudHMgaW4gcXVldWUgKDYpIFsgMTExNi4yMzQ2MDddIHJkbWFfcnhlOiBjcWUo
MzI3NjgpID4gbWF4X2NxZSgzMjc2NykgWyAxMTMxLjY1NTQ4Nl0gcmRtYV9yeGU6IGNxZSgzMjc2
OCkgPiBtYXhfY3FlKDMyNzY3KSBbIDExMzEuNjc4NzAwXSByZG1hX3J4ZTogY3FlKDEpIDwgY3Vy
cmVudCAjIGVsZW1lbnRzIGluIHF1ZXVlICg2KSBbIDExMzEuNzY2Nzc2XSByZG1hX3J4ZTogY3Fl
KDMyNzY4KSA+IG1heF9jcWUoMzI3NjcpIFsgMTE3NS41MTcxNjZdIHJkbWFfcnhlOiBjcWUoMzI3
NjgpID4gbWF4X2NxZSgzMjc2NykgWyAxMTc1LjU0MDI1OF0gcmRtYV9yeGU6IGNxZSgxKSA8IGN1
cnJlbnQgIyBlbGVtZW50cyBpbiBxdWV1ZSAoNikgWyAxMTc1LjYyODIxNF0gcmRtYV9yeGU6IGNx
ZSgzMjc2OCkgPiBtYXhfY3FlKDMyNzY3KSBbIDExOTAuNzYwMTIyXSByZG1hX3J4ZTogY3FlKDMy
NzY4KSA+IG1heF9jcWUoMzI3NjcpIFsgMTE5MC43ODMyNDNdIHJkbWFfcnhlOiBjcWUoMSkgPCBj
dXJyZW50ICMgZWxlbWVudHMgaW4gcXVldWUgKDYpIFsgMTE5MC44NzExNjddIHJkbWFfcnhlOiBj
cWUoMzI3NjgpID4gbWF4X2NxZSgzMjc2NykgWyAxMjQ5LjY1MTkyMV0gcmRtYV9yeGU6IHJ4ZS1w
ZCBwb29sIGRlc3Ryb3llZCB3aXRoIHVuZnJlZSdkIGVsZW0gWyAxMjQ5LjY1MTkyN10gcmRtYV9y
eGU6IHJ4ZS1xcCBwb29sIGRlc3Ryb3llZCB3aXRoIHVuZnJlZSdkIGVsZW0gWyAxMjQ5LjY1MTky
OV0gcmRtYV9yeGU6IHJ4ZS1jcSBwb29sIGRlc3Ryb3llZCB3aXRoIHVuZnJlZSdkIGVsZW0gWyAx
MjU1LjIyNzkxNl0gcmRtYV9yeGU6IHVubG9hZGVkICINCg0KQWZ0ZXIgSSBhZGRlZCBhIHJ4ZSBk
ZXZpY2Ugb24gdGhlIG5ldGRldiwgdGhlbiBydW4gcmRtYS1jb3JlIHRlc3QgdG9vbHMuDQpUaGVu
IEkgcmVtb3ZlIHJ4ZSBkZXZpY2UsIGluIHRoZSBlbmQsIEkgdW5sb2FkZWQgcmRtYV9yeGUga2Vy
bmVsIG1vZHVsZXMuDQpJIGZvdW5kIHRoZSBhYm92ZSBsb2dzLg0KIg0KWyAxMjQ5LjY1MTkyMV0g
cmRtYV9yeGU6IHJ4ZS1wZCBwb29sIGRlc3Ryb3llZCB3aXRoIHVuZnJlZSdkIGVsZW0gWyAxMjQ5
LjY1MTkyN10gcmRtYV9yeGU6IHJ4ZS1xcCBwb29sIGRlc3Ryb3llZCB3aXRoIHVuZnJlZSdkIGVs
ZW0gWyAxMjQ5LjY1MTkyOV0gcmRtYV9yeGU6IHJ4ZS1jcSBwb29sIGRlc3Ryb3llZCB3aXRoIHVu
ZnJlZSdkIGVsZW0gIg0KDQpJdCBzZWVtcyB0aGF0ICBzb21lIHJlc291cmNlcyBsZWFrLg0KDQpJ
IHdpbGwgbWFrZSBmdXJ0aGVyIGludmVzdGlnYXRpb25zLg0KDQpaaHUgWWFuanVuDQoNCk9uIEZy
aSwgSnVuIDQsIDIwMjEgYXQgMjo1OCBBTSBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29t
PiB3cm90ZToNCj4NCj4gT24gVHVlLCBNYXkgMjUsIDIwMjEgYXQgMDQ6Mzc6NDJQTSAtMDUwMCwg
Qm9iIFBlYXJzb24gd3JvdGU6DQo+ID4gVGhpcyBzZXJpZXMgb2YgcGF0Y2hlcyBpbXBsZW1lbnQg
bWVtb3J5IHdpbmRvd3MgZm9yIHRoZSByZG1hX3J4ZSANCj4gPiBkcml2ZXIuIFRoaXMgaXMgYSBz
aG9ydGVyIHJlaW1wbGVtZW50YXRpb24gb2YgYW4gZWFybGllciBwYXRjaCBzZXQuDQo+ID4gVGhl
eSBhcHBseSB0byBhbmQgZGVwZW5kIG9uIHRoZSBjdXJyZW50IGZvci1uZXh0IGxpbnV4IHJkbWEg
dHJlZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBn
bWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gdjg6DQo+ID4gICBEcm9wcGVkIHdyLm13LmZsYWdzIGlu
IHRoZSByeGVfc2VuZF93ciBzdHJ1Y3QgaW4gcmRtYV91c2VyX3J4ZS5oLg0KPiA+IHY3Og0KPiA+
ICAgRml4ZWQgYSBkdXBsaWNhdGUgSU5JVF9SRE1BX09CSl9TSVpFKGliX213LCAuLi4pIGluIHJ4
ZV92ZXJicy5jLg0KPiA+IHY2Og0KPiA+ICAgQWRkZWQgcnhlXyBwcmVmaXggdG8gc3Vicm91dGlu
ZSBuYW1lcyBpbiBsaW5lcyB0aGF0IGNoYW5nZWQNCj4gPiAgIGZyb20gWmh1J3MgcmV2aWV3IG9m
IHY1Lg0KPiA+IHY1Og0KPiA+ICAgRml4ZWQgYSB0eXBvIGluIDEwdGggcGF0Y2guDQo+ID4gdjQ6
DQo+ID4gICBBZGRlZCBhIDEwdGggcGF0Y2ggdG8gY2hlY2sgd2hlbiBNUnMgaGF2ZSBib3VuZCBN
V3MNCj4gPiAgIGFuZCBkaXNhbGxvdyBkZXJlZyBhbmQgaW52YWxpZGF0ZSBvcGVyYXRpb25zLg0K
PiA+IHYzOg0KPiA+ICAgY2xlYW5lZCB1cCB2b2lkIHJldHVybiBhbmQgbG93ZXIgY2FzZSBlbnVt
cyBmcm9tDQo+ID4gICBaaHUncyByZXZpZXcuDQo+ID4gdjI6DQo+ID4gICBjbGVhbmVkIHVwIGFu
IGlzc3VlIGluIHJkbWFfdXNlcl9yeGUuaA0KPiA+ICAgY2xlYW5lZCB1cCBhIGNvbGxpc2lvbiBp
biByeGVfcmVzcC5jDQo+ID4NCj4gPiBCb2IgUGVhcnNvbiAoMTApOg0KPiA+ICAgUkRNQS9yeGU6
IEFkZCBiaW5kIE1XIGZpZWxkcyB0byByeGVfc2VuZF93cg0KPiA+ICAgUkRNQS9yeGU6IFJldHVy
biBlcnJvcnMgZm9yIGFkZCBpbmRleCBhbmQga2V5DQo+ID4gICBSRE1BL3J4ZTogRW5hYmxlIE1X
IG9iamVjdCBwb29sDQo+ID4gICBSRE1BL3J4ZTogQWRkIGliX2FsbG9jX213IGFuZCBpYl9kZWFs
bG9jX213IHZlcmJzDQo+ID4gICBSRE1BL3J4ZTogUmVwbGFjZSBXUl9SRUdfTUFTSyBieSBXUl9M
T0NBTF9PUF9NQVNLDQo+ID4gICBSRE1BL3J4ZTogTW92ZSBsb2NhbCBvcHMgdG8gc3Vicm91dGlu
ZQ0KPiA+ICAgUkRNQS9yeGU6IEFkZCBzdXBwb3J0IGZvciBiaW5kIE1XIHdvcmsgcmVxdWVzdHMN
Cj4gPiAgIFJETUEvcnhlOiBJbXBsZW1lbnQgaW52YWxpZGF0ZSBNVyBvcGVyYXRpb25zDQo+ID4g
ICBSRE1BL3J4ZTogSW1wbGVtZW50IG1lbW9yeSBhY2Nlc3MgdGhyb3VnaCBNV3MNCj4gPiAgIFJE
TUEvcnhlOiBEaXNhbGxvdyBNUiBkZXJlZyBhbmQgaW52YWxpZGF0ZSB3aGVuIGJvdW5kDQo+DQo+
IFRoaXMgaXMgYWxsIHJlYWR5IG5vdywgcmlnaHQ/DQo+DQo+IENhbiB5b3UgcHV0IHRoZSB1c2Vy
c3BhY2UgcGFydCBvbiB0aGUgZ2l0aHViIHBsZWFzZT8NCj4NCj4gSmFzb24NCg==
