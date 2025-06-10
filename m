Return-Path: <linux-rdma+bounces-11134-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919A0AD3BBE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 16:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4573A96BC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9539B221DAD;
	Tue, 10 Jun 2025 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xo6Ia0nJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D42720E034;
	Tue, 10 Jun 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567109; cv=fail; b=I+91QoD2NBv0Zfhvb5Jm1B5qgI0TMzMVfgdqa8DYRIjGb2PfxP8rybFrqvzNr4k6eiwP/mZyxBkVaw7EcBS7XI+76eL9ZHJzHwJ2gh4Mx3AlBlvBjn3Wy2VyEtR9pDakN6OAtF4x5nxmXWT/3gxKlKJlFws6LxVPxBi33gjUO10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567109; c=relaxed/simple;
	bh=jhPV3FIDtBSEV+R2TDlsoecyJX2Xp82f2bShDjWE/Y0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZyWWxKUsm9Tb3yBSFMKv975mArwqWZHps9lKdsizLniSYn48A5RQjmd6lM5xTvDtzkNxmJi1xIMpNq3MReZ+Dg2WSXQC+vyN54FRA+skhLwMhb1+wtEdUTunZBoDKYmpO0o5Cj5ZB8ZdYw/I6iSPr92qk2fX6/qHXptkzX5QkzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xo6Ia0nJ; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk1ctVv9LdT5TNas6MPjMyDxrd/7DNi42SqgW4ToPIt5/GKQ8yx2LSnY8TG8DdWziU9yf4rV9L4n5i7PIEdftR8K07nNbRoj3PSOP1xlujwHwrnOIFQN42xZLkHV6Y4npPxxhP1ODL4/TrGeTrf3nB3xTu2rvkdDqXkrLLQrtM7NQbubVJCoVEBwlvXwX41VGIzCoMSB1yM7ERrUHI2tTBTvYcXk6m8F5MlEGglMhG2B5zGainBxDlcSL2/GFxuu3TnSVyuB6yRdzDFGdd2+tl4y2ul+TE1a+9GJEEaDYAZ4C4lBGzZy17Tj+7/GbYds+8CyTJ5M/ULlYw89Iar8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkeOB8q+KnCGY/a+bQLEhDkbLyT08OrldZE9UJmZXyQ=;
 b=GRt4Wmf1VEqoj60Rtug99q/KeKK0GRe2QKlsqeFCInUlLQ5u/+ZxexbBTjq8I0VnZXmwgza1y2wNfACD7szWiSnbt0I5ip8f0jkcc6g0VGVsMbxbJFRnIMRLj9Gm4JURN9gY/OlSeeOES8sbl+OX0TymKfYO3LJmgvMSrwBJSzXFDNp3RWEZm72E9mMqlVe6mTfch7WDbPJkLz/Pce2MoXT+/ld4J+A4B6yfBYXgigtsBvkgqYcCNh1sV01eelcshdWtthQ6GJJ8Yy3vBSOvqLNvT6EsIcRb+zivm320w8ITg3H+Sfq1JfF7r8p5MO689HCujMSheTvjL6qD+Vkp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkeOB8q+KnCGY/a+bQLEhDkbLyT08OrldZE9UJmZXyQ=;
 b=Xo6Ia0nJWRNfW25zVsljqSBPWnQzL4HoYeRrYvNeSPUfzO6oN8q8s6H0kB2grKvAOYSL11ym0SmaYaE3UKuX2cGTYT8gUXv/567nTCzkTtWf1xPmB5P0M+V58c4AFNc1YFjHYQJV5CO5VW9Dvv5Cim2GgAXfEVu7vdQYP6AFAbBT04k7cQp0px/QwzI/V6Td4N3lOx3YMC64YqA6U9GS1Cv2BCglrM4E/SprWA47YCAtN7E6YKXnInrFvyZoUPxfEFe0QD5Adm+IOb90aryGOBUp2VbPMTFlrF43ThU96hb4wwODOzbkd7j4sqYHN+MbaRXXcaW2kgR7yOrFoE9f+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 by SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 14:51:44 +0000
