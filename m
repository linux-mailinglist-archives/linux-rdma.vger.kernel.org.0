Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1C6308C3C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jan 2021 19:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhA2SPa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jan 2021 13:15:30 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:26694 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhA2SPX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Jan 2021 13:15:23 -0500
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10TIDn3R023996;
        Fri, 29 Jan 2021 18:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=+6nNEg9db4GHbqR3G/IaRNvhVg+eWsIXjlpZCWJOxns=;
 b=gI5bPO57PYW7PgpH//m/kIbcjQXKucPDb/fYV9amXIu9W+mCc5/4bdGJH7xzXDvf8mYh
 YTglkZUPcZvWE3kGjGVetMSrw4Hh3WiVJatVUGi2srbbIhKXFhJTZXm6JeRuTVZJmEHG
 7e50OtRO/yLO7lChjTvDrI5SN+7zhWWFsqz0GUu7kHWFdV1zoFx7U+xX7ZXJN6JV0q0R
 79N/7oUSS9FlBk9iUM3vlgLPTpLPDJf9pfe2gTelZBSpWX9kQtIvTdxhEeoxNeT0mBWv
 fXVjvyn9r+egL1wULFS+HIY42LkZd6Sb4YcSeEhbOmBLy+lgOs5H1MqWZnz+mPef1Erx Gg== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 36c20gh4je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 18:14:37 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 312CB61;
        Fri, 29 Jan 2021 18:14:36 +0000 (UTC)
Received: from G9W8677.americas.hpqcorp.net (16.220.49.24) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 29 Jan 2021 18:14:18 +0000
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G9W8677.americas.hpqcorp.net (2002:10dc:3118::10dc:3118) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 29 Jan 2021 18:14:18 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 29 Jan 2021 18:14:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIpAiKd6BcxhnMCcUzDnfxCHSDGD+5fErFBFYu6H228oKol1p0I5OmnG7Y7VK6k47L6GDq52xFgKNGS5+6pabj2Xn4JGNM7kJ2zRWidKadebgNtsV01jpK5HvqF089cmxsIxrTC+8iwQ7quz5bZz8HsWvF4OCUtn1676hwkrZbdIz6lpYcAJWiJlZvpLrDxV2b9SNre3Z5jHILwR60QdLU7GYdjzLJ/+QA0iPNMLs+IBhX66JVM4bc2NQZw3J7gX01URWZFwPcuOcmXYydgSI0VmmV/I0sWSqpWVHjsQu/4i+ngZdnJwqb24Shn47qFO70xdeKcOOxT4raNul4UR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6nNEg9db4GHbqR3G/IaRNvhVg+eWsIXjlpZCWJOxns=;
 b=ZxvIzDWTBkogvbtwRrS65mFh3v0vcgNuBaswZuWoWJMx+0u732f39xIwN/P03jm4bCI7A8BcSZhwLt3kizch90mPCqi5CgfnjO8KqrfNcQTxUVZ8k+RxJXJYidUWfNSiKwvovoXuY42lHKaSWSbdXgkYmu2OnvNyDjzGZJMOXlZ1SuvnlriGZdCNtGyRhsph5dK1JdVLV8FfbtBvdfEKhx/u7sjasgci27PQEbREgvJu02MavQiQ5CTQOdcXQ8AwCbJHiqw5G1GKWFc3nk6lIdzwlDvkEJCTyADrSUWn8iPjErMEKykB9WHg6eLpwQ5ZrXeW/a3VkKEAy/iQVSakbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB1016.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7510::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 29 Jan
 2021 18:14:16 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8%5]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 18:14:16 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Subject: RE: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR
 with imm_data finished on SQ
Thread-Topic: [RFC PATCH] RDMA/rxe: Export imm_data to WC when the related WR
 with imm_data finished on SQ
Thread-Index: AQHW9ImNyfzWU0ybtUqjnD0r5FqHFqo7YAuAgAB/TACAAjqWAIAAytww
Date:   Fri, 29 Jan 2021 18:14:16 +0000
Message-ID: <CS1PR8401MB0821B68A7D33130859A28E12BCB99@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <20210127082431.2637863-1-yangx.jy@cn.fujitsu.com>
 <20210127120427.GJ1053290@unreal>
 <b4f0d73c-9624-b971-e56a-f1db02d683e3@gmail.com>
 <6013A038.9000903@cn.fujitsu.com>
