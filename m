Return-Path: <linux-rdma+bounces-12501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA2AB138C8
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 12:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD54188FF85
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jul 2025 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CB6255E4E;
	Mon, 28 Jul 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z/vtH/Ea"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5032550D4;
	Mon, 28 Jul 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697865; cv=fail; b=k/3MEEfACokaKIs7PMwyjvNgSSrE2L1xlXV5OuB8z5qU/8/bbVVTM05YGk75HcfwaIappvMPXw3or0lj4fNpVxeGyasl5vXMoew55CA1/o9fVyOh6q5scfLpFdF6SygwqgQTtpg0+bD5PfDODOiL8U+AAq5QEPhdoNl1DEcurrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697865; c=relaxed/simple;
	bh=cWtclGiH3DxtMAhrCFqDoI+zddLdaT12gDngoIlr/oM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JBBReX3MPXS505agbCMeIKJKEHeorf3xMjMfnK3aBsOoL8alaIPEG+19qRrpNqOKKisDI5LqpB3g6sy1+QPtPznk3aTWjFPNZ4Cfy4U5R+8ZY3VwDdePn/zUe3JnbM3Y+Na3Q2ckRhbM282GxFg5YLc7TCUeZE/XJPLMZgoK88Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z/vtH/Ea; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA+tJY3LO4ZJUSwpgiegFtUtCImIS/T9xQhAFEzfmb+o7fsCc2wKStMJrOYhpFlzIj4ijqY2Gw2PDkcc9ag0Br3VJgHc92uVwBqQjmKRlfcq+VvK197zC9bc7chH2yFQyPX8B0cWZ9p2vduq0efw34Is6NBvhMj28HKuA5qhu6D/lp+quOJO3DTUr/28nmNkB8D45WTPNJ/5ebc/DUMMr+4kMIBwmZCtFValqxLCBpX1mfoVCt9iOYP8IL/J8lXjdyYt8dlzC+W9CQYOcAIfGQyDsBuafLuwji1JuMcIBsnqOjs9HegbOIEVppEX1/R2j3SkJDDtJIN2DGqwLo4BRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmNZansXHkcThP2puBNHitPGcT41uE613MKoUCcuTMQ=;
 b=VyFMOjVooecwuwmseX7gTEPzufII0ytpIIcbNYuIejzRrPEPqu5TSBje46gwxeBaNKLx0syCdVwZw+4rzOcaxRjDp+EEg5uc1+dDF4ZSBUq5wgPh7DSmRDTh92pBlcal4cXnxrA3WRITauIK+RsM5aJZwJ5mH3I4Vu2cdcjj+FoorRDFXkPKQGLB4XeQ6cdMoem376Qv1ZI0QbLD4JbJzcBqEz8HT+LUuCwWel8IYe9+ZB/JtmJ/Af6kC6uLf52dySNMwHUtds7IBg/UjNEatpKHKJZZUb7man+3yXpnfJr2rwVi5ROUo9fwX82VAAo9VyV+nUzEHq4HV+3skWodGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmNZansXHkcThP2puBNHitPGcT41uE613MKoUCcuTMQ=;
 b=Z/vtH/EaI7AcxGkX3MZdIHfAHeO7/1FkHt2Tc9eoa1/nmky9wP3yWFPKz848NYdN94ZzphuG4Z7M5RJZ8+7SmCge7RCLjp/kyBoXEWraluHx6c7XZI3U4niwXA364/UyKF3bLQxloPHU/3k9kiTPKfuO+I+yWGRKRGCNFipe0Ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 10:17:41 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%5]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 10:17:40 +0000
Message-ID: <14c50407-9b0a-e3ab-8c62-2943b8592bb2@amd.com>
Date: Mon, 28 Jul 2025 15:47:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 01/14] net: ionic: Create an auxiliary device for rdma
 driver
Content-Language: en-US
To: Shannon Nelson <sln@onemain.com>, shannon.nelson@amd.com,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca,
 leon@kernel.org, andrew+netdev@lunn.ch
