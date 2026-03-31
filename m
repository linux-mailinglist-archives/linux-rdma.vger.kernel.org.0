Return-Path: <linux-rdma+bounces-18842-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFXYFKrFy2mnLgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18842-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:01:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FA5369E0F
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D0E830D0CF9
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 12:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836513E3C40;
	Tue, 31 Mar 2026 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W31VwgIX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158503E274D;
	Tue, 31 Mar 2026 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961848; cv=fail; b=hPGzUn671d5cApu9SwA/MRr/QiaVzkyZb4BB9qQZPl0qWeZXUa1puxA6o0cswfNN/9zv2friZuFQGf1yn+S8AJANTC7MWhAkmyt0ltkwgCP9Oj3ymctxsx6VLxvIEBGpCuZjzUcqENJTTfSaN/ZV9+2NowpgvpXCviBgAAGPmrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961848; c=relaxed/simple;
	bh=Nroa6LVpL+McKXCPdjvZmvLYQCewQCQtHFS8s5nVoVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ojyWM5SP5+471DqM6KrZqrrrhpdOvVzK+lkWtc8n1MW2eBKMVNWVf/O7cNiUXmeZ4RfaOBj2YCm/+NIzfUlyQpiyJ/vwhMIyL3jRTOE6KAV045apKqrvwMzbuA1mbpRC2CC04wQrqiOAx09KkZzQ99BxC4ReK446tVmG8a+HijQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W31VwgIX; arc=fail smtp.client-ip=52.101.53.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBp+LC3rdx+ZeMunqXlUnwQz74uZ5CjhkE5hPa6SZ7au6ta08oGflRkqJ03CX+o1cEv+KkbPmSlOXEon87c0tUrqhu41oiAB0KiTJ0FwIfvdGfihCCEZCQKfi6AJnILJuZN69Ugg8QqVhwyZcGCJy5wdlEmiuZQOfVqxnevcq56pHWadySQ6vt8TB5RNzx9p17N7IybekhuU0VMxG/njfgy1F5YI5OdLfqC8tyqHgZ1IX3V+ZSBYOVCNIPg5yPr5qGfjEVd1+KYbWyuaFhpW2E62II2I5oMUCCkGYgyVqUcOiV24Y/yDWE79+DQeDxQvMTO4wFY7XEoZ0hUJ0fNOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nroa6LVpL+McKXCPdjvZmvLYQCewQCQtHFS8s5nVoVI=;
 b=JwqdYGYBCEm2jZpTKVBf9uxyO1Nm4AhI3Nn7B4xkFtJ3J/ntDSzwZNpmOwETl7OUvdIolK+pzGb7MF0S0BzdL8vNeMIT0/CWNr0M5CcHPmU2BM7Qeb5SZ0mkvRrXR2o2T7G3FAURVgMq3URTMRMs9BnAyLmnBex5evkbDvbdDZKcdngvp0L1dpKGWujULggZQjL36i36JWfMr/EvjLC0niTYuBcXUHe81gumsttmu8AnNmQVGAw8pzVEKL/jTsg6V64Ov3x4RGwfa7wCqUrEPasN0XlspcRamUzyjrg+kGgIHif1BWMuSTuuJGGCrvsXH9fTTWk2ULV+w6XpVFkNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nroa6LVpL+McKXCPdjvZmvLYQCewQCQtHFS8s5nVoVI=;
 b=W31VwgIXm/mGnRQNfLEIVKnVCbMFpFcKRTZvPNCFphMg4mvdu+E7CYgsJHUaTk7zF73h6N/UB+wP0At9S47vG77YtP/GN+PbyaK9+pkpQVr8dBzCt4nzYlDbxSnP1pHGVnkkjqBQKp9+meV0v70KlSiSpipGx5BsZJz2grsJ0JFvkkSqfZVLzVJt5Arm2aUkxICTOO2GfCB8IUNGcb7g6QMMAdP3T0MHKzElCoKB9HeUgVOWjHIF/lJet1+qnNJjS4ePM6Eu2MhQCA0hSniZwsUFOopfCUoBkwNc0kcVPJcqn9SItPyofIGvFufJl/Gj3j1d4OsSjtXwT7Y8lFnUjw==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DS0PR12MB8217.namprd12.prod.outlook.com
 (2603:10b6:8:f1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 12:57:17 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d8b5:cf72:3e36:3701%7]) with mapi id 15.20.9769.006; Tue, 31 Mar 2026
 12:57:16 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "allison.henderson@oracle.com" <allison.henderson@oracle.com>, Moshe
 Shemesh <moshe@nvidia.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "daniel.zahka@gmail.com"
	<daniel.zahka@gmail.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matttbe@kernel.org" <matttbe@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Parav Pandit
	<parav@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>, "kees@kernel.org"
	<kees@kernel.org>, "willemb@google.com" <willemb@google.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "razor@blackwall.org" <razor@blackwall.org>, Adithya
 Jayachandran <ajayachandra@nvidia.com>, Dan Jurgens <danielj@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"minhquangbui99@gmail.com" <minhquangbui99@gmail.com>, Nimrod Oren
	<noren@nvidia.com>, "dw@davidwei.uk" <dw@davidwei.uk>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, Petr Machata
	<petrm@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"antonio@openvpn.net" <antonio@openvpn.net>, "mst@redhat.com"
	<mst@redhat.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Shay Drori <shayd@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>, Gal Pressman <gal@nvidia.com>, "joe@dama.to"
	<joe@dama.to>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next V9 12/14] net/mlx5: qos: Support cross-device tx
 scheduling
