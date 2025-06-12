Return-Path: <linux-rdma+bounces-11243-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173A9AD6A52
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 10:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30B6189D191
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2211522330F;
	Thu, 12 Jun 2025 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GBoqUraV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A820E713;
	Thu, 12 Jun 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716394; cv=fail; b=cR9n0pju14HoWJhXnzpuhOiOKL9s2yGd/hwGLwfYUsv9fS6JDT9MiwCCU3mzIwgTrKj84dqQIsREJlicbl5tz/gsqXgAkyjEuX8G9G9KhCT2hpRZeUxEv7/lCBTFM/o0qP9dwVRqWDXVpNFskmZ6Q08Okon8b9wayZG8p3kEeaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716394; c=relaxed/simple;
	bh=hko6okAmFR876/DDaxwPGh4e+FhszzWUyp7F136BX4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XSPyqg/0erDkYbskf6oVc7kVfW4Y7oYSAVEwrFhB3viSEf4hbw0pzRS5BhiQyikmyDs6L7sI9p2nZQoT0iPHSlFa6I9vjSTrABYYHnqvu5nW38Bg75pEUNaBktbS5W+1uNBmydHvVnYgLbasxv6rD6kIPauq04xHnx1OSq6xN4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GBoqUraV; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3A5TW4zn+B33bnIZs95CvSNCJjD2yvwlOn1XPa0jy2tMvTh+89LuZ+g6LLn1eXrWQnFDjrUYvvX7vwppyCdfxPnQ/Zb/Ja1ivnmbFYlgtuQYb0Toe88//ugp6Bk3qjL5LabG6omGKohzuyEZ9lWYLwbRzc/8tbPcFy3Z8a3rW86stQrWmQCDCQUuHGv3xcupFY7V/FTl548q6kFZRQ0pSSB7HFeZwufuRYmPZ+bh8DJIMKRsdwTy2bHoAXidVqoLABGXY12AYBDtLOUsaRBCar+YzCFIizfGNYz3rOKqyPWrerqQBHh4NNARgio9+Cqdhozg1zw2ds0Ry3NkQTK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrEd5zp8MF5hhstc2yBFrKlcw1M9j8vt7KohwQuY1zs=;
 b=xYRjpBzbI2QVeYnxX/Bc8x09vROZsBZIvWQ2eF7S8FELRilSaa1M92+pur/v2vHNmde1ozLEdMpqiUvwhaRsqRZrf8Ch3x3cks4zJmYHYuv925hz80xicajVs1h7MH8+FUnfKQKHHlzw2GD8yXB21xjgD1328rJHxiMADAk2ybk47+SJTSRPgh0yeIDL6xdh0+4KjIgDvpbOUDA1l/NvOb86AhJ+gIMxwAI70SOpsma99D/1Rh46MsyRtt7aARrdYzcrIjrxyiWjbnqRQCGmZNNZK94qbHBLHDEeq43/hm+T8PZ1zzj5cLA73i6ujSolLv4MZCpJOVOwBKi7OrN17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrEd5zp8MF5hhstc2yBFrKlcw1M9j8vt7KohwQuY1zs=;
 b=GBoqUraVwn8/NjCKLqQRMNaDA3dqpToo5fc29kr++FDpcAoNrHiAeGHpmfSLB8ximYUxgznodSveFJA+2GWOM03mbdHbemJWUMmi5SVAKpIu+1k4lD0ieg50pgTYY7Uen3OqRHgF2X11QdhG8DPYTsUaZ7xanwVMt5jaMSjB9kZHfe1Y3u/qdFnmTUmJK/vD8fBaU5a1Ym59xQ5Wj+crgSanKn1EBtNdUe2qQ/bRjeLABlzhG15K9bpnn1DTGvSXTacdlp2gLtCMoTUenCSkNKV1j3/uouGuc6iacQdVw9kNK3zCi4gdhsYLRYxPfzp1kbWFj9qN0+5rnqNYzFdriQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 12 Jun
 2025 08:19:47 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%4]) with mapi id 15.20.8835.023; Thu, 12 Jun 2025
 08:19:47 +0000
