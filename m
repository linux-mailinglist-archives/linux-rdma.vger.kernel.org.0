Return-Path: <linux-rdma+bounces-5000-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E893497C725
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 11:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5521F244B7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE57519994B;
	Thu, 19 Sep 2024 09:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p0jFId9l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8AFC0C
	for <linux-rdma@vger.kernel.org>; Thu, 19 Sep 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738329; cv=fail; b=aZb+A8YPOZ5OCuXhL9pQTpQY5S/t2ydKd/CcD4xTUqWvIP46qFI7TnZmEZVtalWiKNcQIjaD+Sw/0mTKQY/sUeQWIxnLvXluNejT2brH2MCsx1spaxOOF0oe4QD0X+L5gUpE1KZyhvOWgzBtiuVhbSx0QaVg5mFgJLnNw56EJtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738329; c=relaxed/simple;
	bh=mR0YOtFhEG9DOxHnaIXIdX5JkkPyw5axEqIg8TXzD+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X/f6VJZdsX0xUPlx9AQvkFTRCvG8ZZkpynCdkXK2K2P+dLekUAUg5hmVDVrbryrtnJonopKkYkLkawQGEypeNrHKVyBNlMDId+0ExgqpJ2qCiMlQ3NWForxpfywNORd318yrLFWdLYLsl/SZ1SxLF818LhqUKG12dhjqTdxC5Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p0jFId9l; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e11232NSquI2IvYKIhXLheIdBsi/Xt4NsL9GTi0LW+Gd6avxDMShU8VqUW7/Mrkbd18wCbbVJiirIB3sqtdk8Gwh4bBJMdQOF2UrsESXhqsYVmTR6VMOX2A6BsO4FfNmvu/yI5+9iNeClzLyqPm/KPxxcXEcyvvV0590tntXDC1XK0vScpggoeFYuXSTyvHJ0+D/VxrcExLa3DNP2zpOv5gLsFB8zE2W6UODfk5TwyhegNaeqjtyhpDjCQ3yW79typjHRa74B5hnFNnM6SbqjL4WpmpGoz9OpBOgQZcbtjollyC9u0CxpHyB4wR1tRW28TS0e6N59djToLn4eSFGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0XJ3+lClPXMxAjZ5LAgAILUNHJb4F/4aTMUEHuL4v4=;
 b=ima2TGojHkT7rt2jJU46PJm8tqL9R+wkN0fPogZj9BWD88RPBxXMwSGKQkS0SCeLLiYJSTQM4XR9s/RgfNCfy+VsgaD+2Fi5LHnRLg6pjcu5eqLbJYZAgz2gAl6eQUEjrVJKdjAReqprtNGMg31h/6ugQoA+/VfWkY3Yr9B+WYTTlF5skTqqwp8Y5h1Lw3A+g0lIkOghqdFyDce15LhLt3gqY3L+vB25j4CszUH1ak3njDNuCbUsTgkFRh1DAUeiuGlrB1w9v3vwvL0LSkJYQubTqcmbRWPafexmUd8Tph1wf5002cNq4NvSHjp+HwpeaIiuy/LLdBUTAD/MUKKcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0XJ3+lClPXMxAjZ5LAgAILUNHJb4F/4aTMUEHuL4v4=;
 b=p0jFId9l/0lE4wC4axThlMa00ylDzso9YGIgsYlRDhLIBSld85hM0Xr7Rec1EcDdXyEDo5ICYjikaCttpnjmws1qzsI9kngxW/lGhAJOxD1y9D/8X4EXJ51bNABkPOH0Kp/EBoq4nsZJXkK2LyM1bRQvF5f4JhfyDelAj6LWGmpFRCMzcvLkcFYRQSORQGdZlGMWwr4LMhnwbYiJj0+Paj+z7BWTHMzKo0270DNuB53Ptwtjx/nGZ29qMstb7onslwn4CcK3CdoMLVFF0iqG5ncYlKfIeE+wZdk4iF0q38xKqjAV1Sog5Qdl4tk7sq8r+p+x4KcJGumxSs77W/UrlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 09:32:04 +0000
