Return-Path: <linux-rdma+bounces-8324-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A407DA4E5BD
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 17:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28BD461E90
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 16:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407BB28D081;
	Tue,  4 Mar 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fDAI498l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2D27F4C1;
	Tue,  4 Mar 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103879; cv=fail; b=FnHZOTcCcrkcPZuBEN95p8NQd8LFXWDp7R64yWarPFxw3vNTNteuMVYGXKGdEgGPuw8VFwFMBe7qp98d2qvyCZnS5bioLJ976W25kFLu3GyHzgaT0sbZ0iCIsDJuyBmAuhZDD6OX0E1jqlYKyUl4PuZMxMCQQvlFPM408rCgzoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103879; c=relaxed/simple;
	bh=tesTLzsJBXk7HI10qCwfN+ymDxVmyx2OTm7TXfUecRw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IIyxGuAZZmenUYXKBSrxtWqqsTALN6BTnS7HT9pnZpKEd3Eeoaqb3RbAkX6I85CXKRBdqAJ593c2iquLcjFHhzRAo98TfNmGU/sOLW3QYlsu/6U3Pt/xhj7vehVgNWxPQmov9yzBaAB6nKlH/KX5TtEX0IIl9quLYANX0S1PKf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fDAI498l; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEgADAMKGOlD8Ie3MruiCkvFpE3d1qaQX3eKGmbl+6/rtrrC9qXlDMCIyvZm8VmCJ75Bkc9X4APRmr/w8v0gIEV1+G625/LVrCNjUEcmzBUkWG+LTjL5XW2p5mnLzIZk73l+XiYZmofLw+fIpw2NEUT1Z6NIJLyze7w6ACOBtx3UuDeckYJSXVReL+jAn27czrc7PaAE/CEMR2RteBBheAixMkjznkWD0P6ZKNwMGneiq2yGXH+IuStE6kb7XKbWAXm6GCLjLrdnOmIgwH9YKV1HkGaCYZVhIFv5ZcZW2gGC+jtCSu0LIaJqVFhTCQ15k2vYSr2UOo8yplNJczaGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/0KwfEA+Cjb/eYXAQsaYeMfOJNkl1XjO430uRjjHVk=;
 b=h33EF5sONlkN2pAGjTd/FvUmGr+Svs2s//FuPL01ULGOQdoOxzUaDPoUeF+P/7nKDL2t05kuxcew5izL53DVTRXkuPokKqz2Cyx7ttcS/j8f7hM++xkgMq8QTAt0hOuJCvydDdtKIBpAQi1Y3kojgyvoRWN+HgizZuqc0dHg97DvX7UaJDfvxnFbbvRRogx1vvl8vdGZvDylzkDnNb0cKmmxraRsLqRfDcOvp3JRcLxSP6CIVv6HH+jH43h3Df1jFPE7AYapk+0gsnliKf7lmJlyH0BVALe0tP4X/pbHpYUziXCqwyBIfniZNtGwUZguYNupc7tY6ndhPOzxgaqMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/0KwfEA+Cjb/eYXAQsaYeMfOJNkl1XjO430uRjjHVk=;
 b=fDAI498ldOUN/54blcGZI72sYmjeJYsYTLeJY0pbiCokWGH2p3M/6yLMYI7WrJIaBxmgr95bPnNBTF4OOxxb7bidq5eeeWChmpk2c5y9QkmGSOduXcIxcgdOm7CtAN1u2ZNpzEnEnh/O3Hix3c1yayECwyvvjEZyiSHfzWtIiU8dZC5V38i2YlJh+D/oIl+trvGMj5LcFnmgpWurUDYSwQDYxBNYvk4s97dRNFsebvjKV8MGLu/RReBbch7e3aARCHiKFp9/fYOydJgxvLtpOIKXRjwY2syCUA6H6ptEdpKIffUmsiEz9WG8Hk2Gsfw0pDkG8accomFlaVvvdSlD7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 15:57:54 +0000
