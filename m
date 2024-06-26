Return-Path: <linux-rdma+bounces-3532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA09918E23
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 20:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FCEB20A3F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF03E19047B;
	Wed, 26 Jun 2024 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hSrSkEba"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2128.outbound.protection.outlook.com [40.107.104.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35DD14A0B8;
	Wed, 26 Jun 2024 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425987; cv=fail; b=Xux03CBbMiROPJBM8w7Lt0YEM0dve24DOlHsTMcB2OFb6878IKLeJeyAEgmdywXjnZ18sSBYBdFg5DXL3XXQFv9zYRXF/842LpViFgZgid8Kzd7kWXRL4QIC9tyOJV9lcYI5zPwHjTmCXzkECCr9hk/m7qeLowtrh9OGBdeGzbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425987; c=relaxed/simple;
	bh=S7vKsGhbldWjZr3F4KYgGzlXdSChUbsv3lNXbZ8vqsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cMXTOzrw34AyiPCwiT/sXvcAiSUblT3qkDrRV0qW5LGm33i/KOF6AIkVPZ1FEQ30v0JuM/ypKIqKngC+6bIbPsAwvBAEYb9FSND3cfsrCJUrwQZPpUkwRjUPBMZNrX5laxGpOK+GTCkydQ5u/lHwNVByFLxihPoKj1J2LwjUHUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hSrSkEba; arc=fail smtp.client-ip=40.107.104.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaCr/gCgHsCXRG3Y9x0ps5zZ3NkKhSzpsCoauAqFhvcwu2hSpP/jXIMsSq/I52fFyft4lILuWNsVv8SvbkbLWbK0mvUwjC4wr90tJY3X9hLeWUf0U2s632036CcGmkZpGwY+GhBAExpPnCGKPyC7WuOvFOXeQVer7sj55k3dXqMwSJITsJmzgPAg9FfvRGeIbCCTIbiKvqZtZva+iQhglSCskLERcnICKR6IPi3Lwk/gP5JhR6YDYVrJEW/guFfkOsl77EIYCUii6C0Juk/D7u2S4wtW0vjcdicOtVDI/VwkFza5KOvTNGHynDtY+hgPbF+rQGZ1aYOvwQ0fuT6a4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7vKsGhbldWjZr3F4KYgGzlXdSChUbsv3lNXbZ8vqsE=;
 b=Bl898E3dUl5HqiJiZEC6W0Gu8/AQ6Ql5mELSX6izobBCeyOKcbIrjWE5uh27ZGh6d/6F0WJJ+mbOlu6plU8x7IfaxfHLc59DI098OnZjdynEvSNSUEz9vL7ADCRKEycAtTUJl/jUmWh4qTOgUPIiOHCyGe45M8OR7LGTCcOWaDq+Z1KzEbl1mBgbzDOEwKM/uO0Qg3sWSNHnzB86aDJBTGoqpZfir5ffXA2/uYeKe6+2Fqd9qv0tmxbYynQt8nrqkg9Dwiq4T4HfTLjy5XGahqN/HnIGv9TrVegT858RlnAvAiruIoBSMr9itWMOd2sjyvhDGDF6lonihbqiY9YxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7vKsGhbldWjZr3F4KYgGzlXdSChUbsv3lNXbZ8vqsE=;
 b=hSrSkEbaJB8FEL+qtmRcrYMji+Fi1Oezy6/Dd5T9a2Pr7fbfYUzHXnrJFiZAijOb5SMzpmGwOqFI3lN3b5NLXBJ6xXx5x8i0JoiW0q3D2jbPCqffKQHKjX8QuGHUx1Iap7yn0zx76nC3cOayd3nAjwuQd8QTQ2mcTdo8mtZi94U=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by PA1PR83MB0688.EURPRD83.prod.outlook.com (2603:10a6:102:450::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.6; Wed, 26 Jun
 2024 18:19:42 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7741.001; Wed, 26 Jun 2024
 18:19:42 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Leon Romanovsky
	<leon@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Wei Hu
	<weh@microsoft.com>, "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, linux-netdev
	<netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Index: AQHax/VptPUFxpDhC0qzKAWZO+66RQ==
Date: Wed, 26 Jun 2024 18:19:41 +0000
Message-ID:
 <PAXPR83MB05592AE537E11C9026E268F7B4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
	<20240626054748.GN29266@unreal>
	<PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
	<20240626121118.GP29266@unreal>	<20240626082731.70d064bb@hermes.local>
	<20240626153354.GQ29266@unreal> <20240626091028.1948b223@hermes.local>
In-Reply-To: <20240626091028.1948b223@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4b29753f-b919-45bc-b000-b5171f6f686c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-26T18:16:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|PA1PR83MB0688:EE_
x-ms-office365-filtering-correlation-id: f79294b3-b5a2-43a8-4706-08dc960c8c77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?RURFdHVqQkVvMkROdmxpSkp1ajdVNkc5Ry9zclp2T01DcVdrZVcwRXFpWG0r?=
 =?utf-8?B?cVhvc1VXa3FEMjA4Ym1aSWtiRGlPb0lhRXRmTXFVZ0pZRHk0UUNuRUM4akZl?=
 =?utf-8?B?RWNVc0RkOWVlS3NVZHJKNEZKdW45WmVyeDRTZmRRcHl6UVBnQjZGOGdaRGhH?=
 =?utf-8?B?TC9QQmwxMjlENnBqWFJ3YTIzRnNST3EwMWhOUzRrSnJYcTBRZlU4U2NOc0tt?=
 =?utf-8?B?d0JiY2JobEl3eGlEUExPZXFERjdJczBHZzZqU2dSNHVwSjZVWHV1cjFORlVL?=
 =?utf-8?B?dzM0MTVYRHMxVVVPSTBHb1EybHhrTEdTL0JSSDFJaDlZdHVhUnNYLzQvZ3VU?=
 =?utf-8?B?S3EvbThLWk10TVdSN0FJR2MzZEhNRzVtTWdqMmRDc2drRSthZmR4NjJNQS9T?=
 =?utf-8?B?RHZMcndieXZ4OCtjYzFMazBpamJIelowS0V3aytMaFB0R3RDc1Y3bzJ5Tkls?=
 =?utf-8?B?OFhscDZJSmIvNkk3RW5HMjdNc0tjamtqM09Zb1BBbmZlSTFWSnZKRzJ2NXNH?=
 =?utf-8?B?QS8vZ1dHOWlIOVl1dW5qRjlacEI3Y2ZSUDhqaHdHeWZONjJZNXZjSnRpZUdJ?=
 =?utf-8?B?MXVkUEJVcnJNTm5nb1dNMVVsSld1bWthUTlpNWdkQnN6RGQ1U2FPRDA0UHd6?=
 =?utf-8?B?M1RKQ21yZDlFaG1mbWhZdHV6R3hjMlpYY3FhNGRsUlJyWmR5Y045Z25FWnE4?=
 =?utf-8?B?RW9yK0hJQlhwdWx6SW1tdi8rZE4xZDVwYlZjK2xQMVNTNm1ISnNqeG53bWZo?=
 =?utf-8?B?RXI2NHhPMFYwaEtUTS9XaUoxRlA3aGVUK3JvSTRmUHp4Q3RJMHU0VVRLaVNR?=
 =?utf-8?B?alAzL3l1N3NYU21xRHN1eVM1N2txaVkrMXNzdjJTVkpYMnZaVGwxNnRsaVpH?=
 =?utf-8?B?dDNyN0FEakZ4KzFTblRmOFVMaUtnRWlweTdjTUhZZ3dpcHZma2U4SHAwd25C?=
 =?utf-8?B?TDdaNTRVL1BWdFJBRzBvY01RbTh2US9OaVQ4aHZGMTFVRlNJWWc1aDNYR3Vv?=
 =?utf-8?B?THRFQ1dVQWdGbnpLaDhzL2JYZmlGMDgvdXhnMW44THJ3d3Nyak1MbEpBcm5i?=
 =?utf-8?B?OTNaSnpzaS9ZZGVOUktGZ0RJVDdxazkxUkE4WEdOcEJhZjFZZEkxcWpRQWlJ?=
 =?utf-8?B?TUptK3hMVGNjYVRiemxZMEhtWVRzSG1CcXpCZTVNV3k3YVpLMmNVTEZ2RXg1?=
 =?utf-8?B?N3dLbEhhaWFwNy9ISGFxUGNKb2lUZEFZUFBUdURlejRma0libEQ0KytycDd4?=
 =?utf-8?B?MWZWNTFhNzF3b29EMlZKMVFQM3JhWTdDMTUxVitCOWRMVk5HZCtLaXVGQ2sz?=
 =?utf-8?B?aWVmRExic1Rka0JEWnR4MzVuNVd2VUd6OXhYbmNiQzB6Y3h6cnpvSEo0NWJO?=
 =?utf-8?B?dHE0UWNXSGpnM2o3Tm90dVdFOGhZQUNxbEF2ekpqc0lONjViR2RUQnMvQ25J?=
 =?utf-8?B?eU1GeHRyTG5ZclhqRkVNZlhOWWNGcjcwOW11bVc3a0c3b1NyOGZTWGNrL1pW?=
 =?utf-8?B?UUtnclNTWFBmUkhrY1ZLSVJienNJMFdiYVEyaTlTcUlPbU0wcVlNb3ExNXdK?=
 =?utf-8?B?YnN0cExHdncwMG1ZNGdGc2YwdDlDSHlFUnEwRi9CdHJzWDEyTU1BcUxBbTBP?=
 =?utf-8?B?OWFFSGFrMGhuM0h6dG13Z1R0V1hzQmJZSkFSWHJSaUd1N21UYmp6Q0syYUVY?=
 =?utf-8?B?RjNLbTRlRkJ5MEJmejZ3KzJab0RzOVBJZUNaNVdUNkFvRUlUV0Fzd2d4VStD?=
 =?utf-8?B?WDFqNTJoU1E3bk1YTkJYbm5nS3dTMDVIQWk2RGFQbkw0cG81TnNhbWJscGU4?=
 =?utf-8?B?MElzUm12UGdnL2VmQWE3NUYwYW1IYUQwUy90MFZVWjRnU2ZpYVIzWUU5a0t6?=
 =?utf-8?B?ZFkxcy9uQThXNWRwdkphczl4d0JtYVVmRUtOb09ieDVsaFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1J6VEt6VEkzdXRiLytmVEdQWlFFdERtZUN4M0tKV0lKQ1dZY09BWmduLzNC?=
 =?utf-8?B?bkF3U2hZbXF1Zkw3OUtEa1A5emlHcEdFeFdObnN3NWJ6TmlUK1E0dGNCazY3?=
 =?utf-8?B?SHFRYTFMSHBWeUZYUE5MVWw5TkJpVlREbHM2bUVKb1JBNXFKRGp3bjk5NEFq?=
 =?utf-8?B?VFBiR3pTMmdSZ2FXb1BRb1NLQi96RjBqUE0vZFFrdVBWV3ZGZGcrWTNNeXE1?=
 =?utf-8?B?YnRJcUl3eFdkUFpqUlRsZWY2cjlJNG9tUjZlTlU1VWgxS3VoQUxmQVVaQ3Zz?=
 =?utf-8?B?SVZLOWhFRld6VXdzTi9lQmFVZm5aUElVQXBtYW5obEFjL20yM29BNFV4Yllm?=
 =?utf-8?B?VWwyUU9FTFJxNWYxY2xYWWRIR3Z2U2t1Ym1LdEFMS0ZVbUgycEJHODNicTFk?=
 =?utf-8?B?dDBkOVhLRU9mZzIxZ05QZ2p3cXdBcm9XVVRXUGxETGhtZjdRbk9oZ2hrQVV5?=
 =?utf-8?B?dnRlRlNsbHh6VGhRdnpKSjRYbVhaK2U4VWNPWkUrYVF5TTNjWHdlenAzUlZI?=
 =?utf-8?B?eWE0a2JHazR4TkZmOWlWRXdmaTU3RzZvclJFWmhpTWcrczQzTWJaek9yRGhL?=
 =?utf-8?B?ZUkrL3Q2WkthcVVEbVNRTlBYcEMxMkZDK1dJSUtXRlJSZkY0YnQzTXZFMXZ1?=
 =?utf-8?B?NFJQSjR0cGhjOGRwc2wyZHJFT1RQUVpBSFpOaElrMGU5dFNWbmNlczZveGVW?=
 =?utf-8?B?VEJUUllhUFBzTjMzc2ZwUCtrUVFmbFlRcFl5S1c0a1JUNFRWZVJQbnBJZ0ZW?=
 =?utf-8?B?d2Vqcy9PbWsxQ05YeVR3YXZnbGxSTm44ZWs5RDN2THlibUZFN0JNYlE5WFh0?=
 =?utf-8?B?WXM5SjNKSVdVeHZ0N3JzVEkyenJZOW1RTk1Hck1SeHhkVXByTklFZ2RCTjlj?=
 =?utf-8?B?UVdIZUNvRjNrVUJuWkNXL0VzRm1UeXdGWnF1ZStkNW9QR3hMb2doU1RKZjYw?=
 =?utf-8?B?MkU1TjcxZ012bW82QWo0RkJVMDVNSjlqMy9udnhwQm95UWNsWTZMZDY3VXZu?=
 =?utf-8?B?Ymk4V0Q2N2UwcS84SHhXcXJEc1hyVlZIUCttYVFuNWI0bUdvc0NlbjVrYTRk?=
 =?utf-8?B?cGRQcXhoTFNYL1IwRys1RmEyWVlSdWF0TVJRZm1wWFM4Y1AvTXlLUDdvYjRV?=
 =?utf-8?B?TWlXN3E3ajYxRmNFVm5aalF3OXBGTjVoUWc5NjM3U1pQSi9oLzNleEIzdlNO?=
 =?utf-8?B?T09aczJyTFlFKzF1OW9VRzhnbEY4SW1HbVd3dTFOZytnb09LeXpOeFIyNTdS?=
 =?utf-8?B?S0dmbWs5dWVBd2MvRStHN0EwNDk3T0IvNUd2a01MSGhhRGpYZnpmeURCR2l2?=
 =?utf-8?B?Y0RGTW9VRjFXZjFES1E3V1M4bFhSaGZHUDZLcElNN216YW5xTEtMSlVsU1NM?=
 =?utf-8?B?Z3cyTkpVaFFNL00rZXNZVDhVN3Z3TWVhMXlEZkJqbUViYlovSVdqbFNPYWhH?=
 =?utf-8?B?SkxYNnJhSmJlWDEzTWZ3bm1TSC84S3JwMCtucUpFRzI2QmFTQWJYY1NnaTd6?=
 =?utf-8?B?alFNUXF5aEFpUWJ5UHdyWUlTOHRObnhtSVlPbjBVRHQ0TWNRUzhIM2RnNWZj?=
 =?utf-8?B?MFBucElka2xHTU56bkQ0SmFlQzlRNG1zYzE1ZkJkSmVPZUR6TjZvMHJXV2ZS?=
 =?utf-8?B?SGVpQkpoTmxCS05ONGkzcmcvcERYTlFEWnl6Zk9lUDE3dXVNeE83L0QwbmF0?=
 =?utf-8?B?UW1MbzcrVkxtZ3dDZ2RMRXhGMUNDZTVBN0Z4c0tKTS9zNFJmQmRBQW83T2ZP?=
 =?utf-8?B?TVlQQ0pjOXV0ZWF2Vmd6c0VWaFAxQ2xDZm5USkxqbm5XR241K2ovUFUvOXpj?=
 =?utf-8?B?UUNvY3JsY083NDJkUTlRY1VUOWdHay96MUxieVRlUDRZWkZCRGlpeFNQTldG?=
 =?utf-8?B?MGlIVjlJWTRhTU1aeTd4ZWpkZ3pyeTFlWWtrdUFGMkhsV1h0OFhjblJYRC9I?=
 =?utf-8?B?bGVaZXhhU2FXWFFManhKN2dXcmZIdHRyQTRhTFdpdWUwdnFndHFzeXNWNGNG?=
 =?utf-8?B?Q3ZzV2ErQk0zSktiWnFoZHhXMGpDYTRKRXU2WEtRcnQramQrdXUvTlJLR1Vp?=
 =?utf-8?Q?tsScSz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f79294b3-b5a2-43a8-4706-08dc960c8c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 18:19:42.0073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8gzlRyBjW3QowLF115Cdg/yy7B9AdjcskYYR42kN2NkguWOKOnnnVF6gQ5MKaND7W07fDWkAZUklzmWHOXHP1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0688

PiA+ID4gPiBPbiBXZWQsIEp1biAyNiwgMjAyNCBhdCAwOTowNTowNUFNICswMDAwLCBLb25zdGFu
dGluIFRhcmFub3Ygd3JvdGU6DQo+ID4gPiA+ID4gPiA+IFdoZW4gbWMtPnBvcnRzWzBdIGlzIG5v
dCBzbGF2ZSwgdXNlIGl0IGluIHRoZSBzZXRfbmV0ZGV2Lg0KPiA+ID4gPiA+ID4gPiBXaGVuIG1h
bmEgaXMgdXNlZCBpbiBuZXR2c2MsIHRoZSBzdG9yZWQgbmV0IGRldmljZXMgaW4gbWFuYQ0KPiA+
ID4gPiA+ID4gPiBhcmUgc2xhdmVzIGFuZCBHSURzIHNob3VsZCBiZSB0YWtlbiBmcm9tIHRoZWly
IG1hc3RlciBkZXZpY2VzLg0KPiA+ID4gPiA+ID4gPiBJbiB0aGUgYmFyZW1ldGFsIGNhc2UsIHRo
ZSBtYy0+cG9ydHMgZGV2aWNlcyB3aWxsIG5vdCBiZSBzbGF2ZXMuDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gSSB3b25kZXIsIHdoeSBkbyB5b3UgaGF2ZSAiLi4uIHwgSUZGX1NMQVZFIiBpbg0K
PiA+ID4gPiA+ID4gX19uZXR2c2NfdmZfc2V0dXAoKSBpbiBhIGZpcnN0IHBsYWNlPyBJc24ndCBJ
RkZfU0xBVkUgaXMgc3VwcG9zZWQgdG8NCj4gYmUgc2V0IGJ5IGJvbmQgZHJpdmVyPw0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgZ3Vlc3MgaXQgaXMganVzdCBhIHZhbGlkIHVz
ZSBvZiB0aGUgSUZGX1NMQVZFIGJpdC4gSW4gdGhlIGJvbmQNCj4gPiA+ID4gPiBjYXNlIGl0IGlz
IGFsc28gc2V0IGFzIGEgQk9ORCBuZXRkZXYuIFRoZSBJRkZfU0xBVkUgaGVscHMgdG8gc2hvdw0K
PiB1c2VycyB0aGF0IGFub3RoZXIgbWFzdGVyDQo+ID4gPiA+ID4gbmV0ZGV2IHNob3VsZCBiZSB1
c2VkIGZvciBuZXR3b3JraW5nLiBCdXQgSSBhbSBub3QgYW4gZXhwZXJ0IGluDQo+IG5ldHZzYy4N
Cj4gPiA+ID4NCj4gPiA+ID4gVGhlIHRoaW5nIGlzIHRoYXQgbmV0dnNjIGlzIHZpcnR1YWwgZGV2
aWNlIGxpa2UgbWFueSBvdGhlcnMsIGJ1dA0KPiA+ID4gPiBpdCBpcyB0aGUgb25seSBvbmUgd2hv
IHVzZXMgSUZGX1NMQVZFIGJpdC4gVGhlIGNvbW1lbnQgYXJvdW5kIHRoYXQNCj4gPiA+ID4gYml0
IHNheXMgInNsYXZlIG9mIGEgbG9hZCBiYWxhbmNlci4iLCB3aGljaCBpcyBub3QgdGhlIGNhc2UN
Cj4gPiA+ID4gYWNjb3JkaW5nIHRvIHRoZSBIeXBlci1WIGRvY3VtZW50YXRpb24uDQo+ID4gPiA+
DQo+ID4gPiA+IFlvdSB3aWxsIG5lZWQgdG8gZ2V0IEFjayBmcm9tIG5ldGRldiBtYWludGFpbmVy
cyB0byByZWx5IG9uDQo+ID4gPiA+IElGRl9TTEFWRSBiaXQgaW4gdGhlIHdheSB5b3UgYXJlIHJl
bHlpbmcgb24gaXQgbm93Lg0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgdXNlZCB0byB0ZWxsIHVzZXJz
cGFjZSB0b29scyB0byBub3QgaW50ZXJhY3QgZGlyZWN0bHkgd2l0aCB0aGUgZGV2aWNlLg0KPiA+
ID4gRm9yIGV4YW1wbGUsIGl0IGlzIHVzZWQgd2hlbiBWRiBpcyBjb25uZWN0ZWQgdG8gbmV0dnNj
IGRldmljZS4NCj4gPiA+IEl0IHByZXZlbnRzIHRoaW5ncyBsaWtlIElQdjYgbG9jYWwgYWRkcmVz
cywgYW5kIE5ldHdvcmsgTWFuYWdlciB3b24ndA0KPiBtb2RpZnkgZGV2aWNlLg0KPiA+DQo+ID4g
WW91IGRlc2NyaWJlZCBob3cgaHlwZXItdiB1c2VzIGl0LCBidXQgSSdtIGludGVyZXN0ZWQgdG8g
Z2V0DQo+ID4gYWNrbm93bGVkZ21lbnQgdGhhdCBpdCBpcyBhIHZhbGlkIHVzZSBjYXNlIGZvciBJ
RkZfU0xBVkUsIGRlc3BpdGUgc2VudGVuY2UNCj4gd3JpdHRlbiBpbiB0aGUgY29tbWVudC4NCj4g
DQo+IFRoZXJlIGlzIG5vIGRvY3VtZW50ZWQgc2VtYW50aWNzIGFyb3VuZCBhbnkgb2YgdGhlIElG
IGZsYWdzLCBvbmx5IGhpc3RvcmljYWwNCj4gcHJlY2VkZW50IHVzZWQgYnkgYm9uZCwgdGVhbSBh
bmQgYnJpZGdlIGRyaXZlcnMuIEluaXRpYWxseSBIeXBlci1WIFZGIHVzZWQNCj4gYm9uZGluZyBi
dXQgaXQgd2FzIGltcG9zc2libHkgZGlmZmljdWx0IHRvIG1ha2UgdGhpcyB3b3JrIGFjcm9zcyBh
bGwgdmVyc2lvbnMgb2YNCj4gTGludXgsIHNvIHRyYW5zcGFyZW50IFZGIHN1cHBvcnQgd2FzIGFk
ZGVkIGluc3RlYWQuIElkZWFsbHksIHRoZSBWRiBkZXZpY2UNCj4gY291bGQgYmUgaGlkZGVuIGZy
b20gdXNlcnNwYWNlIGJ1dCB0aGF0IHJlcXVpcmVkIG1vcmUga2VybmVsIG1vZGlmaWNhdGlvbnMN
Cj4gdGhhbiB3b3VsZCBiZSBhY2NlcHRlZC4NCg0KVGhhbmtzIFN0ZXBoZW4gZm9yIHRoZSBleHBs
YW5hdGlvbiENCg0KSSBhbSBhbHNvIENDaW5nIEhhaXlhbmcsIHdobyBtYWludGFpbnMgSHlwZXIt
ViBuZXR2c2MuDQoNCg0K

