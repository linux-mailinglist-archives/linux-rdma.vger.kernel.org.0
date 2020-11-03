Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698B62A4BA5
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 17:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgKCQfX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 11:35:23 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:15644 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726212AbgKCQfX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 11:35:23 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3GIrD1008596;
        Tue, 3 Nov 2020 16:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=UpiUfCEAfX2H+3S9vl0gU/r1r0yRGQGyBCQPUSlLoSk=;
 b=B+gpaomCvRw5PLX1anQ5XWo9miyGbuCOgM0vX8ybwSfey2NtQ91fegInm28d99xe8mAP
 2CBYLggdKPpmLpRqEIPFVmeGwFpQaYHMr9ZfB1LAWyK7pp8LKGBGvC0uBgnbta6aZ23x
 8yCDdA8UUPkFiWorPMe1DIf+GOH3QJP54jXujFC74zAKOZBCCYdD2rUkiExoHTUbhRXP
 lTxoVd8IpGwZRA/6k0kq/+FLv86J22upkMQ0gTzDxZadw4ijygFvGw4mYwZIzgha4BmC
 OghPw8JHyLILTPfxePgEHe20TvWfcfOi/t+S6eutTQ/vOLuexO2sqUTZHVYaBYnmdzRO hw== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 34k9ca0u8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 16:35:19 +0000
Received: from G4W9120.americas.hpqcorp.net (g4w9120.houston.hp.com [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 3C73181;
        Tue,  3 Nov 2020 16:35:18 +0000 (UTC)
Received: from G9W8454.americas.hpqcorp.net (2002:10d8:a104::10d8:a104) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 3 Nov 2020 16:35:18 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W8454.americas.hpqcorp.net (16.216.161.4) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 3 Nov 2020 16:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IekQNUKwBkwMjMjkgEvzBdBeXIfRxj5FA9EHd6fA/gbqGZhC1OSMEfMBp23e8ePC4Sb6Ng3EmavzuFCd9poi0IhyYfyGWcYK7iOg5wMxmQ6PTeCekGUCmmutag6d2O0AH6byls7m4vgu0fPp+vyeQkyigMtkSywqst7t8SyMkIAcqngsxCfypc0xLYF4usbGE4hHCZPgdZDtHqs1xOskcGa+sjmK+7eQG09Wiizr9Plf/ShE9xdkPEdkDO8Npt9MXGBAd3kWuDlPnJFRBIIQFDWVrCCVkNH0KwoPfnN3esmy2SLk0YbiDWAXeBbVdjfhM1rHFa6+8jew95JOG1GMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpiUfCEAfX2H+3S9vl0gU/r1r0yRGQGyBCQPUSlLoSk=;
 b=iq456+oe7S+VFc+hwX6FSVkNfoAynWGqjHaPS9QXNJnCkHwmpLO2QSowasCjYE8zJ86/JqGGdU0FRNt/mfeiwcsdmTk82NTYvYY84qXT95hU1sZkD9Wp2l1XmZWm4RZKo8UnNkBAKhvJ5fJ9FilJb7VI72pLifqUNu4kMRU+/8CsyYGoedeubUNZGNwljlAtIYaLmefCWHmh1RV9A46KihU/WHJ9Nh8Q/Bmpxq9FUz50PYS3RnfEupoycIv5oGI5Yeu2sKz8GWQ+NVLYECDdppcLWvrA2phqOykBI/Rr93tSPvOfkMYbUcyJXNuuFNTnAKx57R8avvdzbb/ph54Iaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB0725.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7509::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Tue, 3 Nov
 2020 16:35:16 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7c1c:4b55:a7c1:cc55]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7c1c:4b55:a7c1:cc55%12]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 16:35:16 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        linux-rdma <linux-rdma@vger.kernel.org>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: Oops problem with rxe from 5.10-rc kernel