Received: from CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4]) by CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4%5]) with mapi id 15.20.8511.017; Tue, 4 Mar 2025
 15:57:53 +0000
Message-ID: <cf97f6fd-d40a-43f0-8b58-ad51d602fdfd@nvidia.com>
Date: Tue, 4 Mar 2025 17:57:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/mlx5: Prevent UB from shifting negative signed value
To: Qasim Ijaz <qasdev00@gmail.com>, leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250304140246.205919-1-qasdev00@gmail.com>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <20250304140246.205919-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To CH3PR12MB8583.namprd12.prod.outlook.com
 (2603:10b6:610:15f::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8583:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0838a2-8816-45ed-9cd8-08dd5b3552b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnVuSkF5YkF1akVDSU9kcHIrcXBiNUl2YUNaSmpLWjhjVzZaZk9FMEJURWpp?=
 =?utf-8?B?MnlZMitWcFptWk5DREg1enZaa29tZHRyMjBVZ09YemduczlUVFIxME9mckQr?=
 =?utf-8?B?Yzg3aTNUZDN3TThBMjBvQ2RiNThnUlhJY1lsQW1raHVIeVE3VjFndk1nclBs?=
 =?utf-8?B?RFhEZmJhbk4vT2tFdmprWENTMEo1c2VacTQ1amg5dDhwMndSakxjVXI5Qm1R?=
 =?utf-8?B?WUFCV0JzU2hNWmNGZWhacVJRRnJIODdDL0UrWVAvSHFLcTRyUUt6djRLc2FW?=
 =?utf-8?B?SDdKY1ZLbjNneXM1RHhkU0VYVkVvMG5Qb280NldpYlY2MkhMbzIvNzhTMHRU?=
 =?utf-8?B?Nk1CSHprV2s2UG5SL3JNdTIrWGRQY3pKb1V6Tnc2M3VWLzZUSHhkbUVtcFoy?=
 =?utf-8?B?NTV4RmhqQ2EwTmpBcDJoVSs5S2VmeFVhWUNUdGY2UnROV0hrd1V3bW02T21M?=
 =?utf-8?B?THRsOWFqRjNEZVVjVXF2ZTQ1alUyaTJadU5IZDhKc2RRVTNiTWNrMjVtOWFW?=
 =?utf-8?B?U1EzSmJiZG1sRTJLZ3BWeGs4OUF5aE50UTQrZk1yLzkzYldZajI2SlNaRW1s?=
 =?utf-8?B?eGo5WmJYYUVUWmZKVkRrMGpuYk91UGFLcGVxUFR2SlY2elB1WFlPcVowRFRM?=
 =?utf-8?B?bFlJS3lkb1ZFVWhlSGVLSjJ5QXpzbVdXMktaTzcwQTQwMHJLdjV4WUdrR2VG?=
 =?utf-8?B?QmRxZnBtbEpRUit5VGRySU1nb2lQNzJ4NVhNOWRkbXc0SFljdXl0Zmp5QWFJ?=
 =?utf-8?B?WGhGdnJmSFJia0hreTA1dHUwYzFuMWtCVCtmTzBuVmZoRHNwVDBvVy8zTzQz?=
 =?utf-8?B?ZzR2S1ZBRldzL3pOMWFtRVdnMU9EUGhRd2NZSTZxOTlRTzdJZ08veDhIaStq?=
 =?utf-8?B?QUcyMmNMMUJMUDN1QmZNeDBBNENtY0JVSFA1czlzbDJBend3a1FzZWxKVEdy?=
 =?utf-8?B?QzQ4TWswM0draFNPSytybUV1eDRRNzVsM1VLcVlzR09MdDFLWXVwTXZVUk1y?=
 =?utf-8?B?blVnS0E4RSs5bUZvVk9OZGZyUGxUcHNXbWZQUEpYY1JtTTZQMVZaei9oMXMv?=
 =?utf-8?B?cGg2ZEJrSUFpTnkzZmw5M0RCSTgydlpkOHhWN0FncEI3WE8wbTYySUdFNGs4?=
 =?utf-8?B?b1R6YW5jNzF6WEU4RWgyYTJXV0xyYVNvbnorQy96Y29BbVNtakRvZ2VnaURP?=
 =?utf-8?B?UGxMbkozb1RaWGRLdkhFM09KekN5KzI2T2E5WFVzT0pETXNSYkF5VmFOTUJ1?=
 =?utf-8?B?NVkyaFhhWjhmMVJ2QTQzZXZnVlZYYjR0THJCQ2doclA5V3U2Q2laK1NXVHIw?=
 =?utf-8?B?WnBET3RsZGQzbDhSS3V6U20xeHFGWkhCbnVBTGlwUjhXajZWZFNUdENGamls?=
 =?utf-8?B?TWFoRTdiaEtjK3lGcnB4aGJydEZWa0MyOU5Zdk9BWDRsMlhkZzNmTDJYV2tT?=
 =?utf-8?B?MExqRnE2Y0QzajN2cWFtYWx0TkdHMzJTcjhjSDR3ZnU3eW9hTmxjNzlsaUFJ?=
 =?utf-8?B?aUQvUGVqYm1OK0QwcTA1Zm55dEJrejVyeEpuSXZ5QUhrMm16aFdhZVpMWExj?=
 =?utf-8?B?R3dhalJGVC8wL0YwZlB2T05aNnlkSXIwSk1Penc3Nm5pVGx4dDVNazQzZ1FG?=
 =?utf-8?B?UU5LOHdMNXVCR3I2OEVValhVdnZOOW1kRlNhekpwRjFhK0VLQURrdEN0SEtD?=
 =?utf-8?B?RVdjZVdQQVoxYXY3a2xmT1N2dkRzaE9RSlZlNC9BMDYzMkg1elJZWDI3WGZw?=
 =?utf-8?B?MW5xSFM2MW9kenNSbDk0ekd6aW1GTVVPcVB4TWNyR1dnTjZtQkI4UDhXMTdk?=
 =?utf-8?B?enB3YUxOSU9MekxFaHVka1JJREs0eDJKMW5oRmZtdCtTenp5b1p2SiswcGhh?=
 =?utf-8?Q?gjCVni2vZ6hwk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXB1WVVjUlhac2kvcFNHc3plUjhqNGh4a3VkelhKVXlpU2NmMEt1bkFWV2h5?=
 =?utf-8?B?TkI1cGVCdlp4TXN2V3J3MUFNdHNTYTFEMHNzc2NLSTNiQTdSS3hyaG80M2JC?=
 =?utf-8?B?Y29pemF2cFYzRmtsa0tETE9sdTdJNC8rcW4zMnk1dHpDYkVZS1FEQk9teFdk?=
 =?utf-8?B?aHRRMGJtK01IMjMyMmJIWVhheHJwR1d1NUZCY1p0NVFHZnkzNTBRd2lHbnNZ?=
 =?utf-8?B?V1NpMHhYd24ya256TEUzQUlFSWZOWCtJZHlCalhtdFpETFNSZWo1RUlnTFYx?=
 =?utf-8?B?TjMrVElFSlBRMHdBekszS2JVZHhjcm5HQUdITk5RQUFLc1NuMWExZ3BVMUVt?=
 =?utf-8?B?MzV4WUR3K1d4djBJL0E4Q0llRGVOd2JPVkl5TUp1czVhZVFReUhEeUd0LzNt?=
 =?utf-8?B?TGJUYytlMml0SXJ2byswTXlkQ2t6L3NtbkNFcFdiWmJHcWJnVUhRaHJQWGcv?=
 =?utf-8?B?aWpac04zcG5UbzdxdlJTcCtUYnRhaWM2Ny9pQzJUTlNtME5kQ2xHaTZ1WXhZ?=
 =?utf-8?B?UlJxU1d1Rmt4SDgrWG8yYXpTczE5L2hrSkQ4Z0NOT1QyVFYvRjg3clNnRGM5?=
 =?utf-8?B?K0FjT2JVSDhDVVZzNXNteEV5SmJ0L0lwSnZ1dVJYSjVlUS9pdTFSWFZXd2FB?=
 =?utf-8?B?N2lGR3dhMDg0ZEZDZ05PcFJ1Q2tZYzRLb3ZNQ1FFNnJMUVNuU0RHbVhXSjBp?=
 =?utf-8?B?Zk0xakFUZGtBRGdrdGs2NHB1WWJWTHYwUUJiYkpLUTVPQkhUWmpPSE9kL2JZ?=
 =?utf-8?B?UytGa3V1cDVyRWg1UldzK0R1a2FneGNtNWRFaVFCUS96WTVIOUl6YXdXMVFH?=
 =?utf-8?B?ZUZlRFpKdzkvYzNLcjBkZVRMOEdpWTExRUNpOVNpSGhpenNIS0Q2OWhIS0Jj?=
 =?utf-8?B?NmNrTEEvQ0VkZjhNK25SZ3d0NnVzR0xia0pxT21tYTMxNVhxQmNockhtYlpZ?=
 =?utf-8?B?TmJMNzBDUzdmR2JsQ3d2Y2hOdHUwdUloUVd1aWFoSGZpWFR0UklSbnJOc3BH?=
 =?utf-8?B?U0NWVlNuemlWS2NFbno2YVZlOHNkZVIvWU04MXdubmtFK2k3czNmOGZFdzZ3?=
 =?utf-8?B?VUlGRW1HdktkazZ5WlpuZk9BM0tCS0hTUnpRNE4yM1BrUGhMcEluQnVpSkor?=
 =?utf-8?B?V0E1b3lQUmk0azIvSUVuL3FjNjM4NjEvbE5yUXZvek1aTUUrTG9WeDBZa251?=
 =?utf-8?B?Nmllay9HVmF2NXBWS3J0dzIrWnUrRklZVHpVa2pJWkgrVWtIL0U5S1pLdDZj?=
 =?utf-8?B?M1B0SXJ0aG14R3lEVklSZnJ0NzE3Z3JURFFJQUdYOVkwanRLWkV2czh0Y29v?=
 =?utf-8?B?ZW5ERHJ6MDFwZWpBNFVqcWdCWjFZT0tRRFp5c0c4Z0kzeDNXaTJkSDg3b1Jv?=
 =?utf-8?B?em1uVWducWlUeEtkRzJGS0NCTjEyOHpBbnVuY2wway9vQmJhdGFKNjBSdFE4?=
 =?utf-8?B?QTRhVmV5OWRWT2w0QmxGYVhJTk1GdkN6ZUE5NlpVQlhkektoUjYzVXlxY1dp?=
 =?utf-8?B?c04zZGFMMTJobWhpdlpJN1VLbTRUYmZoK3JjNFJFOUVtdFBsV0tsVXBYZm9t?=
 =?utf-8?B?ZHFNYlFJd2luTDVqcHpaYnAvenV1Sy9tRjJmRTJxOGlLWHJ6cTIycWM0REsr?=
 =?utf-8?B?dmRqSGQ1eVgvaFcyMXdmMEJmRHdYeFB6alVQdEx5dTI0TWVUNEtlaGw0WWpo?=
 =?utf-8?B?ekRFcEw1VUIzdG5qRjlRbi9yQUxZUVVEa2RxK0MzWUtQMFlaa2dlL3UrMlkx?=
 =?utf-8?B?cGhQdWNuSTV6cGFhNEM2MUVhd3lSenhkNmtYVkhhZkkzSzNKTTMxRHp3MUhr?=
 =?utf-8?B?R3NmbnNJL0xoRkNKS3ZPZHdOTmVjL0JZcjFUWlVnbFdhd0MwWEdtUFdtUzBh?=
 =?utf-8?B?dWVKZXhlWWlKTU1SZHlzUy9wL1Rva1dYY29kc0h5anZlY3hXVWF4YjFWcm9y?=
 =?utf-8?B?UDBwNDlmYWlQVXVZQTE0TEoyTi9VTVAyeUJPdnFaS0R5NGpNYWx5YkhlQTBJ?=
 =?utf-8?B?Mk5Qek5TRG5aaVgrbXc2R0phbi9XMVNtR0N1S3FxclVrUE1RaWdMaHIydHRY?=
 =?utf-8?B?ZnFjcWFXeUlVWEZ1bE8rcVZkODAxb3BXaDhyRlRzTlZZeXdPOFM5dnFHVDhJ?=
 =?utf-8?Q?3FXFkkMDV70lO5Mi1mDtWYL5F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0838a2-8816-45ed-9cd8-08dd5b3552b8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:57:53.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWvKjsce3ARsFiNc1OHP/4xKrJM8yxO6vTrhMp4KVenEQer9LW8ZLXM0iUkodEH0ZAHoIIRwOI6vEl7pBQ7lpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360

On 3/4/2025 4:02 PM, Qasim Ijaz wrote:
> External email: Use caution opening links or attachments
>
>
> In function create_ib_ah() the following line attempts
> to left shift the return value of mlx5r_ib_rate() by 4
> and store it in the stat_rate_sl member of av:
>
>                  ah->av.stat_rate_sl = (mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr)) << 4);
>
> However the code overlooks the fact that mlx5r_ib_rate()
> may return -EINVAL if the rate passed to it is less than
> IB_RATE_2_5_GBPS or greater than IB_RATE_800_GBPS.
>
> Because of this, the code may invoke undefined behaviour when
> shifting a signed negative value when doing "-EINVAL << 4".
>
> To fix this check for errors before assigning stat_rate_sl and
> propagate any error value to the callers.
>
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> Fixes: c534ffda781f ("RDMA/mlx5: Fix AH static rate parsing")
> Cc: stable@vger.kernel.org

