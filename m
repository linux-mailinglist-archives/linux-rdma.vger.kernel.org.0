Return-Path: <linux-rdma+bounces-10865-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF86AC73FB
	for <lists+linux-rdma@lfdr.de>; Thu, 29 May 2025 00:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A375E188FA8E
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 22:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138302248B4;
	Wed, 28 May 2025 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lDo9H+ut"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA52222A1;
	Wed, 28 May 2025 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471190; cv=fail; b=V5aqXVx9yqe5tCZd5bCA4zqNyuHbVB+bime6lAas74l5l39L7aRR/2ki2v3CGf878GjtH8fBJRnAqkCfgsPhetmRTSep/P8yEDMQXc6vAIUcp1JM625Df3zOYAbEI1F6x/6Cb/idakGMLORuGjcjvY+V7ujzNiBYJyZI+5ynGhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471190; c=relaxed/simple;
	bh=tO+yuD6bF+DpL9nCS8DOW1VipKPOi22Vk04heMZbduQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PiVAqB0NcQt7qnQzSsJgY/fUm4ZEeaUSkio7V1icjpE0lhzGhDZN9ThDFPuoyLW8rXy+DTwwCrGQvDAVn4VvLkkeVBGEHKdWbB9xw0W7K0Hio5jOgLU8Vp0dfZT8+xzZ2L/W43H/rlV92ffTaQeqkMMZtnKy0nIQRcB0dPVZg2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lDo9H+ut; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ7F7Zpm9Uj/qI7DSNuElACvZHY64HVLnjNJcLYbn6aVMU/U50LLnqj7ONQpJHdh0ggQ+nMHSxTwZvRo4Bt3JhqexBzl0IV5ovk3F2t3FvWVAY7CXy/M3NISlTWye38zeosd4kDnaK52dS95dchO/BBRbeYTBGHUlmtRvyroIHCyILD4kneZ7sMQwRYw4esm+yysFb8+OKORC3aHGIn1t2tQXCASXzAIdDmCY/dYWwxQNwzTm/9hw5MiLQCqSQpSzVoV8F3tNdh6O7JFWlN9BLZsNtf3tPZO3Ttu6gkpxIV6iCfP4lwHd8UlJhQq6Pxyk8IxtfiGUlpTqLYYg+m3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDYY4sbDdbxs8vtbGqhF2viy9Y4TgAcHhggBODzE15c=;
 b=uILXQIOa0VCpwsc4iI4+f+BjnOhdP6TTW63L6LtZumz/BFEjZIUuFNJxYj9Uq2wfuSPW1OGpNhYtjG+ZxXuIy6fufvrXgbY7NCpg6AADzSAQ8p2XjE+vygDSLM2Vi9WD4kI9Cm1WONZ3phVz7aX4F47sJ9euqAAZUpeMydiNCpKg1u30MhReJsAcr8M91SXWDhm4PUS2WgMeM+Akh4am8qVh5Ftok1220MVwARHYxCx8KuZUJIjYdKyzlv2HUgiGQWwLWhcswIaFCdoaLL1KIV48dO3gOmzg6KS/7k5OBgQsbDGAZXQ/hEAOSbZ8uwIUqaJufYsIip58muTy9BAHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDYY4sbDdbxs8vtbGqhF2viy9Y4TgAcHhggBODzE15c=;
 b=lDo9H+uthysSzgyHj2GTfTfoBuN2ItMFZSQ6zy9NSrQxojgSKDfaOBItrAhztrWQT05b4Qy/j5ifeiLlfjpcixqZtqqkdjm8404oZ37U+kHuJmJSn7hcXp9fwbxxkpRI4LSf34gRP5QWBLCLa0A4RFnuPCn89jOM4NNI/2cigTDFeuqxMx6yKReeAtzmS/GlbpiRzaFGENFyjiMwIG6OsRbi6Fma6fdOY0fO1Aol4zoQoVfPOhHLdtYqeDQ/Yp80gTE016oc64bJJUutsLgTX8ICvYadOuOYB1dUj02n2jkRFSHJUdxuCKKYbraN0YqYeO492Cy6IdFxlOOPdUXk2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 22:26:25 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%4]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 22:26:25 +0000
