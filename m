Return-Path: <linux-rdma+bounces-13948-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2B7BEFC8D
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 10:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E54C4EC778
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Oct 2025 08:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA00A2E8B98;
	Mon, 20 Oct 2025 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ibpbW9Lc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179DA2C08BD;
	Mon, 20 Oct 2025 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947339; cv=fail; b=ok/7WOLkx3opUFSnKkXh/RA6iUIeY/4BRne92zGiLAG6XdwKIAlvFdaB/Mv9GyVsHGSiRuF2bq3fUW82TitsistcXXbrFY6DYj12o5Mnut7x8eDY6AACYY/fdrh/EPB1MOnFavdJd1qlcuwL4Ihzv+2ravw/ZRrNyVNS/6Z8gfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947339; c=relaxed/simple;
	bh=dTR1ZVf1W236RCn8l352i+3gkHGjm3in6p4radzdVKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TLr3J3u+rD4ulfobaotz2UNfLa9aqzSCsjzElfaTcEJ1ALdN9WYGkNPPEDFqRa0A1qWpJulrU/dEF2+LQKfYFzAfbf3Wpl8PSiAk8byyGdO/kXOCLvXUBetxAdcbI5KwOx99FmU96FOYPX0WJ4+dyJ7m2QiMT8zG7o6gMIBq2c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ibpbW9Lc; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFbKn1A6x7u9Di4fTyuCJV/7m+L6jhEtO6hBm4I3BVRGey6C7buIt8RDw7/1SgF6AcUMaZOxA8DSrag9I700ZaWGm6WWUWSYuocbXANu4ewUvmbYJBBN070fa8lAcRM7yGSGmybtjO6ndL3KW4bdjRElF7XsCe/OH/dgdsL0S3QpFuvT5YwIgafyjgljYLYb0C2uPn71WCatav4IprCidIg0kiFRA5wQJ1KBzBY4Nr1BnXLEvVjB3i16oH6XGOFNmvO7GMkxTVyKzmPK12u5ohrmuNF1SSw7elgMdaDvAkukXVDeHd/Dav/GD2pwZkfZRHpUXerijHBD150oJaWHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqn8JGwyz9fyXKu2Ehb8zgrOe/Pr2Ceqadf9Ym0j+3Q=;
 b=v5hW7Smz/7C5t6GTHCku65Dji+VO88Do6M6B08PSYaGrdzhljHZQMBBBY0KbXOISnPK3EocivLZvE/7GLkpfAAiazy0KKgP6voQCFyRebSmJ+n1rY18ZFn8k8h2+ngPV+qBm66zIhjDpHC4fvyzsi9uTQPtQzZepxeIg9yInWIDkAIG5Jn0mKgm++EdaqCvne3UWHatyGW+AVYVHIIxhAyl/0jFGYfI+um7mm/5Ww0VqpUMoqD+3Nm5dUqUgsGPYYGz/OFy1Tl7gqZ9ETnMxeyv+Sw/j/QL0s2yHm9yvHNA+9FFxZM1TiYCeG6/o/R6+Z/w8JRM2acb3Eg2k4+ULtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqn8JGwyz9fyXKu2Ehb8zgrOe/Pr2Ceqadf9Ym0j+3Q=;
 b=ibpbW9Lc7VfF36gWFrOuasuPtNWiNeBoL7CaBSU4a2Mm7P1guTO3fK4IgMb3Ef4kiEHgfbyBIrDc4wlV8pKLTtmmCvcNvJLtO715HSCpqL49X3axUn1ASvVk8hP+m5UWJ1uRY7B4ZKHOa4L9fmjM+q/DjdMF+iJffwI/o+bGhD+RMuaytnZMmx/vJFOrTtvjOR8KLLl6Tyn3QKuURcZ+eSl+7BnCSjAxmw9o1uw0at+Mc7hY3SEpmiDQYD/B7R4Rfwuvce5z9vWb2+aOC3KRIZRJBNpNqmvSHp2xFWKdTRJCm4dKw3+yiaMgqkwwA8ljYUxPY176snNEauM9NzZOTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 08:02:13 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:02:13 +0000
