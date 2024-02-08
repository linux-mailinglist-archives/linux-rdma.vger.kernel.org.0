Return-Path: <linux-rdma+bounces-975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F5F84DC5C
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 10:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3640E1C212C1
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DEE1E4A8;
	Thu,  8 Feb 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xxu9WL57"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BCD69E1E
	for <linux-rdma@vger.kernel.org>; Thu,  8 Feb 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383141; cv=fail; b=dJPE1daEQBHbYFImnMlaWrUlu2Du4THPlgGeIHSj0BzQ3pHwRBCjO4oB/v1JFU2tFbCqBIO+8Jhng+HhzmtpcUQZBMk3obpq19VgRCGc5IuLoONOgKQkziM29MEAfXkeF2hoEjegQ+1TWk7JdAPl1wqQh8toCe4OKeC8gdspWTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383141; c=relaxed/simple;
	bh=TeDOWEr/D/P2WRQHjM2bLx0rZAzdjagjOUU5jjGxbcY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mIzCUPbkZ9i3hFxpnBOeSYyWetxkCvk5X4YXkFYvuWNytSpqC29hdhiG2iZt8qkqbdVwcGRdTn7lKK8kG/JtYo/bsnS6aI4qM9D6gI0rKIr4KUvNey4GnyiGaf+h1gkE6EpiDOhrvLDErG53Pf2llFOuK+JofB/0i2GGKLlBR3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xxu9WL57; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7nBgkF0QS20CUjHui8jKUa7+2Y1EQLETZnl9lGE9WHxqFvO2EotDfzKfB0fz6jODg5NpPzUDQ+rQS5dUT8ic1vgAuPVxrJp46cc6O6nRsl+GXfp9dhVOC/HzTFs1+1/K8RCxK9wmclr5KAVEgxL/2WTeHILU1Z//mgDswBI6ZvoEm0e7PCiCGOh2HFtW7MtPz1rIAxD4iW/vIzZdYU9vxCbL1HpklPcYCZuDyPmAz6JEHoTX8lEIYjX1fUJXzGx5c4DJWq8nsJ9ZtcIA4vlX7APV7c6Tyq1TJO9GyTgMChkvnEx8RfDkn9b1nBqqIdZkJG8+HKLsw/1uz8ic4TXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCtCu3WB1OQquhFLdUOYvhwNAbUQWzyVIHVWxwhnPyw=;
 b=nCIYRgFGA8PlmjBrvZ3yN2C09qeB1WZjNaJQqsUPW0SlayGJzVYFblx/85Er2k38aSZgMTDyvHhpNit+PCmGmfjmUX4e196bPF3gdkxpAaDzZzs0hO4b+itGIq2ji64YFCKAXBSZEWRxjqtjwqcVyQrJP37cDqD4VTUcpy9MqtmTGDuaNW8N8gE28hLfwWo4WHOAVa/eei49GeJFT4LiJDdDAmAvRFbay5Jq7btZ/j3KJxppNUwdTgNhnE7EsHzEDnfaB34DoW38CGW0AuPazIlV7LECcX0dlJ9Go8X8yq+2gZZMK/wLJdzs0VVnDVXKRDCwxha31rS5MiYmIC+kkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCtCu3WB1OQquhFLdUOYvhwNAbUQWzyVIHVWxwhnPyw=;
 b=Xxu9WL57aaOaMwvdcV4uRgMjDhrpzAdGrE65PHktezguuPKr+7PqbUQv34X1i3hxycAsVuUe5ICWwIZ/EO+aDdzK1nOFK1Ufc+o2TFNSgK0qcH7hgb+1n/LXbNCbOWLOjbPOfU/0BNA1Xi1+lcH6gjWPZV4Z2ByRUgaL4aM1UwbDGfnZA+HNEWfwVHjBgkiyvmRZHbnbFhJdvH/BSgci2rCJH8x1OnRHdv84Pxb99pkJ2wfVDE7VGtxKZlzEiv2YF4dzSHp2gM4/5t/FJn0KqUj3dBT6ygJDNQD1N8AhH4eiTXp31fJDAWx7RHN4MwpHIsGBkEM8eljhs0aA0Lncow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 09:05:34 +0000
Received: from IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::747c:b6c:523b:63ba]) by IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::747c:b6c:523b:63ba%2]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 09:05:33 +0000
Message-ID: <f56f1b8e-bc99-4dd4-8f24-6c718f6031fe@nvidia.com>
Date: Thu, 8 Feb 2024 17:05:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Segfault in mlx5 driver on infiniband after application fork
To: Leon Romanovsky <leon@kernel.org>, "Rehm, Kevan" <kevan.rehm@hpe.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>
References: <E25C1D96-0FBF-44AB-A5B5-71CDA49E73D1@hpe.com>
 <20240208085229.GF56027@unreal>
