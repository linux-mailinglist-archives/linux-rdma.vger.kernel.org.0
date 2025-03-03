Return-Path: <linux-rdma+bounces-8261-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44AEA4CA44
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 18:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F091659AA
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0712250C12;
	Mon,  3 Mar 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="niGdRC8q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA1214A8E;
	Mon,  3 Mar 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023075; cv=fail; b=M6BE+0gISDXJcRAqWq9Wl8HDx0kEsgrlHYsmZMM/wlZYqYhjXymqc6pehO1dVHtxCWf4iulxw6zx5NltwGNvVoMHf29wnfKd2Aga/Y4xYscU5E7KiiQ9we5qtIGLwJBOGLanH68EVM9B/4N2LRIzWhTE8MRMoDI3qjVLfRtC2mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023075; c=relaxed/simple;
	bh=L2fTQblg4bKklhiCXp5DflGq+HOsm/eEVCJo9z2mZtw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=otqNZOklal8SBljcwB4oRoIQUfDl4XWfM6ZKQgIzkNVlh12F5opq0wlPaZp53s8XA6FSueqaszzmDttf9/zGqkHvrF5bJvU5tuN+Hb4wUnemJGjdGA2cA9pQOM9o+p15v1Hv/zI1LDjt5T0wYfEOStIp3/ybSgNnlJ9W0O6/ihk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=niGdRC8q; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPewnmPRDHUSwYKkoCfHndSTE6P7hANzUk1qrv/WkkgN0NnZhOffU9HtCMZ1P5Qb14ixDZhbhCTEeKAAkoz18/p5ecHtAoNcSzQ+aQ1vyKkWTuh8yfUD8RbWvalZCSkfTyd7JH0NZJJaR00ZDcFtWRpa3eFEML7NjQGqOpYVIWAVvZDRybx0M39pOZp4vhug0idh8znnKhwlSJKzZXIIwe+qzB020cJ17zJZRgGFe2e82NhqqRX5low5oVe3KOgcJ/ZkJ8mvZPfoO6DapjAXD3+iEiHn67Ti7PqeTovC28DZKj1J5MtfOmAEce482DwwcnF/aMiDEWwAxaNfPy+1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37lQA3FbG5mw4ExJB2pCC4RKc6vrosNTuxokZL4xwAY=;
 b=Dq7sx3EfmVgsOtuIrOz8x52Tk6XMUIjuXM8SFzoch0/0JTwFW+q8BncMW01znT/SzKuc+v1oUIRmG15BdTGjiNoQlFzGH9aREpaIcGLPczXlu6PYyIcJOSH8iqn9/WG5jzMVW6sXUrHMb3e4AyfivVc3Xqx2iT8E6RWsvK1OK8tIiVAvMAbUc8Imyj0iNxzZJq6FEpDCLzcbO9GxuVUTAWDbOJIOyBtSMwz13NJoUEWI38GH4eJ5+lmWnk1uC0lTlYcXxjWuGBUu3Domxd6+DhgibvUrAmXiEYbyXnH5fzmoYIrfTCVXxg2l5ZcWa2UOoBSGvaU0jd1tYUpnpbW5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37lQA3FbG5mw4ExJB2pCC4RKc6vrosNTuxokZL4xwAY=;
 b=niGdRC8qex4+nALM/99ePNDouSuIwljE4WB28K2VWwvnpumuniEu4tH0Xb80OD5601nIuYmpzZFdtmLepYiXjYtzl0SlzDmae29QgqQbbBZlzysjCeM20XTndqMDUXJLvdx1CnrA19cwMgoUKZVKPRybtnH01pFrf0653BbPboM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Mon, 3 Mar 2025 17:31:10 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 17:31:08 +0000
