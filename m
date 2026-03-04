Return-Path: <linux-rdma+bounces-17468-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFctEKozqGm+pQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17468-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 14:29:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A09BD2006CF
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 14:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97617310B6C8
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B26303A26;
	Wed,  4 Mar 2026 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gZGtusQi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020111.outbound.protection.outlook.com [52.101.84.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C91A681A;
	Wed,  4 Mar 2026 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630642; cv=fail; b=bt/CVbFMPNw8Jgc2xeGJvFMREyj+0yCG1la9F/wSzzTI+jdoJPh2bCPBWdjjkdx0EMgQ3n8c4Yu06RPXJFLFxpVpnKjd9ylj9Vfw6HxVbL9HX4ds+/MtEp17vHssJeeuKHg+hArUHW2Nkn4+8A9T2cGec6UK0JUyXydF0YtoUDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630642; c=relaxed/simple;
	bh=3dsE/riO1JSJ3ft6LpRoI78Datc5/pZTKja75cd6Q2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BZCo6wfTwRCbmnI9cdW1QxrPzH1ELdGEOtWDHhO10eDxCicv4+QPNSgsP6kfJ0VS/HiGBHeA2RMg+t8onp4u/c05k6SNIhwFFhNoNVJxzB2meMnyyuawQje5ITaX7iUEAlKUnHuZnyYbSQAqoJzVyuzDOD8EiZDGz9JUGaRdjg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=gZGtusQi; arc=fail smtp.client-ip=52.101.84.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyQrxOKUPxqybS+ckdI5tvkEaAIGYQ00TDcFO1q1ZSCguQ7CAsQRx7T+xlD6ZSW0JJKCohyguz5b0leLAzlJLVUqG6mk4Gfrx3GPzlGlkaowq/MdDohKZESyIwDThJhWOxlxxB+STiWnuM6KWgL7l8f7+mQMRLjLpqSXxJT0GCYzEYoe5ZQqEi//mTWnUqEdy7R/qDCh8qJkNFmMOe4AfCPKB/0d2krIDru9s5L2dQjldT2h55PWl45rcfmkVVSQIjZ84fPzqB+fxo80Gj1Q04vc5+niBj7oiPvImqCEO0Qo4080UY9Rp4MIH7/YnAS12JkpWv0zb8NSINRFKjW8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dsE/riO1JSJ3ft6LpRoI78Datc5/pZTKja75cd6Q2Q=;
 b=a5SxcHkxLwnegxzZifFDmAFPZSWojW5OiLoHlCms2d6Uqb7XCzHW5EReNbEzfYJq2x7OQdMstKdVfGLmQq6UsEOIDZcQWTfoQGPxd8ab5EfWPubHIlM3pl2xyhfwzQYBF7kCskMmjwXreEKPTYMf+tekOvx5v8h+YOKCT7SZRF7L+JaTdXZs4+mB4yCGriQwqHGfMUXLy49z6dOSgaNdTbEZ6zLjlnzIxp1lt4JN6nT6lBBL7XiIEZpcdn0953s2ycYu19RTLmCfAJn5ihw/B4XMJCwdof5ZL9Y2hEd7qWFzDVFrIrQwKRRrXddiS87cp9suKSsmrFmZWeYCbCPUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dsE/riO1JSJ3ft6LpRoI78Datc5/pZTKja75cd6Q2Q=;
 b=gZGtusQifs67gWNT83c+dmUhGt7QBzQwvbBUlr+nGonEL91XivG12/6ubhuzOgQ8QspQ2Gk+RedCTUY0tZk0uHPvKBj3slVSnS6TvIAfzS70wW14Ai0Wt7Hv8xRb+1FmX2M6FluBaf9B1YKwAApVzeRRaJ11Q3MhW+UsSsOBVJQ=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by GV1PR83MB0652.EURPRD83.prod.outlook.com (2603:10a6:150:161::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 13:23:37 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%3]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 13:23:37 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Konstantin Taranov <kotaranov@microsoft.com>, Leon Romanovsky
	<leon@kernel.org>, Konstantin Taranov <kotaranov@linux.microsoft.com>
CC: Shiraz Saleem <shirazsaleem@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana: Provide a modern CQ creation
 interface
Thread-Topic: [PATCH rdma-next v2 1/1] RDMA/mana: Provide a modern CQ creation
 interface
Thread-Index: AQHcq9obj5Bblf2meUa1Zm63iFmp5g==
Date: Wed, 4 Mar 2026 13:23:36 +0000
Message-ID:
 <DU8PR83MB09750B39D50595F015641D7DB47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260303124825.301452-1-kotaranov@linux.microsoft.com>
 <20260304110500.GZ12611@unreal>
 <DU8PR83MB09757DD51165365AC8BBB884B47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
In-Reply-To:
 <DU8PR83MB09757DD51165365AC8BBB884B47CA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec221220-48c8-4bce-a819-128ea156a15a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-04T11:27:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|GV1PR83MB0652:EE_
x-ms-office365-filtering-correlation-id: a9b0f5e4-9716-4152-2812-08de79f13e24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 Eee90sXK73gRSaFa/9Zbgi8Kd8m+YWdRtwew5vCGAu1FDFBq7eyOmabsn9gW0ShKanhn1BH9V89bQ3XIiqy7v2Dj+RQoNlXc3cMd25liebydcckxR3juybkONP5JqUQHmfq0T8Npj0QKzjXqyjL+XoKQ7TT++DSOk0lFgkqoRXBC2YV32xZdZlI5UPHkgmxSEuDCcETtzI1FyDpvFcjanMJDMdvkKOVS9zmSNLvxnYV2XrG4g4aUmslDYgSn61NCy7hviq9Bn2BiFELe+o7eBw0voPnqUeX7e3ur6BjhrUhUxQ7VuDPGfEG50zomTk8MbKdjWHc7Rq3sThxOyqk2b9BhBHrQjTrMaHscdZom7duBwKO+LimrzeLsmeTfra34U5N7KbV7pbxjZJzwVsavD+QdERzgelLLNVYwCOSTH6MYUiGNjs94uJmFkgO5+RxdRsCBWhgup8eL9NxLzHO1/FhogphHMFmmmcalaf1z7OYVkMZAw0seI/L/Kk7TAqYbrjJvNxf8U3IZN3EBKWUf+kxqWDRG8nMizM0bICBqsDM52Fx5nUzVpj+URVTTEdu3u2dNaDJuteQmnP34GcjBBMfvcWZPt62vd9bOmyRmbRMzOlRITd4bLp1i2fcXs67gf2va1ABRwxyTDZ8QPBAbsdk1FqBUVUUCWNCirZb0KEUXv1RPJQvEVk4Uy/RI13rnM27fyFxJ/tIgAuo7bHHOTNSBp2JRBemsDVS1Rr3rSapLFww3JUFhF6khBcuHPQ6P+vyNJGlfPFks/r94My5U62DUD/q32Fe9wviBBfxk070=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWlodzQxY04weEdLNlgza2wzaUMyMVNmNnBKWnFyMTBySm5TVUdiaUpvUkpp?=
 =?utf-8?B?NnIrVVlPZUpWbDZueWZrdXAySUhVYzl6Zk1JbmxwOFZUcERiOUY5WGJMYzJ3?=
 =?utf-8?B?bHMxRGkxdWtxL3FwK1dMZGt2UEw1VDJMdGJYaWJhRDJ1NTFncjRQbk55OEps?=
 =?utf-8?B?Y0dnYW5VQ2lDcTh3MktxNSswRWQrRk1aNi94Zk8vS2o1N2owMU9UK0tpd1pX?=
 =?utf-8?B?UGpTWFZ3aEhNYU1CbCtiQnp2enVjenhaajEzSGJqcTVpa2RiVFVCbzAvRWxC?=
 =?utf-8?B?a3U5dU5IcmVmS2RpSlFoMWdTOWxsMFZ2Y0kzZythWUUyTHo4R2lvYTFWdGhK?=
 =?utf-8?B?bnNSUm9pNE9MTHErNjg5TzcxVW5pbG94eWkyb0Z0UldubUlLeXBJc0VZM29I?=
 =?utf-8?B?WElRMDMwd0w1TjE1WnZDbWRMTTc1enFIamFmVmdpbDJUV3h3aGhWM1JBbmFw?=
 =?utf-8?B?d2NEZ0Y4cElVNnpFdkVUOTdXNHl1MjNTSm5nT3RBUEl2VjFZYTNxVmptVEls?=
 =?utf-8?B?T2k4MGxyMTlLQ1pPWHhIa3B1YmdkaC9LTVhtV3RQRGpqSGlKdjVRS2g5YTF6?=
 =?utf-8?B?a2V2YVRMaVQ0dXZ2R1FyQ1NWY3BhdGNGeW5mTzk5azd3RmErRm15M0o2NWl4?=
 =?utf-8?B?VU1ESkh3a2VhakhmSWxaT282bDJnUmpIcTB1bDBza2tMaDI4SThlZXhrZG1Y?=
 =?utf-8?B?R3phcUlHcmgzOURYeS9GZkZ4YVViVGlZcUNqV3F5bFp3dTdPSUFLZmhBV3Z3?=
 =?utf-8?B?RVBxSHpVMWJqTzBPams3NXoycDlCVkp2RE9PRk1lc0tDd2piNS9zQ0JDT2Vz?=
 =?utf-8?B?Snd2VFpjakduTFQ4Q3JHVGR1akVhc2ZGTFM2RnJ6QVNTQkJQelhJem52Q29D?=
 =?utf-8?B?K3o0WVBZcWo0bmdCb2dYZXE0REVOUWg1dmY5T0paSjdjcUNPUzlKRXZPWEZD?=
 =?utf-8?B?SjVaMVhxS3lNblczSzUzd00zRWs3WjFlUDVvZzJwMkF2RVZiaTE3V3pzMUxY?=
 =?utf-8?B?R2lzbE9RUXVYL3V0K1l0TXVZL3pVb3B6WFpUbUdtZzVwdHdzOHFubE16T3ov?=
 =?utf-8?B?MmtmaFVzOEVYc0pvK3ZxVkFCZXR4QWxQR09ZMnBIQ29WTHJ5UE41cWltcFUy?=
 =?utf-8?B?WllWUzU4U3c3N0d3dFphTkFVMTRGemQ2cnZ5dnVGWnM3Y3FXY3FEdHFMbGtl?=
 =?utf-8?B?em1ldXVqblJ3UlVyelVubVdPTXcrSnl6VVpnL0NuYU5ocXBwNHEvODJYQlJm?=
 =?utf-8?B?cE1DSGtueFR2dGt5MzhQYTZva1grWnBTNXUrR3lvKzBZQUZkTXBDZGFTNENU?=
 =?utf-8?B?ZEczM0FWMmorRnBseXplZSthdnVKZ1RaVjZ5d05kcHdSU0lpSy83OU0vR1hr?=
 =?utf-8?B?MXREZ3NzWHdpSzZOYXFWeHN0cFMyS1VITmlZMlViYUQ4S1FDaTdZK0ZUTWJJ?=
 =?utf-8?B?Q1hFRWExM0RPYzlPWWwxWUhqTDRHUHBIcmtqaHUram10ZU8vUWtCQ05nSkx5?=
 =?utf-8?B?TzVJUEI2OHdwL3EzSWFLOGNDWHdLS3ZTd1ZkTUY5WjgvWm5xVE9oM0s0YTlB?=
 =?utf-8?B?clZGYUFVYnhSL2FJNjJPc3RqdWlVZy8vU2R6VzFZdmZyQndwSHZ5RVFqVXB6?=
 =?utf-8?B?L2ppY3VVczdBTFNwZjJZSlBrcmNBUzJSVENFYytlakx0enE3Umo2RklqZ3NH?=
 =?utf-8?B?ZWwvOEhRUDA4T2dETGpJdEFESWNlTGxYUVE0RVZ1ckZ6ZEhtbUF4dDErRVdJ?=
 =?utf-8?B?VjVoWm9GdlZPMi9BNGpaT1hyc3VaM2xVQ2Y0ZVo2UldtaWl1bGc2Vnc0ZXlq?=
 =?utf-8?B?WHVBNU5pYUg3VVAvalZhaFpZRVJ4MW0rSVlYSTF0WW1rc2tWTHU2MGxWLzZl?=
 =?utf-8?B?alJEUDRPYXFNTGJobmZMM0dVYStadW4wSEpuSm83a3c1bDZ6VTZvNGY4L1N4?=
 =?utf-8?B?cTYyWXI3V2E4QklyMkhjazFhZ2NIa1liRVk2bm5rTHFxbk5KaHZudlpQQ0Ns?=
 =?utf-8?B?RFZjQTFrR1QwRWkxbldzZWVxVERocTB3WVBzNDVrY0tJUDZQeWhoOTZOUE9q?=
 =?utf-8?B?cXFLSlJhWm1pOTdMNm44MWNSU3AwWld2QTUyMEJJQ1Q1d3pqK3NuOFhncStp?=
 =?utf-8?B?YlNmY0tqOFlhaDBuSEFXOUNiRmFaZkVxYzgvdy9lZDhONXZMMGVmNW53WVJR?=
 =?utf-8?B?djFTcURlUkoxS0xhN0tKc0ZkK3dDOFpoZ0w4aVM0UU5yNlA1WTFRdW1WYXh2?=
 =?utf-8?B?SWVxNDR3aHNyS3JuTW9oVkJ3MFV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU8PR83MB0975.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b0f5e4-9716-4152-2812-08de79f13e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 13:23:36.9748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCl5G6vJmgbH4aCz4AVVOqCBOFfipdUfelTxM21/ejohQJu0J50vCbEbO3QKxbPEaQzEw4sj0HbgKw2a88Gp5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR83MB0652
X-Rspamd-Queue-Id: A09BD2006CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17468-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,DU8PR83MB0975.EURPRD83.prod.outlook.com:mid]
X-Rspamd-Action: no action

