Return-Path: <linux-rdma+bounces-8749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD694A650A3
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 14:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBE1174CB5
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 13:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CFA23E34E;
	Mon, 17 Mar 2025 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s9rzYRJa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942522E40E;
	Mon, 17 Mar 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217737; cv=fail; b=F1qWnY/OH+EqJeUIQRNiPiVoaMkQ83TJha4F9hbDxmw05MbNqGwSc98/0sPHcLWJY6gFzPFDqEoENenpdL+Uh8D58EKiWVFMiDsCsyTAPUMbVoiv7vzUDeWmbTnBygk3AZErOFQTowg9MuY990DlflJrDvVTsEYO+gNEPspEjo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217737; c=relaxed/simple;
	bh=Gv+NsDc3cXgcmbmSxYhDotTPOQGtUCtPEM9J+aKuic4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PY+hZeVx2RZ6vx2OapVqNORd9Dc/UQhtwq4UNEnpMt12rjbyC23sX5s2eU+T3de4zeoxGN/x4M3F+4dV4Ptla1wf3Ox/yd0L3kvqGgN7iNb/9rSh28i+ZCeuJfHhfDHoBk/KJWinrodfLKGEu2KxOdVD0TMmK5+dTocdUg9/42Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s9rzYRJa; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHdiwtRPdtxbA/zAMKjWsqIazi7/d/fel5r1KfccIcQMA92lM318MmFL/12sPOawDoTmV0qJto2vGdqpJXGGz5FcLYXv6vyauHvhhUTKF0DFbclf7tKdLnSX/oSngNLv1ZpHG59q70tmx96Pk85k4nH7MgxkmEswFI5cwExyDmpGLDVc51Zdc5FaKD3h2nc2GBxc63tAFgAMruIuMiZZXtIFyco4ODs228s6mPUSGqYhgs2cxk9JURkhxXBqu3w2eockmoNURzu/wHR50Y1x3N6DMHKDAqBMibJtCMhm53x3R+98N8FcfGw1+N75LEyYbwMB5l+NKcAt0RjLRwUwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H8nMIJyPCx67iubxI4jnH978xSbTbZkM1KFwH/JvGo=;
 b=UJtRGeqrJ9JY7JOMh8kXdZBcXSYVvZ/41Ty9CeClKLlFwn5HDDmCf/kjY5RyYIzFOQfzm3mqTF9SqRMdL8HbRKstsdHOAJasJzwGi9vIL3sM0C2fpr68xQNHG9kdEPFS1EIRsVqCtxhlpWhwRNMhfhv5/jDcfhwxZE9mSmoYptmuagvqVpR52wnhTpLUIiV5av2OTDgKoaR+WF2EBPTKYrMt+AxpCZmZon65rLtdBDsyJcP9l2k3n2qPSbxBNrqP3ROreo2mHwpv/GVT05gW+1mBvZf8KalNLsqalbkLHlTyH4R2ngVQDvjA+GofjCD9oBR8ruL0ajDPGiNiH3u0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H8nMIJyPCx67iubxI4jnH978xSbTbZkM1KFwH/JvGo=;
 b=s9rzYRJaCSm40otgdABCrg0UxoUyUccCiFHV3o1i1CvqSV2y8ebOGy/voJMnKCJOF9S+N6/uCIXbtHKp7xgoodUtKFmUU9SvbgFbOpOLY1oIqkpynWRTjfKxIjUC38Er4JNb4bjS/AqOfXhwdv2V6VkFm4nmZoRzCpvSuhhUJa/JjApZUjMkY46MRBLu8cfq5twnvWTb15jgI5530IWUELTFty5ZOcZYGc8N1DEEe273UOYugG2QUrzrjAlLnxZ7bHzpiRXl1SBGRQqJEuhv6INc4xB4gngfit2HaucVhUCucG7Wta7EDRKW8/NxFEbRJaEvirdbCEGdn61NVfvKtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 13:22:12 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 13:22:12 +0000
