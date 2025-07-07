Return-Path: <linux-rdma+bounces-11930-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B9AFB694
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 16:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AA317B3FF
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9032E1737;
	Mon,  7 Jul 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lOyMZOsm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83B220F30;
	Mon,  7 Jul 2025 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900199; cv=fail; b=Zz62G4vgzQ62X4cfT1xTWhMiF7qRRwzLBrwIOebjLXbxkokHhXL9S613xnhj4aijeohtvLbuk35Z1q7sZVeGEmEpcq98B9/j6FKoVaqd8eVA5OmS7FZFnabNCn5MPdDB+vcnPQanOhwSXXqSIFHCfjmDTOnAWSN3VHlW77kbtW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900199; c=relaxed/simple;
	bh=PzqBJOPNMUSMysSxSzF76KYFS6Y7d70Gz+GA+bWyglA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rEsCUCcZ76Zrzp8NeiLcBbhJwI6FnTrhWdHXPBGlW2INFQiy8Sjakw4Ud1LAY4j2R1swlYLQsVhP52oRm2Sm+invIU5g8xrHxEWCv+PAhMrehLbIMbf7Pd13wjIi4v+rqnafd8G7/SEaqusV6z4mwEk3BE+bBoPQIb+qr6vi8oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lOyMZOsm; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0SUv1skgmETSoB+M5QYsdPg1mo8qm3wUO6RKNIQDT0PKWqs2kO+hHAp8xfLsTgUIoH1NRZIffYpTsK2pQmTqEnS2YAKo026gjtz3aVLbtnyVgG5sceN0mtlLAKx3xLti9fRV+aZHO31/OnF6V7owpW+b5qoU4GpNZE1FmR+CvN9GQ5Jqgsiu0g5QuFzToobEpqyFtp4ZmA+eqwQfmTX4rqCM6/lR1ZfTsm6FkY4FAYAyGmgyohWsFnna3FkZp6WEpfa1SKVbgs5nsRx6PkBZX19zQ6sBvWoJ5rtdwaeJLYEKcUEE6lIRQEW9M2lHv1syOy7FC6M2CT318gIeKgchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7eBL3T7F5FDkAC6HtDKopk4py84wfEU51BK4T70KA8=;
 b=FUhbV/UdtM9kEQrWh+XrMu8m33l5oGl6B3JTqGEgVz47mAa42f5A1CFC+drv22N48QhF56OApv7znIVQuHf/O212SJm68KlQmG7VJ/0DtHP074Mt2KZ1Eb2Duy1qRmD3mZnyWei1QERwchyEQS4+bhTvFh5OwTKY03qNARWcfeW7OTrSeOIz0b8C+MVznFGPEWn9A83BYXgCVbJg+t/v/Fcwi0a0FMvWtGrWZ9k90HkkuNDfpSrA0ndc6acWtUvqzdLmJN6Sl6H0C+9wacC9HVeOAxr7/BEB/EXnJkVjLXLZRPkvu1e2cti3RJH8O1LIIQT2Y6jP19+xpcO6JmLavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7eBL3T7F5FDkAC6HtDKopk4py84wfEU51BK4T70KA8=;
 b=lOyMZOsmWYjxQufHQrvIE9NXkFwTujmVp1GlXqVxqgqTd1EXwwiopsDthzL7j6OAL4KQRnvHxKElw9wvAkva2ncAUeXbf0SejbZPHxNgdx1zsVRiE8XUmz7xTPuzBDB0vzAqgCKK2GD2hPzfbqhIbkf86VYPmWO3EZjTMKUPnF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 14:56:30 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 14:56:29 +0000
