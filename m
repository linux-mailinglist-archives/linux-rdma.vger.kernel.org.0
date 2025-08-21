Return-Path: <linux-rdma+bounces-12851-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54768B2EE7B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 08:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5112EA20888
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 06:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9FD2E266E;
	Thu, 21 Aug 2025 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QU4fELue"
X-Original-To: linux-rdma@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012001.outbound.protection.outlook.com [52.101.126.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659472D77EF;
	Thu, 21 Aug 2025 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758672; cv=fail; b=hvm6gzd6H7cqasH3yQ4RRIltNH23dXJvhr3svfIPFnr3coLK17K5eERg8TcJYy6v80b1OzGkIXr8jMoOKZO71K38fpD8fkALNjfvjypDDXsLGHYPag6/I4Ccu0vpWatXaqMM6JKnen3VhkAGYJ2L0jBPFiq7AzDAoQN6gfvXOv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758672; c=relaxed/simple;
	bh=ZJHaJv+GivPZ3vqgWGRxRVU/6+XbliBGr/O0v/8P8tE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dw8W2grJLPDIuonNqZNFVlQhmElr4Ac7JyrqRdxLd8io0hgWzVg1zD6T96uig3eo9x6sw2CDZ+bzemCPsSMNK2YT7YwzzqQ+EeZiQBZ6NiJrwsiaE4kyAWiwOHeJMeGOzds4EyfF5ZrbHo8QRRsZUCT+JRn8ztzLx9OaqSyH/hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QU4fELue; arc=fail smtp.client-ip=52.101.126.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLA7rSbnOjts3QBsumOwyw3Yqpn8ozvXGOKEAEwkdfQZ0YAfOwDcJ/j34uOQiEHRR9LTr+gB6IB2LNNBd+OEFlz8EMLasPDZ1DpiOuJS7oBz53vJ9AWS7mX5/gE7cu8g9gX2GD2P4E9y1bORjYx8lLJOQijuDLq2QEjTqGELc55neDCxmMoP9TBPu2S3g/JHCVqFucm1JIy6ejTuBXTE/XGKqmt6SC2dLhwtMq2PBl/574php1+24V1m2WqJFY/wen5/Zno/MqqvhliIqkJVekV6yD9MFCUnO9VOw01nIL9G20L9WI7dxP2lQEURfMOEb3u/KijsAwmarxso/kjG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDuZCSXpxHrL/cOk1v4aCza5UFPWafkeszxOngfMOjQ=;
 b=ctorwXA7rqNA7gCbbfFlcaqRKv4R7ZpqKdaWIdazWm4R4FcxWpumNm2bi+r3hek6Si7Zz/O8FqI48RZiGhph/cZ5h/Uduh6TWwGgWGvPN1OErmHb7UjcqSKY1NywBx4sMDGV3AGBrtiwk2wDWa+JnCOpOJwMENlIYSy7Jg8MRO/e8WfbmLo5xJ0VCLmIYebyO9YvtjzILsGMn56PC8U29u5yPjs1lJAlfGgcDHHbryer0oqwCcVS0eYJkvMZC3ngk0kwwy45zk20VG81ICp+hmJJhXqj/e+OZTfh4sW3TDItlWvgtcQ1lOjvSs5aAB+vYe0wzoOUa4SX6EZP2JZpvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDuZCSXpxHrL/cOk1v4aCza5UFPWafkeszxOngfMOjQ=;
 b=QU4fELueeczJT6PiRy6MubbPP/1C4F629S3wfpcG/ej/zuRiRb2/8YU8ZC1D/UxQ82bNqMKnSc3n6AJETZAgrsXo3oQpkJjV/9qBP6xhr1f0Kq62Ywu9yGl7eHo7DA+/h2lt8Nw5W9dmYFAuXkXf+2iGg02XVGi//q3NuGM/ewyr6Y0TMBGnIfV8K52yjkDkxuwi8TbGwGdLOh5IzyO+HkL3zaailUqBtrylUpi3NLD4QEkfZ3FDuGYRLWGC+q/0VpDgciiZrRy4bJLGPV4PoW+mS12LdVH+dhKP9rRliPaghQ25GRfQW9g/p1hw296ztGcgmpzR0HmpYLTIvVvHAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SG2PR06MB5192.apcprd06.prod.outlook.com (2603:1096:4:1d4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 06:44:25 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 06:44:25 +0000
Message-ID: <474093f9-e2da-4803-8839-df33f70622a9@vivo.com>
Date: Thu, 21 Aug 2025 14:44:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/erdma: Use vcalloc() instead of vzalloc()
Content-Language: en-US
To: Cheng Xu <chengyou@linux.alibaba.com>,
 Markus Elfring <Markus.Elfring@web.de>, linux-rdma@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kai Shen <kaishen@linux.alibaba.com>, Leon Romanovsky <leon@kernel.org>,
 Liao Yuanhong <liaoyuanhong@vivo.com>
References: <20250820132132.504099-1-rongqianfeng@vivo.com>
 <e8a8404b-b524-4d9e-b0de-d743acf8d7b4@web.de>
 <176d4590-6cfd-8a39-a855-ee21105496b5@linux.alibaba.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <176d4590-6cfd-8a39-a855-ee21105496b5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SG2PR06MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 25558b31-1c7d-4057-5571-08dde07e2ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cm1KV0NCTFlkZ1lvc0RYQXB3SDlGM0FYTUVCbnhOUlBFOHAwL0JrSk9RVjdU?=
 =?utf-8?B?UUNiMmMrU1VUTmZTTC9nRHdYQUQxdlJyNHFVdXBZMzZoeVZmbUtUU2k3VFV0?=
 =?utf-8?B?dy9GS1RDWmhCSFkyMzUwWDgxWlNzTlEzdXVTdC9uMFE2TzRuekhiRFRWMWpm?=
 =?utf-8?B?YVJyNkhRZEQ5d2MvM3BWT3lHeW5hckhQMWtveXEvcm96bkU4RlZhNnlsWXY4?=
 =?utf-8?B?QWpWaTVRTGN4eWlqL0ZwbjJsUWxEQXhDcHFyWFR1czA1M0tvLzZZNTk1eENm?=
 =?utf-8?B?Z08zVDB1MXI5UFVHdmg5U2JPWDN2cGZPME54L3ZGU3d5a3hhazlyOGVNd1RW?=
 =?utf-8?B?cy9BQ1o4SkpRTWkzbTJZZERwVTlsTE03R3lJOHhuWFVtdXdyc1ZPbVZWOWhs?=
 =?utf-8?B?ajZlNXVZRjFwQXAyNU9vZW1Pa2llRndtV1gwWHR6cGJKZjR3M05VaHJNV0lN?=
 =?utf-8?B?RnpHcXRTellwMW5UaWVkdFhsZXYyTVAwejZqZDQrZFNlcHhwb0hIcWJTUXZS?=
 =?utf-8?B?M2FpSGVQQXVEbmpoQUtDVWkwbldCVW5WWkNRUW1jbWNwYjZ1dmFjdENPbG1J?=
 =?utf-8?B?cW5ha0hpM3RCSXFpV3VDNkp5cnNFdWpjSkVWU0xORC8zUDRaQ2VIajJjaS9S?=
 =?utf-8?B?TkZmSk1XaXk5bWJ6MmVmUys2UmZ1R21uTGlDVUdseGQyTnBFM2k5MzdKZDQx?=
 =?utf-8?B?N0gxM3kwaHhjRWpKNVFJVWhmampaR2Vzei93Z3dGbEhaMzZlaVFXTDBuQStT?=
 =?utf-8?B?elNkYkl5QXFSQy92MjEzM094NUNZZjZKQWhHc1NROE5TOUlOcHRVa0RpSno4?=
 =?utf-8?B?WXZuQjIwbk92YzZxbGI5SFRBMDhiQm1MZU1DZ3BaTmtaNlRjWGFlbzRCRlMz?=
 =?utf-8?B?dzVQUXpCY0tFY0thM1FoZEJVcURoVko3VEZQVDgzeXZJd2M4aExTNGk3bzRY?=
 =?utf-8?B?Y1pWNFhvdXNGeUo3SkhTc1lvVW5OTzZOUjAxaVRLcVdyTitpWFZKZG96a1l3?=
 =?utf-8?B?dytJTU1wZTRTQlRHaTQ0eFlkK3RtQlA3NkRwOEl1WEtVNkFwMEhPMmtIRUR5?=
 =?utf-8?B?aWNzQ3YxOHgvV2VPTWVWNm4xbjFwRXRvTzFabGxyM09JSFdPbFpFUVJIT1JR?=
 =?utf-8?B?YmlSYkFnQkh1eEl1NTVyQ2Z3ODFUZ1AyMGp0Wks5dDczOXo0RVZqRGZqeWlF?=
 =?utf-8?B?UFZXSzJheTV1ZXNkU1FKSjFDTVdKTXhOYmlReDkzSVNmakFaeFZFZUp4MU90?=
 =?utf-8?B?UnhDRXZKajBLWkM3cktDU0lNTUw3YldXQnpDOXE2SndjYnZHczZxa3o1bW9L?=
 =?utf-8?B?KzdBNXVMZFRMMm9QK2FNY01VTWRuOU9KL2EzYS9yUGpZZzZOblFjc3UreGNu?=
 =?utf-8?B?VW1oZ0tIMC9ObzFLU2dDbSt2anFDTDF0eCtlbUJrRGw4aFRyTDNJYTAvUHZn?=
 =?utf-8?B?T0laNnY4R3RjdzZxRnl2YThxR0t0cFNKUkVnd1orUm5KOWVZTjhvelRQS2Ux?=
 =?utf-8?B?cEN2MGhZUm9LbExQeVdKaGQwdDI3YktJYjNxdi9wVGcybldmL3d6Q0p6eGdl?=
 =?utf-8?B?OHZwK1p6RUFFbE9XQXFoV2IrSy9zU2M4TmFqMXpkWlZ4OUw3blYrenlmR1ZM?=
 =?utf-8?B?M1JpQU8vdXFiSTFZU3VaQUdJUXBnWU4yS21NRi9qM3B5QnVsczg1clpUUVNX?=
 =?utf-8?B?WHM3RXQyVGhhY2g1a3R4YXhtOU9vVzBDcWxPMzg2SngwaG5KTEZiTmVac2E2?=
 =?utf-8?B?b09TTHE4OGRpb1FHNFcwWXZoMEd4eVpIV1MySktmNFcvOTQ3emk0SE04TCtp?=
 =?utf-8?B?NUVROHpBM2htbjdpZkhiRzJPVlcyWjAxZENjSmF0S2svOHRrT2tuQ2RJSUp1?=
 =?utf-8?B?bUVXYnJuL0p2czloSm93M21nMkJtUG9hUDcxNmFoK2UwbTcwYTR0a3JhRU5O?=
 =?utf-8?Q?ueSkrIrR0g4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXA2ZVZOMEIxYWFvNW5TejlFcE4rZ3B6L1lPSmZBekJaOERhcG05T042b3pv?=
 =?utf-8?B?UHp5RXV4cVZMYUxCTThGMkdFZmVaK1p0eUFucXdYTzRiNUVRcHJVV3NjZ2hE?=
 =?utf-8?B?MERIdTdMRlJ1OVZ0MHMzUGJTZzZpb1dERjFkaVB3WXNaakNib0luaGhnb3hB?=
 =?utf-8?B?VVI1WS9zZ0V0eS9QVmFFSzdHTmtKTmtwTlYvR05pQnZ5NkJ5WkttQjcwUlh0?=
 =?utf-8?B?Ym9XVE5YOG56cDRWYXBMRjhEeCtFOVNhcGY1MUE4UDQrYWtIQ1Z1SHl5Q05N?=
 =?utf-8?B?UGQ4UEFibUtvSFBzU0tMTUZiaXVIcWY0cHlkVGRqRkVRS0tHa3JBWFVWMkly?=
 =?utf-8?B?N0lmNldkZm5UWkw1M0NrSWx0dnhLa0tSTjlJamJLS0FJUllzKzNVckFZQ1lE?=
 =?utf-8?B?UnZQRjUvdjVNU0VjNGNueE1HcHlPRkVEanNpbnZySVlNWFJVM1JkeEd5VjIx?=
 =?utf-8?B?dW9LNExPSVVRSGhPVWJJK2F4QTNBT3VGMFQxNERsaVhobFlYL1hpNUlFWE9w?=
 =?utf-8?B?d3IrSDdwQWpYeCtYVlZ3cjBQNk1vS01YQy8rUTJFK2pSRldtQUFUUHVBTE1I?=
 =?utf-8?B?OXdzd1JacFZnMEpGRXBkVkZIYnY4V0tKZVB3eGFuREhDUDZUVjVWaGJCYXUv?=
 =?utf-8?B?OWhGQ3VUYm4yNE9FcFd3QkxBNUU4dm1yODM1MENTdnRZc0pvY0g2djBPVnVa?=
 =?utf-8?B?TVkvYjdEbFpXd3FBeXk2RnZaTHB0MjJSdWREZU41WW56UHBTUXM1TEdReXlG?=
 =?utf-8?B?MnFQRG5PMzU5d3UxbXFkaVRCTENJV0F0MStnQ00xeVNJZFFKZlhhZVVEQTRF?=
 =?utf-8?B?SjhwaCsvSTNEZFBZc3NMU0QvQ01xcDlmcGNDRVdBa1pRMFlMbXk3b29kbmoz?=
 =?utf-8?B?SzJ3MDU1SWtFSVRsYUs1OWJ6YVF6R1EwNmtEWmZ2TysvNHJ3RTJyaWYzZlpL?=
 =?utf-8?B?K2hGWHc3Ym1kNis0NFNJV1BaNm92aUU0ZTMxbkVFcy96Sm12NkhuOUVjcG4y?=
 =?utf-8?B?NEpsUFdVZmJDRE1vdmRTd3ZORVlydlZ1ME1iTFRQQW0yTHJ3V1ZaMmVNSGJx?=
 =?utf-8?B?SEdyZjQ4cXl2NEdmWG5LSGVvZkNRcWQ2MDBZOFB6SmNZQVVYVHdNYVVBOG1w?=
 =?utf-8?B?S1I5V0g2eTNxaDRIS0k3WldFMW1UV00rdStpbHVkRHFiMXl4ZEVwaXAwSmZa?=
 =?utf-8?B?YzdHSGFnVENOL0kzRytqM3M4MVFYVkM1Q0ExdUZQbGdmTnJPTnEyMndGMUpU?=
 =?utf-8?B?UkpxSGZBRDNOVEhpdXlpdW1WZ2g2ZStOZ3F2dVVqUjV1K3B1eFN4RjhkM3BP?=
 =?utf-8?B?T2NreG4wSFBzZzdXYzFLbVMrV0ZXN21rYy9RbmJOdHZBY0dlTG1sWTZBREJ2?=
 =?utf-8?B?VDRQazJkZEIvbkwzR2lEU3k1QWsxbGtiL1RpWG0vME1IZkUwa0FkbmRqR0FD?=
 =?utf-8?B?ZlhZbzQzN3YvbTZ0QmN1bkQ4d05VSTI5VGtqd3RadWlBK0hqaGd5UnpEMjhJ?=
 =?utf-8?B?aE5Nalp4N3h1MklLK1VlYmtMbEV6R3hWUEVUZElZNWc3dzVrOGlmMnBETCsr?=
 =?utf-8?B?Z1Y1WVR6UnI3R2JxVGpWb1gxd25GWGxNZTNiQ2NBS0hlZ0ovR3JLNGIwcmdl?=
 =?utf-8?B?aEZKLzRvVVVTZUszK3UrOXE3QzZ5djY3UVZTZy9hQnl6dEFBNE50ZTZIbElQ?=
 =?utf-8?B?VEJmV2JxN3RjSU80U0RaUkpFTHVFTGtvbFJKSTJGcTEwc3FBUjZPTjVrYnZL?=
 =?utf-8?B?Q1BsaDJsUUdQTFlkNW1WRUFId0dWcWNpc2daU3VmZjFtbDZKejN3SCtHZmh5?=
 =?utf-8?B?UTlQQ25NK3dscDNxaUN4R0tZVzNqa0RLd1RTK0tuMkVmRTRiTHg2NHJUR0hm?=
 =?utf-8?B?TzJ5dFFiL0pEVkFiVWQwNjk5NDh2WFNSOGlwTjBNaEQ2cEg4M2lqWFZEMzhC?=
 =?utf-8?B?QnkvdWFRUXlNelR3YlhBc1A4N2RCUjEzenhBSWJ4aXZtVVVoS2VxRFdyNi8z?=
 =?utf-8?B?OGVqK1F6cUpWMFdWUzBSdFJyaDFSanRNbjJVOEdlVndwLzVCK3pKZEc3VmVH?=
 =?utf-8?B?QXpTanh1MHNUdktjQ2NFcmhIRVdDRTJvTDhrTUt2WmpqZllNbFhXVUx2T0Ry?=
 =?utf-8?Q?7PIzI87Tb69kKBOtDJ34laclH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25558b31-1c7d-4057-5571-08dde07e2ab4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:44:24.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AS3cNX6UBopSdNcw1JZzaNczCn3gc1dDrny+tiAIwr6ThoOK32Oo+M2HGNIybXSoCjNjKe3O7tMMsB+QDF9KbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5192


在 2025/8/21 14:26, Cheng Xu 写道:
>
> On 8/20/25 10:34 PM, Markus Elfring wrote:
>>> Replace vzalloc() with vcalloc() in vmalloc_to_dma_addrs(). …
>>
>>
>> …
>>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
>>> @@ -671,7 +671,7 @@ static u32 vmalloc_to_dma_addrs(struct erdma_dev *dev, dma_addr_t **dma_addrs,
>>>   
>>>   	npages = (PAGE_ALIGN((u64)buf + len) - PAGE_ALIGN_DOWN((u64)buf)) >>
>>>   		 PAGE_SHIFT;
>>> -	pg_dma = vzalloc(npages * sizeof(dma_addr_t));
>>> +	pg_dma = vcalloc(npages, sizeof(dma_addr_t));
>> …
>>
>> How do you think about to adjust also the size determination?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.17-rc2#n944
>>
>> 	pg_dma = vcalloc(npages, sizeof(*pg_dma));
>>
> Hi Qianfeng and Markus,
>
> Both your changes look good to me.
>
> Qianfeng, Could you send v2 including Markus's change?
Ok, I will release v2 with Markus's change later.
>
> Thanks,
> Cheng Xu
>
>> Regards,
>> Markus

