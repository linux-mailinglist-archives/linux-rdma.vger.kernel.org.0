Return-Path: <linux-rdma+bounces-3884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BE79327B8
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 15:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0A91C226CA
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2024 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0709219ADBA;
	Tue, 16 Jul 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Uw1xVhdU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2132.outbound.protection.outlook.com [40.107.21.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF98197A72;
	Tue, 16 Jul 2024 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137375; cv=fail; b=NuiVHwecs4dBbwkP+SnHCm9h81PTl4EKyUgTKSiUSDfWQFhjmS2Ov3UXoIqt0qg/773XbFrzfrQpX5XQ8nnqpKpfjtRpbTJAGf9D5HKU78NWZQFDwzo9t2kuBaU2cdv61kDae1Gv5sUml1uBaGmdIJijLWoKCnGY+U6UDmgCElE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137375; c=relaxed/simple;
	bh=i2nn8D80gM2x96WQRI3lYFkqipli4uiJfgbmfFj2rQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IB8h1mo8VUpwPeCLyW9pNLCAsvU5B4JAZMaWS6jvaWE0XXfSoE53GSL/OWR66QJRcXL5GfXpv+JSuzDW7T2eJ52xbjnX1a78ns9DxIK4JheUezC7cIaoYy0mVdL38rArICS0iERCpLIyOhR1D6tvz7eq9FBZ82b5A5CTQ6LJVas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Uw1xVhdU; arc=fail smtp.client-ip=40.107.21.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFBQw+m5JZj2qY4lMuN2wV9OmAT9tQAs8dvOpY9TL9Kw0g2+YjkY5ZO8KnWoSQDnHm7eysp10UdWtoCiJwMD6S84YE3p9s+75/DGmYw50GMmbXA5LH1ghVQMxE8Sk6JDJRg7mcxqKAyXLlIQefupX3tWalq4gLcDe/SJDlePX2BMaIPgtszRjhm1ebF/9jk2bxqP4hFpCWNh1Jl2GeEdyMisQL1qnyqOcqz/yuPPwlmJ+EO8yGpszS7cDIb/7UqQ33JuwujkCC+MGSxFBhgq4EhPHlkaTfhmIbfqopJ43M/3LJO+ji6tgATjp3CaCG7h7qIWNPYp+6oLni3Rop0H3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2nn8D80gM2x96WQRI3lYFkqipli4uiJfgbmfFj2rQc=;
 b=h03PkZK+LEQBvnjXuCIf8pLUL5afSXhv7MAXr2TCsnS0YqO2kGItOu7HhWZbaas57LMScYXblkyy9HJJwUV2KJ6O8VMIuCeXgOQF3Z2sUTzgl9kYQJ98vXPzpMHJIm39S5cOufKZ86kjzdeWLvMHgBYFigGqZm92HE+NdHPNomT8i3H2f5RpBT92a3htsxsHqPQN5C2ph7vyts7/AndR7GkPf0U3HXtCdw45HZyeBNZIoX/H1WLV/ZAjS3eiCaNEcFykn0I8Czyww4uygskt4tpyolMsAQmP4N/IsEOgCA0Hxsr6Cb4SnqQUF2bKny/fINxCGHf+a4kdnIRvaEDwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2nn8D80gM2x96WQRI3lYFkqipli4uiJfgbmfFj2rQc=;
 b=Uw1xVhdUw9IQtER9EU53u1zxE8LhDkfARhF4nTdmKZq/wlewCFxEhUYzfzDdwFqykpUyVHFb+dYImVqK95u5nYAYiOWhS7+/E4peJ2iMPKwL+mLBg5NWex5mtK8qlt9OZoROHtGGR01MD7RL5Wpu18875HnHsFsenp4boK+spOg=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by DU4PR83MB0678.EURPRD83.prod.outlook.com (2603:10a6:10:55b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.5; Tue, 16 Jul
 2024 13:42:49 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7807.003; Tue, 16 Jul 2024
 13:42:49 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Wei Hu <weh@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, Long Li <longli@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that inline data is
 not supported
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: indicate that inline data is
 not supported
Thread-Index: AQHa14YMP1QXjMN4PkmBck2aoandKQ==
Date: Tue, 16 Jul 2024 13:42:49 +0000
Message-ID:
 <PAXPR83MB0559406ED7CCDAFC0CAEC63DB4A22@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1721126889-22770-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240716111441.GB5630@unreal>
In-Reply-To: <20240716111441.GB5630@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0480904b-3175-4e74-8f2f-7fa1faab90ac;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-16T13:30:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|DU4PR83MB0678:EE_
x-ms-office365-filtering-correlation-id: 56028618-6d07-4a1c-5789-08dca59d2ed9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c3hqTCtTd3ZEZ28yQVA1bGg2MWJzYjc2N3BXN3RycW93WlhZcEx3R3FIbDEz?=
 =?utf-8?B?eVBYTUdzU1BBTzhnZE5tMVhTL1ZTdjFJalYxa25xcmZHaG9RL0t5ZE5lY0Vs?=
 =?utf-8?B?WE5ZWll1NWUxbmIrN2JNaTF0cWVGM2ZjZ0lvSkZvaW9QM3M4SXBCZDhQVkRr?=
 =?utf-8?B?Y3JTTWtkLzlYcmdmcXpKeXZrL1F4ZW5IdkRoWnJBVjlocDhZYXJmeElVQWJl?=
 =?utf-8?B?alpkUDlYWUNMVjBPUmt1L3dBWWRhV2Z2TW1iUGFoMmpJbXpsZnFkMzBuNnZX?=
 =?utf-8?B?L2Z1WVl2djdoM3BQVkczaENnV2RWQnh4VnNUOHBTbnhEVisvR3RZNnErNHds?=
 =?utf-8?B?eTh4VlF1QUhqNTJKeFpocWRybFV6Q0JuK1ZWTVJPaGJlRmswUWl1c1R3bHFI?=
 =?utf-8?B?V3pHbi9Nd0ZNMms1OUtlbDI5U2t6MGpzSkdJbGY2WERHRDJlOFh0ci9YVkxX?=
 =?utf-8?B?TTB4T2VZZU1IOXZXVy9lTlozTnpXMDRxQ21lckh0NjN4UXdBdjR1Z0JYcThT?=
 =?utf-8?B?WE1jYXlXNGtRVDU1YzVIN2NseWtXcGh4NWp6L0FORVdsQlE5VGd5Z0xuSnhu?=
 =?utf-8?B?RU1nRHBCWUVNdHJSZTdVeDFnbU8zT2ZUaDVnWFNIVFJxY3ZCeDJuR1hySEwy?=
 =?utf-8?B?MnF6WXRIVmpIeGMzUWRUVXR6cVlRQk5HNFgyTERJaVdhZS8yK1ZoK1V1dllB?=
 =?utf-8?B?bmp2UjBwWUx3ekFuQURkMEdGV1Fwekl2ei95ald5VXpqUmNYMWZBSUVVbFNC?=
 =?utf-8?B?RE8xbWl2TlorVUtzTVZXWmw4ZE1vMlY5SGx4d1QyUVhMNkNqeUswbHRGeW94?=
 =?utf-8?B?eDVuSFE1YjRLK1dzeXpOV25OSndXVCs2VlJzZ1BjcjIzMGRnTVZFZjVRZWt5?=
 =?utf-8?B?ckwvSk9wd3gxcEtHKzdVT0dJV25FRzhzNmFnM29sc212YlBic2pSZitsR2xq?=
 =?utf-8?B?Qk05akwyZ01sYzBBd05GNVhoTnRFSCtJT0Rnb1VNSjZBUXhycWlKSi8zSHFy?=
 =?utf-8?B?bG83VWw4RVU1REFIRm5UcVVhR3hhUHdPUzR3YUx1NHRYaGJkbGprbVJSa0Vm?=
 =?utf-8?B?WU1hb0I0VjNtaXBTTlRjU2FIOGx1K0ZsL3d3Si82RmpTSFpaRkNVazBJbWtI?=
 =?utf-8?B?Mm80WHpVejZBZmxBc2tJbzhRWk5FZjJOOGNzcUpxd2g2VkdYRkVJNlZLd1dZ?=
 =?utf-8?B?YUdVcXBxTTR3MmY2ZzRjZWNiTjgxQ0hJbDJnNk50bkFjemxGSUVlOXNLV1Fu?=
 =?utf-8?B?aXJvYVhQZmJiUC9UZjhXRW9zSTBvYnhrcEtzWi9NU3A1K3lnNUFWYnJwQnVt?=
 =?utf-8?B?eGdNckhBUkVxMmhXNkVKb3d0VnY4TW53d2tlcllWZ1FxZTB1MDdRUVRTbUVi?=
 =?utf-8?B?R1M5VjMzbzh0V2JHZUx6Snlkb2d5azNpUUJDb3F4WWRkWE1PYnBVT2VZbmND?=
 =?utf-8?B?UDhiVDdCMHI3SkwrMkRxWCt6MlRZN1p6S1NwdnlBdWlnaGhzdGhBRHRyclIz?=
 =?utf-8?B?VTN2Q250TFFXTGJMMjhlai9wQ0RyaDIxc1hzRFRPYk9pcFN6ZzhxQlNuYXNP?=
 =?utf-8?B?Y2QrUE5GZnFTV0RLaTlBaW1yVDNMK0szd3RvK1hyOW8zam00OW52Y3lOakJG?=
 =?utf-8?B?L2VHOGtBcU9pZy9FNjEwM2k0ZnZUUTFXWk5ZbjhBaE04NHRzZ2VyRDlVOWtS?=
 =?utf-8?B?cnF6N2ZtUE5DaVBTUmFhWXcrb0JCenRiQWJrc1VRajlwMFhIQUdhMXlURmVv?=
 =?utf-8?B?eC9OTXdXdWFEQXU0d0FPenQ4bTJJbjlrQmloNlJydzRqdmloeW9nTnNRcDNN?=
 =?utf-8?B?SkZEQ0t3NUlQeUVlRUxVVnEzVDlreEZsdXBzaFRQOUhBN28wZUV3Y0ZLWk51?=
 =?utf-8?B?dVN6V1d6Qk5GZDhYR1lSNnhyMkFCdTZnRFRYMmh3Nkkvbmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkU4SVAxMXphREYzWlJBUksvYnhyaitPQjFSZ2RJK3BsQXJZNUZYZFV0OSt4?=
 =?utf-8?B?TDd1T0ZpTXkrbFkyMTNUdWNGQUJpUHlQdTJKTEZoQ2lYa1VIUFhsVzRSbkZs?=
 =?utf-8?B?akt5bkxTVVVYNnlVL1lyUTU4K0JtNFZ2K05oOGRMNU53UXo4TU0wbDRJMStT?=
 =?utf-8?B?eHFhQ0c1eWxJY0ZEQmJQamw1QzRyNmZPUnlEeC85TEtEUTNQVFVKYWd5UGRQ?=
 =?utf-8?B?bGV6c3NCbm4zV1BkbkVxa1lIWjJ2c3JpU3kxcnpVajRvTTJ2V08zQnpsWTlT?=
 =?utf-8?B?Ny9WdTFzRDIzK0hrNVVUeHo2RDZpOXZJNURTd2NlanhRc1RNQ3JSUkFiSjlw?=
 =?utf-8?B?ZlRGSkx5ZERXU3pOUDhzQysvbzZ4czZxMzNmTmN5aU41bUFlNlpvM1lmR2hZ?=
 =?utf-8?B?TlRncitPbnJkWmxjdzNZdm9ERFU3amx5eC8zeUhlaUhNVnZoWHFZUjVCZTVE?=
 =?utf-8?B?NFMvR0l1aTRWQXF1eEJOTGIzZ3doN3dGNng1eEsveGJTY1lSSXVqTDFxQU5w?=
 =?utf-8?B?QXlncVhqb29OMHpSSGk1elNQKzdraitRVXBZWlBmT20zdEZQR28yam95MmpY?=
 =?utf-8?B?aGRzWmFYS283cWhHVTlTM2lYTVlWQUI0WjlSYTFYbVl2UlZKMms1aXU1b3Y4?=
 =?utf-8?B?Z0tneDROamVTUmtScklGVHBZN2R1SVFJdVJKc2llTDZiLytOVC9OWUh6QkZV?=
 =?utf-8?B?OUNKc0ZMaUVMY0NHbk1zYWVTNC80TjhLQk9UMXh5MThzUDBYZFpPVmZVLzdm?=
 =?utf-8?B?L0ZCYTd3T0tSS2hGczZrVVRYYVRtMndZMkM3UHJ6VUhnMzltblVHbzRSS2pD?=
 =?utf-8?B?S0ZjMlRYU054MC9IVUhkMWdMR3pZbGpXRTNkZlQwZytReUxhcHBKTG1ORmxX?=
 =?utf-8?B?YW9UUDNJdUFvWW1WdlQrV2lyTjFYaU9OZWxxSWxyR2dEUHZySkEzV1VDMkVr?=
 =?utf-8?B?Z1VvbXh3dzFiNE5nZ2pWZjYxTkM4VGdRdy9oRW5iYm9KbE4vSDE0WUtpc2JK?=
 =?utf-8?B?bFNPZUU4YlF4a3JCR1YxbTFDOG1hR1Y3UG52Sk1BTlZ4OUx3Z2Y2aUVQT1Fj?=
 =?utf-8?B?SHRHYTlDY1FVcjNrVTdvSGNhZWlKYWVVZytvYjRLbGNiR0RwRVRZNGlxMi9C?=
 =?utf-8?B?QS9sKzZ2VUpXK2g5R3lzNHprazR1MmwyRXNUS3hMM3RoWjdsMFFVVXhDdDZP?=
 =?utf-8?B?cUdGK29lT2pXcFlUVUZQUTNYTm4wNHlESjFPbGNoWEJvbjZsQXh4SFVNeE0w?=
 =?utf-8?B?aFpWekdTZ0NhUEhkSkJEOFNNdGx4L2ZVdlpZR1IrUmtiR1RpTEJwTFBCNWRq?=
 =?utf-8?B?Mk1vRGpTZG1FcElqRWtFMDJLMHlra1VXK0hNZzZIZWxzSDJJYXY1UU02ZmZC?=
 =?utf-8?B?QjJtTXptUkFLeE1HOWt6cittMXZ1aTN1eWVEZDk4TmhBakdwbEEvM2tIWVFO?=
 =?utf-8?B?T0E5cExReUF2S3BuZ1ZERzhhak5YQ2tDRHpMQ1h0bFFScUFtaUJlSndWbnRm?=
 =?utf-8?B?YndYOUl1eHBaenA1djNHUCtYTFc4aWVhMDI1OElDeDVpRDlSbGNGcG5DSks2?=
 =?utf-8?B?d21nUkNjSkZ6c1EzTDJyanVMbEh1QUhVN3doZzZSR1d3SkllaGtMMitwQUt3?=
 =?utf-8?B?R1FCamhLWEZYeHVQQXVTMkh3a2NHeXI1K0NweHZnbnVQRE5xQmFFSCt5dHpu?=
 =?utf-8?B?eWZnZ0xFSFdQWjUzTG1iSGhCbHlyZEo1NnpwRklud2RkOUJLYlpqazNpSmkw?=
 =?utf-8?B?OTBSN3N4OHFYS1RXaXRBRVUzQ3pXcjZZWkhsZUgzSEwyKzJOcjZGUGUvVGFN?=
 =?utf-8?B?SWZtWGhVZWMxcEtqdjF4Y1cxTlQrcDkyQ1dsdTJ4UStBclRld2lOT2dHdkJR?=
 =?utf-8?B?Nm5vK3hXdldVWWpNU2hoR25TYVl0UnlsR0RHbzRmeENSSHF5SHZzbGowZ3lM?=
 =?utf-8?B?NlJDVHg1RXltaGhrU1RNdzlyajA2dFB3UXFJZnltV2g5WGwzM0ZmZW5MQVp0?=
 =?utf-8?B?dHNVZnoxNjY3UG5WTUNLVk0xdFhNbDJIUzY1VEZENUJzMVYyZUpiN3J5R2ZH?=
 =?utf-8?Q?p8Maov?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56028618-6d07-4a1c-5789-08dca59d2ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 13:42:49.3695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aS1cp3x//IakTK/3AOIfDZ7mkLCSaFK+jFyK0f8ZLmAwIJ+DCNMCzyQWfZZl/lFdpXUtvU38alOBeke9fTEMVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR83MB0678

PiA+IFNldCBtYXhfaW5saW5lX2RhdGEgdG8gemVybyBkdXJpbmcgUkMgUVAgY3JlYXRpb24uDQo+
ID4NCj4gPiBGaXhlczogZmRlZmI5MTg0OTYyICgiUkRNQS9tYW5hX2liOiBJbXBsZW1lbnQgdWFw
aSB0byBjcmVhdGUgYW5kDQo+ID4gZGVzdHJveSBSQyBRUCIpDQo+ID4gU2lnbmVkLW9mZi1ieTog
S29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZAbWljcm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvcXAuYyB8IDIgKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9ody9tYW5hL3FwLmMNCj4gPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL3Fw
LmMgaW5kZXggNzNkNjdjODUzYjZmLi5kOWYyNGE3NjNlNzINCj4gPiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9xcC5jDQo+ID4gKysrIGIvZHJpdmVycy9pbmZp
bmliYW5kL2h3L21hbmEvcXAuYw0KPiA+IEBAIC00MjYsNiArNDI2LDggQEAgc3RhdGljIGludCBt
YW5hX2liX2NyZWF0ZV9yY19xcChzdHJ1Y3QgaWJfcXAgKmlicXAsDQo+IHN0cnVjdCBpYl9wZCAq
aWJwZCwNCj4gPiAgCXU2NCBmbGFncyA9IDA7DQo+ID4gIAl1MzIgZG9vcmJlbGw7DQo+ID4NCj4g
PiArCS8qIGlubGluZSBkYXRhIGlzIG5vdCBzdXBwb3J0ZWQgKi8NCj4gPiArCWF0dHItPmNhcC5t
YXhfaW5saW5lX2RhdGEgPSAwOw0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgcG9pbnQgdG8gbWUgdG8g
dGhlIGZsb3cgd2hlcmUgYXR0ciBpcyBub3QgemVyb2VkIGJlZm9yZT8NCj4NCg0KU29ycnksIEkg
ZG8gbm90IHVuZGVyc3RhbmQgdGhlIHF1ZXN0aW9uLiBJIGNhbm5vdCBwb2ludCB0byBzb21ldGhp
bmcgdGhhdCBpcyBub3QgaW4gdGhlIGNvZGUuDQoNCkl0IGlzIHRvIHN1cHBvcnQgdGhlIGNhc2Ug
d2hlbiB1c2VyIGFza3MgZm9yIHggYnl0ZXMgaW5saW5lZA0Kd2hlbiBpdCBjcmVhdGVzIGEgUVAs
IGFuZCB3ZSByZXNwb25kIHdpdGggYWN0dWFsIGFsbG93ZWQgaW5saW5lDQpkYXRhIGZvciB0aGUg
Y3JlYXRlZCBRUC4gKGFzIGRlZmluZWQgaW46ICJUaGUgZnVuY3Rpb24gaWJ2X2NyZWF0ZV9xcCgp
DQp3aWxsIHVwZGF0ZSB0aGUgcXBfaW5pdF9hdHRyLT5jYXAgc3RydWN0IHdpdGggdGhlIGFjdHVh
bCBRUCB2YWx1ZXMgb2YNCnRoZSBRUCB0aGF0IHdhcyBjcmVhdGVkOyIpDQoNClRoZSBrZXJuZWwg
bG9naWMgaXMgaW5zaWRlICJzdGF0aWMgaW50IGNyZWF0ZV9xcChzdHJ1Y3QgdXZlcmJzX2F0dHJf
YnVuZGxlICphdHRycywgc3RydWN0IGliX3V2ZXJic19leF9jcmVhdGVfcXAgKmNtZCkiDQp3aGVy
ZSB3ZSBkbyB0aGUgZm9sbG93aW5nOg0KYXR0ci5jYXAubWF4X2lubGluZV9kYXRhID0gY21kLT5t
YXhfaW5saW5lX2RhdGE7DQpxcCA9IGliX2NyZWF0ZV9xcF91c2VyKC4uLCZhdHRyLC4uKTsNCnJl
c3AuYmFzZS5tYXhfaW5saW5lX2RhdGEgPSBhdHRyLmNhcC5tYXhfaW5saW5lX2RhdGE7DQoNClNv
LCBteSBjaGFuZ2UgbWFrZXMgc3VyZSB0aGF0IHRoZSByZXNwb25zZSB3aWxsIGhhdmUgMCBhbmQg
bm90IHRoZSB2YWx1ZSB0aGUgdXNlciBhc2tlZCwNCmFzIHdlIGRvIG5vdCBzdXBwb3J0IGlubGlu
aW5nLiBTbyB3aXRob3V0IHRoZSBmaXgsIHRoZSB1c2VyIHdobyB3YXMgYXNraW5nIGZvciBpbmxp
bmluZyB3YXMgZmFsc2VseQ0Kc2VlaW5nIHRoYXQgd2Ugc3VwcG9ydCBpdCAoZXhhbXBsZSBvZiBz
dWNoIGFuIGFwcGxpY2F0aW9uIGlzIHJkbWFfc2VydmVyIGZyb20gbGlicmRtYWNtKS4NCg0KVGhh
bmtzDQoNCj4gVGhhbmtzDQo+IA0KPiA+ICAJaWYgKCF1ZGF0YSB8fCB1ZGF0YS0+aW5sZW4gPCBz
aXplb2YodWNtZCkpDQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAtLQ0KPiA+IDIu
NDMuMA0KPiA+DQo=

