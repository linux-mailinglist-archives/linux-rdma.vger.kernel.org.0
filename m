Return-Path: <linux-rdma+bounces-11959-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C90AFC7DD
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 12:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A891BC51DD
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C342A26A090;
	Tue,  8 Jul 2025 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ia+UroGh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E71269CE5;
	Tue,  8 Jul 2025 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969169; cv=fail; b=l0FuFmRYAQydcW7q4PDg4W/dVQzVurpWdGMchaEgGqmMvFjkFuxGxzPbn+Timc8epYKiMe4PI0en4i1N39Fo2v2/LSg48mfcwq7xtCvbx8xd9w4M69uYBZBaWDSDs9RgE+n8UecvIulr9x4dWG+i81LV1L2Nz1IOScRIidvmKCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969169; c=relaxed/simple;
	bh=4lp4NE+MMTnN9ZqQ5LrUvGzeIJFs+EZn4ulD2QIXVZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BeIhYwaTBmn6Dq+AQhp0Az3GCvd4X+DQpyggMtd3wAeluiHZrlNA92cTq7VU8PlRnROUOCRs3G5B5y/rPncJIGwEa9EtSYhvkrT08a+Vd+dTx3XJ70x02uUDIq1IC/XEMsUznK3WFmNSfbTKWCWx4lSdol70LiRDjWPVzHYbEa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ia+UroGh; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGlMxIXoYl3XF8MTJSbN7NvnX3dyO6aMvt8E2Zc0jKYSHqcAy4Fxd+Vy2apKBqX3CZAAaEi0UhYHxMNyPIwGnfC9lfE3GqjQhmv9hD8P9BMyP2u2UibwjmVjtz2busVjDnaoAByMkwl1AP7SdMgngPe3YTAfP/wlgkQk8SXMdOYNDOienG3LpqhLvkLuXUuzMnATH5ao50JjpGEhrq6u4ZBaAQJSc2V0QC0dCZN91anp+D5wVRWEWUGhGbcgmJ3xzoDeKguCJSI1bbpvO+qxnGLw3bqdOv6avY7uqhaPuRDtjc5CEB6ESuhSHJ0Mj6JhPnb3hIfEydDbkdThsM5FmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOwmUQtDnLR2NUp5bPPU8QjL+02ubCDRR9lrfKa1t/w=;
 b=wUSufh93KpIjBvdWzq8nFXi+rdkaHJjYprtfSve5M0tmDsbtFTbNV0GPJ5I9klINpPIVdc+myAWmBpmwBKrELQtn4LM4YZAvXvQxElp3oBEaIJ1wov6frJAWotjdH77mfBPXHXVfw0nWSBJ/MCqSfIauxiNtViLbLLIyEzB0jgeiQs3sYzx41WAK0ml/T/mIQ6YZJdzkOPeZ8w4H8yxaA5mByaH5X8hZrlg6a+USX0OzkktWAXlFo92JJfATa8Y1wq/a3Aez7q960QTPkQdWlE1K0dMtzJghl0pkPDhmqTvPpY29jBxbO7q24nXCOi6U1ensmr68RVEKYyFnwmCHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOwmUQtDnLR2NUp5bPPU8QjL+02ubCDRR9lrfKa1t/w=;
 b=Ia+UroGh+OL08a9jhzkrAoTVnZ+Q5lu/eWsZh3GpJ0V0MwiPtB2YcUt9Prf3nhgWKAOnqIADUwZEa1eqeXQNcxlDPZ4Iue+Mjl0RwPo+Z/tFM3FFi2ZST//fajxIzbTw+aq4H1rwZrkU+H784K5sUChKDlvjqT+yH6VhLJe9+xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 10:06:02 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 10:06:02 +0000
