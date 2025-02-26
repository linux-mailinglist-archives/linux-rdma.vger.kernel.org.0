Return-Path: <linux-rdma+bounces-8141-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8BBA45F64
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E9016A096
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C9821576D;
	Wed, 26 Feb 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nipc5Qtz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EBF1CFBC
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573387; cv=fail; b=tVucGC/es+wWFlUwDLRwpiOuShuRiTZP0/BjgGBbv0l8dJXT7MNRN+AW0Epn8SKiT6VNZE+VhjQpfkE4S8e44LZB0W+3ZIYrn4HBsO3nufY+9pFCD6QumQdDlICvatmvXWZ7awf+iEPVwq07/QOQaV1sQfBrcmfY9yqvG1I5gbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573387; c=relaxed/simple;
	bh=TE97sn12xQbwcUVWhesv6xCAckpv3/LRyiAtwOnw0k4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pwyAaT8CX7OBBdE5q+SaX4Vgt76L/Nvi8VleSbNPSAC9C5hwW018orp0jA5fOJddquQc/ot+maKGRYqFImseKJvgpav4Dd0qEIoz3FIg78iJnvEejl5vfBaNTQU3N0WWQ2ZAozBTQ9WgXoM8aUhCtZ3ZLtFj59IudGxEeGOmawQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nipc5Qtz; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoowOFi2xuacW47JqJFjnVFY2hfQ8x7MquOGX749Ljxnj9d8zh0lYZHC6yT4MaBaFhc182ap2y2rUZ9TU2y6mEQ+j2kSYnoZ8/HszQpp+yGJ61RxansZQcAU0LXYTJT0c2hRnIw8EDzmjD9OLf5AmmH4C7sjclgcpB/tuLzIr6NVamsaSqhM6LG3lGSemCQv63YdDa5cnfQJCHcSqmHpfohsuZFUw4CQa4i5uufRd+gQNtimadEvXEVZhIq+bm5hevqbgYzkL8LMJNydlPUly8GA6zThQH0BujchyeV1nQJX3jD+P3gSZHjE/pWm2y6pjRfybaHAuxGkPcYQf9PAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9v+OnGILUYUhzKPa7JYX5M9cdURncuAmHcJkP/WpmI=;
 b=pn5LheM6Q/h3N8LlgLdPkYKzD1GDRQ8u0H7PHp5OAUc/ByG5cotb1cvphGVc9rZ7HvR8W62hLJt9UE+mffk2Oz4dYMAeSkz+0hAH/JGs6Q5QM7fCzpJOq6rb0das8Vyq+giU+0BVdt2Sw4NV/nUWdmfFi53Bf5MgYV3OaGTdASQLl0sfu0VjSnwdk6FivqLSvGU/I1CcylIPq63nnQlm/Y+XUFjkkTqhgFZEJxaEDzrQDH7wKYnOxpgmJN3JoZ6VIZ55ogsGO/ZnVDdSCu9++mXVLQRsh3BzRduzsH2EaLomWYQ75/8MpSiW+xLPKaFtMz1IyGc0jpvEeQj1FoFcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9v+OnGILUYUhzKPa7JYX5M9cdURncuAmHcJkP/WpmI=;
 b=Nipc5QtzsTeY6Ip/mklPbN4BGWstutN53BiflXSh87SAyPMSTESWrWwiBXS2XrsCLODXIoQoKU65iRSGuuuB7JyCVvnUI+mZW9K2VgbzVXubiwuAVp5aL9c5yLwASbo21ABufxmBfFKtai3PtbFR+VUZK+dAWejfiPFwFpV8P61Bw6BHEPHmB/VIu0RlFWrMuYvZbBty4DpBS5MUNsGaucKWvLXSoFFkwkoq8U6BEHEQXT9Qj9OQf32yChCdx5Nx9SR7lJ/JmDmAQqZvchMrkls0LJrY9Wp3KrkCwUJaFgEVAdk+GMrS5llUdBEwW35KSBDiVkmfGSKAfiJ9JtZccw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) by
 IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 12:36:23 +0000