Message-ID: <635f8a25-83d9-48e5-a19c-c8f2b0fcd0bd@nvidia.com>
Date: Mon, 17 Mar 2025 15:22:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] driver core: auxiliary bus: Fix sysfs creation on
 bind
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 leon@kernel.org, shayd@nvidia.com, przemyslaw.kitszel@intel.com,
 parav@nvidia.com, Amir Tzin <amirtz@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>
References: <20250317103254.573985-1-mbloch@nvidia.com>
 <2025031710-herald-sinner-cbc2@gregkh>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <2025031710-herald-sinner-cbc2@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0289.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::18) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f462a4-22de-4413-715b-08dd6556b9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHJtZTgxOUowUnR0TVlmVlc2aUtoU2JMUDZYOHZ5V3JQZmJUOW9iRXNrdG5F?=
 =?utf-8?B?ZGZ4T3dsQXZ0NGZ0cFJ0TElPbnRQNW40WGxjT3VwVWJ4R3dBdEpSU0VkaXJa?=
 =?utf-8?B?VktEbUxJbzYrNjhOaitwQzdMaThURHJaOFVvYkh3QlNwNTZjWERyNkRnTkl0?=
 =?utf-8?B?WTRDNUZHRWdGZlhrL0V5Y1ZsbWladFdaeHI1dnZhYVgvSWoyQmhhU3F4VUpw?=
 =?utf-8?B?NWNmZi9mOG9Pcmp6MHZ0L3NlMDBPN0NwTkQyTzNWQmtRWGhUSjcrTFJGeHZs?=
 =?utf-8?B?OGVlTFNEVEdHTTZrM1NoKzFEc3pnTEVxakk0VFlrcVRxYkV0a1U5OHJENXJD?=
 =?utf-8?B?OVR2by9sblJGMDFXemgwYVJCbi9Pa0FWU1ZRaEN6NXFLWjlCQ1ZheVk3Vzkw?=
 =?utf-8?B?NjQyR2haUFh6UGh5YjJPZ3hYbURYcXlET3BIbks5b1B1eW9NODZlSFB6aXVr?=
 =?utf-8?B?TnR2OG93SDNZSEZITVQwd3FjbmtRaUVoSW9NQytHMXd4Nk9TWG9IcVlJa3gy?=
 =?utf-8?B?WXlKMWEyUmN6VGU2VjFtOXl3WWx2UU52cU8wdVMyVEkySExubHhMMld4elJ2?=
 =?utf-8?B?NFg5eWhsODVXVnlEcHRMY2NTM04zbmkwUDgyMjhKZlJpbS9Qb1ZOS004WEZ2?=
 =?utf-8?B?YVVYOVVrVVZ6dVpKeENZVUN2L2FObXNCOGNLOEwzWVE1NXFRSEFjdzJiTzA3?=
 =?utf-8?B?c2JMM1ZDTzZkdlZMZFZmVllvTENaYmlKdm5jZjVlSXBvSFpPQXpld0Y1WFI1?=
 =?utf-8?B?V2pVZHRhdkNaWHdwOXZtRVRYYlhlMlB5WHoxMlJiOEd5TzkyMW5MQjNKMCtY?=
 =?utf-8?B?LzVZNzlKTi9hL2o3OEE2TW5jeDdGQmtLLzlEblk4aWNVMVNDcmVCRXZKbUQy?=
 =?utf-8?B?bytPa0loYVdwU0RaQUJkTWQ0NHVCMDRMMTdKTThIVXJ6WlVCMG51VDZzUWhp?=
 =?utf-8?B?LzhJdDg4K3JrK0pSelF0WTdmL3lyaFBzZmNHTzJ1cThNS1dwL1ZGVmdYeGRE?=
 =?utf-8?B?bUg4d1NxV04yakdLSW1SYTI3NU8wemlmT1hQZVd3NjJiY0Y3RGhkb0ZVTUNN?=
 =?utf-8?B?d1pRbU8zbEt1L0E2WVJ0QnhITzNQVmhYNnIySlFHZjZtWWNzOEkrVjRUWHVw?=
 =?utf-8?B?ZXpJOEZqYXprLzNoaFdUVHVoZTh0bzY1d081YzNhSkRkTzVBTDIxS3E1ZVNn?=
 =?utf-8?B?N0p1eEVLc2FBdExSWWt5ZUVkTHJBMWZqOTZaRnZjTWRkQWs5MTNSV2hYOEFJ?=
 =?utf-8?B?SVdCQVJBd3JPdzRRRmp2aHJZejAyV0wzcUVPYzQ4eXJHYlF6ekRjRi84RFNr?=
 =?utf-8?B?L1krUXlvWERjWmtkVGh3MjNlWktWQXYyUkQ1amtEU2lVUHI3c0NBcllDcGlF?=
 =?utf-8?B?eExtc2M2aVY5eHgrRVVFZ3ZTd2JGQndBcSsxQ0hjNjAraHF0VGwrcFdSb0Zl?=
 =?utf-8?B?a0tUcmtmdVdDL05CakxMdVhjcjZvd2MzalN1WWFaN3JjOG12ajlnMVkrQ0Yv?=
 =?utf-8?B?UFJYOURnb2ZXcE92WnBpQTY2NEhTRjJlNDE2LzE3d0tuU2NETVd4RTI3ZnBB?=
 =?utf-8?B?ZStoS3FJQmEraktWQzBsY1ZBZ2JrY2NQYWNWNCtWZnFPdjhPWVBnb1BRcXhh?=
 =?utf-8?B?UmhUV3kwSE1YU2dKbjJlZTJMN3d1ODd3eVNkTVl2ejVTY2lTOFd6NFlyU2p5?=
 =?utf-8?B?T2REWHY1RWc2ODQ2NVZBNzlNSnJUTFI0NXdJQi8rdElkTUZIQm5vcFZxZFE4?=
 =?utf-8?B?MVVaNGJsWEhaVUkxblBydlVLNFZ5MHMrRzkxS2pPRVd4RFFHajhqV1NZZmY2?=
 =?utf-8?B?TVRmRS90NkU3aXFpMVhoSnNpcjcyQWNuZDhZeWtLdytUSWJyNmQrTlF1Vm45?=
 =?utf-8?Q?YcK22R2e78QHl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlZXNE1iSkZJNVYvdk93UTdlcUl6NWlvZlROajlpa09qTG9JU2Y2UWNrQUpr?=
 =?utf-8?B?SmRuN0xjM1ZYUG8zWnpKUmVNaXVqMHdpYVVZL1lkbmpJNlYyaVV1RzNHWFl5?=
 =?utf-8?B?bGM2U2pqUFl0SVlaeFdXZExuZEN2cWdldndtQm1WMTMvdTVsQVExSDVxNUJu?=
 =?utf-8?B?aDRLa1EydGxFd0xqdTB1ditZOWdhdjE2NkhvYWRIQ09DWEFRZ21rYWYrdTFG?=
 =?utf-8?B?WWN3R28yaTl4Q3VMcmVyT3FJN1RDWWdYWmxSeGJLUTVTeHBKYjJSYVRaVXhk?=
 =?utf-8?B?QmtmRGpqME11MnpxeUVTSUVxODBMU1pYTmRua0NBVkhvdUM3L0lYV1BxTDAv?=
 =?utf-8?B?U2VmU3AvWS94VHNuWkFadzMyQ1dzdDE2MlJqQzd6TlVUTldwTnNvM1dVWEE4?=
 =?utf-8?B?MGJ0amdVUjNPWkI5VTF5YjBaeElDcFZrdHM3NzhYNjErVDVVWi9UVDFVYzdr?=
 =?utf-8?B?bzJpakpPeE9SSTgrdkVrS0JUWEJWYWpBeTZVMDRNdVdpS3lISk9vUGpVc1F3?=
 =?utf-8?B?OFI0ZXBTRWlXSWxoQjF0Y0FuS1JiQzhZdWxVZUg4MnBXc0I5VFhFZENORE1U?=
 =?utf-8?B?UURNZmg3clRrYlE1WjJERmpiME42Yk5uWHlybmw0Wkt6SkNxN3pYUG5UdEMy?=
 =?utf-8?B?REUvbFdKMnFEL1pTTElhTG5tOG9hc0dnUkxCWGVobHlKN1BzTFNENXlIQVVR?=
 =?utf-8?B?NFVRQ2EyS2I4SDJONzRoclV4ZmpFZUt4cjU4cm51Y2NEU0FQUzVlb0t2U2Va?=
 =?utf-8?B?ZXh4MiswaXFlWW4zdGJpc2hkb3pLWEpkYUxPbThtcWVaT0E4TnM1bEtNeERI?=
 =?utf-8?B?NXpSaG1SeEhGMjZ2bUg4dmF6ZkJ3SE4zSE5jNDIxRlF4RFJZTTNaaTk5akN2?=
 =?utf-8?B?VmtES01Sb0lxTkV2M2M3eURUTmNOWmZwWXFFWWhxU29EcWx6dEFLSmY4NjRO?=
 =?utf-8?B?Mk9hVzFzSldLK3h4ZnNiTFU2VUxBQjJjdkxEbTJoQ0RidFZSMVlyWjdHbE1z?=
 =?utf-8?B?TEhDb2Q4TUNZYkJMUWNUVno4Z0pScUZEb0hTSFMzMTFIOHZPRjdpZkdxalNv?=
 =?utf-8?B?OWZqS2h6SEV2cG04Q2t6OW55bFhJVDBlbmFjZzhrOXJDSEp5NUNJSUMzd1VV?=
 =?utf-8?B?YjBKdlY2ZDY2c0pmWmdPMDg0UDBDY0M3L2FmYkhFWlZneFpUWElQZWU4ZUFj?=
 =?utf-8?B?TmwraEMzYmVGS2VxZjdSdWJQTTNUVmlWTGlFOWE0bUtHd240dmN0WTBtdmN2?=
 =?utf-8?B?dEhDaUZ2d1drUWZBNGdhcDFoN2NoT1R2Rzhic1Q1ejdRWXVwejRHOXlMN28v?=
 =?utf-8?B?OU9qemdlbi9XdWR0WkdRZ0cyTEZuZ0lUVTJJNHFxMGVSZFZSMWlPeW5WYjhU?=
 =?utf-8?B?QW9iM1N2QnQ3d1Uwa0k4SXZnU3ZKcGFPVlpIVVlKeEViN0R5dUo3OTFwclpV?=
 =?utf-8?B?azhUb3FuU2FINjVjLzB5ZGQ4V1Z2NHFZVlFqNWlOZUlyUHczNTVibms3Qjlm?=
 =?utf-8?B?SnFwOGdlbVpRMHA0NzJxRWhqUFBOY3B1djZoTFNKWXJsdnIrd2c2Q3Bld1Nt?=
 =?utf-8?B?a3JDNFk2NUxSbHlON3R0WGZQMjliZkRoZzNsQVR3Q3VCQldMd21sQ0ZuTlBO?=
 =?utf-8?B?SmU2cm1sSTFpSVN4YStTdlNzSEk3KzhqU1J1MUFhK0dZUEQ4Qm1YcTRnYTZH?=
 =?utf-8?B?dEphTEMvZDdBMndGaWlSeUQ5bXdLTnZkcmQ5emFLSWhBSnVLSjcvVUVkNlFI?=
 =?utf-8?B?cGRvQUhOUmtjMWZhRmZrSitVQVd5NUQ2K01PYitGSmhHTXhvS2U3czlTQ2J4?=
 =?utf-8?B?QXJyQnFyNUFMM0RkRFc5bVkzank4Q1JOM2tHSC9CU1ZaeWFuc3Z2UXloMWEv?=
 =?utf-8?B?a2dnNEUyR3dvS3pJUTMydHZ5TVZ3NUEwdjdWdFgyYjNoU1FFQjJ4dDU1eE85?=
 =?utf-8?B?Yk11alRDKzdwaGZ5eXBNTndaeXAxVXJERFlNVnRTaXdmU3YwenZSQm8rR3hJ?=
 =?utf-8?B?dWpzTjhKTEtvSHlmcmNrZSs5RW1DVzljQTZaWFlqRTlMM05HdldvWUpzYTV0?=
 =?utf-8?B?WmxhY0J4V2ZXN3d3blorTmZHT3hVWnJ6d0ErZy92S1VURDJoRlNJcEdSaTJ6?=
 =?utf-8?Q?KU+6urjuywWrhz1nd8ReS3q3c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f462a4-22de-4413-715b-08dd6556b9d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 13:22:11.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8uXQ9ggqH9VhchdS4ukCs7ti/6rRbXyifnWtL56/RHtXzkMwgkywsVefKwE6tdN73lF0/e4ycGSf46exkxbVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183



