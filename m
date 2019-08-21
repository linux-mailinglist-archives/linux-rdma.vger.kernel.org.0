Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7589740E
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 09:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfHUH4a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 03:56:30 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:46562 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726479AbfHUH43 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 03:56:29 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7L7sS1r029721;
        Wed, 21 Aug 2019 00:56:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=690ho7U6mpykGRtuSVMn3SBdClGIPjwbkoR3X6d+7N8=;
 b=t2e3FKBkYG8lfL0uK09Tk5pfu20UgRIYmTGmJXKajTw8yu3I9DwVdpCgoLkcWJhr5XcH
 jVzoHyBHdjamr4+cr5Hc2Ow8fWPeksfrW5TXJ4z5MPAkdFNWmjg7e4j3AiBPfxLctIbF
 XvWBluZ1IOR6FXCfF8dSyRn+u4gzfzyW/sgb2/cFLzOMSF7gFzxmw+qzThC9K+SAKzEi
 Hs963elid0URW8wc/suKi3t3+zj5JIXi7Bdopt+jwXYH34gyy6mDxwGNd+YzBzs+Gm46
 zeJnEDikP1jXxTmfBmxxgCiR5cRNq8Uj5ixr92UoaGqZMr2mYzi8TyPnyTyaqce6WAs6 5A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ugu7fhcr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 00:56:25 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 21 Aug
 2019 00:56:25 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 21 Aug 2019 00:56:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZzI34O7UiVgFYVyutMbE/Cchakx1lE+8GPLoN5dUNOmGIhLhwxX8+lbCmOD6chZ1p7TSkwFBHZ2AU2ovHHAdjx5gk0F4WtlaIV5iBntNoB+y8igUVa3S+3Mo4fkbxmiMZxSqHwMw/WJJeQTPBNYhdXoSy5z0ChnYr96P+gs1voV3tVsziJ5guoMfm9ZoUXA4sY8g5zFxrCZtJAZnekSIllcPZPRvvl2iMmvrWb3nrIfzXee97IBFdk7aAA4MwSotY/BzPTf2XF8Oj2Y6yLU9r36ciE4Hg3FD/353hmIqMwCF2qSBjiwj5EnHim+xPkf9UhPF4BWFrAPdGj21LrO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=690ho7U6mpykGRtuSVMn3SBdClGIPjwbkoR3X6d+7N8=;
 b=XAd3OPrCDYWOW/BiPtG3hdliXPdb8Wnl14ksrCg1WRaZ9ny4wGfafmL9BaNV4vbxVNHCyJCiO3nC7KJD8V6O5tWFkAquBcQyxC17AZcjZUEg4PKXmTouUBY8vbrEhApaIO/B5QgduDfA/l7lIhZc9Q5AJ62byzFJdHMFqeuqER+Z7MjkrBC3DNbm9PsIgLEaqEs3yaL1QY07UwZ2vR8H/REZBieRGy4kzTqq3QFFZllthJOybJJm2XqGFydmrY4WXo1jUeyAJvdhmEtrrTZ9KEYwHeNeRL40jAx1loJGdbdYoCgPE1JL/FdALIyiF1kC4J+8WicRscf74pmbk34iIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=690ho7U6mpykGRtuSVMn3SBdClGIPjwbkoR3X6d+7N8=;
 b=F7kE0GbogAY2N1j1bhC8p723IFqPaq1eDMcXT8s0gpr9Ke+XENV9XAYrSmDJWpXGjPe5cQ1+eGY/7YZzTvzM5FlDsVZjy8tbkOkAeRjFopmqh36RelhHk2IGTimhT5v6E6OSkFW8zDL00y3bd88kTCyILnf2FjbdtNKlgt/s06Y=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3039.namprd18.prod.outlook.com (20.179.83.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.19; Wed, 21 Aug 2019 07:56:19 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::f001:1b96:3396:1781%5]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 07:56:19 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v7 rdma-next 1/7] RDMA/core: Move core content from
 ib_uverbs to ib_core
Thread-Topic: [PATCH v7 rdma-next 1/7] RDMA/core: Move core content from
 ib_uverbs to ib_core
Thread-Index: AQHVV1GwGCRn/XfymEKuSvdhB7Bdf6cEErgAgAB7zECAAJAKAIAAHfhQ
Date:   Wed, 21 Aug 2019 07:56:19 +0000
Message-ID: <MN2PR18MB3182A8EEB89DB3520961489EA1AA0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-2-michal.kalderon@marvell.com>
 <0f6f1dd6-e4b3-5261-7480-0735f29bac63@amazon.com>
 <MN2PR18MB3182BE00A39C1A933C584737A1AB0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <3ba20a5e-8fd6-a42c-0818-7fcaa25a979a@amazon.com>
