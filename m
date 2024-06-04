Return-Path: <linux-rdma+bounces-2837-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283DA8FB36D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 15:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 744CCB26A14
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B5F1DFD9;
	Tue,  4 Jun 2024 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KqfzGlx0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD2144D2E;
	Tue,  4 Jun 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506979; cv=fail; b=WSwAO7brjlcNc3ye/+DedpE3QuYwc8OgOcRl0I2pTchi7dRjlShuEFOccMpRPzvLmLN5LHtBFOvtWKM869tMzifZSr0Uq/RDl0F69uJJY/sXkYp5cX8g2NiaBPNBdd4QGu8aIOag2UZIBAOQhuTE/bmA8LIFbbY15XoEPwClVhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506979; c=relaxed/simple;
	bh=gyx2dbwZvst5R89Uo4mxxC3LGgGkwy2bnvddBYXdJ9Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZDPLXy5cJzak3rqtwpsaCtMld5TwOwsGkJkIYeoU5woyhUbbwSW00hGoa4FZCgTgqhPeOulWm1/halHOrpZqY2dhrXcmJv2+dPajwLRAlMKpYap/uKqfnUML0dJMXktlFs7R2+QkgOO9Dy0nE5kxuKEUZLrHIMZbDlwheMYn5Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KqfzGlx0; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aT9qEL35rSpEMuMDaoUBb8cXmHLPwutK7yfoClSLsjci+xPSnge0SkVhhd2nymvD6u9Xae4T0NxXBb4xq5yrZ8am27cP4G4ozy8jXMlw5uRk0AlJX1L0qhWkoXw+dOLFFwrtjnzsRY4wRxP247hgXDdyD2aKYbx4KT31DJLH7+rSkm4rq/CJUJNBGzepdKBjUsz6f4lEbJa194JxzjLOa10xAO1MBj7iVIjdeSrsSbJxLamzzMK8ZULhXUIpi+pBrzZ0AIa8DDYUEEXvVmw67MMSic0L9FUr7wIsdlXQEk6UD4f2xd/ZvXWdaZTFSQ0YV06zOvKZFKAl7eGeF8/XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su8SvwJo/zHvX6f6rBO84JHNGKihAzVHjb5wWC0nUMM=;
 b=g2ln/yhFpemY17EGCfWFcSC7GrJXBPlxv9/n6n2nNQLVgFXTfiNpkSjZHQK2Gw6u1Eak4XTQOjkejFGRe7jS2eZ3J/y56W6VNZFAP+zuQK74DPLZGM1aVi9OePvjeIQFdSfNZQUYSLfiFhMfS/woqkyNhohMms4PjmApY/8M9S6tluOUywL4cppo4RQt1XtM62B8I3QHeMKCqj47iQ40ViewqCxw9WKW3UsSDsi5MNh9oc0t5b496jEJgThifj6uvt78xP1yWAVDWACTACOJ6CVG8JXAviEKJyq2mQX36f7nNUa83Zdk2BFRdvNe93358ARDN49jheQmnyPSFNqlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su8SvwJo/zHvX6f6rBO84JHNGKihAzVHjb5wWC0nUMM=;
 b=KqfzGlx0WAIrmdEHUJnPr65O34wa9wmsawaqCcBTzjJhHMsQCn8c8Tq6IJ+HmMb5p5ZGkcCgkygKxpH+PpgQBbKX5oy1ptoLXBkXvfb1VXzUTmEP5xUwpb79KFLyykxNwf/plhl3q89Sdei59SBAUCzJ6QBDJmCUpEysU+Jv2LXPGinq36aMc//V/t8qALl1bKpniZEWZ4om4gd54a5gLCssm2d8gTDdYoH6aWis0SAjANcZLPY+ssVfjaU5yO9TR8jBaAvs4xGn/1gFkvVmUn6YctTPXzhXmBLCUrFkt6U19TZJlwS2X9YVrr45933X7pNkf50uh5FkLPA8GNl5BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 13:16:14 +0000
