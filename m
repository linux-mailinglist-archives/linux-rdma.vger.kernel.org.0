Return-Path: <linux-rdma+bounces-7657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4860A3142B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 19:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B597A12CC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DC82512CC;
	Tue, 11 Feb 2025 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XjFcI5jC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52203BB54;
	Tue, 11 Feb 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299005; cv=fail; b=rhTPkQMi3Z62og/j4Q5LumYMaWm+CBTPrytT8Qels2Swu4r1FrM7hmfAUnH6yFXyoQVh60TVNpViq5WM4Ob4bnGcEjzzQ7/kaoXtYKuk99vMIl3QE72qL8FBAoVXVrCfUUV6468FQ/JSI2XjD0F9decevgY47Z6ZB6uYK+NvxmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299005; c=relaxed/simple;
	bh=WcwfMrP3/+FIr5ys2G+JpzadWKA71N2qOuzU18i7Vww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u+GwXLOdmWs0kQ94ZwgnXyYVX5w9K7JU2obupA5AtxlsUbU58YisRfQsbMyFNAK4WZbg5Q7ZhVxtMOv2okSj+GUfC9oqxC0XG0e6CkfOAwm2+8oClfvVRAVVTa7vM0sGXAAVNExMSWvJe3Mm9naMJxtEsL1xnMNTVegHhrrrUBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XjFcI5jC; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohwG7LVgvvXm6hyIEYZWBAGAdDv5Y2shB/zfnjQGv21XYyS1F/pG3unBGH1JAK/vnuE7cEOMhW/ZIjYXt2yZHJZULII+j5TLkpBeysWQoL02rzs23XB17PfAYfH5KKTPUvMfDGHeO0Q2pUKnZcWsAKBbu9qCc2PdIDVwwFWmh5v7OUN/mbot/K8j/wbTtHODvrGBIKGc1EPK/SWqq4xbukbJJDqhBiFENj1JZEjf0xxbY1QhnNy+voG4//hQCYsk2tj+RkhgOU64aHtvJl95RMFJ/Pw4dR3KVzeUSx4DSWFKkSWXCeIxbXPdl+a6ZUWH0c0oLdxp57V5Tig0fXIbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S1V2QSiOsSSJOAAbm4cBA41rCRMuWsQsng6lUs1b68=;
 b=Zoem67qkP8FfiDq14w92TZ5SgbFVWalpG7dgf8PP+YyxQ8lzHJ9ngN7Ipc7/gBcWdyowBxpMQFqOvVxA3hq0IZQaUhdNjHSBmSP1G/8RqRuwOBZMamxE34PtTOCTqxUzjEp/PQrbmjMDNGzZvYWmUz1jedd571YW7tcNQuRYPBy9doyHacqSz7/ZEfB+W9nefVHkkgWlnA3eMaFmOrKUK3HlWeskCFG+voqc+egGiAWOw+0RC0RvNFnfxhMyGu5jNJffBhW8gWXQao2+chap2XzCfvGZHfwGm+tbFbRI47T+wqONohk2DLQ5iFtV8TGjtPPDIyLR7qO7G6F3tyBt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S1V2QSiOsSSJOAAbm4cBA41rCRMuWsQsng6lUs1b68=;
 b=XjFcI5jCxdkgkH27iF/hBCokIPoatin+UT22W7jQJCzhVyXo2CkenBaeKfSIlS7DlWkpSWej0aV0G0KWpdwef+D9izpI7qStgtipa6SglKhJF8bhqRbgZ3zKFRqlD5pfTdISyM4s/T0Kx5IWxbKYJFy8nDHWcq55yWXiFuztFdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.16; Tue, 11 Feb 2025 18:36:40 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 18:36:40 +0000