Received: from DM3PR12MB9414.namprd12.prod.outlook.com
 ([fe80::ee7a:8e5e:b401:5fa9]) by DM3PR12MB9414.namprd12.prod.outlook.com
 ([fe80::ee7a:8e5e:b401:5fa9%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 12:36:22 +0000
Message-ID: <ca363e7d-9c77-4014-8786-8b3ed8d89525@nvidia.com>
Date: Wed, 26 Feb 2025 14:36:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next] RDMA/uverbs: Propagate errors from
 rdma_lookup_get_uobject()
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org
References: <520b83c80829714cebc3c99b8ea370a039f6144c.1739973096.git.leon@kernel.org>
 <20250219144616.GO4183890@nvidia.com> <20250219155647.GI53094@unreal>
 <20250219175335.GA28076@nvidia.com> <20250220065938.GJ53094@unreal>
 <20250220090652.GN53094@unreal> <20250220135352.GA50639@nvidia.com>
 <20250223085226.GW53094@unreal>
Content-Language: en-US
From: Maher Sanalla <msanalla@nvidia.com>
In-Reply-To: <20250223085226.GW53094@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To DM3PR12MB9414.namprd12.prod.outlook.com
 (2603:10b6:0:47::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9414:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fb3cca-03f5-4c20-6d12-08dd56622d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWdsYk8rckZaOWkxQm5KMjdkanBwcS80b0xMTXhlRDc2eGZHakJaZitNZDNu?=
 =?utf-8?B?bG1XTDQzYnFjemE2VUFycS9jcGJTRi9LRnByK3hOV0FQcUZ4a0t4R3IrQzlv?=
 =?utf-8?B?VWxsVTQzQ3FxaUhZRlY2QTRoZVIrdDFtTGVmLyt2OUIvTitLeDNhVXBESlJa?=
 =?utf-8?B?bkN2cGZ4MVFCWUxMT3dacHFMZGgzYTdEbkNWNVFwOFJyOVY2cDN1UG5jZnFY?=
 =?utf-8?B?L3ZVRkN3NUtBdnVtMjZXRk53eFZSZXQxU2ZmaWN5QlhBSzRnUU9EUm12MDFY?=
 =?utf-8?B?TWdBTTVLKy9ORXpDOTRCVXBWSDNRdStiQmc5UnROZ1BLakVac3B0WWhIYy90?=
 =?utf-8?B?RWdTcGtSeEpQOVZteTdCdEpuQnhRejZlZTFtdnF4elIyTWoxQ3Q0cXNaVHhp?=
 =?utf-8?B?QWJ4K1orNGNmOWl0by9DZkRiWVJIYU5ET3NlWk5VS3pDMTJ1L0hmdFljdlZT?=
 =?utf-8?B?Q293Z2Jrdi8zVVZhS2RIYmxSVG5nTDBXTFIzWEYzUDB4TWdjWllhN3ZvcENy?=
 =?utf-8?B?bEcyOXRBZk4wVHNsTmd3elpKaUJQTDE0UG9BbXhLaVhiM0t5NlVMMjhBVTJD?=
 =?utf-8?B?Mm1Sd2dQQkRIT1lnTk4xVzRPTjVZNmZJRXMzc01kelRWYkZxdVUzWWJyM2ZD?=
 =?utf-8?B?bm95Y05XMEFKNWpGVFpLb0NRTTV1SENjQjY2R05mM003Z0J2a0lMbGo3UDE0?=
 =?utf-8?B?L1FoaW9DU2hxSGpyNjBRdEg5cFEvZ1AwL3ZSMTJnTWJQS0hWVWo3V0crV2xo?=
 =?utf-8?B?UTcrTElXYXR2b3RWTUQxVjFNWFh2Uy9hQlVKd25nbFlJMHppMFpqdTI3eVRS?=
 =?utf-8?B?dy9pQUtKRE1QWG9sUzMzRHdkMGEyaTg3YTR4WkZXNm45dGYvWnBsdmFSUEpl?=
 =?utf-8?B?SUlCYnpIWXpoenU1bmw2WHhyQnJVbkhKQ0UwUXMxKzNQenpCbVpPVDRSZ3dV?=
 =?utf-8?B?NWYvUUJXRTVtNklHcXovY3c5NmF5VitHa0R5SzBVcU9aTXBRR2FFNWQ3Rzhh?=
 =?utf-8?B?SXNKUmhFc0R6RUhKNzNzNW5qWi96RkRBUmd3TzVtL2VraWQwYzFBdGo2OWFz?=
 =?utf-8?B?VEs0VUs4UitqVEhlRHdteTF5VUdjT2RLYllaTUZCcHJXa3hubnVQQ2Y2K1J3?=
 =?utf-8?B?aThpTmREWnBwYmtJZ01WSWVTTWkrSlNPVlFzZ0VvQ2NCRTE0N25ZanRSM2dM?=
 =?utf-8?B?M3dhYzNzZlF2ckxOK0ZuMjQrS3FTbGZYK256STN1clNrVUQ2QW9QV3FkRS9B?=
 =?utf-8?B?RVJlSzh0QWpLMDBueWg0N21TWCtMcTM4SWU4SlBwZVVndFF3dkVEMGlsUmdM?=
 =?utf-8?B?STFDSW1ZVlpFenVxUk0xSXZibzV5OVZrQjdCSjVZdDlyT2NBV1p6S1pLUnlV?=
 =?utf-8?B?TGExYUVSeUN3QkR2azNPVDBhUzNOU29RWmhEQ0krUitUM2dST2VJS2ZkQVhD?=
 =?utf-8?B?NGkweDR5V21MeXZ3K1BjSXhMYnU1My9DS3JIRjhvaHZXS1ZRbitIK3lXdm15?=
 =?utf-8?B?clJibk5xM01jUEhkOTFwVnhadEhwQTN0TzNDV1hMRFhseXlISE55M2N4bFBE?=
 =?utf-8?B?SU9wc3doNWtBQVRiL25wYTdDcTFtT1IvZ2p5MlNMZUIxaFNDc0tiT1grOVNy?=
 =?utf-8?B?WFJhcCtzL2Jpb2VKR0l1SUxkNU1YZFVueC9RcUZzcFZWcVJhN2hUQlRDaitx?=
 =?utf-8?B?WXE4TW95VS9ReHBuM1NBbUt1SjNYVksyWkFGR0sxSW85akJ1dllHTlBVZUIz?=
 =?utf-8?B?RW5Ob00xZ29BcmJmcXE4VXNTZmdja0ZhTFAyMmdlb3U5YXUwSkdFMGpZb1Nv?=
 =?utf-8?B?NXprOFNxdWs4M0pkU053MWtieXNGWi8rdzdVRmZJS2ZINzhoRWRZc3BQejQv?=
 =?utf-8?Q?tmhbDn1kAYcno?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3FFVllBUHpYY3l2M29nazJna08rWFBiQk0vc1k0V1RjcnpvRWtlZ0Mzc2hD?=
 =?utf-8?B?bFIzQ0dJRHY3MzJRMTVPV3YycXZLRjZkS2ZLbEQrVG1ZMEl5dnhmM1NTYi9S?=
 =?utf-8?B?cno0YytIT09IMzJLZU9VdVhPakFCMXR0Wlg1NTh6VmVXTks5SzZzMUlIbEFr?=
 =?utf-8?B?dm1BTmFrUzh3UndsSnEwMXFYWnIwY0prSFhkVm85WGE0OVgvV1BLRlRkQmxH?=
 =?utf-8?B?OTY4bGtRR29GeGpWS1FZWkR2YVlPQlN0YnRHTk5qSG1QbGVnNEhrcFh4N0I1?=
 =?utf-8?B?L2MwbmJvakIwalRTbFhTWFhHUkhncGFVS0pONWhvcnQ2WDRkd3Jad0tMclJn?=
 =?utf-8?B?M0VSSDc1Z0daRXhuMVE2OE1OejA3ZVgweUVod1BuY085MjdIQmJGMXhFcjUz?=
 =?utf-8?B?YjlsQ0k1UDN4aE5COXp0a0xocjZQNW1NL3BWOVpXbWtZRmRYRjVycCtZU1hR?=
 =?utf-8?B?bEc2YldLaWYwQjF6NTg4c3dacCtOYWZUUC9XQVpmMTFvalVpVjVYeFF2bTJ3?=
 =?utf-8?B?dnpCVVZqZy9CWDN5K1gvWmdmNDYwRTl1ODQxa1ZlMURXbzlvNVVvMmJFZG9C?=
 =?utf-8?B?WDBkb05ZWlJGS2VrZ2pSeFdzdWt6cEMzWTBaYUpFZ1g1eCtteEdsVG5iSFBz?=
 =?utf-8?B?YkdWQythQmZ5M1l6TzhlUDVDbURGRVQyMHRRdk9GdDBDaE5TSFlUMGQ1aWY4?=
 =?utf-8?B?WFFLVGNYbGhEWEdEcU8vd1Jvc1h3dkZnLzUrUkV3STBUTk5iSEh1UXVGbUNx?=
 =?utf-8?B?aFl4WlRNYlJEc2lSeDZvU2tqUU0vbjZvK1orRUdwdzY5UVU1d043YTdpNzVJ?=
 =?utf-8?B?SUtqMXpvNjJZREorczA2OXQ5OERieU1LeGVnN3lxUHpUc1pnNzFKSC9lOGpO?=
 =?utf-8?B?UXR0SklHZldZRDRRREY1TnY2eFYzOVRVNkNBUWM5ZGdmODhidnFHaHJtRFVV?=
 =?utf-8?B?a0xvdEdPaWR4NGt6K0R5MStvczN5NFRtUHYrWG4rNmlGNWZGL1VZQ0lYbUFH?=
 =?utf-8?B?ciswemM3aFl1L0E3ZU5ySENnV3gzWkhHSjc3TkFZRnpjTENDcWFqODBFRVl6?=
 =?utf-8?B?cWRkQzlLZGFNMGN2cERNekUyTzYyODNPRHRJTjVEcUx5eDhHUWthblRsWHFo?=
 =?utf-8?B?d29QSWl3S2lZU3FYdTREODZiSVl4VmhxTkw3NmJ1eklDekoxVGJocnQ2SEVo?=
 =?utf-8?B?dTYwdjhRRW83bmZFczZVRU9EcGR2eDdjVy8ydGpXZUIzVmNkYmU2eDZyM2ZB?=
 =?utf-8?B?SkRxb2tNZUhZMEU5L0hHdGtqSlM1Nys2R2MxbDJLS3pYc1NGSVVDaDRIRUU2?=
 =?utf-8?B?SkF1SFFqTVQxZEFCTDY1QkJLMU5OVmdZc0xLNEVaZlRFWGJYMjBtZ1crM2pM?=
 =?utf-8?B?YXRzSjRvaGpMeWNYTFpRR3RLeThDTEFKUWcwWGNPa29CSHBIa0NuZjNxRHdl?=
 =?utf-8?B?SUo3NlE1QjBGZzh2TDZ6NzZXMDhqa1h0VG5tRmx4MStQVFZaUWhHbFBoc1Vt?=
 =?utf-8?B?SXF3R1ZyTmo1ODJQUFdyTEhPbDB5S2hwc3ZEN1NKNFpld1IyUDBPdmpnYlZ5?=
 =?utf-8?B?QzhmZ3BsOHZjUUY5bVYxVjZ4UFplR25tRTd0VDNVMDRnQ2J1dzJCWnBnQndJ?=
 =?utf-8?B?U1JubXcxT0pwVnFrWUtQaUxvWUdsU2NyYytlZmh2YkR3OWordVd1RzJ5SFhU?=
 =?utf-8?B?T2lidFB6cVd1bGJZUXlQMXhJZnNqUTFjazVibHNxNWtmUHlDeTdicmVkOGxG?=
 =?utf-8?B?eGs5S3h2eU9TQktwUVNVSnBTTkdXK1RmZG5jUWNKdlI4MTBYQXRtZldSbHEz?=
 =?utf-8?B?dXFMNEZ5eURpZmtiYUhDMVl0OG9CMkxIb1Q1MDZWVEYrR0JWUmJTM2xqMWU5?=
 =?utf-8?B?ZVRmZFlvU2RRcnA1Uk1seXRuK1g3Z0wyaThMT05zMGpEd3F1NjliQ2dOaDI0?=
 =?utf-8?B?Qjl5UGhvdHhkek9Cays1VmZSR21XRnNoYWdsSEMzSThtOGlQb3RZV3RmbGg1?=
 =?utf-8?B?eWVZUS8vQWRBVE9ZNWpPSU9VVVVudjlneTc1VmZjV3o4NEpURkRDSHQza2x3?=
 =?utf-8?B?OTkyR09KSkkzTlR1TksyQ1BFVUdQZ1NOWTh3SjBHMFNRb0VQb3JqcmJ3Mnhh?=
 =?utf-8?Q?LbYgWk/pMctonKFCIQbufbjYi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fb3cca-03f5-4c20-6d12-08dd56622d78
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:36:22.8817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3pv4nX7nRdaHzYq9/Ngi5GPeiKx7dvIkxlZihTVM7/OchuE7DGp5kqaS3eEmIooP7zXQ8opEdcN7Uz/dfl3lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518



On 23/02/2025 10:52, Leon Romanovsky wrote:
> 
> 
> On Thu, Feb 20, 2025 at 09:53:52AM -0400, Jason Gunthorpe wrote:
>> On Thu, Feb 20, 2025 at 11:06:52AM +0200, Leon Romanovsky wrote:
>>>> Mainly -EBUSY from FW command interface, so users can safely call again
>>>> to modify QP.
>>>
>>> Forget about this comment, I was distracted, and it is -EBUSY from
>>> uverbs_try_lock_object() and not from FW command interface.
>>
>> Userspace is doing something really wrong if it is triggering that..
> 
> And right now, userspace isn't aware of it. Users will be aware of it, after
> we will return real error code and not mask everything under same -EINVAL.
> 
Yes.
Currently, most libibverbs calls pass the kernel-masked return value 
directly to the application.

Thanks.
> Thanks
> 
>>
>> Jason


