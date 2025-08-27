Return-Path: <linux-rdma+bounces-12942-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEB6B37B3D
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 09:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CDE1B62630
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F6A313526;
	Wed, 27 Aug 2025 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ewrJmNFL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A592D0C76;
	Wed, 27 Aug 2025 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756278515; cv=fail; b=k1r1bEqiNRNxCD5TUqNS924y8rUPu0DkYff4Eayk+/uUAyI2W/UrGcjG5liUzZu3ksho/hLyK26FEhOroa8gAkiR6/b49utoQ3p8KgQio6mYzld6GCB/Y33p/iAccfL4ipinDr1dHOT7YiOGTOPbbzcSYuasN1E+E0e0z3wPiJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756278515; c=relaxed/simple;
	bh=+STd661gTTMGpn2cTNiz/ppauqAMZeGCsWcYoQ6BB1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JFCBYm6pvNFK8jggyYli1TNwmQ9rWfiXeTY90U85pdmEhA0CCrJbxpgE1LAlxRduQfRbZQET2r/GCXEfKRuQkGYlmi3Uycwo3sbNLVwPgxT3SvvUC38gXABj0FpfPGJUmUYH/CJEM/WEbJV2JyLUzG40VHJSuiYiHIRnpascUXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ewrJmNFL; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTCujiakWeeAlm2itrwMm65oOfyHnTgzXS2x9jkzymIIianbEhOyIFp5lU3umHuN8rjVBQJuVZyOMzeKHT07VZflFIV1e7Pk9ZPXXsewV7lSQshNORZ4FALR63m1VTsAbRzRbFW+oqHf46bjx7rydjKUoIza9T7UfVAiEJA3w7Bibtm3wH1T/QNiX0gszJrWSv6YRXajwG91VvL5hYM5fgL/ly/OVM1von0LGJrkw4KEB34BDEmxRuMUcsfA/9yDUYGxJyLo9WxCUN46eZfzG599+esLceSEM/ovV7fU5YeCK/qhqvC7G56pCUvN4Wml94LIFdNpO3C2M0iy/3oxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL8c727OWJz5S1lF3nQ7bj0GuFHzgdLBK6zJvb5hrs4=;
 b=bU7nYvLQo68ea6Q/T4RoctYTHWPsxz0sU3VPL8a8DExkv90ddXNctDxgWqYGl/nUliopc5gT4USqUHOk3O6E5iFfaWT/cvz8qJuqN0u7RCnP6Ld5HaiaI227anijz3L0DLTSCHy09JatQXZIXAV+oGaXvrJcss3fykLh0bmJCMNgWthwP3Zl+u53IqFcO8Oh9/RouWy/pFz1WfJ/u9OmtShk4qvGKNsAnJEy88pSKWNyVLJdkHRN2ulBs4xdun49heeo0TbcmzA3ELjQljaxKSQNfb/h2XuhMJVm6VljMtCNkeFqAJfnH40VpEeaJgGXFgZ2r19zhaYDhKqGc80rQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL8c727OWJz5S1lF3nQ7bj0GuFHzgdLBK6zJvb5hrs4=;
 b=ewrJmNFLZHYJ2mCPcQOuLIQ7RVv3fD/YkbzcfTd9VIFfMvGPxRUfsq4fFXq/E11sapForSadFy3He8SK2IxRPwAjorepVIpdPSHs9abNGoZRbUqH2Eqa89/WARRb0mMB5wY61q0cY/KHFBAmFpgP/QPCLjPw1C9zjw28TQtxC31zPZawyL5V9GEXzCe4vlRg0qvuEkrMdrBtndX5jYYfQqqaXV8tGfDsxDtNs6SgZ4geM0luv6NWIkNmP+CoAnxmXlBXF002Fm0qC1ui+dkLu3oJZF+z4UcyCEFQNPagx2A0xbD+QqfcqZjMQCkn4qArBAwm4p+CZ8pQRFrE6vBQnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SN7PR12MB7785.namprd12.prod.outlook.com (2603:10b6:806:346::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 07:08:29 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:08:29 +0000
Date: Wed, 27 Aug 2025 07:08:18 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Christoph Paasch <cpaasch@openai.com>, 
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Gal Pressman <gal@nvidia.com>, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
Message-ID: <b5k5gan4nwyrjm5pm76oeyll55u2om2chnvx4tekgsw2y3zqpm@pa3e3hhfbpjf>
References: <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-0-5527e9eb6efc@openai.com>
 <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-2-5527e9eb6efc@openai.com>
 <CANn89iJ5brG-tSdyEPYH67BL1rkU5CKfvUO4Jc03twfVFKFPqQ@mail.gmail.com>
 <CADg4-L9GdJUVcGBoR3+jAt5QsSEwtiQptx2KY7UF8ga1yA7SWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADg4-L9GdJUVcGBoR3+jAt5QsSEwtiQptx2KY7UF8ga1yA7SWQ@mail.gmail.com>
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SN7PR12MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df97715-9ca3-4810-406a-08dde538862a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1FMWTZ2NUJiR09acDZmNGlLUWRHTThrdDh3NlFpczFvRnBRa1ZtVzBQNXli?=
 =?utf-8?B?WGVTS3luYWlVN3JrVmZoTW42Y2FRRTdBTW01QURLelB0NVBmbkEvd3JtR0tq?=
 =?utf-8?B?c0RPTVcyZEVDUms3NncyVlJmRHMvWWRneW5WVkIxR05tTnU2ZStoRGxUSnVl?=
 =?utf-8?B?Smc2Y3pDQXhjMmx0bkQ1L0tMdXovRFVWdUQ4c0hWVXFRQ3N4WlNabFJ1YnYw?=
 =?utf-8?B?aEFuZzJCZjlOV3BQZ3lRM2NYdnorQkcxam9Gd1RkclpQZWhUTlN4SktMLy85?=
 =?utf-8?B?SEg4QWFPNUtaYkRnb1laZUE1M3hoOGh5NGR0MEt1ZU9WTEdXQWVsQ2VkM0RI?=
 =?utf-8?B?eVB5RTdnYmV5SlFUdHQ3dnluM21BQlF4MmJrQnFsUDFlWUhtdjM0Wlk5a2Rp?=
 =?utf-8?B?aXFtYytBWXljamE5T2RqZS90NGR4OUJWTFhsbFJ4c3c3OStBT3FQdkE3dTJz?=
 =?utf-8?B?ZmorUTFDT2VKL3o4aCt3V0JJc0lZM0ltbHltL3RnZEpWN0E1dk1NamRNaHBo?=
 =?utf-8?B?akx3d0tVN0JhaTZCaTVQV3JZcTI2b1cyV3RoZk9WWnlac0dBYVZtU3h4Rm8z?=
 =?utf-8?B?Z1RGYUFqeDQySlVTM3B5Q09raTRVTUFscGI2R09nUmxwak01Q3hOZE1hMmNL?=
 =?utf-8?B?dFBLZEl1UTdQQ1B0VWVtMVpSaDkxZ2tUM0JreTBVZWlMTXF5cHloNEFjS3NR?=
 =?utf-8?B?M1N2eFlLQ09IKzd3QW96cFY1dVBVUzJGeC82L3FtTzRhclFXVTJoYW9XL1hL?=
 =?utf-8?B?N3U3TmttdE5wV0gvYlFMQncrQUhPbEt0RFBFM1NQdXRtVHU2WStJTUNMY0xI?=
 =?utf-8?B?clFCT3YzQnZCYUJGaHVCLzdvZU03MmF2dExQK3pYRU9EdC8zb0lYejZoZERR?=
 =?utf-8?B?UnBVYjRBOEpqSTlhOVhFQWZSVnhWVSs0N3FHN1QrU0hTSTdyWVd5UWZBYjIz?=
 =?utf-8?B?bmRKaFY5L2VGWmlsREpwbWNZM2ZZdnlleEJmOFpYb0MyN01EbjZHRDRDOHBV?=
 =?utf-8?B?VFZwMDE3cTVSQ2ZGS0w0czlJMEtVSkFsbU5oejV2dnBXRTB4R1E1Vjl2YWtN?=
 =?utf-8?B?Y01pd3VsNkd6YllvSkRycGlOTFlIeE5rSm4wUEZkcjhoTVg3ZzNYTkZkV3FW?=
 =?utf-8?B?WnRaTGFMSVZkYnBobmV3VU9pRm9yckhQK0pXd2NFbnVVOWhIT2RVeVFXUGtk?=
 =?utf-8?B?WHU3bjNURWc3dm80MlAyMzUzU3Y4cDdoN1VGYk5yc3pLckVXY2NnR3JaTmpt?=
 =?utf-8?B?MzZwejNLUGhtenhXeEVCUEl3M3dDTVJJUzA1djgvQnpiREhSaWtOUmgvbmlw?=
 =?utf-8?B?eXJKVEJPNHNuVzBMZjIzd3Y0ZWdxS3VJQXZaOWJQQ0dGQXgwdGVFdzhiS1ps?=
 =?utf-8?B?QTlXSmxXaEp1dGdUM25vT0QxSXJ2czlicEplMUtiOU1FMUJ2eFA4ZkhZS2hC?=
 =?utf-8?B?SEk4cVFHaU5yNDdoNUdwOHNsczgrYkl3eWxDWkhnV1dBZHVOSVhCMlQzbGJF?=
 =?utf-8?B?czlkUHBiaEE4cFJqbFN6c1ozaWNZeFVoRG92Y0RzVEowSnJLVDJMdVlZUWJs?=
 =?utf-8?B?bGc3eUFuZUgvZDNlK0dLakJsZ1JCcks1MU41L0pkbWkxTU5iblpRMEFGeGFh?=
 =?utf-8?B?K25xdzc4ZEJDeDVyTm00dnJLU28vdEhmYUpFL2YxRUE1amdmaGZ5bWtENkNi?=
 =?utf-8?B?NkgzQW02S0pMZTFHOHphWGQ5NitEbHF5ZmRoNld4N0V3S2J6ZFJQRi8yZVNE?=
 =?utf-8?B?UkRCcWJwbnBnR2FYZUZwL3JOUEozek9wYUl1T2lST0tlTGgxc1NRZnoyZy9E?=
 =?utf-8?B?c2MrcnBUU2tHazhKbzNXU3FYU0RkWnN4WUZaVnJGaThGNUpiRG9RNG5aN09D?=
 =?utf-8?B?bnBBaVA0YXNGdzBHNXBsWE9KT3Y3ZllyU3dBdSt6ejcvcDRsendUNnB0UUR6?=
 =?utf-8?Q?L0rbBijCHvI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHFXYWIybkhJYUYxTURyNDhZenpRUGhzb3J4dWJxQlpmUFhYZGNOYjlNYlp6?=
 =?utf-8?B?dVJzbzRnVzhRMUltQm9QVXhKaHpKOU1US3pIZlhPeGhweVdKczBZZUZMc3B3?=
 =?utf-8?B?Zi91VVJaRGRwNWNQaUYxRDBudEsxUU05WVhxWXBya0poRm9STlcxM0p5NDlG?=
 =?utf-8?B?Ny91RnlNbmNzbVZ3U2FaalJlMzBxK0JrMGZCT2ZDaXdXOXQ0cWlpRm9WVS9w?=
 =?utf-8?B?Tnl3U1RBaWVVWWJzL1grREFrS3MyVzFVRDd2dGpEcXVMdnJXTDZFV3lseHZ0?=
 =?utf-8?B?cFo0M1k2R1poQlpZU0F6V1VWTWwvaEFhWHppWTRQUTN0YyszZHAvbUMrbE1r?=
 =?utf-8?B?THl1TWhud3NXbGh2Y0tENU11c1Ywa3ZZUkJpRW1RU01HY2wrbHh3enQ1M2hi?=
 =?utf-8?B?YzRpVXZzQ2VRRzlSRTVXSmRYOTI5NVQ3c01VVHhXd0l3djA0cEJFZE9rMFZG?=
 =?utf-8?B?NmtvUHJ3VE43K25ObHpUV2RqNXpxWXVwU09UUzdaeDlhcE9EeldyVlZlQ1hR?=
 =?utf-8?B?R00weUtGSFdsM0FEN0xBZk9DZzQ0R2wzSTdDYkxoRVdsN1dOeE5icUEwMXFR?=
 =?utf-8?B?WWlHRmNqZDhqdU9mTFZVanJvdGRzRXB4WXdXcFZxdUhRWTh0NDJSU2VHeXJK?=
 =?utf-8?B?TmJGNmhuTVFUMmdMWWkvYXcvREFuUjJBcTAyKzNYb2FxNmpvMVVMMVlZYWRm?=
 =?utf-8?B?YU1KbFVOa0d3YlhEM1BsRnVLcWFhOVZsTnAzbVJZakhaRlRhcFJ1eExXaTVY?=
 =?utf-8?B?SjNIcjJkaCtxM0Fxd0IyTW9SQUUxY0NwSDIwSTlpbVdYd3VJVHJsdzhCY1lh?=
 =?utf-8?B?aGdNaitGUDBGODJkQmc3eVNBejBXeFo1N09DYktDQ016NmJsMDh4Mnh0dkgx?=
 =?utf-8?B?eFFxQVp0REh4OU90aXVpL1MxQ2p3cXYzcEVEVk9jZU4wUnh3VWF2dktGaVJk?=
 =?utf-8?B?U1d6YUlOUTR4aWJ5VFlWNmFzalNzR05xYThXVGZCVXFnMDhMcE9rTzk4dkZ3?=
 =?utf-8?B?N3hhOWxTaHIydlhnOTk5N01iYmNXV3VFYlozU1hpUHZoYnEzcFYvZExkT3Rk?=
 =?utf-8?B?d2V5Ny9aNmltYTZCQ2xMTDlwdmZ2bVg4T1g1ODNYL2VXYjYxQ0oxSGZDaWw4?=
 =?utf-8?B?Z1lNQmxXeXk1Q3htY1BmNmlpK0FqRmJ6RExwUHhiZ2IzQTJXdGhWNlp6STdT?=
 =?utf-8?B?eWtMeXcxY1VLTVRIYXFBM2wxalZTdjdyRzJ2N0NKK3lXSnM0YkhVS09ZOWZ0?=
 =?utf-8?B?MVlLQWgzOEJRWnV1Y0s2K1picW5zZE16dUt4MFdRUGpDVkY3VzgvTmlaWW5t?=
 =?utf-8?B?K2p4c0xiTUFjQUV4eWpqWTQwSHNCd1FRa0FTMGRBc0k2MnRGbWoyOWFBNmhp?=
 =?utf-8?B?U0F2Nit5RjAreHUyWGQzYlZySXh0YXRoR0J4Z1JwZENaSk8yYTdzVjlmamdV?=
 =?utf-8?B?UEpvdWRrazJ3cjNFcmpmajBHZmJDaUMvekpqcGlTQ1M5MXBFUjE3VmRhU3JY?=
 =?utf-8?B?VG5SaFBwcXpkSm1sTGlKMFVjdE0yUzkrSWRCUlRXZFcyVklXV21LdWZOSnVT?=
 =?utf-8?B?QmEvTFE5NGN2VlUrVlJnVC9BY3UrNG5uTjV3V0hVRVNFWEtXOHBUTDlZL1h3?=
 =?utf-8?B?eG5HR2IwaFgyWnRqQloxcjlyS3dxMnp0YThzNm5YeFB3MExLZXF2WjJJdDY2?=
 =?utf-8?B?K2lJR1RMQzI3L29pS0RrcDUxU0RoQlp1Wm5acFRzeHRlVEVZSWpiczBwdi9k?=
 =?utf-8?B?bUlPRnZKY1QyaGgxWjdBS2duSEg0R1dnV0VzckhjU3JCRFB0VmhZa294Nlhw?=
 =?utf-8?B?ZFVzRS90c3FtYStOUnppYW1OVCthZmxEOE5IMlM0OEtsMXFWakYxaUdKQ016?=
 =?utf-8?B?RFViN0NJbk9DSWJGcm1zN25LSEFlaG1KUTgrQ3hOQ21ocEUrV2dBUzFyUFVo?=
 =?utf-8?B?c2FpdFBaVDkvNm40VFRqWWo4d3VzSDR6ZXJNdUdXSmY0UDBHdFRPUnZGUk14?=
 =?utf-8?B?T1U2RnlDeHRzVFp3SDcwbWMrNVFQN1drc2RvcjlWRUdtZVRUZklkU1ROM1p6?=
 =?utf-8?B?K2ltODJIQWU0VjZXU0xtRXNyWWgvQTVwQS9CalZjR245VklRQ0dGQll2WnBE?=
 =?utf-8?Q?x8L/7RB5G5I/v9+T8mqHt5zWm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df97715-9ca3-4810-406a-08dde538862a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:08:29.0469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmw/vNm/tSKgjhqju+N/knukQVeuCRrDHyTiC16Opv97DJGJetaU5fcopGPhD6lyWSJyJO07+Ms503u6Iso6ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7785

On Tue, Aug 26, 2025 at 01:31:44PM -0700, Christoph Paasch wrote:
> On Mon, Aug 25, 2025 at 11:38 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Mon, Aug 25, 2025 at 8:47 PM Christoph Paasch via B4 Relay
> > <devnull+cpaasch.openai.com@kernel.org> wrote:
> > >
> > > From: Christoph Paasch <cpaasch@openai.com>
> > >
> > > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> > > bytes from the page-pool to the skb's linear part. Those 256 bytes
> > > include part of the payload.
> > >
> > > When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> > > (and skb->head_frag is not set), we end up aggregating packets in the
> > > frag_list.
> > >
> > > This is of course not good when we are CPU-limited. Also causes a worse
> > > skb->len/truesize ratio,...
> > >
> > > So, let's avoid copying parts of the payload to the linear part. The
> > > goal here is to err on the side of caution and prefer to copy too little
> > > instead of copying too much (because once it has been copied over, we
> > > trigger the above described behavior in skb_gro_receive).
> > >
> > > So, we can do a rough estimate of the header-space by looking at
> > > cqe_l3/l4_hdr_type. This is now done in mlx5e_cqe_estimate_hdr_len().
> > > We always assume that TCP timestamps are present, as that's the most common
> > > use-case.
> > >
> > > That header-len is then used in mlx5e_skb_from_cqe_mpwrq_nonlinear for
> > > the headlen (which defines what is being copied over). We still
> > > allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking stack
> > > needs to call pskb_may_pull() later on, we don't need to reallocate
> > > memory.
> > >
> > > This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> > > LRO enabled):
> > >
> > > BEFORE:
> > > =======
> > > (netserver pinned to core receiving interrupts)
> > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > >  87380  16384 262144    60.01    32547.82
> > >
> > > (netserver pinned to adjacent core receiving interrupts)
> > > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> > >  87380  16384 262144    60.00    52531.67
> > >
> > > AFTER:
> > > ======
> > > (netserver pinned to core receiving interrupts)
> > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > >  87380  16384 262144    60.00    52896.06
> > >
> > > (netserver pinned to adjacent core receiving interrupts)
> > >  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> > >  87380  16384 262144    60.00    85094.90
> > >
> > > Additional tests across a larger range of parameters w/ and w/o LRO, w/
> > > and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
> > > TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> > > better performance with this patch.
> > >
> > > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > > ---
> > >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 49 ++++++++++++++++++++++++-
> > >  1 file changed, 48 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > index b8c609d91d11bd315e8fb67f794a91bd37cd28c0..050f3efca34f3b8984c30f335ee43f487fef33ac 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > @@ -1991,13 +1991,54 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
> > >         } while (data_bcnt);
> > >  }
> > >
> > > +static u16
> > > +mlx5e_cqe_estimate_hdr_len(const struct mlx5_cqe64 *cqe, u16 cqe_bcnt)
> > > +{
> > > +       u8 l3_type, l4_type;
> > > +       u16 hdr_len;
> > > +
> > > +       hdr_len = sizeof(struct ethhdr);
> > > +
> > > +       if (cqe_has_vlan(cqe))
> > > +               hdr_len += VLAN_HLEN;
> > > +
> > > +       l3_type = get_cqe_l3_hdr_type(cqe);
> > > +       if (l3_type == CQE_L3_HDR_TYPE_IPV4) {
> > > +               hdr_len += sizeof(struct iphdr);
> > > +       } else if (l3_type == CQE_L3_HDR_TYPE_IPV6) {
> > > +               hdr_len += sizeof(struct ipv6hdr);
> > > +       } else {
> > > +               hdr_len = MLX5E_RX_MAX_HEAD;
> > > +               goto out;
> > > +       }
> > > +
> > > +       l4_type = get_cqe_l4_hdr_type(cqe);
> > > +       if (l4_type == CQE_L4_HDR_TYPE_UDP) {
> > > +               hdr_len += sizeof(struct udphdr);
> > > +       } else if (l4_type & (CQE_L4_HDR_TYPE_TCP_NO_ACK |
> > > +                             CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA |
> > > +                             CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA)) {
> > > +               /* ACK_NO_ACK | ACK_NO_DATA | ACK_AND_DATA == 0x7, but
> > > +                * the previous condition checks for _UDP which is 0x2.
> > > +                *
> > > +                * As we know that l4_type != 0x2, we can simply check
> > > +                * if any of the bits of 0x7 is set.
> > > +                */
> > > +               hdr_len += sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED;
> > > +       } else {
> > > +               hdr_len = MLX5E_RX_MAX_HEAD;
> > > +       }
> > > +
> > > +out:
> > > +       return min3(hdr_len, cqe_bcnt, MLX5E_RX_MAX_HEAD);
> > > +}
> > > +
> >
> > Hi Christoph
> >
> > I wonder if you have tried to use eth_get_headlen() instead of yet
> > another dissector ?
> 
> I just tried eth_get_headlen() out - and indeed, no measurable perf difference.
> 
> I will submit a new version.
>
What are the advantages of using eth_get_headlen() besides the fact that
it is more exhaustive? It seems quite expensive compared to reading some
bits in the CQE and doing a few comparisons. Even if this cost is amortized
by the benefits in the good cases, in the non-aggregation cases it seems
more costly. What am I missing here?

Thanks,
Dragos

