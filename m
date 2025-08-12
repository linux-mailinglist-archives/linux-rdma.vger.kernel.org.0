Return-Path: <linux-rdma+bounces-12687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34388B22B6D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 17:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44027AF3E3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8BB2F530F;
	Tue, 12 Aug 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HD6yb4BJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A13B2F5308;
	Tue, 12 Aug 2025 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011450; cv=fail; b=N+YSCalXr2mFvnrt/gRVFCrpoo1nEu+VqHFTm5P1grdB9KUNhP53vS5xRAVLbwOdbu+znlxal3j6reQITA5GhhCmP+LSPV7lPkAnTEMD6H0bmU4/tqbmBGIHyqSC6p4QXB/X+Wz/Pr9n0God+DOtAUfRiU4uO0jO3Pnfn7cjsro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011450; c=relaxed/simple;
	bh=p1DYgsFitiyDIsFJ1PQrZhuc4Dqk8c1Q9gY6MuTsc5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vj/8CBK17uI0Y3Jfd8gT1eHGNrwvg1PVELb50cQk/g0Yt9Tg6iqXmhDYBi0nFS+TliWc8lgpfOnASVajuNlaZWpVGrYNTZOvQVUzw9WsECTJCGjEJhXwbUblU1J72h54KcSeLnTkowEYsugQFBVrukRVYzXZHOsfqRIBhf2DOXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HD6yb4BJ; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5RGziEm/UBhEg62ZxqY7j2OhltctSI0zqi2QRt39FHA48xZhq4at/cn0PYhBDl8CKRn7U1hObciyhGT3vTLwZ1T3qbvw0u8LU2onvO6lnbdxWMGleWbqVRmUF9EK5EwASrmvZBSurUXy5Hk4F2hnkS+GkkZZhqfWcogewD3AgM7Ab9fLtCBqkA6N/ShRMQrkPaF3nfGT+/2Ayfv3NozOqg1VARotbGTF06IeL4vWCzngoG/TU3pmKIj2yeXSDiZSkxTIGtWsPLmYp1NUvOj3f/eHpOoGCMKiBEllokTNB2rbAGEz7I9PGoffc8zVTdol6f/JC9wm1JF513f4+qxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz2bJyykGasvalwTjjUDQAEjMONwOHokthsOPZABC2g=;
 b=yQ6aQ59jJiV11LUBYilQyUgmAWai9CU+FJZVfdcAjmxh7+co1p9Zj3q7d+738mnsz7eg5Lfyo0Q5R/t83F7HLbZ87xt59iMq5l/IyBzQAUEYGgDsbZNJ0SWhGcs+a1r/NwYIRtC7TGqpdB/eUuNcJLoh3Yz9koyxUvYi5QXzgkPfBwo87NtSOtF4k1plC1u3NJXFljp8vu3S+8jW29QsOTG6u5oDBMtxfU8ln/386yJLBf5uHRlTUlANIZ8NCy8e+8k4+5RKIq8eygIW4pnz3354Wy4AMOKl6ipH4Z/0LXrR6/R96CxD01b6odPWZyQJoSAL6iE0rGEoO03k/yjwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz2bJyykGasvalwTjjUDQAEjMONwOHokthsOPZABC2g=;
 b=HD6yb4BJisRuhbC7Ah4x+bd+IPtraBtTHDosoAPhB8ST4f2H/P1ZdWAkXmTLVJw/G8H78LuoVxAGt0NWXoi0wlSu9ffWsPzhyrVlvDdUu0eN7WR6iMiIbczpOc9rDgidCeq3gm+Sf5Mo7msbq/zvl9eHUV9+jO0w2Z0JxkyoUGXmn98UQWJYX5m0JzO6XggZ6sqpTtZXKruRvHAUEjAIYvHjSJrlMnVq+AEOl7v2yYGFrvvaXDgl0pvIkPXJaqW/+OVniSqlqHpDlJOZWio6P69SroQMYX5ixcZSPvWudgzFOKSsnNAShk4bxM8N4cS9B3STbQkDmX5YzZ6t6Udz+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 15:10:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%2]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:10:44 +0000
