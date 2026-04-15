Return-Path: <linux-rdma+bounces-19374-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEoxA6VM32mFRQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19374-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 10:30:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 773D5401FC7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 10:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 357DA3019813
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9579121FF2A;
	Wed, 15 Apr 2026 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QfpyOU2l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372792620DE;
	Wed, 15 Apr 2026 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241575; cv=fail; b=A1p61nOfNllXUvHH/Nf8p7fNwfC1kEKGSUiYfQR2I/r/Im92WDaXQBnMKoEtYsPVRsC9xlxNhcGnY02M3ckRfha7TFG1/LxuQAR1q0z4ElfAqf87bARV0VjgEsmdJimFEKzYUYodAuX4VRsZ3m3es+DJAf4xWXMdOL0ukBVqbHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241575; c=relaxed/simple;
	bh=sh7BaK1dkb1+y0J7mxHVh/5r975+a+Lnoxvp6BKa93Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QJwCvyibVwM7lxilhsz9Nowh53DXV1RJOUrBjqc+Bul+7gFpBMMsvURCfqNf+XHtMyUzm9rplhkb7WSA9gvA5jfR7kjWt4HtD17+4JjsoFPfUl/LB7X+NA/imTk+e15vAeMVJGSLao78FrbZkjweFaFMgxCYn8tQXWuTBw4UGfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QfpyOU2l; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chi0X5nXNJHXO0cPcXwc2Eyc2A47AR4vDpBVewHxJ5iAQPHd/iX3ePg0ix9mHddRxwWI4OHm5UBvTfk1PprnInovfTI/6gxiKCxOr46SeCImmFWAb/3azzLetnpQern2c0cbAWJ33FO22ySjRiYWjEUNVLkn//NgYtdrUDtCH+K4XYib8aHWAxmwtxg1dpxAENH8kPtD/ApKnMTgKLNIui77ew0DJqwM8Mwyh8OZT0/Vv61VF5JvQpGsDrFwMwRIXTKB1d6OgsM2Cl76pXo7R6v+AIM37UtmROosDYmp4GZWHM9vQASQOiTFkNF4kDbSC/X9SUh5ZQma+3yn9jGQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh7BaK1dkb1+y0J7mxHVh/5r975+a+Lnoxvp6BKa93Q=;
 b=xiGQv3sNDj0D6+10SbPCQ5gYTNiDymmK9Ez9vy2dKGKhheQzFwvaa5gTWtKE88xC3wSNQ6OX+xCWJWKtgSgQXGou9aDSTTnwpwQ5jM9epAffE2WCZvVBQK27bjnIDUJZsZbAUaBCs4eJiZu9QG+sQ8MB54+NQTqVBFAcb7Lt3Vf5Kv2Ti297OtO6yej4CD4gricKFCAKjiLA01WuN9YOhdIEc6oCnqJ6GawmJxe77o7gLgLSS1xWTJW8MEyjvLkcAe2APGNpzzTHmm0NUW9yVU4NJVUIcEuhNJK/R0pUM5KJgQsNlpcEV7abFiqP/QGnjoboceH1hGzVLFT4nIGrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh7BaK1dkb1+y0J7mxHVh/5r975+a+Lnoxvp6BKa93Q=;
 b=QfpyOU2lNGQwupnR6kMzIxUtzm2u/2rtZAxxPfMJz0yNVhbnt36UW59QzHNTiWxcLYILtBpF0LxEchu/ZyaFmiXtJjMox+SBTw0wiFObAGzAKVmj7umZt2ReUUY9Bghk0vG3aS2O6E6RSdvLFiA9gadzJn/URRDI4wNbvAkWXjTy+S2b/baWuZzLrpxfPDOwIllGdyLOksaZgufu/4u5yQvMw2c79LCQ/8cJhrx7xArCTFsKvJ4nD+0Z46g751UtnbKnl3YXB9ncUUxpdFobURMjA9939yevrMU0bGpDtlTs177oAtcWhckJqsMJxuB993sYsaqN4PnXBaCfd+t0WA==
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::608) by SJ1PR12MB6218.namprd12.prod.outlook.com
 (2603:10b6:a03:457::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 08:26:11 +0000
Received: from CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::473:4cdf:9d66:c8f5]) by CH1PPF189669351.namprd12.prod.outlook.com
 ([fe80::473:4cdf:9d66:c8f5%7]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 08:26:10 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, "prathameshdeshpande7@gmail.com"
	<prathameshdeshpande7@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>
CC: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v1] net/mlx5: Fix HCA caps leak on notifier init
 failure
