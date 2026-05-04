Return-Path: <linux-rdma+bounces-19932-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKVhNk29+Gnh0AIAu9opvQ
	(envelope-from <linux-rdma+bounces-19932-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 17:37:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FB24C0C7C
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 17:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 046F1301ABA4
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C98B3E0228;
	Mon,  4 May 2026 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmLpFBPF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6786C3A5E92
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909065; cv=fail; b=OwyxeVz8VZiQw/aMlGuHZQLzRDWotC7xFpSbQjrLtTvOSwNNY1MtFdNld4GEZyEZZeS76R2i+Dl9Q03pk6441b+DwmYKuw+jAfwO9o/dDVsSKsZ0eTRjhmAjG68h0Mg8iR04LkRcib+tD7DCObx7ac+J8VPuFVUvR6AZxhOsQ6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909065; c=relaxed/simple;
	bh=eO/ofjnizjyFGsBh5p4CRvCpkTFx9NDtXJxaw+XPaoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sKih8RUT4Nmqgmlt9z5neZV8yGaFWeaRL/eVe+ryr10cgIIDJFdNXEHG1vKtUf8fZDLFBgXMqyXIqgrnp8I4lk9X/ztJ/fRKXKr8wcDqsgKJli4pfogvPTy0tGnerLBU2OgqrbtaULwwbJhNQrJr0AjYpzsU4FFpUCLhBud7zug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DmLpFBPF; arc=fail smtp.client-ip=40.93.196.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnz+9b0DSliY5HW214l+h5ObovWtwubIAVFS37C/e5rZelbwT1JPl42JTg65G8JcoF9mEgH9QlTqSRUUZj+2qSqXM8AXb2zedbTl0JrjS8NbwzXgPLeKe8612l6TCL6n6DKOF+tarINZ/s+B0kxij0ZzHpqt4R7WFZPimDY3Xq1tcBAAMgI3xjlq7d+OW1SKb5SY6j58X1ujta5ojUGt5AuAIwaMFVF2ZHOBKXwhx4Xiy0tbSqmp2xvH55WR2d1+CW+2URq+4eMFFpMzAS0IPi2M7EXdGKF5z9jxK2OqK2CGUOiTn186oZkMBxUct2Ch+A7V7ACrFvdG1nT8j7n7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eO/ofjnizjyFGsBh5p4CRvCpkTFx9NDtXJxaw+XPaoE=;
 b=Ok+EVGn7uRx23+Yf6/dT+kYa751ZFr/THe3kPFmiLzibznK34NvMcGUd76Pvm9+fWicJskd66U+YU6LXxNglsPm4lnNqi5X98kOIYepPnqFyF9J4MAqk3asr0J8uN1As38m2zx9aLfQh1BKpg/lNRj0Mdt4khbP45xtf1xpPsWoorcc7VD5VAM92CH/PisXr4GgSBATWxMGt8ZehJVprLI/DN86pz8bf+8WjgYwNESF5CsxuJkrO9pLgGn3dVaLwehV9grOD1RalZy15u/vZVBrnjDO9DYeBsZV10d23IOhu5So70G494bY1Wu8mtn8AExnW0h7hiNyPjaSvXw95ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eO/ofjnizjyFGsBh5p4CRvCpkTFx9NDtXJxaw+XPaoE=;
 b=DmLpFBPF4ZeWAELQCq8KW0OEE6jkJnM1koBvJllLXkPyhktwQZ7s8QIM72WDr2oHLleLSXVV69+k+F7XeJBRmhJdeLSEIF7t+7ebpS44V3PrA/2tv/DBPmAjvNDufxLylrPlBJDu9EmmSUU0yCIipxPHeiX8/+rg743Krv++vLAtHDJnsLvb3CAeTfZuyG6pZ45i9MxFtI4Uy/h2gvHFNLuAbPzYkI3PCiduyOsS57UXs4RjW/MP64UGZae3JeWSq6HL5NEbk6a9KiDvTkLKoIBhxluhnUoKFbcXsOW4yoKGI/cuGRwgvFkSXB0DXCPeUR8BrbId0PoSgQJQVIY0QQ==
Received: from CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 15:37:35 +0000
Received: from CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::43a6:8d0:7081:65d7]) by CH8PR12MB9741.namprd12.prod.outlook.com
 ([fe80::43a6:8d0:7081:65d7%7]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 15:37:35 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Michael Margolin <mrgolin@amazon.com>
CC: Doug Ledford <doug.ledford@hpe.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "sleybo@amazon.com" <sleybo@amazon.com>,
	"matua@amazon.com" <matua@amazon.com>, "gal.pressman@linux.dev"
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: RE: [PATCH for-next v2 1/5] RDMA/core: Add Completion Counters
 support
Thread-Topic: [PATCH for-next v2 1/5] RDMA/core: Add Completion Counters
 support
Thread-Index:
 AQHczedSJ4Yfur41l0a1M+T0mYoZQLX22v0AgADAIICAAHLZAIAAHgIggAXBlICAAChkcA==
Date: Mon, 4 May 2026 15:37:35 +0000
Message-ID:
 <CH8PR12MB9741DCC8C4000459B793EC6FBD312@CH8PR12MB9741.namprd12.prod.outlook.com>
References: <20260416212327.18191-1-mrgolin@amazon.com>
 <20260416212327.18191-2-mrgolin@amazon.com>
 <2bfaa4cc-8e4f-43ad-a483-36ac1ae3caea@hpe.com>
 <20260430121833.GA30363@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <d3994658-d679-4205-8b59-a6888bcbc144@hpe.com>
 <CH8PR12MB9741AC2B68E736EC5D2C9C93BD352@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20260504125109.GA36751@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
In-Reply-To:
 <20260504125109.GA36751@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH8PR12MB9741:EE_|SN7PR12MB7249:EE_
x-ms-office365-filtering-correlation-id: bfffb3bc-fb94-44f4-34df-08dea9f310b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 lP6c57DwY5j/i2BWqucKFfd5yDqtMYhuwc/t1YWVI6v2lo5PUUWBoU4xftStW4iqATIXw0a61Ih96U7eA7d1ds4kSgrXKpUDuRoJZXLzwidqhWvjsrc3anSm6WI1rezfV9S8ePLrL9wXbG7N4NeY6wo5+ORgzXihUG75f5v0rTkharoJBqhsKhnZg+i1ztZcMC8mnxfSs+5GgkSLXmP6gFEBQw2sZqcXWNDZFAytHdSzjUc5I2OPPs0hsww42X2KZFGP91jh84c1+NUeLL3/Mhou0TpDnmfD9LZmBn5s4RyAZgLfYTaDgDVCcHUFbQK/U/TSQS+SFhiNFRAWNvolLncnsLKI2FinPdihNFC1V6IxD4MdxuNJzX560Ev/ik1j6ow3scYVSK1+QBu09wfVsYwnjAU+o8NOTABvmzNoRrh7LzMqN+WLcoikgB3O1TeEnKWxwbHm+iGb6vG9j3jCINaXUyAA090bdhk8roepC5NeDkMl28f+e6r+wxolcY9AiapYVaz9gpWfrvmzcj139m6UpjZTxBZD/XT7IsM8D4Dv8ovt0rpE7O8SlEOxdjwNIfOUDC9ludInXSE1f1jGwUIMzln8xMYoOzb9JmWA7UuMT7EOxYXjMPdqx1Fl0+c5EvfnvLuDNFw0XWfC/RSE2l7Syx8fOISHMasuYh6N6Kdr1TrXlc36WJReRhYLG6PF59OsI43sQ6nHi/1MGjVHK/zyLqMVc5plmF8s2gLpjWp5a8ybaCClbtwjqWs+j+eX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9741.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXFLTG14ZFhMWWhOMEJzWDFmY3RFYXhwbDl0dWpjbkpVZmRUT096ZlBpRmZI?=
 =?utf-8?B?MUtyMloycHR1UHBVYTNEMXhQc1BxeUZRSkhSS1NDdmZOaDB0ektlcFo2TUkx?=
 =?utf-8?B?bjF5QzIyd2xnenNmTGJBbGVINGZyV2pTMmNnQXVTQTN4MGROcHFqNUxrc29n?=
 =?utf-8?B?MDM1aVgyckRiRytUNG5VbmVHMXFXMWlaMVNnNmExcDMwSkVKYnd4V3ZHcjN4?=
 =?utf-8?B?K21sWkRKNi8yek1QTE1uVXpZdE5uRXFsNlZJSXhRTkYwcGhmazBTM1dIcGgy?=
 =?utf-8?B?MGcxYmFIQjJwS3RTU1ZFYVpiWEVzUlFKemhaWmxIaHFJV25YSTRuNzR1UVpI?=
 =?utf-8?B?OGZ6cFNDTVZIdUcwMEtIQnFxRi9qVmFvUEJhRDUvTGl6RzVnQWowSGUvWnNJ?=
 =?utf-8?B?T2VOUXl0Yi9GUDZtTzdNUHhCdkUyVEhIeTFwcjROaGFZRzVpcTZoY0NJcHAx?=
 =?utf-8?B?ZVU5M0kyV29OeVBETHYvQUp6eTFFSWd3QTJOOEpUUmpnZkVOWHRabEwzQWhC?=
 =?utf-8?B?Qndvb1JBZlRoMVR2dk5LTHVnQXZ6dEhic3JkN3ZWc3RCUnpIZGVyZmxTSlRt?=
 =?utf-8?B?RDJXTWd4Wm1aWVR2Z3RkdzdPd3RFcE41QS9RL1dtNlNyYVduRS9UdGpOdDJs?=
 =?utf-8?B?c0drQTFySXV6bUV6d3RhOGZQOWdtUElabTdUWXhoWCtIUGFhdXFka1RHVEZV?=
 =?utf-8?B?c1BLaFplNitBWHd2b3ROb1Q0N3dqSzByM2NtdkxhTW5ON3NNMzdXcGVqRTJ2?=
 =?utf-8?B?b0drZW4vL0s0RXFTQlE2aEpkSWZ2YzhER0o4MWpvRkIvOXVHcjRvNFRkZWNH?=
 =?utf-8?B?OThsYUxJVnFnczcxWkhTMlNjd3Z2cDZJczNuN2tSNDFMelJtY21mM0owdHVM?=
 =?utf-8?B?TmlDenZZT2JqUER0cDFvNGh5bmFidzZRZG9sbEtmMTVBM1Q1Rk9KR29yVG5v?=
 =?utf-8?B?YVI5T1MzcEY3RERZM2IxY1NIQjkrUHFxNGcvb2s0SGs4cE9RdStqcm5GMi9v?=
 =?utf-8?B?c2x0WlFCVUJDeU13MnRZRWVEMGNWdFZsaG5xL25ONTg4VngxVG1qcWxrYWRY?=
 =?utf-8?B?UHk0Yk5heWhBTG43b0IzUG1Ic0ZlRTZLUjUwWFR5ZU5RZkVQdFpvVlBsanZP?=
 =?utf-8?B?dnFXR1hDbWVpUHhYVmNselBzTmNzeU05ZDI4VW44aDc5OEpzbGY2NnJ2SWtZ?=
 =?utf-8?B?VCtJbWZ5ZHVTYkQ5VGFLaXdIOWFjWHkwcUJ6dWYxQko3WEthd2YyNm5WMURy?=
 =?utf-8?B?WjU0R0lGWDd6T3lxTXZUcmZoQU5EeHdjUHMzMzgxdS9jenhNd3ljWk96Y2lQ?=
 =?utf-8?B?V0ZEazNiQnhMQWswTFpTQlIzQU1tOWNYcC9ZeUt4bDFWRjRMM0ZBbElybW5L?=
 =?utf-8?B?TGpwVlNNVEtTR2ZiM0FHbURPQmhoTWZrS3IrNkFCeWJnNFFVYkNCTDBIMk1X?=
 =?utf-8?B?RHJmcEpMa1o0V1BVNVBnUEx2d2ExaWlMQTNNckwzdzBCRlBveTdCdE1SNTR3?=
 =?utf-8?B?YWx2Y1VEQXIwcGJNOE5DM3QrZnAvWHJkUUZIK1JCMW42bG8rSzVMaGFOeG5l?=
 =?utf-8?B?b05ua1BxU1BQSGJIUG05SXcvelJjMXl2QitZNDhvWHI1V1lOUFRLOUxFelZj?=
 =?utf-8?B?aEJUVmVTelJTMVNDa0xXZDhtU2ZEOWIycVBWNVhYU3FSQnJzNi8xVDlQUEl5?=
 =?utf-8?B?eXYyTE5qbDVhbjduUUI0VFVra0hyUmNPWkxlV0F2dVprYUNCQS9UdEgyMVJC?=
 =?utf-8?B?dUdRVDdQQUtiYVlnYWVaalZ4dlp3UnpYcEZKL3hKdzh3YlJnczdDK05wOTB1?=
 =?utf-8?B?WGRDN0hsYkcwOCtDWHNJTlN3S3orYVFvS0RsV1VtVlE1VTBLS0xHWlRNaURj?=
 =?utf-8?B?bWwwcFF1VnRTNDVEYjU0NFQ4RldKSTZTMVorL29UVVFuRWUyblpYcWZFNHAw?=
 =?utf-8?B?RXZCR1hzYldod1FZc2Ixa3lhdVQrTWtUVDh0ZEY0NDZUdFp0bEJPNzlZVG93?=
 =?utf-8?B?UWMwT2lzQWVTR2M4S0V6bzcrQjg0WlNIUG4vdlAwRkxKUndVcE94dEFETVF4?=
 =?utf-8?B?bWVOSXlnUDZvNEhBUU4vVGZaYmFPUEF6eEhzY2FNSjdWMkg4SUxscm9tL3Vt?=
 =?utf-8?B?ZGRnUVJlbERjYlIrMWxUVkkyVmxtcWlaemVXaFVtWE00SWZkYzZtMGJhOXpn?=
 =?utf-8?B?dmhCQ2hkK1hqYkRvMTZHT2ptYTZ6NmVJNFdxV0dneGQzSlpsMENEd2FQZE9y?=
 =?utf-8?B?OEZTR1JNVVhQa3NDVmNzSVhDVDNkWExhd2l3bDhJTW9NMVUwQ1doczhEUGVK?=
 =?utf-8?Q?uE8q1AZlOxb/dxVeyC?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfffb3bc-fb94-44f4-34df-08dea9f310b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 15:37:35.5143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ebcGQkg44GjXXCoZjc+09tiVzJGSFCu7DjQ9u82CNqQU3vmVJ8FYFKpGTdkmsdlJiigZ7Gb88N6ANizqUvGaWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
X-Rspamd-Queue-Id: 19FB24C0C7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19932-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shefty@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,CH8PR12MB9741.namprd12.prod.outlook.com:mid]

