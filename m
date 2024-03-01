Return-Path: <linux-rdma+bounces-1180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E544186DB93
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Mar 2024 07:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660161F221ED
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Mar 2024 06:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53967E65;
	Fri,  1 Mar 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="f10yl7K0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258A67C74
	for <linux-rdma@vger.kernel.org>; Fri,  1 Mar 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275274; cv=fail; b=fCsUMKkXfHCYgVKm/BOVnxeTwMskVIngaFqN/dejqAIIgH723i5jE52lrCwqVh3LHrcnK6uIKYGM6c9Tx5Bs3wotgSbg7uwO7rVhpYv7cZ3QfA7ERwENfIKLmuBfFrRO/uez7F0GRiEqu6Er2pKfsMsHgcXa+aUuM3tBM8iTXSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275274; c=relaxed/simple;
	bh=SbYOllnTFPsxT039//jMaiQSCRggxAIk6F6gwQIjb+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M6z6WavtZDY0ZRw1Zzwi2gmHdQaCBhaID5Zqo7HxZojNIqKWhH7bCTxGd8lXqEbxp4b2A5m2PQ4+tHVIzxkhIf6PBllvT5fbhyOghI+7KIioG9EWxAE5j1Y7kmvCPvgjLCs7HkpWm8qoxD7sdrsF7istg9F7XFDlhPv5v0a/6LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=f10yl7K0; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4216Sc7V001928;
	Fri, 1 Mar 2024 06:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=SbYOllnTFPsxT039//jMaiQSCRggxAIk6F6gwQIjb+w=; b=
	f10yl7K0WFdrTy6C/RWYYHunp1nhJ/KFXth/+POAQ5X5Dx0W1IaO+vkiPTNvtMaV
	+sAVw5dxfF61u9n6Va+vfnSMHrVObPmUHs2+DRgrQpwZ059tezITp/yB/slRnkqF
	ZctlNXYoDZkbney2pJi1Gi2frpkdqi9zvQRTximA0Vd0Ktk95PnhM8/Aiqm8yn3v
	x9NGt/tynB0Bm95a6H1jbZgGNXkVI6CczJJW8CodPRaKQIoVTQ5HTiaYFQJ/R8Ry
	ikkNPqyGofApZ6Q6E9lHA6iU05s97RZRLIKeoP4Hw7k3i2t4jFMO4dnLeb7V8vPj
	PFoV0I4Wi7NIgkMOekR/nw==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wf5nx6cff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 06:41:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbmcImCp2qgJRdMu/Xpz2cc9/GU8zvLePwBLpBIsmjwyF/MeqiPBhE2d6YJbU8coiGDPSF14uq2fiEgWIPoXgVjoUEU9mgkZ/g5fMczo2PH61HJ9cnpXQ9PEGKNCvRiTGkSg4PZ+k9x5AMVjyApmLaZUk6d/c/7u1vQsVxI/jGeWggjpLSd12mWcWEuxGC1oYS5aU/KScLPPFP+NbgJRARHHGcC3quCGQo7MBCOAu4eBZOm9L3BNLzHzCCB6EXYSbxEPEK7O0wC7bCdpvpBlNQ48qGjUsSIde2bJrWTmypbE+9t+QEmXYcFg2OqORBQDwlvv2Y593kIlmtJ6+wxrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbYOllnTFPsxT039//jMaiQSCRggxAIk6F6gwQIjb+w=;
 b=m0A1bAhbxwqgOR/88Gik/dsVzxSOVySsiVDlwGKM6GbcTtlYMgYw71oRIE+cHvaLMe0s864sZaszRVEhX27U9uBYfBYNb6AfPQIASE8D/KZHYkpq+F0FuYhjf5O2o0nhpi9XcrJYJKX3Hy8RXPt7Yxv2kao6abrTUHes0/DXXF7FNUAfO268zw/ZD6iIYlmIkDde5V0pS7Rha3jqsKkLQ0RXoFvJcZI5CdDYIMj+5jdoOcXLyIzuiyVLaiq6naLtT7eJ3Y/GlZsfpnaY8Efhz6zCMt7hd4DJBQdS4vo6JMhi6wYB7eslMtjjV8sNfG94FCTW8z/waGR28tz3UYysFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by PH7PR11MB6556.namprd11.prod.outlook.com (2603:10b6:510:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 06:41:07 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::f298:533a:3daa:9c2d]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::f298:533a:3daa:9c2d%6]) with mapi id 15.20.7362.015; Fri, 1 Mar 2024
 06:41:07 +0000
