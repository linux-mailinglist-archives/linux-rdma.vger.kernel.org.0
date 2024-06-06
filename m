Return-Path: <linux-rdma+bounces-2938-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B500F8FE55E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 13:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2441FB2224A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 11:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FF51FAA;
	Thu,  6 Jun 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QvPYNRMT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4EF19580A
	for <linux-rdma@vger.kernel.org>; Thu,  6 Jun 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673446; cv=fail; b=uxP9cShZ65hgttytP9Q3edJ06KnmeWqhqb5aLz/wsW2iBKpeV5kvqrqUZPHTd6CvglOBNX41X4FxSy0hOhlck0dbiXB1MaFqfmbLv7nBZQUi2whywVIY/XLjAKxriSakmDN4bPSgBBQp8pX2drqwSmMoHrAjqY5BEynXLpxCx+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673446; c=relaxed/simple;
	bh=iGW+BrjQ0OI3XG7+nvAxU46zvQWJB8ruGv24KUuxBwM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h1WvPP0vtaxhEuLui7H1JlAGJIvq4wfXzYZL0HT2+0X91+RL2N8lZO1P/oHfvd1Mu4XVMXtFbJkpclh2CVoEZpt2GX30YnOy54f8T/nzGa4UIPV4y5SojsoGPQBn+LohIch5TYHwwvk0ADL+Fp+Y3nKzdFhI6kE88DDIqGVDPgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QvPYNRMT; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK7H0CFkLB3bmBaJsNltU1woAsiuTW1Kj7AiJoKFvifJK1AyRdF/kjFC8s3HRhVIOUS9Qneuf7mm6pEVXhPnAzzEcl0gfWvoknUDCsH/dYT8JAXi5S0LwBPfXjHuC9SSqjF1+GAiiY9uUaveCAgYc2rljXHK/WfxLlhYSgpp2tdSyQdq4y3nVHU01AJOZ8CF2GbG1ELS23AsuijIRZg6Rn2/JyGuHqMJB70IzO9R8xM7g9brpXIQZQQwytEB/opY5M+XPrYQIp+iEVeUlx+RBnAkLhAPuhFAkyb3NW3rSBeXacS61Hp65ccw3VcZGJeaGgC/ihMDSSTCu2BTRmMQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFSHk8n3pCPp8zhFwjxaNKgSKtNhi8Klb/kj01zBBoA=;
 b=HtLyhjpRORh3QmJW6zOo7zRJoxd42qLe7ORbq7Ope1bdh6cDg/3ZvlzharwrmpnkR5008mt5S6YXwBTNP0sCkcKYqizOKwAsdaE63OhXduKFs6c/pbdXb4sz9elCYd8VtvSl1hIwVsbSmQoJXIc9lBS24vef4VqAYhIT/6FYMHguIWbMMNcYLjBIlCrt+cRPWnhDLVRyLcs85wdCrZSwY6Dzb2lr7dPCWzLVSFhAcEA43lRCISDMThir/WBybl7UruuPYZmLStkpzPHrm2NuB83BSc/uORLcNe5drmXW6K4G/yjRaEh+zQOOBxnIOwWMbSwwk2YyrgFEwsksv2QWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFSHk8n3pCPp8zhFwjxaNKgSKtNhi8Klb/kj01zBBoA=;
 b=QvPYNRMTuDq0pPizbx3hDfPYVRnXAmxh30OAZVpku4vA7K9O7qu8Jpb60QOvEvIx+K2SUvTrN0Nf91rGREQFiZwnH/6OnmDsM34EHb/whmehB2ascjqOwtvEI+C0bD67ZciWlVto3urxQq7xsTBVP4GQOR8avTZS79ILMMu+oyNAnUjus0ysxAK9jd+3JAKBXeZ3p0INxWzT+rDO1ZojrYhJUR/VRf3PJzVhx8RGwJj4Mlvhwou7qp6flPh9VnnzaIrQY519x/kcsE8mLT32irLyT+6SGsv/TgZrR9eX/XZ7PiM31km6cUYgK7nv3iGkrUw1pGVoVaYROrPyN7a7WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 11:30:41 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 11:30:41 +0000
Message-ID: <01ae8b79-fc45-4361-ad28-cea7bc63a330@nvidia.com>
Date: Thu, 6 Jun 2024 14:30:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] rdma/verbs: fix a possible uaf when draining a srq
 attached qp
To: Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Israel Rukshin <israelr@nvidia.com>,
 Oren Duer <ooren@nvidia.com>
