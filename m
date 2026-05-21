Return-Path: <linux-rdma+bounces-21081-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEl7NAvTDmr2CQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21081-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:40:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF895A27FB
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 11:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0D003016035
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275737B400;
	Thu, 21 May 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="e/ELaWYz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021107.outbound.protection.outlook.com [40.107.130.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783737B01C;
	Thu, 21 May 2026 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356424; cv=fail; b=LuHByTu33CvtXbu+us2sXpDo4Tafk9QUzfDvGHWbQ7imnibrw5WWDqIVTv/fG0ij+XAAO5rrt2K4ctR04mblTJaYQyv5XUgTqIpgRyq3Yi5kxgI/hodR8EJqlTLuifl5Lm4mDsYaG3Ww+IN2CMpYSm6qx7GE07ipY8e+187pqgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356424; c=relaxed/simple;
	bh=ysMJCYuz9NPzR5WzEWLkU7qChNvoNjP+Ke7RwBi1nrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FpVpgIZfL6nohgsXA4SA5yIwRq49wmUF958odQlFjCGXInmD95V87lgTUxskc61XlcuMwN53DLpS5ngsDl0nfOsBMTHWkOQgtWwemjX4Uungr9PcpxsF1ZDsZ/0pzwU9+5q+yig7bx7dxKLqPK0GblS9R2xo9/oLLT91+FMQ3Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=e/ELaWYz; arc=fail smtp.client-ip=40.107.130.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9LGWaCokTXIQG+RP/aM55TUOt5r/bi31n0C7R2Fem4Vx2ikUdtiyq6AM/saLF9D2hFfUT+DB09d+kKuqTl6KgJRKRUV8zfJYv6tAzFVafCS+y+tWVm7zBNQC9dieN6n92RnAEPPtGdTd+7rEU38PZ515TlbuzTuXdjKM2t/GMirRqLgLxxvyt52X81AWPoR9Nyk6qdm8KlkdThuLRypvF+CsJRcwWG7sFSotzAWXfUQ8b/wfNcUCeiy999A/GSFYe0qTrCqE9nwwwwVZ3CnBtUDK0rLda0DTvXx0HxCJBPZWgPkxKEQNyNZW8spKLwSAxOK+tNpdLXedsFmOX10MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysMJCYuz9NPzR5WzEWLkU7qChNvoNjP+Ke7RwBi1nrU=;
 b=fHzZyPt64Un4StNXRJFXPhMLO+mI9vFQS8JZ/+Sm+D+7gD4ZFgS2h7XTsVuNlzP3qMMMiv/IYRib+J192So7WjDS3jKPQo6nuIeI5Mmy7wMvmTJZvTrlrIXL6ZRUf2aAaYDMD3bWbJy263QRi7HsiorQpxlCJzftZNie91on1+kIin162xvRq32cPrKCsOvEK761kYOFA+/8vzyD+YRa2f2PBMwo+kYMrCdqZAIsc0E/eoQ4wr6Jk8Gnyqgfa5Ts7I+Nw0l+ZfRmSGoJg877Pdt+zwa8rssTj5LnIMf8JXyBlSoNljxU8/tbfarwDbXxhsMPQAZaJcLg/9Hyd3IBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysMJCYuz9NPzR5WzEWLkU7qChNvoNjP+Ke7RwBi1nrU=;
 b=e/ELaWYzfHYicnyhg/LDrvIPbbem/c1y1mcVoaR2UnJtGaSauorldXhP9LMIBEbM4YQ6Nqqjs337F33dLGSruzSDw84SIJ9IuPFxY898sHAqmRG1cZ0YIpLzUWkG1gNZH7JRh05l/o3Iq4FeITpWUKGb3tV/ZaZUOa829pUC+Rc=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by GVXPR83MB0670.EURPRD83.prod.outlook.com (2603:10a6:150:1e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.6; Thu, 21 May 2026
 09:40:17 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%4]) with mapi id 15.21.0071.001; Thu, 21 May 2026
 09:40:17 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Long Li <longli@microsoft.com>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mana_ib: Use ib_get_eth_speed for
 reporting port speed
Thread-Topic: [PATCH rdma-next] RDMA/mana_ib: Use ib_get_eth_speed for
 reporting port speed
Thread-Index: AQHc6QXVWRSV8TwvyUirZAXznlmVJA==
Date: Thu, 21 May 2026 09:40:17 +0000
Message-ID:
 <DU8PR83MB097593C9AD4F8A9FC4C3804CB40E2@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260512094056.264827-1-kotaranov@linux.microsoft.com>
 <SA1PR21MB66831B2B066734B6228C866BCE062@SA1PR21MB6683.namprd21.prod.outlook.com>
 <20260517110701.GD33515@unreal>
