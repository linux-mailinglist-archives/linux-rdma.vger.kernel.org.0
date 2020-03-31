Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2706A19A224
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2020 00:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgCaW5K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Mar 2020 18:57:10 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:20900 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729647AbgCaW5K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Mar 2020 18:57:10 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VMsDUS017704;
        Tue, 31 Mar 2020 22:57:08 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 304eq2045f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 22:57:07 +0000
Received: from G4W9120.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id 3195265;
        Tue, 31 Mar 2020 22:57:07 +0000 (UTC)
Received: from G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 31 Mar 2020 22:57:06 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W9120.americas.hpqcorp.net (16.210.21.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 31 Mar 2020 22:57:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBLzwVBTE4kw4SIZvGMPb8bPV+BpCAqDxLMQrvU3pQL1qVxEhCGfKNgNiaavDPTcgoE/Z2prvlzT0d3aXuhS2sG/PReTvzvGObmyBA7wqgH8l6wVd2gHyCMCdwcAIXIZzAUentBpQwsXBkuBcYDO/gmnvgF+FPLiMO8RrDN9rw4BFzyXYTzsROOeWZ3mreA5I7bZTluQ3TJ/eBuqvv/+N+AJcaEPudmTR5bxUvs00FxlTGah3cNdK1MIMczZb8/VAbmN78nZyzAfTzfk4v4GMQUMOta8Ag9qEb0jNlHv47Y++nFelgZDiOXiV59hGR4bst2HcKoBiJs0Uy3dGuiDiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT4DZRjRaf1U04NokvWDHqykFty6tlsDGjLCLIECZqo=;
 b=RR/933kSD8sMu1JOEE+onN1sEWLqOfTBLqvdPeFF2YiiBoA1VOGdi+M+igShWNb7KCoSb9wrnAUuiHCHsIkpJXjQKPQrqmaZ0UrM5R6dGevzYB71xcvjCbwOqh+fx1FQxN0Vew1Pnt025FMQIKyJaTHz7SEilUs1wFcctX1diFQ1udKI9x2Ygex4tCw6Zlbzzk8tmDohHxqUFOQlQ/CRd9H4k1GCTJqLKxdISYXgZuXDwWoekzlNP5verzXlRcZD82+l1frEabhxEn96D9j01JZp/TF6pRpOQoEZBGx7O+XY3C9RuLPCZGva1/ks+SMxEnLStLOL5WXqNwvz/tZHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0373.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750b::8) by CS1PR8401MB0359.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7507::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Tue, 31 Mar
 2020 22:57:05 +0000