Message-ID: <24a5c1af-f00f-4df0-b9f6-47dcb8d1947e@nvidia.com>
Date: Mon, 20 Oct 2025 11:02:08 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: tls: Cancel RX async resync request on
 rdc_delta overflow
To: Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Boris Pismenny <borisp@nvidia.com>
References: <1757486861-542133-1-git-send-email-tariqt@nvidia.com>
 <1757486861-542133-3-git-send-email-tariqt@nvidia.com>
 <aMQ48Ba7BcHKjhP_@krikkit> <b5790517-a15e-43be-ba70-fbc9dbe2b6c9@nvidia.com>
 <aNLyCP9gXWgaAUkm@krikkit>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <aNLyCP9gXWgaAUkm@krikkit>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c094f7-f5c5-4894-d4ee-08de0faefa6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFN1WDJFdFJiR0FzcDNxZlZUOEJrS1NOdEd4aVlrREY0NE5HcENKR0VybWds?=
 =?utf-8?B?T2FRU1U1TEZvUml0enJ2OFZsOVFJdlNnZ2ZYaklCcko0UDVycDhMdDJRODdn?=
 =?utf-8?B?RXFOQ3hXMi9GOFlRb3dYcGpzZGdDKzJKeVgyc3R1RFFEQTMxdjQ1VXJ0bmZk?=
 =?utf-8?B?RU9NaXJRb2hzRDZIbE1OWGp6bmR5ZWhKYWxkVFNUSGo2aDkyWVc3U0tYTENV?=
 =?utf-8?B?WTJTVGNrZm5hSEtpMnZOa2g2M3d3N0ZzQjVLRS9iQVBrYmhNdm1vMEFXZSsz?=
 =?utf-8?B?aVA3Zm41Y3hFOHpvMXdzR3lkbFdRNzNyaXluMkFOVDRLek9VQ3loV0FROFBo?=
 =?utf-8?B?dXkwS0RJb3B2NDRrUWVwWTN2TnBNeVc4blF2TnhJa0gvcHNhdHkxZjNObUt0?=
 =?utf-8?B?VHRxY3YwcURCMm1BMlc1OG5WTzFRV3M3SW9obGlZMXJMVWVLY1RpUjFwbTVq?=
 =?utf-8?B?SU9LSkpqWDF5SUFzb2tuZ2Zsd2pNZk11ZzBGMmFSLzhjV2s4Rkg1WmV0NFJR?=
 =?utf-8?B?Wm03SjVtY0JmZTFUZlVGWTBxZ214R09keUhFdWV0ZnUzaGF6ZTkrQjhUdGZP?=
 =?utf-8?B?OHhKSzF4eGNsaEpHUHFNNXNWN3FJRTdZSjJXcjF2WmhTUng3WFdZYS9DZit1?=
 =?utf-8?B?Z0hxQVFXVmtqeStJZU8rU2ZjWk40T1Qvdk53Y0o0YUJvWHNTdVRucU9XZ3JO?=
 =?utf-8?B?Q3NIUDNhcEo2NVFScGhOVzJZNFRNeVFiaFE5RjFvYWMzYUt4bVlXRzdoSkZ4?=
 =?utf-8?B?RTQ4aFZXYllKNjhqZFNDY29GeGMyblFIcXpXbHY4eGcvTEdIWEJha2x0S2Qz?=
 =?utf-8?B?SnVmbGNKTlBOcFl6cytNZkxzNEl2ZkpJTDdIU2wwMFFDL0lvVnAyNUprcHlI?=
 =?utf-8?B?Z05WbWtiNDZIK3JlcjVXeE16WXRtSy82RjVDbjNyR0cxaWVsdnREanR5enhZ?=
 =?utf-8?B?MiswNlJjSnplWkoxSFNxcXRSSXV1aWVsU2VTc0ltN20xRDFoRVFEZThYM0lU?=
 =?utf-8?B?VFpFNUhZOUpVMTV0TWRVUFBqeHdmbGl4RmNCVmE0YmZUOXJuYlNqSEdDVS83?=
 =?utf-8?B?czZlMmRlSVRJMFZ5bkpoYlQrNE0vT00xL3NReSt5cFZoNGR1bzZkeDluV2Fw?=
 =?utf-8?B?cVJocXhBaHVQMzV2MGpCbDFCZTdpZUFMcjRvY2NRbkpFZ1oxM0NwYUNKME1v?=
 =?utf-8?B?R0tNZXE3TllWZUU1UDIxR24wMVJpcFNJMWlQSFhuVXI1K1RzWmNISnByb3pP?=
 =?utf-8?B?dFM4Rkg3cTV2SjNUVWsvOS9VQ3FqY1VYdzdicnF6UEUwc0p4aHZWd0FXNnpK?=
 =?utf-8?B?TFpBZFVCNFNlYVU1QjRXN00zNnBQd3A4dFVYdnVsZGRHcG5RTWVaWWlPdzha?=
 =?utf-8?B?K3JsMHpGME05emV1NWpoUGlaN0dndTZWQk9MWTlYT0oxWEVIQTVKdjZJa0dO?=
 =?utf-8?B?V1huYzRsa1VObnNoVXFGZXNNSTB3bHRWR3QzYVV5U2xZNjdBOVMxcVFJNk43?=
 =?utf-8?B?M285c200V2IzWHhXb01lWXdFSEN2RllpejUvcFhPUWdYanZTSmxyZ3VYNTdX?=
 =?utf-8?B?Y3hIOTdsQ0ZJSEErejRtR2JabHhjQVVJS2dGZ05uUDdzYTliZjIySzU0RXFD?=
 =?utf-8?B?M05sdDJOQzRNdkVyRjlmNkNLbmVicHNoSHVrL3FzSDVsMFBEUlNtZzIxdjI4?=
 =?utf-8?B?UmsxMGpXdkFoZS9BQlQ5RVpoYzBxT3dhM0F5N21PT1grNS9Vc09xS1cxYmlP?=
 =?utf-8?B?MEMzVEtKbEpOQXM2UmxlZmJwVkM1bWEzbUxXaXFpL0ZhcFNuN1BXQXZYMitx?=
 =?utf-8?B?WnIveU9NZ1RaQkVjN2RnZHV2ZlozWmlBbyszVFJ3RnRUdGhGeWlSUUNWM251?=
 =?utf-8?B?dE84Q3pZZnVhYi9uUHF4dFFOVXA4RDF1S0JHL0lWb3ZRUW1TcTE5QThtUGVF?=
 =?utf-8?Q?uRrTagnQI2yM8Yqs/oUqY/ZoAZDbkvny?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0pGaWpWcm1BRm8vZU11bzRUeXI1VHQ1WUxra1dkZXdHQzdYTFlPUXU5Y2xj?=
 =?utf-8?B?WHFxOXQ1ZXlGMzVJbzdJTURZT1dSWjR3bmw5UUp0dUJTVmp5dTI1cVZXZ0lD?=
 =?utf-8?B?MkZvazRhNmFQMDRNWHowQnErdWEyZGZ0SEFSSUF1b1J0eDJGUllwL29meEpk?=
 =?utf-8?B?cjE1ZUkzaGZ5Z0NldUd2WTZQQmhtcVBHVE5HTVdJR2NuRVQ3cFlRTjl3VXQ2?=
 =?utf-8?B?ZXlBNFJUYWdVSFNreTFDTTRiQTNTd29aZ2ZxNVFjQUNVVU5kRWVsUkQ3clo4?=
 =?utf-8?B?ckQ5YkVNQjZpcmJmYzFWTUxGYTRBU3Vad1JadmlKMk1rK2liTXpXSkFjMTNz?=
 =?utf-8?B?cWdWR29EbzhUbVAxd3l6MEhNQUZvYk5RcERxWlZtMjVUN2ZoeFZsb0hjQTNF?=
 =?utf-8?B?Q052T2tDUFlnZ2RmUlZSRkl2UWl6ZS9yOEpYd0EvWExDV2YzczU1aEtBR1Fz?=
 =?utf-8?B?QmJpRGw1NFcyUk56S09SRkZxZ2hlamNWZ1o3ZDlRc1pBaGRUaHRGNXlMZFBm?=
 =?utf-8?B?c2Z4RFZUNGkxck5mYi9NZHdPK2UwclNUc2trWmdkaGxhelhMQzBkbWNKczVo?=
 =?utf-8?B?UThYZnlVTXJBZ3luUit5Ym91YTNMZmRjVHAyRjhoa0ZPOGxBVlV0TE02M0RV?=
 =?utf-8?B?T3VzRTBhS05JK1hwKy8zbDdDMkcvSmE4elNNNUZSQStFSjdsUkVyKzJ5T2F1?=
 =?utf-8?B?cHk3bVVxWVlHcENrMlpkMzk3elNwTFA5eDZwdS9wbnQzL2M0YVpVaG83TGNX?=
 =?utf-8?B?Q0laU0VxcUZhcVJrQWp0Y3ltQU90SEc1SS9TUXNzZkNIUGhBa3o1N2ZkSWNq?=
 =?utf-8?B?Wm5qenZiU2lzWTFCWXRvZk1zd1lNQTZQL2xnTi96a1dGTWNBR3BEbFdMK1FJ?=
 =?utf-8?B?ZjBoVDNLOGlXQ25INXRHanZxNlBYR1pycE1TUHNEMGVnTGZKNVlFMzNKREps?=
 =?utf-8?B?Z0U3cXFGaWZUZm15OHRUWW01dWJwMERtSkljbjFtT0g2M1lTUEJpREFUWmJL?=
 =?utf-8?B?TkZOR04rci9oWmxWWnpGZXZGdXBZaUxUUEdoaTZST3MycEZYUExhSHZMWUlH?=
 =?utf-8?B?Q21nSzJUay9iUnJVbVk3UTQ0N1h0K1VHd0w1K0gvOFdPcXErc05DMGMybXBB?=
 =?utf-8?B?NURtWFRxZ1luV0NpWkZPT3FHQVZHQTE2ZW9oZ0VoZktzbE9udHIzRlVkckt3?=
 =?utf-8?B?VTl2clZ5SE1HazdXYjQvaldYd3JUR2owc01KbnovWXk4UUI5akJSMmtSd0pU?=
 =?utf-8?B?OWJleDNVeUdrZkhMcjR0RXloVzUzZHRsdWxmUU5oVzB0a1RmYlR2ZjMvOGVj?=
 =?utf-8?B?S1FmREdTbGVzeXlkRHdXdCtVdUdBQ0lqRVBoajVNU0dKWDRpblZzWlRDSXV2?=
 =?utf-8?B?ZWgzVHZFdUtuNWR1OU1TQVpUZ2dYampxaWpNdWZranduZWtuUmZENmliaEc3?=
 =?utf-8?B?YytEQTdZMGpmUWZmZ2J1VHVXMzVQSnhTeVBEcjNzVFhDbW5NbmxoWFA2dGFl?=
 =?utf-8?B?L2dmUGtiSndoSkV5dHJDeWNpcmpTQ3VHclArTU5mNHhBbGF6eUwrOFdOUUxK?=
 =?utf-8?B?UTV2bkE3REpPRHI2cEtGTngvbllWOVR2L3dhbC8wM20wa0hGZVMxRC8vN1c2?=
 =?utf-8?B?WEsrYkY3MUN0OTZNYUU0dm5ZeDJIaWVEZTdOQkpsVnhEM1lWZjhUWU0yWExV?=
 =?utf-8?B?emlQZlg0VlNJV2ZKYXdkalJkTmVQQUY1VHNBeVdDdWdqNmhLTnJOaWFsS2Jh?=
 =?utf-8?B?QTRZQTAwMmJES2hWaVdsZmxtM3orWVpwbW9yK3BTaFgvN1E1azhEQmZ5aWY2?=
 =?utf-8?B?aXRxWndaSkNwVWhLaUh6emtNcnZsTDNFSS9FS2lONkFIMGNueUVKUDVSMG5j?=
 =?utf-8?B?VWJOM2NqRUtNUC9kblVKNllmaWV2MGlsbkp4MXQ1Q21JZ05sRWQ0RkJWU3lX?=
 =?utf-8?B?YUNVRmdYYWRia3ptT1o4eVkxQ09MQ0JWcjZoYlRiVXRMbjN4enVValFVVmZs?=
 =?utf-8?B?UTlESWhzRVdWcE5MM0JGQU9wUnAzNUZqNEhBTXUvQ2d1TUg5Mi95T254ekdl?=
 =?utf-8?B?a08xYU83U3dzQkpHbUJtbFdGTXpTQ28rQjArcnJNd3haNVlMbTh6Z1Y1VGI4?=
 =?utf-8?Q?16PXfyBX4TI5+wwwG2OpEEKMt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c094f7-f5c5-4894-d4ee-08de0faefa6f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 08:02:13.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p46YfJqAKDAe8e3M5wCDbeBxHcwzsPL+T/uFccQi/5korTzs5EGY5BT096/pC5ffMy3LH8NmLse2Y6ec3I/R5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471