In-Reply-To: <6013A038.9000903@cn.fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cn.fujitsu.com; dkim=none (message not signed)
 header.d=none;cn.fujitsu.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:dd30:aece:e19a:128e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 643d6cd6-4dd0-4ecd-5237-08d8c481b089
x-ms-traffictypediagnostic: CS1PR8401MB1016:
x-microsoft-antispam-prvs: <CS1PR8401MB101644E0572A603362A66BCDBCB99@CS1PR8401MB1016.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z8hPXCV2qCLWkMw3LmvJVwubj+eMZ039XWZ5l0mgaasddCqYreqJabRoic8rRwKHSYyZg+LSlGQN3ldfU2nPVxK9pHQrObvvJ2+vXH4fOJLE7BRh8PYcSBfhefmAF4UDcAQw7yr1k8/N34HPGx9+obkm6O7SodoZkGreJPPhvBdCiQCXG3LPyeychmsLPCjy3a1kHlrgX+nNPHUsFZFB9KMz7E+p6lxKgbdeCTieg3iWnOLZlOegyY1lSAokMWy02V+Jrs+u2zJnwaYWl4XWTxW+/hn5+0UYEHtTmfGNxBv9PZ5LqDmqtuApcaTgl5dq6/4ZlByOFulwdOYBPRPhhzBO86IPDgf8QkaLNxL4LeJf3abCRyI5Wh765Lmh9NUxm+ZqvqYEAdlNEUehf85se8CCohctIFUlFJEWZqtEmqqmmEmiBvFzPlpiS4Zo9McDXTrbyTBUuOz9Ac/PDZefz+j6uDasd4WmzAkgdb5097fe81m4Q+7Oq1Thzx5xZRsw+TCnVOmPjM7YwUXTfzTw9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(346002)(136003)(66946007)(4326008)(33656002)(64756008)(76116006)(66476007)(66556008)(6506007)(53546011)(186003)(86362001)(66446008)(8936002)(52536014)(71200400001)(7696005)(478600001)(55016002)(9686003)(110136005)(2906002)(316002)(83380400001)(5660300002)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YkRDYUl0WG4vN3NUOFMxMmFJSkw1Tm9uMXhKVUJMVU5TUWsxcmxqYnh4Q2VV?=
 =?utf-8?B?VFhqcWtDcVRXV1I0d0VVUnFyRTVPYkFpTzNFYzdKRTk5L013L2tPaEVTY04y?=
 =?utf-8?B?dlI5aGVPOWhOSVRxZEwrYW9kcXpwcG5GV0xPekVwOHdKWDVqdTBzUjJtVUpU?=
 =?utf-8?B?eVpYTVpsZzRiNjZreE05MTdWVUNTT2t4ZzRGdTV5UC8wMnZVVmNERjY5UGRq?=
 =?utf-8?B?cUpTOEZsQzZwMFc5dGV1dGpxTDA0a2ZTU2l4WUxNYlVZd1BJR3VFZEhnY3Iz?=
 =?utf-8?B?T3lvSUxRVm5BY0tham5Wb2dia2RMaHVnVjNSUkhqczloZW1VazFiWVJQYVp4?=
 =?utf-8?B?N1gxTU54ZGlNWjBXNytORVhzMDlYMUVBUXl6YUFlQ0V6STJISDB0Yy9uM21s?=
 =?utf-8?B?TGNLQk8xbzVEVXNONHpuYm94VytFc1Z4WmtiTDIxeHNRU2oydnNJV0lBbXRj?=
 =?utf-8?B?ZXhBRkx3RzhtUG9INDJJYnFJUGp4S0Jtalg5RzRVcTlFWE1yREVxTkg0Z1pq?=
 =?utf-8?B?R3I2WnAzRWhxbFREa05QOVdhaTcvT2Q2aXVmWUdzODhDdUQzODl0VnJNckgy?=
 =?utf-8?B?MmNWVW9YcUNhZXdpSS9iSXJHK2FkeHRaUlMyQ2xCV3BCV3l0eXdzWFJ6NUJU?=
 =?utf-8?B?ekNpb3E5TW1kS3JTQmppYVpRTFVOK0VlSFFJKzkvck1McmtyaUx5RGgwd0lw?=
 =?utf-8?B?NWYzcGZneEdlNFR3VEZUOUlrTjh3WUJTRHdjUjM5NlBUMFQzajUxRlRHeWcx?=
 =?utf-8?B?TTNZZTVraHpEZjcxUWZ2Z0pPdEhLZExjR3dCekExZGpUaGJaWFJ1V3RHT1BT?=
 =?utf-8?B?cFpPbWJtUTloSXpQWkdad1ErcVBXdTAwSW5Ibk0rSFFWYmQ1S1krQnVvVnZv?=
 =?utf-8?B?Q3drMmx4NGVXUUtMYXdHSmJWcTYwNWVaSVU4Q3dpQUtvTm1FY2JUaktTNTVm?=
 =?utf-8?B?aWJHdVdjVUM2YjFGUmxtRE9raU1LczNrMi9EOHp3SnB0MS8wcjJUbkVaTjdv?=
 =?utf-8?B?dzM4UXd5OTl4cmJVaGlmZlFHYXVlTW54RzgrRGlWV3lseGJvL3ZlS3R3Ympa?=
 =?utf-8?B?MHJabmIxTjQ5aUF0emFqSTcvTmJHWVBudDRTWXdmalZSN2x5UEhqNU9tVFB4?=
 =?utf-8?B?ME1GalBpcjNEc3JSMytXYTdzaDlXM2FpQk9GVGVhTy9UWjZ5WndQak5HdWNL?=
 =?utf-8?B?K2FHcUZheHZhcDNEbG02VFF6UHZKVk16bjI5UWprejNNMXk3S3cyOVUxTjZU?=
 =?utf-8?B?OU96MHdXRVVGeU9uWGNTMDhVeXZabUNMUVdUMm5qMVNUTFFHOVJjQlFBaUtS?=
 =?utf-8?B?MTM0Uy9zVzZteDczWG9ONmVCb2kyVWxMcGFYZHF6VUJHR2E4cndnNnJNN2ZV?=
 =?utf-8?B?WWtERGNqTHMzQkt2MGpsbGtMSEk3U05pTzVzVnBQQTZycThLY0tGTmdRTmdX?=
 =?utf-8?B?U1NLWXdtMXZHMFdPZk1RV0dlcHpzNGhjMS9nWkhHVWoxK1ZjQ1p0ZkplRG5K?=
 =?utf-8?Q?voA+cX+mWHDHJe/qM3l64gSsTRH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 643d6cd6-4dd0-4ecd-5237-08d8c481b089
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 18:14:16.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJhJgn3wOzmoJZ950tixqZZ4gQm9OOcx3YDLX1uTrx09W09SpgRX8nRi5mb9HJ5P43fIjZsv7ouxdEe7C65cuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1016
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-29_06:2021-01-29,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290090
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBYaWFvIFlhbmcgPHlhbmd4Lmp5
QGNuLmZ1aml0c3UuY29tPiANClNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDI4LCAyMDIxIDExOjQy
IFBNDQpUbzogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4NCkNjOiBMZW9uIFJv
bWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBq
Z2dAbnZpZGlhLmNvbQ0KU3ViamVjdDogUmU6IFtSRkMgUEFUQ0hdIFJETUEvcnhlOiBFeHBvcnQg
aW1tX2RhdGEgdG8gV0Mgd2hlbiB0aGUgcmVsYXRlZCBXUiB3aXRoIGltbV9kYXRhIGZpbmlzaGVk
IG9uIFNRDQoNCk9uIDIwMjEvMS8yOCAzOjQwLCBCb2IgUGVhcnNvbiB3cm90ZToNCj4gT24gMS8y
Ny8yMSA2OjA0IEFNLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+PiBPbiBXZWQsIEphbiAyNywg
MjAyMSBhdCAwNDoyNDozMVBNICswODAwLCBYaWFvIFlhbmcgd3JvdGU6DQo+Pj4gRXZlbiBpZiB3
ZSBlbmFibGUgc3Ffc2lnX2FsbCBvciBJQlZfU0VORF9TSUdOQUxFRCwgY3VycmVudCByeGUgDQo+
Pj4gbW9kdWxlIGNhbm5vdCBzZXQgaW1tX2RhdGEgaW4gV0Mgd2hlbiB0aGUgcmVsYXRlZCBXUiB3
aXRoIGltbV9kYXRhIA0KPj4+IGZpbmlzaGVkIG9uIFNRLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogWGlhbyBZYW5nPHlhbmd4Lmp5QGNuLmZ1aml0c3UuY29tPg0KPj4+IC0tLQ0KPj4+DQo+Pj4g
Q3VycmVudCByeGUgbW9kdWxlIGFuZCBvdGhlciByZG1hIG1vZHVsZXMoZS5nLiBtbHg1KSBvbmx5
IHNldCANCj4+PiBpbW1fZGF0YSBpbiBXQyB3aGVuIHRoZSByZWxhdGVkIFdSIHdpdGggaW1tX2Rh
dGEgZmluaXNoZWQgb24gUlEuDQo+Pj4gSSBhbSBub3Qgc3VyZSBpZiBpdCBpcyBhIGV4cGVjdGVk
IGJlaGF2aW9yLg0KPj4gVGhpcyBpcyBJQlRBIGJlaGF2aW9yLg0KPj4NCj4+IDUuMi4xMSBJTU1F
RElBVEUgREFUQSBFWFRFTkRFRCBUUkFOU1BPUlQgSEVBREVSIChJbW1EdCkgLSA0IEJZVEVTIA0K
Pj4gIkltbWVkaWF0ZSBEYXRhIChJbW1EdCkgY29udGFpbnMgZGF0YSB0aGF0IGlzIHBsYWNlZCBp
biB0aGUgcmVjZWl2ZQ0KPj4gICBDb21wbGV0aW9uIFF1ZXVlIEVsZW1lbnQgKENRRSkuIFRoZSBJ
bW1EdCBpcyBvbmx5IGFsbG93ZWQgaW4gU0VORCBvcg0KPj4gICBSRE1BIFdSSVRFIHBhY2tldHMg
d2l0aCBJbW1lZGlhdGUgRGF0YS4iDQo+Pg0KPj4gSWYgSSB1bmRlcnN0YW5kIHRoZSBzcGVjLCB5
b3Ugc2hvdWxkbid0IHNldCBpbW1fZGF0YSBpbiBTUS4NCj4+DQo+PiBUaGFua3MNCj4+DQo+IFRo
aXMgc2VlbXMgYSBsaXR0bGUgY29uZnVzZWQgdG8gbWUuIHdjLmltbV9kYXRhIGlzIHNldCBpbiBy
eGVfcmVzcC5jIGluIHJlc3BvbnNlIHRvIGFuIGluY29taW5nIHJlcXVlc3QgcGFja2V0IHRoYXQg
Y29udGFpbnMgYW4gSU1NRFQgZXh0ZW5zaW9uIGhlYWRlci4gSS5lLiBhIHdyaXRlIHdpdGggaW1t
ZWRpYXRlIG9yIHNlbmQgd2l0aCBpbW1lZGlhdGUgb3Bjb2RlIGZyb20gdGhlIHJlbW90ZSBlbmQg
b2YgdGhlIHdpcmUuIFRoaXMgd2MgaXMgZGVsaXZlcmVkIHRvIHRoZSByZWNlaXZlIGNvbXBsZXRp
b24gcXVldWUgd2hlbiB0aGUgbWVzc2FnZSBpcyBjb21wbGV0ZS4gSXQgc2hvdWxkIG5vdCBoYXZl
IGFueXRoaW5nIHRvIGRvIHdpdGggdGhlIGxvY2FsIHNlbmQgd29yayBxdWV1ZSBlbnRyaWVzLg0K
SGkgQm9iLA0KDQpDdXJyZW50IHJkbWEgbW9kdWxlcyhlLmcgc29mdHJvY2UsIG1seDUpIG9ubHkg
c2V0IHdjX2ZsYWdzIHRvIElCVl9XQ19XSVRIX0lNTSBmb3IgdGhlIGNvbXBsZXRlZCBzZW5kIHdv
cmsgcXVldWUgZW50cmllcy4NCkkgYW0gbm90IHN1cmUgaWYgaXQgaXMgYWxzbyB0aGUgSUJUQSBi
ZWhhdmlvci4NCg0KQmVzdCBSZWdhcmRzLA0KWGlhbyBZYW5nDQo+IEJvYiBQZWFyc29uDQo+DQo+
DQo+IC4NCj4NCg0KT24gaW5zcGVjdGlvbiwgdGhlIElCVl9FQ19XSVRIX0lNTSBmbGFnIGlzIHNl
dCBpbiByeGVfY29tcC5jIGZvciBzZW5kIGNvbXBsZXRpb24gcXVldWUgZW50cmllcw0KDQoJCWlm
ICh3cWUtPndyLm9wY29kZSA9PSBJQl9XUl9SRE1BX1dSSVRFX1dJVEhfSU1NIHx8DQoJCSAgICB3
cWUtPndyLm9wY29kZSA9PSBJQl9XUl9TRU5EX1dJVEhfSU1NKQ0KCQkJd2MtPndjX2ZsYWdzID0g
SUJfV0NfV0lUSF9JTU07DQooVGhlcmUgYXJlIHR3byBjb3BpZXMgb2YgdGhpcyBiZWNhdXNlIHRo
ZSB1c2VyIHNwYWNlIGFuZCBrZXJuZWwgc3BhY2UgV0Mgc3RydWN0cyBhcmUgZGlmZmVyZW50LikN
CkFzIEkgc2FpZCBlYXJsaWVyIHRoaXMgc2VlbXMgb2YgbGl0dGxlIHZhbHVlIHRvIG1lIGJlY2F1
c2UgdGhlIHdjIGNvbnN1bWVyIHdyb3RlIHRoZSBzZW5kIHdxZSBhbmQga25vd3MNCndoZXRoZXIg
aXQgaXMgYW4gaW1tZWRpYXRlIG9wZXJhdGlvbiBidXQgZG9lc24ndCBodXJ0IGFueXRoaW5nLiBJ
biBwYXJ0aWN1bGFyIGl0IGRvZXMgbm90IGltcGx5IHRoYXQNCmltbWVkaWF0ZSBkYXRhIGlzIHJl
dHVybmVkIGluIHRoZSB3Yy4gDQoNCkl0IGlzIGFsc28gc2V0IGluIHJ4ZV9yZXNwLmMgZm9yIHJl
Y2VpdmUgY29tcGxldGlvbiBlbnRyaWVzDQoJCWlmIChwa3QtPm1hc2sgJiBSWEVfSU1NRFRfTUFT
Sykgew0KCQkJdXdjLT53Y19mbGFncyB8PSBJQl9XQ19XSVRIX0lNTTsNCgkJCXV3Yy0+ZXguaW1t
X2RhdGEgPSBpbW1kdF9pbW0ocGt0KTsNCgkJfQ0KKEFnYWluIHRoZXJlIGFyZSB0d28gY29waWVz
LikNCg0KSW4gYWRkaXRpb24gdGhlIHJlY2VpdmUgd2Mgb3Bjb2RlIGlzIHNldCBmb3Igd3JpdGUg
d2l0aCBpbW1lZGlhdGUNCg0KCQl3Yy0+b3Bjb2RlID0gKHBrdC0+bWFzayAmIFJYRV9JTU1EVF9N
QVNLICYmDQoJCQkJcGt0LT5tYXNrICYgUlhFX1dSSVRFX01BU0spID8NCgkJCQkJSUJfV0NfUkVD
Vl9SRE1BX1dJVEhfSU1NIDogSUJfV0NfUkVDVjsNCihUaGlzIGlzIHJlcXVpcmVkIGJ5IElCVEEg
Y2hhcHRlciAxMS4pDQoNClRoZSByZWNlaXZlIHdjIHByb2Nlc3NpbmcgaXMgdHJpZ2dlcmVkIGlu
IHRoZSBub3JtYWwgY2FzZSB3aGVuIHRoZSBsYXN0IHBhY2tldCBvZiBhIG1lc3NhZ2UgaXMgcmVj
ZWl2ZWQgKGkuZS4gd3JpdGUgbGFzdCB3aXRoIGltbWVkaWF0ZSwgZXRjLikgd2hpY2ggd2lsbCBz
ZXQgdGhlIGZsYWdzIGFib3ZlIG9yIHdoZW4gYW4gZXJyb3Igb2NjdXJzIHdoaWNoIG1heSBub3Qg
cmV0dXJuIHRoZSBpbW1lZGlhdGUgZGF0YS4NCg0KQm9iDQo=