Message-ID: <b0395452-dc56-414d-950c-9d0c68cf0f4a@amd.com>
Date: Tue, 11 Feb 2025 10:36:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
To: Leon Romanovsky <leon@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org>
 <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org> <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org> <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org> <20250211075553.GF17863@unreal>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250211075553.GF17863@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: c5485e2c-2205-462e-82c4-08dd4acb0683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1FNVHkrS1dZdmx6aHliVEI1azdOZ0NHQlBPb3pUanBGZ2I5M3F0bk1WZEpC?=
 =?utf-8?B?T3ZpYVhnMmVjN0Vland3bDFCOGcyZVJQMlh3MEROczQ5NWFrSGxpQ0w1aVBj?=
 =?utf-8?B?eG42NHpraVpJbDVpb0x2Nncyb0lhN29NMzRiWU9zejdXK3hQbXk5ZCsxWHZC?=
 =?utf-8?B?UVUxWGVCNXF3ay9ZVmNHdDR6L3k4OStZdldrdDFyTHRLZWo0L0VFd0VRZUp4?=
 =?utf-8?B?cWdPaVRwcXErK0ZVYXJwODhXUTZXdGR1Y0VWbTMxTFQ3Yk9Zakg3NTBLMGJZ?=
 =?utf-8?B?VkNXdzdtakcwc2RGMHdjeE5hU2tPa0NzYWtqY3NMekN0OTU4NldqU3lFb3BG?=
 =?utf-8?B?NzV3STBtbVVEOUcyOTZVVWQycmxWbjloVEVEbUpZTGt4UkxSSGVCaEcvNXN6?=
 =?utf-8?B?akl5MlJpUk5BNlVkWnlOSHhaZ05VbUJ5RVVCa3NpMTRCditwQi94Y0J1RTNQ?=
 =?utf-8?B?WXF0TktuQ25GQytEdnR3OGdBT0x1V2s5dlEvVTdxUk1KRHZMWDc0VG8yaDJr?=
 =?utf-8?B?c1hSNkxFTS9mYTlJZVZrMy9yZXhCOTl5NjhnRlBsaWVxbDY4ODkwamhNOUY3?=
 =?utf-8?B?U0FBMGdOSTU3YW9DNnc5YTlzSUxrbHNzcFRmNWticmRVMFIxZlcrMVM5NG03?=
 =?utf-8?B?Z3lHR0dsaG9aZGJ6T2hpbDBKZVdjQ3hLaU1aZHd5ZkNwQnNIRmVqSzJleUY3?=
 =?utf-8?B?Z3BxY3dWb01Cc01GYkhMc2tBSDN3dnh3aWhqbXY3NXZwTFQxOG5iVG8yODVJ?=
 =?utf-8?B?MUNjcHVvNjB2SUNQNTVZZDgrMTJubGhBQzBjUUFsdFhQMmwvUEJoVm9sdXhB?=
 =?utf-8?B?Tk9ncDA1RkdibVRyOFR1UTJlYTNoangybmMyS1pBYmR1SnBEU2dVWWowM3FV?=
 =?utf-8?B?bFBCelBFQ2ZPQWFBUUpCNGVFVDdjRm9SWStJUzJ0WWF3ZjM0bEZ1ZXFpVTJs?=
 =?utf-8?B?OHVUOVR4eWxBS1hnZzc5eWdLUjgvaGF0TStoQjcvZE9yc0MyV2EyeEJ2MzYz?=
 =?utf-8?B?MS9TSk1vcWJ5U3hIK2JjMlVZY3gwYXFaQlpKanlPZXdQSnRRbjFubGxXdU44?=
 =?utf-8?B?bEFNdks5RjZtU1luMVlQUFMzdHFpK3FjRkw1ZWErZmNoNnhkOHNhMUpxTUFN?=
 =?utf-8?B?WkNxOG0xa3NRcytOYSs3SmxpVVhYak5KcElkRS9TQm5tVWcvcGkydGYwNEY5?=
 =?utf-8?B?UWNKeTNsVjB6RFdQMHdIb2w0ODlmY3FzTTR1bDlGc3hySGc1RWlwczY2K3Fv?=
 =?utf-8?B?OUJqYWZDeHl4Z1g2dVJZVkEvOHNFVWxRa2JnQmp0RkZ3S3VBMmhwbDh6WnNH?=
 =?utf-8?B?ZnZ6cU1OMVNWRkhra2RqM1FQQWlEdU50VFYvUFNXT0lhTE1pVWQ5TWdYVmpN?=
 =?utf-8?B?SHhkYytYcmQrMURWV3lJNHM0cmh2WnVVRG83aWFrUlNaL3JZUVpaUXYxM1FQ?=
 =?utf-8?B?bnhnN3Zrd3RzOW5ERVJLWTE3Mk1rNjh0WGRLSlBpQjROUWdQaVNLSkJkQThn?=
 =?utf-8?B?TlpPMVBnRWhqRStKam9kd0QzQkZHV2lzbk8rTGg0ei92RU9ZMDM1L0h1VGZt?=
 =?utf-8?B?bFIwUUtydWxoYXlWSERFQUl1cW96cDFSZ3B2WitQVXJTbmZZRjNsK1VqcDh3?=
 =?utf-8?B?dzRRTVZzS0ZvMmJHMUZYSGNFYnNOQTFZUm0vTkZSV1JvcERTL1lIR29MUkRs?=
 =?utf-8?B?Y25tVDFKdVEwN0dCVWFqUmxGMFUwcStodm9MRjhpalZZMVU0d0tramJVS1Bi?=
 =?utf-8?B?c0NhMFRkcmk1SG5zZ2dTcUYvakdXV0NNT2JjQmQ4djZtMWE2cjJvMGxvRFp0?=
 =?utf-8?B?OG5DSS9rS1FUWnJMaHlxZkw0SE91c1hMK1p3VzlrVGxTRXFxU3A0TC9QeWRy?=
 =?utf-8?Q?UJdRDm4ApH0w2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUl6TGxGY01XenpjVEllWTVMTUIxN0VqcnlXMGl6cTExZnN5VWVDWEJhd2N5?=
 =?utf-8?B?OW1DRkROeS96TXZPRjFhdHBNdTdIaS9LdjBCM25kSTdZL05PSUMwUFRNYktM?=
 =?utf-8?B?R2RldnFWdVhSdGtEaVhUVVh6elB5eURMaVZuSHk3RHR5ZWhFRi9vNXhPeVBL?=
 =?utf-8?B?U2t5elV5bTdVMjREcXQ3MjRpSlJvNG5yeHlSNURMVFZ5LzgrV0wvNmJGMmFo?=
 =?utf-8?B?QSs1TWdTTkZKUTJ1MkxqcExaWko0SG9EakhuYS8wUjl6b2V0OCsrNmcxUUgy?=
 =?utf-8?B?YkxaQnNsbUc4dGRmR2E2NHJheU1zcTU3enJ4aS9WZFFLc0UvSVZhYndkOHhj?=
 =?utf-8?B?azExa3d2RkFGdk5uMTN4YmszSkx2Vm01dGRCUERET2lkRWVWaTRzaWVJeGFP?=
 =?utf-8?B?b3E2MTBYaHFPeEFGMkdxK3piZ2xWSmVOcXc4TlJBeCt6MFhsWFhjL3JqRHo4?=
 =?utf-8?B?aFRkUjAyZHBqazM1QkMvOS9xYkpJWUZDWW1qa0RlT0hxSzd2YnNVNDMyNElQ?=
 =?utf-8?B?NFRRVlpMMTlDZ2FYRXBuVFdvRWo4MEhDdTYzWUpXNzB6WVpvTytsN1BZVjlR?=
 =?utf-8?B?b3B4YkRqM05hTmU1TUVGUjRMc3NRVTFLOE1McSswVmNycElXcEpFdG80eTh5?=
 =?utf-8?B?U25La0pOWWFUWGEwZ3R1M0ppSGRCcjZXa0RzVTZFaTNBZVJsODlLeGJOUUJo?=
 =?utf-8?B?djY0WkFlZTRESk5Nb29JY3I5d3Vyb3hNdkQzM3JuWDBzcmFheGkxczNTMksz?=
 =?utf-8?B?Vy9Bak4ycjJ4NHFKeTlmOFFvYTBsSWVQWU9RNFJ2ZTNHQWt4U081OGRjWlBC?=
 =?utf-8?B?SUFmQ05mbVF1RkVKMEJ0YytZNjhrc2l4UXBnTXpHSkl2TnZFT2JWK0VOaUtC?=
 =?utf-8?B?cVFEbm52ME94OXArTXlsTCsrSUxUTEZmMXZSd2J3MFdxTnRuZjV3WkQ1aEpl?=
 =?utf-8?B?UVJMYzcvMmVzckRZNy9lL1lSSEY0Y3pZVHNxL2VWS25KYVRhSjRsQ1ZnV01h?=
 =?utf-8?B?Ry8xekhOYVhCY0NlV0xxRGtyc25sY01yYjhjb012NTdIL2drTlRwN2s5cFg5?=
 =?utf-8?B?cG9FZmdMSjllblBFcWFyMWt6dzEzTnA3bHp6d2pIeFRoeGg3K3JlZTVOd2x6?=
 =?utf-8?B?VVpHV2ljazMrV1paMjZ0ZlNkbk5tK0ladGhNeS94K3dNRkdJRGhVRU85QXN6?=
 =?utf-8?B?ZkZhMGNnSzAzeFRTTHg1SmhOTEg4SWdPdkp1NGN5T256Qnh5MDFmUFd3Y2x5?=
 =?utf-8?B?ZVZNUFM5QzNxaFZKYWhiWm9ISkJJQktjbjc4dWRIdlNOc0ExU2JOOUY4N1kw?=
 =?utf-8?B?aVNkZEtBbEdQeXFqcDlVWi81eFFDSDdYNW1JSVd2SzJ0TEhFM1B5S2Zicmdx?=
 =?utf-8?B?cFVCVnpYSmJoWW1HSWpNN3U5Q1U3c2pxOWh1TEh2cGJ4a0ZUdXVVNmdXdW1o?=
 =?utf-8?B?dUM2b3FyMWE4ZVMvUVlkWmVOeklpb1pIb1BYcVpJYk9YQW1CRVhsK1hhNmhO?=
 =?utf-8?B?ZDVFRWNpRE5jaHRhcFZlT0V1bUF3UEJRekJzeGVoc3U5MVFXRnBNaHJRcFEw?=
 =?utf-8?B?Mk1yUk5ma0xYN21LL1QrU1M3dzZzRXk5cmw5NVhJYlpOZCtRbTY4ZzFsRno5?=
 =?utf-8?B?c01UMTUwTW4ydXE3MVRKdGdCeDBRSzVZazFkRGJFbGE2WTFoTU5XeUlWeTFi?=
 =?utf-8?B?Sk4rUG5vdmxZTllZdWphNElGcXY0SDFQZG5Kd0tRUHlCTy9GRmtmcFArWE1k?=
 =?utf-8?B?ZGJPeGlIRmNzNkRyLy9VdG5mWGx2NXp0UTY3WVJ6SFkvQ1RIKzFPRldDaUhm?=
 =?utf-8?B?aVJzdDNYbkR2eEpVaFo4ZFdHRHZHMENDQmxnbkwrVXd3Y1NUa21wWGh4eHhq?=
 =?utf-8?B?cTFnemRaUjdrT2pGeUNXOW1obWdIUFpabmQ3WHY0eS9Qb1BCMXJOZzRYT21L?=
 =?utf-8?B?ZmlWVlJiVlFzWmxLZVp6U1BKKzdoTC9sb05iN2ZRaE5Yb084a3hzQ1pldWEy?=
 =?utf-8?B?bnl2L3V5RSt0VXJIaEVlWGUzYi9VdUZ4Tzkwc20zQnNaTW01YzBxQ3hvNnB3?=
 =?utf-8?B?TFV0S0tYVGtqU2RNTHZ4Y09SZkpvMjBpMFo2cUJJS2FNa2hidnMvMDRlOUhR?=
 =?utf-8?Q?W5FtY4M3uZ7W5xdX2vr9W9s06?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5485e2c-2205-462e-82c4-08dd4acb0683
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 18:36:40.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ta2lFLw4vdaSKEh2gFFBiQvXaOVcvYd31skf6JYTo5odM2JnIfQYoofpSFa3zIddkEmRWOpvVnRu8+G2pekXHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590