Message-ID: <13cc74e7-4a18-45e6-b511-940f9ed56a2b@nvidia.com>
Date: Tue, 12 Aug 2025 18:10:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 1/1] RDMA/core: Fix socket leak in
 rdma_dev_init_net
To: Parav Pandit <parav@nvidia.com>, =?UTF-8?Q?H=C3=A5kon_Bugge?=
 <haakon.bugge@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Chiara Meiohas <cmeiohas@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Yuyu Li <liyuyu6@huawei.com>,
 Patrisious Haddad <phaddad@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Yishai Hadas <yishaih@nvidia.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Wang Liang <wangliang74@huawei.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Junxian Huang <huangjunxian6@hisilicon.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250812133743.1788579-1-haakon.bugge@oracle.com>
 <CY8PR12MB719547A39C4B93FFA6FF40EEDC2BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <CY8PR12MB719547A39C4B93FFA6FF40EEDC2BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b633de-d935-418d-e1d5-08ddd9b26859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rkh3aXJlQTZGcmJzZVFCR3E0ejNKSHk2LzlscTZaa2hQQlV6U2d6MVlwclpE?=
 =?utf-8?B?Q2hsOTlNV2g2VHZicWN3M2FlN08xL21GRU5RdHhFcmVoaHBEdWp3QUtnek1F?=
 =?utf-8?B?TGdxdEFuaHpXK3pheXUrU2xBdFZSeTFOV3lYb3h6UEJSNVA0ZHZrdTVSbzFW?=
 =?utf-8?B?VExmbWNBOW83K3JqVWp0WVU3UEgvYUl6RngvQUVodWJ0UDk1QWNudWFKNjhz?=
 =?utf-8?B?ckZZQWhqM256Y0dUSHVGTlpFdThYV0xhUG5PYXFibjN4dHZuUkUyS3dKbmx2?=
 =?utf-8?B?ZktGQXFxRlJOZnBLaUJGV2RnUFpPeVV5akxsTThXWTVZRGdJZVovSGtwRE1n?=
 =?utf-8?B?dDN6aGF4YTR5SVV0Ly90TER2NnNqTXpVanIrUjRZZmVJR1dGVmszQTN5OGhH?=
 =?utf-8?B?QUJqVGNYYnViWWI5ZjE0OUZzcHhiS05uT3UxNXl1SHZHdnY0bUNRSURTU0U5?=
 =?utf-8?B?L29hYURzaDlrdk85ejhkTm40U2hybkNaaS9ML0NYdWhrditKWllYZlpYeEtZ?=
 =?utf-8?B?ZldLNE9EK25pZGpBUlVTeEd1QWw2RlFOaEVQMzY1aDEzdytNOGlDRWVLaGVs?=
 =?utf-8?B?ZUM4cWkyaHNueVBhS0FGR0FZeEJOWUhIeWlyZ3JIYk9ZbFE5bHRJYnhVN3cr?=
 =?utf-8?B?SkF4cnVNQVFMK1ZQU0NERGwxclR5eitmZllsWktXRUJSUFdkZ3lsaXVRbkNW?=
 =?utf-8?B?a1UwbmVXVUxDMEtzcjY4WTQ4cXZmR0g2Skc0bEZMZ005MWhnbWRtOTBzb3g5?=
 =?utf-8?B?TkdLWTJIQkYvU3BtMnJxQ3I4aWV6aTFUejhIVXBobGZuTEhYYk4xSjkwVjBO?=
 =?utf-8?B?Y1dUOVZsaHZHaGdudjN0VHF3RkE2b3prUFlPaS9sQk5CcTRTZTZWMEFxR2ty?=
 =?utf-8?B?UnN0bzJLWHdmS1p3NmNIUUlDOGlXbmdqL0l1RWpmalN1ejMwWDJGQTl4YVVF?=
 =?utf-8?B?ZFNsaTQ5K2ljNDR0azEwVW84TllyVC9QQS82bWdQKzltVFlITUZVLzBsUW5T?=
 =?utf-8?B?d2F5ZUhySUVhTmlZTkVuQ0FwbVBNMzdiNTE1ODUyVlpQd2pqTlNrdlpyU2pj?=
 =?utf-8?B?L1FEK2tnQm1rWVppMGdkMTNHNTM0YzJNZWJNdDRkZ1VkN2NPNHFoWHhFK3pl?=
 =?utf-8?B?VDFnWkRrMFo0UW12MUZOVlJoWkFRSVYzTE9STTBpUmgvaGw3ZFQrUmp6VmZE?=
 =?utf-8?B?R0ZXM0xtT1F2Z3JkZEpwQzRtL3FHYkh4NTh1dUtWS21qN1ZXdEpUV0xlbnNv?=
 =?utf-8?B?amNyQnFXekxWMzNxWjlCVHBYWUt0amJQN3M1NDFhc2xEdmVCK09JMERLVzQ4?=
 =?utf-8?B?SlNWb0g5MVh2VlU1OHNtenFwRlJZTDFOU1Q3am5KZjRJdU92OWdEcTcxbXFX?=
 =?utf-8?B?QlFrRDhYZWJqRkVnaFRta1l3OU5BeGtrV0hBVDdFTW9Lc1ZqeEk3Njh0NVNs?=
 =?utf-8?B?TExzV3dIakZGSytHOVJMVDV2a3FYWTFCMkRUZjhvTGVERkJhYVVZVFVJRTBn?=
 =?utf-8?B?eGZ2aWlxUnlyNGR0MHJYc3ZpbXkwd3BicHJyRjduMW0wSTUvdUs4ZE9na2xO?=
 =?utf-8?B?ZVRKUmJVbU8wNFZ3QXFGSEhjeXV6T0ZmSWZPTTljbURNVUNyVzh2by80cUJO?=
 =?utf-8?B?MlBiOVNIbmcybTNFMkEvblJ1WkJqaExoaXJiK0pBbzY3TnkzSTBSY1BZQmZO?=
 =?utf-8?B?RUk4K1UwREJtY0I4TWovWWp5bDEzUWQyVWlmdWRnUHBJdlhZeDVDOExWQ3Rn?=
 =?utf-8?B?azJyYW1KcUhaT3B1Wno4bXJWMXdoSkNKVWFDOTdsYk5HVjZVYkpkbm5kWW9I?=
 =?utf-8?B?OWxMd1RjSHBVbzFlQ2JYNTU5WlFGN3l4MDVXc0FDQlVpT1RrREVQWklQT1dT?=
 =?utf-8?B?bVlwZ2QybTFVb2wrMCsySEpqSkVZNnBrSTR2MmxKemUrT2JPN0RudkJwR3hw?=
 =?utf-8?B?NCt3VGdmSm55VFpvWlRlczUyTDFYSzUzcTlDREk5SVQ1OGpaa24wMUJSWDgw?=
 =?utf-8?B?QW10dzJaTHpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXF0RXhxWjgydmNNS3ZyemphejByWmZLZ05xWnIyZ2JVWVdkUWR6aTlqVlpp?=
 =?utf-8?B?dFlNRjNHZDQ3d0xGblQ2eVl5UEZQU3NZc1g0SSswWi9UNTI5cDMzWFYxMmoy?=
 =?utf-8?B?TFNlQU5yeWFrakhBN1d2WG1GMFcxVVZYUFM3OGFKekpXME5JSEhGRDliNmlx?=
 =?utf-8?B?enN4amJ5U3M2NkFrNmM0SE9nSUFKaVhXWlhsTThCdXM0RVdjVUtlZUo4M2hF?=
 =?utf-8?B?cmZoVkdwb1FHb3ZuMmdqKy8xN04zKzZ3aDYwaFBWQk1KT0NSMzZZTWprTU00?=
 =?utf-8?B?UzhhMGVwK3VRRWpmOWh2VElEV0YvN2hjMkdhaFdpdU94QmY2TDgyeWVTbFhu?=
 =?utf-8?B?WnlMdjZIQUtKTUdobGtMNFJtaXNGZ1VRayt6OTBmem5jVVhJRUJ1bzNOOVVR?=
 =?utf-8?B?cUZrZkxMV0RoYWljMGwyMllqRTVQYWdjNXhoMVYxbTR4QnZia3FlU3plekhB?=
 =?utf-8?B?aUV2WDkrSEEvb2YzWVl2NzQ1NUp2RHlpeE1GYzhJekJ5QU5DUy9YY2lReUk2?=
 =?utf-8?B?WDFhcUR3MFFveFZaQlJTYS92OENpd1g3WU91NWtSUXo2dnkzb0lGcW9EVDVp?=
 =?utf-8?B?VWxDSHVrcXFqTnNxdHBBWW9zTUNZMzhxaDQ1bVRhcjBLaWVuSXVqM1dmeVV0?=
 =?utf-8?B?dU9kQ1pYOFpxZjNadm9MeXJhc0tONFRYL1IvVUFBNFNYclZVM1NSZjRUZDky?=
 =?utf-8?B?RFFRQ0FURjlLS0ZpazcwZzBmUUcvS3FwbjVjM1I5RXMwU1M4UHF4U3RseXR2?=
 =?utf-8?B?anhYSVdSVXpTUDdPVzBOcXBZUWpPdmZPUFdJNjVwa2FGaUpvMU5JRWxNQXkv?=
 =?utf-8?B?QWdydnZwZEZVL3RnS3dKRGRIaVJPdWVONWlvSGFWMlFpdGxHRlVxZWhkbzlL?=
 =?utf-8?B?SXhReE1yVTRGOHErN3poem1BV1FvN2ZLSEttdVVNYW9jYzc2VnZIRGJxd2lo?=
 =?utf-8?B?elZkcCtSb0tzeWl4VHA0cWxkRExIMk5uQ0ZyMjdtWDFTb0NlV1ZGV2p3YjQ0?=
 =?utf-8?B?ZkQwcUZoS0RiL2Vmci9VODlFbzJzVk0wVUVEQTZlV25jeHJHRGs0N056WFR3?=
 =?utf-8?B?c0lhMnBJaXdFTjRoLzNTUDEyT2lsUW01QjZnUFJHSXFlcHQ0bGRnVXB5cnFB?=
 =?utf-8?B?WGtORU50d2UzM3NUMGhaNW5FdmZqRVZwQTlRUWdVVjRYQnBGMzZVT1EzbDlK?=
 =?utf-8?B?WEhKRCtpQXRSdFFESmx0dnhWU2FIT0dMNUVXK1Q0MEJnTStzdjFvcFRlQXRM?=
 =?utf-8?B?THdscFFiT29DSU9aQXF0ZEl4dGRtR3FtM0JIczdxaXgzRGEwbk9EcGVTRnND?=
 =?utf-8?B?UU1PdzJpK0lJai9UakhRSkd0Q2lYNTNQWkJ0dG1CL2tidnlMdEU3dFF4bytR?=
 =?utf-8?B?VWhWSFJIK1B1K3UwRHBEeGhyL3FnOTExbUFPMTI1U1lYWmJhdUxWUExMY2N4?=
 =?utf-8?B?ZDBpVWd3ektXV2dFUStpOHJZbEFUL1lrTUhWZnJjdStCNXI4QnpjcHo2TTd0?=
 =?utf-8?B?YUhrbzNDMk1TU0ZQSGxidXpQYU9ZQUxvYmpXcjlCNksxVW1EeTZSeVI4eTds?=
 =?utf-8?B?MXRmMkFWK0M5VzlGN3o0TUNSaVd5Q1NXRm1VOGdHS3RMTWhWQWVoSTUyWSt1?=
 =?utf-8?B?M0tqS0dSSDdrbDhuTDBkLytlb1FFN3RCdWxwV0lJbzUzSnRMWGhXYk00MkJL?=
 =?utf-8?B?cG1wYUpOT0lBR1h1dVY0a3EzZW9wWXUrbklaMk54SlVUZ2NjU1ByNUwzOGdL?=
 =?utf-8?B?V0pxbGE1b0VXRG9JMEd3M3FQSUtBcFJBZDdjT2F6UlBabkZoV2hDOUhFcGt0?=
 =?utf-8?B?M0ZXV3dPaitKQ3J0Wm96Ujd4SDNXQ216K3crSGM4WE1hMVFDMUZYVzRPRE42?=
 =?utf-8?B?QzhaYkpxRDI3bGlremV2N1hrMzJERDRrV0pLNE1JWFVSNmRkeEFHL2FEMGV3?=
 =?utf-8?B?eFZ4UURaTmJTQk8raEJoU0xNSkluMVRxTU00TmRQRkc2NmtWUWM0S3J4MGQz?=
 =?utf-8?B?QWFtY2xCbEV3OFVubkhjaHdxc2w4US8xckUvL2NwNHphdE5yb0lQcTdsMFZR?=
 =?utf-8?B?MkZXeVZaRVp6U2k4d1NueW9vUTR0dm5WMk9xclJ2Z3Q0MHBVQTZ0NjlWWE1W?=
 =?utf-8?Q?6G6HGlL3MwR8iS+i05S/unXXE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b633de-d935-418d-e1d5-08ddd9b26859
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:10:43.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWebqpa4kZ792u35Flgrgf8BXeiz/LztITKS5W4qc1Ze7PT4h7g7Z3DPY+rD5GEkvYiL6gn2Jtc2SSA8zDrtEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642



