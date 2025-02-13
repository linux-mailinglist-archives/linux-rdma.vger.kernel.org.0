Return-Path: <linux-rdma+bounces-7756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3114A351FF
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 00:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382397A1B7B
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B378202C55;
	Thu, 13 Feb 2025 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="36lTCq1O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458932753E3;
	Thu, 13 Feb 2025 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487981; cv=fail; b=pcBYjPhGtYe7AV8pg0bE2ddskSq1zIoSzqIjj75MdXvdqafsnAmljCfP0RfYeVeUgzPduN8A1vIqGeXn8hsoGLWg4OD/yFdoTzHqhjyGOHqDAWoCZN70Uys4tn2Id4u1IxLnkgsukMq2ahAYE9YF48lov815uQk0ayrzXPG+GSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487981; c=relaxed/simple;
	bh=xv1Okc5RuCHjp7PAnxeOXU/HMLjXGlL5/y0/3opdGa4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KW/t77NmLo5Olmo/mkHpYj0UOwEqWYp5WgoYCrq73u38L3ll7omgMTeC+gNvQslmS2O/DQ+nSO+sp6Q7ERqLHyIiJfVowhMOCZ4d0Qwg0z9uE5ZLkXM1VT1Fsu2qcjOS5LXQFNCLfeFmYBzCZuA+2tqgy106qQCtYQuWwTyKgX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=36lTCq1O; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdbDvRKQDSlQTdTCrqbU5ddqDMLCmlP/hVINYR+H8i3yGtlShG2ZhBFHa9B9X55auj3bChEYaPvMfYjf4bFfOr4QcUli2guqptvErFLdZLwokVnkoVeoEDupAf2Eo6UmseZI3+xrCYA7FCHUmvXnihBg4x1xbs8CPDcBOYxQT39+//vEHfWcX8bQk9ETwctxSvI/hE7ls4PKpu98lvjm3w2bJJDh6xIsWaa87tRfPhrCH4u0IXivgSXpJHGFATHwvTI6s9C4LEtUWr8wY5DKJAR/d2Zhky0QJMd9V2DhA5+K1xJEJ1OZWzDEuGWO9JEQz3zx6C/ic4J0Zh+IMsCpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXfMpzgyHkc30s1/SfUa+kRe7AQATSEk9/P4UjoNdxM=;
 b=yit2OHPnM7TkWyn3t82bKwq68tjLeFBW+n5tqb/Tb0B8zk3MDQI0pwngMxz1FQajU8dayZGCHIno0WZxIkYLNoKi2nQITOsnmO8b2HR8vezsLkguvhcIi71Yo+V3woSOLZH2LbwC0f1EulfyjH0IZ/Z/rPUwTrpNjiCZCZK272V92W2kEfWUZPZwLj7wm61PsB0PnK1XjCwGeL65Y9S8S/t68tuQEZTaIly3CCGlXUDEDOwdzFMqyYbewMwVjaHYNYcn+P211PlUOGyr1/thyJ0UsbnqnxmFCVQ0bnfb/T4ysN9dxJNmJy51zEc2CvHj7/iE/vUGxCvlPH3avevssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXfMpzgyHkc30s1/SfUa+kRe7AQATSEk9/P4UjoNdxM=;
 b=36lTCq1OMR1fr/blbwMlKf+hFR8qgF0sdgstRVLP6MkiaUSSIviRcWsFY/EZUUzninfX5XCtnGMynrnCCA/vc7lto28ln+xlJohlVHDzR0iGh0uAbTgFdZ49ujW3WwniIN/8PN+YEtqNsdVhAiGADqOYSXxYMC76gUtyo+U8jJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 23:06:17 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 23:06:16 +0000
