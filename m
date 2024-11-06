Return-Path: <linux-rdma+bounces-5780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80AD9BDE59
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 06:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A64B22FA6
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 05:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330DF1917CE;
	Wed,  6 Nov 2024 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tdQX4NTY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD74084D;
	Wed,  6 Nov 2024 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730871878; cv=fail; b=dEztBmJ/YjOPyAiMZeA9eBpEGen+XVrAZPn8MWasHJOONNU3bnuWOBCj2otKY4Z8Nx3B/rV/bZJkTKNqE84sQ/9VV0gELFuJ5udYeqVDYH7hsiW3zJyu/wRJElvNuWWZ+YQKP7EKNT2CX3OABKLF4dfysXddQC6SUr6YcaU780s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730871878; c=relaxed/simple;
	bh=Su/z36lsfSRZkZ7SE28bZj066RyVqUmCoBjpaj5MdgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BM6Wlk/yMYyNMqlCaTo/neSOihmBaA3840JXyIu1OF8kLAOcVL8ChNDTJU8a2nAPCi7e8AYcGyuYRjxA/Zf3uLRnO2g4U9W2SpBBztADX9rsshHMXbvjdy/ea40RGtsxLivmU9aM6JcST7NJiCniL7kxreMcZQD53NGay904T10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tdQX4NTY; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3U9jotgTRpV/Z/r7QcJdRGlW3v7u3HspNawH540uheiMV3Q6POZDvisrP/f/3l/2qDH9ZgpKJqPZ6KEmmtVkJ3GsKU3XvDVWNgkpk9ynCSP+Rts/1KWTfelh2Qn/adZ29UxgQXte8iu8yySWuyIQUlIR4t9MEfAGYVCv6HBXGJinktZqZGO/D6RyB6vLOc9mJXxsRiAiuzhY21+egcf+32nJYYY574szXgpohlmzbHlwNRVRYof1XU4kQ6WNfFiUqM7/IcBB+947owfPBZeTTcbH8gR93xDEOCCJQek6NbWs9G9JQ2TCr8I0z1wplGSi/qsUVmq7drXWOMh/pGvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su/z36lsfSRZkZ7SE28bZj066RyVqUmCoBjpaj5MdgE=;
 b=SkKj62Q2no7+i4cJf1WAxfRmRfHz0to2On0jGGOeBMTWEYY7IMNxP0+N/U00DjNsbBKW3dx12S7PWrdWSQJhGycyL4L7J7vgaEYatC4gkhFHDI4pOUD/pKXwh/vHPm9gGBkoqQOziDL4NDEPF2Dw1h9/EvwO/YJH/pAfc2reKf8I22s8SIzOk8ugPdclwBsmgDyQR/hoXlNm+/LY9gpdTWhfRJKiSeDmVohRuTIftscIDiiPXfnihho42RcAZSWg2vbhL1jngLYyq+hsIEfykdWmWZQCjVCV9uqKzmfp3ogbKTitxNtwnH7O1jXvi2xCie0W6q91PN8e7VoB8E/7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su/z36lsfSRZkZ7SE28bZj066RyVqUmCoBjpaj5MdgE=;
 b=tdQX4NTY0oDF6DqMViMjXL5zr7mogRFhUG8stzUASgFl2r6odXn0UIB5zwF9PwGOHBnU1Vy7k/p+zvjMuQoKA3DDzRGB2SlWweQXN8LW+7TYYpZv0+qmNG6IqKZGxJy8XmxaPOVsjldDi5Y7MFyZZ0wTUso+x7MSzk8I+kCJ4xkEiwUVNBk01p0r/UpaX9ayLFSb5aztHQNOHTST4k40+qNY67ADIPXE581nLjnyELgwSeqtQVIJ1KNqFOjfqj7l4uebWzIuqLWFyP8hewbU/PatpRFfjnqowJVlCAOA55kfJ1WZDWPT1PPUmeF8yF6TR8u5d4Il8+lfYSeDgwiGHA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 05:44:29 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 05:44:29 +0000
