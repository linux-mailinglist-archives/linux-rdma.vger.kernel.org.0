Return-Path: <linux-rdma+bounces-16077-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDwhDee6eGmasgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16077-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:17:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC16D94C1E
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29E5C3019166
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B93559EF;
	Tue, 27 Jan 2026 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2EWg7DZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B87205E25;
	Tue, 27 Jan 2026 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519841; cv=fail; b=CpwqfiRn9YvSguebGM8NTtVY9oJVVM5CmGDBfOHGyANCUi3qcwlekcHHd76lOH239knPG+yaihXauLjrGxX8T7UOe74a/Nxzb0qF6KTK4Vy5ejPPXU1hy0nONFvRdsWuJ/f3ORszhlJjrbqb7TkFmQABlD2roYUmcPBm+fvibjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519841; c=relaxed/simple;
	bh=ZKGuIgVLXwGeB0yqkELuAXw7HYjMDGV6Ewe3JJ2ulek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J+VOSBUFKkLToOB7B8E1uiYpa1A9zmfoAMAFfbRthIObIEmCIfly9t06TnYIrtM8UrNVRwCteZiXA/DiTznuhlDEiCxF7PmVg0P5H1WSSPUpsp69A88vHNYizDkRLBHTv6dmPFkc+njd3lgA5wCws5DNk83wDv+Yhr/eaMC/bOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2EWg7DZ; arc=fail smtp.client-ip=40.107.200.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yqfv5J2bR+9zxt1QegevVWsWPZrhnjtOHopgiB4/IuN678lbaAGc74HBnOdZ1ue1a8znr/470qDYC8Dn1pt41MvNLXgZv3FMPo6Jhs590AY3p1KNTZ2T8Xtr6prN7vyLYGR09vhNWsZWJHZMTYYxPepfNm5OrhDI7rs++9wt6Fwonq3HYJ8UB7T9PHmmtEljdxGyE7dMKO4eOIaz0TGJ9nr/z7oFSu9tHyPz6G4UmO94q58AtGthYdcsqP3nc74NC9Gec0ChhJ57+cdw4O4Bw9XtxRb1nRx+2CbcihAZ/Mm0pZ/h6ScRaj/l1j6OANd8vMszxNLQ+S4eAw8zFa40tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKGuIgVLXwGeB0yqkELuAXw7HYjMDGV6Ewe3JJ2ulek=;
 b=XeEGS8j6mRaWU73b0d8RaQ5rGAidrJvLUN8XNTPTaCl3unDIj2hemkW4Sy9NxVOFIV8353nsVxIH72oe5tm5sNektcy1r7RYNSYLkouNdP4N2mFrcun2EzBntEE+5OsKCpRV4shSCBsYSLim4pxiJNX0XtwAxrmwoAyy5VWi+lCD16rEG573QyFBEfdfXPgJJ5Dwp6YepANoySNMSSiJyc5p5tom2f7MJm7w0w0ymACpR2Pd8EtjcHrxGVuAWXiT0LzizWf6+gSfmtl838V3LSax+b1W5VVDEbsBAwnUiSio5Njtpxky7co1/ZqO+W57rsa6x5wX0BYp5xKeRr7fSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKGuIgVLXwGeB0yqkELuAXw7HYjMDGV6Ewe3JJ2ulek=;
 b=s2EWg7DZ8P2OsnxCSSqoptY7U+J9wQZ7nENB4HB8MPCrDDU4dbk6Kjide+1u9WTO7KyxoBip6aoLlUd1p0PMP72zKMbAzJgKzRV/iNPVLkwIRKfD+lHELDdBt9ABqiaZO/Ms5Uq2Fxza2ZYiFFzd3GfTaQ/tZvqXNI3zkmc15kbbjgrr8/f4yEGyF/yALzBqwrtZoXWI3LL9D7y2DpHMrDzzZieBcpjmPXpc7lDFNrAURXsKsr07pEKT/cMkMpy7V5BjcAl5/22vTej+T6u0X/8+X4dJDN6MvF1VG9VMERq93blfmBLuk2hdOhCOumSdwq7qsogFtnewJLbuMkBaLQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by BY5PR12MB4210.namprd12.prod.outlook.com
 (2603:10b6:a03:203::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 13:17:16 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 13:17:16 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>, Tariq
 Toukan <tariqt@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Raed
 Salem <raeds@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org"
	<leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net/mlx5e: don't assume psp tx skbs are ipv6 csum
 handling
Thread-Topic: [PATCH v2] net/mlx5e: don't assume psp tx skbs are ipv6 csum
 handling
Thread-Index: AQHcjvtZaEc3H8keZECfHUfmxA4UfLVmAIoA
Date: Tue, 27 Jan 2026 13:17:15 +0000
Message-ID: <96eec14b49c9bcbccb00619f66abe5a86df3982f.camel@nvidia.com>
References: <20260126-dzahka-fix-tx-csum-partial-v2-1-0a905590ea5f@gmail.com>
In-Reply-To: <20260126-dzahka-fix-tx-csum-partial-v2-1-0a905590ea5f@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|BY5PR12MB4210:EE_
x-ms-office365-filtering-correlation-id: fc5a80c3-ed30-43c0-e200-08de5da66436
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2J6Z093VXFwNHd3NExxUUNZL01xWnRjL2xYOW5xYjRScSswdzNod0pSU3Z1?=
 =?utf-8?B?OVNnb2lKUmppL2Q1elFtWXp1STBvVkp0bmkxZ3REMGpEajlneDFOSE0vYisr?=
 =?utf-8?B?OHR5bmhzMVUwRlJITGRtSHRzYkdOVjNKQ1VsOHJVRUx4M054dzJxdm9iNThT?=
 =?utf-8?B?czRHRVZ2TTdjb1RMZDRSbEhpaU5DZ2R6cWhBZGc4bjRpRCtVeFV4Lzhvc21S?=
 =?utf-8?B?VGVkYmtKcitWOVZxT294ei9lT0svWkhkTlVaM3Urc2psT0VNT0xPazBZTmxE?=
 =?utf-8?B?MVkrdUZoWS9HZllWQkZsdXk3UHduTDNCWGprZmdMcDVjS2VOUFBKSHdNQ2hY?=
 =?utf-8?B?MDFmek9BMVBSaWFBVStFNmUyZ2d2aWpraUVBcENneExzbTRiaXlWMTc2cjh4?=
 =?utf-8?B?TlVSM2NKbWlkMzJPWjVlbFBaZEtKQlNLaHBod2RqQUZEd3BEVUtKall4aDFF?=
 =?utf-8?B?dStoWWZkM2ExUUUvcHF5QlhpbVdFMUNrL3hRSlhkdHl2dER3V3BiQjlKKzFJ?=
 =?utf-8?B?U2kvQTNlUmJlRG9Ubm9LR1pyeSt0ZmE2OXluaWQ3b1duU3NYaUJaLzJiMHVU?=
 =?utf-8?B?S1BGbm5iSzg0TGpJSER1dnRpckVxVzVZcnJ3S2ZrL1NrMEhjbEhnaDhlK3hn?=
 =?utf-8?B?TmdNd0E0QUJkdXdsSWJ3RklFVEZiUkJ5Y1JtdHhpa1Y2bDc4VnlTUnBrTUNq?=
 =?utf-8?B?cXMrTVh0SktRWFlVOWVSeUk2bk4xeUYxT28wdzlTdTA2WmR1TnpMUzRBcG9K?=
 =?utf-8?B?ZjVzVVRhcEplTnEycWs0K3FteklmcEE1L2YraFZaSThyRHdTa1JXRm1QdUtx?=
 =?utf-8?B?V21XNDFwSlhzSENrL1R0emNRTk55TCsxdkZtZGNOZlk0TzB5MjRFdG9uTHZV?=
 =?utf-8?B?b3VWUWZDYVZyZHA5TGxGVlVjeEFULzE3RmV6TWxNN21hQ2tqbTBPQ05RRWx0?=
 =?utf-8?B?UXBuV0lIZi9aK1RTL3JMRG1adTVLa3JPZVJkK1MrVVRMWFJPeVFXWWo4UjFG?=
 =?utf-8?B?dzQ2NDlIdG15eVZ6QjJvM3puaFZUQkRCVzdPQk1DcHh0a1UxMjVnQjl2NVRi?=
 =?utf-8?B?WWxVZERPTnJHYTRVcWVvNDc1WlBHTUFQM1pRZjBIbG45V3N4aDhQekgzT25T?=
 =?utf-8?B?dTk3MzNkNktpMVRCSXlmRklnUEUrdERoMFB0NUNzV0U0L2VHRyt4cDNQR3VE?=
 =?utf-8?B?UzZoVXVqSFJYTjkvdTZCbjFrMmlOQUtHclNKMFp6Q3doZDVsbWJpeGhhZWhq?=
 =?utf-8?B?Y211Y3NZbkVqcVFLSUdLbDVCL3ZpTE1NVjI3UmxEZnVZTFlpenJmZzBhcFhX?=
 =?utf-8?B?S1hPWHF1a3RYRzZzc210NVViQWIxTE4wdi9KVCtZOUphZ3F0V2YvMkFLYVd1?=
 =?utf-8?B?NjE3NnVJRjRMZ2pmNk5WYjVjQisyMVpGRXFQYVpLSCs0SnpCWFlBMUQxRW1B?=
 =?utf-8?B?dmNpSGVyYjhuay9jYXV2Q0JCNEY5QmN6YVRUUVVveXo0cFhWVCt5SEhOV09P?=
 =?utf-8?B?cUlGUktUc1h5VkdSdDlqaEdtOU5ZNUZVU0N5dzhLZzdIUERqVHZjNWYvbXNm?=
 =?utf-8?B?L1J3K3hNT2htVjRWVGV0Y0YvcXUwTG5JbjkxVEtrUkhBOElCUkRtbFE5MEtS?=
 =?utf-8?B?UTFwV3pTbkxLYlJRYWVTZzBEY2xtTjY1Zjd1RUNsUkFsWEhnWFhvQ2xHWEpy?=
 =?utf-8?B?K05lVmFPaEp6YlZPT0M2Rlp5VTlwS0xxalQzdHV6RVZycEdCUVZ1dkhORlQw?=
 =?utf-8?B?dG1Bc2J1RUdrMzBVemVtT2ttVkM1K0dTamVDWDNGQzlIamVNS211aDc1b3JT?=
 =?utf-8?B?S1k1akFCV3BBMTAwQm0vcUJrcHhDZUhoRWJVTDQ3bnFuRzI2QXdDTU5lYncz?=
 =?utf-8?B?dXg4VHJHVTZTWUllWU40akJEWlQ0Y0pzVS9zRXA1aW80cENGN1BYRmJCbm0w?=
 =?utf-8?B?eE1TV2xkTkJoUjlBM0U3TU1Da1ZOVU1ZSkc1Y3BwenVQcUl2ZzIvYkVOb2Vu?=
 =?utf-8?B?SE1PNkt1bGZpbUVPNGo3Y2RmVXlMRFpZM3A5SVlHYmQ2Ly8vZ2lrQ2lkSE10?=
 =?utf-8?B?U2REdi9vdE9tV2hOUUV0dW9mTXNSQ2pCa2pianhieVB3Rm9nZWdMOHkxMVJy?=
 =?utf-8?B?SHBOamxOaDJCdFIvTnJxZ0s5d0dncmhlc1FwOElOb3B3bmkrdCtNRVZ3ZDlS?=
 =?utf-8?Q?3GJx/x8Ofx4nSW8Px5cBhcW8q7lDny4POMqLM1BIiHPU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?di9OSnRMR0RRalJIYWgweTlvbjBtSHJQaDBPaHdGamVYYVEwODBYNnJHZGlI?=
 =?utf-8?B?RkRFNmRtdVBySUp2QTlYcUQ4SFp0TjJJS1JOY0pib1VITHJSdk56QzJyTTRS?=
 =?utf-8?B?Uzk5eENYazZiQSs0czEwTGpKMit4TGVhOEw5R04vSFk1TVpod0U5SStjbTJs?=
 =?utf-8?B?NndNd0lNcWpqa1lla3dDTTJuSnZuRmRZSW9TdlliSHo2a3BnVlFOdnF1alhO?=
 =?utf-8?B?QWxJZjE4M3did3lMOVE3MDNyWXpsdUEwdlBvcVdIVDB2RFVXb0pWV3VmZXYw?=
 =?utf-8?B?NEI4UTJWeE4vMTg5ZXIxblJTT0pXSzhpL041QURWTDNXN3lNZjdwcHBzRDVn?=
 =?utf-8?B?Si9Uc21UQmlMRFNocTlNcUZTVmJXMTNEOGFCd0I1ZkF3WWN3MThiYzgvSWhq?=
 =?utf-8?B?dU9vQkFZNlhuR1ZlTFVSZmFhWUpza3orS0oxNXdMS21UOSt2aUMzd0ZWZ2JV?=
 =?utf-8?B?TlJHQS9qTWdBQUp4bk1uVzJoRXBTb3c3d1k1eUtpcXViSlpPaE5HQUpyNVI0?=
 =?utf-8?B?Ujk2cXg1SWRtNlFuSzZVRHpZOWhmMzlHNDIzZGc1MnRLNHhIUW5uWlpKUDd6?=
 =?utf-8?B?VTQxRm0wMjNLNm1oUUErTHRnbmpXR2FhbkdST1dRR3dBT0JJeVBlTTMrY2pi?=
 =?utf-8?B?ZGV4dXlONTF5Ymw1d25WQ2lVakRXbHpWZmUrY1NDRG1VYkJmUXowZVZ5ZWJW?=
 =?utf-8?B?d1crTGhuNmVyUjhjbmlnTXY3L3Q4dTRURWk0VVZ4bTNnd040bmFzK0V0UW91?=
 =?utf-8?B?engzRUo4QStKeXptVjJxNU9DMFZoZ0srS1NveTMwcTBjZEhnZTZ4Z05kdndi?=
 =?utf-8?B?SlhZZ0czMk84SUdDT3ZUdDVvUDQwTzA1K2J5cEtHTEpvMHFmWEJhWnJUU29V?=
 =?utf-8?B?cmdqUTN6YjVSRytYMzM4dUQ5dGpGSzlXYm0xWitaeWJISCtabldjRkNYeFRH?=
 =?utf-8?B?OVhXY09GODRUQ1IydFBMOWROTU0za05IVndQSjBRSDg3WWwrYit0ZmRreUgx?=
 =?utf-8?B?L0s2YjlrMEdIYVF3OTU3YTd3OEhtYUxjNVdqWjVXY0FONGg1L1ZJWkIwb1Qw?=
 =?utf-8?B?cERSWHA5NzhHS1E4LzlLNVU2MG9CQndMcTRubTdGb0lONkw4cWRhd1V2Nmdp?=
 =?utf-8?B?OGk5T3VkeFd3T2hEWXlOOXVidHkySForMzlCbVRDVkdQTEVxRklTcmNaeFFK?=
 =?utf-8?B?dVhkaVcyKzJMaEJUTDVGUEU3OVRqN1ovMklpNXF6N3o4VnVlRzdDd2xJWGpu?=
 =?utf-8?B?Z0czaC9DYzgyZnBad2tGTWoyRUZ4c3B5bkdMRFh5ZEFaai9CRFJUOEc5eWs2?=
 =?utf-8?B?ZkU4RmhmRVF4VEx6YnNCTnpLWjFxQUEzSmhvSWlxcUpxaTlONW1VWjN5UmFu?=
 =?utf-8?B?QnhvMTdFQXMzMmhtRTd2RC9Yc2p0b0NBbXdtMUltd00yVGJRakxqdWM4SDZM?=
 =?utf-8?B?SWJ2OFNzUEdwUG43OWlSODZhYW1NRFphSVNhbXRLd0FjK1BFQzVhclpvRlBO?=
 =?utf-8?B?V3pjTVNqaHJkcDd4QXVsTGxuZzR4ZGR2cnU0eGFKUUlFb3N2eEZGQVZ1bDRJ?=
 =?utf-8?B?VHZaZExsVUFpRTdPZ0NuSXowaXVUYnVvS1dzZm1nb1owNjFIb044ZWsyc1ds?=
 =?utf-8?B?eDdsR29QRkdWbHEvZ0Jsc0xTd3R1OXlNbElERlE1TWtMZXIxUXQ0c2ZTTzAz?=
 =?utf-8?B?UEdCUGlIU0FkSEE4cnlvMlJGUk41dlhxWWpRcG1KRktTQ0w4V1hiWmNCT0ww?=
 =?utf-8?B?NndFaFljUGJTMFBpU1U2UDJESnNjWEI0SnF4YTlML1RaMW5LQkpNbVVKR1lM?=
 =?utf-8?B?b2ttS2JVM0REY3plNmJ0cUhqLzFIZGNSdlB2MnhWMUNZZFNHazcwalJlQjJW?=
 =?utf-8?B?dmh2ZTZNUUNOSVh0Yy9SODkxL1BFcVo5dDRSamUvVXdGYU5PRzd6ZklxT1pq?=
 =?utf-8?B?S09QNWI4MjFLWTd5S0w4UnBzMkZLaG45ZW1qMWRwWXU1ZzVvOS9qUGlPbm8w?=
 =?utf-8?B?ZmxDaVdXc1N0QVdYdDRneTBkQ3M3NCtEZ2JiVWRsZFFjV1FoWDMrbXJnWnN6?=
 =?utf-8?B?SFFuNHVyTG1HNy9BUFAxYjBKdVVKc05vUkJBOUxKOUhtMnBYeW1KY2RUM2ht?=
 =?utf-8?B?U0V5aE41OVN0NWFCem9kcEZINXJndzk2UHNwN0pZZmcwbTJGb0JtbDhqN2tW?=
 =?utf-8?B?VFZWY1RFdEdpYjZGMkZwRlNuOEdHaHVWMTRMTUswLzBGaW9lZUdiWmdkeDJ4?=
 =?utf-8?B?OFRwYU1IZ1RrempydHRJbDNhN0QxajRwSFJqb0dkN1M1enhuUnBEMno3Yjkw?=
 =?utf-8?B?R2RMUHc2eUt2YmowUngwMWk0bW5aclhKOEE4RS81bm1JcWMxVlNhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B4BA946F00F154A8B244723D9564987@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5a80c3-ed30-43c0-e200-08de5da66436
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 13:17:16.0155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prShmba0qjG77SqqYlzmgDvN+xYq9pmB6YrD8NXfga9ziLHIMaYYMCkSRY3+dSUEwQxbtK0X0qJE2zLETXfVFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16077-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,google.com,davemloft.net,nvidia.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:replyto,nvidia.com:email,nvidia.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: DC16D94C1E
X-Rspamd-Action: no action

T24gTW9uLCAyMDI2LTAxLTI2IGF0IDExOjM4IC0wODAwLCBEYW5pZWwgWmFoa2Egd3JvdGU6DQo+
IG1seDVlX3BzcF9oYW5kbGVfdHhfc2tiKCkgYXNzdW1lcyBza2JzIGFyZSBpcHY2IHdoZW4gZG9p
bmcgYSBwYXJ0aWFsDQo+IFRDUCBjaGVja3N1bSB3aXRoIHRzby4gTWFrZSBjb3JyZWN0bHkgbWx4
NWVfcHNwX2hhbmRsZV90eF9za2IoKQ0KPiBoYW5kbGUNCj4gaXB2NCBwYWNrZXRzLg0KPiANCj4g
Rml4ZXM6IGU1YTE4NjFhMjk4ZSAoIm5ldC9tbHg1ZTogSW1wbGVtZW50IFBTUCBUeCBkYXRhIHBh
dGgiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgWmFoa2EgPGRhbmllbC56YWhrYUBnbWFpbC5j
b20+DQo+IC0tLQ0KPiBUaGlzIGlzIGEgYnVnIHdoZW4gYW4gaXB2NCB0eCBza2IgcGFzc2VzIHRo
cm91Z2gNCj4gbWx4NWVfcHNwX2hhbmRsZV90eF9za2IoKSBhbmQgdHNvIGlzIHJlcXVlc3RlZC4g
SXQgd2FzIHByZXZpb3VzbHkNCj4gdW5kZXRlY3RlZCBpbiBteSB0ZXN0aW5nIGJlY2F1c2UgbXkg
c2V0dXAgaW52b2x2ZXMgY3g3J3Mgb24gYm90aA0KPiBlbmRzLA0KPiBhbmQgbWx4NWVfaGFuZGxl
X2NzdW0oKSBtYXJrcyBQU1Agcnggc2tiJ3Mgd2l0aCBjc3VtX3VubmVjZXNzYXJ5Lg0KPiANCj4g
VG8gcmVwcm9kdWNlIHRoZSBwcm9ibGVtIGp1c3QgdHVybiBvZmYgTkVUSUZfRl9SWENTVU0gYW5k
IG9ic2VydmU6DQo+IG5zdGF0IC1hIHwgZ3JlcCBUY3BJbkNzdW1FcnJvcnMNCj4gLS0tDQo+IENo
YW5nZXMgaW4gdjI6DQo+IC0gbW92ZSBkZWNsYXJhdGlvbnMgZG93biBpbnRvIGJyYW5jaGVzIHdo
ZXJlIHRoZXkgYXJlIHVzZWQuDQo+IC0gTGluayB0byB2MToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvci8yMDI2MDEyMy1kemFoa2EtZml4LXR4LWNzdW0tcGFydGlhbC12MS0xLTdiMDEwNzY5
Mzg4M0BnbWFpbC5jb20NCj4gLS0tDQo+IMKgLi4uL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZW5fYWNjZWwvcHNwX3J4dHguYyB8IDE3DQo+ICsrKysrKysrKysrLS0tLS0tDQo+IMKg
MSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2Vu
X2FjY2VsL3BzcF9yeHR4LmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZW5fYWNjZWwvcHNwX3J4dHguYw0KPiBpbmRleCBjMTdlYTBmY2Q4ZWYuLmVmN2Y1MzM4
NTQwZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9j
b3JlL2VuX2FjY2VsL3BzcF9yeHR4LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVs
bGFub3gvbWx4NS9jb3JlL2VuX2FjY2VsL3BzcF9yeHR4LmMNCj4gQEAgLTE3Nyw4ICsxNzcsNiBA
QCBib29sIG1seDVlX3BzcF9oYW5kbGVfdHhfc2tiKHN0cnVjdCBuZXRfZGV2aWNlDQo+ICpuZXRk
ZXYsDQo+IMKgew0KPiDCoAlzdHJ1Y3QgbWx4NWVfcHJpdiAqcHJpdiA9IG5ldGRldl9wcml2KG5l
dGRldik7DQo+IMKgCXN0cnVjdCBuZXQgKm5ldCA9IHNvY2tfbmV0KHNrYi0+c2spOw0KPiAtCWNv
bnN0IHN0cnVjdCBpcHY2aGRyICppcDY7DQo+IC0Jc3RydWN0IHRjcGhkciAqdGg7DQo+IMKgDQo+
IMKgCWlmICghbWx4NWVfcHNwX3NldF9zdGF0ZShwcml2LCBza2IsIHBzcF9zdCkpDQo+IMKgCQly
ZXR1cm4gdHJ1ZTsNCj4gQEAgLTE5MCwxMSArMTg4LDE4IEBAIGJvb2wgbWx4NWVfcHNwX2hhbmRs
ZV90eF9za2Ioc3RydWN0IG5ldF9kZXZpY2UNCj4gKm5ldGRldiwNCj4gwqAJCXJldHVybiBmYWxz
ZTsNCj4gwqAJfQ0KPiDCoAlpZiAoc2tiX2lzX2dzbyhza2IpKSB7DQo+IC0JCWlwNiA9IGlwdjZf
aGRyKHNrYik7DQo+IC0JCXRoID0gaW5uZXJfdGNwX2hkcihza2IpOw0KPiArCQlpbnQgbGVuID0g
c2tiX3NoaW5mbyhza2IpLT5nc29fc2l6ZSArDQo+IGlubmVyX3RjcF9oZHJsZW4oc2tiKTsNCj4g
KwkJc3RydWN0IHRjcGhkciAqdGggPSBpbm5lcl90Y3BfaGRyKHNrYik7DQo+IMKgDQo+IC0JCXRo
LT5jaGVjayA9IH50Y3BfdjZfY2hlY2soc2tiX3NoaW5mbyhza2IpLT5nc29fc2l6ZQ0KPiArIGlu
bmVyX3RjcF9oZHJsZW4oc2tiKSwgJmlwNi0+c2FkZHIsDQo+IC0JCQkJCcKgICZpcDYtPmRhZGRy
LCAwKTsNCj4gKwkJaWYgKHNrYi0+cHJvdG9jb2wgPT0gaHRvbnMoRVRIX1BfSVApKSB7DQo+ICsJ
CQljb25zdCBzdHJ1Y3QgaXBoZHIgKmlwID0gaXBfaGRyKHNrYik7DQo+ICsNCj4gKwkJCXRoLT5j
aGVjayA9IH50Y3BfdjRfY2hlY2sobGVuLCBpcC0+c2FkZHIsDQo+IGlwLT5kYWRkciwgMCk7DQo+
ICsJCX0gZWxzZSB7DQo+ICsJCQljb25zdCBzdHJ1Y3QgaXB2NmhkciAqaXA2ID0gaXB2Nl9oZHIo
c2tiKTsNCj4gKw0KPiArCQkJdGgtPmNoZWNrID0gfnRjcF92Nl9jaGVjayhsZW4sICZpcDYtPnNh
ZGRyLA0KPiAmaXA2LT5kYWRkciwgMCk7DQo+ICsJCX0NCj4gwqAJfQ0KPiDCoA0KPiDCoAlyZXR1
cm4gdHJ1ZTsNCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNzA5YmJiMDE1NTM4ZGZkNWM5NzMw
OGI3N2M5NTBkNDFhNGQ5NWNkMw0KPiBjaGFuZ2UtaWQ6IDIwMjYwMTIyLWR6YWhrYS1maXgtdHgt
Y3N1bS1wYXJ0aWFsLTk1MmU4ZGMyODM3NQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQpSZXZpZXdl
ZC1ieTogQ29zbWluIFJhdGl1IDxjcmF0aXVAbnZpZGlhLmNvbT4NCg==