In-Reply-To: <3ba20a5e-8fd6-a42c-0818-7fcaa25a979a@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b301f9b0-b8e3-415f-7127-08d7260d0d69
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3039;
x-ms-traffictypediagnostic: MN2PR18MB3039:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB30393B6EF09E45AD37493F71A1AA0@MN2PR18MB3039.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(5660300002)(8676002)(71190400001)(6246003)(6916009)(478600001)(86362001)(25786009)(71200400001)(66446008)(66476007)(66556008)(64756008)(52536014)(99286004)(316002)(81156014)(81166006)(7696005)(66946007)(55016002)(9686003)(6436002)(76176011)(8936002)(6506007)(14444005)(256004)(3846002)(6116002)(53546011)(229853002)(2906002)(54906003)(26005)(186003)(14454004)(486006)(66066001)(11346002)(76116006)(53936002)(446003)(4326008)(33656002)(102836004)(476003)(7736002)(305945005)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3039;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DGPlBpHK9dWKmUxZn/WJJ7xxjOMFiP6rTUdBTrq5PtSHJdaZ5fBN/Mimp+OAuRCWSi82Q5UcyR09JrPRgvxENbXpqWZMVTN/XwTS35PvKz3ReuFus/+S/kxlZeK/JPVPMYtJDB44AcSMXfFDBBGYtccPUbQkjZdu0sRH8vE/ck02R9vEcHX3cnL/kKtm/x6foUNLR2oorQUWShP/ySJBLRPtNAwcAswZcLCsi6VfDH0QTU4/LPI4g4Bgvybr7t8n5mR3qeqhu4kJ7NyL/w4WavEHCfl1GFbRddSe6fnqmg7/gCPTE4VNBYzUDNcthPLbSNxMDvDGMegHFMcRHtmTIwvn3FA1IZPqfRmT2OXS07n+zwnsKPDH/VcRY2eIkhun1bUCsx+CDzsIA+fp7xjXyE4Bq0J67XfVpGKekiVYp3c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b301f9b0-b8e3-415f-7127-08d7260d0d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 07:56:19.6179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dXOTea56YqmnFxP6L1kWZ+EbaBzTnG8koGbuCjv/d41cTO4wABTbdqs8DFXDLodOyczKl2EFoIiDJGRC9LOaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3039
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-21_02:2019-08-19,2019-08-21 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgR2FsIFByZXNzbWFuDQo+IA0KPiBP
biAyMS8wOC8yMDE5IDA6MzIsIE1pY2hhbCBLYWxkZXJvbiB3cm90ZToNCj4gPj4gRnJvbTogR2Fs
IFByZXNzbWFuIDxnYWxwcmVzc0BhbWF6b24uY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBBdWd1
c3QgMjAsIDIwMTkgNTowOCBQTQ0KPiA+Pg0KPiA+PiBPbiAyMC8wOC8yMDE5IDE1OjE4LCBNaWNo
YWwgS2FsZGVyb24gd3JvdGU6DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvaWJfY29yZV91dmVyYnMuYw0KPiA+PiBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2li
X2NvcmVfdXZlcmJzLmMNCj4gPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4+PiBpbmRleCAw
MDAwMDAwMDAwMDAuLmNhYjdkYzkyMmNmMA0KPiA+Pj4gLS0tIC9kZXYvbnVsbA0KPiA+Pj4gKysr
IGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvaWJfY29yZV91dmVyYnMuYw0KPiA+Pj4gQEAgLTAs
MCArMSwxMDAgQEANCj4gPj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBP
UiBMaW51eC1PcGVuSUINCj4gPj4+ICsvKg0KPiA+Pj4gKyAqIENvcHlyaWdodCAoYykgMjAwNSBN
ZWxsYW5veCBUZWNobm9sb2dpZXMuIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQo+ID4+PiArICogQ29w
eXJpZ2h0IDIwMTgtMjAxOSBBbWF6b24uY29tLCBJbmMuIG9yIGl0cyBhZmZpbGlhdGVzLiBBbGwN
Cj4gPj4+ICtyaWdodHMNCj4gPj4gcmVzZXJ2ZWQuDQo+ID4+PiArICogQ29weXJpZ2h0IDIwMTkg
TWFydmVsbC4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NCj4gPj4+ICsgKg0KPiA+Pj4gKyAqIFRoaXMg
c29mdHdhcmUgaXMgYXZhaWxhYmxlIHRvIHlvdSB1bmRlciBhIGNob2ljZSBvZiBvbmUgb2YgdHdv
DQo+ID4+PiArICogbGljZW5zZXMuICBZb3UgbWF5IGNob29zZSB0byBiZSBsaWNlbnNlZCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlDQo+ID4+PiArIEdOVQ0KPiA+Pj4gKyAqIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgKEdQTCkgVmVyc2lvbiAyLCBhdmFpbGFibGUgZnJvbSB0aGUgZmlsZQ0KPiA+Pj4g
KyAqIENPUFlJTkcgaW4gdGhlIG1haW4gZGlyZWN0b3J5IG9mIHRoaXMgc291cmNlIHRyZWUsIG9y
IHRoZQ0KPiA+Pj4gKyAqIE9wZW5JQi5vcmcgQlNEIGxpY2Vuc2UgYmVsb3c6DQo+ID4+PiArICoN
Cj4gPj4+ICsgKiAgICAgUmVkaXN0cmlidXRpb24gYW5kIHVzZSBpbiBzb3VyY2UgYW5kIGJpbmFy
eSBmb3Jtcywgd2l0aCBvcg0KPiA+Pj4gKyAqICAgICB3aXRob3V0IG1vZGlmaWNhdGlvbiwgYXJl
IHBlcm1pdHRlZCBwcm92aWRlZCB0aGF0IHRoZSBmb2xsb3dpbmcNCj4gPj4+ICsgKiAgICAgY29u
ZGl0aW9ucyBhcmUgbWV0Og0KPiA+Pj4gKyAqDQo+ID4+PiArICogICAgICAtIFJlZGlzdHJpYnV0
aW9ucyBvZiBzb3VyY2UgY29kZSBtdXN0IHJldGFpbiB0aGUgYWJvdmUNCj4gPj4+ICsgKiAgICAg
ICAgY29weXJpZ2h0IG5vdGljZSwgdGhpcyBsaXN0IG9mIGNvbmRpdGlvbnMgYW5kIHRoZSBmb2xs
b3dpbmcNCj4gPj4+ICsgKiAgICAgICAgZGlzY2xhaW1lci4NCj4gPj4+ICsgKg0KPiA+Pj4gKyAq
ICAgICAgLSBSZWRpc3RyaWJ1dGlvbnMgaW4gYmluYXJ5IGZvcm0gbXVzdCByZXByb2R1Y2UgdGhl
IGFib3ZlDQo+ID4+PiArICogICAgICAgIGNvcHlyaWdodCBub3RpY2UsIHRoaXMgbGlzdCBvZiBj
b25kaXRpb25zIGFuZCB0aGUgZm9sbG93aW5nDQo+ID4+PiArICogICAgICAgIGRpc2NsYWltZXIg
aW4gdGhlIGRvY3VtZW50YXRpb24gYW5kL29yIG90aGVyIG1hdGVyaWFscw0KPiA+Pj4gKyAqICAg
ICAgICBwcm92aWRlZCB3aXRoIHRoZSBkaXN0cmlidXRpb24uDQo+ID4+PiArICoNCj4gPj4+ICsg
KiBUSEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBB
TlkNCj4gPj4gS0lORCwNCj4gPj4+ICsgKiBFWFBSRVNTIE9SIElNUExJRUQsIElOQ0xVRElORyBC
VVQgTk9UIExJTUlURUQgVE8gVEhFDQo+ID4+IFdBUlJBTlRJRVMgT0YNCj4gPj4+ICsgKiBNRVJD
SEFOVEFCSUxJVFksIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFORA0KPiA+Pj4g
KyAqIE5PTklORlJJTkdFTUVOVC4gSU4gTk8gRVZFTlQgU0hBTEwgVEhFIEFVVEhPUlMgT1INCj4g
Pj4gQ09QWVJJR0hUIEhPTERFUlMNCj4gPj4+ICsgKiBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwg
REFNQUdFUyBPUiBPVEhFUiBMSUFCSUxJVFksIFdIRVRIRVINCj4gSU4NCj4gPj4gQU4NCj4gPj4+
ICsgKiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1IgT1RIRVJXSVNFLCBBUklTSU5HIEZST00s
IE9VVA0KPiBPRg0KPiA+PiBPUiBJTg0KPiA+Pj4gKyAqIENPTk5FQ1RJT04gV0lUSCBUSEUgU09G
VFdBUkUgT1IgVEhFIFVTRSBPUiBPVEhFUiBERUFMSU5HUw0KPiA+PiBJTiBUSEUNCj4gPj4+ICsg
KiBTT0ZUV0FSRS4NCj4gPj4+ICsgKi8NCj4gPj4NCj4gPj4gSXMgdGhlIGZ1bGwgbGljZW5zZSBu
ZWVkZWQgaW4gYWRkaXRpb24gdG8gdGhlIFNQRFg/DQo+ID4gVGhlIGZpbGUgY29udGFpbnMgY29k
ZSB0aGF0IHdhcyBwbGFjZWQgaW4gYSBkaWZmZXJlbnQgZmlsZSBhbmQNCj4gPiBjb3B5cmlnaHRl
ZCwgc28gSSBjb3BpZWQgVGhlIGNvcHlyaWdodHMgZnJvbSB0aGUgb3JpZ2luYWwgZmlsZXMgYmFz
ZWQgb24gdGhlDQo+IGdpdCBoaXN0b3J5IG9mIHRoZSBjb2RlIGxpbmVzIEkgY29waWVkLg0KPiA+
IFRoYW5rcywNCj4gPiBNaWNoYWwNCj4gDQo+IEknbSByZWZlcnJpbmcgdG8gdGhlIGxpY2Vuc2Ug
dGV4dCwgbm90IHRoZSBjb3B5cmlnaHRzLg0KT2ssIGdvdCBpdCB0aGFua3MuIEkgdmVyaWZpZWQg
dGhlIHRleHQgaXMgaWRlbnRpY2FsIHRvIExpbnV4LU9wZW5JQiB1bmRlciBMSUNFTlNFUy4gIFdp
bGwgcmVtb3ZlIHRoZSB0ZXh0IGFuZCBsZWF2ZSBvbmx5IHRoZSBzcGR4IGlkLiANCg==