Message-ID: <3d9b8966-8ad6-43ee-a745-073a5c82554b@amd.com>
Date: Thu, 13 Feb 2025 15:06:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 3/5] pds_fwctl: initial driver framework
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, saeedm@nvidia.com,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-4-shannon.nelson@amd.com>
 <20250212122215.000001a0@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250212122215.000001a0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 187cea82-5044-433c-c950-08dd4c830527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1ltcDAzY0pXbEtad0lPUkNlbjFWSkxINkdsL296MUhodEhMNUhTOUhpMlFX?=
 =?utf-8?B?cGkxRE4ycjRPRVRXWnVuc1FXK0ZxK0tNd2FJQW9rNXNMUFNSUHZnVXhCZnk5?=
 =?utf-8?B?RFlOSnhrQ1FhVG9UMTR2SzVYNWdIQXNzakt6Ry9kTjU5RzZKS25DNnVoWk9G?=
 =?utf-8?B?NUgrODhwVkY0eS80UWJlcDRxbysyTCtINFZFcXA2NW9leStNVDZhbkZnN2xU?=
 =?utf-8?B?Sk9UZjlJbDM5Rll0RjdGTkJSdEtreFJuV0lvRmIwNkg3eU9yM0t1QnRJdXZn?=
 =?utf-8?B?ZlI5UnVPU1NJVXJqRGQyUzJuY01wS3lUOSt2aFlWK0gvZDdOVktmYkZFVHZr?=
 =?utf-8?B?V0kxVHdkYnVsbGVSUWdmeGJiWi9VdVViR1hwSkpCZ2ZGcTQxRUw5bThnbWNQ?=
 =?utf-8?B?Wk54YkI2NWQrcy9Hc2pGTW5HWndUb0doeGlNNXFNT1d4em5GeXJIcUpCaHZi?=
 =?utf-8?B?RmxyS01QYlVCbFRJb2dmWUwwNzFMSDJiQlR1UGNRb3plVmtudzRQcmlVSVcx?=
 =?utf-8?B?d3loaEZDdW9uc2w2c0RlcXVBYW5wYk5LOEdQclZhMzE4WC80bS9hTXJyZnRs?=
 =?utf-8?B?amRGYVJEbklaR0ZZMUVkWDVPa3pDR0svMFVLa1dHblRaV1NsbE9aZTlvQ2M5?=
 =?utf-8?B?aXlYMmZFeTIvQnltVUtFNmo3eEVySTFHRUNkTUpEakl1cUZBYit5UkFQdlYz?=
 =?utf-8?B?Ymw1SzZ2TUdiWk52aW1qeUxSdWJFQTNGclBvOWgwQThRZHlPVmh3YnJRR1BM?=
 =?utf-8?B?OWZtTG9yQnpyaWZMY2E3b1NYNTJ0TlIxVDdUcXNYL1NYWWxwcUNzT3prWEZU?=
 =?utf-8?B?NFhVNTkxZ1FVbG93dXppUzlQQi9ubDQ0bzZoT25WUm5uSXQzN21EZC9uT3h3?=
 =?utf-8?B?T3M5RjFoNWxCNUR0Tk41QXlud0RScWVzd0E1dmlPMGdKMWsyQ09QcUVKaGxC?=
 =?utf-8?B?S3ZpU2R2OU52T1ZRazFlbmRUNVhDNENlVHFlNlZVaCtXYUtEQzJjWU1ZRC9Z?=
 =?utf-8?B?YXFEbU9ScHNxdjZidWhXbGVZUkl5ajBibmpuUXN0aFVZMEliWTJwNXlCQlRz?=
 =?utf-8?B?TWFtakpEems3Sms0N25sU252T0t2bW9vNE0xWTRVK3lpYzY1UitNR0NySWUr?=
 =?utf-8?B?RjhMTFhBak5oWmlwS0tUN2Mwb0NvQVdPYUhaNjBKbkdvWldFeS9oVkhCVHV5?=
 =?utf-8?B?NzBYaDJoU1Y3Y0lVc0NPYm9rSWs0ZU4wYkhvWmtwaU5iOE5xOVdvb2YwN21R?=
 =?utf-8?B?UGNsdzh3RDQrR09WelFYTkdwZkhSV0UzeE5rZ1piby81T3RjaG5qNkljMjJK?=
 =?utf-8?B?Y0FZdW94OU5mb1RCM2JrNFY5K25FSmZNdGZMbHJ6S2FmOGs1dDJ4MjhrYWZV?=
 =?utf-8?B?NHY4WlZWem1XQkg2dHgzVG12b2ZTZjZtOFM1eWpXVFBvZHhGcXVJM0cvbEZS?=
 =?utf-8?B?T2l4SnN2Unllc3FjY1BwdWtSVU9GTWJWN1VxOUZqQkJoVElxY1lwUXVJdVNv?=
 =?utf-8?B?cndZUWI1L05JMDBRVi90MHFDZ2F5TE5DaWxwQVhqcGZqc01KWUpwSUJNeFAy?=
 =?utf-8?B?SHkvcXArVkJ6Vi9hbkdEUlFTMjZ2Z2duU3MvMHFHQWQ4TlZqZTVJNDlyd0Jw?=
 =?utf-8?B?cTVoRTdaRmRzTExLaVZWSWQ0Z3ZXdzJJVytNam40Qy9vOHc3SU50ZDJ1QWJu?=
 =?utf-8?B?eHNSNnJWeDlYdVpNZk1oYktVbmRkRmZzYnNOMTRwT3dxT2FDODNDTndVYjlD?=
 =?utf-8?B?WjZwTUtacWQxMEdqN1V4RjB5TXJBOTJaaWtUVk03emZsMHhaNmx0NkRqK1Jt?=
 =?utf-8?B?VlBBcnNJMzU1NnFoYnk4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3hqd2xMbFkvODFWVmJUaG9oMFpEZ3RyaCtDbndVUnVkd280ZExkVUJxZDZi?=
 =?utf-8?B?YnZyK0o1bHBhQ2hsVnBLNGQ1cHozVWZyc0IxMUxNUXN4VmJaTEZRZXBZM21Q?=
 =?utf-8?B?UGlFTXltTk5QYmZYaURhdUJXaXc5NjE3ZHlUS3BHTzJqcUpwYmJzMUdTQ1RL?=
 =?utf-8?B?eGNXN0JpaVI3QWlBcDJmWUM3Y1A3clFqV1F2UjF2QVJyZ3BhblYvc1ZsTDdt?=
 =?utf-8?B?ampXTmY4emgzL0VQNlNuVE1STHBUbEVYVVd1RURReE1JNHN5OE8wRWlpZGFl?=
 =?utf-8?B?ZVJFQ2pjOE5McSt0VG4rVC96SzhmYk5vV1B5aE83OFZWL1YvQkJheHVRUEVR?=
 =?utf-8?B?UHVnbGJzVDNxaVZMa0RSWXBJNEZrRHRTODlJc21jcmFhSGk4NGNUUnUzSzdj?=
 =?utf-8?B?QVh1Vkg0RU9ScE5iakdtN2VGaXJhQTUxK3dDZnhUT3VvREs5cTAveHg4ZGwr?=
 =?utf-8?B?WXVMYUNPSUo5aXRVSVJMOWJKYkRkT01XcXd1WWIxU3FzdTYyaE4yVmlZd1Y5?=
 =?utf-8?B?ajcxL2xHL1MvYS9yUzhDV29WYWQ4aVNVV3FPQ2ptbkswOTluWUhxV1ZwVnZv?=
 =?utf-8?B?QVJ6R2tRTTBtVzBhbmFXcXFwWXUvN2ZJdWZrakExRjNFc2tWcGcrU3NLMnZt?=
 =?utf-8?B?Tjd2NHNBdE9UZzJRZEtMOHA4OXZtdG4rWm5jZ2ZSaWZ4Ylg2KzhzMTJmVVdK?=
 =?utf-8?B?aTE5aEl1ZTlGblUyZk53YXZCb3M1Si9WdXZaYlI3aDEyUy9LVE9vaE00T3U5?=
 =?utf-8?B?Z29RK2JEY1hUM2tsU2JBcEFjSXpRVUVFdWZxK1g4MXh2UzByWHJjcmZ1Z3lG?=
 =?utf-8?B?anNPWUp5KzMxcGZMMkkwaWlkSVNUbjBKUmFDWTBvTDhSVngzVE5ESTRETis1?=
 =?utf-8?B?RU1vTERib09CU0x6TXl6aG5NYTVFUm5UWHRiNGxpRHc5WnJwS2Evb3RGQmZZ?=
 =?utf-8?B?OTQ4UG1BZWFHYktGT3JtVU9mTk16UEM0dUI1V3YxUDRCaVFTNFJmM2ZhWmFU?=
 =?utf-8?B?SFRRQTNLaU5jMUVmcDJuKzhReU9IKzBaRmNueFhoS2Jtb2ZCYVZWUXFUVEdH?=
 =?utf-8?B?djBmWG1IZUs2RTNvSzhHeXVNSS93K3hvZ2h0MThSclpJOHFoOUdCSnFMNDlv?=
 =?utf-8?B?SU1Nb0ZpOU1lbVp6Uno3aTdlM290dUNBNDl6eTZEZ1h3SVNhT1d0QU9vZ0lp?=
 =?utf-8?B?U2dMVEc4blZwaDdVTlVMMmVWK3V1V2NDWnU2UWtLSGVrOWZyMmRYcm5qNTY2?=
 =?utf-8?B?cysyMnRQZmtyWGtpQXoyb2wyRVRzSjRaKytrUU5SYXJkdDZBSjdsaWZERlU2?=
 =?utf-8?B?L2RaRzIwL2FtcFhielU2ZnR4OVk2RnVMRWVaaG5Nalp4OEYwdXNjNll1OUV6?=
 =?utf-8?B?K2dJU0NwK2JiVkJLK29WU2xUL0gxZWExTjRNdEhUekhzWkhiV1JQdEtCaEg5?=
 =?utf-8?B?V1F1VnppMVl6ZllDdUl1cGZmOHhKQjNxMzkrNGg5WnVuS3ZFRHk4cklJQ2NE?=
 =?utf-8?B?ZFZ4aHY1eEdkUkZlcWNMOUNjQUdqekJWV2hVMFJQQXlTM3pLcHlzS2Fiajdu?=
 =?utf-8?B?ZDljOTlWdC8xYlBUeWpMQ1JVK1huU1NqVGVQbkUyOEp1NTRhQVpVeEJPK0Ro?=
 =?utf-8?B?U3VmUzRIeVN1OFpjbEVkRzZnMnVIdVBSQVpTKzB0SUg2TkdzS1lJN1EyK29I?=
 =?utf-8?B?MHNlODlFZlBHMStQOStIOGQzV0ZmRUppZ3FZRmFKclltRXl3RUxKdGNZOE13?=
 =?utf-8?B?cFplQXQ3bnRRTFhLMHVuUWZaL3FFWnpNVXpSZ0RLUEdpUDlIR1diWFlkTkI4?=
 =?utf-8?B?dXlrckg4VmhnOXdpY1BmMlVyN3R0RWF6Ujl2Y2VEazVOU0J4Zm5raUpGTHZz?=
 =?utf-8?B?VVB6TXd6YTVxRjlvVW4xQUlmUkpwQUhYK2NUWDBCZTJPQ1grbGxWbDB1ZTRY?=
 =?utf-8?B?dHRxNXAvVWJrcnFCb0FGTG52aE5DUFBtMktjMEhXSGEyUUZwbjlRWENmTlJw?=
 =?utf-8?B?QzBKdlF1OGlaNkQ3amlCY29CNG5xaENsVWV2VmJGRXQ2OVBmcXZ1UytuQXFX?=
 =?utf-8?B?b3lMUnhpcTJjTnFidTBrV2luc1RoQVQrZ0M3ci95TUZrc1IwYjh1TnVZeFRP?=
 =?utf-8?Q?cInLX/f7VD4JdbhWnW+ruV0SN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187cea82-5044-433c-c950-08dd4c830527
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 23:06:16.8894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbcozoGnzEW26YggaYy3ijkQ6qp5DnZS1Up/OPpuqpNHYIN3ev1TryfRtvCoDzjSVNkS8qubkJ2mCNl5CxBH5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

