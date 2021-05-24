Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B9838E402
	for <lists+linux-rdma@lfdr.de>; Mon, 24 May 2021 12:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhEXK1x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 May 2021 06:27:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60862 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhEXK1w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 May 2021 06:27:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OAJaV3116785;
        Mon, 24 May 2021 10:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GCga+bf2X6xIsHyYksUdaa5YZNeQ+hGj5c+8IIFf8uo=;
 b=Elt1CdyHLxi4mhX3QdV/Ud2TdhaWPuGq9gij3uwlmKi6cK1CR/yVos9IdCA7ATXdvpWI
 h6X1dSURg+AVrTJCA31Hvkeh8Vd7T+ZNc5DPnLd4/aTBy1a106eoDKwxGwzYc6psXrs5
 tlNM95hs9AjXGCSTSLn5O0jLhj/xXrzl5xaZ8wIAXFs+ZyxssCnlGHbXSL78tzIAtnjZ
 nkbyA+VSCnd4i91w2unP8p/kJc+6Xv1iTfiqr91iY7NOQIwj9ZZIQtZqAIADsNYM57VW
 R7ia4E/ZaD/CPI9v0w5ZfyHyLmw87vsUNcHS0rZUEdSfilpPk/dlZmC/rikJPJ/IgCXI 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 38ptkp2ju4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 10:26:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14OALHeV024136;
        Mon, 24 May 2021 10:26:19 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by userp3030.oracle.com with ESMTP id 38pq2t6b9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 May 2021 10:26:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb8USmb1eWQcJZvlyotzcKaaBl/JrNt14J3/dVF9335hz86bPZNIPLc03mKDVfBszS7kls0Ep2gYAqwfgcqReMgBzUdX53Y+v5xwdCfMg2ufMh4P8uAFLkqaHeSAOl/QF3jlwzZBjLq0eVhVzOASjbgKTHjKD0UG1FmcZ2eJL00LFI5fNBu7TXkdd8DlAI6kYFw8En9+AoCpVvBBazp0xBabQPCSh8UPjADPQ66gxUgyy+dJokQXqHtnWh9n9WEG1MFjdkzVru9XAlBF18m2Y9T4zwKYQRFEShhhgsKvyKzKKbOBbNncx2oMGiQ+15mzBRuQ8o8FDEw9OV6YOOHjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCga+bf2X6xIsHyYksUdaa5YZNeQ+hGj5c+8IIFf8uo=;
 b=UJ3qerNZA7lhQaBMmI2OdW4LmRBxdufxNuvqJ8XiBQ/q8gcRLsr7LbA2ZKOYdJUaAZ/Zn2d3koR/qTul97kePc7bjSiX+pou3XWnYyZPK9oHmj8EigJZ3Vei9VSlZxgG6EGcBBWtH7/Ueu6JHM1IxWiJ6uaEedusuOtiOz1kytusDktOlLyv05ByUgP4vPsZXx7HzXSt0twPyWBK7fmHhd1WIKcZjVH76A4sFyHI1NI0Fdl4VqnwRFvspTAvaDAkeOPSH31+/Oa9N/091m/k6KjAc5r7bfhahfqGAOdQfqZnx6ZOfOH2Ak5TTRtbfCHhH+dExsT5oy536LohNCW56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCga+bf2X6xIsHyYksUdaa5YZNeQ+hGj5c+8IIFf8uo=;
 b=tb2KE+aeGydqzrEhcv3UNe1H8CWsSea28CpxlyLjEHn3yesJctiq3JSpEHVAyjlyUU0WNG2VKNKL+/QRBtrhpmHyXKYSX3vwiXmd3Ngj2/S0nYVmDO9YM8r0yK8vFZbl9dT9tbJb4+XpDGsiIG13yyNGq5th/Yfm3Sj9cNsAdpE=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1544.namprd10.prod.outlook.com (2603:10b6:903:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 10:26:17 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 10:26:17 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2] IB/core: Only update PKEY and GID caches on
 respective events
Thread-Topic: [PATCH for-next v2] IB/core: Only update PKEY and GID caches on
 respective events
