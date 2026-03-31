Return-Path: <linux-rdma+bounces-18835-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOpCOgmRy2m6JAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18835-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 11:16:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 920DE366DC0
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 11:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B8CE301F3AB
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A983D890C;
	Tue, 31 Mar 2026 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WiZiM5Ym"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020090.outbound.protection.outlook.com [52.101.84.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A1B3EC2C7;
	Tue, 31 Mar 2026 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948577; cv=fail; b=DFECO/O1U744Mnr1tFktvtH1zWt0xPwSyOlckHzYgDtVnIYLWQCUUZeQHOdFp/T23ZOtBgFMIcLD5T/6kFpYgWvk1xZq4EwTHVjkKO2oBZqGYEGeLQCQQhQOZ5aw88d71nMTw3PMnyLbuZFxcY5zyQgXv9e4iU1QyAt4JDcBIEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948577; c=relaxed/simple;
	bh=jCIedLb7pcmNa3CDh2mE8i13euKCVDCT+I9pDKuSvdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MbAqGyIJ+VVmg4Hor/f3igmHtmrIGU5hxZZMfZy21d6SZSnHzdgwWqVsmyeQRHIBRZxKHkns9SNHaHjdjz7y0lBvxpseQYL89ECWM6yViod20bBhbCYsdCGliGt73OAkxqfvDenIAJG+EsL+WXw5zM/WW21dpQ41/jbRpasoZQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WiZiM5Ym; arc=fail smtp.client-ip=52.101.84.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIGbfkJWPnI7n4UQkaOpJY6FylKUiKuS8OzkRVXElcu5NQceyAqDFcJu0ff1/Z/MWc5T8p7BLw9Q/yukD2SrloRQR3ERnZ1FF6DcdDjfnmS8p8jntoLR+uVPNxOp5Ok/bPmnPxp2L9aevQggYMNe82D8YXHSEVK2kgTdEx0dRS6N3cliU4mY7IoRz7QAM95pNQBlbnWSK7GG4NY343Rc9YyJpuxVpPTlkUIOA6KgZ7iGf8gkyOC8c3Xc7+D/fybfeEPtbyrH9D9ikBDkD3icAt/UIqpNoNuZEkssyaexdSiA0mOn3LsWKa3WhEsl1TVvZ/nlQ9rKtbx/nMHQuS6elQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCIedLb7pcmNa3CDh2mE8i13euKCVDCT+I9pDKuSvdo=;
 b=jVtv2JGC7ihypWYWj9vpTEo3EK9f2PB2cu+Ct1u5KMFpqG4+LHbbuZ5D5M672iwLtzHLj03Gy8oD09Dz0kwJ8QO6oy0OPgB/E/wI7FWtUhWYSUhGbgnV57qQ6z24XcXmDfLvW+fPU6xGKXbZUV7CyfFN2JLNPmcRNX399Ebyf10jJpzcFVJCDdchk5mS55LSIxvE/tmnVYuhjRh4oRTsqOO6+6UdxK3qOgmJ29as6E2yNG2OXLTBC2feC4FQZ3QBFFASSWCzKNUEBKAwhCj6RJAsjNA8pSJhXv4HBiNpeiCZMFoMW5udefaJ2+dHWP+6bF/ApyN5tr0Q425rHRKFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCIedLb7pcmNa3CDh2mE8i13euKCVDCT+I9pDKuSvdo=;
 b=WiZiM5Ym3oaA6V7Fx8nSDzmGzJrHSlflhXgUAnt/ZuzHW9IJnWvoccIZIxuXNkU4FRqtrFjgzEvK+pHMXfMlBraHz9hYsu1ZzFuoHoYBAcWWZRFV7Y5vA8y6v4Ro0ybhM9COtLbGgkEcEwmy+86GI6PlF/8k+cD1o7bST7ec7D8=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by VI0PR83MB0659.EURPRD83.prod.outlook.com (2603:10a6:800:219::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.6; Tue, 31 Mar
 2026 09:16:07 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 09:16:06 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Shiraz Saleem <shirazsaleem@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: memory windows
Thread-Topic: [PATCH rdma-next v2 1/1] RDMA/mana_ib: memory windows
Thread-Index: AQHcwO8Bf8bQHpLVkkyt80Cz+fDmMA==
Date: Tue, 31 Mar 2026 09:16:06 +0000
Message-ID:
 <DU8PR83MB097535795435224C126673C6B453A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260318172323.1416803-1-kotaranov@linux.microsoft.com>
 <20260330115810.GU814676@unreal>
In-Reply-To: <20260330115810.GU814676@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f4ed5db8-a396-49d2-bfc6-cf2c50ac3b01;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-31T09:13:48Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|VI0PR83MB0659:EE_
x-ms-office365-filtering-correlation-id: 187c0d7f-3718-4c23-be9f-08de8f0623cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 nAAGLEPs/M8V5hD+M4v4k5SYeI36E3cPsaaTvNhMsJ0fdjQV5ZXzr6a3PUB92u1e/fmZvtSbQy6lbEeS8DskPH3JiAeRooJ4m0LuDioBh1mRMSw3VEmMbPmkAW9xpY0NcipJt3nsrYEmyUxoifXdFcf4hZmCUFhwJrIsSbLVnA/OHbgn3NlK81Tx/onucjrA/hAkrqy+g6NRIfGCqnMokRV57pTfKYlqbjMY4p8/X4A9wdI0/yl0+l/Lc50pDAbGJQF1/bUxrMojr4QXbdt4pSRiG4IQWm9iKaouYt7UHV/PupJNUHF0wDCm0Su2HCBSnXQAg7mAUyzbDM/5arfW09QHfJXaUrakEdhEYrVixp0lxTepgi3f+4361ULVCFFDd0vBm2v9CZCCTG9dnhMRBUfvreDoeKmMeXjQ8Rjfpql+XQ3Box/QmzWIGkenVlBcBlAEtg5MaSEYLzU3AkEDkoDgwLCc3uBX2CwlqIENT73YMRI7JJXGU67AwS0X7f1gTj8yFCS7JDxtx87g8Zk2UCymno+FsSxinp+WcEqI7q5vEuOEFEssEPI7WwAYPCO5aPNuntt4Al3fTcapDRhvqK0OZ+GRUBnum5Bjs6h5SzkluC4Jzm0BN/8JxwbOObaWgdJji3OLutRe/4kL+pyzR8iRFdqO4j7h/6rhaJNjjoPedHQa9hra8GwQEEOzF7lhhNvU+T0lwyuOPmVJrM2CRuYblmbOgJn0LV80T1b+NNAPOdLWb25SZThuQGoDWS4jk2s5w6pf5Nbvv7YpjFf29yZZKCvcC2Gb5fdHkCQSo08=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cG1ubnNxRFRJYndLWHR6cGVFeTFBeGt2ZlhpY2sxd1RiREk3WFdVR2hvbVVl?=
 =?utf-8?B?b2syZEd1bHI1WGkxRXh2SFA2dGY3SUlTU0Z3ZU5YY3lTNllwZ0k0dU1hdDdl?=
 =?utf-8?B?VFZ4L0wxejZoakRKMVo5UVUxeVJmb3c3THREdEpIMjM2cGdNakQ0dVRQeCtT?=
 =?utf-8?B?WFUvK2EvMW5IZCtCWWtRbk9odWFZRmJBbTVKOVF1MzZha01tUWZ3MzBoeTN1?=
 =?utf-8?B?V2tSUERZcURYYWxRWm1TdGpFY214QUl2UVVTaDlCZ0lrNjlEcEpaR25LRUVC?=
 =?utf-8?B?bEhLb3IzWEpEZXlrbkRPeVZlaVBIcUZGa1NkbWwvbnBvdjNvcE05UnBKNUFr?=
 =?utf-8?B?bzNuNTMyTUlMdTdzUXpCQlR0LzV5cExhT0ZxbC9qNHkvNlBYVVh2eDFVbm5n?=
 =?utf-8?B?N3NlU0JHaFhOSXpXSWxjLzV4QThycTE2RGY2N1RScjAwMnQ2RnRDa1luVjdB?=
 =?utf-8?B?eXkycVZYa0tMR2ZqZEltNWVOckxXcGRubm5HcFFmdHpHdnJpU0taSEs5QzJN?=
 =?utf-8?B?d3JYd0hRc2tmaG5teHdrN2VsSzhrMEk0OWQ5c0NYWlB5MUx1SUpqcHdjLzZV?=
 =?utf-8?B?YThsVmYvL1d2MTdkQWhjOUpaRTBpeUdvWVRmdVBUZHdqQTJ5RDh3S3p6eU5m?=
 =?utf-8?B?TnFubFN0Sm5uc2FTUlRnR1dsOCtPbzlVM3ZqcyswUHBnRkx3dG5NMTdhU0do?=
 =?utf-8?B?SW10LytBTE1UWjQ5YkVZNjdGTFJhZ0w3dEtna2JoOG82QWQ4Q0NnZ29EQ2VT?=
 =?utf-8?B?K28zenhUNFdmQlVDdWZOQVlZenBoQ3lCa1l1cVNDZURBaVhqdVRiTkllUUZq?=
 =?utf-8?B?VTQybjZSdDRRaE9zc1M2SXh0YU5BSHVNNy9ldG5tM3lzcjlEakxDdVhUeW9G?=
 =?utf-8?B?eXRLbzZDdXdOZmZGMFY3dWVqbUlWNGVYVXRXZDNjWFluQ1RXUEpkTFQvZDRk?=
 =?utf-8?B?OU16RFUwa1BJaTNRcnlQM2lTNlZrUkNLRDZFNjNXUVhhWlNsaVJGRUh5aklG?=
 =?utf-8?B?Yk5COVNsc3A2NjhwbVA0TXQ4ekZhZWNkdVRxblNpOFJyQ215VU9WdDRxV1F5?=
 =?utf-8?B?WkI3T2FOc3hreWRReEtsMlV6aTZHTW9BQmVkNTdNd2lMampJQmZ3VzhKZ1I5?=
 =?utf-8?B?cExDWWhHMmZNOXNlS1dsdmxPRjFSalpwdlAvSWYrYU9wVU14d1R6c1A1UDlQ?=
 =?utf-8?B?UDZGRlo0L1hUVE93VzI1ODVCYTBKeW5FV2cwcm9BYUt3K0I5YkRVSHFJcmlp?=
 =?utf-8?B?STNwSktHRVphWTV4UEhVS1N3bnl5MUJPdlBjeXhWbU5qNFpwWkRqVy9tZjZ0?=
 =?utf-8?B?TzdUTmoxV24vL3N4NkMyNzZRYXhCK3VGOXBZbWUvcHRVV1RLdWJBQjFuMzNL?=
 =?utf-8?B?dG55a2pEeTVmcXZ5NGorakRUWnEwcXFIRGwxaE1DYWsvUDhaeEtHOUpwQzd0?=
 =?utf-8?B?R0dieFlobGlwOUNleUtsQjJ0SFFIbG9aWDlNOUdXckpsbTlxQ0xsNVZFcFRK?=
 =?utf-8?B?UDlmVkVueWtVNFpIUEtIZlJzUVE0TDFmRWJwRnBOaXN5TzZxSnJRUkpEeWNq?=
 =?utf-8?B?eW5XRUhialdNc3M5Z29KTGJ3WFlueFFCWDYvbWZ3c0RPdTRzUGkzdFU0WnVh?=
 =?utf-8?B?RzYrKzhZRVRHQ3dOUGtoSTlXejNZekxtLzdxYmFEUUFiT2k3VjE3TFVPck5o?=
 =?utf-8?B?R09BeUppUVQ3bXZ3Q0hwT1pSVU5HVi8xd1ZFdTM5anFObHFLMC95ZzlhY0Ir?=
 =?utf-8?B?eTA5T0xydVFCR0JpQWVTQjhVZ01sZkNaV0FFV3gwNVFoanZyZHU1amxZTXVK?=
 =?utf-8?B?VjJJRGNtZnhyYTFWSDBHeWMxZ2JNNUZ6T1NXWG1EcE00bXpIVWFQczNYRFYr?=
 =?utf-8?B?ZlNWc3YyYXdwV0JlNTlFZFk0dXZPbWlCb010V2J1YjlKTEZWWlBnVm94d3FX?=
 =?utf-8?B?YXVueUJEWW0yanlFemNnRUZRVGhWRXI2UWttb001VHVaQ2pXZm4rcXJ4TlZF?=
 =?utf-8?B?emlpMFJBSVFzeEpGZktvNWY1ajB2dEN6Unp0cFJoZzIzZTNIMkpPWFFnY2pi?=
 =?utf-8?B?Vi8wOXhCZEhYT2JodTRzcWg3YXEvZ2RWSG5UdGR2VFQ4NDJKK0srS3czOWN2?=
 =?utf-8?B?VGVLZGRLT0xRSW5XbE5rS1Uxa2ViRzVpZ2Q2SHo3MElpdHdLNEMrVkpzcThE?=
 =?utf-8?B?K3BRZmVkK2ZoQXJCOXlVUlRRWDFSNVNPRVMySy92Z0FyMS9OS3FYenhoVzlV?=
 =?utf-8?B?dzh6YithcjBaTTF0M21DeWx2eGx3PT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 187c0d7f-3718-4c23-be9f-08de8f0623cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 09:16:06.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ciw+bdyN1mXrAlsWtmRMsHppufZ1c9CqZSSYqb7SViXqXF9322AB5zQ3Jrmwx3eFTT/5MjlqzPuiIgP4Z1o3Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR83MB0659
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18835-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashi:url,DU8PR83MB0975.EURPRD83.prod.outlook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:url]
X-Rspamd-Queue-Id: 920DE366DC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBXZWQsIE1hciAxOCwgMjAyNiBhdCAxMDoyMzoyM0FNIC0wNzAwLCBLb25zdGFudGluIFRh
cmFub3Ygd3JvdGU6DQo+ID4gRnJvbTogS29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZAbWlj
cm9zb2Z0LmNvbT4NCj4gPg0KPiA+IEltcGxlbWVudCAuYWxsb2NfbXcoKSBhbmQgLmRlYWxsb2Nf
bXcoKSBmb3IgbWFuYSBkZXZpY2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLb25zdGFudGlu
IFRhcmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBmaXhl
ZCBjb21tZW50cy4gQ2xlYW5lZCB1cCB0aGUgdXNlIG9mIG1hbmFfZ2Rfc2VuZF9yZXF1ZXN0KCkN
Cj4gPiBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9kZXZpY2UuYyAgfCAgMyArKw0KPiA+IGRy
aXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21hbmFfaWIuaCB8ICA4ICsrKysrDQo+ID4gIGRyaXZl
cnMvaW5maW5pYmFuZC9ody9tYW5hL21yLmMgICAgICB8IDUzDQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKy0NCj4gPiAgaW5jbHVkZS9uZXQvbWFuYS9nZG1hLmggICAgICAgICAgICAgIHwg
IDUgKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gPC4uLj4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgbWFuYV9pYl9nZF9jcmVhdGVf
bXcoc3RydWN0IG1hbmFfaWJfZGV2ICpkZXYsIHN0cnVjdA0KPiA+ICttYW5hX2liX3BkICpwZCwg
c3RydWN0IGliX213ICppYm13KSB7DQo+ID4gKwlzdHJ1Y3QgbWFuYV9pYl9tdyAqbXcgPSBjb250
YWluZXJfb2YoaWJtdywgc3RydWN0IG1hbmFfaWJfbXcsDQo+IGlibXcpOw0KPiA+ICsJc3RydWN0
IGdkbWFfY29udGV4dCAqZ2MgPSBtZGV2X3RvX2djKGRldik7DQo+ID4gKwlzdHJ1Y3QgZ2RtYV9j
cmVhdGVfbXJfcmVzcG9uc2UgcmVzcCA9IHt9Ow0KPiA+ICsJc3RydWN0IGdkbWFfY3JlYXRlX21y
X3JlcXVlc3QgcmVxID0ge307DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCW1hbmFfZ2Rf
aW5pdF9yZXFfaGRyKCZyZXEuaGRyLCBHRE1BX0NSRUFURV9NUiwgc2l6ZW9mKHJlcSksDQo+IHNp
emVvZihyZXNwKSk7DQo+ID4gKwlyZXEucGRfaGFuZGxlID0gcGQtPnBkX2hhbmRsZTsNCj4gDQo+
IEJvdGggc2FzaGlrbywgd2hpY2ggcnVucyBvbiBHZW1uaW5pDQo+IGh0dHBzOi8vbmFtMDYuc2Fm
ZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnNhc2hpDQo+
IGtvLmRldiUyRiUyMyUyRnBhdGNoc2V0JTJGMjAyNjAzMTgxNzIzMjMuMTQxNjgwMy0xLQ0KPiBr
b3RhcmFub3YlNDBsaW51eC5taWNyb3NvZnQuY29tJmRhdGE9MDUlN0MwMiU3Q2tvdGFyYW5vdiU0
MG1pY3Jvc28NCj4gZnQuY29tJTdDZTg4ODhjZTY4OTEzNDc5ZDhkYjUwOGRlOGU1M2ExODYlN0M3
MmY5ODhiZjg2ZjE0MWFmOTFhYg0KPiAyZDdjZDAxMWRiNDclN0MxJTdDMCU3QzYzOTEwNDY4NzAz
ODA0MzMwMyU3Q1Vua25vd24lN0NUV0ZwDQo+IGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlk
V1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFXNHoNCj4gTWlJc0lrRk9Jam9pVFdGcGJD
SXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1yOW4xSm1kDQo+IEtlNXNtZHdE
UXRvODAlMkJIV29zazNEclJhMXo0amRObXpqTGprJTNEJnJlc2VydmVkPTANCj4gYW5kIG15IGxv
Y2FsIGNsYXVkZSBjaGVja3MgcG9pbnRlZCB0byB0aGUgc2FtZSBhcmVhIG9mIHRoZSBjb2RlOg0K
PiANCj4gICAgMjUgPiArICAgICBtYW5hX2dkX2luaXRfcmVxX2hkcigmcmVxLmhkciwgR0RNQV9D
UkVBVEVfTVIsIHNpemVvZihyZXEpLA0KPiBzaXplb2YocmVzcCkpOw0KPiAgICAyNiA+ICsgICAg
IHJlcS5wZF9oYW5kbGUgPSBwZC0+cGRfaGFuZGxlOw0KPiAgICAyNw0KPiAgICAyOCBtYW5hX2dk
X2luaXRfcmVxX2hkcigpIHNldHMgbXNnX3ZlcnNpb24gdG8gR0RNQV9NRVNTQUdFX1YxLg0KPiAg
ICAyOSBtYW5hX2liX2dkX2NyZWF0ZV9tcigpIGV4cGxpY2l0bHkgdXBncmFkZXMgdGhpcyB0bw0K
PiBHRE1BX01FU1NBR0VfVjINCj4gICAgMzAgZm9yIGFsbCBHRE1BX0NSRUFURV9NUiByZXF1ZXN0
cywgcmVnYXJkbGVzcyBvZiBtcl90eXBlOg0KPiAgICAzMQ0KPiAgICAzMiBtYW5hX2liX2dkX2Ny
ZWF0ZV9tcigpIHsNCj4gICAgMzMgICAgICAgICBtYW5hX2dkX2luaXRfcmVxX2hkcigmcmVxLmhk
ciwgR0RNQV9DUkVBVEVfTVIsIC4uLik7DQo+ICAgIDM0ICAgICAgICAgcmVxLmhkci5yZXEubXNn
X3ZlcnNpb24gPSBHRE1BX01FU1NBR0VfVjI7DQo+ICAgIDM1ICAgICAgICAgLi4uDQo+ICAgIDM2
IH0NCj4gICAgMzcNCj4gICAgMzggSXMgaXQgaW50ZW50aW9uYWwgdGhhdCBtYW5hX2liX2dkX2Ny
ZWF0ZV9tdygpIHNlbmRzDQo+IEdETUFfQ1JFQVRFX01SDQo+ICAgIDM5IGF0IEdETUFfTUVTU0FH
RV9WMSByYXRoZXIgdGhhbiBHRE1BX01FU1NBR0VfVjI/DQo+IA0KVGhhbmtzLiBJIHNlbnQgdjMu
IEl0IGRvZXMgbm90IG1hdHRlciB2MSB2cyB2MiBhcyBIVyBzdXBwb3J0cyBib3RoLCBJIGp1c3Qg
d3JvdGUgdGhpcyBwYXRjaCBsb25nIHRpbWUgYWdvLg0KSSBjaGFuZ2VkIHRvIHYyIHRvIG1ha2Ug
Y29kZSBtb3JlIHVuaWZpZWQuDQoNCj4gVGhhbmtzDQo=