Received: from PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe]) by PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe%4]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 09:32:00 +0000
Message-ID: <a45b9cfa-f7f0-4ac9-83be-44a035871f35@nvidia.com>
Date: Thu, 19 Sep 2024 12:31:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net/mlx5: HWS, added send engine and context
 handling
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-rdma@vger.kernel.org
References: <e4ebc227-4b25-49bf-9e4c-14b7ea5c6a07@stanley.mountain>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <e4ebc227-4b25-49bf-9e4c-14b7ea5c6a07@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0024.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::13) To PH7PR12MB5903.namprd12.prod.outlook.com
 (2603:10b6:510:1d7::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5903:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6cd136-c8e2-4ef9-0aa8-08dcd88de999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVV0NHFmR1o1blRGSnlUZldGdlZjNWFpK2ZvVzhrYmF0ZzVrNmVkZnpyTEta?=
 =?utf-8?B?bWZveW1aVWZkL0RxNkZjV2h0bjVWL05rRXlPeG9LZGdWMGxvOFcvZGZQWUZt?=
 =?utf-8?B?dHNsYmoxV01SNzF2dnQzUU9JYktmdTdLT2lPRm5UZFgxbTBlWDRKQ295dDZn?=
 =?utf-8?B?cEhsVXJXbWVBZWNHQytqVVAvVThNQnYwNEp5Sis1M1lBRWFqUFkxZjB1ZEtX?=
 =?utf-8?B?WlN2WkZpNHhxNGlWWFN0T0NhUmVwUG1YcWxjRUxmOXA3RzNkWmo0WEczejJx?=
 =?utf-8?B?Sm9ZOXFOOTQ1bllqVFhoYWJpZEw0YXRCMlFyek1KMEMxY2RUZHByNG5OZWs3?=
 =?utf-8?B?YXdCdmY5M0tLL0FUVmlkNHIrVzRWaE1xay9vdnIxUDhMeURITDZxbml1RCs0?=
 =?utf-8?B?SFMwZlg5NlgrZnkya21CS00wZi9nZSsxZDBRUDdWcUxncFBteWkyL3pMNnZB?=
 =?utf-8?B?ZVdla2tTZW02SGtwRFIwMTIreGRxcEJmblhXbUFFbklKZ1ZLc3F6dHgxMjNH?=
 =?utf-8?B?WFlBTnJUU0htUnhCUmZObEw5cnE3aC92SEJMeVMrZ3BnZEkxeFNXdTVDY2hE?=
 =?utf-8?B?SE5jSmw0Ujl5L0I4emZKNHhVMTZCbngwUE9jK0NvWlA5bjQ1akM4aHNhOXg0?=
 =?utf-8?B?bzJOZ01VUlpFUUgwZnJIN01GQk5EZVMxSm1heU42dXBQV0IvSVE3MXRCaTFD?=
 =?utf-8?B?MWJFTkJpcVlZZkdVRDRmTmdXN3JiL1NVbEp2UURDRDZRaHpsMjY5cVppQThN?=
 =?utf-8?B?Nkpwd2t6SFRTOEcrdmxmMGl6UnNoY3FWYjlZcXZjeWFFM1dSNWFDK1ZhaVht?=
 =?utf-8?B?ZTNoYzlETnlXS09XakZIZ0t0UzFraVcxRlFvNkFsbC9wbVcwK2x6MFRIdUY4?=
 =?utf-8?B?YWZTMVM4d1FDeHBiYU1XcjhaZW5vQThFMWJ1MUo4MUE0L2FJYzNzY2xKM3B6?=
 =?utf-8?B?UkZvbjNYWkJicUFsdTdadUIydm14c2dTS1M1WXBEeFpTdEg4VlZxVDFyTllH?=
 =?utf-8?B?emdTelc5QWhBMXhxZnl5aXQ3a0Y1dXlkNlNOSEZWNEcveGFoVk9lYWhwdlcr?=
 =?utf-8?B?ZGFZSERxN2tmZFVVNUpHcTBoUFRXRlZXSWQxY2dVdUR6Y0FmOGRsVkUycHE1?=
 =?utf-8?B?ZkZORGJLZG9BN3hLSm1XRVFEbHdKOXduYlBna1N3NzZXM2w5QXE0SjFLWXNX?=
 =?utf-8?B?cFhwNnJ5NWY1S2RGTDFZSEloVU9Teng4aDVNM3Y1Qmtic1UzVzh6WitQeUl2?=
 =?utf-8?B?UFZwdEppaHlaMzJFR0dadDZ6VFkraHpaR0tvakFhNlBZNnRlTXlkRUkwVUlz?=
 =?utf-8?B?aGtqYVJYeHF5eXFKQ3hLYWFzU3phOTRzd01pVjluR3Q2RjlxZmd4UDVJemFF?=
 =?utf-8?B?T0I4dEpsZlduTFU4Q3ZxQUFNREVHMysxSDVMSlNhbTBRQTdJdUgvQzFkeEJI?=
 =?utf-8?B?RytnQWFBTGgzN0k1QzZ4ajNzNFg5cVlQSzdrTDZSclB2VFJIdUovVVNiRlFm?=
 =?utf-8?B?WHFKU3ZuYWlCM3oxMFZ6V0VhNXNRMHQ1VTVMcVU3YXY2S2FDVEt1UGR2ZnRv?=
 =?utf-8?B?VUVNSHpyWEVINWFyYmRDcC8ySVV0MHFzTEFiaFRmSVpWVUNCRzJ6cGtWT0Nt?=
 =?utf-8?B?MFI4a3FObGFkV28vWndOK1hOckpwa3pPZVZhVmNsd1NnWDZGeDBkWXI2M1Bu?=
 =?utf-8?B?SmJUYytKQkxhSVg3OXBHSG1TZzZSaE9xdEtEQ1hITGxydmR4b0x5bmJkR3VP?=
 =?utf-8?B?TTlxZEN0Mmx1S1BoMHRNZ2huZ0UrSXJzeGtQU3lTUG5sUUxERlkrQmFiMFZC?=
 =?utf-8?B?UnI5OWRjYmdVVHQwTGdCdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5903.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUVhd2lvb0hsRm5nSm9PandZaEJoZ0VWby9JdWNJK0pHcTIzS3VUTXc2TlZk?=
 =?utf-8?B?MS9hZzc4bU1IWFVtTzF4aXJpbkErT0VlOE5VWUJtOENnOHR6SVErVnZMS2Y0?=
 =?utf-8?B?bUhndTBDRllBcStGajN1UnlPL2R2UDJ0Wi9HMytYSDJ0VkFEbFJEK3dQM3Bv?=
 =?utf-8?B?aE92bFB1ZUd1Sm0vS1JRRWpuK09GYnU0ZWJGSkZKSlhUemRxWEdiVnBoeDFF?=
 =?utf-8?B?eDRvdW9PQnMxL1VnbzFqclRocHQ0blRQVXFmVE9KM2VxZjJUL3hGbnFTUENV?=
 =?utf-8?B?aTZnR0tEc2E0VGlaRFF0cldPNnFML2FjcThDWXFKR2pPSXlhTUpjc1NrYjlW?=
 =?utf-8?B?ZDZLMW11MFgrMDI4RUtyWVpOK0k0Y1N2R2pmL3I5UFVBRTBhR3FNa1FUUFJO?=
 =?utf-8?B?dm5lY0RxYk9WTU1UWjdKOE12OHJnRlIzWGpYR2NsQWdTMzB5M09MZmZHMktt?=
 =?utf-8?B?WitmUFZSUG53aFVtTmc0MENPRlJmYlAyS1RZdmhzdXllK2NsVStqQmlZOGdL?=
 =?utf-8?B?V1dIMGtVNDRUZWtpeEQrWm5IaWlsQWhqbENBdzc4b1dOekQrc0VnRTJVNVJI?=
 =?utf-8?B?RFlKbW5LckZuOENFdjZvdXdZOS9tTGE3VWlwS0I4eUdOYTlWNVoxa0ZhT2tj?=
 =?utf-8?B?MmxvVjJZWEhLRE9kdmNYMHNOY1E4aDNoRFYrM293TEFDb1JqU1paWUtKbG5s?=
 =?utf-8?B?eDEvcUxsV2p1MVpvc3NkUWFRbjVsNmVGWTQzZlJRNkdsVURWRlFDMGpMK2h6?=
 =?utf-8?B?UUdNRTdHZjZDWmhERW5zSjI0TGZOVGEzZUtNeWdhaFo1OGFDN1J2MndsSmFC?=
 =?utf-8?B?a2dPTVZsNUhDMGJ4Qkw3Z2puOUtXb0srU3F4aURyeXNqRVdSNkg0b2RucFgr?=
 =?utf-8?B?Y3R2ZGtpQXd0aXlrMDdRSnJ1WXNtc0lJVDVUbjE0TTNwZGdEVmdaSFQvcUlU?=
 =?utf-8?B?TnNLSEVaRXBvTkk0RmRtK09XdUZvL0IvKzBmQ096c3RKUlBIZFdvZU9SbVg1?=
 =?utf-8?B?cFF5VkZ3Ni9KdHV4Y2RzSndTQkQxamRYN2pvT0JaSlZkS0FmQnNTVkNlMDZT?=
 =?utf-8?B?SEJleldaUXltVG1hUW12OFdVc2J5bkFhTFRlK2cyUDZRS0FReXl6WkJSeUlo?=
 =?utf-8?B?MkxlaklxMFlyY0lzbkF4M2RHbmVFaXRNU2o4cDlOdDdPMVF1dTBydGltclll?=
 =?utf-8?B?VjJnMkJJcnN4QmFIS2VPcDMxaVFSU2RIVmJ2NlkzSUVocTJZZ0QySnBiUlNn?=
 =?utf-8?B?MmdlczZJV0ZYN2U2YXROejJTRlJOSWpOcTFsMlJGQ1pCV1pBZGhsTnVFalFT?=
 =?utf-8?B?bzNXUU41V0ZVZ1p5bStrNU5TTW5ZaTVFLzVIc0V5c0FlTTRSNVEvOHdFQmFP?=
 =?utf-8?B?ZUxUZjdPK1Z5OXdSMWYxUW9EbnpWVHR3T254ZmprN0tWTEhpb1hzZUUrNzVu?=
 =?utf-8?B?MSt3eE1nN3h3K0xsUWNTWkFlUnRFZ3BkNS9lWDRsV1Ivek1lQmVrOFFReXUx?=
 =?utf-8?B?dHgzM2JkNUVwVzQwOEtycG5OSlBrMUltZzZIczNveWVEWmFHNXc5WWpKSnl2?=
 =?utf-8?B?SEorbkZsLzIvQ2Rpd2NlcXQ0b0NyQkYvUWJ0RXZMNGkreTNCWUtML3ljL0Zu?=
 =?utf-8?B?Z202NW00am5CU1MwM1p3VjdlRGs0TVgxYmwzUyt6Y3F4c2V4ZlZRb29zZFNy?=
 =?utf-8?B?VnRQWGhrUURrY3daK2M2RVVJT0lLS2hSaks2N0p0OXVYdUdsZ1VqZnJaYjJ3?=
 =?utf-8?B?UFlabzJMVEovYm5pbXJCQkFoekR0bXh6eXovVkdYWm5SNWhkVy9wSUplS3hF?=
 =?utf-8?B?QkdsUjJrUTNKUnZMREx0ai9abERtZzhXNmpqeXdmWW1IZ25aVURDMGRzMU9k?=
 =?utf-8?B?MHc1Q1FLdmhsSVNBOFZMQnVBcE5neGxjVG5hSjRTaFgrT3dTNHpMeDBvcUJX?=
 =?utf-8?B?d2c3RGYwaVlYenZ4dmRUL0ZZMmpxTEtIekN0REJaT2FEWUtnZEhqZ2IzY2Zy?=
 =?utf-8?B?T1RhNStVVHhNMVF2T0p6Y0paNThxc0h1d3AxY1hraWRuV1NtTEd3TEJPWmQ3?=
 =?utf-8?B?MjZEQ2pSNUVCcFFnU3Y3dlBpSmFTV1Y4N1I2aHF6cUFZRnZSMi9nUE5FVVpP?=
 =?utf-8?Q?bKuavku7V8E4vaOcYlTsWeENb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6cd136-c8e2-4ef9-0aa8-08dcd88de999
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5903.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:32:00.3645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPcZ8yxnFHKprhlPpsGQd1fGlDquWaGwDXDYX6wiSFrONL10TByg4cG1BvSHhqGkC+5GECyKgGEhQsUClPK6nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077

On 13-Sep-24 17:37, Dan Carpenter wrote:
> 
> Hello Yevgeny Kliteynik,
> 
> Commit 2ca62599aa0b ("net/mlx5: HWS, added send engine and context
> handling") from Jun 20, 2024 (linux-next), leads to the following
> Smatch static checker warning:
> 
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c:739 hws_send_ring_open_sq() warn: 'sq->dep_wqe' double freed
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c:739 hws_send_ring_open_sq() warn: 'sq->wq_ctrl.buf.frags' double freed
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c:739 hws_send_ring_open_sq() warn: 'sq->wr_priv' double freed
> ...
>      725
>      726         err = hws_send_ring_alloc_sq(ctx->mdev, numa_node, queue, sq, sqc_data);
>      727         if (err)
>      728                 goto err_free_sqc;
>      729
>      730         err = hws_send_ring_create_sq_rdy(ctx->mdev, ctx->pd_num, sqc_data,
>      731                                           queue, sq, cq);
>      732         if (err)
>      733                 goto err_free_sq;
> 
> hws_send_ring_create_sq_rdy() calls hws_send_ring_close_sq() on error.
> 
> I would say that it's the free in hws_send_ring_create_sq_rdy() which
> should be modified.

Exactly - it should call the mlx5_core destroy function, but instead it
calls the HWS function. Will have this fixed shortly.

Thanks Dan!

-- YK

> There isn't an official style guideline for error
> handling so do whatever works for you.  But I've written a guide to how
> people often do it:
> https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/
> 
>      734
>      735         kvfree(sqc_data);
>      736
>      737         return 0;
>      738 err_free_sq:
> --> 739         hws_send_ring_free_sq(sq);
> 
> It results in a double free.
> 
>      740 err_free_sqc:
>      741         kvfree(sqc_data);
>      742         return err;
>      743 }
> 
> regards,
> dan carpenter