References: <20240526083125.1454440-1-sagi@grimberg.me>
 <20240602081934.GJ3884@unreal>
 <ac1ccd5e-598e-4e67-8e32-2f8d499d6ff7@grimberg.me>
 <d70273b6-56ad-494e-b1d2-884b537dcfa7@nvidia.com>
 <f1f52597-c159-4c87-993d-51221c974dfe@grimberg.me>
 <deb873a4-5c59-4292-a86e-3f0b8c460096@grimberg.me>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <deb873a4-5c59-4292-a86e-3f0b8c460096@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 533e0a7a-66b3-4261-05e4-08dc861c18ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ai8walE1aUVZM1l0SHN0c1YwUnFKcDVYdFFjTHlJV0J5RFI5SkFNVlZES0Fx?=
 =?utf-8?B?bW52TWtLc2dIbUk2R01JcG5kYURTY0pOdnBXR3o1UlpYa0o1STBRNTlGK3lM?=
 =?utf-8?B?eXZGZ0FxbkxsbjZrWlVZYlBzekR4M0xFZFJzV05QTkZER0hPT295d3pSYVNX?=
 =?utf-8?B?eW1hVGFkejcyYTlJODk3K1JEOW0rV0dlUmtqZ2ZlWTArWGYrYVJvQlFDMXNM?=
 =?utf-8?B?WkZnOFhpcWsxMjU5dG5LcmRsVDluODNJU2M1a2djOTB3MFZSbXVuMXBHSDd1?=
 =?utf-8?B?SEZvNmJVZ2c4TXlDeXJ1K0ZKR3ZLV01acDNqczBsaDNyaGpZRnU3TXNHV05E?=
 =?utf-8?B?OE9WREtqYzFhUXRhbUF3VGVsZVNWbnB6OTVaRGFmZVBONjBiMjQ1dlpBTWRl?=
 =?utf-8?B?OVRCNTczSHpNZUY0bWpKTUZJYThHYmhQYU1NeThySFlpOHVPeGNoYmJsdnhJ?=
 =?utf-8?B?RXVBTFJpcUs4bmhjWGhjaEtpNUE3Ky9vazNnYjE2WFVFR25RR2MrS3o3ZUFh?=
 =?utf-8?B?MkZnSXN4TDVXVVBuQkpJK3RFcTd0UURQK3JwZTVGOVZnc3NsS1Nsbm5HWVNh?=
 =?utf-8?B?L3JPMDZqYmgyQk93TDFxZitlUmRGL0s5NG9nRE9iRy8vQnhDTU9CdGJpVExL?=
 =?utf-8?B?dllqZEZackVPNWlQTlVIK2YzNXdsWnB2NXlGTE9Zc3cxNk96TDRzMVJKWEF2?=
 =?utf-8?B?c2krMXVwNE93RjdXS0tEUVFlSng5U2hlTjlCcGlaeW5VaEMrMmpzK1BZZmdZ?=
 =?utf-8?B?U1llWkVXQlcvU1ZsU3g4eHliNHQ1YVdiSTZDdnU0YW1JN2VGbHJiY1o1OVdV?=
 =?utf-8?B?TVRMWkR6MU13RTBLcGZOemdXcVZGQ3ZpdUgxSndDTU1YUWl4WGh0ek1hckVH?=
 =?utf-8?B?WGdIQ3NIaldiSXVhMzhMK3pvR2kydUxtcS9Nem9PR0VtMURaMDBwSWdiU3hV?=
 =?utf-8?B?NW4vM2RCV21QWDBvRVl0cGx1S0k4NUVXVVFtbzJIbGUwaTJPeGFib3pYT1Nh?=
 =?utf-8?B?aVZlc3kzczk5cDZ2b1E1NzJPZ2pqMzd3cFVDYktHdXZaN2J3bzFqenQrTnps?=
 =?utf-8?B?SWtSSExrdmR6VGtMUXEvMDBOc2EySGFiaUV6eHdRVUU3dFJudmpvc2Y1TTNV?=
 =?utf-8?B?Y3JFWVM0QjB4STdUOG5yVy9DODdObWhTT3dtbkQ3M0UvUDZJK01pVmRNUUlD?=
 =?utf-8?B?dDYzUWtMVTRFRE1BNlN4OXE2MW95bkNja1orTXplTk1ucGVhZUZtUW9Yei81?=
 =?utf-8?B?TlJSY0ZaTDNzTldYbUh6Um1uMDVCMXNpR2kxT0VQcHhRcUhZN0xwVkhFTy9u?=
 =?utf-8?B?SjhKbWhCWmExaU1mMUZnbFQ5VkZIK2RDaXpCKzBzOWtBNWFwZloxSXZKaTZx?=
 =?utf-8?B?SGJpK1laL0h0ZGJWSjhPa29xeGJtM0ZldDI2N1ZHNnljTVp6SGp2bzRYVWRE?=
 =?utf-8?B?U01SVzgraWVadzZFbHprbVhUSXg5VjROckMxRmU3ZHN6TUQ0QVd1V1VuR21p?=
 =?utf-8?B?Wk5FVDhtS21sbUlZRDFjZDUvVUlFUnV4ZjhNZkNxOWI5dGVaWEFWc1R1Qito?=
 =?utf-8?B?WGFNQkFlcDdKMThvaGI0U2d3MkkycmNXaDdOY0NKekNiVlRXa3VzcExaTm5w?=
 =?utf-8?B?OS9YK3J3NjhWSm92ZXdMWmxoYkpIVEtzRUZLcGhHaEhFaytoZGhjRXZVdkhF?=
 =?utf-8?B?Ukd0em5kVmVXdlB0S0FzT2FVRDA0ajFNOS94cDh5b1lYMm1aVVhuRGdnTWxD?=
 =?utf-8?Q?ZUSQemB3g4ELyX4RcC55GLQJa9U/RGY3gMYMks9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGdjeURxenJNWGY2TmVxcGdEditYZDR5TlBtVXg4VFQ4cFdCNGE3d1FQT25i?=
 =?utf-8?B?UDVwNUlqY1NYMlY5U3FtbTBnUTBQYVZJTHlrZVNidTBMNExML0pycTQzN0I3?=
 =?utf-8?B?Zm0vakJFOVZGOFg0eC92Z3o1T055am1yVGhhRlA5SUxLMmYyTFBPZHhaUlp3?=
 =?utf-8?B?enJZTFpPVFcwaFBxWHlLRm5Lb3pOYmdWVUdFSmtuL0tCcDQwcG43STM0OE1z?=
 =?utf-8?B?UUtIZHc3YTVrNWRsb1BndVpqTDBkUERaMmFxSmp3d29nU1Y3MzkrSmM5bTFs?=
 =?utf-8?B?TkZnRnF6ek1aRTJFcnZDVHlsZzVWNVdWQ2ZSbG4zR3JBblFUaGZQbm82NnBw?=
 =?utf-8?B?NDRYNW92cnV3SFRPbk9KWWovb2pDaTN1cXV5bVBCbmtpMnZKZTU3dFJsR29F?=
 =?utf-8?B?Y29xbzRkSWdvY3haQm1xUUxlS3dnMkFkdkt2SkM1QVZDVTFEVnUxNE5SbURu?=
 =?utf-8?B?VUNsUTZSb3VoUEo2ZGVQaWdqY1pER0MzZDh3dmVFNEM2d285VlVtdXRLL01K?=
 =?utf-8?B?azFZNU9FQ3dIZ2lubk5XeTBSTVBzOFA3Sm96dUVOMElvQXNCQW90aUovdEF1?=
 =?utf-8?B?a1NIR1czdTVFZElCSHBndkhwaEhNazNZVXQyM2Zuc0luMXhsVXB6ZU51ZFlY?=
 =?utf-8?B?QlVDUk42QjhvUldydVVIVFBqeElSUUo5MlVUVDJXeDVocXJxbjcyWkZrMVRV?=
 =?utf-8?B?ZHd1QXNSRS96N2p5Qk9tRSt4Y3NvZGFmeWZRQWMvUUZjSVhnTHEreXhpUGpV?=
 =?utf-8?B?and3M3dOaGtCTy9GMDRMS2Vod0ZMNHhuNVJLckgyTGNaUkt1dVhsN3hTbnBO?=
 =?utf-8?B?a2h1Ym02VFBVM3E0eTVjdEk5amdMeGdKVGlYTGZtOEVHQWFYQ3pLUUlsZlNM?=
 =?utf-8?B?ci9aMlVzZ1lVVHdaNXIrYVlFNllzK25GQmJ5MUt6cVY3QjhBeGZpcytzeDZx?=
 =?utf-8?B?QUlQWWc4QzljUHExd0FGRThhWTVabU5FN25BQjl2dUdkekJ2ZmxycU5Pcjc5?=
 =?utf-8?B?S0l0M09GQ2w0S3FsMGdabnk3emlrTTVRejR6SFhHdnpuTzFTQmJlNERvSy9X?=
 =?utf-8?B?QWFNbzBXZWhTNW4zMTNpbUYrWjNMVWdqTGlzKzFyZlRUai84dnM2M1dtdU1I?=
 =?utf-8?B?OVRnWUJOZHNqb2pGVkhoeGo0akladWZzMUdBMU9FeWg5cnViQWIzUmJza2Y0?=
 =?utf-8?B?YWlqelhjWDh5aGN2ZmVFKytmQnpBN3B6TldxOVkwa2cydDlVVGlabDVGZWJZ?=
 =?utf-8?B?Q3NpM0lhVU9hVE1HNnpiSTFaMjhjTEVQT0dTdGFRTnBCODdyQkRpUzRZazFp?=
 =?utf-8?B?RnJiNUpUM09QY2I3NVFRVW1GMVd1YXlMRUI1WG1SNzNyWStHaUxmdjJCcm1n?=
 =?utf-8?B?VG40UlR5Nks3a01QM1VRNm1KdzlBV0pqR2tUREEwbitGdE00UXhkZ2xIY3RD?=
 =?utf-8?B?aFFDNVlxM3BoM1R4SUJYM1ovdy8vRldMdWVBWmhFVUxOYXcyTGtnTHJra2R3?=
 =?utf-8?B?SlNjMHlUdUx5Q1dISU1UVTFCcFhyRFVzeGdFK3JZenNESjNvRHMzek1odDNM?=
 =?utf-8?B?MkIzeWtNVnpUUGpKY2p3NjlkQ25qZDVxbUhLQ0NPYTQxenlIMXp0RHdPTVdz?=
 =?utf-8?B?MFVlM1o5V1FwWXI1RjRjR1V4SjJTOExoRlZoRjJNQnEyNE1iV2JOZXMzMHJi?=
 =?utf-8?B?Z0hYM1VTcnB1V2JSa0Q0RG56Z1Q3S1BrdTFHMjVFTkxwU0dnRDBXRm5jQjM5?=
 =?utf-8?B?RERtdHFwaFduSFpTL1JMcldyZlIyM1FraUlSYmhHUGFOeVVQckhwTVUwc3c0?=
 =?utf-8?B?a1M1aUViZmVMckF4eHVHT0h3VHd3Y0s5MHc0U3RlVyszOHQwZkFPNWEwRFJ6?=
 =?utf-8?B?WjBpTjhCckV0SW4zeGJPcVAxOW9QZlRaLzFyRFJmczdsVVVUeWVHd01lMmc4?=
 =?utf-8?B?SUxJcitVQWJTUnltSFQzRzRCWStjMStqblQ0ajlHOEt6VmV3K054OE1jM2pX?=
 =?utf-8?B?YkRwbHkrT2lGWlpUU3JhMS9GeFVIUGFROGtwU2p4UXk4dzYxUEF4TFRDTksr?=
 =?utf-8?B?dzV6Z0h5akVRZG5aOWcyaDNCU0dmeWs1aFJlOThJVjNESk5yU0dZMDZtNjJX?=
 =?utf-8?Q?lifYNJqvqQe6yrvKxdNSxkDRF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533e0a7a-66b3-4261-05e4-08dc861c18ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 11:30:41.3328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ks1Mvg6sYEKMPyD+ZR0y0GtHshX/Q2w8ARKSAQKxsVt702jBeF1HYTl8y80MGRYzk20HZhLgszfotLZT2gZzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551


