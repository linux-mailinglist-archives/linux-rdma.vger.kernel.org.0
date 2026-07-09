Return-Path: <linux-rdma+bounces-22959-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0+EiNCB+T2phiAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22959-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 12:55:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1573A72FEDD
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 12:55:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=NVoWomMX;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22959-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22959-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40D8C301F152
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AC640DFA0;
	Thu,  9 Jul 2026 10:51:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25663F44E2;
	Thu,  9 Jul 2026 10:51:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594306; cv=fail; b=seMPxORmzZFK2clBpO28u2jVwUXMXStOvskl0QRUwb33MZHotimtX6Ix0fi7Ub3cevZcLKGP7vxw6iUCR5Yae8t7/8g0ZhCdfAjBKXEU6FVdJ+o8DcHDvk7+txm9EicjoZ9/k8r8ayIMhb7RK1AWAVtKXyVNH75RSrlG52jCv/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594306; c=relaxed/simple;
	bh=W20PRZc+4rKY3oy15YsaBGLdwMa00WYcDAx/PL2LqIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RnlgwrjKr+zeUkevaCclmVo4q+lCsXoAQv3Hal79HI4Iyj7mpmNNElW/scE7gr75O64D3EKwxgQPfmR59K59+McO/wY/AWlYoOx02mHme8R4+fifa0bOygIps8gXPHg6RXDRhIqKcPV+qpITUBuGhT1UPQvSgO/OrodmjiHwF4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NVoWomMX; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tN6ivCd5ILpCkV853vN/MyST8HIvTKLt5lV7sdCiSvkGtx1LUDDF6dgIElq9jCQyjVhDf3vLejDIgGEDF2iCzMpNgAuVxS+VkoPeIDYSBnbn3TIzdYEFY/zzOy4pOh5/SkpghlkTPohTk33e2JtZpywWZiD0hd0k+GlGmsjP00CpE6Vmi40kqCOOmX9rtLV6p3LZcK9VFA0KjoTi/0c4hHYc7ooKsQEQaDQA54WuuZMH9NOUFRna0jIQJ3rKHj7NBPJEoRx8wsglXvPYDdYLs8wj/at//08BKYbkozk3GAJjLIsX45nhWSYFYZx4hYB+auLVTpyoMK8FxciD4NRiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W20PRZc+4rKY3oy15YsaBGLdwMa00WYcDAx/PL2LqIM=;
 b=sRlp/G4iC7ZFZNbFo4fX8KL3aPjAQVgKDAzfbbFcPQuFDXogxxWHq1rmAkSrQKQdvsdHEKvztrHcb2NmjsvKTkB+1NeoIgLmogxy29Vg9oLaA9RXyEUz3hIB9mqtf32LUD+1l316GB1QyC6FrEmiwMQu1wNcgu/tLej5+UuTjFDmfnJpMxfCDBI0/et+9GQQSho8EzwBjc909lFw7WYbnfawags2xN8pzZxzw2yOL4O0LqpALiYQgdC9B65kvtLh0ZLyZaFrq+vPo0NJ/28kQSrawjF0tbXN67+f/W66uN1iQ7zQCdgIAjTOCv0wBLl0Fw949EURv4RZYIodpC+v6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W20PRZc+4rKY3oy15YsaBGLdwMa00WYcDAx/PL2LqIM=;
 b=NVoWomMXZJwkLMwkA3q3CFOigPwkUpM11amNl/hMKj/v784jIRmBCn7ttnwl3TxKwPkL3+IlatElq9mynqxWIVvvo0SMDntKskl17gYeCFGm8BOrkhgvZtHrsTKLohxl/BphqOubo9gtv84tP5GETZIrfdthC4ZD3sm64ZF3OsV3O2U+OluRAfewwE43Av4YwncTdmX+lC4Ow7MGMTQ4rUVTVtwdjTQrVJGWFE+gtqpfJcrE3xGgAX+Db6vlqsM6yKcoDzFHsIpMosuEdSdWCsIrwZkINtJWefhpJXqob3Pe1kuGXRw4tpBZK4uWKI6P/i+ufTPF5M6Q0DZfZB79gg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CH3PR12MB8756.namprd12.prod.outlook.com
 (2603:10b6:610:17f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 10:51:35 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e%5]) with mapi id 15.21.0181.012; Thu, 9 Jul 2026
 10:51:35 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "daniel.zahka@gmail.com"
	<daniel.zahka@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Boris Pismenny <borisp@nvidia.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>, Jianbo Liu <jianbol@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Raed Salem <raeds@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf.kernel@gmail.com" <sdf.kernel@gmail.com>, Mark Bloch
	<mbloch@nvidia.com>, "sdf@fomichev.me" <sdf@fomichev.me>, Saeed Mahameed
	<saeedm@nvidia.com>, "aleksandr.loktionov@intel.com"
	<aleksandr.loktionov@intel.com>, Gal Pressman <gal@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 00/15] net/mlx5e: PSP cleanups and improvements
Thread-Topic: [PATCH net-next 00/15] net/mlx5e: PSP cleanups and improvements
Thread-Index: AQHdDhH7PELuU083kkWlRqf026mokrZiYReAgAEv+ACAAXSdAA==
Date: Thu, 9 Jul 2026 10:51:35 +0000
Message-ID: <3a8a33b0822e82d8a37aeb7e9c326889074e458a.camel@nvidia.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
	 <0dfe5f6b-dbc8-4104-8883-e88e8e59ab58@gmail.com>
	 <9c6a65b7e54a31dea87e7ea1c5b1b3931240f3ac.camel@nvidia.com>
