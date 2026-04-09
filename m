Return-Path: <linux-rdma+bounces-19184-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBFsMSLq12msUggAu9opvQ
	(envelope-from <linux-rdma+bounces-19184-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:04:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F143CE6B6
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F6D63011C6F
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1953D9DB2;
	Thu,  9 Apr 2026 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ryXLtWTQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040631A682F;
	Thu,  9 Apr 2026 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757768; cv=fail; b=PLNiIfxLus0H2E5WToan7BUrwxHAmdi/Kyai8EWzrvqjLllwvCTH4nlX+YFs1f5SwDKAqBHzeZ+gzsTG3Snjvv8On+YgsrlAp97dhWwZxtFuKhGYqTGr045d3+LOx3gmeaz4xzqmJny250zuW6wZ84Ph8isUSgTXHHz/S5mPawU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757768; c=relaxed/simple;
	bh=FIuo/MTjLgUOaBfnxRz4oUkUEi+9F5lFRGTkrxBelKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XAf2GPkOB10HiPtnkHeLsS7v91EwGJ/hnuIY/rXjmCSu69i7Y1I3Da0tB/8i4fjhKeUmlBMLG9HSUmxhPDSbaO6uYanMl2CaCVil9Q7LrZjWi1/5dTxOpMZn0p2D+/mRCnfbCV4GypWJd+Nt+eIqZuC/26fD18IZ6xDJ6AwK5n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ryXLtWTQ; arc=fail smtp.client-ip=52.101.61.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMwt4tsHYOj34jica3s4kVlUsgyVMFklpLv+qT4a1LRX07QgWoimgd5sZlxKjIgaoyyuslryoyKxxpZooUymxBRB9Ab3BIoDTDa3nQffIo901QIJzdcEyTJ5wnru2zrvU9q3iBhY2ceAn63093iZ6LxDUd4/N97+Kg73S7k0VRlQKz/NwaOJL6LFnMgrLaEd49/sT2DxGj/IdjWxTbyZGxzlG2pUqosmeVolqgMYtZ4y4s9+hy6g/+1fLDzZDUoZd5cq4XcBmM3XZTiLNdPkC7LXW/OL4nNxI2VSZZ6oGKPgc2yIrfOD1bfcNOr/HjPlglLqh5yWI8mUPZ6g0DMb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfH6FeRnuIh9DuJ8EvJd0kGlIkMbkHn7iwaVYKEIKWE=;
 b=HoT1fF7MRLV4mdbowh9FJhjKldy6iAEOg6cZymhTyzJh0FB3CearCyAE61nF46XoBb3IA1LcEuNOMqWt9ZbPI510VOvtO2WIFvrNuF4nLEw9IjYDguZBzRJcKi/GGwK5PRNtTlnDATG6Kc+z3rGA3l8jtzOohDnPjb/qIboJIdK6b5JltKzSSGH45rpLjlDNqnUJ1/niZ6eBybZplnMWeFqJHAyJz5UcXNbRy9cEfKB35jZY3SmAUTVQsWc15zPlZXYT/peS09wqM8ZXluEaYsVKaD/q5lzBq6m6N/XPcW/9dJZGN4iTHS4oeLRueWURTtL1KviLcfo8dnYY3Dy1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfH6FeRnuIh9DuJ8EvJd0kGlIkMbkHn7iwaVYKEIKWE=;
 b=ryXLtWTQWkorgVTUKRuYV/3q6lm4mWPRF1hIFqiEtp/yWwhLP6K9OTLSxXCoB/ydC26v6fieBkKh9vWWZmt2eBqrtQA7t16dhfP+5lTKmTAq8w8ukPen/4ISwWmfTUh56CI3lAYK98DYFe9zuj2qQRnjRbFI3EG5R0G3CjqQwmpLePiFTb1kVwJHxy/wRFQxCYSWKlnrlTbeu73evwFoYTDVuTBbcTYSU7X0+aUHRnydAup7Cn04T5JRIsvnObcSah7TIH3RgQhAfIZReLZZkVYxwkISUK923Bdoo7cGeEtfSOodoY0Rw8ftlvATe68HNluO7h2XuWCr4WR0ONWwKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 18:02:43 +0000
Received: from IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7]) by IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 18:02:43 +0000
Message-ID: <77ebbbc8-2991-40cf-baa3-080f670aaae5@nvidia.com>
Date: Thu, 9 Apr 2026 21:02:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] net/mlx5: Add profile to auto-enable
 switchdev mode at device init
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Shay Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>,
 Simon Horman <horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 Kees Cook <kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
 <20260409115550.156419-8-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260409115550.156419-8-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To IA1PR12MB7541.namprd12.prod.outlook.com
 (2603:10b6:208:42f::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7541:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b82b635-b369-4995-4089-08de9662323f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18092099006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s9auFtBW3beBIQZdaDim3eNgUdfJEku+miyCMR8zJMUrq5ZrGN0mscrvHuJd2F7ir+fKU1gWREh8cLa62NiBfSEnSbx30vIksU09InYS85Tg+KXcJhmvkI+J7E8MRxsQswdhLJgCaTJZG3yFHP7G1AYqTzlXc8YPK8x+oRI2NybzlNBBFSD33USVGr795whhk7RPhWeKa3llaka2DHmVnpII0HcYX99odnsUsCyU1hTHZNKwaKdE25aJqMbC6Q/pGDqsyw7efVFqSxSljBp2lV+mKPDcqnr51bIVISuF9nBvTPZA/dsisIhzCNyZfKcn4zr9uSjl0lh/8v+e4e659c5PuxE2ZQemWl6wceQNKcwgexKMw9qQuGcSbLDBtY5C/5WYm4s1uiS3AD02GjoS5nR98BSNEu6TRoSVbOPrlP+9dSShpua7Rs0uwQZIlWRKM1ag/H7XcRhzNM5Md4TSNTbiL2gIiJ1hWl4Od0B2kzkt2uzFgRQ49LRdrs/erKUecGonC/W8FI1faPjwNChbNq3pbvOUXBHOtgy3RlEdYoi/NRJJn9UaJI4E32bxJib5DKpFL1nAu1wXvqnJkAxFi31uRkGce69lb53Y9TcIdwzFTtKmzGnTZQlsVcZRdeqBld41oM52uV8GOpYukPO2F2isLo3MlV00sev/loDZWYW6nrN/Jex75OYVO+x9OyJDQOFS1db+fsSHRrfN+vx/7ev6zVq2BfE4gOclJL2MFBM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7541.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18092099006)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUpzMVdjVE1yMVJZOGtRUlhyZUFXZlZlM1B5Q1RQUVk0SnBLc3REM2pSU01j?=
 =?utf-8?B?c0Ixckhzd2N6L1BqaFFWUXdRa3RHU1BiSUhTQkRjZjA0SG9KaTRCdCtSb1dy?=
 =?utf-8?B?Q1BURjFBMDNGUW8zTFNRQmZPUGIyWUM4N2lzV3dzcVN1VDNOUHNMcDFvNVRX?=
 =?utf-8?B?d3BQMW93OERVMHBmeStFV3FJMXVXcnFCK0p3Mmh5dzZkS2VzQVNodUZ5RWpV?=
 =?utf-8?B?YnhTa0UwU0Q2b2dwN29lYXhNK2FYd3d5RjRlQmVKdGFRd3pENGF5RkhNdmdP?=
 =?utf-8?B?eWI4OFFGbENjNGtvNFNXc0ZzSDBNQVBBMDl2SWprQzl5QmNmc2RnWXZCa2xz?=
 =?utf-8?B?SlZYTERmY1hSM3ZJMzlqY2ZjU2I3aUVZK0JIZFV4UEpiTTR0YXFabDE4aU9Z?=
 =?utf-8?B?N2VpVmFzM0N0cGE5SGZyc2lVTU1wRjBBRVRTUlFnU1pTa0lmWEFCbEtHSGt0?=
 =?utf-8?B?WHB2MWVXTERVbDNiRlF5WFpkSXIvSCtHOXZyalhyNjQzTE9NUlVvNnRmZytI?=
 =?utf-8?B?NThUZEI4c29XMVVUTmMrV3ZDMzJ5MUlMT3JmbkViQkxLOGlPTlhKSGIrVXBX?=
 =?utf-8?B?UlpXNXpBVmVjUWZ3S2Q1eUo2aitzbm9EaFpZbDc0bm5URlZmYlRkcnRNaUNQ?=
 =?utf-8?B?NFl5aUw4bll0WThaY2tuTHp0Rm4ya1hVZVpxMHRHL2s3d2RWUThZaG5FSjE5?=
 =?utf-8?B?VVhHN29nZG9GV1JxbVpLQUNwN28yZXVDZ2Nud0dxOGVyQWRWbHo2MEZiWW4r?=
 =?utf-8?B?TlpheExtanljUnZDWDl0UjdmR3NKazgrMTFpVmJ6d2NOWURBWkJHcEZHYVlO?=
 =?utf-8?B?Y29kcUxmbUtYN21MNm1BNHBQVmY1eXNYdTMzczBqOXROQXpXbnFNM3puRXRG?=
 =?utf-8?B?UnYxN3dNTytuR2xTZVJZYWtJOFJNMkF0dW13MDd3aSt5N0djYkl2NXJ1eUpU?=
 =?utf-8?B?ck9UOUlFM0pVRUtmR0NRcFNZU2dKTHFqaldKbUVIcS95ZDVCaFZnRkI3QnJa?=
 =?utf-8?B?WXd3TStnUFlINmoyRktnZTFad29FTzZDeVB3MUwzbktiMEl4cUlEMkZMNW9V?=
 =?utf-8?B?Wi94TVgwSXFJeDZSMEpROCtwMFZVNW5QRUY0NGM5NFNteW1RUXFZRmxNQlpS?=
 =?utf-8?B?WktGdi9Jb3lVOEg2UXZWSndMM3o5WnZ2Q2xqRVZ1WTRybjVKR2RBZncwT0ZS?=
 =?utf-8?B?N1dnRjcvaytpR0hzMFdKdzZFbTV1eUUrS21MNFd5cFdQUmNEWjFsK1NMMFpV?=
 =?utf-8?B?OWZZM3QvYzA3M1l0NEozZGljY0loVGJXQlllZkMvdTZQWThsNWNJU05KL1pH?=
 =?utf-8?B?MFp1ZTY0dnA3Wnh4a0Q3OHFaM0htdTIxbmlFbFNjRUlCY1JlV1FJY2NsNFRu?=
 =?utf-8?B?d3BWNE1pd0lDMjRaU2FKUUtuOGlxMEY0OG9ra3VHTDV2VDJ0VHBPN1p0VnJq?=
 =?utf-8?B?MlRRWUNiYzJlanhyWHdPdWU1TFEydmk3UGZvUkltbVBzdEFvNDFtWDJoR0Z2?=
 =?utf-8?B?WS8vS2RLL29QL0FWbkZFNngrbWVMMXh6YThpUjZ4cnJQK291UVRlSzdJeEp0?=
 =?utf-8?B?ZWx6TFZrREpPdG1CVk1CbytWMFJVTjZ4c2V4RVhndXVJOVBJUnc5eXV2ZFNZ?=
 =?utf-8?B?a3VqaHNNc1hLdnkzaFlBTTUyeGVMY0t5bTY3Z3dGSXNGdFdDUDdiK1JkTzdj?=
 =?utf-8?B?OVRuUzU4TnJvMmNGRGdmQmtmc3J0YnkxR0EyWVBpcUMyby90NU0xSnNnVUwr?=
 =?utf-8?B?QnhsNnozYi9GNHlNMm5MOGJRb2ZyaVBHSDE4T1owaG9FUEQyT0J2aytTbisv?=
 =?utf-8?B?V05uZHpHSzhrRDJ3dnhOZXFDSm1TT01OQi95RkFKN2cwTWFib2dWMDZIWi9l?=
 =?utf-8?B?RnhUV21ySGtaREZsNm9NVHh4QXltNFhyMklOK0FQVHZaYXlEckZ1akNPVmhO?=
 =?utf-8?B?bDlUSDIxcGtHUDJLNm5aYVZKeVRUdERiWC9rL0R1Qmd1TEh6UFdZcXZzTXQr?=
 =?utf-8?B?TW1OZWVaVFFRWDdiZVNYcXptbzMzNjluVS9tMFpETE1qaW44K0lDR1dpdjVE?=
 =?utf-8?B?SVlJMGlobTlyK2hjS1BHMkpkUTBxZlNDOXZCUXAweG1EMHo1WHlnc3p5Qk5H?=
 =?utf-8?B?ZFVHUjlXaWxUK1ZpM2RqY1pCbTh2dlNMTkFxZE5IdGpLbEovRTVXMjBaKytq?=
 =?utf-8?B?Lys0dGlVUUJjZGFucW1oaGttc2F4R2JZV3Bxd004MnRyWm5La3VmNEJqVGRP?=
 =?utf-8?B?cjBZM0VqR2tmQkFwN3cxT2tUUGlmemozaVQ0MDMxRm56K1ZxalhjYXRQSE1W?=
 =?utf-8?B?dE9OVk84d2U3a2w2SWlucHBZSlZWWGNTUTYzZjh2eEtUSnBsTWdHdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b82b635-b369-4995-4089-08de9662323f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:02:43.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNovXOxna1ncHuDRweRnjxDVNWHmwupjM6eErolI+MhzZCuPmmAlCm9azyvvVdGciE9vn9XJOv7xBNCPVQMDuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19184-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 66F143CE6B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/04/2026 14:55, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> Deployments that always operate in switchdev mode currently require
