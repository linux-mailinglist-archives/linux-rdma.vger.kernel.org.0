Return-Path: <linux-rdma+bounces-12354-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA27CB0BD11
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 08:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC00189BE4C
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782C828000A;
	Mon, 21 Jul 2025 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EQtpEAkL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947B19924D;
	Mon, 21 Jul 2025 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081104; cv=fail; b=IZvbez/4NDTslNoxT0FZgTIgilgt6nBjRYikjKYn9T4QsO0s7f5c7I//Y1AquTjyaGKfBokD+Akg555izLE4DwDnGiLROLtmuJny62Foed+xa1N6Zo9bFScX959i55MumCp0HBe5LSEFGw+kZ1g9aLFp2p1yF7yF8CAZRuoNJmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081104; c=relaxed/simple;
	bh=fKFrajuE2aTCFDpZul+JnUBInAYMSTCNSQ1nIStDqzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WzpqbakIbyZdZ9xX7RJsMZvaO34kLVOQZYOoxrNK2YaQNvWQyNlA2y0X9MxZJpoW0b524DSUa4+FWcW+4PGLyTwolwcNePwk84ESsIkppv35/qq+F8gF8N1hxeU9RisN9iPoeJlKP3e+Er75Lu01gHiW32kHeKWOsNcdpp2/prM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EQtpEAkL; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yovapYFJ6bI7fmAhxoBPgRxZLblblpJOuBh1pjf2BcsAsV5lzOB+m4gIamfOg9ZeLSIjVQ9WK9itJ2tbLxsPq/iKkM0s612KG6CO6JEiF7jPVeRDu+7c3qt3fQl/ZuGjO1bmlVGo4cv4jCpAbx+R8jwYmzwOERrMCBNTRXYF8ASZQBNSqemTbEJHj/EbUoflmLFLusXEuRqvFFdD6gfjta5m9DWdYz+WpkxnRQEBU6cl/ND8durQDH9kD2MG1XWfWC0BiumL3Fm37YBRm8evw2OM9EYIjZV2kSQSUKCVsovc5uWoiNQaVwu3TfaSlqqFnpoiUgorf/XCuE0fHlaaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f0984MLsH6ZA7HAYxbLSm4aHOrbEtF5pf1mOw2RR50=;
 b=Fmy4tkmLK7ehKbjymUU+fcyPsIrgvGCTxknyrzKsnf5bBvUBJLkYWgP/pS7AZx5rKcsnEXE8XsquG+QlVeNRfy4OYuje8oGM5INlygFYlypucpuOtNceGHLJiFTB5XRc9ZYxo9Zu2GKhkL+lHHUjF6q+xVgX67IsJe/axXDbNgEb3Gnp4ZS0o2VusH8nXf/3TXtDO42Bf8XIanK2ZgfuaF90Ixn4pS3wBAd//C8IR1OufUrM6PqH5q/fIOUe8jjBbbFaVwdmZpAe29+1G1d+DJUNZKKRYnKxM4iN5K3UTk5O83lsJ8l5BHkQWoPnpD9tsdSOymog6OxGfcI5zWRQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f0984MLsH6ZA7HAYxbLSm4aHOrbEtF5pf1mOw2RR50=;
 b=EQtpEAkLdLtew39THQOmDGBKbL6iuDuiEp9SQio5L7rk8bvBB5D+/2/hij2+mkCUvM+gzfE350wlmLohxmXb9HJaCPTqatgClfhu190RRhmhvjT3b6pGESYSQesvQ2TaVb0UFcY5f7Pj4zBJRg3DAYnVdu9gPDzb3Q8bCf8r46cydUXVZwwXIYBXwa8WZ00AagNfIdxgKz/UrkiTv2MayTpAkZn88ccyidIZTLx05XP+CkRehWjI4SaLHXCrodgiYWEqenP3JnQV06wJonVR9IHR2kdxwecqEZ5+HEoWs30p7aUjoJX8o1IKHgCvDwxlAIbQ/7EPROxh4uUBzKtQQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 06:58:20 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 06:58:19 +0000
Date: Mon, 21 Jul 2025 06:58:08 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>, 
	Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5e: TX, Fix dma unmapping for devmem tx
