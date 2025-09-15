Return-Path: <linux-rdma+bounces-13351-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D79B57028
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 08:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2197A9245
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 06:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A386280018;
	Mon, 15 Sep 2025 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nngjbTab"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855D1EEE6;
	Mon, 15 Sep 2025 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917393; cv=fail; b=JHC8JKicz435k0gcRFhyqbMW6r/c/ucFgvUWN1KIAP34hdj/F6+arkLJkdoFPyrt9ogNM4nn1k8gMsJr+vUo1TEQZ6fI6VRfW6AG/VwYjLsgy7C46AdKvaEreAZoqaG1iee+MxIujkxz9Qc1EhLK34J2Rxg7D/ql7hxHaFa+a7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917393; c=relaxed/simple;
	bh=UWZqV3f1Tt6PjxTXPH843a5sAE2ZAu4Q/54wD4FK+Uc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MrjgDVf9Y+RKnGVaiTt+Vs/Q7Nj9zZ9nS+XLeE9eWF0PiNoPhxMOSkB1FcUzto09ihWsjPJUB2vmAkKBWsiZU6ndqF/qmyQhL283V83SP4yDViCZJz3JXhpZ8rUxqA8XlKEjca14HQVCc+U9KddcB5RXPje7WtKaWkAKoIZvo/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nngjbTab; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grrQf759kZl3mweSUJfACRYbP4eYdnBZPBhTr9VsUKltdLN7XKrmJnBMeIExW5MJC0YzM1EfNQKRi+wShloGiCWss95tNe1kHQPJ5tJMJJVzs2cy0/Hu20ZP4GHIMpxS1HkHKkpwT+E7tu1BAzxPvqeEwiF8qVwkQXOx4X0fLgLrKojmhwS5b/0izJoUQpP+qZ0DicF6HsDXBMfsrvTjsnyQU1ZOsYrutL0UgTg0mwWbHBZD2jCKHs+qcuDz00EsuHhMPTWLlOUX1kGqr0v/rpZzPXNcrhKb/nv0FV2UoMG9csOrGxbRLzwSi9MozwD6H1DvBKNEQEs+awt2pueCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eY5z3OKkCWWpTdjmbsomcd4ftl0Oe2E6YuTcnQP/Zqc=;
 b=E+dCTggl0+d+p0dLkS+gUj/Jf73rAcKCCOis1teIspEdU8K+hM2ygO+78BcnwSAHDaEuPNWln+cu4pMLdCm56EXT7ceBaw83SYF5n3IAc84cAeOvlUfEhf8Gx41azwJvxZYISEfWkjatAUR7LoRLzR7VlA5Fp9QI9+PLB/FtjgKsxhNEerDC8o3hQVsa5pc3yWS/NE4FRFHJ5FnGjwyaoLzilpe9Zqmg+jMzZRQxuzy9/rbFUnlWtqbaj8XPmWCBp5b73Z//gqNOX44rViDOeWpt7dvxU70oZMsCAwQhvhA6xo9ISN67LWBx9LGVTP3qj2leK+8EvS+ULQhcpSSW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eY5z3OKkCWWpTdjmbsomcd4ftl0Oe2E6YuTcnQP/Zqc=;
 b=nngjbTab0+85LpoJAhrAXzKEf8Mffi+kViW2bqfnCdNeAZT2qLfxVewwPWiXACKuWwSsnDcr29PrfAcONuOiHk7TxlpIFJx0nLVapusGZPqf6nnRciaM504smlkpu3D+oSiTEvI/2lxUMYMt/n72QFKUoI0WRej0CUdhWhTPw7ZvmJE8h7e+8numcee4dQKvIhjd+AQDb2NPRCuEQPdVr2ZFLT8XDiP63zTfZAY6xg2PxMN+Q+S5CoudwLy4sQNzTytc0q7mssPoJ+rzKQWGQhjyXcWFGMrURlmADS2eSVNXaT0W0pWAZf6qq3EtLfDRZ/noJi+x/9oQ4R/hhdTFtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 06:23:06 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 06:23:06 +0000
Message-ID: <153b22be-3cd4-4ae8-9091-923e4e0018f2@nvidia.com>
Date: Mon, 15 Sep 2025 09:23:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next 2/3] net/mlx5: Refactor MACsec WQE metadata
 shifts