On 2/10/2025 11:55 PM, Leon Romanovsky wrote:
> 
> On Mon, Feb 10, 2025 at 05:04:23PM -0800, Jakub Kicinski wrote:
>> On Fri, 7 Feb 2025 21:16:47 -0400 Jason Gunthorpe wrote:
>>> On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
>>>
>>>> But if you agree the netdev doesn't need it seems like a fairly
>>>> straightforward way to unblock your progress.
>>>
>>> I'm trying to understand what you are suggesting here.
>>>
>>> We have many scenarios where mlx5_core spawns all kinds of different
>>> devices, including recovery cases where there is no networking at all
>>> and only fwctl. So we can't just discard the aux dev or mlx5_core
>>> triggered setup without breaking scenarios.
>>>
>>> However, you seem to be suggesting that netdev-only configurations (ie
>>> netdev loaded but no rdma loaded) should disable fwctl. Is that the
>>> case? All else would remain the same. It is very ugly but I could see
>>> a technical path to do it, and would consider it if that brings peace.
>>
>> Yes, when RDMA driver is not loaded there should be no access to fwctl.
> 
> There are users mentioned in cover letter, which need FWCTL without RDMA.
> https://lore.kernel.org/all/0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com/
> 
> I want to suggest something different. What about to move all XXX_core
> logic (mlx5_core, bnxt_core, e.t.c.) from netdev to some other dedicated
> place?
> 
> There is no technical need to have PCI/FW logic inside networking stack.
> 
> Thanks

Our pds_core device fits this description as well: it is not an ethernet 
PCI device, but helps manage the FW/HW for Eth and other things that are 
separate PCI functions.  We ended up in the netdev arena because we 
first went in as a support for vDPA VFs.

Should these 'core' devices live in linux-pci land?  Is it possible that 
some 'core' things might be platform devices rather than PCI?

sln


