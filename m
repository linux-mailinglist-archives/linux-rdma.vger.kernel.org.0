Return-Path: <linux-rdma+bounces-8896-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ED4A6C0BF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 17:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E0A3B30F4
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 16:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9222D4E2;
	Fri, 21 Mar 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gRgBMzvw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D91D95A9;
	Fri, 21 Mar 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576381; cv=fail; b=VgQ58y2+NNa8Cs/Y0e6cIHaK50Y6+9vY+Chs8z9BmMcgjqoredamVIy+nzicEfBnsvSTbPJ4WvUotoFSGpIPaIo/04jrepZQuoCu+Mz6yLxCPAjBZ6eQMhBcaFTJZJmaTTN/ni/ipRMxh0eIvIjB/fiv9GXUgi6pcKEd0hP1DTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576381; c=relaxed/simple;
	bh=TtXZ2akKuvOZSwn6lXH84QST0WDYeOLMx5en6pxh8/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tWyspeql4TtsmCwE+/1jkBdCBE/SS5Ipb011TxMuMNsUbQRZf+xvptlRfcNsoP8bF2+A5yRGL58BAFKjJoaOy8RBBrE03hBw3sLXdgclcW3essNgJ7r8yrdvlhsUnWGPCSk3A0vlocql0cdCSDnFXnslVDWQR5VMa5CmFwQWwjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gRgBMzvw; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNsO3TY0Iu38UZp+pDYu+BpC7z9dzoReBEnDSBDEbLW4avJ2Zq/JQD57JHKZMQnRCPusYsr+S6JCTL2PynFYWjrIcHvYfqStt8MHIK8yIiCIs96nsc2TOGtNvQsGJSlnZ5I6Yi/w34kCEhHX8TyMKI89DxS7PwSWqDqGDwVaqgXgKfvrqwQPAhfSwe6l0UQR5U8V/cZ9xdn/iqevBKVFwzeECeFQY3rsnk0nH2DWL1xpDrooN8F5xK83GJEDGJcuoejEBih+ekHu5uFO+aimGd2Zs1b4asokE4c/DUpSu05/g5QrI+oXJ0sGQA0nmveTawEuf6KFOZdLd02pcqYUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/KnoKkXp/W4qC74Mg614jHwTRD1QQnjpoFdAGEWjr4=;
 b=uqOfHeXj7Wd97JVyBRrakGWpFD/knj6OvxdnDuuUMCycnFKipznP4+XmcKy1y0SjIcHC1x8tK/3l7x6UrVZWpiakejazHDGA/uku4RYrhQqxL2CQGNaO2DgxpW7/FEBIzLx36IX6zohkuuzgG27kDAUeknOFjHuVzbDspxVum0YE8SuN1cRmWSJJsF0CeVu3ObCX+yfm79gcVMIovvQ2wm3OSgtvAxGrHiULeR3mEsNwY0PgPLs3T1ZonUx7e/w2861nYNhGoBj1dY57d4kSpbcNGfPup3vsNOqf6FCr9jDjfbnZGDLdSN8bFO13f8DEji2En3YHGs/f6jn96RI+Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/KnoKkXp/W4qC74Mg614jHwTRD1QQnjpoFdAGEWjr4=;
 b=gRgBMzvwYENNxnOdAh8r4kc7tYPu/96usSvtrmLQfVufU/mSaJieGItpAob43FRr9oh4dzwUJXJvSemkxwVdA7p57bMgItvAUhI/TiB3SoWNQxkSsYzoyikKTZiVEDU63uQHy02GzXf+XkTsIZ2gOqF6B21IHFqEX7WAWDT+7bw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 16:59:37 +0000
Received: from CY5PR12MB6573.namprd12.prod.outlook.com
 ([fe80::144e:53e7:5d29:2937]) by CY5PR12MB6573.namprd12.prod.outlook.com
 ([fe80::144e:53e7:5d29:2937%6]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 16:59:37 +0000
Message-ID: <8225f492-721c-42d1-ac74-cf1a20f19b8d@amd.com>
Date: Fri, 21 Mar 2025 09:59:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] pds_fwctl: add rpc and query support
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gregkh@linuxfoundation.org,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com,
 Jonathan.Cameron@huawei.com, kuba@kernel.org, lbloch@nvidia.com,
 leonro@nvidia.com, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, brett.creeley@amd.com
