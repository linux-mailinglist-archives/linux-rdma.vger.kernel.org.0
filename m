Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A688A494157
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 20:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiASTzC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 14:55:02 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:51444 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233089AbiASTzC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jan 2022 14:55:02 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JI8V81030117;
        Wed, 19 Jan 2022 19:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=HRCstalYaDhsY6UXlegpmz8dr/iMQQzW/esBZsxqNow=;
 b=W+kdAxcI2M/oAtjbNyQg0/aZHBpc9dF1lNH+TscfLqQdhtxJnLFhFqc/TrcyFm9qDfuw
 XHUarIBYHmi0lSXD3Ts7cIVnyAbXLXTs/kuXLWiDCDwbJuzTv9Isp3u+Zno5p9hIRpq/
 yScg0aUabDL3K3dCn0kTNHxMK+ONR1FNplrviqD7iFyXNoCF1BB4RKfDgCWGZ9+MpTZn
 eBavv0BiJzzAjKYNKNQrm1NRHDq3Ro5mjhcX+onzF2P78gf04xRG1lh+i9QrtSl43U8K
 dI0qUtTvu2FufaN1qCZv87H0e7DPYdrrBUQJfv4p+U+oBmcmWfwR84WRWUbdkIWMKK1H 1g== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3dpqn60vrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 19:54:57 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id A50E5A1;
        Wed, 19 Jan 2022 19:54:56 +0000 (UTC)
Received: from G9W9209.americas.hpqcorp.net (16.220.66.156) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 19 Jan 2022 19:54:40 +0000
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Wed, 19 Jan 2022 19:54:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OER+ZEqEAyMbVU1YyAP6+2FKrAlMFZ9UML8ECD+bJ9nIWuuEUp+Y8x0QUiGrDzN3ROHmRGzYeTsfGs2g5n0dGPjXP9b+dcF4X2k239yjuvXKRgoJBjzUt9elMJBrdDH+aLdyLwbhEVfWCZ+dIFxu3xXOm43cL7MvAebf5zHYUUfqf/NVxmwojxPW01LrkY6GD/TP0vNDgsASyNF3aYqROg0PrOMn2HuFdssjB6VfZYBiX8gmj9vmdfbCHTbqtUw7T7WoaeiZ88ZXurF4EmwOsCQ8PiXVa7w51Jp+EofFwBmr2sn0n6X4eHkiBchAisI9oeEDhr1lNud399wklCQuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRCstalYaDhsY6UXlegpmz8dr/iMQQzW/esBZsxqNow=;
 b=hHqNEHvQl5UM/GPQiTcqdmTX+3UrLz6obxnvCmsEn6Qv9hzG/gjll4lmcZuKDkZ2yOm5sz3nKZc7RHna2MW2Wb/cznP+vIWOLFr7YGw+6nVv70hycsv6+3jvJmfFhouM9U/L0xnNQkNG/FlwGfcpGWCYcJtmkeIJp64mnKlsCrqRyuBZBg81QWG0+ndfYpgp8b0jIs/i/vVT298lSArbufEFXiJYRbY+H0GQj/KK5NxrosvbjSBUxNFeytYVD9EzTdyTzMo3ukttrv1L0Mh/piqFZErcyVoUcI330NBw7hQNt6h3rUtT0b9dCoTAlUC3Zx3Fkd+v2u0OdVteETXCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:153::7)
 by SJ0PR84MB2111.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:436::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 19:54:14 +0000
Received: from PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9128:1766:2075:2033]) by PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9128:1766:2075:2033%5]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 19:54:14 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Alexander Kalentyev <comrad.karlovich@gmail.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: rdma_rxe usage problem
Thread-Topic: rdma_rxe usage problem
Thread-Index: AQHYDSmeLz3Lsu5YcEm1xfWuM75rHKxqYvaAgAA9hACAAB6HYA==
Date:   Wed, 19 Jan 2022 19:54:14 +0000
Message-ID: <PH7PR84MB14880DAC2578D1CBFAC7CC87BC599@PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM>
References: <CABrV9Yt0HYenR_qk_QWFkvH4-0Ooeb61y+CyT3WVOnDiAmxjhA@mail.gmail.com>
 <d6551275-6d84-d117-dfa3-91956860ab05@linux.dev>
 <CABrV9YuiYkCKMBMsrnd38ZxwqxJeWMw+xXFRpXc1gMtdAN9bFA@mail.gmail.com>
