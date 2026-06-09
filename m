Return-Path: <linux-rdma+bounces-22016-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KTVDKgkOKGq19AIAu9opvQ
	(envelope-from <linux-rdma+bounces-22016-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 14:58:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A65796604FD
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 14:58:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=mKBZxrgC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22016-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22016-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E788F3090628
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A38C421EF8;
	Tue,  9 Jun 2026 12:48:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011070.outbound.protection.outlook.com [40.93.194.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4441931B;
	Tue,  9 Jun 2026 12:48:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009291; cv=fail; b=Ed6vnX6DHuqINb6ekS8sYRTkwtZeYNvc6CpojZcPJN/Y91sI6AEo7DNB9BKtyvjA4GSTThhIzvwC+sF6EenOzLiY8PSfR+T1BzlWUrZ8e/sGqxelDpI8NZvMbc77ugu4DO+HOzf2lClrP0ySXVPzTzHYnob0jI4ixY6JXqSQSoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009291; c=relaxed/simple;
	bh=6zKBvJyrYg40W+EfockhwQLri8KUNaQYpjoFzuuQCtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cgh/bzDPI9W0Ta8RDYpbxmN3EUWoAGL+SmK9CYh4OcLO1CypRIvWvSbAB5870EHaFiT4cnakE90ETKnRj921upyq3b2sz/JAtRtINsvOtTZ8QpxVaIHuCUpVAjrp7kBZOoViIog0H/FAkYbg2WfFfE+Na/H/UAt497h0yxmfJDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mKBZxrgC; arc=fail smtp.client-ip=40.93.194.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgA4OX8h2mYIyi4QltX+kTF+MbeaUaZlr6ExsFPMiPXzS9n/wnCPwYrg6DHPJlWrn0ldTUsg8/Mq1K5x05Gc4szg9Dj5PWjC14rGFIOvuKCmHDdXwkinUQL/nEEw8B4Mt568UHxv5Cy2qu/XPHEJuk7P/De0/fNpJZ/joctuhQ8BEWGAhS0L1gygl07VmA82bdquq1xq84aqOxuNjdN/LeMY8drfq02KY2VQlse19oZ/fBCdvoYmRmhrJHrvBopTbKmUHS0wh3ocPajsM9jf/64MjZ1G6oppu4PCyNsifPqCCQl/QydRVKryZXIu9YWoFP75Da0OqfZZIffX2xM7KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zKBvJyrYg40W+EfockhwQLri8KUNaQYpjoFzuuQCtk=;
 b=AVu+pF48Yct6hhd+sNK/xywbifbkvvR6Dw4HKkpvb+P4TbtBkW71p0ZvJl9a6v2yW0g5Dv+C6BqP2FZX/Tmq/8QM7UiglFO9wjFFWvymH3bR1CMb1gLQdg4XLT1H/QNyML9tcWMdzzQJHC8FMfVOh1s2hPi7zk0A7fiwI0nIWPYLY5u86KSMCJxYnD195xwPxtAjWvlwAxC1LbuHgBSt9tz7n+yrb+kBWeYa/CrNmPjCbQUhu8wTilzNjCcnjZTiXBCoNmH9RE+O8Ny+wids1i/WXoR46fVKuNG66sS+67fAEgxScofWQoEApANrJRdG32e3Ygz/N//QQxqOXnSImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zKBvJyrYg40W+EfockhwQLri8KUNaQYpjoFzuuQCtk=;
 b=mKBZxrgClW9B9srQQVTtdxn5dw/drbNaIJh/W5Sy3RsziXrKzro1TeA3yPjaeAVBWS+0Ot0G/ojGZCoGE0nHahqKC21I9qeZwYs869ZFlGSPPmW8yhPHcXBp2SJtwwoBsmlrm4lHEOkQa1hfAPwHJO65d/TU/H8YaeX0k+7WpIWLrPLtDzUYjKHVpc595qy64Wahw5Cz77fG1Ek1ZstcBEAxbMU5bLr56Cd27UQu+0I1m8Fdl5bIBvzQhgVRVhpYAQrETKUBiCtren8yBs/p0IAVLi1v5bk+f7UCMUxgCfGbynx3fhXaYzE2/Cltt5H4OsHyBHonJtbTQ+t8Juv3zA==
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 12:48:03 +0000
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6]) by SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6%2]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 12:48:03 +0000
From: Parav Pandit <parav@nvidia.com>
To: Edward Srouji <edwards@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Vlad Dumitrescu <vdumitrescu@nvidia.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rdma-next] RDMA/core: Fix broadcast address falsely
 detected as local