References: <20250319213237.63463-1-shannon.nelson@amd.com>
 <20250319213237.63463-6-shannon.nelson@amd.com>
 <ac2b001d-68eb-46c4-ac38-5207161ff104@stanley.mountain>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <ac2b001d-68eb-46c4-ac38-5207161ff104@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:208:178::36) To CY5PR12MB6573.namprd12.prod.outlook.com
 (2603:10b6:930:43::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6573:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 3994d82b-92a1-4294-bdcc-08dd6899c348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDRUV1JOMG43TkRjTkVsZ3V4SDkwS2FZK0F5WHY5clYwT0tZL2dwalpPdUs0?=
 =?utf-8?B?V1ZsRENXcVlDUnpJb3FCdkVwQndRNnBvMExMbXIyS3Q1NW9nRENad1VZUHZG?=
 =?utf-8?B?dk8rKzBmeXoyRTN4SHU1ajdRTzFPWXFqUnpmbFJQakNUZnpHMTlzdTFjTnRF?=
 =?utf-8?B?OGo3QnRKRXV1MEdlSHBla0pWemk4RFU4NDBtV04wOWV0aVpCRWVNMjNPZG43?=
 =?utf-8?B?K0N4aVBxbjJpdXZlMmQ0dXZhQzVTdWt3UTllVjc5YUZ1SnhCYks1TnBRZmU3?=
 =?utf-8?B?T0E1azAxWWJJUG1sYjZHT29XZDc4WFhxVHQrcGNOZ1BZMnF4dUd3RWNYOFh5?=
 =?utf-8?B?VnRvVFAyWFUrejdxNWNCLzhjTTlWUHRLOGFXVHVmeVV4blBOaU1GK1B0Tm9t?=
 =?utf-8?B?UCtNNXBrb0tVUWpHZW9yNE14TWRydWd2RDlTWHZtck9NenZ5dkpRMlpTVWdy?=
 =?utf-8?B?ald5ejdVTU1MZzVJR3lpZFJzUTdibU9PVHJxK1NSWE5qcDE3aC9kWktzQUtL?=
 =?utf-8?B?OXpXZm56RThxejQ5a0tPR3lrbTBjTGswWFFwM1N4THNZSHYxZXVmRGJsZVB1?=
 =?utf-8?B?UzI5bWVtbjhDQk05ZzQ4enphWHUxanBKY2NiSWMzT2pVSzlydjd1dHpBSnVu?=
 =?utf-8?B?N3JNY1F5clh1Z011Y3cxTGNPR0VFeWF3TVVrWVgxemVVN3h2WC8vd0RocE5I?=
 =?utf-8?B?WHpaNjVIT1pSZEZzakUxa3hsOFlEWlhXSHAzald6Y291YnR2RWlSQkxycGg0?=
 =?utf-8?B?bmRET0RVbE1YdUFsUGVteWpOeUNIY01yMFQvSGl6T1FheHJwZUR3Q2lUemQ0?=
 =?utf-8?B?dHRvWGVUNDEzR2hzeThtS3FSM1dvdEk0VzFxR0txTnRhWW8wL0g4QXB2UkZ5?=
 =?utf-8?B?czF3cC8zOWxiNmxVQmVEdldMSGthZk9NOTIwT1JyeGl5N2k3T2F5TmVPTE8r?=
 =?utf-8?B?VEU5NHRNK2JXSDYxb25zWUNVU2NONm1zZTF2Z1E2aTBmMEx5eExoZ0tjOWZ5?=
 =?utf-8?B?b3JDN1hwcDNUaUNBK0k2VFFoUFk0bkkwNmJuL3h1UFhBSFUrQ1Rab2ZNeW1m?=
 =?utf-8?B?Y2pXaFlNb3h5NFdyUi9VWkd6NlRWcEtCd2xXTFJEaDRXN2dlK28zTDdjb1Fx?=
 =?utf-8?B?R3lmWXo1RGgzWEhyV1ZBamltVjVzTjJYTms5Wi8wZGpCZzJUNzhDTy9zWHR0?=
 =?utf-8?B?TDhuMFZqNU1XNm5iZmdaWVNZanNkWU9iMVVKeWZDdG0ra3Yrd1ArQlhaSUNj?=
 =?utf-8?B?amFleE5EQVBsVXBXTi9ZYVJTVHVXK3o3blZpdVA1USt2RXdlYlhKOUtCK0Vw?=
 =?utf-8?B?MFBNQml4S1J3cjJtWGh1QzFsZ3BpTVdiSlBPQkdER3B3eEUrQTJITXBZbHps?=
 =?utf-8?B?VE0wdkZTQk5jejYzM2Rmajg4RGVJb0FqcUhuVmR5dEtVRUM2ZEovZnpQeURW?=
 =?utf-8?B?N2NwY2JhRzhZVFlxYkU5ZzJuU0hhZlBVK3JPUnk5QkRpQXpkMlN3dEpjZTNh?=
 =?utf-8?B?WEV6bFp4Ulh1ZDJzUHhVTkFXNnRuMENSQjJ2OVoxVldZY2k1ZTl5S2RzTG1X?=
 =?utf-8?B?eUw5Vm5lR04zNzdaN2Y3bXhYUDZrYVF1ZzJ2NlNkUExyVUUrak41Q2ZEcldq?=
 =?utf-8?B?cWNOSTRyRGdka0g3WmRWK3BDZDNKNW5KdDBhSkNqRTlRWjdpOEs4Tm5tTi9s?=
 =?utf-8?B?emJjY0dkMkcxUnk2bENQUW5WRXVTYzRlSVBHT1pobzlWcS9uZjNMRlFuMndi?=
 =?utf-8?B?WU0vaHlhM3hNQ05uT2p1R2ZwVlQrY0RKWDZNc1cvbkdVdFo2cUlDRFhjR0FP?=
 =?utf-8?B?b2c1SWJwSFVsTndHdlpERXdxeFBHd204MUZIdmx2Zm1JTjVDaFJEc01lUE9N?=
 =?utf-8?Q?IgmaCO/dlg2HD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6573.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVhmbGhYV01Jc1d4OWo1VElNd3EzMmRMZ3gxQ1FzSCs3WGtPRXZBZzg5bFE3?=
 =?utf-8?B?V21pK2pYYkRMYS9rRkpNTDNra0t6cEFwTkpLRW9IVW9Ldll6UlZBOXRXeDF4?=
 =?utf-8?B?QTNkYi90RXU5QWtBSk1KVUJsRGRkcG12ZHZ2MUlJa1NVVWdNNkhEUk5lcllX?=
 =?utf-8?B?ZXo5cVJnY3JFeEZCR3d1NVZmODlDNnJCUWRqQkNzQWUyRHkwNVRLQlNVZ0k2?=
 =?utf-8?B?Y2dUQTcxMTREVndQUTRvZm9IblJaQ2JsVzA1MzRCN2RIT1RrcmNxMndvSGhy?=
 =?utf-8?B?VWl2U2d3UVZGeUZzMjZLNy9EOXorMjBHaE9vcHIvRUx0WFpsU0dNUFRRMXpr?=
 =?utf-8?B?dVFYNFQ0c2xLRVlQMFZzMEdFWFhielh3eFpXbm5SS05TLzNnUHBSbkp0SmFK?=
 =?utf-8?B?b3lWaEFjY1FsNklySE01Mm94N1cvVWJFOTJmZFZycWprV3dReUNTR3Y0SDZZ?=
 =?utf-8?B?eUVFQUkzM0Rsc3I2cE1pdFhpd1lTSjNvbzFJd21KTXV3M3g1ZHpib3UrSmxk?=
 =?utf-8?B?Z2kyWmIrZTgwUllqUW5YeGF1Sk9UMDExaEIrVndESDVFWWxPVVRnZ3NiRGNH?=
 =?utf-8?B?OUNxUXNpZ1BCanI5ZFg1bC8xdURzS1R6aWRoQUV2YTdXT3JtNUQvcm5yQ1Fq?=
 =?utf-8?B?aDkvcWpZSHpGTTJLVFZJdWVzVTROVmI3cVZYVXZaVmN3S0RUalN6TUdYcytI?=
 =?utf-8?B?VGh6aTF5STVlVEdjVHovekl0R1NIa29PemRTTW9MeHZjdGZucUw2NC8xOXFu?=
 =?utf-8?B?eXBPWFNtK1NIbnhaMXovbmpON1JRMWE3VDQySVJ1UklpMEdFbW9nUkF1K0t5?=
 =?utf-8?B?MVRoVjNpbnRFOG9TNmN3aDJ2dXF4WUJuazVMbkg3R0ZNZ3dBcXlsQlZhWXNT?=
 =?utf-8?B?dy81WjJrR1hBb3c5b2VuUmE0TFpoZjQ1d1A2VTRoVkt4ZUFvZGhWZ3NBbTdi?=
 =?utf-8?B?Yml6MnkzelREajhzVUZ6ZDJHc05LQ3lrcG53UXZ5OVgwUFZycmY5ZjR3TDRj?=
 =?utf-8?B?Z1ViMy8wSlFEcWFHSVRuVFVEY3MvUW5CbDVrcEpCTmxpOVl6ZWFjM3hYNFlY?=
 =?utf-8?B?QStVT2N5MlgvQmZtS0xXMW1iWCsrT1V0UXIxQmtrMGNPekdwZWd4NlVCMHZt?=
 =?utf-8?B?T1lBWUFyTEFoZms1MVU0SmN2VERyMG5UakpGWE5XUXE3OXNhMlBaMVFqWUo1?=
 =?utf-8?B?Q2JhWVBQUmthdFNBK1lUc1d4ZTlDTVErSU51dzA4bUxVcncwQnZIemNMTUtI?=
 =?utf-8?B?OU5EWmFNSjhjQXJkb3FHZmYzOTFGZ2haWC9xRHdhT0VQTWJiYk5vM3FWL1F0?=
 =?utf-8?B?OVFIUk5KWnRjdFIrUWVIb0x4NDZqemlBY3hrcDZuZFBnWWI0SC9pTVd3eEtE?=
 =?utf-8?B?VnNCZ0JIa295NHl0ZzQraWFLOTFSZDRMU2p3WXRTV1J0N2xIODV1V2RrcEt0?=
 =?utf-8?B?RVBVenVpQ0kzL2RpS1NlbVlhY0RvUmRZU0NnNDc2YmJqYjhldGdDNVJUQzFQ?=
 =?utf-8?B?VFU0QURtQWJGV3pJYUFaTWlkWUVLWmdMOG5NK1FQemNHUnlaRFJzOXhHczJp?=
 =?utf-8?B?dVVuTWZjVCs3N05CTlZlaFUxeHRndmV0czZZTFFML2hYWXFiQk9kbVF2RndH?=
 =?utf-8?B?YWk2YzEzZmtSWllpZGdhVWd4M0w0eklCaVcxU3hpbkRXVkx1MEpDYUV4Z3da?=
 =?utf-8?B?NFZwK0tSVWg2cWk2cXE0WVkzdml5ZlFiRHpDRDJkYmNPTlpiMlQ1WWdvMTFa?=
 =?utf-8?B?ZDVya1JqbjFvOElFNVp5WmtlWlE5bm80aDhSWE1HV3ZFZHlGODN1MG5VTFp3?=
 =?utf-8?B?THZLK3Q5ZVZ6aFZCa3lRSUdRd0s3MUtHVUJoOWoybm1HbEwwRGIxTFV5TFZ4?=
 =?utf-8?B?ZkMwSlBFbUthL2VBbzR5dldEK2pydUNNalRZL0ExNjdJRWxuT3JmYTV3NnZF?=
 =?utf-8?B?bVBncEJEWWwxS2IyYlAybGpGd21jSE9BM1hvcUdST0tXUzVWK1IzRnFTQnp5?=
 =?utf-8?B?V1JEZ29mUU9YNVpQajlYTC9xT09FZ3NLOWVSdzFUbU5SaWVyVlFjZCt3VDVB?=
 =?utf-8?B?QzI4dElkQmRrVDhNeW5mSGdMWm1NOHAzZlZOUW9JT1V0d3NGVEoxUHRpRHlh?=
 =?utf-8?Q?Akel0y6vyZgnlwoo+7vtc8BFw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3994d82b-92a1-4294-bdcc-08dd6899c348
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6573.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 16:59:37.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZSq5K4YvwG5v1DUfaX5uynWwQgCd5uSOkHrOhCZRz+zr2+EAx3H/RRyhhHs6ZJJ3zRijhYSuso/3vB4aW1GbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146

On 3/21/2025 7:33 AM, Dan Carpenter wrote:
> On Wed, Mar 19, 2025 at 02:32:36PM -0700, Shannon Nelson wrote:
>> +static struct pds_fwctl_query_data *pdsfc_get_endpoints(struct pdsfc_dev *pdsfc,
>> +                                                     dma_addr_t *pa)
>> +{
>> +     struct device *dev = &pdsfc->fwctl.dev;
>> +     union pds_core_adminq_comp comp = {0};
>> +     struct pds_fwctl_query_data *data;
>> +     union pds_core_adminq_cmd cmd;
>> +     dma_addr_t data_pa;
>> +     int err;
>> +
>> +     data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, GFP_KERNEL);
>> +     err = dma_mapping_error(dev, data_pa);
>> +     if (err) {
>> +             dev_err(dev, "Failed to map endpoint list\n");
>> +             return ERR_PTR(err);
>> +     }
> 
> This doesn't work.  The dma_alloc_coherent() function doesn't necessarily
> initialize data_pa.  I don't know very much about DMA but can't we just
> check:
> 
>          data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, GFP_KERNEL);
>          if (!data)
>                  return ERR_PTR(-ENOMEM);
> 
> regards,
> dan carpenter
> 