From: "Ma, Jiping" <Jiping.Ma2@windriver.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
CC: "Friesen, Chris" <Chris.Friesen@windriver.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Asselstine, Mark"
	<Mark.Asselstine@windriver.com>,
        "Tao, Yue" <Yue.Tao@windriver.com>,
        "Wang,
 Linda" <Linda.Wang@windriver.com>,
        "Bicakci, Vefa"
	<Vefa.Bicakci@windriver.com>
Subject: RE: question about in-tree vs out-of-tree Broadcom ROCE drivers.
Thread-Topic: question about in-tree vs out-of-tree Broadcom ROCE drivers.
Thread-Index: AQHaa04uiiYjFQpE8EypXAjT4dsP/rEiDynAgABXnYCAAARNkA==
Date: Fri, 1 Mar 2024 06:41:07 +0000
Message-ID: 
 <PH7PR11MB649867A35D47F27A78B331B9D85E2@PH7PR11MB6498.namprd11.prod.outlook.com>
References: <febe07de-d57b-4369-b388-caa461c94b6b@windriver.com>
 <IA1PR11MB6489954AE406151D5F09AFACD85E2@IA1PR11MB6489.namprd11.prod.outlook.com>
 <CA+sbYW1TnGrhST1eumh5D_4g-vfUt6sZ-rQtdu3tr4PqRfWrmA@mail.gmail.com>
In-Reply-To: 
 <CA+sbYW1TnGrhST1eumh5D_4g-vfUt6sZ-rQtdu3tr4PqRfWrmA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6498:EE_|PH7PR11MB6556:EE_