On 2/12/2025 4:22 AM, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 15:48:52 -0800
> Shannon Nelson <shannon.nelson@amd.com> wrote:
> 
>> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
>> devices.  This sets up a simple auxiliary_bus driver that registers
>> with fwctl subsystem.  It expects that a pds_core device has set up
>> the auxiliary_device pds_core.fwctl
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
> Hi Shannon,
> A few comments inline
> 
> Jonathan
> 
> 
> 
>> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
>> new file mode 100644
>> index 000000000000..24979fe0deea
>> --- /dev/null
>> +++ b/drivers/fwctl/pds/main.c
>> @@ -0,0 +1,195 @@
> 
>> +
>> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
>> +{
>> +     struct device *dev = &pdsfc->fwctl.dev;
>> +     union pds_core_adminq_comp comp = {0};
>> +     union pds_core_adminq_cmd cmd = {0};
>> +     struct pds_fwctl_ident *ident;
>> +     dma_addr_t ident_pa;
>> +     int err = 0;
>> +
>> +     ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
>> +     err = dma_mapping_error(dev->parent, ident_pa);
>> +     if (err) {
>> +             dev_err(dev, "Failed to map ident\n");
>> +             return err;
>> +     }
>> +
>> +     cmd.fwctl_ident.opcode = PDS_FWCTL_CMD_IDENT;
>> +     cmd.fwctl_ident.version = 0;
>> +     cmd.fwctl_ident.len = cpu_to_le32(sizeof(*ident));
>> +     cmd.fwctl_ident.ident_pa = cpu_to_le64(ident_pa);
> 
> Could save intializing cmd above and do it here where all
> the data is available.
> 
>          cmd = (union pds_core_adminq_cmd) {
>                  .fwctl_ident = {
>                          .opcode = ...
> etc. Up to you.
> 
> 
>          }

Yeah, there are a lot of ways to do this.  In a lot of the ionic code we 
do a bunch of the init in the declaration and add to the more dynamic 
field values later in the function.  Let me think on this a little...


>> +
>> +     err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
>> +     if (err) {
>> +             dma_free_coherent(dev->parent, PAGE_SIZE, ident, ident_pa);
>> +             dev_err(dev, "Failed to send adminq cmd opcode: %u entity: %u err: %d\n",
>> +                     cmd.fwctl_query.opcode, cmd.fwctl_query.entity, err);
>> +             return err;
>> +     }
>> +
>> +     pdsfc->ident = ident;
>> +     pdsfc->ident_pa = ident_pa;
> 
> I guess it will become clear in later patches, but I'm not immediately sure why
> it makes sense to keep a copy of ident and the dma mappings live etc.
> Does it change at runtime?

No, actually this doesn't change at runtime, we could copy it into a 
local storage and drop the DMA mapping, which will relieve us of the 
need to remember to clean it up later.


> 
> 
>> +
>> +     dev_dbg(dev, "ident: version %u max_req_sz %u max_resp_sz %u max_req_sg_elems %u max_resp_sg_elems %u\n",
>> +             ident->version, ident->max_req_sz, ident->max_resp_sz,
>> +             ident->max_req_sg_elems, ident->max_resp_sg_elems);
>> +
>> +     return 0;
>> +}
> 
>> +static int pdsfc_probe(struct auxiliary_device *adev,
>> +                    const struct auxiliary_device_id *id)
>> +{
>> +     struct pdsfc_dev *pdsfc __free(pdsfc_dev);
> Convention for these is to put the constructor and destructor definitions
> on one line.  I'm too lazy to find the email from Linus where he
> specified this but Dan did add docs to cleanup.h.
> https://elixir.bootlin.com/linux/v6.14-rc2/source/include/linux/cleanup.h#L129
> is referring to setting this to NULL, which is minimum that should be done
> as future code changes might mean there is a failure path between
> declaration and use.  Anyhow, it argues in favor of inline as shown
> below.

Obviously we're still new to this pattern - I'll look at fixing these 
things up.

> 
> 
>> +     struct pds_auxiliary_dev *padev;
>> +     struct device *dev = &adev->dev;
>> +     int err = 0;
> Set in all paths where it is used so no need to set it here.

Got it.

> 
>> +
>> +     padev = container_of(adev, struct pds_auxiliary_dev, aux_dev);
>          struct pdsfc_dev *pdsfc __free(pdsfc_dev) =
>                  fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
>> +                                struct pdsfc_dev, fwctl);
>> +     pdsfc = fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
>> +                                struct pdsfc_dev, fwctl);
>> +     if (!pdsfc) {
>> +             dev_err(dev, "Failed to allocate fwctl device struct\n");
>> +             return -ENOMEM;
>> +     }
>> +     pdsfc->padev = padev;
>> +
>> +     err = pdsfc_identify(pdsfc);
>> +     if (err) {
>> +             dev_err(dev, "Failed to identify device, err %d\n", err);
>> +             return err;
> 
> Perhaps use return dev_err_probe() just to get the pretty printing.
> Note though that it won't print for enomem cases.

Sure

> 
>> +     }
>> +
>> +     err = fwctl_register(&pdsfc->fwctl);
>> +     if (err) {
>> +             dev_err(dev, "Failed to register device, err %d\n", err);
>> +             return err;
>> +     }
>> +
>> +     auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
>> +
>> +     return 0;
>> +
>> +free_ident:
> 
> Nothing goes here. Which is good as missing __free magic with gotos
> is a recipe for pain.

