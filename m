Return-Path: <linux-rdma+bounces-6186-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA39E181B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 10:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1838128564A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2F51E0E16;
	Tue,  3 Dec 2024 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U0OyeSFA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAEC1DFE1A;
	Tue,  3 Dec 2024 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219064; cv=fail; b=CeojBcjk2uWlYf483kdJwc4KkI5pg951ltIIBIfivTXlbhjnCfLdhtFwnuscljezzmjrlsVal1J/Vqx38oTXRIhEitdtL7Bv+EadH1r5WOOgStqa0TFQsktpRH9zcZ/2KkwDYj5f5aQhx4pWhaU0Trs8Dwd3hSEXZ1C7Ic5/eOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219064; c=relaxed/simple;
	bh=xWGGMcuA016YQAUhJb4lUVitZ3BYndHb2ax9jNRe6rc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PadqJLBX4+XSkbtHatahKz7X+SRcRL7+y9lS2JI5/NARDa+FLVzL/UfuLCMd3eIn13CQt0Cfbup+w7Pyr8J360B1kMaNOQUJtjXVycMYLg14DwxhXl7Zuxb2BTJVxnhNMHSWm98Ecp22e8xfgIwIel0koND14ua9phBtziAoLFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U0OyeSFA; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFkD5O3+H+HYCx6ZsHgjBKSKFnaDI+l2YwyBUy379A1sGLOb99JrViSucrcZNmTViykOY6CrVeyHau045xlUBiitcIx9GlOypaFtKHj/5rj2hsTk77fA76ssfr4ixiMGpcuhdGoRxJEoghAofk+EX5LZ1CvwQnxPMfchDYukY/OFQ0muMuyWraUukgFxQeUBBD9w71SGbW0Omw4TmQ99yFacwPq8t1EurdN45M3J3+zN7dwwL8ZAOOhpD4Wi3e8uUI13i5UgaI8E7vGyF0di2cxrWFBpaaweTaCSH3hFe6P0BxXY0yLSF6nIPSvXIztqVeOm69CW12KTLR7xZApTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBVHoL0IlaNVrFTT+ab1WUtmlcPjmYD5RFf2xA6NFhU=;
 b=dqvFpPQ+BIJRcnohUS3n9Rf+yWO92KMLJQIK65GQiMRZJoQBkOs0FrgUsFAJhG+BXKZFdTuVaM5FSL7fW3K6sqMiEANYuL8ypd43xXZxIOCZ5xRh4wD2x8a+SIdd/sbKFIaNJiQ38FhzlFIa4nM+sBsnuhBxqFc9aGhxhF5kWrXe37G5Iw6DDjewioNAt9TaloP4iZfrOa5BZ8mKwvZ1Xhw7PCk038fjJDxdZJVut1lAcxlVl9g8JqEPU9k1Use+3Fl8xJox2R/UeX/Q40Xo28Qsf3YJ/+hB7RhAWIqDzsHJBBcMYGQVHK4Dg1lV+POjUN4o+lc1g4zqazUps3GHJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBVHoL0IlaNVrFTT+ab1WUtmlcPjmYD5RFf2xA6NFhU=;
 b=U0OyeSFALjkBd/pyog2NQ9qE+We8vwPmwJE+gkuyk9Kicxh8YAaw1EHsdQFtw3YrQKGUvpUWHrOyJrSM3l3/hpp1gNkoPjqIVseZVLliaiHUlns1+uvYp4JPm9q2LV+XoEq9x6zgwnlVzpDI513Hhv5XEQU9bgV4WCM4sdW7AfWGinmSCtR+qFmfsg3cszlbPtqsb+AdOMXB0Rl1QMUrbmdDH3ybbs3dFnZE2uBSshowU2HCDmKW22pTuIe+fZnk8wi8H7ug2a2zbux8SuEcOyreNq6aqc10rPEgG/uKv/UGwETqlyly3eOXbs2CpGUJZnsp8Dv7oI0xptvXc15H3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 09:44:19 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%4]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 09:44:18 +0000
