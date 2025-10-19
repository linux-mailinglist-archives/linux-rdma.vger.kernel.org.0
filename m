Return-Path: <linux-rdma+bounces-13938-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8467BEE4B8
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 14:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A223B76B7
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACB5227BB5;
	Sun, 19 Oct 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rioTIl19"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C37433B3
	for <linux-rdma@vger.kernel.org>; Sun, 19 Oct 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760876740; cv=fail; b=tvf1R6CK+u/TYEeA0JuQHgYNjeCiTZQS0Gk1qb9FjvCQ9HhFv6MmnhF7iaC6vbYJHd3C8BG2EnKrFB2WFJMkStlb/SMWbNORQnLsGyPjX5vkpxVSZ5+xlJ6F7xdpvtlkRrXtcx/0f68ZdPLVqMSiKFodiJUKE8uQ4THIearFUE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760876740; c=relaxed/simple;
	bh=Mly513TlONd/jmy/jav67LNwrJJBnk6XKUkBzlMHmFI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vek0i8NhMmSSiaN+OpjKatuMlzDMPd3S1BN2andk3nDKHTYshb29SXHh0LsaLB5bnli+OaDUwd9QT/LsWm/YpQ5LqJ5yYwjfCRmiFIrQ5/T4nq9/d3Scv5K269d/VGux1pqfPEMsaW2RqY29FixImwFO/crbRZuWShe0QYrwPnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rioTIl19; arc=fail smtp.client-ip=40.93.196.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WO6qnmQZFRqkl+5/TArgiOxjLGZKoHyTUa9o5AKHZFSdR9fx47VjUEsA1VYa4XiSHZWilzsk/mHJCiJ7GN5yRBTpafV7Fdd7O/52odWUjReLHUqIZpnYZK2nFJXlsNv2t9HPabKidE8xRIPvWjV7poYFvSKvzkWtUxjQWZnZ5O/Z30rnRfvE+XvkMO2RmNyXyBY8bqDdm0wZ6yg0fByInGx54SUPJ6RI+uQs+ZWWo7cZ4LAj5SPUQEqCpzunRzse0x2lrMU5FrW5/ZJrJiI01HtycaSrrZXz05HEcyOMmHwO+FaI7sTCFvrTRTzZDQfk63jg/BxKTxddt5PmJm68jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7fPatZ1F+CFcFWqsn4wECtEj+VbPy4ncF/8Gyes8fM=;
 b=HhU/kOUovSYd0m8qLvJZlfaHwojG7hzCQ/dv+gAPDchlvBzxYJMYMfGlRyrvLygWw8OotTX47cVZk4x2BXsVRSNKVj4KdpE4G6VhdV+hJ6nqmGAcYIawSl+byqbYu9CaDFRTwNBM7Rxf9aNqDfxF3c78eID65kS3StWsdI/UyLLBj0DzoYZMPC8z7P3DmnLOEylNpPwOVXQ9B9mP1lhAVX0bRvpyb/VtXxWHAgmTYGkxxEM8pVci+Z0xU2w2n3B9yCnReVHHNTPKsyjjSpusBEsbRfnBHlxF4zdHaQ0DZ9fEoMpevP/PoMaLrKU/z4U3/8twXe6RjeHCyaFM4tzizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7fPatZ1F+CFcFWqsn4wECtEj+VbPy4ncF/8Gyes8fM=;
 b=rioTIl19HtWM5j3UEnskbON00u2UipnzJUavyhvM0uMdCuskexuQRihFYQb2546dauHhjIvSycH74OnVOl21hU8NlDS7uq00u9J/UwEEwiwBb2NzzV2YaZUSMWlbOFCGxU9vb1yww1vJKeeg2I4fknBWGTDyBt7fwJIaBvUIgl3mU/2gotk/yicYCpHIgpGXYjKXhnfSVkTg9Rkl4O+q5zZMDYUiTy2QGZsZTG8MAepGfw0sBKZys0lu8HEJHbdTHwUHB+kN1WNDWc2XhMXJc9o9ep5HrNPrxiM6HifpM1oAQVtR+NzY4EaTI23P0G/DfD4+EUaIra4Msk5ZX0MeaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Sun, 19 Oct
 2025 12:25:35 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%3]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 12:25:34 +0000