Date: Thu, 12 Jun 2025 08:19:40 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>, Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, 
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com, 
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v4 07/11] net/mlx5e: Convert over to netmem
Message-ID: <4m37kmnvyyj3f7ubgysk577bgofj5bly7tq3e6ygxf5e7kzj5t@nkqnesri3siq>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
 <20250610150950.1094376-8-mbloch@nvidia.com>
 <CAHS8izNkYg6GoMNZOaridxWLYpE3WU0yWpNV2-g4oLd7q9TfuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNkYg6GoMNZOaridxWLYpE3WU0yWpNV2-g4oLd7q9TfuQ@mail.gmail.com>
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 951cc7e4-ca2c-4914-39f9-08dda989e4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWFpdGpBVDMwbmFwSXYyUDdWaytzOUR3aDc4cDQxTFZpZWpEakRlU01JQ1dO?=
 =?utf-8?B?WjF3K0NPS0R0cjdtVjA2Wm5JcjRjQTJyeU5udWJYVS9KLzk0cUgyNi85Vmd2?=
 =?utf-8?B?UEtudWlLQS9UUGVWeGJKZ0RoU2Q4SU5DWFFXazNvMzNpaE9kZFF6R0tJL21W?=
 =?utf-8?B?dlRjNCtJbHJjbnYreEhRUWVod0hRb0Z1ajJCbndQTnZjSzNWdGJNSlg1RmZB?=
 =?utf-8?B?SWFaSkcweHJnb2FnaExPR1p6anE4eVZzRkNoY25Iby9MSjhyK2FodERrQUE2?=
 =?utf-8?B?RGdkWjQ2UFIwUkU4dy9YSVF3RjRQS2tGZVZabkdnUmw2WFZjL3p1U2l4ekNl?=
 =?utf-8?B?THBWU2VaWnU5b1l5cG5qWDZlT014SEhUQ01LUXgxTGtyRlFyMGZONFQ2SCtr?=
 =?utf-8?B?Ukd6cnhKU0VRYk1LOWhlWmppc3h6Wkp6WVVuZ3dIbmRNeFd1WklBQSszVmZL?=
 =?utf-8?B?WmxSSzFreWhLQmNuazA5MGV2UURnMGc0OHFRMG9pWUZUWlpYN1Y1clU1RFNT?=
 =?utf-8?B?R25qVStYNFlYR0w5L1UyRWlCa0lHTCttYi9QSW1iVGRnQWpkRXdTUGhKMHh3?=
 =?utf-8?B?UWFPSWREQ21sbXpaRklNdjZyQ1VNSXdwVmdNUlRLZlQvU3FqdFRFRzUrcnJ2?=
 =?utf-8?B?clNuSXRmaTV3UmFlZ2xJbGJjVXRPWm5LRG5uOG92a0lENUs5R2JjSDVTN1Zu?=
 =?utf-8?B?S2xPRjYwU2Erc2NLMmtDaC8wSjVFTDQwRWRIdHRMalZoS2tCeENaM0dLbHhp?=
 =?utf-8?B?L1hnTmlTSGRCSURNazlMOWVjdmtPeFkwL09IeEdGNk1XTTVBQjR1U1Fqck1l?=
 =?utf-8?B?ckJUSGxJWDg5cktVV0dEbGY5dkNmZ1dhQ0ZRYkVMUzhVQXYxUGhDTy9yeXJ3?=
 =?utf-8?B?NHo5NGpMYmZNY2hKbGl6Z05SYVFBMUU2VDBPYXlVbXpxR1FRQk9TNW1TUWdU?=
 =?utf-8?B?YWJDZm03VElZSXo5ajErbFN3cmpDZTlGODF4NUFSZ045RFRRbU1wdmJ1Q1hC?=
 =?utf-8?B?akJzNHdsRzRmU0ZTcEo4dUVNOGdTWHptTFZoU3pudzRZRU9HOU8yOGVkUFBu?=
 =?utf-8?B?UmxMeTNiL3pLaFkzcUJqalQ2R21PZnBkQkNoM0QyTGlKQ1h1aUZ3dDJrZlRi?=
 =?utf-8?B?YVh3Q3gzZkxUMnpKeGNOZ3VuN2NJaGtmZ1F2V2R2TjVXL1ljZnV2Qkx4MGls?=
 =?utf-8?B?NkQ5TGV0aVBKdTh1c1dFaFJYL2Y2REdWaVBIVGJqbm9DSmtjSzNhQlNKU0xY?=
 =?utf-8?B?WjNLSWJkYTc5b0l1Lyt4YUxwcUE4RytDWmh2TlNDZEVWRmw4ZDYydlYvellG?=
 =?utf-8?B?RkJNNmtzYUpBSHQ2ejlOdm54QjhhWUxhbHhkRmRPK2xBWFpqRTdTcUZMTEI2?=
 =?utf-8?B?TmVNaWdQU3FybFRVMTExcmZocUU0ZWlSRll5RTlrTkl1OGdVbjgybnZ6d041?=
 =?utf-8?B?SE5wV1MrOVNmbDFHb1Jtd3ZNY1lRKzI0V1lwL01GRWhGUVNvVHg1bG5INWlK?=
 =?utf-8?B?ckhzRkhuaG5rZHhqWVFsZUUyY3N6NGxyN1lmdVJGOXpiMjNEWDFhNmJFVVJp?=
 =?utf-8?B?aUxRcGVjNE9HUWx4eTJJS0lGUTkrUE5iNHlWOEpGV2tDQlVKTkw0NmRCNHVT?=
 =?utf-8?B?N2FObVdqMWRGVlFEVGdOSlFUT1VXNGhHdGIzVkZQWW5WL00zR0VlVC9LZzNq?=
 =?utf-8?B?aFFWS2U3TUp6M0RXZGVZZ0hZeHRkN0JIU0M0YWZaRzdqcUtrTXBCekNzMlU0?=
 =?utf-8?B?QU96aFpzaUxIUnExWGJqYXJaTkVBMWtxeHp2VFZWMzZ1ekhRcEJ6TnUrYXhZ?=
 =?utf-8?B?YW14d0NGem91aG56bldZSkZ6bi9KSVJhTExRRnpJRGd3Vmg2dmFVNzB3V3kx?=
 =?utf-8?B?Vkx5eGp4ZFZpQVVRd2Z0aHcrRWJjdzA2ZDE1UmI1ajdkVmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1BTK0kzMVNUamc1NjlVckRoTkYzTFdFT2hKdFhnckFjSUNyclBDaXNiMWFm?=
 =?utf-8?B?T3ZwaUVQWFBDOUVKOVR6OGNtT3NrSDd6R2lCU01nMmcxOGU0WXNsVVBnVDcx?=
 =?utf-8?B?VkYvY1ZEY1NVQm1MeUtVbS9ISUwrZzVnRkFMWHpUZVpOalBuNStEbkt4NmtD?=
 =?utf-8?B?K05LeHZIMEtnTmI3RU9ZWDU5S05Qb3M3ekhsKzM2TDdTMWtRMHNZUk9TMlBm?=
 =?utf-8?B?eUxyZWJHQlN4ZmZ3T0Z2UHVnK1NJSzVCbzUvdTBwdElUdVg3MlcvbDRQNTZU?=
 =?utf-8?B?M1BsTUZOcHplMEFIVlFkRFlKNjNMQVdqVmorbklnM085a2NJT1Jlakc4MXJE?=
 =?utf-8?B?Z2FvZGptZ1F1SlBMa1AyT3A5VlhpUTF6YytMbFQrV3EvMkJhVDJLM1h3d0lX?=
 =?utf-8?B?eWdzN0toRG5vWlVoMkd6dHhuMVVoUnVQa2JZTDVpcCtxWDhNUFJ0TDQ1NDdy?=
 =?utf-8?B?Y1dudzdhS0pRak1kaUo0ZzJMTGVsSENqc0tyb1dXWnA5TkN4WEpLbFhnZFdC?=
 =?utf-8?B?d3Q3MXBQdGhwUFJtcmZyaUx2WEpuc2JaMnlndW5KbU54eGgwVzhCaDUxS0tw?=
 =?utf-8?B?b245b3VVT3B5RlVUdklJOTE4MGRLYjlvVVAwQTYwZFhQellhSTdtRVRpb1p4?=
 =?utf-8?B?WUozd2FOdThCUUJGVW9HM0ZsQ0Jpb0JHMzY2NmROTGZ0VDU5VnpsQTkvdFlw?=
 =?utf-8?B?VG42cEprdUlNWWdiOHR5ejZ2bzdOaTN6RnhuOXoyTUFPaWYzYTZFalhZUkV6?=
 =?utf-8?B?VUxueCtOM2E3dWlpS3ZmZjE3ZExSa1pCdHpJQlo1SmlaNWtoQTJIWVEvelRE?=
 =?utf-8?B?eC91K3ZkWm1qK0dST0RqalE2TUJxNHpSc1NibFNhYThXUnNHVU9teXo3cmor?=
 =?utf-8?B?eThwNXdOckk1Y2xxemsxS29nU3JURzc1UHBhOEJ3cGdkMUQ2YmlaMGNqRHVa?=
 =?utf-8?B?QnNpNFBnTldaanBGdXlWUWsrZDFoL0F5enlvMVRJMVo2TE5ZK254Zy9lT2V2?=
 =?utf-8?B?OUM3cVo5RTJBK1NXQlNPdjV0REUzTUwxZjlRMHlwbG80QUI0ek9MVjNlQ1JO?=
 =?utf-8?B?bTllckFvOGJFWVZKUzhULzltczJwZkdTaTFMN3ZEa0JtZ3FIdnlIZTdScEdO?=
 =?utf-8?B?SDBWSUdFVG1zMExHbW81VzVCc29KYXl0K2tjc0lBbGNsb1NmYnlEY1E2NHRW?=
 =?utf-8?B?U01xb2gzZzBXY3ExM09aeDNpcjB0V1kzOER6eTF3TWJaNUJ2ZVZ3cnFoT1Bo?=
 =?utf-8?B?V0M1bVkzaWFjWGZmc3kvYzdTQ1FMRnFZUVJ4Si9YbEFoalFULzZVZGdmQkZF?=
 =?utf-8?B?c1ZSVmJSaC80QVRVVTc4NnNlbXdEMjRPR2NEMU1YdThaWlozVEZ5aW9yeC9S?=
 =?utf-8?B?NHhJZWd0cEN1b3BQdk9JUVJZSkRlU0FtMWlnL2xSYUJaTzIwUnZ0blRia3ZN?=
 =?utf-8?B?UDB5SEV2VGZRbG9rUlE5LysySVJkT3VFNjJmMnJWdkNwNGRlbkFQUllMYU81?=
 =?utf-8?B?cnoybkxnclFXVnlLZGpBbXJ3TC9kYVl5V0s3dm0rd2VTczNrcDZUUDhoTU1z?=
 =?utf-8?B?RXgxVkxrK3psak5vOXhWcS94SUNrUklzT3VPZE1TRHFHc01QY0l4YjFLa3Nr?=
 =?utf-8?B?c0xqVmJkSVVzQXFxNXk3bDUzRjZ1TVREUGVuM3NZdVR6VWxIT3N0VFNKbW85?=
 =?utf-8?B?VUVoQXJqNVU2K2N1VnFEVzRHU01PL1BWbEVQTzBhNmMzWnIyNGlURDM3ZEhD?=
 =?utf-8?B?Qk1RdVdxamtEeWdoclFBQUJkYnRRd2Rqc1BPcjhQcXZZTnJVTitPWnNMdTE5?=
 =?utf-8?B?OWxVV2tHZmJPajVXa3FTSm1QdDJxWGV5RXgwekxobFp4dlh2NlZNQ1ZVRW4v?=
 =?utf-8?B?SHd2Z2xuWmtZV1Nsa2JsZmlyYnRJOXVIVitLUnFsdDl5OU5tTW04V1RVdVBo?=
 =?utf-8?B?UUErQ0NhemtsdjVaQWtnWmZsbVFoSzFMZXczMmZPaWQ0Mzc5Qzc5b0M5Zmcx?=
 =?utf-8?B?NTZDRFpnL0RLSDczdSs5ZTJiTks2MkFIdDltSm5USkZ0TUYyakNocVpKa2Z2?=
 =?utf-8?B?aUxjTjJkZlppdXlEWm9FUmh5MGMxd2J0TDYxOFR5dWpNeWQ0ekh3TWhvYTBu?=
 =?utf-8?Q?1SWaa8xvhtEbCvh6MJrDDu8Hs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951cc7e4-ca2c-4914-39f9-08dda989e4ce
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 08:19:47.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6yUhTvliyFzWfDbiXVhQqJa3qIcvewP08ukKUVZHxLmVCMAXqNX5IPHDxqSPJCciFYFhqgZJABSg+th5X7edA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

