Return-Path: <linux-rdma+bounces-9263-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B64A80FAF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306DD8A5A22
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC4E22A818;
	Tue,  8 Apr 2025 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P6+qgA2j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CEC224252;
	Tue,  8 Apr 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125399; cv=fail; b=uxiXd4uTxCCXH56VwOiHHXXBmuMtOQHC/M8Zv5R9rsyMy1sMxLnjZ91+HRXaxz900JaN/nD9m9cNJq2w8KiPKzf/UCQrUuJK1xIrhBM41Ry363TdmuMgmprihBkpcx2GUeFwlwfTSVLdxdEcVgcXQMQWub8LgWpnh0ohveORJE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125399; c=relaxed/simple;
	bh=+Bi2wmUMfHzCz0iccwsXxLx7xBHqadP2Uq5pZHeOVdc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mJPx1Fas1l67OP9SvRlzSpTRFu/H5ip3+yGtoAj2XMInDJKdON3yJg5LuzfSwNskA2iv2bmkHEOOXsGOjcnGRFi/0iMseFmvi/lgQHa8IYJCWNo8ZpYUYRsUh6jQr+6Da4m+D+NV/+noYvIVBLH+SRKfaZLW2xIyfD8BefFrtZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P6+qgA2j; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaDbxarhkWYXSz6h0HC+sH4DT4Mo+sB+biftEhssoSPOXUUxj3u+L3FNc8qK6+RHwq21ejzk3se1yYbd3yU82OJgISBkiMyAgztN2KYgSXzDBPfym0lddu6fIqNLNQt2WPGSGZ+40IuUCPjjP7z4AZ6TquPOSdbfGUS+RmDTS4nWqj9POJfiv/ai0+xCNnyNypYGWLMolQFMfHfdTEmLtun1wFZp6rQwbR7yfu5zmzKll99ayH2obxRMgF2HFftZNnPo6Y/+8hKP3llhtVT9Bv1TDhUqnDCwJL1UNwJxBqX6qpEeoOYs4zRF8wxa9nbUiOmYTEV52HGQMYwu66QvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7ZC9FNCurL25DbhwFhrSaZiuWtpBPrLFlGd2DgFNYI=;
 b=vRvuq+DcaE0HQ4WpmujpoJGRvuV3HyE1wpSq80jz2i4k+/qDutW1u8Caf2K5/tl/iY/GqyK8FBp8ddEFf//4w5I7hyqK1XN7iQxJQ/PgLnXnCYIQt4pdvA4cAFnCVrxnm4t9bvj04Lgeh7+ruSNT5abo0RW/tuk5+dMQtJJNOO+nsMZo3y4UHSulzJGJoM42t4wZFznmVJ8IbFZ+4wFEYOTmtksSic2i6MuXs2PaK4UKAUdOLULvMdTS11324gPS4/1IQS99jKzAVDnZ+da5sNKQXX+/7JOc9qRMeqz80BZvAIS0bdN/WwG/bRqSmMuMa8OKHPZ4V37OjdAFq73MxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7ZC9FNCurL25DbhwFhrSaZiuWtpBPrLFlGd2DgFNYI=;
 b=P6+qgA2jTboBHjuRF7cYmN/v/RMR650/QRoREr0EBwAcxhB9XS4w7ut4LpefWdGAsjnNhr1T/8rKDioUUj4ni/UgAQzVO9ytp8q6Vk+PRGCFogFc0YOKeynim8bwJuHalH+GySiG1dIcTqvG1XfmsEMYl7qccarwuAV9YWqDpOFV26a3qTuQy1OYPSEiuZ0kTzNAhEWVLcvqxmdXv0O+5QvOrgXmgpfE/fWl14NlNFF4dRRYFyJnGGk6dL0Pxbi6QSIak5RoRs+AiKM1yc5NbioBw8EifB727mmRHyBpyPAReswuasJO61NBBJDFhZMozNjyNTCNJpoeMhlHg7uorA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 15:16:34 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 15:16:34 +0000
