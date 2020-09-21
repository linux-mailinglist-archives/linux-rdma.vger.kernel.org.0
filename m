Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AB52730CD
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 19:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgIURWj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 13:22:39 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:40770 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726584AbgIURWj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Sep 2020 13:22:39 -0400
X-Greylist: delayed 2862 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 13:22:38 EDT
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08LGX634020018;
        Mon, 21 Sep 2020 16:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=o1e1bPOvFY8lf4v3LG4V2xUCNn3wXuoJmD0fC+qQAbQ=;
 b=fV/wSni9LQrVBPsQxvzB0DxlSPm5KYVw+aOryAANrpCYxB7uHh+O4xqn/7vgLmVrgYst
 vYtcMOVIp/mzWawQAiv5hBq5zwhNdh2rGCIRNQT2PzPziKz4cxmkAj/coVBMReYQ/cq4
 cZoSRvkcK6uLP91A+zhz788x7HRKbgQZ4/qfzOX+Oui0UQ1BbSYeirgiuLRihUw+0AWG
 fhw34WgLGiFSkSK38kcyPsJSvqZMVAjjhi3w+K2jpzPL/ZFGFVHUD6xgsy3HpB1iKJfs
 xmWuI6iz6ef81X9Tb80Y18f3a+wNweAFcAx5EsmajvrbeS/GvaTDLdkB8s40eZN9OmWd DA== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 33nb6dxm21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 16:34:54 +0000
Received: from G2W6309.americas.hpqcorp.net (g2w6309.austin.hp.com [16.197.64.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id BCB036D;
        Mon, 21 Sep 2020 16:34:53 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) by
 G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 21 Sep 2020 16:34:53 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.241.52.13) by
 G2W6309.americas.hpqcorp.net (16.197.64.51) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 21 Sep 2020 16:34:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE6Y2TL/+Z0W+5xNOS7oQVqfyTFNyPIk8o6HPzTUmw9P3/iilKcagG3lmhCa0Kpj/9kUN75UL1MtbwGAnh9LbAwkhqErUvWSj232zDPkHK675i/IRxnDjty2D72NlIhZtmzvMgXk302QdToe+Wz8mVB8TUWQKVwdKARRbPmPlcYzdUDthewOx54eVQiwftD0WDOATH3BuNLwDzMHSwUyFi8Sb5yveJ2sIg5/XGaYRwxWTg5RbpkLd8mvBfaWgSzQKarreIQtI+9PTe/OaId10Do3DAC4ZD3oV83yERJYO/b582UpKvPaBi2io99xilCg+W2IxaabENmqaAfdC+jWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1e1bPOvFY8lf4v3LG4V2xUCNn3wXuoJmD0fC+qQAbQ=;
 b=BUTOviezE8AFyeCL/e6O+7X4Y17JeLSjGHYuAHpzbPVGz9B3cmyo3wHEUQJzQogMJsPw6gd9DF+6ww7LOYsQD+2squUxPZyunzKK2aG4WwoqPSlywulfgLFZJzqWTPWphS7WC5Yr9XKrA/X4bDU2nWv+Xk9oHW5n/7K5j2nozX2vUs32qKb4yMjHnkaWRrUJk1S1WAnKyO9MabuHPEC9yXwfNTl1LlfzdMI+bH/qCH7qBd5tsD8r/hk1/aw/uHHborFUx48mpy+Db5Iek09e/33BDQbt3QWKxbz44+rBAcSXYMGyGV/59hsqREvhy+cRr6hcD4xZU3xGfieSlNDGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB1205.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7514::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Mon, 21 Sep
 2020 16:34:52 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3407:a0fd:38c1:70cc]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::3407:a0fd:38c1:70cc%7]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 16:34:52 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Edward Srouji <edwards@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: pyverbs regression
Thread-Topic: pyverbs regression
Thread-Index: AQHWjeB+rv0PG0wt2USWnJR+zj7A8Kly294AgAByV1A=
Date:   Mon, 21 Sep 2020 16:34:52 +0000
Message-ID: <CS1PR8401MB0821BD9BEF78160638B4C7A2BC3A0@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <5c484f6d-364f-834d-0b16-144be92fc234@gmail.com>
 <1fb57743-20fd-1316-8071-cc3ab056e582@nvidia.com>