PiA+IERlZmluZSBjb3VudGVyIGdyb3VwOiAxIHRvIE4gY291bnRlcnMgdG8gc2l6ZSBYIChlLmcu
IHUzMiwgdTY0KQ0KPiA+DQo+ID4gMS4gQSBjb3VudGVyIGdyb3VwIGlzIGFzc29jaWF0ZWQgd2l0
aCBhIE1SIG9uIGNyZWF0aW9uLg0KPiA+IDIuIEEgZmx1c2ggb3BlcmF0aW9uIHdyaXRlcyAxIG9y
IG1vcmUgdmFsdWVzIGZyb20gYSBjb3VudGVyIGdyb3VwIHRvIHRoZSBNUi4NCj4gPiAgICBQcm92
aWRlciBmbHVzaGVzIHRoZSBlbnRpcmUgZ3JvdXAgb3Igc2VsZWN0aXZlbHkgZmx1c2hlcyAxIHZh
bHVlDQo+ID4gICAgRGVwZW5kcyBvbiBpbXBsZW1lbnRhdGlvbiBhbmQgaGlnaGVyLWxldmVsIFNX
IHNlbWFudGljDQo+ID4gICAgRmx1c2ggbWF5IGJlIGEgbm8tb3ANCj4gPiAzLiBGdXR1cmU6IGZs
dXNoIHRha2VzIHBhcmFtZXRlcnMgdG8gY29udHJvbCB3aGVuIHRoZSB3cml0ZSBpcyByZXF1aXJl
ZA0KPiA+ICAgIFRha2UtYXdheSBpcyB0aGF0IHRoZXNlIGFyZSBmbHVzaCBwYXJhbWV0ZXJzLCBu
b3QgY291bnRlcg0KPiA+IGF0dHJpYnV0ZXMNCj4gPg0KPiA+IEkgZXhwZWN0IGZsdXNoIHRvIGJl
IGhhbmRsZWQgYnkgdGhlIHVzZXJzcGFjZSB2ZXJicyBwcm92aWRlciwgc28gaXQgbWF5IG5vdCBu
ZWVkDQo+IGEga2VybmVsIEFCSSBhdCB0aGlzIHRpbWUgb3IgYmUgc3RhbmRhcmRpemVkLg0KPiA+
DQo+ID4NCj4gPiBBIGxpYmlidmVyYnMgQVBJIGFsaWduZWQgd2l0aCBsaWJmYWJyaWMgd291bGQg
bG9vayBsaWtlIHRoaXM6DQo+ID4NCj4gPiBEZWZpbmUgY29tcGxldGlvbiBjb3VudGVyOiBhIHN1
Y2Nlc3MgKyBlcnJvciBjb3VudGVyIHBhaXINCj4gPg0KPiA+IGlidl9jcmVhdGVfY29tcGNudHIo
Y3R4LCBhdHRyLCAmY250cikNCj4gPiBpYnZfcmVhZF9jbnRyKGNudHIsICZ2YWwpDQo+ID4gaWJ2
X3JlYWRfZXJyX2NudHIoY250ciwgJnZhbCkNCj4gPg0KPiA+IFRvIHN1cHBvcnQgZGlmZmVyZW50
IEhXLCBJIHdhcyBzdWdnZXN0aW5nIHRoZSBrZXJuZWwgdXNlIGEgZGlmZmVyZW50IGNvbnN0cnVj
dCwgYQ0KPiBjb3VudGVyIGdyb3VwIChwcmV2aW91c2x5IGNhbGxlZCBhIGNvdW50ZXIgYXJyYXkp
LiAgVGhlcmUncyBvbmx5IDEgTVIgcGVyIGNvdW50ZXINCj4gZ3JvdXAuICBJZiByZXF1aXJlZCwg
aXQgaXMgdGhlIHByb3ZpZGVyJ3MgcmVzcG9uc2liaWxpdHkgdG8gYWxsb2NhdGUgbXVsdGlwbGUg
Z3JvdXBzDQo+IGFuZCBwaWVjZSB0aGVtIHRvZ2V0aGVyIChKYXNvbidzIHN1Z2dlc3Rpb24pLg0K
PiA+DQo+ID4gVGhlIHJlYWRfY250cigpIEFQSSBzdWdnZXN0cyB0aGF0IHRoZSBwcm92aWRlciBv
d25zIHRoZSBNUiBmb3IgdGhlIGNvdW50ZXINCj4gZ3JvdXAuICBBbGxvd2luZyBkaXJlY3QgdXNl
ciBhY2Nlc3MgdG8gdGhlIE1SIGltcGxpZXMgdGhlIHVzZXIga25vd3MgaG93IHRvDQo+IGludGVy
cHJldCB0aGUgdmFsdWUocykgYmVpbmcgd3JpdHRlbiwgc28gSSBkb24ndCB0aGluayBhIHVzZXIg
cHJvdmlkZWQgTVIgbWFrZXMNCj4gc2Vuc2UuDQo+ID4NCj4gPiAtIFNlYW4NCj4gDQo+IEknbGwg
dHJ5IHRvIGFuc3dlciB5b3UgYm90aCBoZXJlLg0KPiANCj4gSSBmZWVsIGxpa2UgYSBsb3Qgb2Yg
dGhlIGNvbmZ1c2lvbiBjb21lcyBmcm9tIHRoZSBvcHRpb24gdG8gcGFzcyB1c2VyLXByb3ZpZGVk
DQo+IG1lbW9yeSBmb3IgY29tcGxldGlvbiBjb3VudGVyIHVzYWdlLiBBbHRob3VnaCB0aGlzIG9w
dGlvbiBkaWRuJ3QgZm9yY2UgYW55DQo+IHNwZWNpZmljIGRldmljZSBpbXBsZW1lbnRhdGlvbiBv
ciBkaWN0YXRlIGhvdy93aGVuIGNvdW50IHZhbHVlcyBhcmUgd3JpdHRlbiB0bw0KPiB0aGF0IG1l
bW9yeSwgSSd2ZSByZW1vdmVkIHRoaXMgc3VwcG9ydCBmcm9tIHRoZSBjb21tb24gbGliaWJ2ZXJi
cyBpbnRlcmZhY2UuDQo+IEFkZGl0aW9uYWxseSwgZm9sbG93aW5nIHRoZSBkaXNjdXNzaW9uIGlu
IFsxXSwgSSdtIGdvaW5nIHRvIG1vdmUgYnVmZmVyIGF0dHJpYnV0ZXMNCj4gYW5kIHVtZW0gb3du
ZXJzaGlwIHRvIGRyaXZlcnMgaW4gYSB3YXkgdGhhdCBjYW4gbGF0ZXIgYmUgY29udmVydGVkIHRv
IHVzZSBjb3JlDQo+IGhlbHBlcnMgb25jZSB3ZSBoYXZlIHRoZW0uDQo+IA0KPiBTaW1pbGFybHks
IGNvdW50ZXIgZmx1c2ggYW5kIHVwZGF0ZSBmcmVxdWVuY3kgaXNuJ3Qgc3VwcG9ydGVkIGJ5IGFs
bCBIVyB2ZW5kb3JzDQo+IChpbmNsdWRpbmcgRUZBKSwgYW5kIEkgZGlkbid0IHBsYW4gdG8gYWRk
IGl0IGF0IHRoaXMgc3RhZ2UuIFRoYXQgc2FpZCwgSSBkbyB3YW50IHRvDQo+IG1ha2Ugc3VyZSB3
ZSBhcmUgbm90IGNsb3NpbmcgdGhlIGRvb3Igb24gdGhvc2UgZmVhdHVyZXMgYW5kIHRoYXQgdGhl
IGludGVyZmFjZXMNCj4gY2FuIGJlIGV4dGVuZGVkIHRvIHN1cHBvcnQgdGhlbS4NCj4gDQo+IEhl
cmUncyBob3cgSSBzZWUgcG9zc2libGUgZnV0dXJlIGV4dGVuc2lvbnM6DQo+IA0KPiBBdCB0aGUg
Q29tcGxldGlvbiBDb3VudGVyIGxldmVsLCBhbiBvcHRpb25hbCBmbHVzaCBjb21tYW5kIGNhbiBi
ZSBhZGRlZCBhbmQNCj4gY2FuIHRyYW5zbGF0ZSB0byBhIG5vcCB3aGVuIG5vdCByZXF1aXJlZCBm
b3IgYSBnaXZlbiBIVy4NCj4gQXMgU2VhbiBzdWdnZXN0ZWQsIGl0IGNhbiB0YWtlIGFkZGl0aW9u
YWwgcGFyYW1zIG9yIGZsYWdzIHRvIGFsbG93IG1vcmUgZmluZS0NCj4gZ3JhaW5lZCBjb250cm9s
IG92ZXIgdGhlIG9wZXJhdGlvbi4NCj4gDQo+IElmIGZvciBwZXJmb3JtYW5jZSByZWFzb25zIG9u
ZSB3b3VsZCBsaWtlIHRvICJwbGFjZSIgbXVsdGlwbGUgQ29tcGxldGlvbg0KPiBDb3VudGVycyB0
b2dldGhlciBhbmQgZmx1c2ggdGhlaXIgdmFsdWVzIHdpdGggYSBzaW5nbGUgb3BlcmF0aW9uLCB3
ZSBjYW4gaW50cm9kdWNlDQo+IHRoZSBmb2xsb3dpbmcgaW50ZXJmYWNlOg0KPiANCj4gaWJ2X2Ny
ZWF0ZV9jb21wX2NudHJfZ3JvdXAoKQ0KPiBpYnZfZmx1c2hfY29tcF9jbnRyX2dyb3VwKCkNCj4g
DQo+IEFuZCBleHRlbmQgaWJ2X2NyZWF0ZV9jb21wX2NudHIoKSB3aXRoIGFuIG9wdGlvbmFsIGNv
bXBfY250cl9ncm91cCBwYXJhbS4NCj4gDQo+IEFzIEkgc2VlIGl0LCBhIHNpbmdsZSBDb21wbGV0
aW9uIENvdW50ZXIgaXMgYWx3YXlzIGEgcGFpciBvZiBzdWNjZXNzIGFuZCBlcnJvcg0KPiBjb3Vu
dHMuDQoNClRoaXMgaXMgdGhlIHNhbWUgYXMgSSB3YXMgZW52aXNpb25pbmcuICBBIGNvbXBsZXRp
b24gY291bnRlciBpcyBhbHdheXMgcHJlc2VudGVkIHRvIHRoZSBsaWJpYnZlcmJzIHVzZXIgYXMg
YSBwYWlyIG9mIGNvdW50ZXJzIC0gb25lIGZvciBzdWNjZXNzLCBhbm90aGVyIGZvciBlcnJvcnMu
DQoNClRoZSBkaWZmZXJlbmNlIGlzIHRoYXQgdGhlIGludGVyZmFjZSB0byB0aGUga2VybmVsIGlz
IGEgbW9yZSBnZW5lcmljIGNvdW50ZXIgZ3JvdXAuICBJdCBkb2Vzbid0IGtub3cgYW55dGhpbmcg
YWJvdXQgc3VjY2VzcyBvciBlcnJvciBjb3VudGVycy4gIEl0IGp1c3QgbmVlZHMgYSBzaXplLg0K
DQpFLmcuIHRoZSBFRkEgdmVyYnMgcHJvdmlkZXIgd291bGQgY3JlYXRlIDIgZ3JvdXBzLCBlYWNo
IGdyb3VwIHdpdGggb25seSAxIGNvdW50ZXIuICBFRkEgc2VsZWN0cyB3aGljaCBpcyB0aGUgc3Vj
Y2VzcyBjb3VudGVyLCB3aGljaCBpcyB0aGUgZXJyb3IsIGFuZCB1c2Vyc3BhY2Ugc3RpdGNoZXMg
dGhlbSB0b2dldGhlciB0byBwcmVzZW50IGFzIGEgY29tcGxldGlvbiBjb3VudGVyLiAgVGhlIENY
SSB2ZXJicyBwcm92aWRlciBjcmVhdGVzIDEgZ3JvdXAgd2l0aCAyIGNvdW50ZXJzLiAgT25lIGNv
dW50ZXIgdHJhY2tzIHN1Y2Nlc3MsIHRoZSBvdGhlciBlcnJvcnMuDQoNClRoZSBwbGFjaW5nIG9m
IG11bHRpcGxlIGluZGl2aWR1YWwgY291bnRlcnMgdG9nZXRoZXIgZG9lc24ndCB0YXJnZXQgcGVy
Zm9ybWFuY2UuICBJdCB0YXJnZXRzIHRoYXQgTklDcyBtYXkgaW1wbGVtZW50IHRoaXMgZGlmZmVy
ZW50bHkuICBTb21lIE5JQ3Mgc3RpdGNoIDIgaW5kZXBlbmRlbnQgY291bnRlcnMgdG9nZXRoZXIg
KHdoaWNoIGlzIHdoYXQgaXQgYXBwZWFycyBFRkEgaXMgZG9pbmcpLCBzb21lIGhhdmUgYSBzaW5n
bGUgY29uc3RydWN0IChDWEkpLiAgSSBkb24ndCB0aGluayB0aGUgcmRtYS1jb3JlIG5lZWRzIHRv
IGNhcmUgYWJvdXQgInN1Y2Nlc3MiIG9yICJlcnJvciIuICBJTU8sIGl0J3MgY29uY2VpdmFibGUg
dGhhdCBhIE5JQyBtaWdodCBuZWVkIHRvIG1lcmdlIG11bHRpcGxlIHN1Y2Nlc3MgY291bnRlcnMg
dG9nZXRoZXIgYmVjYXVzZSBpdCBjb3VudHMgc2VuZHMgYW5kIFJETUEgdHJhZmZpYyBzZXBhcmF0
ZWx5Lg0KDQotIFNlYW4NCg==