> manual devlink configuration after driver probe, which complicates
> automated provisioning.
> 
> Introduce MLX5_PROF_MASK_DEF_SWITCHDEV, a new profile mask bit, and
> profile index 4. When a device is initialized or reloaded with this
> profile, the driver automatically switches the e-switch to switchdev
> mode by calling mlx5_devlink_eswitch_mode_set() immediately after
> bringing the device online.
> 
> A no-op stub of mlx5_devlink_eswitch_mode_set() is added for builds
> without CONFIG_MLX5_ESWITCH.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/eswitch.h |  6 +++++
>  .../net/ethernet/mellanox/mlx5/core/main.c    | 26 ++++++++++++++++++-
>  include/linux/mlx5/driver.h                   |  1 +
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index 256ac3ad37bc..5dcca59c3125 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -1047,6 +1047,12 @@ mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
>  
> +static inline int
> +mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
> +			      struct netlink_ext_ack *extack)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_MLX5_ESWITCH */
>  
>  #endif /* __MLX5_ESWITCH_H__ */
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index dc7f20a357d9..12f39b4b6c2a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -86,7 +86,7 @@ MODULE_PARM_DESC(debug_mask, "debug mask: 1 = dump cmd data, 2 = dump cmd exec t
>  
>  static unsigned int prof_sel = MLX5_DEFAULT_PROF;
>  module_param_named(prof_sel, prof_sel, uint, 0444);
> -MODULE_PARM_DESC(prof_sel, "profile selector. Valid range 0 - 2");
> +MODULE_PARM_DESC(prof_sel, "profile selector. Valid range 0 - 4");

Sashiko writes:
"Is it appropriate to expand a module parameter to configure a feature that
already has a standard devlink API (devlink dev eswitch set ... mode
switchdev)? Automated provisioning is typically expected to be handled in
userspace rather than configured via driver module parameters."

This is intended as an intermediate step.

The end goal is that for certain environments (e.g. ECPF/DPU), only
switchdev mode is supported and it becomes the default without requiring
user configuration.

There is also the question of multi-NIC systems, where a user may want
only a subset of devices to default to switchdev. This patch does not
aim to solve that. The long-term direction is to tie the behavior to the
NIC type / platform rather than expose it as a generic user-facing knob.

Accordingly, this is not meant to be a general-purpose api. It is intended
for controlled environments (e.g. DPU deployments) where switchdev is
the only supported mode.

>  
>  static u32 sw_owner_id[4];
>  #define MAX_SW_VHCA_ID (BIT(__mlx5_bit_sz(cmd_hca_cap_2, sw_vhca_id)) - 1)
> @@ -185,6 +185,11 @@ static struct mlx5_profile profile[] = {
>  		.log_max_qp	= LOG_MAX_SUPPORTED_QPS,
>  		.num_cmd_caches = 0,
>  	},
> +	[4] = {
> +		.mask = MLX5_PROF_MASK_DEF_SWITCHDEV | MLX5_PROF_MASK_QP_SIZE,
> +		.log_max_qp = LOG_MAX_SUPPORTED_QPS,
> +		.num_cmd_caches = MLX5_NUM_COMMAND_CACHES,
> +	},
>  };
>  
>  static int wait_fw_init(struct mlx5_core_dev *dev, u32 max_wait_mili,
> @@ -1451,6 +1456,17 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>  	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>  }
>  
> +static void mlx5_set_default_switchdev(struct mlx5_core_dev *dev)
> +{
> +	int err;
> +
> +	err = mlx5_devlink_eswitch_mode_set(priv_to_devlink(dev),
> +					    DEVLINK_ESWITCH_MODE_SWITCHDEV,
> +					    NULL);

Sashiko writes:
"Does calling the internal driver eswitch mode function directly bypass the
devlink core? This appears to prevent the devlink subsystem from emitting
proper netlink state notifications to userspace when the mode transitions.
"

The intent here is to support platforms where switchdev must be the
default (notably DPU/ARM side). Today this transition is handled via
userspace scripts.

This change provides an intermediate step, allowing the device to come
up directly in switchdev mode without relying on userspace orchestration.
It still requires explicit opt-in via the profile.


> +	if (err && err != -EOPNOTSUPP)
> +		mlx5_core_warn(dev, "failed setting switchdev as default\n");
> +}
> +
>  int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>  {
>  	bool light_probe = mlx5_dev_is_lightweight(dev);
> @@ -1497,6 +1513,10 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>  		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>  
>  	mutex_unlock(&dev->intf_state_mutex);
> +
> +	if (dev->profile.mask & MLX5_PROF_MASK_DEF_SWITCHDEV)
> +		mlx5_set_default_switchdev(dev);
> +

Sashiko write:
"If a user boots with prof_sel=4 but later manually changes the eswitch mode
to legacy via standard devlink commands, will this call force the device
back into switchdev mode during a firmware recovery or device reload? This
seems to override user-driven runtime devlink configurations."

Given the intended use case, this is acceptable.

These devices are considered “switchdev by default”, so after a firmware
reset or device reload it is expected that they return to switchdev mode.
Preserving a prior user override to legacy mode is not a requirement for
this configuration.

Mark

>  	return 0;
>  
>  err_register:
> @@ -1598,6 +1618,10 @@ int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery)
>  		goto err_attach;
>  
>  	mutex_unlock(&dev->intf_state_mutex);
> +
> +	if (dev->profile.mask & MLX5_PROF_MASK_DEF_SWITCHDEV)
> +		mlx5_set_default_switchdev(dev);
> +
>  	return 0;
>  
>  err_attach:
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index 1268fcf35ec7..cfbc0ff6292a 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -706,6 +706,7 @@ struct mlx5_st;
>  enum {
>  	MLX5_PROF_MASK_QP_SIZE		= (u64)1 << 0,
>  	MLX5_PROF_MASK_MR_CACHE		= (u64)1 << 1,
> +	MLX5_PROF_MASK_DEF_SWITCHDEV    = (u64)1 << 2,
>  };
>  
>  enum {


