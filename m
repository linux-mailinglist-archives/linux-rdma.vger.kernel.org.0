Return-Path: <linux-rdma+bounces-12596-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE05AB1C1F0
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 10:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB8618962B4
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 08:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6176F220F57;
	Wed,  6 Aug 2025 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DHXmWa+j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281FC2FB;
	Wed,  6 Aug 2025 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468106; cv=fail; b=f3GGKWJ7wjOm0NelJmJ65nQrdlBKWLPLUm08X4Qudcux1zHtwJ350FtieXeQjV1zA0K++TxIzBrvVuKXG7w0cTzki6nfHMPHlQVP6U6OyE7Hd4EviJno4qvrKjekj38BedsmUvMgt9G4hs6XAHZBiEzO0xvEGB+w582zBt6UGDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468106; c=relaxed/simple;
	bh=z4caOL/KbR75c3cdz+sVYQ7gkCddqZm/NCqjJX7q8O4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oenKgyi92zkEYSgpDFQOIwXSPmLzjc0XFTwXi0al/dnuI7e/srJOf7YLqf3Jni+VuZvYFdtdVkayt6EyFwtCOospXuX7zsRs/8VnFPySdEjNq23cp4yc24w+aaD2Tt6OJ/7v9YHU5U3kivC/OphNqLCOIHZaQ48vuhV+PbzBvns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DHXmWa+j; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fsjiALWD/1lHrGFJxlOT2Pmor/XWPoesJjpsdhkaEJe52gnUPLaHaWy3vqFKHvlwNJ15qRkcv4LIlrdCO3y9NE9LRtewiHJ0jaxPoqmxvkXApTUjSfsHiPZZgp7l7vQF9wqf1Bd09xH4qarPGCItknQPSiOSPunKlDqTkBEwUaXBaYGrDH06zUjWyCxoajKNdSx8QXiRpXhh+xNmAiaVRULVbRUJrqt7dFVOVcq9nBnhRB7nemuFo0stmGOFvN/FC/nRb7PR2+jBlnTXDTn955n8rluNY6CXblNFTYgeURRqmwhOLHQ2gm/Jb3o/yukyiAs4eQp1ZFJkdYys4JfsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siWqRy5LoUUwgNxH4WGopgLZvgD9Og/0QaWFGT0o6qg=;
 b=Z6TpSltOeqIbBWUw+Gty51Fo8DGHWUrLVqiISf+TcALzN/Exx0AhET9b604BKwZTlh9rBMwNI5yHC3qioHhO4jNZD0xlQHKNHf+gIZ5N+kWAnMP9KQmExUFu+FtzjXssjDuUq0w8jo7yqVcSAmSwoom6xPEU32S1Je6MDzKiSYycQgpDe8geSvPvwFG2RNXHVlQhW986DtjwzE7YJ6zBi1xwctYU6xN2urAsMsctcvHqs+7x9vFLQuRG1oYU9UbTT4D+uDat4YY3+HaGVIPRLQOrFnQxlG7+oU5GKY8u29tUiJaxjqt8B8RQLLn+Tc7bDQ1f3enOwRnnS31EX1Bnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siWqRy5LoUUwgNxH4WGopgLZvgD9Og/0QaWFGT0o6qg=;
 b=DHXmWa+j5dcydpwQ+I7zGcdhUKCff66dnEMJEBJyLt91rCkZQQb4OmHYtw8pzHG31khFATkmgtMHy+w8noh+DzIOEUUnAVGFoClKquV7f1YmUpEGDh74xgMjyMm9gredtu0wTiTvrJVC/mJkA8xLCIqn7FTktrsSYZ//5CgxjMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.15; Wed, 6 Aug 2025 08:14:59 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f%4]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 08:14:59 +0000