Received: from CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4]) by CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4%3]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 14:51:44 +0000
Message-ID: <53621985-23fc-49e3-a402-4b6e2335a970@nvidia.com>
Date: Tue, 10 Jun 2025 17:51:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/mlx5: reduce stack usage in mlx5_ib_ufile_hw_cleanup
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Chiara Meiohas <cmeiohas@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610092846.2642535-1-arnd@kernel.org>
 <fa916ae4-1ed3-4f90-8577-3666ff0fe84a@nvidia.com>
 <a5c62d13-a8de-4efa-aa87-dfdf8a4e56bb@app.fastmail.com>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <a5c62d13-a8de-4efa-aa87-dfdf8a4e56bb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To CH3PR12MB8583.namprd12.prod.outlook.com
 (2603:10b6:610:15f::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8583:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 76458c63-afa5-45ea-f973-08dda82e5105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEExT2tubk1uQ2l1QVREOS9Objk2a1lpK3A4M0hlYjY2ZzhRN3IyUnJ2MVZy?=
 =?utf-8?B?TmV1V2hQeDdjYklSeW0vNUUrRDdjUmNOc24rc2t1U3c0UnQxOW5nbDhTaTRX?=
 =?utf-8?B?OXRNS0E3T0tNSU9iV1AyZ3FJd1VpdjlMd1BUZSt2ZXVVTXc5TlNXUlpoc0tR?=
 =?utf-8?B?MFllZWZlTG5BMUt1TndoV2U1dS9oRGhDM01BUDh1YllRNEJWQzNpdW1kOHda?=
 =?utf-8?B?ZTgrSTNTbithUDZNQ081YzVNeHlpQlRMUzRUZHlNbnpBSXpXTmN1ZTVWd1JL?=
 =?utf-8?B?NklKU2Z5QWcybzN3aDREWW1xeXdleVBKV0lFV0RwRnlvNVNWK0xXbHJycVkv?=
 =?utf-8?B?NDJiMUlHVUhGWXhWcGNWUCtHQmRrTDZldlFCK2luZmJDN21yUE82SEU3TlV1?=
 =?utf-8?B?cUZKT0NpQU4wRDNNRlNLYUJnTzQ1Vmo2SG1VVWJwQ0RCclNvWUJiNDlGK0Zw?=
 =?utf-8?B?WEJ4cmNKdkwrTmh2K0NDNEtRNExEa0p4TzFyNk8wNHFwM2c0bVNudHlIeUFM?=
 =?utf-8?B?Y1ROR0ZaTkRnOFFHWVJ6N2NDNFJCbU9sTzdXaU8yQWtEeG1wYlA3RVJXTEhT?=
 =?utf-8?B?eldXcUZUODFIWXhjUnNUUFVKTWl6QU5HbjBtM3BWcjAwVkhhQmJZYVU3bjd0?=
 =?utf-8?B?bjBwWnJKUWdhVk1MN2JKWE9jd2NJWnlrUnBwVmZRS1VlMk1IN2kwKzdCTmhw?=
 =?utf-8?B?NkZpcXVxQkxIeEJiU2tNc2lHSXBpMGxvYlFaMDFtQ2FoQ0p5OVgvMFBNdmZk?=
 =?utf-8?B?czRLcHQ0cWlYNnM2SEVkU0w3SGowbitDam1nYlJscmhrSk9CL2lPNXlhdTNn?=
 =?utf-8?B?NGZZTExGRXJiZzB6T0RuK1AwMUpkMU9XZFJ6NzFycHN6aWRxbE4yN2tjU2JU?=
 =?utf-8?B?ei9vRFJIOEltQkZBUk9BZnYxaVgreVRQVVBVbGRkbzQvanNVL1Rwa2YxZGY2?=
 =?utf-8?B?N3ZpUS96dUJKeGRDM00zdGZMeTZkZFRVdHIxUzFUUUdSZXVGN2JLdkF0cHdP?=
 =?utf-8?B?WkNZejcwbnJTNlhFNGI3cW9rdks1QmNUbnpBdy95cUN2WjR3cVhpSStNZkt0?=
 =?utf-8?B?djhIR0pnR25JcWFxY2M4VXlqTXdIUWM5cHhyM2RHSUNyL3NTd0x6U0RjOURK?=
 =?utf-8?B?R21qbkVXcDY0a1NGNlVxME1TUTBTZWRPQlpBcHZycEVBVHlVU0lsN2NMUVFD?=
 =?utf-8?B?N0NHK29IZDQ0VTRiMk55SEY2NTBtZlZGVE8wV0RmUmVRb3E4b1FGY2JyekFr?=
 =?utf-8?B?WUh4RE1SL1g4TVdvbFpZOTlUSnlJUnJtRk40c1FOV1k4MytSV0s5VG1mZHVJ?=
 =?utf-8?B?RG15R1IzMVhXVHlKSHp6UzQ3WjNwb3RPaXRIQ2dlZW9ZTEdONWpuMUIyVUF1?=
 =?utf-8?B?c3hyZm1lRjlsOFdmNytrQ0dmUnFPekl6QWpNenFVa1J4R3VKSEYxSTRQSE9F?=
 =?utf-8?B?cmJ0TUtZRWEybVlEaHppaUhReEdBSk9jNVBaRlZXU3ZYbFZMQThqbHkxd3U1?=
 =?utf-8?B?VGJRb3NqUHdCL2UwWXZwcjNmVDk2VWFrZWVialdSLzdUM1FiVVp2c0toTEpS?=
 =?utf-8?B?cTUrMVJNaXdsNktRR1plcW9QNUloNHRrTEM2VUh1NjlRSEJsRlh2ZWhNMzZN?=
 =?utf-8?B?NWo1NVhTSUF4ZHZ0TWRBbCtuZkRscU5GV0pvRFU4MFh1ZzZ6a0hMc1cweTBm?=
 =?utf-8?B?VThyZ2orYzk0amZlVjJhTThOSHNva0dRSGhpMzlZaXZsREg5NFdmS0ROYU9q?=
 =?utf-8?B?Tm1LOCtlUWQzQVk4enRJN3RUYUFWbllDYXIyd0hweTlRdGFiR2t5N2drL2xU?=
 =?utf-8?B?SHVBRFBQcEVOTmhEYkxiaC9GenEzTWRKLzErckQ2VHFEcUZTQTA1am1uTEti?=
 =?utf-8?B?UEFaU1lHclNlQ3VyQktvNGVHcE4yS3R3THYzMTNSUWpoeTdiQ1RBQUJqSmRs?=
 =?utf-8?Q?vMZtuwhKaok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTRYMXA1ZzhTU2JCMG9jQ1ErYUZXSWx0QTVLV2ZjbnN3VDJhckZNZU1HSmlv?=
 =?utf-8?B?d0dVQ1Z0cDFFNFFwcC9JLzBmemc5L1R3bU43U1UwWkVBdVFHdi9jbjlLempi?=
 =?utf-8?B?WFZwK1V6U1NLTEM4c1hGZzU2SXZ0TlBsMDhwR3N6T2NOeHBDWjZQd0d2eU9H?=
 =?utf-8?B?Z093c0hMZXRiNkNlWlNaOUFpVmIvdUkwSHpkbzdhbTBXaGJPUVhwRzMydzdV?=
 =?utf-8?B?ZFFWZlhEWm1SR0tua2h2UGtEVVhiUStnWC9PaTRZR2o3ZzI4WWlRS2pXdnZF?=
 =?utf-8?B?QzZ4Rjl4QjdCTk9XeWNsZzhCbzZKRW9yUXdTZ1NrRmZpRFpzZXhNZFpaVDJs?=
 =?utf-8?B?dWhXaEFJRzdaVGtBMHBkSDRLQW5CLzFVQUVMQWdaZlpCa0t5REIxV1RrQnhv?=
 =?utf-8?B?ZEwvZ2dMaWVIbmI4aytrU1d4SFlOM0FEMGMvOFdCNGQyRHVMZzc2aWg0MFht?=
 =?utf-8?B?Q1owOXdFWWI3OG1MUG5HVnBiUGRGR3JTK1NzblVCV0N3aVJHUnlBV2ZyMHNk?=
 =?utf-8?B?cXdVbU16MVFrVDJDanpRbTExdGRuRkE5dzNyYWhwSTU2QUFDWFk3R2hEVHNZ?=
 =?utf-8?B?L2phU2tPZFFoNEg3WjU1b0RMUXkwVUphM1BnNDdYOUJOWVhnZElFeUNTRUE0?=
 =?utf-8?B?SjZwRTlaRVk0ckxmSlZXa2VTcHpUQ29vTTk3YWxncGJDeUN0VHJKMnRvdkxj?=
 =?utf-8?B?SWlRcXNERGFHdEsxcFdRK2RVVXNXWm9CMGhQL2l0VzdkUnNtcW95RkYvZE94?=
 =?utf-8?B?Ny91bEI2akNYL1B5cmhyZlI1dkd6eWluK2RDcXgzMGFSVGlFUURiWmZYQWFq?=
 =?utf-8?B?VnFrTmdrclFNSVpFSkIrWlNEM20zNkwwdDZsd1djbnpYd3NvQ0x4dkozWlNR?=
 =?utf-8?B?cUZobS9pNzNjYkRiK1l1RVZOQVZOWnVPQVdmODNnV1gzOWdnQlNDaUk5ZFhn?=
 =?utf-8?B?SGJ2c2RESWE2TEZvK2ZUMFp1K3VWZzFRNkFZZnNpK1d4czZTZEFTd1pua0Js?=
 =?utf-8?B?cCtMOWsvOFpQZkd3eDdYUTYxekZPMFFGSXJvRlVjdXhXYlBvVnJ2eGRqVVhj?=
 =?utf-8?B?K2F6eFkwK1NPa3dWRXNSRFBJeXZ6eGhETVFSekZGNmd5RHhUd0VqNkE4ZHZR?=
 =?utf-8?B?ZHdtdGZTbVF6bkJ6U0UvM3FRbUx6YW1wVlVQUUIvUUxjR0JPaDNEbDB0MjU1?=
 =?utf-8?B?bGJtWllCMXhwNGdZclgrclZsbjBJQTNkZlg2NlExMUxMeEFEbDc3aVNaMEJP?=
 =?utf-8?B?aUJiV1B4b3FOTVczTHhXUThlNDFZK0RQNnZaQ1JLM2p3anhpdENndEN5ODIr?=
 =?utf-8?B?U1psWmxoYS84MEpsLzdMSllvMzNyenNmK0Fwd3gyZ3V0cFFTbUk1ZDM3dmhB?=
 =?utf-8?B?ZVIxZ0pPMDV1M204T05mQi9uQ0Z4a3l4ZzljelNGbjJtaDd4Y2lwK2xPWHBz?=
 =?utf-8?B?RkFaMDdJS1A4YVo4eDhYMVRBTldCb1Z5Zzdkb251U3lxblVGdGs1U1AzTi9w?=
 =?utf-8?B?aEtUQzhITkFGUmZ0RDVxTE9ERE93QlpGNzlHTkdYZmhGUDZqeThESmZmazJx?=
 =?utf-8?B?Z1F6ckUvVjByTE5USnZQVGwrd0EzbDNrVTEyc0JwSzJiU09kRUY0ZWpkQkZP?=
 =?utf-8?B?QSt5NWFRWGpKNk91VElGN0p5bFlIOStBSGErRC9EaGk1cEptblZXYlo2NUx1?=
 =?utf-8?B?SDRwM1NqMlVrdmVSSGFhVWdZRVVZeC9LWXlqbGtGUnRUOVhBS2oyLy82OU9Q?=
 =?utf-8?B?aXdXTEh0OWUyNmlMRFBYaUlSeE1TKyttbmxaekJ4bWdwam1HeDZGVisxSzcy?=
 =?utf-8?B?VHRETXFaTVh3RUJWVEQ0K3hMK205N2hmYTFNV3RVUW5qdzYwcXpSZWMzUGRy?=
 =?utf-8?B?U1B0T1huRlpQdTVtMXV1Z3h2ZEhCK3BhL0VCUTM3RXovY0t6alg1WUh1UWMx?=
 =?utf-8?B?d1RyRGdoY3h5SURTby9MWkNxY216a0pWVEEwb0FZYmNlcE5OemQ0ckFmd09K?=
 =?utf-8?B?RHpLZEhVVEc3cTd1TlNpWDRmbkEvQk5ZUW9XZVFwMG9sdlhLOXY5UzhCL1I4?=
 =?utf-8?B?Nmh4NFAxdUJWZmplY3BpdDhsOWk5ZDRrTXlwR2M5dGY2Ulh0alZtQ05FQnhv?=
 =?utf-8?Q?7+Fud3kAweHPGr/mkjxUMIN3S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76458c63-afa5-45ea-f973-08dda82e5105
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:51:44.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWHOr/o/bSU5q+VR4NqBIJiKAVnYHrKMttvif7l1LITEgC2HvHP+LqqVV8jgAp6IEDbdqRJMfuDZuIR6mfWRLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051


On 6/10/2025 1:31 PM, Arnd Bergmann wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Jun 10, 2025, at 11:50, Patrisious Haddad wrote:
>> On 6/10/2025 12:28 PM, Arnd Bergmann wrote:
>>>    void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
>>>    {
>>> -       struct mlx5_async_cmd async_cmd[MAX_ASYNC_CMDS];
>>> +       struct mlx5_async_cmd *async_cmd;
>> Please preserve reverse Christmas tree deceleration.
>>>           struct ib_ucontext *ucontext = ufile->ucontext;
>>>           struct ib_device *device = ucontext->device;
>>>           struct mlx5_ib_dev *dev = to_mdev(device);
>>> @@ -2678,6 +2678,10 @@ void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
>>>           int head = 0;
>>>           int tail = 0;
>>>
>>> +       async_cmd = kcalloc(MAX_ASYNC_CMDS, sizeof(*async_cmd), GFP_KERNEL);
>>> +       if (WARN_ON(!async_cmd))
>>> +               return;
>> But honestly I'm not sure I like this, the whole point of this patch was
>> performance optimization for teardown flow, and this function is called
>> in a loop not even one time.
>>
>> So I'm really not sure about how much kcalloc can slow it down here, and
>> it failing is whole other issue.
> Generally speaking, kcalloc is fairly quick and won't fail here,
> but it can take some time under memory pressure if it ends up
> in memory reclaim.
>
>> I'm thinking out-loud here, but theoretically we know stack size and
>> this struct size at compile time , so can we should be able to add some
>> kind of ifdef check "if (stack_frame_size < struct_size)" skip this
>> function and maybe print some warning.
>> (since it is purely optimization function and logically the code will
>> continue correctly without it - but if it needs to be executed then let
>> it stay like this and needs a big enough stack - which is most of today
>> systems anyway) ?
> The thing I'm most interested here is the compile-time warning:
> we currently have some configurations that have a very high warning
> limit of 2048 bytes or even unlimited, which means that a number
> of functions that accidentally use too much stack space (either from
> a compiler misoptimization or a programmer error) are missed and
> can end up causing problems later. I posted this patch as part of
> a larger work to eventually reduce the default warning limit
> for those corner cases.
>
> The risk in this particular function to actually overflow is fairly
> low since it gets called from sys_close() or __fput(), which
> are not nested deeply. I can think of a couple of other ways to
> keep your fast path and also build cleanly with a lower warning
> limit.
>
> - check which exact configurations actually trigger the high stack
>    usage and then skip the optimization in those cases. The most
>    likely causes are CONFIG_KASAN_STACK and CONFIG_KMSAN, both
>    of which already make the kernel a lot slower.

Personally I prefer this option the most.
But If I were you I would wait to hear if the maintainers got a problem 
with that approach ...

>
> - reduce MAX_ASYNC_CMDS to always stay under the warning limit, either
>    picking a lower value unconditionally, or based on the Kconfig
>    options that trigger it

No the number 8 wasn't chosen arbitrarily it also due to performance 
reasons, whereas note that it is also the number

of commands that can be sent in parallel for destruction so reducing it 
isn't ideal.

>
> - preallocate the array as part of an existing structure, whichever
>    makes sense here (mlx5_ib_dev maybe?).
Can work but not ideal.
>
> - reorganize the code in some other form to have the stack not
>    blow the warning limit. As far as I can tell, I only see this
>    particular one with clang but not gcc, and that often means
>    it happens because of some particular inlining decisions that
>    clang takes, and we can force them by adding strategic
>    __always_inline or noinline annotations that make both compilers
>    do the same thing.
Sounds like the hardest option to implement but I have no quarrel with it.
>
>        Arnd