Message-ID: <g7le42azgihoija26ekiiedvky6r3kmxbo4eea65f5s2wsbq6c@bpezzeuicg25>
References: <1752649242-147678-1-git-send-email-tariqt@nvidia.com>
 <CAHS8izOkpcpO0KwtOZb0WE5kw+hec8nN9cWGarjT7dupw3Z+UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOkpcpO0KwtOZb0WE5kw+hec8nN9cWGarjT7dupw3Z+UQ@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 168ddeb6-4505-4465-e820-08ddc823f99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFltNmlvTmZMWTRCRHZ5L3N4VFloTDJLTWNCWDg3T1llMkJNQVBoaUM5Y2VM?=
 =?utf-8?B?ZHkrZzUvM2ZDdklnVUNWSmJVNGRQazJTRG1jU0drdEtIdE45QlEwS01PNFh6?=
 =?utf-8?B?dEFLVEpIU3ZUZ01UYjMzZjFubkVQTVpsbFAvaGEzVXdTWlFuLzR0RGpFbEhU?=
 =?utf-8?B?dVZkdDZDZ21MRUdhczRuUk9CL0tPUWtKMGFyVUl2aksxd1ppMlE3bXJCMnRT?=
 =?utf-8?B?ZVJHdlQwWnJScStmMXYrOVFTck5xaDZiOElFS0VRMkFiek5nWXc2YXRMemlQ?=
 =?utf-8?B?WCtCUG1Oa09ackY1TGZpazF3T0tvUzJuVmRHUTg3VTNOTkVGdjZGL3NFOEoy?=
 =?utf-8?B?b0ZvUGtCY0M3ZTYvOW9JUXFLZ1RRT0xUK2xEYXlTM2F4OXRXNXF5NVkvQkhh?=
 =?utf-8?B?K3NUN1EyeFk5djNQdFNXZjV2VC8rYjVHWGtwdWJyczJLZGo0WDhPRmFmU2ls?=
 =?utf-8?B?ZEZRdDNtbThNYTJ2TER4K0ltS1Mxc0JVYklYdTk0dUUzam5IOTJLYStPTDAx?=
 =?utf-8?B?K0hiS01EckZ3dGROdWVwV2xyR05nRXJTR1ZERXVzckNCRFlXZzRNZ2lsb3l6?=
 =?utf-8?B?NTZjdmhydktkU3hMWUw0b3BxQ2VKK010T0ZYUXZPRE5JcTB3aThycVZndTJJ?=
 =?utf-8?B?WlFQWWU1cWs0YkRVZHd4NVNRVTBxRkRmdExNWWZoL2FJMEdySDhSWnFSOWNp?=
 =?utf-8?B?cWs5RlV5M1F2cS9lZGY1QTNadDQ3cXFzbDNCU0NKWlI3SU56UmlwbzNUZE5Y?=
 =?utf-8?B?NEFwQWYzNW1HQ09RSWtEdnQ3bzQrRnJpWWNGMitlNHQyM3RuZVFramZ2WDB0?=
 =?utf-8?B?S2V4N0svdWpTaFN6YlVWYzc1RS90SnZ0ZktkQUh2UlorL0RZV25MRGh2d1Ir?=
 =?utf-8?B?cXNvekZCZFdNM0VmcVl3bERBVlRRZmFVNHNZeDZya3RERGF5KzRwY2M1T21Q?=
 =?utf-8?B?M2tlN3A4QnJOYkYwSk94bHZpcTN6RjlmQlFTdngzaHI5bFJWSVl3L20zN0lo?=
 =?utf-8?B?bVdCT1Zla2owTDFFWE5relI3bjlobVlCRmZmMWFNNitlemxWbGM4Uk0wdVhz?=
 =?utf-8?B?Z081OHkwS0l0c0VPUUFMaTRyL0N6c0pHTGtXdEhCbmY1aUtSMnRpUG5DYUdL?=
 =?utf-8?B?QUoxL2xKbjA5dG5MSEsrQ25NSVA5UTdNQndmbU50SjBLRjQ1T0MrcFpkS0U1?=
 =?utf-8?B?eGdiVS9TQzkwZWRGT0FncURraUh4UElHYXlFUU1pSzNrYlFNd2tUenpoT09s?=
 =?utf-8?B?YmpIV29OTFpvVk1qM1AzVDhyRWNKY1BkNkEyU0x5Y2xhRU9RMXpzb1VSTVl1?=
 =?utf-8?B?SW5YK3hXMk1sT0N1MFZGL1BBTi8rSXd3L3VNVThMRlQyd3J2bUZmaG5URXZz?=
 =?utf-8?B?OWI5akQ3VnptVExUL2d0VVkyTDZONWY5N05vR1VMcVhOU0ViaGtzVm81THNu?=
 =?utf-8?B?RVMyQXVyR2pYM3JPalJ1dTc0MEFCV25vcUNqMXMvejhOcldsWm9SNGJJRmMz?=
 =?utf-8?B?ZFMzTVJ5RTVtMFpKWnVvT3grY09NZmJtTmJ1M21BQVp6MGJYVTc4WWJuVmx5?=
 =?utf-8?B?WWc4dUVsYUZZbDR4RTdsME1nbHNNYk5HMFZ5WTI1NTZ6ODUrTVlMek81RjdD?=
 =?utf-8?B?RGlEdnlDMnBsS2oweXpSMVcwTXBiMnV4N1ZoWXFmalhta09pbkxtL011eHhO?=
 =?utf-8?B?Mm0rNDBzb0drTVhBTHFWQ21UaXRDWlB6VTQwQ2d3RnNxVHE1MzQrV2paeFcx?=
 =?utf-8?B?SDNBUEdKQ0grQmhUVEsvZDFVUUsvei9RWFNCb0RMRGtoYUtielE3dzhSOGFC?=
 =?utf-8?B?eEVIMzgxRExKSUxFZ3BPWFZMQVdSL3hNTWlLcDlUblY3WlR2aTVLY2Z2WWcz?=
 =?utf-8?B?eGg4MDh1aUNSMlpyMGh2OXFwTWNSTEJYT2xIdU8yUUJaSXo4cmpBK0hUbzZ1?=
 =?utf-8?Q?N6GCtafZTZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2prRE1GWTVDTElmcnJMZ0RZYi9DNGJFZVR0LzdjUldBL3ZlS3RDcmp3czZk?=
 =?utf-8?B?MmR5ZmVWMENkVkw4N3pWRmJDWDJpNGhqOEw2VkQrT2NTbFVYVTlQdFo2ZHRM?=
 =?utf-8?B?emtXRldzTzltdTZickJvTEZKOU4zWEF0L2llNnNORzNJYlEwTWUwMW1Bc0Np?=
 =?utf-8?B?Z25hYk5QeU9OTWlGaFVHdDgzVnpibkNhQzFDemIwUVRmNTFBSTh2UVhVQTVQ?=
 =?utf-8?B?ZTE0S0FXYlFkYlhBS0x1c3dlQ08rZGVsOFRvY0d3YWRjZTNjcHYvYmVNMHJ5?=
 =?utf-8?B?bys3cGdmWDNlc0xvc2p3L0duUDdTMWN4bHJNYm1ESjQ2U3E5M3JmdXJVQktB?=
 =?utf-8?B?WnpMalJVRExUa29DWTFzN1Jwd0JiajgzMm9OZUV5VEI5NXJYRWExNGxySGoy?=
 =?utf-8?B?RnpPVVNta1Ywd2hydmF5azY4NndXSG9VNHBmc3Eyd2FTTG1uYzdYQ1d2aCtq?=
 =?utf-8?B?bkUvV0N2a2o5OWZoYzZVRkFqRWFuNThjSGJubElEekZETzFxWHg5RjZXL2Va?=
 =?utf-8?B?SnB1blp4Si9JYkUrNStPR05GRVhyUjl6T3RwTWhkaTE0L3dXbkZDVkNONUM1?=
 =?utf-8?B?VHprTGFoUU5GeXhMZHlna1lrNVJBOE1SdWc4TEREcDg1RzNOWU9teWNOUU9u?=
 =?utf-8?B?VjNJUTMrbUhxSkx1Q3BXeFNFZjRDbFJ5OThubStLZzI1a1NNZFkwMzRvQ25V?=
 =?utf-8?B?alhuN1NBM29iTkZ0TVZoMXZHOGlLY0xHOEgwTTVNVzcwMFVDeXE4cWVUQnNy?=
 =?utf-8?B?YW9MNDhOa3BQSXlsTTRLOUtlN010OEkrWllwV0dVczNBQzl2OWltckRJQzBL?=
 =?utf-8?B?MU4zYlNqd0FRS2dhdjkwUjhnS0dRaC84QTNXaTJBK09nUnVXSEhaWWJiR2tM?=
 =?utf-8?B?MEtUWVlPMkZaSm1hYzJzMjVoSVMyS1BwdWxtOUtkZGVvQmZaUWVnenZhR1JC?=
 =?utf-8?B?NWs0d2VQZzBZMkZNc1B3OUF3ZlBrZ2RuRXQ1WXhzN29CaDJRUWhRb2VlOXZT?=
 =?utf-8?B?UlI2ZklpNnQyMjErTlFlTkVvK2FZYUx0YVluTnlYZnQ5b3NURVVXRFY0TzdX?=
 =?utf-8?B?R1czaFhuaGh3dDRvZkNWTWh5RCtKRUlpU2lQQ3g3c0x2eGw4Vm8wTVJGNm9l?=
 =?utf-8?B?Mk84RkJ0ZWxYYk84YVRsLzBLT0NUR3ZkR1NkUGIzd3FRSjFWaks5T3I1WXlH?=
 =?utf-8?B?dTErVHNnWk5wUUlOa0V6QWNtWmV3aG1OWWYvWllFZk1BSE5wKzhlaWRXZWFG?=
 =?utf-8?B?bytPa1Q3RjY0K1AwcjJRekFlQkRvb2pFa1lpSUh4cUt3MTFRK0d2VDdZMDJ4?=
 =?utf-8?B?NkdERlRHczVlNTRxQXpYYWNUNUhUclF2SFhpMzROMWgxZUF4NVVyL3d2RkM0?=
 =?utf-8?B?WGluUjlPZ3NqZEVBUkxBSDlPWGlVU2ZWUktzQ1RIQlFvS2oyVE1CRDI1WU9v?=
 =?utf-8?B?dGwyVjIrbEVrcDAxQTc0Z3BLZFpLcnp1THNDdlJ5RnFlU0w2SGd6b3JHUGxI?=
 =?utf-8?B?UUlOcko2TDg3T3dBK0FvQlQ0Rmt4UHJNNENTTS9uSkRncU1YQStJYURxUEJz?=
 =?utf-8?B?MWZVOTFISnc0dkpGQkpwRkFWZ2dCTGlrZlk1Z1VEUWR4YUdjQmxhbGxNalV2?=
 =?utf-8?B?MmJHaVBZcEduVXF4bWllemNuK0F0STFIQktiRDFLN052SkV4QlhySHFMSHhM?=
 =?utf-8?B?dU0xUFFWUXZqaHBiOVhvR3IrUnd4blhvUVRmdVBLMFRoUVhLWTNucmtPVHVG?=
 =?utf-8?B?eUhRc21KR3l1TkJHTTFDK2RVa2laSUl3TnRtOGN6M1Bwanp2QnZzY28vVHZm?=
 =?utf-8?B?bCtzUFAvV2hsVGxqK3RkYzJWdEM0R0h2RW1tZUgwUmpOeHRsVVhJYmJGckl1?=
 =?utf-8?B?Z3RIYzU0aUFmQWIwNUc4aGdQODZmcW1rUjZkNjZhTVpURVdJVDF3cHNXQSs3?=
 =?utf-8?B?Z290VnVtdTVJUnlVRkVMOWJxRUNjdm95TnVhLy9vN2lVVWh3Wmo2RFEyY3lI?=
 =?utf-8?B?RXBiSU0zKzhNSGxzaHhqQ0RZeXRnNVBJWGJKc294Y3FyTW0zRjd2NWZIZXhm?=
 =?utf-8?B?R2VaK2prcnIvWHZQZW9hN1FBbDg1dVJmMldSaWZycjFlU3hPTVpQUVV5RllY?=
 =?utf-8?Q?9kmFE6UQXVaOwZhnSjE4UAxPA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168ddeb6-4505-4465-e820-08ddc823f99c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 06:58:19.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7zaZAQsFo3ParuHJp+GThzVImnC3jPvrl16jy/bmy113O1UWZAbiyyUzZMaRzAHzq2LoBo16cO1EOQ+x23p3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705

