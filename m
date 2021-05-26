Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6624F391B62
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhEZPOo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 11:14:44 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:33611 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235339AbhEZPOn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 May 2021 11:14:43 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14QFCj7Y016688;
        Wed, 26 May 2021 15:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=IachDA/U8wOSXsivHnB+V8Ris3oXkiYjIzUYGR4/9KM=;
 b=bEJ/cxjPUpMipHW4wWpdkVGY1d1xniaVxdhPgacS8QzGBJmORGgpZVOeizV5JX48jdGL
 0RDGJpTrHIBZlTPKNAW8Jx7TQ7cSXdsVdXs1ofu+9EGadcSlsq4pxWCkL+kAZFGD7X/X
 hr9Fy3e/WnXTOErsS7AFEcM+M0PDz8sM6tlVfqj+OxDeYPtHxU19YZs6y/bYk6bHNEVh
 +fxpSrJQiX+iNkO683oS2F5UnqPQjqX7PwwG975pWxNtm1+GysqatMg5dVwDAe9QqKcp
 SFe6ArUyK0imjTOXz5o3FSZwWcxPalWlN9vNBaxRJS/ldvOku0ZE7PVoUQhlkazvhKzL Jg== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 38sqr00tvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 15:13:08 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 75DBEBC;
        Wed, 26 May 2021 15:13:07 +0000 (UTC)
Received: from G4W9336.americas.hpqcorp.net (16.208.33.86) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 26 May 2021 15:13:07 +0000
Received: from G2W6311.americas.hpqcorp.net (16.197.64.53) by
 G4W9336.americas.hpqcorp.net (16.208.33.86) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 26 May 2021 15:13:06 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (15.241.52.13) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 26 May 2021 15:13:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnZxdUZswnJ1YoJVgqQNzRKfsWxWdOkLp06QK1ZhjAF0TAITovWum7eOy0ZRP6fgKjEJ9kmy1qIWO1P/ehFu2q5W7TfiPqYR0pFjp+YfrdSj14C53SvwJFko1XSbfF9aySGCh3Jr/hHjsE296ju1tAzGi83dKtRbHCMXnqA1Ch7eiKNbFBXQwnBY3TBEr+UGpotMnKJfYXLVs6KCtfPZ2q3OhFkHa0Ug/KS8v0VP5qFfmT3dK275Jt7DCrdfoceWt+6QxJsOj5amsv3aJ3T2i3plf0mWptKdWAnGbcFO1hFssYUg6bCyMzqfQNBrlGDQ93NfD85qZbhqUfyxb+506A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IachDA/U8wOSXsivHnB+V8Ris3oXkiYjIzUYGR4/9KM=;
 b=njtQeMtc+923gl2oQ66cW2Y0YKD+wEOltqhkat6Buz0kYRLc86fwrezMU3YS3kCIC4gBKOCUqyFYKQJ4+h2Ouhpgo4RjyZ65efLqQDCifK8Pv/K0E+JKPwIFOAGhuGWp8x1IkDT7E0R489cshSk/tAlZPN7XsaGNV5gczepninYcFQvxJNZcbCTBwqvg4Na0tRSKmCIAjOd2DKMbPMcXnrdtE4WUfl5eGqYfKpR3AshwRM7X5PsOLPjRVmox2qGeW0AZugMgdQWBaCnB2B49t0lWmrPaps3Tzmsj9iw8rxsnkCRoB+j05W24S2VjUpbuQUB5AP4Cmev/u9DVnzrhFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7512::16) by CS1PR8401MB0904.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7511::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 15:13:05 +0000
Received: from CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074]) by CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f10c:ded5:f64e:5074%7]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 15:13:05 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "zyj2020@gmail.com" <zyj2020@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next] RDMA/rxe: Fix memory ordering problem for resize
 cq
Thread-Topic: [PATCH for-next] RDMA/rxe: Fix memory ordering problem for
 resize cq
Thread-Index: AQHXUaJXh7ik6e12JEuCb5VcMdDoNKr1Q6yAgACI1PA=
Date:   Wed, 26 May 2021 15:13:05 +0000
Message-ID: <CS1PR8401MB10960F45011F78151C1345E1BC249@CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210525201111.623970-1-rpearsonhpe@gmail.com>
 <CAD=hENdFca7919P37UGKt0bsph7TMTBomytJ93coivdpELhAJA@mail.gmail.com>