Message-ID: <15faef57-3e78-4d30-84bc-8297d71634eb@nvidia.com>
Date: Sun, 19 Oct 2025 15:25:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net/mlx5e: Prevent tunnel reformat when tunnel mode
 not allowed
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-rdma@vger.kernel.org
References: <aPIEK4rLB586FdDt@stanley.mountain>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <aPIEK4rLB586FdDt@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|MN2PR12MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: c96f0465-4299-49b7-afa3-08de0f0a9a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1V3b1BUemEyZmwzL2h6aHJLcnNSQWxwZGk2Q3A4UGtTQXU2c2lLK1BjV3J6?=
 =?utf-8?B?YWd1RDMwdmlhT3hPbzQyNHVHazBSNGdDczNJV29CanlBOHFhYlR2bS96QlhP?=
 =?utf-8?B?MFZ4MUdSaFA2aG04c2xBMDNFYUhDOVEyTHdCVE53b0tCZkhYVSs1cDBvZnJv?=
 =?utf-8?B?cXF5cHRzV2pFaXlYNHVYcExmT20wdktySEFCbGtZUit3TXpjTmh2eUZ6cWYv?=
 =?utf-8?B?NEg3RTlZVkFQUkZHbEs2bGcyV0FtTkpnUjFyRDd5VzNZMHRUdzNmQmdrcUFh?=
 =?utf-8?B?cHRLSUgydWQ4L1R6M1pKZlg3ZGp5T1VNY2lGRUNBNVZkNGVGbjQ5SEdLZlla?=
 =?utf-8?B?blhXeW55OWE1M0puOGd2Mk1EMU9QbFpyWmIvQlhaWkVTb1pGaEJYM2lFcDFT?=
 =?utf-8?B?TGcwWHlwRWx6WWVXeU80b3FKdjNpejA1ckxpbVdibks4QmFGeTQ1SGVaclhW?=
 =?utf-8?B?aTZQTDN6c0ppMHNibjgrWDR3OVZhUTFqQlZIWm9IZkt3SllWTU0vclZ4MnNV?=
 =?utf-8?B?ZTlvR0FzRVl1UmQ2S0dvclJsVVE5SFRWTlVxMW1pRFZzTGxuVC9RSUx2bWNv?=
 =?utf-8?B?Z0lZajlHK3dObkNQMnVwSHRwVTdFUVR3eDh0UEdKNWcvb214aUdGb1NnOTBS?=
 =?utf-8?B?dmljQ2MxejBBQWVtc1dVdjlIV241WEJ6M2ppTHRKSm5xQUY1Z25aY0Zjb2lp?=
 =?utf-8?B?SW5zZmR5aHRNUWtOd2c4SldLdEdHcW1zQ1hkM254UWIxYmZJc1RNemNLOXoz?=
 =?utf-8?B?SGJNdHJnaGRkRWFsZGJORU9xR1h5ZTlJRDR5RTVpODVBaEdFNERuVzVQMUYv?=
 =?utf-8?B?NHRPNmxaMjlLY1pxRWlLRHE1WkhuS0lEeW4zNzlmVWhxZUd5aW1jTjFqNkRj?=
 =?utf-8?B?ZEdTQ2FnTGtBdlBpQTg1YnBoMUI0dUhPeUI3dDYwQ1Z1b1VLRnEzMUFDSTNm?=
 =?utf-8?B?UnNQNk42djNrTHg3SGNPZmtPZG1tK3dzazQ3bmF0dEZJa2NVeXdrRDV6RXdm?=
 =?utf-8?B?UjNiaHNoQWxJQWRiZGdOckgwc3hnTVlQY2gwa1RCL0RERkdpTHowa2hGMjFL?=
 =?utf-8?B?UFErM25nOUREdkpvLzZmV0RTb3pPWFRWYzZ3dVdYdVpucjFadXJIS0d1bGF5?=
 =?utf-8?B?UzdjQjlycSs0MldWNHEvaTZ3OVI5RllLU1ZNVlhrRzZHdGhzUjA5MnJRenpF?=
 =?utf-8?B?U1M0Ti95N0M1emY1Qzc0eU9kbVJsRTdla2hDS0pibEFZbS9Tc2JPR05iZC9N?=
 =?utf-8?B?UWZJbk9pTmpmS1lmMTJINERsdmRtM0srb1c1cjQ0WXhvTDFIV2k2L3EyS2V1?=
 =?utf-8?B?WS9PZit0Rm5ybTJVaVcxV1djbkhtb3dxUVFUV2tqckZ0L1MwdURVeWtYbHZY?=
 =?utf-8?B?T3dyeXMzc2dYTGhhL0NaUlpZOVluU2FpMjVOd2thS1Q1VVRzdUNVMmUwa1RD?=
 =?utf-8?B?dUI0SXI1RE5PeXExU0Z0cU1xT3RWRkRGZ3NkVVpkRXQ4Zk5kR0ZCeGpmemZO?=
 =?utf-8?B?MWQ1aHB4cE9JamNHYjBiOEU2a3ZkRXY5WFV2dWJXRllFYm9MQkdrZGF2NFhW?=
 =?utf-8?B?V3I3T1ZWc01tb2RyZzU4Uk4wNDJNdnRWVDEwUEJmeVRubFB2N0lSMWwvQkFV?=
 =?utf-8?B?bWVXcGxDUmc1NHJWRkNkN3o1UCs1aTExOXNGZ3hFWHBjcEFFNy9qNExXWWEw?=
 =?utf-8?B?V1doK1pwc1luclNMdXY1RCt0MEs3SHp4U3ovWjhnemhvSTBDVWNmdlJ2cVJt?=
 =?utf-8?B?L0NzbzE0c2VMY1c4RnV3NmRWMTJnck1qZXlsQkxZalRuNFdNQlFVRHY4eFZN?=
 =?utf-8?B?U1FwNXFXVlZzL2FaL3NzU2FIeCtOMWVLNmdSVkJEOG5GUldEcHNsaGZxNlVY?=
 =?utf-8?B?SWtLZ0MvbFArWUVvaEFZeTI1RWhvZlVOZjdsNW9SRGEyM09Ec3dqbmZWMUF1?=
 =?utf-8?Q?4MHIFYg8zHF8X83ieKSMtPmvuHpDycuj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHVWRXN5UkE4T1kwWTRRTEFzblYyZy8zQ2E0akNjVUVzcDhoQ1ExVG8zeXgx?=
 =?utf-8?B?U0YyY0JyQmd3b1lGMUpEbnlnN2RFWnN4OGxHZDlhOHVtNjAvZ05UcHI0b0lm?=
 =?utf-8?B?WVNLb0Zmb2d4T0hHcnFwcWNtc3JuTEh2YWxrYWd5eVBQaEU1OHcwM1FtR0FQ?=
 =?utf-8?B?WU9NTEIyUGNsVnQ0cDNQeXFKanBUWnJLTXEzM00vTFJXSzl4U09zMm1sTlBI?=
 =?utf-8?B?cEtyelBXWit3cWdnWE1Wc3lGWGE1dndXcHdFbXdINFZNZHVCZW1reHJaRTBt?=
 =?utf-8?B?K0VwTmxZb0h3NDFmOXhoU0Myb0g3TXNudjZBcTI0eTVXUnpnSXZ0ZnBSYlFn?=
 =?utf-8?B?RUdvQld4TjV0WFNEMCs2TG5hQThubE1OZkc1dGFTQVZlOERWRjhpQzRuZmY5?=
 =?utf-8?B?TUhiRTFIbWVqUGwwT1F3Tm83N0Rtazdic2toQnVtZXI5UFQ4QnR5Qit3YmNL?=
 =?utf-8?B?bGZKZlNtL3BSTGpkUllOa1NqbDhGaTU2NXJhcnp0cCtWWldqcHh1RGxrbWdl?=
 =?utf-8?B?MFVPM1YwcUNqZTN0b3BmM3dhUEVCQnlqcnhZZFNtQUpJa0xzUFN2THhjMTgv?=
 =?utf-8?B?VEV6RTdvNzY5cnk4Q01FRzQ4YUhGdW9oQmoreDdaTHYxbHV2cWhRazh3VU0y?=
 =?utf-8?B?NkllK0c1a1F6Nzl2bTdOblpBa3pTQW5aYXljYmFCRzNtaHJRbTNjQm9zbzVP?=
 =?utf-8?B?MW5GeGhGVmVSTnM4cjdpYWQ0Ylo0cGlBRTliMllidXFaYTJoTEZFVWRPZjlM?=
 =?utf-8?B?WEtpeEJHdkFuNFdieWdDNUF6VDZTZXNGQ21JRUd3V3VqR0FhNDdCaGNWTEdG?=
 =?utf-8?B?YVZ6OVhUenA5ZTFTODlYaEhMSDh4dE9PSS95UWM2bHY4TWRyNXNCUFdzVFVT?=
 =?utf-8?B?TVJ2QXRSTU5PZlpud0Mxb3ljdjA5a3d6Z2lCTXhudzdpeEMrdTdnSnIyRVhi?=
 =?utf-8?B?RkE2YUM0WkRFeGhaMjN0djFZZjN4OEtUKzBBQzlOM3RpY2gvSSt2WTVDTHNQ?=
 =?utf-8?B?K2szTVhzRnJnL1JJTjZ0a3UrK0xjRFpRbGtLUlZmYUtscHJsaFhjNGc1bTNV?=
 =?utf-8?B?SjlZSzR6NkUrSEl2cW8rdEd0dW1WREQrMk9IYm4wb01YdEF3b0xJSEt1V2tH?=
 =?utf-8?B?VDBjVURYc2h6MG9sNUlld0xkZ3Nnb00yZVRPOEhSajJkT25HbmlBeUJSaFpS?=
 =?utf-8?B?djN1ZlNCc1lMT1E4MjBXaUlGaVAvSG5BT3NuLzJwdXNmMW5QRDJCKzd5R3Q1?=
 =?utf-8?B?cnVxSnZkdCtOWjhGTUF5eTBodjByZ0thc3NsZWJBaUUvcVY0a3pzaVJJSEt2?=
 =?utf-8?B?MHdYd21zOElYcEZKenp2WUJ2ZGprYTNkL0txUmluMXZCUWtzdURCeEQ3Y1BB?=
 =?utf-8?B?YzVwclBXYTgvNitURytVRk1RaXBsUlh3akNGVWVmenF1UEtIL2ZCWlo3bzJO?=
 =?utf-8?B?bTZkS2Z6RFBLbmdvZzRWNDh2MWtTcHFyTTJSeDFHbndGMHpEbWppc2NmMTk4?=
 =?utf-8?B?MGdaSC9Ud3c2WHh6UDdWVmF5RXI2OGJudW51eUl2S3FCRU5DTTBleG1vd2NE?=
 =?utf-8?B?TnZWUUc2dDlqR2tTWWpHd20vVndIN3QrcVpHYzJvem1BV2doYmwzYkxiVEpn?=
 =?utf-8?B?dnFKM2hqVWJHU1Z5V3dUNGhPRHJFOVM5MDBud0hERVo1Wkc0QXRpSWI4bzgx?=
 =?utf-8?B?REl0MWorUDNRRzlQd21mbTI2NXRUM3ZwNElyT1FnU1p3MkkycmVZUHE3RzNK?=
 =?utf-8?B?NG1BTiszZC9DZERlY1o2ejNleXlIT0h5ZjFCUUM5SndtZ0ttZEJIL21WMVJK?=
 =?utf-8?B?TEFFWmdwekZMaEs5M1FDVmgrajJsYk1zblpGcC9LZWYxNHArMHlGQkxiejlv?=
 =?utf-8?B?MWNBL0gxKzJkM2JSV1VXZWhLM3JBeE5NN1J1QUpoY3ZnN0pPUitDaGx0L0lo?=
 =?utf-8?B?aG1jRlJDbWhDeUFHczlXb3U2S1haWHkrdU83WkJScE41enFWSFg2T0ZDNFRo?=
 =?utf-8?B?cHBEZzExUXExVFNFK2F1MUFaVFQ1TEFNQmUwVnN1MmNRT2VCaUI0eDR6UFNz?=
 =?utf-8?B?d1BvZVVaSnJyclFPR0hPYUk5QjgyWkw4NVRraXllYjRkbkVUdGg5dEFsVHVE?=
 =?utf-8?Q?IOfJ3jXEB/PeL1RhJR/aL1Hos?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96f0465-4299-49b7-afa3-08de0f0a9a3c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 12:25:34.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAxTM/KYGIAfdJtatUKoYFcsIe6NFRgF6/R+U+IAbzQkRrc2jjoCapHkYPS+E7qTqpcg9tJGjD7TqLP6J3t28A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173