Message-ID: <76a68f62-1f73-cc81-0f5b-48a6982a54c7@amd.com>
Date: Tue, 8 Jul 2025 15:35:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, shannon.nelson@amd.com,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, andrew+netdev@lunn.ch,
 allen.hubbe@amd.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Boyer <andrew.boyer@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-11-abhijit.gangurde@amd.com>
 <20250701103844.GB118736@unreal> <20250702131803.GB904431@ziepe.ca>
 <20250702180007.GK6278@unreal> <bb0ac425-2f01-b8c7-2fd7-4ecf9e9ef8b1@amd.com>
 <20250704170807.GO6278@unreal> <15b773a4-424b-4aa9-2aa4-457fbbee8ec7@amd.com>
 <20250707072137.GU6278@unreal> <1a7190d4-f3ef-744c-4e46-8cb255dee6cf@amd.com>
 <20250707164609.GA592765@unreal>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250707164609.GA592765@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::14) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: e72f53a9-8d84-47e9-be20-08ddbe070b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2JLYU94WUVBS3Y4NnUycmF6OXpmSHpiVVJnOHR3K2pEZ2ovYnl5RFExM0pw?=
 =?utf-8?B?dmZtOGM5MlpncHVKWHUxWS80ZWxXcnR6S0VvWVNYZWMrYTk4Vk1uYjlpZ2Rp?=
 =?utf-8?B?TXhGdnpYREJTcUNtQVN0d2NwZ1hmSm1hY2J0MVA4THVaRXhPdjJ3OFNQZTRm?=
 =?utf-8?B?NEUxOHh0dGlESHIxamRCd2Q2THpoMWhLVFJFRVY2bFFEMllMZUR4dGlzcjJL?=
 =?utf-8?B?L01pUGVRWTgxZnY1RTNGMFR6cjcvRDFnS2xzaEJkZWp2aXM3YnhOczBYd1Z6?=
 =?utf-8?B?RVpTKzVmcm5sNzMyeFpFUWdKbnc0OEJzQkdJN1JaNGh2NmxBRUJxeW1lbmNY?=
 =?utf-8?B?VHZrZnkxSm9CaVJzbUZxWWptMkI5V0xpMlczOEZSS2JLOTRhSEJwajJad21o?=
 =?utf-8?B?d0lldGo5cUhZM2NBWEZpdXlWVHdFN2ZKYTltNWRmSURrUnd4blZWNk44TWdi?=
 =?utf-8?B?aUJWQUUvVXVaWWVpekN6b3lqUUhKbE5xSEdQeDFlOStwNnNNTjJpdHdDcHU1?=
 =?utf-8?B?ZW4vd3RndFV3U2ZYcWRsYU5vYWVuZHVKRVJDUDVyNUd5dW9ZYS9IdXRDWWdU?=
 =?utf-8?B?VkcvRWMyK2tobVVQdnhqNmxmdGpybWtZdCtQYmQwS0phR1FYcGordXk3L053?=
 =?utf-8?B?ZWdadXAzSks0Z21oNFlrazZTaFlsUUxiL0pHTTMwcTNPanVzTHFVVEJOY1FW?=
 =?utf-8?B?VWVEWWZqS3ZLUXc3WlZib0RZbEtvV2JVZlNHek5jeWxYUExTSVRYMVFseGhO?=
 =?utf-8?B?Q09XMFhnZCtqQXZGMTFEQ3ovNlJlOGRHM3ZYSnJGNG5odmtjUjhWYmM5RHRB?=
 =?utf-8?B?bkdJdDJvWXVpZUdjYTBMY2kzelVmejJQMENUZE13WUdISnFGMDRzT2JDcDRH?=
 =?utf-8?B?enFTODFqdm1SSUxkbUExWlF0YndGRXFGdkMzeklValNjVm82Zk5CWTdLSWJX?=
 =?utf-8?B?UlE4ZWdJTW9ROW1mS2loa2xxSmQzZjcwcFIvL2duZlZNcjgxbjJHNHNBekZu?=
 =?utf-8?B?MC9YWUJndkdsTnh4T3lQYlZqK2dZdkkreFZWVmdEamNSY2FxQVd6Z3hjTmJm?=
 =?utf-8?B?Z0xacFltbGVzdDZ3WGl1SE16RGdUbzJ2S3RTalFLQ3E3SzhxdkZTNnZHTmtI?=
 =?utf-8?B?bjJmUXJZdHRKeG5HdnN5QURTNDcvWE00ZEhUTWExd0sxbUpiNkhhWGF2V283?=
 =?utf-8?B?RnYxL2wvU25hdTE4QXBtOHNkeGdVTWZwb0wzSk5EbTN0OHR5b29PRDViUm5X?=
 =?utf-8?B?NnJUNVE4bHlYSHJWTWEwcDFUQXVtWHpTbHVjQkNxYmZTQnJSR2Zvb3FzYTdB?=
 =?utf-8?B?L1lHRTA4M3hObU5SU0lKbWhvcnltUGI2VDRlVDFzWVRVZUMvaG9DSkRtMUJR?=
 =?utf-8?B?Q09wSTZCNjJwNXI5OEx2OWtSSWk4Qm9kaVZFWW96L1VCRjF3cWNiUlhHL0Ew?=
 =?utf-8?B?RU5WcENzVkRzUUc3UGdGckRHN2NncVlpT0tvYjNDMlhWcWRCZ3ZnNkZDS3RC?=
 =?utf-8?B?QVMrcVF6T0NUS21KbnpNTTJSWklSUTNWSHlISytFRHVXTGJEYjByZ3dSRVdt?=
 =?utf-8?B?MGw0TEtkRWlhRUxtWmRBN1F0bzRObytnS3hSeHhsMTZPSFFSM2d3aXBmVXVY?=
 =?utf-8?B?T25wREdIUmg0aHcyM3pTL1BaUStvbEJMVGQzcjhnbm5TT2hXeFVxR0dnbkpE?=
 =?utf-8?B?cHZBSkFUWktlTnV0ZG1LblBPRzd0eWlBejdGSXNUaW5zNFppVTYxMFhiR1Qv?=
 =?utf-8?B?Rk1hb29YSkY0M040Y1VEaHVPTGRZdXlWMUZJcXVvOUFZYnUzalptTGtZVlpW?=
 =?utf-8?B?cks4TzFtblZHN0xjSlBLbUhOUjk0QnMvRytYeTl2SHRQMERSeTdpQkdYZ2dJ?=
 =?utf-8?B?WjR3SU1lZXd4YnhudDVWUnl5UDMzRFB1amg1alhqaVBDMVhydys3b2tEVjFL?=
 =?utf-8?Q?POfXXSuAT4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm93YWVHSExob3A4LzJGQ2ozV3lDZzBOcHhyUDRya281TWdacDlTZnF5Q1ZZ?=
 =?utf-8?B?ZkN1STJWS1R3REZDK2k1Mit1OCtKNDRBTUxZTVVyaThJNUFieXpnS0Rac2Nt?=
 =?utf-8?B?bWFRYWJ0aVpqbi83NnlraWFtdkNLSEF5SWJGdHFja3BYQnhRenU5NDF2NkZW?=
 =?utf-8?B?eEo3aW1BbTFWemViaTZwUkFDc0lDaVc1UStiME14ZTJaMFdRQTNGQ0Z0Zjhi?=
 =?utf-8?B?d0JrWk4vRHBDbGlZcWg2bC8yVHRWdUtyb0FaendCdk9RenZiamJtZmRobWxK?=
 =?utf-8?B?OFdUNEMxTFlKcWt0VkFHaDFHbnNTN2JTWGZ5VUl4TXNUQUtPbkx2VFZtVWJP?=
 =?utf-8?B?SThpSUpUOXk4ZlI4OEtjaVErR0poUGdMZHFMQkRmN0JQRDNzaXc3aFljeWpG?=
 =?utf-8?B?RmM2aHNjb3lVcnVvU0VWMUJaVWxzcUVqbHZGWU5xSnZxNHVOV1F3STMvMXEz?=
 =?utf-8?B?R2I3a3NWTkoxMUlmc0dpOGxhWk9jZGZjOCtuRWEvYjV0YlRyTDZudWJjaURr?=
 =?utf-8?B?dzRuVE1OdjRuMnRGQ1B1OE01WGZPWStTQU5WL2orb29oNFk3RmVuUHNNM3dt?=
 =?utf-8?B?MGlDUlRxTzRJb0lOTnZ3RW1selZrN2NLLzFQclJuQzlYbG84MUN4V1VFUVJ2?=
 =?utf-8?B?R2RaRnNoWU9nano0cU5zeUROZFI1MHh2QTFPTXlMUFlmWVU1N3JXQ2dSWnVu?=
 =?utf-8?B?eDA0dXZHeVZCdnMrSmI4M1dRclphOHltTmt6ZW1QeEQ0ZkVXMlM0MzNKLzdT?=
 =?utf-8?B?cTI1cVZnaFFMTk1wVWI0bDJYNVc0OThwTlFxcUlVcjNPdlVWbjF5bTZIcWUv?=
 =?utf-8?B?Yk9RR2pFejJFaHRWVS9SbXY5R0Q1djNHV3NJZUc3bHdMVHZlMGgyTEx3UkZj?=
 =?utf-8?B?LytYNjJsTUNwZmVFeWFyYjNUS3VmaGY1aDhlbnJvTnRhb2R4b0h3R0drNDJC?=
 =?utf-8?B?Q3JORUdiTHhEY0o3Q2Qwc1NKLzlwTzJSUWcxQ1lpS0tqSDdmaUxJNmNGeFpk?=
 =?utf-8?B?N1dlekxIUytKY3pWKzJwckpjMnI5MldycEx4YVBwdDhNQ1B2S0VMa0R5N3Yv?=
 =?utf-8?B?TFhDaHhLd3pySlEvTjlhZDU4VEhGN3ZnQ1h4NzQ2MXdQUms4bFRCS01IL1lm?=
 =?utf-8?B?Q0JIUXBuclVEdXVnK0srZStpYmdwM3o0UUdFVGlGM1lkVldVUUx0SWdZYUZN?=
 =?utf-8?B?SUp0Nnp3MVl2WmFjVytZcXdtanZzL25SQjh2RGdwMXBnaWpocTg2YzNZYWtr?=
 =?utf-8?B?M3RHRU4xMVB6Nzk1WVE2c2ZMdHJZUnhzU0FyQlJtRDV5Qng5a3NPbC8reUFa?=
 =?utf-8?B?Q25PTTZ4bXF6VjZmUkxNbUIwdHpEYVVLWGNFMEJaajN4ODJzV2tRRnd5U3lu?=
 =?utf-8?B?cHRyQzcyMElkV2RXK1dlZjBnWXpGWjRnRVZucUZkcmwwMUE2YVFjVzh4QUJD?=
 =?utf-8?B?WDVDUWhzN3lVVHJYdjlWZ2Z3eHhmRWN3QjBvRUpiR0h3NWt1WE5OcEliZ1da?=
 =?utf-8?B?ZEdRenNvWlJvRjY2MXpSc1N6NCtsa2o5SmJIMEU4UVNZRi8vM2Zjd2R1T0RI?=
 =?utf-8?B?R0pIQ2FySlhCWmRoWUNHT2tHbGlFbWNabHpYQzNPL29sMDQzZzFjUE9RL3I5?=
 =?utf-8?B?Wk5kbXFFNC9zNW8wTlZDU0pSOHNDOVMwNFhVbUxGdlRtUVNlWVFuK2V0Ritr?=
 =?utf-8?B?VHJVM3NlTHJNU1YxZFl0WHczd1FYM3lZeElIampvd0sxU3dQdGdjd2lIVXdS?=
 =?utf-8?B?R2lqZ1NCWTBHLzViZHNIbVJMeDBXSUVtUC9iNXZRT3Y0RWxiTEdkSUNrWHVv?=
 =?utf-8?B?ZjJJQytMTFhVMFZNL2RwOXNHMzFwTEVqNUhHeHdSRmowakRCRDRlL0N3WHZ0?=
 =?utf-8?B?ZlJQOHAxOHN2RVZvR3BJM0F3Mlh1dHZ2RHRSZmhmNFJ3RjVhRFdQeXZBZHpO?=
 =?utf-8?B?NG1IYys2MERIZUQyODE3aStXWFZYb2IyZzZzUU5ndldrQVk2VFBheEFPejJ5?=
 =?utf-8?B?VWdjV0Qzd2QvdjZ3cmhrUWlUVDdFN2dtdTVPVlhNenFqbmY0dGJBWXFkbGhz?=
 =?utf-8?B?dVVqZk9MMk1McHBucko1WDZVSmhCVnBkT1c3czdYck1MdkN4KzBPN21vMGs1?=
 =?utf-8?Q?PA3ZPxjrfqTv26r73mWYwm1uD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72f53a9-8d84-47e9-be20-08ddbe070b37
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 10:06:02.1894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Sxm6/X4m5eu8E1xvUrVJDxwyyMaYCng+Dz8ppeqTGgcmDZo5cKL5OlwBD2d/r09fs6S/A1F6ooC24H1KloLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148


