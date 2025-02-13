Return-Path: <linux-rdma+bounces-7753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 224FEA3516D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 23:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB9A188FA3A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 22:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6184B26E17F;
	Thu, 13 Feb 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XwB588dg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289D62661B9;
	Thu, 13 Feb 2025 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486692; cv=fail; b=svGOMXZJnt4160GtNCTPOq5bEjGaypSGYsTw1/kb2AGMAF8I7qjzwrVtPO+1/h3z3MkI/Jfsjf+NoZaL+m+z3xPqrMfPIaIOsseNGgHNIxu3OCPCPgTdffqAbA1SG5ujosYDIaguvBovs3OaX/TPuWr92AiBrlMaZzPm1fr1p6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486692; c=relaxed/simple;
	bh=VJ/5AXMzGVm2hubfWF7Imr4P/IrZs1JSvoT3riDerQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tl5VRzouDyoPwXPOMpeXLfh5B180ORUJG7UKTjk5WDiYPULO8CMV044RGXOG0eEFDhwWWH3UYwmvHKcrbz07t+us3CGDbaoXMtB97iUxk1SmQ6KMKqPv3/QUMcFbsGdPTLAtoyjPz2at3mm6+55dNZNH+P3HXMDTif1tYnMm/Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XwB588dg; arc=fail smtp.client-ip=40.107.212.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4E2nEnpv947zCLJePcJsJ3pqwLAQAdSQ9H2Xl5C2Sgu0+8pU3b8gnc5wipzzqlnoA6iNkxs3baRF1x6O0kklyOCuWevOYo36Eg/EHzhMpH919Tb6zwgCuvZrkVPbd6q8hZamKg6N9PYMx1muWiK9ioMUoeY162CRCnchRITFGzal5+TUpmNmC2L8rvbVbLuFvl7/4i1YeU7hOtWGSuwa9eqk75M3tyI9OvsSMiaw0xwNDXbgaFJGF0BN2KNVaxBmV1P525IjcGZTk80j0Gw9zFz+iFHnKYpPlQuIoOThlc4d3FRt6A3FPVmqpyTVM9hxzb6CfGNlMEX5yXzB09w/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j0rq177pmQ14iZNQrYfIAcmwxR26Ifml0tWTaYDoXg=;
 b=HEul8DyufVWopvv7rmHpEpWufDEC160nVxsUKbs6qZa0PvhvViuI6HrvTgmPc9KbTppHGNgy9eauGft0EVqpXI4tnxoxq98aI1y5Yw4L7oXFsRMbKXRZcf150SUffBob/wJm9QLC2gVAO4jjOn8H55sYh6TK9b5yXPNBL46icXDxwF5V8MX+xO585ww43mHuwyMXxYkWDorUbfpjr8rahMKGcpNVIrWCZgBOdRLw1C3iXM8fyY6QzwAZ5/lxXPabAbzRIL5+cw9bEHl7HjwlAdNsEZosJn4/NEALrjOjq8EUGyEPE42uxVjwqPKgmaUI29EhREc4fvwhDH1lET8CWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j0rq177pmQ14iZNQrYfIAcmwxR26Ifml0tWTaYDoXg=;
 b=XwB588dg+UqOrbswtZEk5sj55xoPRausbYnhM1Uq0vfPKFnDmHo8qJZV2Z7VtQwhhU4yEDVu4APBQQxRrkI8aR4C2Uwmi3ntAWoQ64LqYsfILEt35lPBeRQIy/v1VdFVrP4fhQQK4uCZ+6u9SljCWQgoFDxn2XAziLdZ9W/YnQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB8332.namprd12.prod.outlook.com (2603:10b6:610:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 22:44:47 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 22:44:47 +0000
Message-ID: <eea7b6cf-5e69-4799-9faa-ef625e4545b2@amd.com>
Date: Thu, 13 Feb 2025 14:44:44 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 1/5] pds_core: specify auxiliary_device to be
 created
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, saeedm@nvidia.com,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-2-shannon.nelson@amd.com>
 <20250212115738.0000161b@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250212115738.0000161b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0048.namprd07.prod.outlook.com
 (2603:10b6:a03:60::25) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: 166535f9-115c-49fc-a3d4-08dd4c800457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDJuNnY0MU1Td2t6RzA0d3NmOFFFY1VCNFAyQnhoRlQ4Sm5yT0ptZ1FBSzJC?=
 =?utf-8?B?RGVtVDhpZGwxakRGaUIxd20wSmpnUmhncTBiWTBzc2J3NmRZTFhVVzJORktC?=
 =?utf-8?B?WUtTSW9CVE1OM0lXNDdOakxLbU83cmt1c1Q2aTRnMGZqRklhcFpSaDFQR2wv?=
 =?utf-8?B?VGZWaFZFSkNDZzFTc21GQXZRQnBlR2xwUTYwTW4zemxoVHhNajhocGNaK1RG?=
 =?utf-8?B?Ujl3ZEQ4bVd2U1J5UFB5TnNnNE5lVHhkc1V3SUpmMkMrOXpUbWZxWG5yZ09L?=
 =?utf-8?B?RUVmTHlTTEk5ZU9DUlJpeFNOUkFSb0RnV0psTUw1YTgzMGZ0L2dYTElaRFhI?=
 =?utf-8?B?dDhEZ3pLeU9Nc0FCZFFyMmdHU2trNmdoZVRLRDV0d1NwRmc5a2JyUnhJVWxx?=
 =?utf-8?B?S0tEMUhMekRIQmsrSUV4VHRPMWsydVJQZTkvMDd4L1M2TTIxVVQ2aGJVaEVV?=
 =?utf-8?B?VzBRb0NiVFNLRXErM0FMdWVuaDNkRElxL1NMbDdZYmlyV2xzUDFuaVFQOERl?=
 =?utf-8?B?TjZVN3ZuTk52d3ZpUVZHN2RvL1dyb1paZGl5UG81UkNHQkpCTGllcENBL1d2?=
 =?utf-8?B?YTRZZldBV3RGcFVyeVJJS3VZb004azFFTFhtN1U5cDY4ZmV5R0ZjZkUzR05x?=
 =?utf-8?B?Q0J3aW4wcS9FWERSR0ZYdCthZExwYXJKUnVDZTBIUi9aOGwzRXdRM094K1dn?=
 =?utf-8?B?Y2h3Z2owcUkxUVpRQ0xLVE11NjJGMzZkWWxDaFE1dGVlak9sVjFHcWFHWW1j?=
 =?utf-8?B?dW56ak5vRk44K0tmUVQ1V0VJbmZ2RWNOR1VzdE5YUEtEMEx1djVzLzh1dGpp?=
 =?utf-8?B?SDRzbm5rTTh6Z1RnSm1NWnM1WXd5NHgyWDNSbG1VQ2tNN1FPVndaakpPOFU1?=
 =?utf-8?B?TDJwUmVIMmdBdjZ2elpwbExuaWcxUm90ODh2cmE2dlE1YnEyWndYSldDS1Ay?=
 =?utf-8?B?V21keWpmUVZlTXpLRDNVb1RGdngzRFZUVE83ekNaWHcrTUpoVXVSUWtzUlpD?=
 =?utf-8?B?Q1ZzQ3VCZE85NUt6ZjI2T0xBc0RaVkMxUitWQnpZWGgyRzVNS3IwdVp1d0V2?=
 =?utf-8?B?SUpBbHZVV08yVE9yOE1VaEJQdksxVDViVmdzSFNXc2RvUkEwY3VVQXdPMnc3?=
 =?utf-8?B?QXlJYTcxY2JyL09BZnNTNmxISWhMbG9MdmF3Z3YyblUwUHFKWVNTd0dURGp1?=
 =?utf-8?B?YUNUYndyRXpTYnh5cnZ0eU81bGp0QnRsejBoeFJlbXBuMk1kOFFZdnl0QUJD?=
 =?utf-8?B?UkQ0R0tnais5OVFHWkhKWmM3QkVpSjczaTlSbTFpSzBveXRDM0lLNDJJelNY?=
 =?utf-8?B?OURlRlBzc0d6eHFCdk8rL0NqZTcxdGhqNVFwZ3hPcjJKcUFVeHNSQjk2UWxP?=
 =?utf-8?B?cGVvdXVkZHZ0TVhrK1dnWVpnbkptV0hPNE5meTR4SVdNa0E2RkVtLzBmclMx?=
 =?utf-8?B?SkIrM3ZuemRDdDVlR0NicTRERktZUnBjVW5YMHdzTGJTTVA3ZFJyTmJUUFph?=
 =?utf-8?B?SHRyeE5LY0hVUHNuVGhEYWdySTZRcFNEcE9LVlBQYndoSHZmWmVjcTNDbUtT?=
 =?utf-8?B?a3dZQjM0L3o3ZlpvWExpa2xzYTg5aE9oTkx1MkJhYTZuWXhyVzdxdFVTRXpB?=
 =?utf-8?B?Ni9MSnpnUVdOU0RFaEdGWHFvNk5lbjQyajR4Mml3UkhEaXlFK0NpelpRc0NR?=
 =?utf-8?B?VmlYWXhYT3NLN2k3MHJDUzZJcEN1L1NNbzdobEdvbEhIMnliOEtxSHVPS0ph?=
 =?utf-8?B?ZkFmZENmV0FQbnFwd0I0SS9yNityOHFnVXY0cXQzand5QWxYb09Ka2p5YXpa?=
 =?utf-8?B?cEp4QlVxM3lVVXdnZzA1Y2t1VDRIdTd5aUtaTjRxdlpZeGZJa0M5Y3BuR1RR?=
 =?utf-8?Q?F7Owo/y0QytV6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b21rRWhWb2lxVlEwUmV4Vmp4cHZvWXNuUkhEem54K002dkhnbjQ3dytEOWJH?=
 =?utf-8?B?dDQ2RXE1RkFFM3pLZUJZL042enZLLzA3aVV0S0s5cnZ2NUl5Q2o1bWFRcUhH?=
 =?utf-8?B?b0JiNGl0QkNBUHRnMXZGbGp0ZjBSWGhGQlExUkZYZXAybUNEVm00N25YMXBh?=
 =?utf-8?B?d09VOUIyalQxeDVGWHNzK1NVa3piQkNsVkpPNzBZSWRONnBrbERJUGxST0Nq?=
 =?utf-8?B?Y0o1ZFRRQW9UUHkxY1F5cjlXb1R4bi9ZYjNlWXRCd0gvanhVbUFEcVFxV205?=
 =?utf-8?B?emowV3c2Um45WUFCQmQwK2JSV0FFeEI5emNvVEFiRkZVU1NpcVpBcXR2bDNh?=
 =?utf-8?B?YXZ1Y0ttMXdxclhOM0g4YmlhSnU2L040QW1kejlYQWIxNDBiaVo2MHNNSEFm?=
 =?utf-8?B?amQxbTNzMTh0TVNFQ25UdWF3T3JjUEwxcVVQMUZxM3c5Nk9jV295K05GNWhE?=
 =?utf-8?B?RXhudDFDT00ycWtMZmo4dlJvS0V1VnRFWkx4QjR5SzdBK0E3MFlEMmY4Z2o3?=
 =?utf-8?B?NzU1Zk9GZXIreFE3ekZ1S1Q4MDJPUmlRL1M4czhkL3hacGQyVnI2bXI1ek9N?=
 =?utf-8?B?LzdCdWd4Q0czend0WGFwZ1FvK2orYUZreWRvYldneFcrSGE5bjJMRHpNaVVj?=
 =?utf-8?B?VEdRMk9kTTh3MGtRNTVLak9YYm1EdHVSWFNaMmQ0V3FVRVJxemJROHc0YzNk?=
 =?utf-8?B?dzk0Qng1MThNcDZsY080NkdPNkY4VGhydzhtSzlYdEh3OWdNWXJ4YjBJeEll?=
 =?utf-8?B?TWlsYjJlNzV6Y003NTFFSmRDQkhjdVJwMnNyajJ3cWVpcFdvUmEyY3piOU1h?=
 =?utf-8?B?R1lrdDlESHhuaHpoSHBocndkYnN5d2oxSWs1UmpkN1dHL3pnMzBvVVJiYUNi?=
 =?utf-8?B?WFdVSHVnUUo2Q25EenZHQjBGSjdzcDZFb01ocDlGRUZSa2xyYWhHN0NDaDh6?=
 =?utf-8?B?UmoxYTNYcHdhM0FBS3B1b25YWlhBQitScEtsbWl4QVVlT2JTc3F1WWNvYXFG?=
 =?utf-8?B?Wng4U1dCVkVJcFVKcC85NytFWmJJU0hsaVJMK3pTRzdFWjdYTGNPamd2b0tG?=
 =?utf-8?B?YnVYZ1Fzc0hhVHhIckxvS09tS0dGMUZHd0RxY2ZXSU82Q1ZIeGVTNzVmMy9Z?=
 =?utf-8?B?VE52UnRzOHhyNDREclVwRExvNVFydTNHSnM4QzRQWFUvMEhkNVVDdmk1SnNL?=
 =?utf-8?B?SS84cWFvRXl2WjdDUi9yVFlFNHdFSnRWU3lUNWsvbm5RSGRsbXI4Q2xWV3cy?=
 =?utf-8?B?TmRLNU1HcmxSYjlucEJmbG1HZ21xd2dEZjlPdUdtTGJna2Y5SFNUUzlGT1U4?=
 =?utf-8?B?MUJyYmxzbmZ5bFlsWWQxM3BsZ3M4d3FQWlRDaFBhUzVsVjlOYmd4TnFObldl?=
 =?utf-8?B?d2xibzR5NWtXOXNFUC9pb3NGYXpOVXd2dmRLOFQxUjRJaUZjeWtKUmNIUDRk?=
 =?utf-8?B?U3p1U0lYbzVDZUw2bnZvVmpuSEkrYlFxSDJUMVRoMG9KdDdod1JnZ3I1Mk8v?=
 =?utf-8?B?dE1ianl2Ri9xa2U0ZWg3VCtueE9lUXVxbjNBdHRlYmNBMmNBN01XZUpaLzBy?=
 =?utf-8?B?M2NZa1M5S2N6SmdqVXphNkdIVzNxODJOMXRiWFhDeWMrcUNJSStqbzJ4SzJD?=
 =?utf-8?B?ZmIwcmRQOHRaTU1WMlFzLzMycVIxS1VWQ2ZyMlFuK0dLd1dFOVk5RDlEOENr?=
 =?utf-8?B?Szlnc0R6OTYrVERaUFVPZ0JuYWpPNVhQN3gvSDc0d01hc1crQWdaTk1QMVBK?=
 =?utf-8?B?SVI5Sld0dGgyZTBPNVgxVVNvTm1ndVhWckNhY01rMndwRmFyOHI2OFpNSW5u?=
 =?utf-8?B?aTdhU1pCLzV5SUdCbnpwRCtmSTlEKzZUM1JERnBNVmlTOCt3SUhFc21JOVh3?=
 =?utf-8?B?OVdDYWFlKzFRcm1BTEE4Nm0yRDJWNXU5dmpQR2ZaeWtHbjdkVHNyQythQS9X?=
 =?utf-8?B?a0hPMm9LWlVHZ00vZHZGaGhMem0ySDByMUZ5S3BFdXpPR0Y5NUNqenVuOVBW?=
 =?utf-8?B?emkydVlXMXFFVnVUNUpxeFNDNnh2eFV3ZFhwcjNHbUdOL0NRdk81RzAwOS83?=
 =?utf-8?B?emVLZ3Y3UTlFREw5cTROVEc1QWtVTUIzeUZqNWcycXRsRWM5SGdKcGJMQTBM?=
 =?utf-8?Q?KJeGi8/bQOyrEGi272wDt1cnC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166535f9-115c-49fc-a3d4-08dd4c800457
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 22:44:47.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jff5MuDOkDWG+AaKsZM2mI1DIZ1p6RYyPToZ4jxB+nPhPEXBC4UEblppRH54X45j0sRnFAtiQx3P0cn4dqJftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8332