Thread-Topic: [PATCH net v1] net/mlx5: Fix HCA caps leak on notifier init
 failure
Thread-Index: AQHczHHg1SvMOrPLz0e9ZNDhKN3NLrXfyh+A
Date: Wed, 15 Apr 2026 08:26:10 +0000
Message-ID: <314cbe51501c36fc8a44bebe8ec7dac068aa1f3b.camel@nvidia.com>
References: <20260415005022.34764-1-prathameshdeshpande7@gmail.com>
In-Reply-To: <20260415005022.34764-1-prathameshdeshpande7@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH1PPF189669351:EE_|SJ1PR12MB6218:EE_
x-ms-office365-filtering-correlation-id: f3d5349d-aab0-43f9-f6d0-08de9ac8a616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 dzysM8zdmx8M1U/dKDIMNbCweLmAq5k4IEsWs3XE5gS5q8FcVcJ58Wiblmp/TMn+ceaVxS+VLjWlZS8qgnnDP4YhY57VzfRbbDCP/0geXAgCoq8PQFvWOddVH57ro6l0CBKurrJwFez9GSj/IT9DVF7q+YiNAD6AwujoQAvZN3beb6beZKH1sDwwl7WRuAZUzngQGvgRI3S7IqhnauUYGIEYOOuSH/0rWRipy5LvFNuPRvTnTkiFs/SSbKEwNUP9BToznJGfQZkWHKayqm9r9dSSjEzW8B2bzHPNrOz2WR48oWSwh2eIqGCbWbkhMzHJyMcJEtSZQAQfEauGVKA8DkLl70ND5Guzzv+dNl4WPvz5i/o2vBxuHwZkZTbtLuWjLnlQDhJ5KFPJaL7nJcqD98dbN4mE4jaaMDuBMhq1nviE8BxAsOxkslFDHgaQb2ALAL2U79U6/C0/klM+XDq3WRYkV2xNQHl4hI85rrVMuwskz8l5UodT+VOrezdRo4YSDe/idlndimdFRODsvMuw5yo4BXM+s27mG3ZyEjUv7jlZ3USXQFLdL11TByE3r7SfYFyP8tZn0rs28CPCmCOcMaIsqf6JKYQeFKIFlBXZxLOZzwYnvUSRIhGjPMpD6O9CjGE7YVTSvKkoDzKx2nLES11xBTV3vmVT8KE4UCDTZJuVTN4go2EELm1IARv2c6fVkz/06Gz09JZuZYI0U8hG4PW2RcKFGqcMwc/kfAsntl0BAI8/7+l2xBHcateBw/ISO2dqnOA3jhY3zUimfADMgyoS3R+O4++M1LhNdppgEOI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPF189669351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUtPMUU2UDkrMmV3czYzbHp4ZFkxTEx3SGRYU3kwTEcyRi9vbUFjOWQ1cEhS?=
 =?utf-8?B?K3A5bjJGWTZZR2FudEVVTjRLRmVBME9ZVGpqRTBWR0FUanA2WkFmNlVRem9r?=
 =?utf-8?B?TzVUKzFxWmI2NmtMNkZzeWU5TVNqQjhIOW5FclNOOEpxb0dEM2JobTFIN3RG?=
 =?utf-8?B?WUhiRVZ5MGo2QlkwZzhQbHo4amFtaFQzaXhxSkVaTjFSUXFRNWhpN1dJbitK?=
 =?utf-8?B?RVRETC93eWdOUzYzci91a0xHVjdicGlaMW9OUm8xT3JvSEFtVHBZMS9zNUwx?=
 =?utf-8?B?UTVSVXphcUtLRENQTGcyZm9IMGxTWkNIRTNPdzVUYjBiVzJqNWF2NWtJTVBI?=
 =?utf-8?B?N1FsZ3FlQ1RuNFBUUVNXdU53OS9nMTRVNWtFRThxRmx4b1VmdVJxenBHSkZv?=
 =?utf-8?B?c1puK3dXV2FROVBXa1BmRkZqcWdEdnNqZU1WUlhpWkZrdkJ1OWN3aGQ2KzQr?=
 =?utf-8?B?T0xsczd5TC9adi9GLy8vNUgxdXM1Sm1LK0FlNGhLVUFmbXdsNE1Pbm5SUHo0?=
 =?utf-8?B?VXdIU1VXNlBiajRka1M3dlJpZGszK1kyTG9rM3JaNWhFTG1yWHpXL3NFamF3?=
 =?utf-8?B?MTJLNTE5NlVQN0RyUXJDMHJHN3pzUzFXbFkvU2FFcHA0T2QycTIzZEVaTi9n?=
 =?utf-8?B?cVNJU0xHYWRwWlNNZUcrZWNyQ1BrajRzQmdkUERjbmRvVVlnZ3pQMXlOMCtx?=
 =?utf-8?B?eTJEVU85NVZPSE5ZcFhaekcxZ1pYQ1huODFZdG1ZWUxFaGE0Z2Z3aTJObTNt?=
 =?utf-8?B?aXJoQmczR0xRWlE2QjE5NzFHOHVBZ2plNHZaUXpNK1hCLzI1TGMrRzRCZW8y?=
 =?utf-8?B?bXZRMXB1YWptOXR6d1grUHY5Zmhac1JhbjlRbTdWWDFhTW9lRDliZjFMWm5i?=
 =?utf-8?B?MSs4RG5ScW92ZW50QlJJcG5zcHN4N0tTcVhTdzFLSnJsS2RLVjZWbkdlTi9w?=
 =?utf-8?B?R0xFa0d4NmM2amhHUXRaQWpxNWFKdnZiWU1ZUktVZEpqWDg2U1dnTzlxTDBs?=
 =?utf-8?B?VXNuYUIxYWluRHRLMDNkTmZzYlErblBDT0ZSTXY5dWRkUVNxWTJTYmdKOUx0?=
 =?utf-8?B?SDFkWDdHNjRQOEFNQ1J6N0hlNjR1b2k3N0lSNXZzamt4eFpMQ2liV3hPZ0hE?=
 =?utf-8?B?Vmx5MjZTSzRXcVhNU1NIaVdXenc4U3lBaGZ0NEZBOXpCT2U0N0E3c3VWRlBy?=
 =?utf-8?B?TGlJK0M2S2lXb1pYN21HU1dTRnZtUUFsbFZMeTVob0YrbWRkcDV0TE5pTDJJ?=
 =?utf-8?B?ekxiZlRTdWM1TTNJYUVjdXVrZGlubXV5QVZVL2tYT2ZuSjQvNi9qMHhMWVAr?=
 =?utf-8?B?VnhiSUJXdDYvS3pGWkV6dk10ZDQxN2RhYUo2WTBQSmJWaTBwek5oTUNWMURm?=
 =?utf-8?B?VHVJODNkcndoRGNDclRBNTdhU2JIUUQ0YmJNUDE0M0NpUi9odEIyYitWYTk0?=
 =?utf-8?B?L1lYZWM1TWh6VTdwMmhGN0VXT3R3Umt4cU9reGZ4ZkFEVEljY0p1RWIrRnBT?=
 =?utf-8?B?Q05KUVM1U1g0Wkd6blkvcWlwVHFGcG43bUlxWjBCN0JaQ1ZENFFVMTBDcmFY?=
 =?utf-8?B?NFdNM2twSnA3aTZYVi8vQzJuaWV6ZTNsWTlqYjRGTDhsVDZ4V2R1OTNGY2lx?=
 =?utf-8?B?b0RGN1NVMFB0NXVLNDhvVVZ5Wk1xR2JDYmZOMHlBZUk0VlgxajZ5a2NUVUR5?=
 =?utf-8?B?SjM5TVB3V2pobmZmYkZTL3AwRWxjOTd6aGpDM0EyaHNOMjlZbjlXZm9vZFh6?=
 =?utf-8?B?R1JIaFJneXMvY2t6VmNqT0VBVzB4MThxUFhyL3BwMDBERUdqMVhpY2R2VjFo?=
 =?utf-8?B?QmtoWkpVRUlmNjdTYTg4YlN2Q1R2aW5FS2VBb1d5TkZZNzN6OURWNWt2eDBi?=
 =?utf-8?B?WUYyZTZyNWNFTDJiUG9FY0hGQWZUbjMrZ3B1VzIwcnVNaFZaZk9sUU5EekVv?=
 =?utf-8?B?bjNhTGZCMXU3RFNqMGEvRTJ3N2locysybFlmTXRNZktkYmViSWdVTjFuM3Aw?=
 =?utf-8?B?NERjNldSUjB0UXY0K1RGOHEzTHYxMlB1alNxSUFjcWwyZ2lIbzZlUDJORzlj?=
 =?utf-8?B?ZUtWakdscitZd3Y3M3NoSDU5ZzZSNk5lOEVMSG9FSC96SVdid2hNTFR0a1Fl?=
 =?utf-8?B?MXBiemd3TjhpWUxOdE5sU2x6T3VrVElwSlBhZEdCNHRMbHZ3cU0rU1ZoVU0w?=
 =?utf-8?B?enB6NzlVNThtOFQ5K3VOVWI0U1dUUysvQmorSU1WamxrR2ZNUk1iVk9EU3dl?=
 =?utf-8?B?OUxzY1c4T0lBM2dZRkJhR1FGNjkyaU1Ba1NibjYyQjJwamx0Qyt5NFNTV1Nw?=
 =?utf-8?B?UUdKblR1bU93dGJldzY0WlJWL3R4QzExcGxmRkc2R0YwTXh3R2Uvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CDE00EA796F194882A1EC3DB1A83FB4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH1PPF189669351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d5349d-aab0-43f9-f6d0-08de9ac8a616
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 08:26:10.3245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dt/D/2O55qeHjDooXxCskKu+h/XxB77ZGPXvhHyYgcjr7ZsWIPJdbQG5oc48V4ja7wJse22L9Fq1isw9Osyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19374-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 773D5401FC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCAyMDI2LTA0LTE1IGF0IDAxOjQ5ICswMTAwLCBQcmF0aGFtZXNoIERlc2hwYW5kZSB3
cm90ZToNCj4gbWx4NV9tZGV2X2luaXQoKSBhbGxvY2F0ZXMgSENBIGNhcHMgdmlhIG1seDVfaGNh
X2NhcHNfYWxsb2MoKSBiZWZvcmUNCj4gY2FsbGluZyBtbHg1X25vdGlmaWVyc19pbml0KCkuIElm
IG5vdGlmaWVyIGluaXRpYWxpemF0aW9uIGZhaWxzLCB0aGUNCj4gZXJyb3IgcGF0aCBqdW1wcyB0
byBlcnJfaGNhX2NhcHMgYW5kIHNraXBzIG1seDVfaGNhX2NhcHNfZnJlZSgpLA0KPiBsZWFraW5n
DQo+IGFsbG9jYXRlZCBjYXBzLg0KPiANCj4gQWRkIGEgZGVkaWNhdGVkIHVud2luZCBsYWJlbCBm
b3Igbm90aWZpZXItaW5pdCBmYWlsdXJlIHRoYXQgZnJlZXMgSENBDQo+IGNhcHMgYmVmb3JlIGNv
bnRpbnVpbmcgdGhlIGV4aXN0aW5nIGNsZWFudXAgc2VxdWVuY2UuDQo+IA0KPiBGaXhlczogYjZi
MDMwOTdmOTgyICgibmV0L21seDU6IEluaXRpYWxpemUgZXZlbnRzIG91dHNpZGUgZGV2bGluaw0K
PiBsb2NrIikNCg0KVGhhbmsgeW91IGZvciB0aGUgZml4LCBMR1RNIQ0KDQo+IFNpZ25lZC1vZmYt
Ynk6IFByYXRoYW1lc2ggRGVzaHBhbmRlIDxwcmF0aGFtZXNoZGVzaHBhbmRlN0BnbWFpbC5jb20+
DQoNClJldmlld2VkLWJ5OiBDb3NtaW4gUmF0aXUgPGNyYXRpdUBudmlkaWEuY29tPg0K