Thread-Topic: Oops problem with rxe from 5.10-rc kernel
Thread-Index: AQHWsWv5aKu4RWaPLEiEw5YpfGlTq6m2miVA
Date:   Tue, 3 Nov 2020 16:35:16 +0000
Message-ID: <CS1PR8401MB082109E7EC37690E063A437FBC110@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <CAN-5tyHaVyoLMOc0Qtte=Gz+UUE+HX1b3E1d9xh-RD3Uve22JA@mail.gmail.com>
In-Reply-To: <CAN-5tyHaVyoLMOc0Qtte=Gz+UUE+HX1b3E1d9xh-RD3Uve22JA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:8c91:3dc:8a22:b3d2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec5da269-8767-4653-b968-08d88016725a
x-ms-traffictypediagnostic: CS1PR8401MB0725:
x-microsoft-antispam-prvs: <CS1PR8401MB07254316E350DE456F22A833BC110@CS1PR8401MB0725.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r5VXKqxUHibx6fn9up9Yrigb4FqVfzqP8vDxpIIMGXNRoVMuCwrU8pDv/47cXjQKBUTtMkZyjuI0uqLu8wdrlCjTHGXT06w/dd82WeHYknbDKJAATDLMJV1tD7Ek0WAoc8TIAc3JOYTbvNcHzXh2q0RZoIWWWWvoFG6HNZCKzG0UBGY/bT4yUObw4ysPiFsElYM7tmnAHztdhyZgQVoE8+4ZUcmK7S/8jH6yitdXMttcucU1laiNKLKofYQVEsmf6nTc1iSqhuVwj1+5FcW1mGAjOiNScxIvAIrS3TYFXHi7+KpmKUNRDVp5/NNA7p2Eeysa5uJmSPk/6EoXWE4jTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(366004)(8676002)(2906002)(4744005)(316002)(478600001)(4326008)(71200400001)(52536014)(5660300002)(110136005)(76116006)(9686003)(55016002)(86362001)(7696005)(64756008)(66446008)(66946007)(33656002)(53546011)(8936002)(6506007)(186003)(66476007)(66556008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /K1wVSIjIw3VJSOHzWEeHRXI2+wRX2OKM7hUpGogZIyf98yv/MjRUEzUi3t9b9pFwyRZqAN1vgBTyuSTXhjV6e2Qk5J9Fds6kSmLMpWM0yiZIBhiZztvHWx/xq3L1fnQ6X963+Yaq6WES5Xx3AhWP+dfvE9+xV0yDA/fP5eZ93mlzfsQe1i0ZNiBmNO/tnD5A8XFN2eTaMiv1xpSNTIEqyQwMQondaDOL3vV5cnUY/TkUSNpuz0ZQOtLtggnnGcQ0WY3GNCA57Rbg7dWqKySJeLzHDK6Cr1yeEcxcCsvxqf3fBLliA0JOXDfoPNcdmlJF6FoKEj+X4PbBc387ZU7CN0aWe5/lCbOXBGlIGG5vzRK+wn9Cb2Yu6nQvlKKIP8tHBPCrGtRdL6ohPZ8DzCmX7Eg7SetXXzR/AaMdmUE8bLyI27UPp+6d5Na5oz5gL8r6HQstnEvzD0+gbOoEPnXBbAkg97mlmqtAz2EpVTJnku8NAEcZKybaUgJMIXez84eESG87kjFtCLqBF3zjNIX0/Hr1uq+oytWv6io149cARyiTY6fIDYFKf8kPdugfIv6Qq1Aj0pApi7BbxfA6mfuyD0eeDBTvytlJVbUwP4B/Z0t3Dadvx9PsyFOh4ztkgLMlRkd62BCSSqkOaMbD53Cp/w2wuC+oNQz1SlYwqjhZ+WbseeKrlXmBKYnncWttgkkhH7/ylkx+fvTaTrNJF0jYw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5da269-8767-4653-b968-08d88016725a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 16:35:16.7689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGaiBC7L4bOS5fSyP7cUKGKRsjd/JuNdU/m413t6OsQnUHYUCFLl3imD+VE5LfZVlYC/MvUQxfuwW4F+WWoreA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0725
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 malwarescore=0 phishscore=0 priorityscore=1501 mlxlogscore=961 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030109
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbGdhIEtvcm5pZXZza2FpYSA8
YWdsb0B1bWljaC5lZHU+IA0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDIsIDIwMjAgNTowMCBQ
TQ0KPiBUbzogbGludXgtcmRtYSA8bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBP
bGdhIEtvcm5pZXZza2FpYSA8YWdsb0B1bWljaC5lZHU+DQo+IFN1YmplY3Q6IE9vcHMgcHJvYmxl
bSB3aXRoIHJ4ZSBmcm9tIDUuMTAtcmMga2VybmVsDQo+DQo+IEhpIGZvbGtzLA0KPg0KPiBJcyB0
aGlzIGEga25vd24gcHJvYmxlbT8gSSdtIHVuYWJsZSB0byBkbyBzaW1wbGUgcnBpbmcgb3ZlciBT
b2Z0IFJvQ0Ugc3RhcnRpbmcgZnJvbSA1LjEwLXJjMSBrZXJuZWwgKDUuOSB3b3JrcykuDQo+IFRo
aXMgaXMgYW4gb29wcyBmcm9tIHJ1bm5pbmcgdGhlIGZvbGxvd2luZy4gSSdtIGFsc28gPiB1bmFi
bGUgdG8gZG8gTkZTLW92ZXItUkRNQS4NCj4NCj4gc3VkbyBycGluZyAtYyAtYSAxOTIuMTY4LjEu
MTA1IC12IC1DIDMNCj4gcmVjdl9idWYgcmVnX21yIGZhaWxlZA0KPiBycGluZ19zZXR1cF9idWZm
ZXJzIGZhaWxlZDogMjINCg0KVW5mb3J0dW5hdGVseSByeGUgZ290IGxlZnQgaW4gYSBicm9rZW4g
c3RhdGUgaW4gNS4xMC4wLXJjMS4gDQpZb3UgY2FuIHBhdGNoIGl0IG9yIHdhaXQgdW50aWwgcmMy
LiBGZWVsIGZyZWUgdG8gZW1haWwgbWUgZm9yIHRoZSBkZXRhaWxzLg0KDQpCb2IgUGVhcnNvbg0K
cnBlYXJzb25AaHBlLmNvbQ0K