In-Reply-To: <CAD=hENdFca7919P37UGKt0bsph7TMTBomytJ93coivdpELhAJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:9c3e:91a9:fec:4490]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c859d66-7ed1-4e29-368c-08d92058c36d
x-ms-traffictypediagnostic: CS1PR8401MB0904:
x-microsoft-antispam-prvs: <CS1PR8401MB09048ABA54BEB3C60831C536BC249@CS1PR8401MB0904.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 98cg13nX1/1DcESxS9CvgGpajHI49VCjdCQJ+jEcqGK+hrzQhHAIBp40kPtvpkYdvRQD72G/JhmYlY55DnPW5gn+mcIwtiKZy4V42KjECw1MAkAPY+XKWziASJRUJ8eVJma6BqSiIQSoah+ilsLhEXTt9U9gPaD+UllUXm0TJ+HQbA0ClM+fk4ZF1quPAYO4it1KhNixQfj677AqKKu3cMhhfZlYsa0F1HoR+h3Hygh8/Wl4CybCmWoqWl8QEkPshMwN129tJ8GvknxBtq1++PKbTXa3flrrgjztg/3StGcujEffVDR6ihSy1HXPiiy8ucEsjKXYjqHiW8Ihja8u6HBmN4P3exarALmCfNiABMzxEZG6x9B6jWWaJnuDZGkqJoGTf8Juem59lfA+35bFwmlQuNQ4hYJ+XrQHdSVlZUbj6gp+No9B1moZaWBEQiU1UtBt+j2D4jNsssKG70qFci8F6Av/XtiAS0TAcfakgYLtvBdIHqLO5ZnRIHyTjpKq6kgsmbhPOSQlBwu+oruyT2qS0CIN2URBoHCabqAXknvGeY7pn3syEahcid6S4bGIMQds2cszCCx2157+gesQwb5nbjw6hNOpuerbZTthcXM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(396003)(136003)(346002)(9686003)(186003)(54906003)(110136005)(55016002)(86362001)(8936002)(2906002)(4326008)(316002)(8676002)(83380400001)(71200400001)(66476007)(66556008)(76116006)(66446008)(52536014)(64756008)(6506007)(33656002)(53546011)(7696005)(38100700002)(122000001)(66946007)(478600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UHBGRG5iZXdscG52SWk5NlVML2l4SWRSSnVaam5jdmdUdXJTeHVYclV6b2Z0?=
 =?utf-8?B?dVdaYk5aNlhkUjd0UFFHbWo0WjJrU3FXQnNXRVo4ZldwTys3ditqSmM1dkU1?=
 =?utf-8?B?MTNKcjBTdm0zeS9LVEpPeEtTL0tjMTE4STc1MVFYWVdwLzZaS29KOVJLVDFk?=
 =?utf-8?B?d3I0VmZpaWhObndpM3FmM0hPQkc2TmRlTDJPd1dPNEtVSmFrTG5tVkpzd3hT?=
 =?utf-8?B?NzFWNWJCOTUwVVpWcUUxNUV1ZnZWSkVHbFdyOTdiME4zSWVnWTRzSjhvYzRL?=
 =?utf-8?B?SlBCTlNyRFhvUTRIRC9uWjJsaFlnclR1RmZ1K3lkNVdES3RXOERrZXZnOFJk?=
 =?utf-8?B?N1ZqYy80eUprOW0zZVZISzEySFFFc2tuMGpxdlhxWXMyVFV5OHhrN1U3eU8w?=
 =?utf-8?B?VGljR1hnb3Q2L1VTaFBLczFRTDQ5VVNKZEhZM3ZVSWd3Q2haWkkzL3U3WEpV?=
 =?utf-8?B?TzBROUt3UDh4VEFTNE9WZWpzZ2VuOForWDRsQmhFT3BnaGNrZHY4alJNZmJX?=
 =?utf-8?B?V3FXTHJDQWVrRkRiMnlIUTg5WmluZ0ZKVGl6Y0ZQd0dqL3hxb3RYNjhYMSsr?=
 =?utf-8?B?bXhhb3k4QldpVFJIcXBUMUgyZGxPZnREYnRnRU5Rekd1dE9GNDlZNUxha0o2?=
 =?utf-8?B?ZFc0aVdxMERmVytFb1lCM09mUCt0OU1zV2x5MmdudG5pVkwwMTh5VjBWamx0?=
 =?utf-8?B?L1lvS3R3NnBiQ1hLV3VMV0hRKytXbk1LWDljZ0RScWxMNFhzUWhwT2JNZ3Mv?=
 =?utf-8?B?R2pTcmJjUVg5aTdVd001NkZaSTlzeDlyYW5zcVVieEMrVzYvSFhIbTYzWVlo?=
 =?utf-8?B?N1hyeDNzWFJTeGZGNCtuN1RndXVmUTBkTHJpc25KUS91YnAvbWRFMTdYSHNI?=
 =?utf-8?B?UHBGKzJCWjd3aWFtSXpNM1Z5emVIYnZCa1dIVnRQRWFibUkyUHZ2MTkvOTlp?=
 =?utf-8?B?djZ1aU1LNXk0RFFRTFl3eFpuN2wwZ3BkNVUxYzRhSk9GUEFxUDB3ZklzSE5p?=
 =?utf-8?B?MCtHN1gzSzlIazd1K1lraDg5eW0wR3dFT0pjUWwrNUZmdEJUVlJKQzZMNG0w?=
 =?utf-8?B?YW85eGd6RE9UYStyUEYrT0pwTVRJZ29xWkkraHVTUnhNZHlGV24wR0ZFRGh5?=
 =?utf-8?B?a1RTVU5iVWllYkJENDZaM3doWnlpZUNNcXZIbmlySnFHK1puVDNaWGhvWUxT?=
 =?utf-8?B?emlGbVp3TlpWMEV3ajJ3aEk5a09vNEJGdmp5UE1scjZvTCtCUWhlcUlxd1lI?=
 =?utf-8?B?eGxOd1NyRnNuakFNQ0FwZEhKZDVXWXBUTmR2NVRMRUoxTGhCbG1VblFBUXZI?=
 =?utf-8?B?SCsreUtUQWNodGtKdmJzbDZCMm1vNFpSL1ZzZmRHTlZyYi8vTER6RTdET09T?=
 =?utf-8?B?REtXVTBtMjJYaTRsY2VQaEY1RWhqUFJZMkJ5Q0Ftbnd4c2VhL2Q3MUh4NWo1?=
 =?utf-8?B?RXN1UWNTQXB3cjNrUnpXWFMvRUxJdjFBdUU0L0J1cXpKbEo4aWNHb1VnUEh3?=
 =?utf-8?B?UVN5WnhiK0M0OEl5VzJ6Q05lVjN2NUhHUHZZbW5rdUhmUjA5OFdtMGVLQkgw?=
 =?utf-8?B?UW94NlR6NEJJcFlIenVIS0RueWhqSmY4R0cvZHRYUGViazVzUGhRMnd5RkNO?=
 =?utf-8?B?SE9JYk5qdFBVZ2hJb210MVNCOTRCYWZEMWYvRTNuc2dzZFVmUXRydzlwUGlY?=
 =?utf-8?B?UnNnU2ZOcU1UdDJEdERnbStRa2JEVmR1ckYwTFh6bk16S2dQWisvMk1ObFl0?=
 =?utf-8?B?clhzenJ2QnRyUFZ1ejBvVlNTYTJaRHBObXd5Q2s4UHU0cEZIMXlyNUNKK3U0?=
 =?utf-8?B?Q0RpTmdlam16L3dGUHRMMTJhWjVjU25EZnhBdXdxdnRZQWVSQ1hXU0F5Vjlt?=
 =?utf-8?Q?GcVMyzOAvLOys?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB1096.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c859d66-7ed1-4e29-368c-08d92058c36d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 15:13:05.5282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrQKB26HNR1Fn/fBytbjNeURW7VmT1lVapo6AUUK2pv3A+VnN/VvRjnm7pcE+mWjiAz+B4tM5MWFCW8ItUL1zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0904
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: a26OkkIqRw-Gbk0dPBnSPex3pOc8XF0h
X-Proofpoint-GUID: a26OkkIqRw-Gbk0dPBnSPex3pOc8XF0h
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_09:2021-05-26,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260103
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhhbmtzLiBHb29kIGNhdGNoLiBTaG91bGQgYmUgJi4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFpodSBZYW5qdW4gPHp5anp5ajIwMDBAZ21haWwuY29tPiANClNlbnQ6IFdl
ZG5lc2RheSwgTWF5IDI2LCAyMDIxIDEyOjU0IEFNDQpUbzogQm9iIFBlYXJzb24gPHJwZWFyc29u
aHBlQGdtYWlsLmNvbT4NCkNjOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgenlq
MjAyMEBnbWFpbC5jb207IFJETUEgbWFpbGluZyBsaXN0IDxsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggZm9yLW5leHRdIFJETUEvcnhlOiBGaXggbWVtb3J5
IG9yZGVyaW5nIHByb2JsZW0gZm9yIHJlc2l6ZSBjcQ0KDQpPbiBXZWQsIE1heSAyNiwgMjAyMSBh
dCA2OjI3IEFNIEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBnbWFpbC5jb20+IHdyb3RlOg0KPg0K
PiBUaGUgcnhlIGRyaXZlciBoYXMgcmVjZW50bHkgYmVndW4gZXhoaWJpdGluZyBmYWlsdXJlcyBp
biB0aGUgcHl0aG9uIA0KPiB0ZXN0cyB0aGF0IGFyZSBkdWUgdG8gc3RhbGUgdmFsdWVzIHJlYWQg
ZnJvbSB0aGUgY29tcGxldGlvbiBxdWV1ZSANCj4gcHJvZHVjZXIgb3IgY29uc3VtZXIgaW5kaWNl
cy4gVW5saWtlIHRoZSBvdGhlciBsb2FkcyBvZiB0aGVzZSBzaGFyZWQgDQo+IGluZGljZXMgdGhv
c2UgaW4gcXVldWVfY291bnQoKSB3ZXJlIG5vdCBwcm90ZWN0ZWQgYnkgc21wX2xvYWRfYWNxdWly
ZSgpLg0KPg0KPiBUaGlzIHBhdGNoIHJlcGxhY2VzIGxvYWRzIGJ5IHNtcF9sb2FkX2FjcXVpcmUo
KSBpbiBxdWV1ZV9jb3VudCgpLg0KPiBUaGUgb2JzZXJ2ZWQgZXJyb3JzIG5vIGxvbmdlciBvY2N1
ci4NCj4NCj4gUmVwb3J0ZWQtYnk6IFpodSBZYW5qdW4gPHp5ajIwMjBAZ21haWwuY29tPg0KPiBG
aXhlczogZDIxYTEyNDBmNTE2ICgiUkRNQS9yeGU6IFVzZSBhY3F1aXJlL3JlbGVhc2UgZm9yIG1l
bW9yeSANCj4gb3JkZXJpbmciKQ0KPiBTaWduZWQtb2ZmLWJ5OiBCb2IgUGVhcnNvbiA8cnBlYXJz
b25ocGVAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X3F1ZXVlLmggfCAxOCArKysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfcXVldWUuaCANCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9xdWV1ZS5oDQo+IGluZGV4IDI5MDJjYTdiMjg4Yy4uNWNiMTQyMjgyZmE2IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xdWV1ZS5oDQo+ICsrKyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3F1ZXVlLmgNCj4gQEAgLTE2MSw4ICsxNjEs
MjIgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgaW5kZXhfZnJvbV9hZGRyKGNvbnN0IA0K
PiBzdHJ1Y3QgcnhlX3F1ZXVlICpxLA0KPg0KPiAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQg
cXVldWVfY291bnQoY29uc3Qgc3RydWN0IHJ4ZV9xdWV1ZSAqcSkgIHsNCj4gLSAgICAgICByZXR1
cm4gKHEtPmJ1Zi0+cHJvZHVjZXJfaW5kZXggLSBxLT5idWYtPmNvbnN1bWVyX2luZGV4KQ0KPiAt
ICAgICAgICAgICAgICAgJiBxLT5pbmRleF9tYXNrOw0KPiArICAgICAgIHUzMiBwcm9kOw0KPiAr
ICAgICAgIHUzMiBjb25zOw0KPiArICAgICAgIHUzMiBjb3VudDsNCj4gKw0KPiArICAgICAgIC8q
IG1ha2Ugc3VyZSBhbGwgY2hhbmdlcyB0byBxdWV1ZSBjb21wbGV0ZSBiZWZvcmUNCj4gKyAgICAg
ICAgKiBjaGFuZ2luZyBwcm9kdWNlciBpbmRleA0KPiArICAgICAgICAqLw0KPiArICAgICAgIHBy
b2QgPSBzbXBfbG9hZF9hY3F1aXJlKCZxLT5idWYtPnByb2R1Y2VyX2luZGV4KTsNCj4gKw0KPiAr
ICAgICAgIC8qIG1ha2Ugc3VyZSBhbGwgY2hhbmdlcyB0byBxdWV1ZSBjb21wbGV0ZSBiZWZvcmUN
Cj4gKyAgICAgICAgKiBjaGFuZ2luZyBjb25zdW1lciBpbmRleA0KPiArICAgICAgICAqLw0KPiAr
ICAgICAgIGNvbnMgPSBzbXBfbG9hZF9hY3F1aXJlKCZxLT5idWYtPmNvbnN1bWVyX2luZGV4KTsN
Cj4gKyAgICAgICBjb3VudCA9IChwcm9kIC0gY29ucykgJSBxLT5pbmRleF9tYXNrOw0KDQolIGlz
IGRpZmZlcmVudCBmcm9tICYuIE5vdCBzdXJlIGl0IGlzIGNvcnJlY3QgdG8gdXNlICUgaW5zdGVh
ZCBvZiAmIGluIHRoZSBvcmlnaW5hbCBzb3VyY2UgY29kZS4NCg0KWmh1IFlhbmp1bg0KDQo+ICsN
Cj4gKyAgICAgICByZXR1cm4gY291bnQ7DQo+ICB9DQo+DQo+ICBzdGF0aWMgaW5saW5lIHZvaWQg
KnF1ZXVlX2hlYWQoc3RydWN0IHJ4ZV9xdWV1ZSAqcSkNCj4gLS0NCj4gMi4zMC4yDQo+DQo=
