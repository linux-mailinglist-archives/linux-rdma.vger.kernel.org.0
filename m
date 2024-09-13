Return-Path: <linux-rdma+bounces-4935-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58532977ECB
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 13:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E201C25161
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3F81D6C7F;
	Fri, 13 Sep 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="MY45XmDP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020117.outbound.protection.outlook.com [52.101.56.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C029E17BB3A;
	Fri, 13 Sep 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227987; cv=fail; b=rhh71qYh6bvlNgpwuUW7BZWiykVU/B/plMIT3dyVkuBKl4BrJxN/P3YfDN9gIMeEdxLs0M3REcsBTLwzehZluuc8w7LeDTfQGpi5Dt1mqJXah6o7v24bYwYJcaNpFTJf2l4AT1fIze8tBnBo5uqgtF22zsR8xv9b6StotcUBnXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227987; c=relaxed/simple;
	bh=8gutm4fJKsXf3M2VdV5RBklOX3geGrZImOT9/5zjM5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g9aDhh46RPrv9U9WuvwnwMTpbCoPCy4UxeqRLamWGBweMxPHe/psK7JNnOBbDKGr3Czvecua/0Fbzkrzy3mVfXVYkzNdkV0RBzYcaeli1JLdqSR2UwKCt+8eSH+ECVAe7jo/xYj7xTakTfL/ocNT7JC6MqynLPeBz1ZE2owMM50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=MY45XmDP; arc=fail smtp.client-ip=52.101.56.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBSciQxywThITio4ry1c3aBxdou8d45xFNft1QisraXw7Cvycm3YcB3shuR4VdVx6i317TxoVjK4kjcyu9E8/mdLIlVVVkbfnZf8ilil5qED/xDZdJ2JG3ujQItYN41q6ZkYZFAt/p2jAKZe4R3OCntmDxGRtxrCBWtsJa5r7bneyBlsA46fGJGfq5p7cTuv4g8X5ppkzWI754q3GLySIYgbucns/FdReJwdHhNMv18S25zJrGnGyevUTU32t1bjg9YfVEylMnplgGF8WjGAB3dEhuV9V5VXOfN8Y8c7UOKNW9GFveD2cmCBiWjhX1imAckk5TP5LmQmsOL69sXMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Upy3wa6buRIHguFrKO1p2bl3tA7hGII8IW8qzpjTeYs=;
 b=LKOTGb6ZyA16L9pIYJVn+bKxyANWZmUdkh7EHGS5GlzG0AuRXFXRkaCPWDDf9GtOUWi9LalVjjyBvTEEGRf4x1X/HGq0a36yNb+wXVSdBeanJvpeV+PLTgZZcLTDlFM6ZD5PKYfSAQVqRhYX7YTbiKdUvwKHjawjf0pSeTuLPA3qBeiZxzsseaxcSPL9aWJhSH/0X3AJGKp6iQ0pXZ75C5gYpNAZ988+xgNz9h5rxK0Bq3BgN04s/9XyYAMsQOEQUI0i5uonTqI/D422UbqpZs64ap2WaNj0X5acXPTca3EYLdh0BPy/ZuhpP5Dy3Ct043xBI51vNeOM3cIQxOC47g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Upy3wa6buRIHguFrKO1p2bl3tA7hGII8IW8qzpjTeYs=;
 b=MY45XmDPVFsqh7gHwQcU9aL8zBRX+nv/idjas+A42QVoNcPZlYPTpdJ3Xr8iTcx3GRuGyj87qSy0dUWppofNKB0TWuusMB6I9bo4BPVY9j7y7fD0gmRaMq/R9QYVRDjkXlxuk1cYzjhYGkjpIMwrropbUA6vLq/+q6rsDtA3Uyj6Cav4Ot8NjR7OAcPqxZujJ56eaLa+pIrVpQ8nlBEBoTsgPGJb2QofDDHa23QXzpd0lPxpBdEwltBWSBeWLCC4k5Z1YmIjtzHwrClHtVyj8TTdOblo3a/CXYp32wQCtepE539+OFsH0pXPjwtIvI4XviFvaKyHbOQ39jcqtnO0sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SA1PR01MB6736.prod.exchangelabs.com (2603:10b6:806:1a9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.18; Fri, 13 Sep 2024 11:46:17 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 11:46:17 +0000
Message-ID: <d8a4001c-d8c7-457a-a926-1d03e4f772fe@cornelisnetworks.com>
Date: Fri, 13 Sep 2024 06:46:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
References: <cff37523-d400-4a40-8fd1-b041a9b550b5@cornelisnetworks.com>
 <70cf5f00-c4bf-483a-829e-c34362ba8a70@cornelisnetworks.com>
 <ZuBiLgxv6Axis3F/@p14s>
 <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
 <CANLsYkyuB=BsswRmbSbjDNMqz0iGHrviLMGfNJLx-HJ60JeEMA@mail.gmail.com>
 <591e01eb-a05b-43e6-a00a-8f6007e77930@cornelisnetworks.com>
 <ZuMEW9T2qSTIkqrp@p14s>
Content-Language: en-US
From: Doug Miller <doug.miller@cornelisnetworks.com>
In-Reply-To: <ZuMEW9T2qSTIkqrp@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:610:51::37) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SA1PR01MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9d5ebc-6db6-484c-08bf-08dcd3e9ad74
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWljRU5oanU1Q3hkclJDYVpxV3hvV2xyS2IvVmlLZ0cvOXltNWNWWDFtN1Jk?=
 =?utf-8?B?VDBCQ2lxdHFZeFhnSUxhUzhRelgzVjBRcVR6VEZ1c3V2ZmJXM1hadk1aN3pO?=
 =?utf-8?B?bnY0cjlLaFAvVlorZk1xWXBDTzJFTWtqT1JQOHFJcEdqU2tNWmNDWTNMcUEx?=
 =?utf-8?B?aWlXM0FLcDFURGJmQTM1RTlSc1I2QW9yZkVzQ2ZyRnp0TUNPbFJ1K3BONzVr?=
 =?utf-8?B?cWtIZ2NkZnUxZ2N3T0EzK00rU0NXUnNHWU4wWnhNTDJCNkd0NXQwUFkrSnhu?=
 =?utf-8?B?dU1kbnc3a21vdkJsaVJmN0RyKyttS2gxU0FXaFc1dVY2MXNXdHF2a3A4dHdT?=
 =?utf-8?B?UkdtNzBUQURISjRNK0kralFsTWhXZzM2VjlRbU51L3dyT1hCbzhwbW54Tmxs?=
 =?utf-8?B?WUhEdTFOWkJhdDJ3eU9vMjdkckVkaEtxSG9yNllMZkY0QW9ZM1pteC9VYzY3?=
 =?utf-8?B?STNvVVMvMzhEcjFoa3NrS2VDVFh2dENYS2ZpVllMNXRFL1FBZDdscVBFNGVk?=
 =?utf-8?B?SEFzOCtiUS9sdzhUWlVYS0g1eERBSURvZHlwY3ZMcnNlWXhVSHNaNW10RGhM?=
 =?utf-8?B?V0pPa2hTMVYvZThhQ1JLaXF3V0R1RVpGQnhoTDZINklsTlBISmFQSStqMTRR?=
 =?utf-8?B?Y0NZMDZNRk8rYm15aitha1FRcFRoQ1lzQ2p4eXIvOEpwdkx6eU83M1FCS29j?=
 =?utf-8?B?bFBqSWJQK0pXMmd3blJTTk93KzlxMTY0blB3UXNUMUxyOUEweURwcWxhNnpI?=
 =?utf-8?B?YmpzNGdZZ0xUd0lPL0R6M1NqY241Q3RKRHJNcU9IUFJDTmdiem5pTUJjMEJQ?=
 =?utf-8?B?Z1Q2Q3ZDcVhNZVIxT2RjL01YWGlNV3orajZxY21pOGdYd2E1WXNhMnQ2S0o5?=
 =?utf-8?B?YVVoUjhIbzBSYjNpUzBZdkwrQ1hsb05mMHkrc1BiY1FtdjVEYlFXRzFRa290?=
 =?utf-8?B?akJHaG51T0MvRHBmQ2NrRytCNVZtQ1FETnExakR2WG9ZRVdOaHRvYVUwS0RR?=
 =?utf-8?B?UU9pa2c5Ym1rZ2FaYTNCaGkxMUNCSjZiMlNWdzJIQ0d5cFBSeXdDODhjRHp3?=
 =?utf-8?B?RlpZTHplb1dzTzVyczVzZDZCVzB3Q2VXQ2hpekR6WkpGdC9TZ3RsUElrU3pM?=
 =?utf-8?B?dUxqaEVLNEkrVldhRmZrS2Mxa0FxOUZlRVB6amhHc0NhU0NpMjdWVFlPMjRK?=
 =?utf-8?B?Tk5EaCtiNGNZakxCT1pyaEI2WTIvS2NIU1ZXN2I2S0lWaDBYZjVuNzU2TkpY?=
 =?utf-8?B?ZTB2R1UrSHN4K3dCcjByYnF2ZmVCUWFGa1ArUkdXVUJad1JGWThYdlpuVERv?=
 =?utf-8?B?ZlpjMFUwMjJsaktVU0ltZnBiRzRQQldWRG1CdGlkS1FxUU90RERCMXA4a2dt?=
 =?utf-8?B?RzUrS0NRRUNPU2RjLzNsRm9FSlc1RHplLzJKTlFwK2x0R29DR0N0aFBFTG1K?=
 =?utf-8?B?SVloa2wvZjk5YjZ0azloRG5RaEh0cmdWSEdtM0g1NUJuR2dMZE1tRlg4bDY5?=
 =?utf-8?B?T3EzVWxLc1BqSGRDcXpnRHpxZEZaakE3ZTRhallweHNOcmtDdUJ2YUMrMlc2?=
 =?utf-8?B?c3BKZ3hzVURCSG9OWTYwNU9XQ3Q4azFGWVpSWEgzTVFZN2FzcjRDOGhZaStZ?=
 =?utf-8?B?MjJudW5qKzF6WXYyYkhZeWVSY09YOFJleXAxdGw4TjFiYndBNlVTcG04Vnpt?=
 =?utf-8?B?U0hOcDhrcWVLMm5nYWhKZVBKcklmNWtUV1p1UXZzaS9MK2taYUlGWm9HQzNI?=
 =?utf-8?B?eUM4bWcvTlNsMm9DQ1FOU2xVTHhDK0hzOVVreDRuOUh1ejIrS1BEUjVzOXA2?=
 =?utf-8?B?QVBzTEl3MUpQTU5WSHVQZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmZ5N2p0UHliNnN0RjU3eGNXNy8xYURjU0xPUUNyZWFYNTlIcGd6ejU0WHF6?=
 =?utf-8?B?RkN6MW1ybnFjeHpVRHR3VWtFbDFFSUhNZVdiNTFBbDZvTFBzS055TmdncUly?=
 =?utf-8?B?V0szVGlqelJoUHRRQzhtSUZ6V0xnT3NLVlpBT1dMaTV0eHpDa1B0cTNVcFFP?=
 =?utf-8?B?enNSb0F5MnkwM2dWSmJvUDdzLy9na0ZRUXhFODVoRGtLa0ltd0ZQNmk2RXlO?=
 =?utf-8?B?SXl5QnRSam91UEtaUmtCU2J0RGxDUVRhYmRrQnpDK3V1UmxDSFpKWEcwaEhw?=
 =?utf-8?B?aWtjdlF2Q05uZVIyZ2NWNDhJVjhuYnFRS3QyK2pwZlVEQTl6UWx5RThEbXAv?=
 =?utf-8?B?aVRmR2E2bTRYbUxnamRDV1dueUZ3R2ZPamwyazkzK1ZZVnVmdEhjVXRUWjhz?=
 =?utf-8?B?V2l5cWdJWVoxUlByVzRuazU4ckZBL1p1WHAyS3E0VWdIMnpVNE9GaTRaZTB2?=
 =?utf-8?B?T2pIbHM5amRNQm5lL1RzTU9WM2VYY0hvRzF2U3ZNcnJUd0FUT0paWUlsR280?=
 =?utf-8?B?QmhPbFRYS1ljZEUvWFZKR3Flbk9oWUJtYlNLWWdleC9IK21OMWhNQzZrRCtH?=
 =?utf-8?B?OFROenh5cGNlcE42d2h5MkNrczA3bkpUb2dHY1RuZ2lTS01RVTI4NzcydHlG?=
 =?utf-8?B?cXc5by9DTVlnWDAzYnMrRzBuRldQSFFXVEJxL3VrTytlbVN3aU9yRHhOVFU4?=
 =?utf-8?B?aWQ5UWF0L05YWERGL3RQOGIxcGtGTHpKb295YnN4RVFyM0hvbE9xQXUvMDFP?=
 =?utf-8?B?S3p6bFVQN0RRdjkrNThSRlFQVnFNYU1zdFZJZGlDejhBbisrUnYvRWJlNTd5?=
 =?utf-8?B?eTlJdm0rOTZFWExIMUExQVhVL2xzV0VnTzdVM2xqdUY2WkJJdk01LzJ6UzlB?=
 =?utf-8?B?bHdBV2ovcDU3Q3JzRXRMN3pQZWpRUW1KUGtvQ1Ryc01reVQ0RjBSWGlaQ2Vm?=
 =?utf-8?B?M3djMmw1UTZycVpwQURsQTVRUjVpSUtrMVVWenROazNKZ1JINGdsT091RGNJ?=
 =?utf-8?B?aHllNTkrMXIvNW56SlIyNWlOQ1pzRXY0ZU1ySWZ4a0ZLdXNFMjdhbTBKOFRr?=
 =?utf-8?B?dFkwRHJDWFNiSkU3V1hRQkFTbUpVZXZMTllodUV6cGVOSkF5T0t1VzBFYjJ5?=
 =?utf-8?B?cnpyaDhodk9jZlV3K3B0SHNSeW10NUVOdEZRRHhKK0xWZlc1ellHUlM3MWVB?=
 =?utf-8?B?NzV2M0pTb1pOdzhiSEIwZ1liaEJvdk9IdjQ4Mmk0TFg2MTBkL0NmOGZ2dnRz?=
 =?utf-8?B?VFhiNklHRDhzdEFxQVNsa29MTkduY0JXZnFFM1VEbnVXWlp6K3dWeUhiZnZX?=
 =?utf-8?B?SmJjSXJyU1Y3VjM2bHpIY0Y0RUx3WmJ2cDl1bWJkbVhtdlBodk9jSXRDbElZ?=
 =?utf-8?B?RjloTlhNbVNBYjJTTWhRYnFvVzhubnBYdDV1a1pSdkxJbXdpZFNaUmRLc25N?=
 =?utf-8?B?WlU3K1JYU2U0b2V3UzRDTUFNaHR1RzFQSzlHUjR3WGZwL05SbE1Uemw4V1ZG?=
 =?utf-8?B?NndOR0xUbGMxbzRDL0lTd2hVYnd6RzRoWmV2UHJKbDJONDl4S3pUQ1d3QVRm?=
 =?utf-8?B?NmFsOC9CSUp5NVpyWEFwY2tkUGppZzZ2QW45bFVDN3kvNENta3l4LzZqcm1M?=
 =?utf-8?B?M3JCQmJ4KzNPa2Joa2xvYjBOQ3BuRHI4N2U2Tnl4M2x0UjhpdFhrckx1Qmhq?=
 =?utf-8?B?TWd5NVN6d3R3UXB2TktRNm96eTFVcDBaYjV4bDFqNHpjd2FuMVpFeit3eENJ?=
 =?utf-8?B?bjZjcWRSVXYyU0tWSjh0a2dSNHpHUnNpUDBkbHo2ZjNXZlRLSFV1andGcFhr?=
 =?utf-8?B?c1VtTjg1L3I4VnNtK2k2ZDBJbUVxUWM3Z1JOeTdaUzhCdnVhOTZ1M0kyQ21k?=
 =?utf-8?B?bnNhWHM1R2xLcGIzWWpCWVR5SVlpaFJubVo5SUgybG9pRndhMlptYVh3dTJ1?=
 =?utf-8?B?VkQycHI1TVFvbEZJSVBhU1ovNDByZk9ZclFmQjNBbytJbEN1MDlpdGpqVlhp?=
 =?utf-8?B?MElaV3V2cWhMZUZuQjBaMllZMythUi9URmo3K0NpR0RtRjhtWFNPRE9nRlFP?=
 =?utf-8?B?WTNUaThkNTNRZmhPRk84OW8zYVkxWVpVbHo4Z25ZTHVUa21vS05JTXNlWE1C?=
 =?utf-8?B?cUlRMzdHY2xCM01KMG1rVjF2MlF3a1dQZk5FRFRaVjJoRHg2RmptQzBZQUFM?=
 =?utf-8?Q?+1DXWT4rn2htTwwWmpOSQqw=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9d5ebc-6db6-484c-08bf-08dcd3e9ad74
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 11:46:17.2208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQjPSzEbzsmotCNQbcGLcC3k2y/S8sctcXoZodu+NsB0YqmeOf2/UUI02BrM6rPeAkyERzdLmnD5/c0r/TsBPFuplOifXtsWvFsS24krgcqHWXaKGHWWQrLQ719pMB7l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6736

