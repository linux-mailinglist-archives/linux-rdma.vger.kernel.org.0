Return-Path: <linux-rdma+bounces-22994-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JDKaBk+2UGpq3wIAu9opvQ
	(envelope-from <linux-rdma+bounces-22994-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 11:07:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D138738D4F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 11:07:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=GUNibut8;
	dmarc=pass (policy=reject) header.from=microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22994-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22994-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56C9230C3F62
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6476B3B0AF7;
	Fri, 10 Jul 2026 08:54:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023126.outbound.protection.outlook.com [40.107.159.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81063C379C;
	Fri, 10 Jul 2026 08:54:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673649; cv=fail; b=m767RzzSyjPQBD5410r9qiwQUp3pxhV2b3N8qUyuDQudbatvkz5ABA+jEcWshv9+FCFrSrUsQwGToJ0mS+nQGrmt5fc98uPzXQp2Yt7NdDD4dyQ8BYysE6EpEFSfYoD+AGUaAneb5YsqE2gaBmCRdkKjBDcxaGEAKBbbXt/PkgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673649; c=relaxed/simple;
	bh=MxQo88DXrflwbLDF8lCBYn5QRM9BDHETezT3K3PQQOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EF9gIrjaHVtdy7uEqVwGfOMyGOst0cR+74kPW02re7w0bQ2mD2PftwauLIxMVP2txoPM1m9ZmPi638kZd8eFGNestkfxvLdiVHCvrg5LctdCH1ZJszusRBd/305uEE6srVgDbW+BwD6RVOdqCmLBuejvASB+AscYWvTtO62ufiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GUNibut8; arc=fail smtp.client-ip=40.107.159.126
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPexaU2KpuDBGx1Oq1tfB0AOi+Tma31RQlbRvsVlrKCpj+uKSmls4ksDGY4mD3Y/YHQBgbNQX7mJh2+4ogXyNyDgZymOJTbsU7nCmUJzhzXkdvWz79IjRPj+PcGGIHpt6j2VBFF8ITFspOWCB6IInQfPB1CDm1AUelm3CPy0jnsAjo8YJE/Xvo1ZX690T67hor/JV1GRF+Z4DswSBub1QNK8I7d2HLSJF15mtavAZ5n6FBmyEIeP+CsTt0QGD0bIF4upNVx0MYN9OBi6jyHx9nsW2oVYBrzE7/wjE+e1z/qc9MjqTFyctvPMyMYm9QcXYKtB/OifGAPvcxyDoAOKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxQo88DXrflwbLDF8lCBYn5QRM9BDHETezT3K3PQQOA=;
 b=BtWRX854ctBOnKW0+2nSg2st2beuuygY+TCNt76fxuPx4ELbnA1v4DbZU2B4I4u0ASJdXOeULJcjIfXu9EWD1rTjrN7juQZWVex6J4DTij3+VPmnGkuRGtZl/OzuKxdrqVfqFxpaEupNHe6vRclrx8vm98kar/6FjbvPbrPtsOkEdcwYv5IjXio7IJs9ZAhFwnIDxbu+t9Oi/m6O6KAWWOeMe9wMm1JIKJtxGJrRWp3gIPGqyY/NZFe5ulxHrAbTL3JciElY8hGiuThPIXnKMa/v1M9mxP191bxlsaNlDU0Uc/vdCzrM65hMT3dNRd1WPlDXJTbN0LzSCvKmZ0pJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxQo88DXrflwbLDF8lCBYn5QRM9BDHETezT3K3PQQOA=;
 b=GUNibut83tkmSkaIw3Xo8sPesRdC6RQMwIrjIBo4QOXe4YUUX1sImcQT61m3cHRjc7zAmNN7yVW0KtQaeReQMx/MZ+xrLF2xvwniTxhh4Bs9everh2+oNXjnx6CiRKCKoU5R5v6GzsU19wWdUSG615EMRXfGHo11TPcrHqUOPPw=
Received: from PAWPR83MB0984.EURPRD83.prod.outlook.com (2603:10a6:102:4cb::22)
 by DU5PR83MB0639.EURPRD83.prod.outlook.com (2603:10a6:10:522::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.5; Fri, 10 Jul
 2026 08:54:03 +0000
Received: from PAWPR83MB0984.EURPRD83.prod.outlook.com
 ([fe80::3503:1b57:6b00:4866]) by PAWPR83MB0984.EURPRD83.prod.outlook.com
 ([fe80::3503:1b57:6b00:4866%3]) with mapi id 15.21.0223.003; Fri, 10 Jul 2026
 08:54:03 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: "shirazsaleem@microsoft.com" <shirazsaleem@microsoft.com>, Long Li
	<longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Adopt robust udata
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Adopt robust udata
Thread-Index: AQHdEEmod1vq945YW06YXy1SZDndFQ==
Date: Fri, 10 Jul 2026 08:54:03 +0000
Message-ID:
 <PAWPR83MB0984EFB0540738E4393837BEB4FD2@PAWPR83MB0984.EURPRD83.prod.outlook.com>
References: <20260623114444.1429042-1-kotaranov@linux.microsoft.com>
 <20260702180158.GU7525@ziepe.ca>
In-Reply-To: <20260702180158.GU7525@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0b9358bf-8990-4f11-92b8-a745026f0486;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-07-10T08:45:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR83MB0984:EE_|DU5PR83MB0639:EE_
x-ms-office365-filtering-correlation-id: a5eed801-b0cd-43a6-7d00-08dede60ca9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|3023799007|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 zU1InDT8SWNXBzoIrVlOE/fyZufIM6Ii5Dqyf4UUzm+e2FRKs7mMQk/GTNbRJyI1Qaxd+c+kXphC4+sbXgzvwn88Xd+MSTerjANhv0h6XQ/tJpoCeX8lJJ/ZnKBMsRf1XjnnpHFPY6U02WnCh702aYF+lbLMiuUHiDSJJPH1KOcovSx/UMvWEtFTiYtkD953H24GeuUHOf3ziTIJLX2PXOiaVRll2iHjAGHHmG4g8T88aZ5YExkvPVZj2Tz3JzxSazr8KGytGNHe61uxBlO+Shb5fHvxUn/btFy6bSGnQI7jos4KaPrliS6wUfPzlVCylAP7SaTH2nfiHQVF/m/X1YxwRbHCgZDvHA/rg0KC0UQ+mdHAlykgV0uxXjEn7aDj6Ckf5EPgdbv8ryFlJufnR0s+4fCuLSkoP2Gg0bUy1B4FwqpkKFBtxv9YRa+YaA5Qn93tgVIDDGDylWGFVBf5bPjvpqX4X2kEf4gu6oJSFfojYtSteA+ya+IPXMFNNxZKk5wF8rg7G5qyw1x1b2GKug9I+XL5BWJdOJ8CniJS/9LQ179Gf5R/eRbjZRSI6F180LF+0aO9b9XCEf39yTT58QozIl1aCkAYZ7mtxNDIsLovYh2p3pQYz0p15lWQv+Ce/tudFCi1pFhY6G17518YgaATqykoDHX31zIR5nF4rI9a2ewPP2AbCmaLW2+m3t82CI8+SazhhkN8uZ2FAFd1N+USdblcwVPiihMQg7XH3Gg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR83MB0984.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(3023799007)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZHZBR1dQd1dvblpWaGNSNE1vQkFBSE5LZ0IrTEsxR1JNZVZOdnFEMklnQ3Y4?=
 =?utf-8?B?VmNtV3VRMzhnV1c5NXVXZkZqamRFMTBJTEhCS3dhZEFCZ3FwVDY4b0d3ckhU?=
 =?utf-8?B?RFVZVXROWW90MUtaL041N1JEZFJ0Z2tQWVZ3SFRMbGY3emdpU0lWS2dYYWJE?=
 =?utf-8?B?NFpqNUJkWUVjaUI3WjlQZkxEVWxRQ2Z5aS9zUWRUeE5MbXhCSWQzN0dPYTJQ?=
 =?utf-8?B?YWRUaTF5UDJVenV3SHJvWVU3U3g1RlBOejRrQTh5THJPdGEvQmErNEJyekFG?=
 =?utf-8?B?WGl5OUE5SDVJTW55VEhiTDQ4Nmlna0srYjdnZlByWlZFVC91Q2N4VENsN3g2?=
 =?utf-8?B?bVlhdkhBUWNnYW43bHhIZEVON3dzMWZvSEV2anMxSXR3enNCcXBzVDR6UUZG?=
 =?utf-8?B?N0F2VjcySDN0Wm14ekJuajJVcFlQaytwM2ZYSWtTWVhoejFOV25COWpHVWpG?=
 =?utf-8?B?dzZ6NlI2VTVlRW5tRmRlU2xkS25ycmJZR1pIcGVlYjBUb2hYQVdyb25RRFFI?=
 =?utf-8?B?dWU2L0RpM0hFMnpPb0o0dktOQ2kxcFZ5MHJsVDlEMFF5dS9NbmFYVDdSTy8z?=
 =?utf-8?B?bVFBVnlzTEo3KzhTcXJYbTRVR3ZMWU4vQ2lRU1M5aDJtZGxmbkllaUxmUkoz?=
 =?utf-8?B?R3liUzJCWVcyeWZLWmU2ME1rSnlzM0Z0TmhNUksvNXlxY1lQZ1VFYkZMeU5E?=
 =?utf-8?B?U09naHZxZnpEVmx0Zkt0dEFCcDlUZkFlNzdyVzFQdC94eHZNR2Mzb2xSZ2JE?=
 =?utf-8?B?S0llODQxQjdIZzduQzlRLzJ5YmJRbnhFYVU0Wjk4dUJINGpEbTZ2aTlKMGRi?=
 =?utf-8?B?aXlLOGxDY3hYd0JTMUZzenNKMHFwZ25ya3k3QjM0cmVPU1Fwb0R6SkhBamVH?=
 =?utf-8?B?UG9lb1JmM3FCMVZDeUdRSGhodHd6SWRFU0hrYWNUcWoxOXJhQTkvQmJmdFZP?=
 =?utf-8?B?Mkp6NlZpN0IwakpIa1E4V1VxQWMxQzl0VkhqcS9BSjcrd3dkQ3hHYlZZZHZV?=
 =?utf-8?B?TlZ1NEFjUFBhME1xVVUxaEFIdUh5bzdDV3RGVXd2c1JobS9kdUJ3SHpWd1VE?=
 =?utf-8?B?VUtKVG1zMnU3Q01BSnVjV0E3UE1MOXVlSThwaFJMSnBXZXRkcHY2enZmeFJQ?=
 =?utf-8?B?R1JSNnRPSjAxck1KWHFTTGs0MGZXcG53Y29sVUdLNk1NaHVrQm1qZ0pNZEpV?=
 =?utf-8?B?LzBYVnFCVTJQMVdObFFoYkhKcFlYUnZmZHVIZUtUSUZFTmN0Z0NtRGJPZHZL?=
 =?utf-8?B?QWNxTUVJd0NMQXRRTmpMMnNld3RPbUMwQUZZTThvZ1B3NWVBVlFjdWRQbkJ1?=
 =?utf-8?B?LzUrWk9sRHIwVUVHRlZFUStMN1M3OThmQ0Z6S3dpRGM3dlJveG9nSlpBNWQ3?=
 =?utf-8?B?bTAxNTg5cFRJSjJkUm1HZExCMjc4OVF4VEN2NVR4M3g4a1Iwckp0WkdzLzky?=
 =?utf-8?B?RnQ0YmtFSDJJbXo3Wnh3a0NTNVo0RjRPUWc0RXkzd2FKTFNRR3pNZTB6eWJx?=
 =?utf-8?B?ZUUyTHdQbjVhTWtGMjRBSTdFcEtoMUFhTHgxOU9Tb2FTMnlQQW5CenE1TzhQ?=
 =?utf-8?B?Yzg2MkFJd1p3TGptOVd2UWtBc3hYVjdXNWYwUEF1YU5pQU42YnBPMGdmMjQ2?=
 =?utf-8?B?emExU28yZ3MxQlhTNUMyc0FucmljTFU5RW5UMnBNV1ROOG0vYVIvaDlTR3pR?=
 =?utf-8?B?aC9Tb011SnVuL0Q2TlBnelp3UC9rV01sQ2s1R1hxdFJ3SVVOS3NXcEQ1SWtE?=
 =?utf-8?B?TFRXcldOUWlKQm1PdUVFZlAvd3llWmVVSGRoMnZ3UlpuZXQ3SGNzV3hzU2dT?=
 =?utf-8?B?czJwT1JEZHplS0ZKWmRXQkNjYnBoZmNRK05oUjZyNmpMUTVUT0Q3Q1BkQm5B?=
 =?utf-8?B?SlZ2ZXZIbDlvaXZXUVlIREV6R2p4WGhTZHNnajZGWFhTYitMK2lvdFJVa1Vl?=
 =?utf-8?B?emxIYSt1K1VYS2JGYitZa3VxVnlrdEZMem1qTFNibDd1MXY0Rit1ZXdaUTNH?=
 =?utf-8?B?eUwyUWowWm1xWXJlbGw3M2JCUEhEREV6cDlkd2lFUXJPR0t5a0tHaDVtRWJZ?=
 =?utf-8?B?NVhRT0haaUd2NzJCNHBOeEN3TFM0dzg0cGt4ZkFWMnZiOWpuNzZXUllWWVN4?=
 =?utf-8?B?ZGxUUVdvUkV1QUp4OTk1ZXZTUGxpV2FFcDBqQi8xbzBKeTNRYU1XYXJ2M2h3?=
 =?utf-8?Q?jUL6hWTbT1y7SyT+YvrhM0vXNT+/HtvRmKIb5cP4plZ9?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAWPR83MB0984.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5eed801-b0cd-43a6-7d00-08dede60ca9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 08:54:03.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AKcypAoCdARbLw2rC5E+FSzpxyC1xCIg0o4xNz1xwOwR5bwnmNq0HCTT6YCPp67D+BYqY3Ow8n8q6dzE6HAXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR83MB0639
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22994-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:kotaranov@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:longli@microsoft.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,PAWPR83MB0984.EURPRD83.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D138738D4F

DQo+IE9uIFR1ZSwgSnVuIDIzLCAyMDI2IGF0IDA0OjQ0OjQzQU0gLTA3MDAsIEtvbnN0YW50aW4g
VGFyYW5vdiB3cm90ZToNCj4gDQo+ID4gK3N0cnVjdCBtYW5hX2liX3VjdHhfcmVxIHsNCj4gPiAr
CV9fYWxpZ25lZF91NjQgY2xpZW50X2NhcHMxOw0KPiA+ICsJX19hbGlnbmVkX3U2NCBjbGllbnRf
Y2FwczI7DQo+ID4gKwlfX2FsaWduZWRfdTY0IGNsaWVudF9jYXBzMzsNCj4gPiArCV9fYWxpZ25l
ZF91NjQgY2xpZW50X2NhcHM0Ow0KPiA+ICsJX19hbGlnbmVkX3U2NCBjb21wX21hc2s7DQo+ID4g
K307DQo+IA0KPiBJIHRoaW5rIEphY29iIGhhcyBpdCByaWdodCwgVGhpcyBpcyBsb29raW5nIHBy
ZXR0eSBncm9zcy4NCj4gDQoNCkphc29uLCBJIHNlbnQgYSByZXNwb25zZSB0byBKYWNvYiBlYXJs
aWVyLiBJIGFtIG5vdCBzdXJlIHlvdSBzYXcgaXQuDQpUaGUgcHJvYmxlbSBvZiBlbmZvcmNpbmcg
cm9idXN0IHVkYXRhIG9uIGFsbG9jIHVzZXIgY29udGV4dCBpcyB0aGF0IGl0IGJsb2Nrcw0KYW55
IGZ1dHVyZSBhZGRpdGlvbnMgdG8gdGhlIHJlcXVlc3QuIFNpbmNlIGl0IGlzIHRoZSBmaXJzdCBJ
T0NUTCB0aGVyZSBpcyBubyB3YXkNCnRvIG5lZ290aWF0ZSB0aGUgcmVxdWVzdCBmb3JtYXQuIEFu
ZCB0aGF0IGlzIHdoeSBJIHdhbnRlZCB0byByZXNlcnZlIHNvbWUgZmllbGRzIG5vdy4NCg0KPiBJ
ZiB5b3Ugd2FudCBzdWNoIGEgY29tcGxleCBwcm90b2NvbCB0aGVuIHVzZSB0aGUgbmV3IGlvY3Rs
IGZvcm1hdCBhbmQNCj4gZGVjbGFyZSBzZW5zaWJsZSBkcml2ZXIgc3BlY2lmaWMgYXR0cmlidXRl
cy4gTm9ib2R5IGhhcyBjb252ZXJ0ZWQNCj4gYWxsb2NfdWNvbnRleHQgeWV0LCBidXQgdGhhdCBp
cyB1c3VhbGx5IG5vdCBoYXJkIHRvIGRvLg0KDQpJIGhhdmUgYSBxdWVzdGlvbi4gSWYgSSBhZGQg
bm93IGliX2lzX3VkYXRhX2luX2VtcHR5KCkgdG8gYWxsb2MgdXNlciBjb250ZXh0LCB3b3VsZCBJ
IGJlIGFibGUgdG8NCmFkb3B0IG5ldyBpb2N0bCBmb3JtYXQgYW5kIGV4dGVuZCB0aGUgdWRhdGEg
Zm9yIGFsbG9jIHVzZXIgY29udGV4dD8NCg0KS29uc3RhbnRpbg0KDQo+IA0KPiBUaGVuIHlvdSBj
YW4gdXNlIHRoZSBleGlzdGluZyBtYW5kYXRvcnkvb3B0aW9uYWwgc2NoZW1lcyB0byBwYXNzIHdo
YXRldmVyDQo+IGlzIGFwcHJvcHJpYXRlIHdpdGggZnVsbCBlYXN5IGNvbXBhdC4NCj4gDQo+IFNv
IG1heWJlIHNwbGl0IHRoaXMgcGFydCBvdXQsIHRoZSByc3Qgb2YgdGhlIHVkYXRhIGZpZGRsaW5n
IGxvb2tzIE9LDQo+IA0KPiBKYXNvbg0K