PiA+ID4gVGhlIHV2ZXJicyBDUSBjcmVhdGlvbiBVQVBJIGFsbG93cyB1c2VycyB0byBzdXBwbHkg
dGhlaXIgb3duIHVtZW0NCj4gPiA+IGZvciBhDQo+ID4gQ1EuDQo+ID4gPiBVcGRhdGUgbWFuYSB0
byBzdXBwb3J0IHRoaXMgd29ya2Zsb3cgd2hpbGUgcHJlc2VydmluZyBzdXBwb3J0IGZvcg0KPiA+
ID4gY3JlYXRpbmcgdW1lbSB0aHJvdWdoIHRoZSBsZWdhY3kgaW50ZXJmYWNlLg0KPiA+ID4NCj4g
PiA+IFRvIHN1cHBvcnQgUkRNQSBvYmplY3RzIHRoYXQgb3duIHVtZW0sIGV4dGVuZA0KPiA+IG1h
bmFfaWJfY3JlYXRlX3F1ZXVlKCkNCj4gPiA+IHRvIHJldHVybiB0aGUgdW1lbSB0byB0aGUgY2Fs
bGVyIGFuZCBkbyBub3QgYWxsb2NhdGUgdW1lbSBpZiBpdCB3YXMNCj4gPiA+IGFsbG9jdGVkIGJ5
IHRoZSBjYWxsZXIuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogS29uc3RhbnRpbiBUYXJh
bm92IDxrb3RhcmFub3ZAbWljcm9zb2Z0LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gdjI6IEl0IGlz
IGEgcmV3b3JrIG9mIHRoZSBwYXRjaCBwcm9wb3NlZCBieSBMZW9uDQo+ID4NCj4gPiBJIGFtIGN1
cmlvdXMgdG8ga25vdyB3aGF0IGNoYW5nZXMgd2VyZSBpbnRyb2R1Y2VkPw0KPiANCj4gSXQgaXMg
bGlrZSB5b3VyIHBhdGNoLCBidXQgSSBrZXB0IGdldF91bWVtIGluIG1hbmFfaWJfY3JlYXRlX3F1
ZXVlIGFuZA0KPiBpbnRyb2R1Y2VkIG93bmVyc2hpcC4NCj4gSXQgbWFkZSB0aGUgY29kZSBzaW1w
bGVyIGFuZCBleHRlbmRhYmxlLiBJbiB5b3VyIHByb3Bvc2FsLCBpdCB3YXMgaGFyZCB0bw0KPiB0
cmFjayB0aGUgY2hhbmdlcyBhbmQgaXQgbGVkIHRvIGRvdWJsZSBmcmVlIG9mIHRoZSB1bWVtLiBX
aXRoIG5ldw0KPiBtYW5hX2liX2NyZWF0ZV9xdWV1ZSgpIGl0IGlzIGNsZWFyIGZyb20gdGhlIGNh
bGxlciB3aGF0IGhhcHBlbnMgYW5kIG5vDQo+IHNwZWNpYWwgY2hhbmdlcyBpbiB0aGUgY2FsbGVy
IHJlcXVpcmVkLg0KPiANCj4gPg0KPiA+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2Nx
LmMgICAgICB8IDEyNSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gPiA+ICBkcml2ZXJz
L2luZmluaWJhbmQvaHcvbWFuYS9kZXZpY2UuYyAgfCAgIDEgKw0KPiA+ID4gIGRyaXZlcnMvaW5m
aW5pYmFuZC9ody9tYW5hL21haW4uYyAgICB8ICAzMCArKysrKy0tDQo+ID4gPiAgZHJpdmVycy9p
bmZpbmliYW5kL2h3L21hbmEvbWFuYV9pYi5oIHwgICA1ICstDQo+ID4gPiAgZHJpdmVycy9pbmZp
bmliYW5kL2h3L21hbmEvcXAuYyAgICAgIHwgICA1ICstDQo+ID4gPiAgZHJpdmVycy9pbmZpbmli
YW5kL2h3L21hbmEvd3EuYyAgICAgIHwgICAzICstDQo+ID4gPiAgNiBmaWxlcyBjaGFuZ2VkLCAx
MTEgaW5zZXJ0aW9ucygrKSwgNTggZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2NxLmMNCj4gPiA+IGIvZHJpdmVycy9pbmZp
bmliYW5kL2h3L21hbmEvY3EuYyBpbmRleCBiMjc0OWY5NzEuLmZhOTUxNzMyYSAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2NxLmMNCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2NxLmMNCj4gPiA+IEBAIC04LDEyICs4LDggQEANCj4g
PiA+ICBpbnQgbWFuYV9pYl9jcmVhdGVfY3Eoc3RydWN0IGliX2NxICppYmNxLCBjb25zdCBzdHJ1
Y3QNCj4gPiA+IGliX2NxX2luaXRfYXR0cg0KPiA+ICphdHRyLA0KPiA+ID4gIAkJICAgICAgc3Ry
dWN0IHV2ZXJic19hdHRyX2J1bmRsZSAqYXR0cnMpICB7DQo+ID4gPiAtCXN0cnVjdCBpYl91ZGF0
YSAqdWRhdGEgPSAmYXR0cnMtPmRyaXZlcl91ZGF0YTsNCj4gPiA+ICAJc3RydWN0IG1hbmFfaWJf
Y3EgKmNxID0gY29udGFpbmVyX29mKGliY3EsIHN0cnVjdCBtYW5hX2liX2NxLCBpYmNxKTsNCj4g
PiA+IC0Jc3RydWN0IG1hbmFfaWJfY3JlYXRlX2NxX3Jlc3AgcmVzcCA9IHt9Ow0KPiA+ID4gLQlz
dHJ1Y3QgbWFuYV9pYl91Y29udGV4dCAqbWFuYV91Y29udGV4dDsNCj4gPiA+ICAJc3RydWN0IGli
X2RldmljZSAqaWJkZXYgPSBpYmNxLT5kZXZpY2U7DQo+ID4gPiAtCXN0cnVjdCBtYW5hX2liX2Ny
ZWF0ZV9jcSB1Y21kID0ge307DQo+ID4gPiAgCXN0cnVjdCBtYW5hX2liX2RldiAqbWRldjsNCj4g
PiA+ICAJYm9vbCBpc19ybmljX2NxOw0KPiA+ID4gIAl1MzIgZG9vcmJlbGw7DQo+ID4gPiBAQCAt
MjYsNDggKzIyLDkxIEBAIGludCBtYW5hX2liX2NyZWF0ZV9jcShzdHJ1Y3QgaWJfY3EgKmliY3Es
IGNvbnN0DQo+ID4gc3RydWN0IGliX2NxX2luaXRfYXR0ciAqYXR0ciwNCj4gPiA+ICAJY3EtPmNx
X2hhbmRsZSA9IElOVkFMSURfTUFOQV9IQU5ETEU7DQo+ID4gPiAgCWlzX3JuaWNfY3EgPSBtYW5h
X2liX2lzX3JuaWMobWRldik7DQo+ID4gPg0KPiA+ID4gLQlpZiAodWRhdGEpIHsNCj4gPiA+IC0J
CWlmICh1ZGF0YS0+aW5sZW4gPCBvZmZzZXRvZihzdHJ1Y3QgbWFuYV9pYl9jcmVhdGVfY3EsIGZs
YWdzKSkNCj4gPiA+IC0JCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+IC0NCj4gPiA+IC0JCWVyciA9
IGliX2NvcHlfZnJvbV91ZGF0YSgmdWNtZCwgdWRhdGEsIG1pbihzaXplb2YodWNtZCksDQo+ID4g
dWRhdGEtPmlubGVuKSk7DQo+ID4gPiAtCQlpZiAoZXJyKSB7DQo+ID4gPiAtCQkJaWJkZXZfZGJn
KGliZGV2LCAiRmFpbGVkIHRvIGNvcHkgZnJvbSB1ZGF0YSBmb3INCj4gPiBjcmVhdGUgY3EsICVk
XG4iLCBlcnIpOw0KPiA+ID4gLQkJCXJldHVybiBlcnI7DQo+ID4gPiAtCQl9DQo+ID4gPiArCWlm
IChhdHRyLT5jcWUgPiBVMzJfTUFYIC8gQ09NUF9FTlRSWV9TSVpFIC8gMiArIDEpDQo+ID4gPiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+IFdlIGFyZSB0YWxraW5nIGFib3V0IGtlcm5lbCB2
ZXJicy4gVUxQcyBhcmUgbm90IGRlc2lnbmVkIHRvIHByb3ZpZGUNCj4gPiBhdHRyaWJ1dGVzIGFu
ZCByZWNvdmVyIGZyb20gcmFuZG9tIGRyaXZlciBsaW1pdGF0aW9ucy4NCj4gDQo+IEkgdW5kZXJz
dGFuZCwgYnV0IHRoZXJlIHdhcyBhbiBhc2sgYmVmb3JlIHRvIGFkZCB0aGF0IGNoZWNrIGFzIHNv
bWUNCj4gYXV0b21hdGVkIGNvZGUgdmVyaWZpZXIgZGV0ZWN0ZWQgb3ZlcmZsb3cuIFNvIGlmIHdl
IHJlbW90ZSBpdCwgSSBndWVzcyB3ZSBnZXQNCj4gYWdhaW4gYW4gYXNrIHRvIGZpeCB0aGUgcG90
ZW50aWFsIG92ZXJmbG93Lg0KPiANCj4gPg0KPiA+ID4NCj4gPiA+IC0JCWlmICgoIWlzX3JuaWNf
Y3EgJiYgYXR0ci0+Y3FlID4gbWRldi0NCj4gPiA+YWRhcHRlcl9jYXBzLm1heF9xcF93cikgfHwN
Cj4gPiA+IC0JCSAgICBhdHRyLT5jcWUgPiBVMzJfTUFYIC8gQ09NUF9FTlRSWV9TSVpFKSB7DQo+
ID4gPiAtCQkJaWJkZXZfZGJnKGliZGV2LCAiQ1FFICVkIGV4Y2VlZGluZyBsaW1pdFxuIiwgYXR0
ci0NCj4gPiA+Y3FlKTsNCj4gPiA+IC0JCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiA+IC0JCX0NCj4g
PiA+ICsJYnVmX3NpemUgPSBNQU5BX1BBR0VfQUxJR04ocm91bmR1cF9wb3dfb2ZfdHdvKGF0dHIt
PmNxZSAqDQo+ID4gQ09NUF9FTlRSWV9TSVpFKSk7DQo+ID4gPiArCWNxLT5jcWUgPSBidWZfc2l6
ZSAvIENPTVBfRU5UUllfU0laRTsNCj4gPiA+ICsJZXJyID0gbWFuYV9pYl9jcmVhdGVfa2VybmVs
X3F1ZXVlKG1kZXYsIGJ1Zl9zaXplLCBHRE1BX0NRLA0KPiA+ICZjcS0+cXVldWUpOw0KPiA+ID4g
KwlpZiAoZXJyKSB7DQo+ID4gPiArCQlpYmRldl9kYmcoaWJkZXYsICJGYWlsZWQgdG8gY3JlYXRl
IGtlcm5lbCBxdWV1ZSBmb3IgY3JlYXRlIGNxLA0KPiA+ICVkXG4iLCBlcnIpOw0KPiA+ID4gKwkJ
cmV0dXJuIGVycjsNCj4gPiA+ICsJfQ0KPiA+ID4gKwlkb29yYmVsbCA9IG1kZXYtPmdkbWFfZGV2
LT5kb29yYmVsbDsNCj4gPiA+DQo+ID4gPiAtCQljcS0+Y3FlID0gYXR0ci0+Y3FlOw0KPiA+ID4g
LQkJZXJyID0gbWFuYV9pYl9jcmVhdGVfcXVldWUobWRldiwgdWNtZC5idWZfYWRkciwgY3EtPmNx
ZQ0KPiA+ICogQ09NUF9FTlRSWV9TSVpFLA0KPiA+ID4gLQkJCQkJICAgJmNxLT5xdWV1ZSk7DQo+
ID4gPiArCWlmIChpc19ybmljX2NxKSB7DQo+ID4gPiArCQllcnIgPSBtYW5hX2liX2dkX2NyZWF0
ZV9jcShtZGV2LCBjcSwgZG9vcmJlbGwpOw0KPiA+ID4gIAkJaWYgKGVycikgew0KPiA+ID4gLQkJ
CWliZGV2X2RiZyhpYmRldiwgIkZhaWxlZCB0byBjcmVhdGUgcXVldWUgZm9yIGNyZWF0ZQ0KPiA+
IGNxLCAlZFxuIiwgZXJyKTsNCj4gPiA+IC0JCQlyZXR1cm4gZXJyOw0KPiA+ID4gKwkJCWliZGV2
X2RiZyhpYmRldiwgIkZhaWxlZCB0byBjcmVhdGUgUk5JQyBjcSwgJWRcbiIsDQo+ID4gZXJyKTsN
Cj4gPiA+ICsJCQlnb3RvIGVycl9kZXN0cm95X3F1ZXVlOw0KPiA+ID4gIAkJfQ0KPiA+ID4NCj4g
PiA+IC0JCW1hbmFfdWNvbnRleHQgPSByZG1hX3VkYXRhX3RvX2Rydl9jb250ZXh0KHVkYXRhLCBz
dHJ1Y3QNCj4gPiBtYW5hX2liX3Vjb250ZXh0LA0KPiA+ID4gLQkJCQkJCQkgIGlidWNvbnRleHQp
Ow0KPiA+ID4gLQkJZG9vcmJlbGwgPSBtYW5hX3Vjb250ZXh0LT5kb29yYmVsbDsNCj4gPiA+IC0J
fSBlbHNlIHsNCj4gPiA+IC0JCWlmIChhdHRyLT5jcWUgPiBVMzJfTUFYIC8gQ09NUF9FTlRSWV9T
SVpFIC8gMiArIDEpIHsNCj4gPiA+IC0JCQlpYmRldl9kYmcoaWJkZXYsICJDUUUgJWQgZXhjZWVk
aW5nIGxpbWl0XG4iLCBhdHRyLQ0KPiA+ID5jcWUpOw0KPiA+ID4gLQkJCXJldHVybiAtRUlOVkFM
Ow0KPiA+ID4gLQkJfQ0KPiA+ID4gLQkJYnVmX3NpemUgPSBNQU5BX1BBR0VfQUxJR04ocm91bmR1
cF9wb3dfb2ZfdHdvKGF0dHItDQo+ID4gPmNxZSAqIENPTVBfRU5UUllfU0laRSkpOw0KPiA+ID4g
LQkJY3EtPmNxZSA9IGJ1Zl9zaXplIC8gQ09NUF9FTlRSWV9TSVpFOw0KPiA+ID4gLQkJZXJyID0g
bWFuYV9pYl9jcmVhdGVfa2VybmVsX3F1ZXVlKG1kZXYsIGJ1Zl9zaXplLA0KPiA+IEdETUFfQ1Es
ICZjcS0+cXVldWUpOw0KPiA+ID4gKwkJZXJyID0gbWFuYV9pYl9pbnN0YWxsX2NxX2NiKG1kZXYs
IGNxKTsNCj4gPiA+ICAJCWlmIChlcnIpIHsNCj4gPiA+IC0JCQlpYmRldl9kYmcoaWJkZXYsICJG
YWlsZWQgdG8gY3JlYXRlIGtlcm5lbCBxdWV1ZSBmb3INCj4gPiBjcmVhdGUgY3EsICVkXG4iLCBl
cnIpOw0KPiA+ID4gLQkJCXJldHVybiBlcnI7DQo+ID4gPiArCQkJaWJkZXZfZGJnKGliZGV2LCAi
RmFpbGVkIHRvIGluc3RhbGwgY3EgY2FsbGJhY2ssICVkXG4iLA0KPiA+IGVycik7DQo+ID4gPiAr
CQkJZ290byBlcnJfZGVzdHJveV9ybmljX2NxOw0KPiA+ID4gIAkJfQ0KPiA+ID4gLQkJZG9vcmJl
bGwgPSBtZGV2LT5nZG1hX2Rldi0+ZG9vcmJlbGw7DQo+ID4gPiAgCX0NCj4gPiA+DQo+ID4gPiAr
CXNwaW5fbG9ja19pbml0KCZjcS0+Y3FfbG9jayk7DQo+ID4gPiArCUlOSVRfTElTVF9IRUFEKCZj
cS0+bGlzdF9zZW5kX3FwKTsNCj4gPiA+ICsJSU5JVF9MSVNUX0hFQUQoJmNxLT5saXN0X3JlY3Zf
cXApOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ICsNCj4gPiA+ICtlcnJfZGVz
dHJveV9ybmljX2NxOg0KPiA+ID4gKwltYW5hX2liX2dkX2Rlc3Ryb3lfY3EobWRldiwgY3EpOw0K
PiA+ID4gK2Vycl9kZXN0cm95X3F1ZXVlOg0KPiA+ID4gKwltYW5hX2liX2Rlc3Ryb3lfcXVldWUo
bWRldiwgJmNxLT5xdWV1ZSk7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiBlcnI7DQo+ID4gPiAr
fQ0KPiA+ID4gKw0KPiA+ID4gK2ludCBtYW5hX2liX2NyZWF0ZV91c2VyX2NxKHN0cnVjdCBpYl9j
cSAqaWJjcSwgY29uc3Qgc3RydWN0DQo+ID4gaWJfY3FfaW5pdF9hdHRyICphdHRyLA0KPiA+ID4g
KwkJCSAgIHN0cnVjdCB1dmVyYnNfYXR0cl9idW5kbGUgKmF0dHJzKSB7DQo+ID4gPiArCXN0cnVj
dCBtYW5hX2liX2NxICpjcSA9IGNvbnRhaW5lcl9vZihpYmNxLCBzdHJ1Y3QgbWFuYV9pYl9jcSwg
aWJjcSk7DQo+ID4gPiArCXN0cnVjdCBpYl91ZGF0YSAqdWRhdGEgPSAmYXR0cnMtPmRyaXZlcl91
ZGF0YTsNCj4gPiA+ICsJc3RydWN0IG1hbmFfaWJfY3JlYXRlX2NxX3Jlc3AgcmVzcCA9IHt9Ow0K
PiA+ID4gKwlzdHJ1Y3QgbWFuYV9pYl91Y29udGV4dCAqbWFuYV91Y29udGV4dDsNCj4gPiA+ICsJ
c3RydWN0IGliX2RldmljZSAqaWJkZXYgPSBpYmNxLT5kZXZpY2U7DQo+ID4gPiArCXN0cnVjdCBt
YW5hX2liX2NyZWF0ZV9jcSB1Y21kID0ge307DQo+ID4gPiArCXN0cnVjdCBtYW5hX2liX2RldiAq
bWRldjsNCj4gPiA+ICsJYm9vbCBpc19ybmljX2NxOw0KPiA+ID4gKwl1MzIgZG9vcmJlbGw7DQo+
ID4gPiArCWludCBlcnI7DQo+ID4gPiArDQo+ID4gPiArCW1kZXYgPSBjb250YWluZXJfb2YoaWJk
ZXYsIHN0cnVjdCBtYW5hX2liX2RldiwgaWJfZGV2KTsNCj4gPiA+ICsNCj4gPiA+ICsJY3EtPmNv
bXBfdmVjdG9yID0gYXR0ci0+Y29tcF92ZWN0b3IgJSBpYmRldi0+bnVtX2NvbXBfdmVjdG9yczsN
Cj4gPiA+ICsJY3EtPmNxX2hhbmRsZSA9IElOVkFMSURfTUFOQV9IQU5ETEU7DQo+ID4gPiArCWlz
X3JuaWNfY3EgPSBtYW5hX2liX2lzX3JuaWMobWRldik7DQo+ID4gPiArDQo+ID4gPiArCWlmICh1
ZGF0YS0+aW5sZW4gPCBvZmZzZXRvZihzdHJ1Y3QgbWFuYV9pYl9jcmVhdGVfY3EsIGZsYWdzKSkN
Cj4gPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4gKw0KPiA+ID4gKwllcnIgPSBpYl9jb3B5
X2Zyb21fdWRhdGEoJnVjbWQsIHVkYXRhLCBtaW4oc2l6ZW9mKHVjbWQpLCB1ZGF0YS0NCj4gPiA+
aW5sZW4pKTsNCj4gPiA+ICsJaWYgKGVycikgew0KPiA+ID4gKwkJaWJkZXZfZGJnKGliZGV2LCAi
RmFpbGVkIHRvIGNvcHkgZnJvbSB1ZGF0YSBmb3IgY3JlYXRlIGNxLA0KPiA+ICVkXG4iLCBlcnIp
Ow0KPiA+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwlpZiAo
KCFpc19ybmljX2NxICYmIGF0dHItPmNxZSA+IG1kZXYtPmFkYXB0ZXJfY2Fwcy5tYXhfcXBfd3Ip
IHx8DQo+ID4gPiArCSAgICBhdHRyLT5jcWUgPiBVMzJfTUFYIC8gQ09NUF9FTlRSWV9TSVpFKQ0K
PiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArDQo+ID4gPiArCWNxLT5jcWUgPSBhdHRy
LT5jcWU7DQo+ID4gPiArCWVyciA9IG1hbmFfaWJfY3JlYXRlX3F1ZXVlKG1kZXYsIHVjbWQuYnVm
X2FkZHIsIGNxLT5jcWUgKg0KPiA+IENPTVBfRU5UUllfU0laRSwNCj4gPiA+ICsJCQkJICAgJmNx
LT5xdWV1ZSwgJmliY3EtPnVtZW0pOw0KDQpJIGp1c3QgcmVhbGl6ZWQgdGhhdCBJIGZvcmdvdCB0
byBoYW5kbGUgdGhlIGNhc2Ugd2hlbiBpYmNxLT51bWVtID09IE5VTEwNCmFuZCBtYW5hIGZhaWxz
IGxhdGVyIGFmdGVyIHRoaXMgY2FsbC4gSSBuZWVkIHRvIGNsZWFuIGliY3EtPnVtZW0gaW4gdGhp
cyBjYXNlLg0KSSB3aWxsIGFkZHJlc3MgdGhhdCBpbiB2My4gSSBhbSBzb3JyeS4NCg0KLSBLb25z
dGFudGluDQoNCg0K

