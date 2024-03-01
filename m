Return-Path: <linux-rdma+bounces-1178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D4F86D892
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Mar 2024 02:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B182B284F7F
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Mar 2024 01:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80441E891;
	Fri,  1 Mar 2024 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="d5rBf+sC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A421FAB
	for <linux-rdma@vger.kernel.org>; Fri,  1 Mar 2024 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255727; cv=fail; b=a4Uk5/Ri2HtvNEVAIUH1Bzq0R3/YKAKEAhgfdHKffkmxTB2VyXj18dtwdcuCzleaci9O7BEyNuJ5okpLpWzYzZmoEGVlveAjS9lYJX8FH4WBaj3l6bdAmUdV+8ZyOAgCN2tILVB/CpInNf3gpj3s9uqEPd6bt0xqSEbEQuXZJYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255727; c=relaxed/simple;
	bh=pLFPo0MZsFa0hJR0ybDprxVDMqHEdfZY5qy9pdoAOQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PCuqEG8928j10M0YyLYhP3Dpv6TVjeIkPX3IQ+pnRLVDVNzM8U76Q/m9bZiM0DM5Ajsq0w4rTUYz6muslms5109DszNUTV6W4/zqzDWD4ZXVqe7P0IlT4nG9y0E+wzVa43X9tbreDMBNqaiYDCWSiy7ghyRl08xdq1BmI39xTU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=d5rBf+sC; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4210qm8d016649;
	Fri, 1 Mar 2024 01:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=pLFPo0MZsFa0hJR0ybDprxVDMqHEdfZY5qy9pdoAOQU=; b=
	d5rBf+sCGOWPhQt6BqRpM5uM1sPoWg/ZN7Yn71r/gWissUI/XCwm2IwXdLO4/GPP
	R7qUAwBAeKhfQsfm/YAB5ApO3yi2/AvoXW8Tkp29Jmr7gJ4gufFXIjpizhsNdqmj
	lyY/pNfzebHRaBcsq6pVkqYJfadRgBx3VaHRJUsbVxOhzo/TX3Ij1shWKZHeACgC
	D+driqAeugHPyfnFxesWYzj2C/h97GBJeN9/jK38EsO6MTHhhjf1q+khFxKsuUJ3
	r3m6hS7By8l5x2tCH2vo2PM0k9mh7FhjI7kIMAfsG4XZgxg4bPWFtcQiiUclBWjA
	664c7xwMzFcXbPHNlWP14w==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wf7e6e3tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 01:15:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvhvVoFvqNezSpVhQJO6UUw8D0eCSYc5P+wdw7vdltCvjU24OL0flgQN2BtU3dUfQD/BKRyUfO+HCxb4ts7w2qIJhicTnYs2Y6A+VxLTOcUrit7svcjReczQ2Zh6W9D4fOx0WCM/hO9tspDLYZUjPHBhUHuqxz6Iec2mp0qjS8mxtseCFmMpABN/S6RUs4L340k54ji7l8f+Rh8n9jWnXEE716/gyd8IycXiMLLhf06fwRRFq+s29JspW0MsMDWlgvcNcImWB4lp8xNXe2RzAvEw/7c9wptL/tFTk5dHo4mv/eWUA5jFeTRhYhmGoVaK83o93mrXjRB0Rc5i5SOdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLFPo0MZsFa0hJR0ybDprxVDMqHEdfZY5qy9pdoAOQU=;
 b=ZVK7rGNwtshK5nyqNUj9DWNJn5UzMVCArorBPGeULPNeQOVU84EPOmLWFFXM/v/XYuk/UmHBX9sEaWZfIIqyevSmxDKi8nxIjoyXzTYwwvJ6i2A7kez/Tp3TbnTofGaZZPXXHY1CZbGLb6cmXTfMd0iKdEBkqRm2J8vWN+fydmcejImh5x6n+uuWFGXMb995hkkMVrwRjuXV5E+EWHWRTtftFc/b3MEBP8yxgNEDicofP8jV1H199041iHXjBtOHIUNlM0dSX1A+I2L71+hhROIMWfY/sRNELCyOflKafrrrHZOAJrB4KipUjJOFnUSsWK6XeeYTIfoVSHpuwRbrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB6489.namprd11.prod.outlook.com (2603:10b6:208:3a7::8)
 by SA0PR11MB4528.namprd11.prod.outlook.com (2603:10b6:806:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Fri, 1 Mar
 2024 01:15:19 +0000
Received: from IA1PR11MB6489.namprd11.prod.outlook.com
 ([fe80::a715:20b7:dbbd:8b3b]) by IA1PR11MB6489.namprd11.prod.outlook.com
 ([fe80::a715:20b7:dbbd:8b3b%2]) with mapi id 15.20.7362.015; Fri, 1 Mar 2024
 01:15:19 +0000
From: "Ma, Jiping" <Jiping.Ma2@windriver.com>
To: "Friesen, Chris" <Chris.Friesen@windriver.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>
CC: "Asselstine, Mark" <Mark.Asselstine@windriver.com>,
        "Tao, Yue"
	<Yue.Tao@windriver.com>,
        "Wang, Linda" <Linda.Wang@windriver.com>,
        "Bicakci,
 Vefa" <Vefa.Bicakci@windriver.com>
Subject: RE: question about in-tree vs out-of-tree Broadcom ROCE drivers.
Thread-Topic: question about in-tree vs out-of-tree Broadcom ROCE drivers.
Thread-Index: AQHaa04uiiYjFQpE8EypXAjT4dsP/rEiDynA
Date: Fri, 1 Mar 2024 01:15:19 +0000
Message-ID: 
 <IA1PR11MB6489954AE406151D5F09AFACD85E2@IA1PR11MB6489.namprd11.prod.outlook.com>
References: <febe07de-d57b-4369-b388-caa461c94b6b@windriver.com>
In-Reply-To: <febe07de-d57b-4369-b388-caa461c94b6b@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6489:EE_|SA0PR11MB4528:EE_
x-ms-office365-filtering-correlation-id: 3c30e501-30f4-4ff3-223f-08dc398d0f86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 J3fVRfiyQp/zmNLGv0kRrbbVLZuiXz6fgjkUAHiR7gWmpVboC426X9MGPGm9U5tbag6vS47zaueGnl6UIgcAU809G8+oVflhrrHkhUpOpm5L0IWdE/lz8K1nPG34JsR8ZjOM10vLv+7h23oDsXghGhD4g73K6w841Xakom9ZYAOq/ZHaLAXgHrA7RnqsYvDR9nnNL3vWeOQEDj4Z37tG+7qDfj8lUF1lfgzbc5CPWF6+XS8tBqDvsCiLFY4IIGswFKNNRzKqOpjTmzdYaDl7fogIkEZG7Agj1rqZ8HzkNKdkDB62Ba72PToZocCKHGQrNPgcUj8DtTB04SSk5zAQ5cgxdKs2dzvSwPnOTEH2HQUI0NVfsnn0neHiiDE0j3KjJGXBakMe92RVZCEOjWamp8eJ/5W80f88Xp3g/AkiZvLXr6sK6rzYDs3ohd6toAZhx4yjVouJUj30egE2ZOrT6SWGhiFRzXt7k5U988ejxqoQUpGJfrn9tg151YlHiDgaDQmn8Zy0kATtR4omll38VbeSqBFzub1SNrgtVYFHx3QgQsUbyK6ifn63WFHDAQ8jaNTVx4r3rOlSCkMbfdgV6zqM48cyopNH+WcCmYAAHbFlZmiwdvCg811TaAkv2zdrxJG7cq8+r4nWItwd1MSCrg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6489.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NWhMWVdDbUpmOGhIdk1ZVHhySjRnMzNocjFpUm1IT0k0K3dacFRUMmpBN3d3?=
 =?utf-8?B?aWJzUnFmWW5FYStBV3N1aWNhaWIvTGFJUXNRdk1LMVU2VmNLZUJUU0ZURG10?=
 =?utf-8?B?UFVsM2JIR1N2M3ZUQkNZd0JnYW9iZDk2Wlo4YjZnRG1pL2VTZk1ybnE1Z3Zq?=
 =?utf-8?B?dHVDVXNaOUtLZU1tRHQzRFdSOWIwS1BwZk1lRGRaVWp4dFNyekZFakhuTjE1?=
 =?utf-8?B?Rld3Z0JUVVVwbHlKK2dPR2p0MDVlWCtVekpGSnIvY1YzeGY0cEhmTWErYU9L?=
 =?utf-8?B?bTNRWjBJTmh5Mzk0ajlIWHJRUmpZMnJSL3hYSnM5WXpySkNUZDVDZWY2Yyt3?=
 =?utf-8?B?N2I2bTJFQyswTkJwNEpHNkRkeUxieHAvckNPOXgwbHdyaFZlQzFtQitEUVI4?=
 =?utf-8?B?TTU2ZkV1REdnNUduRXRxVkFWbmxGYmpjN0lOMThHSkRMUlVwMUlXVUtlTnh3?=
 =?utf-8?B?UGtVeEhFNnV3c3JHckJhU0NxSjNDd25hemRsazJmQW5LWUlwMlI0QzJVZEVi?=
 =?utf-8?B?NU51cHRZOFZoK1Evb1VpQTV1c2xoZXpGZEtmNW81R2xGY1RLcVB0M3pjdTk2?=
 =?utf-8?B?VEFFV2VNdW84bENBcUg3VW9XbTZBUmhvbktUODBKSVV5SFhuTXBjcHl0WUNV?=
 =?utf-8?B?NEUreW5hby9jRjZra245UDdteGpOWGdrUHBEM3hMZUM1UDVmRk96ZkxDYXBW?=
 =?utf-8?B?bWRScU9TdHY3NG5CTWExeVRiNlo2dXNmV2NXVzl4K1NDaW8wcllHeE5rK3FQ?=
 =?utf-8?B?NHdVbmk1ZEVFbndFSENGMXgzNHdlYWxqSTVxbit0MzFRNWtwRmg3c1gwU24z?=
 =?utf-8?B?MFo2Y09CMzRWZEd1NEVMRTV1N1dhNDIzOVlIdWpuR1NrZ1hVT1NqeHlEQmVD?=
 =?utf-8?B?QnIvVlY5N0dWTU1OM3Uwa0N3ME8xOUpmY3UvMDNYWTIyVjR6Rm5QUDJGUnpE?=
 =?utf-8?B?N3FWVzM1bXRMb00vUCtFUGx3b0VBV0paVGxqeG5jQjlSUmJ0R0RoYzJrVFZC?=
 =?utf-8?B?c2t0bGR6NWxSTFdHcWE1NEhaV05zUDBoUUJIT2ltdkdIbmc2dm9VNzAvd2k3?=
 =?utf-8?B?UVRsZ2diWnRjd1RkdlpHdExzRE9ZeGE4Z1ZMeHhud1hmWHRKWEdyNFFJejVU?=
 =?utf-8?B?SGlucjY1MDdnMGh5SGJaK0pnUWp3djc1RE42YkdHQnRuUklmZjFGTlRyUWVC?=
 =?utf-8?B?d1JLbHh0YitYVmRKTHhHN2FTQnpLMllnelBPbXJjK0FKSmxRNk1wNnpCQWhq?=
 =?utf-8?B?SkpBSnlJeUdSd1JiK0xwQjluTmlydVk5Mmh5NTNGNE9TVDAwMG5USFJ6dkcr?=
 =?utf-8?B?Mk5kb3RaYnRmRUtmby9sUzdWRVFZMFZWMm1pQ3ZtNjdreTB3NWhjQlRzaGk1?=
 =?utf-8?B?dWduNXJaVE55dmhjSWVHVm9HZHVnVm8wcUdzL091dzYvNklqZ2RxMWtuVThS?=
 =?utf-8?B?R3p0NUNGY3B5NGdncXJSV21YaExIN1pCTzlhSHo1aklxUzB3Nko1REtTWTV2?=
 =?utf-8?B?bTBxaktlcFlMbGdHN1dqT2FrWThxWnNMTjUrSUIzZXJtNkhXb3JoTGp1Q0Qr?=
 =?utf-8?B?NHRzRVZscHdrazM5cHhZZW9sK1hqUkhEamV6OHpsd2ppdWVEN2tZSUxkWnZM?=
 =?utf-8?B?WmtETnlwZmU0RktZeW56T3RqNVZZZTl4M24yS09RYXdLTGZ4M2dOMHYyT1BO?=
 =?utf-8?B?V2ZyUFlMeVFKbzFLT2IxVFk1ZHBJWXFCY2JYOFpmYkRRNE85bEF6OWFNS1dN?=
 =?utf-8?B?MzMzeWI4RlYzNENGZjRuSC9QNTN1TDNBdlhEWWlhdXI0dTkrOGR6QVIzTWhW?=
 =?utf-8?B?L0htbEN3Ym5VM2tranN4NGtSM20xMnJ5cGlsVkVray9qTmlRTW1uZlp3R1Vq?=
 =?utf-8?B?NjNucUdBWTdRbVM1aUlRZVF0TUw5VUd6cWRXeDRPVUUvOVB5K0FEWUhSZWdM?=
 =?utf-8?B?bDFTUi9KNHU5dnRhSExnWU5Dc1RUK0VnM0VNa0xFNGxFaVZHSEtwcnBreTIy?=
 =?utf-8?B?dzIzemR5QUtoOWFCODhHLzI1ZmtmY2ppbHlFYW40RWcvNE1HeTZoeHhqYVc3?=
 =?utf-8?B?N0h1d1hYU3hCczM0bmFXSFVteWErL3NiMHV6eFZOZWpLMlZGZHJNRlg1T2Nm?=
 =?utf-8?Q?GVKfBZpXtjnPHWtiS+z4V20qz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6489.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c30e501-30f4-4ff3-223f-08dc398d0f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 01:15:19.2775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1IX8XzIerXwSZiVvuF4QWYSUYHbM1X82av66PtRVDI3YrlOHISYtnZeVGF1HQNU8HH1A7ProyRsW25jdAYbq5GPo+fKt86PCfBw7s1GDdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4528
X-Proofpoint-GUID: HSzuU4ImdmjStJGoASjnQaolKWhHqo6t
X-Proofpoint-ORIG-GUID: HSzuU4ImdmjStJGoASjnQaolKWhHqo6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_07,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2403010008

SGksIENocmlzDQoNCkFkZGVkIHRoZSBjb21tZW50cyBpbmxpbmUuDQoNClRoYW5rcywNCkppcGlu
Zw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogRnJpZXNlbiwgQ2hyaXMgPENo
cmlzLkZyaWVzZW5Ad2luZHJpdmVyLmNvbT4gDQpTZW50OiBGcmlkYXksIE1hcmNoIDEsIDIwMjQg
NDozMSBBTQ0KVG86IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBzZWx2aW4ueGF2aWVyQGJy
b2FkY29tLmNvbQ0KQ2M6IEFzc2Vsc3RpbmUsIE1hcmsgPE1hcmsuQXNzZWxzdGluZUB3aW5kcml2
ZXIuY29tPjsgTWEsIEppcGluZyA8SmlwaW5nLk1hMkB3aW5kcml2ZXIuY29tPg0KU3ViamVjdDog
cXVlc3Rpb24gYWJvdXQgaW4tdHJlZSB2cyBvdXQtb2YtdHJlZSBCcm9hZGNvbSBST0NFIGRyaXZl
cnMuDQoNCkhpLA0KDQpJIGdvdCB5b3VyIGFkZHJlc3MgZnJvbSB0aGUgTGludXgga2VybmVsIE1B
SU5UQUlORVJTIGZpbGUsIEkgd2FzIHdvbmRlcmluZyBpZiB5b3UgY291bGQgY2xlYXIgc29tZXRo
aW5nIHVwPw0KDQpBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhlIGluLXRyZWUgZHJpdmVyIGF0IGRy
aXZlcnMvaW5maW5pYmFuZC9ody9ibnh0X3JlIHVzZXMgYSBCTlhUX1JFX0FCSV9WRVJTSU9OIHZh
bHVlIG9mIDEsIGFzIGRlZmluZWQgaW4gaW5jbHVkZS91YXBpL3JkbWEvYm54dF9yZS1hYmkuaC4N
Cg0KT24gdGhlIG90aGVyIGhhbmQsIHRoZSBsaWJibnh0X3JlLTIyOC4wLjEzMy4wIHBhY2thZ2Ug
YW5kIHRoZQ0KYm54dF9yZS0yMjguMC4xMzMuMCBkcml2ZXIgZW1iZWRkZWQgd2l0aGluDQpodHRw
czovL2RvY3MuYnJvYWRjb20uY29tL2RvY3MvTlhFX0xpbnV4X0luc3RhbGxlci0yMjguMS4xMTEu
MCBhcmUgdXNpbmcgYSBCTlhUX1JFX0FCSV9WRVJTSU9OIG9mIDYuDQoNCltKaXBpbmddIFRoZSBh
YmlfdmVyc2lvbiBvZiBPT1QgYm54dF9yZSBkcml2ZXIgaXMgNi4gIEJOWFRfUkVfQUJJX1ZFUlNJ
T04gb2YgNiBvZiBsaWJibnh0X3JlIGlzIHRvIGNvbXBhdGlibGUgd2l0aCBPT1QgZHJpdmVyLiAg
UGVyaGFwcyBsaWJibnh0X3JlIGRvZXMgbm90IGNvbnNpZGVyIHRoZSBpbi10cmVlIGRyaXZlci4N
Cg0KVGhpcyBzZWVtcyB0byBpbmRpY2F0ZSB0aGF0IHRoZSBpbi10cmVlIGtlcm5lbCBkcml2ZXIg
Y2Fubm90IGJlIHVzZWQgd2l0aCB0aGUgb2ZmaWNpYWwgdmVyc2lvbiBvZiBsaWJibnh0X3JlIGFz
IGRpc3RyaWJ1dGVkIGJ5IEJyb2FkY29tLsKgwqAgSXMgdGhpcyBjb3JyZWN0P8KgwqAgSWYgc28s
IGlzIHRoZXJlIGEgc2VwYXJhdGUgdmVyc2lvbiBvZiBsaWJibnh0X3JlIGludGVuZGVkIHRvIGJl
IHVzZWQgd2l0aCB0aGUgaW4ta2VybmVsIGRyaXZlcj8NCg0KW0ppcGluZ10gWWVzLCBpdCBsb29r
cyBsaWtlLiAgQnV0IEkgZGlkIFJETUEgdGVzdCwgdGhlIHRlc3QgcGFzc2VkLiAgU28gSSBzdWdn
ZXN0IHdlIGNhbiBkbyBtb3JlIGZ1bGwgdGVzdHMgZm9yIHRoaXMgcGFydCwgIHN1Y2ggYXMgd3Jj
cCByZWdyZXNzaW9uIHRlc3QgZXRjLiAgIEluIGFkZGl0aW9uLCBJIGRpZCBub3QgZG8gbW9yZSBz
ZWFyY2ggaWYgdGhlcmUgaXMgb3RoZXIgbGliYm54dF9yZSBjYW4gYmUgdXNlZCBmb3IgaW4tdHJl
ZSBkcml2ZXIuICBDb3VsZCB3ZSBhbHNvIGNvbmZpcm0gd2l0aCBCcm9hZGNvbSBmb3IgdGhpcyBx
dWVzdGlvbj8NCg0KVGhhbmtzLA0KDQpDaHJpcyBGcmllc2VuDQoNCg==

