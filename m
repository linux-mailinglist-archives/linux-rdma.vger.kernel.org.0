Return-Path: <linux-rdma+bounces-8198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A38A48D3B
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 01:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E5B1890DF0
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 00:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C0E2C6A3;
	Fri, 28 Feb 2025 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vy3mDget"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A59460;
	Fri, 28 Feb 2025 00:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702409; cv=fail; b=Q/wJjrAU+7XNQOiG2PAvwnfhzCArQnyJ7LZkUnM/r9fykK5KrTkGkpVz288jARfCna+kGm3gKKDarcTIWeIKa0uQWF01hJHxtq2ZeMSw7L2f95dxtf5gaFejFIALezc8fq3VQwe1dntFB9kDsLkTI/RArc90mLQmJ3uCNjcfI94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702409; c=relaxed/simple;
	bh=UJhXBDRqKue3clJjUG+NBNqL/yi9puPG2onsIo+dTuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tbl6LfmBVsnnmwUWkhLNZmzECvOf8Hvhm14m+C83zLpUBNc4cmcmdggTqblfLgi9eScjEydEJNODPNFwCgYpCsneFEznCuR942no+/QhBHzRTa325csf+xfdA0hU8tGgMget052fBl0WhJuJzMEqDeNLzUdlUwVrcXWUdJVa+bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vy3mDget; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSd6R/HTx7lGlpetZZvNKcqMFjHYJQgCZ6etKSUvkjh8NMXWkNFcg3gb4SAw4uwYlnw4OSDjj1GVnmpFuRxXYWU4SKUZhpTmneilqmqAIJOwrJepui4ENA9VMklD0TWQ+X//2pAEVEqD0Aoe0QlIKYFmVzuN5jbYe+oH6XN8MbFbX7cegyUL/HFmCP+Fq+tP3yozS+WroR98PTuhlxXkJ0JfEO56TU11ci/uAqvOdTOCFRlWgDmTo7BP0WiOi0Y/gqJbF01IwBYHmGfdU6cfstx2ZD9oHiYIsfz+Yl24Xumdx+6qMcP1MkN7cuXO25YnAk6lm+PDUe5o8dPM4hFp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swA/0qCB+HeSTiTet2Z1sahb9NsBq3Fepnkx+x7B5Rw=;
 b=j02Teksi+k/aTnYUd890KYiJ2PwwNntXgXVwHy4/dgeW2IJXYxv7aVyfSgid+UUkwAo1pRHumCEStvxjbz8aoCd7y0lckhc8NasSGT5ipl688LQ/QsIj8NB/R8Ub97gCPBJ+SEYBSLOs01Mf6YCYCvNUfXZL4yJb4q4t5QSvMYYoYHfvQGaacsfdKK48M3i8/YElgmCd1jXVjPu/B4eAkmfskVDX1JEjagMgEG2c5B9YQL3nvNu9iaxKtcMbIcn5Bu1KJuxhHIoCrLDZgCEwOILQ5+oP1SBVVN1wmrHkCZqLqzPXDcBcUl62nv+iCYAaXzcOECArICZA8TLAuQneNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swA/0qCB+HeSTiTet2Z1sahb9NsBq3Fepnkx+x7B5Rw=;
 b=Vy3mDget2yQmz2cJe6KlOUbmK8cTDdWMXdyK1OayN/RG5ivY0WCm6Ctk/BELOVY+D2hNN/aNDdP8ZP1ImAF+YdUYWqSBYstFFMUUvixi7Usat0aDqDxKjAEaHIcKNtTfSMinsNOvf7g721HDoPJ1LcAbychF+taCVs9m+nHESEdTNIkG/FYuOELZ+OIT5qZDiumgGQ2B7Zzb+til8HaH0CNchlK1h8jrj37GCnBRYpTXQ+fo5YscZbAcnStwmI5FtMx4lebRvi7gY/tpaRNaXp9Mrsk3F9kTe/XhrlmJJb5X3/OZ+j+xn7qPoCVI5IQgemjOdeY8fWVyqd3BzGUv8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.26; Fri, 28 Feb
 2025 00:26:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 00:26:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v5 6/8] fwctl: Add documentation
