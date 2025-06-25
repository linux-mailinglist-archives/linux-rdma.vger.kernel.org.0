Return-Path: <linux-rdma+bounces-11629-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A5EAE8500
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 15:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F68F16BC3A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631FE261595;
	Wed, 25 Jun 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kZV3IlQC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567617BA5;
	Wed, 25 Jun 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858903; cv=fail; b=CAsJSQLAfJbo/iRhYFzBEOhnaAxxlWsp/7A1/1ErNhTI+H1JFLSnkXw0P+dehIU1NFRi88tnRWvG+lgfNKqIBX1nOHT6y/7rBVB3nMVUbzV7ONfURrYSzXDEEQ8Nt9pw79xd76l3Cs1pzx8lvK9yowY3/gzseF2+KRJeULQxtTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858903; c=relaxed/simple;
	bh=uZtb7qOwYvhl1t9RDKFz/2jkWQ68uHKJUIBLhMj6sDM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r2I4feVxUkfgKGggdps5SnLadbhiaz/sOsXMkd3pTpEt0KveBQsHt9fntsZz2ck8t3fNo+FI5p7IVMuBhsVBEIbMqgkFvISNwMQ5Iq3P0RUhzAjwt0d/dJkL0se+KRxTRTTwXS0XcOS5OogQ6Zjut6H9cbK3nUd+YhJjU2dAyHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kZV3IlQC; arc=fail smtp.client-ip=40.107.100.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwLMU7IkJifx9b8fT3RDGMxBUiYgvmWjVW+sgVJIqleJvzhMwUIw5BefhOnLqh0ApSjD2ShrdKicQTSlAMIlR0BOWjePvYqccKwlwx0xSOvsXdkHyXqrdf5096sKRclfMtZ0k//O+wC29Y9wN88eLwADfxNWH3SRQs1L3aLPD5TOJhfd0J1tPKRKZCVZb0ElgeSH16RVSsZL3VT/RNQzuHX1QXU+rbnopx4d0k1cbSwyKbbsDmJsAzZ1IR0IQdvw1zYtcLCbZPjXS5x0AoBz3QiDIqphCzW7jt/ZV58zBWhYP3DAkybwglZXHbqA2I19J/m1AxVODuCmlFsC4F00Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1rwB/HTz321531XLy7wJFkhOKo7mw7yPzYrkgZmGk0=;
 b=wLGd97VVUmPMJoMGRbmfo0Ssyeci9WKVqC19O7LEr531eXkBko61Oiix3Jdo36DL1Jw8/PY4okRYjP9In1D7OuOb5jpbfng4KMJjZ3x2AgwISJgvcTFkl77gPm2wST/N0L5UFr/tn7cDg+5T2MBmeatKhneEENGxDWFmSiqHKTcNGOL2lJS/QWD78H6TkItqMx7iYY6Sro1VlcqpHXQ8JZ8iGZWwxK/a7jcsiNhyh4N2ukkWdTVApzWqXihXF1SkR4XelJ3fmqvw2R7MrsrQgII7q0j/SsN06GMe/Dagr2E5yyfGtfAqRLJQffalA8uwHayB3Y9sVgrfFPBpvapjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1rwB/HTz321531XLy7wJFkhOKo7mw7yPzYrkgZmGk0=;
 b=kZV3IlQCnlgGC6tHyJMV5/c/DN0ZYsvhXbbohs9pH1u6T8kaZnQ53J1lJAnmQPm3KjLrIJHyhvOBwp9WeuzUC5sQDuBQPMhUU5Z67+JsabiC5H/ek0T74WURxtjxw8lPH1ymd7ZYJ7slY0ljFh+Ozm3ol4HX2Y9+QeLyJ9qDWGZQZMyY67u3pE9UL/cR5/PmfWN142lrL5r1V8K2veB/m8jEB6CnQnk03qo0mJEG9Lq6ixIp/6LPSesxxZ3oYwjifU7b8I/ICME2R4RRuruaSKtLTTyZBGFy+EnWTjmLIjARwrvDhcfwDKxE8CSp/9fLvPT4uSFPl1fQBGEkdos+KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by LV9PR12MB9781.namprd12.prod.outlook.com (2603:10b6:408:2f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 13:41:38 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 13:41:38 +0000
Message-ID: <2eeb79cb-eb2e-4d0a-a05e-32f940434d95@nvidia.com>
Date: Wed, 25 Jun 2025 16:41:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/8] net/mlx5: HWS, Refactor and export rule
 skip logic
To: Simon Horman <horms@kernel.org>
Cc: Mark Bloch <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, moshe@nvidia.com,
 Vlad Dogaru <vdogaru@nvidia.com>