On Wed, Jul 16, 2025 at 12:16:11PM -0700, Mina Almasry wrote:
> On Wed, Jul 16, 2025 at 12:01 AM Tariq Toukan <tariqt@nvidia.com> wrote:
> >
> > From: Dragos Tatulea <dtatulea@nvidia.com>
> >
> > net_iovs should have the dma address set to 0 so that
> > netmem_dma_unmap_page_attrs() correctly skips the unmap. This was
> > not done in mlx5 when support for devmem tx was added and resulted
> > in the splat below when the platform iommu was enabled.
> >
> > This patch addresses the issue by using netmem_dma_unmap_addr_set()
> > which handles the net_iov case when setting the dma address. A small
> > refactoring of mlx5e_dma_push() was required to be able to use this API.
> > The function was split in two versions and each version called
> > accordingly. Note that netmem_dma_unmap_addr_set() introduces an
> > additional if case.
> >
> > Splat:
> >   WARNING: CPU: 14 PID: 2587 at drivers/iommu/dma-iommu.c:1228 iommu_dma_unmap_page+0x7d/0x90
> >   Modules linked in: [...]
> >   Unloaded tainted modules: i10nm_edac(E):1 fjes(E):1
> >   CPU: 14 UID: 0 PID: 2587 Comm: ncdevmem Tainted: G S          E       6.15.0+ #3 PREEMPT(voluntary)
> >   Tainted: [S]=CPU_OUT_OF_SPEC, [E]=UNSIGNED_MODULE
> >   Hardware name: HPE ProLiant DL380 Gen10 Plus/ProLiant DL380 Gen10 Plus, BIOS U46 06/01/2022
> >   RIP: 0010:iommu_dma_unmap_page+0x7d/0x90
> >   Code: [...]
> >   RSP: 0000:ff6b1e3ea0b2fc58 EFLAGS: 00010246
> >   RAX: 0000000000000000 RBX: ff46ef2d0a2340c8 RCX: 0000000000000000
> >   RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> >   RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8827a120
> >   R10: 0000000000000000 R11: 0000000000000000 R12: 00000000d8000000
> >   R13: 0000000000000008 R14: 0000000000000001 R15: 0000000000000000
> >   FS:  00007feb69adf740(0000) GS:ff46ef2c779f1000(0000) knlGS:0000000000000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 00007feb69cca000 CR3: 0000000154b97006 CR4: 0000000000773ef0
> >   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >   PKRU: 55555554
> >   Call Trace:
> >    <TASK>
> >    dma_unmap_page_attrs+0x227/0x250
> >    mlx5e_poll_tx_cq+0x163/0x510 [mlx5_core]
> >    mlx5e_napi_poll+0x94/0x720 [mlx5_core]
> >    __napi_poll+0x28/0x1f0
> >    net_rx_action+0x33a/0x420
> >    ? mlx5e_completion_event+0x3d/0x40 [mlx5_core]
> >    handle_softirqs+0xe8/0x2f0
> >    __irq_exit_rcu+0xcd/0xf0
> >    common_interrupt+0x47/0xa0
> >    asm_common_interrupt+0x26/0x40
> >   RIP: 0033:0x7feb69cd08ec
> >   Code: [...]
> >   RSP: 002b:00007ffc01b8c880 EFLAGS: 00000246
> >   RAX: 00000000c3a60cf7 RBX: 0000000000045e12 RCX: 000000000000000e
> >   RDX: 00000000000035b4 RSI: 0000000000000000 RDI: 00007ffc01b8c8c0
> >   RBP: 00007ffc01b8c8b0 R08: 0000000000000000 R09: 0000000000000064
> >   R10: 00007ffc01b8c8c0 R11: 0000000000000000 R12: 00007feb69cca000
> >   R13: 00007ffc01b90e48 R14: 0000000000427e18 R15: 00007feb69d07000
> >    </TASK>
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Reported-by: Stanislav Fomichev <stfomichev@gmail.com>
> > Closes: https://lore.kernel.org/all/aFM6r9kFHeTdj-25@mini-arch/
> > Fixes: 5a842c288cfa ("net/mlx5e: Add TX support for netmems")
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> 
> Hmm, a couple of issues I see, but I'm not sure if it's really wrong
> or my own non-understanding.
> 
> I don't see  netmem_dma_unmap_page_attrs called anywhere in your
> driver. The point of  netmem_dma_unmap_addr_set setting the addr to 0
> is that a later call to netmem_dma_unmap_page_attrs skips the
> dma-unmap call if it's 0.
It is called in mlx5e_tx_dma_unmap() [1]. This was added previously in
commit 5a842c288cfa ("net/mlx5e: Add TX support for netmems") and Stan
noticed that the required netmem_dma_unmap_addr_set() is missing.

> 
> I could not understand why the mlx5/core/* files still used the
> non-netmem variant. The netdev->netmem_tx was set to true in
> mlx5/core/en_main.c, so I would have thought at least all the
> mlx5/core/en_tx.c callsites should have gone to that.
> 
Only the skb frags use the netmem variants. The headers still use the
dma_map/unmap_single() API.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h#n375

Thanks,
Dragos