In-Reply-To: <9c6a65b7e54a31dea87e7ea1c5b1b3931240f3ac.camel@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CH3PR12MB8756:EE_
x-ms-office365-filtering-correlation-id: b6879c41-6e70-4247-aaf2-08dedda80bcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 BgPVIFwo5UZD/ds4UhdqEnVhIrCiBJ8n5tnJYDObS8ApFjWC+dGcD6LFdTs3fMK7xzR+xS14aRzq1N9i2z7eQXjAGxKo5ZYNo6jATWgyV+Fg59sA9Sr6IAg8NSbE+QhneJmx6ZKGf4QqqXwZd3BmVBXLH4Nyu2mmZxGmPegl87FtYsoYIXz3vk7cGxlbzvDBxlF19xhJsGosOSxgIodaN7eEt8WLcL8d4ODgwK1wAybmQczZ25mL8ZgDOU9Enqc6P8fsYMXW6LAjBe83fQ+FIbM2vHzj6jIYtpYfxpvW/qYgxR1ndG+dWM38Fhe2rG3oIfvyEpoO8Y4YD24Z2O6ftDaOawJ/LeAw8jn9DL1MxWD3ucRRHVfBpQ7ZmFwxgTVdqu4YN5gtSP7JB0b1F4fErUYcAwHLMDl+5BSgGbJUQ6S/ot4ufNslScMbz7FdSgST5o38cSDlU/CdIEsaZjfjePaPEFr62DWzQdG4B1B3el35NTHxJs5OcgeFSzeJVojkXnV1ioffheVcoQRnZUvpz3c5s6LlE+AoJLK9N7IW43e+eiJkZO38Ow+Jv03/9cNUiLwLpZVUR+8+RMF4qvJh9D/+wiWR5m7V131bDsm0x2X59qPTMNE0+2qNGZY9Pu6c4EoF6srAjduBI0npxO/v8YYVXNquf05rPqRb3PgQCz/4NClP9yweOMNx+HuGnIjtbH5pgWwAhpiYdyxq23G5/eAYJ1uNCVZ9210NfMX7Hjw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGhic3o4S0VmMHZPS1V6N1hkRE9QMmpJVXd4MlUvTEdtYjI3UGY1cVdXbngv?=
 =?utf-8?B?bG1BMXdhRFJXaFFkSXM5cHZRVW9GZXl2VkQ4Ymc2TjRBZFQ0NXlkdGJlTkxW?=
 =?utf-8?B?QUdTQXpmNldyTkEvTXdFR3BBcDFJc0ZIaVNFS1pWbFN0ZVduYWp6anpjY1Z4?=
 =?utf-8?B?dDRXdHpXeWoyMWZndWdUcFB2UGFNMmJMY0RwQXdvQ3ZXVDg5WHVCSGFHbisv?=
 =?utf-8?B?bjVkQWs0Y3lYczNOdFlLVENYYTFaQTFwNUdZcmFlQTdIMUFvcXc5VHF0cVI4?=
 =?utf-8?B?YStuSHhnRnY4RTNHb3MyOVJRWVptWWtsU3BJRnFvbzB3UFV1SHF3L2dvSnZZ?=
 =?utf-8?B?cTlMMjZkdlBzbVZGQzdjazZ5Sit1VlhVencwRWFRM3dpZlBRU3VCczRiQlhz?=
 =?utf-8?B?OUw4RnVsdmRWcXN4aVhud1J6QW9qc2lzVWczMUQvcnQ2ZnM2K2h6NmkweW1t?=
 =?utf-8?B?Z25WRStmMGVrc3k1SFBybUVPbVB6VEU4emUyaU8xMlhyTk5XWHNjaEVFK2Jo?=
 =?utf-8?B?Y285d3dFVUMrKy9GdnNXdUx0dXl3TkNvbVNVNmxXMXg5c1llVDI5eXpMbmZn?=
 =?utf-8?B?OWcwSEpWV2xMZkNiQVo0akpCYmV6dGJXb3E5UDl1KzNFV2FCSXlpaTBUVmJx?=
 =?utf-8?B?eDRoNGtXUk5FSzhxV1IveUNEZWR5L3Y2L2tSeUJnazRBaThGZ21MOU05cUcv?=
 =?utf-8?B?NjBFM2xaMlB4cE8vYlFKWDBTM0VUNkJmam14M1ZKRHNObEE1ZllyK0krWHBx?=
 =?utf-8?B?a0hIY2V0dFc3TG5zc1RsS0JZQVZ5NTdtazlHaWNHM09aMXV1M2Ftb3V3aVdr?=
 =?utf-8?B?dGN2TThsK2pzaWZkWUo3VlQ5TzJnTUd0UVNnRHoyV3h0SC9sTUFKY0tTaXF1?=
 =?utf-8?B?eE10aEtiZTNKVnhGdnladGt3M0w2SWF0QTRTa0tuRnhNOExsVkp1VXVUNGw5?=
 =?utf-8?B?VzlSMUtTbUtYV3VjcGpvQnFNZTdrcHpKdno3aFBLMEYvOXlWckpQUU9kVEl3?=
 =?utf-8?B?Y2RuM2p4VVlwOFpidHZZRm0wR1Q1eTZwbFRLNE55QWNLR0lmM0FobHA2cnc1?=
 =?utf-8?B?Qm9uVVJpMnI5QnJwRitmcXpCOG1nWis1SDZTUU5hRFJMRW10Y25wNlhBd2dt?=
 =?utf-8?B?L1lmNEtIRHdsK3c3T3BKakRzTTBNeU9EekF5elpxSm5KVHRsMml5VCtLOFZy?=
 =?utf-8?B?YTRjQlczdlFkTUZaM2ZJcEMxY3BIekVRU1Y4NGZhVjZEbVZqUkNpRXMxMkU0?=
 =?utf-8?B?YUxVRkw5aTlZVSt1UHBwQnhzbDYzSGtvRnQ2T1JZNEV4TlViZVkrWW5OTUxN?=
 =?utf-8?B?UUQ3OUtoWldXdGhHbW1xTWFrU3BtTHcvaVpxZktOMGw2QTY5RlQzeHhLcEM1?=
 =?utf-8?B?aEYrTWE3NkE5WEtzdHJDNS9OeThGMm16NTJ3cGowb1JaSVJmZzJqUWVYL0E3?=
 =?utf-8?B?emo3ZVVzOHl3MWxrVENUY3VUYmJvNzN6NmFUeVl0bEp3Zkc2SCs3QnRvcis5?=
 =?utf-8?B?elJRb3VqUlRmM3dMUER0M0F3Qm5tM2JINXVSMnptUUxTajg4MmJ4Q2JUT1pO?=
 =?utf-8?B?SzRqK0JORlZhYnB4eXI5d0NpS1kra1A5VDVKWVRsK2dzTEN1MStxSzNZMnc0?=
 =?utf-8?B?WGJPdTdOMCtUbjduR3NzTFI1TGtaZ1MwWE9ob1VJdXAzVjdBK01xN2paNW55?=
 =?utf-8?B?YXdsWnMwdWtXVXhISEJIRmdsMHl5RXRSUGpkSW8xcFBKbXFaVjFXbEFmQ1Rk?=
 =?utf-8?B?U3lxQzljay9lUlpxQ2pETmFRcWFpWHBYU3FaNDZ6NlF6ZG9MWXZrbEl5ZDV2?=
 =?utf-8?B?cXJjR3BmRi9Xdk9WdVFxaXJ6dXVENkw0VVJqTndnbmFJUXNUZm9scHMrYmJ2?=
 =?utf-8?B?eTQ1L3FCcnRBeXBqV0VWdGMzbDNFeGw3S1A2MXlPbm1aSUlYN2I4anZIbnFl?=
 =?utf-8?B?ZHZVVVd4N0Nsa3FUNjlXVlZBUFJscm8vMjlSc24rNTJxTmo5aGFFZ2FUeStC?=
 =?utf-8?B?K0d6M0YvNE9Xam1BZ2V2VWlVYUlsclhSeVp0RlBlbDZqZE1hTmdNTnpSbW54?=
 =?utf-8?B?dmlnVFZrMlozZnpTTm9VS2xIQWhQbTlXMjZRVVBNbS9KUFVJV3M4WEdFVit6?=
 =?utf-8?B?S2dmQzNQWFE1TUN0cURPSmtsazQrK1hSTlBtaVRxbmwvVXRsbGw3bXdrbjg5?=
 =?utf-8?B?N1FSemhScnRncEtqMUlHZkZnL1pja2dHZFFZbGwwYlZtZldCSlR6aHBsQ01u?=
 =?utf-8?B?QzVwU05PNUtWaWxYMXowbk1rTG1Xa1Vwb1R3czk2YVFLNFhVclVpWUMydXRZ?=
 =?utf-8?B?aXF2M255Q0UxV1dZaXZLV0g0SERrbldBT0xSa2tSZTUyNnB0UHh3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6933F2B5F8A924EB5EDF104875ABED4@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6879c41-6e70-4247-aaf2-08dedda80bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 10:51:35.4989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjzzf9iucdES4ECcXWs1zJPgLkNH31hQzS4G+bo61hoZFu2YdfZ1JEaHtVlc2SqGpGnD91v3WVlN8DpvmgRCIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.56 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22959-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:replyto,nvidia.com:mid];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,nvidia.com,kernel.org,redhat.com,google.com,gmail.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:tariqt@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:daniel.zahka@gmail.com,m:netdev@vger.kernel.org,m:borisp@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:jianbol@nvidia.com,m:leon@kernel.org,m:rrameshbabu@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:raeds@nvidia.com,m:cmi@nvidia.com,m:dtatulea@nvidia.com,m:sdf.kernel@gmail.com,m:mbloch@nvidia.com,m:sdf@fomichev.me,m:saeedm@nvidia.com,m:aleksandr.loktionov@intel.com,m:gal@nvidia.com,m:lkayal@nvidia.com,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1573A72FEDD