Yes, you are right.  This works for the dma_map_single() calls on 
already allocated blocks, but not here for the alloc-and-map calls.  I 
think something like this would be better:


Author: Shannon Nelson <shannon.nelson@amd.com>
Date:   Fri Mar 21 09:37:52 2025 -0700

     pds_fwctl: fix use of dma_mapping_error()

     The dma_alloc_coherent() call only returns NULL if there is an
     error, so checking the dma_handle with dma_mapping_error() is
     not useful.  Fix this by checking the returned address for NULL.

     Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
index 6fedde2a962e..e50e1bbdff9a 100644
--- a/drivers/fwctl/pds/main.c
+++ b/drivers/fwctl/pds/main.c
@@ -76,8 +76,7 @@ static int pdsfc_identify(struct pdsfc_dev *pdsfc)
         int err;

         ident = dma_alloc_coherent(dev->parent, sizeof(*ident), 
&ident_pa, GFP_KERNEL);
-       err = dma_mapping_error(dev->parent, ident_pa);
-       if (err) {
+       if (!ident) {
                 dev_err(dev, "Failed to map ident buffer\n");
                 return err;
         }
@@ -151,8 +150,7 @@ static struct pds_fwctl_query_data 
*pdsfc_get_endpoints(struct pdsfc_dev *pdsfc,
         int err;

         data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, 
GFP_KERNEL);
-       err = dma_mapping_error(dev, data_pa);
-       if (err) {
+       if (!data) {
                 dev_err(dev, "Failed to map endpoint list\n");
                 return ERR_PTR(err);
         }
@@ -221,8 +219,7 @@ static struct pds_fwctl_query_data 
*pdsfc_get_operations(struct pdsfc_dev *pdsfc

         /* Query the operations list for the given endpoint */
         data = dma_alloc_coherent(dev->parent, PAGE_SIZE, &data_pa, 
GFP_KERNEL);
-       err = dma_mapping_error(dev->parent, data_pa);
-       if (err) {
+       if (!data) {
                 dev_err(dev, "Failed to map operations list\n");
                 return ERR_PTR(err);
         }


