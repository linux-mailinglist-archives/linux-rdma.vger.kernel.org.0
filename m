Return-Path: <linux-rdma+bounces-13381-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2808CB58333
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 19:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EB97B22A0
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 17:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DEC293C44;
	Mon, 15 Sep 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PlUNacmv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B261FBC92;
	Mon, 15 Sep 2025 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956588; cv=fail; b=IGTL84j4y3c++ob62XzG5PqD0SS+pL72ddNVMK5MgEa9KDyelewJnKipArj5gpZMpbHg+pWx3TzgcpBd+gcIQR+Sa+50sB6/2Z8bfvzk51C0381zWt1P/NsE93vPWeN9PbGuawhGF+yd3cYjct9f0mA0yg/rsaMnexsC99XyZ6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956588; c=relaxed/simple;
	bh=EIZlXexuhwTK4uXdco6/SgErNgYC/2I1duqtGGQYdTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7KhC8Fehm/tVB3J+eS0iYZmKUsoH54BD/zc37bSR0/onmPfu2ezPkjnLnlWS1j+SMjBYNFFmoXbBaL0PFEzzpFKapQy0CQL0DqXYB7JZeafpXEc4HswpCD/zzhMuCUGnhrEzhXzfsGtRfXXTC5KJo3zoAe8/8Ny+KzJ7m9RFGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PlUNacmv; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDArtF92J4H1kLLn51tf1ThsOsM/yvE6DYFswu/zTxrj7NdkdYs2R8d+cueFxE47q4pumOBXqVc3hP//FCYCVWWtl91WKJb3PPEWa+Bs0PJ89iA5UJrWApDHF44vm5oyxjxtJTGn2E+z8YMOjx1j2DWRcioFIL2V+kBoasB4wd+ac5NA2vshe5XQKcJoKJfk4S3ohogvzwXqWq34KHJq8ebCfsvK714Z8YFk1k/ySrwgZmw+6Eqz5IF7pYYmebfDnJTw4YIPC3J0o+5E7iPwGLthKIcYW9Rv/GvpKQKpB4tQTXU8h+s+A/ZW0OWKJdrQz3qXgd+CL/c2nt1Et0vwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNqE87MOOdsw+oc50ksW/5lPDvI9sb9esXO7lKrS21s=;
 b=h3rrgnGAo+Tcfn21WZ/Iiihhwdd98oS1Iuyw+BDPI1UmlThtB5WPBfB2cEdc7HK4UP1yvPWpGIluHcNqjYUGwwnOBDfxC5bS5bgs6vLMK6W55XK/eWLP7mvGZg2YCwN+EEEE1F3wsvZJ5fgqv1k5qnEk1SfRp9886e9WLTYRzgG9S24b8+jCSgnA7jjUwx9Izr0yNLM+F+jJ/7dG17tb8vkioq2V3uxdH7OK89h09Qpor+TZjYI9Svv0Ed8CjnN61HFeRb5n41QeOghTfliNbh4qijsQtPz0vyaOd3pHDy0jrphEereHduzRxh/Q76GcqNWlQztEziWg1bzKPO/chQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNqE87MOOdsw+oc50ksW/5lPDvI9sb9esXO7lKrS21s=;
 b=PlUNacmvgUq7ONmJsyc6+puT6fUZfihUezrrkAenOjGeL9PwsxGd64/Nq39TGqKATfNDlYn5qVWLnepM6cxJVGbGRxgceNE4bKPj84fmBVqlnEOYfExQAuWhDmbUQJ43wUBvI+ZDtQxa5CA9wbk+n5GAf24E+K2L/B3tn9l/PRQMUAZzI4CIPe4HGPc8Q6Qb/Z68QQvU1LNYM6AGIj5lXPl+S0prrFjo5eGXsZ0BOz1yxpiPGNu6/+kE35FOzVG21EoH3CLFSn8UxtNXQ5oJolHvYg+7KYJcJBFvbZk5YxUxjSR+qgkyEs5WL6WZorEnDLB026jX7n8OGbbP2U8B4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 17:16:22 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 17:16:21 +0000
Message-ID: <09b53dc4-79b2-4933-abcb-4b414860cea0@nvidia.com>
Date: Mon, 15 Sep 2025 10:16:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] RDMA/core: Resolve MAC of next-hop device without ARP
 support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Edward Srouji <edwards@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Cosmin Ratiu <cratiu@nvidia.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>,
 "kuba@kernel.org" <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <20250907160833.56589-1-edwards@nvidia.com>
 <20250907160833.56589-3-edwards@nvidia.com> <20250910083229.GK341237@unreal>
 <CY8PR12MB71954BE7258390B4B7965E8FDC0EA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250915163002.GJ882933@ziepe.ca>