Message-ID: <3a77a28e-6d66-4315-90c5-d6802c256700@amd.com>
Date: Mon, 3 Mar 2025 09:31:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] pds_fwctl: initial driver framework
To: Dave Jiang <dave.jiang@intel.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com
Cc: brett.creeley@amd.com
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-5-shannon.nelson@amd.com>
 <01e4b8ad-82dd-43ac-92b9-3b3a030f86bc@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <01e4b8ad-82dd-43ac-92b9-3b3a030f86bc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::33) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b687503-bff7-427c-14a8-08dd5a792f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE9MUkpIUlFURTAzaFB6c3Z4QnlIWkQzVEpubjBPRWxGM1lFR245WFdZK0lu?=
 =?utf-8?B?clZCNmhLTVVydUVQR0lLUVFGUnRiY0ZoQnpGWHk4OFRKc0IvVU9wTytkeDlk?=
 =?utf-8?B?YjdXNHJicTVrZWd1Ym9ONjJEa3VyOTBWYVhTbUlYaG9mRE9WNmphK0V2UzVm?=
 =?utf-8?B?OUkxQTIyZktHdUZpTkdSMkxKVXAzY05xOTJ0djUxL0M3azJjeXN0d1RGWUZ1?=
 =?utf-8?B?Y2hyL2NDWUVheVdzQm4xQThkS2VqSXdxWENSYTlVOW04ZUthS2VWMU0rdmFj?=
 =?utf-8?B?VnFrSUhlaytCUWJ2R2lHWlRaRGxrT1NMU1J0aWtaWjJGcmw5eCtXZGVUNTVo?=
 =?utf-8?B?N0NpUzdEYXBWV2tmYTZRQlM0ckQ3S1ZtQVVUZ0wzTmFwcDRxWkkyRjUrSWhS?=
 =?utf-8?B?NWFVTkFFaThYcFF1M3JDam9nTTQwa1JLQ0xrV3Jwc3JkUFk4aFQ4MndicEpx?=
 =?utf-8?B?MGN0Vy9NOFpwMWVRRVNJT1lzd3pKY2F5Yzgxc2E1NTgyaVRIUHlkeGJocHNM?=
 =?utf-8?B?OVg1R2FpUjZYYU5QNFlwczVSUXVuYURSVlZrMzR0cWNLKy9KMnBOTlJnTzFt?=
 =?utf-8?B?NU5QNldrZmRqYllwbUpibUZhNHdjclZZQ2FINkRENFM1T3hJbFB6OTJwQWdq?=
 =?utf-8?B?T3NreWFlQmtEMHkrNnNmUkpvRG1LKzJvZ2M1UzRhWVlnYWZ0RnhwaGtjM2dX?=
 =?utf-8?B?YTUwc2lzbUFadEplN1IzaE1VdHl0ZUlwbTVBMW0zVGh2dVhmbHdvczhOTGFJ?=
 =?utf-8?B?ZnhKbzV0TFNIeUx4VFVkMkFjWUVKcjBiNHBOS2JncW5MMEVhWjVyWjFEQUoy?=
 =?utf-8?B?OVIvN3VsUmVJR1ZGRnRpYnNOeDJ5elFRY1VPaE5UVXYwMm1QSU9TaTFUR0dY?=
 =?utf-8?B?L3RSWTVJTFQycC9jZjlMcVZBY3ZZUnlvZHE2Ym84NnkzY1ZaaTlnVFBjejIx?=
 =?utf-8?B?WXpqRCtHSG1xdlFMOVM1ZEpVTFZRM2ZKYmlISUhDZG84aUlLUFVQSFdXdjZy?=
 =?utf-8?B?cGs0aW1vWmFydTUvallVMGNBUVpybXdBZTBvaFB4NmVKMVNZa3lYU0VZc2ZU?=
 =?utf-8?B?TUZLeXR4OXIzT094T3ZVSGdXUjhXWmpjMDUzbzRoWG82ZjMrckNVaEg0R3ZQ?=
 =?utf-8?B?RnN1VDFoMFlSbE9xbDV4WVJrb2NNcS9sbyt1S0tHb3U4VTNYVGZHc1pLeHZq?=
 =?utf-8?B?ZVFXWkNKRXBXckNpYTRGaU9oZDRYZFB2SzVlZmpRemZQWElwQ0tQYWlKTWdS?=
 =?utf-8?B?Uld4T0VSOUg3YlI5aTRpZkJVZlRpODNOSEVMbWx0b01UM21BUEZDUDhaSXha?=
 =?utf-8?B?NUZEV1UvK1VGMG1WVVFoS2RrbkpoUm5qYmk1Tk0wYlR2OU9SSGdvVUpWWms3?=
 =?utf-8?B?UWgrM21OQ2RGWFJaeWU2OGNON0tCaEQ5eUFCSW85VmN6a1ZVYTI2cGdKWEo5?=
 =?utf-8?B?S1N0M0poRlA1bFN3S3B1Zy9DbzFJVDdKclJ5ZUZvL0JYdVlZbWlmZnhVSDF5?=
 =?utf-8?B?TXhtWFhHTDdvdG53S2Qya0hJV3AwTXZBYjM2ZjFicFJURklNQVJBYVFrSm90?=
 =?utf-8?B?TXcycXRyL3pWamZzNTFHVEk1cWg3L3lhY3AwdDRtWVRxUUxUalZCOG1CVXlu?=
 =?utf-8?B?MnJJOVhLamNWLzdZSThhdkZnZy9xY3NKSm9KKzFjY1YxUFhET0svbERQKzhx?=
 =?utf-8?B?dTZzQkx0bi9sYStYNG91c1FhZENKYm9aRS9WdDNGRlRtUFMxM2RHN09uVDQy?=
 =?utf-8?B?YkRHaFRQWkpURDE5WXVZaEFLT3ZwZS9PVTBvQytjY1I5NUVGbWthRCtvOGxn?=
 =?utf-8?B?Y2YzdnhBeEpOSzNnUmpQdnRhVitrVVJMb29rUXJFOVU1WEk4a1M2WGZkWnFT?=
 =?utf-8?B?eGd0bUZVUlVsN3h2cUxBS3ZZdndITUhRZkJnQUtvMHdMVFVMb052TTdReWkv?=
 =?utf-8?Q?A6Q5viy/y4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW9id25pYjZEdTAxTXBiZTkvbFM2N2QreFNoaEZMWEJsYW5FcVZwaTlLQk5s?=
 =?utf-8?B?enBMblFLcmgvQSthNDBFbHVBSzQ0aDdwdllsYTRwODI4dGpkOWsxVFR4OSs5?=
 =?utf-8?B?Ui9PWVh6T2s4Wnc2TTlrZmkvRWRtS0UxcHhKU1VzcGpRTGpNRnl5b3FGRU9Z?=
 =?utf-8?B?bTdVellMVGFxdUpIOGRYbjIwYnBUSGdrZGxqKzhUbVBNZlNWSWRkbThyN0xh?=
 =?utf-8?B?NHFmZ0k5SFh0SGFJVU9pMWttSkM4QWxuQ1BLaGdUWVloZ2N6QjY0NnBNOGdo?=
 =?utf-8?B?bmtyZkhuVEVOL2hxb2RJVXlTam1EWmZVYnZ0VzB3WklJNWRRa1F6QktKVlBC?=
 =?utf-8?B?SGViaFMrV1lUQWxKVFpHSW5KZndjb2tITTdRdmhBMXNRWjU4RVFsYVFoeHda?=
 =?utf-8?B?Z3JpdGJWdmZVRCswSEw1amR0eDN1MW90eHVhMlNIOGxieTMxUjlVSm1hU2Jv?=
 =?utf-8?B?MWlPQUpQWUlIalJKUUo1UmdRTDg0VnZnME5WK2NwMzQ4UE1GZWo2bU8rT1Nj?=
 =?utf-8?B?RzVpcDgySkJTOGJtNXJzdjRJVDR6UlFyN2NvWGJBZXVvOHBLaHl2OXBqcm84?=
 =?utf-8?B?aW1WUUllb0t0dnJEejMwWGwwbEdTNEdVN3lJa1BoQWdIcFEvRmRwMHFPdzFr?=
 =?utf-8?B?R0g5MXJhWWFGMTQzTzBWZVZkMmRuZzNWRlpWOVYxSk1MZU5ZbHFWM3JQdkZx?=
 =?utf-8?B?NS93Z0xzaE1nbE9lNlpWVDMxS1VSZkdYVlhTVi81dGFVMTEwa0d5OXhEejBS?=
 =?utf-8?B?VVFnc2VYQitXQlQ5Zko0UTloY3RzTWlybXpKNUVGV0FHSG5jTXYrTHBoay9E?=
 =?utf-8?B?UzRPVWJNM0EvVzd1VTBJWVNJeHIvV2Z6NHBmK0RlYjc1QXJ6QkRQckJpc1dl?=
 =?utf-8?B?YWQxNEFWc2lJdDdlc0YvWGc2d0VEbEdlREVtdUtmbVhQNkw5b08rdW1mQUxJ?=
 =?utf-8?B?VTNBWUpuQlpHbXVLZlhPSXBFcWFTSlJsTzhlRWRDQnZtNENFMStVV2NPVm56?=
 =?utf-8?B?azZCclZDQzdhb2dGZ3k1MFBQREpTNmV6TFJySElmamFCY0JneW9icTdmdHB4?=
 =?utf-8?B?dHh3T1hsemdFZHVwckRjSm11SVJxS21CY2Qvd25saDgzMWtOWUtXTFBEdmZX?=
 =?utf-8?B?dGhqUnIxUXZMaG5iT2RNeDgrRkZXMmtJby9HYXFzM2wyVm9uWGRvZzF5V1Ru?=
 =?utf-8?B?Q2h6R0JpaG9waHFkaFJueTgzbCtOdHNuSlZQSTJoRk92OTBrbXBwbG5UK1JJ?=
 =?utf-8?B?OGFJdHFZQlB5QmFPYUFXWWFLa3lvRHFxZ2phWWZvWDZyK3o4OWxlSjZHNnY2?=
 =?utf-8?B?MkVORU1DdGZUSGh0eGV2VkRRcDZpdUlhekloVWtTb1BRd25WcjQ4a1B6bFJZ?=
 =?utf-8?B?cUVLTzlwRFNwTVQxSUx1dUhNSzJnNzRFbktxTzk3Z1RIaHBvV2lJdnJ5Q25V?=
 =?utf-8?B?NG1QZC81cGdONFkzL0kwOVZ1U3JxNEZLd2RsTWIrYWtZTFViTkZWc01wYktm?=
 =?utf-8?B?TmZBaTQyVXJSZTltQWgxVWFrSjF6VURSL2NTaVYxQS9YYlNUOWJQSWl0Y2Jx?=
 =?utf-8?B?V0NTZGpKS1hITW8wQiswS21ETitBYVdlYW9yR0Zzd2ptQjk3VXQ4eDhEYVd6?=
 =?utf-8?B?S3VUNkhnbU1CMHYyajhwN2xRL2RxL0VGRVdYOHNCaC9rQ1JJVWZEdHRUTHZn?=
 =?utf-8?B?ZmROMGZwbjBacjV5MWxkaU4rSXlaVUNJQnFud3FibkMrVm9Sd0d5YmR2UGtp?=
 =?utf-8?B?YkNrcUFOMm1mcVBYQUlBWk9rMktSb1pLNElhY3hjKzc3VmNCeWdkSmxJam95?=
 =?utf-8?B?QXlheTBTY3R4akxzYTlpdTRrNWpiODlDSTVIaFNTNVFjdUlJVU96YUhKOUpT?=
 =?utf-8?B?Yi9uV1RoNi9qZkdpZ0FCSm4wSnBxZXlTSjF1VWVjQXc0cGdvSDVlNkRlVm9k?=
 =?utf-8?B?WGd2WlpTem16d05UR1BoMmdpWm5qMFBUdWlwaEF2ellPOVhRY3oweFZTZ1Vk?=
 =?utf-8?B?aGtmRGhDWmdkSmhRV2RacXFRVVYxdFFaRVFHVVo1OUNoZ05Rbm1QWTRWdEtP?=
 =?utf-8?B?TGFhQ1huTkpjYjlwellkNjVrOEhDaFhsYXVheVFlZ1NadlMwa2RlTm5xVzlJ?=
 =?utf-8?Q?P6lk8RFS+IhWa4OvoWdrgOu6s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b687503-bff7-427c-14a8-08dd5a792f31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:31:08.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRUWQhYmOHU5CS2Edvm2YN0LTh3y07yECH5FqjhOfbDtBZ0vXFBlAbDuYaYqgrO4bI66yMsf4DNNnqDlfRftiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427