From: Parav Pandit <parav@nvidia.com>
To: Caleb Sander <csander@purestorage.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] mlx5/core: deduplicate
 {mlx5_,}eq_update_ci()
Thread-Topic: [PATCH net-next 2/2] mlx5/core: deduplicate
 {mlx5_,}eq_update_ci()
Thread-Index: AQHbLBDvBoxTaznD+0G3MAKMk1HOTrKk6zPQgAE5WoCAAgfKUIAAtNuAgADi7uA=
Date: Wed, 6 Nov 2024 05:44:28 +0000
Message-ID:
 <CY8PR12MB7195FDC4A280F4CD7EA219ABDC532@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241101034647.51590-1-csander@purestorage.com>
 <20241101034647.51590-2-csander@purestorage.com>
 <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZofFwy12oZYTmm3TE314RM79EGsxV6bKEBRMVFv8C3jNg@mail.gmail.com>
 <CY8PR12MB71953FD36C70ACACEBE3DBA1DC522@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZqanDo+v_jap7pQire86QkfaDQE4HvhvVBb64YqKNgRHg@mail.gmail.com>
In-Reply-To:
 <CADUfDZqanDo+v_jap7pQire86QkfaDQE4HvhvVBb64YqKNgRHg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA0PR12MB8421:EE_