Received: from CS1PR8401MB0373.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e984:e877:8994:423d]) by CS1PR8401MB0373.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e984:e877:8994:423d%8]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 22:57:05 +0000
From:   "Rehm, Kevan Flint" <kevan.rehm@hpe.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Delphi <delphi@cray.com>
Subject: updates needed to Documentation/librdmacm.md
Thread-Topic: updates needed to Documentation/librdmacm.md
Thread-Index: AQHWB6+y/XRAy8Gqq0Kp4DL7qkt/ig==
Date:   Tue, 31 Mar 2020 22:57:05 +0000
Message-ID: <EF5E5EF5-3F38-4405-A01B-3DDDC89190BC@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [24.131.145.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cea9929-2e02-47b3-d894-08d7d5c6d573
x-ms-traffictypediagnostic: CS1PR8401MB0359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CS1PR8401MB03598EAE2D303B44B0962B7283C80@CS1PR8401MB0359.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0373.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(376002)(136003)(346002)(39860400002)(366004)(6486002)(6512007)(26005)(66476007)(76116006)(6916009)(64756008)(186003)(6506007)(71200400001)(2906002)(86362001)(2616005)(66556008)(66946007)(66446008)(316002)(91956017)(8936002)(81156014)(4326008)(478600001)(33656002)(8676002)(36756003)(81166006)(5660300002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4b/ouIGzDBySJQBHv/y1JDm8Ilp9AVTgY/G7zKafZeUT6Yha3Ss4D+hTbxeTvIkd+IK6N5mPn6xNUY1IxQ3D44bUnBMDZhQgfLCW9qEc84FtaySNkCXvTusN/dKhHUGbH27YxaMja5nZRTm4/whbVwQREw14WPLmgcQX8TQLCw5IbKSI+oTfMF2PU3EzclPFrLJyI0oQGpzUt/iNnKeyZpqgH9CoxD1+qJqcZrkswjM62d1jYf15JGJS6v3pWrq7E4Ux+aDr6oyktHGPFm0ntVgL7cJoB2QzeWPbDJgsoMwa6aRhXaUuO62is2HjvAHQ6yCzIo5bv0Imxbk1PqRh+WhvzqLg0FZiEpghAp9UAPpbpZxT5/sMImzQSLbjgSLjblc4E5E2glg/NO7czMvR3vwUN+yW6Wms2ZrUEZLtWgaZ2VLmid+xSlQLAKopJJES
x-ms-exchange-antispam-messagedata: 35WWTZiw79DM9IlmQBP4e8iknBFl568skV1mSZwpW6Qqg6okC0cENkMM59ZWa3h8PrGfFIMYDk3b2RKdbQ/ntd1sMRzq1UQNW2f/8XofisICdHcYhzmcPqSeySPUpy8PcrtJkM1OlClWqg3Tt/8QXQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <334548061DC0A849990CC79BF6868D5E@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cea9929-2e02-47b3-d894-08d7d5c6d573
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 22:57:05.6425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /C8Vn1fwyeaoye+UIfWjiaRFZU8349EghYM0poed+rzOgHMQJ72Oh0TAQxSR1R2nqijJHaAPXQ7kwq9P2mKf3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0359
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0
 phishscore=0 mlxscore=0 mlxlogscore=741 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310186
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

R3JlZXRpbmdzLA0KIA0KR2V0dGluZyBtdWx0aXBsZSBpbmZpbmliYW5kIGludGVyZmFjZXMgb24g
YSBub2RlIHRvIHdvcmsgcmVxdWlyZWQgbW9yZSBjaGFuZ2VzIHRoYW4gdGhlIGhpbnRzIHByb3Zp
ZGVkIGluIERvY3VtZW50YXRpb24vbGlicmRtYWNtLm1kLiAgV2UgaGF2ZSBhIGZldyBzdWdnZXN0
aW9ucyBmb3IgYWRkaXRpb25zIHRvIHRoYXQgcGFnZSB0aGF0IG1pZ2h0IHNhdmUgb3RoZXJzIGEg
bG90IG9mIGRlYnVnZ2luZyB0aW1lLg0KIA0KMS4gYWNjZXB0X2xvY2FsIG11c3QgYmUgc2V0IHRv
IDEgYXMgZG9jdW1lbnRlZCBpbiBpbiBsaWJyZG1hY20ubWQuDQoNCjIuIFRoZSBkb2N1bWVudGF0
aW9uIHNheXMgdG8gc2V0IGFycF9pZ25vcmUgdG8gdGhlIHZhbHVlIDIuICAgVGhhdCBvbmx5IHdv
cmtzIGFzIGxvbmcgYXMgYWxsIHRoZSBpbnRlcmZhY2VzIG9uIGNsaWVudHMgYW5kIHNlcnZlcnMg
YXJlIGluIHRoZSBzYW1lIGxvZ2ljYWwgc3VibmV0LCBlLmcuICAgaWIwID09IDEwLjAuMC4yNywg
aWIxID09IDEwLjAuMS4yNywgcHJlZml4PTE2LiAgIElmIHlvdSBoYXBwZW5lZCB0byBjcmVhdGUg
c2VwYXJhdGUgbG9naWNhbCBzdWJuZXRzLCBlLmcuIHByZWZpeD0yNCwgdGhlbiB0aGUgdmFsdWUg
MiBkb2VzIG5vdCB3b3JrLCB5b3UgaGF2ZSB0byB1c2UgdGhlIHZhbHVlIDEuDQoNCjMuIFRoZSBk
b2N1bWVudGF0aW9uIGRvZXMgbm90IG1lbnRpb24gdGhlIHJwX2ZpbHRlciBwYXJhbWV0ZXIsIGJ1
dCBpdCBtdXN0IGJlIG1vZGlmaWVkIGV2ZW4gaWYgeW91IGhhdmUgY3JlYXRlZCBhIHNpbmdsZSBs
b2dpY2FsIHN1Ym5ldC4gIFRoZSB2YWx1ZSBvZiBycF9maWx0ZXIgY2Fubm90IGJlIDEsIHlvdSBt
dXN0IHNldCBpdCB0byBlaXRoZXIgMCBvciAyLCB3aXRoIDIgYmVpbmcgbW9yZSBzZWN1cmUuICAg
VGhlIGRlZmF1bHQgdmFsdWUgb24gQ2VudE9TIDcgaXMgMS4gICBXZSBhcmUgdXNpbmcgMi4NCiAN
CldlIHdlcmUgc3VycHJpc2VkIHRvIGZpbmQgdGhhdCB0aGUgdmFsdWUgb2YgcnBfZmlsdGVyIHdv
dWxkIGFsc28gZ2V0IHJlc2V0IGFmdGVyIGEg4oCcc3lzdGVtY3RsIHJlc3RhcnQgbmV0d29ya+KA
nSwgbm90IGp1c3Qgb24gcmVib290cywgc28gdGhlIHNldHRpbmcgeW91IHdhbnQgbXVzdCBiZSBw
ZXJzaXN0ZWQgaW4gYSAvZXRjL3N5c2N0bC5kIGZpbGUgaWYgeW91IHdhbnQgdGhlIHZhbHVlIHRv
IHN0YXkgYWNyb3NzIG5ldHdvcmsgcmVzdGFydHMuICBUaGUgb3RoZXIgcGFyYW1ldGVycyBoZWxk
IHRoZWlyIHZhbHVlcyBhY3Jvc3MgbmV0d29yayByZXN0YXJ0cy4NCiANCldpdGggdGhlIGFib3Zl
IGNoYW5nZXMgcGVyc2lzdGVkIGluIGEgbmV3IC9ldGMvc3lzY3RsLmQvOTUtZGFvcy5jb25mIGZp
bGUsIHdlIGhhdmUgYmVlbiBhYmxlIHRvIHN1Y2Nlc3NmdWxseSB1c2UgbXVsdGlwbGUgaW5maW5p
YmFuZCBpbnRlcmZhY2VzIHBlciBub2RlLg0KIA0KRGlzdHJpYnV0aW9uIGlzIENlbnRPUyA3Lg0K
S2VybmVsIGlzIDMuMTAuMC0xMDYyLjE4LjEuZWw3Lng4Nl82NA0KIA0KQ2VudE9TIDcgc3lzY3Rs
IGRlZmF1bHRzOg0KbmV0LmlwdjQuY29uZi5kZWZhdWx0LmFjY2VwdF9sb2NhbCA9IDANCm5ldC5p
cHY0LmNvbmYuZGVmYXVsdC5hcnBfaWdub3JlID0gMA0KbmV0LmlwdjQuY29uZi5kZWZhdWx0LmFy
cF9maWx0ZXIgPSAwDQpuZXQuaXB2NC5jb25mLmRlZmF1bHQucnBfZmlsdGVyID0gMQ0KIA0KSWYg
eW91IG5lZWQgbW9yZSBpbmZvcm1hdGlvbiwgbGV0IG1lIGtub3csDQogDQpSZWdhcmRzLCBLZXZh
bg0KDQoNCg==