The above ident change will remove the need for this.

> 
>> +     pdsfc_free_ident(pdsfc);
>> +     return err;
>> +}
>> +
>> +static void pdsfc_remove(struct auxiliary_device *adev)
>> +{
>> +     struct pdsfc_dev *pdsfc  __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
>> +
>> +     fwctl_unregister(&pdsfc->fwctl);
>> +     pdsfc_free_ident(pdsfc);
>> +}
> 
>> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
>> index 4b4e9a98b37b..7fc353b63353 100644
>> --- a/include/linux/pds/pds_adminq.h
>> +++ b/include/linux/pds/pds_adminq.h
>> @@ -1179,6 +1179,78 @@ struct pds_lm_host_vf_status_cmd {
>>        u8     status;
>>   };
>>
>> +enum pds_fwctl_cmd_opcode {
>> +     PDS_FWCTL_CMD_IDENT             = 70,
>> +};
>> +
>> +/**
>> + * struct pds_fwctl_cmd - Firmware control command structure
>> + * @opcode: Opcode
>> + * @rsvd:   Word boundary padding
>> + * @ep:     Endpoint identifier.
>> + * @op:     Operation identifier.
>> + */
>> +struct pds_fwctl_cmd {
>> +     u8     opcode;
>> +     u8     rsvd[3];
>> +     __le32 ep;
>> +     __le32 op;
>> +} __packed;
> None of these actually need to be packed given explicit padding to
> natural alignment of all fields.  Arguably it does no harm though
> so up to you.

Old belt-and-suspenders habits...

Since this is the common style on the rest of the interface definitions, 
I'd prefer to keep it for now.

sln


> 
>> +
>> +/**
>> + * struct pds_fwctl_comp - Firmware control completion structure
>> + * @status:     Status of the firmware control operation
>> + * @rsvd:       Word boundary padding
>> + * @comp_index: Completion index in little-endian format
>> + * @rsvd2:      Word boundary padding
>> + * @color:      Color bit indicating the state of the completion
>> + */
>> +struct pds_fwctl_comp {
>> +     u8     status;
>> +     u8     rsvd;
>> +     __le16 comp_index;
>> +     u8     rsvd2[11];
>> +     u8     color;
>> +} __packed;
> 


