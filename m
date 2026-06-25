Return-Path: <linux-rdma+bounces-22466-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o0MDAxntPGoNuggAu9opvQ
	(envelope-from <linux-rdma+bounces-22466-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 10:55:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4F86C3FF9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 10:55:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=OytNkegG;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22466-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22466-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 243AB301185F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0882838657D;
	Thu, 25 Jun 2026 08:55:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023088.outbound.protection.outlook.com [52.101.72.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D64386576;
	Thu, 25 Jun 2026 08:55:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377748; cv=fail; b=Tzxrdzc0jDAu7vuCA2aqFfeB/c3nXdZepiAQQA9LzwffbYLg59ryCVcEWB/N3IDeDBsW/JKA7BIxZxJysfc0sNv681cvKVFuflD/13DfwF9PoVuSiauoy9t5caVt0rmapHyuGwn27mkeVMHbwT7GFxvjAAvkrGKy1LEUwZxpteE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377748; c=relaxed/simple;
	bh=ivo5qUgP4lZSFlrZt7a82Mmo9DVAOw84T0rUJkXdYUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4a7A3oLOK/dF5rd+uUQfHhB5Gj6jkMDwFmTjVPrKY2DUDcrT2qGG9nrqXsH7RP44Lv+WF0XUEHaqWDRDh5oTbs+bI92RNEqiqjCKZFmhRbuwyK8EGjHWP9CqA4XjbhspMu+xJSVB+W/rCCoNa8v4PtU2qQoCahAIJ3cdIcAPqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=OytNkegG; arc=fail smtp.client-ip=52.101.72.88
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8QSBSuWvu7KuXnuZOiUF3eVLOzdh8pR7OiETAa8Shp2UHhfH3o00OL3tiY3+Z3PXdcr3TUCUEd6P70JLLaSpMVVlAZSf8CaZPxC3HpWDpJKFkQoo3BrjLD0fCF/j7ftmsqIZwLX9ZMlYVjReu/89BV/mU3xliuEKD8hSPYHr8TktNCEJUkjN115LSdllbhxis7Ecv6A41ZoPDsaZbG305mOMWguFFj73sAXHrIQuiqWer3OvCHvrBuGnzyapFP5LxCUoMVctb2ECMYnY9KDvqYeCIvPuu0QRlJRGQZ9bGwhjqnrWXalXD7rBlD1pSbipaGHabJAG0wrl8b+fBMIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivo5qUgP4lZSFlrZt7a82Mmo9DVAOw84T0rUJkXdYUM=;
 b=YS+Z6qlJzrmdSBH+YztzGq8+leC/PmsMFpAL0p3sH1lQriyzgKIDeB4WkQGFzp0Ul51YX5vtgS+Qhnsn+a8eGdOhECvGwn7+Z5laTmapUKCa8lWRXjXGOV6bf8xfW567C9VauJ94JZAFyGvY90vk7zpLLAayO77EOjkmW40PLBiKB+SAPkFpzpcMkneL9bkOqRYauo35+KxCj2DKv3XLkKxLq7hHGys2ZuuCGWo2Z/XcxQTyx6YGTzGRFn40SQBbtNc9LkOOnk0ugQK0P4fV8YxS/CsQ3iJk4lM0krVHkn2DZITYQBDC2BVxJuO7Hsa8cM3c/xISppRnW95bxv9uXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivo5qUgP4lZSFlrZt7a82Mmo9DVAOw84T0rUJkXdYUM=;
 b=OytNkegGj2pjDnPT6cR30pzERqeeRcBDssiaxT4L/p5KXCMg8SByMrWC9ZJ4YhxfiuA7W0eH+6sZ6rbXhdqrbweeWgG5Si8HJMJch7itEycTMS4YyedK0M2Bd4jAnZxcne/jgTJ2waK+jjLOkIRuzXfs7j5Ema3jPuTKio5tuzk=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by PA4PR83MB0550.EURPRD83.prod.outlook.com (2603:10a6:102:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.3; Thu, 25 Jun
 2026 08:55:40 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%4]) with mapi id 15.21.0181.005; Thu, 25 Jun 2026
 08:55:40 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Jacob Moroni <jmoroni@google.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: "shirazsaleem@microsoft.com" <shirazsaleem@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Adopt robust udata
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Adopt robust udata
Thread-Index: AQHdBIBlS5UItNcAuUukbs4ROQD26Q==
Date: Thu, 25 Jun 2026 08:55:39 +0000
Message-ID:
 <DU8PR83MB0975639D552898AC93801EEBB4EC2@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260623114444.1429042-1-kotaranov@linux.microsoft.com>
 <CAHYDg1RQ8vEMrKPoS3qHgtf5S+T1Wzrm=YuwdfzFEX3g22Ruhg@mail.gmail.com>
In-Reply-To:
 <CAHYDg1RQ8vEMrKPoS3qHgtf5S+T1Wzrm=YuwdfzFEX3g22Ruhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=19c16ef8-9b23-4434-90a5-c5b48887922b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-25T08:22:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|PA4PR83MB0550:EE_
x-ms-office365-filtering-correlation-id: 5d358e2d-dd90-46f9-3afb-08ded2978828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 9Gg/mjAHlfK6KWgyP+552d/m0P+0NVv+K+MKjsuq5p1YLfmio70ZCC5f5sznCr4+J7Jpbd69tXoFUKFG+HPErFUE+X5KuCR4uUOltYRro00CelpcW7CKjxIeTKyhr9eAHnRGV614AqXlC3CtqlGcY/lno0fzI7P6Mmo+4ZH8mYkssRGESHk4cZ/UG/EWw8s5yPy92IH8vJe9hAgURajQC7a/IrjwhwFhUYDvu4fJdBABd/1flMUzJ5NmIhQnKBEWQ2vk8X3QXBd6KYX5n4m6h8qywrWEu0RY7ipHKExQdL5DJPkXAAyvxgTa1vrqrjMdWkijpP00lUGlUP4OM5mgaRx8HjYDTuLQOMeOl74vw+C48j8fmI7JMLfxtMg8MgE8qOnbY3u+jU8ypLXVQXlVFpH/3OpY35cBiMo2p/vbVHETMxJ/BFVgFLnznc3amJXms3+uHy/Zgb/KaRt5svKQ9VLGTRiQzXDO1TiuQ9Y1OcgURbQOht5SXDKkikVVypkYTEIxgdLZYmoJpcMi+VyiM1lkURY0DyJTvNSFfrUMOea/H8k/wRXz0hRKR+12UNsWBfqazPESgfOQ+7bWEBzHPmCNOj/jrvGsn8uPUAF8CcvzsPULHnqWlbl3Q0Ndoa5jrzZLX5fnV+EKXthnCpAe/EIgFM8xo4SdCO71lkCVdlaLt0IxBXzEYEptdDiGZe49iXUzAHVUDuu3AG2gAbsfb+JiPGbFnrOBJr5ZiSt76tU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmRJQVpnQjZMNFpPNkFtUmpsQzdqbnIxNmhQSWhIMUtBZjBlL2JZOTVLb0Qy?=
 =?utf-8?B?U3A0WUovNk5OeFVud0lzSm8rUW1ITHBiY21TTWNWNTM0NmRtZi9jeFpGY0tj?=
 =?utf-8?B?S0RVZHN1aGErMVB3NTB2Ukl0VWJ1YTJOdlpacnVxZjZpczRSWHRSQytJNGs2?=
 =?utf-8?B?SDJxQnF0SDEwWVArT2VtMEdVNERFNHFWcXZJM1BDbC9McWlMUm15YzlMbHhm?=
 =?utf-8?B?eHAydWtGUU8zOVNSbWZMVWJqbW9FQVRDY01xN1cxSHpyWUYyLytxcThaR2VX?=
 =?utf-8?B?L3BoSmRYTDNQSzZWU0o4VENDcUNYeFpBZm9ETkFYc2lhbHh1bWVJby9oYmk1?=
 =?utf-8?B?OEloM3RtMmpvZmpIUmZZNlNJS3I4SExXSGNOc3NZT2tLcno5Rkl3ZEFPaWxl?=
 =?utf-8?B?NlJ1VTNucmt1NW9XU0M0bWEvaEwySzFxUFBlVnNZMDRRZVV6Mm12VWJwWFg3?=
 =?utf-8?B?ZmxqYmlvRTh2TGEyTklJbzZ2YUdTbzFvSFJWMURRajBRRklqRVFETk9qdzNS?=
 =?utf-8?B?NHVaSUZzVEo5MlhCbi9wNEdBanMva3JTNndITjFmQjFhSjRSenlSbytET0VB?=
 =?utf-8?B?RHlwcG52cXVHNUUxRUp5LzRJSzVoVmVMeXR4VG14V1VDaGloMkxZRVFUU1pC?=
 =?utf-8?B?UXBlekpMbmZWU2J3VXQrT1hXZERJWmZSTnFyb1dNdm42bEdFakhwV2cyS2ZD?=
 =?utf-8?B?dVQ5Mnd4UEszQ1VhMTg5SkhiSnh4SktnSmxFR0ZwU3g4ZlUwTmQrODMwc01H?=
 =?utf-8?B?YVh3NjR4ODh6Nk5RcUxOOExiYWZ0aVhBbXlYSDQ4bzJ4a08vekVSSVBrYkpl?=
 =?utf-8?B?dWQycHlKamdNbWw3TVNXbFdCeGVXUjlEdVhwOTN1MXpqYktSTXllaHNmQ3BN?=
 =?utf-8?B?ZThqeWxEbHBlaUN4RnVnWVF0YTRmZDIraktnQ1JITWQvaWxqakhpTERmMXBG?=
 =?utf-8?B?NmlHOURYbHB5MnhHVzVLcW00L1VYZVRUWTV2U1Q0UEcxMFFYV2lhenkrQmVY?=
 =?utf-8?B?WHk4QTgwSG9vVzdCZlVZQkEzYzRCeFZwVlBlS1Rxald1cVBuM3JlY1FvM1lw?=
 =?utf-8?B?c1gvdkJVSW9LNWYrUHJXMXhVTkZBeUxodXk2Z0pCT0t6QWpab1B2TnRZYVhU?=
 =?utf-8?B?Z3JmRVk2RnIwU2NPaG5WK2RSMU13R2lZOU9VVm8wK2piL0tIL3NOL0JtWFp4?=
 =?utf-8?B?ajB1SE1hSUdHd051UUhqd0czeWtRbkgrMXdKc2J6SzlwRmRtY1VPeE94TjBI?=
 =?utf-8?B?a3lyaHJvNHlJWDhnVUlLYUpHb1Y3THJteVpIL25scnlPTjBZay9EZUUvT0gz?=
 =?utf-8?B?S08wQ24vaU54Wkh5VW1iNDJpeDc2b1FnRGM0UHh0aEMzN2xpQmpuZWJzeTF1?=
 =?utf-8?B?Rk1BUkFDZEdUYS80T2tQZm1zTlJxRVZCWlBIV21VMHQyNzBwcVo1YjYxbVR6?=
 =?utf-8?B?WnRrcGJKTmVaTVlLVjgvQjl6K3VMUml5aDIrOXBZNW83UXlTR1hOY3ZScGd1?=
 =?utf-8?B?NWlHbkc2eXJPRkV3dERDZVZTUG9EOUwxVnN6RW8wTmFZZ0l0WHVPWWhXY0ox?=
 =?utf-8?B?c2VRcTUrdTVtZnpSRGJ2ajZkTm5hblhVVW9MRXV1NEdlTEFTMncvWGlJSk5l?=
 =?utf-8?B?OEtUTkY1eWhCV1V2dm9WN0FNN3lnbDhiUFkwREc2QnYvbFMxb3NpbXNockRL?=
 =?utf-8?B?dWJZTWZZNXo4TzVwUkJySytSdzNvU3Z5bGVRMXV1Y3pUWjMxNFkyNVozWDlS?=
 =?utf-8?B?NFVJRlBzbFhTb1FoelJCWGdYNi9DUDd3a0FLTzRzYUl5V1RDZm5rMlNpWXFI?=
 =?utf-8?B?YUxnT2g5MEdtZmU5NzJkYWgxVHkxYVdKRlZuMnZGaCtaMElEL1ViQlg4VE0x?=
 =?utf-8?B?QStVdktOVlBNdHFNVE5EVTFKYy9sRTFrV0JHb1ExK1RiNVlUeUdZOE5IVTBv?=
 =?utf-8?B?UGs3UnpWK09iTVE4ZjMrd3dreE12d1VKUHlLQkk1OFBBa1pLelBwS3VIMVZa?=
 =?utf-8?B?RkoxRjNBSFFsT1I1TEZoVURiZ0pxME9mZlc3STlRdTZvUWNuR0c5QkF4OUVR?=
 =?utf-8?B?QlhMT0h3cWpvTzYxRFNpd0ZReEN2Y3MvZXJWNVdQSDRHWXVlRSt1SDJEaTIy?=
 =?utf-8?B?TVEyaVhxTGpDNVZ5TWZZaVdvc29FaFc4ZkkwdERhZVNXdWJVRnlwMzV2blpT?=
 =?utf-8?B?UFF2ODBobTdiSUZHcmtiTFlQaVlmaVhUVk5kd2NrVEdlRUVDOWUwWkRjeDg1?=
 =?utf-8?B?TnlSQllmaXpEV1Q0L1NiZVRwMTN3PT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d358e2d-dd90-46f9-3afb-08ded2978828
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 08:55:39.9274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkqEpn+JQ3oIl4Oa56Y/fwD5UAN3PqZRh7IcbMALqw/rKKfxQkNB9j5+Q/F6+tg6j7cbtLOrNug7pTII5CZD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR83MB0550
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22466-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:kotaranov@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:longli@microsoft.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,DU8PR83MB0975.EURPRD83.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A4F86C3FF9

PiA+ICtzdHJ1Y3QgbWFuYV9pYl91Y3R4X3JlcSB7DQo+ID4gKyAgICAgICBfX2FsaWduZWRfdTY0
IGNsaWVudF9jYXBzMTsNCj4gPiArICAgICAgIF9fYWxpZ25lZF91NjQgY2xpZW50X2NhcHMyOw0K
PiA+ICsgICAgICAgX19hbGlnbmVkX3U2NCBjbGllbnRfY2FwczM7DQo+ID4gKyAgICAgICBfX2Fs
aWduZWRfdTY0IGNsaWVudF9jYXBzNDsNCj4gPiArICAgICAgIF9fYWxpZ25lZF91NjQgY29tcF9t
YXNrOw0KPiA+ICt9Ow0KPiA+ICsNCj4gDQo+IEkgYW0gY3VyaW91cyBhYm91dCB0aGUgYWRkaXRp
b24gb2YgdGhlc2UgdW51c2VkICJjbGllbnRfY2FwcyIgZmllbGRzLg0KPiANCj4gSSBndWVzcyB0
aGUgaWRlYSBpcyB0byBiZSBhYmxlIHRvIHJlamVjdCBvbGRlciBwcm92aWRlcnMgdGhhdCBsYWNr
IHN1cHBvcnQgZm9yDQo+IHNvbWUgbWFuZGF0b3J5IGZlYXR1cmUgaW4gdGhlIGZ1dHVyZSAtIGxp
a2UgaWYgYSBuZXcgSFcgdmFyaWFudCBicmVha3MgdGhlDQo+IGRlc2NyaXB0b3IgQUJJIG9yIHNv
bWV0aGluZyBhbmQgdGhlcmVmb3JlIHJlcXVpcmVzIGEgcHJvdmlkZXIgdXBkYXRlPw0KDQpOb3Qg
cmVhbGx5LiBUaGUgY2FwYWJpbGl0eSBiaXRzIHdpbGwgYmUgdXNlZCBmb3Igc2ltcGxlciBpbnRl
Z3JhdGlvbiBvZiBuZXcgZmVhdHVyZXMsDQphbmQgbm90IHRvIHJlamVjdCBvbGRlciBwcm92aWRl
cnMuIFRvIHJlamVjdCBhbiBvbGRlciBwcm92aWRlciwgSSBjb3VsZCB1c2UgdGhlIGFiaSB2ZXJz
aW9uLg0KDQo+IA0KPiBNeSBtYWluIHF1ZXN0aW9uIGlzOiBob3cgY29tZSB0aGV5IG5lZWQgdG8g
YmUgYWRkZWQgbm93IGFzIG9wcG9zZWQgdG8NCj4gZXh0ZW5kaW5nIHRoZSBzdHJ1Y3R1cmUgbGF0
ZXI/DQo+IA0KDQp0aGVzZSBjbGllbnQgY2FwcyBhbGxvdyBtYW5hX2liIHRvIGludGVncmF0ZSBl
YXNpZXIgY2xpZW50IHdpZGUgb3B0aW1pemF0aW9ucyBvciBmZWF0dXJlIGVuYWJsZW1lbnQuDQpP
bmNlIHdlIGhhdmUgc29tZSBpbXBvcnRhbnQgY29kZSBpbiB0aGUgcmRtYS1jb3JlIHRoYXQgdGhl
IGtlcm5lbCBzaG91bGQga25vdyBhYm91dCwgd2UgY2FuIGRlY2xhcmUgaXQNCmFzIGEgY2FwYWJp
bGl0eSBvZiBhIGNsaWVudCAobWVhbmluZyBhIGNsaWVudCBjYW4gZG8gYWRkaXRpb25hbGx5IFgp
LiBJbXBvcnRhbnQgYXNwZWN0IHRoYXQgdGhlIGNhcGFiaWxpdHkgaXMNCmFuIGFkZGl0aW9uLCBh
bmQgaXQgaXMgbm90IGEgbmV3IGJlaGF2aW9yIChtZWFuaW5nIGEgY2xpZW50IGlzIGJhY2t3YXJk
cyBjb21wYXRpYmxlKS4gU28gaXQgaXMgaGFuZHkgZm9yIGJ1Zw0KZml4ZXMgYW5kIG5ldyBmZWF0
dXJlcywgcmF0aGVyIHRoYW4gb3ZlcndoZWxtaW5nIG90aGVyIHVkYXRhIHJlcXVlc3RzIHZpYSBj
aGFpbmVkIGNoYW5nZXMuDQoNCkZvciBleGFtcGxlLCB0aGUgdXBjb21pbmcgcGF0Y2ggYWZ0ZXIg
dGhpcyBvbmUgaXMgdGhhdCBXUUVzIGluIHRoZSByZG1hLWNvcmUgd2lsbCBiZSBvZiBmaXhlZCBz
aXplLg0KVGhlIEhXIHN1cHBvcnRzIGFsbCBzaXplcywgYnV0IHRoZSBrbm93bGVkZ2UgdGhhdCBh
bGwgV1FFcyBhcmUgdGhlIHNhbWUgd2lsbCBhbGxvdyB0aGUgSFcgdG8gYXBwbHkgb3B0aW1pemF0
aW9ucy4NClNvLCB0aGlzIGZpeGVkIHNpemUgY2FuIGJlIGRlZmluZWQgYXMgYSBjYXBhYmlsaXR5
LiBUaGVuIGluIHRoZSBrZXJuZWwgY29kZSBmb3IgUVAgY3JlYXRpb24sIHdlIGNhbiBhZGQgSFcg
ZmxhZyBmcm9tIHRoZSBjbGllbnQNCmNhcGFiaWxpdHkgKHNvIGEgc2ltcGxlIGxpbmUgaW4gdGhl
IGtlcm5lbC4gMSkgaWYgdGhlIGNhcCBwcmVzZW50IHRoZW4gYWRkIGEgY2VydGFpbiBmbGFnIHRv
IEhXQykuDQpPdGhlcndpc2UsIHRoZSBjaGFuZ2Ugd291bGQgYmUgbW9yZSBjb21wbGV4OiBuZXcg
cmVzcG9uc2UgZm9yIGFsbG9jX3Vjb250ZXh0LCBhbmQgdGhlbiBuZXcgcmVxdWVzdCBmb3IgdmFy
aW91cyBxcCBjcmVhdGUuDQoNCkEgc2ltaWxhciBpZGVhIHdhcyBpbiBibnh0X3JlIChzZWUgQk5Y
VF9SRV9DT01QX01BU0tfUkVRX1VDTlRYX1BPVzJfU1VQUE9SVCBhbmQgdWN0eC0+Y21hc2spLA0K
YnV0IEkgdGhpbmsgdGhlcmUgd2FzIG1pc3VuZGVyc3RhbmRpbmcgYXMgdGhlIGNhcCBmaWVsZCB3
YXMgbmFtZWQgYXMgY29tcF9tYXNrIGFuZCBub3cgYm54dF9yZSBpcyBsb2NrZWQgdG8gMiBjYXBh
YmlsaXR5IGJpdHMuDQpBcyBpdCBpcyB0aGUgZmlyc3QgcmRtYS1jb3JlIGlvY3RsLCB0aGVyZSBp
cyBubyB3YXkgdG8ga25vdyB3aGljaCBjb21wX21hc2sgaXMgYWxsb3dlZC4gV2l0aCB0aGUgd2F2
ZSBvZiByb2J1c3QgdWRhdGEsDQpwcm92aWRlcnMgd2lsbCBiZSBsb2NrZWQgdG8gb25lIHVkYXRh
IHJlcXVlc3QgZm9ybWF0IGZvciBhbGxvY191Y29udGV4dCgpIHdpdGhvdXQgYSBjaGFuY2Ugb2Yg
ZXh0ZW5kaW5nLg0KVGhhdCBpcyB3aHksIEkgdHJ5IHRvIGludHJvZHVjZSB0aGUgaWRlYSBub3cu
DQoNCkFsbCBpbiBhbGwsIEkgYmVsaWV2ZSBpdCB3b3VsZCBiZSBiZW5lZmljaWFsIGZvciBrZXJu
ZWwgdG8gZ2V0IHNvbWUgaW5pdGlhbCBmZWVkYmFjayBmcm9tIHJkbWEtY29yZSwNCmFuZCBJIHRo
aW5rIGl0IHdhcyBhbiBpbml0aWFsIGdvYWwgb2YgaGF2aW5nIHVkYXRhIHJlcXVlc3QgaW4gYWxs
b2NfdWNvbnRleHQoKS4NCg0KLSBLb25zdGFudGluDQoNCj4gSSdtIG5vdCBwcm9wb3NpbmcgYW55
IGNoYW5nZXMsIGp1c3QgdHJ5aW5nIHRvIHVuZGVyc3RhbmQgdGhlIGludGVudC4NCj4gDQo+IFRo
YW5rcywNCj4gSmFrZQ0K