Message-ID: <8948a9d5-0b0d-4df7-9958-dc6f8f300e2f@nvidia.com>
Date: Tue, 8 Apr 2025 18:16:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] net/mlx5e: fix potential null dereference in
 mlx5e_tc_nic_create_miss_table
To: Charles Han <hanchunchao@inspur.com>,
 Tariq Toukan <ttoukan.linux@gmail.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lariel@nvidia.com, paulb@nvidia.com,
 maord@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <9ae1228039dcba4ff24853ac72410ad67-4-25gmail.com@g.corp-email.com>
 <2bfd9684-7ef0-40b0-b35d-abb0a3453935@gmail.com>
 <Z_TK3uIIlJ5y3fWy@locahost.localdomain>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <Z_TK3uIIlJ5y3fWy@locahost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 336ccc93-4d4b-42ff-1b84-08dd76b0596c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXB4TGZCUUlvaCt6QXlnZHpVVlZPbjU2aE5JTmNRTXN1SkRRVWNJNWxCUVlv?=
 =?utf-8?B?YmwzL3YvcTY5SUI4dlR3ckNOZ1BkMHB0Ui8veUFwRWJzekdjRVkvL0RCUGJZ?=
 =?utf-8?B?dTM4ZzZ5UU9meHJGV1JxeVFOdlJjL1g5anhmL2tUOWQvQ0M5NXI5RHdETmNN?=
 =?utf-8?B?RnB1MllNdXA2YUJha2YxNlVSa2FjenFacjhObDlKOUU1Y3VnZ0dJcWtzZTV5?=
 =?utf-8?B?WERuQWNaQzlYQ0VIa2t6Vk1BWXE5VllQSDg0OHdnU2ppU05qWm5JUWFPWWIr?=
 =?utf-8?B?M2lJL3J1SXFReHlkQUp4emllZWlJYUtQNTBqc1MxZDFxYVA3dEJYNVVnbzVP?=
 =?utf-8?B?UGw1TjcreWthcGxOMENpR0pIdG5GRlhhOXdybURNQ3NvUkVNMjM2UE9JN29o?=
 =?utf-8?B?eEpRRFU4VVB1VWE0U3FGTlJLYk5reVQwdmE5aEhaUkF4R1NYeW1wZmN3TThr?=
 =?utf-8?B?VXJXQ0pITVNUS1QyQVlQaU1MQ1N6dVdac3VURVBySUxsdWx4ZTdpVlFOY25z?=
 =?utf-8?B?UE15U1Z5OVRHZGh4YytBa25jV2VYYkNNcndkSXp2NDhRZ2lKYXJsRmlDMi9P?=
 =?utf-8?B?Y0hXaGZtck5VWFdESE01STdYVGhKZGp2b1puZk1idlJ5SXhPYWhXTktMNUNM?=
 =?utf-8?B?d3NrWVI5elhtVEdGZDdIekNXUE1va3p4OXF5ODBQckdkenJVTVY4QSs1MkR5?=
 =?utf-8?B?QlJwT2EyWWhETHRGRUV4MDd0QmcrSmZJSHlpd2ZOZUVJcCtSRFhrbmJCbXUw?=
 =?utf-8?B?S3Ewa2ZvK0pCSDViVFR1NjgxZGJFYXhWOGlBenVmWkFJSVRkeGtWNWx1K3NB?=
 =?utf-8?B?cEZWSXZlS3BjUDVDbkRkeXc3ckpPRlQzV2VaR2pidGVQQTBvS1duYURnakVG?=
 =?utf-8?B?VWUzc1dCeDBhNDM1RTVSSlBWYmU1eGFHVFZ5UUY2dTE3ZUhwTCtLd1BKN0h2?=
 =?utf-8?B?OWU1ZU9TeGpaU2RBMjlhMFNNWWpaOGlzTUlraExwZjhiYXBwbjFxVDBWdDlF?=
 =?utf-8?B?SlVETzgwWG5xNVJvSU9nWEIwMzZJRXhoWGVGZjVKb1pVYm5xYURsS3VWUEU1?=
 =?utf-8?B?R21SbWZuNXRIRTFJU0kxRFY5OEd4Q2RTMjNKYWFmWjhKYVEwTlUrd0RGZndm?=
 =?utf-8?B?TlNTZnNIMWNKL0pPc2JCaHU1cWN5OWNGVURUaXRFeitYdEdJclRESVBMRU5s?=
 =?utf-8?B?ald2Y0JsODlVdVQ3TmVHRUw3b2k2QTc3NEpib1ozc1JkWjFGRklyTDZDZmlU?=
 =?utf-8?B?K3BROTBiUXgvTE1sZlpITGtUMUQ4cTJ1T1FlU2QvVWs5M2lrV2s1bFBPRGE0?=
 =?utf-8?B?TDd3eXkwWkxyNUZmK0NUVEMwVVR0VE5lQkdYRVoyMzVvNnA2aG15NnM4MnpR?=
 =?utf-8?B?QlVOQXFkbUZWUDlrdlU0VGJuR1dmYXU5MzNkUUpQSkJwaDFQZ3pNaUtvR002?=
 =?utf-8?B?WVpPcFMwazlReTVBUHNQZzA0cUQ0TW5UMWF5K0RmMzhkclMxbE9rWlNrN1k2?=
 =?utf-8?B?dVl3K0xjZGp3dHF0VG4zdXZoOTRQUDN0eXdaSG5hOFQzVWc5VGFrSDh2WVRI?=
 =?utf-8?B?a3NjS0wwTitaZ2tWU2ZRQUVwbW5vTTgrQW40MVBVbWJJRmJhSVRnRW9VYVVm?=
 =?utf-8?B?ODlKRko3MzNETlB3ZVRkWm9YU0UzSzRuV0VoRHNNc0ZEUHNTZzBlNHFHQXBn?=
 =?utf-8?B?T1lqbzQ4OWpFbnRCUm5QVjBzbjJJRG5ndE5IU25GRXpWL25kbEZxbTE1bFZX?=
 =?utf-8?B?Z09CZW1mOXp5aW5nUGVTZUZFWGZSbXpCUTV1MWFHYWJiYUtNeXk3Y1RwQ3lD?=
 =?utf-8?B?MWJYUzQ5TWRkamI2SUxlOTNoQUxpd0xKU0h4VWNqTEZqeE8rbjNkTjZZUHFy?=
 =?utf-8?Q?uAXCAVT3Vz71C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2N2ZDI0ZVRGdTZjVTV3Z3U3Y3F0R1ZTRGdvOVRyTlRNZER4U0xrTXZUMlpV?=
 =?utf-8?B?VUhNbDlLOS8walB3RkxlVWMrRVhNbWRHOHBNN3U2MEVYTlYxVDE2MlR4OFRK?=
 =?utf-8?B?a1puV1Bic29hQ3gvZjN6NHE2OEhpWUhnbjRiaFlJK0RTVUh6Rmp0ZFV0RFJl?=
 =?utf-8?B?RGI3SVg2a0VZcmhyb2kySzZvZVFDVHZXVEd2bTZHRE9NWlEwNDFSaWtXQzJx?=
 =?utf-8?B?OGdNekJQSS9qRkdOWkc3dW1ZZUdCYmx0VmxKYnFLcjIrQStqbm5MWXFhRjJs?=
 =?utf-8?B?OEM3OUk2ang3bTViTWNGQ1R0dVNRbXkyY1FiQTI5R0RuMUdVb2tVd2ZwbzBC?=
 =?utf-8?B?VVFCU2NRais3dkh2OHVHQU1ZeVNmUDRjRmRua25uNHpXOVBaWXp6Rmg3THJv?=
 =?utf-8?B?R0xrTnVIczlZRlJiUDh0SmU3TDVmdnpNWThJeEpxdFBLM2p3M25DMXkvamY4?=
 =?utf-8?B?MmcrSXZNRmlJN05jRWFBRTEyUVRWcDdSZ2R2NjVBcGVrU0R2c2tRR0FoTVhN?=
 =?utf-8?B?TU5VbFJ5Q01PYno1YmpTSnVlSVl0eW5CQ2R2ZmprVVBBbE1FRkRidlRuSGsv?=
 =?utf-8?B?R2gzaWdFcEZ4Mmp6T040VDFyc1RvNzk1NEkzSldLZXBGV05kN21leGhjMW9B?=
 =?utf-8?B?NEtRSHRrNkhiT3pLZW5XV2VvZitmazVUVURUQmx6V1VYVjRvMENQdUtFSHBw?=
 =?utf-8?B?dTNyYkNzV1lxbmhxTTNZOWpjMjFVQmswcFB2MnRzR3VKR1RTWlMwY0UzMWZo?=
 =?utf-8?B?OEF3MEkyTVV5TzB2a0plRkJlQUw0Mk1sYm92YVFaYm5wR0szOFRmSUkxQmN0?=
 =?utf-8?B?bGFJMjV6NHMzSTRUSUtNMWswcmgwdURESFJYUVdMRVN0ajVFUDFLWnR1b3FI?=
 =?utf-8?B?em9hUE5iWkRzN3U2THd5b3RTWXg2VVVUVEVQM1puSlkvWHBXVFppNmEyT1VV?=
 =?utf-8?B?enpsdzYrZWMwbEFiZm1UaXhmOXlMWU1aQzQwUEVUVXVRc2tFSlVQWGZsZTF3?=
 =?utf-8?B?SUlYUkF5SW9MSE01UWV3ZFQ1ZW5TbVFrQjJXWUxhRjRDSjVhOFJZdnd1TjRK?=
 =?utf-8?B?OGo5RFN3anFUMjlDMXpTTGNOUEg4UGxmaVlOaUlLMGc5Z2hNV1V5M0NXUk9z?=
 =?utf-8?B?NjkwUURMSkFqSWNxbzIxa2dRVE92aS8ybzZJZjB2SU1BSU9SeU9Wd2ZsUE9m?=
 =?utf-8?B?RjIyczQ0MitGTXJwQk03S0xXbVNreEtzK3RKeGlZVGFmV1JWbVgvNlBiY2dp?=
 =?utf-8?B?QXppNTZFQWZIY21XdlJOYWpsTlovREpIWFVtcmxadkNVdXcyN0ZqcUs4NjdG?=
 =?utf-8?B?T2JQSVBvYmtzOFdTdHlhbUJ1NjN2Y0lFUGlmNisvSXZxMThBS3A2SUJVV2xt?=
 =?utf-8?B?THhsR1JRRy93LytwUXBuY1UzS1c0VXJhcVN1Vk10V0g4eUxIeU1KbUxuY0tr?=
 =?utf-8?B?OHo5dHo3Y2ltaVFVelNtbm5DaGFhaVgwMFZxTXRWR1ZDUlcvQzhEemFJeUhs?=
 =?utf-8?B?dWZwZUk1YW5aV0IzSDFTandNR3M5c1BmK0dVZEJNdDhPeUpGVnUxbGs5ZCt4?=
 =?utf-8?B?YXpMQUR4RXE3QlZRa0RqV0YzUk1CNDRDM2pQRGI4d3lBKzJzb01NWnBYWkps?=
 =?utf-8?B?K0lvbVdnaGtJbkI5QWVIMW9zYnpLVStqclRlQ3ZoblNXaGQ4NXZOaVdRWnpO?=
 =?utf-8?B?MUVJeWRMZzJWZC9MVkdGaFF2UHJycHpVSVZGTUJHZDI1QmZKWUk0bEduVFlE?=
 =?utf-8?B?NU9xWXZLRm1Kb3V3ODh1MHVoZUxBNkZxcXdzR201Sk5tZmx2MXJNQWg5UVd2?=
 =?utf-8?B?RVpGWFF2QlRLU011eTR1bFhPdlVXVWJINU1JYmNWK3l0NGs5UjM5RmNYdDFO?=
 =?utf-8?B?Qkw3NG01NU9MWTFxdG0rMFdiQ0h1VE5CTUF4VEFKNWIvWTFaeC9wNW5RWTJ1?=
 =?utf-8?B?NkRwdjhyMFlnMUJyWm1CSjEzcW9WRFovL3BUT0d3MUl0aklQcm9FNU1mRlBz?=
 =?utf-8?B?QVZPdzhyQ29wTCtZMy9vTGZudUphWEU5UFpQcXpScEVqS2JzUi9mRlA1WkR5?=
 =?utf-8?B?a3dGOXpyNlcrVFdWSm5DNVpCaytrQlhWOTNjeEYzcVp4YWxxckFJQlhlZWwz?=
 =?utf-8?Q?4YVvUm/BTctJiKBCoOFnOA0kb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336ccc93-4d4b-42ff-1b84-08dd76b0596c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 15:16:34.4821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ln8DUoKYiApAlDzLmaE29iyzIAyWnb/tzmUprrlm8Ms8I5NzRfMGCZtVHZN8TaWB9H1N9IsjimBhCEu+wEFRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401