On Wed, Jun 11, 2025 at 10:11:32PM -0700, Mina Almasry wrote:
> On Tue, Jun 10, 2025 at 8:19 AM Mark Bloch <mbloch@nvidia.com> wrote:
> >
> > From: Saeed Mahameed <saeedm@nvidia.com>
> >
> > mlx5e_page_frag holds the physical page itself, to naturally support
> > zc page pools, remove physical page reference from mlx5 and replace it
> > with netmem_ref, to avoid internal handling in mlx5 for net_iov backed
> > pages.
> >
> > SHAMPO can issue packets that are not split into header and data. These
> > packets will be dropped if the data part resides in a net_iov as the
> > driver can't read into this area.
> >
> > No performance degradation observed.
> >
> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> > Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +-
> >  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 103 ++++++++++--------
> >  2 files changed, 61 insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> > index c329de1d4f0a..65a73913b9a2 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> > @@ -553,7 +553,7 @@ struct mlx5e_icosq {
> >  } ____cacheline_aligned_in_smp;
> >
> >  struct mlx5e_frag_page {
> > -       struct page *page;
> > +       netmem_ref netmem;
> >         u16 frags;
> >  };
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > index e34ef53ebd0e..75e753adedef 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -273,33 +273,33 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
> >
> >  #define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
> >
> > -static int mlx5e_page_alloc_fragmented(struct page_pool *pool,
> > +static int mlx5e_page_alloc_fragmented(struct page_pool *pp,
> >                                        struct mlx5e_frag_page *frag_page)
> >  {
> > -       struct page *page;
> > +       netmem_ref netmem = page_pool_alloc_netmems(pp,
> > +                                                   GFP_ATOMIC | __GFP_NOWARN);
> >
> 
> I would prefer if you add page_pool_dev_alloc_netmems helper for all
> drivers to use rather than specify the GFP params inline here.
>
Ack. Will do.

> > -       page = page_pool_dev_alloc_pages(pool);
> > -       if (unlikely(!page))
> > +       if (unlikely(!netmem))
> >                 return -ENOMEM;
> >
> > -       page_pool_fragment_page(page, MLX5E_PAGECNT_BIAS_MAX);
> > +       page_pool_fragment_netmem(netmem, MLX5E_PAGECNT_BIAS_MAX);
> >
> >         *frag_page = (struct mlx5e_frag_page) {
> > -               .page   = page,
> > +               .netmem = netmem,
> >                 .frags  = 0,
> >         };
> >
> >         return 0;
> >  }
> >
> > -static void mlx5e_page_release_fragmented(struct page_pool *pool,
> > +static void mlx5e_page_release_fragmented(struct page_pool *pp,
> >                                           struct mlx5e_frag_page *frag_page)
> >  {
> >         u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
> > -       struct page *page = frag_page->page;
> > +       netmem_ref netmem = frag_page->netmem;
> >
> > -       if (page_pool_unref_page(page, drain_count) == 0)
> > -               page_pool_put_unrefed_page(pool, page, -1, true);
> > +       if (page_pool_unref_netmem(netmem, drain_count) == 0)
> > +               page_pool_put_unrefed_netmem(pp, netmem, -1, true);
> >  }
> >
> >  static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
> > @@ -359,7 +359,7 @@ static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
> >                 frag->flags &= ~BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
> >
> >                 headroom = i == 0 ? rq->buff.headroom : 0;
> > -               addr = page_pool_get_dma_addr(frag->frag_page->page);
> > +               addr = page_pool_get_dma_addr_netmem(frag->frag_page->netmem);
> >                 wqe->data[i].addr = cpu_to_be64(addr + frag->offset + headroom);
> >         }
> >
> > @@ -500,9 +500,10 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
> >                                struct xdp_buff *xdp, struct mlx5e_frag_page *frag_page,
> >                                u32 frag_offset, u32 len)
> >  {
> > +       netmem_ref netmem = frag_page->netmem;
> >         skb_frag_t *frag;
> >
> > -       dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
> > +       dma_addr_t addr = page_pool_get_dma_addr_netmem(netmem);
> >
> >         dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len, rq->buff.map_dir);
> >         if (!xdp_buff_has_frags(xdp)) {
> > @@ -515,9 +516,9 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
> >         }
> >
> >         frag = &sinfo->frags[sinfo->nr_frags++];
> > -       skb_frag_fill_page_desc(frag, frag_page->page, frag_offset, len);
> > +       skb_frag_fill_netmem_desc(frag, netmem, frag_offset, len);
> >
> > -       if (page_is_pfmemalloc(frag_page->page))
> > +       if (!netmem_is_net_iov(netmem) && netmem_is_pfmemalloc(netmem))
> 
> Unnecessary netmem_is_net_iov check.
> 
Ah nice! Will do.