On 17/10/2025 11:54, Dan Carpenter wrote:
> Hello Carolina Jubran,
>
> Commit 22239eb258bc ("net/mlx5e: Prevent tunnel reformat when tunnel
> mode not allowed") from Oct 5, 2025 (linux-next), leads to the
> following Smatch static checker warning:
>
> 	drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c:808 mlx5e_xfrm_add_state()
> 	warn: missing error code 'err'
>
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
>      770 static int mlx5e_xfrm_add_state(struct net_device *dev,
>      771                                 struct xfrm_state *x,
>      772                                 struct netlink_ext_ack *extack)
>      773 {
>      774         struct mlx5e_ipsec_sa_entry *sa_entry = NULL;
>      775         bool allow_tunnel_mode = false;
>      776         struct mlx5e_ipsec *ipsec;
>      777         struct mlx5e_priv *priv;
>      778         gfp_t gfp;
>      779         int err;
>      780
>      781         priv = netdev_priv(dev);
>      782         if (!priv->ipsec)
>      783                 return -EOPNOTSUPP;
>      784
>      785         ipsec = priv->ipsec;
>      786         gfp = (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ) ? GFP_ATOMIC : GFP_KERNEL;
>      787         sa_entry = kzalloc(sizeof(*sa_entry), gfp);
>      788         if (!sa_entry)
>      789                 return -ENOMEM;
>      790
>      791         sa_entry->x = x;
>      792         sa_entry->dev = dev;
>      793         sa_entry->ipsec = ipsec;
>      794         /* Check if this SA is originated from acquire flow temporary SA */
>      795         if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
>      796                 goto out;
>      797
>      798         err = mlx5e_xfrm_validate_state(priv->mdev, x, extack);
>      799         if (err)
>      800                 goto err_xfrm;
>      801
>      802         if (!mlx5_eswitch_block_ipsec(priv->mdev)) {
>      803                 err = -EBUSY;
>      804                 goto err_xfrm;
>      805         }
>      806
>      807         if (mlx5_eswitch_block_mode(priv->mdev))
> --> 808                 goto unblock_ipsec;
>
> Should we set the error code on this path?  err = -EINVAL?  If not the
> way to silence these warnings would be to set "ret = 0;" within five
> lines of the goto.  (The compiler will obviously remove that, it's just
> for the checker and human readers).  Another option would be to add a
> comment.
>
>      809
>      810         if (x->props.mode == XFRM_MODE_TUNNEL &&
>      811             x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
>      812                 allow_tunnel_mode = mlx5e_ipsec_fs_tunnel_allowed(sa_entry);
>      813                 if (!allow_tunnel_mode) {
>      814                         NL_SET_ERR_MSG_MOD(extack,
>      815                                            "Packet offload tunnel mode is disabled due to encap settings");
>      816                         err = -EINVAL;
>      817                         goto unblock_mode;
>      818                 }
>      819         }
>      820
>      821         /* check esn */
>      822         if (x->props.flags & XFRM_STATE_ESN)
>      823                 mlx5e_ipsec_update_esn_state(sa_entry);
>      824         else
>      825                 /* According to RFC4303, section "3.3.3. Sequence Number Generation",
>      826                  * the first packet sent using a given SA will contain a sequence
>      827                  * number of 1.
>      828                  */
>      829                 sa_entry->esn_state.esn = 1;
>      830
>      831         mlx5e_ipsec_build_accel_xfrm_attrs(sa_entry, &sa_entry->attrs);
>      832
>      833         err = mlx5_ipsec_create_work(sa_entry);
>      834         if (err)
>      835                 goto unblock_encap;
>      836
>      837         err = mlx5e_ipsec_create_dwork(sa_entry);
>      838         if (err)
>      839                 goto release_work;
>      840
>      841         /* create hw context */
>      842         err = mlx5_ipsec_create_sa_ctx(sa_entry);
>      843         if (err)
>      844                 goto release_dwork;
>      845
>      846         err = mlx5e_accel_ipsec_fs_add_rule(sa_entry);
>      847         if (err)
>      848                 goto err_hw_ctx;
>      849
>      850         /* We use *_bh() variant because xfrm_timer_handler(), which runs
>      851          * in softirq context, can reach our state delete logic and we need
>      852          * xa_erase_bh() there.
>      853          */
>      854         err = xa_insert_bh(&ipsec->sadb, sa_entry->ipsec_obj_id, sa_entry,
>      855                            GFP_KERNEL);
>      856         if (err)
>      857                 goto err_add_rule;
>      858
>      859         mlx5e_ipsec_set_esn_ops(sa_entry);
>      860
>      861         if (sa_entry->dwork)
>      862                 queue_delayed_work(ipsec->wq, &sa_entry->dwork->dwork,
>      863                                    MLX5_IPSEC_RESCHED);
>      864
>      865         if (allow_tunnel_mode) {
>      866                 xa_lock_bh(&ipsec->sadb);
>      867                 __xa_set_mark(&ipsec->sadb, sa_entry->ipsec_obj_id,
>      868                               MLX5E_IPSEC_TUNNEL_SA);
>      869                 xa_unlock_bh(&ipsec->sadb);
>      870         }
>      871
>      872 out:
>      873         x->xso.offload_handle = (unsigned long)sa_entry;
>      874         if (allow_tunnel_mode)
>      875                 mlx5_eswitch_unblock_encap(priv->mdev);
>      876
>      877         mlx5_eswitch_unblock_mode(priv->mdev);
>      878
>      879         return 0;
>      880
>      881 err_add_rule:
>      882         mlx5e_accel_ipsec_fs_del_rule(sa_entry);
>      883 err_hw_ctx:
>      884         mlx5_ipsec_free_sa_ctx(sa_entry);
>      885 release_dwork:
>      886         kfree(sa_entry->dwork);
>      887 release_work:
>      888         if (sa_entry->work)
>      889                 kfree(sa_entry->work->data);
>      890         kfree(sa_entry->work);
>      891 unblock_encap:
>      892         if (allow_tunnel_mode)
>      893                 mlx5_eswitch_unblock_encap(priv->mdev);
>      894 unblock_mode:
>      895         mlx5_eswitch_unblock_mode(priv->mdev);
>      896 unblock_ipsec:
>      897         mlx5_eswitch_unblock_ipsec(priv->mdev);
>      898 err_xfrm:
>      899         kfree(sa_entry);
>      900         NL_SET_ERR_MSG_WEAK_MOD(extack, "Device failed to offload this state");
>      901         return err;
>      902 }
>
> regards,
> dan carpenter


Hi Dan, thanks for the report!

Will send a fix to net soon.

Carolina


