Return-Path: <linux-rdma+bounces-9839-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66122A9E717
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 06:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9293B9190
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 04:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C08C191F94;
	Mon, 28 Apr 2025 04:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ABm7rFgO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996BEFBF6;
	Mon, 28 Apr 2025 04:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745814870; cv=fail; b=HwXh5qHdx3SRRlj34EbvV8CvV2AiRYzSlxv2wIuhxpBQxpm8W/qykG0Q1T2QjIaQ/IrFICo5pE74lZtIcjEM0KqgQo3gAMDj/+rSjYrdXdXiTKC2V2WN3eMj3zhFuUWUNxVQji1aBkwgS2aYCvTyeL4cA8ii8veqYewiRaykjgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745814870; c=relaxed/simple;
	bh=p9gPTGxjSSpRyJCWuYPCeJu/4cS6rlrp7ohvW5a7Zwk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C2Qy8zJ05R2JM3FbqbzrgmQgIwFaTeEIXsd+WjytOfRoq71YNw3/OHcRQyhUfoyddnK10lS5wHbYURqUb3YCAJV92TtlFpGjWwvQk2a5hDxdGVSIV9G1p51p7HzeMzXQe+alr1NsT+GqBcQtOvLBSxec5+rwJ40gV+PzFzzve4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ABm7rFgO; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7gG5NpQwPszLV+Qv12ZZ8uyXNv4pX/XSivNGyYX2XRMSaQkTUMAJIHjaPhytfT1IxSEiOtQXgh2IzzHJXdcxCD6urPLKwOGzdoJ+VpCksQkEmz3RZwCcm87PjCEb1t8covFAu6M/rGAxXFPJuHZgPeY8WDgWeefraip6vzquSB0wN++8yp1a/W/vgQUY9CByHYI4H1IXDTECm6mG/tMzy9hfIYuG48pDzdhqkhJXBBpBvf8UFaCZg/FmM7EgZ6QQC0fv1pvhzXne7MWQIfx4SX7W9eK9FwCFo07Yoj3UejaDvZ6RfkA0d3AxT7Xm3zNiCZ4d2mEFpmUqNdjaPO8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=namc4BZg0I7+Ot9q5pL1eXy+cjorM2YQORFIehBisQs=;
 b=pbIYkd1cvShGOJkwoLEBZgL202BmRBAcXINBR7c92lA2MVIz/HzX7VjpB1texbNU/j779YFSNQv+07GAAJkiTB4Tf7aRYTs5z7MqWVCudztyhG/Bwq/4H5Ggq6PYQIuljpOabdq0/ROSCgw2eTYpQrvMTHQIGZU+X5Jk8l24h42jSEaBoAHZFGfPVqpSFLFu1FhuAQMDw2ucEOAKm9x8QBUB1ff6qGcPLA9TT7lWMQ205cUNIObebgSZ1ykLukKWxLeylzUj10LZmW0QGnyzBoxZCy1DrgD3E9ZwtwSzS4g80zXPNwYH4BClERQWgWOHkET5owWyGdTq/4psiGsn9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=namc4BZg0I7+Ot9q5pL1eXy+cjorM2YQORFIehBisQs=;
 b=ABm7rFgOlPm+A6h7666S4aHzd0FSc6KB/kRmfjHLKOZnaGiiToHB8mftc33hbupTA5U1acAUoHKAmtnygLFWvMAOukioYv7iwaiVyghXBQSkW9Fy0DiMf8ajVxHrl/JXWZGr8pA6wQVs2LEViOz3IrlmJdBeIK2uHTCK3zmCRmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 04:34:24 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 04:34:24 +0000