On 9/12/2024 10:10 AM, Mathieu Poirier wrote:
> On Wed, Sep 11, 2024 at 12:24:07PM -0500, Doug Miller wrote:
>> On 9/11/2024 11:12 AM, Mathieu Poirier wrote:
>>> On Tue, 10 Sept 2024 at 09:43, Doug Miller
>>> <doug.miller@cornelisnetworks.com> wrote:
>>>> On 9/10/2024 10:13 AM, Mathieu Poirier wrote:
>>>>> On Tue, Sep 10, 2024 at 08:12:07AM -0500, Doug Miller wrote:
>>>>>> On 9/3/2024 10:52 AM, Doug Miller wrote:
>>>>>>> I am trying to learn how to create an RPMSG-over-VIRTIO device
>>>>>>> (service) in order to perform communication between a host driver a=
nd
>>>>>>> a guest driver. The RPMSG-over-VIRTIO driver (client) side is fairl=
y
>>>>>>> well documented and there is a good example (starting point, at lea=
st)
>>>>>>> in samples/rpmsg/rpmsg_client_sample.c.
>>>>>>>
>>>>>>> I see that I can create an endpoint (struct rpmsg_endpoint) using
>>>>>>> rpmsg_create_ept(), and from there I can use rpmsg_send() et al. an=
d
>>>>>>> the rpmsg_rx_cb_t cb to perform the communications. However, this
>>>>>>> requires a struct rpmsg_device and it is not clear just how to get =
one
>>>>>>> that is suitable for this purpose.
>>>>>>>
>>>>>>> It appears that one or both of rpmsg_create_channel() and
>>>>>>> rpmsg_register_device() are needed in order to obtain a device for =
the
>>>>>>> specific host-guest communications channel. At some point, a "root"
>>>>>>> device is needed that will use virtio (VIRTIO_ID_RPMSG) such that n=
ew
>>>>>>> subdevices can be created for each host-guest pair.
>>>>>>>
>>>>>>> In addition, building a kernel with CONFIG_RPMSG, CONFIG_RPMSG_VIRT=
IO,
>>>>>>> and CONFIG_RPMSG_NS set, and doing a modprobe virtio_rpmsg_bus, see=
ms
>>>>>>> to get things setup but that does not result in creation of any "ro=
ot"
>>>>>>> rpmsg-over-virtio device. Presumably, any such device would have to=
 be