Message-ID: <7393e875-9e7b-929a-a999-2b5e23230da4@amd.com>
Date: Wed, 6 Aug 2025 13:44:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 01/14] net: ionic: Create an auxiliary device for rdma
 driver
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: allen.hubbe@amd.com, nikhil.agarwal@amd.com, davem@davemloft.net,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 shannon.nelson@amd.com, brett.creeley@amd.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca,
 leon@kernel.org, andrew+netdev@lunn.ch
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-2-abhijit.gangurde@amd.com>
 <7044823e-c263-4789-b83c-ecb1eccde04f@wanadoo.fr>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <7044823e-c263-4789-b83c-ecb1eccde04f@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::8) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0ed275-e819-42bd-37dd-08ddd4c155cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3EwNFJsZHJQSjVmVm42QWd0aFRwVElNaExuT01nb0ErUDZqSldQMkRxNVBl?=
 =?utf-8?B?QWZiVkVIM0FlUjZFcGxmSUY2UVJmYXlValZWanRGY0ExYXNadzVQaFlWU0Rn?=
 =?utf-8?B?UUYzVWdpVlY5UVl0RUhuckxJb25DOUZpSHNJbmFYY2wrRi8xdHppWTZtVmVk?=
 =?utf-8?B?N3lEblE5OHVaNkJucFlyZVJmeTBFUVowUmJ6UFZYTUl1SGpuOEVZV3VDbHhq?=
 =?utf-8?B?b0I3VHBWdW5lUjRNRm9rcEhaSmx5eUQvMHhMWk9HQVpHYmxHTnZnb2FBZEJD?=
 =?utf-8?B?T0pGWWJZUkdZUU04WHF1ZEFmNVlvaGxNeXpqOGY0WmxzSk9Ody85K29kUi8y?=
 =?utf-8?B?d0dTbi9OZUQxeTJLRXo1SnByREs4UExWTVFuczlsdTFzT1BJTHhLQ05UMWV5?=
 =?utf-8?B?MEErWEVwRmNtdVcvVm5yRDNXL21HNC9GVnRmRXR2c1BiR1NzR25mZXBMSFFq?=
 =?utf-8?B?Nnk0VXRMTCtLcy92dVhGS0ZGZ05SRGhXNEkvc3F4TlJNRWtjTGhHUVRONitz?=
 =?utf-8?B?bXQyOHA4S3dENWQ4SHBOY0dET0YrMmhaZjdUbnF4MlFLMHVvL3dFOEMxN1Fm?=
 =?utf-8?B?b1BSdldySXowSU8zNXFFRUovMnYwSmJjQzRtMXdPN2h4TXlOU3Vzek9UU2dS?=
 =?utf-8?B?K3hLRGNBcTJoNEdxbW96ZW5sUy8yMFhFV3E2NUdvSnY3bk93aWkvNzJBNENk?=
 =?utf-8?B?dWdzQmh5RkdJS01LelQ1MDNZWUtvd1NneGRlL2IzaDkrSFR5V09OYVdMbWJQ?=
 =?utf-8?B?K2J1TnpEbkppeGlVSE8wRG93Y0Exa1o3TDdOTU0wc2YxcitpMnhFM1Z0QXJy?=
 =?utf-8?B?aXl1dEdIdCswRWJOeWNrL2QyZDh2ZEJSR2U2bzBGS1lVWTZOMjFEbktHY29R?=
 =?utf-8?B?Z0V3NHY0SHl4UFJnVHVMOEc1N2xXVDhqTER4NExXT1RUQ3hiNWdpdVlMejNv?=
 =?utf-8?B?R3publU1cDhaUmRYUHM4RXpTeU5kYlMxRnA2c3QxT0FVOGFaeGF3Nlo0Q0do?=
 =?utf-8?B?T3RLOXFoV241Um15emhxV1FRUzVhTFpYL2hmQWpZbVNzK0ttRVdDOGhkSE1I?=
 =?utf-8?B?dGM5b3ZkS0pOZmZicktVYVFGSjdSSjYzMUhpRmVVWG9UdXJrakthNnN1UzFU?=
 =?utf-8?B?WXVFMmpmRHZDMVJVRmNrYWxkZEc1Y0lDQUlTTmpNSWVxbjF3STRYM0lCSlVr?=
 =?utf-8?B?Tk5rVHN1OGhxYVJpaUttVHArUlR3T2tXMko1WWtwYm5SQmliWVd6RWZrTDNQ?=
 =?utf-8?B?Wm4yUnpib1AwVTlYOXZzckduMVorTFpPYWJsckMrbDR4dzFoWWUzTllMZGhH?=
 =?utf-8?B?cXg3Q2FxdFY5WnpDWmtMUGZqeVMwSkF3MGk2Tm9QNnZkckNhTUhUOUl5RkE3?=
 =?utf-8?B?Y1Y1OXVaeVFFT1F0NDQ4L3NMYUVrMG9zYlowaExBdmRsbDJKTU1FSDAzRG5i?=
 =?utf-8?B?SWJYUVg1MWpaNmZndkZtc2lzUXp3emw3T0tMM3h5WlYxcDE1VGdRd1hXQkxw?=
 =?utf-8?B?M25qUDNrelhXSUZOeHZWUWxqa2F1SWkxWUlpL0kyZjZibElsMis3UnRjQ1U2?=
 =?utf-8?B?L0xpampZazExK29nckh5SVljdjZIRDRRb3lwWGRIMHZQcy9rM1hOdnFxaHZF?=
 =?utf-8?B?TmhUelBkRXdxN040K3hoaUgxZkFvTFFSdys4T21paUcxVDRrNTlvcW1nR3dC?=
 =?utf-8?B?TTMrV2VVTTlKbWMyckZYTWJFdnNEazNFVTIrRVdwSWRIZ1ZUZ1l5NDVXcjVr?=
 =?utf-8?B?amw4YnFxbWJQb1N1VEQvclgvS3hIQlFseGc3NUNobTJmcGpxbUMxVzBRVFU2?=
 =?utf-8?B?OXh1eUpDdTdMckNMbHFxcVNGTHB5b2p3aDlJdWl3V1R3TXRaUmUxZ0MyK3cw?=
 =?utf-8?B?TitSTVozMmV1YTJ1TmVFVXp5RVZ0TnpBNlJLYU5nYWtEdHdTM1dYakZhQ21M?=
 =?utf-8?Q?ggajzFcBL0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enpCOVRvVkxTR3ZqV3VJYUxsS0Vka2ZqbUlUL2dwK1VLd3k3L2VVMjJvSUdD?=
 =?utf-8?B?OVdoSHk5RGFtZVRpbXdTY2hKdmNYMXNtemNlNitnaldoYUZCYVFvbTBycnZk?=
 =?utf-8?B?ZllmK2xCZnFTS2NDbFpmRWZNNnJoc25WRzNwQVRJZGV2TDF2QVp1REllQkpH?=
 =?utf-8?B?bHN0a0dWN2RVZjNiTlRMTlU0Q2JmSDN3UDVvcy9zT0ZpQlFLOE1uUjE5a1hI?=
 =?utf-8?B?NjRxMHh6REc0SEZEMllpeDZCUDBLTTVGUWtyazk4bVh3SkJLQWNMTXRtRjJV?=
 =?utf-8?B?Y1BKTUt5c0trZDlpVFc0RGpQUjB1aTFJOFpNUkc1a1FqV0R3RXV1K1EvVW00?=
 =?utf-8?B?STFmS2VQYVpsREUxd1hDVnJBb2Y0THNQSkNqalhZNGJUZ3BGalp5M21EYnVK?=
 =?utf-8?B?QUNyd3pZSmFwWjhZYk10RlpFQkVzcGpyMURWZFIvOGtMVDdwWEFLaElnMHhh?=
 =?utf-8?B?WnU1VzVkLzU4R1E2UDlpYlExUjdoZmE5RDJldFJyaWthUE42RmFEU3RSaTYr?=
 =?utf-8?B?ZDQ0bWswWS80WGJheW9lY2xOc2lWQ1N2YXQyU3NxVXNtMW43ZVpTT1lLazll?=
 =?utf-8?B?SEpJMVE3SldCdzk4Y1l2OS9hWFo1SUc5WFVTWFIxam9HUjdUN2Y2WkNQRXdD?=
 =?utf-8?B?Mnh0SlV1NnBpOW5rWlBaTHhXYlhHUjhtemtJVlZxek5IVFJiTHJFZTB5c1VZ?=
 =?utf-8?B?NG1EQ1NHakk3WmRlR3BWNHpFczhSM1VpVGRidHlKb2pSYzA3ekpmNlNWVnZ5?=
 =?utf-8?B?RWswNTVMRk5NZG04RVFEQTAxUFRxK1lJOFVUUU9kcWlhdGZBRjZsdlpBZXhS?=
 =?utf-8?B?WXBlZTRlT2hDd0lvZUs5bzFVd3VQTDNsTG8vN0Y1cVYvOENqUUFGM1RWTFhx?=
 =?utf-8?B?Y0RYQmZranpidS9DNjhhSVNydE4waThRc1pWT2FxaEJKdjg1MURZVHZUYzFT?=
 =?utf-8?B?L3NCc25zdm56V1ZPNzVLU2ZIU3FxQWNxRTA4ZTNlTHZrQTY1alVVaG4xdSti?=
 =?utf-8?B?SkNuVENONkcwUVA1aXYxWlJZVEttOHlmbVBOMkQ4Vjh3d3QzMnFZYXFnMmVO?=
 =?utf-8?B?ZTJvWlpaMjl2RWJHUXNpbG00YkRaakVPdExaZlk4cmlIaHc2RXZFMitPMi9E?=
 =?utf-8?B?UVl2RnN6UkF3WXpwdWxkUWl2NHZGcVBDK3hJbEgvYnRMTkszd0JsK3JsclFy?=
 =?utf-8?B?amthTDZVblRlcGUyeTFrRER0UGFxNFhHdDFKeXE2NC9MWEdZMVVBa1hlNWdT?=
 =?utf-8?B?c0RxdVpWM05oeGIwRmltbmVGTEY5ZktVQXdLakxiZ0RLT0hiVkFqQzNsZUto?=
 =?utf-8?B?aUxtSDE1UUF2MEx0NDIwWTVBUzhQWExaYjZIRVhkVUhoZ29YRDAxYmNSWHg5?=
 =?utf-8?B?bnMvTFZCN3JaN0FNWDdESHVPTEtuR2R4bUhHQitpUURnM3JuenhBNjRjTUNF?=
 =?utf-8?B?SGtXTGJIeElEU0NuK0F5VGhMa2lpZUVJd3dpM0lFVThiTmhrMkJyeHMyNGtV?=
 =?utf-8?B?Z1pNc25TeTZYRTVWSDJpc3ROVzZFVFhRdFdVWXVNYWdBK3pGZ1M4MURPaFpV?=
 =?utf-8?B?QnFwUnlocmc4a0RYaUFjazlvWElPUlFXSUJBTlZLQmtXZHRTQUNjcmJLU09B?=
 =?utf-8?B?ZG1MRzFaeHhUY3pSVDVFaENkRW1tcW5Eb01nSERNOEFLRG5IVGJPbGJnd1FU?=
 =?utf-8?B?d1ltMHV1S3c0UTBRbGlUOFJWUTM4UFZYcUxyanNFcHlrQlFZVVNERUhLajlk?=
 =?utf-8?B?RUVWQVRnMGM4Yy9XQWhkeEpXa2Q1Y1JTVDNpOU1nendPNHJYM21YTjU1U0Jz?=
 =?utf-8?B?M1VHVlR2VjBweFlDZjZNR3VtcGhVUk9lejdMT3FOS0lDVnJWUnlpWUlacmlG?=
 =?utf-8?B?RjVHWXRjdUhPRnF5UnF6VjQzY092NzYyTzlGekFlZVdpWHlzbXk4c0VNaXUv?=
 =?utf-8?B?bklPMVRpdWhaL0U5N0V3UGV2bm9rY0hiaCtpWXlRTlZtYjgzWFM5WlBrZjZS?=
 =?utf-8?B?b3Rpci93U2dXK0EvTXRnZHQ2c2dYbWt2RzRCSU1LSFA5RFhOMFFYbEhMaDcx?=
 =?utf-8?B?SjgwTkdBbWJ3K1JubUVkZ3JLVC9peFdYdDhlcXZsbE94azhPKzg4R2hjelJZ?=
 =?utf-8?Q?U3C7TRg+OVMfqGS1n7Fb/p96F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0ed275-e819-42bd-37dd-08ddd4c155cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 08:14:59.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SISQIqyZxjcWfQTHhVZ1D1jB+x3nDcg4KJVxVBSkHh6GKMCZsZydV4yFqD5JQliSIzpVVTIIHyvMLPJhKdaSBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271