Date: Thu, 27 Feb 2025 20:26:34 -0400
Message-ID: <6-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
References:
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:208:15e::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 961d272e-9fee-41a1-1bd6-08dd578e90c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFdmQ20zTGhCN0FmL0tjV3JYdUZhYmN4K09ybWRPcmlYS0NZdlAvRlB1UU1U?=
 =?utf-8?B?SWpuRXVOQndXQk1BZ0VXbjBHcWREdnNpNTJMOEwzanlWYTBIQzdJeWZhUnR4?=
 =?utf-8?B?dGlvQk4xa2FCdmF2RnFPWnlhTzRaYWRCbm51R2w2TFUvdksrZEJ5SWxha1R1?=
 =?utf-8?B?bkJMYkNRVDNKdFpLY0tpa0gveGFuSVFjRVZIOWE0WEU0VkRDNHlmZFU5dXph?=
 =?utf-8?B?c0R6LzF5cWszQjRnMk1QMVdiZTBhTVJOM0tpNTZIdUlDSGJ0enJ5TUN4S2Y4?=
 =?utf-8?B?SEx3dGNYSzZNd0NaQ0NESGxSZVF5bDFWTXVDVm1ER2YvdUFoSzN2UkVSb09D?=
 =?utf-8?B?S1JJb0dTYWMwOTJmSDFsZTN2Q05LaCttUUluTEZ3ajFkQVdLM1ZvbjJjaFRt?=
 =?utf-8?B?RFZsOE1qMWpqYVphdlVZdjRCbkNsYlNiaU1FQkw0MDZydWZQK0cwQ2Qra2x0?=
 =?utf-8?B?STBhZ2tkUmlpK1Z3dHJ1RWE2TXpIdU1MQzcvTEtWT3ZJd1VTSGZQS3pEajRY?=
 =?utf-8?B?aXErbmk0bVNpN0ZOT1B2Qno3TjJXTHVyV3VEbW9lZ3VYOUxHcmpDdlZPckJB?=
 =?utf-8?B?UXNnakF1VXZ0R1ZSaTNDcDBJS1lFUEN6TUExMXB6TGp0aURERGw5cGhtVnhZ?=
 =?utf-8?B?VG9mcGRYd1VpWVpyMU9JQkxWODM2cEJYRnpSMU15RTNRZ3l1eldVTTR6ZEdz?=
 =?utf-8?B?ZzU5MkVCalhoNjAxaFFtcnpUN3hvcDl6eVI0RFVGa0lvUHRNSmNPbEdNMjNi?=
 =?utf-8?B?MW1SRFRPNWI3TmJXL2trc0RpVzJEc0l4U1MwbXJ1Tld3V1k0ZjdJdmoxOWZS?=
 =?utf-8?B?MVByMU9kd1N2SGdCbXE2Y1lBZTVqaXZPK0hzV1c1ZDVKcGVOUFpKM2NDM1hS?=
 =?utf-8?B?bFdnZWtpaVFYeDZhV05mUHVWdE9vMEloai9PeUxaUHZSSEcvRlE5UVZEbFdl?=
 =?utf-8?B?WHJtTHZCdWJ3Z2hwVGp3WEtoUXJMM0VRK3VFcEFhWWVha2xNUnpIdWpLa3Jm?=
 =?utf-8?B?aWMxMTJ3WTRTNVp3TGR5SlRJckVjRmVVOHRONEpXN244MmlNY21ia1RTaXlj?=
 =?utf-8?B?UXJuMHl2WVUrYk5VMjdDMHRRSXBlYjBBRjZ3WTZERzNMdWpVdkZwTFNkaDQ1?=
 =?utf-8?B?ZGMvTUxOdlo5TTJRWHlkV0E3aVEzdVhSMkkxc1owbks2OGNzaWxWSUk2Nzg1?=
 =?utf-8?B?T052aXJMN0JlYnFPK0U5Nm5ocjZDd2JLUHEwa1hhajVVaHFyMHExZENEZUlu?=
 =?utf-8?B?U1MzSGtOWmtERmV6YlFmRTVhcHd5bzJ1VUJoc1E5bUovWlpKdGpjNE43UDNU?=
 =?utf-8?B?ZUtscHcrTWVJemx3YStmRUFmMW1jdkgyOWE1TE5VdC9aa2gxdFZZY09JQWtB?=
 =?utf-8?B?UlFwSFVHdzFqOGRsUUt6T1pudi9MbEE1aGo5Z0UwUTdudHBweEY5Znc2QVBD?=
 =?utf-8?B?d1pTUmVaNE9PUldCQzNHeGpFUml5QTZJaWl5Mk1wUlNnUmlWMmIyaWM2UU0r?=
 =?utf-8?B?TEtoT0xhalJvVTJPQkxZV2lMUTBpaEcycVQyaWNiOHNFUzZtTDZHbE1LbUlD?=
 =?utf-8?B?aHlUVk9GYThMZ1M0U1RtQ1IvT2NCVTBLQVNxMC8vZnpWY2d2YjlmUC9jZTU4?=
 =?utf-8?B?ZXZsNUpldXp5dmtVekhMakRCVVZkdzRDd2ZBMnNjNlNoUFAyQlVpQjY2MU5l?=
 =?utf-8?B?aWhHQldXOE45L21ZR0tIS1V4WWV6TExzaWthWjUyd2xHWmlaUnRvOUxzUEVT?=
 =?utf-8?B?UWszUHZHMWVLaDhSSGlpSkxDeXY1NjF2WXRQTW8rYldhUXhWYk0vNmNuaDQ2?=
 =?utf-8?B?Y3JaVERkRTgxRTlyTkZqMERqemRUUXVpN1Y5UXJxR0VIbnc3RHp0MU1iWFpt?=
 =?utf-8?Q?OtM15SL5L59GC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE1oc3lqSno2MkRLck5RTjN3UEpTSTlJVWlXUUdqVnluc09MbmU2amlna05i?=
 =?utf-8?B?ano1L0pZYkxqWXFDTDVaN3pmZ0ljS0VCRTBjaUNvNTEzdmh6bFlvSDNpalFs?=
 =?utf-8?B?TGFHbjhFdUZlQk9QV2puNFpSdmVaVS9qUzc0VVBRY2dVcEZwK1NCbHhQVUlD?=
 =?utf-8?B?OWcwbk4wcWZRSDhFOXZWSURZZXBFSTE1UU43TVdwZXZLMDVYazJZRjZnQS8x?=
 =?utf-8?B?dHVlODhobUoyTXE0N3FEcDl5dS9IeCsxZFZnOGYyS2JhaHJDdFZKV0hJWHd3?=
 =?utf-8?B?MTYwR3oyQnlvN0NNbHNoTTNUU3FYaHZpdU8wQnVsZU5mWlprQnE0SW5IL0xU?=
 =?utf-8?B?MzhuOWdleXJRZWtPcWpoVXlyR0lteS92NzBlLzdkOTRsYlI3UWJ5d0ZHYVV1?=
 =?utf-8?B?SWkzNDJ4NjZwcGhFaUZVWndBbDFydmVYODJVR0pLWTdGSTY2RjVBdDRnZzVY?=
 =?utf-8?B?anJ1NDhzVVJBUHZ3dC84L3MxTGZ5emVmZXBWZkhJU0czbUxpV3RyOW95dzVu?=
 =?utf-8?B?bHJWdndtdzlsRU9mVFVuZENNUWdrR0svTE1BR2F6bzZNUEpKUk4vRDJ0Mm5s?=
 =?utf-8?B?a2VGL2ZIdUcyaXd1cGhXbTlGYTkxU0JQcHBXNW9rWFJOOURkUTQ3R2lYNXN5?=
 =?utf-8?B?OWN1WVB0UHR0ZHA0MWJiR2l4Wkt4RmxJam9JakkwSVd1YUZQcC9ZakFLVHNl?=
 =?utf-8?B?dlo3NzhtNjlONVQxZHdkTGpQaCtUMzZ6M0QranZjaVAweGlTN3FZOHl0TW9B?=
 =?utf-8?B?YmJqVnVWYjdueHQ5M251bzJPOCsrZCtKY3NISDl1WW9aZVo5aE9PMnNReDVK?=
 =?utf-8?B?SlJmMnBWTVdXaVE5RjBvS0MwU1p6OVFyS2RWSzRRVTVkMHZjM00zdDVDRjA3?=
 =?utf-8?B?QmlEdndNcm9VcE8rdVhKQjVtRURSTnJNQ3hsNUEzSnJ2YWFLNnJQR2MxdHo0?=
 =?utf-8?B?OXdOcU5VVXZUZjFCcUV4TEZBYWZsQlRsTXpHVUxBRW5ZSkhyemU0UlpBOG9w?=
 =?utf-8?B?YmxMdnZSWC9OYzRwaTB3am1VaEw2NnRzSE01cGlVZXVjUFNzb2VnRHZkR2Z4?=
 =?utf-8?B?bllMQktkNWtoR1lIR1RCZzdtNHB6aTcyVno0aExBT1lYbHdOMEtpNjNqTjVn?=
 =?utf-8?B?cEQ2RkYxMmNzZ2RIMmdKOEJ0Y3dLa281OEVJblFZajBQbjQ2aGJQVzZqVVdB?=
 =?utf-8?B?QjhnQ1lZdzlNSldHQkhwK01ncU5wd2ZVb3dycjBWS0NpR2NBdE0rNEVsWE03?=
 =?utf-8?B?VGgrTjBsODJ0a0Z3V0tRMHIxRURSa0RETVN4UHpkaUptdVROY3pMbUFOWHhu?=
 =?utf-8?B?aUNSdmxIazVVM1A3S0tiNkFnaDJ1ckgybld3ZHFxaFBHV0dZdS92RjNVNGx3?=
 =?utf-8?B?SEJxTjZrZ2JzNTdGZm1LREJqTjQwY1hQWDBmSjJYVlViaGFWNWtTck9ZSUJL?=
 =?utf-8?B?dW01eE9zL0FRZlU4T3pGbWtMREpDR3pvU3B5OHNnVlNxRWFOcE95Yll1dzBk?=
 =?utf-8?B?SEVCc01mSVhaT2VBUGtsb1JtQzI5K0xRTG5mUHNDcWEwLy9kSjZRSVdpdHVG?=
 =?utf-8?B?Q25KeVF6dHlzWnpVV3dNNTRra0w0UGFhUnR6YTJ2bll2cTF3TFVOUUdGUFYz?=
 =?utf-8?B?UHBUQjFKaVhQaTNBSkVHWXRtZUREMUdGazV2THN5bGVoTGh6ZXdyRndWM0pI?=
 =?utf-8?B?YWM2QnY4allTVEVZekw4WkhHaEw0aEZOdnJXSFdTMFh3UGlneXZFcDFJT256?=
 =?utf-8?B?RkRzYVlSQmxBSmNjNDUya3NWOElUanBSZzJHUFZnVzVTSEN0elRwRDdIQ285?=
 =?utf-8?B?WVduYVF0ZEhQRzF2SHdVSU1DTnlaS0lRK01lVEFib1B4a1Y1c0dlQzc4a2dw?=
 =?utf-8?B?cStxUnNRUXBieVdPU0xLVFZ5azMwMXhpNEV3M3IzenRodEpkWktCN2ptYTFP?=
 =?utf-8?B?cUtpemRzWVMzREFERDZpTkNPMkRjbU1oc0FMa3Z5cHRRY0lmRnVJS1hSYTJQ?=
 =?utf-8?B?ZnJpUWxERVlZZmdIQU1iS1VBNkNGS1R0aU9DcjA3QzE3eDRxVDRKRHE2bm1j?=
 =?utf-8?B?ODdpTndPcGs5L0hBejNSL2xoUzRrMXcrOVZBZUk1UG0waHZMeTJWSWlIN3Nq?=
 =?utf-8?Q?hn9yjBrde2T7lcE5iThhmbkbB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961d272e-9fee-41a1-1bd6-08dd578e90c0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 00:26:38.5704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1t93RsQFLa7YOz0wxJZv/WctBboLqs7ZCKP5+kl0XdRhgbCh8maLS9LJcc/Q8Dg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529