Message-ID: <4183c48a-3c78-47e2-a7b2-11d387b6f833@nvidia.com>
Date: Tue, 3 Dec 2024 11:44:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: DR, prevent potential error pointer
 dereference
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
 <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>
 <bf47a26a-ec69-433b-9cf9-667f9bccbec1@stanley.mountain>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <bf47a26a-ec69-433b-9cf9-667f9bccbec1@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::23) To IA0PR12MB7722.namprd12.prod.outlook.com
 (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd88dc2-a101-4dca-2f16-08dd137f0ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1VXV1J3YzkrNjJkVzlBMXhoNGJsbitMcnpZRjFkODQ1TzZ5VWNlQ01iQnUv?=
 =?utf-8?B?ZjRzWmwvSThCT2ErTWdaZ0ZuSld5cTV2b3k5ZTN1YXZBSkYvR1pUb1k0Qmsw?=
 =?utf-8?B?VTkvaEdsR3A3MGVrMjQ0em1OSDhCZG0xMXRFYjVGeElSdmdIY29uYk4vWVdN?=
 =?utf-8?B?b0p6eHhpdXQwc0pPTEZJRnhhUnA3UFZaVGI1Rmx4V052WUM5LzVFR09lN1ZT?=
 =?utf-8?B?Z3dnTlhsRHRtVEVoVnh1MlRCYVJmSGRDc0NsL2UyemY0WU03SG0yeWkrSDc2?=
 =?utf-8?B?QkJ4TDRTeEpiS0JaMFlncmFtZVVHTmV4cU9vanlORW05WUwxSW91K1BUZTRM?=
 =?utf-8?B?eGNqZ01jT24zbFhrK0kzc3JWZXJ4SzhlcTVPdWU3ZXB5ZFh4WVFLRlpHZXEz?=
 =?utf-8?B?SzZHb1ByTVd2c2ROZER4VDdGMmxnUzhpYmMwZDRMMWdQM2kybEhyR0hVWGZK?=
 =?utf-8?B?YTMyQ1JwanA0aGxXT1hLVTAwTnNuWGx5d2Z1dWVpL1UycUVKbFpHdXRpd3Jn?=
 =?utf-8?B?cmxTOStiMTBwdlhjVEhpTVRBUy9VdFowN2dHakNhS0dtQm1xQ2VUNWNZbnVn?=
 =?utf-8?B?eFNJU0Z0NC9XTkhtb2dtOWx2ellodEZNaVliai8wMkNyTnFqU25oTzNHOGEz?=
 =?utf-8?B?cDMvQ0h1cTdBVm9MaVptVHcwZjhweGJSOFIrU0VaUm1JVys1SmRPZlFCcG9M?=
 =?utf-8?B?MVM1a3k1WjFjRmFvS3ljbW9tWUg2SG9peHlqcDRJdmxTcDdQNmQxTTRVckpW?=
 =?utf-8?B?TG1qZGtEMTZlMTFqR1VKM1M4T1F3YXE3a3RuNk5MSXByelZEL3V4ejVxZWMr?=
 =?utf-8?B?NjlCaUlFU0VHRjZzL3d3Qm4vQk5EY2xwWHFDZW5MbGRjNEdCcXVFZExKcEpE?=
 =?utf-8?B?SUJnblpzNDBwQUdXdkJLUmVpQ1djZ3NVTmcwczg2U0JnNGhKSEdXSEZVNlRF?=
 =?utf-8?B?Und0NUNnK0toZlBMNm1NU1VyK1hIYWY2N0F4NkJqcjFxeW50K3ZBTHplT3Zw?=
 =?utf-8?B?RDkwUlg5Z1dXQ2VFR2pFdUV2OURUR29kN1hBTG1qRFllc29hSGVlWDJ4QXVF?=
 =?utf-8?B?dThPYWJZQXFpZmM4SC9udml5YkhKWHJhU1RyMmRJS2R6M1cwM0VsVTVBNmhV?=
 =?utf-8?B?Q3NjVEUxOVNUU0luQ3hCNEZIOVFuT1pqS3JtakVtRjJXZ1dLdU16R1duSm90?=
 =?utf-8?B?bmJMcDNRRnNIM3prWUU4VFdUNTFDMFNLbmZFajViNHBOMWpCNFNPSWx3cjVk?=
 =?utf-8?B?Zk1tNHRpZTZ3czFHSGpmdGFFVjU5a0ttdFdzeHVOc0JrSk5vUkthb1pzVmtL?=
 =?utf-8?B?QlhpS2lUWnpSRy9xRlZwNXBaRmR3NytaajBzbmZqQkpDKzFhOEVFYjkxdHhT?=
 =?utf-8?B?Y1FWWlQ0MFhJZi9yYk5wY2Rkc3pKU3VUaVQwMEhoeHVWNEJraUdEc0twTkEr?=
 =?utf-8?B?SklLNFlZZGJJUGcvQkdKTXpJVmJPbFBZTG1ieWQ5YXY5NVFLR0kvMXhNMzFp?=
 =?utf-8?B?MW1ZVGw2KzJ5aU1mSkJ0VWNncURJYXIyTFVpMkFpNEFkdCtOL2dVRGcxcmpU?=
 =?utf-8?B?YThVVDZvV3p2anJZYVRxQzFpVkdScExERlVOQk0wVXdaMmkxZWdka1BudjJu?=
 =?utf-8?B?dFRrV0JNMWFkcFp4UDQrYzBJZkVTMS82YnZ3WXZzaHZtYkoxemFLdG5VYXM4?=
 =?utf-8?B?cWt2ZEkwdm1zbWxVdGNVMmxGOGxIa1BBbndNK01RV1pacXBNSVJIMWlwZy9N?=
 =?utf-8?B?ZkpGeHJkdXpHSE94OW1tc2dZYTlhVEZ0TUppNG4wOUlvODFpcWtXZTl6bFE1?=
 =?utf-8?B?UC9PeEJhNnU4YkZkeE5EUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlVaU01SbEpvRVFmT3kzbk44UGpUTDg2bkJpdDFZU0ZsemhOdmdFRG9aTFRW?=
 =?utf-8?B?VnZ5RmI1cnFIb0I2MHNmbHcwdzI1VDFMVEV0cDF6eC95bTRNWCtCWHpNQVBZ?=
 =?utf-8?B?MDE0VmdyMjFsb09GVkVmeG5MbG1GWXU1MWhOUm1VVmtxSHdWd2RSVFZMV01t?=
 =?utf-8?B?MXljUm81aEh4MkVFalp5Z09jQlJEM2x4YnlsZllEcnpIdzFNQldGNUlCZ3pT?=
 =?utf-8?B?THp5c051bEM4QW5RcFV0Q1d6djRQa3JRckpIRkR0VnFvY2FLTUdOeFFBOC96?=
 =?utf-8?B?ajJqdHRLM0VTN2UrMDd1ZDQwT1RYZ2U4NzgzbzVWWTFRczB2Smw0Qk1Ga3Bm?=
 =?utf-8?B?WGt3c29yOXZ1ZTNlUk1Wcm1lbWlUQnk5RkxMMnpJeVdSWWc0d3pwUStVMGJS?=
 =?utf-8?B?M1NZVEZaNUxuWFdlSVJTM2dpTXZabVZnVE56MUFVZmkxRWwxOUxyUlBoZWFa?=
 =?utf-8?B?eERCdzhTcnJMWStsOHExSEhvYVAzRDdTVHZpMnpzVFg4eFY2aFdmejVDYU54?=
 =?utf-8?B?QUh4MnJjby9scTdPdDhHNTNkL2hiSGlKd3NEVHo0eWhUc2drSmh0VXBSWGYv?=
 =?utf-8?B?M1AwVDFqZmdraHk4M0hBaCtxTktmWEtvdFFSSHlPS09meG9janVMbVpvNlQ0?=
 =?utf-8?B?R1N1cUJyL1BZTW9DbmErOHBQSDRabWs4dS9mTzJ3d1I3Q0x3MjhJa3p2bWdI?=
 =?utf-8?B?Ykhzek8zdGRRUng2MGFUcXcvVzg0aDBHTEd2UThva2NFTEx5ZzhXMEl4QzFK?=
 =?utf-8?B?UmFRNURsYzkzeTNkMFI2WmJuUGJrU0ROcTU3VkRVMXVwVUlsZXdUYXRhUlU0?=
 =?utf-8?B?MkJ0VlRqNWFwOTR2T3d6NHE2RlpZZ2plYW9IbG9SdWRaaWNuSGJOcmNHTDRR?=
 =?utf-8?B?R0hGTjhHSGc2dTNEY0Y5YVA2QWlQY0FPdW1YaldGSDFHMEdybjJ0SHhZQWY2?=
 =?utf-8?B?WVJPZnhIWU9uS2NoSEJoNzIyUEVUQ1BTS0x3R1p5MXd5Zi83M3FkYWFzck95?=
 =?utf-8?B?bENZVDd1NlhqUTFXN2pnZDdFcHRoZVl6UVVjTHFMMEJFcFJQQTVkdEF2RWQ3?=
 =?utf-8?B?YmlIU1RBWWRON3Q0VGhRVnBZeC9PQTBOTTJESVhPYzZJUnRKaXgvcGt4ZWJv?=
 =?utf-8?B?OTlYUkoyRlU1bjNDbFcrOHhzdjBFK2g3UmN3TUYrdHgzbW9HUC9MdzF3WTQ1?=
 =?utf-8?B?bnp3cnBhODJXYW83K1o4Mzg5WVcxTG54TVVJUVMrZDRId1loUzF4NmxBbzF1?=
 =?utf-8?B?dmF5RlFKZHNFWXhGeGlpeHF1Y0ViaEorZ0g5VlZDamdXVzRSY1AwdXB3SkhX?=
 =?utf-8?B?L3MxVVptYWFGNE82eWFNN29pRnF6RmhTcDZUTUFTZHdYKytRWkE5RzV0VkRL?=
 =?utf-8?B?bUQ0QmJuNjJyTWVxYnVab0FLS0ZYc3kxWmJyVGg3eTdPVUd4UktDNUVtZDJp?=
 =?utf-8?B?TEpzTXl2MDBOM2IrdE9PQkdQUUN5SER0aGt2TFFSWmJQeUhzUzl0SlZQZ0F1?=
 =?utf-8?B?UVpwMnl4QzBFYnFIMHRXeDlRR2EvblJxckdkTW8rQkNGSG8vL1dkNnJYL2tj?=
 =?utf-8?B?eDIvbkQ5K1pRanRIN2VNTzM1ZWlVQ0Uyb1ZQeVRldGRrUjhydzc0WDNXaFBS?=
 =?utf-8?B?ajRRcEdkUmU0V3AvdnZhOEFYRzRzSjlXUGhia1haelk4Y3MycDBoZ1RrSEVX?=
 =?utf-8?B?U2Y3TUZXWllCQ1hkUTRQaStzWEpuUUdTR2pSMnBUS3BQVTE0TVNjS2pXWFow?=
 =?utf-8?B?WHl6NE5rc1ltZlIzeTl0RXMvL3NnVE9mTExIZTYrN3lFbTAxTlRkUWplT29t?=
 =?utf-8?B?eC9qUDNacThMZW9pelRsUlg1SUFJbzZkeHhmRk9FbSt1OVpZUEF2Nmg3V2pq?=
 =?utf-8?B?dzJ5eWlOenhBZW12ODJyZ3dZelBKcFJIdEZ0c25FTWtWQnBUU3FRa05WdC8v?=
 =?utf-8?B?ZTkzc2xib0J0RkhlRlVaMGFlZy8yVjFUaE9JN2NXWVVGSkpteXhxMkFiNDJ2?=
 =?utf-8?B?MGpEWTFtRktsTGQyRFFtK1hhNzkwRkVFY3FnbHlIbmJLelRlZTFLTWFmOXJq?=
 =?utf-8?B?Zmo4RTFRMUhNYmFTWk4xdGtVc2NwU0xTbEk3NEEyNmwyTCtyU3NrQ2NIMUg5?=
 =?utf-8?Q?vvaE7zJqr6FDMqRsmWTsUH/EH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd88dc2-a101-4dca-2f16-08dd137f0ed0
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:44:18.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fq09oY6lNvJ4h+x3EZDpRvabLVERizRmszkLBu5vPUvC8frxNQHMdHdbCMwrQJsAXI1Gn4jboGntGdd/3lERJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

On 03-Dec-24 11:39, Dan Carpenter wrote:
> On Tue, Dec 03, 2024 at 10:32:13AM +0100, Mateusz Polchlopek wrote:
>>
>>
>> On 11/30/2024 11:01 AM, Dan Carpenter wrote:
>>> The dr_domain_add_vport_cap() function genereally returns NULL on error
>>
>> Typo. Should be "generally"
>>
> 
> Sure.
> 
>>> but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
>>> retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
>>
>> Please remove unnecessary space.
>>
> 
> What are you talking about?

Oh, I see it :)
Double space between "retry." and "The"

-- YK

> regards,
> dan carpenter
> 
> 