Thread-Index: AQHXQlJN5+TG4/FSE0Wg1M5qrYY6fKraypSAgBe/OIA=
Date:   Mon, 24 May 2021 10:26:16 +0000
Message-ID: <0E229A2D-178F-427C-9F66-221439B63395@oracle.com>
References: <1620289904-27687-1-git-send-email-haakon.bugge@oracle.com>
 <YJeTp0W1S81E5fcZ@unreal>
In-Reply-To: <YJeTp0W1S81E5fcZ@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [46.15.132.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63ce3af8-b514-4dfe-c2b5-08d91e9e5d65
x-ms-traffictypediagnostic: CY4PR10MB1544:
x-microsoft-antispam-prvs: <CY4PR10MB15447DE54DB5053A9C69983DFD269@CY4PR10MB1544.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3KXTxU5CtgzIRi99ITED3iRihXjn8MzB8KDMtOD3BH/0qeCtIfdXs76Wv712Fs3QiYGTTM0R3/uJkyssnMlYdMiV4GbwdKmZskMOMFkI2gQYrc04cDjDwRJUkUDKF4qUT9Kp7fNCyEKbOHKhUZMXk2natQ1Rr6Md8zu68r9Ncnh6k+Wd7LhPIO0YTroVZztFUqb2tAqkdJEihk9KQNULrBgpz7GXPSVWhauUSpG6ZyCKzJZDj+kS11ND9h3xwx8A7fCoPlGn4gL8fXwopKCl5ds4VaaFwOXhg/45bb/oT18dmNdS9Oh3VA/8WnxwDNuQdqbevdSE8JCWU/tf4AY5SVBH7aEhzesvRPlFacRXdhe3zxQ4d7Xq2bbb20VKdjSB4rjPEtQBqH3x3Az2l1HejUfFoBvf5iNHzr5rbD4RA+S33OV91e4URQ4ib0vIN9s+qHexYXuBfQJhLtaKYWv5ZqfQjHT4P57V7iA0E+lMqURj5264mAvCvMpfJR9MiAwvuWNS+V6UZZycFTKvg+0EKhOGbEB06xECtnPEdbqyZo//FPj6/xnwOTmqUbYvyFwOwGWtzVJFrGlDgHOy0awyKpPInkYdDEwHdQDCAzv6uw6yvA3dfsYj4Llf0VEH0mfnIQafhdnY4Mm6fUAGYbk4FUqzOr6rJMDE8zuatEqIpI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(376002)(346002)(6916009)(8936002)(86362001)(38100700002)(64756008)(66446008)(36756003)(2906002)(186003)(26005)(5660300002)(122000001)(2616005)(66476007)(4326008)(66946007)(54906003)(6486002)(6506007)(33656002)(76116006)(91956017)(66574015)(71200400001)(53546011)(44832011)(6512007)(316002)(83380400001)(478600001)(8676002)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?anlDNEUwRUVtcmlPVndkYVp0NnpiTXNUL2FSRVNFVWFHMVhkZmp6MDNLc1VG?=
 =?utf-8?B?eUJaSStxbjd2dk1JWmE1b0VJckJuNnQxaldvSE1TbHp3b2dnaVBWQVpIUzhU?=
 =?utf-8?B?Vjg3QXJBT0xtYmtJOFNNK2xzc01jUFdlWVdjWkw3akxRcy9yZ2dBOHdhNndE?=
 =?utf-8?B?bGxUMlhLNkVFV0hVQ2N3cEhYcXppT2k1bVVUdHJOdm5GTy95Z2hYd2pHWVJB?=
 =?utf-8?B?dVQ4WGRYWWdhTG1aYUcxNFBJRDB2K3hjTWtFTmJ6VGZQYTZLZ1pwRkN0RUdk?=
 =?utf-8?B?dytLMzlQSjVPVHZreXFlOEhuTXBET09Rb0owY1c2enl4NGd3QjBTWTVtbVNa?=
 =?utf-8?B?RFJQNnZrWisvYnpsRTlNM2RuZUdNUXYrVTNTYktsdjdrSkZ2R1BnTVFrazBa?=
 =?utf-8?B?OVJmVWsxUU8wTDZ4US9LQUVCWU1UYUgrNnVmRnpFOXo0VUZHTHRPZmcrNnRO?=
 =?utf-8?B?ZWdtWEY3VEJHeUF1eFlyakhya05zTGlZOWVkYjhKUGdISk14Tk1EcDJOUTda?=
 =?utf-8?B?RzU1OHZ5MWlJc3VtYThFOGduQTB5dE51dG9uUmRXSDJyR3NTdDRHUnF1WXM1?=
 =?utf-8?B?cWVNWTdmODBIdVkvY1RTTmhXT2ZvVEF4Rjl2cVR0UktCR3NYUVZkRUlIU1h2?=
 =?utf-8?B?Uk5IOUZnL3VpY1FVcnd1aVB2TnJYQUV5U1I2MElkZElHYXplSmpaNkUwRVVJ?=
 =?utf-8?B?NXhqQU91VnlQd1JhVUp1cDRiMGh3eDRyYTFKdkdrdS9Wc2tjbC84S21KcjdV?=
 =?utf-8?B?dEpzQlE3NW0ydURWTlMvaWQ3bmdiSWtHU3NOd3ZZeE5PeXRYM3U0VXdsMU9T?=
 =?utf-8?B?WnAxWlRobmd0ak0zajByMFhPa2tNQi9nUE1zNG04YnVyU0E0RXZ0TlBCRU9P?=
 =?utf-8?B?T2xXTXlQY1RzcGYvR2VxaW1YS2x1WUxIQm1tbC9NUmh6R3UyUXpGMnRUYVA4?=
 =?utf-8?B?TXdRZkFjandJd1Y5T1htd09vMTJkTXZUQzNXZGJ1T3htcEIxcTExU2NJZG1O?=
 =?utf-8?B?SUIzN0tQWVRYeHMxaVBEdnRXaFJlWlFnTUllRWgzZFBqSmRRNnUrZzZaKzhp?=
 =?utf-8?B?Nk5tL0ZiMkFpMW5oMU1xbnovaXVORCs5d1l2RlhPUTRrQVlBeHVTaDk0czNH?=
 =?utf-8?B?aGVidUNQNUx5SUVYOXZvVFdXNFQveEowd2pnTUxqM2tlbHo0aFI2Lzhubldh?=
 =?utf-8?B?b2JIUlFzTlNVUkg3ZXd2Qm8rQ09ua21lY2IzSWFMUW5oMmV2bU5SWk5VbGt0?=
 =?utf-8?B?NE9ES1FDSGpkbHl5ckw5ZmNuTFBPWmhWMmZvRlNVendUdVQ4eEJCdmJyc2ow?=
 =?utf-8?B?NDgrY2ZYL1hQZ3RPSHJNMFFwTlpuajZVWjQxNFJTNENkd3NzMDFiVHVHRHhi?=
 =?utf-8?B?SWlDRVgvZFVVaFZvWS9iTW9QUWFXL0I2YlQ2UmNBQStHYmp3YnpXOGtrdGpt?=
 =?utf-8?B?RXB5bFIxQVhWMklpVDh5ZlQ5NXpGS3A0OGpOUjVGNnROaWNzODNNaGdLRmcv?=
 =?utf-8?B?OHFBQko1OFVUaXhUZW1ZczA3UU0vRUFNbXFwVDB0d0tCVkhDQWd2bGQxajQ2?=
 =?utf-8?B?Sml3Y0ZzS3RuWmpBMDdpdVNwMHIrOVJyRnhuNFVqamhydHZTMXMycW4vWENP?=
 =?utf-8?B?VyszanpDNE1xZk9TNUUyTUg0SXZmVkdTRW9WZG1KUzZ4SkdtamJmamJLZjFq?=
 =?utf-8?B?VkVKTnRvWWtGcGtKSHBYeTl2WFRHbGk1Z0ZXdkZPQm5Da2Y4TkhFTmhkVnVM?=
 =?utf-8?Q?1ub74O49apuMlaiisJnXUEw5C7etpatSiQyZQoz?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <051B6067174BA14685620A7427943EC2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ce3af8-b514-4dfe-c2b5-08d91e9e5d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 10:26:16.8902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4D3r8gTLKIClOnr1qcqWLTIC28hPt3mKaaYSkdZxU9OmwPnWFdq0xb04n7Ng4QrpuNMrVDiqHPz7O2HEZ4xdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1544
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240075
X-Proofpoint-GUID: WQyrwF5XgatMLSG6z5AmV3DvxWm6-OA9
X-Proofpoint-ORIG-GUID: WQyrwF5XgatMLSG6z5AmV3DvxWm6-OA9
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9993 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240075
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gOSBNYXkgMjAyMSwgYXQgMDk6NDcsIExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgTWF5IDA2LCAyMDIxIGF0IDEwOjMxOjQ0QU0g
KzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IEJvdGggdGhlIFBLRVkgYW5kIEdJRCB0YWJs
ZXMgaW4gYW4gSENBIGNhbiBob2xkIGluIHRoZSBvcmRlciBvZg0KPj4gaHVuZHJlZHMgZW50cmll
cy4gUmVhZGluZyB0aGVtIGFyZSBleHBlbnNpdmUuIFBhcnRseSBiZWNhdXNlIHRoZSBBUEkNCj4+
IGZvciByZXRyaWV2aW5nIHRoZW0gb25seSByZXR1cm5zIGEgc2luZ2xlIGVudHJ5IGF0IGEgdGlt
ZS4gRnVydGhlciwgb24NCj4+IGNlcnRhaW4gaW1wbGVtZW50YXRpb25zLCBlLmcuLCBDWC0zLCB0
aGUgVkZzIGFyZSBwYXJhdmlydHVhbGl6ZWQgaW4NCj4+IHRoaXMgcmVzcGVjdCBhbmQgaGF2ZSB0
byByZWx5IG9uIHRoZSBQRiBkcml2ZXIgdG8gcGVyZm9ybSB0aGUNCj4+IHJlYWQuIFRoaXMgYWdh
aW4gZGVtYW5kcyBWRiB0byBQRiBjb21tdW5pY2F0aW9uLg0KPj4gDQo+PiBJQiBDb3JlJ3MgY2Fj
aGUgaXMgcmVmcmVzaGVkIG9uIGFsbCBldmVudHMuIEhlbmNlLCBmaWx0ZXIgdGhlIHJlZnJlc2gN
Cj4+IG9mIHRoZSBQS0VZIGFuZCBHSUQgY2FjaGVzIGJhc2VkIG9uIHRoZSBldmVudCByZWNlaXZl
ZCBiZWluZw0KPj4gSUJfRVZFTlRfUEtFWV9DSEFOR0UgYW5kIElCX0VWRU5UX0dJRF9DSEFOR0Ug
cmVzcGVjdGl2ZWx5Lg0KPj4gDQo+PiBGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGludXgtMi42LjEy
LXJjMiIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFj
bGUuY29tPg0KPj4gDQo+PiAtLS0NCj4+IA0KPj4gdjEgLT4gdjI6DQo+PiAgICogQ2hhbmdlZCBz
aWduYXR1cmUgb2YgaWJfY2FjaGVfdXBkYXRlKCkgYXMgcGVyIExlb24ncyBzdWdnZXN0aW9uDQo+
PiAgICogQWRkZWQgRml4ZXMgdGFnIGFzIHBlciBaaHUgWWFuanVuJyBzdWdnZXN0aW9uDQo+PiAt
LS0NCj4+IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMgfCAyMyArKysrKysrKysrKysr
KystLS0tLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pDQo+PiANCj4gDQo+IFRoYW5rcywNCj4gUmV2aWV3ZWQtYnk6IExlb24gUm9tYW5vdnNr
eSA8bGVvbnJvQG52aWRpYS5jb20+DQoNCkkgc2F3IGEgaGFuZGZ1bCBjb21taXRzIGJlaW5nIGFw
cGxpZWQgZm9yLW5leHQuIEFueXRoaW5nIG5lZWRlZCBmcm9tIG15IHNpZGUgaGVyZT8NCg0KDQoN
ClRoeHMsIEjDpWtvbg0KDQoNCg==
