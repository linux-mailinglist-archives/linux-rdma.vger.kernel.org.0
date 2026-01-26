Return-Path: <linux-rdma+bounces-16012-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD3hJAMxd2lVdAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16012-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 10:16:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA13B85EA3
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 10:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E24623008A69
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26DF306489;
	Mon, 26 Jan 2026 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y8vpRSAL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EEE2236E3;
	Mon, 26 Jan 2026 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418939; cv=fail; b=ukdIF7KSyH5nkV04NWVVwviIxueU+VpbCI0nbvwds3/4XmktDm9KJi4pUz5qLOpiU87vR1bXed52n/ZeeVv+/RxkrvDISEk0tXveZweRyGXKr1bJWhWf/2E6OUYICHTfe04xkMbTlL9COk7pnWb0hVxn6oiYzv8RBLp4Y9winoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418939; c=relaxed/simple;
	bh=YSdNYGJgor/yE/OdPiup0DSIO1v7NFtZLQ9IRm0uSJo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pe2hiC7HhYJdGbiu+LTNO7YLulU/JMR/XY6yBwxug8f9fg05E4d85eIVE5HshaO4gN2aowojM6U+pcA2q/RGPrhyNtjoFVBOa68PHgmD/n8xhs/10IEu7qerDOVNDUae6BHYGMGUlCdoFODLIS4kHqrrtKKzb4HnC1YnTq+TZ+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y8vpRSAL; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1CQXR7t17xJj8CeM5W8aRmuptkruXRZ2iN/PTOiJ5uTDzbNt5n6/v3pj1Q+DnhDMd5XMo8kSJVySC+yGZhkIXCkNhg0eJ+3d4QyM7YVovB75hM3suMP0BA3SgnMpe2NP0Rf/NRwUkpmMT3GzUD5vFhpvbszl8GOuQU3NF9GTjmno0EG7lBKk+P5nZpvqgYmChyO58A0RXkP1mGZMFq3/N50BYsf3gJ3096C5i4qfy8XMPM7huzrvJrfEGTXoIsZNbrtAGN6tgAeEsmPDYiuPO68bdsIWqy72/e3CsufIcU/r7KgxnUuu78s4fD89zIhLGzlBJBw5PoTCw7QtA5p/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSdNYGJgor/yE/OdPiup0DSIO1v7NFtZLQ9IRm0uSJo=;
 b=i0M7cqSwk+JtITvqMo0kv4HVOM2+3alkmMIZuLGrVz0XyY4ycdFwPK5oFQj4QtL9aAfN8Baku0Hlx5zMSEEnf92A0hV7sW5u/a9tceeixsyCbe20WHnvkEYgOKLSPLzveQRxezsIpmPIcf2dHiaomG+Lv7phR/THcPaV8mVCtcIf05UuYrgtFtiAECYfk6ouGx9AqTs+tfvdbIt4Eg7A65AnHWZD+dE5+gVqSJkyPA3VM80iPB+BOox0gfOU6DhZmpgf+kQXu/9UzrUwX9njy141t+6N+XRKI2K8gTG/18KQ+S/RyIgRLbYZORfizS007qifdjf9ptsdC8vZShHy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSdNYGJgor/yE/OdPiup0DSIO1v7NFtZLQ9IRm0uSJo=;
 b=Y8vpRSALPNPAw/p7c5aJYV/4dSWPR/HqgAYCuFs36z6CZMQVQWN/+ggol+FF5OPim9oPAHHwXUSW9h+xyCF96MjhH1ElQtuJGX696gIPYzRvQZph+GwyIXS8uwfyEn4L1b40Lv4q3qAsgqf9L7nl1msAdeoOwrZmeOnuRPazgngOGzV2ACCnKhDAV5uYv/CjtZRgOS7wIgAJ8uOWXFz3qfBgXp0eRVM+XxRLy2DWt2mzX+k61Jk4mybgojVX8o517c0/Z5kBzIcrVZBpqstuM0InWi8z1hJrgM/IKnkK30a9lUikbukcc5RMX7icMeD49ZcveyRDsh4yBnkNKo0YHg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by BL3PR12MB6545.namprd12.prod.outlook.com
 (2603:10b6:208:38c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Mon, 26 Jan
 2026 09:15:34 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 09:15:33 +0000
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
Subject: Re: [PATCH] net/mlx5e: don't assume psp tx skbs are ipv6 csum
 handling
Thread-Topic: [PATCH] net/mlx5e: don't assume psp tx skbs are ipv6 csum
 handling
Thread-Index: AQHcjJOtoxLadyLgAUKFCUzREF4QS7VkL3uA
Date: Mon, 26 Jan 2026 09:15:33 +0000
Message-ID: <dddaf1c5923576042112c2edad2f285306b839cb.camel@nvidia.com>
References: <20260123-dzahka-fix-tx-csum-partial-v1-1-7b0107693883@gmail.com>
In-Reply-To: <20260123-dzahka-fix-tx-csum-partial-v1-1-7b0107693883@gmail.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|BL3PR12MB6545:EE_
x-ms-office365-filtering-correlation-id: c565860a-26f0-48ab-8955-08de5cbb75b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?cC9TMjVudEFVUXZjcVFKV2hBVlR0M2UzTEJ5dkxFVnNKOE8wdElFOUdHTHF3?=
 =?utf-8?B?Q2puM29JeTNiU3hVVG9WYkh4UVp6R3dOcmxUK0R6c2dHVVNZc0MvcFY5UjRR?=
 =?utf-8?B?QVlVb216SWY5Z05rZGZad2xCMlQ0WWVmRE03eUcwaXgwdjNBT2IxTmI2RjFv?=
 =?utf-8?B?L045UWdJNzdweFV4MVlqcEJ2cm9obit5dzZjUWMwYnUvcFIxM0ZBdHNXcjlr?=
 =?utf-8?B?UEsvWlo2cEZndjBaTWlqV2xmYWZyQzFWMHdaSGt6emtqNEFqeS8yNVBsUmp0?=
 =?utf-8?B?Ly9CMDBpUTJ5VzIvM1d1clRPY3U3ZkdwOWVaelVzemRqd3VlNHBhSFh1UjRR?=
 =?utf-8?B?UHJBWGFFMDVyQzlENVY0VjNFbzE5d1Iya2ExcnJhNzBWT01pZkZ6ek84Z0dN?=
 =?utf-8?B?V0RkckNISDRNUnVqWlNiL2tIbFF6VytEa0M4QTlBbFVkUnlJejZwUzB2c09a?=
 =?utf-8?B?bEJBa1JucnRSV0FWd1pkT0JhL2RqelEwN2c2dWxkbHZVcTJURHJNT2tCMWVj?=
 =?utf-8?B?WGtYSlNmWHNpMm1vKzlUcmZTVUFqWVE4SGk2amxJYld5MTlEZnViYllXOEMw?=
 =?utf-8?B?Sm1RNnNNd1BoZ2s4cVlTS0laWWZsVmYyZlZ0YUh3ZjdjUjViYXRZdFR2UmRy?=
 =?utf-8?B?Y0lWWkR6b0puUUNtMy9jZ285OXQ5Njk0OUoyY1ZRRjZEVVdINFA2Y016d2Nt?=
 =?utf-8?B?ZStmY3hjWlRoOHRteFR6bCtXRXk2dEdEYjV3R2JoVUYyMG9KQVBYa1NDMGlT?=
 =?utf-8?B?ZW9uNWZsakZ0SU9lbFF5WVg5STQ0ejZLS3FSSU9CYTFESEdEbWx1Mmo3WkJo?=
 =?utf-8?B?cThocytMb3RVZkkvQWpJVFdKY3JPVDQ5Ri9uVHpxZVhOZEZPWkgrM3hhRUhh?=
 =?utf-8?B?dWVGZlArWGlsWng0ZWNpc0tuV2xnQ2tETFR6QjJKYzNWUEhIR1JjZW1BVUlh?=
 =?utf-8?B?Ly9TTGlkZ05PdWVZbWxBVzhkUnFhSmxWYUQ2bmNoTW9GV2xkQVZKOE9BcEw2?=
 =?utf-8?B?eXM1NXZxeGtrTHF2b1laM1lIYVZvTnpIZ2I0aWdZdUdXMytIMlYwN1QzTzBr?=
 =?utf-8?B?QUpJRE4vZFB3WWhyR1NMd2FnR1RPb2Z0VytHeHFiUnlrOUJUTWtLQjI3TVd2?=
 =?utf-8?B?NG91TmtFUndZTmVoSVJZcFYwWmpDS2ZlZ09ZUWszUWRVeTh0YVdIL3RhdDYw?=
 =?utf-8?B?VjZXR1JzYXoxZ1hYZ0RBQnVWT0JIUUhxM1BjN2RpV2lPUEYrZm1MOFZIWFdE?=
 =?utf-8?B?VnY3NjRsaisrY2FGbzl4YzhKTnl5MkNEcHQ2N2dCMjg1MEZJNzdvd0lNbjho?=
 =?utf-8?B?a0ZKdEdvT0gvVnhveDF1M0RETmlvaEFYb3JaaVM4VmZJZUxUQUpUSGp1Umt6?=
 =?utf-8?B?STNKV0txUjk1RlF2b3lpbG5WRCs3OE11b0QySm1xTVdIMWFneURzUmk4a1pu?=
 =?utf-8?B?c3Zab29ISmdxV20xWGRnQ3FZUTFJVnY5SGs5L0pUdGd2TGVrQ05BYWVNSGdX?=
 =?utf-8?B?aXpiUmsrV0RHcnMxeXNSSlNDVW9UY0p0ZTlXdkczTUlqYjMyMGY1VkJtRzNY?=
 =?utf-8?B?RElWL1RENWxpbWtNd3VDSGZzOGlkOFFrSmVkWU43eEI3ekpUSmE3bDVkM3Mz?=
 =?utf-8?B?TTNkMU9wU0kxcDlPbjdKRGIvcUpIL0tRaTBlQkhrV1U5VFQwS2tSaXFiNk83?=
 =?utf-8?B?aGhYdk8rTFYyMkxKaTM5QnBpb0tPUFJ0Wkd6emxuSnFKRmdsd1EwN2NFWGJ0?=
 =?utf-8?B?ZXNvaXU0a2lzQmV0elhXS1U3bXNSV1RZcW83QmtzRXdzeE50VzEvT1F1NXUx?=
 =?utf-8?B?TnBLMFA5ZzBuQW94WHFTSHNEazZ6VGVjT1Z1TkFZUkFZeUZzNHIwZGdvZldz?=
 =?utf-8?B?am1waUkyd3F6K0dEcnlwY3hDZnM2aEJNUTE2UjlYZm42QXhENFhpeEMwUTNq?=
 =?utf-8?B?NzFHZXhnMnlMZ0RQc1RkQzJ3Q0hGNy9yV2pIT0hLRTVuQlc0dUtJaVdHWXRS?=
 =?utf-8?B?TnVFcWpmS1pYSjNTVlE1cUhFVEswbUtwWmRiUGJUNGxCK1RWMEVjYkJxUmhu?=
 =?utf-8?B?MGg5SkNldktGS1l0SmdjMWMxb25rM3F1d2p4alorOVFaUER1WTVOd2loaFFC?=
 =?utf-8?B?VzhTOGQzOHlXV1pLSFNNNVhoY2hlYnI0dFJQUEtENDFWYzRrZVQ2RWpQTEo5?=
 =?utf-8?Q?djc6pqK6E4/W6RJPPj/Ro0qDBA1POd4teWKr7DHEdgh9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mm5BVXdUeDVOK1JIc0kzbm9zWThiVDFVRHVEVDVhcXNUdktMR1BZNnB1Rmo4?=
 =?utf-8?B?VXZybU5XSzJDa0tyQ0ZkN0MzTk9EZTdjL0N5SUs0cW9nWWp5RnFWZDlpdDBw?=
 =?utf-8?B?RGZhbmNsL09BQjQwYmtRSjRDNHgzR3JIZlJDMXhVYUNBMzdHeGYwMXhscWF3?=
 =?utf-8?B?bFVtUk1oc2JOS2JoZTREZjNLL3RpaTJkNTZTMTVtRnJ0TkpwSTUvTXRlbHIr?=
 =?utf-8?B?WFV4a3UwRVJsVU5ZN2lmMTZ4MHZ6RGYvb3JpWlltM2FmZFBXQXlhcGYxOTZu?=
 =?utf-8?B?VWZEb1grbXphWXRRSUxqODk4RWY0OFlNMEJFbmtmY1ArWmtDMktBMDdoRVBC?=
 =?utf-8?B?OXk0VTlONDlCYkI1Nm1VWUJSNUVKajhOUzNjZlJTMmFqTTNTb0c0biszQURV?=
 =?utf-8?B?a291T1hUVzlwTHpLRjBINDVLSld1ZTlXcjFwZmpDbEU2RHVBYi9jc3dCRnRl?=
 =?utf-8?B?TzNZR3hsUnBLc1ZyZ084NGIzV0t2MlR3WEg4NG9XVTdTemhVQTlRV0g3Zytk?=
 =?utf-8?B?bXNJUEZyeExmM29saUtqcWV2R2ExSHo4SndITnJhYk5JaHBzaU1nMjVWeFVS?=
 =?utf-8?B?Zkh3SWRqenYwOUYvbU5XMFRIcEUzaXgzQ1FQWWV5d3dvenpGY3EwTEhDN3Ez?=
 =?utf-8?B?WlV2WEc0MXVsczJXYktqL2hSZHBRQWNJRk9oQWpxVzN5UVVvWUVwdnR0V2E0?=
 =?utf-8?B?NzFEU2tibVhBQWhKSDZzRlIyUFpmRTUzdStudjUvalBFSlpCOUFUR0RUeVlh?=
 =?utf-8?B?UC8xVHY2VjJCbUliZ0NsaU5tWk90WGhGbnRLa2x3ckNibjdsa2tqVGpxbXp1?=
 =?utf-8?B?NTJRd2oxWFFTZ2dlZEFDME96N1BidGxhQlJFdnNpZU1oZE9zQ2MySnpHSUQ0?=
 =?utf-8?B?dzJqbktaaW1TbXpsVlpvYWFKbENzamJIRThRaDlOMmVmUnhpMHpZbkVxWGN3?=
 =?utf-8?B?bEpveUZyQWJ6dVd0SUxnQ2wrcWFZS3hBQVNHRmhYdGQvcCtNZjUxanR5R1ds?=
 =?utf-8?B?OHdWYS9HMzZURzlGeFhrN3RnMlB6Y1kyRkppVGVnemc3L25VeGFveWZLelF3?=
 =?utf-8?B?V3FwY29sNEMxcGpJTmFlc0xkZFg1YnJGMXZEcWhod0Rpa2o5SFNYcEhIeTU5?=
 =?utf-8?B?dlhvcmhoeFBWZ2paaE03M0F0eW1HbkYxSmNnM3IvaWZXQW1kSi9jNUFCRnhz?=
 =?utf-8?B?czZ6MGU0SEM1QmhONlBEY2hEQlA5eFh5RnNUSytoa2xzVThzTDJwWlNFL1ZR?=
 =?utf-8?B?amVnNUhhR0swaWsrQThiUHhibnI3YnpBdEh3VHJQRkYxV2Y4a0xMYk1BNHQ3?=
 =?utf-8?B?a0Y0ZDRxNlJyYzZYSGFvcnRQRnRhb0tvaUg3QU01MDU0Z1dwbEF3WWZyMGcv?=
 =?utf-8?B?WVRpWDc1bmYzcVM3eEJFUGhyazV2ME5sZmpIajJnV2ZWVjQyTzhXblJqTWRr?=
 =?utf-8?B?K1ZMSGVDNWZSTkR3UzU1Z1hPSFVkVUVJbS8rMVB4dklpbFhQS2VrQUhCbVBz?=
 =?utf-8?B?cUROU2g0YlA4WjFJR2dXSlRlVmI5RXZnS0hWaWQrc0pHV3lVang4cUJja20r?=
 =?utf-8?B?TEpvOGxrYmhSYjZoN0Fqb1NGa0VEck5YYnk2Ulp3dE44MVUzMnRMelAwVS91?=
 =?utf-8?B?aU1hUmZqTEpHZURkMWVXSC9zdmFZdFNvK1l0THZhcENOYXlQU3BTRDY5eTdz?=
 =?utf-8?B?YkYvMHFxT1R2VTRnRkR3bkpCd3o3VlE4bUFMb0xyWFFGUHFBd2pWUWs3ZXh5?=
 =?utf-8?B?S3BEbmxWQklpTnFRQXVzTkRxTVhaaHRydys2U25obm9aTkcwTVBVOXRTTVVl?=
 =?utf-8?B?VzB2RTlVOHhQTUd0NmwwOHpibW92dEo1M3Q5MzRnV0RPems3Wlc1cGlUMnpL?=
 =?utf-8?B?ZFVOR0RoZk92MWt1amx2TnZXSzBITnB5U25TYTdENEltUklmSjJJOS9LeE92?=
 =?utf-8?B?bzdYY3o5TVZJR3F4c0dzai9Wa3pkQ1ZSR1d4N25VMmtuSy8wNW1KQWlJZy9L?=
 =?utf-8?B?em10MXd5Q0RCSlZXMWJDSmhKU2I3OEFOaFJlcnVEcVVyYzhubkdNZEtLN0dL?=
 =?utf-8?B?VCtrKyt3WTY2N2tlUnNyOThVT0lXUUdKV2NaUDkrdHIwcnlxbHhRWXlSNmpY?=
 =?utf-8?B?SUMxaEg1WGVsWGk2bnQzdFpCZWVSaXMxWUNQUkwxdC9NUUpNd3hQQXNrM0VV?=
 =?utf-8?B?b3R5aEZwYmFvYmFRTlJDUnY4d295Wk1vaXJuWEdFcXk0aS9wbmJZVVozOUt3?=
 =?utf-8?B?Vlp3WGxYUHU1cHB1MDV4SDNJOWR3dndUc2FYRHZTZW84RE9KNyt0dEpoUXo5?=
 =?utf-8?B?VE01YjAyNGxxSGxub2IvcHpWZktDSzczWUhXNyt6Wkx2Q2JtWmcwdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1AE1B81E3E07847A65EF40D1E037D90@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c565860a-26f0-48ab-8955-08de5cbb75b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 09:15:33.6082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXly719lJUZGN4S3idJM1qHEoINAd0ds09u8MhuvXKVdZfaip2Zbb1oml1ggm2yrJmV/y/LVsyj+qhra2Tyr2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16012-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,google.com,davemloft.net,nvidia.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: EA13B85EA3
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAxLTIzIGF0IDEwOjExIC0wODAwLCBEYW5pZWwgWmFoa2Egd3JvdGU6DQo+
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
IG9ic2VydmU6DQo+IG5zdGF0IC1hIHwgZ3JlcCBUY3BJbkNzdW1FcnJvcnMNCj4gLS0tDQo+IMKg
Li4uL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvcHNwX3J4dHguY8Kg
wqAgfCAxNQ0KPiArKysrKysrKysrKy0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQNCj4gYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvcHNwX3J4dHguYw0KPiBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lbl9hY2NlbC9wc3Bfcnh0eC5j
DQo+IGluZGV4IGMxN2VhMGZjZDhlZi4uMTVhMzQ0YWQ0NzFkIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwvcHNwX3J4dHguYw0K
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fYWNjZWwv
cHNwX3J4dHguYw0KPiBAQCAtMTc4LDcgKzE3OCw5IEBAIGJvb2wgbWx4NWVfcHNwX2hhbmRsZV90
eF9za2Ioc3RydWN0IG5ldF9kZXZpY2UNCj4gKm5ldGRldiwNCj4gwqAJc3RydWN0IG1seDVlX3By
aXYgKnByaXYgPSBuZXRkZXZfcHJpdihuZXRkZXYpOw0KPiDCoAlzdHJ1Y3QgbmV0ICpuZXQgPSBz
b2NrX25ldChza2ItPnNrKTsNCj4gwqAJY29uc3Qgc3RydWN0IGlwdjZoZHIgKmlwNjsNCj4gKwlj
b25zdCBzdHJ1Y3QgaXBoZHIgKmlwOw0KPiDCoAlzdHJ1Y3QgdGNwaGRyICp0aDsNCj4gKwlpbnQg
bGVuOw0KDQpBbGwgZm91ciBvZiB0aGVzZSBzaG91bGQgYmUgZGVjbGFyZWQgbG93ZXIgZG93biBp
biB0aGVpciByZXNwZWN0aXZlIGlmDQpicmFuY2hlcy4NCg0KPiDCoA0KPiDCoAlpZiAoIW1seDVl
X3BzcF9zZXRfc3RhdGUocHJpdiwgc2tiLCBwc3Bfc3QpKQ0KPiDCoAkJcmV0dXJuIHRydWU7DQo+
IEBAIC0xOTAsMTEgKzE5MiwxNiBAQCBib29sIG1seDVlX3BzcF9oYW5kbGVfdHhfc2tiKHN0cnVj
dCBuZXRfZGV2aWNlDQo+ICpuZXRkZXYsDQo+IMKgCQlyZXR1cm4gZmFsc2U7DQo+IMKgCX0NCj4g
wqAJaWYgKHNrYl9pc19nc28oc2tiKSkgew0KPiAtCQlpcDYgPSBpcHY2X2hkcihza2IpOw0KPiDC
oAkJdGggPSBpbm5lcl90Y3BfaGRyKHNrYik7DQo+IC0NCj4gLQkJdGgtPmNoZWNrID0gfnRjcF92
Nl9jaGVjayhza2Jfc2hpbmZvKHNrYiktPmdzb19zaXplDQo+ICsgaW5uZXJfdGNwX2hkcmxlbihz
a2IpLCAmaXA2LT5zYWRkciwNCj4gLQkJCQkJwqAgJmlwNi0+ZGFkZHIsIDApOw0KPiArCQlsZW4g
PSBza2Jfc2hpbmZvKHNrYiktPmdzb19zaXplICsNCj4gaW5uZXJfdGNwX2hkcmxlbihza2IpOw0K
PiArDQo+ICsJCWlmIChza2ItPnByb3RvY29sID09IGh0b25zKEVUSF9QX0lQKSkgew0KPiArCQkJ
aXAgPSBpcF9oZHIoc2tiKTsNCj4gKwkJCXRoLT5jaGVjayA9IH50Y3BfdjRfY2hlY2sobGVuLCBp
cC0+c2FkZHIsDQo+IGlwLT5kYWRkciwgMCk7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQlpcDYgPSBp
cHY2X2hkcihza2IpOw0KPiArCQkJdGgtPmNoZWNrID0gfnRjcF92Nl9jaGVjayhsZW4sICZpcDYt
PnNhZGRyLA0KPiAmaXA2LT5kYWRkciwgMCk7DQo+ICsJCX0NCj4gwqAJfQ0KPiDCoA0KPiDCoAly
ZXR1cm4gdHJ1ZTsNCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogNGEzZGJhNDgxODgyMDhlNGY2
NjgyMjgwMGUwNDI2ODY3ODRkMjlkMQ0KPiBjaGFuZ2UtaWQ6IDIwMjYwMTIyLWR6YWhrYS1maXgt
dHgtY3N1bS1wYXJ0aWFsLTk1MmU4ZGMyODM3NQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KDQpPdGhl
cndpc2UgTEdUTSENCg0KQ29zbWluLg0KDQo=

