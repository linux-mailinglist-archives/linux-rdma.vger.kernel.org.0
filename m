Return-Path: <linux-rdma+bounces-11542-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431AEAE3F79
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 14:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBCD189A7FF
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26E246BAC;
	Mon, 23 Jun 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SRf0Klhq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604C1CAA96;
	Mon, 23 Jun 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680249; cv=fail; b=GWqnAkd8k8CiQIg2r9F9MGZze8GRw9JI/Z+8VqDsS4b84X2JTGUAWL26dVaDYV9rF8gsJlNW5FkoC1cP1Y/JXj6E5WCt5rU2tTCJX/bk1G+9P0OR3QeoCzMltFpJms2WIjFiIQQl1yEdm6+UJ3OMKkyOzA7mIt1BA50yDPBkImk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680249; c=relaxed/simple;
	bh=N+JN0631Xr/GyoFuguXF2zJF8Y9CqabKRO66ilHwTCM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PsVJtijVjBOksg9CQL/jdBlI3kGBWoMYByfsbfaTrBNBBbFOwezbCnX5iSOlrBoPCniBSWq4q1AcUugyJbcJ7vi8Zd32ZdnJJAwn6GICYWBv49R8lJcq4f3o2asisv/l22QnV0RSk+RBNrXulFJDbpMcOBS1laQOrca5teiHXWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SRf0Klhq; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxT1PMs0VLF4WClNRy0aPB9PBl25/iCFPSNC/FYwmphBoz1nQuMRfe7dlFps7KUwuNRpNR8C04+0n9lW4Sh+O8NkZ3pWneWHI6sGSKp3cAsBvNDrvXVa/tj3BwIwrYZn0imToEBuc0N0xe+0CEBK/nCyMBymewGtPFz+iKw5aw+ITqCQoHu36nKUIDRXzMeA3P4dblaiLMhlfPJg6L7gdq/RecnZ/u7KiKLK2zfTqkYg+0NUxmWBPqepL693TP5oWmE5+0jv9lZjkT6x/N8MQ/Doo0muKTpyqbDzkg5csdtfVQRb4/9Bs8U71LV7uz3m8wJjrra28782zRPkIn6RMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu3XZ3POT2nWh1YMv+nEFZ8vP3TWc8xTAhDuIVQJDc4=;
 b=BylCb2OiqZYk2wYsWjSWRPyQwcAnULZcg295dP0C2bKjeNma3Kql++yO+MVr04y3pEjl0GH31bAtXE10/CfLs0CwCh8LS+Mza+82idRjcYXTxe4QKJrvtWq8I4LhSQ/AOkRqz4cspZNv3b3vdkw330SdM9K/7koHePhnD8mvofeR6U+bw7NlrVpVgpqTvkfFOSqzwsN6tIM9pL0v79vs6cRerht1KiZgOhifXHwr6FOShM7WIrC21PDX9ph3Ut2W1/XHgmdyoJ9xEnXKFO/g0F7/2PA857NVvgO0xzoWdhB5fTXBpDh9WBnpSBiFrjBl9P7xFLQNlV+ZMHhQAPHNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu3XZ3POT2nWh1YMv+nEFZ8vP3TWc8xTAhDuIVQJDc4=;
 b=SRf0KlhqLh+yYfcfxRy2NKCQNsF8RzWtrjAecSL9zV4/Ox6XqzvoWVC7zwBa5hV6ZsNE4qGQimSkkP2MIkG3kxgnyCVXpgN9B6dmoCnwhPemIYzdAu84ewXWCIMgeAB4hQ6327hcyCYl6QTxDrcCfqxGLuOLLGNSdVww0jjCwGhUJaIiY95bSRp83Tj6+rx0Dkqx0uCEiSevUH9h2NrIMuBGNsYeCF953g3aQPmM2XFhzX4Bg1UTav46TGZgf2DRzK2jILj5cYNFsbvEZPOkTrykcoHphodFb2uH7Vlcuap0n10cOAjw/zfhk6BM1Liew2pWX7ralg92Xx/i+WPDxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Mon, 23 Jun
 2025 12:04:02 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:04:01 +0000
Message-ID: <386f36bb-d37c-4082-92ba-6153b4683810@nvidia.com>
Date: Mon, 23 Jun 2025 15:03:56 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] net/mlx5: HWS, Optimize matchers ICM
 usage