Content-Language: en-US
From: Parav Pandit <parav@nvidia.com>
In-Reply-To: <20250915163002.GJ882933@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To CY8PR12MB7195.namprd12.prod.outlook.com
 (2603:10b6:930:59::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7195:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0d61bb-407e-4044-1f85-08ddf47b978f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rzd6djRiVzg1QVpYSVowanM2SkJKS3dITTdBUVBvcnc0TnppUFlOOXlZTEhN?=
 =?utf-8?B?eDZib2p2VFFkSDZCOHA3K1lqNzNSRHBEbXZ0cFJEZ09aRzg5Z3E5VEovb3pJ?=
 =?utf-8?B?OTkxNEQrNG55OWJ0dEZaNC9DcVM3UVozaEZ4SVpTQm5Ua0FiMktnR2RZMUk5?=
 =?utf-8?B?elJhMXY0NWtUQ3FWYThqRUQ1SUhFeHJtbEJjN245Z3JwNHZreW8zZVV0K0p4?=
 =?utf-8?B?WWRHcGh1T1RMMFU2ZDR5Tkp6UnZOajVxZjJGNU5DZzVwQi93VUswME1pNDl5?=
 =?utf-8?B?eGZhY1VwTVNFTlZKRXUyYlVSNEVob2FnNTkrcVpUZzg0aGQzRTdJZHhaelRV?=
 =?utf-8?B?TzlkZWdXQkM0ZHJYeTFjKzE1eVJoQU5JM3hMQjdoejQwUEN5TjlVb0hDdzM4?=
 =?utf-8?B?U0pscG5DbUhEQnFBTUNCeko4dStMSjVPVEIwdmVCUUYycXl4WkpnWjFIZ2xS?=
 =?utf-8?B?UjFQWElieFVreXlxdDFSZGs3NGVuTEZiUldkUkhmOTFxY2N6UXRIM0lhSnRW?=
 =?utf-8?B?N3JkV0RYWkZ1S0duSnIvcHlaYW5vZFdqdnZ2WWJPTGdoTDl6Sk5Nd0dyREtW?=
 =?utf-8?B?U1ZiM2JCWVNKTEsvWEkxZ3RNWE9ESGdkeWhuZGFGM3VpWXBZNi9MRzI5NlY0?=
 =?utf-8?B?RG5EejE2MUROZklJdEVqQ3BsM0c1cTJlN1MzMVdhUmJseXFhVnYrcCs3OHB1?=
 =?utf-8?B?UzF4TDk5VFNoWWxjby9iNERTejI5SEk5bk9lZ09sdFpucFhLQmNNY2UrNUlH?=
 =?utf-8?B?aVN3WEczQVhmR3lCeUw3NW1OQjkydHJqSGlrYVdnaGhNTXdxY0xNeVV5UkFH?=
 =?utf-8?B?MFhGL3kycXpNQ1l0YkV2cW94NkxsUGpoRVozeWdHMGVseDR3NkRISE5ENHZ2?=
 =?utf-8?B?R2E2TVpwKzVvSmdERWZNT1dCaUFmN284SjR6M3I3OWIrOXUzZFgzR3NSYmxu?=
 =?utf-8?B?UTR2Um9SbUtxQTZXeXlYUW9lQnVhQTIvSStiR29XTHFUbjFjdVNvVzQxV05C?=
 =?utf-8?B?ZVBZRFBnTTFRdnduM1kvL1ZxY3JFUHVvcXA0UHdjSkVOdHFJUnIvemZ1aWRY?=
 =?utf-8?B?MWdhbVNINFVOWXNTM2lSakM3dXlHbzN2V2tLc09lUWgxb1NjNENPdVluTkx5?=
 =?utf-8?B?UHErSVl6UDM0RjU0WU1LU2JrOUtORFV0RUpvSHJVY05TT1NiRG1yZUh5b1pn?=
 =?utf-8?B?c2duWC9ML002NFcveWZvOHRXYkdnUklablJLUVNLV2hRWXNOSmxzZ3ZoRWtJ?=
 =?utf-8?B?M1hmSlRJcEYyd1BxakE0RFl1dE5KblRveFY5UUJKUGVBTm5WSWtUU3MxOTVi?=
 =?utf-8?B?MlNMNFFvMmNJRFA0RVZITXoyNlNZYW9MbTNZTmxSeUR6QTlLYzBNYVJncTJh?=
 =?utf-8?B?K0lZdUhjVmROd1NSMERLcGJkbnRBdzA3RndMZHcyZ2MvMTlQNVdxUk8wOVRL?=
 =?utf-8?B?dWtYMVptYTBzRjdQRWR3bHZHeG8rbkw1eFVjZFRsM3VGSXlRaDZPRUFNa0pR?=
 =?utf-8?B?c3E2QTNNdnFzVlMzTTVpazFjT29CSTd0czJZV2FZaU1HNUk1dlNFRW8ydTJX?=
 =?utf-8?B?VlgzMm5DM0JKMjVKeTdDdlJRYU00TUZJd0hVU3k0YWRkSjVFUkhleUxjaFE5?=
 =?utf-8?B?QjVsck1OSjZoMHlEWCtQR2xXZ29tOXh0ZkorVE5ZSE5YZk9xNGpSb1F6UDk2?=
 =?utf-8?B?b0lYcHFWZklMREdoWEZvclR0V0ZYdDgvRmUxenE1ak1tYUFsNHhaTjZKOVJM?=
 =?utf-8?B?QVRuVEhSQ1hjSWxXbE80V2dIMTBkaVN6bmxsbnlWenJ3Zllsa3dYMUtsUU1W?=
 =?utf-8?B?WFFNWmdiQ2RhZkRialJSZ2Fkcnl6aFV4OFlxU0xyYlJkTWIyY2RhRkdZWUEy?=
 =?utf-8?B?MWNBbXVVUE8vTlFoa2RBQThXZk5ESzFUajRuelNsU2RyQWpGY1pmd1J6MkF4?=
 =?utf-8?Q?E29vaaIAxjo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmFvVHRrVzRDSnN1R2dGQ2xMUDBoR2oxMWkzMk43ZEtQSlVGRGJMZ1ZCSE0r?=
 =?utf-8?B?UXdBK1ZSN0xGeXJjeVNGcXM4ako5d0dlaVoxNkpldWFHVkJjdG1QT1BvV3VZ?=
 =?utf-8?B?WWVXQVpXRGRhMUtoQ0lpMHJjRVNNU0lMQjFkNW5hVzJMVHcxUlVSOElnTDlm?=
 =?utf-8?B?aGh2V09WbW9iczRFbGRnVXp1MTdJd0ExUm9ZWFVnVmxNbDBOd3Qwa0llcXpY?=
 =?utf-8?B?MmVvd1dFTkk1ME5ORks4bnk5Wjlua0FnUEFsRVBzcnhEY3Z6ZExNQklwK3Zl?=
 =?utf-8?B?TC96RmZ5KzlIZTZsWjhNWitsS1VRektQcE1EWlNwRGptSDFzUFZXNm44K2pX?=
 =?utf-8?B?MFRCVHU0N3dQWFhtaWJKYXJyMlU4VGtXZTBTU01sSVdIc0FyVE51YlBMZHpy?=
 =?utf-8?B?VEp6ZytLMjd4c29jWWdFZGdya01Sa045U1hoSkRQNFBOZ3BqSHQvTHZvVzZm?=
 =?utf-8?B?eDhNV2F0c2FsZFFCOXVLQ2ZBVzhleWt2TDlveDZ0aWlYQkZGQ2hEQkJqT0JO?=
 =?utf-8?B?WUFETmhnd0VSY3NKTUNIY1VWTHlxT2doQldIeGJ1WHlIT0V4NzVPcCtpakdp?=
 =?utf-8?B?SytkQTFBUzBnN25OV3NLUjlWSlE1WVpuMjB5TUR2dHVsVmNyZHcyVzV5Nmht?=
 =?utf-8?B?azZmYXNoTXVNQmRmUWoyZng4QzNlNHpjbkpzSXZKSzRGNVdmUGgyM1hWbjlU?=
 =?utf-8?B?djY4bHB5bURYOUxtWW1rVlFNSlJibnhTTElkN1IrcmNVUE5nbUlGMmZHNjdo?=
 =?utf-8?B?cnpSVysxT0RLMFIwRWZodkk4Q3NpSHNDL3U1RHBzSDd3ODM3dWV1V0lFc0Rj?=
 =?utf-8?B?aFZXSGZhQnQwWHVaUWpEZGs4SnNzM1hES0VGNkFiZGhFbWhwa21qNlNCaU9u?=
 =?utf-8?B?bVAveWNjL3lrbGV0cHpCNGNaeFRzN2lma3M0RU9JK0R2OTJ0bnNHTmxJRkQv?=
 =?utf-8?B?M3I5enpqUElRS0E4TFdDQzgxQXgrYi9PTGw2SmYxQkoyM0x2OFdxYjNyN04y?=
 =?utf-8?B?eGlEOElwYnRlQVpuUUpVYW4xL204WHlSMTdydmdQVlNteVhtamdBY0lJK3ZK?=
 =?utf-8?B?VDhZVDN5ZGV5aDZWbVBJWVp5dkp5bzVhYmxDKzc3U05Nc0FDeXNUc0dxK0o2?=
 =?utf-8?B?eFYyaURPdkVFcXV6a1p3MVBteWFTakVJUDJFQWlFUTZHVG5DbGNuczFxeHdT?=
 =?utf-8?B?Yk5lckNGeE9PL1VZQ2xBZ29vcU5ZbDRVZm11aGxkaTJCSUUxeXYxeWRLYkRX?=
 =?utf-8?B?M01EQnc1TDR4VGRHMnFGK2dqSlo3ZzNzcTJ2ZXNES2k4MGhrVEFyU1hWYi9q?=
 =?utf-8?B?elh5Z0dsS1RUdWM5Z2JTMVcwOW0xa1RzRWIzb0YydFJBeVNpekpHWmQrZnE4?=
 =?utf-8?B?aU11NkFHTXVYVE5BK3VzTlJnRXJMUk0xVXNtZUc0SzRabjZFNEZaaUNmc3Y2?=
 =?utf-8?B?TEZ6a2ZLS1QvNWJMRFFISk5YdE9OS1BUVW1lN2Qzb2hDazRkaThxWXRrZzJt?=
 =?utf-8?B?cmFhVWs1aFpWT1VyUzZGU2RNMGdzbXZxbUZtQXB2T2ozd1AwN2Rld0RTRThm?=
 =?utf-8?B?b3NCVU9ZdlhPZm5xMXlWa3BsTXlGbCs1c2NOSVlBNytHRForelltRXBPNmxG?=
 =?utf-8?B?SjRTU294VitZRDRwQ2Znb1FxSVZZa2JXRFN2SE5kMWViMG96RWhhYU9NQ0VF?=
 =?utf-8?B?Y2g3eDA1RStDam51VnZkSzZJejNSaTNYSUVXdWdaSXk3SE1MQzlqZWs5WnhZ?=
 =?utf-8?B?QTVveTVRSXczdTR5c3I5eWxzV21GTkhhNVFZUjgvc3NNRVhEN3h1UjJ1bnFT?=
 =?utf-8?B?L3pGSzdtV2JSSjd3eG8vV2pEVlZJL0VXNFVPbmZ0L1NlYVExUTQ5M2RjMEc3?=
 =?utf-8?B?VithaTNobmxGVklPREVDM1VreHk3TlEvTjJ5K0xtbkI0Q0J3bVo2V0lsaWlR?=
 =?utf-8?B?K3ZqZmg5VDdNNk1KaHBMZTZGTFRnOTR0SjlrVFdaYXR1TFNGWWZhZ0Jwc2d4?=
 =?utf-8?B?UmtqK1FQemRvbFJaZ2JmQjhpZTlFTUlQaHBmcUFVN1M0cFE1TjdXYVo5Smtj?=
 =?utf-8?B?N3FrWVkwWVRPSDhvbmRDSWNJTDU1YVhHZkJVRWpQemJ3NWduOG5JWGk2cGVU?=
 =?utf-8?Q?cMJWzyHY5WGH91pz4IAb31O2Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0d61bb-407e-4044-1f85-08ddf47b978f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 17:16:21.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gezCzVEfbP/7sKcY8aWptidldzUqdVBveGKKeGMz3vPOjDA+AzkRzvXh+INY9oybxjP2em7yKTO0CP7EpgUvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442


On 15-09-2025 09:30 am, Jason Gunthorpe wrote:
> On Wed, Sep 10, 2025 at 10:55:36AM +0000, Parav Pandit wrote:
>>>> This leads to incorrect behavior and may result in packet transmission
>>> failures.
>>>> Fix this by deferring MAC resolution to the IP stack via neighbour
>>>> lookup, allowing proper resolution or error reporting as appropriate.
>>> What is the difference here? For IPv4, neighbour lookup is ARP, no?
>> It is but it is not the only way. A device may not do ARP by itself but it relies on the rest of the stack like vrf or ip vlan mode to resolve.
>> A user may also set manual entry without explicit ARP.
> I think it was just a mistake to use NOARP this way in RDMA, I looked
> in the git history and there was no justification. That or it was
> right in the 2.x days and netdev moved on to the current schem.
>
> I expect to just call the neighbor functions and if they can't work
> for some reason they should fail?
>
> Jason

Right. This is the patch does, to rely on the neighbour functions to 
resolve without depending on the NOARP.