Thread-Topic: [PATCH rdma-next] RDMA/core: Fix broadcast address falsely
 detected as local
Thread-Index: AQHc+AGGjg5W0l093UWHeh9yBlMt6bY2LEVw
Date: Tue, 9 Jun 2026 12:48:03 +0000
Message-ID:
 <SJ0PR12MB6806CE63D4624023C760A115DC1D2@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <20260609-fix-rdma-resolve-addr-v1-1-449b8b4e6c09@nvidia.com>
In-Reply-To: <20260609-fix-rdma-resolve-addr-v1-1-449b8b4e6c09@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_|SA3PR12MB9160:EE_
x-ms-office365-filtering-correlation-id: 353a8e7d-8403-4722-c3bb-08dec6255887
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|6133799003|56012099006|11063799006|5023799004;
x-microsoft-antispam-message-info:
 7r5suu/Cj78a9vIjnfZTFn24tNWpXQROkeQGt7u5rrbon9fNWvEbKb2BBy0MNU61XUDynOmsR65a1XPczNXicDPQ4HspCmPQHYslF+loUSSE0xA5/5BSLFWVWSFrkr62BUZRvI1oQdhbZzcK2mVI1Hat48BpUKwff2r/dxlbVJVr4cbyzD51IlHkxpi00s36pzwXP3Ijv/m3dGNI7TzkP59bGcHqZ0UDJlq7I0901Ir69lZxWNAdWUJrlR6ZErgs6/rHWP8ZsZzfBoDHPyBV9B3/eRBavs2u8et5yRq5Nnbl1/Toi2StijEbnY/Ac71opiNUQTJnADHXPIwsrPziiNSNlujQI6xv86Zo7DOdkVrDXYeTGw4Ol1gxhcmKaheLd263aT2sx+tbxoLQSjpkODVNOKwoX4+A09EvGVDGsq070xb9rJH8r6yM2zSzVPFaE5Ne9OoGOssaLnutzYet4L7uYw8OFiHtncGt7XAGtWPkSLs5Vz1Td9enrBQKcIn+uSdIT0tmHalw1ahdqreT/HvxJGwJ1hiiPWwwvAsEnqlmHwPLlv3WSKsUR1TJVU21riphsLGQv/UVYCt7C6vvTS0JSTOawHxjgBAalAR6/KywF1bOYNnYR44joa03jFZm0NcE9w3xxb/jtJ+GrGC+9bkP5UaIcXXwX38XJAujiOp/W8wCFlY1lRa2Ha5wUYhfbsJqxN2EoqKoPIXas4dWVZHn7aCJ1Xfc7O4F3DjjNr4dcW6UMdBv1V01ENvFmnZ4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXlnN3lJamhkTWJiUVBtVk1VRFI2Z0tyRHJRWjZ6a21ic28zK3hteUNCWm5Y?=
 =?utf-8?B?QUw2WlVENmRSNmVJa2M3dllUSHBRSW9keElIZmJnOEtUejBHcGlTRE1JNVVI?=
 =?utf-8?B?Y2hWcDR0QVlielFGY3BQUS9MRVcxRTllNG1CODZwcWxzUGg4QzJDS01LZE5C?=
 =?utf-8?B?bU03R0dleVdWUnpRQXBmajVOVGJHM0tQem1FSU1CYzdEeDVRbjZCeXR3UHJG?=
 =?utf-8?B?aUxzNUQvUlQ1UlFFKzN0OHNEWFc0bHhwMDNKdnoxeEpRSUcyeThlbWFiaXNJ?=
 =?utf-8?B?NFBMVlFzWGcyb2k0WkpLeVhiUGphYzlSQWRscENmMUxwSkVLVkJ2enRxdHcy?=
 =?utf-8?B?WkpCWUY4ekJJcHdtbW9PWmVJVFpoS2tLbjlsNWVYeDg5SElLYW1QTmZkRWh0?=
 =?utf-8?B?M0pOdUJIZVNEcGpTbElVcFZNZFpKdlFydEVkbHZNTEdCaDcvNEVEb1drVVdv?=
 =?utf-8?B?ditVWWNJUFFDOWVOR0JKOThjR0daR05qOWtkcXJvU1ZURHdlelBLZjNlbUJC?=
 =?utf-8?B?MDdTT3BkWkFVSUQyNHlRSmNub0c0Z2VqUHplZmZSdXNWNXVNYkhaZXZaekda?=
 =?utf-8?B?NXFwRUlTWERjZ201QXhobTJScEI4L0lhN0ZvdisxNWhvN3o4ZVl5KzIwa2h4?=
 =?utf-8?B?cDlKSXU5dUk1ZEVqL1BKTWRTZWtmdURPYUplMlZ3TFJvS1dkUWNmMEN1QWpY?=
 =?utf-8?B?SVZJeU13NUNKOXMzNGJrWDV2RnJtdkxzN3VQYmdZSVZIVFRidnZ5bW5rWk9B?=
 =?utf-8?B?SjA4OGJCcXJCb0RUVVdoWEtCY203MU4wa292SFozY1lxRmxGakV2VjhZRFVw?=
 =?utf-8?B?U0pGeGhDeUtBckFLek5WMGd5a0JmZ0N1bW10dU9lbXVQOW12U2pud3Rpc1d4?=
 =?utf-8?B?WU16Z2VrVUl4dGRLNThmYzlHWTNoeWtkaWxJQVFpbTNRa0U3MDlEU29CZk1j?=
 =?utf-8?B?cUtJdWp5Y3k2b2hxcVBudUt4MEFtSEpaRFZMY0p3UzM3Z0FVS3V3bjNQWWpo?=
 =?utf-8?B?UmYrTXl1NDlSSk40SVJ1M0F6N1RkNnRZZjE4NkZLVmtsakhWVVdOelhFU3h4?=
 =?utf-8?B?MWlDM05DZEU3R042SVlxZlp3aXo2NCtBbi9UbEVDRDVzdlQ0VG9YT0VndnBv?=
 =?utf-8?B?Tm1zUG1SWlN6NnMreVd2VitCUVFEd0cxTlQzalh4Z2dOZ2hOS1JCN0FlSVo5?=
 =?utf-8?B?OGlqaHFpVTVIMjJ4Z0VQUngrQndvRk45a3c1S01DRm9xVmo2dEZwQVdjYlQ2?=
 =?utf-8?B?SlFJTGxBWnp1T1Yyem1kbmU0T1ZpNWhmbTBacmQwSjY3bk5RZHVyVVVJSWVQ?=
 =?utf-8?B?NmRWUkNWNGtKSGtwK1B6ZjJjVnlYQmhHeEY4U2labVNpUHFKMC9NVU50MVdk?=
 =?utf-8?B?YkRLaGpLVDBIci9qbnhOR2FBU1pxcnJuV1UrVVFUTHlISXRveHRWQjZ1dHpt?=
 =?utf-8?B?QUp2bWV5SFpSTnBWSzlVaE1WQjJKL0p5bmR2R1orS2dQZjN1NkNYM1VFS2t5?=
 =?utf-8?B?TjU0eFZnblBwdXM5d0pVc3BzMGlKUWkxczBaQWF3cHg2UjRUZS9WS0dtM1dW?=
 =?utf-8?B?cHo4TU9PajVFc1l3S3Y2TzJsNUlTYStWeHovajRtQVNOeStLdmNkS2I4MHIv?=
 =?utf-8?B?Y05nemgvaUlyOHFLd0I1L2J0SHRLKzVHQzF2ZDFZR3J3OVdqbmhOUzRIbUlF?=
 =?utf-8?B?Yjh0eWo5WFFXeDIrRUFycEViSy9wZHZFSWQ0TFAvY3lCLzBmOHhNUjVKUGVt?=
 =?utf-8?B?L0JTbUUvSmhTblZXNlROOFo0RTBtcVp0YmxVdDhWSHRrMCt6MVRCbUFNZlJB?=
 =?utf-8?B?bnRwOGhlZ1hScVd0b3ZPV2hnSi9nYnNkK3dZcjdNK2s1TGRKZXRxQ1IrbjJH?=
 =?utf-8?B?N0FKcG4za05ObU1lem8yOE4yMW8wMW02ei9jL1NSMmZPT0IzYlV6YnNLZnNY?=
 =?utf-8?B?TkFRenAvL21CNm1vOGRYYnpQT1l3azJGY1hYWjQzaXZsYk1YODhUTDlZeU51?=
 =?utf-8?B?VTVOdUlmOG9mN082bk00akFhdGdGRy85WGZ4MmJ1RzlLQWdWWGdPZW1NdVJw?=
 =?utf-8?B?dU11dXJsblQyOGZuWTUyTGc4Mm5xK1ZRV3NPakpVNEpnR1BzYUxmWjZGVkZR?=
 =?utf-8?B?Zy9JQlhaYnEwd0RXcEp3ZDNFK2Q5TFJMemxGbytIeWIreUxTZ2tLRDlMRklv?=
 =?utf-8?B?V1RhWjhNWlJDK2o5M21XbHQrbTcxalRjWUo3eDNEVkdCS2JVRXFSTDcwSUFs?=
 =?utf-8?B?Q095ODNkaUF3VDhBNy9TZEt2MGZqdWNQMWJUS0tUbis4bFNIWG00RXdzVm5I?=
 =?utf-8?Q?QIoiiYVXTdBd6UHEAe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6806.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353a8e7d-8403-4722-c3bb-08dec6255887
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 12:48:03.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjAtzAgG/Rq+jICY/nfE5TrM/OmIVDg2cDnnwuQA+dOLwxEagNDR6+/czrtJtme5jkOrw5X/1ylVB9jcMM1cwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22016-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[parav@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edwards@nvidia.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:vdumitrescu@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:msanalla@nvidia.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parav@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SJ0PR12MB6806.namprd12.prod.outlook.com:mid,nvidia.com:from_mime,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A65796604FD

DQo+IEZyb206IEVkd2FyZCBTcm91amkgPGVkd2FyZHNAbnZpZGlhLmNvbT4NCj4gU2VudDogMDkg
SnVuZSAyMDI2IDA0OjQ3IFBNDQo+IA0KPiBGcm9tOiBNYWhlciBTYW5hbGxhIDxtc2FuYWxsYUBu
dmlkaWEuY29tPg0KPiANCj4gV2hlbiByZG1hX3Jlc29sdmVfYWRkcigpIGlzIGludm9rZWQgd2l0
aCBhIGJyb2FkY2FzdCBkZXN0aW5hdGlvbiBvbiBhbg0KPiBJUG9JQiBpbnRlcmZhY2UsIGlzX2Rz
dF9sb2NhbCgpIGluc3BlY3RzIHRoZSByZXNvbHZlZCByb3V0ZSBhbmQNCj4gaW5jb3JyZWN0bHkg
Y29uY2x1ZGVzIHRoYXQgdGhlIGFkZHJlc3MgaXMgbG9jYWwuIEFzIGEgcmVzdWx0LCB0aGUNCj4g
cmVzb2x1dGlvbiBmYWlscyB3aXRoIC1FTk9ERVYuDQo+IFRoZSBpc3N1ZSBzdGVtcyBmcm9tIHVz
aW5nICcmJyB0byBjb21wYXJlIHJ0X3R5cGUgd2l0aCBSVE5fTE9DQUwuIFRoZQ0KPiBSVE5fKiB2
YWx1ZXMgZm9ybSBhIHNlcXVlbnRpYWwgZW51bSwgbm90IGEgYml0bWFzayAoUlROX0xPQ0FMPTIs
DQo+IFJUTl9CUk9BRENBU1Q9MykuIFRodXMsICJydF90eXBlICYgUlROX0xPQ0FMIiB5aWVsZHMg
YSBub24temVybyByZXN1bHQNCj4gZm9yIGEgYnJvYWRjYXN0IHJvdXRlIGFzIHdlbGwuDQo+IA0K
PiBSZXBsYWNlICcmJyB3aXRoICc9PScgd2hlbiBjb21wYXJpbmcgcnRfdHlwZSBhZ2FpbnN0IFJU
Tl9MT0NBTC4NCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiBjMzFl
NDAzOGM5N2YgKCJSRE1BL2NvcmU6IFVzZSByb3V0ZSBlbnRyeSBmbGFnIHRvIGRlY2lkZSBvbiBs
b29wYmFjayB0cmFmZmljIikNCj4gU2lnbmVkLW9mZi1ieTogTWFoZXIgU2FuYWxsYSA8bXNhbmFs
bGFAbnZpZGlhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFZsYWQgRHVtaXRyZXNjdSA8dmR1bWl0cmVz
Y3VAbnZpZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRWR3YXJkIFNyb3VqaSA8ZWR3YXJkc0Bu
dmlkaWEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2FkZHIuYyB8IDIg
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2FkZHIuYyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9jb3JlL2FkZHIuYw0KPiBpbmRleCA3ZTYyYjViMWZmYWEzNjRjZTA3MjBhMDkw
ODRiZWNhNWY0ZGI5NWE1Li5lOWZiN2FkNGMzNzdjZmU0NjA1YjEyZWQ0YjRiZTJlNWRiYTdlYjEz
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9hZGRyLmMNCj4gKysrIGIv
ZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvYWRkci5jDQo+IEBAIC00MzgsNyArNDM4LDcgQEAgc3Rh
dGljIGludCBhZGRyNl9yZXNvbHZlKHN0cnVjdCBzb2NrYWRkciAqc3JjX3NvY2ssDQo+ICBzdGF0
aWMgYm9vbCBpc19kc3RfbG9jYWwoY29uc3Qgc3RydWN0IGRzdF9lbnRyeSAqZHN0KQ0KPiAgew0K
PiAgCWlmIChkc3QtPm9wcy0+ZmFtaWx5ID09IEFGX0lORVQpDQo+IC0JCXJldHVybiAhIShkc3Rf
cnRhYmxlKGRzdCktPnJ0X3R5cGUgJiBSVE5fTE9DQUwpOw0KPiArCQlyZXR1cm4gZHN0X3J0YWJs
ZShkc3QpLT5ydF90eXBlID09IFJUTl9MT0NBTDsNCj4gIAllbHNlIGlmIChkc3QtPm9wcy0+ZmFt
aWx5ID09IEFGX0lORVQ2KQ0KPiAgCQlyZXR1cm4gISEoZHN0X3J0Nl9pbmZvKGRzdCktPnJ0Nmlf
ZmxhZ3MgJiBSVEZfTE9DQUwpOw0KPiAgCWVsc2UNCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDog
ZWE0ZjZmNmM1MzU3N2ZiM2YwNWRiZDc4YjE1ZTU4Njc3MmQ0OTgzMQ0KPiBjaGFuZ2UtaWQ6IDIw
MjYwNjA5LWZpeC1yZG1hLXJlc29sdmUtYWRkci0xY2U2MTUyNDhiNmENCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gLS0NCj4gRWR3YXJkIFNyb3VqaSA8ZWR3YXJkc0BudmlkaWEuY29tPg0KDQpSZXZp
ZXdlZC1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPg0K