Message-ID: <4335f6ee-8e22-84f4-4836-552ea09f1df5@amd.com>
Date: Mon, 28 Apr 2025 10:04:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 08/14] RDMA/ionic: Register auxiliary module for ionic
 ethernet adapter
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, shannon.nelson@amd.com,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, andrew+netdev@lunn.ch,
 allen.hubbe@amd.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Boyer <andrew.boyer@amd.com>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
 <20250423102913.438027-9-abhijit.gangurde@amd.com>
 <20250424130813.GZ1213339@ziepe.ca>
 <ab361812-566e-5454-ab2c-40757a8808da@amd.com>
 <20250425171005.GU48485@unreal>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250425171005.GU48485@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0044.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::14) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 9378c109-592b-4691-31be-08dd860df3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MElXbk4vZCtHVWNmL1p1OVBkd09DSU44aExGK1BEdWRIejNNcmRyNFVRcWVO?=
 =?utf-8?B?RDJqQTVmRTgxU0NhRGIwSmlmRFBLaE5lUEFVWG04Y1FYaUxhNCsxeGtGMmVE?=
 =?utf-8?B?K1FsZ3ROeTg4NTRsMTFmWFNGMWZJWENsN1dReFJZYW9kSzRjTDBEODkyK2h6?=
 =?utf-8?B?L2U4ei91VGJ0Z2JRTmZvQ3NOVmZaanNHaWRIRVlVZUVlb3FTanJTTVozNEtX?=
 =?utf-8?B?SzV3bjUxcTdvWmF4Y0JrQ0FqelJRYW9QZ1Zmei9xSFc4SGkveWpZZVY4R0FN?=
 =?utf-8?B?Nm5OdjJibmxXOFRHRFpWN3Zsbmx6Yi9DeTRHd2lrNHdNcVhKYUIwUnltMDkv?=
 =?utf-8?B?UGxkV2s2cWFxd1psYm5DWTdaT1JYZVVmNW9kcjU4S3RKZzJkQUhQNGd3cmxE?=
 =?utf-8?B?Z2R5Q0N0T3lkY2ZBaEpacXg3ZlIremh5eVkwSUNSeGFNME9WTUdiL2RLSVZK?=
 =?utf-8?B?VnB0MlU2a2VnZlBnNkhXUTdsdVR6WnhMRjFDN0wwR0VwYVJDZk54Z0l0bFUy?=
 =?utf-8?B?M1VPMk8xS1F2Vm5RT0tGNDdZaThUQmVmRkh0SmdCQldXRktIRnYvZnZGdDdr?=
 =?utf-8?B?VkV3UUVhQjk3VFpQTkVhc29RZ1R2YXVYVWNZaVpjS3ZxRlphakV0WDB2ZmZp?=
 =?utf-8?B?WkxvcHpnVGVEL0dUdUJyOWlZWEpySmdJYlg0a2NwWWxSS2VoS2xIaS9haEhQ?=
 =?utf-8?B?Q3lKS0JrV0lTd0VyUjV2ZkVlMW9PSm5iSlR3M1MwSUZkQWZ1Mi9lTVplZytB?=
 =?utf-8?B?cCtFN0hKT0MrNFF3RkNmUzFGWkRISjg4VlZaWmIwTFFEV2xjK3pwZ2hrbHQ0?=
 =?utf-8?B?dW5tWlJoY2NNSk8wSyt3WC9rQWkyYlVFcGt3NkRXRGdnYVdQUG9mTHd0TWQ3?=
 =?utf-8?B?MzFRblNDWjFqWEhNc0FabkxXVk10K2UxczFpY3JtMzlXcUtvb2FoTHVGVHU3?=
 =?utf-8?B?RzhEWVRlMGdOZ01VRzBNc0pXcTV5VE00SngyYVNleXZ4aU1GR1VrQTdWWlc4?=
 =?utf-8?B?aFp2SGYvbFczSUhTWVBzQm1YeVBaYTh6TkNkMDJQMXgwSTlQUHVUMHVySkJB?=
 =?utf-8?B?YkYyc0cwVG1VNFNVT29lT25XdjF1QkpaRFRLc0xGbTNHeVBNRWN2L2JzT2Ey?=
 =?utf-8?B?b0NmWVF4Zk5aVW5tbCthY3lhOCs0amdZVzZUaVd1dFRFMmVRU3hxV05yL0p5?=
 =?utf-8?B?NHkwd0wxL0xrTDJKMDFXa2poQ0ovTFhMN3B0NFhtMnFrRkthcW02V2hva3ZN?=
 =?utf-8?B?L29VK290UW1wc3NSR3c4dGpYcVpBQm8wY1h1WndoeU9uaGpUL2U2cUxXaWZD?=
 =?utf-8?B?MlZ1TnBhenNqbGw1WlBHQkF2OS9SSHRvZFU5Z0N0UjdNMXUxS2lhRzlteVlq?=
 =?utf-8?B?bGZodkwrTEFzZnQ5MUJSSGpVcjlJSTdLMXdsNVIwNWxlWk0vSFoxMWJWajBO?=
 =?utf-8?B?WmExK2xOMFlKNlYwMGxTY0hMcGQraW41cTNjTm4xODFkSEZ1Zkt2Nmx3ODZZ?=
 =?utf-8?B?S0RGSHRRWDJma1pyQlJUd0NPOG5WMExncjdFck9XSkpEZFhSSzZ2WmpiOFJ1?=
 =?utf-8?B?R1BDV2ROZys2WGdESThPVDdYT2ViejhFSFU4eGNVSnpLVjB3bTJzbFpYSzhD?=
 =?utf-8?B?M1djOUpRektwclhMSXNQR25oK1JJL1dVS1l0cEVXRkdqQUNjL3pidHZKQlVw?=
 =?utf-8?B?cVMwdFZYcFJxMFBSRmYrR1Q0ZHdsSXJ4elBPR3pJcDlJVU9wSEpTdXFOc0hC?=
 =?utf-8?B?MWhPZFF3QXBGbkg0WmwrSFhQRElZcTNWNkRpNHM2MTBWcDFNY2hLNmNMZk1p?=
 =?utf-8?B?UmJBNFkwZHpGaUVsTlFyZ1NnREQ1Y3lXa2xIRnM2b084K2p4OTNsWnRjVmgy?=
 =?utf-8?B?S3hncEtGSXV0TFNGa2x5RG5wVDAwS0s0cjdoeHl4Z0RRY29XenBoZWZ2UVN0?=
 =?utf-8?Q?uyLx2ZhgvvI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEpwRzh0eTQ4cklFS1kvUU1WNGJUNXVISnVPOGtKaGhRUmxtU3EvUnIrS1B3?=
 =?utf-8?B?MjlEODhpV3cyRHBnVUp3ZHBOTlBKRnRacWNtSGlObjJlODhnU1UwN3VVY0Q4?=
 =?utf-8?B?eG12cmMzZEdCM1ZLOGdRTWFteDZjd2w1eWhvVjY4S2xNSGEvWm5rZzFxWTAz?=
 =?utf-8?B?U2Y4ZkxHa291SWlZWWFIUDgrcy9XWFY4bGh6dE1lcDQ3REMxZkErSnFKV2Jo?=
 =?utf-8?B?c2JEOG14TVFPWElOTEV6WnlPeGRwUjhZbnd2cVo5ZEhZZEcwTHh1dGlwOVAy?=
 =?utf-8?B?NTF3RCtWZStBcUFEVVBpemhkR0hUUUY4dUcyUk4zalFCUlNsNjYxWjBoNkFr?=
 =?utf-8?B?bkxkeUc4N1lFR0VudGlNZDhGU1VLeWxrTEZvN0U3Wjl1amVucjAxb0Fza2tz?=
 =?utf-8?B?VGUrRzltdXgyckJJRVNoMWhMNEd1M2pwcE4vUG83Y25QN05JMDByUTlNZzdl?=
 =?utf-8?B?VCtrVFJUV3FIS3o1SWxGcGJpZkhqblJBSGdlWmRQaWwvbmdQQTBKZ2ppY1RB?=
 =?utf-8?B?emNleEo3RFFxMGlhOVNWa2RCemVFSWExZmRHTTQ5ZzZGRi9KQUFMRW44akw4?=
 =?utf-8?B?ekJhUjdqR2NPNW9rVC9YV2g3WFRFd0lkMlY2ODJVNzBvdDY5ZWhyQlJzeTRD?=
 =?utf-8?B?aitMVVpsN283M3BBR1lXZzl4VXRwb0JmZWZZSVFlTDRXUEgraWVLUEFoaU85?=
 =?utf-8?B?czdFZ2lhL0tyaFByeUxFc21DZlVuaG0yVG9qUGJoTjlycHIyb1prN2NlQ1lQ?=
 =?utf-8?B?Y3Evb0xHM3lMQkFPbTg2RlhMRlRwOFhPczlyZ3o4d2pyenZrayt4QllqVDJ1?=
 =?utf-8?B?OFNRdEovdlhGa1YyTmIyZ2V6dGpLcnNoM0IxbE56OXBMQ1owVkl4bTRUM05m?=
 =?utf-8?B?eXBFWkwyOFJMRGsvZ2kxVW8yYzRDcDJLZ1loNlFWSHVqVHJ1Y1YvV2xWQjdL?=
 =?utf-8?B?dkR4eE1FMHNIVG1Rb252RHhuWVhRNDBNSy9NRTFrODdhNmJyOGwvdFpPREI0?=
 =?utf-8?B?L2NTVHEzVnRGNVRTU2d2Ny9oV2Z5WnUwU2Q5VzhJR0E2b3IxNWVQSWNLc3ds?=
 =?utf-8?B?N3lFNWdJTlp6eUw3RENuK0I0S0pyeXZqc0Zrc3FzSmErUnBDVTVaUzRKOUp4?=
 =?utf-8?B?b0dwYzl0aFlRbWQ4LzFxa0hZK1RJWTdveC9vZC9tWXl3YllTeW1jVWhRb1lF?=
 =?utf-8?B?K1NHZHJld2tqcjhFVnUxZW5IcXVaSnJuM0o3L3dYajZBV2FHSlhBWlZpN2ov?=
 =?utf-8?B?aVJPZ2J1MmUxN1g5T1JqZnhLUXdlcHBXVG5Ec3crZGZMSXZPMDY1RUJoaXdh?=
 =?utf-8?B?UzNkQ0RLMHQyTGF2UmsrbkZZblZDOERtNXo2dTRFdWN2ZFVPUWEyandJZzNW?=
 =?utf-8?B?cWNraXVYZWkyS0dva21KbURCZW9zNWx6RStQVkN1aTlsV1FrTmo0RU1ZSGx1?=
 =?utf-8?B?ZWJaWGVZZ2dsYlJ2Z0Z4c1hmZHYzZlVxajNvVTJNU0xWVGJxNUU4L1R2TWUx?=
 =?utf-8?B?Qm82WmFwSmpNSUxnemM4SUJWUUtZTE42Mlc4ckhCNnFXYzA3T2ZPaE9FbXBZ?=
 =?utf-8?B?S2VqRkJRNmw3MDN4bXFJQnlrN2VBOVFUbis0M2M3clJjUElieEozelZQa2dn?=
 =?utf-8?B?Y0Z5WTJFUlF5WlZ0aHpiOXpaT0FnK2VFcG1uaExGVjJHVGFYWG9BVGluTE96?=
 =?utf-8?B?Q0xIR0VRUjg2ekpPeWttMSs2RVBSV2E5dDlzRlNXTTYzcjB2WUlMSm9LNEl4?=
 =?utf-8?B?R3ArN3h0TUZITlQyME1FUFZJR2k0KzJhcGFqZVoxdDVJcUVyeTRyYVM5QUIr?=
 =?utf-8?B?ZFFsL3VBYlU1RTRkMW45THVVT2VkVjJmSStoalNTT0Uxbmk1YVg4d09pNjJK?=
 =?utf-8?B?eGdZN3o5ZU1FVVdPYk1MUGlSbEhhcUFyU3gyY05QOVphWTh5Y1NNcC93Ymxq?=
 =?utf-8?B?NHF4Vk14ZmZ3VVlmTEQwTUZsek5oYStCQTd0b09GKzFEenlRdElGaENIamlm?=
 =?utf-8?B?WDRvKytHTDVSN3lBTW5pS24yZ3FHYlZuL0RrTzJSWHdkVlFteGNVOWhvdFZx?=
 =?utf-8?B?Y0p3T3duMGNUaXFmRytLVms3d1lqNEJ2TkZzMnFEM1Q4ajE0Q3ZLbDFvZVdD?=
 =?utf-8?Q?weHZ3V8F3d6NeGnlIt9eqTMGn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9378c109-592b-4691-31be-08dd860df3c6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 04:34:24.2082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kq4J2Zhp00MH5OpgjriAnnv88IL2cKInVvD7s37l7evYxhy8RhKZ/Xk6qSsb8EqHZ7Mifu7Xw+muR5jS/sUsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263