> >                 xdp_buff_set_frag_pfmemalloc(xdp);
> >         sinfo->xdp_frags_size += len;
> >  }
> > @@ -528,27 +529,29 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
> >                    u32 frag_offset, u32 len,
> >                    unsigned int truesize)
> >  {
> > -       dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
> > +       dma_addr_t addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
> >         u8 next_frag = skb_shinfo(skb)->nr_frags;
> > +       netmem_ref netmem = frag_page->netmem;
> >
> >         dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
> >                                 rq->buff.map_dir);
> >
> > -       if (skb_can_coalesce(skb, next_frag, frag_page->page, frag_offset)) {
> > +       if (skb_can_coalesce_netmem(skb, next_frag, netmem, frag_offset)) {
> >                 skb_coalesce_rx_frag(skb, next_frag - 1, len, truesize);
> > -       } else {
> > -               frag_page->frags++;
> > -               skb_add_rx_frag(skb, next_frag, frag_page->page,
> > -                               frag_offset, len, truesize);
> > +               return;
> >         }
> > +
> > +       frag_page->frags++;
> > +       skb_add_rx_frag_netmem(skb, next_frag, netmem,
> > +                              frag_offset, len, truesize);
> >  }
> >
> >  static inline void
> >  mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct sk_buff *skb,
> > -                     struct page *page, dma_addr_t addr,
> > +                     netmem_ref netmem, dma_addr_t addr,
> >                       int offset_from, int dma_offset, u32 headlen)
> >  {
> > -       const void *from = page_address(page) + offset_from;
> > +       const void *from = netmem_address(netmem) + offset_from;
> >         /* Aligning len to sizeof(long) optimizes memcpy performance */
> >         unsigned int len = ALIGN(headlen, sizeof(long));
> >
> > @@ -685,7 +688,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
> >                 if (unlikely(err))
> >                         goto err_unmap;
> >
> > -               addr = page_pool_get_dma_addr(frag_page->page);
> > +               addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
> >
> >                 for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
> >                         header_offset = mlx5e_shampo_hd_offset(index++);
> > @@ -796,7 +799,8 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
> >                 err = mlx5e_page_alloc_fragmented(rq->page_pool, frag_page);
> >                 if (unlikely(err))
> >                         goto err_unmap;
> > -               addr = page_pool_get_dma_addr(frag_page->page);
> > +
> > +               addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
> >                 umr_wqe->inline_mtts[i] = (struct mlx5_mtt) {
> >                         .ptag = cpu_to_be64(addr | MLX5_EN_WR),
> >                 };
> > @@ -1216,7 +1220,7 @@ static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
> >         struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
> >         u16 head_offset = mlx5e_shampo_hd_offset(header_index) + rq->buff.headroom;
> >
> > -       return page_address(frag_page->page) + head_offset;
> > +       return netmem_address(frag_page->netmem) + head_offset;
> >  }
> >
> >  static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct iphdr *ipv4)
> > @@ -1677,11 +1681,11 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
> >         dma_addr_t addr;
> >         u32 frag_size;
> >
> > -       va             = page_address(frag_page->page) + wi->offset;
> > +       va             = netmem_address(frag_page->netmem) + wi->offset;
> >         data           = va + rx_headroom;
> >         frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
> >
> > -       addr = page_pool_get_dma_addr(frag_page->page);
> > +       addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
> >         dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
> >                                       frag_size, rq->buff.map_dir);
> >         net_prefetch(data);
> > @@ -1731,10 +1735,10 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
> >
> >         frag_page = wi->frag_page;
> >
> > -       va = page_address(frag_page->page) + wi->offset;
> > +       va = netmem_address(frag_page->netmem) + wi->offset;
> >         frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
> >
> > -       addr = page_pool_get_dma_addr(frag_page->page);
> > +       addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
> >         dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
> >                                       rq->buff.frame0_sz, rq->buff.map_dir);
> >         net_prefetchw(va); /* xdp_frame data area */
> > @@ -2007,13 +2011,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
> >
> >         if (prog) {
> >                 /* area for bpf_xdp_[store|load]_bytes */
> > -               net_prefetchw(page_address(frag_page->page) + frag_offset);
> > +               net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
> >                 if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
> >                                                          &wi->linear_page))) {
> >                         rq->stats->buff_alloc_err++;
> >                         return NULL;
> >                 }
> > -               va = page_address(wi->linear_page.page);
> > +
> > +               va = netmem_address(wi->linear_page.netmem);
> >                 net_prefetchw(va); /* xdp_frame data area */
> >                 linear_hr = XDP_PACKET_HEADROOM;
> >                 linear_data_len = 0;
> > @@ -2124,8 +2129,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
> >                         while (++pagep < frag_page);
> >                 }
> >                 /* copy header */
> > -               addr = page_pool_get_dma_addr(head_page->page);
> > -               mlx5e_copy_skb_header(rq, skb, head_page->page, addr,
> > +               addr = page_pool_get_dma_addr_netmem(head_page->netmem);
> > +               mlx5e_copy_skb_header(rq, skb, head_page->netmem, addr,
> >                                       head_offset, head_offset, headlen);
> >                 /* skb linear part was allocated with headlen and aligned to long */
> >                 skb->tail += headlen;
> > @@ -2155,11 +2160,11 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
> >                 return NULL;
> >         }
> >
> > -       va             = page_address(frag_page->page) + head_offset;
> > +       va             = netmem_address(frag_page->netmem) + head_offset;
> >         data           = va + rx_headroom;
> >         frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
> >
> > -       addr = page_pool_get_dma_addr(frag_page->page);
> > +       addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
> >         dma_sync_single_range_for_cpu(rq->pdev, addr, head_offset,
> >                                       frag_size, rq->buff.map_dir);
> >         net_prefetch(data);
> > @@ -2198,16 +2203,19 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
> >                           struct mlx5_cqe64 *cqe, u16 header_index)
> >  {
> >         struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
> > -       dma_addr_t page_dma_addr = page_pool_get_dma_addr(frag_page->page);
> >         u16 head_offset = mlx5e_shampo_hd_offset(header_index);
> > -       dma_addr_t dma_addr = page_dma_addr + head_offset;
> >         u16 head_size = cqe->shampo.header_size;
> >         u16 rx_headroom = rq->buff.headroom;
> >         struct sk_buff *skb = NULL;
> > +       dma_addr_t page_dma_addr;
> > +       dma_addr_t dma_addr;
> >         void *hdr, *data;
> >         u32 frag_size;
> >
> > -       hdr             = page_address(frag_page->page) + head_offset;
> > +       page_dma_addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
> > +       dma_addr = page_dma_addr + head_offset;
> > +
> > +       hdr             = netmem_address(frag_page->netmem) + head_offset;
> >         data            = hdr + rx_headroom;
> >         frag_size       = MLX5_SKB_FRAG_SZ(rx_headroom + head_size);
> >
> > @@ -2232,7 +2240,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
> >                 }
> >
> >                 net_prefetchw(skb->data);
> > -               mlx5e_copy_skb_header(rq, skb, frag_page->page, dma_addr,
> > +               mlx5e_copy_skb_header(rq, skb, frag_page->netmem, dma_addr,
> >                                       head_offset + rx_headroom,
> >                                       rx_headroom, head_size);
> >                 /* skb linear part was allocated with headlen and aligned to long */
> > @@ -2326,11 +2334,20 @@ static void (struct mlx5e_rq *rq, struct mlx5_cq
> >         }
> >
> >         if (!*skb) {
> > -               if (likely(head_size))
> > +               if (likely(head_size)) {
> >                         *skb = mlx5e_skb_from_cqe_shampo(rq, wi, cqe, header_index);
> > -               else
> > -                       *skb = mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe, cqe_bcnt,
> > -                                                                 data_offset, page_idx);
> > +               } else {
> > +                       struct mlx5e_frag_page *frag_page;
> > +
> > +                       frag_page = &wi->alloc_units.frag_pages[page_idx];
> > +                       if (unlikely(netmem_is_net_iov(frag_page->netmem)))
> > +                               goto free_hd_entry;
> 
> If I understand correctly, when the code reaches here, head_size == 0,
> which means the packet was not split. And if netmem_is_net_iov ==
> true, then the entire packet (including the header) has landed in
> unreadable memory so now you are going to drop the packet, right?
> 
Yes.

> If my understanding is correct, this is all subtle enough that it
> maybe warrants a comment. Also you may want driver stats to see how
> often this happens (seems like a headersplit failure causing packet
> drops).
>
I will add a comment. A counter is also useful, especially to detect
when the steering was not configured properly and unexpected packets are
landing on this queue. But I'd prefer we add it separately. Don't want
to rush it.

> Mostly nits, so,
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
>
Thanks for the review!

Thanks,
Dragos