x-ms-office365-filtering-correlation-id: 75b6928e-a929-443f-67ed-08dc39ba92fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 07hgkxPG6bzFhyF2hyZLMobngMsn/FRImeh33mpXBsXYVI2Y8HZCWtZ/Q74pe+dEjxJ0T8iMdvSiIgSHWYBpnOoX9b6qSM92std8lWgKassvi4Rp3zV1o436F28BM2XJUk5SLMoo9JPRHRSIKWtbhT2cMubco+DcgUUQqqKYx153kLNimUvg7frGvnawIKUynEUzo99JbLuIyE/H+yeHhboPvQCRkHsRLNI2JcGnEQ0CGvuwiLQuBQmHywg9391wkg07XZpN7WQGeXFT43Gt3oiRXZNA8tMDID83nvmjk3pO6swg0XYCgQjWGdS2mnUoc59931fUB7TvrfSl5cOL76Vyj+l5SKCkqZV8XEAOYz/gBQPPPsAW8HCephPLm2NSoQ0xEDXJHCdP6WgLjC3GG49T2BDuBr17BKw1dX7z1Qy1VqVkdWcobCCau4VC/OPBniET8av13E+tzi/cTrRqlEGMixZ5WgLrUzRUj40NQt1lWCHjOWxJFbrqGzNaN8xuECabi2vC+FlI/aHUDDOxBs2Ja8OcvsSbG21MmiF0vFPgErjZyGkd5Ae37JINDGFfAtpqBd0bb4tM4lsJSmjRYY2mdpip25IV13ozxnGtmxogiQLynLa6SucRGzi3CrSVYd1luzMYgHdkQCu8e1NJoBZU1rQUAWmCm0QW7yy/Wes=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZnVZQXpjS0VST2hqVERnNW9YaUt2TmQ4QUoxT2g5YWdoM0JyMW9wdkpkZjJ2?=
 =?utf-8?B?ZTVuSmlHUWFjUnp5NmJ6eXlEdS96MTd1eG80NllGa2tjbmx4SVJJTjM0YmlV?=
 =?utf-8?B?RmJqb2dNRzVQVklLc3U1TERFWElWcWNJcGdmNk5wWS9NYWtlQmtxQklZQlJx?=
 =?utf-8?B?OTdJakowMTZSblNFYzFEbUo1REZjVUwwdHNKZzRjZ1lwd2FjYzBzYjdhN3VR?=
 =?utf-8?B?Zm4zUDJjbWVEWlI5QzRubUExQm1nQXBVRlhLRFV6RUxuWXVDVnhaZk10MzVX?=
 =?utf-8?B?T2x3bGJQY1RhWlIwRVFCYXh6RVYwaVZRQUIyWU51bWRKY0F0TW5xYlpGTStp?=
 =?utf-8?B?QUxpNUtLLysxbmszdHpHTm1HOHFFZDh2Yk92Unh6Y2F6dTQ5eTl1WHBQRVBj?=
 =?utf-8?B?TzNEN1ZLZ2JCcTNiSXJMdGFKM202VnQyU0hxVG4ySG5UL1BxRnNMMlBUUmxI?=
 =?utf-8?B?VFdlTGFxN2g1TExFUUFZMHRpbnczMVpjckxZOWVTY0hzSkRIczU0N0lRL2Jl?=
 =?utf-8?B?SGZxT0VoNDJoL085b2o5c0svVlNZSkhITm44SVE5ZjVuYXpPMTB4MnFJNXE0?=
 =?utf-8?B?SFBMLzN0T0tzb2tlb2FIc0pXK1NlLzQwVk5aK1BUM0ZaTmJUUXFTNzlEYWhB?=
 =?utf-8?B?dlVnWWVJZkhBNzFRNlc4bDFPdXppMGcyemZyRkxsTHgvKzJNUjVFZExleUZR?=
 =?utf-8?B?T1k3VzVNWS9VVDRWaG1IREpkT3lZbGhpQ3VVa21qRUo0aGpKRm5WQ3NGNTNn?=
 =?utf-8?B?MXNGMVorNHpmS0tNSVhRSW1EQkpUYjdic2tRZmRwdnI2bDk1a0RwSFFZRlA5?=
 =?utf-8?B?V2hCbUZPRW40NHl6akdmM085YjdMSCtRaEx4cUNPM0ZaR2toZHZkZ0tzWXFR?=
 =?utf-8?B?MTFRWjNKREE5M2owRnJtc3VsOXhIY3B4MjdUNmlLY1RBaGhiR3JSRUJ4STN5?=
 =?utf-8?B?Q0dsNFpVNzhieDgwWmdYVktDaC9qZW8wSVdnYnQ0bTVVTHJMek91dE1HcmdC?=
 =?utf-8?B?b2NTd0V1UU9uTjZGREE0RVZWTHNkT2djdlFHWktNQmZjMXpPRjNHcWplb2E5?=
 =?utf-8?B?WEhSaEU4ekJ0RFhKd3k3OGVXME5JOGU3ek5pYkhVa0NTNzlscVVTRHZXZjFh?=
 =?utf-8?B?aFJMbFhsVU54UFl1TElnYi9rMFdvcG1CYjR6Y2YzbUM4UnF2L0ZJaUV0L1Zq?=
 =?utf-8?B?R2V3NGVSNHVLODVqVUNFb3h1elNEcjZzSXZNNTZzN08xMXBwWkhkQmI4UjFv?=
 =?utf-8?B?d1hTVE0zUCtVNlQrWWxoNC9GY3pKd09LTVRQNGtNQW1iYk9EOVNhQUV4aFM2?=
 =?utf-8?B?U1Z4SktYbEsyUkhJSktvSy9EdllKMDFSRDlyYmIvc2t3dHhodWNjY0dNeG5F?=
 =?utf-8?B?RzJuc3ZrSTJ3SkhVUjUvNTc0NWZaQWY1Q3Q3Y3dpRCtudXdiRThpdHpwcVFQ?=
 =?utf-8?B?ZC9zOGxOTDRQQVJCTG56WWVZM282NXdsVEdyQndDdnhuTlIxTVdEZUQzbmpG?=
 =?utf-8?B?MXBHWWxRNk1rcmNKRXhDRFd3LzJoMjRmdktYeitnK2VkaVFuSXJLSXZlWHBK?=
 =?utf-8?B?VEJQdVgrUXlZT0xLbDR3bjA0MURBdzR6Um44WFVFNWVlUitiR25FSFdnc1Zk?=
 =?utf-8?B?WXNCVDZVNENHNDEyL3lmYkVLVUY5aWowbGwrMkVsOVdCY1BFamJtM2NqeXJw?=
 =?utf-8?B?ZUpiT2dGNnFWT3dhUTluREN0MlYzMndXSGcxL1g1dXVHYTdFMStGdkg3bVBx?=
 =?utf-8?B?VVRXU1RsOWI0NjVCdk5EVStOVXRiV0FBUlNlZjk2NTlVdXZpRnpxSHUyRFJu?=
 =?utf-8?B?bDQyK3FNQUlYNDljcDlSTlF1R0lrNXJ0QjBla0pkZGc2aFh6bEl6WmpIL0Uz?=
 =?utf-8?B?ajlUaWhTbnQ3RWFJNXZXUXJBTTZDclAyTEZXcDUyNDJSWVl1ZEhYZ3p1bm00?=
 =?utf-8?B?TG05Mm5YWXVCSHh1eXFTRjFBMWxqbUt3NHBZTVI4RWpDRzZlQTJNQXZFaU5J?=
 =?utf-8?B?ZlZ4aHdDZWpPeXRCU2tiYzRvc2d1OHM2NkllaFBjWUM1Vm1mRmRMYnl1TnBE?=
 =?utf-8?B?OTkvd2Z4ZlFKek40ZkpVQzZJdkphc0Qxa29WVFZZMnJqaytKbVdGMExSRUk5?=
 =?utf-8?Q?f5vWnJhPU8CvrvutGvUUuKClR?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b6928e-a929-443f-67ed-08dc39ba92fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 06:41:07.2001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzDQ+e0ftQyDJW0L2eNwu3/7ZVmj1jF/qw7K60xTP1JEzaeLU5oz5d+1Kc+xc8L2v8indjgBYQ9WDb+vc7xIsIiP4unScgF3wYJwGoyL54c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6556