References: <20250622172226.4174-1-mbloch@nvidia.com>
 <20250622172226.4174-4-mbloch@nvidia.com>
 <20250624183832.GF1562@horms.kernel.org>
 <dff4ea02-4adc-4044-a18a-ee884abc0053@nvidia.com>
 <20250625094524.GN1562@horms.kernel.org>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <20250625094524.GN1562@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To IA0PR12MB7722.namprd12.prod.outlook.com
 (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|LV9PR12MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: f994be40-5134-4349-b3b6-08ddb3ee02b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y04yUXY3elVBVENyOERRQmhyUmh4cldXQVpZNFBPQi9IOWo5SXo3WUFrRjUy?=
 =?utf-8?B?RVQ5eEZqNmZiY3h5Q1U0NndmU2pneExmZzlleGoyd2M3cHZwa2M3cjd6bUF4?=
 =?utf-8?B?UTIrUk11TWxvRS9IT092SWxJd0pGYnRqc2UraHg3T1B2TnJhQVA5RlRHM3R3?=
 =?utf-8?B?MDIvLytITTRkVXZPUzV6REM1OXlZRGVLbmNGeG15ajlYcFRiZklQamZpM3VE?=
 =?utf-8?B?WmJFZnVISG1tQm9SQjZhS3cvVE92eUh2VENsemRTSDkwZ01WR1NMQkdScmxN?=
 =?utf-8?B?dVppRzh6bVVWUjcwWjNyRGxWTnQ3UFphTTIrWm5OOVJ4OGJ0L09FYmRrYmxa?=
 =?utf-8?B?Y2pwM2ZmUTdoZVA0UFE3WGdwN2hVQWJQckpOOGtVOWxDTnBoUGdxWUR3bkJB?=
 =?utf-8?B?N0ZsWmVNZmdvdHBrSDJ0SWF4cDQ4WHl3TU5Bc09tR2hEWkUxY2dyWmEyY2Fm?=
 =?utf-8?B?YzJib0pGQitOUjV3QnJ5MVYrZ0QyK0h1bVk4bmgyRG5GOS9QRjB0ckxPQUM5?=
 =?utf-8?B?Z3N3aHJuNU5qYWw4Q216VURmYzZNVzU1cGVNSG5GRnhnL0tqcVRPYksreVEy?=
 =?utf-8?B?aFE4YXBnUGVETzJYM29BWE55dWZxblc1cGNlMXBKMGNEZU55NzlQNGpuREtp?=
 =?utf-8?B?RmZUVjBjVzYrVXZSNndjRjJBVkZFbnBjWE1qWVhiMWNvdWlpU3lvRW94K2t3?=
 =?utf-8?B?akdHK2JTamVSMVBGMlcxdHVCcitiQ0U1VmU0NHgwYXgwVGtwS1c3U2lpNVRl?=
 =?utf-8?B?Nk9DR1JIblRDL1V5b2FJSFg3RjhZcWdQMEVtWlV4eHpOUlJzcHFNdE9KeXRC?=
 =?utf-8?B?WTRKL2F2WUdFQnkzQlU4b2UwVnZZbjVPQ3UwR2w3emh0T3BwK3UyWTRBSVZC?=
 =?utf-8?B?Y1RWclBhaFpHdENENVBBWCtQdnMxVUlSUHNIWWpYN0ZPUGtQN2V3VFErbXlk?=
 =?utf-8?B?allGUlZ6dFpHVHh2RzlUMUQ3YnJBZlJZckxQWDkvYXNWdFU4cm5telJKN1Jk?=
 =?utf-8?B?cG94TXZ6UXludTF4SDloWTZpR2cxZjlrUERzSFZSeFNzS0VNSG1rbElqMFhz?=
 =?utf-8?B?TWJkVnRrSnp5eU5HdGZNQkNyMUpiWUFzQm1venNoVUZ4cEs2TE5oYmtIcXl5?=
 =?utf-8?B?d09JdnZYTDFOYzVhRmNzSGd0dUhzM0pyZjBHL1ZOajNiZE8wR0FCcFRKL1Yw?=
 =?utf-8?B?anhqRVBGRjB2QWxPUGd4ZnpoTVRKTHFzYmJSbEpYd1d4K3J0RnJvRnhXVVRs?=
 =?utf-8?B?ZjZkaTBWT2s1ZytaUTdaa3ZkL0M5ME9acjd6N2kwRHpBN0lqQ1FxWXpXeFl0?=
 =?utf-8?B?ejY2OUl0Sk1kY3c5UkwyRmkvYmwvV1M1OGFPRlFLL3VVWmdjVncrMmtjV0tX?=
 =?utf-8?B?cE9FdDQreGkyVnBmQUl3T2lWbzl1UmU2OHFlcG1oSlJITDNHekZCRE9vZHJI?=
 =?utf-8?B?MTRNR0JPazhEcmZZY29kUElBTzIyY0RJNVQ2QUFOTG9vYVBUaW5aWjhSUFZq?=
 =?utf-8?B?SFRhSXpybU1leFVRZEdsR1d6bVJ3WXVhdmJTZGVIMVNYWnRBZmszM2svT2JH?=
 =?utf-8?B?NmhkdHkvZG5IM3JjL3BwWTBEQmpBMUwyMnZIZ29aTkNDbjY0OTBpTTBGdGpF?=
 =?utf-8?B?bTluMGVGeGFDdkc5YnJyeWdjWnUzV29kYSttWmlwbXE5bFN2UGdtM3ZZTTRs?=
 =?utf-8?B?MGdkcnhVckc3bzlPa0ROL0tQc1hNT3RpKy8xV2ErWjhqVkVFUnh1WHNZbXVB?=
 =?utf-8?B?bmZuZmp6KzNvdUxEY3hxOHFXQjAyWkNQR3NQb2NQZFZvUjRwOEtHeDd6MXNB?=
 =?utf-8?B?Q0xHbm1KMVlieG4wNGtLOVNsNXFhTlV5NXdWeFZYNDg0eEhMVW1LcGlxWWNI?=
 =?utf-8?B?VzU3OS95UHJpUnhSSGlwdWlNSGJSVmozMFVQbjNEdFlRZDdSOGRHckhjVEFo?=
 =?utf-8?Q?QA2bbTDRlfk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUVvN3pMS3daWW9BeGI1QUYyR2F6MW9BbTRtYWFNeTJkR1VEa2FPL28wR3hy?=
 =?utf-8?B?QTI1eTBvYkhDdzU5TWVZdFd4L0JRdWlxVzh5YndITFlMQ0dudVZRZjA5Q2dV?=
 =?utf-8?B?ZHNPUmZhVmQrd3p1MDRnUTQvcEgzWHlVTUlCWkI3bEtZRHNpWnJDbXZqMlNq?=
 =?utf-8?B?ek1iRkROS0VIN050M214MWdnTTMyc3EzTkpVZlB2MjMwS3RidlhXNDVkZHpL?=
 =?utf-8?B?cnU3Zk9lUk9yb0pQUXl2dVEveXRSYmtNS1YyNWhFNkRrRkdDUSsyaVJya0xj?=
 =?utf-8?B?anlkUDdHZ0FTTWNmUmk3dDloS3UwVmt4ZFJyYnpZZEhDR3ZvOEIwazZhMFZq?=
 =?utf-8?B?ZXZDcUx5VUJ6YTY0SG8rYm81YzVxK09yYWNlaGpPaE5KRnFuTHk1Sk1GQ3VF?=
 =?utf-8?B?ZjcyaTl3WWhOakRUMWZpUjV0K2RWTnVYMDNaOENqdUJDSk45RjRMdzRHZ3px?=
 =?utf-8?B?WU9oWkU4ZTN6MGxYajlZa2ZKNVlVMUdiZDVObWlOU3kwL0Y2RFFnd2NxQi95?=
 =?utf-8?B?TVlBbTdWTGtFYnR6QSsybjZ2Z3RRRDFuMDhlS3lDMmlaSnpCUTdRZHU2SDFa?=
 =?utf-8?B?V0R4azlSM0ZRdnpvdlFFV3JYcitZVWN6UWJoUjErSmp6Mk5YMFU0a3R0NGNX?=
 =?utf-8?B?djZobis0cS9zVW1QakhBaTdOZ3Jza09QNGliUXQ4YXJGNlpaQ3BwMmNla3Ru?=
 =?utf-8?B?bzVDb0praTZDWTFTSkQzZzZDR0cxSnQ0L0xFSzduc1hodHV1MXBPK2hJTVRw?=
 =?utf-8?B?cFdFR0NvODl5TEJid1BlM0ZvRGpLTkRzME9sZHRhYWlZWitLbU5pZzloekZW?=
 =?utf-8?B?cGtHNUdQTGtJK3dYUXRGbFBzR1o5ZzNXNDNudjR0Ykx4emhMNk1jdmJOZ3Jk?=
 =?utf-8?B?bkhQRk5vdEtYTHNaM1lNTWZpNGQveUZmcWhNSXFkcy9zVEZIMTduY2hqUjQ1?=
 =?utf-8?B?Vk9LUC9sTW1zQy9NbE1BSFRqVmlRMkZheXNTK2lZYU1WSzZyYjZQNndnZnlG?=
 =?utf-8?B?QnNDb3lrT0hXUExMbFE5VzlVUlNQaXQ1ZitWaHJ6emNqRXd4bm9wNkkvU3pp?=
 =?utf-8?B?Ny8ramlCcVVTbXVoNTVTMVo3bVAxUEVCamc3SDdnUXRlUGNmSVdpdVFyeUln?=
 =?utf-8?B?R2QrVHdxL0wxUS9CWEdvMFJheXh5WFZ4T29nUlliWGkwcHgxekJKYjNZTEk3?=
 =?utf-8?B?Rm9yZmZ0TXM0ZUtHa254WjR5MzBGK2FPSllQUEJYT2hOT1VFRzdFbjhEcUVY?=
 =?utf-8?B?MkR5UDZaYzJtVmt4Tlkwc0JmQjdZSGt1bFphSnFSMHcwRzBHOHRJd2Jpc2w3?=
 =?utf-8?B?bWI2REFOemJlVU5qci9IaVBNUXBpWWd1U1ZZUnV2QW8wWWsyVDM4VzhQRjJr?=
 =?utf-8?B?cW5wMWN5S2N5alllZit2NTd0MmNTNzBDRWNKVjR3OEp1UkErMVcyNUQrZ25t?=
 =?utf-8?B?NmFiWEZ5WkxXTUt4cHFpUWZyYzREWmx4azBUaVFock5hU09VY2dVL1o3VUl4?=
 =?utf-8?B?b3RIZDJMNDJvNnVWYmNZbFRIdG1HdnFpRnZCVGQ3R1FmQUtia2Q2aG1nYUxW?=
 =?utf-8?B?ekV0dTZWcTJtblFMSHM2MlRyR1BkOUFldWhJZU90YWpwMk12NmlMdEI2QU1O?=
 =?utf-8?B?dHE4RGJqMEZoSXpyd3ZFc2pVc2tMcE1UY2ZCYlhlUFNoTkM5bzNUbGFSUXU2?=
 =?utf-8?B?NENQZXYyeTFUSU1kZDhremgxaHQ0WklSNTNmdnFlZUNLNTc2cUR5dnBXNDB3?=
 =?utf-8?B?K3JmSGtMc2w0N3NZTjljVmQwc3VHSjlGTW03enE0bDZLbUs2b3ZnTGpLdVI2?=
 =?utf-8?B?d0xWWjN4QmJsQWVzR3AreUpROWp2NWJ6YzBWWTEyM3JmbFJKU3RQYWIyRDlu?=
 =?utf-8?B?SlJkKzVJandlc2ZFRWczTUlxWmFhMWVHUXZ6eHBXZVYvZ3YwbkxSMEdpT0NV?=
 =?utf-8?B?c3NxNXVrV0E3UllLM0lOV0dUYUhGWFZhemlMb1puS21QeVQwVWxtOHpKR2hj?=
 =?utf-8?B?Y0ZRd01mUnNPVGNmcUgvbWtPN0Y3aTRZOUprOG9LTjRiNm5Ub0hnb0daSXov?=
 =?utf-8?B?WWpMaENQQ1d1a2RtMFRGK3Y3eEh3bGR1c29CWTN1OFA4VDhzYnp4dk9NZThI?=
 =?utf-8?Q?sR0XNup41PrHEd5UzOu+efGha?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f994be40-5134-4349-b3b6-08ddb3ee02b1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 13:41:38.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEuEQ/8v8aNLpBxWGEvzHnz+CR4THsUWRZLV/4QJtjiHAmx6Fn8Zfm+oVN+tjZHHy2Q1Tdv65sNQC7TmKJ6ZSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9781

On 25-Jun-25 12:45, Simon Horman wrote:
> On Wed, Jun 25, 2025 at 03:35:52AM +0300, Yevgeny Kliteynik wrote:
>> Hi Simon,
>> Thanks for reviewing the patches!
>>
>> On 24-Jun-25 21:38, Simon Horman wrote:
>>> On Sun, Jun 22, 2025 at 08:22:21PM +0300, Mark Bloch wrote:
>>>> From: Vlad Dogaru <vdogaru@nvidia.com>
>>>>
>>>> The bwc layer will use `mlx5hws_rule_skip` to keep track of numbers of
>>>> RX and TX rules individually, so export this function for future usage.
>>>>
>>>> While we're in there, reduce nesting by adding a couple of early return
>>>> statements.
>>>
>>> I'm all for reducing nesting. But this patch has two distinct changes.
>>> Please consider splitting it into two patches.
>>
>> Not sure I'd send the refactor thing alone - it isn't worth the effort
>> IMHO... But since I'm already in here - sure, will sent it in a separate
>> patch.
> 
> FWIIW, I think the refactor is fine in the context of this patchset.
> But I do feel that it being a separate patch within the patchset is best.

Ack, thanks

