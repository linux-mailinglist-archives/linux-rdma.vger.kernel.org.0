Return-Path: <linux-rdma+bounces-14806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC187C8E9E9
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 14:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C41A351B7C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29C3321A3;
	Thu, 27 Nov 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CdunPEZX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A230330326;
	Thu, 27 Nov 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251641; cv=fail; b=elVhzneHRoovPnfiRZP3srnzVz8HrFA3chdVZ0X+H7QWBBN5U+p64SaIYTEeFwcaASsbqbmrB9b3e4QMXh+N+AvGOOFai0GsV0SdUG1C+S792c/THGsZA1VhVraw60BAeGb/oIlgvokln7gZnkiyo1Z6ivRoF083YNCa1iYXvSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251641; c=relaxed/simple;
	bh=GmCHFuBIDaWCzR8cV4TPzeunm195xsZ+PUmZIVtq5to=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fKN3TQFLsokcKWUfSk1lKnGjWJ+xDcj7lWZrgrE0CDxstynZCAD+7sxg6HhnctnLrdRE+chmwWY34m9HOm8mWyyUq76PiU/tbRw9Pg6IAxd21RUVcf2oy/Blbgf/D39loCgZcXJZVhZcrmMa4pwBnWICGElyc76ueEm5ALY5OnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CdunPEZX; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5mse7uk0HnLFbcFZE35oEnQLTCJf+0jYErCPfHeIcN6z6wXVhtlYXQStkBX7mvpmXLT/MPdWSdckUjNfOhzRJK/tFwdiF90lD0F3U2bXZaGfSDKHwWFvTBFGLXhGo6tIM10T8YzBfzlhrEbxaFyUEsO5E9JZGjxXPbWuDX3GbhCoNESB60fW+ninAah8clpHLFG5u5lHZeOGB/rKMfcEebkN6tpUsDwDb/R4O40v+dJzkyzGX91cNI7k4dPWX40qXASZ3jmHMfuPE+4e4HDGbDf+DmTmxK6Wq8qknq50aQFJNUUbg50c54OZtdztS93pbPZiN5ASFGt2rrwJbMENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjDuNW+SWQBo69qn9RqULux5CMu/FGqM3GY+xMfkKJU=;
 b=k35kFsrad3Bib2ntf+7H4YCxJ7hxttwH6PKJhyceShTN7YVsDPhSWAlmTqi3pVjHcolOeVaJFY5n9EiJdBO6nr9baS54TgmSpKhVgirT+ub47lLIoR1zIyuIrfpcm5ZvI+xipRr2Qz1qsZ3uJXl4ENufEdzziykk0KMoOZgwtFMcgm9TLX7yhUcBQsrgdjfg9f6f0o+YAwJu8oHqDcc9LZunE2fYxnpIkFgAwNXDHm24o92hEIEiOuG1b7T4XnVjOZNaEOVisaNI8CdkIEQVlPfx+xO4xLf3VZfgesCQXSUsNzhPpM23vl9zVO42VZF/8846AMYuev63rw+CSwCO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjDuNW+SWQBo69qn9RqULux5CMu/FGqM3GY+xMfkKJU=;
 b=CdunPEZXQdH/xo5eE/ZQXQwMwAEk5Kzg5GFatjCSd4D956q8McOuWbg2NZ5jJ0PgpaFCwtZ29tE2UJsQK6U3fM3EmYsRw3UeQ7diCEoEipg/WUa2ZwsttuzpKJZ6NQtpnzVrd6uAXVgvpejYgr0dEt2g6qbtmnGjonsZEjdcfUI7x1r3zmxWG49u7lEkhKZw6v5F/pft+Ufg/TiOartn0ZuGY6b7xsz71U5z/KriBdM78eXi4ukrsjOMl5+lwlkJ9WvfuN3yTsFaxl+Q7EfD+CAg5xbbVNh65nOsC7NRIrDLNJ1pva+xHVZGCbzxREgdvrxM71vstfKX/Lbxa/w1Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 13:53:56 +0000