>>>>>>> setup to use a specific range of addresses and also be tied to
>>>>>>> virtio_rpmsg_bus to ensure that virtio is used.
>>>>>>>
>>>>>>> It is also not clear if/how register_rpmsg_driver() will be require=
d
>>>>>>> on the rpmsg driver side, even though the sample code does not use =
it.
>>>>>>>
>>>>>>> So, first questions are:
>>>>>>>
>>>>>>> * Am I looking at the correct interfaces in order to create the hos=
t
>>>>>>> rpmsg device side?
>>>>>>> * What needs to be done to get a "root" rpmsg-over-virtio device
>>>>>>> created (if required)?
>>>>>>> * How is a rpmsg-over-virtio device created for each host-guest dri=
ver
>>>>>>> pair, for use with rpmsg_create_ept()?
>>>>>>> * Does the guest side (rpmsg driver) require any special handling t=
o
>>>>>>> plug-in to the host driver (rpmsg device) side? Aside from using th=
e
>>>>>>> correct addresses to match device side.
>>>>>> It looks to me as though the virtio_rpmsg_bus module can create a
>>>>>> "rpmsg_ctl" device, which could be used to create channels from whic=
h
>>>>>> endpoints could be created. However, when I load the virtio_rpmsg_bu=
s,
>>>>>> rpmsg_ns, and rpmsg_core modules there is no "rpmsg_ctl" device crea=
ted
>>>>>> (this is running in the host OS, before any VMs are created/run).
>>>>>>
>>>>> At this time the modules stated above are all used when a main proces=
sor is
>>>>> controlling a remote processor, i.e via the remoteproc subsystem.  I =
do not know
>>>>> of an implementation where VIRTIO_ID_RPMSG is used in the context of =
a
>>>>> host/guest scenario.  As such you will find yourself in uncharted ter=
ritory.
>>>>>
>>>>> At some point there were discussion via the OpenAMP body to standardi=
ze the
>>>>> remoteproc's subsystem establishment of virtqueues to conform to a ho=
st/guest
>>>>> scenario but was abandonned.  That would have been a step in the righ=
t direction
>>>>> for what you are trying to do.
>>>> I was looking at some existing rpmsg code, at it appeared to me that
>>>> some adapters, like the "qcom", are creating an rpmsg device that
>>>> provides specialized methods for talking to the remote processor(s). I
>>>> have assumed this is because that hardware does not allow for running
>>>> something remotely that can utilize the virtio queues directly, and so
>>>> these rpmsg devices provide code to do the communication with their
>>>> hardware. What's not clear is whether these devices are using
>>>> rpmsg-over-virtio or if they are creating their own rpmsg facility (an=
d
>>>> whether they even support guest-host communication).
>>>>
>>> The QC implementation is different and does not use virtio - there is
>>> a special HW interface between the main and the remote processors.
>>> That configuration is valid since RPMSG can be implemented over
>>> anything.
>>>
>>>> What I'm also wondering is what needs to be done differently for virti=
o
>>>> when communicating guest-host vs local CPU to remote processor. I was
>>>   From a kernel/guest perspective, not much should be needed.  That sai=
d
>>> the VMM will need to be supplemented with extra configuration
>>> capabilities to instantiate the virtio-rpmsg device.  But that is just
>>> off the top of my head without seriously looking at the use case.
>>>   From a virtio-bus perspective, there might be an issue if a platform
>>> is using remote processors _and_ also instantiating VMs that
>>> configures a virtio-rpmsg device.  Again, that is just off the top of
>>> my head but needs to be taken into account.
>> I am new to rpmsg and virtio, and so my understanding of internals is
>> still very limited. Is there someone I can work with to determine what
>> needs to be done here? I am guessing that virtio either automatically
>> adapts to guest-host or rproc-host - in which case no changes may be
>> required - or else it requires a different setup and rpmsg will need to
>> be extended to allow for that. If there are changes to rpmsg required,
>> we'll want to get those submitted as soon as possible. One complication
>> for submitting our driver changes is that it is part of a much larger
>> effort to support new hardware, and it may not be possible to submit
>> them together with rpmsg changes.
> The virtio part won't be a problem.  In your case what is missing is the =
glue
> that will setup the virtqueues and install the RPMSG protocol on top of t=
hem.
> The 'glue' is the new virtio-rpmsg device that needs to be created.  That=
 part