On 3/3/2025 8:45 AM, Dave Jiang wrote:
> 
> On 2/28/25 6:35 PM, Shannon Nelson wrote:
>> Initial files for adding a new fwctl driver for the AMD/Pensando PDS
>> devices.  This sets up a simple auxiliary_bus driver that registers
>> with fwctl subsystem.  It expects that a pds_core device has set up
>> the auxiliary_device pds_core.fwctl
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   MAINTAINERS                    |   7 ++
>>   drivers/fwctl/Kconfig          |  10 ++
>>   drivers/fwctl/Makefile         |   1 +
>>   drivers/fwctl/pds/Makefile     |   4 +
>>   drivers/fwctl/pds/main.c       | 169 +++++++++++++++++++++++++++++++++
>>   include/linux/pds/pds_adminq.h |  77 +++++++++++++++
>>   include/uapi/fwctl/fwctl.h     |   1 +
>>   include/uapi/fwctl/pds.h       |  27 ++++++
>>   8 files changed, 296 insertions(+)
>>   create mode 100644 drivers/fwctl/pds/Makefile
>>   create mode 100644 drivers/fwctl/pds/main.c
>>   create mode 100644 include/uapi/fwctl/pds.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7d2700d1ba0f..a396726feb6f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9601,6 +9601,13 @@ T:     git git://linuxtv.org/media.git
>>   F:   Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
>>   F:   drivers/media/i2c/gc2145.c
>>
>> +FWCTL PDS DRIVER
>> +M:   Brett Creeley <brett.creeley@amd.com>
>> +R:   Shannon Nelson <shannon.nelson@amd.com>
>> +L:   linux-kernel@vger.kernel.org
>> +S:   Maintained
>> +F:   drivers/fwctl/pds/
>> +
>>   GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
>>   M:   Tim Harvey <tharvey@gateworks.com>
>>   S:   Maintained
>> diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
>> index 0a542a247303..df87ce5bd8aa 100644
>> --- a/drivers/fwctl/Kconfig
>> +++ b/drivers/fwctl/Kconfig
>> @@ -28,5 +28,15 @@ config FWCTL_MLX5
>>          This will allow configuration and debug tools to work out of the box on
>>          mainstream kernel.
>>
>> +       If you don't know what to do here, say N.
>> +
>> +config FWCTL_PDS
>> +     tristate "AMD/Pensando pds fwctl driver"
>> +     depends on PDS_CORE
>> +     help
>> +       The pds_fwctl driver provides an fwctl interface for a user process
>> +       to access the debug and configuration information of the AMD/Pensando
>> +       DSC hardware family.
>> +
>>          If you don't know what to do here, say N.
>>   endif
>> diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
>> index 5fb289243286..692e4b8d7beb 100644
>> --- a/drivers/fwctl/Makefile
>> +++ b/drivers/fwctl/Makefile
>> @@ -2,4 +2,5 @@
>>   obj-$(CONFIG_FWCTL) += fwctl.o
>>   obj-$(CONFIG_FWCTL_MLX5) += mlx5/
>> +obj-$(CONFIG_FWCTL_PDS) += pds/
>>
>>   fwctl-y += main.o
>> diff --git a/drivers/fwctl/pds/Makefile b/drivers/fwctl/pds/Makefile
>> new file mode 100644
>> index 000000000000..c14cba128e3b
>> --- /dev/null
>> +++ b/drivers/fwctl/pds/Makefile
>> @@ -0,0 +1,4 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +obj-$(CONFIG_FWCTL_PDS) += pds_fwctl.o
>> +
>> +pds_fwctl-y += main.o
>> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
>> new file mode 100644
>> index 000000000000..afc7dc283ad5
>> --- /dev/null
>> +++ b/drivers/fwctl/pds/main.c
>> @@ -0,0 +1,169 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +/* Copyright(c) Advanced Micro Devices, Inc */
>> +
>> +#include <linux/module.h>
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/pci.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include <uapi/fwctl/fwctl.h>
>> +#include <uapi/fwctl/pds.h>
>> +#include <linux/fwctl.h>
>> +
>> +#include <linux/pds/pds_common.h>
>> +#include <linux/pds/pds_core_if.h>
>> +#include <linux/pds/pds_adminq.h>
>> +#include <linux/pds/pds_auxbus.h>
>> +
>> +struct pdsfc_uctx {
>> +     struct fwctl_uctx uctx;
>> +     u32 uctx_caps;
>> +     u32 uctx_uid;
>> +};
>> +
>> +struct pdsfc_dev {
>> +     struct fwctl_device fwctl;
>> +     struct pds_auxiliary_dev *padev;
>> +     struct pdsc *pdsc;
>> +     u32 caps;
>> +     struct pds_fwctl_ident ident;
>> +};
>> +DEFINE_FREE(pdsfc_dev, struct pdsfc_dev *, if (_T) fwctl_put(&_T->fwctl));
>> +
>> +static int pdsfc_open_uctx(struct fwctl_uctx *uctx)
>> +{
>> +     struct pdsfc_dev *pdsfc = container_of(uctx->fwctl, struct pdsfc_dev, fwctl);
>> +     struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
>> +
>> +     pdsfc_uctx->uctx_caps = pdsfc->caps;
>> +
>> +     return 0;
>> +}
>> +
>> +static void pdsfc_close_uctx(struct fwctl_uctx *uctx)
>> +{
>> +}
>> +
>> +static void *pdsfc_info(struct fwctl_uctx *uctx, size_t *length)
>> +{
>> +     struct pdsfc_uctx *pdsfc_uctx = container_of(uctx, struct pdsfc_uctx, uctx);
>> +     struct fwctl_info_pds *info;
>> +
>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>> +     if (!info)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     info->uctx_caps = pdsfc_uctx->uctx_caps;
>> +
>> +     return info;
>> +}
>> +
>> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
>> +{
>> +     struct device *dev = &pdsfc->fwctl.dev;
>> +     union pds_core_adminq_comp comp = {0};
>> +     union pds_core_adminq_cmd cmd;
>> +     struct pds_fwctl_ident *ident;
>> +     dma_addr_t ident_pa;
>> +     int err = 0;
>> +
>> +     ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
>> +     err = dma_mapping_error(dev->parent, ident_pa);
>> +     if (err) {
>> +             dev_err(dev, "Failed to map ident buffer\n");
>> +             return err;
>> +     }
>> +
>> +     cmd = (union pds_core_adminq_cmd) {
>> +             .fwctl_ident = {
>> +                     .opcode = PDS_FWCTL_CMD_IDENT,
>> +                     .version = 0,
>> +                     .len = cpu_to_le32(sizeof(*ident)),
>> +                     .ident_pa = cpu_to_le64(ident_pa),
>> +             }
>> +     };
>> +
>> +     err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
>> +     if (err)
>> +             dev_err(dev, "Failed to send adminq cmd opcode: %u err: %d\n",
>> +                     cmd.fwctl_ident.opcode, err);
>> +     else
>> +             pdsfc->ident = *ident;
>> +
>> +     dma_free_coherent(dev->parent, sizeof(*ident), ident, ident_pa);
>> +
>> +     return 0;
>> +}
>> +
>> +static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>> +                       void *in, size_t in_len, size_t *out_len)
>> +{
>> +     return NULL;
>> +}
>> +
>> +static const struct fwctl_ops pdsfc_ops = {
>> +     .device_type = FWCTL_DEVICE_TYPE_PDS,
>> +     .uctx_size = sizeof(struct pdsfc_uctx),
>> +     .open_uctx = pdsfc_open_uctx,
>> +     .close_uctx = pdsfc_close_uctx,
>> +     .info = pdsfc_info,
>> +     .fw_rpc = pdsfc_fw_rpc,
>> +};
>> +
>> +static int pdsfc_probe(struct auxiliary_device *adev,
>> +                    const struct auxiliary_device_id *id)
>> +{
>> +     struct pds_auxiliary_dev *padev =
>> +                     container_of(adev, struct pds_auxiliary_dev, aux_dev);
>> +     struct pdsfc_dev *pdsfc __free(pdsfc_dev) =
>> +                     fwctl_alloc_device(&padev->vf_pdev->dev, &pdsfc_ops,
>> +                                        struct pdsfc_dev, fwctl);
>> +     struct device *dev = &adev->dev;
>> +     int err;
>> +
> 
> It's ok to move the pdsfc declaration inline right before this check below. That would help prevent any accidental usages of pdsfc before the check. This is an exception to the coding style guidelines with the introduction of cleanup mechanisms.




>> +     if (!pdsfc) {
>> +             dev_err(dev, "Failed to allocate fwctl device struct\n");
>> +             return -ENOMEM;
>> +     }
>> +     pdsfc->padev = padev;
>> +
>> +     err = pdsfc_identify(pdsfc);
>> +     if (err)
>> +             return dev_err_probe(dev, err, "Failed to identify device\n");
>> +
>> +     err = fwctl_register(&pdsfc->fwctl);
>> +     if (err)
>> +             return dev_err_probe(dev, err, "Failed to register device\n");
>> +
>> +     auxiliary_set_drvdata(adev, no_free_ptr(pdsfc));
>> +
>> +     return 0;
>> +}
>> +
>> +static void pdsfc_remove(struct auxiliary_device *adev)
>> +{
>> +     struct pdsfc_dev *pdsfc __free(pdsfc_dev) = auxiliary_get_drvdata(adev);
>> +
>> +     fwctl_unregister(&pdsfc->fwctl);
> 
> Missing fwctl_put(). See fwctl_unregister() header comments. Caller must still call fwctl_put() to free the fwctl after calling fwctl_unregister().

Is this not covered by the pdsfc_dev cleanup we defined earlier?
sln

> 
> DJ
> 
>> +}
>> +
>> +static const struct auxiliary_device_id pdsfc_id_table[] = {
>> +     {.name = PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_FWCTL_STR },
>> +     {}
>> +};
>> +MODULE_DEVICE_TABLE(auxiliary, pdsfc_id_table);
>> +
>> +static struct auxiliary_driver pdsfc_driver = {
>> +     .name = "pds_fwctl",
>> +     .probe = pdsfc_probe,
>> +     .remove = pdsfc_remove,
>> +     .id_table = pdsfc_id_table,
>> +};
>> +
>> +module_auxiliary_driver(pdsfc_driver);
>> +
>> +MODULE_IMPORT_NS("FWCTL");
>> +MODULE_DESCRIPTION("pds fwctl driver");
>> +MODULE_AUTHOR("Shannon Nelson <shannon.nelson@amd.com>");
>> +MODULE_AUTHOR("Brett Creeley <brett.creeley@amd.com>");
>> +MODULE_LICENSE("Dual BSD/GPL");
>> diff --git a/include/linux/pds/pds_adminq.h b/include/linux/pds/pds_adminq.h
>> index 4b4e9a98b37b..ae6886ebc841 100644
>> --- a/include/linux/pds/pds_adminq.h
>> +++ b/include/linux/pds/pds_adminq.h
>> @@ -1179,6 +1179,78 @@ struct pds_lm_host_vf_status_cmd {
>>        u8     status;
>>   };
>>
>> +enum pds_fwctl_cmd_opcode {
>> +     PDS_FWCTL_CMD_IDENT = 70,
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
>> +
>> +/**
>> + * struct pds_fwctl_ident_cmd - Firmware control identification command structure
>> + * @opcode:   Operation code for the command
>> + * @rsvd:     Word boundary padding
>> + * @version:  Interface version
>> + * @rsvd2:    Word boundary padding
>> + * @len:      Length of the identification data
>> + * @ident_pa: Physical address of the identification data
>> + */
>> +struct pds_fwctl_ident_cmd {
>> +     u8     opcode;
>> +     u8     rsvd;
>> +     u8     version;
>> +     u8     rsvd2;
>> +     __le32 len;
>> +     __le64 ident_pa;
>> +} __packed;
>> +
>> +/**
>> + * struct pds_fwctl_ident - Firmware control identification structure
>> + * @features:    Supported features
>> + * @version:     Interface version
>> + * @rsvd:        Word boundary padding
>> + * @max_req_sz:  Maximum request size
>> + * @max_resp_sz: Maximum response size
>> + * @max_req_sg_elems:  Maximum number of request SGs
>> + * @max_resp_sg_elems: Maximum number of response SGs
>> + */
>> +struct pds_fwctl_ident {
>> +     __le64 features;
>> +     u8     version;
>> +     u8     rsvd[3];
>> +     __le32 max_req_sz;
>> +     __le32 max_resp_sz;
>> +     u8     max_req_sg_elems;
>> +     u8     max_resp_sg_elems;
>> +} __packed;
>> +
>>   union pds_core_adminq_cmd {
>>        u8     opcode;
>>        u8     bytes[64];
>> @@ -1216,6 +1288,9 @@ union pds_core_adminq_cmd {
>>        struct pds_lm_dirty_enable_cmd    lm_dirty_enable;
>>        struct pds_lm_dirty_disable_cmd   lm_dirty_disable;
>>        struct pds_lm_dirty_seq_ack_cmd   lm_dirty_seq_ack;
>> +
>> +     struct pds_fwctl_cmd              fwctl;
>> +     struct pds_fwctl_ident_cmd        fwctl_ident;
>>   };
>>
>>   union pds_core_adminq_comp {
>> @@ -1243,6 +1318,8 @@ union pds_core_adminq_comp {
>>
>>        struct pds_lm_state_size_comp     lm_state_size;
>>        struct pds_lm_dirty_status_comp   lm_dirty_status;
>> +
>> +     struct pds_fwctl_comp             fwctl;
>>   };
>>
>>   #ifndef __CHECKER__
>> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
>> index 518f054f02d2..a884e9f6dc2c 100644
>> --- a/include/uapi/fwctl/fwctl.h
>> +++ b/include/uapi/fwctl/fwctl.h
>> @@ -44,5 +44,6 @@ enum fwctl_device_type {
>>        FWCTL_DEVICE_TYPE_ERROR = 0,
>>        FWCTL_DEVICE_TYPE_MLX5 = 1,
>> +     FWCTL_DEVICE_TYPE_PDS = 4,
>>   };
>>
>>   /**
>> diff --git a/include/uapi/fwctl/pds.h b/include/uapi/fwctl/pds.h
>> new file mode 100644
>> index 000000000000..a01b032cbdb1
>> --- /dev/null
>> +++ b/include/uapi/fwctl/pds.h
>> @@ -0,0 +1,27 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/* Copyright(c) Advanced Micro Devices, Inc */
>> +
>> +/*
>> + * fwctl interface info for pds_fwctl
>> + */
>> +
>> +#ifndef _UAPI_FWCTL_PDS_H_
>> +#define _UAPI_FWCTL_PDS_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/*
>> + * struct fwctl_info_pds
>> + *
>> + * Return basic information about the FW interface available.
>> + */
>> +struct fwctl_info_pds {
>> +     __u32 uid;
>> +     __u32 uctx_caps;
>> +};
>> +
>> +enum pds_fwctl_capabilities {
>> +     PDS_FWCTL_QUERY_CAP = 0,
>> +     PDS_FWCTL_SEND_CAP,
>> +};
>> +#endif /* _UAPI_FWCTL_PDS_H_ */
> 