On 23/09/2025 22:16, Sabrina Dubroca wrote:
> 2025-09-22, 10:16:21 +0300, Shahar Shitrit wrote:
>>
>>
>> On 12/09/2025 18:14, Sabrina Dubroca wrote:
>>> 2025-09-10, 09:47:40 +0300, Tariq Toukan wrote:
>>>> From: Shahar Shitrit <shshitrit@nvidia.com>
>>>>
>>>> When a netdev issues an RX async resync request, the TLS module
>>>> increments rcd_delta for each new record that arrives. This tracks
>>>> how far the current record is from the point where synchronization
>>>> was lost.
>>>>
>>>> When rcd_delta reaches its threshold, it indicates that the device
>>>> response is either excessively delayed or unlikely to arrive at all
>>>> (at that point, tcp_sn may have wrapped around, so a match would no
>>>> longer be valid anyway).
>>>>
>>>> Previous patch introduced tls_offload_rx_resync_async_request_cancel()
>>>> to explicitly cancel resync requests when a device response failure
>>>> is detected.
>>>>
>>>> This patch adds a final safeguard: cancel the async resync request when
>>>> rcd_delta crosses its threshold, as reaching this point implies that
>>>> earlier cancellation did not occur.
>>>>
>>>> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
>>>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>>>> ---
>>>>  net/tls/tls_device.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
>>>> index f672a62a9a52..56c14f1647a4 100644
>>>> --- a/net/tls/tls_device.c
>>>> +++ b/net/tls/tls_device.c
>>>> @@ -721,8 +721,11 @@ tls_device_rx_resync_async(struct tls_offload_resync_async *resync_async,
>>>>  		/* shouldn't get to wraparound:
>>>>  		 * too long in async stage, something bad happened
>>>>  		 */
>>>> -		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX))
>>>> +		if (WARN_ON_ONCE(resync_async->rcd_delta == USHRT_MAX)) {
>>>
>>> Do we still need to WARN here? It's a condition that can actually
>>> happen (even if it's rare), and that the stack can handle, so maybe
>>> not?
>>>
>> You are right that now the stack handles this, but removing the WARN
>> without any alternative, will remove any indication that something went
>> wrong and will prevent us from improving by searching the error flow
>> where we didn't cancel the request before reaching here. We can maybe
>> replace the WARN with a counter. what do you think?
> 
> Do you use CONFIG_DEBUG_NET in your devel/test kernels? If so,
> DEBUG_NET_WARN_ONCE would be an option. Or is it more so that
> users/customers can report the problem (ie on production kernels
> without CONFIG_DEBUG_NET) - in that case, the counter would work
> better.
> But if you really think that this condition indicates a driver bug,
> maybe the WARN is still appropriate. Jakub, what do you think?
> 
> 
> BTW, I was also thinking that the documentation
> (Documentation/networking/tls-offload.rst) could maybe be improved a
> bit with a description of how async resync works and how the driver is
> expected to use the tls_offload_rx_resync_async_request_{start,end}
> (and now _cancel) helpers. The section on "Stream scan
> resynchronization" is pretty abstract.

> 
We will submit documentation enhancement in a separate patch to net-next.


