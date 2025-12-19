Return-Path: <linux-rdma+bounces-15105-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD51CCF92F
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 12:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46D0A300661A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 11:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7163128A9;
	Fri, 19 Dec 2025 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T4PYMfs9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f3fLU4YM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD83126C1
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766143746; cv=fail; b=mcJThzGTOrOEKZ9VuYkVeXULp9NuIEGH6WSUhEUKOjMuV58pNpWhfKD50OGPVFggdV2P/x+qDkSYMzA8W8HuDCHajfEsBo+KfUCRPYfxDd+ai9ujl0NagT+Zta/6YXly5In2he2v3liCuvC5cJvysqjRJf6ZxI2lDH0YwjOSlXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766143746; c=relaxed/simple;
	bh=k8xjUFUNXoD2S8I0mOfLorAFglu26IziJUt9FuDfxp0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LLUp85DIiFn8yoWWTixXkkmC9MFua8UMvYb6PUwjvWhvPFRCqOHmeQUZKJlng8OzFY89CalvVo+hU4wco4AW1mfBEdzjHuRBkQ5A3NwFHjQIwoH1lMetNZSNTbsGixtpjvGPRUhH3IC0DtCqI14rCy7G3D+WYYKRePvqYNpcqho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T4PYMfs9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=f3fLU4YM; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766143743; x=1797679743;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=k8xjUFUNXoD2S8I0mOfLorAFglu26IziJUt9FuDfxp0=;
  b=T4PYMfs9goDK8XBB8W9WFUDQrhG2p8RVZiqdjupC3MkSSPrkQ1GzD68i
   AenS6pMZLLN2jhCXKm7U8uinDI9o4sVMSWK5fd2TxhgQS2urTaLPO/BzQ
   nPwpr4CKRREGUL4jzkyx7FJ7G4wJVlzPFt3Pu0/+bWNeGEcd4ROYYqHf8
   IDifkEWb99Yss7vr/lOlx7GZfok22hE6JI0Ani2jw912zoRaxqzylFAPr
   63FKFiBGJljLjrQAL3YQ/bHRrQPy6DFznLimyNoOirYIThII9N7bo2CEG
   c6zREG/AFRfCYke1wmJP7IkovO/w3L1+FftL6Wyjs1MvXZxJxUm53FSCj
   Q==;
X-CSE-ConnectionGUID: tI1M6A7rTbKi+ZBsxEWlLQ==
X-CSE-MsgGUID: ZbShz96DS4qQyluLoDUEDw==
X-IronPort-AV: E=Sophos;i="6.21,161,1763395200"; 
   d="scan'208";a="138654535"