On 8/2/25 02:45, Christophe JAILLET wrote:
> Le 23/07/2025 à 19:31, Abhijit Gangurde a écrit :
>> To support RDMA capable ethernet device, create an auxiliary device in
>> the ionic Ethernet driver. The RDMA device is modeled as an auxiliary
>> device to the Ethernet device.
>
> ...
>
>> +static DEFINE_IDA(aux_ida);
>> +
>> +static void ionic_auxbus_release(struct device *dev)
>> +{
>> +    struct ionic_aux_dev *ionic_adev;
>> +
>> +    ionic_adev = container_of(dev, struct ionic_aux_dev, adev.dev);
>> +    kfree(ionic_adev);
>> +}
>> +
>> +int ionic_auxbus_register(struct ionic_lif *lif)
>
> The 2 places that uses thus function don't check its error code.

For the eth driver, RDMA functionality is optional hence return code was 
missed. Although devlink parameter to control this is not included in 
this series, where it needs return value from this function. Till that 
point, I'll make it return void.

>
>> +{
>> +    struct ionic_aux_dev *ionic_adev;
>> +    struct auxiliary_device *aux_dev;
>> +    int err, id;
>> +
>> +    if (!(le64_to_cpu(lif->ionic->ident.lif.capabilities) & 
>> IONIC_LIF_CAP_RDMA))
>> +        return 0;
>> +
>> +    ionic_adev = kzalloc(sizeof(*ionic_adev), GFP_KERNEL);
>> +    if (!ionic_adev)
>> +        return -ENOMEM;
>> +
>> +    aux_dev = &ionic_adev->adev;
>> +
>> +    id = ida_alloc_range(&aux_ida, 0, INT_MAX, GFP_KERNEL);
>
> Nitpick: why not just: ida_alloc(&aux_ida, GFP_KERNEL);

sure. Will use ida_alloc().

>
>> +    if (id < 0) {
>> +        dev_err(lif->ionic->dev, "Failed to allocate aux id: %d\n",
>> +            id);
>> +        err = id;
>> +        goto err_adev_free;
>> +    }
>> +
>> +    aux_dev->id = id;
>> +    aux_dev->name = "rdma";
>> +    aux_dev->dev.parent = &lif->ionic->pdev->dev;
>> +    aux_dev->dev.release = ionic_auxbus_release;
>> +    ionic_adev->lif = lif;
>> +    err = auxiliary_device_init(aux_dev);
>> +    if (err) {
>> +        dev_err(lif->ionic->dev, "Failed to initialize %s aux 
>> device: %d\n",
>> +            aux_dev->name, err);
>> +        goto err_ida_free;
>> +    }
>> +
>> +    err = auxiliary_device_add(aux_dev);
>> +    if (err) {
>> +        dev_err(lif->ionic->dev, "Failed to add %s aux device: %d\n",
>> +            aux_dev->name, err);
>> +        goto err_aux_uninit;
>> +    }
>> +
>> +    lif->ionic_adev = ionic_adev;
>> +
>> +    return 0;
>> +
>> +err_aux_uninit:
>> +    auxiliary_device_uninit(aux_dev);
>
> I think a return err; is missing here, because, IMOH, 
> auxiliary_device_uninit() will call put_device() that will trigger 
> ionic_auxbus_release(). So kfree(ionic_adev) would be called twice.
>
> I also think that ida_free() should also be ionic_auxbus_release() 
> (just a guess, not checked in details)

Thanks. I will fix this in next spin.

Abhijit

>
>> +err_ida_free:
>> +    ida_free(&aux_ida, id);
>> +err_adev_free:
>> +    kfree(ionic_adev);
>> +
>> +    return err;
>> +}
>> +
>> +void ionic_auxbus_unregister(struct ionic_lif *lif)
>> +{
>> +    struct auxiliary_device *aux_dev;
>> +    int id;
>> +
>> +    mutex_lock(&lif->adev_lock);
>> +    if (!lif->ionic_adev)
>> +        goto out;
>> +
>> +    aux_dev = &lif->ionic_adev->adev;
>> +    id = aux_dev->id;
>> +
>> +    auxiliary_device_delete(aux_dev);
>> +    auxiliary_device_uninit(aux_dev);
>> +    ida_free(&aux_ida, id);
>> +
>> +    lif->ionic_adev = NULL;
>> +
>> +out:
>> +    mutex_unlock(&lif->adev_lock);
>> +}
>
> ...
>
> CJ