x-ms-office365-filtering-correlation-id: 5171492f-2055-4a41-fe94-08dcfe2614b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajVOdHAzbnhRZFV6K1RCbDdBdTBsWHllYnNJaU1MSit4Sk1XWURxdzRvcTdP?=
 =?utf-8?B?cndvdW1KLzd1M2ZDakpmWSs4bElKbXUvWG9kazRxNjdVdVc1U1BhLzNFTnBx?=
 =?utf-8?B?WFdidlNnSzFVR0hTM3VtVWpXY2x3dyt6OFhBNmJYd01kYmcxY0R5eUZVWWx4?=
 =?utf-8?B?QVVRNUdkZy9YTWJjUTVab1IvZ25WQTVncHRvMk80TmtXZmRBb2hydVNvaXN1?=
 =?utf-8?B?Q3A0dUw1bnVNOWFYNjdFVHNLRkZqZ1FPTUZBdzI0OFdYYk1kbDJHenVQK2Ru?=
 =?utf-8?B?QjdWRmVHZDdubXFFN1RyNXByYzZYdVBMb0d2WjZDRjdqZTFjSzNvd2w4dXUw?=
 =?utf-8?B?dFh6QzQwQTA2S21KZ3o3ZTRoRWx0UFgwR1hlOFp0ZzRJTTZMckorTXVVdFgw?=
 =?utf-8?B?MmlueWhoSGhNUkxESHVxRzJwaWIvSVdTeXBMZ2xqY2IyR0srZFQ4VFNVTHVB?=
 =?utf-8?B?M25zZVQ4dkNUS2haSTVjWXduQXdJODBWdnNHNEFTK0Z2ZGp0Q2VsWktaZHR4?=
 =?utf-8?B?K01YWktteXhiak90dENpNExkRGhxc2g1eDloZkJ0NThvdzZWT3FoL005K2Zx?=
 =?utf-8?B?Nk5JUGNmZHZqbXZEMThPK1FEdEF2NU9zZENsODVLMnl2QWNtUGhaTngrcUh3?=
 =?utf-8?B?Tk9zblhITkVqY2sxckJMeERoNzNzVkJUTEtEaHU5eklpQnpiTmRxbGdMSHVC?=
 =?utf-8?B?aWtRWWhJY0FtZnNET1ZFU1U4NWRiWFJqL3hjM1JlS0VKMUwvSzJubEZtRTFQ?=
 =?utf-8?B?bFBUY2k0RjBDVUdrUVpiWEtmWWc4NmtuR1ROd3VtWG5FbGhhRVJWbE5nb1hn?=
 =?utf-8?B?eXZjcVorYmQvRFJTZUtaaXo3b0tXRzJmYjR2MkpXZzV3UVp4UGlTT1NjQThK?=
 =?utf-8?B?VHFyZWx2Vk13eXM3NVRZNFlPT2h5WTNkU29MVDYwbEwxcjNqcFh0UmpqOEc0?=
 =?utf-8?B?dmsyZkt3VzFkUnJPOTAwY21Cbk5vMzNnVmlyQUdGSjRpc3NPclFOYWdYTGpB?=
 =?utf-8?B?Yk52V3dUZStNV3IrL1BObTNqWHRwR1FkUG12V3QxNmp6a0I0RVhITmdwK3ZP?=
 =?utf-8?B?RmJCT2FwQXVBRUtmMnorV3U1eEtIeHNPRkVhYmpFNndvcmlvdDFZY0NOa1Na?=
 =?utf-8?B?SEFJWWdYRFdvV0FQZ091elBjcFMvSU9BYWlkSk50YVJtNThubE92dlBmbEQv?=
 =?utf-8?B?L1pZcXE3dUd0T0hKL3lPZlJKY1V4UUt3MnNOTWl3QUZDWUkrT1Z5VUphVys0?=
 =?utf-8?B?am4xcGV2ZG5tRFp4djMxNTFrOTF2MTh5d3dRZHROck1sSjZuNjFlRFpWODZa?=
 =?utf-8?B?emNnV010dlNPSVZQWGV3T2hLNVhhU2RGSU9TcENERm1FTDFLNVhTaEhRUERa?=
 =?utf-8?B?VDdPL3Y5RWt4cUVmcWhLTDVhWlM2TlI1NzMrc0x1V2M4TDFhc3FxckU5RzFy?=
 =?utf-8?B?VktvYmJRclgvcFBqdWl3KzVXRS9ZcGJDT3FlaDRxcEVOS3JiMXZ6dVhyeWFz?=
 =?utf-8?B?NWprRXlsR2RDTWRYTExBckcvektLaGVFazVERzE0MW1GZGZGSzFvNG5yaFp6?=
 =?utf-8?B?V0VQcnFuNk5iSkRHSHRsQWFwMkszUWl1Zkg1T01LYmlGeGlDTWRjUWRLZWZY?=
 =?utf-8?B?MmNpVmxEUzFLR2FZTUthQTV6SlJ4N3NhbU5scDNseGo2VGR4WUFzWEV6Qkxt?=
 =?utf-8?B?MVNwMmJqdW9yMjlYc1VvaU1uZmZkTTVHZzJCTlVGYzVMcEVIWk9ob2ExcmtZ?=
 =?utf-8?B?eDcrUUI1QWgrcDV2WXpkTmJMSTN6anFKcGhuS05EV1JLVnROZUVGRDZlRGtw?=
 =?utf-8?B?MmZlUWJXQ0xTcjVVVFNUWkR3dVNVN0tMSkRrRU5RcGNVQVN6QTlXdVdSY2xV?=
 =?utf-8?Q?wl7eCe+LaZChe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dko0WWt3dUJabnpYRnJZR25ZRU9YWGZYNk11QkpWSTBaakZ2YkxpNFdNblNw?=
 =?utf-8?B?cGRHemdIdjArVG5TVGpmaVg0QTE1TVJMOWorLzRMTE90SU9hbm0xU1UrMmhZ?=
 =?utf-8?B?bUhvSmJ0aUlLOU11T0F2bGN5Znk5T3p5VVhkOFZ4cEY5Ky9Bd3UxVEdnTEM5?=
 =?utf-8?B?YXZHaklDT2dJdSt2ZkZDVUJsVWp4VlE5U0JkbVhXNnpKQ25iSElmdnh6MDFJ?=
 =?utf-8?B?Zkh2NXpEMklDUDhLMkNVSkV3a2x2OHNnamhldnpIU3VEd2ZYVnMxcFNQZ3RM?=
 =?utf-8?B?VVh4WXpMN04xOG9kYWV5QVYyaUcrQTlnLytNeUtMK3B2NFUweVNwcTRGTFZD?=
 =?utf-8?B?M1ZEWkhwa3hnVXdGY3JtNW5tMDRVY0dKQU5rZDUwNFArUHBTdTVyUVhEOXhw?=
 =?utf-8?B?eVBtTlY0SHgyK0VJMkNkTWFHUFcvQldOUjZaWjY0K1hyd1ppUkd4cmpZVlM4?=
 =?utf-8?B?WUlhdzl3eXRPdGgvakJYYnBMaXZ2QVNCeGpRZGtQZXZzdzdCb2ZDb0RoeGpS?=
 =?utf-8?B?UzFHR1lTSTVkY2VXTm9id2FJUE1zMDJOSExHQ1lidXZtM0ZVbmhGNVRwanpG?=
 =?utf-8?B?UklzODNNOHBjWmxCZUtYS0JOOXpRcFNPZzBQbUVPbGhsdHd1Ym03MHF5UkdQ?=
 =?utf-8?B?Q0N2cnE4TDNiYzFuZUtrYXZBR3MvQkNuWCs0M1ZVdytRc041Sm04Y3E2dVhO?=
 =?utf-8?B?Z00xdnVZK011alg1NkU4dU1DQkZzVkNyRUFpUGJ1Q2dkeGJHS0gvQnNqMlU3?=
 =?utf-8?B?SDkrVzBtNm05Y0YrcnRvOWR3RHkrQVFIOGZPUHl4aHpBb012Um1nTkFXQmJT?=
 =?utf-8?B?NktsRUlnQnZXSno0SnRkOWpiL2NNQmJQeW9jTzJUUkgrSTNGQS93ZjkyMWli?=
 =?utf-8?B?VlMybUtPZjllYkx3U0x5Y2ZpbVlET2ZCVVFHUDhPWHNSMktOVnBzd1cxUzZ1?=
 =?utf-8?B?cktLd3VRK3V2bFZtVDlSSVpaTlRBbjlHSFJ4ckVJUU8yenVtdHVQZ2w1NVBj?=
 =?utf-8?B?Zjc4ODVPdHFhd2E3ekhKNGtFSUxiSG1XNWhVS0YwQ3A3NllEb3R2ZWUzMWdI?=
 =?utf-8?B?Wk15M2xFNDc5RE9CZjRuMzVhU1hMK2VFcFhHMmlYeDQzYWFTZnZsUUdIcnZz?=
 =?utf-8?B?cGdDQ1NKZEtlczdHTDRZZ0tHVEJrdkRCbU9tTklCbEQzSy9zcmdZUk5WMm5U?=
 =?utf-8?B?dXBTNDh4N3haNlN5WkJRZHNZU1ZNcmN6Yk9haEVSaitzNVBvVkRRYlV3eGJH?=
 =?utf-8?B?YzFBVWtHNXdEb2pIQVV1Q3BocjRaRnFnZkF6L3Zab3NRZHlMVTNvUkpQdjhY?=
 =?utf-8?B?SHlzRnlEQzNMRWFkemFkeWpVTE82RUsyY2ZHZDRXU2JPY0pmcHRrYVRPajd0?=
 =?utf-8?B?ZGhLVGRDUnI2eWRRR09lUTdFb3VaNnpDYStaQVl3amFOZHlDUCt3YVlld3lE?=
 =?utf-8?B?ak45M0dlakw3VmxoclhEa2I1MVhETnp5cjluSVdDWVptMitmV0U5RGQxd0J4?=
 =?utf-8?B?OURLZFVsNDlmTlY1K0dSVmUyTCtCbHZyUm5SOHhlZzRlOHl6U3hQaUJRNGZ3?=
 =?utf-8?B?Tkh1OTU1b3JEbkVQbWpQRVY5ZkJ0L1Y1allHYWZRNUZ4QzV3YjhJMExsYnA0?=
 =?utf-8?B?VlZZU0QwNTVKbXNUdFQrS2JrdGlZRk01NFN1ZzZSeUdSRmM5NFByNUFXQVcw?=
 =?utf-8?B?UTYyeWVnRW1PSWNTTWFKTkcxU0J4QyszdU8xQWJ6WG40QkhVajNUSm5KSXdO?=
 =?utf-8?B?WEwxeWRGcDkwUjU2bFhIVUJPeUl5dmdvOXRscTdDakJwOW1MYmN4QVdkMGlN?=
 =?utf-8?B?QmtTcmZkQyswcHEzMVpkUVJZamlYK3NWTk9ERFFCR0xrVjdnUXhua2RUMG5O?=
 =?utf-8?B?bFl0ZzhXdFRDZzNsTjRpMjkxMGVRY3FoVkR0aHNoeEMrU2VUc1FOS2VqMGYw?=
 =?utf-8?B?U0dNaGlwdzRiNU9zK2J1dWhmMXRoNjB1OWxzYTVIUndlRkFBTERIU3RmcnJN?=
 =?utf-8?B?Y3RiUk1Hc2gwQlh4Vi9FYVZGZ09HdGV1U2w1UnFPRDNwdmVpWkxUc01YclJp?=
 =?utf-8?B?NElTdEdXMzZwZ0pqZEFwNkZGa3hQTXRtQjJ3RzRaN3hWWnQralBXWWgrbDMx?=
 =?utf-8?Q?YeF4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5171492f-2055-4a41-fe94-08dcfe2614b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 05:44:28.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zu8b+Rs9QpDH6xprkuSZAbt184TSfa/V3VFxkdi15OjhT3qR8IykCPcxvBKgDNN+ejDh1sjp/DWD7txA5b71pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421