Thanks for fixing this , looks good to me.

Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>

> ---
>   drivers/infiniband/hw/mlx5/ah.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
> index 99036afb3aef..6bccd9ce4538 100644
> --- a/drivers/infiniband/hw/mlx5/ah.c
> +++ b/drivers/infiniband/hw/mlx5/ah.c
> @@ -50,11 +50,12 @@ static __be16 mlx5_ah_get_udp_sport(const struct mlx5_ib_dev *dev,
>          return sport;
>   }
>
> -static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
> +static int create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
>                           struct rdma_ah_init_attr *init_attr)
>   {
>          struct rdma_ah_attr *ah_attr = init_attr->ah_attr;
>          enum ib_gid_type gid_type;
> +       int rate_val;
>
>          if (rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH) {
>                  const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
> @@ -67,8 +68,10 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
>                  ah->av.tclass = grh->traffic_class;
>          }
>
> -       ah->av.stat_rate_sl =
> -               (mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr)) << 4);
> +       rate_val = mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr));
> +       if (rate_val < 0)
> +               return rate_val;
> +       ah->av.stat_rate_sl = rate_val << 4;
>
>          if (ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) {
>                  if (init_attr->xmit_slave)
> @@ -89,6 +92,8 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
>                  ah->av.fl_mlid = rdma_ah_get_path_bits(ah_attr) & 0x7f;
>                  ah->av.stat_rate_sl |= (rdma_ah_get_sl(ah_attr) & 0xf);
>          }
> +
> +       return 0;
>   }
>
>   int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
> @@ -99,6 +104,7 @@ int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
>          struct mlx5_ib_ah *ah = to_mah(ibah);
>          struct mlx5_ib_dev *dev = to_mdev(ibah->device);
>          enum rdma_ah_attr_type ah_type = ah_attr->type;
> +       int ret;
>
>          if ((ah_type == RDMA_AH_ATTR_TYPE_ROCE) &&
>              !(rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH))
> @@ -121,7 +127,10 @@ int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
>                          return err;
>          }
>
> -       create_ib_ah(dev, ah, init_attr);
> +       ret = create_ib_ah(dev, ah, init_attr);
> +       if (ret)
> +               return ret;
> +
>          return 0;
>   }
>
> --
> 2.39.5
>
>