Received: from mail-westus2azon11010025.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.25])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Dec 2025 19:29:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpbkUAFoR29xudngffMN85EZwwa89KC/4rVnX5MNOyKOXSxKgFhgqcOtKKODiq01u8rCpr+GYrDgoYhzBdSShci5r1fyJg2kpoGA+WeaBriaC8DC7YRmvXIbW3uI/VRAgh57MeLBbROxLHAKcFEoThahXJcZuIMaYttPks+Yo/B3eA9dSyDSVkzrBNstdDwnUQQN6Zp1bR+ieRkUJOsm/wr39QeI92cC3N0vWtfvqG2r6xdSkbxq8qhtEK71l2Hquc4p1Cx3Pj6tERnC+Xh9OLv7vNPoXAq955+3EnDJd1a5mgHgB3icSks/h22a9J/PkZ0X2G0z8/9B1O/N6Mz9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8xjUFUNXoD2S8I0mOfLorAFglu26IziJUt9FuDfxp0=;
 b=TI9TN3Pl4pL3dLED1Hw2+pJzHQfPvVQjzIZE/VTqhJ2HQlCPzKYCUApiltE95cAN0lX8pWKYt7GD/9JuOI6pPiWwBxFXJGW64RpN7ZVjSEQgRo26IhO/mg2maQZ8TLv9xmAABuPFJQZR1HxQq4aXZv1+WT4I1CjWoCuyq/yYjTEvqQ17MZaxRZxnQ8ldNR08zd729nzK/r+CzZA69S/TBkx0C13QGPGIzK9lOI9ErVhPs9xbznJgbUz3euLbQk4aVyvF3rB56sbZQeJ+G+8SKn9NIL4bCl3PRZLy4emyawiLI9fZoV5E7zDH2GFbwxmPH/kyoH/SN2KBT7AXMQJKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8xjUFUNXoD2S8I0mOfLorAFglu26IziJUt9FuDfxp0=;
 b=f3fLU4YMISAr+JA5TUAdNZtmI3Aj7UiBTNq/QrVHHMcy7G69kdd1oOcWsgrgRLHpxSe6Fq8k/ZkhqgGr3KhK+VenFv+XTvnN14hUj/rcO03S+pLr0plcTs4JdX3AFeDAVTzInKpyO3/Eg0LG85/HwBXnOXYMczWQKa82Nk4CCJE=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA2PR04MB7611.namprd04.prod.outlook.com (2603:10b6:806:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Fri, 19 Dec
 2025 11:29:01 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 11:29:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: Stefan Metzmacher <metze@samba.org>, Leon Romanovsky <leon@kernel.org>
Subject: [bug report] rdma_rxe module unload failure with DEBUG_LOCK_ALLOC
 enabled
Thread-Topic: [bug report] rdma_rxe module unload failure with
 DEBUG_LOCK_ALLOC enabled
Thread-Index: AQHccNqsjzVQPZSJAEeuIJj5Da+rsw==
Date: Fri, 19 Dec 2025 11:29:01 +0000
Message-ID: <170e3191-7e15-4af8-948f-14904fe260cc@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA2PR04MB7611:EE_
x-ms-office365-filtering-correlation-id: 9b995553-33d7-4aa8-ae6d-08de3ef1ceff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?djZ6UHhwU05zeXhsU3lvRHpQSklJUXRzU2F3RWc3dzVqNzVWekxZV1lCcElO?=
 =?utf-8?B?Mk9IbktNb2YvVW5QMERwYVluWUVibVg4czlZZTNlcCsydVpOV3IrNFJPNWl1?=
 =?utf-8?B?Umx2bXYwd29iSFluWk12YlpBRDkzZUQ0YzdGMHdVeTMwQXN3R29TcWx2TmRY?=
 =?utf-8?B?M1lvM3o1SGN4WDVoNW9RbElZOXF0VVNtc29xb05VKzVvTWdtc2w5MEdWaFoz?=
 =?utf-8?B?UVhzZWxVSnlMVnBMRmY1TDg3QWVOcHBIaHRlNVdIWXZKZTNFN3VvaEhoQTl2?=
 =?utf-8?B?bzhtdVVlcnNhTE1jRFlQYmNNMW1BT3lPSFR6TWZRVDdzTTFKUWhNeFFvNFVu?=
 =?utf-8?B?ZlVCVHJCTXJzMDFBRC83bk5XSnovV0pHbTZKS2ViV2xlZVhURU1EN0hwWTVG?=
 =?utf-8?B?dWNxenFYcGtORVlWZjFJMUo2S2xDdFhHb2pYdkNKWlBHeXc2cXpoU3ptTmdS?=
 =?utf-8?B?aHRJVm1FOWhkSGJHU0g2b1pXOEt2T21FdGg4b3FyTWJ2YVdIaDNtZTBEY3U3?=
 =?utf-8?B?dG85TkpuZVo5QUVrR3VOK1lndlg2anNqREt1bHNXcmxpYjlyU050RC8zaG5J?=
 =?utf-8?B?cE5ydStsMEVBS05LL284Y2dlT1BkUUFQb25obHBKQmN5SnBlRkVGMXk1VmRM?=
 =?utf-8?B?STQzT0J6d1EwajdONU5PYzRWeHJFOXVBaGFJbDVlRTBxdzd0dVlURm1ST1VO?=
 =?utf-8?B?YzhoVCtyZWdMdzV0c29uQ0oxMk5kelhlTjE3eTAwNURIZmxrSWFwSmU0em9j?=
 =?utf-8?B?VVJnZ1BnV0xwQlFTdHpCcXRMN203ZkFiczFqQzRPb2FKOWpzL1ZEellJMlYr?=
 =?utf-8?B?aXViRnZrYTVOUDBVK0xDR0Z0Vy9FUXEyVnFPVmxWR2VsV1lPcWlsbDVaanMy?=
 =?utf-8?B?RmxsVEVHeXd2V2lRUWtXdUhkZndKc3BHT045K016cFRheENXdFAvdkRqUURL?=
 =?utf-8?B?cEVZUndJd1lzUWI5LzM1SnJGOHpSSzlCZzFBRi9pTDJRSWE2bnBIcjZiT3pV?=
 =?utf-8?B?bW54d3hVb3M1V2NwNE1ZVy9mcmJVcC9MWmE3a096VlZDcitndzRsMHVkaVRU?=
 =?utf-8?B?UGx3VEgvOVJONmRQMEhvdnVtdFF4L25qV2JWY3FCeEEyM1VUa3NtSS8yenUr?=
 =?utf-8?B?WjVWQUp2Y1owZUkzang4QXRTbDRGa2FPUjdMSkRFQnlZbnI4cDk0THdCMml6?=
 =?utf-8?B?S3Ridmd2bElPVG9GeWhDUmxoSS9xTGgzeDhkWEc2eGVPYUg5cGJQR1dUK0pj?=
 =?utf-8?B?M0RCaExRcm1LVllxeVFmeFJSRXlLeXk5d0NSdTU4SEk3eHF1eGJ3OVNLWFNC?=
 =?utf-8?B?ejF5U3hoWDllK0pFMFpoZGZ2U1lNOHdmV1pZSXYrNC9rVy9xaGk0VXVsVUVl?=
 =?utf-8?B?VVJuelV2WG5uM3RUREU4YVF0c05wZ2ZlZ3MvU3VsSW1vN3hhbGtmNzlrclcr?=
 =?utf-8?B?RXJkODVrc0NiU0Z5Mm5pcTBwbC84N1lJOEl6djJtSWR6YXVpVER2WDVjT1hQ?=
 =?utf-8?B?aWQ5UjFVZXZGamRRSUpaSTVDc2ZFc09aU1h0anpBOC8raEJscnAveU9GMU8w?=
 =?utf-8?B?Y1dqVTBYejhBTWlZWUdFT0w3WnllcHd5QlEyZXlNN0NaRTg4LzE4cEZ0c1Q4?=
 =?utf-8?B?TUpycmo0dmRoUlY4NGVXaG5ScTdmSlBtalhPMGtWaWdFbWt2UVZ2VUF1S1Rh?=
 =?utf-8?B?akxMUHM5Tmk1ZEU1ZkFudllrU2djUjI1K0NxUVFDSWJYb2JNM3Z2WnNMSVJR?=
 =?utf-8?B?ZjRObHJlQ3YzbzFnNEJnbDdpRXg2N1dPTGdLbGR2UmgrZlFEcXdXdmk3aHhi?=
 =?utf-8?B?ZW4wOG53YzZ5MlFLYjFQVDNRYUw0QkdyNFViMkFXdk42TGlZY29UOXk5SFZB?=
 =?utf-8?B?KzZiellDRlFxdyt5NGthRVpYaGpvYWZIQk4yY3ByTkFNVkZrUlBoK2Z5RDFD?=
 =?utf-8?B?bFZOWEc1SVdlZUREdnNwVFduYXJ6MnFaTy83cndHUWV0R2J4d3NydS90UnZo?=
 =?utf-8?B?Zm5JRWR2anRpRyt0R1Z3UHJUVVJZeUxUcWtDQWt3RlNpNWVPS01Tdk4zSWR5?=
 =?utf-8?Q?sIq4rU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3E5Q0lrVXBjZUM5K3hURERmc09mbmplSjJQRHE0dWZKaXRKUmNyby9wZFRy?=
 =?utf-8?B?T2orTmhiaElBb1BYbUg2MDAwb3ZPQkVNemtKMVRvRjF4MVFzUGUwcUc0Y3VT?=
 =?utf-8?B?VjgxaHFicHprVVNjUVp4ZGZDbXRtRk1YeFlpeFFJTXVpMCthQzBKNHp5S2JT?=
 =?utf-8?B?RWdnM3dUanNLWVRVOGVlcHJld3JQSXViQTVwT3R6NHM1cGZBb1ZMU0NEWC85?=
 =?utf-8?B?d2Z3OGZRWHh6ckRDTEdLM2YxOWlWdzF6RGcwdEgwZitzZnVjRTNhMzhUWGkx?=
 =?utf-8?B?TEo5QjhsaW5tMEEvQjRZUTh6bXVIckRDNlArNnZSN0VweDM2NWpjcFBlaW5U?=
 =?utf-8?B?VkNpcE1ObERYU0JPUjE4cHhIRmE2STZ5UjRiaXJtQXljM2w2eUdNU3psTXI2?=
 =?utf-8?B?WTJJSVJGeThBY1ROcWVrWVdqdHZuUjdmdzBPcFR0NHVBN0dDZEVOalpnbEdx?=
 =?utf-8?B?aytjOE1wQUpXRmppRXNCcWdLRTg1dFN0eS9KbTlLNURRNUZBeFh0OWdPNTdX?=
 =?utf-8?B?R2wrc1BmaGtyUzBqbUlrNVhpRkhTd0l6c2xjdU90T1RhNDJWVW5zbXNHUHFU?=
 =?utf-8?B?N20relY0QVNvdklHcloxSkhmNWRkQlJBb1ZLVHA1dzg1ZXdWVGVKK3Fncmh1?=
 =?utf-8?B?bU8ydTZDaGFmcE5JdEppZ1lYYlFySGFpWDhCOXBGNGtMbFQvdWhLTUs0VHBY?=
 =?utf-8?B?UU9vSklxVFFUUkMvTm53K3JjR0hjaXBlTWphRjZPS2JxOU9EUjZ6Rm5YNlZi?=
 =?utf-8?B?WjFrSWl0OHRpM25TbWpUM0pITkdaSnhnMWxiS3c0UDcxdmZhOXlNSHo2MURm?=
 =?utf-8?B?a3lBZXVZVUI0TVZnMndQRUY2bXEvU0R3SGRVRVY5N1dIeGtvRnF6M21PZkZH?=
 =?utf-8?B?US9xSlV6ck9NY0FsT0krL3ljR0t1VHdobWFjTjVQa2x4dE1mWjlyVERENmRZ?=
 =?utf-8?B?YUNEZ21oNEhsUWlGVG9uZHZxMXVLNlUxek95QW5SbmIrNTRmaFpHdG50Njc3?=
 =?utf-8?B?RG1qVGh5c2FpdEQ4KzM1NFJvbE5Cd3dGc1RuNExRUXk2ajRzbU8wVGY2NVFS?=
 =?utf-8?B?c0hKa3lNVDlybWt2cWRkSDFKVkZ4UVJKMjI4T0lsMWpkd2lETUgvY2tqYStp?=
 =?utf-8?B?aUZ1cjFaRnJuT3BuanlwZjVpMEJOTGhKaVVsTFk1Z0lJWlMyK0NmdDU2ZENB?=
 =?utf-8?B?MlNxRWhVRlJiQUx0ci9YUWhqQjVnNzdrZm54RjhPakhWUEhESjJvbTJlVEhC?=
 =?utf-8?B?Q281VkhwVmphR0ljUG9CVUVmWFoyV0llQVFma2lVSFNGeVJSS21xcHJrZWdP?=
 =?utf-8?B?UDdxZlhMZWNFRGhNZGlXVDBLWDhBL3FSN1FQRnpLWDhxUjJhRHpkTjVrV0ZH?=
 =?utf-8?B?RzVUZWd4cDJuZTA0WkdJdEMrR3RZb1VhWHozeGhHWmh0alpnMEltMFZsRUJu?=
 =?utf-8?B?UDZ6d050Qlp6QlZKdjg2a0RJeVk2a08yT0hsSFNHRjJUbEVpN3Q1amFZYmtL?=
 =?utf-8?B?STlnRXBrQ1BmSzlTZGlrUDFqQlVHNDFBS0x6bEdrU1A4NWxSVkNtS3piY21P?=
 =?utf-8?B?NE5wa2RaTXF2Smt6SC9pcGpxQ0h5eTRMbEZla2owNVhkN1gxSldjUE0vRWIw?=
 =?utf-8?B?bmE3ZlBIMEhIQU5OYktBNzh3Vk5Pd3VaNUJCODFWZnIrZ3FoVDhtdXdPak1E?=
 =?utf-8?B?bTB0b240RVZjbG0vVHIrdTRVUnEyTE9raWd3MmFLNDZpYmI5VkRiUkdrbmJ3?=
 =?utf-8?B?TTBuSExRdFcvTER1RUdmdlF1cmRjREpKVDE5UXBDanA0YW1ROTlXUklHWHJj?=
 =?utf-8?B?NDN4clNGVGw1aWFabmN1M1d4TW56allxUVdmMnE5U3M2eGhkZkxsbTY1aHlG?=
 =?utf-8?B?RjFDMTNlZE11a25MdXZINGRnTHV0NjF0TU9NSnpBR0xCWmkwSFNHSWs4cXha?=
 =?utf-8?B?WStvZ1BBT3RaaGZaWGhMa0I5RXIxdElGTW1aVUlkNVV2V1hpYUpMWUxUV3Yy?=
 =?utf-8?B?d3NRZFpwSkpPR1RvOUtXTDVXWktIbHlzYURac2NUbFNiSFowQi9CSkU3UnQ4?=
 =?utf-8?B?MmJUMTdLNXQ4MDZGeGJWc2dDcldNSFRZR2xEVHhSMWJDNVhUY2piQSswcVUw?=
 =?utf-8?B?NDlCOTg5MmJLSU16bFRYczlBdFdEUGpqQ0l1WnpGYzhLMUQvNktMMXZWWlVR?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3A8896B159E8848AB1C7498EA4ACCB4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nlHmHfQST1d5bI9aA2aMEtsb6I32ZGisiB7XMVMep3AHZ4jM6HxgqOwPMiQRKMh6wgN9PbJM45HGm3L9tm9zvPuFHLaar0fcXw2ABRRTJtKgnqCd3Tu9rb5Z6p7K26dpcAokG/yDmxdqCCgG0So5baTOpnKMlhtLMF9neRNtrmGHN1F2htfEwKZ+BZ2ysl30Da9EH6qK4VMa27YuMeqBpHLa7ygY2o8Yoejt3wRsPpP4YpR/2isSJ06Mf56dLOQLnvD0hYH+zg2RNvuPBZaiJpIPRvGoknlDbhqwcJhG+4StfLueFaVwL7jEvTZ8pbuLoSqLToX7hQxgT7iF+hjUR7/3bP/Q+y/e/fBj7rdPothZJdYoXwm/qsidlaKGuzTXY2B6iroQkKWhFQ/qbNS1I7IRi8cBy4ydGqHT78ik6IES4sLQzZ/1s6WXS+yAKT6jZtkqeWy8uGM42MAbz/nFRCtbw/5NgovT2/Olmh7Fvayy9MNFKleIS1ZSRVp0TVm2F1jBDW8ggiL9TZjPmGGr96JER8feBO76Ff7ubqVY03U3jeHKXKqsI0HvyDEyTJESz1T0PRn+zkmtdDgYgLKpD6c7Oce8i1muw6QeZCV6aY1Zjl9Fx3iFKoBWUUKDg+lA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b995553-33d7-4aa8-ae6d-08de3ef1ceff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 11:29:01.3587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVtmUerVjb4go6QuV3DUBJa5mWHx+RNiU5tqdOjCB0hq5xf9ePbhCcWVCaWAXq5GqGdtEF3xL9NFGECqzhYHQs953xTndf296ygIiLDw2hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7611

SGVsbG8gYWxsLA0KDQpXaGlsZSBJIGV2YWx1YXRlIHY2LjE5LXJjMSBrZXJuZWwsIEkgZm91bmQg
dGhhdCByZG1hX3J4ZSBtb2R1bGUgdW5sb2FkIGZhaWxzLg0KVGhlIGZhaWx1cmUgY2FuIGJlIHJl
Y3JlYXRlZCBieSBzaW1wbGUgdHdvIGNvbW1hbmRzIGJlbG93Og0KDQogICAkIHN1ZG8gbW9kcHJv
YmUgcmRtYV9yeGUNCiAgICQgc3VkbyBtb2Rwcm9iZSAtciByZG1hX3J4ZQ0KICAgbW9kcHJvYmU6
IEZBVEFMOiBNb2R1bGUgcmRtYV9yeGUgaXMgaW4gdXNlLg0KDQpJIGJpc2VjdGVkIGFuZCBmb3Vu
ZCB0aGUgdHJpZ2dlciBjb21taXQgaXMgdGhpczoNCg0KICAgODBhODVhNzcxZGViICgiUkRNQS9y
eGU6IHJlY2xhc3NpZnkgc29ja2V0cyBpbiBvcmRlciB0byBhdm9pZCBmYWxzZSBwb3NpdGl2ZXMg
ZnJvbSBsb2NrZGVwIikNCg0KVGhpcyBjb21taXQgY2hhbmdlcyB0aGUgZHJpdmVyIGJlaGF2aW9y
IHdoZW4gdGhlIGtjb25maWcgREVCVUdfTE9DS19BTExPQyBpcw0KZW5hYmxlZCwgYW5kIG15IGtj
b25maWcgZG9lcyBzby4NCg0KQWN0aW9ucyBmb3IgZml4IHdpbGwgYmUgYXBwcmVjaWF0ZWQuDQoN
Cg==