To: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>
References: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
 <1757574619-604874-3-git-send-email-tariqt@nvidia.com>
 <20250912154926.GG30363@horms.kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250912154926.GG30363@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fcc074-e621-4efd-ebb7-08ddf4205557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDFWYmdiZTE1S0VPY2tIUEtsZUNFNnJyVHMvQnpMdFR2bW5BaElBWk9sSlpr?=
 =?utf-8?B?c3pYYjRmbVhXeTdESWkyT2M2bjhmNTFKaDRUZVEvZDhBRi91b1VPWnBmdGlZ?=
 =?utf-8?B?MXhDWmt4ZHFCVFNpeitvNjBZbGwxeWtqams2K1JGRUlOakxPVWkxY3c0Nko3?=
 =?utf-8?B?cFBuQ3kxb2FJRENtVTZUaVZFN1NIUHE0Sks2enVLWUxZdUtkcUhDZUQzejl0?=
 =?utf-8?B?ZHZ0aHpWNnlmeWdkUUtSbVpKck1xOVZrZXlpRTUyMzBpNy9sOS9ka2JMdGpO?=
 =?utf-8?B?YXFhRmlHekV1MHlEaFhvS1F1MXJiaGR3YXp6RUhicHhqL2FkNDh3dDZsTk9i?=
 =?utf-8?B?bTl1WGZtc2VMc3ZIaXZGZC9KWGJuRktBZFRoZzA1SURvc0srazhPb1pmM0kv?=
 =?utf-8?B?NVRTK2RrbUk3OExUS1ZSYkhBQTlHZ0g5aEJ2NmY2Uld3ZThqMzdyODR2OERL?=
 =?utf-8?B?clZ0Q1owYW1PRlJDL0FUQ3R3cVhEdkxjYnltR1R1amlPekhaZkZFck84RTkv?=
 =?utf-8?B?bEg1WitiUnFXZzVIMVI4OW1ZdmgweFB6QXhOVk9rRENoTnB2bEJhWXJTV2tV?=
 =?utf-8?B?K0s4V0VoZXFCOUtXZXh6c21TR1ArWXRVVmdJY2c2MUEySXAzckhGbVNLMDFI?=
 =?utf-8?B?VThneE1aakFQK1JOekZUZElRYVVzRlJqVjRkcHJLTURFQVhjSTRYTEIvVW5T?=
 =?utf-8?B?NUZPN2tsejZ5QVdTQU4vNnRuMjJCZHplU3V6dmV3NWtvaExlSkRhUG95a0hS?=
 =?utf-8?B?RmYrZEtTN3Rma2tkYUxsck94V1BMcm5KRm5ncWpnY0l2V1NFRlo2YXJlSGwz?=
 =?utf-8?B?UnZ3ZWVuOFJCZmVQM0M4MzB1dXVyZGRtRXYzWFppSGJGay96ait4cGlQUG1K?=
 =?utf-8?B?ZG4ydEx3cm9oRnkwdzQvd2hvQkMyS29jRUdnTXpnMGUwajh5dXlnM3c2NlRj?=
 =?utf-8?B?Mkk5a0ozQ0RhTkI3WHJPU0JKdWhweVlHVXdOVjlFOUpYZGVrVHZ6VHFQU0Jj?=
 =?utf-8?B?ZHQ2Z0tUamNFeUc0ZHloV0xqWHR6YjZJR2ozclZGcDZxQXhDbmpTZGxvMkdD?=
 =?utf-8?B?em41Q1ZuZXpPb0ZBenprMlBuUkxsdHU4aEpJQ05hN0FtSHhEa2xXT1IwLzZE?=
 =?utf-8?B?RjRoVWwwMnBoOEkrckpZUGxwUlZhd3R5MTZlU1p6VkF1NHVFZ1d2azlwUzly?=
 =?utf-8?B?THQ1eEhDa0tocHFUeURRMjNHaGVJT1RXQ2JXcGplTTV0UHc3SjBZdzZYamp0?=
 =?utf-8?B?WHUwRkpoaXpHTktRU3A4ZEVCRDBsNmxTbmwzR3RHbHBRaFlMdGxOb1VpZHls?=
 =?utf-8?B?ZEFvMzFKUjA3MC9mZjR2bDBQbm5vWmN4OG5xVTBUTnFZNEZ0VnJndkwrOWlj?=
 =?utf-8?B?c052VnZMc0hvNmoyVWFNbzJVc1FJcldvcmRlVzcxTHM1RVBVeTlMd1pKQ2xG?=
 =?utf-8?B?VXhObjJneWhGdElSSGtZSVBlMkViYkwxcEZCWnAreDFCM0lNS3BSd3kycXdx?=
 =?utf-8?B?a3psTVI3cHVBb2VjOVJpQU0yRnpEVkZFTHRyOGh6UVJFMkxYTUw2ZzNPMUM3?=
 =?utf-8?B?RHdSZ285ZUhLaFVJRmdCWW9Fa3N1YktkbTcreGlWc0NyVng1ZlA5czFDVEdr?=
 =?utf-8?B?di9oMkI2N1g0VTBWZ253MzNSUXB2eXBoK0kxKzJ0WVk2QXVCSERLWVF3TG0r?=
 =?utf-8?B?bDV5emt4eVpNWGNxOWM2c0lqc1FXRlc4M1JSYkErZVhlUEtTdVQyRHlvRXdV?=
 =?utf-8?B?cUo2aVgweE1reTJEdnp4Q2EvR2plamRxSVVNa21ObWpZZXh6eS9jWjJ1dFl1?=
 =?utf-8?B?VDlhWnQ2MlZWbk1nMmFKdkxES043em5ZSEF1LytrWTBqbTlienJ5QURTbVN4?=
 =?utf-8?B?ZitlZ3BkbFNYeUtrdkVRV3FoY3poeGVYdFRxdWU3c3lEV1ZEVjBBK04vWS8z?=
 =?utf-8?Q?bX8ixqq9LeA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTk2STY3NmVnUmhmWndISmdBcG5zNmVHVmRWcVNHZVFYaWhIKzlMMjNTSUdV?=
 =?utf-8?B?b3BCQjlRZnJ2UDRUM2VuYmxaNUZrVWo4M2JtWjNyKzkrZ2dQRzJKc3RZUDdJ?=
 =?utf-8?B?UEJRb1lpWS9idllsai8vTVBaWklEUUo5OVVVcit0R1IxMnBaRFdHTUV3c1ZC?=
 =?utf-8?B?M2FQYjJ6dGZHYTl1eldBZVVJZWx4NWNPbmRLQmxxOHcwRDIrZ2hFRGFoVU9Y?=
 =?utf-8?B?d0crV2EwVGVCTXZWczdLMU1jQmtQeWxHRkF1ekpmcDVTMkJFb3RsVlI4c1du?=
 =?utf-8?B?OUxJMzhpK1FuV1orN2JtQno4dEdyUWlNSjVFWklPTHZtSTk4MXhZS3VWdlAx?=
 =?utf-8?B?ZXkremMzenVMZ0xXK0xYRHM0RVNSNW1tRXlZWS9IakdHYUV3WU5IMXNVbWZL?=
 =?utf-8?B?QVFENzNTTnZRbkMvbHBJTE9zZVJRYmVnZ0NNVElYUmlFTXZKWW8wQ3dUcnZu?=
 =?utf-8?B?Z1dEYjNhTE05Ylh6MnRuV1g3WUJzU1FzNGRpRzYvaE4yU1RaNERYcVpzVlc1?=
 =?utf-8?B?R0RnZ2QwU213S3Z4WFNmTHRYUTV2VTM2Q1JLSU1EeHBkTlhRM1RvTWJIVnJn?=
 =?utf-8?B?YWs0NVZmR2hDcUZTczJETUJJSGJkTUFKNjhQZG8zcnNZMVNueERWV2ViQ0tv?=
 =?utf-8?B?M0NaZFVSUlZpVTJGUUd2TlpQczhiY3lMdG1aRFMyYWI5dDV6cDFRMDA2YWxa?=
 =?utf-8?B?VkE2c2xIWnRBVndDbVU2Tk9tejFJVk1USjVTUkxSSCtCbERjOE54Nnd5RWRK?=
 =?utf-8?B?bGVRbXZrMWVaK1FwVVhoZS9YQUhwdklQeDJCYk9Wc0VTNW56R2wvY0NVdnpp?=
 =?utf-8?B?S1dpcGpjSHAvQjcrTlpxcVc1L0tmR3pKVWRtYkREWEtNelhCVE83Y1N4U0Z3?=
 =?utf-8?B?bllUZklKa0plVkx2cVZXQWZWWDNlT2tkZ2N5dTREWG5qaVh6OC9rWGJjWmE1?=
 =?utf-8?B?bzU0cmFkRzhrRXJFZ3hWT1gyOFNEdEZoY3VnZXYxeWxQOW9Zd1lUZVFnYTBv?=
 =?utf-8?B?WTFmSzBYUjRUS0Zla3pMSDNLNDNlSGlYN2dUd1o5Q3Zoa0x1d0FSMUUyZ3dF?=
 =?utf-8?B?RUl5UXg2ZDl3azMxY09ibm5OM1ZvN3l5UmVlTVUvVDlEN2RQRGFOM0ZoWmwx?=
 =?utf-8?B?SW5pK1lEemhpY29CZStoSUVRdUo1aG9DR1pEbEZGbmErWndLUUoxTWdqdzBw?=
 =?utf-8?B?bFhhcXhKT1FVRlowUkhQNUthdGhvRzA5S1B4WVNXbFVVY3dDOG1QTEROOXYv?=
 =?utf-8?B?VlVtOGt0QmRNcnNoVG0yUTJHWG1NZU9vWWtNYTlJUUN5T2VJRzkwbGNBNGtX?=
 =?utf-8?B?VGxRNEVUbExCUStJbGx6YU8xMkRMa0V2TjhVUmg3UEoyMlpxM1Eydm93cnZh?=
 =?utf-8?B?ZDZBamoxb3luTHo5b2JJRUFaUUVtMmFHUkFnWXFIMnJZKzNNOE9KVlBRbzlw?=
 =?utf-8?B?YnduS3FleEhDQzdjTTl4NzVxTVA1bjNkMGVtTU5HMGRqd2VadENSVitFc2Jm?=
 =?utf-8?B?blhDU1h2QVVVVVVtWFhqaFNsWDhSeTd4SjNNWE5La3hHVmczMnNEczhRbzQx?=
 =?utf-8?B?QXNtemNMMnhCWFV4SkJ0NXgvRm8rQjhqbU9vcHl6R2FOWVhJK3J3OW1FYVRp?=
 =?utf-8?B?NWxoY1ZJK2ZZK2VCdUdQYUllMHR2b1ZPVHdxQlFyek5rMWk2MWhFVjJiWWpn?=
 =?utf-8?B?UUsrbjlSSjBibDFHVUdrVDhzS2tuYW9abHQxYXpVYWpacWxobG9ObFRHa3B0?=
 =?utf-8?B?blkybFFtejBUaUpnUWk5VDdGd3pKaitubWplcXk5K013bEkxSGtVa3JvTnQz?=
 =?utf-8?B?eGZMZ09oYWxjbDc2eWk3emFFT3M5Unc0aG1nY3pTbEJkemtXZ05tc0ZSclIx?=
 =?utf-8?B?YkNqbnFaSUpneGNVeEh5UTV2VGovcUwxcUNDYmlOcUZ2bUVxK1ZraUNzSGc0?=
 =?utf-8?B?eURHeHpaVVhxa1NpcE1RL3k3ZEd0TDBRUzUrK2hTYVpuMTZRTURDKyt3S0Z5?=
 =?utf-8?B?dWNRQ0hvL1dhNHhmc2g5ZFYzaTJEZ0FXVWxIR0xOaTJXZW53VGVaY1FoMG5z?=
 =?utf-8?B?K3NlNEV4TS9oYkk3b1F3TTJxVG83YVZSTWs2MzBObXE0SnR2TndXRmQvSExs?=
 =?utf-8?Q?0iN6grFkXSHjPeXVQKkE66HJF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fcc074-e621-4efd-ebb7-08ddf4205557
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 06:23:06.7648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPvw26YKq6qIw5wAdCpGnc2bL1ObWvpoQo6MBKkpNgcx6RvzDn/08quFgff9YkFpLLXKC9kaoiY7B7jdSGY1Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF


On 12/09/2025 18:49, Simon Horman wrote:
> On Thu, Sep 11, 2025 at 10:10:18AM +0300, Tariq Toukan wrote:
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> Introduce MLX5_ETH_WQE_FT_META_SHIFT as a shared base offset for
>> features that use the lower 8 bits of the WQE flow_table_metadata
>> field, currently used for timestamping, IPsec, and MACsec.
>>
>> Define MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK so that fs_id occupies
>> bits 2–5, making it clear that fs_id occupies bits in the metadata.
>>
>> Set MLX5_ETH_WQE_FT_META_MACSEC_MASK as the OR of the MACsec flag and
>> MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK, corresponding to the original
>> 0x3E mask.
>>
>> Update the fs_id macro to right-shift the MACsec flag by
>> MLX5_ETH_WQE_FT_META_SHIFT and update the RoCE modify-header action to
>> use it.
>>
>> Introduce the helper macro MLX5_MACSEC_TX_METADATA(fs_id) to compose
>> the full shifted MACsec metadata value.
>>
>> These changes make it explicit exactly which metadata bits carry MACsec
>> information, simplifying future feature exclusions when multiple
>> features share the WQE flowtable metadata.
>>
>> In addition, drop the incorrect “RX flow steering” comment, since this
>> applies to TX flow steering.
>>
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Hi Carolina, Tariq, all,
>
> I'm wondering if dropping _SHIFT and making use of FIELD_PREP
> would lead to a cleaner and more idiomatic implementation.
>
> I'm thinking that such an approach would involve
> updating MLX5_ETH_WQE_FT_META_MACSEC_MASK rather
> than MLX5_ETH_WQE_FT_META_MACSEC_SHIFT in the following patch.
>
> I'm thinking of something along the lines of following incremental patch.
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> index 9ec450603176..58c0ff4af78f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
> @@ -2218,7 +2218,7 @@ static int mlx5_macsec_fs_add_roce_rule_tx(struct mlx5_macsec_fs *macsec_fs, u32
>   	MLX5_SET(set_action_in, action, data,
>   		 mlx5_macsec_fs_set_tx_fs_id(fs_id));
>   	MLX5_SET(set_action_in, action, offset,
> -		 MLX5_ETH_WQE_FT_META_MACSEC_SHIFT);
> +		 __bf_shf(MLX5_ETH_WQE_FT_META_MACSEC_MASK));
>   	MLX5_SET(set_action_in, action, length, 32);
>   
>   	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_RDMA_TX_MACSEC,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
> index 15acaff43641..402840cb3110 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
> @@ -13,18 +13,15 @@
>   #define MLX5_MACSEC_RX_METADAT_HANDLE(metadata)  ((metadata) & MLX5_MACSEC_RX_FS_ID_MASK)
>   
>   /* MACsec TX flow steering */
> -#define MLX5_ETH_WQE_FT_META_MACSEC_MASK \
> -	(MLX5_ETH_WQE_FT_META_MACSEC | MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK)
> -#define MLX5_ETH_WQE_FT_META_MACSEC_SHIFT MLX5_ETH_WQE_FT_META_SHIFT
> +#define MLX5_ETH_WQE_FT_META_MACSEC_MASK GENMASK(7, 0)
>   
>   /* MACsec fs_id handling for steering */
>   #define mlx5_macsec_fs_set_tx_fs_id(fs_id) \
> -	(((MLX5_ETH_WQE_FT_META_MACSEC) >> MLX5_ETH_WQE_FT_META_MACSEC_SHIFT) \
> -	 | ((fs_id) << 2))
> +	(MLX5_ETH_WQE_FT_META_IPSEC | (fs_id) << 2)
>   
>   #define MLX5_MACSEC_TX_METADATA(fs_id) \
> -	(mlx5_macsec_fs_set_tx_fs_id(fs_id) << \
> -	 MLX5_ETH_WQE_FT_META_MACSEC_SHIFT)
> +	FIELD_PREP(MLX5_ETH_WQE_FT_META_MACSEC_MASK, \
> +		   mlx5_macsec_fs_set_tx_fs_id(fs_id))
>   
>   /* MACsec fs_id uses 4 bits, supports up to 16 interfaces */
>   #define MLX5_MACSEC_NUM_OF_SUPPORTED_INTERFACES 16
> diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
> index b21be7630575..5546c7bd2c83 100644
> --- a/include/linux/mlx5/qp.h
> +++ b/include/linux/mlx5/qp.h
> @@ -251,14 +251,9 @@ enum {
>   	MLX5_ETH_WQE_SWP_OUTER_L4_UDP   = 1 << 5,
>   };
>   
> -/* Base shift for metadata bits used by timestamping, IPsec, and MACsec */
> -#define MLX5_ETH_WQE_FT_META_SHIFT 0
> -
>   enum {
> -	MLX5_ETH_WQE_FT_META_IPSEC = BIT(0) << MLX5_ETH_WQE_FT_META_SHIFT,
> -	MLX5_ETH_WQE_FT_META_MACSEC = BIT(1) << MLX5_ETH_WQE_FT_META_SHIFT,
> -	MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK =
> -		GENMASK(5, 2) << MLX5_ETH_WQE_FT_META_SHIFT,
> +	MLX5_ETH_WQE_FT_META_IPSEC = BIT(0),
> +	MLX5_ETH_WQE_FT_META_MACSEC = BIT(1),
>   };
>   
>   struct mlx5_wqe_eth_seg {


Hi Simon,

Thanks for the suggestion!

The goal with this patch was to clearly show which bits are used for
each feature in the metadata field, rather than compressing everything
under a single mask. That’s why we chose to explicitly define MACsec,
FS_ID_MASK, and the shift separately. This way, its easy to see at a
glance that MACsec uses bit 1, and bits 2–5 are reserved for the fs_id.

Using FIELD_PREP can work, but it hides the bit layout behind one
mask, which makes it harder to reason about when multiple features
share the same 32-bit field. We wanted to keep things more readable
and maintainable by showing the bit assignments explicitly.

Carolina