Received: from BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21]) by BL0PR12MB5505.namprd12.prod.outlook.com
 ([fe80::9329:96cf:507a:eb21%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 13:53:56 +0000
Message-ID: <076e1623-6344-470a-bdff-d8a594ce17d6@nvidia.com>
Date: Thu, 27 Nov 2025 15:53:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: Introduce
 netif_xmit_time_out_duration() helper
To: Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Yael Chemla <ychemla@nvidia.com>
References: <1764054776-1308696-1-git-send-email-tariqt@nvidia.com>
 <1764054776-1308696-2-git-send-email-tariqt@nvidia.com>
 <383aed26-aa07-4759-92b9-5448161ba6a4@redhat.com>
Content-Language: en-US
From: Shahar Shitrit <shshitrit@nvidia.com>
In-Reply-To: <383aed26-aa07-4759-92b9-5448161ba6a4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To BL0PR12MB5505.namprd12.prod.outlook.com
 (2603:10b6:208:1ce::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 23463c77-5824-4188-0a62-08de2dbc6879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDU4VjBJWGkyOUhYZzU5SWQ5WGx6a0R0WUgvNlNvc25DZlU0aXVVUit2SU41?=
 =?utf-8?B?bGszek8rMVhPbHM5RXNrOGhacktUaHl3cU9zdmtCam5PaHg2aURIZld6NGlj?=
 =?utf-8?B?SUthTFdPamV4TTlNYVdBWHdzT3RMZU1CcVRlL1NueUFyd2phUllmaW1JVnNn?=
 =?utf-8?B?MmdRMUd6Rk9jbEoxTkcvVU1VbXFHUTQ0VnIvOE5DL0ZoVGM5MFg0eDNEVS8v?=
 =?utf-8?B?MFN4MTl3SjNTVHJLYUNBNEdCZ1l2aVpCNzhpc3BEWkswYlRwYjYxZHREY1Fl?=
 =?utf-8?B?SjVkR3lXc2tCMnV2emhiWjVrc2Y2eG1yKzJtd0xRT3BBMGovNjljUFQxdjJv?=
 =?utf-8?B?Wm1paDZ2UjIrSEtnRUNVTk1wblljUjRlRG1SZ09xM01YMkhOYlhZZWhjN2s5?=
 =?utf-8?B?bUxJMlhRMHFucGR5ekZSN0lXV0s0VlJJZlJyVWcvQVlOd0NLZGdSMHNaU3dE?=
 =?utf-8?B?VnEzbktBcmRIMU9rUFA4Q3BWWkNjMENLeVRYbUVLbFJYdmdlN3Jad01IT1lU?=
 =?utf-8?B?aE9mdWwvemh1dzFGQVdvNXU3ZDNiZXVCT003ZldsRWhHRjlESWwxUnZMNmg0?=
 =?utf-8?B?ZlEvMVVNNE1DRTA0VmcrYVhHT3hOTUlxOHU0dDg3Skluem1HbEpYWGRhWFNi?=
 =?utf-8?B?MVdpaktlYnkydEd2VTdiRGJSeHNiaFFXK2lJK1NDblQ4UEkwTGZiNE92Nkpn?=
 =?utf-8?B?UHBRcjJVd0hzblB2Q1BPV3dFeDZpTFYwMjBDNG9TYWowV2lIMFA4VEM5MWpQ?=
 =?utf-8?B?Mmk4aHZtWnllSzdHbitwSFovQXFNdTY5MHQ2K2FkbkVmNHBIb3llU0MzaGkv?=
 =?utf-8?B?V3VZU3I1Um10UjJneURzM1FmQThtdlp4M0p2K2kwRHBkVWY4bUxtUGVXUGJT?=
 =?utf-8?B?Mm9xM1FSYkQyVDFtZXRDSDdaRksvNWdoakliQW54QVJaaG9kM0tXKzdsb2Ft?=
 =?utf-8?B?ckRXRFZJMVJ6OGxQUW1lZGdoQnNrS0tESEl0dDRyNHkzSENjQjhtVVBuMXc1?=
 =?utf-8?B?WE0ycDQzRXB0VDdHb2ZXR3VIZmJjdHFJdkxiUTg2eDBNdHZIUFdmd2gxc3hI?=
 =?utf-8?B?bGFLLzQ1RUlaTC9RZTJ1dGh1WVNOaWRpc21pbldWejJKS01lVWNTYUt4MHgr?=
 =?utf-8?B?dnpBQ3dLTHVKTkpMbi9ybW56aVYvRnByOVAzSjVtUWE3SWp6NmdqR2JNQTJp?=
 =?utf-8?B?RlgzSkJsaURBNTBOd1FmeWZRYlVkR2NRTE5MTGtwMStzSDE1L21lTEVtY2tQ?=
 =?utf-8?B?cHBReVpUa3d5a21vYVFHU1diVllRS1dGMWptMUxzZjVYdDc5a3RnSUE1dW0w?=
 =?utf-8?B?bWszVmh1TXhzRmFvWXk2TWdwZ1BRU1lsRHFlK1orTUQ0c0tTRlR1Ty9vVE05?=
 =?utf-8?B?SHJrUE5RbEsvNVdURCtvY2pxeFJzSmJKc1ZoTG0rRzZRSHVDbEI2eS8vNGNp?=
 =?utf-8?B?WkdZK0dCem9Ua3VBelZYQXZERkdzTGJCcEEvY0kyUS9uNDdvTytkQmN6NGkw?=
 =?utf-8?B?M3pSMk5mcUtVQ0wydjZ2Tk02c3lhWkhRK2x3bFFuNXF6YmE3RVdUTDdndjQv?=
 =?utf-8?B?bzBIejdPT2JDbEUrOVBhLzVOQ0g5emZoTjB2bmNKS1JQNGdjTUJnTC9tbEFm?=
 =?utf-8?B?ZlRmci9DZThGMGVKMFd0VThSWkZxQVc5aGxpMG1vdFZhZkJoS2doeWdBcWZR?=
 =?utf-8?B?Ykh5UFVPUXZhNmdvNnhPSWxDemhENkhTRlFWUHhON3FMNHN6aHcxWnc1ajY4?=
 =?utf-8?B?MVh2UEl5bEJIVGJJZmhlbExXZWRUdktjbXN6N3lGaVNTMDZ0aUd3NlN5NlZG?=
 =?utf-8?B?YVlrYUd6TE1tZ3BuUzBTRUVONkVCZDNrZHVreFN0TE9uRlNJb2pvNEJobFhs?=
 =?utf-8?B?ak13bG1BcDIrVkRkMUhCYkxZdjlIejNlL0hoc2FvY0ZqZWNzZTdVdkpwWWJJ?=
 =?utf-8?Q?ZegH8+7aFt1tN+ufpeCJuS0I3vDGYhFY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzcyVlpjRjVlaE9WWFJ1Vmt4eGg2b1gvWStmWVZ2bjB6WFR4aExyeHVOK2Jn?=
 =?utf-8?B?VTZROTJER2liYkNKMVpPTEU5Ny8xaTlRUGxvcGZiWDd6WTB5YVA3RVh2VENK?=
 =?utf-8?B?K2N6dHpqWUtzeG9vOU1PS3R6bFVpaFZTbEE0QXZZQkQxUHFzMkdzMXJHN3lz?=
 =?utf-8?B?SjZTQ0Vrd1UySnZiM2NuVU0vNzhhRWJMSVZycGFQZjRwK3JtRlNpVVlRUkpU?=
 =?utf-8?B?Q1JzRzdYVm9IbVJvM3B3UmJOenNCSkt5Y2s1bXBTbDJlTjlxcG1OMVNvcy9i?=
 =?utf-8?B?WmNZcDMvdGdUaWlDczNmR3Y2VVR1TThsWUptZHRtM2hoYnFRNkw1VjIya3Zq?=
 =?utf-8?B?dTVpSi9LV0lwVEt4SW4vUktvTVA2ZFdaRDV4RmhtbWlNN0gxY2xwb2tGRlVT?=
 =?utf-8?B?UVNOUlJ4K04zUkx0L3pIQ2tJRG5paGJqclNtNHZLSGR6aDB3clI4d041YW5v?=
 =?utf-8?B?Y3Vsa1lRWUZGaGFUUUF6QnpqM1EzQUN5YmxnZ0lQQVBMeEpsaGJNTUN6eEJv?=
 =?utf-8?B?Rmd6YlJPYkIvNzA4WXV6UktTVUNDNFR0QzA3WlJmZkk5ZUJNMkJweFZkTWY5?=
 =?utf-8?B?RDhidHRMNTdFQTJ1RG5tS3RzZ1kvNHIyNDgrbGJhR1VlRVlDK2xOdWRrdjdw?=
 =?utf-8?B?VnQ5ZTJlRTEvVmkvK1BzZ2dYS2F2bm5rNThjOERBVU9xSmp3NldsZUVhU010?=
 =?utf-8?B?Wjg5WHhrcElLNW5Kd1o2WkppSWJpYmk1cnF3M3NLQmp4K2ZpNGozSlA5Nito?=
 =?utf-8?B?VHFEYVlDUjd6Qi9Zd3RoOWNVb05VNjVDWXljNWlqa1EybUpwTVlFRERUM3hl?=
 =?utf-8?B?bWtuUjJVUEEwZzd4WU9kMTAxUHJBUzFvckFIQUFHWWJkWjJIazMvamJnRXN2?=
 =?utf-8?B?QVU4OFNLMWVHUWF2V1ZLSEYwZjlxbVkzREg2TEozZmhYOW1Zc1QzR3NVS05H?=
 =?utf-8?B?bG5LZzlobHhSQWJTZzdqUWExbzlCYmwzTStTUkNybitCSUV1N0ZpejRURVFx?=
 =?utf-8?B?djdMUldtTjZvRVcwQVZ4MHlPQ2lsY3dKajVKRDhhai9NNWZJUTFNcURaSTBV?=
 =?utf-8?B?U21PaExkR1dya0JLd1RWZUZNWVp5OVZEbDY1eUhrSm1DVnhhajQvbFpwbHox?=
 =?utf-8?B?QXZIbkpnKzFRTTRkWUY3VU51Q1FKTFAzUy83Y0lKcEpGeDFVMDFKYmxsYVUx?=
 =?utf-8?B?STZRb3VZWFpzS3lvMEhFTFFYcDJtcTlXWE1SbVN6bnVDcWFxMVlPdVFLdVFW?=
 =?utf-8?B?NHhLdHZnSTlPRlFEc2NIbGs3eTJXaFNFczF6Q3c2SVpZVVRiUEtvdzFONzdh?=
 =?utf-8?B?RHNhYnFPWi9jeTFCNUIzSW51azQrN1VzNWt5UTdDNDZibVc2NXZ3N2dpTEF3?=
 =?utf-8?B?TnFLNUZ6bWhIV0drNVk3KzlsaUZvcXBESXUzME5XRkJ6Y0dvZE9tV1IveXds?=
 =?utf-8?B?a2gxQUk4R0kveTNoRWNjY0hqN1RnemRGbmNnaXI4dFlmSkdVYU9iVmFNeUNh?=
 =?utf-8?B?bnJ4Z1pqWHN6SUM1NmhlUmZYNERGcFVGR2xUYndBUk1UNU92YVR6OGc0aGg5?=
 =?utf-8?B?VkVjSDNHeFVXOGMyd0lsWjJIcHhFMFJlWFpLM05qajFia3ZRMFhFbVJKUVV4?=
 =?utf-8?B?cVMxRHoxb1MxWm5YUjgrWHpna3dHMjBPb3Rhekt2dkxwN0tMLzNFMW9kUTRO?=
 =?utf-8?B?Y25SdlNDQ2llc05GSkt4RXdwS3Fvbk9ZS2F6alp1czVzOU1jMDR0ZGRveDFU?=
 =?utf-8?B?NkhacEVWUmFTdnRCVnhpaVJlL3JrQlhYMW5vdnhoNTdCc0NQcFRMSVd5cDNr?=
 =?utf-8?B?OWl3dXl5dDA1OERyYkRPcTJUNEdMWjVmdEpSQUl5RkxvRmRvSzR0RWgrZm92?=
 =?utf-8?B?SDV5RFk3YmZtWjJIYlJacllHWU5QWHNGalVVMmV2QWt0dCsyVzRTTHFmc2Nm?=
 =?utf-8?B?bnIwSWU3N3FndnNtWDdHcHRHZWtEQlhqRnVqdGsyNldXd21yNm9PUFIyVzRO?=
 =?utf-8?B?U09ERmVkUzBmaWg3V1g3TzNudG9lUHExbGpwRU9uSGFYeXlVRkgyUys3Q2o5?=
 =?utf-8?B?by9IbS9TbDgvMnlHUWR4dDQySDhHajhTWEF2VFVqcStNUU5FVVdKYityMkFa?=
 =?utf-8?Q?GtCnTbP9F8Qlss/kkmOa8Ziif?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23463c77-5824-4188-0a62-08de2dbc6879
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 13:53:56.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SibRunCC9BFi9vknBxm7ktilM0WHuKqay2mrsCywFaHH1xwZ1kbsE8h++PyMmP+uw1TglI9KLYar+kKXnEmdmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663



On 27/11/2025 12:53, Paolo Abeni wrote:
> On 11/25/25 8:12 AM, Tariq Toukan wrote:
>> From: Shahar Shitrit <shshitrit@nvidia.com>
>>
>> Introduce a new helper function netif_xmit_time_out_duration() to
>> check if a TX queue has timed out and report the timeout duration.
>> This helper consolidates the logic that is duplicated in several
>> locations and also encapsulates the check for whether the TX queue
>> is stopped.
>>
>> As the first user, convert dev_watchdog() to use this helper.
>>
>> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
>> Reviewed-by: Yael Chemla <ychemla@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>  include/linux/netdevice.h | 15 +++++++++++++++
>>  net/sched/sch_generic.c   |  7 +++----
>>  2 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index e808071dbb7d..3cd73769fcfa 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -3680,6 +3680,21 @@ static inline bool netif_xmit_stopped(const struct netdev_queue *dev_queue)
>>  	return dev_queue->state & QUEUE_STATE_ANY_XOFF;
>>  }
>>  
>> +static inline unsigned int
>> +netif_xmit_timeout_ms(struct netdev_queue *txq, unsigned long *trans_start)
>> +{
>> +	unsigned long txq_trans_start = READ_ONCE(txq->trans_start);
>> +
>> +	if (trans_start)
>> +		*trans_start = txq_trans_start;
> 
> What about making this argument mandatory?

Since not all callers are interested in this return value, as in the
case of mlx5, it would be nice to allow them pass NULL.>
>> +
>> +	if (netif_xmit_stopped(txq) &&
> 
> Why restricting to the <queue stopped> case? AFAICS the watchdog is
> intended to additionally catch the scenarios where the rx ring is not
> full but the H/W is stuck for whatever reasons, and this change will not
> catch them anymore.
> 
> /P
>

dev_watchdog catches only the cases where tx queue is both full (queue
stopped) and timed out (last transmit timestamp was longer ago than the
watchdog timeout period). We wanted to preserve the same conditions.

By the way, I notice now that the new helper name in the title doesn't
match the one in the code. We will fix.