On 08/04/2025 10:06, Charles Han wrote:
> On Mon, Apr 07, 2025 at 12:29:22PM +0300, Tariq Toukan wrote:
>>
>>
>> On 07/04/2025 10:20, Charles Han wrote:
>>> mlx5_get_flow_namespace() may return a NULL pointer, dereferencing it
>>> without NULL check may lead to NULL dereference.
>>> Add a NULL check for ns.
>>>
>>> Fixes: 66cb64e292d2 ("net/mlx5e: TC NIC mode, fix tc chains miss table")
>>> Signed-off-by: Charles Han <hanchunchao@inspur.com>
>>> ---
>>>   drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>>> index 9ba99609999f..c2f23ac95c3d 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>>> @@ -5216,6 +5216,10 @@ static int mlx5e_tc_nic_create_miss_table(struct mlx5e_priv *priv)
>>>   	ft_attr.level = MLX5E_TC_MISS_LEVEL;
>>>   	ft_attr.prio = 0;
>>>   	ns = mlx5_get_flow_namespace(priv->mdev, MLX5_FLOW_NAMESPACE_KERNEL);
>>> +	if (!ns) {
>>> +		netdev_err(priv->mdev, "Failed to get flow namespace\n");
>>> +		return -EOPNOTSUPP;
>>> +	}
>>>   	*ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
>>>   	if (IS_ERR(*ft)) {
>>
>> Same question here, did it fail for you, or just saw it while reading the
>> code?
> I just saw it while reading the code.
> I've been working on code vulnerability scanning recently.
> 

I don't believe this scenario can actually occur.
The function mlx5e_tc_nic_init() is called from mlx5e_init_nic_rx(),
and before that, we invoke mlx5e_create_flow_steering().

In mlx5e_create_flow_steering(), the first operation is:

<snip>
int mlx5e_create_flow_steering(struct mlx5e_flow_steering *fs,
                               struct mlx5e_rx_res *rx_res,
                               const struct mlx5e_profile *profile,
                               struct net_device *netdev)
{
        struct mlx5_flow_namespace *ns = mlx5_get_flow_namespace(fs->mdev,
                                                                 MLX5_FLOW_NAMESPACE_KERNEL);
        int err;

        if (!ns)
                return -EOPNOTSUPP;
</snip>

Note that MLX5_FLOW_NAMESPACE_KERNEL is allocated and initialized at
driver startup (as most/all namespaces), and it does not
change dynamically.

If mlx5e_create_flow_steering() fails, it indicates that
something fundamental isn't functioning correctly, and we
never proceed to the more advanced functionality (like tc).

Mark