Message-ID: <1a7190d4-f3ef-744c-4e46-8cb255dee6cf@amd.com>
Date: Mon, 7 Jul 2025 20:26:20 +0530
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
 <20250707072137.GU6278@unreal>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250707072137.GU6278@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0116.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::8) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 47958195-08e8-47cf-963b-08ddbd667477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnFJclJuQndXMnlmNHVFVlk1bEJGeXJWTXJiV1MrZWplU0w2T1doZnoyLy80?=
 =?utf-8?B?MDJ5VFN2TE00aS8yano0RUkvSzRRQTNKVnhoL2dPekdJTk5Zczk2OXBYNXIw?=
 =?utf-8?B?dDdENnEyMWFkVWlwczhEUUtwVWxQUVBqd3RlMmFyT2xXcVdHN3dmOWlaMkhP?=
 =?utf-8?B?U2V5UlphNjc3VTVoMkx6anBjSFpIV1Q1YitRWjBTS01uUGN0aGlLTzVhSVVr?=
 =?utf-8?B?SFNGbk9Md1c3N1Q2dmpoZllVMk9UalhLSHdpT21pY0tHb0ZFMTZEK0xBOHc0?=
 =?utf-8?B?M0gzUks2U1I1bDRScXJraFBCL3psclZHenI3aG1NZkFLalo3a2dqSUNEc0s1?=
 =?utf-8?B?MCtKNlZ4cHA5QXR3Qk1QaTRRbzhWVmpITGo1THJMVkFEVVBNdDhjR1pPWEZv?=
 =?utf-8?B?NTU5dTBVMklRRTQ0SFIybWZxZFFTM1Yxb0hpKzBQWXVXSk1CK1VqaFNjR3B0?=
 =?utf-8?B?TFJkS0ZnVWJ0YlcxbDdQaXRicmUvV3RCSjBNaUhVWWFESDBINkk3QWMxZVpN?=
 =?utf-8?B?RWFmR1VENnFhZ2hlVTQrOVN4SWVFc0U5Y0x1MHpSSVhsQnBTci9Jd1VyV09l?=
 =?utf-8?B?T3NiN0phVHAvdk0zS1ZsRVBraEljS0kva0ZLcDRpd1dPYkZvQWpPMVdFcUkw?=
 =?utf-8?B?UGljcFNNSUNjL3NIbjd4T3BsVUJXZnF1VkVrSGd0VHI4ZmtiU3FzdnpXR01C?=
 =?utf-8?B?M2Q5Y2wrbUdyYnNxMkxJRHowMm13RWkvblVsWnRZYTZMSElTck1sV01WTkFI?=
 =?utf-8?B?ZlV6ekRoNWpoL2NFeVc0NU00Z2JoL2NhWFQ4eDFkV2tBRlZtMEdaOFF2Vko4?=
 =?utf-8?B?R1lkMDhBSnBtcEJ1VThhU2hSeWZNOGdhNjMybXdyZUd4Y1FVeHFzNXdQUmF4?=
 =?utf-8?B?V214c3pOSEdLOHY1d3IyMFJ0WTNhVjB4NW5IUWkvaFBaVC9wa2JwaW44dUta?=
 =?utf-8?B?SWdBMWdqNDhieEJxUWdKWTRQdTB3TW5Ea0J1R0dYWVhQTm8zL21KYWRZVHhl?=
 =?utf-8?B?ZCsvSUZQSHZXNXI4ZVplejhDd09IcW5ENVlzaStNYkhuSnN5Mmg1dmdFVDhW?=
 =?utf-8?B?Q0MvTjVUTXRrcU1QWVM1VUpPMWRBZGNHdlIyYWZraWltUjBGM0kyRlBhc0M1?=
 =?utf-8?B?elBuSjJxam5NNWVOenRlRWs0QVVLMVlpd1NEWnRoVDN0ZUgxU0lnaWk4TWhp?=
 =?utf-8?B?eEZHSHRLS2JhOUVqTk04aXdnZlNvU09Dd3ZDaEExalAzaVZIOGpOY3JxNzNE?=
 =?utf-8?B?VzlqdHg3Q01vYlJlU2UzaVI4YmJJRGprVEhZY2xsd1NjOTZSSXBIOHZ1MmZl?=
 =?utf-8?B?MEhoZGlnNXRqUjZWQ0RFRWc4S3JDZ0YwZ1BZOSsrenJDajdCTmVEdUk2dTlZ?=
 =?utf-8?B?Ui9KMnE5a2t0c2QxSllzSnhOcnRaTUFxUlc3NnBEWjBVaVM1WEZrNGc1VmZY?=
 =?utf-8?B?dXcyWFZtRnQrU2ZtdHBlajBIUDRwV05raEVnL3JVdTdJckE0dnV2a0tRa2FO?=
 =?utf-8?B?REdKbjVnaS9YVGJCbjJJSXZKMldQWGRtbDlSM1Erc1o1eElyQXJ6TEx1eVho?=
 =?utf-8?B?TG5PeGgxRGxCL29kY2plR3hhWUs3Mko3bGpxYnRJRFFIeHlxS3dyMTluS0pz?=
 =?utf-8?B?cWtQSTYzMkUvTFY2NXV5QW9odHlyeThTc3FnOGVGU2RDd2tKdEFNRWxjcFhW?=
 =?utf-8?B?UjZuVDllOTVKbVNtN1FNcmZmeEIxU3hqSkZwNkwvTDFLV3EwMHdPNGFMc3ZN?=
 =?utf-8?B?VFVjaE1sTEV4L0hMQjQ3amhCZ0pUSXMyN2JMOURDbU1GVklqTnZQVEcrUGxL?=
 =?utf-8?B?MEdEcTgyeGQ4YXhzdjdudjZjZUVnaXZXOTlScm9tOGhpUkN2a1hhTy9OYmkx?=
 =?utf-8?B?aUFjcXlXTUVlQ1FOUXZQd1lnY1NUYU1JbDY5aGRGNE5xanFuMFZiUlZpWCtN?=
 =?utf-8?Q?cpnhHRofRzY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmhHU3BNNGJZV3N6OXlscnhzVG1sZzhvVHpTNkFVdlNLZml5RTdSK1oyMi9x?=
 =?utf-8?B?c3p6Uk9iNjBGRkgrZEg0Nm43MnBjN1I1cTVvUStVd3RWM3BzTXlvL296bmd4?=
 =?utf-8?B?RnkrV0NjdENGWXV0OEFOajZrWmdRdWhiTHV4bkE0U0w2Wmg5TmZHQnh4MXpG?=
 =?utf-8?B?N1VFb2NQa0VOMG9hWWIzcGpPaVdiaERyWDVYTjF4Z2lpQzJIb0EzREg4TFIv?=
 =?utf-8?B?RGlaK1JaMnMxaHU4T2podktWVVM3Q29rdTRkbTZVa0tQdTFtSVRpOE00cUJ4?=
 =?utf-8?B?V3liWkJWYnQyMTBVdFJwcU56OVcyRjd6VlZYNjhNV2pIMzc4SnlQSmFCTU1v?=
 =?utf-8?B?L2wyM2tESTMzVUtxMy93TS9RUHBBTDAzSU5QblJwM2h5bjVUM052K0hwY01B?=
 =?utf-8?B?SlZaZ2RUN2J5dmhnVXMrOHlEdCttSUtaejA4TnJ3WG1EWnlZa1hOTU93Zk1i?=
 =?utf-8?B?TDc0cUpWNEhLYWhVaGJKSlBjZE4wcmlVZnk0cWJ2YjF5VTlabmVQczhGRnlu?=
 =?utf-8?B?YThvR1JpQUViWFo0bmJzVjBRbmQrTmZZL21acWZHM2loS2c5RWxYbmlOS0tl?=
 =?utf-8?B?cTk5VVZSR2hiQkszNnRsdVNjMDRkWUl6aWdQMi82dDlQN3RUZWdNYUlHUHBn?=
 =?utf-8?B?dVRMa1dJVGxDd0p3TUI5TUZqY1FFUHJwZVpESkIzUHcyYUJGWXlFK0ZpUzNE?=
 =?utf-8?B?SW0wK0Q3VEYrS3I1M0gxZzUxNGpUU0tKMjBjdjkzazROVU93RVBTdFRCcnE5?=
 =?utf-8?B?dFBTQ1U0Z3lmekdKWTVRbW5NZlVTYXVKajBucU5uOWs5c014eDVtWXVrTXds?=
 =?utf-8?B?MHZ1Z1Ivc1YrRDA4RmlXSHlRV28ycVVKMUVGOEpMSlpuc2xpRGVhN2tJak96?=
 =?utf-8?B?R1Z5R1hUODFSTWZQUVRTenEzVW9nbmFvdTR2UmVGNnhnOWhiVVlLS1IwNXlL?=
 =?utf-8?B?N0s0bFAwc2ZKYk5QdldvczRoL0xEcDJkc2RYTTJlQU02UzlJTmYxZjNDVlUr?=
 =?utf-8?B?UlF1MFVjY0FHc0taRHFPbFVJVjlGakZ5Z3pzb3Q5TEJxK1VETXZsaFhyYjVM?=
 =?utf-8?B?TmFCUUN5SUh4NVo0akZTOG9ScEdhRkZRbnQ4dWVrbFdwQzhBL05HeXRTUUpX?=
 =?utf-8?B?Q3FnZGlRRUlGRm1JYXVnUnpDdnJWLzBFMkF6UXVjVkc4cm1MRm1VVnM4eFlS?=
 =?utf-8?B?V1dwblNFY1ZYcU5QZlFqcDEzdDBOVmM0ZHdMU0htVGZVaE1sRy9VNHRFVWlh?=
 =?utf-8?B?OXJENGlud2F0Vk5pajhNbFN1blp5T1FiKy85ZFZ4M24waVVIbEpXYjJRdE54?=
 =?utf-8?B?SmQyZC9LRE1sZmovMVhRanZJWUUvRUh6dldtWHNPRXNWd1Jyc3JVUEZUemRF?=
 =?utf-8?B?WDJmMlNiNzhmVWpaVko3d3AyRmNYMGxZaG0wT2Y0VU0rMVoxMjZTTk1xVVhI?=
 =?utf-8?B?clliUE1jYnpGbTY1aUFlNk1DZHBNdk52Ry9qMGJmUU80K2FoN2Zpb1ZyZXZF?=
 =?utf-8?B?RWZ6cGZvR0E3N2NYOWwyZmVRbHBzOXA5VDRYZ2x2eG14M2drRERTM2UycXdL?=
 =?utf-8?B?bGp3U2l3TjFiaDFxWmp1ZFFycmFUMkhLSGw0SG1rNzArUGRpWlMxbXZSYW9R?=
 =?utf-8?B?S3pmUGVTL0d3dFNjTkEyS2dMT3RSdmFtbDFGMXoxUmIxYldBNzRhTWtaVFVO?=
 =?utf-8?B?dy9mbkw4b0lYcU1NMi9hTXgxdW5ueGNBa1Z0UVpvYXMyN0UxTFlscmtBdEVH?=
 =?utf-8?B?K29MKzFSRFc2Q21JOHZpQVhtenM4KzdRWVM3c3hVbDM3Y1NPVCtydlZ6eG5i?=
 =?utf-8?B?R05iRDJQTTY3aVI2WGpDR21iK3kyV2hxRHFCbHRlN21zc0ZRSHZTTHl1eCtw?=
 =?utf-8?B?QVdaMEIwc0hSa0lxc1A5L2VNVFNreG5VdWIxRlVTKzFucFpuR2ZpS29pWkRh?=
 =?utf-8?B?STN6SmVlek4wNldxUzN6Zk9DMzlSSTlXNkQ4YWdJU1lIVkRPWW5BWENDQW4r?=
 =?utf-8?B?bG5mWXp2NTlSOHJqbCtpa1FVQUtmUGZVaWxrb3dMR2theUtvMzRYeW5zdUFQ?=
 =?utf-8?B?akV3b2NGelhYd1B5UnhMSldvWXgxSTMzelpGa2JqeFhIcThMWXZPMzRNWWhy?=
 =?utf-8?Q?bhWtKVWm+dY/S6pLO48vS4l7m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47958195-08e8-47cf-963b-08ddbd667477
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 14:56:29.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spp7nyi29CjDCuXblFFroZOhJzm0jUlUCmmudReXpSqpMINX0ulmzqAs7k60nCvSJul6+fCXL+RW/Pln/XNfRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107