On 7/7/25 22:16, Leon Romanovsky wrote:
> On Mon, Jul 07, 2025 at 08:26:20PM +0530, Abhijit Gangurde wrote:
>> On 7/7/25 12:51, Leon Romanovsky wrote:
>>> On Mon, Jul 07, 2025 at 10:57:13AM +0530, Abhijit Gangurde wrote:
>>>> On 7/4/25 22:38, Leon Romanovsky wrote:
>>>>> On Thu, Jul 03, 2025 at 12:49:30PM +0530, Abhijit Gangurde wrote:
>>>>>> On 7/2/25 23:30, Leon Romanovsky wrote:
>>>>>>> On Wed, Jul 02, 2025 at 10:18:03AM -0300, Jason Gunthorpe wrote:
>>>>>>>> On Tue, Jul 01, 2025 at 01:38:44PM +0300, Leon Romanovsky wrote:
>>>>>>>>>> +static void ionic_flush_qs(struct ionic_ibdev *dev)
>>>>>>>>>> +{
>>>>>>>>>> +	struct ionic_qp *qp, *qp_tmp;
>>>>>>>>>> +	struct ionic_cq *cq, *cq_tmp;
>>>>>>>>>> +	LIST_HEAD(flush_list);
>>>>>>>>>> +	unsigned long index;
>>>>>>>>>> +
>>>>>>>>>> +	/* Flush qp send and recv */
>>>>>>>>>> +	rcu_read_lock();
>>>>>>>>>> +	xa_for_each(&dev->qp_tbl, index, qp) {
>>>>>>>>>> +		kref_get(&qp->qp_kref);
>>>>>>>>>> +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
>>>>>>>>>> +	}
>>>>>>>>>> +	rcu_read_unlock();
>>>>>>>>> Same question as for CQ. What does RCU lock protect here?
>>>>>>>> It should protect the kref_get against free of qp. The qp memory must
>>>>>>>> be RCU freed.
>>>>>>> I'm not sure that this was intension here. Let's wait for an answer from the author.
>>>>>> As Jason mentioned, It was intended to protect the kref_get against free of
>>>>>> cq and qp
>>>>>> in the destroy path.
>>>>> How is it possible? IB/core is supposed to protect from accessing verbs
>>>>> resources post their release/destroy.
>>>>>
>>>>> After you answered what RCU is protecting, I don't see why you would
>>>>> have custom kref over QP/CQ/e.t.c objects.
>>>>>
>>>>> Thanks
>>>> The RCU protected kref here is making sure that all the hw events are
>>>> processed before destroy callback returns. Similarly, when driver is
>>>> going for ib_unregister_device, it is draining the pending WRs and events.
>>> I asked why do you have kref in first place? When ib_unregister_device
>>> is called all "pending MR" already supposed to be destroyed.
>>>
>>> Thansk
>> The custom kref on QP/CQ object is holding the completion for the destroy
>> callback.
>> If any pending async hw events are being processed, destroy would wait on
>> this completion
>> before it returns.
> Please see how other drivers avoid such situation. There is no need in
> custom kref.
>
> Thanks

As per your suggestion, I looked some of the other RDMA drivers. While 
many are using locks, that approach would negate the lockless lookup we 
gain from the xarray.
The MANA RDMA driver, for instance, uses a similar refcount and 
completion mechanism to handle asynchronous events.

Thanks