Received: from IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed]) by IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed%3]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 13:16:14 +0000
Message-ID: <238b128d-0577-42e4-9623-1ab500bc1362@nvidia.com>
Date: Tue, 4 Jun 2024 16:16:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
To: Leon Romanovsky <leon@kernel.org>, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, RDMA mailing list <linux-rdma@vger.kernel.org>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <20240604114050.GP3884@unreal>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20240604114050.GP3884@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::24) To IA1PR12MB6018.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6018:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: e72e99b3-5f5b-4199-03b0-08dc849882bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck91NzE5a0pmbGZMcE0xUWFUUW5TOGo5a0MwaytYYnNvWVJxMlE0WGphVHpv?=
 =?utf-8?B?bDU4bFBhTnhRY0YyZmJQcml0UjJySzlua1RjNnlicUJwNFhKK2hyQXZ1VC9S?=
 =?utf-8?B?VnYxZWcxQjh5djZ1Mm0rdTgvVi9ZeWpmZ05kemZ4ZEJoMW9tVUtad05Ia0J0?=
 =?utf-8?B?R0RBQTU3NTBIQzVGbzUxZlJVc0gzQmcwcE0wa2Zpazk2SVdJRWl0b01oYUxt?=
 =?utf-8?B?aDJMNGFsT2x2dHZpbG1WU01xbHdBMHFJdXhpR1hFZ0xXUTZ2NTY2WERrV3Jx?=
 =?utf-8?B?ZnRrOGxNTXBKN3VCRUM3dDhHYkdUOVNvVXNsc3BJdnpyY2M4UGdDODJ3bU9p?=
 =?utf-8?B?K0g2ZGFmdWdSVFhIbnYrb3RkTTlyRUs3aCtSTlh5ZHZZM0p6QyswWHBSWkZC?=
 =?utf-8?B?b0FnMjNFQm5PWERRaS9vUllrU0o5RzEwNWQ2UW9lSll4REdIaDNxVy8zckFE?=
 =?utf-8?B?VEpWK3hCeDA4UnJkd0lSYzd5YnBsQWhFNkxndHpqQVRYUng2ei90aWdwQlNO?=
 =?utf-8?B?ZW9Fa3I2T0hXVk5Eb3RrdTNDSUZKVjV6bVdQTU8vVnEzWHQ2TVFDd1JTeWF3?=
 =?utf-8?B?SzBrK0NMMjJkWW9IdnZKMVFjcCtBWklCbEdSejkwYkZ1QVYwNlcwTzF0dEF3?=
 =?utf-8?B?VGpYTGFVMkViVC9sUlg2UzVnc0NYRk9WYUp5RTJlenlQaXpXVjBhMEtmR3Ax?=
 =?utf-8?B?M0VCQlphWWZRa29mUG95bzVtTnNpUUpCdDRhR3RpL0EyUUN2bmRaUFMySTNH?=
 =?utf-8?B?ME9vRXJqRG1WQ0ZQZkdibzk1Z1VyaFNvV3k1Ykg3YkZ2cmRjMTkwUkorYlNR?=
 =?utf-8?B?ZnFkaC9VclBqK3hrY1Zoa2E5SE9wbHVkaHlab1BqZ3hsQWVKaXlSS201cm5j?=
 =?utf-8?B?NS9KWHNoTi9mbGlTd3ZNWnpxSVpvZklhY3RMTy9UYjdiNEV6cFIxSXRFYi9E?=
 =?utf-8?B?eFdVMjBvb1hiMHJQU0JwSDFueGpjbDgwanpKd3B2SGx6b09MaDgxRmdma0Nh?=
 =?utf-8?B?K3lIS2MzVklZaWhpOWRNMklGcG1oT0liTlBBYWRZQ2p2Q2d1TjhrSE5yejBw?=
 =?utf-8?B?UklpRFBYNk1pTm9UWjVGNDdMdTR5TloyV0IydWhkQ0h4ZWxBV1lFTUJPTGFR?=
 =?utf-8?B?OC9ZNVM1ZVBYZVd2NnhocFZ0YXdQNlpheGZjaHpQL0RmNFRhZUpFSkt1U2N4?=
 =?utf-8?B?c0Z3MFp1cnFnbGF3T1llS1VPbXBHbnRQM3pTSHJsVnVsMGlMMEZFZ0NFcTB5?=
 =?utf-8?B?SFFteEtpaTgwd2dsNTNlSkFiczJPMlBMK0Q4ZWZUWHZmMld0R3JQSk1GbC9v?=
 =?utf-8?B?TzRrZUltTGFCOEZDN1NyR3pXQ1VlL05Rb2xZQlI4SXkwbUJ0Q0MzR2d5dndo?=
 =?utf-8?B?b1NxWUFFMytXanVhcENLWit3SHRlMVhTOElabEFUcW0wTXBCajhwbVF3T2RU?=
 =?utf-8?B?L0tOYWZPV296bkZkYzFvd0RuaHFYU0gwaXZUSzhMYUFXcDFKV1czQm1PVWxp?=
 =?utf-8?B?cDd4RlNCdVZ6Q2lLdmRwcHM0NUFYWkdCbzdLS1FxUnB3a3lpWG5uYjJaTjRL?=
 =?utf-8?B?em85LzFqY3J4bk5tUmNtN0w4MDZxMDJvQlU0cEdoeEd4SHdua3hCTUU2SHpr?=
 =?utf-8?B?WmFkL3ZQbjAyWGI2SXYxVyt0UXJTKzVJejdIS3ZUK1Jlemo5M3hlMUtmb2NY?=
 =?utf-8?B?eGxjNnhmM2tuOGhyU2tFeVpIbGJ5UFFXY0FqWDZyMC9VSFREaG9oQjhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TERpYmZ2MUsvN1FxYXJaSG1sQjhxMDF6eGZZblVaMk14Q1JOSnBvb2hsWE5W?=
 =?utf-8?B?T0d0dUJ3a3F0RUpqVERzTWVNd2dPeHdmeGw5ZHRQT2VkZDd0K2wyZmQ0SkVE?=
 =?utf-8?B?MlFLZlNmZnoxY2xpbFFMeWowNkZxckZWaWtXbFZ5OFFGc2d1QVgyUWdkd21L?=
 =?utf-8?B?bkp6dzRaTkhlKzNXSU5va0EvS0FSQWJxRkZodXVQUVFWcWE0TTUzZDIzU0Zu?=
 =?utf-8?B?Wmt5UG9leGg5REE2N1kwYjRtV2U4ZVRTUE1BbUZUTFNMMlBPOVJOMVUxSDFP?=
 =?utf-8?B?cWR6TUs5TENaV3RPUXBMZjFCYXE2Q1dSbnJndmhiekxQWTVlK3l6YzlRUk9S?=
 =?utf-8?B?a2RPVTNQcmI1ZXBsOTUyajdxWElFTHdOVkUvQ1RwVnJhNk1uODVIQXZZOTlX?=
 =?utf-8?B?WjA1YVExQ3FibEV1RWdtUFM4Z2FPQko3NnhNQUVuUk9FQW1uelc1MkdNQ0J4?=
 =?utf-8?B?cEZJbFhCbHFhNERCMGlzRjAwTEtWQ1hVM1BwSGJldEJGQTBFdE1Cd1crbkdY?=
 =?utf-8?B?MHlTMGJtajNOcHdNbUJuUXNtSkZIWHAxN0U5bGVVaHdIMFBWOTNyS0xZY1E4?=
 =?utf-8?B?SnZza3ZIRmhYUHZ0cEQwaW9pV1RLelJKNkYrQUlFMEJHMWlGcklLU1kxdGhk?=
 =?utf-8?B?djM2VjJoaUVTS2VFVEpLNzRERnM5VUN5akkvRUozOHE0alpTMnhrOFIwUlZa?=
 =?utf-8?B?Y282Wm1hYnpWaktXNkJFUXZSZnVPWG5EN2t6aklQaHQvWWZ2VEMwZ0p0eVdh?=
 =?utf-8?B?VmdocmVKOG5jNkl0a1pzLzlRdFpHTS80Nk41MjFMVjlpY0VQWTg4TUhKS1RX?=
 =?utf-8?B?WUlQQnphQ3ErbWZYaE1JTzVWSi95c1hSQ0xST0pYeExESDVYV3dCbFVDSU5Y?=
 =?utf-8?B?dFp4Nzg5dWdCVkhoN0NRNW9GOWVMcmM0S0Joa1VRazBuVUc2M0FCMjNHVVRv?=
 =?utf-8?B?UkRuaU8xMXZ5REtpKzlja1hVM2JwRmtDSlozQU4yam4vNXdtYW1DTXdpSVJG?=
 =?utf-8?B?eEh4QUlIclVCaUlPTCtheFVDVmtIaFVrbUpwSzFISTc1SWdyd0ZDalhIdDBJ?=
 =?utf-8?B?azQxNkRpMXRIZy95NVZCSlZZTGpXQmlmY3VnZFhtbE9BRzZjWjhIaHJoY1Vz?=
 =?utf-8?B?MFRZUEtKMVo1aWkvQksyNnhsYjJnVXdGOXMySERhV1JOSzd6dUZFc2RLcHRV?=
 =?utf-8?B?aGZ4VzZWU20vUDd2QzVkN3grVmYwVFhSbWJDVXMwTmxpRVkrdytaUk1jaWQ3?=
 =?utf-8?B?bW1FMmpNWGhmUHdYNC9RSjdLSVIyUTBoa1M2dkx1c0ppUEpBVTN3aGpoUlU0?=
 =?utf-8?B?a0VRWU5yUHJ0SllTcDU4RDBMUGc1em9rZHNIUUZKaWg2dzBZRG50MFJudStv?=
 =?utf-8?B?ak5KSFVTNE1CcC9jY2Y4SWtYZGtEWHJLRXdWTkQ4dk5HWUp0Qy9qSXJOcUQw?=
 =?utf-8?B?YzB5ZGdwMTVXTGkrTHpzTUZzd0ZMVnFDSk51QWlCNzRjZjArMjNMZTZBanB6?=
 =?utf-8?B?aXB4ak5Vcmk2eXQ4WjNESE9EYUNreHg3aEdMSE1LTkFBNktaeTVNWnVlc2xE?=
 =?utf-8?B?VHpXT3JNdkY0Y1VjVHV5NWk4ckFUNWNLYlNoYUhwTkQrV2toZlVsS040VDhJ?=
 =?utf-8?B?bHdCNkM5dG41eHdQZ2htaW1QTXR2eURmUG1TZkVUbjRKcGo4ZUpBM1FmbXI2?=
 =?utf-8?B?b2lNYnBrSVdseFJxSmR4QWNQSWJVM0xua0Vac09zQVJ5MHRSS1lhVElTWmxU?=
 =?utf-8?B?OVBpUmFPbXQxNm1NQTNRYXRLVVB5Rk1TRmxPa2ZWS3FTSGVUbzFETjBsZmg0?=
 =?utf-8?B?a1RGYW9tY01wM0prb2ZNNkNSWUJmOEhyRW9UM1ZndXcyTHA3cCt0bmJrQkIx?=
 =?utf-8?B?NEZFQ3MvWGNObUVMWUxaYWdUQURpNWsrZXNqWDVSRkcxNUg3aDdKcmNUTkl3?=
 =?utf-8?B?WXliMUUyUTFsVmdEaFBhTGd5SDdMQS9pcFpWbFdLRmM4MEl5ajcrTXNSZys3?=
 =?utf-8?B?bGtVQXFKUUFIT1hQTWVZT3c0ZldwMmdub2FqOFRHMytWN0lJcmxiZUVSU2xO?=
 =?utf-8?B?bVJ0aXZ0VG15bWJHa3A2V01XQ3JTWkIycGtNVDVBY2wrY0FGVlFBSG5kbnNW?=
 =?utf-8?Q?Xv5h5cW9KtnIJ0WyxqujxTCsj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72e99b3-5f5b-4199-03b0-08dc849882bb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:16:14.5006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P13NWd2SDv3rTX7zfTVq49fyd8w6ZJHO1Z1JlJakxk4UXDbkkwbIQ5bouDvFiupnSDSttxX+KT5nFppPoTwKaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167



On 04/06/2024 14:40, Leon Romanovsky wrote:
> On Tue, May 28, 2024 at 11:39:58AM +0300, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@nvidia.com>
>>
>> The commit 643445531829 ("workqueue: Fix UAF report by KASAN in
>> pwq_release_workfn()") causes to the following lockdep warning.
> 
> <...>
> 
>> As a solution, let's rewrite the commit mentioned in Fixes line to
>> properly unwind error without need to flash anything.
> 
> Tejun,
> 
> If you decide to take this patch, can you please fix typo in the commit message? "flash" -> "flush"
> 
> Thanks
> 

Also "worning" -> "warning" in subject.