Content-Language: en-US
From: Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20240208085229.GF56027@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To IA1PR12MB7495.namprd12.prod.outlook.com
 (2603:10b6:208:419::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7495:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e4603a7-0e92-456a-b855-08dc28851b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KU/OApb5pdLvbHZvW4O8ZHY8Is4JMOZoWv+6lP6ZPYgAi+Qkpxd7mhlpegfeD6a+b9xobGvsRYOP/q6vceFCsRJTb2BDoSXvJakuCCHnmC9zvaJe0ikxvPjz773f2GNvNeGJE52f1N3ebcVzo1NDoL0EWxivT5hIFFakxKP9DNX7QeRUD8Fb1qUGoqpyAjmCOXgHw+qs5HVT9vmzdr1xx4tWIRpSrRQKU3gUtkQMpnYBcSH/Z5pTWeKIPhMMcG+7w26GdXTBtUG909YJYRC1PBt6m4AVA2d1+vrJyjYYPDg1aqU+po2CiSjUaRaun+lUVnnwfnNZMosjeu1bkodKu5ubQa208UY6E6Acor2Xh+XB7gOgXDHfZyaZeyt+3pfop4Btbsa28JUZNv7wojL9r5fMYSbSqgJccS+RfYTQnln6fCB9ee4uonCGtSN3oE0XegM14HAESk3e4Ia9du/mXYx/4L5iPmWYGMK0ugP8nK86JFbbDzlr4CVFJM1RVgDzswcEds2Buio7qVCaS0iMPpsKG0K5QNYBOJGumy0S9ufuW+tm8IMk6kWlXtWW5RWcanq4gttvwp8gt2RFyG/ZLYVtwwmhlU0AE8XlOW1siiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(26005)(107886003)(83380400001)(31686004)(6666004)(31696002)(6512007)(5660300002)(110136005)(53546011)(86362001)(66476007)(41300700001)(316002)(2906002)(54906003)(66946007)(478600001)(2616005)(38100700002)(6506007)(6486002)(966005)(8676002)(4326008)(66556008)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmhBSUdTMlVyMmhQY242aXBkcFBqc2ZRZDQ1OXI2ZzluYUlkRjI5VDEwNGVV?=
 =?utf-8?B?L0NteUp4eHJaaU05eFlPLzliQjl2cHRpZ0NNYUk3b0o5VFV5VVdGenJXaUNx?=
 =?utf-8?B?VDBNWVNNOGg0VlBnbG5naHBPZlhaZXdkY0tyV04xOGtDc3BTQVdPMWtPU1dC?=
 =?utf-8?B?VncrMmM0eTg2NWw5M3UvaWx4TFRSK0VRWXZVNWNDTUl2aTFoa2o4U0NrTnJH?=
 =?utf-8?B?THl4Mm5zNzY2b09acmdlU0VxazNab2NwVkZPVGdzMTU1RXdXdEIvblMyK09z?=
 =?utf-8?B?bnNUeUR0NmhMSzZlK2doTlFrNUNMN2xyME0zWFZPTVFDNm00WTFRUEl2cXhv?=
 =?utf-8?B?cEloYWNxTGtOckU1UlRsRXdQby9ad2c3Y0lPL0NVb0VSQklLc2VPWkkvYUtq?=
 =?utf-8?B?Y1M2dHkzSDZ4VW5CU0RGbStYZFFZaGNwd20vSVJVSjRobWZzSXNQNEpYMnky?=
 =?utf-8?B?OVBBeG91NVppbWJvK1VnY05KbDNzYlpIcUIxYk9qb09zM0MvMmhiSUt0WDUz?=
 =?utf-8?B?Q2h4MnF4M0g4UTJYS2Zpc01EbzFGeTJJSXdhZ2xYcDZXMVYyTFFCL01yQldz?=
 =?utf-8?B?bHFOT1JheHJWUXRUb0hUSE9XeEFWQXhCSFhLZ3cyL3dSb3Y1eGJWSWZPdVU2?=
 =?utf-8?B?bXBlZjFUWlJ1UytaVGsxaWJ4eGxNcFBKUlRRNzBQVmJNSDUyK3JMbUhneG5t?=
 =?utf-8?B?cjYwWnZ0WnNBay90Q2swTWZYV2s3d0dvRW9DUk5NYVU3cVhEMjB1WHhHRk9P?=
 =?utf-8?B?NS8vR1prZnFRbEJUUkRKS0RJQXNaVFEyVXdaWjBBWnQ4S0s4ckcvUXZwMGc1?=
 =?utf-8?B?ZFhNY1NUZTk0U2RHczkrMXg0RmJocVBkazBoWlVieFdFS0FkYkJ3OWZUU3l0?=
 =?utf-8?B?N0pDM2FINXgyUWtHSFJ6TEhiZ3BJSWxCb0RLSng4MHRDaTNVcGFQWXNqTWgz?=
 =?utf-8?B?K2g1YXNCV2p4OVZlL29hUlBPUEd1cGw5dU5ldlhlS1FvNmMzUjBNOW5NTTN2?=
 =?utf-8?B?Mlk5YUlpZHJtMkJNekEwTi84Vll3K1VQRTBPNEgrblJ1WVV4YXpxV2dBNy8r?=
 =?utf-8?B?bEs0YmZHbEh3QmZoYktLSVp1bUF3THFSY1lpT2psdTNpNHhES0s0bHYzdkJk?=
 =?utf-8?B?MDVZYVQvVE1PSGFsQ0c5RzQ0VmdCMjhGSldQRklWelhoaXJVbVVkWEplaFN4?=
 =?utf-8?B?eGpmdlBIMW5xUEMxamxmanYzOEFxWWNzVFpkQlMzNCtuMHB6N2pHZ0U5bTRs?=
 =?utf-8?B?R3h3cUtBUEIxT2dQT3hjRm9JNFZYcVZ1c0dZODkyU24rMmZScFplZjlwMW5R?=
 =?utf-8?B?ek1renRNN0Z1WGZVak8rSWZ5aHZyNjRYSXh6QTF2NHNXUTcrK1JPa21ORmFX?=
 =?utf-8?B?OEkyVktobzl4UDhJZ0NQenNRL1ArdmdNVjVaZWdCbElYUHgyL045c0p6RjZX?=
 =?utf-8?B?U290MHJ1ZEJYM3J5YzNza2pOSW1mTVNNbE5WcUhReDA3RzRIdUJ3d2h1Slg4?=
 =?utf-8?B?c0pwaktOWEE5aEp6TjFMbmdZYTh1SnIzak94RFFQMlFPRnhZK0UxN25IaVNi?=
 =?utf-8?B?VndITWtOMEVoNmRDRTkvOFlXVkE4RWJva1p4RUdremxLRVU2bGdlajE4eVR4?=
 =?utf-8?B?ZXVTV3UzbmpQNFBIbTdFUy85QVFQbkZJZnpEYzIxbk9zbkx6RnNoM1M3b2xx?=
 =?utf-8?B?UTluZW5OVG9PMFdTWEVkOGo2enJ4VFhnTzYrTWg4Nk5KM044aCtYQVVqL3dV?=
 =?utf-8?B?aEZ6eXdLRDJWcWt3VEpPMXRnTzNpc0p1UnE1dElMZ3NkY09Hd3NrUkJvZmlJ?=
 =?utf-8?B?ekxCZS9XUnZBY29Zd0JTdmhra0R4OEFBekxGanllZEZBOFVGK1NQREROWmt2?=
 =?utf-8?B?ams4SVdmZE00TTdQRmFtYTdRQzZpWWxSOUtxU2lqdElhWEZyMW40UUhsVnRI?=
 =?utf-8?B?ZHFjZUxTZHdyK05ibFB4UW0zaldDekx2MjcwTTl3TjBrRHNORE5pUmx5eTFX?=
 =?utf-8?B?VEo4V1RwaWs3MklpYWdNTWtYTEtXanNtRjJHYThGVGQwZUdBaGl1SXQwL082?=
 =?utf-8?B?cnFQUmxITWRxZzdHWWRIclAvRFZ6bmhVUUlCQUtNVHNFakhkUjJ0cnZ0OW8v?=
 =?utf-8?Q?7azZOGR5fCyNBV9HyFXSNsqm7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4603a7-0e92-456a-b855-08dc28851b13
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 09:05:33.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkghcO1efuMh9I+hyZXruPoSGkhGRpPPtYGSnCwVSi76hnTa7GzpVstVWY3yuUeQwKzo+l5cS+4YRrzqIHPK/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047

On 2/8/2024 4:52 PM, Leon Romanovsky wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Feb 07, 2024 at 07:17:01PM +0000, Rehm, Kevan wrote:
>> Greetings,
>>
>> I don’t see a way to open a ticket at rdma-core; it was suggested that I send this email instead.
>>
>> I have been chasing a problem in rdma-core-47.1.   Originally, I opened a ticket in libfabric, but it was pointed out that mlx5 is not part of libfabric.   Full description of the problem plus debug notes are documented at the github repository for libfabric, see issue 9792, please have a look there rather than repeating all of the background information in this email.
>>
>> An application started by pytorch does a fork, then the child process attempts to use libfabric to open a new DAOS infiniband endpoint.    The original endpoint is owned and still in use by the parent process.
>>
>> When the parent process created the endpoint (fi_fabric, fi_domain, fi_endpoint calls), the mlx5 driver allocated memory pages for use in SRQ creation, and issued a madvise to say that the pages are DONTFORK.  These pages are associated with the domain’s ibv_device which is cached in the driver.   After the fork when the child process calls fi_domain for its new endpoint, it gets the ibv_device that was cached at the time it was created by the parent.   The child process immediately segfaults when trying to create a SRQ, because the pages associated with that ibv_device are not in the child’s memory.  There doesn’t appear to be any way for a child process to create a fresh endpoint because of the caching being done for ibv_devices.
>>
>> Is this the proper way to “open a ticket” against rdma-core?
> 
> It is right place, but I won't call it "proper way".
> For anyone who is interested in this issue, please follow the links below:
> https://github.com/ofiwg/libfabric/issues/9792
> https://daosio.atlassian.net/browse/DAOS-15117
> 
> Regarding the issue, I don't know if mlx5 actively used to run
> libfabric, but the mentioned call to ibv_dontfork_range() existed from
> prehistoric era.
> 
> Do you have any environment variables set related to rdma-core?
> 

Is it reated to ibv_fork_init()? It must be called when fork() is called.