Document the purpose and rules for the fwctl subsystem.

Link in kdocs to the doc tree.

Nacked-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20240603114250.5325279c@kernel.org
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/userspace-api/fwctl/fwctl.rst | 284 ++++++++++++++++++++
 Documentation/userspace-api/fwctl/index.rst |  12 +
 Documentation/userspace-api/index.rst       |   1 +
 MAINTAINERS                                 |   1 +
 4 files changed, 298 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl/fwctl.rst
 create mode 100644 Documentation/userspace-api/fwctl/index.rst

diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
new file mode 100644
index 00000000000000..8c586a8f677d5b
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/fwctl.rst
@@ -0,0 +1,284 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+fwctl subsystem
+===============
+
+:Author: Jason Gunthorpe
+
+Overview
+========
+
+Modern devices contain extensive amounts of FW, and in many cases, are largely
+software-defined pieces of hardware. The evolution of this approach is largely a
+reaction to Moore's Law where a chip tape out is now highly expensive, and the
+chip design is extremely large. Replacing fixed HW logic with a flexible and
+tightly coupled FW/HW combination is an effective risk mitigation against chip
+respin. Problems in the HW design can be counteracted in device FW. This is
+especially true for devices which present a stable and backwards compatible
+interface to the operating system driver (such as NVMe).
+
+The FW layer in devices has grown to incredible size and devices frequently
+integrate clusters of fast processors to run it. For example, mlx5 devices have
+over 30MB of FW code, and big configurations operate with over 1GB of FW managed
+runtime state.
+
+The availability of such a flexible layer has created quite a variety in the
+industry where single pieces of silicon are now configurable software-defined
+devices and can operate in substantially different ways depending on the need.
+Further, we often see cases where specific sites wish to operate devices in ways
+that are highly specialized and require applications that have been tailored to
+their unique configuration.
+
+Further, devices have become multi-functional and integrated to the point they
+no longer fit neatly into the kernel's division of subsystems. Modern
+multi-functional devices have drivers, such as bnxt/ice/mlx5/pds, that span many
+subsystems while sharing the underlying hardware using the auxiliary device
+system.
+
+All together this creates a challenge for the operating system, where devices
+have an expansive FW environment that needs robust device-specific debugging
+support, and FW-driven functionality that is not well suited to “generic”
+interfaces. fwctl seeks to allow access to the full device functionality from
+user space in the areas of debuggability, management, and first-boot/nth-boot
+provisioning.
+
+fwctl is aimed at the common device design pattern where the OS and FW
+communicate via an RPC message layer constructed with a queue or mailbox scheme.
+In this case the driver will typically have some layer to deliver RPC messages
+and collect RPC responses from device FW. The in-kernel subsystem drivers that
+operate the device for its primary purposes will use these RPCs to build their
+drivers, but devices also usually have a set of ancillary RPCs that don't really
+fit into any specific subsystem. For example, a HW RAID controller is primarily
+operated by the block layer but also comes with a set of RPCs to administer the
+construction of drives within the HW RAID.
+
+In the past when devices were more single function, individual subsystems would
+grow different approaches to solving some of these common problems. For instance
+monitoring device health, manipulating its FLASH, debugging the FW,
+provisioning, all have various unique interfaces across the kernel.
+
+fwctl's purpose is to define a common set of limited rules, described below,
+that allow user space to securely construct and execute RPCs inside device FW.
+The rules serve as an agreement between the operating system and FW on how to
+correctly design the RPC interface. As a uAPI the subsystem provides a thin
+layer of discovery and a generic uAPI to deliver the RPCs and collect the
+response. It supports a system of user space libraries and tools which will
+use this interface to control the device using the device native protocols.
+
+Scope of Action
+---------------
+
+fwctl drivers are strictly restricted to being a way to operate the device FW.
+It is not an avenue to access random kernel internals, or other operating system
+SW states.
+
+fwctl instances must operate on a well-defined device function, and the device
+should have a well-defined security model for what scope within the physical
+device the function is permitted to access. For instance, the most complex PCIe
+device today may broadly have several function-level scopes:
+
+ 1. A privileged function with full access to the on-device global state and
+    configuration
+
+ 2. Multiple hypervisor functions with control over itself and child functions
+    used with VMs
+
+ 3. Multiple VM functions tightly scoped within the VM
+
+The device may create a logical parent/child relationship between these scopes.
+For instance a child VM's FW may be within the scope of the hypervisor FW. It is
+quite common in the VFIO world that the hypervisor environment has a complex
+provisioning/profiling/configuration responsibility for the function VFIO
+assigns to the VM.
+
+Further, within the function, devices often have RPC commands that fall within
+some general scopes of action (see enum fwctl_rpc_scope):
+
+ 1. Access to function & child configuration, FLASH, etc. that becomes live at a
+    function reset. Access to function & child runtime configuration that is
+    transparent or non-disruptive to any driver or VM.
+
+ 2. Read-only access to function debug information that may report on FW objects
+    in the function & child, including FW objects owned by other kernel
+    subsystems.
+
+ 3. Write access to function & child debug information strictly compatible with
+    the principles of kernel lockdown and kernel integrity protection. Triggers
+    a kernel Taint.
+
+ 4. Full debug device access. Triggers a kernel Taint, requires CAP_SYS_RAWIO.
+
+User space will provide a scope label on each RPC and the kernel must enforce the
+above CAPs and taints based on that scope. A combination of kernel and FW can
+enforce that RPCs are placed in the correct scope by user space.
+
+Denied behavior
+---------------
+
+There are many things this interface must not allow user space to do (without a
+Taint or CAP), broadly derived from the principles of kernel lockdown. Some
+examples:
+
+ 1. DMA to/from arbitrary memory, hang the system, compromise FW integrity with
+    untrusted code, or otherwise compromise device or system security and
+    integrity.
+
+ 2. Provide an abnormal “back door” to kernel drivers. No manipulation of kernel
+    objects owned by kernel drivers.
+
+ 3. Directly configure or otherwise control kernel drivers. A subsystem kernel
+    driver can react to the device configuration at function reset/driver load
+    time, but otherwise must not be coupled to fwctl.
+
+ 4. Operate the HW in a way that overlaps with the core purpose of another
+    primary kernel subsystem, such as read/write to LBAs, send/receive of
+    network packets, or operate an accelerator's data plane.
+
+fwctl is not a replacement for device direct access subsystems like uacce or
+VFIO.
+
+Operations exposed through fwctl's non-taining interfaces should be fully
+sharable with other users of the device. For instance exposing a RPC through
+fwctl should never prevent a kernel subsystem from also concurrently using that
+same RPC or hardware unit down the road. In such cases fwctl will be less
+important than proper kernel subsystems that eventually emerge. Mistakes in this
+area resulting in clashes will be resolved in favour of a kernel implementation.
+
+fwctl User API
+==============
+
+.. kernel-doc:: include/uapi/fwctl/fwctl.h
+
+sysfs Class
+-----------
+
+fwctl has a sysfs class (/sys/class/fwctl/fwctlNN/) and character devices
+(/dev/fwctl/fwctlNN) with a simple numbered scheme. The character device
+operates the iotcl uAPI described above.
+
+fwctl devices can be related to driver components in other subsystems through
+sysfs::
+
+    $ ls /sys/class/fwctl/fwctl0/device/infiniband/
+    ibp0s10f0
+
+    $ ls /sys/class/infiniband/ibp0s10f0/device/fwctl/
+    fwctl0/
+
+    $ ls /sys/devices/pci0000:00/0000:00:0a.0/fwctl/fwctl0
+    dev  device  power  subsystem  uevent
+
+User space Community
+--------------------
+
+Drawing inspiration from nvme-cli, participating in the kernel side must come
+with a user space in a common TBD git tree, at a minimum to usefully operate the
+kernel driver. Providing such an implementation is a pre-condition to merging a
+kernel driver.
+
+The goal is to build user space community around some of the shared problems
+we all have, and ideally develop some common user space programs with some
+starting themes of:
+
+ - Device in-field debugging
+
+ - HW provisioning
+
+ - VFIO child device profiling before VM boot
+
+ - Confidential Compute topics (attestation, secure provisioning)
+
+that stretch across all subsystems in the kernel. fwupd is a great example of
+how an excellent user space experience can emerge out of kernel-side diversity.
+
+fwctl Kernel API
+================
+
+.. kernel-doc:: drivers/fwctl/main.c
+   :export:
+.. kernel-doc:: include/linux/fwctl.h
+
+fwctl Driver design
+-------------------
+
+In many cases a fwctl driver is going to be part of a larger cross-subsystem
+device possibly using the auxiliary_device mechanism. In that case several
+subsystems are going to be sharing the same device and FW interface layer so the
+device design must already provide for isolation and cooperation between kernel
+subsystems. fwctl should fit into that same model.
+
+Part of the driver should include a description of how its scope restrictions
+and security model work. The driver and FW together must ensure that RPCs
+provided by user space are mapped to the appropriate scope. If the validation is
+done in the driver then the validation can read a 'command effects' report from
+the device, or hardwire the enforcement. If the validation is done in the FW,
+then the driver should pass the fwctl_rpc_scope to the FW along with the command.
+
+The driver and FW must cooperate to ensure that either fwctl cannot allocate
+any FW resources, or any resources it does allocate are freed on FD closure.  A
+driver primarily constructed around FW RPCs may find that its core PCI function
+and RPC layer belongs under fwctl with auxiliary devices connecting to other
+subsystems.
+
+Each device type must be mindful of Linux's philosophy for stable ABI. The FW
+RPC interface does not have to meet a strictly stable ABI, but it does need to
+meet an expectation that userspace tools that are deployed and in significant
+use don't needlessly break. FW upgrade and kernel upgrade should keep widely
+deployed tooling working.
+
+Development and debugging focused RPCs under more permissive scopes can have
+less stabilitiy if the tools using them are only run under exceptional
+circumstances and not for every day use of the device. Debugging tools may even
+require exact version matching as they may require something similar to DWARF
+debug information from the FW binary.
+
+Security Response
+=================
+
+The kernel remains the gatekeeper for this interface. If violations of the
+scopes, security or isolation principles are found, we have options to let
+devices fix them with a FW update, push a kernel patch to parse and block RPC
+commands or push a kernel patch to block entire firmware versions/devices.
+
+While the kernel can always directly parse and restrict RPCs, it is expected
+that the existing kernel pattern of allowing drivers to delegate validation to
+FW to be a useful design.
+
+Existing Similar Examples
+=========================
+
+The approach described in this document is not a new idea. Direct, or near
+direct device access has been offered by the kernel in different areas for
+decades. With more devices wanting to follow this design pattern it is becoming
+clear that it is not entirely well understood and, more importantly, the
+security considerations are not well defined or agreed upon.
+
+Some examples:
+
+ - HW RAID controllers. This includes RPCs to do things like compose drives into
+   a RAID volume, configure RAID parameters, monitor the HW and more.
+
+ - Baseboard managers. RPCs for configuring settings in the device and more
+
+ - NVMe vendor command capsules. nvme-cli provides access to some monitoring
+   functions that different products have defined, but more exist.
+
+ - CXL also has a NVMe-like vendor command system.
+
+ - DRM allows user space drivers to send commands to the device via kernel
+   mediation
+
+ - RDMA allows user space drivers to directly push commands to the device
+   without kernel involvement
+
+ - Various “raw” APIs, raw HID (SDL2), raw USB, NVMe Generic Interface, etc.
+
+The first 4 are examples of areas that fwctl intends to cover. The latter three
+are examples of denied behavior as they fully overlap with the primary purpose
+of a kernel subsystem.
+
+Some key lessons learned from these past efforts are the importance of having a
+common user space project to use as a pre-condition for obtaining a kernel
+driver. Developing good community around useful software in user space is key to
+getting companies to fund participation to enable their products.
diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
new file mode 100644
index 00000000000000..06959fbf154743
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Firmware Control (FWCTL) Userspace API
+======================================
+
+A framework that define a common set of limited rules that allows user space
+to securely construct and execute RPCs inside device firmware.
+
+.. toctree::
+   :maxdepth: 1
+
+   fwctl
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b1395d94b3fd0a..e8e861f767fd5c 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -45,6 +45,7 @@ Devices and I/O
 
    accelerators/ocxl
    dma-buf-alloc-exchange
+   fwctl/index
    gpio/index
    iommufd
    media/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 1bc1f97934b6b8..319169f7cb7e1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9561,6 +9561,7 @@ FWCTL SUBSYSTEM
 M:	Jason Gunthorpe <jgg@nvidia.com>
 M:	Saeed Mahameed <saeedm@nvidia.com>
 S:	Maintained
+F:	Documentation/userspace-api/fwctl/
 F:	drivers/fwctl/
 F:	include/linux/fwctl.h
 F:	include/uapi/fwctl/
-- 
2.43.0