To: Zhu Yanjun <yanjun.zhu@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
Cc: saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, moshe@nvidia.com
References: <20250622172226.4174-1-mbloch@nvidia.com>
 <8ed873ce-619d-4bdd-8fba-222320229efe@linux.dev>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <8ed873ce-619d-4bdd-8fba-222320229efe@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc31bdc-dd18-4751-75bc-08ddb24e0a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlVwNWRjejZTL1dSWlROTlc1bUo1b1dUSEZ0TDdiQWxiNU00OVkwSnVLZFhG?=
 =?utf-8?B?WkpIcXZDSit0VDJoRDFRb0NEUWw0alNqQWNQWXlOMys3aEdVUktJaWdOS1dZ?=
 =?utf-8?B?VU9xUGVla2RQOEgrTVA2Mml2ck52RGt4MkllNWhNbFBZbzRlblZ6bGJCTnhE?=
 =?utf-8?B?bUZSWEczUnZQWEUrODM3Tis3d2xXakZKanFkZjNKN3g2OFp2UjBVMXI3V1Qz?=
 =?utf-8?B?SXFOcmtydUpxT0w5UmhhbHVqanUwTU5hcktLaGRUZWRCVDhTMnViaU5BWFpB?=
 =?utf-8?B?Mmd3SU5abmVhdG9aaUI1QjlvUkR2Z2tabVdLeTE0amFMcG1PYitBakRSWWdn?=
 =?utf-8?B?U0RMbzdMTDVvT21DMXpTUDZ1bGxXaXJZQVcvTWFwbW5BYVNBbnFxL3hpN1Y5?=
 =?utf-8?B?M0lsNS9oK3RyZFFqVUR1U2NZcERzV0JjQ2g5K2ZSYXA0eUtCeUNrVElNdHkv?=
 =?utf-8?B?RGh1a2l5eXk0bXNrVGxrdENHTTFXTldPOCthRFV5SkVyL0E5N3NNaWlMYXln?=
 =?utf-8?B?QUVOb3B3NnRDL29nRTNNUG1FaWtBUVBEZTBxUm4xRHRjWHQwWCtJYUtiaWxi?=
 =?utf-8?B?UEhIS1d2bkVvWUNFZjBnTFhmTkxUYVpxaUZYZnFzM0JsMDhyWFAwN2YzWTB6?=
 =?utf-8?B?MkRnczd6VXBwdm9tQVNRK2tJZC91UEIxRUhwOHFqS2dOdGRYVjV6RkdFdkVR?=
 =?utf-8?B?RW1OcUZsdVpJaHRlTW9PS1FzRmU5eHJTQm5EZGcyek9MMDFwRXBNY1lpYloz?=
 =?utf-8?B?dDNNVExaV1g0clM3b0lCMEVEVUZOUVhUQ2tuUlBDUCt6Z3ZOSTlFYmk4ajFS?=
 =?utf-8?B?WjZqTWZLYW4ybEhIRVMwTFJQRnBLeFRtc2tSQ09ESlJEODlYMm5OSFl6YXJv?=
 =?utf-8?B?eUdJK3JJMWZ1a1BWMEJwd09GM1Q1UlI5TUF5czlzZlpSNlhubkxPem9FNXlh?=
 =?utf-8?B?S0ppdDdyYUZDRnk1ZTZ0Q0pSRWxaWnJxUS8zb1ZXbmpobE42RlgzZGRXaVNS?=
 =?utf-8?B?VUlic2tZT2RjUC93Vzh0Z3c2S1JyVFM1d1luTGFhY2daK3RWNXZuQUVvTHg4?=
 =?utf-8?B?b2ppUnNxblZMb1J5dCtIQ3FXQ21TZFpsVFVoRXJFeDZlbkQ3Rmd6NzF3Mytn?=
 =?utf-8?B?bTN3aklLR3FETUFQM1pxSTE0Q3k2WVYyN2JYMGpzc0V5ZkNuNnRiV1dsYjYz?=
 =?utf-8?B?b0Y2NXduM2VKTUR1dVo3S2ViQ2x5L2RJbmtCRC9vajVlbUc2d0JwUld4a0tq?=
 =?utf-8?B?d0VKTFdGeGZObkF0ODNzU1BiWmlKVFpITEl2TE02Uy9UTmNNcm5yV1A0R1Jo?=
 =?utf-8?B?R0VXM0tKV1prT0U5NXNzSG1RdjNGcGJ4dU9xSXlPMjJvNDlUSG1OR0E5RmV4?=
 =?utf-8?B?QzR3OTJPclN1dS9xSzVWeWttazQ2enFOcXpxb0NiWkplRnVMeVZwN2NkSDFh?=
 =?utf-8?B?VWVZcTh0VXZqVG82VStra3BvUHdPZHBaTnltOTM1akVSVE0wVHpMOHlJTE1k?=
 =?utf-8?B?dGFGNjRZb0hoTnRjb0lQUCtweG9BZ1dZZjl4YllubHRlQjBlL0N3QTNBOHpo?=
 =?utf-8?B?bWJPSU8yU1dMTjRKTk9oeTAwcjNJQjVoU1VMTzZhdXpsSi91U0lVNS9FVlhP?=
 =?utf-8?B?V3JvRjF1OEhvTlB3T2VPSEt4SjQ0RnpxZlkzS213cm0yenMwdTJPQ3Q0dVZl?=
 =?utf-8?B?L0Vkc1hTSVFNZTNoMUtURGw3V3U5d25XczE2Nm1MNkxGK1FvdVh1SGpwQmxQ?=
 =?utf-8?B?alRtV21aektIT1VGOGV5WDNMc0pXOEZyVzZQQTU4NHE0ZnJVaEoyWTZzOXFC?=
 =?utf-8?B?bWlKQ1kyTmpaeW1Ec1pWRDNkQXpISGMzS2pXVWVrWFFpN1FOUkdTNnFYTTFD?=
 =?utf-8?B?ekNoRkxTRUdOeTVESExnZ3hIbHlqSmVyay9TaE9YK3VMd1Q5bEVwTzloVmhH?=
 =?utf-8?Q?v2qxG/YDM+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDFXQkU5M3l0YXI4RHJpa1psZnZNcVRuNm9xTVI0VmNzVGM3dkx0blkzV2pm?=
 =?utf-8?B?M1lyVTVEd1lscW95WGJnOWJicVhQZE9GWjNtTzdKUlNPRnVFYjl4VUc5WFNT?=
 =?utf-8?B?M3pwSGhudElUZm9XMndMKzAvYXRUcGRqcFBCTEtocmtKRWNrc2FyeXIyeEJM?=
 =?utf-8?B?ZjUxVitPbFNoSXlhU25yc2ppSjJkQlg5MXBId01iK0xuSlFvUzhCZndTenhx?=
 =?utf-8?B?UUxSSEgrU2Q0cGEzdmVQSlkwVXUreTZIZ0J3SmpWTUc5U0Fqejg4cUNFT3p3?=
 =?utf-8?B?d3JVSWtFR2xiR2wramVJbW1HcTlrTTdvTldENW4wc0tDUGpuekQrNDdZZnhG?=
 =?utf-8?B?RGFXRS9idnQxWjZiVGttTlZNRll2RzUvWlhvVUhBTUVlZk8vSjhlS1R1Rkov?=
 =?utf-8?B?VklJYnJMRlFmeFNYQmp5cmcybmQ0bGhrMVgxNjlvbHhGMHBnNFdhaGphNjQ1?=
 =?utf-8?B?OG4xallmZ1pDbHpGWG5ZNFk4ZG1BV3lDRWZoZkRDVDdYUml1K1k4TVNPaEN3?=
 =?utf-8?B?dytiSmZKeFNXQmoxeUFZdEd4ZDRWenlhbjJReGpDdUV1WWdEYy9OOVBIMm1C?=
 =?utf-8?B?THg5bXVVK0Fkc05KeCsyRkJRUFpQR1dodFJvZitUMHVtMjFhclowMThKUE1F?=
 =?utf-8?B?MWMyL0pwVEpZNjhIWGEyTXZBRGczZFJlRHM1Mk5xQTN3M3dBODAyZy91T2NV?=
 =?utf-8?B?bTlvdmM2eUEzQTF6czBlN1pyM0tiRW02cFBqRG9FL0dXSlBOVlEwKy9ZZE1S?=
 =?utf-8?B?L3hPVk1tVjBkRHhhb2dTekN4cVBveGlkVTd4akg5Wnl6N01HekcrS3FQck5x?=
 =?utf-8?B?bXk4blNtT2N4RkVxdERzVkdXTSs5WTZwQ093R2ExcWVaZE1FSEg2Vjl2UExN?=
 =?utf-8?B?elU2SlFjNk5uckptdnpNanVBc2xmbFl3Smp3VDdablV3LzN4cGV2eXlrdW9l?=
 =?utf-8?B?WExDT1VpamlzeVY3RDlmZTd5MVBRQmR1QjJRcXZIM3ZqMFlZSjFzNmFEeUQ2?=
 =?utf-8?B?UzBDRXZOSEhNQUZGc0Y5RXpwUVpaQVgwWERPK05Bbjdzb09BaTdKKzgwQ3BD?=
 =?utf-8?B?TlZoQ2wxUmRnRWdFajM5TkN3N3I0cmFsQjRPUEZTTnpzVFgxNWhGL2gzVmRE?=
 =?utf-8?B?N1p5NkhPSWNXdFJ3TitWc0ZQa0JLZzFoNzFVZmpmUzdNSkcwQlNXdi9CczZj?=
 =?utf-8?B?REFLNTd4bHpuTCt4UnV0MmhRWlFuZ1NEN0QrWnlkVzNDVTZQTEVlOXMzWEZ2?=
 =?utf-8?B?NmRuaXdSTmY2eXhmd1Z4S2xNa3ZpaGxRVGJrdExRSkFVem13Z0pRbTVycCtk?=
 =?utf-8?B?aDhnWDUxMXhxNzlQVlYwcHFKTmJhODc1dFZlamU3RTJiU3IrNUUyeWV0SjNx?=
 =?utf-8?B?YlRzQS9LYzZubjNuM2xqbW5oTmNDSDRCMjBYbTFTNFcwZklKZHhVaGFCZjJa?=
 =?utf-8?B?cENNM0RnSGp4VjdHQm9tdC9CREdsYUlOSlpYQ29lYzN3ZzFOb283a2dZVm1K?=
 =?utf-8?B?YzNGQzNVcENRdEhoRU9XbVcrSmI5ZkpMbFlMMkx6QW5JWUUrdUxKQlgySHRK?=
 =?utf-8?B?dXFZZjBnTkk5OUk4WWczYXA2WVUrZ0RjVzhIWUtPTU9DRGk0WVpPUkVLRTVy?=
 =?utf-8?B?bmtVTUxjUTRORHU0cmNwUWF4T0kwaVhyemhLZVZBbjVDQldPQk4yWUpJYzhV?=
 =?utf-8?B?RDZ3cUYvQWd1d21UMGprcmxXQjlNNlpLaGlmb2RzbzJRWTJuazNIeGZMMGZI?=
 =?utf-8?B?Uy9tV1pUOVcrLzFNelZHbUw0QndZNWEzL2Y3eEZmV0g3M0lmWW5nckJNWm5M?=
 =?utf-8?B?ZzRCaWhpUFA1U0RZVUZxU1dLa29YUTZNMml0ZG1HOVpWalRRdzlDOHpiT1p4?=
 =?utf-8?B?ZkNoZTNXdWdPSTZsb3drcXBJTVByeUVQaEtsQnQ3eGljaU0rOHc3ZkNvNmpT?=
 =?utf-8?B?RGxKQk15MkNKSWxoRUg5QjNNbWhURXFlcW52VXpIMnd3RlBjYjJUdlVucmhq?=
 =?utf-8?B?bnI3ZEFQNTVOOUFjblJXdHpubmpLVlJsaUJPSHZ4L1ZCNDZxOGozdndyWVly?=
 =?utf-8?B?WGd6QjJFVk1ZYmlDbk5YRXZXTWpkdGNVRkZWOEtQRDlMN3RLQitVWmxUVmd2?=
 =?utf-8?Q?nkgmrXcoNpPWtSdL9+wcVtcOX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc31bdc-dd18-4751-75bc-08ddb24e0a8a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:04:01.4721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8GTUZdhbgLAAQ7nnkMwFgoGCnTbEf3nPb6e2RfXNrMcRgGgo0XMX2R4n9A2c/tAcFqcLVUO4NLksjsJsImBYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867