T24gV2VkLCAyMDI2LTA3LTA4IGF0IDEyOjM3ICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IE9uIFR1ZSwgMjAyNi0wNy0wNyBhdCAxNDoyOSAtMDQwMCwgRGFuaWVsIFphaGthIHdyb3RlOg0K
PiA+IA0KPiA+IE9uIDcvNy8yNiA5OjA4IEFNLCBUYXJpcSBUb3VrYW4gd3JvdGU6DQo+ID4gPiBI
aSwNCj4gPiA+IA0KPiA+ID4gVGhpcyBzZXJpZXMgYnkgQ29zbWluIHJlZmFjdG9ycyBtbHg1IFBT
UCBzdXBwb3J0IGluIHByZXBhcmF0aW9uDQo+ID4gPiBmb3INCj4gPiA+IEhXLUdSTyBzdXBwb3J0
Lg0KPiA+ID4gVGhlcmUgYXJlIGFsbW9zdCBubyBmdW5jdGlvbmFsaXR5IGNoYW5nZXMgaW4gYWxs
IGJ1dCB0aGUgbGFzdCB0d28NCj4gPiA+IHBhdGNoZXMsIHdoaWNoIGFkZHJlc3MgYSBsb25nLXN0
YW5kaW5nIFRPRE8gaW4NCj4gPiA+IG1seDVlX3BzcF9zZXRfY29uZmlnKCkuDQo+ID4gPiANCj4g
PiA+IFJlZ2FyZHMsDQo+ID4gPiBUYXJpcQ0KPiA+ID4gDQo+ID4gPiBDb3NtaW4gUmF0aXUgKDE1
KToNCj4gPiA+IMKgwqAgbmV0L21seDVlOiBwc3A6IFJlbmFtZSB0aGUgc2F2ZWQgcHNwX2RldiB0
byAncHNkJw0KPiA+ID4gwqDCoCBuZXQvbWx4NWU6IHBzcDogUmVtb3ZlIFBTUCBzdGVlcmluZyBt
dXRleGVzDQo+ID4gPiDCoMKgIG5ldC9tbHg1ZTogcHNwOiBSZW1vdmUgdW5uZWVkZWQgcmVmIGNv
dW50aW5nIGZvciBQU1Agc3RlZXJpbmcNCj4gPiA+IMKgwqAgbmV0L21seDVlOiBwc3A6IE1lcmdl
IHJ4X2VyciBydWxlIGFkZC9kZWxldGUgd2l0aCBmdA0KPiA+ID4gY3JlYXRlL2RlbGV0ZQ0KPiA+
ID4gwqDCoCBuZXQvbWx4NWU6IHBzcDogVXNlIGhlbHBlcnMgZm9yIHN0ZWVyaW5nIG9iamVjdCBt
YW5pcHVsYXRpb24NCj4gPiA+IMKgwqAgbmV0L21seDVlOiBwc3A6IEZhY3RvciBvdXQgZHJvcCBy
dWxlIGNyZWF0aW9uIGNvZGUNCj4gPiA+IMKgwqAgbmV0L21seDVlOiBwc3A6IFJlbW92ZSB1bnVz
ZWQgUFNQIHN5bmRyb21lIGNvcHkgYWN0aW9uDQo+ID4gPiDCoMKgIG5ldC9tbHg1ZTogcHNwOiBS
ZW5hbWUgYW5kIGNvbnNvbGlkYXRlIHN0ZWVyaW5nIGZ1bmN0aW9ucw0KPiA+ID4gwqDCoCBuZXQv
bWx4NWU6IHBzcDogQWRqdXN0IHJ4X2NoZWNrIEZUIHNpemUgYW5kIHVzZSBhIGRyb3BfZ3JvdXAN
Cj4gPiA+IMKgwqAgbmV0L21seDVlOiBwc3A6IEFkZCBhbiBSWCBzdGVlcmluZyB0YWJsZQ0KPiA+
ID4gwqDCoCBuZXQvbWx4NWU6IHBzcDogVXNlIGEgc2luZ2xlIHJ4X2NoZWNrIHRhYmxlDQo+ID4g
PiDCoMKgIG5ldC9tbHg1ZTogcHNwOiBGbGF0dGVuIHN0ZWVyaW5nIHN0cnVjdHVyZXMNCj4gPiA+
IMKgwqAgbmV0L21seDVlOiBwc3A6IE1ha2UgUFNQIHN0ZWVyaW5nIGNvbmZpZyBkeW5hbWljDQo+
ID4gPiDCoMKgIG5ldC9tbHg1ZTogUmV0dXJuIGVycm9ycyBmcm9tIHByb2ZpbGUtPmVuYWJsZQ0K
PiA+ID4gwqDCoCBuZXQvbWx4NWU6IHBzcDogUmVwb3J0IFBTUCBkZXYgcmVnaXN0cmF0aW9uIGVy
cm9ycw0KPiA+ID4gDQo+ID4gPiDCoCBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZW4uaMKgIHzCoMKgwqAgMiArLQ0KPiA+ID4gwqAgLi4uL25ldC9ldGhlcm5ldC9tZWxs
YW5veC9tbHg1L2NvcmUvZW4vZnMuaMKgwqAgfMKgwqDCoCA3ICstDQo+ID4gPiDCoCAuLi4vbWVs
bGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL2VuX2FjY2VsLmjCoMKgwqAgfMKgwqAgMTkgKy0NCj4g
PiA+IMKgIC4uLi9tZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvcHNwLmPCoMKgwqDCoMKgwqDC
oMKgIHwgMTAwNyArKysrKysrKy0tDQo+ID4gPiAtLQ0KPiA+ID4gLS0tLS0NCj4gPiA+IMKgIC4u
Li9tZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvcHNwLmjCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDE4ICstDQo+ID4gPiDCoCAuLi4vbWVsbGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL3BzcF9yeHR4
LmPCoMKgwqAgfMKgwqAgMTMgKy0NCj4gPiA+IMKgIC4uLi9tZWxsYW5veC9tbHg1L2NvcmUvZW5f
YWNjZWwvcHNwX3J4dHguaMKgwqDCoCB8wqDCoMKgIDMgKy0NCj4gPiA+IMKgIC4uLi9uZXQvZXRo
ZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX21haW4uYyB8wqDCoCAyMyArLQ0KPiA+ID4gwqAg
Li4uL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fcmVwLmPCoCB8wqDCoMKgIDgg
Ky0NCj4gPiA+IMKgIDkgZmlsZXMgY2hhbmdlZCwgNTE2IGluc2VydGlvbnMoKyksIDU4NCBkZWxl
dGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBiYXNlLWNvbW1pdDogMzE4MTZmYzVkOWFj
ZjhjZGYyMjZjZGQwZGMyOTZlOGNmMTVjYzAzMw0KPiA+IA0KPiA+IFRoYW5rcy4gRXhjaXRlZCBh
Ym91dCB0aGUgc3VwcG9ydCBmb3IgbWx4NWVfcHNwX3NldF9jb25maWcoKS4gSmFrdWINCj4gPiBh
bmQgDQo+ID4gSSBoYWQgYSB0ZXN0IGNhc2UgZm9yIHBzcF9kZXZfb3BzOjpzZXRfY29uZmlnKCkg
dGhhdCB3ZSB3ZXJlDQo+ID4gd2FpdGluZw0KPiA+IHRvIA0KPiA+IHVwc3RyZWFtLiBJIGp1c3Qg
cmViYXNlZCBpdCBvbnRvIG5ldC1uZXh0IGhlcmU6IA0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9k
YW5pZWxkemFoa2EvbGludXgvY29tbWl0L2I1OGU5YTk5NTczY2Y2Yjg4NGU1ZmUzMjI3YzlhZjdh
MWYwZDgwYjANCj4gPiANCj4gPiBJIHJhbiBpdCB3aXRoIHRoZSBzZXJpZXMgYnV0IGFtIHNlZWlu
ZyBhbiBlcnJvciB0cnlpbmcgdG8gY2F0Y2ggDQo+ID4gdW5kZWNyeXB0ZWQgUFNQLVVEUCBwYWNr
ZXRzIGFmdGVyIGRpc2FibGluZyBhbGwgdmVyc2lvbnMgd2l0aA0KPiA+IHNldF9jb25maWcoKQ0K
PiA+IA0KPiA+IFRBUCB2ZXJzaW9uIDEzDQo+ID4gMS4uMzANCj4gPiBvayAxIHBzcC5kYXRhX2Jh
c2ljX3NlbmQudjBfaXA0ICMgU0tJUCBUZXN0IHJlcXVpcmVzIElQdjQNCj4gPiBjb25uZWN0aXZp
dHkNCj4gPiBvayAyIHBzcC5kYXRhX2Jhc2ljX3NlbmQudjBfaXA2DQo+ID4gb2sgMyBwc3AuZGF0
YV9iYXNpY19zZW5kLnYxX2lwNCAjIFNLSVAgVGVzdCByZXF1aXJlcyBJUHY0DQo+ID4gY29ubmVj
dGl2aXR5DQo+ID4gb2sgNCBwc3AuZGF0YV9iYXNpY19zZW5kLnYxX2lwNg0KPiA+IG9rIDUgcHNw
LmRhdGFfYmFzaWNfc2VuZC52Ml9pcDQgIyBTS0lQIFRlc3QgcmVxdWlyZXMgSVB2NA0KPiA+IGNv
bm5lY3Rpdml0eQ0KPiA+IG9rIDYgcHNwLmRhdGFfYmFzaWNfc2VuZC52Ml9pcDYgIyBTS0lQICgn
UFNQIHZlcnNpb24gbm90DQo+ID4gc3VwcG9ydGVkJywgDQo+ID4gJ2hkcjAtYWVzLWdtYWMtMTI4
JykNCj4gPiBvayA3IHBzcC5kYXRhX2Jhc2ljX3NlbmQudjNfaXA0ICMgU0tJUCBUZXN0IHJlcXVp
cmVzIElQdjQNCj4gPiBjb25uZWN0aXZpdHkNCj4gPiBvayA4IHBzcC5kYXRhX2Jhc2ljX3NlbmQu
djNfaXA2ICMgU0tJUCAoJ1BTUCB2ZXJzaW9uIG5vdA0KPiA+IHN1cHBvcnRlZCcsIA0KPiA+ICdo
ZHIwLWFlcy1nbWFjLTI1NicpDQo+ID4gb2sgOSBwc3AuZGF0YV9tc3NfYWRqdXN0LmlwNCAjIFNL
SVAgVGVzdCByZXF1aXJlcyBJUHY0IGNvbm5lY3Rpdml0eQ0KPiA+IG9rIDEwIHBzcC5kYXRhX21z
c19hZGp1c3QuaXA2DQo+ID4gb2sgMTEgcHNwLmRhdGFfc2VuZF9vZmYuaXA0ICMgU0tJUCBUZXN0
IHJlcXVpcmVzIElQdjQgY29ubmVjdGl2aXR5DQo+ID4gIyBFeGNlcHRpb258IFRyYWNlYmFjayAo
bW9zdCByZWNlbnQgY2FsbCBsYXN0KToNCj4gPiAjIEV4Y2VwdGlvbnzCoCDCoEZpbGUgIi9yb290
L2tzZnQtcHNwLXNldC1jb25maWcvbmV0L2xpYi9weS9rc2Z0LnB5IiwNCj4gPiBsaW5lIA0KPiA+
IDQyMCwgaW4ga3NmdF9ydW4NCj4gPiAjIEV4Y2VwdGlvbnzCoCDCoCDCoGZ1bmMoKmFyZ3MpDQo+
ID4gIyBFeGNlcHRpb258wqAgwqBGaWxlICIvcm9vdC8uL2tzZnQtcHNwLXNldC0NCj4gPiBjb25m
aWcvZHJpdmVycy9uZXQvcHNwLnB5IiwNCj4gPiBsaW5lIDYwOCwgaW4gZGF0YV9zZW5kX29mZg0K
PiA+ICMgRXhjZXB0aW9ufMKgIMKgIMKgdWRwcy5yZWN2KDgxOTIsIHNvY2tldC5NU0dfRE9OVFdB
SVQpDQo+ID4gIyBFeGNlcHRpb258IEJsb2NraW5nSU9FcnJvcjogW0Vycm5vIDExXSBSZXNvdXJj
ZSB0ZW1wb3JhcmlseQ0KPiA+IHVuYXZhaWxhYmxlDQo+ID4gIyBFeGNlcHRpb258DQo+ID4gbm90
IG9rIDEyIHBzcC5kYXRhX3NlbmRfb2ZmLmlwNg0KPiA+IG9rIDEzIHBzcC5kZXZfbGlzdF9kZXZp
Y2VzDQo+ID4gb2sgMTQgcHNwLmRldl9nZXRfZGV2aWNlDQo+ID4gb2sgMTUgcHNwLmRldl9nZXRf
ZGV2aWNlX2JhZA0KPiA+IG9rIDE2IHBzcC5kZXZfcm90YXRlDQo+ID4gb2sgMTcgcHNwLmRldl9y
b3RhdGVfc3BpDQo+ID4gb2sgMTggcHNwLmFzc29jX2Jhc2ljDQo+ID4gb2sgMTkgcHNwLmFzc29j
X2JhZF9kZXYNCj4gPiBvayAyMCBwc3AuYXNzb2Nfc2tfb25seV9jb25uDQo+ID4gb2sgMjEgcHNw
LmFzc29jX3NrX29ubHlfbWlzbWF0Y2gNCj4gPiBvayAyMiBwc3AuYXNzb2Nfc2tfb25seV9taXNt
YXRjaF90eA0KPiA+IG9rIDIzIHBzcC5hc3NvY19za19vbmx5X3VuY29ubg0KPiA+IG9rIDI0IHBz
cC5hc3NvY192ZXJzaW9uX21pc21hdGNoDQo+ID4gb2sgMjUgcHNwLmFzc29jX3R3aWNlDQo+ID4g
b2sgMjYgcHNwLmRhdGFfc2VuZF9iYWRfa2V5DQo+ID4gb2sgMjcgcHNwLmRhdGFfc2VuZF9kaXNj
b25uZWN0DQo+ID4gb2sgMjggcHNwLmRhdGFfc3RhbGVfa2V5DQo+ID4gb2sgMjkgcHNwLnJlbW92
YWxfZGV2aWNlX3J4ICMgWEZBSUwgVGVzdCBvbmx5IHdvcmtzIG9uIG5ldGRldnNpbQ0KPiA+IG9r
IDMwIHBzcC5yZW1vdmFsX2RldmljZV9iaSAjIFhGQUlMIFRlc3Qgb25seSB3b3JrcyBvbiBuZXRk
ZXZzaW0NCj4gPiAjIFRvdGFsczogcGFzczoxOSBmYWlsOjEgeGZhaWw6MiB4cGFzczowIHNraXA6
OCBlcnJvcjowDQo+ID4gIw0KPiA+ICMgUmVzcG9uZGVyIGxvZ3MgKDApOg0KPiA+ICMgU1RERVJS
Og0KPiA+ICMgI8KgIFNldCBQU1AgZW5hYmxlIG9uIGRldmljZSAxIHRvIDB4Mw0KPiA+ICMgI8Kg
IFNldCBQU1AgZW5hYmxlIG9uIGRldmljZSAxIHRvIDB4MA0KPiA+IA0KPiA+IEkgcmVjYWxsIHRo
aXMgd29ya2luZyBvbiBhbiBlYXJsaWVyIHByb3RvdHlwZSBvZiB0aGlzIGZlYXR1cmUgZm9yDQo+
ID4gbWx4NS4gDQo+ID4gQXJlIHRoZSBzdGVlcmluZyBydWxlcyBzZXR1cCB0byBkcm9wIFBTUC1V
RFAgcGFja2V0cyB3aGVuIHRoZSANCj4gPiBjb3JyZXNwb25kaW5nIHBzcCB2ZXJzaW9uIGlzIGRp
c2FibGVkPw0KPiA+IA0KPiANCj4gV2UgZG9uJ3QgaGF2ZSBwZXItcHNwIHZlcnNpb24gc3RlZXJp
bmcgcnVsZXMuIElmIGVpdGhlciB2ZXJzaW9uIGlzDQo+IHJlcXVlc3RlZCwgc3RlZXJpbmcgcnVs
ZXMgYXJlIGNvbmZpZ3VyZWQuIFdoZW4gYWxsIHZlcnNpb25zIGFyZQ0KPiBkaXNhYmxlZCwgc3Rl
ZXJpbmcgcnVsZXMgYXJlIHJlbW92ZWQuDQo+IFdpdGggbm8gc3RlZXJpbmcgcnVsZXMgaW5zdGFs
bGVkLCBVRFAgdHJhZmZpYyBzaG91bGQgbm90IGJlIGFmZmVjdGVkLg0KPiANCj4gSSB3aWxsIHRh
a2UgdGhlIHRlc3QgYW5kIGRlYnVnIHdoYXQncyBnb2luZyBvbiwgYW5kIGdldCBiYWNrIHRvIHlv
dS4NCg0KU28gdGhlIHRlc3QgcmVsaWVzIG9uIFRDUCByZXRyYW5zbWlzc2lvbnMgdG8gY2F0Y2gg
dGhlIGVuY3J5cHRlZCBlY2hvDQpmcm9tIHRoZSByZXNwb25kZXIgb24gdGhlIFVEUCBzb2NrZXQu
IFRoZSB0aW1lbGluZSBzZWVtcyB0byBiZToNCjEuIGRhdGFfc2VuZF9vZmYgZGlzYWJsZXMgUFNQ
IG9uIGl0cyBlbmQuDQoyLiBkYXRhX3NlbmRfb2ZmIG9wZW5zIGEgVURQIHNvY2tldCBhbmQgYmlu
ZHMgaXQgdG8gcG9ydCAxMDAwLg0KMy4gZGF0YV9zZW5kX29mZiBzZW5kcyAiZGF0YSBlY2hvIiB0
byBwc3BfcmVzcG9uZGVyIG9uIHRoZSBjb250cm9sDQpjb25uZWN0aW9uLg0KNC4gcHNwX3Jlc3Bv
bmRlciBzZW5kICJlY2hvIiBvbiB0aGUgbm93IHNhYm90YWdlZCBQU1AgY29ubmVjdGlvbi4NCjUu
IHBzcF9yZXNwb25kZXIgYWNrcyB0aGUgImVjaG8gcmVxdWVzdCIgb24gdGhlIGNvbnRyb2wgY29u
bmVjdGlvbi4NCjYuIGRhdGFfc2VuZF9vZmYgcmVjZWl2ZXMgdGhlIGFjay4NCjcuIGRhdGFfc2Vu
ZF9vZmYgdHJpZXMgdG8gcmVjZWl2ZSAiZWNobyIgb24gdGhlIFBTUCBjb25uZWN0aW9uIGJ1dA0K
ZXhwZWN0X2ZhaWw9PVRydWUgc28gc3RvcHMgYWZ0ZXIgMTAwIG1zLg0KOC4gZGF0YV9zZW5kX29m
ZiByZWVuYWJsZXMgUFNQIG9uIGl0cyBlbmQuDQo5LiBkYXRhX3NlbmRfb2ZmIHdhaXRzIGZvciAi
ZWNobyIgdG8gYmUgcmVjZWl2ZWQgbm93IHRoYXQgY29ubmVjdGl2aXR5DQppcyBiYWNrIGZvciB1
cCB0byAzNTAgbXMuDQoxMC4gZGF0YV9zZW5kX29mZiBhc3NlcnRzIHRoYXQgc29tZXRoaW5nIGlz
IGluIHRoZSBVRFAgc29ja2V0IHF1ZXVlLg0KDQpTbyBVRFAgcGFja2V0cyBjb3VsZCBiZSBlbnF1
ZXVlZCBpZiBQU1AgcGFja2V0cyBhcmUgcmVjZWl2ZWQgYmV0d2Vlbg0Kc3RlcHMgNC04Lg0KDQpJ
dCBzZWVtcyBkaXNhYmxpbmcgUFNQIHN0ZWVyaW5nIHJ1bGVzIGlzbid0IGFzIGF0b21pYyBhcyB3
ZSB0aG91Z2h0LA0KYW5kIHNvbWV0aW1lcyB0aGUgZmlyc3QgZWNobyBpcyBkaXNjYXJkZWQgYnkg
c3RlZXJpbmcuIFRoZSBkZWZhdWx0IFRDUA0KcmV0cmFuc21pc3Npb24gdGltZW91dCBpcyAyMDAg
bXMgc28gdGhlcmUgYXJlIG5vIHJldHJhbnNtaXNzaW9ucyBpbiB0aGUNCn4xNTAtMTcwIG1zIGJl
dHdlZW4gc3RlcHMgNC04Lg0KDQpXaXRoIGEgc2xpZ2h0bHkgbW9kaWZpZWQgdGVzdCB0aGF0IGRp
cmVjdGx5IHJlcXVlc3RzIGRhdGEgZWNob2VzLCB0aGUNCnRlc3QgYmVjb21lcyBtb3JlIHJlbGlh
YmxlLiBBZGRpdGlvbmFsbHksIHlvdSBuZWVkIHRoZSBVRFBfTk9fQ0hFQ0s2X1JYDQooMTAyKSBz
b2NrZXQgb3B0aW9ucyBmb3IgdGhlIGlwdjYgdmVyc2lvbiwgb3RoZXJ3aXNlIHplcm8tY2hlY2tz
dW0gVURQDQpwYWNrZXRzIGFyZSBkaXNjYXJkZWQgYnkgdGhlIHN0YWNrLiBJIHZhZ3VlbHkgcmVt
ZW1iZXIgZG9pbmcgdGhpcw0KY2hhbmdlIGZvciB0aGlzIHRlc3QgaW4gSmFrdWIncyByZXBvIGEg
ZmV3IHllYXJzIGFnby4NCg0KQW55d2F5LCBoZXJlJ3MgdGhlIGRpZmYgdGhhdCBtYWtlcyBib3Ro
IHRlc3RzIHJlbGlhYmx5IHBhc3M6DQoNCi0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Ry
aXZlcnMvbmV0L3BzcC5weQ0KKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZHJpdmVycy9u
ZXQvcHNwLnB5DQpAQCAtNTY5LDcgKzU2OSw4IEBAIGRlZiBfZ2V0X3BzcF92ZXJfaXBfdmFyaWFu
dHMoKToNCiANCiBkZWYgX2dldF9pcF92YXJpYW50cygpOg0KICAgICBmb3IgaXB2IGluICgiNCIs
ICI2Iik6DQotICAgICAgICB5aWVsZCBLc2Z0TmFtZWRWYXJpYW50KGYiaXB7aXB2fSIsIGlwdikN
CisgICAgICAgIGZvciBfIGluIHJhbmdlKDAsIDEwMCk6DQorICAgICAgICAgICAgeWllbGQgS3Nm
dE5hbWVkVmFyaWFudChmImlwe2lwdn0iLCBpcHYpDQogDQogDQogQGtzZnRfdmFyaWFudHMoX2dl
dF9pcF92YXJpYW50cygpKQ0KQEAgLTYwNCwxNiArNjA1LDI4IEBAIGRlZiBkYXRhX3NlbmRfb2Zm
KGNmZywgaXB2ZXIpOg0KICAgICAgICAgICAgIHVkcHMuYmluZCgoJzAuMC4wLjAnLCAxMDAwKSkN
CiAgICAgICAgIGVsc2U6DQogICAgICAgICAgICAgdWRwcyA9IHNvY2tldC5zb2NrZXQoc29ja2V0
LkFGX0lORVQ2LCBzb2NrZXQuU09DS19ER1JBTSkNCisgICAgICAgICAgICAjIFBTUCBwYWNrZXRz
IGhhdmUgYSB6ZXJvIFVEUCBjc3VtLCBhY2NlcHQgdGhlbQ0KKFVEUF9OT19DSEVDSzZfUlgpDQor
ICAgICAgICAgICAgdWRwcy5zZXRzb2Nrb3B0KHNvY2tldC5JUFBST1RPX1VEUCwgMTAyLCAxKQ0K
ICAgICAgICAgICAgIHVkcHMuYmluZCgoJzo6JywgMTAwMCkpDQogICAgICAgICB3YWl0X3BvcnRf
bGlzdGVuKDEwMDAsIHByb3RvPSJ1ZHAiKQ0KIA0KICAgICAgICAgX3JlcV9lY2hvKGNmZywgcywg
ZXhwZWN0X2ZhaWw9VHJ1ZSkNCiANCisgICAgICAgIGVjaG9lcyA9IDENCisgICAgICAgIGZvciBf
IGluIHJhbmdlKDEwKToNCisgICAgICAgICAgICB0cnk6DQorICAgICAgICAgICAgICAgIHVkcHMu
cmVjdig4MTkyLCBzb2NrZXQuTVNHX0RPTlRXQUlUIHwgc29ja2V0Lk1TR19QRUVLKQ0KKyAgICAg
ICAgICAgICAgICBicmVhaw0KKyAgICAgICAgICAgIGV4Y2VwdCBCbG9ja2luZ0lPRXJyb3I6DQor
ICAgICAgICAgICAgICAgIF9zZW5kX3dpdGhfYWNrKGNmZywgYidkYXRhIGVjaG9cMCcpDQorICAg
ICAgICAgICAgICAgIGVjaG9lcyArPSAxDQorICAgICAgICAgICAgICAgIHRpbWUuc2xlZXAoMC4w
NSkNCisNCiAgICAgICAgIGNmZy5wc3BubC5kZXZfc2V0KHsiaWQiOiBjZmcucHNwX2Rldl9pZCwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgInBzcC12ZXJzaW9ucy1lbmEiOiBpbmZvWydwc3At
dmVyc2lvbnMtDQplbmEnXX0pDQogICAgICAgICBpbmZvID0gTm9uZQ0KLSAgICAgICAgIyBXZSBu
ZWVkIHNvbWUgbW9yZSBUQ1AgUlRPcyBzbyBsb3RzIG9mIHJvdW5kcw0KLSAgICAgICAgX3JlY3Zf
Y2FyZWZ1bChzLCA1LCByb3VuZHM9MzUwKQ0KKyAgICAgICAgIyBEcmFpbiB0aGUgc29ja2V0IG5v
dyB0aGF0IGNvbm5lY3Rpdml0eSBpcyBiYWNrDQorICAgICAgICBfcmVjdl9jYXJlZnVsKHMsIDUg
KiBlY2hvZXMsIHJvdW5kcz0xMDAwKQ0KIA0KICAgICAgICAgIyBXaWxsIHJhaXNlIEJsb2NraW5n
SU9FcnJvciBpZiB0aGVyZSBhcmUgbm8gcGFja2V0cw0KICAgICAgICAgdWRwcy5yZWN2KDgxOTIs
IHNvY2tldC5NU0dfRE9OVFdBSVQpDQoNCg0KLS0tLS0tLQ0KDQpXaXRoIHRoaXMgKHBsdXMgZGlz
YWJsaW5nIGFsbCBvdGhlciB0ZXN0IGNhc2VzKSwgSSBnZXQ6DQojIC4vdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvZHJpdmVycy9uZXQvcHNwLnB5IA0KVEFQIHZlcnNpb24gMTMNCjEuLjIwMA0Kb2sg
MSBwc3AuZGF0YV9zZW5kX29mZi5pcDQNCi4uLg0Kb2sgMjAwIHBzcC5kYXRhX3NlbmRfb2ZmLmlw
Ng0KIyBUb3RhbHM6IHBhc3M6MjAwIGZhaWw6MCB4ZmFpbDowIHhwYXNzOjAgc2tpcDowIGVycm9y
OjANCg0KSSB3aWxsIGNvbnRpbnVlIHRvIGRpZyBpbnRvIHdoYXQgZXhhY3RseSBoYXBwZW5zIGlu
IHN0ZWVyaW5nIHdoZW4gUFNQDQpnZXRzIGRpc2FibGVkIGFuZCB3aHkgYSBwYWNrZXQgaXMgZWF0
ZW4gd2l0aCBubyB0cmFjZXMuDQoNCkNvc21pbi4NCg==