Message-ID: <782913be-5e22-4b4f-9867-26a6019271d9@nvidia.com>
Date: Thu, 29 May 2025 01:26:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: HWS, Add an error check in
 hws_bwc_rule_complex_hash_node_get()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mark Bloch <mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Vlad Dogaru <vdogaru@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aDbFcPR6U2mXYjhK@stanley.mountain>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <aDbFcPR6U2mXYjhK@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To IA0PR12MB7722.namprd12.prod.outlook.com
 (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f75066-6d10-47e7-25a1-08dd9e36ae77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NER0RGZ1anB6ZE1za3cvOU45aVpyMTB3WUdUNW1CT29ObnRVbFlYcnJBQ3cr?=
 =?utf-8?B?MEViU0I3ZHVmNkRGenJsUFg2andzcjJ6N1FyUkhxRTJUNStVOUJHY3Nlb201?=
 =?utf-8?B?VFJOeFV0L05YV1I1cVZGenNTd1JaZFJpS2lSa09WRzFEV2puVHBXcTJFMWk4?=
 =?utf-8?B?bFR5YlhhVUZlM1hBb3ZMMGRQNDZQeWFvUHJHTFJJenlOanE5a1RVbTMvZmts?=
 =?utf-8?B?dWJtSjl4eHhJWlpLRUNnRWcwSGtoY2laQi9uckEycnhuRnhQWkhXVmNFeE0x?=
 =?utf-8?B?c1pSb1RpWkVFYTdyYkwwcExTTjZIVVBsUEI2c2JYSVNsanBEczhmdnlXRUdz?=
 =?utf-8?B?K0g4MDVKRlk1VVRFcFA2U1FqMXZXaTNrK0E3bXFET05XcUZJYUpwT1NzYy9i?=
 =?utf-8?B?OS85VDlwSUNaTnE2MCt2UzZveVZVQVV0SkgxSTdObzl4TmF6NURFelNkRkp2?=
 =?utf-8?B?S1lwdzBvZEdCdlhTaFV1bVNyUUppMFRQZmc2SG5zUlQ3cUpwSHI0cFd5SlFW?=
 =?utf-8?B?SUF4R0xIcmpPNWdaSldoSXFZOVcxQ3dZaUtmQWFKNHVOMkY0OGRiUHk2S0w2?=
 =?utf-8?B?d3EwNlBPbUV2V2NmS0JyejZQcnRUTU8xSVF0VXJDbythTERTTXlWYjQxRFJk?=
 =?utf-8?B?ekpUcFlJS2d3eXRhQ0NrUmRyY1gxcjNma1ByR1ZtTEpZRnUzYmlXNE4xRWVE?=
 =?utf-8?B?SGZIS0xTTnh1RDJHUDEyL0gweXZDV2JaamFJKzhtZk9KaHV5b1Y5RjVlT2c3?=
 =?utf-8?B?NmU0UVdIM2RRVXZraGpaQk1UeFg1aFo3YThtbENTU2NMd0ZSQ1JzNjJqT3pW?=
 =?utf-8?B?bzRVcnp1YmVNMGhVNGxyNmVCdmlVY1ZGY253clhacWw0UjdGQjkxUnhHeUxB?=
 =?utf-8?B?aGowYjJVM1hSbTQ5cHdnYkd6TzdSM0pYN1ZkYUxRczFsMXZVVmFCV3JFaDZ5?=
 =?utf-8?B?aGJlOW1kVWZOM3kzVkpmZ3dCNDY4ZjQweU1kR1ptQ2pNZkI4SFJhV3JiWlR5?=
 =?utf-8?B?alFobThMNWlKTkZBMjRFeUdxMXhFd0U3Y0NzblVJZWVhUVNhNU9rUVZ1d2tE?=
 =?utf-8?B?UVBNK1ZvdzFwRWF0bThFS0dadThSMGF3QVF0VXZQTnI2ektOZXk0ZXFtV3kr?=
 =?utf-8?B?VkRzZEh6eCtUUkpacHd1dWZ6dDc2ZGY3WGt5Q0VGSGpjRkpqaWNTNlBMNHNI?=
 =?utf-8?B?cHQ4Y0ZTUUZJOUJTamV2NU5FbFVlWWttWUtMdTJWYU5DbEJqNk9jczV6Wmd5?=
 =?utf-8?B?c0ROOEhCS2RWZFBQZ2ZUcTQ0SzhKK1pOaXk3N2YvNHdWU2JUZUpUQnI4aXgy?=
 =?utf-8?B?eFp6aUxINGFsdVFMdVZXS0MzQWZZa1k0dzhjam5mZ3NsUXAraXlkRi84MkxY?=
 =?utf-8?B?bmxsTzZOUDFWSVlBRkdSVGZzZ1Y4NFo0NmJjemcxSHhiYktYb0s4eG1kWHVP?=
 =?utf-8?B?VnIwNHJpa2REODNTM2Fhcjc4b1JXU293bEw1NGNOSTkzN1ZtdmFiSDR4Y0Jh?=
 =?utf-8?B?a1BscTlWZEYvMVN4WlhxQ2IrY3p4NVV3VDdIeStXVTBJTE9RNmZjNWtmbXNh?=
 =?utf-8?B?Vzd2T2NVOG5QUHN6QitBOFZhUWU4M3ViLzhKS1JIbzBVbUsvRVNYRDQ1SVdm?=
 =?utf-8?B?Sll6T1VWS256UGVlRUR1VmlMdGFwQUU2cEhBTXJmMUpST3NmUE9xTUxOOTNq?=
 =?utf-8?B?WVVQeXFadTdYZlllT0NkcEVPMmRLMG9YRW5tdkRJcENpcjh2WG1ZTmJNbjNR?=
 =?utf-8?B?WUJUSGVtUXB3QU9iempNUUplYVVDSkJSVzFwNW1hVGl2ajRJYWJqcTFMOWx2?=
 =?utf-8?B?U1hTeDlPc3NkczU2ekpDYUM1cnBaQVl4TmREWFpHUWdHNjV1MjlZQVBiNzFn?=
 =?utf-8?B?T0hoeXRLUGp5Zm0xdTVqcWR3N2k0VzNXQmxZWmphSk43OTlqaVNIK2RRTUV1?=
 =?utf-8?Q?TNC+swjkII4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OG5zQU96anZObmUzbGdZcUY0RWg2ZVNuUjJGeXc1TFd3YmF5bU14VmpCMW9W?=
 =?utf-8?B?N0tZZmxwUndOVWFoRWlLSDA3Rm9WK1hLbzAyQ0NpbGE0MUN3OWRZQmFsUjd2?=
 =?utf-8?B?WmJpekhzeHdXYmhMMS9NVzY3N24zbmlaR05GVzQ1aHZ6VlV0YVNlWXU2RnRK?=
 =?utf-8?B?WG82SW5IMjVxQkU0MDlmeXNlOU9NUjJJbGtSZE5ydzdjTmVtMk5tcHBzdjcy?=
 =?utf-8?B?STc3QW84a1BjVGJWVlcyMklWSjltaC9sVUZ0bW5VSHBkQitXRFNMN0lvZmR6?=
 =?utf-8?B?TTlHZTFnK1pVRjJhcXBjSmFpODNnMzBpKzZzbWd5azJCNkRmdnh5R2pCaEo3?=
 =?utf-8?B?RTRUZS84WTFwdmFhZEUyZWVNRk1lQk51aEs0VkdmS0ppc2JMeXdhejRwY1li?=
 =?utf-8?B?WTRBQkxWcFpjaEpVbG5semZTNUxDYUFiRjF0STl3ME96MmFDY1hBZHNzbjFS?=
 =?utf-8?B?RG9mamdRM1UrbU52dmVvMzBoUXh0TVZ3eTBVa2EzR3QvVlluaXBMMlJoYzBp?=
 =?utf-8?B?UHVVRWlGQWlIa1R5WU1wUXI5TW10VUV3MzQzcUFkZUplZWZUNTJPa0FadVV4?=
 =?utf-8?B?bHo0cDRMZDBPNU1kL2l1MEtBbWhJb3RzQzdjQ3RxaUZvZU4zemV6NFdETmR0?=
 =?utf-8?B?akc0MlEzYVl6K3dOa3k4c3hWOHVxM3RvSkMyMmt1b3BPNUVPbDJVVHc2S24z?=
 =?utf-8?B?ODNaSFBXQk5JSVNKMEJnZ2UyRFZKMFpvNVo0NXkvYUNqQWlsRHRKQXBtRFpi?=
 =?utf-8?B?d0dIc3lYbTNSMGVCY2tzeEF4SzI1NzhhaGhrMExNZ25qNWpQVDJkYmZKb1Zi?=
 =?utf-8?B?RWdTaDlVWk9TWDYwWU9aSDJUOXNLZitPYngweW5WR0tEdVh1VGxCdnd6NUlH?=
 =?utf-8?B?c2VGS3paRWlYZ1hqVXJHOHJMYUx6YWQ0RUhUT21tMWU2bGtaalAwbTFKa3dC?=
 =?utf-8?B?RndHZ1JjRWhZWVpraE9JcVk2SkV6eHUxOGNHV1lsK1VsOXBWcC9kN1FnL25Z?=
 =?utf-8?B?MlFWdEdscTNGb0I0UGs3ZnprUnJrU21VVHNsTXR6WXVOYW9GTTJ3YWxhSml2?=
 =?utf-8?B?aDBEQitJd21hMUVPMnNYaUp1VXZma0xicWFhR0NaVjQyV3Q5LzY2Y3RQQmIw?=
 =?utf-8?B?UXB6UzZ2N3hGblRrUFFXU1YybDB1eWNweWtydVVkaGZzL1JhbiszRWVjOXJw?=
 =?utf-8?B?M1dVUlRrVTBMK1hSQjZjQWhVY1BpV1dLczV1UmFKUlRDN0JFWWtEUE4vYTk1?=
 =?utf-8?B?aTUvcjdoVDdSV0p1VUJRSXkwenZSVXNnSjMwb3pmRkQ5STQrSHdpQjR6dzZD?=
 =?utf-8?B?cUtzdDFYdWVpVXBmWXRoTzVsMEhjb1grV0tSalZXdjdDbnRwN1V5WWhnelMv?=
 =?utf-8?B?QVJlRzJpTkoxVzl4WFZMWHZqeUtBQ0hLUDJhT0krRURDRFkzSm0zQ0QvSlBO?=
 =?utf-8?B?cG9SblZFb2RmL1B2dkI1RkJUZjMzNVFta29yRlRFb3VjZGlhYmliS1lwd2lG?=
 =?utf-8?B?NlArRGF4MTcvaCtxSDhDWnk0Z3U5NHA4VWVXd29Ta21ZaVlnVVNsTmVPU3NN?=
 =?utf-8?B?WXZLQzdlU2lpSHQxS0g1WSsveE1Ma0pkd0FlVlJyd2RMd3dyNkVWVmozbkNR?=
 =?utf-8?B?cDZ4Tk9NN0JobC9FWkpXZGg5bnFMbmxKZFlRSUNoNmVlM3Y4RG9aS3NDWjk3?=
 =?utf-8?B?Wmpodm1jNnMzNnF5NXh2MStsLzNHcVZkdjFtMlZMUE5TOWY4cGZiSWgweWlp?=
 =?utf-8?B?aEdva1ZSQUhkNzNRTzdIU0VWZFpCSzRsV3IzaVpWUktEQng4SkZ4Wm41Ti9C?=
 =?utf-8?B?T2FSNGxMTmp0TU9lQ0tDRXcxa0lMak9pN0grY2Z5VHorVm5rRXhTNnpMTDBw?=
 =?utf-8?B?Z1V2TFpLektFdVBTTFJLRVFocms3TUZpM3IrcThXSFEwWWNMMWdxSjBtMG8y?=
 =?utf-8?B?WUlRUHB4c2krUld4VHEyaVhRYzMwMzNHUDlkSU1KRTEySGJQWGxvMGlGUzY2?=
 =?utf-8?B?djZ4RUV4ZGp5Wm4wSmNRK0tEVGp4MURHVUFkeUZYNzVYYThqeWV5NnBJb3lj?=
 =?utf-8?B?OGhQdWh2SUxrd0orTjZwZkFzT0FHaVNDWEt2aHZ4bVVoLzZma0MzZnFZY0FG?=
 =?utf-8?Q?5b65o5q3DIUB1mmc2gn1ySi8H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f75066-6d10-47e7-25a1-08dd9e36ae77
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 22:26:25.1991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w93qEFG2BrUEkvi4fEa+/A1Zkwto2ngiFUdq5+dwlZkITGp7EgRwCWT4SEg/KyAzqCHFWNGUiI4G1BEPj8i/KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649

On 28-May-25 11:12, Dan Carpenter wrote:
> The rhashtable_lookup_get_insert_fast() function inserts an object into
> the hashtable.  If the object was already present in the table it
> returns a pointer to the original object.  If the object wasn't there
> it returns NULL.  If there was an allocation error or some other kind
> of failure, it returns an error pointer.
> 
> This caller needs to check for error pointers to avoid an error pointer
> dereference.  Add the check.
> 
> Fixes: 17e0accac577 ("net/mlx5: HWS, support complex matchers")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   .../net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> index 5d30c5b094fc..6ae362fe2f36 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> @@ -1094,6 +1094,9 @@ hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
>   	old_node = rhashtable_lookup_get_insert_fast(refcount_hash,
>   						     &node->hash_node,
>   						     hws_refcount_hash);
> +	if (IS_ERR(old_node))
> +		return PTR_ERR(old_node);
> +

Agree with the need to check IS_ERR, but error flow is missing here.
Need to free the previously allocated IDA and node.

-- YK

>   	if (old_node) {
>   		/* Rule with the same tag already exists - update refcount */
>   		refcount_inc(&old_node->refcount);