In-Reply-To: <1fb57743-20fd-1316-8071-cc3ab056e582@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2605:6000:8b03:f000:6c79:b21d:dede:76fa]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c92539a-d304-462a-0c40-08d85e4c43e1
x-ms-traffictypediagnostic: CS1PR8401MB1205:
x-microsoft-antispam-prvs: <CS1PR8401MB12053FC82DE495D0619040AABC3A0@CS1PR8401MB1205.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mQreXkt8FJWSqjAQjfptp52xBqGolcoHTxEckZNI/p8JU56ehY1HLLFiT0f0vgM2mICSjMlnjKd+VFVK6N6dLHbd2fQiXmrEp4X+D0Qr/s0jrb8wRtFWH9dVH4dQKyU3UXV7XKmSQCXzotUqSyU2QyBz6o9punXmgmaGUENc2AA5k1KwVbcWeXjLz7SPn7RclxwFb5czFVfeIH1EgLGRKfCznt23Dq4nNF8Nynvl2hUdDO0uLki+tdyQq3DW5URkwkLdjhWuXdz52n+H/4hQzFwWdvELy5fTdjtlxagXnNT74eS2cNb2jR+d/pyEcwU5tigIztmpg7vW1uoIiHC1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(39860400002)(346002)(76116006)(186003)(9686003)(83380400001)(86362001)(5660300002)(66446008)(66476007)(52536014)(55016002)(66946007)(478600001)(66556008)(64756008)(7696005)(316002)(8936002)(8676002)(6506007)(110136005)(71200400001)(7116003)(33656002)(3480700007)(2906002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aSG8Zbr7YlNbnmjgrVWxSaJlboXTbKytJueUsxf8afObwBzaJF4MTOVXTSZ74epAPzhaaB50ppHJL5zgFF6ofUYXVd2Y5ltQujGqeKfsdpR7U8Dpu4c9PqEhewMlRCMNtZeel57bRAEXuEsYdYfEzHZB5UKmZoKEXZ/lGQFFGPKRRHqU2nWSjyZWw3J0pjbNW6lU+kH+TMNtFoMTmC2SYNpG1x9s2NKh4T3fu0jYxQ1/xkLEWalrX4D18yZOsYsPMBdVLm6Hl/gO82T/Zy1hAS9CfVM1BLDbYqUtoczn9+7RoK74nwbGEK42gOw3gjt0JvQabB8EbZAD9VjJrR6DDZn2siGCd7ZHSStuxHtYYUZ0SFvTwLVHN3AjVWt3vfmVGS/ftFLyAhktsEYxx5VFwzOWyKkLT+nxqZoPT3N1Tlfts2uTlFJlFXUIGbJ09Dj88R9MyyRzQZa5c62kAvlS/mxuZMK9JPKt/NA/SKFeZmPNJG9K15lOYoMPi9r+Y3dCfjNNzKr9g68JDa9cOTfV2xeMxFXpWgecGP/kWgtZ0Yp7e0ilL8/dTolLLR0YXcEZSTDd2Wec5uxxOJ+syDWhUgwsp5zPpYOqnq0W+YVitEtXLo6e7QvK+ssu/+4NMaHUAccrovRZkBQPv5w89nH0GYgr4GRjS6K+pCUdencKigV/6NBfmFOyKMx/d//i5rNb5rX76j3D3zcvZuS7unqYHQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c92539a-d304-462a-0c40-08d85e4c43e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 16:34:52.0793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xFe1FSkMu3EgdvdWj3RVIGaHspmFS71OpeNd7mDRSJW2sCmSG3anCNHGTI+1v5WiOsN5Y+ML8ckrBOKN1gzEog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1205
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_05:2020-09-21,2020-09-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210117
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RWR3YXJkLA0KDQpUaGF0IHByb2JsZW0gd2FzIHJlc29sdmVkIGJ5IGZvbGxvd2luZyBMZW9uJ3Mg
c3VnZ2VzdGlvbiBhbmQgZGVsZXRpbmcgdGhlIGJ1aWxkIGRpcmVjdG9yeS4gSSBkbyBub3Qgc2Vl
IGl0IGFueSBtb3JlLg0KDQpCb2INCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEVkd2FyZCBTcm91amkgPGVkd2FyZHNAbnZpZGlhLmNvbT4gDQpTZW50OiBNb25kYXksIFNlcHRl
bWJlciAyMSwgMjAyMCA0OjQ1IEFNDQpUbzogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWls
LmNvbT47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogcHl2ZXJicyBy
ZWdyZXNzaW9uDQoNCkRpZCB5b3UgbWFrZSBzdXJlIHRoYXQgUHl2ZXJicyB3YXMgcmVjb21waWxl
ZCBhcyBwYXJ0IG9mIHJkbWEtY29yZSByZWJ1aWxkPyBJdCBsb29rcyBsaWtlIHlvdSd2ZSBuZXdl
ciByZG1hLWNvcmUgd2l0aCBvbGRlciBQeXZlcmJzIHN0cnVjdHMuDQoNCkFsc28sIGlmIHlvdSBo
YXZlIG11bHRpcGxlIHB5dGhvbiB2ZXJzaW9ucyBtYWtlIHN1cmUgdGhhdCBQeXZlcmJzIHdhcyBp
bnN0YWxsZWQgdW5kZXIgdGhlIHZlcnNpb24geW91J3JlIHVzaW5nLg0KDQpJIGRvbid0IHNlZSB0
aGVzZSBpbmNvbnNpc3RlbmNpZXMsIGNhbiB5b3UgcGxlYXNlIHByb3ZpZGUgd2hpY2ggaGVhZHMg
eW91J3JlIGxvb2tpbmcgYXQgaW4gY2FzZSB5b3Ugc3RpbGwgc2VlaW5nIHRoaXM/DQoNCk9uIDkv
MTgvMjAyMCA4OjIzIFBNLCBCb2IgUGVhcnNvbiB3cm90ZToNCj4gSSBwdWxsZWQgaGVhZCBvZiB0
cmVlIGZvciByZG1hLWNvcmUgYW5kIHRoZSBrZXJuZWwgYW5kIHJlYnVpbHQgdGhlbSBhbmQgSSBh
bSBub3cgc2VlaW5nIHRoZSBmb2xsb3dpbmcgd2FybmluZ3MgZnJvbSBweXZlcmJzIHdoaWNoIEkg
aGFkIG5vdCBzZWVuIGJlZm9yZS4gVGhlIHRlc3RzIEkgZXhwZWN0ZWQgdG8gcnVuIGFyZSBzdGls
bCBydW5uaW5nIGJ1dCB0aGVyZSBzZWVtcyB0byBiZSBhbiBpbmNvbnNpc3RlbmN5IHNvbWV3aGVy
ZS4NCj4NCj4gPGZyb3plbiBpbXBvcnRsaWIuX2Jvb3RzdHJhcD46MjE5OiBSdW50aW1lV2Fybmlu
ZzogcHl2ZXJicy5zcnEuU1JRIA0KPiBzaXplIGNoYW5nZWQsIG1heSBpbmRpY2F0ZSBiaW5hcnkg
aW5jb21wYXRpYmlsaXR5LiBFeHBlY3RlZCA1NiBmcm9tIEMgDQo+IGhlYWRlciwgZ290IDY0IGZy
b20gUHlPYmplY3QgPGZyb3plbiBpbXBvcnRsaWIuX2Jvb3RzdHJhcD46MjE5OiANCj4gUnVudGlt
ZVdhcm5pbmc6IHB5dmVyYnMucXAuUVAgc2l6ZSBjaGFuZ2VkLCBtYXkgaW5kaWNhdGUgYmluYXJ5
IA0KPiBpbmNvbXBhdGliaWxpdHkuIEV4cGVjdGVkIDEwNCBmcm9tIEMgaGVhZGVyLCBnb3QgMTEy
IGZyb20gUHlPYmplY3QgDQo+IDxmcm96ZW4gaW1wb3J0bGliLl9ib290c3RyYXA+OjIxOTogUnVu
dGltZVdhcm5pbmc6IHB5dmVyYnMucXAuUVBFeCANCj4gc2l6ZSBjaGFuZ2VkLCBtYXkgaW5kaWNh
dGUgYmluYXJ5IGluY29tcGF0aWJpbGl0eS4gRXhwZWN0ZWQgMTEyIGZyb20gQyANCj4gaGVhZGVy
LCBnb3QgMTIwIGZyb20gUHlPYmplY3QNCj4NCj4gQm9iIFBlYXJzb24NCg==