On 06/06/2024 13:13, Sagi Grimberg wrote:
>
>
> On 02/06/2024 16:08, Sagi Grimberg wrote:
>>
>>
>> On 02/06/2024 14:43, Max Gurtovoy wrote:
>>> Hi Sagi,
>>>
>>> On 02/06/2024 11:53, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 02/06/2024 11:19, Leon Romanovsky wrote:
>>>>> On Sun, May 26, 2024 at 11:31:25AM +0300, Sagi Grimberg wrote:
>>>>>> ib_drain_qp does not do drain a shared recv queue (because it is
>>>>>> shared). However in the absence of any guarantees that the recv
>>>>>> completions were consumed, the ulp can reference these completions
>>>>>> after draining the qp and freeing its associated resources, which
>>>>>> is a uaf [1].
>>>>>>
>>>>>> We cannot drain a srq like a normal rq, however in ib_drain_qp
>>>>>> once the qp moved to error state, we reap the recv_cq once in
>>>>>> order to prevent consumption of recv completions after the drain.
>>>>>>
>>>>>> [1]:
>>>>>> -- 
>>>>>> [199856.569999] Unable to handle kernel paging request at virtual 
>>>>>> address 002248778adfd6d0
>>>>>> <....>
>>>>>> [199856.721701] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
>>>>>> <....>
>>>>>> [199856.827281] Call trace:
>>>>>> [199856.829847]  nvmet_parse_admin_cmd+0x34/0x178 [nvmet]
>>>>>> [199856.835007]  nvmet_req_init+0x2e0/0x378 [nvmet]
>>>>>> [199856.839640]  nvmet_rdma_handle_command+0xa4/0x2e8 [nvmet_rdma]
>>>>>> [199856.845575]  nvmet_rdma_recv_done+0xcc/0x240 [nvmet_rdma]
>>>>>> [199856.851109]  __ib_process_cq+0x84/0xf0 [ib_core]
>>>>>> [199856.855858]  ib_cq_poll_work+0x34/0xa0 [ib_core]
>>>>>> [199856.860587]  process_one_work+0x1ec/0x4a0
>>>>>> [199856.864694]  worker_thread+0x48/0x490
>>>>>> [199856.868453]  kthread+0x158/0x160
>>>>>> [199856.871779]  ret_from_fork+0x10/0x18
>>>>>> -- 
>>>>>>
>>>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>>> ---
>>>>>> Note this patch is not yet tested, but sending it for visibility and
>>>>>> early feedback. While nothing prevents ib_drain_cq to process a cq
>>>>>> directly (even if it has another context) I am not convinced if all
>>>>>> the upper layers don't have any assumptions about a single context
>>>>>> consuming the cq, even if it is while it is drained. It is also
>>>>>> possible to to add ib_reap_cq that fences the cq poll context before
>>>>>> reaping the cq, but this may have other side-effects.
>>>>> Did you have a chance to test this patch?
>>>>> I looked at the code and it seems to be correct change, but I also 
>>>>> don't
>>>>> know about all ULP assumptions.
>>>>
>>>> Not yet...
>>>>
>>>> One thing that is problematic with this patch though is that there 
>>>> is no
>>>> stopping condition to the direct poll. So if the CQ is shared among 
>>>> a number of
>>>> qps (and srq's), nothing prevents the polling from consume 
>>>> completions forever...
>>>>
>>>> So we probably need it to be:
>>>> -- 
>>>> diff --git a/drivers/infiniband/core/verbs.c 
>>>> b/drivers/infiniband/core/verbs.c
>>>> index 580e9019e96a..f411fef35938 100644
>>>> --- a/drivers/infiniband/core/verbs.c
>>>> +++ b/drivers/infiniband/core/verbs.c
>>>> @@ -2971,7 +2971,7 @@ void ib_drain_qp(struct ib_qp *qp)
>>>>                  * guarantees that the ulp will free resources and 
>>>> only then
>>>>                  * consume the recv completion.
>>>>                  */
>>>> -               ib_process_cq_direct(qp->recv_cq, -1);
>>>> +               ib_process_cq_direct(qp->recv_cq, qp->recv_cq->cqe);
>>>
>>> I tried to fix the problem few years ago in [1] but eventually the 
>>> patchset was not accepted.
>>>
>>> We should probably try to improve the original series (using cq->cqe 
>>> instead of -1 for example) and upstream it.
>>>
>>> [1] 
>>> https://lore.kernel.org/all/1516197178-26493-1-git-send-email-maxg@mellanox.com/
>>
>> Yes. I'd like to know if the qp event is needed though, given that 
>> the qp is already in error state (from the sq drain)
>> and then we run a single pass over the recv_cq, is it possible to 
>> miss any completions.
>>
>> Would like to resolve the drain without involving the ulp drivers.
>>
>> If so, then perhaps we can intercept the qp event at the core, before 
>> sending it to the ulp and there we can complete
>> the srq completion.
>
> Ping?

I think that catching the IB_EVENT_QP_LAST_WQE_REACHED in the core and 
complete(&qp->srq_completion) is possible but will require some event 
processing in the ib core.

Probably my patch [1/4] from 
https://lore.kernel.org/all/1516197178-26493-2-git-send-email-maxg@mellanox.com/#r 
should be updated with this logic.