On 2/12/2025 3:57 AM, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 15:48:50 -0800
> Shannon Nelson <shannon.nelson@amd.com> wrote:
> 
>> In preparation for adding a new auxiliary_device for the
>> PF, make the vif type an argument to pdsc_auxbus_dev_add().
>> We also now pass in the address to where we'll keep the new
>> padev pointer so that the caller can specify where to save it
>> but we can still change it under the mutex and keep the mutex
>> usage within the function.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> One trivial comment inline.
> 
>> ---
>>   drivers/net/ethernet/amd/pds_core/auxbus.c  | 41 ++++++++++-----------
>>   drivers/net/ethernet/amd/pds_core/core.h    |  7 +++-
>>   drivers/net/ethernet/amd/pds_core/devlink.c |  6 ++-
>>   drivers/net/ethernet/amd/pds_core/main.c    | 11 ++++--
>>   4 files changed, 36 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
>> index 2babea110991..0a3035adda52 100644
>> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
>> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
>> @@ -175,34 +175,37 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
>>        return padev;
>>   }
>>
>> -int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
>> +int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
>> +                     struct pds_auxiliary_dev **pd_ptr)
>>   {
>>        struct pds_auxiliary_dev *padev;
>> -     int err = 0;
>>
>>        if (!cf)
>>                return -ENODEV;
>>
>> +     if (!*pd_ptr)
>> +             return 0;
>> +
>>        mutex_lock(&pf->config_lock);
>>
>> -     padev = pf->vfs[cf->vf_id].padev;
>> -     if (padev) {
>> -             pds_client_unregister(pf, padev->client_id);
>> -             auxiliary_device_delete(&padev->aux_dev);
>> -             auxiliary_device_uninit(&padev->aux_dev);
>> -             padev->client_id = 0;
>> -     }
>> -     pf->vfs[cf->vf_id].padev = NULL;
>> +     padev = *pd_ptr;
>> +     pds_client_unregister(pf, padev->client_id);
>> +     auxiliary_device_delete(&padev->aux_dev);
>> +     auxiliary_device_uninit(&padev->aux_dev);
>> +     padev->client_id = 0;
>> +     *pd_ptr = NULL;
>>
>>        mutex_unlock(&pf->config_lock);
>> -     return err;
>> +
>> +     return 0;
> 
> If you are always going to return 0, maybe change the signature
> to not return anything?
> 
> Would require changing the ternary usage below, but perhaps
> it is worth it to remove the implication of failures being
> a possibility.

There is the one error case in pdsc_auxbus_dev_del(), but even that is 
rather useless in that any call is already going to have to have a valid 
pdsc struct to get here.  Yes, I can look at adding a clean-up patch to 
get rid of this useless return before changing the rest of the function 
signature.

sln


> 
> 
>>   }
>>
>> -int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>> +int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
>> +                     enum pds_core_vif_types vt,
>> +                     struct pds_auxiliary_dev **pd_ptr)
>>   {
>>        struct pds_auxiliary_dev *padev;
>>        char devname[PDS_DEVNAME_LEN];
>> -     enum pds_core_vif_types vt;
>>        unsigned long mask;
>>        u16 vt_support;
>>        int client_id;
>> @@ -211,6 +214,9 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>>        if (!cf)
>>                return -ENODEV;
>>
>> +     if (vt >= PDS_DEV_TYPE_MAX)
>> +             return -EINVAL;
>> +
>>        mutex_lock(&pf->config_lock);
>>
>>        mask = BIT_ULL(PDSC_S_FW_DEAD) |
>> @@ -222,17 +228,10 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>>                goto out_unlock;
>>        }
>>
>> -     /* We only support vDPA so far, so it is the only one to
>> -      * be verified that it is available in the Core device and
>> -      * enabled in the devlink param.  In the future this might
>> -      * become a loop for several VIF types.
>> -      */
>> -
>>        /* Verify that the type is supported and enabled.  It is not
>>         * an error if there is no auxbus device support for this
>>         * VF, it just means something else needs to happen with it.
>>         */
>> -     vt = PDS_DEV_TYPE_VDPA;
>>        vt_support = !!le16_to_cpu(pf->dev_ident.vif_types[vt]);
>>        if (!(vt_support &&
>>              pf->viftype_status[vt].supported &&
>> @@ -258,7 +257,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>>                err = PTR_ERR(padev);
>>                goto out_unlock;
>>        }
>> -     pf->vfs[cf->vf_id].padev = padev;
>> +     *pd_ptr = padev;
>>
>>   out_unlock:
>>        mutex_unlock(&pf->config_lock);
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
>> index 14522d6d5f86..065031dd5af6 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.h
>> +++ b/drivers/net/ethernet/amd/pds_core/core.h
>> @@ -303,8 +303,11 @@ void pdsc_health_thread(struct work_struct *work);
>>   int pdsc_register_notify(struct notifier_block *nb);
>>   void pdsc_unregister_notify(struct notifier_block *nb);
>>   void pdsc_notify(unsigned long event, void *data);
>> -int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf);
>> -int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf);
>> +int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
>> +                     enum pds_core_vif_types vt,
>> +                     struct pds_auxiliary_dev **pd_ptr);
>> +int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
>> +                     struct pds_auxiliary_dev **pd_ptr);
>>
>>   void pdsc_process_adminq(struct pdsc_qcq *qcq);
>>   void pdsc_work_thread(struct work_struct *work);
>> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
>> index 44971e71991f..c2f380f18f21 100644
>> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
>> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
>> @@ -56,8 +56,10 @@ int pdsc_dl_enable_set(struct devlink *dl, u32 id,
>>        for (vf_id = 0; vf_id < pdsc->num_vfs; vf_id++) {
>>                struct pdsc *vf = pdsc->vfs[vf_id].vf;
>>
>> -             err = ctx->val.vbool ? pdsc_auxbus_dev_add(vf, pdsc) :
>> -                                    pdsc_auxbus_dev_del(vf, pdsc);
>> +             err = ctx->val.vbool ? pdsc_auxbus_dev_add(vf, pdsc, vt_entry->vif_id,
>> +                                                        &pdsc->vfs[vf_id].padev) :
>> +                                    pdsc_auxbus_dev_del(vf, pdsc,
>> +                                                        &pdsc->vfs[vf_id].padev);
>>        }
>>
>>        return err;
>> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
>> index 660268ff9562..a3a68889137b 100644
>> --- a/drivers/net/ethernet/amd/pds_core/main.c
>> +++ b/drivers/net/ethernet/amd/pds_core/main.c
>> @@ -190,7 +190,8 @@ static int pdsc_init_vf(struct pdsc *vf)
>>        devl_unlock(dl);
>>
>>        pf->vfs[vf->vf_id].vf = vf;
>> -     err = pdsc_auxbus_dev_add(vf, pf);
>> +     err = pdsc_auxbus_dev_add(vf, pf, PDS_DEV_TYPE_VDPA,
>> +                               &pf->vfs[vf->vf_id].padev);
>>        if (err) {
>>                devl_lock(dl);
>>                devl_unregister(dl);
>> @@ -417,7 +418,7 @@ static void pdsc_remove(struct pci_dev *pdev)
>>
>>                pf = pdsc_get_pf_struct(pdsc->pdev);
>>                if (!IS_ERR(pf)) {
>> -                     pdsc_auxbus_dev_del(pdsc, pf);
>> +                     pdsc_auxbus_dev_del(pdsc, pf, &pf->vfs[pdsc->vf_id].padev);
>>                        pf->vfs[pdsc->vf_id].vf = NULL;
>>                }
>>        } else {
>> @@ -482,7 +483,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
>>
>>                pf = pdsc_get_pf_struct(pdsc->pdev);
>>                if (!IS_ERR(pf))
>> -                     pdsc_auxbus_dev_del(pdsc, pf);
>> +                     pdsc_auxbus_dev_del(pdsc, pf,
>> +                                         &pf->vfs[pdsc->vf_id].padev);
>>        }
>>
>>        pdsc_unmap_bars(pdsc);
>> @@ -527,7 +529,8 @@ static void pdsc_reset_done(struct pci_dev *pdev)
>>
>>                pf = pdsc_get_pf_struct(pdsc->pdev);
>>                if (!IS_ERR(pf))
>> -                     pdsc_auxbus_dev_add(pdsc, pf);
>> +                     pdsc_auxbus_dev_add(pdsc, pf, PDS_DEV_TYPE_VDPA,
>> +                                         &pf->vfs[pdsc->vf_id].padev);
>>        }
>>   }
>>
> 