On 12/08/2025 16:49, Parav Pandit wrote:
> 
> 
>> From: Håkon Bugge <haakon.bugge@oracle.com>
>> Sent: 12 August 2025 07:08 PM
>>
>> If rdma_dev_init_net() has an early return because the supplied net is the
>> default init_net, we need to call rdma_nl_net_exit() before returning.
>>
> Not really.
> We still need to create the netlink socket so that rdma commands can be operational in init_net.
> 
> However, there is a bug in incorrectly cleaning up the init_net during ib_core driver unload flow.
> 
> I reviewed a fix internally from Mark Bloch for it.
> It should be posted anytime soon from Leon's queue.
> 
> Mark,
> Can you please comment on plan to post the fix to rdma-rc?

Leon is reviewing it now, once he’s finished, he’ll send it.

Mark

> 
>  
>> Fixes: 4e0f7b907072 ("RDMA/core: Implement compat device/sysfs tree in net
>> namespace")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
>> ---
>>  drivers/infiniband/core/device.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 3145cb34a1d20..ec5642e70c5db 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -1203,8 +1203,10 @@ static __net_init int rdma_dev_init_net(struct net
>> *net)
>>  		return ret;
>>
>>  	/* No need to create any compat devices in default init_net. */
>> -	if (net_eq(net, &init_net))
>> +	if (net_eq(net, &init_net)) {
>> +		rdma_nl_net_exit(rnet);
>>  		return 0;
>> +	}
>>
>>  	ret = xa_alloc(&rdma_nets, &rnet->id, rnet, xa_limit_32b,
>> GFP_KERNEL);
>>  	if (ret) {
>> --
>> 2.43.5
> 