Cc: allen.hubbe@amd.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-2-abhijit.gangurde@amd.com>
 <3528db67-86b4-47af-b002-87a75bbdc4df@onemain.com>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <3528db67-86b4-47af-b002-87a75bbdc4df@onemain.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::7) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b823e7-898a-4daa-fd1d-08ddcdbffbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R254eE5ScUtLMjBUVkVlaEo0cS8vY0F6eDQ0SUdkOHJLbkNOcTF2K21yQU9L?=
 =?utf-8?B?K1lXTFZCWUd1RGhVUnFhcHQwM3BWVG03U1A2d3VobkRaazlFT1JvOE9qT2c3?=
 =?utf-8?B?bU55cWVzMzBzc1BEam8yM1h3TUlmNi9oSXpnWitpVWViTWRqZVc4S1REUUtz?=
 =?utf-8?B?R056dFVBTU9UOHJ0cGI3cmsxZXdZOXhzejgyS3lidTNpUWQwODk0TmJLQW5w?=
 =?utf-8?B?TEJrLzRhR3N0aXpRekxuZkhKWkxhWWJDV2tBM2RjNzN4dy9KcVVBa20zeGZ0?=
 =?utf-8?B?MWVsODhCM2Y3bDNvdTFWTXRDV21FS2UzNVBXZUU5VlA4cXYxUEF1d2NKeUd0?=
 =?utf-8?B?T0JvSlhFb3N3dUtZOExoTTUycGwzc2x0dExnb1AwaHUwMmhScEEweVBQbUFi?=
 =?utf-8?B?enFXazFEbk1kb1VzcFFwcU8yRGhJcm4yTURDbmgvUWNnRW5OQ08zNSs3U1M5?=
 =?utf-8?B?amhRUjk1UmVPMlF3QUJEbWlRWmIrN3licXNHbmU5akxjTGp4WWdxbUQvRUFF?=
 =?utf-8?B?akcwbmZRVXdzeUVqcXY3MURaTzlpRDl0SVREVTVrcHpVcVZzcXhQdXdwWHJN?=
 =?utf-8?B?N3hoRTVCVG1aYTAyTW9WeUY4SHVseG5HeEdRc3NGN2xWY1Bvc2NaRlBVM0cw?=
 =?utf-8?B?cWdmVTRGYzNaU3BSRTNZTSt3ZEFVSGpldTFqalhXci9qeU5vQ3lKMEdkQWFa?=
 =?utf-8?B?blpqRFBuVTc5bXBneWJ1ZXdZOGZ0eWxwZ2EveUMydHBHSDUzYW03eHF4eUMr?=
 =?utf-8?B?NG8zU1VuTUdyVzAwSW1RSWpIQ3hZRkUrNTBvYWxES3Q1ZE9MQVpEQ0ZOZHQy?=
 =?utf-8?B?anhudkdteUhPeVB3Ym5BMERySDVIS0pwVmt4V25PRGR2eXFPYWJDdHdiaG5B?=
 =?utf-8?B?OTdWOXg5dCs4ZkxlTkJmTVdxbTVzdk1USERGTGZ1a3ZxK2tneFBWU1cyRUI0?=
 =?utf-8?B?WTFqQ01sWkdSY1d0OGt2ekorcnNJK0YrYlpwNGMzNTJZWUVNRUdUSjEwcTNF?=
 =?utf-8?B?dkdJQ21YNUZXdW5GdzNoSW9GeUo4RlVVWCtYMEJkRGFkNjBtV1BrbE9MZGt6?=
 =?utf-8?B?Q1BzNU9IdTBxM3hwQmVscS8zTURyRDJxbjdoWmJBYk1vWU8rYjJ1Q25GZUs2?=
 =?utf-8?B?c1ZQcVZidjM5ZzV0SGhoTWtka3AyWHJRUGxxY1MzbkZiM2hnZlJTMThGaEcr?=
 =?utf-8?B?NXJYQ3FtRmRwbEZzbEFqYjFidmd1a0NMSzYydys1QjZ5TW5IaDRqRm9HWi9U?=
 =?utf-8?B?YWRmRktZeVpXU2F2dVF5dnRhRTVZVE84QUExQllIclVidDlWL0hkWlVhcWRC?=
 =?utf-8?B?Zi85d1JsUWRFZ0xuZzZoZCs3OWpNN0dFU1NvOC9RMmpTSnBjVC9QZ1ZRR3pn?=
 =?utf-8?B?RE5QM1l5ajRZV2VKNnJxUVpkUmNQNDZWOTB0ZFlmNUVMcEdDc0NGMlh5Y0dU?=
 =?utf-8?B?VXIxY0FTZDlKZXpHR25FS2FyRm40UndrNVZPRGZieXRmSjhTeklwcU1IMVVD?=
 =?utf-8?B?UktKNlRid20xZUt4dGFhdy9Ma3JaTWlCbGRxRC9ZSE1pRnpRbmdvV1Y5SWcz?=
 =?utf-8?B?MHU1UUF6RDVEOWpxZzYxT09MbTRPNkNmdHhhbWl5MndRUnFHd0NjZlhWamYy?=
 =?utf-8?B?WHZMTnViYXA3dWRaS3JsbTlGTmZpWURvYjVxZDl3OWo0NHFtNUtzTXFCVEcr?=
 =?utf-8?B?K0tjRnZwSEU4VmV2YStBei9FV2h6czNnOGR2M0EwVzJiTGczODFMczd3L0M3?=
 =?utf-8?B?eEZiTUVncDVMZjhXa2N3YlZoNTBRWXN5cTR4a2p3ZHpxK2c2dUhLVXAvRzFi?=
 =?utf-8?B?cGNscjZ1bm9VT3pBd2tpYVFmT2NwK3BOTWdGZVBCRVIrelByWFdWTHI0bWkr?=
 =?utf-8?B?djFudG9ESGlSM2VUOVNQN1pLU0ZkdUdyRmJDSElVOXVFVnNSL2dTTEtCUmtC?=
 =?utf-8?B?NHhza3dHbVBQbXA5YStXS3N0bmtGcFB2OHduQXlzN3RMeG9HSnJrQVRqWGti?=
 =?utf-8?B?QTd2RGx6bzBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkFOK1RjUVdRVkxVVTlGUTVRNGx1RStXc3FscVdZUCt2dURMSU1oV0J6Um4w?=
 =?utf-8?B?NWNJM05IRzlLVHNCTldKNndiSitFNFdVVUx1TEQxWTNibHpuOWFRMVVRNnNk?=
 =?utf-8?B?RmhHM3k0dHZRcTE2QkdaU202N2ZQejV5VGlUbm9VN2lpa2F6cTdCbWZFZjVx?=
 =?utf-8?B?YVowWEE2SlFObnF3ZVVTOXFEZHZLTit3RVJUOElCYW4yMWIvUzgrcnVOLzl4?=
 =?utf-8?B?Y01Nb1BlY2JGbGtHNEN5dVpWanhTbVAzY0JBeHZmN2pKU3k3WUMvb2IvMnUr?=
 =?utf-8?B?VlNzNHozTFdLMmh1Zjh0a0xTc2RmL1A3VXdWQ1IvNjNlN1NneFhYelVocUtn?=
 =?utf-8?B?Y2d3TXlzUWVldXp4dDJoaldzRG5lSDNiNUJKWlpQYy9sbXA1d3RwY3BaV3hX?=
 =?utf-8?B?aFgvVUw5OVRkR3N1YjJaMDArVTczWHRrSUFRQXhyekZWUURtdGZCQzM1RHBS?=
 =?utf-8?B?TDJ3Rk1YNlNUa0V3U0VTeGNCSVdkOHR5dzFIaXR2eUZ2K0pkeW9qRElIbjBz?=
 =?utf-8?B?enFmU1hRakdJd0JoNG9GY3RrZWE4b3Jvakt6c1hhUFNKdjhmcHRzZG0yUkM4?=
 =?utf-8?B?RytON24xWDZiV05pUVg5bjJqMnVWQ2xtRmZ6eDAya3hrVDM5VTJ3dzg4ZXJw?=
 =?utf-8?B?MUpoMVNrTjVkcE5ZQWlIZWZBeWMwOWMwS0J3eVJwYUw1cDVYODJvMUU4cWVK?=
 =?utf-8?B?WHN1cDJFa2h0SGVYWXUrVVFvbVRrVVhhblk4b0F0QlN2a0NYd3hKbGVzWGI3?=
 =?utf-8?B?SEY2QnNnYS9WL21tb0JQajdtZUg4THh1YXFmMnF6WjVLbENuRWF0SCtEV3E2?=
 =?utf-8?B?c0NRSlhVejdvWHpVNkxVc1V2V3ZnZTF1OEdtQVJpdStkeXVORE1oSWFxdzZO?=
 =?utf-8?B?ZFRaZXgzblFQRzlBNTZ1a0RSaWczMjlGTDFCOGxOT0pKTXRKUnBzbGxoM1Zn?=
 =?utf-8?B?ajhpS1A4ZEVTNUhaMno2anp1a1k0TmpDMm9oZ0hMck5VZ1J5OGpOU3htWmpp?=
 =?utf-8?B?cGlUVkJMWm5UQ0xDQ1BzeXQxL2xFQXlzZTFuMlFvdDlSK1dTSld5Z2hjY0ta?=
 =?utf-8?B?OVpTb3VPQVFXWWhkNlE0Z3BpVHgzL1NRZ0NnTGpNT3h4STZ4bkgxUUdiR2tw?=
 =?utf-8?B?UzRrVkhxR243REExNHFsRkNWbm53QlUzVG4wOG9SY3h3MEFrUjdncHlPaE9h?=
 =?utf-8?B?UFJxWlh5cnpNcDh2Vk84NXkzMTZ0NUIyYXNkY0c0RFl6dnFTdHJjbG9UWk9j?=
 =?utf-8?B?elVrdmhJazNWUFhrMllpVVVKVXNMVHR6a0xzMncxblcwUVUyVEdOUVV6dlFC?=
 =?utf-8?B?MjVGZkVjZHVhamc5U29nS0h5SVQ3aDVrbzU1WDRTd2llN3cwdXlqRW5TZ1Bw?=
 =?utf-8?B?STQyY1p3UFBzL3k1V2RLbzhGS1pOOHc1cVRaU2psNU5xSk1YVG1rNm1nZFl3?=
 =?utf-8?B?WGk3ZjNBWmVqVkg2ak1MR1JTSVp3d1R2enNnb0FzbXBHbEFoQWlwMzM1OXVB?=
 =?utf-8?B?a0drRjI5OHFxTmhuek94ZjErUDZQK2t5dzh0dWJuNEVRRVNHcWo5RGNHaSsy?=
 =?utf-8?B?TjN5UlRWS3NRbVBnTi9TRDNkT1BnVFNJeDNPMXhZM2orZDhJSmpxTFpuUzBs?=
 =?utf-8?B?WXZQckhlOEh1YlUrcFdIZWorYU9TczBZWDJzZFMzQWh0TG1CcFgvbEVYWllr?=
 =?utf-8?B?TW12QUNqeGxhSTNvVW4zenlGdnJqTklaYktYeHBiVDlaY01TMEdMandPVnBv?=
 =?utf-8?B?UGFSbThQalhXT0M5cFIvTEQ5N2tRNVNUekxiVSs5Nm50bngwc20rT29jK09S?=
 =?utf-8?B?QmVBbDlHZDdOakpVa3E2U2hhMGcvdmVocEpkQ3ZzT3lJeDFSRU9QSGl4YnFK?=
 =?utf-8?B?YWdlZFkzMVV5aWxzK3pnQklFNjE0b2RtSGEyRXYwSHdmL2dDREhFdWV3SVRj?=
 =?utf-8?B?dDFGVEs0V3pJZlVBdFlSR3dwMmdlWEhZcWhsU3ZzMGhhd2E3UTVRalpTblFO?=
 =?utf-8?B?eUR0UENDN0kxNnRzektiYXVmQlVpZUVwbkd3SGdneEt4dkhnRjhyOXMxSXhK?=
 =?utf-8?B?bVpVYm5LaHFURnpMb3RkdVV1ZjE1emlyWkNzK0ZGbExmems5dVdYTDZ2cTgw?=
 =?utf-8?Q?Z8AUo4Ie/qDy4k9ieqh/Ohzsk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b823e7-898a-4daa-fd1d-08ddcdbffbd4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 10:17:40.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLjZKUGJGsAL3x8JguMtq8wfayo6OCpvXXKs8qYgF7/+7E67xeOJcwKUXv8inn8moavBUzxFNPUFj2DQ7McpgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290