On 7/7/25 12:51, Leon Romanovsky wrote:
> On Mon, Jul 07, 2025 at 10:57:13AM +0530, Abhijit Gangurde wrote:
>> On 7/4/25 22:38, Leon Romanovsky wrote:
>>> On Thu, Jul 03, 2025 at 12:49:30PM +0530, Abhijit Gangurde wrote:
>>>> On 7/2/25 23:30, Leon Romanovsky wrote:
>>>>> On Wed, Jul 02, 2025 at 10:18:03AM -0300, Jason Gunthorpe wrote:
>>>>>> On Tue, Jul 01, 2025 at 01:38:44PM +0300, Leon Romanovsky wrote:
>>>>>>>> +static void ionic_flush_qs(struct ionic_ibdev *dev)
>>>>>>>> +{
>>>>>>>> +	struct ionic_qp *qp, *qp_tmp;
>>>>>>>> +	struct ionic_cq *cq, *cq_tmp;
>>>>>>>> +	LIST_HEAD(flush_list);
>>>>>>>> +	unsigned long index;
>>>>>>>> +
>>>>>>>> +	/* Flush qp send and recv */
>>>>>>>> +	rcu_read_lock();
>>>>>>>> +	xa_for_each(&dev->qp_tbl, index, qp) {
>>>>>>>> +		kref_get(&qp->qp_kref);
>>>>>>>> +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
>>>>>>>> +	}
>>>>>>>> +	rcu_read_unlock();
>>>>>>> Same question as for CQ. What does RCU lock protect here?
>>>>>> It should protect the kref_get against free of qp. The qp memory must
>>>>>> be RCU freed.
>>>>> I'm not sure that this was intension here. Let's wait for an answer from the author.
>>>> As Jason mentioned, It was intended to protect the kref_get against free of
>>>> cq and qp
>>>> in the destroy path.
>>> How is it possible? IB/core is supposed to protect from accessing verbs
>>> resources post their release/destroy.
>>>
>>> After you answered what RCU is protecting, I don't see why you would
>>> have custom kref over QP/CQ/e.t.c objects.
>>>
>>> Thanks
>> The RCU protected kref here is making sure that all the hw events are
>> processed before destroy callback returns. Similarly, when driver is
>> going for ib_unregister_device, it is draining the pending WRs and events.
> I asked why do you have kref in first place? When ib_unregister_device
> is called all "pending MR" already supposed to be destroyed.
>
> Thansk

The custom kref on QP/CQ object is holding the completion for the 
destroy callback.
If any pending async hw events are being processed, destroy would wait 
on this completion
before it returns.

Thanks