On 23/06/2025 1:39, Zhu Yanjun wrote:
> 在 2025/6/22 10:22, Mark Bloch 写道:
>> This series optimizes ICM usage for unidirectional rules and
>> empty matchers and with the last patch we make hardware steering
>> the default FDB steering provider for NICs that don't support software
>> steering.
> 
> In this patchset, ICM is not explained. I googled this ICM. And I got the following
> 
> "
> ICM stands for Internal Context Memory, a specialized memory region used by Mellanox/NVIDIA network devices (e.g., ConnectX series NICs) to store hardware context and rule tables for offloaded operations like flow steering, filtering, and traffic redirection.
> 
> ICM is crucial when using hardware steering (HWS), where the NIC itself performs packet matching and forwarding without involving the host CPU.
> "

Broadly speaking, yes. You can also check its consumption via devlink health reporter.
https://docs.kernel.org/networking/devlink/mlx5.html
check out icm_consumption on the above page.

Mark

> If I am missing something, please correct me.
> 
> Zhu Yanjun
> 
>>
>> Hardware steering (HWS) uses a type of rule table container (RTC) that
>> is unidirectional, so matchers consist of two RTCs to accommodate
>> bidirectional rules.
>>
>> This small series enables resizing the two RTCs independently by
>> tracking the number of rules separately. For extreme cases where all
>> rules are unidirectional, this results in saving close to half the
>> memory footprint.
>>
>> Results for inserting 1M unidirectional rules using a simple module:
>>
>>             Pages        Memory
>> Before this patch:    300k        1.5GiB
>> After this patch:    160k        900MiB
>>
>> The 'Pages' column measures the number of 4KiB pages the device requests
>> for itself (the ICM).
>>
>> The 'Memory' column is the difference between peak usage and baseline
>> usage (before starting the test) as reported by `free -h`.
>>
>> In addition, second to last patch of the series handles a case where all
>> the matcher's rules were deleted: the large RTCs of the matcher are no
>> longer required, and we can save some more ICM by shrinking the matcher
>> to its initial size.
>>
>> Finally the last patch makes hardware steering the default mode
>> when in swichdev for NICs that don't have software steering support.
>>
>> Changelog
>> =========
>> Changes from v1 [0]:
>> - Fixed author on patches 5 and 6.
>>
>> References
>> ==========
>> [0] v1: https://lore.kernel.org/all/20250619115522.68469-1-mbloch@nvidia.com/
>>
>> Moshe Shemesh (1):
>>    net/mlx5: Add HWS as secondary steering mode
>>
>> Vlad Dogaru (5):
>>    net/mlx5: HWS, remove unused create_dest_array parameter
>>    net/mlx5: HWS, Refactor and export rule skip logic
>>    net/mlx5: HWS, Create STEs directly from matcher
>>    net/mlx5: HWS, Decouple matcher RX and TX sizes
>>    net/mlx5: HWS, Track matcher sizes individually
>>
>> Yevgeny Kliteynik (2):
>>    net/mlx5: HWS, remove incorrect comment
>>    net/mlx5: HWS, Shrink empty matchers
>>
>>   .../net/ethernet/mellanox/mlx5/core/fs_core.c |   2 +
>>   .../mellanox/mlx5/core/steering/hws/action.c  |   7 +-
>>   .../mellanox/mlx5/core/steering/hws/bwc.c     | 284 ++++++++++++++----
>>   .../mellanox/mlx5/core/steering/hws/bwc.h     |  14 +-
>>   .../mellanox/mlx5/core/steering/hws/debug.c   |  20 +-
>>   .../mellanox/mlx5/core/steering/hws/fs_hws.c  |  15 +-
>>   .../mellanox/mlx5/core/steering/hws/matcher.c | 166 ++++++----
>>   .../mellanox/mlx5/core/steering/hws/matcher.h |   3 +-
>>   .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  36 ++-
>>   .../mellanox/mlx5/core/steering/hws/rule.c    |  35 +--
>>   .../mellanox/mlx5/core/steering/hws/rule.h    |   3 +
>>   11 files changed, 403 insertions(+), 182 deletions(-)
>>
>>
>> base-commit: 091d019adce033118776ef93b50a268f715ae8f6
> 
> 