In-Reply-To: <20260517110701.GD33515@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0efeb6d2-84ae-4ab8-874d-e1a652d23431;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-21T09:38:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|GVXPR83MB0670:EE_
x-ms-office365-filtering-correlation-id: 07cfac3c-d26e-4a9c-1fe3-08deb71cf79c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|4143699003|11063799006|3023799007|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 LyxMo22YqqPOW8Oj4F11h2S9NZ8DcMtz391ra/YcDOqSccVhvb0iW7rnRMA4cJbUbs2S60X02nuHdPCeyVf5UfclSfazuDLUxbMFBEaignfdhD9LNUIHveQqiAYCJvzhYMWS/Xzt0Ez5jNxbExiGzKo+I5YBxS48TiIA7yLtMhU9SblYhsVgPHRMRB2KPzRiMo5B15IH3yLDZhkbJSva+jqXrh/Y910GNTycGIV8sNU0oBUZyf+IPOlDPycEd/qgpVOTZzuaA2YUL21tf199GECjFJbqftauqN3o8oDzt4oJZCK/NlDFEJGb0uhoSood1CfuIkzWtekG3RmO4+zYXRBzw9BQiNuEcLbKCAkLXpnHIog7O7FzeTjLVEw9UB3AGKyyG5wMgD4GQqQWBwBQcX+a6C5l8VbSCWdpC03yBrSh/tnq14QSXioSArnwfcfp+CxBxw2WVGjxnfkLdRtuAU56dDE1nciOZT5RdbPwOSGnIcU/ovXvGlsPaDO27bo89Heq3e87cUKqn85so9FqEz97PYNyH0TVAV+94CZDfGFMEWPhXzxwI6mCvRy1sWqUSuUP/yu4zHQ7C4NMkz4/cFIksZqoY42Jlv16o2+qpojMdvJArcn5gvNnYQHPK5rz5hdtnd0/nX7Emb1f3CKG0bMkLup05pXfE68ktE+2KTIhxqFRLW6kFErfu5dA89sCBbSuw6XPEDJG6HH5K4NlN2l4BrHcMSHJTQwdCl4FOyuuv7/D3GHS9py3Vx9Cc8b9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4143699003)(11063799006)(3023799007)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTJTaDZuUmNpREFkN1I5bTVva2c0MlNCQmN4QURORWIvRkgzUTliRmw2M3Nr?=
 =?utf-8?B?ZDkvQ21tNjE0TnhjUlVyQ2ljaVpwYVFTQzg5ZStmWk9qeHptK2RxN1JKbjBo?=
 =?utf-8?B?ZUFseGJIQm5uYmY2K2VlYkhBc0RkcUxwYXB3cjBaK3JKT2l6QnE5WXV1MTZo?=
 =?utf-8?B?a3ZsTUlWTmRSSnVLbTlKYWtENVZKQTd5OUk5b3ozNjNTdGNraHpSb0J0aEpi?=
 =?utf-8?B?STJMS05ZclhTL1cyZmVhZTY4UEZMb0FOUzhFNmdqODdnMUxiRDdVM1FHRCtm?=
 =?utf-8?B?WDlBcGdnUkNvVGhjTFFmUFJodDRXOUQyQkc5UlNyL013ZUQwR0RUdEFuWmVl?=
 =?utf-8?B?T3NMUldodHlWVVM1RTFEM0lJMXRWYk9tcXhCcnJ1NmhXWUZCWS81cGM5bHdI?=
 =?utf-8?B?VXFmQVVwNnI5dm1xMEJseW8zVmFBL1JuT0pSbmo0T29TZmFnT3o0TENGVHdo?=
 =?utf-8?B?RDFkL0Z1TTdBREVvU0d1MHVWOE8xTXR3QjlWTWJQR3luM004bHZlaVFmbjBz?=
 =?utf-8?B?dVJRZjZHaFFpTTkvOHR0U3Bvb1NUYVlEQWdQa0xoWnphRmpIb2hsc3Fsella?=
 =?utf-8?B?Yk1mRGg0UHcvc0hyNjBmVWk1UCtKY2dWZndOaHMxZERSdUVWaEgrc0tjK3Rz?=
 =?utf-8?B?ZGhUVzQ3Mm5nQ0dFcjdpU0E1REp4L05Ya0l1RlFUQ2NrNnp2UWlHTEMrSnRn?=
 =?utf-8?B?aWl1Z0hiYUVTOTNYNGxsblJxSnk3VDhQQ1lUNDByYVRjTlBqWFRsNVcxZnMx?=
 =?utf-8?B?dkt4a1VnZitpbEFEZHJ6VHNrWVlzTDJJQ1ZQRy8vaHYrN29wNjNxb3hvbml6?=
 =?utf-8?B?aUM0S3dGY2JiOFZSU0RBSDhuaFk5VXhuNi9lcy85c0lmOXBFWmJnaU9Fellk?=
 =?utf-8?B?N0NCTStnVlNlaEZJUWJWQW1mLzRMbFpaekJYdmlPZC9KK2hReUs3TDVHMFdF?=
 =?utf-8?B?eHZCUUd0VVZLRExLWldXN0FUdXhrQXZ2NmtxODJ6TVlFVnlaRkhxUDA2RGk0?=
 =?utf-8?B?OVlIdkFqS1lpWUtkS2dPUnE4Zkk2UFpVaVlFWnVDRmtBSVkxYytyaXE4VTNS?=
 =?utf-8?B?MXhJdzZpdnRYOWc5aWlNMnZWcGVjMlkzYVRHZDdZZjlOcldEem56cjlkTTAx?=
 =?utf-8?B?TVhCOFduTXRzY1dRRkYyaitrU21sQ3cvUGI5NGRLYng1ZDYyTkRNbTZoVUFv?=
 =?utf-8?B?NCtvamdOMW85MXkyMEdTSjV1anZ4bVRPYm9VSGFIQXhUSzEvclVZS2pSVGgz?=
 =?utf-8?B?QUU5ZkQwdmJoUlRCbk9ZRS9Jd3JXNzZsRXBjUkFIRDF1WW5YUmsreEtDM1hW?=
 =?utf-8?B?SWRxNVRqVDZqcHBaaFlEa2NRTWNEcWFkRStHRlRXRzRaMHR2SGp6S2tReDda?=
 =?utf-8?B?ZkJmc3VEZHpYc2REczV6dGRiL2FhTk1JekVHRW4xNmlzMm9qM2NhYkJwTmFs?=
 =?utf-8?B?Zi9BendiNWdYdEthVlVwUWE4aE1LSEw3OHo2N3hxN202ZXJBMTFhbXE2TnpG?=
 =?utf-8?B?dzEzaW90T1hhalArWnY5WXhMN2ozaXpMWDA1ZnYrTHF5Y0VrTjAvZ1AzdDdm?=
 =?utf-8?B?NmxPUHNnV0kveFJpMFEzcXo4WDRwTHZtcmoybmY1QVgzU2NzaGUzc3c0SlQv?=
 =?utf-8?B?dUh1UG5jZDRhUWswUk9lQjg1TXIvdDlHOTRjTWU2UEE4VGloWVV5NmRDaXdI?=
 =?utf-8?B?aFdCOVJodXFNZ0ViMHFaOXJ6aE5aMGQzVzJwYWEwSjc1K2dMWVY0WHRvUmlG?=
 =?utf-8?B?WnBIcytvWkw0OThjTVdTTHNsQ0hwU09ncHllL2dKQ0NBR2Nxa2ZIbEQ5N1ZT?=
 =?utf-8?B?YkFpOW9FbXM0eG83OU1XeFZFZzdaY09SZG5GYi9zbHJJTXFjVUJ6N1lsR3hV?=
 =?utf-8?B?RUwzVE1mOFUrWHY4cmFZVElNbkEwakdoWER3MExQbDZheTdnUkdzOUR1SHVl?=
 =?utf-8?B?YnhHSWcyM2Z4Y1o2Y0h6UjdzU2FoTHZGV1kxUFMyK3Y2VWFFVUtBaWRUbm9I?=
 =?utf-8?B?YWRsaytaZ2N5ck9sdXBmQTVNQlNEQTJVb09PUkJ2alRTL3dSNXlrM1cweFM3?=
 =?utf-8?B?UWlxQlQweVdWU0xrTzRKM2lLaUpJQkg4TjczL1E1b3UrR2J5UEZSRiswMGUy?=
 =?utf-8?B?dXJMcnFaQjJ1VkdtbGhNVzVxbitCZEt6UU5pYi90dlZiNzN2VFRkNzYxQ0pr?=
 =?utf-8?B?RWhhRjdmTEVsakRRVmU3ZjlKeUlNUk16dW95R283aXhJMDdoTzA4a0htbjdP?=
 =?utf-8?B?VHFqMVFTSm40OUsvY0t4RW13ZHdBPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cfac3c-d26e-4a9c-1fe3-08deb71cf79c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 09:40:17.3939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/K9nfS9iTYxkxtfVA3ylbdJ44p5Gwdvhrtb5OxZAGepjzpN90b+sqQQtEVw8mOXuHtLLv3L5BEkAuI7DySi9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0670
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21081-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,DU8PR83MB0975.EURPRD83.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 7AF895A27FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBXZWQsIE1heSAxMywgMjAyNiBhdCAxMDoxNTowMVBNICswMDAwLCBMb25nIExpIHdyb3Rl
Og0KPiA+ID4gRnJvbTogU2hpcmF6IFNhbGVlbSA8c2hpcmF6c2FsZWVtQG1pY3Jvc29mdC5jb20+
DQo+ID4gPg0KPiA+ID4gUmVwbGFjZSBoYXJkY29kZWQgSUJfV0lEVEhfNFgvSUJfU1BFRURfRURS
IHdpdGgNCj4gaWJfZ2V0X2V0aF9zcGVlZCgpDQo+ID4gPiB0byByZXBvcnQgdGhlIGFjdHVhbCBs
aW5rIHNwZWVkIGluIG1hbmFfaWJfcXVlcnlfcG9ydCgpLg0KPiA+ID4NCj4gPiA+IEZpeGVzOiA0
YmRhMWQ1MzMyZWMgKCJSRE1BL21hbmFfaWI6IEltcGxlbWVudCBwb3J0IHBhcmFtZXRlcnMiKQ0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogU2hpcmF6IFNhbGVlbSA8c2hpcmF6c2FsZWVtQG1pY3Jvc29m
dC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLb25zdGFudGluIFRhcmFub3YgPGtvdGFyYW5v
dkBtaWNyb3NvZnQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3
L21hbmEvbWFpbi5jIHwgMyArLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9tYW5hL21haW4uYw0KPiA+ID4gYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFu
YS9tYWluLmMNCj4gPiA+IGluZGV4IGQ0ZGZiZWMuLjlhZjkyYTQgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYWluLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9ody9tYW5hL21haW4uYw0KPiA+ID4gQEAgLTYzMyw4ICs2MzMsNyBAQCBpbnQg
bWFuYV9pYl9xdWVyeV9wb3J0KHN0cnVjdCBpYl9kZXZpY2UgKmliZGV2LA0KPiA+ID4gdTMyIHBv
cnQsDQo+ID4gPiAgCQlwcm9wcy0+cGh5c19zdGF0ZSA9IElCX1BPUlRfUEhZU19TVEFURV9ESVNB
QkxFRDsNCj4gPiA+ICAJfQ0KPiA+ID4NCj4gPiA+IC0JcHJvcHMtPmFjdGl2ZV93aWR0aCA9IElC
X1dJRFRIXzRYOw0KPiA+ID4gLQlwcm9wcy0+YWN0aXZlX3NwZWVkID0gSUJfU1BFRURfRURSOw0K
PiA+ID4gKwlpYl9nZXRfZXRoX3NwZWVkKGliZGV2LCBwb3J0LCAmcHJvcHMtPmFjdGl2ZV9zcGVl
ZCwNCj4gPiA+ICsmcHJvcHMtPmFjdGl2ZV93aWR0aCk7DQo+ID4NCj4gPiBTaG91bGQgaXQgY2hl
Y2sgdGhlIHJldHVybiB2YWx1ZSwgdXNlIGRlZmF1bHQgdmFsdWVzIGFzIGZhbGxiYWNrPw0KPiAN
Cj4gU2hvdWxkIGl0IHBlcmZvcm0gdGhlIGNoZWNrPyBNYXliZS4NCj4gDQo+IFNob3VsZCBpdCBm
YWxsIGJhY2sgdG8gZGVmYXVsdCB2YWx1ZXM/IE5vLiBBIGZhaWx1cmUgYXQgdGhpcyBzdGFnZSBp
bmRpY2F0ZXMgdGhhdA0KPiB0aGUgZHJpdmVyIGlzIGZ1bmRhbWVudGFsbHkgYnJva2VuLiBUaGlz
IGlzIHdoeSBtYW55IGRyaXZlcnMgZG8gbm90IGJvdGhlcg0KPiBjaGVja2luZyB0aGUgcmV0dXJu
IHZhbHVlIGhlcmUuDQoNClRoYXQgaXMgbXkgdW5kZXJzdGFuZGluZyBhcyB3ZWxsLiBMZW9uLCBj
YW4gaXQgYmUgYWNjZXB0ZWQgYXMgaXMNCm9yIHNob3VsZCBJIHNlbmQgYSB2Mj8NCg0KVGhhbmtz
DQoNCj4gDQo+IFRoYW5rcw0KPiANCj4gPg0KPiA+IFNvbWV0aGluZyBsaWtlOg0KPiA+DQo+ID4g
ICAgcmV0ID0gaWJfZ2V0X2V0aF9zcGVlZChpYmRldiwgcG9ydCwgJnByb3BzLT5hY3RpdmVfc3Bl
ZWQsICZwcm9wcy0NCj4gPmFjdGl2ZV93aWR0aCk7DQo+ID4gICAgaWYgKHJldCkgew0KPiA+ICAg
ICAgICAgcHJvcHMtPmFjdGl2ZV93aWR0aCA9IElCX1dJRFRIXzRYOw0KPiA+ICAgICAgICAgcHJv
cHMtPmFjdGl2ZV9zcGVlZCA9IElCX1NQRUVEX0VEUjsNCj4gPiAgICB9DQo+ID4NCg==