On 7/23/25 23:41, Shannon Nelson wrote:
> On 7/23/25 10:31 AM, Abhijit Gangurde wrote:
>> To support RDMA capable ethernet device, create an auxiliary device in
>> the ionic Ethernet driver. The RDMA device is modeled as an auxiliary
>> device to the Ethernet device.
>>
>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> ---
>>   drivers/net/ethernet/pensando/Kconfig         |  1 +
>>   drivers/net/ethernet/pensando/ionic/Makefile  |  2 +-
>>   .../net/ethernet/pensando/ionic/ionic_api.h   | 21 ++++
>>   .../net/ethernet/pensando/ionic/ionic_aux.c   | 95 +++++++++++++++++++
>>   .../net/ethernet/pensando/ionic/ionic_aux.h   | 10 ++
>>   .../ethernet/pensando/ionic/ionic_bus_pci.c   |  5 +
>>   .../net/ethernet/pensando/ionic/ionic_lif.c   |  7 ++
>>   .../net/ethernet/pensando/ionic/ionic_lif.h   |  3 +
>>   8 files changed, 143 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_api.h
>>   create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.c
>>   create mode 100644 drivers/net/ethernet/pensando/ionic/ionic_aux.h
>
> Hi Abhijit,
>
> It occurred to me that there should be some discussion added into the 
> ionic.rst file about this new auxiliary_device support.  You might 
> look in the amd/pds_core.rst and mellanox/mlx5/switchdev.rst files for 
> similar examples.  This perhaps isn't a blocker for this patchset, but 
> should be planned soon, or added if you do another rev for other reasons.
>
> (In a similar vein, the pds_core.rst should be updated for the new 
> pds_core.fwctl auxiliary_device, but that's a different problem)
>
> sln

Thanks Shannon. I will mention the rdma support via auxiliary device in 
the ionic.rst in next spin.

Abhijit



