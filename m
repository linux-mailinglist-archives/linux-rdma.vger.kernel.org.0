Return-Path: <linux-rdma+bounces-13702-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F18FBA74C0
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 18:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB50C176F51
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597F723B638;
	Sun, 28 Sep 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gzEyWyX/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5592356A4;
	Sun, 28 Sep 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759077664; cv=fail; b=D4Ri518CT1WVFa85+kDel1yNigxPPUoqTTvmtO0xwfHnlEDNGhbneQY75aerZiSLcb/BuLws+X9GCu4rVOwyv7IbXElQBEgDAKiBOG/fGBuy7Q4A6nrm99wsfa/KClAGX8Gfc2nRghO+W3O/7zViSRT6OU3UP5mff62ck76L0SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759077664; c=relaxed/simple;
	bh=NLiHT6bEGdCuqQY/U9zgxdfGEW5uYbAiOuoh9qAHrcA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcCwJz7J6wNTTbHg4im6254hL2Wfm+GFO62WdsD4R0UfRkg3M8ALjltlE6PtOHmbteoR4TdocZuw70wGepky7fMuIwihVyMtbXEMjWdJkkASMCUix7wvO7emSgNhHFhV9DpYaL4T8PGn1y3djjjcPl2XA85awv/xZHQY1RUgy/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gzEyWyX/; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGd4n6/Kf4BKBzUdSEQRkiPSOxtrh8zCKjeHP190TfjZv+BRlnKpqh3IIl89d36323EoaWtZkTwNXMRZdhsFJWMrV0I/LEK1Tmjk3S7I0c6spNqKxJCtrN2bQvZTDd/D0lWR88ftPFxju3XxZeRcQjUhR4KECxHrUM1L/CWbqtRoItrH/t4plJaz7SvniBvUe53cnHdYwu6D+L+qWAXZmwpAuJleaM3yKPLxzx7Nx5qtquZTX/BcEaAZYCJaaHdmloIDDEDcsUamNzlFkCctWXgobph/GPfjFD3IFD3vqLhj9KgZEVU3yX4LsTetJLVDdWfw5ec66R5hqcyhGHrc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhNp2avR7CVv2y+lS/zxcEImynVEdjI3Bn33KlwgIN4=;
 b=yNZ0uk97qRGlzhXXEgpR6kKmrCjmA+lhauVvmhNjI0BGkB+MozOMBMTWi3O45t3VvMFYXNd1nEDNOEy2qZgIZeARNr0pS6u651cHBfWPYdL+jyykKtu0Q60cSPYPpM6KM0jVlq2dFNEyGehk3nDYUhVgMQS0QFHSg/OmDe4rv7Lik8wtHGVL5nybFpra4v0GsOLs+TjzPLz+I68LeOp/7VKcYEPMRJg8b3kZ7wgCeaK0AoL03FjI6pKdIsSOTRbi3JgASoFdlMXeNVYy0e1Xugc2m+wnPBTo2y0CMa8ZU33uJ9Pv5KVJica9CxntycEGkxJVKI4qdglINsZSFfavfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhNp2avR7CVv2y+lS/zxcEImynVEdjI3Bn33KlwgIN4=;
 b=gzEyWyX/B8C30GK9pyANz1O2r2UoDLKyddvAYu0y2+Tk8spBPGa9Pz7r0RzW4ZsxRLnLj29DBYIPFRitOkJpa15pMZbv3/ta8E8H4RYDvljotTMQFNbnr/Ns1UWRJaiDpc1i6sgsOeQoMJOFll583smWFJ2T+BOlaQhWd9jvf5XAQyr7wjJmylCZ6vwA4wK6UstYLW8czMU5dkqv/bxwjEGxMmpI0BRHlt1cdnU9LPbsv8rM7BMKqhjRD5vHQ4KadZ+U1IGS9r7M0YPpkJpxjQBUdMamFYHlcn77mGJXi7ovOB/aen5En5NAVvyjlwBLhkfw2jwGPhktfA9ky2RwBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CY1PR12MB9628.namprd12.prod.outlook.com (2603:10b6:930:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Sun, 28 Sep
 2025 16:40:59 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9160.015; Sun, 28 Sep 2025
 16:40:59 +0000
Message-ID: <2c86405e-ae95-4567-b359-36c4dca1fa25@nvidia.com>
Date: Sun, 28 Sep 2025 19:40:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
To: Markus Elfring <Markus.Elfring@web.de>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
 <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
 <8b0034a7-f63b-4a98-a812-69b988dd3785@web.de>
 <7d46a1d1-f205-4751-9f7d-6a219be04801@nvidia.com>
 <5b8b05c8-91db-40a2-8aff-c6e214b1202f@web.de>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <5b8b05c8-91db-40a2-8aff-c6e214b1202f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CY1PR12MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a932d6a-59d8-4e93-107a-08ddfeadcd80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmo2MXp4YUhzYjlrUnRvYWRrNzRKTUFPRHJ5QUZzQ0NaN2VteThuY0NzRGV4?=
 =?utf-8?B?cC9PeTkweTRwVFpidS9nRjErclVVOFV6OEF6d2xQWW9lYTRvRkljLzhvTU5E?=
 =?utf-8?B?Z015RDZETS9KcWlzNG1aQ2hlZGJnMDdTaGFKTHpjWkFuRTZNaFZCSHNCazVD?=
 =?utf-8?B?MUFlRnNFQllFL3BQQVp0MUN1UEp3OHhPQXQwRHhWR3lLU2NOMUkzYWpENFF3?=
 =?utf-8?B?cUsyYXFrdDc5Nnd2NWxreEFyK1BYZCtCbDRyMWhjWGZoQ2FVc1FLMFVxZzZs?=
 =?utf-8?B?U3RRcjZVeUN0Rnc1bHFaVjBoaXAyZUZxUzlKVGN4N0hIdTBxNGZEcGI1R2lp?=
 =?utf-8?B?Tm1VRld4WHFpc0Fmbk9MUjRQQ2NRekFFc25RR3puTmxkRHZMT1ZDOCtYQ3hx?=
 =?utf-8?B?Z0tEWCtwdmJRcEVMNlNnQnZlY0d5YnU0ZVJZOWZlNk1idXlHRVhsQWE1Wito?=
 =?utf-8?B?eW9DOGhsSkVERGFmOERBcHFabGlGYURESzdOeHlJWXdEN2l3ZHV1SHpwRVNk?=
 =?utf-8?B?NjdtZ0tGbzFXaVVTaWRaN2hFVzErR2hBNHozRFpzODhLNXNZZ3N3T0l6aTNC?=
 =?utf-8?B?MnVRREtkWHMzQzdjWks4UGJNVHR0TFdVSHFhdlJENlFXYmdvQ0pOS1M4cHp0?=
 =?utf-8?B?VnB5dXpSOEFHaDZhM2FkRUorTitta0ZFelZmQjFFd3NiOVVGdWQxYmdxVEE0?=
 =?utf-8?B?OXBxTjM4dEp2eWpqSXY2TGtlaWkzSXBhc252VkR3ck9ZWW9lbFRWd0g2ZWVz?=
 =?utf-8?B?TWVwTm9xc0JXSFpWNnpVemRiQUhMQytkSmh6dUJwejNZMjdFZU9GT1pHZFhl?=
 =?utf-8?B?bjZ2dFhBdzVBTXpoa3ZoSGVvcFBPaGJqWTJlcTVKZjRUV1dNU1FkQ1ppczgv?=
 =?utf-8?B?Wkw3aVZGeWsxc1R5VFRsbnFyckxrbTY4WDFiV09CVzZaN05aN3NQV095b2FM?=
 =?utf-8?B?ZzRZMmdwMEh6Zlp2bGgyRFJRUGx2cWNGa3NIZ2JJT3VWSWdHdjhSWmMrY0Jw?=
 =?utf-8?B?THloanNjdzFuZmUza1Uwbk5qOEtUZVBHUTBhYzFOVGNOY1hNL1V6NFo4RDhM?=
 =?utf-8?B?dnhYZkdPcDNRWGVnR3J4dndudTF2c3VvbWRtZHFQUU9UT3gvNENjWWNtR3Jl?=
 =?utf-8?B?SC9rR0VBS1pETERaZHpNQ0t6TTBYRnYyRDRidG9JSXNRSTZ5bks1eXIwdGo2?=
 =?utf-8?B?bFJKaU1ZOTZxTjIwMW40cHJVbTYyZFFNNktydmVzeHltYXU0UWlhbWJYeW9Z?=
 =?utf-8?B?U0Z6L2FjYmJnVWx5Y3RGdWt5ZjAxRHBvaGJDY2orYVVyWHdrTGx4VmNwcnRS?=
 =?utf-8?B?YmRsMHkzQUlwbHR4SXhUWjFYbTdwY1JnYy9TblVxQkg4dGNyeFFCbElDT0VX?=
 =?utf-8?B?cnkvelFxSkExUEh6N3hpVkg2YjFTTXQxekNiUEljcGNDQkRBUHQ0VTJlQm0r?=
 =?utf-8?B?M1J5MnZaVnVBWDB6dTlVaVVOR2Z2ZmJuU2ZQNElPN0xkVmtIV1kwQTNBNkln?=
 =?utf-8?B?emxHK0ovZFpwb0lLVHE5WGpySDdnaEswWWtOOUc4cDZzQ2hnNkxoSmFpa0dt?=
 =?utf-8?B?Z0EwcEZLaldxWmEzUVhWQStzZFJzYzI4aE5YbUMrR3lqekw5ZkQwRmJzMWFi?=
 =?utf-8?B?TGJlUU5tL2ZUTzBoWVordGZqNVFsWTB2VDZ4QTI4RTcrNFlFWjZBcTVmQWVG?=
 =?utf-8?B?Y2RLcmkrZHR6L1pUWU92eGIweGR4RDZzS3ZIVWFoTzF6Y24yRkVHRlp2L0ox?=
 =?utf-8?B?cmJJMlZqaldzZ1Q5d0t2T3dKVU9lT24xcHA1M0RJcThuaUEwUDZwRVR3NkFX?=
 =?utf-8?B?N08wbkhvNW1IRW45QkdLSC9LTzFxbTdaQTNiS3F4ZW1hME5zUS9pSjd1M0pB?=
 =?utf-8?B?S01GRkdpRllKcGJLSm1XL3BpYURJQzFpdzd6MVkzcy9OR0wyenNJQUZWVnZN?=
 =?utf-8?B?Y1k2WFo4R1VMR2Z4S0dPTzAwbDRGRUpRMit5ZDJwUE1ySWtVSGxEeWs2T3ox?=
 =?utf-8?Q?RGzHxzlcbnJBLN7t/QNRh1kmLis0xI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUVVM3FWN0xldTNpVzhPaDdsemNNdGVBTmdtSXlDdWY4YlFudmtrUTByaTZr?=
 =?utf-8?B?TnR1aXoxdkJ2MDR1RWdxRFlkdlk3ZEZKd2pqRktYTkRSNjQ4eGxkYVhBVm5E?=
 =?utf-8?B?ZGRpVWIxZzFrYXRhWENzRWIxQUJNaUg1bEF1dWJmTEZQTDJlb3JDeGxFaFRp?=
 =?utf-8?B?VFd6ZHRIbXdpeFVyeitwU0M5QzVNVmtLRXJORnFCSTR2RHBreUdhQk90bWxk?=
 =?utf-8?B?MzZDYWNuR1BMaEpMSFJEZnJmL0hQV2EwRUYxUTMxYWpVNzFISncxSzl1WXFD?=
 =?utf-8?B?ZnIwT25Mckh5UXRzenZja0FyRXRaSCtwUUN0NitucmFNc0EzTjN0R1BVM0tN?=
 =?utf-8?B?QUZwN0ttZGg3Tlp3aFA3YVlnOXlyTXVJZEFyeGRKdnRvelQvNWVNL28vUmtW?=
 =?utf-8?B?czVMeDVxR3JQNzNsa1ZpWlNxVW9uc1B0SDdKeVdsNnNNSTgwSEp6d3M3YWlt?=
 =?utf-8?B?T1UzeUE1R1YrdFpWOUZPbE1SU2laaXpuenN2Ty9SRjRxNDF4ZzZ4cTJsd1Qx?=
 =?utf-8?B?ckt2UUVvS3J3d3FtcUFMemxhSm4vdjlsd0paa0tVUHZqRlo1cThMWFpQOXpu?=
 =?utf-8?B?TFNzcXBYTWNnblJGbTFqd1F0TlZCMnJ6Rm9kQUhxekR6TkZueHRlY2N1cDVj?=
 =?utf-8?B?dWkxY3VEZlpSSGRuL3dseGlOelhEck1rWWFIZEVPYkdCV29TUVpGQm11aW04?=
 =?utf-8?B?VGlxcllrZEdOa1ZUZHAxc05Bb1Ywb0g0alBaOHAwRlZRaE9jVDQ3ZDZNWk52?=
 =?utf-8?B?dUxUUnRudnZlelNGa0dxVm5tWkFTbWpTWG1RTlZWd1pHRnNobmRKaWQ0dzFS?=
 =?utf-8?B?UlQzSkNXdHM0Slk4U0VhNzN2ZWEwZzdSN1RiV3p0bjRac0pybTlHQzFSMXR1?=
 =?utf-8?B?ZGxPRlJrWGRoWDRYeGNPY3BVUExBOEt5WTJQOTNnaHFyWlgyRStPWWRkZElh?=
 =?utf-8?B?OGRBU1duU2cyaDZjQnJ3NENkU0RaaGRONmgrdUx5dUlTY0JCN1oxNERhT2x6?=
 =?utf-8?B?aXpNNTNSTEFPZUFLbWZWUmE2Ty8xTkRuK0hoSVdWZ2ZXWjJBeGs1ZTk3cVNz?=
 =?utf-8?B?VXFEanBqYzRSUTZ0MjZiV0xmcXptQkhCRkJzVjFZNzFqQnZGamg4clZBa21w?=
 =?utf-8?B?K1NtL3I3WUN6Vm0yQ1BneUhxamFpWllobjVjb2lqdE40ZXJTcWRMSjZnQVNJ?=
 =?utf-8?B?aFRnYk9ndENLZU95Ny85Nm1sZVliN3dTcUxGM2FRNGtvNFd5MmVVcEh5bUt2?=
 =?utf-8?B?Qmp5Y2wxYjdNaG1OVWY5bmV5bTJWaXNzaEtuZ01tbHJyQjZRMzZQSkU3K2ly?=
 =?utf-8?B?b1o1cHlQL3hEVUtqMHlLYUFBaXFKenB6Rkt2TWk0bzRZNk10Z2JkcGFzSWRS?=
 =?utf-8?B?TklJdE1JdGhoZFViOFdoQlNmck0wbFdVM0JIQWxBamZTZWV1T0N6S3FqQWZF?=
 =?utf-8?B?cDVka1lrZG92VCs3S2R0Z0J2UTFjZGRjcXZuL1Z5OGo2TUp4TVBmbkdxSDhx?=
 =?utf-8?B?Yzd1Y3VSY2M1UTJYS1JuOHYyZDB3Wlp2bzczbFd3UjZ1UVJIWllIUXVYN3gv?=
 =?utf-8?B?aUNMYmc2NkRpTHlXdFhqcEx0Q3ptUTRKNkI1c2tQajNmN3g1Z1N2dnVLajlC?=
 =?utf-8?B?a3N4cmRqUGkzbjlwS3grN2o2SkJINFJkZk9YSGl0RzkwSW0wMEZDSTZ2b3Yx?=
 =?utf-8?B?cUR0WDlaOEhreXRoUERTZHhMOFRKUWpiVk8xaHYrRCtYcEMxcEVTZzNnTVJH?=
 =?utf-8?B?SmNtc3hiWXdUYWVFek5Ody9QeTNhRndyZGFtc1RkdDRLYURxUHo0ZXE2RHBm?=
 =?utf-8?B?OHh3MHF6SkRaeWIzNkZBRkplR0p6aVNCK0dEOEkycU1YSWxIbnpzY3ZSTVdG?=
 =?utf-8?B?ZnBLZlF3aGZOTTRIZUUrM05LVjI4a3l0bGFNWFV3NEptUkFRVWs4OEdLVmZP?=
 =?utf-8?B?M3g2WXZCWEVSV0dxVTBRRlpBSWE4RVRvdmFvUXAvR3RvOEdxbm5GdkxNTjRB?=
 =?utf-8?B?NkZPZnFYclRCWVhMcHJvVjl5ZllTUmNJLytrMzY5RHlYRkt5MFpzYnphU2xR?=
 =?utf-8?B?Y1pjSGlBcFc1aVVNdWNSY3g4cDQ2OE4xemNWTjB1QTRYSUxrOEpXc3hGZHFS?=
 =?utf-8?Q?CvXm+jzNsDDrj1FoJmZW9FKSS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a932d6a-59d8-4e93-107a-08ddfeadcd80
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 16:40:59.0150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ttFrVKaex7BVM+gwmBtpQdPd8L6qENsgRn6e9qes/0GdrvvUJfsisPonzVSnir+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9628

On 28/09/2025 17:16, Markus Elfring wrote:
>>>>>> +virtual context
>>>>>> +virtual org
>>>>>> +virtual report
>>>>>
>>>>> The restriction on the support for three operation modes will need further development considerations.
>>>>
>>>> I don't understand what you mean?
>>>
>>> The development status might be unclear for the handling of a varying number of operation modes
>>> by coccicheck rules, isn't it?
>>
>> I'm sorry, I still don't understand what you mean (the problem is likely
>> on my side).
> 
> The development status is evolving somehow.
> 
> 
>> Do you want me to change anything?
> 
> You would like to achieve further software refinements.
> Did you notice remaining open issues from public information sources?
> 
> 
>>>>>> +p << r.p;
>>>>>> +@@
>>>>>> +coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
>>>>>
>>>>> I suggest to reconsider the implementation detail once more
>>>>> if the SmPL asterisk functionality fits really to the operation modes “org” and “report”.
>>>>>
>>>>> The operation mode “context” can usually work also without an extra position variable,
>>>>> can't it?
>>>>
>>>> Can you please explain?
>>>
>>> Are you aware of data format requirements here?
>>
>> Apparently not, I'll be glad to learn.
> 
> Each “operation mode” is connected with a known data format.
> The corresponding software documentation is probably still improvable.
> Can you determine data format distinctions from published coccicheck scripts
> (and related development discussions)?
> 
> Regards,
> Markus

I'm not really sure if I'm speaking to a real person or some kind of
weird AI, so I'm going to respectfully ignore these comments..

