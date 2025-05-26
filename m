Return-Path: <linux-rdma+bounces-10739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04734AC4579
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 01:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485F93B2EE2
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 23:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A585241CA8;
	Mon, 26 May 2025 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VAwnIYCG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F10A20330;
	Mon, 26 May 2025 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748301128; cv=fail; b=q9g7v2JFP6uPwr1TYh1V+WDY5C1YTCt54iMRwesyuSsVsPlaxSJvdCQz5CY9aQPAEe3Gcd8qeUudXLwCaJN9fa/dokbd9zChD2mHaSQV8vPddiTnH20AuNOGVCjRWPivN4HBN9ln6bjjhQysfLJKZacKA/SrQ8GnNL7wqcBI6yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748301128; c=relaxed/simple;
	bh=MHrAAyNOx0Cs9+mkHjGnXJvkaVz1xvygQSbNYH+OoWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HN2RSCz2aB3TciDJWKaImWQSZfqtTm6zctDc09GSNhGe8ZLplzr5nMaWmEeYxfq19lNvjXfq8Mpml3m5jc1bGEXgMg2CFc5jSkORhtkt/gni2OK3wolata1qXs2K0yPkQ+Wy2v3WjH1ANFzYx76C/um6Rtlbjy373ITmb7Am+pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VAwnIYCG; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2S+3LHCiV104ssoLFlTE3QkS5uYh6rA01pJJrsVT5BxOvRFzGCjWizzK24h5MjZXsA3zdbFm3Re5JsADbv7AtN7EQzr1k0reyCjzv3u5R1U/UFXsFSL2RIdn/2tiE0A9jweB2B/2Q88ZkJo4ZodJh5IoFBQad2mCggIGdgib25nHz5pLleVNK8OJfllTmPFKQtpsBqm6a9fsSPBi8bT7+9n9kM573LHPgfLzp6ZVPS8fr3rqJHX0zI2y0FlcLXHjGKX5CiDKAusFBt1KtzQ7CO0fR0+DYFRpRGrBWyst7Z+yxXi2AGk5Mc7gGfm7iYbUQvitCaa474D6LyqyvVj6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1ouVxAI8xr5FVOgB9b1QE3BQMZRwhjgP+G7A6WLaN8=;
 b=q9WJ1/yFgxx/L6yp5nx2j98aX9ZZ8+3X0gU+ue8q0eB9bOpqGu4d1PjGRBcHk8gJTxt3Bh5K9l6qhf3n+1IuhT+jlAaMvt1eM6kS2arVqH/1VhpgoKnY7oMzJpMY92tz9aoxGjAhEyhqazzFHmbO0S8w+7jgyQvlnyezxr+QHMzghFM9BhqNG87lp5TFDHHXhJFTBLwfrHJXrd0zuXtC6OV7BL5E51JxvI9hbUArD8zWPo7wogZMXwb9YNGHjV+cg0EnvWsK6Z9HZuBmkS3PEpKG5RLqKv0Y5CSE2H2XhPwIz50PsMrnsckao5Fh6Oy+pciEJS8IOzz4NDohZ9TKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1ouVxAI8xr5FVOgB9b1QE3BQMZRwhjgP+G7A6WLaN8=;
 b=VAwnIYCGKps+uyarKOCiVBjuR5O4w5ViPJmVFNdk0GjDLF8/8mj53/Mc1fHk4YBieDjvGs+qorJp6CjLyswV2Lo4vIipsL8YzFdyTzISVMlYtfiX1+svZxdqThJLeZKEU3vdtJ3r0lXWoNhAh293xamU1YvhHfcURiL5Tba/w4GY++KyKGnQywAoiX57VPig7r2An7+EJVvRvqUt9RsAWT/BFVEO92UPmjlKk01ZKudQMcvTj6yY3AM/W+ijIVGAjyY2+zn4620onqBv2Ow1wRGHJ6DJuQe9tRJAZgxPhM0+WDCJwVcbbN8PK2Pt9RlXTtEE9woZqdhQhoAQ1cK1yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 26 May
 2025 23:12:03 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%4]) with mapi id 15.20.8769.021; Mon, 26 May 2025
 23:12:02 +0000
Message-ID: <bc1406b6-3082-4073-9523-b1bf35cb1908@nvidia.com>
Date: Tue, 27 May 2025 02:11:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net/mlx5: HWS, make sure the uplink is the
 last destination
To: Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>,
 Gal Pressman <gal@nvidia.com>