On 4/25/25 22:40, Leon Romanovsky wrote:
> On Fri, Apr 25, 2025 at 03:46:06PM +0530, Abhijit Gangurde wrote:
>> On 4/24/25 18:38, Jason Gunthorpe wrote:
>>> On Wed, Apr 23, 2025 at 03:59:07PM +0530, Abhijit Gangurde wrote:
>>>> +static int ionic_aux_probe(struct auxiliary_device *adev,
>>>> +			   const struct auxiliary_device_id *id)
>>>> +{
>>>> +	struct ionic_aux_dev *ionic_adev;
>>>> +	struct net_device *ndev;
>>>> +	struct ionic_ibdev *dev;
>>>> +
>>>> +	ionic_adev = container_of(adev, struct ionic_aux_dev, adev);
>>>> +	ndev = ionic_api_get_netdev_from_handle(ionic_adev->handle);
>>> It must not do this, the net_device should not go into the IB driver,
>>> like this that will create a huge complex tangled mess.
>>>
>>> The netdev(s) come in indirectly through the gid table and through the
>>> net notifiers and ib_device_set_netdev() and they should only be
>>> touched in paths dealing with specific areas.
>>>
>>> So don't use things like netdev_err, we have ib_err/dev_err and
>>> related instead for IB drivers to use.
>> Sure. Will remove storing of net_device in the IB driver and its
>> references in the next spin. Will wait for some more feedback
>> before rolling out v2.
> The problem is that coupling with net_device is so distracting that
> both of us are not really invested time into deep review of this series.
>
> Another problematic pattern is usage of "void *handle" to convey
> information between aux devices. Please use struct pointer instead of
> void for that.
>
> Thanks

Thanks. Will address these in v2.

Abhijit


>
>> Thanks,
>> Abhijit
>>
>>>> +struct ionic_ibdev {
>>>> +	struct ib_device	ibdev;
>>>> +
>>>> +	struct device		*hwdev;
>>>> +	struct net_device	*ndev;
>>> Same here, this member should not exist, and it didn't hold a
>>> refcount for this pointer.
>>>
>>> Jason