Thread-Topic: [PATCH net-next V9 12/14] net/mlx5: qos: Support cross-device tx
 scheduling
Thread-Index: AQHcvO6IvJA9XXDxIkG79e0auTqdFLXH7KAAgAC1ToA=
Date: Tue, 31 Mar 2026 12:57:16 +0000
Message-ID: <825a4d417827cb7cd2ce896ee9e32b4108a21ed0.camel@nvidia.com>
References: <20260326065949.44058-13-tariqt@nvidia.com>
	 <20260331020820.3525138-1-kuba@kernel.org>
In-Reply-To: <20260331020820.3525138-1-kuba@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DS0PR12MB8217:EE_
x-ms-office365-filtering-correlation-id: bd2408dd-6e59-4b94-7918-08de8f250974
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 LfRo5s4d4N94TMyIHhOY/2680thTXws/YW6/on5r0TxPzCEmJF49YlOwmPLMyusCclR01mNMJW/WlcOFDJyv5xhXSnS2BQnEeJEk2TK639596IX7o/JwPfyZ5xTZcqP79Snco5CLp6gPWlLCNk/i4QZEaji4D+XRVwMJ5ipm36ajLflxWV1SOBC+TTPJ1dXsbHm94SaFjjsbYHpgiQYyWW+0RTyL9naskTUTZ0Lw6jR1siZyhJDtreo1DsurcQQHZjvdH2SCSmAGLI8UvPOM6WVRmPwxWraRjrGrDYh13hf5mJZM67evUEwsi+jiB630dQVXH3FvLubY1jKfDb6Sjli33QG4bId3ZtfWZAdPEHkfyyZCJ0FOhTWe1PaJN/jGs1CP7//MwmM15wBOaEk9PLpuTrel2Px8Kdp61EHglflOM43DPW/Yqni6pRS7aDjALbfNyII5R2himGjx/vkyaFb3LIRWC5R85ykvOM1JMZEP9pRF75bH5hxQd45pzHVE6FsW3v4wDvs64rCAwaOLdHy1i06xQYOUBdh/Zw9Y23PaP2IE9EPH8lB7yyic++Bw3jmgJu7OgCuUS1TKik0pcK84aPmzqbyZ30qLKb3OCMOsI0uh+QLL/2isvpTq6JeiPMAqNUaOCZ8KQbU8Ar15MeQQnVObkybBIHJgGlAqobshAM4sY7J35UpUhZE/xoLRooAZfn1Ues/CB98iROnfJVuETwOFr9YiSQHBz84tWFtT/wdAsZM49QEsNVFdBoc51RC2eFwLSyjesli7R6IE3ILAa4zB0WPSceT/lZsRD/Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnlKeU44b095ME00NzJRL28rcWhzSldTMUpydEd3UjFBc2xOcEl2Sm5jbjB5?=
 =?utf-8?B?THV1cUNaWlNSNlhiNnlvL0c1akdMU2RuWCtBblhFVytlYTgxYUhUS1JUa0tk?=
 =?utf-8?B?WXV0ZFRCMTc3MG52YTlJbjYvWHlETHpCdFVhRGRmUHV5RDhDZXBMM3BUNllh?=
 =?utf-8?B?K2hadHU1VlBXdUlqa28wUG51NkZ2N2h0Zm5tZTVXMUh0YWtDZTRldmFsVGFI?=
 =?utf-8?B?SjV6YnhhdjNpbU15eTFnYStMSndrUGxuc3hNOXpLNWRGdDlUcW1EWk1VdGJ0?=
 =?utf-8?B?bG10SysvTzEyTVpFb1F3cUhQeTFCTUE5NG5VRkl6S1dFT0M0RmtqMk5KMTFJ?=
 =?utf-8?B?UHg1elI5NFR2TXFjK250WHNMSW54TzZQR0xldGVoalJXNzdDV3V0OHBoTXl0?=
 =?utf-8?B?U1pPajRBSThmRjAzTlZod1hzQ2gvN2JqOHlLWkpsME5XY3FFcTJ5OXNYRVcy?=
 =?utf-8?B?dllkVGRFOTVrZ3hRQ1VYbXR6c2xlbC9laHFJWWtnODF6MnZleFdpbEpqdmVy?=
 =?utf-8?B?UmFzNHA1QmdIOGxHME9XTzRrM3A1dFhjU2p0TkNtVlhKZktoK24yakpVZllV?=
 =?utf-8?B?cEhQeFoxSFhSeWkwZWRsVFdZelZsV1lCcHhkbmJlQXQxSkQ2di9xSXZSK3Zr?=
 =?utf-8?B?VWJ2b0lTY1JOcjU5S3A4OWQzaVJyNWlWY3MyVG4rck9mSk9CbGE0TDlRWWRS?=
 =?utf-8?B?MGxhVFN6SFhqZzJod2E4UkhIcTVEYWp6bW9UREVJVE5XYkhxcUlPcGI1MG1y?=
 =?utf-8?B?alpBVTZNVDhDVm0vWktzc1QvZE5qUVFwbTVQV2Q4VEltMm1LYnBxYUw4b1g5?=
 =?utf-8?B?OTdhSUxCcnkybUNPSDlvb3Z5aHJEaDRDbjRmMGJ1bTJYY3FpdTR2eTR3RVkx?=
 =?utf-8?B?Zk40RUtsbThwZUxYTDY3aTVOWFZVKzJ6UmJ1WmpCbGRoRUNtY1FYd2VLMXNi?=
 =?utf-8?B?azM1QW1GeWtERFd4dDMyWUMzQ2VHOWxPaDJSaGxLTjI5TVNaVXltRTk0YmV0?=
 =?utf-8?B?MnVVSjJ6MnZya0tKMlNiaGVPRmVLUWVONW1FMkI5dEswZlZGMnRaY3EranRk?=
 =?utf-8?B?ckVIbmRvZU16ZnV3Zks2eWpSRDlBeVFuQURqci85b2luQmVqcWo3WS9jU0xT?=
 =?utf-8?B?NXF3eFgrYWRDZi9Fd0Y2Y2hoTlpySHlPbmRIV05pVjg0Wmw5WTluM3BtWloz?=
 =?utf-8?B?TU03VFJDWEV2Z1BXYVFZYTZWRFBoK2FYUnBoZUlXM2dNa3JFaWI0UUZyTTRz?=
 =?utf-8?B?OS9HeFh1ZHlmbnNIemdlQzdaK0QyWXlTWUE3L3dlNG5MeXVJV25KcEJYY2Zk?=
 =?utf-8?B?SlpYYWRkSkNqK21kS2ZlN0g3MElPUThCRGR0NnNjalE0NDhGdW1iVHQzMDlt?=
 =?utf-8?B?UlpFUUUvdXdqVlNSaHRxSXg5R3NLVkpkb1h0KzRFT2cwcG9uZ0pMblFtNTU0?=
 =?utf-8?B?eWlrUlJIeVpEUXFJOXAwYWV5OWRCdTdmakxLT3NwQ3NMOFJDZDdPdE13Misv?=
 =?utf-8?B?WmJHdFlKOGJNeHRuRFBYemUrWkZvNFZoVFlwZkNWMk5ESGp0K1AweVR3bFRk?=
 =?utf-8?B?WHU5YWdQcHZySDYyNUh4VjBjWE16M2ZzcmVtV1JvWGlXdnRhY0ZrUHQ5N1lz?=
 =?utf-8?B?cm0vZmZhQnV3RnE1dFRaUjZEQmJaQzVTQWl2ZkNOVDdOSXp4WU1PcFBQRHNQ?=
 =?utf-8?B?UHFESVRlbC9Xc1Z2UHlteEtUT1ZNejVjV003VFRRSnVjMmtBVUhlT2FhMTF6?=
 =?utf-8?B?NzZIM2FBcWswa2VFcU02a3NJaVd1dU9OU2FwVDJvbk13K2l3M2ZoeEw5STgr?=
 =?utf-8?B?SUVqZlpqd1pwQ3loNmQ4TzdKTEp1WG40MFcwbk1CeWFXeVVzTzRrYUR1ZTU5?=
 =?utf-8?B?TENGSW1lVEFuM1EvVjI1dk80Ri9GeUZrTnZoS1VCOEUwY1hxTGFDR2wydThL?=
 =?utf-8?B?SXhYaUxmZTlMZWdSaTVROXFwZGJnYnF3WmF2Rmh3Mmhlbi9uV1VyNHJjOFhN?=
 =?utf-8?B?ZFhsWFlBaWhXMzl2Y1FFMC8vNCtubEU4RU1kMjU2SEJJU0J3R2M2VHZBMDdk?=
 =?utf-8?B?dWVtVHFSUWMvZ2ZTSFlEYzAvbTVMS2kvVXd2Z1h1Sk8wV0J0MzVNaXdpOTBl?=
 =?utf-8?B?dnFhenRDbkhmYnNuRkRzeFZELzhyMzVjbzNSdysvTnhyWDEwcTVybnpuNnQ4?=
 =?utf-8?B?VzgxaHJSa1NxdG8zSDFjcmJsL3NLTmcxb0tMdzhSbWtYcmpEYWorL1ZoTWhL?=
 =?utf-8?B?eWRHMFVHN3NYYjdCZnJlVlZSR21zN1N0d3J6S1FmTjd6TFZ0WTJpZTUyUEpr?=
 =?utf-8?B?Vk9oTzlZQUl6aVRabzVMVkczMUNvOWxhRXJMQ0FpOFpkYURhWm0rZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E303EB70AF92534E86534CD20B854F8E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2408dd-6e59-4b94-7918-08de8f250974
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 12:57:16.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xx6Os3mzBQF3qJJxp5+ftF8e24MT9qvGCQLt2VzViB2dszudMhjWJ8AQn7riUOCfyyGxCgZvrK99R+8xuABI0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,nvidia.com,resnulli.us,davemloft.net,gmail.com,vger.kernel.org,kernel.org,redhat.com,lwn.net,google.com,blackwall.org,linux.dev,lunn.ch,iogearbox.net,davidwei.uk,intel.com,linuxfoundation.org,openvpn.net,fomichev.me,dama.to];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18842-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:replyto,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: C0FA5369E0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE5OjA4IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gVGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIgcGF0Y2guIFRoZSBodW1h
biBzZW5kaW5nIHRoaXMNCj4gZW1haWwgaGFzIGNvbnNpZGVyZWQgdGhlIEFJIHJldmlldyB2YWxp
ZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLg0KPiAtLS0NCj4gbmV0L21seDU6IHFvczogU3VwcG9y
dCBjcm9zcy1kZXZpY2UgdHggc2NoZWR1bGluZw0KPiANCj4gVGhpcyBjb21taXQgcmVsYXhlcyB0
aGUgcmVzdHJpY3Rpb24gdGhhdCByYXRlIGdyb3VwcyBjYW4gb25seSBjb250YWluDQo+IHZwb3J0
cw0KPiBmcm9tIHRoZSBzYW1lIEUtU3dpdGNoLiBJdCBlbmFibGVzIGNyb3NzLWRldmljZSBUWCBz
Y2hlZHVsaW5nIGlmIHRoZQ0KPiBoYXJkd2FyZQ0KPiBzdXBwb3J0cyBpdCwgTEFHIGlzIGVuYWJs
ZWQsIGFuZCB0aGUgRS1Td2l0Y2hlcyBzaGFyZSBhIGRldmxpbmsNCj4gZGV2aWNlLg0KPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vz
dy9xb3MuYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vz
dy9xb3MuYw0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29y
ZS9lc3cvcW9zLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZXN3L3Fvcy5jDQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+IEBAIC0xNzM4LDE4ICsxNzYx
LDQ0IEBAIGludCBtbHg1X2Vzd19kZXZsaW5rX3JhdGVfbm9kZV9kZWwoc3RydWN0DQo+ID4gZGV2
bGlua19yYXRlICpyYXRlX25vZGUsIHZvaWQgKnByaXYsDQo+ID4gwqAJcmV0dXJuIDA7DQo+ID4g
wqB9DQo+ID4gwqANCj4gPiArc3RhdGljIGludA0KPiA+ICttbHg1X2Vzd192YWxpZGF0ZV9jcm9z
c19lc3dfc2NoZWR1bGluZyhzdHJ1Y3QgbWx4NV9lc3dpdGNoICplc3csDQo+ID4gKwkJCQnCoMKg
wqDCoMKgwqAgc3RydWN0IG1seDVfZXN3X3NjaGVkX25vZGUNCj4gPiAqcGFyZW50LA0KPiA+ICsJ
CQkJwqDCoMKgwqDCoMKgIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sNCj4gPiAqZXh0YWNrKQ0KPiA+
ICt7DQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+ICsJaWYgKCFtbHg1X2xhZ19pc19hY3RpdmUoZXN3
LT5kZXYpKSB7DQo+ID4gKwkJTkxfU0VUX0VSUl9NU0dfTU9EKGV4dGFjaywNCj4gPiArCQkJCcKg
wqAgIkNyb3NzIEUtU3dpdGNoIHNjaGVkdWxpbmcNCj4gPiByZXF1aXJlcyBMQUcgdG8gYmUgYWN0
aXZhdGVkIik7DQo+ID4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiA+ICsJfQ0KPiANCj4gV2hh
dCBoYXBwZW5zIHRvIHRoZSBjcm9zcy1kZXZpY2UgcmF0ZSBzY2hlZHVsaW5nIGlmIExBRyBpcw0K
PiBkZWFjdGl2YXRlZA0KPiBhZnRlciB0aGUgY29uZmlndXJhdGlvbiBpcyBhcHBsaWVkPw0KPiAN
Cj4gV2hlbiBMQUcgaXMgZGVhY3RpdmF0ZWQsIHRoZSBMQUcgc3RhdGUgaXMgdG9ybiBkb3duIGlu
IGhhcmR3YXJlLCBidXQNCj4gdGhlcmUNCj4gZG9lcyBub3QgYXBwZWFyIHRvIGJlIGEgY29ycmVz
cG9uZGluZyBjbGVhbnVwIG9yIHVwZGF0ZSB0cmlnZ2VyZWQgZm9yDQo+IHRoZQ0KPiBjcm9zcy1l
c3dpdGNoIFFvUyBzY2hlZHVsaW5nIGVsZW1lbnRzLg0KPiANCj4gQ291bGQgdGhpcyByZXN1bHQg
aW4gYSByZWdyZXNzaW9uIHdoZXJlIHRoZSBoYXJkd2FyZSBUU0FSIHRyZWUgYW5kDQo+IGRldmxp
bmsNCj4gcmF0ZSBjb25maWd1cmF0aW9uIHJlbWFpbiBwb2ludGluZyB0byBhIG5vdy1pbnZhbGlk
IFZIQ0EgYXNzb2NpYXRpb24sDQo+IGJ5cGFzc2luZyB0aGUgc3RhdGUgdmFsaWRhdGlvbiBhbmQg
Y2F1c2luZyB0cmFmZmljIGRyb3BzIG9yIGZpcm13YXJlDQo+IGVycm9ycz8NCg0KVGhpcyBoYXMg
YmVlbiBjb25zaWRlcmVkLCBhbmQgRlcgcmVqZWN0cyBMQUcgZGVhY3RpdmF0aW9uIHdoaWxlIHRo
ZXJlDQphcmUgVkZzIHByZXNlbnQgb24gYW55IG9mIHRoZSBwb3J0cy4gVkZzIG5lZWQgdG8gYmUg
cmVtb3ZlZCBmaXJzdCwgYW5kDQpyZW1vdmluZyBhbGwgVkYgd2lsbCBhbHNvIHJlbW92ZSB0aGUg
UW9TIHRyZWUgZW50aXJlbHkuDQoNClNXIGNvdWxkIHBlcmhhcHMgbWFrZSB0aGlzIG5pY2VyIGJ5
IGRldGVjdGluZyB0aGF0IHRoZSBRb1MgdHJlZSBzcGFucw0KbXVsdGlwbGUgZGV2aWNlcyBhbmQg
aXNzdWluZyBhIHdhcm5pbmcgYmVmb3JlIGF0dGVtcHRpbmcgdG8gaW52b2tlIHRoZQ0KREVTVFJP
WV9MQUcgRlcgY29tbWFuZC4gQnV0IHRoaXMgYXBwZWFycyB0byBiZSBhIHNpZ25pZmljYW50IGVm
Zm9ydA0KY3VycmVudGx5LCBzaW5jZSB0aGUgTEFHIGNvZGUgaXNuJ3Qgc3RydWN0dXJlZCBpbiBh
IHdheSB0aGF0IHdvdWxkIG1ha2UNCnRoaXMgZWFzeS4NCg0KPiANCj4gPiArDQo+ID4gKwlyZXR1
cm4gMDsNCj4gPiArfQ0KDQpDb3NtaW4uDQo=