On 17/03/2025 15:16, Greg Kroah-Hartman wrote:
> On Mon, Mar 17, 2025 at 12:32:54PM +0200, Mark Bloch wrote:
>> From: Amir Tzin <amirtz@nvidia.com>
>>
>> In case an auxiliary device with IRQs directory is unbinded, the
>> directory is released, but auxdev->sysfs.irq_dir_exists remains true.
>> This leads to a failure recreating the directory on bind.
>>
>> Remove flag auxdev->sysfs.irq_dir_exists, add an API for updating
>> managed attributes group and use it to create the IRQs attribute group
>> as it does not fail if the group exists. Move initialization of the
>> sysfs xarray to auxiliary device probe.
> 
> This feels like a lot of different things all tied up into one patch,
> why isn't this a series?

Will make it one.

> 
>> Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
>> Signed-off-by: Amir Tzin <amirtz@nvidia.com>
>> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> 
> Why the [net] on the subject line, this is not for the networking
> tree...

We tested it internally over net tree as it affects SFs bind/unbind
on mlx5 driver and because of that my scripts got it wrong, sorry
for the noise.

> 
>> ---
>>  drivers/base/auxiliary.c       | 20 +++++++++--
>>  drivers/base/auxiliary_sysfs.c | 13 +------
>>  drivers/base/core.c            | 65 +++++++++++++++++++++++++++-------
>>  include/linux/auxiliary_bus.h  |  2 --
>>  include/linux/device.h         |  2 ++
>>  5 files changed, 73 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> index afa4df4c5a3f..56a487fce053 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -201,6 +201,18 @@ static const struct dev_pm_ops auxiliary_dev_pm_ops = {
>>  	SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
>>  };
>>  
>> +static void auxiliary_bus_sysfs_probe(struct auxiliary_device *auxdev)
>> +{
>> +	mutex_init(&auxdev->sysfs.lock);
>> +	xa_init(&auxdev->sysfs.irqs);
> 
> You aren't adding anything to sysfs here, so why is this called
> auxiliary_bus_sysfs_probe()?  Naming is hard, I know :(
> 
>> +}
>> +
>> +static void auxiliary_bus_sysfs_remove(struct auxiliary_device *auxdev)
>> +{
>> +	xa_destroy(&auxdev->sysfs.irqs);
>> +	mutex_destroy(&auxdev->sysfs.lock);
> 
> Same here, you aren't removing anything from sysfs.
> 
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -2835,17 +2835,8 @@ static void devm_attr_group_remove(struct device *dev, void *res)
>>  	sysfs_remove_group(&dev->kobj, group);
>>  }
>>  
>> -/**
>> - * devm_device_add_group - given a device, create a managed attribute group
>> - * @dev:	The device to create the group for
>> - * @grp:	The attribute group to create
>> - *
>> - * This function creates a group for the first time.  It will explicitly
>> - * warn and error if any of the attribute files being created already exist.
>> - *
>> - * Returns 0 on success or error code on failure.
>> - */
>> -int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
>> +static int __devm_device_add_group(struct device *dev, const struct attribute_group *grp,
>> +				   bool sysfs_update)
>>  {
>>  	union device_attr_group_devres *devres;
>>  	int error;
>> @@ -2855,7 +2846,8 @@ int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
>>  	if (!devres)
>>  		return -ENOMEM;
>>  
>> -	error = sysfs_create_group(&dev->kobj, grp);
>> +	error = sysfs_update ? sysfs_update_group(&dev->kobj, grp) :
>> +			       sysfs_create_group(&dev->kobj, grp);
> 
> Add is really an update?  That feels broken.
> 
>>  	if (error) {
>>  		devres_free(devres);
>>  		return error;
>> @@ -2865,8 +2857,57 @@ int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
>>  	devres_add(dev, devres);
>>  	return 0;
>>  }
>> +
>> +/**
>> + * devm_device_add_group - given a device, create a managed attribute group
>> + * @dev:	The device to create the group for
>> + * @grp:	The attribute group to create
>> + *
>> + * This function creates a group for the first time.  It will explicitly
>> + * warn and error if any of the attribute files being created already exist.
>> + *
>> + * Returns 0 on success or error code on failure.
>> + */
>> +int devm_device_add_group(struct device *dev, const struct attribute_group *grp)
>> +{
>> +	return __devm_device_add_group(dev, grp, false);
>> +}
>>  EXPORT_SYMBOL_GPL(devm_device_add_group);
>>  
>> +static int devm_device_group_match(struct device *dev, void *res, void *grp)
>> +{
>> +	union device_attr_group_devres *devres = res;
>> +
>> +	return devres->group == grp;
>> +}
>> +
>> +/**
>> + * devm_device_update_group - given a device, update managed attribute group
>> + * @dev:	The device to update the group for
>> + * @grp:	The attribute group to update
>> + *
>> + * This function updates a managed attribute group, create it if it does not
>> + * exist and converts an unmanaged attributes group into a managed attributes
>> + * group. Unlike devm_device_add_group it will explicitly not warn or error if
>> + * any of the attribute files being created already exist. Furthermore, if the
>> + * visibility of the files has changed through the is_visible() callback, it
>> + * will update the permissions and add or remove the relevant files. Changing a
>> + * group's name (subdirectory name under kobj's directory in sysfs) is not
>> + * allowed.
>> + *
>> + * Returns 0 on success or error code on failure.
>> + */
>> +int devm_device_update_group(struct device *dev, const struct attribute_group *grp)
>> +{
>> +	union device_attr_group_devres *devres;
>> +
>> +	devres = devres_find(dev, devm_attr_group_remove, devm_device_group_match, (void *)grp);
>> +
>> +	return devres ? sysfs_update_group(&dev->kobj, grp) :
>> +			__devm_device_add_group(dev, grp, true);
>> +}
>> +EXPORT_SYMBOL_GPL(devm_device_update_group);
> 
> Who is now using this new function?  I don't see it here in this patch,
> so why is it included here?
> 
>> +
>>  static int device_add_attrs(struct device *dev)
>>  {
>>  	const struct class *class = dev->class;
>> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
>> index 65dd7f154374..d8684cbff54e 100644
>> --- a/include/linux/auxiliary_bus.h
>> +++ b/include/linux/auxiliary_bus.h
>> @@ -146,7 +146,6 @@ struct auxiliary_device {
>>  	struct {
>>  		struct xarray irqs;
>>  		struct mutex lock; /* Synchronize irq sysfs creation */
>> -		bool irq_dir_exists;
>>  	} sysfs;
>>  };
>>  
>> @@ -238,7 +237,6 @@ auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
>>  
>>  static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
>>  {
>> -	mutex_destroy(&auxdev->sysfs.lock);
>>  	put_device(&auxdev->dev);
>>  }
>>  
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 80a5b3268986..faec7a3fab68 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -1273,6 +1273,8 @@ static inline void device_remove_group(struct device *dev,
>>  
>>  int __must_check devm_device_add_group(struct device *dev,
>>  				       const struct attribute_group *grp);
>> +int __must_check devm_device_update_group(struct device *dev,
>> +					  const struct attribute_group *grp);
> 
> Oh no, please no.  I hate the devm_device_add_group() to start with (and
> still think it is wrong and will break people's real use cases), I don't
> want to mess with a update group thing as well.
> 
> Please fix this up and make this a patch series to make it more obvious
> why all of this is needed, and that the change really is fixing a real
> problem.  As it is, I can't take this, sorry.

ACK to all comments, I'll take it with the author and will make it a
proper series.

Mark

> 
> greg k-h