In-Reply-To: <CABrV9YuiYkCKMBMsrnd38ZxwqxJeWMw+xXFRpXc1gMtdAN9bFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d45c708-3ada-4397-f72b-08d9db85782e
x-ms-traffictypediagnostic: SJ0PR84MB2111:EE_
x-microsoft-antispam-prvs: <SJ0PR84MB2111FDAE57D67130A0EDD024BC599@SJ0PR84MB2111.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBfiA3g6+fHsicrcdxH0ZAeCQjD8DD3p0Wcf96sUL0tJoGtCCScfr//vyfYbcYnZ1V2CAW2Zl9UhzMhjFg5vFJ/FM9y+YTWZ2DuNEqAKtAVZDsJFyqsU7Q9fhT4RpHGke3Kz7cSthRpfxbS1fNMxobCFumk2B1vlX2lj1noJwcKgEsuePuqWLJQozy1FKhUvMB/buRpbIQPTKbmtBoCn32hiFhHYsLP8IiIsPe+jwGo689dxPmg12aQFFFIC4VtY0h0ccRigoioZZfRFy+CsvJqf6ecLYso1Hi/uRWp65gvFoyKNglxXnXc0j3pmlV3f8i9VTeUz56FZ/ws4NY8sr8mSA95Rno4CidF3vdCnp75okb9TDqxEhuRMxqz3uPDcBCPPhHSAamhU2n/+RGIJM0IaJVJRIup2XliYDk11kguSN7ztlR1lCHtH949bdwxc3tEYi+gFrR4fmw5eVJCedzOZlom5yeINbF3tA9MPZ4Tl9gOmyLbxe3o3iTdMwK7rq+zjoiE/V2gwHdaOwu//yTkW9ng+mSkkwbnB8OkiI8YZEFMk+hyrnnWPKQ5FV8nETYbwez4xHc4jISbq0EIOOWLPTKB79rRynpSmZJDrOEhJUerzY9ULy9DC2XcvazU9FtuiH+i85sWPtVowh/7e/cld5co+1k76TW6gMHpe1RLvrC7daOTokNsSJywtxalYbmdeEYe+bJbGX7tKnN0m9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(76116006)(122000001)(8676002)(7116003)(52536014)(26005)(38100700002)(55016003)(64756008)(66446008)(86362001)(7696005)(66946007)(4744005)(66556008)(55236004)(33656002)(5660300002)(9686003)(508600001)(71200400001)(8936002)(110136005)(316002)(186003)(4326008)(82960400001)(38070700005)(66476007)(6506007)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE5RSjZnbEdWV3RMNFFTS3RVNjl3OXpYMHNiM20yUUh2QXBwenMxeDhCZFZH?=
 =?utf-8?B?TG1UZUxMVmdKUUxRQlc3Z3NOQnRxUVFiMGxIa1h3TWZzbkZJU1BpVmgveS9Y?=
 =?utf-8?B?MDNvTWNJM2l0WXp4RXlROVYzRHlBeithSnNyU0VadlFZOWd5ZEZCMnZhY1lC?=
 =?utf-8?B?bXc2MkVaZmJ2M0Z2QjdwTEEwYXlBd0p4VWNKWGRrcEtILzNwbk9YbGVCbXQ3?=
 =?utf-8?B?MUN6V3RLL1VoZWxRTFgwOU4zT3o5Nk5UNFlabHpiZDN6VTY3WERiUllBanI2?=
 =?utf-8?B?bTd3TWowbkFUSVpXb3Y5alpIcWQxaTlZRmxjU2dDMlZCYnAyMVZ4cm16Slg4?=
 =?utf-8?B?WG5SSXN1NDVhaSs1WHZVOFViMHFndU9xekxXa0dTMU9BY1A5dzZlYjFKaE1Y?=
 =?utf-8?B?ZjIrVmRNYkZ0Z3ZCMllaY2NyUkhIL0ZGbElWc1lndXdyRXZWNktORzBZTUty?=
 =?utf-8?B?NjJmU2Era2VjakFjZkJMUGNkdTgxRmJXMjRDSEhIelA1NWNsY3EwelIrUjB4?=
 =?utf-8?B?Q01naXRFMG5pRUdvcXpJR2ZEQ2ZoOVRBWHdYR1hkYkZ6OGtrNnY5UXk4UmNx?=
 =?utf-8?B?UXlYeCt2VDBzOFZ6UXJKVExXanJMV2JTTGN3WDgwNzRmZ3dqT0dyMDVuaWcz?=
 =?utf-8?B?VGxjR1pSbk5BUzJ5eFNZaXRESmdwR2djVmVEYndUSUQ1c1FmUS9PRHBoak1S?=
 =?utf-8?B?Q1l4dm1PbHREL0NFUjEwcmlZQUVuT0pMRzNCODFPZHZIOEtEaGc3SGJFWDBV?=
 =?utf-8?B?ditFQnZxRzRFUFlTREVqUXpEN2dRa2FiNVRDS1FUTkY3Tnltamo5clJiSFI0?=
 =?utf-8?B?ZVZNSlM0NUx4aGY5c1MwYjZCTnNlUkZyVmZqSzNybU1BOEtSVzRxSjVUNmY3?=
 =?utf-8?B?VkVlV1QyS3hzUHVjQmRxYXQ5VWdJOUlIOVRFcmpmbkxGalRMaHlIUTN6UGw0?=
 =?utf-8?B?NHp4ZXNXN0owZDlJdXUxSzZsWnR0VVdjYzdtcWN6VE1iTC9WOEFnN3lmOE1E?=
 =?utf-8?B?RmdOdThvQXhXamZFT251NS9tcjNZdmdpVkJaNXNaNm1QSkhhTzdIWmZ4TnlB?=
 =?utf-8?B?bWQ2UEloTElEbS9vNElIVURmTXpBN2NQNTlmMEx5b3c5a3l1OG0vd1pUZUxB?=
 =?utf-8?B?cTZ5NjVreUNtYzU4Qm5va0JLVGt2MnlvYzN6Sk5JY1NxdkM3U2QvTjY1SlZ0?=
 =?utf-8?B?ZlY3WUxucTQzTTR2TXg2NkprVFJ3RUlrQ2JSSFZUUGlaWFM0cVVQbU5ES01x?=
 =?utf-8?B?QXB6MUpCUnduaXRhUVdmLyt4eVlMMVdhZk5lRTY1N0NNV0pmZ0lIRGhudHhk?=
 =?utf-8?B?ZkFFbWovcitMYlJpVXk2S0tCV3JCb1pZbGE5N01XWDRhbWN3UXpXTE1qY0sz?=
 =?utf-8?B?NHF2cnBuclhRZ0tGQ3VWenRDRjVPUXRZemdlL3lkTzRTcjRGSGt4TGQrRmNs?=
 =?utf-8?B?dG1lUk9wRkRlZEl4TlZBRDE0U1p4Sm9KZ3VCOXFZSUNqMWRhTWlxa1VqODNm?=
 =?utf-8?B?Ui9TRUFmUGZSVkl1RDVUSGFDSG5iOFVmNEQzNjFsS3ZVUERiV0ZZdTVpbGhG?=
 =?utf-8?B?OWdEMThSUndORDBOdWZScFpBandVOWlKYS96ZGFva1hBNDBHcVczVEs0eWIz?=
 =?utf-8?B?NW9pR1B4UDkxdHBvZGhWQk4rdTNBSWlyU0hmMDIydmtPbWNYRURxZkU0QmJU?=
 =?utf-8?B?RUFyNGJtMTU0TWFaY0huNUZBblVzaWJNem1ZTFMzOVhzRlJRMjk2dUw2Ky9z?=
 =?utf-8?B?Y1RDc1BkZjByRlF2WUxHZ0NBOElRTWZLZm9CdEZGY0VIbEpmMmpiMnAvaEEz?=
 =?utf-8?B?cVdhRUZRNTJjbENHMDRUU0FCWG0vb1hGVlZ6RTJGZ3lRM3V6M21pR0NXc2dy?=
 =?utf-8?B?dXZlaUZiem9ySlZZVU9wOGx3OGliM0ZqdjBkOWdtZHI0eENVK05WYStHV2xD?=
 =?utf-8?B?Z0p2QU84dWFTaGY3NUw3M1hTV3VRUXM4U3JyVmZLR2N2RE43aHNkUStEOXNu?=
 =?utf-8?B?YXhKTTJEendnMkhFODZONkQvVXVtU2RWb1FIOTE1OTFac0NCdFBZaTI1SllZ?=
 =?utf-8?B?elUxbUtFYThKaGZwL1BkVUtPVE5PV3BBV2lNdndVV1ZFRisxT0N5UEE5S1RP?=
 =?utf-8?B?QndXQytHdStjL1pWZWl1YTlBK093US94aXNtcWhSa2F2MEFNMGtJbVQ0dXFX?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1488.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d45c708-3ada-4397-f72b-08d9db85782e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 19:54:14.1863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fj2wfYn2Iqzc+Wp1coJGdebwhKrbgvmQTFox7th7v3PezYYB51Ogutn3MYXI8Op78h9Rqle1KLbAbiq4vByrmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB2111
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: vI3hADBSHRNWonsxEMBYELFdnlqCGBJd
X-Proofpoint-ORIG-GUID: vI3hADBSHRNWonsxEMBYELFdnlqCGBJd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_10,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201190109
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4YW5kZXIgS2FsZW50eWV2
IDxjb21yYWQua2FybG92aWNoQGdtYWlsLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEphbnVhcnkg
MTksIDIwMjIgMTE6NTMgQU0NCg0KDQpBbnl3YXkgdGhlIGlidl9yY19waW5ncG9uZyBzaG93cyBh
biBlcnJvcjoNCg0KPmlidl9yY19waW5ncG9uZyAtZCByeGUwIC1nIDANCiAgbG9jYWwgYWRkcmVz
czogIExJRCAweDAwMDAsIFFQTiAweDAwMDAxNSwgUFNOIDB4MDE1ZGQ4LCBHSUQNCmZlODA6OjRh
NTE6YzVmZjpmZWY2OmUxNTkNCkZhaWxlZCB0byBtb2RpZnkgUVAgdG8gUlRSDQpDb3VsZG4ndCBj
b25uZWN0IHRvIHJlbW90ZSBRUA0KDQo+DQpBbGV4YW5kZXIsDQoNCkkgdXNlIGEgc2NyaXB0IHRv
IHJlc3RhcnQgcnhlIGFmdGVyIGNoYW5naW5nIGFueXRoaW5nIGl0IGxvb2tzIGxpa2UNCg0KCSMh
L2Jpbi9iYXNoDQoNCglleHBvcnQgTERfTElCUkFSWV9QQVRIPTxwYXRoIHRvIHJkbWEtY29yZT4v
cmRtYS1jb3JlL2J1aWxkL2xpYjovdXNyL2xpYg0KDQoJc3VkbyBybW1vZCByZG1hX3J4ZQ0KCXN1
ZG8gbW9kcHJvYmUgcmRtYV9yeGUNCg0KCXN1ZG8gaXAgbGluayBzZXQgZGV2IGVucDBzMyBtdHUg
NDUwMA0KCXN1ZG8gaXAgYWRkciBhZGQgZGV2IGVucDBzMyBmZTgwOjowYTAwOjI3ZmY6ZmUzNTo1
ZWE3LzY0DQoJc3VkbyByZG1hIGxpbmsgYWRkIHJ4ZTAgdHlwZSByeGUgbmV0ZGV2IGVucDBzMw0K
DQpUaGUgaW1wb3J0YW50IGxpbmUgaXMgYWRkaW5nIHRoZSBpcHY2IGFkZHJlc3Mgd2hpY2ggY29y
cmVzcG9uZHMgd2l0aCB0aGUgTUFDIGFkZHJlc3Mgb2YNClRoZSBldGhlcm5ldCBuaWMgd2hpY2gg
aXMNCg0KCTA4OjAwOjI3OjM1OjVlOmE3DQoNClNvbWUgT1NlcyAobGlrZSBtaW5lKSBkbyBub3Qg
Y3JlYXRlIHRoaXMgYWRkcmVzcyBhdXRvbWF0aWNhbGx5IGJ1dCBtYW5nbGUgdGhlIGFkZHJlc3Mu
DQpCdXQgdGhlIHJkbWEgY29yZSBkcml2ZXIgc2VlbXMgdG8gZXhwZWN0IGFsbCByb2NlIHByb3Zp
ZGVycyB0byBoYXZlIGl0Lg0KDQpIb3BlIHRoaXMgaGVscHMuDQoNCkJvYiBQZWFyc29uDQpycGVh
cnNvbkBocGUuY29tDQo=
