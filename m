Return-Path: <linux-rdma+bounces-10339-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D4CAB6392
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 09:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3849C463741
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 07:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA820297F;
	Wed, 14 May 2025 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f+GQsmxL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0D156C69;
	Wed, 14 May 2025 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206061; cv=fail; b=Az1IgYz1QVpYgD4WLqocZDIFUSrjp/oM9E4NdXEEyMeDajnwoqwoa4wzsEbnRA2h0LNJctFooARJh4XXhf6ixUHvrFyEZuL8IFYtuEDzIb0/e3OVpfqvdPWNDACoX2gSJQ8uX7Bjr6V7FFjwsY//Qxf2UJYm4hH1KyHy3T45GOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206061; c=relaxed/simple;
	bh=KMs8+uAYwxp3kBpMal4Xhf38EIK3vGzugCmVbGQiI2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MrTxkwzCRfF/ZhjL/TzVmNf9v2GPZAkWgQdSKvaQSb3b3GXqCqSx3Y0vzmipHGe471s9OKh8FH8QgAqbjfospKRL9BIx2M+Td6YXoTSimR0p3W05qkOhxrTlXhRn++GXAM/6CpPOSh45vLwbTqdqZGsi4F5WGjL86LbVjiDYsCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f+GQsmxL; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4GlfcztL/L4rLOhGeZi3teM9sYq0ESl0sWJYiEi201QUFzDuPbFYz9cnl4ISvpq4PwTe5i8NaalFiCCeSeiUlYhZhKTId5OctG40/791D7lYKG6bleXd/Pl8bIWh1ssUPw1Dh/7xJJMtZjAfLVjpzk1wj9C7SfKFxIs+xIKr0MtNpttyDLJk/tR9+xpZR2TGBdFXle1sLKO2k0s90v20LDjw8uWFDGkvx8UZtgp1Hw2ojNpRBrhQqLCs1CcNofB5IwteWexpieHa2xhqLMY4zOqj4GswHw+HSDx209TpNPOjv8/RI72KvMx/XqyWg4xIwQjB1XsVcmx8718s1ejGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLonvGLI7YLu+K+u2uFI43+luOZk4A6qJ5nnb8TsFm4=;
 b=f4+cUdOvJ6rJixw8iJPUGeUFswWZkBWi4C7CfNrmoIfAn88zkSSEF5lt9gn1S+cdCm0yFRLV+/yht8pxy2ZUtMF2INt3Zk4UEpUuZJqwWU07Jwe8JcDvVGlKKrG+ChQzWUY+Jl+PcXNCkqHd+/TjMHllp4yq/OPaBf+GUbXfLy09Num2ncwg/9l+NpTKVDeDkI6f+n4+UzKN6+q34x/EOMyw7hmMZUZbAF/KAA9lZ2JPS3tEXvmkZ+qFFC0ECNzmv/ibWGxOlt4D1+Y1pAias1ZwKGG2o1s79IRIAVmt2U1C8Aenubjvd90OL06FL7mJHBgFfpUCpZoB3dFhX+toHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLonvGLI7YLu+K+u2uFI43+luOZk4A6qJ5nnb8TsFm4=;
 b=f+GQsmxL5DA0UTR7o/OTRyg9C/bNgEBcR6PFz6Sq++wKonMn2nygfJ57MuiptDrm7uD/CNNQtO+ZM08h1epf9nK09ATBZZqZBm1/eB8mTb/k5kb4B5cd5erldUi4i5hPPIft6ZgF1aNqCuYS3RdHxtMbQcoBEoGt1m1s0rfYkIzWpL/xdRm+IIMGHKjiKoz3dZ4V9gTYS6wgKP5n9Tid8HMQPzofPbdgzNm09kOBOzrLj8oYqW/ui0ELFgecFeipJX/Ve8BPf8CsYbCfn0GfMaOrgK9I9vrei+pZDdVWXJLQqTbehMTD7M5dD7hVobo4o/PJsa8SDZKUb/nKN15PYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB7669.namprd12.prod.outlook.com (2603:10b6:8:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 07:00:57 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:00:56 +0000
Message-ID: <9ee1bdcf-efc5-4edc-9693-bc0f35ca137e@nvidia.com>
Date: Wed, 14 May 2025 10:00:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Use to_delayed_work()
To: Chen Ni <nichen@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250514063437.2513810-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250514063437.2513810-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DM4PR12MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d53753-8936-4044-2621-08dd92b51334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmUva3lqQUE2WENpVkxidkdMUVZoQzVMSjd1WlhpdGRrN2djQUVlZVlsWWpx?=
 =?utf-8?B?OXBWeDE5djZOVXVEUHVaMmNTcm52bmdJREtKRVNGQnU4TVQ1QktlL0dLVVow?=
 =?utf-8?B?RmVBYkxHeWtGNll5aUJNMHFtanUzT3FpMEpjQXpjTkUwcyt2NDF2TzRmblJz?=
 =?utf-8?B?ajNZNVo5WjhYZ1J2eXRHUEo3dzVOaFpzR3NuYjg5UDVPV3l6amVWQ1dkTHI4?=
 =?utf-8?B?dytYZHhUdXNoeXB5U2IwbUd1N2pWNm5DSXFJNzRzcTNMdThNZnRwUXZ4NUpv?=
 =?utf-8?B?Wi82WWZoaEJHcFlmUyswNkJJZzhtQXpUQUY0UXp6VzhDK3lUSm12SzMrb01t?=
 =?utf-8?B?WHo1VnlrYWNVOXNvWHljc0ZzM2x2VkFCajFibVVRZkVUSXhCNmJEWVFYYVZz?=
 =?utf-8?B?c0h4RHBlTndTbXBmSzRKSi91R0ZYZ2RiY2R1c2JLZCtsY3ljeU9KeGdkbFBv?=
 =?utf-8?B?VEhnR0NLM2hGNGxnMHhKaTl4Ky90YmZPQkszamgyUXBkNUZnNStRTHpSL1Vy?=
 =?utf-8?B?UURFUUpXU2QzQ1VUR3lwcmN3eTFFZk1mb3gvNmxXWWJKSUIvUWVjOEhkWUxH?=
 =?utf-8?B?RzcwbGF4eHYxaU9mTGZHZ0xEWlM0MkJuWmNKTFUzNUkxQlZtSGV0OXF1VkQy?=
 =?utf-8?B?RkYvWkJNWkpsYitsd3lteUlITGRHSENtVzBteTZXRGlGY3lNUHhVY04xZDdQ?=
 =?utf-8?B?bDhhL0dES21iOWZIUFV0WDUrLzNsSVBjVERUR3g3UlMwQjYzSUsrTjYyOExl?=
 =?utf-8?B?akJCUG94TTRlNko3ZzYzSktsZXJXR0h6MnZBNFdwbkhjaHhvMUN5OU9ENHNh?=
 =?utf-8?B?b1pqUHBsNndFT0JUY1pxQTFXbmFiTHcvU3Y1YUo4ZC85dld3MHplZm5BTG5K?=
 =?utf-8?B?T3MzMElUSmdkaXlua2NqUHlBcGJiT0V6SVNNUDVzbVI1SE81VVdoZm1yeXZr?=
 =?utf-8?B?aXZiQVhPSngyRkRtd1VWNkNDb295VHl4KzFrVzdUaHpBMnZacGU5ckZVVElL?=
 =?utf-8?B?c1J1dEFNcVV6eFBjczVpTzhVTnAwN1RwdGR6WjhzTVc5SkZXTTNrZ3k1a1VT?=
 =?utf-8?B?Y0dESFRBdTdoVnJWT0lzZkRxaXBHVGJDVjdwMTlzanEzTnk5NHNwK3hTU0Zz?=
 =?utf-8?B?UFZ5czFKYkdOTCsyY0ZHdmtCVHpjckJGT2U1MDh1RmNZQmMwYmFyMllsdUJq?=
 =?utf-8?B?RDNkU3lYSHJ0aGljN0FHV3lxdnZJSi9PVmJsbWNod0hkYytsNlFoNkJZQnE1?=
 =?utf-8?B?Q05CSVlvajJ2UjhORFQzcEpTS3pXNm95TXd4SlA3eWEyU1grbUZ1aVJMVTVZ?=
 =?utf-8?B?Uk5rdGtqVEZqL3JhVHg3dFNTUFJrUlRTQ2xrOG1iMFdJc1NRV3ZUMEQ5QmpF?=
 =?utf-8?B?S2Nzb0xweE1VZnN6UC9UcTA0ZnpnQ1ZkeXcyUFc4Y2VONEI4azFRL2xoS0xC?=
 =?utf-8?B?NW1QSUhPdVBRZHFkNG9nbkQyZXRqZWtzMElIM2hoWW1RdVE1OG91MVVCZHFZ?=
 =?utf-8?B?M0lRZ2xkQ2c0S2svRmFoTnBONW1EN0FNcXhlUzAvck53d0V5NElhWjlpTUFB?=
 =?utf-8?B?N01YWk1aUnd6TFB0cU9pTVRXai85RFgyQUpZUkNwYjFkZlNVZjg4eWlKWW9s?=
 =?utf-8?B?WThxbnRKN3ptS2h0bTR6RTJSMGlEd05LS283dW1NaFgrYWVHaW1BUHVzNTVo?=
 =?utf-8?B?akZ0S0lvZ2tiVm91azhCUkZhMk5SWmdRZkpMazBSVDJKeVNvallKR0crdTla?=
 =?utf-8?B?bHFQQnFGZDNVbnZ5bWlFeEVsc0FrMXpvUUt4Ynl0azYyN2h0WkwxbTV1cjZI?=
 =?utf-8?B?cFN5QVZmM1JDc3E0VjY4clZteXEreWVhODRhWFNnQXRKRWpJOEVKbm9SUURP?=
 =?utf-8?B?RG9XWmNUNy9qM3V2YmVXS2Y2RlY4aEs0RTlBN1A5VG9PRVBYMHRXWkhlK0dH?=
 =?utf-8?Q?nNwNGBiOmXc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlFwUU5oT3dOUnIyQWN5UzJ0SzFheVhMZFMyeVdiT3N5RVZPUVh2amM0aldE?=
 =?utf-8?B?alQ5VWtXUGxlOTlITVJSb2RwZ2RYRGk1cnduS1dlcWY1NHMrQU1lWFhmOEhB?=
 =?utf-8?B?Zi91ak9iZ1hTYVNnYVlyejZzWS9CZ0NmYnZmTWViWE1CTCtpUjdvSmRXSXBl?=
 =?utf-8?B?MUVPeUJJbWNZQURob3BzWTlCZ1JTS0JwaWVmNnA3RXpPRFdLclM2UVArdkV2?=
 =?utf-8?B?cDdwT2NPRVd4SHFJT3ZNeVNmR1hpak9nczhwaktnd05wZVZHRlNROVppTXJR?=
 =?utf-8?B?SzVGMFp6V3hwK3FMMkh4dkNYanRyU0MvRURNQW1NWFFZL0lYWUZPZHBxWlNr?=
 =?utf-8?B?UlVDU0puZ1YwMHluQnUwWnBmaFNwdTgydGtqbU5QbFRyb2hJVzJKT3cxMkhl?=
 =?utf-8?B?NnI3TmFtT21ya2xhdCs2TTdOTnZoTjE1S3A1OXBkL3pHVUNvRUxDU1RDMm9s?=
 =?utf-8?B?MHNkaXlROXFEd0pZUDBYMG85TjZxcHBGeGRkTUZHdVlGQ0l0K0h3cUFoNC8r?=
 =?utf-8?B?elZkWDRUaEpST2pZQklkOS9iejIrcHlSSGtPalJoaGY1cU1SV2JDVkFCK2tO?=
 =?utf-8?B?NXlYL2d2WnNTd2Vna2MyWTVZcllmL3ZQMHhRZXdUSmNNV2s0NGY2aVoydHUw?=
 =?utf-8?B?akZ6b2xhV3lnaXVXR1dsSEg3Q1MwUldid1BYNEVDREg1bkFyaXlRODZqMUpJ?=
 =?utf-8?B?d0VuMlM4Yi9mdHVPRThnNkdsZWxPd21KbmQ1TVA1Q1lOOGhXaEpEdEdpdnRw?=
 =?utf-8?B?WHhoNDNSNFI0Q3Flc2E5a2ZaaE9tbDZNb3FoVHBVbXMvZ0xkRlNic25pRk1Z?=
 =?utf-8?B?MWxiTmI2UEw5ODF6bHk0NW5YdUtVRjd4ajFpeU9iRE9ISUZSbHFmMUpyOXlW?=
 =?utf-8?B?UElYMkxNb2tJRk9SWm9NdGZ4a3RrMnlyZTV1cE1vdW92WXNOOFJFUGROYm5h?=
 =?utf-8?B?WFIydHNzc1lSZ3J0WXlITHRQOCtXQWdCUmU3Q1RyT1Zwbm56ZFdYNFQ3RHRM?=
 =?utf-8?B?aXdjQ0lkanNvR2cvNFpEMXVSWHIwdHhjejk0dHVGNWJyQ3BFL211b0t1V3Yy?=
 =?utf-8?B?U1hlNXVCOUlvNVF5RGtFdmhIbWhqYVBydWJTM1F0SjMwUXJjS3BDaTZ2SmQ3?=
 =?utf-8?B?ajhIVmtnMTk1NlFnckFZNkZ1bHM4RlZXNHNnR2ZWZDZ6N3U5Yng3Y1lzLzBJ?=
 =?utf-8?B?N3htanhscXErUnh6K2VzV0c1VGxjcXVwbG52aWw4NDhhb3RpVFI1aXBOd0hT?=
 =?utf-8?B?SmNGRE5zSU1yTUQrdXFFalAwWE5JUUR3VVNycjVKNnI4cmxwRmJkaGl5Uzl5?=
 =?utf-8?B?amtkWTYzT0g3NytlQm5hUUE5bGJXT0tOeDZRWitiU0tTV0ZQYzBOWXJCaG5X?=
 =?utf-8?B?dUl2ckJTd1lkZnBiSmVQUHhESTd0a2xBNDJ3Wklod3NxTWFwTEVzeHVoRjRk?=
 =?utf-8?B?UVVUSTRJOTVmMEo0eXVCeUMrSFJkSWdTNHpnemE4RUdiRjFwSHhkR0Y4MDg1?=
 =?utf-8?B?dTFuR1pVV0FjdktIOVB3bW1DOUxCY0ljajNUdFpIYnIreCsvODBuTktSRXN1?=
 =?utf-8?B?RFhlWWhpMFRSaHNPNFl5UWRXRjdhODhRKzVKVEZJUFZsZmtXNWhKWjYvQUFW?=
 =?utf-8?B?Q3A5K3JlWG5nU28zMDc2aEg0YUtheUxUc3FYZ1RaajgveGhObkFXejJQdDF0?=
 =?utf-8?B?OXJBN2J0YkZDNng0WkV3cXdmOUpxa1lCTXI5VG9DOHJlOWM4eDFib0xVWXJS?=
 =?utf-8?B?a0l2V3VIbzJzTXhER2p1eUJkWWZZaWFpYTdBZmF4c0tSMVlyNkM2MEtGRXJZ?=
 =?utf-8?B?cTJHcFF6U0lUZ0VWWVMxT1BzSStaNW40bW0zRStVQi9rRzRKUzBnOU1Ub25C?=
 =?utf-8?B?Ry95MmlyRk1wdnVhaWp5Q1ZIWlJsV2pMVXJPYzl6a0ZLTzFWYWszcnJ6bXY3?=
 =?utf-8?B?NHFtdzhrVnJ6M1JhakQxWVRzekJNY0p2aUdsSm56UkRTQ0pwMkh0VlNPaEgy?=
 =?utf-8?B?cTIyK3NGVVVZMGxUYmZTU2M1aTJCaS80ci8zTEpOcEhkSG85SHEwVHp3TUZO?=
 =?utf-8?B?SEh2cVRxWmUvRUU1b3I1OG1WQTJ4enV3bHpmR3Z3cDk2Si9mN0dyWnZFWkRB?=
 =?utf-8?Q?uXg2rCUDFT1irU9Rod/nHQTgE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d53753-8936-4044-2621-08dd92b51334
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:00:56.8501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqLmrQAIxQOQXb6/UPoQXVagSs6ILf2+lzGfGlM62xVI1BlthpwW+QEDE4XdAdeMpfBLJkPphqRYw4A0d1KA0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7669



On 14/05/2025 9:34, Chen Ni wrote:
> Use to_delayed_work() instead of open-coding it.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> index e53dbdc0a7a1..b1aeea7c4a91 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -927,8 +927,7 @@ static void mlx5_cmd_comp_handler(struct mlx5_core_dev *dev, u64 vec, bool force
>  
>  static void cb_timeout_handler(struct work_struct *work)
>  {
> -	struct delayed_work *dwork = container_of(work, struct delayed_work,
> -						  work);
> +	struct delayed_work *dwork = to_delayed_work(work);
>  	struct mlx5_cmd_work_ent *ent = container_of(dwork,
>  						     struct mlx5_cmd_work_ent,
>  						     cb_timeout_work);

Please specify the target tree in your future submissions just
as you did with your Prestera patch. For the change itself:

Acked-by: Mark Bloch <mbloch@nvidia.com>