X-Proofpoint-GUID: 077VFtFpvSScVfTzcvsfefgqiWdfzc0G
X-Proofpoint-ORIG-GUID: 077VFtFpvSScVfTzcvsfefgqiWdfzc0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_03,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403010054

SGksIFhhdmllcg0KDQpDb3VsZCB5b3UgaGVscCB0byBjb25maXJtIGlmIHRoZSBpbi10cmVlIGRy
aXZlciBibnh0X3JlL2JueHRfZW4gaW4ga2VybmVsIDYuNi43IGNhbiByZXBsYWNlIE9PVCBkcml2
ZXJzPyAgV2UgbmVlZCBzdXBwb3J0IHR3byBraW5kcyBvZiBkcml2ZXJzIE9PVCBhbmQgaW4tdHJl
ZSBhdCB0aGUgc2FtZSB0aW1lIGlmIGluLXRyZWUgZHJpdmVyIGNhbiBub3QgcmVwbGFjZSBPT1Qg
ZHJpdmVycy4NCldlIG5lZWQgdHdvIGxpYmJueHRfcmUgYW5kICByZG1hLWNvcmUgcGFja2FnZXMg
aW4gdGhlIHN5c3RlbSB0byBzdXBwb3J0IGluLXRyZWUgZHJpdmVycyBhbmQgT09UIGRyaXZlcnMu
DQoNClRoYW5rcywNCkppcGluZw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTog
U2VsdmluIFhhdmllciA8c2VsdmluLnhhdmllckBicm9hZGNvbS5jb20+IA0KU2VudDogRnJpZGF5
LCBNYXJjaCAxLCAyMDI0IDI6MDcgUE0NClRvOiBNYSwgSmlwaW5nIDxKaXBpbmcuTWEyQHdpbmRy
aXZlci5jb20+DQpDYzogRnJpZXNlbiwgQ2hyaXMgPENocmlzLkZyaWVzZW5Ad2luZHJpdmVyLmNv
bT47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBBc3NlbHN0aW5lLCBNYXJrIDxNYXJrLkFz
c2Vsc3RpbmVAd2luZHJpdmVyLmNvbT47IFRhbywgWXVlIDxZdWUuVGFvQHdpbmRyaXZlci5jb20+
OyBXYW5nLCBMaW5kYSA8TGluZGEuV2FuZ0B3aW5kcml2ZXIuY29tPjsgQmljYWtjaSwgVmVmYSA8
VmVmYS5CaWNha2NpQHdpbmRyaXZlci5jb20+DQpTdWJqZWN0OiBSZTogcXVlc3Rpb24gYWJvdXQg
aW4tdHJlZSB2cyBvdXQtb2YtdHJlZSBCcm9hZGNvbSBST0NFIGRyaXZlcnMuDQoNCkhpIENocmlz
L0ppcGluZywNCiBwbGVhc2Ugc2VlIG15IGNvbW1lbnRzIGJlbG93Lg0KDQpUaGFua3MsDQpTZWx2
aW4gWGF2aWVyDQoNCk9uIEZyaSwgTWFyIDEsIDIwMjQgYXQgNjo0NeKAr0FNIE1hLCBKaXBpbmcg
PEppcGluZy5NYTJAd2luZHJpdmVyLmNvbT4gd3JvdGU6DQo+DQo+IEhpLCBDaHJpcw0KPg0KPiBB
ZGRlZCB0aGUgY29tbWVudHMgaW5saW5lLg0KPg0KPiBUaGFua3MsDQo+IEppcGluZw0KPg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmllc2VuLCBDaHJpcyA8Q2hyaXMu
RnJpZXNlbkB3aW5kcml2ZXIuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDEsIDIwMjQgNDoz
MSBBTQ0KPiBUbzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IHNlbHZpbi54YXZpZXJAYnJv
YWRjb20uY29tDQo+IENjOiBBc3NlbHN0aW5lLCBNYXJrIDxNYXJrLkFzc2Vsc3RpbmVAd2luZHJp
dmVyLmNvbT47IE1hLCBKaXBpbmcgPEppcGluZy5NYTJAd2luZHJpdmVyLmNvbT4NCj4gU3ViamVj
dDogcXVlc3Rpb24gYWJvdXQgaW4tdHJlZSB2cyBvdXQtb2YtdHJlZSBCcm9hZGNvbSBST0NFIGRy
aXZlcnMuDQo+DQo+IEhpLA0KPg0KPiBJIGdvdCB5b3VyIGFkZHJlc3MgZnJvbSB0aGUgTGludXgg
a2VybmVsIE1BSU5UQUlORVJTIGZpbGUsIEkgd2FzIHdvbmRlcmluZyBpZiB5b3UgY291bGQgY2xl
YXIgc29tZXRoaW5nIHVwPw0KPg0KPiBBcyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhlIGluLXRyZWUg
ZHJpdmVyIGF0IGRyaXZlcnMvaW5maW5pYmFuZC9ody9ibnh0X3JlIHVzZXMgYSBCTlhUX1JFX0FC
SV9WRVJTSU9OIHZhbHVlIG9mIDEsIGFzIGRlZmluZWQgaW4gaW5jbHVkZS91YXBpL3JkbWEvYm54
dF9yZS1hYmkuaC4NCj4NCj4gT24gdGhlIG90aGVyIGhhbmQsIHRoZSBsaWJibnh0X3JlLTIyOC4w
LjEzMy4wIHBhY2thZ2UgYW5kIHRoZQ0KPiBibnh0X3JlLTIyOC4wLjEzMy4wIGRyaXZlciBlbWJl
ZGRlZCB3aXRoaW4NCj4gaHR0cHM6Ly9kb2NzLmJyb2FkY29tLmNvbS9kb2NzL05YRV9MaW51eF9J
bnN0YWxsZXItMjI4LjEuMTExLjAgYXJlIHVzaW5nIGEgQk5YVF9SRV9BQklfVkVSU0lPTiBvZiA2
Lg0KPg0KPiBbSmlwaW5nXSBUaGUgYWJpX3ZlcnNpb24gb2YgT09UIGJueHRfcmUgZHJpdmVyIGlz
IDYuICBCTlhUX1JFX0FCSV9WRVJTSU9OIG9mIDYgb2YgbGliYm54dF9yZSBpcyB0byBjb21wYXRp
YmxlIHdpdGggT09UIGRyaXZlci4gIFBlcmhhcHMgbGliYm54dF9yZSBkb2VzIG5vdCBjb25zaWRl
ciB0aGUgaW4tdHJlZSBkcml2ZXIuDQo+DQo+IFRoaXMgc2VlbXMgdG8gaW5kaWNhdGUgdGhhdCB0
aGUgaW4tdHJlZSBrZXJuZWwgZHJpdmVyIGNhbm5vdCBiZSB1c2VkIHdpdGggdGhlIG9mZmljaWFs
IHZlcnNpb24gb2YgbGliYm54dF9yZSBhcyBkaXN0cmlidXRlZCBieSBCcm9hZGNvbS4gICBJcyB0
aGlzIGNvcnJlY3Q/ICAgSWYgc28sIGlzIHRoZXJlIGEgc2VwYXJhdGUgdmVyc2lvbiBvZiBsaWJi
bnh0X3JlIGludGVuZGVkIHRvIGJlIHVzZWQgd2l0aCB0aGUgaW4ta2VybmVsIGRyaXZlcj8NCj4N
Cj4gW0ppcGluZ10gWWVzLCBpdCBsb29rcyBsaWtlLiAgQnV0IEkgZGlkIFJETUEgdGVzdCwgdGhl
IHRlc3QgcGFzc2VkLiAgU28gSSBzdWdnZXN0IHdlIGNhbiBkbyBtb3JlIGZ1bGwgdGVzdHMgZm9y
IHRoaXMgcGFydCwgIHN1Y2ggYXMgd3JjcCByZWdyZXNzaW9uIHRlc3QgZXRjLiAgIEluIGFkZGl0
aW9uLCBJIGRpZCBub3QgZG8gbW9yZSBzZWFyY2ggaWYgdGhlcmUgaXMgb3RoZXIgbGliYm54dF9y
ZSBjYW4gYmUgdXNlZCBmb3IgaW4tdHJlZSBkcml2ZXIuICBDb3VsZCB3ZSBhbHNvIGNvbmZpcm0g
d2l0aCBCcm9hZGNvbSBmb3IgdGhpcyBxdWVzdGlvbj8NCg0KSWYgeW91IGFyZSB1c2luZyBhbiBp
bi10cmVlIGtlcm5lbCBkcml2ZXIsIHRoZW4geW91IGNhbiB1c2UgdGhlDQpsaWJibnh0X3JlIGNv
bWluZyB3aXRoIHRoZSByZG1hLWNvcmUvbGliaWJ2ZXJicyBwYWNrYWdlcyBpbiB0aGUgT1MNCmRp
c3Ryby4gbGliYm54dF9yZSBpcyBwYXJ0IG9mIHJkbWEtY29yZQ0KaHR0cHM6Ly9naXRodWIuY29t
L2xpbnV4LXJkbWEvcmRtYS1jb3JlL3RyZWUvbWFzdGVyL3Byb3ZpZGVycy9ibnh0X3JlLg0KU28g
aWYgeW91IGFyZSB1c2luZyB0aGUgaW4gdHJlZSBibnh0X3JlIGRyaXZlciwgbm8gbmVlZCB0byBp
bnN0YWxsIGFueQ0KbGliYm54dF9yZSBzZXBhcmF0ZWx5LiBQbGVhc2UgaW5zdGFsbCB0aGUgcmRt
YS1jb3JlL2xpYmlidmVyYnMNCnBhY2thZ2UuDQoNCklmICB5b3UgYXJlIHVzaW5nIHRoZSBPT1Qg
ZHJpdmVyLCBwbGVhc2UgdXNlIHRoZSBPT1QgbGliYm54dF9yZSBhbmQNCmJueHRfcmUvYm54dF9l
biBkcml2ZXIgZnJvbSB0aGUgQnJvYWRjb20gZG93bmxvYWQgc2VjdGlvbi4NCmh0dHBzOi8vZG9j
cy5icm9hZGNvbS5jb20vZG9jcy9OWEVfTGludXhfSW5zdGFsbGVyLTIyOC4xLjExMS4wDQoNCj4N
Cj4gVGhhbmtzLA0KPg0KPiBDaHJpcyBGcmllc2VuDQo+DQo=