DQo+IEZyb206IENhbGViIFNhbmRlciA8Y3NhbmRlckBwdXJlc3RvcmFnZS5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIE5vdmVtYmVyIDUsIDIwMjQgOTozNiBQTQ0KPiANCj4gT24gTW9uLCBOb3YgNCwg
MjAyNCBhdCA5OjIy4oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToN
Cj4gPg0KPiA+DQo+ID4NCj4gPiA+IEZyb206IENhbGViIFNhbmRlciA8Y3NhbmRlckBwdXJlc3Rv
cmFnZS5jb20+DQo+ID4gPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDQsIDIwMjQgMzo0OSBBTQ0K
PiA+ID4NCj4gPiA+IE9uIFNhdCwgTm92IDIsIDIwMjQgYXQgODo1NeKAr1BNIFBhcmF2IFBhbmRp
dCA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+DQo+
ID4gPiA+ID4gRnJvbTogQ2FsZWIgU2FuZGVyIE1hdGVvcyA8Y3NhbmRlckBwdXJlc3RvcmFnZS5j
b20+DQo+ID4gPiA+ID4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxLCAyMDI0IDk6MTcgQU0NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBsb2dpYyBvZiBlcV91cGRhdGVfY2koKSBpcyBkdXBsaWNh
dGVkIGluIG1seDVfZXFfdXBkYXRlX2NpKCkuDQo+ID4gPiA+ID4gVGhlIG9ubHkgYWRkaXRpb25h
bCB3b3JrIGRvbmUgYnkgbWx4NV9lcV91cGRhdGVfY2koKSBpcyB0bw0KPiA+ID4gPiA+IGluY3Jl
bWVudA0KPiA+ID4gPiA+IGVxLT5jb25zX2luZGV4LiBDYWxsIGVxX3VwZGF0ZV9jaSgpIGZyb20g
bWx4NV9lcV91cGRhdGVfY2koKSB0bw0KPiA+ID4gPiA+IGVxLT5hdm9pZA0KPiA+ID4gPiA+IHRo
ZSBkdXBsaWNhdGlvbi4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENhbGVi
IFNhbmRlciBNYXRlb3MgPGNzYW5kZXJAcHVyZXN0b3JhZ2UuY29tPg0KPiA+ID4gPiA+IC0tLQ0K
PiA+ID4gPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZXEuYyB8
IDkgKy0tLS0tLS0tDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
OCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZXEuYw0KPiA+ID4gPiA+IGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VxLmMNCj4gPiA+ID4gPiBpbmRleCA4
NTlkY2YwOWI3NzAuLjA3ODAyOWM4MTkzNSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZXEuYw0KPiA+ID4gPiA+ICsrKyBiL2Ry
aXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9lcS5jDQo+ID4gPiA+ID4gQEAg
LTgwMiwxOSArODAyLDEyIEBAIHN0cnVjdCBtbHg1X2VxZSAqbWx4NV9lcV9nZXRfZXFlKHN0cnVj
dA0KPiA+ID4gPiA+IG1seDVfZXEgKmVxLCB1MzIgY2MpICB9ICBFWFBPUlRfU1lNQk9MKG1seDVf
ZXFfZ2V0X2VxZSk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgdm9pZCBtbHg1X2VxX3VwZGF0ZV9j
aShzdHJ1Y3QgbWx4NV9lcSAqZXEsIHUzMiBjYywgYm9vbCBhcm0pICB7DQo+ID4gPiA+ID4gLSAg
ICAgX19iZTMyIF9faW9tZW0gKmFkZHIgPSBlcS0+ZG9vcmJlbGwgKyAoYXJtID8gMCA6IDIpOw0K
PiA+ID4gPiA+IC0gICAgIHUzMiB2YWw7DQo+ID4gPiA+ID4gLQ0KPiA+ID4gPiA+ICAgICAgIGVx
LT5jb25zX2luZGV4ICs9IGNjOw0KPiA+ID4gPiA+IC0gICAgIHZhbCA9IChlcS0+Y29uc19pbmRl
eCAmIDB4ZmZmZmZmKSB8IChlcS0+ZXFuIDw8IDI0KTsNCj4gPiA+ID4gPiAtDQo+ID4gPiA+ID4g
LSAgICAgX19yYXdfd3JpdGVsKChfX2ZvcmNlIHUzMiljcHVfdG9fYmUzMih2YWwpLCBhZGRyKTsN
Cj4gPiA+ID4gPiAtICAgICAvKiBXZSBzdGlsbCB3YW50IG9yZGVyaW5nLCBqdXN0IG5vdCBzd2Fi
YmluZywgc28gYWRkIGEgYmFycmllciAqLw0KPiA+ID4gPiA+IC0gICAgIHdtYigpOw0KPiA+ID4g
PiA+ICsgICAgIGVxX3VwZGF0ZV9jaShlcSwgYXJtKTsNCj4gPiA+ID4gTG9uZyBhZ28gSSBoYWQg
c2ltaWxhciByZXdvcmsgcGF0Y2hlcyB0byBnZXQgcmlkIG9mDQo+ID4gPiA+IF9fcmF3X3dyaXRl
bCgpLCB3aGljaCBJIG5ldmVyIGdvdCBjaGFuY2UgdG8gcHVzaCwNCj4gPiA+ID4NCj4gPiA+ID4g
RXFfdXBkYXRlX2NpKCkgaXMgdXNpbmcgZnVsbCBtZW1vcnkgYmFycmllci4NCj4gPiA+ID4gV2hp
bGUgbWx4NV9lcV91cGRhdGVfY2koKSBpcyB1c2luZyBvbmx5IHdyaXRlIG1lbW9yeSBiYXJyaWVy
Lg0KPiA+ID4gPg0KPiA+ID4gPiBTbyBpdCBpcyBub3QgMTAwJSBkZWR1cGxpY2F0aW9uIGJ5IHRo
aXMgcGF0Y2guDQo+ID4gPiA+IFBsZWFzZSBoYXZlIGEgcHJlLXBhdGNoIGltcHJvdmluZyBlcV91
cGRhdGVfY2koKSB0byB1c2Ugd21iKCkuDQo+ID4gPiA+IEZvbGxvd2VkIGJ5IHRoaXMgcGF0Y2gu
DQo+ID4gPg0KPiA+ID4gUmlnaHQsIHBhdGNoIDEvMiBpbiB0aGlzIHNlcmllcyBpcyBjaGFuZ2lu
ZyBlcV91cGRhdGVfY2koKSB0byB1c2UNCj4gPiA+IHdyaXRlbCgpIGluc3RlYWQgb2YgX19yYXdf
d3JpdGVsKCkgYW5kIGF2b2lkIHRoZSBtZW1vcnkgYmFycmllcjoNCj4gPiA+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvMjAyNDExMDEwMzQ2NDcuNTE1OTAtMS0NCj4gPiA+IGNzYW5kZXJA
cHVyZXN0b3JhZ2UuY29tLw0KPiA+IFRoaXMgcGF0Y2ggaGFzIHR3byBidWdzLg0KPiA+IDEuIHdy
aXRlbCgpIHdyaXRlcyB0aGUgTU1JTyBzcGFjZSBpbiBMRSBvcmRlci4gRVEgdXBkYXRlcyBhcmUg
aW4gQkUgb3JkZXIuDQo+ID4gU28gdGhpcyB3aWxsIGJyZWFrIG9uIHBwYzY0IEJFLg0KPiANCj4g
T2theSwgc28gdGhpcyBzaG91bGQgYmUgd3JpdGVsKGNwdV90b19sZTMyKHZhbCksIGFkZHIpPw0K
PiANClRoYXQgd291bGQgYnJlYWsgdGhlIHg4NiBzaWRlIGJlY2F1c2UgZGV2aWNlIHNob3VsZCBy
ZWNlaXZlIGluIEJFIGZvcm1hdCByZWdhcmRsZXNzIG9mIGNwdSBlbmRpYW5uZXNzLg0KQWJvdmUg
Y29kZSB3aWxsIHdyaXRlIGluIHRoZSBMRSBmb3JtYXQuDQoNClNvIGFuIEFQSSBmb29fd3JpdGVs
KCkgbmVlZCB3aGljaCBkb2VzIA0KYS4gd3JpdGUgbWVtb3J5IGJhcnJpZXIgDQpiLiB3cml0ZSB0
byBNTUlPIHNwYWNlIGJ1dCB3aXRob3V0IGVuZGluZW5lc3MgY29udmVyc2lvbi4NCg0KPiA+DQo+
ID4gMi4gd3JpdGVsKCkgaXNzdWVzIHRoZSBiYXJyaWVyIEJFRk9SRSB0aGUgcmF3X3dyaXRlbCgp
Lg0KPiA+IEFzIG9wcG9zZWQgdG8gdGhhdCBlcSB1cGRhdGUgbmVlZHMgdG8gaGF2ZSBhIGJhcnJp
ZXIgQUZURVIgdGhlIHdyaXRlbCgpLg0KPiA+IExpa2VseSB0byBzeW5jaHJvbml6ZSB3aXRoIG90
aGVyIENRIHJlbGF0ZWQgcG9pbnRlcnMgdXBkYXRlLg0KPiANCj4gSSB3YXMgcmVmZXJlbmNpbmcg
dGhpcyBwcmlvciBkaXNjdXNzaW9uIGFib3V0IHRoZSBtZW1vcnkgYmFycmllcjoNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L0NBTHpKTEc4YWYwU01mQTFDOFU4cl9GZGRiX1pRaHZF
WmQ2PTINCj4gYTk3ZE9vQmNnTEEweGdAbWFpbC5nbWFpbC5jb20vDQo+IEZyb20gU2FlZWQncyBt
ZXNzYWdlLCBpdCBzb3VuZHMgbGlrZSB0aGUgbWVtb3J5IGJhcnJpZXIgaXMgb25seSB1c2VkIHRv
DQo+IGVuc3VyZSB0aGUgb3JkZXJpbmcgb2Ygd3JpdGVzIHRvIHRoZSBkb29yYmVsbCByZWdpc3Rl
ciwgbm90IHRoZSBvcmRlcmluZyBvZiB0aGUNCj4gZG9vcmJlbGwgd3JpdGUgcmVsYXRpdmUgdG8g
YW55IG90aGVyIHdyaXRlcy4gSWYgc29tZSBvdGhlciB3cml0ZSBuZWVkcyB0byBiZQ0KPiBvcmRl
cmVkIGFmdGVyIHRoZSBkb29yYmVsbCB3cml0ZSwgcGxlYXNlIGV4cGxhaW4gd2hhdCBpdCBpcy4g
DQpOb3Qgd3JpdGUsIHJlYWRpbmcgb2YgdGhlIENRRSBsaWtlbHkgcmVxdWlyZXMgcmVhZCBiYXJy
aWVyLg0KDQo+IEFzIEdhbCBQcmVzc21hbg0KPiBwb2ludGVkIG91dCwgYSB3bWIoKSBhdCB0aGUg
ZW5kIG9mIGEgZnVuY3Rpb24gZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UsIGFzDQo+IHRoZXJlIGFy
ZSBubyBmdXJ0aGVyIHdyaXRlcyBpbiB0aGUgZnVuY3Rpb24gdG8gb3JkZXIuIElmIHRoZSBkb29y
YmVsbCB3cml0ZSBuZWVkcw0KPiB0byBiZSBvcmRlcmVkIGJlZm9yZSBzb21lIG90aGVyIHdyaXRl
IGluIGEgY2FsbGVyIGZ1bmN0aW9uLCB0aGUgbWVtb3J5IGJhcnJpZXINCj4gc2hvdWxkIHByb2Jh
Ymx5IG1vdmUgdG8gdGhlIGNhbGxlci4NCkl0IGlzIHRoZSB0d28gRVEgZG9vcmJlbGwgd3JpdGVz
IHRoYXQgbmVlZHMgdG8gYmUgb3JkZXJlZCB3aXRoIHJlc3BlY3QgdG8gZWFjaCBvdGhlci4NClNv
IHBsZWFzZSBhdWRpdCB0aGUgY29kZSBmb3IgQ1FFIHByb2Nlc3NpbmcgZW5zdXJlIHRoYXQgdGhl
cmUgaXMgcmVhZCBiYXJyaWVyIGFmdGVyIHZhbGlkIGJpdC4NCkFuZCByZW1vdmFsIG9mIHRoaXMg
cmVhZCBiYXJyaWVyIGRvZXMgbm90IGFmZmVjdCB0aGVyZS4NCg0KSXQgd291bGQgYmUgYmVzdCBp
ZiB5b3UgY2FuIHRlc3Qgb24gQVJNIChub24geDg2XzY0KSBwbGF0Zm9ybSBmb3IgdGhpcyBjaGFu
Z2UuDQoNCj4gDQo+ID4NCj4gPiA+IEFyZSB5b3Ugc3VnZ2VzdGluZyBzb21ldGhpbmcgZGlmZmVy
ZW50PyBJZiBzbywgaXQgd291bGQgYmUgZ3JlYXQgaWYNCj4gPiA+IHlvdSBjb3VsZCBjbGFyaWZ5
IHdoYXQgeW91IG1lYW4uDQo+ID4gPg0KPiA+IFNvIEkgd2FzIHN1Z2dlc3RpbmcgdG8ga2VlcCBf
X3Jhd193cml0ZWwoKSBhcyBpcyBhbmQgcmVwbGFjZSBtYigpIHdpdGgNCj4gd21iKCkuDQo+IA0K
PiB3bWIoKSB3b3VsZCBjZXJ0YWlubHkgYmUgY2hlYXBlciB0aGFuIG1iKCksIGJ1dCBJIHdvdWxk
IGxpa2UgdG8gdW5kZXJzdGFuZA0KPiB0aGUgcmVxdWlyZW1lbnQgZm9yIHRoZSBiYXJyaWVyIGlu
IHRoZSBmaXJzdCBwbGFjZS4gVGhlIGZlbmNlIGluc3RydWN0aW9uIGlzIHZlcnkNCj4gZXhwZW5z
aXZlLg0KPiANClRvIG9yZGVyIHR3byBkb29yYmVsbCB3cml0ZXMgb2YgdGhlIHNhbWUgRVEuDQoN
Cj4gVGhhbmtzLA0KPiBDYWxlYg0K