References: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
 <1748171710-1375837-3-git-send-email-tariqt@nvidia.com>
 <be4c5d3d-f2c9-4a09-96ec-0b25470ef9f7@redhat.com>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <be4c5d3d-f2c9-4a09-96ec-0b25470ef9f7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To IA0PR12MB7722.namprd12.prod.outlook.com
 (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: e138db4a-15c0-407e-3c41-08dd9caab95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzNZbnovbGlxcGVOM3hMZ1VYWnI2K1paVWhQaEFnb0dGVmdleFdIekxkS3Ni?=
 =?utf-8?B?SmptOFIxRzFpZXNZUzNXWG5FVEIvQWVoemxXQU9MbU9CalNMRHB2RVdXRC9p?=
 =?utf-8?B?bTFEL0NUK0RMRStiOGJNSGJUZy95VnRic3k4Mjk1VVFwbVJDRmRlYU1ZaWdt?=
 =?utf-8?B?QlhxVE5XdHE3UjNma0RKZXdOMTBrM0tDWElJdDkrZTE4Rzh4OVdQRkV6Y2lW?=
 =?utf-8?B?dEFWaUtCWU5BSmdQdUhiTW5yVmpIRkRqaXFzUllHRjRQbDc4SUU0NzdzTnVy?=
 =?utf-8?B?czBDOC96aGt2UjJWMWZwNlMxNFplcWpTdDNldi9yUnFKUjI2YVJlZmUzVWpL?=
 =?utf-8?B?dXVpZWlydzMzNElFOUo5WVpTYmdFd3NoTFBudlVLS1Zvd0pBN1prNkZhZ0VR?=
 =?utf-8?B?eEVSOTYwZUp3cmlMTzkzdlpWeFNTcmNvNUNJMUNOWnNMbTVoZkZRK1pmQ2FM?=
 =?utf-8?B?bE1pZW52K2tldGpnUFZLWFpvODNxZE1XcU5rL3B5NXpobXRJQnU0TjRBOWQ3?=
 =?utf-8?B?VDNIMDl4cGNqMFdsdUVlYnpRRTRjVnlWYWpDMTBFUy9MZTBWQnJZaEUydm1S?=
 =?utf-8?B?eVdlN0FNTlAvZ0lxSEc5L0Z3THJyaEFnaFIzOFFvMXZENTBUUUVKU0UwODQ2?=
 =?utf-8?B?Tm1ydGxoTW1tbWtzNTlnektkbktpK2s2VlNhbFc1enlqcnpLN253OFIvVS9Q?=
 =?utf-8?B?bjVGcmdtWHc0QWVQQ2k4akd2YjN0SWF3bnkxVWxqTWlBc2R6OXdmMzFQL0tT?=
 =?utf-8?B?aStnTE5hc3ovZ2FqcUhxZ1pWa3VpLzN6SFpGZFgyeVNkRU5IWHp5L1JNeERU?=
 =?utf-8?B?ZEEwNjFJV0NoUjFyMnVqZi9WWlh5NUp2UmcyeFpDc3g4NDhzb3crQk8rd2F0?=
 =?utf-8?B?SHd3ZktURkNJN09mVlZSeDNsc3BmWjQ3bjFSVHB0bU1FVTVhSk5iTEZISWFu?=
 =?utf-8?B?SjV4YXo4akU2RkFNT0VsQ3IrTTdyWTNlV2VTeHF2V1o2cWlOWjlBNEpGekU0?=
 =?utf-8?B?aWVYaU5MVFJydEZRdGZiSmhFOHBZNjhSNjFHNGY0ZEpma3kxdHNoc0lkNEhI?=
 =?utf-8?B?YXVkby9pSTk4RTkwKzZOdkRpdHBCRlhkYkFVYzRLQWFRSW5rVGdyNXlKSzd2?=
 =?utf-8?B?UUp1blBUZXdaNmpOUngvWFQ1YkpIVVBuMlllblliQUlHWGFwSzBBMlE5UEs2?=
 =?utf-8?B?bDNhTUJxTHdkWWxhY1g4cVh4U0x4cFgxMXNJajA5UHdXRUJzdUFEWHVmK2hO?=
 =?utf-8?B?dTA0OWExaFZDSEVVKzAxTmVYb09qakY5S1UzSHVobVFpamdyYm52MXVuSnQ0?=
 =?utf-8?B?YjduWHM1VGl5eklxbjRiRTgyK1VZNGVicExPUG1TUzJGSU9SMWY1ck55MDBu?=
 =?utf-8?B?eWswTi9vOVpNREw3eHUrdGtJaEpxT0dHeWdpVnBEcnRwV2xKY2RhSlE4Rnln?=
 =?utf-8?B?bjhRSjZXMVM0cUhLbUJuQndZVFVUeFFnZEswUkg3TFdiOEgzWDZEYVdCWnhy?=
 =?utf-8?B?VkF1SExhZk1zQ2thZDcyZ0hEQi9iZ2FaTlRaSkxuM3UvWnJNR3diTUIxemJY?=
 =?utf-8?B?cDhicjhodm9HRjl5eUJhMFJNcHhGVEw3NCtFZmxUM3lJaUJPVUthMVFPa1BI?=
 =?utf-8?B?NWR0MGhtbjNScklic2dEaDRFZmVZYndTNVRlMnNISDlHMzZhTW04NHQ5TVVx?=
 =?utf-8?B?bFFJbW9taTB1MVdMY2VsR2NiK3JhbHZ3Tk9pNkZwQjlTYk5LRDV6UTJsTDB4?=
 =?utf-8?B?ZFc2TkxQYmhxQXNlaSt2Ri9hRlR5SEJINU5LUStuTENYaUVwNWVZSTFnVHZY?=
 =?utf-8?B?UGpiS2ZqRGZjeWo2U0VaQThsVWRxSzd0dURpRzFjcUh3RXJIQTgxZlQwQldh?=
 =?utf-8?B?S0lMS0V3dURjNVlDbVgvN3hVbTlCcU8vVE1FMU9BN3h2dGFHUmZKVzV0eDdH?=
 =?utf-8?Q?cr+iqLwOmHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXZleVAvZG5nbzh0dU5YUklZYW5iWHFNY24yNEcxQXh6VzJ1R1JNWHdLMW05?=
 =?utf-8?B?WlZUdGVDSFBZeklPZzIxbnU2czhuL0pBL1FteVVGR0NTU09aaGRycmNNdnZz?=
 =?utf-8?B?VTJWUTBJTWhLTklBVUlUYkpXVVhRM3NLeE9EVi9tZ2U2Z0hHWDhwVXVKemVS?=
 =?utf-8?B?SnFVSTI4VmRTVnUxYUdQOEhqdnNFRW9QaDcrZGd2NVBLOEtGVnNMLzZHcnFv?=
 =?utf-8?B?dDY3SGhJd0pyNkZrL2VPdWdEMDNKZmN2WC9NYUkxaUgxYVUydUcrb0RhTWpx?=
 =?utf-8?B?ZkordkZNMm9rOWhYYTJMb2hoc0ViZGhkaGMxU0NoYkcrNHc5MzRlZXhyUW9p?=
 =?utf-8?B?elJnNC9aZjZNOXhDdjQxTG84VEtMVjh0enpmRlFKSW12VzNUN1BxdFozbFNt?=
 =?utf-8?B?MFNnY3NOaVlaN0FGMWo0b1dRcHpCY1UxUG5RNE1NclRNclFCd2JhWjRCTFMz?=
 =?utf-8?B?OXN2djBVbGd4cm4xczBQMXVLcnd1NHVqRlBVV3VmVDg5SWU0VTkzckdzQW5D?=
 =?utf-8?B?UGprZXAxRWpBcmNoaTBBWUZpcVQyOUxPbDJJbUNwTTdlOHZyWmpxNXFCa05T?=
 =?utf-8?B?S2NSMnFzRUZpckJhNlVZZHVnT05tQW1GVE1MR0t2SGc4Y1JuQUFzZEdBMm8r?=
 =?utf-8?B?Z2htaVBYeUhsOFVpRkJ5dVZNU09jVjJLNUExTVIvOXAzRE9pNkxKNHp0cmtT?=
 =?utf-8?B?eE5RMEpBZmMwWjcrc1NQaG1NL1NSa0RFVUlHN3hqQzlhUXJCVytzYU43UnZu?=
 =?utf-8?B?d1BwT1pQVGZMY05DcXhka0o2RVZ3SWY1M1RvNDBHemQ5WWFhN0RJMEhMTzZY?=
 =?utf-8?B?cDVKdWZqdEFkcDRoVlRBcnJpMy9Tb0tFMkl1d3diazQ2U01KMWxaa0tIay9E?=
 =?utf-8?B?SjdpV2NrSGpWQjVTWU5jQmNzM3NqSnZOcjE1azV5SXdYaklpUlJrNEtNZCtL?=
 =?utf-8?B?dFN3UTBJR2M4ZHB4WjBKcDdjUTBRcmVIV1ZoQUpDR1FndG9QbXlzSXlMVXJJ?=
 =?utf-8?B?akVnNEt6dUE0eWpaeFVxeDU3Uk1aeWVqa1AvUC8yaGRoZmZCL3VBNUhBRDZR?=
 =?utf-8?B?cTRzT2t0TGJ1Vk5SUm1Td1ErZjZ1aUt5U2YydmY0K2RpQjBodUUvdithbUtE?=
 =?utf-8?B?Qmx3R0VXVFo5VW9Da3NGQmFQM2JKeGZnLzBqSWVNTzBOVEtPVUJnd25iaG9m?=
 =?utf-8?B?c3h4VnpuVC9tMjdRRUNBQTMyWlcyTzJIcjY2TDc1UVhTYTMxUUVWNmRRREwy?=
 =?utf-8?B?WU81U2x5SmNOTDQ1YThLdUZmVGJVWDN2WmMwSmJqMXYyZ3I3eGF0UkpUb0JV?=
 =?utf-8?B?UzVqb012R0hnYTNkQjdUcGErUkY0TWkrNXFVYVlaQWI4MU5rS1JXMDZDM3dk?=
 =?utf-8?B?Y3pyT3pBNWhWSGNPaVF2S1ZGNzR0MzBDd0tpRkIzZVhSWjlBd2dRcSt3N3Y3?=
 =?utf-8?B?dGZhdHM5STZuL1pHc015eVNES2xibFdCSWRNaVFUMStLUXYyUW1jWjBjQmlh?=
 =?utf-8?B?akNLeGhHYW9vWWFhWU84d2E0ZDlsUTBpUWNNTlRTMk9MY1FnczFZcXp0a1hF?=
 =?utf-8?B?T054TWIrRS9QODhJWCtya1pjWW0zS3FERE5CMW9OalQwbURhdytmQzRQS05n?=
 =?utf-8?B?dHViSDZaTkVrN2pKWDU0Y0prL2lMTElhY2pCM3dBRGpwYWszY0hzbzB1OXVq?=
 =?utf-8?B?UzZXZVFRLzZSVEgyRlN3eTlnUytmZGE1eHJybElIM1NwRWtuTEMzdDd0VzVG?=
 =?utf-8?B?clMwa2pvYjBQNVZ3WEhia09Yb2plRmpwb0QrbHBVcThpa0NRVUxDeHVlWWFO?=
 =?utf-8?B?akhwM1Z3N0Ftd1lnaCtoMExpT05oLytyTUZpNlRNNG5lc1ZZWWhMd21WbmJu?=
 =?utf-8?B?NXQwem1TMCt2aHVCcXYwV3FlT2NxVWJtbGtkaGZSOUxOZk9ScThVWTg2Tzkv?=
 =?utf-8?B?VnBKQXZXSEVLSlBQcTZ2MVk5cVVsLzQ1TGNiVno1djRZakt1cXpYdS9hSUZB?=
 =?utf-8?B?c0J2S0QvMDZQcHEvQ21IdERsc2FwYzg1WDMxeDNQVXFVYm91Y3JiYm0xT2NF?=
 =?utf-8?B?YjNoMmxHbFcyRHNEKzRrQ04yUjBXZDBqSFptYndscWtzYjJFZkxrWEdKRFll?=
 =?utf-8?Q?SOmrJ3MxI57zJ1yB2WrMPIaRs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e138db4a-15c0-407e-3c41-08dd9caab95f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 23:12:02.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVSbEBsvrZ6VsNoCOc8xXL4ajJKGDXDa8RH21qie/DhadyTTDsaINFdCW2A24CXlGqspj1clQR5BWPz0L46NpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216

On 26-May-25 09:39, Paolo Abeni wrote:
> On 5/25/25 1:15 PM, Tariq Toukan wrote:
>> @@ -1429,6 +1426,14 @@ mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
>>   		}
>>   	}
>>   
>> +	if (last_dest_idx != -1) {
>> +		struct mlx5hws_cmd_set_fte_dest tmp;
>> +
>> +		tmp = dest_list[last_dest_idx];
>> +		dest_list[last_dest_idx] = dest_list[num_dest - 1];
>> +		dest_list[num_dest - 1] = tmp;
> 
> Here you can use swap()

Indeed, thanks.

-- YK

> /P
> 