> includes the creation of a new virtio device by the VMM and a kernel driv=
er that
> can be called from the virtio_bus once it has been discovered.
I don't completely follow. Is there some KVM configuration option that
causes the virtio-rpmsg device to be created? And then our host driver
will need to be able to respond to some notification and dynamically
adapt to each VMM being started? I'm not getting a clear picture of how
this works. I'm also not clear on the responsibilities of our guest
driver(s) vs. our host driver. For virtio I saw there was the concept of
a "driver" side and a "device" side, and the guest seemed to be creating
the driver and the host created the device. The rpmsg layer seems to be
more complex in that area, so I'm not sure what actions our guest driver
with take vs. our host driver.
>
> Everything in the virtio and RPMSG subsystems are aleady tailored to supp=
ort all
> this, so no changes should be needed.  As for the VMM, I suggest to start=
 with
> kvmtool.  Lastly, none of this requires "real" hardware or your specific
> hardware - it can all be done from QEMU.
>
>>>> hoping that RPMSG-over-VIRTIO would be easily adapted to what we need.
>>>> If we have to create a new virtio device (that is nearly identical to
>>>> rpmsg), that is going to push-out SR-IOV support a great deal, plus
>>>> requiring cloning of a lot of existing code for a new purpose.
>>> Duplication of code would not be a viable way forward.
>>> Reusing/enhancing/fixing what is currently available is definitely a
>>> better option.
>>>
>>>> Our only other alternative is to do something to allow guest-host
>>>> communication to use the fabric loopback, which is not at all desirabl=
e
>>>> and has many issues of its own.
>>>>
>>>>>> Is this the correct way to use RPMSG-over-VIRTIO? If so, what action=
s
>>>>>> need to be taken to cause a "rpmsg_ctl" device to be created? What
>>>>>> method would be used (in a kernel driver) to get a pointer to the
>>>>>> "rpmsg_ctl" device, for use with rpmsg_create_channel()?
>>>>>>
>>>>>>> Thanks,
>>>>>>> Doug
>>>>>>>
>>>>>> External recipient
>>>> External recipient
>>
>> External recipient


External recipient

