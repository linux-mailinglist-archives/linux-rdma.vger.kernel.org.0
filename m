Return-Path: <linux-rdma+bounces-17046-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNVZGmw/m2ldwwMAu9opvQ
	(envelope-from <linux-rdma+bounces-17046-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Feb 2026 18:39:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B916FF6A
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Feb 2026 18:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4703300D17E
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Feb 2026 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3531B35A939;
	Sun, 22 Feb 2026 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IszMyBGz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE879CD;
	Sun, 22 Feb 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771781992; cv=fail; b=P+rXH5i8BQ/IFWzLqFNQlvYFTnBaYvX6pY4LUe375ARnFYqcu8StQqM6ODp4xnhaALrCsYP1EPH5ZGJr2NDg8QH+Q2v1W+bF/ny/h7+pzd+Jd9nwvC2VJ1JeVATEG2ByFzLnJ8XWTa1I9e2iDYXIIUq5JyOKLoZNbWfKyf5vXNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771781992; c=relaxed/simple;
	bh=Xt1sjFuRn6x86/cySC0qULMmGTFlYOXYd6tSZUtAf8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H7PeRlXktXd35Rke3VJ6QEHIt/NI1ftqe8JY5IeJ6WFiuPml4gkOo0bdn9TBdiouc49MHcpMJOcJhz3oFN3fMGyfID1Ad/XxxeuALl49DYjRBwSP1OiyiGEFf3qEbJBaY4PjSghO49nTceK/5dtF+TRNAl9yIBPlRb7PXFFka8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IszMyBGz; arc=fail smtp.client-ip=40.107.208.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds4/mNTMfd7qLV1mysvz47AvKBWpHqoNBgIC/mbD5RJCLMtvznz/JoSvPJqQDQ08LRkvbHq0jC4jaI57H7SLwFazrIv7biSw6pJV4MH6rIHGfeXqWBJzPMW4DKuVkydRG9JCFADpcY6Ko5fG/vLjNWraAxx593Jq9kNWiJ8yi+O34Ti7siWResM30mV8XsXWqjtuHz+fccLyXtDoIMIJt9yOdii7ziF84M5Iahcx/UHTXp5T3BALyhJ67rDCs0p/PsL0lw7UD+2yAa9vgQmmEUyKbGhLOWn1Vt6Su8dB0GUrgEV9VAwa8GoJE3UCV7YCZOhYdhlrtLqf86yKDS33KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4McuDoJtQB8IGF8yn93bkYqCt8LB/rznh76quEUTc/s=;
 b=syawi2U08C+UkrBkHbGTDKE74yvDHKdoFfd1kjBKbtfkXDly9ll3kgGbxir5pLW1zO84JBRbTzLCtmCJqRA34dOOFg4hHKI8EtMFucs79nXTPKSnkd3VPw4jJrJ4ijG0HO9QA5/N0rhaWHMy/hZxIn66FvtDpIHcEGB2Zs8mgSFM4hIT7cxHBNk8hL0iIxa2VGSx4ZzX/9olvgHmc2tAf3kk4m5pCB6+QL5caagwHIhjRGXYO97wxpbWfYpXnafpiPlTWEWtnm4V7NjqhofogDfaXe3DaXMu/YKa53l5Efc3xVb8juTr8mRYitax1DH3oFUb86rTd7iyj8DETL945Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4McuDoJtQB8IGF8yn93bkYqCt8LB/rznh76quEUTc/s=;
 b=IszMyBGzgQSaLFDLIT5JZ8edBzFWZbRhcQZOfz1XwXZDGkfQELZtqyTC3eu9blpqfMwwxJE2CJHZ0KkGHAWt7icaxfSxiqQitzakKQ5/xAkS/WEbIObNSRvcjCqmVeEaSu0CHyQiCKonQdvsVZMj5hAfwMljKf0UffE5uUElW3E4tNpzX+6sc6lu5sAkPO9lix3MK4AxUY2W47ab/4vHnrQVjrYlZVQPJ7txhCy6Vzau9eeUKIDsHO/aXYJV/RUSBSS+LwyS1+hwk7W3u+sdNc9qg3fii570DtxSQccdsonlznxUtDUb1CaJCuZ6s/S+jatTokDmBDJm5bIw7zzhQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Sun, 22 Feb
 2026 17:39:44 +0000
Received: from BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81]) by BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81%3]) with mapi id 15.20.9632.017; Sun, 22 Feb 2026
 17:39:44 +0000
Message-ID: <72191e37-8f9d-43f8-bd56-493d30719494@nvidia.com>
Date: Sun, 22 Feb 2026 19:39:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v3 02/11] IB/core: Introduce FRMR pools
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260202-frmr_pools-v3-0-d4543e82744a@nvidia.com>
 <20260202-frmr_pools-v3-2-d4543e82744a@nvidia.com>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <20260202-frmr_pools-v3-2-d4543e82744a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To BL3PR12MB6473.namprd12.prod.outlook.com
 (2603:10b6:208:3b9::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6473:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a01880-1b58-4693-90cf-08de72395d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWhET3RtR0VobzEwd0c2T2Y4NWhiMXlOamg3SWNGcnE3ajZOY1JjTStscHNE?=
 =?utf-8?B?YkpPdElpdDVaM1Fyc1NtbDlOTFJ1VXc0MmpyMDhJRzN3azFiOUkxdkhTUSsz?=
 =?utf-8?B?WDFON05WT1Q2UUp2bzFwUXB2ZUMyaHRnSThkZHE0Zi85V0JaMDZCNlRJbytG?=
 =?utf-8?B?b1RFMG1MNHZlZHhMTWVvUUdWQ1VEUnhGS0ZuZG05SGFtMjRZSDdSUHQzcTZB?=
 =?utf-8?B?QXRWY1JZU3BmT3dYWGV3cnJJWE0yWWFOa2JHdUxabGxnVmF2MFNHaEdidjlJ?=
 =?utf-8?B?NFcvbEhwNWtPUUU1S2RKVEVnWW5BVVE3dVo1dkxIVVVNdTg3QXZNRUNlMFFx?=
 =?utf-8?B?NkJJL0dHNDV6Y2tQOTZINHJhZ3FYb0FYQm5iV1hmeXArYTIraVFGSXZmd3dF?=
 =?utf-8?B?RDc3MFE3eGhFN3B6VHRRUVRWb3pKRGNvTmtzZGorbEdDb1ZrR3BIdlhyRzNn?=
 =?utf-8?B?VFcrRlQ0Uk9LUFVuUGhEUWF1V3JKU2NFdFpoVUZrTTNsK1pMRHdPZTdlNk1z?=
 =?utf-8?B?M2QwY0M4NnBNOExOS096YzN3UmFGWWdwck0wUGg4Y2dmS3dmOGFNRG03eVh6?=
 =?utf-8?B?ZXRkRVhvSjhDRjFud05kWDBiV1l6RGRlY3k2VXlFY1A1L094VHhqM0lERCtV?=
 =?utf-8?B?MWFNMm1LdTJxYzh3SXYwQU5MYW94bTNNYjJWb2dsU0UxUmFYUlp6N2dCVzJE?=
 =?utf-8?B?VGIwT1NMbG9kMlIxZ0hwdlJMWU9JL1Rycm5vTzRXQnc0TUYycjlLbHB6V01D?=
 =?utf-8?B?bDNpWFR5UFdseUdrTkM5RXQ0dFk2MWQ2Q1Y3SjRGMDBkVjBiMWZJemZ4TlFz?=
 =?utf-8?B?VEV3NE9WWm9QS09hVU1jQ0E3TitOdTY2R3Jlb0hIZHBiSHZYOUl5SlJHbVpU?=
 =?utf-8?B?WFZCd21xZU5pODJjR1M4NmlOdmZsbkpSZ29GODFKSHROa28vNUVHUzlKV1o5?=
 =?utf-8?B?V05xV1YvSnU4VTdoYURpQUIvZWZVWGlBdUM5ZHV3Y0Ftd2t3RHZ4ZGRsY2pr?=
 =?utf-8?B?Q2pKajMzZVBhYnVHZ0MrRUJXamg4ZzExSGRVRnVTNXJJeTBsL0xjUDkyd0lN?=
 =?utf-8?B?U0dXZDd1UmxlTTJVcGQwQ05Ram9aL3RyS1RtMUFoOHR5cTZXbCtzM3o0THlr?=
 =?utf-8?B?bGVueUYzeU1KZmVOWE9vQTZ1dU96M2x3NGs0ZjdjVGRGRWZVeTU1blFhTmgx?=
 =?utf-8?B?KzZVcitoMFpUOWNmSnJEVGlYVUlTbEN6Zi8ycXRzWUExTW03NFQ3WFFLK3V5?=
 =?utf-8?B?R2x6NklPekN0S2kwWWY4WnlTTU1GL3hyb0VjcExReDFJZEVRc0RYc3J1MlVp?=
 =?utf-8?B?UmozcW5tYkJFU0VYVkVscjVaUGpBcjBYUDNodnMvc2hWWkE3OVR5d3J3RHFD?=
 =?utf-8?B?UDZkS2ZKZU0xd1AyNThKMmNYbjA1eWhZS2U2bW84cVRHSzdkYTltL3ZtcEVJ?=
 =?utf-8?B?ZlZKcXNxZGNVVUVlcFowYktrRVJkUTFCbHVSU01idFBwaFp2amxEZ1RQTys3?=
 =?utf-8?B?RnY5SjhlZm1iak1oYVpqQzF5TVZPSUFWM3JXOGxVRG1mcXhtZWNhTWxjenVY?=
 =?utf-8?B?eEhCNHhLSmdmNGgwUHRVd2lCVEwvWXpESzN0c0xsUDdiNmtIVzdkeStzSTg4?=
 =?utf-8?B?aXpjVTFTcFFQUVVNVHBWbkRaOG1qQU9lN3JsK3MxZDd6ZTRlRmhDT1FiNnQr?=
 =?utf-8?B?ZnlISU5lTExDZjdwTkx5OURlcFRnTXk3Q0VWOThqeis5ZGpOTzk2UUdoc25B?=
 =?utf-8?B?KzlKeUFBU3FVSVZjemVubjd3OEZTamx4dDlma3VQMjBkUTc1V1kzQzhkK3F6?=
 =?utf-8?B?RmNza0dIL3l5clhBUjM5Smo3RG95VHNRcWE1b0tnVXJrVkhxS1FVL3cvSnBm?=
 =?utf-8?B?bElLOEozRmZhL0pIeFo2NDNNUXplWnljUXJpNFJidUpIei9wbWhCVXFqbTh2?=
 =?utf-8?B?MXRmQk01SHQ2QXQyVWE1b21xTndUdkE1aW1Ha0J1VGExcTNqdlg3RndXQUJt?=
 =?utf-8?B?Ti8vNnNVNG9EUWRGeDc0cWRybENWa0tIZVp0UHcwZnB1eTJjWFNXcjloSTRR?=
 =?utf-8?B?STBKRGRUdDRDS3dsajlCdXNJc3IvQ1VFUysvaHY5Smo2eEIxSHJua2xYS09o?=
 =?utf-8?B?TjFPenY4Qk5RUU04eDZ3amhYTXRxNzhFenZ2d3dwaEhMRENGUWhXSTRUS0dj?=
 =?utf-8?B?aXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVA5OUgvZGdIMU9mck5NVjlsRTZZME1MaUhkcFE3MmpFbk1TL3VoUktuMTZW?=
 =?utf-8?B?QmQ2ekNlWk9XWWYzNW5YTUY1azI3aDAvanF5b1NMRU1DYXBrZ0lyYzNiMmhO?=
 =?utf-8?B?aWlIaS8vcis2Q0NyRTFIb0plVHBHSndxZEpLNTFRS1FQaGN3YVF0di9LOThZ?=
 =?utf-8?B?VU1MQ0RTbGhHM0xRdnRGTGU3VzN4Tk1YUHp0dVR2NjZIMWFCakdmc25wQzdz?=
 =?utf-8?B?eHkrUXdZWk9BRGZtNDZWWVlTa1crcXJUcElGNFdGdHB4U2txMnBtSFF3dzBR?=
 =?utf-8?B?L3lDbDk5UDBMdUlWKys4bDV1eTN5eThqdHpOazUrQVo2eWljc1hDdlZycytS?=
 =?utf-8?B?ODF2dDkxb1QrQXVQcTQ3b2VKZkpsY2VZYm9MSXViWHhKNHdkU0N1aVl1ZWlS?=
 =?utf-8?B?R212aDVwODExTGRoVm1qdDRwYlhtMFpHalFxMHRtbmkvN0lTR1dpRDlNMGhI?=
 =?utf-8?B?WnY1NFAvcmNXOXF4bkxjTUxmUEZ0M1RBNWJlY1g0M1ZBZ00yODJ5d09pMG1N?=
 =?utf-8?B?UlVDNHlJZ1RzclJubEdwREllS0U0bkZkQUhTTXh1MFpFVDVPa0FFMkxNcFhH?=
 =?utf-8?B?V3ExOVBHb0F0NTdBV3p4aXJHVXlHRTFuZm1QOVZQNWYxeFVLdE5LVzVYbHJh?=
 =?utf-8?B?cnhHbENpWTdxckkwUURGVm1BY01YTHl6eU1ULzMvbmxuUnZSOXJxK0sycDlV?=
 =?utf-8?B?bVR5WGUyWUhQWXhIWC83WUp4ODkydTJndUg0Q0hiWjVTRjNhcFBpRTBoNHlu?=
 =?utf-8?B?QzRHaDVadzRFdzlSNTAyb2lzUUNPNVhNNjZRYzQ3OFJwWHBDM0hBbDdLZ1Jp?=
 =?utf-8?B?T0FlQVR3NkYyejFHMmpYWHR5ditlZzQvdjdzWTNYR3JqZCtpVmtqUnFsYWZE?=
 =?utf-8?B?QkZSUnFoMVhRNFJtbUE1aFBLZDJSdDhQRVFFeURJd09Pejl2bFdBOWlwYVF6?=
 =?utf-8?B?cUphdDBZaXNRVGJha1ozNlNZMS9vdHljSjV5WHRHbmxqcndiMHc4WWtYTXhi?=
 =?utf-8?B?KzBNTFlLaFhRK0RjMmZWNDlLOHlIemNSd1Bpc01lMUpCM3FFSWdWL3lWRXdL?=
 =?utf-8?B?dTJOZ014UkkyUUUyWHZ0TkNuT2hnN0tsTnNkaWtub1lOa0R6V3dUOGpxZ3Ft?=
 =?utf-8?B?dWJVNkNmQ2lmdE45d2FoOFNpNWN0aHpNNmZjTjJMaGFBc0pLRDV1ckt0QkUz?=
 =?utf-8?B?ZnhwYkpOM0VZZlN0aHQxRUtCMzdmYjJ5c29mMFZaODJaT3hrT2R5dllmdTZa?=
 =?utf-8?B?bkFncGNKQjV6WCs0bUhjSFc0TXhscThoZTVXT0Jtc0N1Y2gvTGZFMFRvOVBR?=
 =?utf-8?B?TU9qUlRhcHYxbzBTUjVBUE0vbmplTm1XbG4rWXpUZytpVENNbWFmWUFldlFh?=
 =?utf-8?B?OWlqRzgyUzJxUDdXbzFSajFPbXN4YU1idFhoeWQ1cnhNTk5kOGFKeXlYTkxD?=
 =?utf-8?B?MExOdnlqTHlJQTl2OS84MHdWWFJRbUFzeUFDdytLa0VjSFhZNFFBRVZKVW5Z?=
 =?utf-8?B?d2duWmNyRkZreFQxcGljMy9FTm9DWTQxMkI4NkhHY1pDRjJ3cEhhUUJFdUdM?=
 =?utf-8?B?a0xKeXJjVUNhaDl5d1VwOEt6am5yZ04vQlk1b0RDM084MU5za2RibStuZFNQ?=
 =?utf-8?B?Z1JVM3dQak9HWGt1N3FFU1JvUTdBa2RIT3M0SnRuMG55YktEdisvaEM3ODY5?=
 =?utf-8?B?NldNSzZMOWlKYlRORTJ1aHVkRzhWSVA2dWh2aTUwSjkwQnNUd1kyTkNjcDBr?=
 =?utf-8?B?eGVDbFZReWFsVUdENzJGSExza3FXYTVlNU9yRmlybUJGZ3BjaXJEYmozZnVh?=
 =?utf-8?B?eXJBWnlrRkVJL040dEhza09YQ0thM2NrVVVOMWxjT0gyRXdSQitXK0dZWlZr?=
 =?utf-8?B?MW9UUU10OUIrdVRBTXh5NTZLYVpoOGlDNk9HNncrbzR6UVA2bGRHbHovMkZV?=
 =?utf-8?B?dUxMTDEzRVltdk9NRE9QdkxVelNDemUwcFo1bE9FOVNnbCtNR0hUYlJhOWxQ?=
 =?utf-8?B?RkVhQVlaeElpaStENHAxTWdnRHhleXJUQjVpNnFpaG1MS09vWEdtNVl4MTdT?=
 =?utf-8?B?aVh1aDNmQzlWOGJEcUtmSE5yd21PTHBxdlJFVHBtYzBLZEFMNnl2Y2VHZ1Rr?=
 =?utf-8?B?UGlVYWlabm10ckpGVWJOZnNoMVNmdmV6Smdld0NRbm1lVC9XSVN6QnRIL2tJ?=
 =?utf-8?B?cnh5NmNXbHFOU0dKY2lsK2hTVmV6SmZoZ2E2UW9QRk1LZDd5TzBzQVovVW9H?=
 =?utf-8?B?cHlhUEFEN21BTTBLbmdyVm0vbGtnamF5WG40MjVlUGRQSEUxa1VDMDZHOVB2?=
 =?utf-8?B?c093dkE1Umw0alFBbm1rSjcwM3dtQXdvUUxrVStRTVdQY0k4K0F4UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a01880-1b58-4693-90cf-08de72395d5b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 17:39:43.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvPnaTRgGUPRTYOOYSsKuhOO6RagzGHCP6CYJrHHcOpaLTGY7mAswYeOCPJamOUv4FUHH2OWbvyulX03Qwg1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-17046-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: C03B916FF6A
X-Rspamd-Action: no action


On 2/2/2026 5:31 PM, Edward Srouji wrote:
> From: Michael Guralnik <michaelgur@nvidia.com>
>
> Add a generic Fast Registration Memory Region pools mechanism to allow
> drivers to optimize memory registration performance.
> Drivers that have the ability to reuse MRs or their underlying HW
> objects can take advantage of the mechanism to keep a 'handle' for those
> objects and use them upon user request.
> We assume that to achieve this goal a driver and its HW should implement
> a modify operation for the MRs that is able to at least clear and set the
> MRs and in more advanced implementations also support changing a subset
> of the MRs properties.
>
> The mechanism is built using an RB-tree consisting of pools, each pool
> represents a set of MR properties that are shared by all of the MRs
> residing in the pool and are unmodifiable by the vendor driver or HW.
>
> The exposed API from ib_core to the driver has 4 operations:
> Init and cleanup - handles data structs and locks for the pools.
> Push and pop - store and retrieve 'handle' for a memory registration
> or deregistrations request.
>
> The FRMR pools mechanism implements the logic to search the RB-tree for
> a pool with matching properties and create a new one when needed and
> requires the driver to implement creation and destruction of a 'handle'
> when pool is empty or a handle is requested or is being destroyed.
>
> Later patch will introduce Netlink API to interact with the FRMR pools
> mechanism to allow users to both configure and track its usage.
> A vendor wishing to configure FRMR pool without exposing it or without
> exposing internal MR properties to users, should use the
> kernel_vendor_key field in the pools key. This can be useful in a few
> cases, e.g, when the FRMR handle has a vendor-specific un-modifiable
> property that the user registering the memory might not be aware of.
>
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> ---
>   drivers/infiniband/core/Makefile     |   2 +-
>   drivers/infiniband/core/frmr_pools.c | 323 +++++++++++++++++++++++++++++++++++
>   drivers/infiniband/core/frmr_pools.h |  48 ++++++
>   include/rdma/frmr_pools.h            |  37 ++++
>   include/rdma/ib_verbs.h              |   8 +
>   5 files changed, 417 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
> index f483e0c12444..7089a982b876 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
>   				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
>   				multicast.o mad.o smi.o agent.o mad_rmpp.o \
>   				nldev.o restrack.o counters.o ib_core_uverbs.o \
> -				trace.o lag.o
> +				trace.o lag.o frmr_pools.o
>   
>   ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
>   ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
> diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
> new file mode 100644
> index 000000000000..eae15894a3b2
> --- /dev/null
> +++ b/drivers/infiniband/core/frmr_pools.c
> @@ -0,0 +1,323 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/rbtree.h>
> +#include <linux/sort.h>
> +#include <linux/spinlock.h>
> +#include <rdma/ib_verbs.h>
> +
> +#include "frmr_pools.h"
> +
> +static int push_handle_to_queue_locked(struct frmr_queue *queue, u32 handle)
> +{
> +	u32 tmp = queue->ci % NUM_HANDLES_PER_PAGE;
> +	struct frmr_handles_page *page;
> +
> +	if (queue->ci >= queue->num_pages * NUM_HANDLES_PER_PAGE) {
> +		page = kzalloc(sizeof(*page), GFP_ATOMIC);
> +		if (!page)
> +			return -ENOMEM;
> +		queue->num_pages++;
> +		list_add_tail(&page->list, &queue->pages_list);
> +	} else {
> +		page = list_last_entry(&queue->pages_list,
> +				       struct frmr_handles_page, list);
> +	}
> +
> +	page->handles[tmp] = handle;
> +	queue->ci++;
> +	return 0;
> +}
> +
> +static u32 pop_handle_from_queue_locked(struct frmr_queue *queue)
> +{
> +	u32 tmp = (queue->ci - 1) % NUM_HANDLES_PER_PAGE;
> +	struct frmr_handles_page *page;
> +	u32 handle;
> +
> +	page = list_last_entry(&queue->pages_list, struct frmr_handles_page,
> +			       list);
> +	handle = page->handles[tmp];
> +	queue->ci--;
> +
> +	if (!tmp) {
> +		list_del(&page->list);
> +		queue->num_pages--;
> +		kfree(page);
> +	}
> +
> +	return handle;
> +}
> +
> +static bool pop_frmr_handles_page(struct ib_frmr_pool *pool,
> +				  struct frmr_queue *queue,
> +				  struct frmr_handles_page **page, u32 *count)
> +{
> +	spin_lock(&pool->lock);
> +	if (list_empty(&queue->pages_list)) {
> +		spin_unlock(&pool->lock);
> +		return false;
> +	}
> +
> +	*page = list_first_entry(&queue->pages_list, struct frmr_handles_page,
> +				 list);
> +	list_del(&(*page)->list);
> +	queue->num_pages--;
> +
> +	/* If this is the last page, count may be less than
> +	 * NUM_HANDLES_PER_PAGE.
> +	 */
> +	if (queue->ci >= NUM_HANDLES_PER_PAGE)
> +		*count = NUM_HANDLES_PER_PAGE;
> +	else
> +		*count = queue->ci;
> +
> +	queue->ci -= *count;
> +	spin_unlock(&pool->lock);
> +	return true;
> +}
> +
> +static void destroy_frmr_pool(struct ib_device *device,
> +			      struct ib_frmr_pool *pool)
> +{
> +	struct ib_frmr_pools *pools = device->frmr_pools;
> +	struct frmr_handles_page *page;
> +	u32 count;
> +
> +	while (pop_frmr_handles_page(pool, &pool->queue, &page, &count)) {
> +		pools->pool_ops->destroy_frmrs(device, page->handles, count);
> +		kfree(page);
> +	}
> +
> +	rb_erase(&pool->node, &pools->rb_root);
> +	kfree(pool);
> +}
> +
> +/*
> + * Initialize the FRMR pools for a device.
> + *
> + * @device: The device to initialize the FRMR pools for.
> + * @pool_ops: The pool operations to use.
> + *
> + * Returns 0 on success, negative error code on failure.
> + */
> +int ib_frmr_pools_init(struct ib_device *device,
> +		       const struct ib_frmr_pool_ops *pool_ops)
> +{
> +	struct ib_frmr_pools *pools;
> +
> +	pools = kzalloc(sizeof(*pools), GFP_KERNEL);
> +	if (!pools)
> +		return -ENOMEM;
> +
> +	pools->rb_root = RB_ROOT;
> +	rwlock_init(&pools->rb_lock);
> +	pools->pool_ops = pool_ops;
> +
> +	device->frmr_pools = pools;
> +	return 0;
> +}
> +EXPORT_SYMBOL(ib_frmr_pools_init);
> +
> +/*
> + * Clean up the FRMR pools for a device.
> + *
> + * @device: The device to clean up the FRMR pools for.
> + *
> + * Call cleanup only after all FRMR handles have been pushed back to the pool
> + * and no other FRMR operations are allowed to run in parallel.
> + * Ensuring this allows us to save synchronization overhead in pop and push
> + * operations.
> + */
> +void ib_frmr_pools_cleanup(struct ib_device *device)
> +{
> +	struct ib_frmr_pools *pools = device->frmr_pools;
> +	struct rb_node *node = rb_first(&pools->rb_root);
> +	struct ib_frmr_pool *pool;
> +
> +	while (node) {
> +		struct rb_node *next = rb_next(node);
> +
> +		pool = rb_entry(node, struct ib_frmr_pool, node);
> +		destroy_frmr_pool(device, pool);
> +		node = next;
> +	}
> +
> +	kfree(pools);
> +	device->frmr_pools = NULL;
> +}
> +EXPORT_SYMBOL(ib_frmr_pools_cleanup);
> +
> +static inline int compare_keys(struct ib_frmr_key *key1,
> +			       struct ib_frmr_key *key2)
> +{
> +	int res;
> +
> +	res = cmp_int(key1->ats, key2->ats);
> +	if (res)
> +		return res;
> +
> +	res = cmp_int(key1->access_flags, key2->access_flags);
> +	if (res)
> +		return res;
> +
> +	res = cmp_int(key1->vendor_key, key2->vendor_key);
> +	if (res)
> +		return res;
> +
> +	res = cmp_int(key1->kernel_vendor_key, key2->kernel_vendor_key);
> +	if (res)
> +		return res;
> +
> +	/*
> +	 * allow using handles that support more DMA blocks, up to twice the
> +	 * requested number
> +	 */
> +	res = cmp_int(key1->num_dma_blocks, key2->num_dma_blocks);
> +	if (res > 0) {
> +		if (key1->num_dma_blocks - key2->num_dma_blocks <
> +		    key2->num_dma_blocks)
> +			return 0;
> +	}
> +
> +	return res;
> +}
> +
> +static int frmr_pool_cmp_find(const void *key, const struct rb_node *node)
> +{
> +	struct ib_frmr_pool *pool = rb_entry(node, struct ib_frmr_pool, node);
> +
> +	return compare_keys(&pool->key, (struct ib_frmr_key *)key);
> +}
> +
> +static int frmr_pool_cmp_add(struct rb_node *new, const struct rb_node *node)
> +{
> +	struct ib_frmr_pool *new_pool =
> +		rb_entry(new, struct ib_frmr_pool, node);
> +	struct ib_frmr_pool *pool = rb_entry(node, struct ib_frmr_pool, node);
> +
> +	return compare_keys(&pool->key, &new_pool->key);
> +}
> +
> +static struct ib_frmr_pool *ib_frmr_pool_find(struct ib_frmr_pools *pools,
> +					      struct ib_frmr_key *key)
> +{
> +	struct ib_frmr_pool *pool;
> +	struct rb_node *node;
> +
> +	/* find operation is done under read lock for performance reasons.
> +	 * The case of threads failing to find the same pool and creating it
> +	 * is handled by the create_frmr_pool function.
> +	 */
> +	read_lock(&pools->rb_lock);
> +	node = rb_find(key, &pools->rb_root, frmr_pool_cmp_find);
> +	pool = rb_entry_safe(node, struct ib_frmr_pool, node);
> +	read_unlock(&pools->rb_lock);
> +
> +	return pool;
> +}
> +
> +static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
> +					     struct ib_frmr_key *key)
> +{
> +	struct ib_frmr_pools *pools = device->frmr_pools;
> +	struct ib_frmr_pool *pool;
> +	struct rb_node *existing;
> +
> +	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> +	if (!pool)
> +		return ERR_PTR(-ENOMEM);
> +
> +	memcpy(&pool->key, key, sizeof(*key));
> +	INIT_LIST_HEAD(&pool->queue.pages_list);
> +	spin_lock_init(&pool->lock);
> +
> +	write_lock(&pools->rb_lock);
> +	existing = rb_find_add(&pool->node, &pools->rb_root, frmr_pool_cmp_add);
> +	write_unlock(&pools->rb_lock);
> +
> +	/* If a different thread has already created the pool, return it.
> +	 * The insert operation is done under the write lock so we are sure
> +	 * that the pool is not inserted twice.
> +	 */
> +	if (existing) {
> +		kfree(pool);
> +		return rb_entry(existing, struct ib_frmr_pool, node);
> +	}
> +
> +	return pool;
> +}
> +
> +static int get_frmr_from_pool(struct ib_device *device,
> +			      struct ib_frmr_pool *pool, struct ib_mr *mr)
> +{
> +	struct ib_frmr_pools *pools = device->frmr_pools;
> +	u32 handle;
> +	int err;
> +
> +	spin_lock(&pool->lock);
> +	if (pool->queue.ci == 0) {
> +		spin_unlock(&pool->lock);
> +		err = pools->pool_ops->create_frmrs(device, &pool->key, &handle,
> +						    1);
> +		if (err)
> +			return err;
> +	} else {
> +		handle = pop_handle_from_queue_locked(&pool->queue);
> +		spin_unlock(&pool->lock);
> +	}
> +
> +	mr->frmr.pool = pool;
> +	mr->frmr.handle = handle;
> +
> +	return 0;
> +}
> +
> +/*
> + * Pop an FRMR handle from the pool.
> + *
> + * @device: The device to pop the FRMR handle from.
> + * @mr: The MR to pop the FRMR handle from.
> + *
> + * Returns 0 on success, negative error code on failure.
> + */
> +int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr)
> +{
> +	struct ib_frmr_pools *pools = device->frmr_pools;
> +	struct ib_frmr_pool *pool;
> +
> +	WARN_ON_ONCE(!device->frmr_pools);
> +	pool = ib_frmr_pool_find(pools, &mr->frmr.key);
> +	if (!pool) {
> +		pool = create_frmr_pool(device, &mr->frmr.key);
> +		if (IS_ERR(pool))
> +			return PTR_ERR(pool);
> +	}
> +
> +	return get_frmr_from_pool(device, pool, mr);
> +}
> +EXPORT_SYMBOL(ib_frmr_pool_pop);
> +
> +/*
> + * Push an FRMR handle back to the pool.
> + *
> + * @device: The device to push the FRMR handle to.
> + * @mr: The MR containing the FRMR handle to push back to the pool.
> + *
> + * Returns 0 on success, negative error code on failure.
> + */
> +int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
> +{
> +	struct ib_frmr_pool *pool = mr->frmr.pool;
> +	int ret;
> +
> +	spin_lock(&pool->lock);
> +	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
> +	spin_unlock(&pool->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(ib_frmr_pool_push);
> diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
> new file mode 100644
> index 000000000000..5a4d03b3d86f
> --- /dev/null
> +++ b/drivers/infiniband/core/frmr_pools.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + */
> +
> +#ifndef RDMA_CORE_FRMR_POOLS_H
> +#define RDMA_CORE_FRMR_POOLS_H
> +
> +#include <rdma/frmr_pools.h>
> +#include <linux/rbtree_types.h>
> +#include <linux/spinlock_types.h>
> +#include <linux/types.h>
> +#include <asm/page.h>
> +
> +#define NUM_HANDLES_PER_PAGE \
> +	((PAGE_SIZE - sizeof(struct list_head)) / sizeof(u32))
> +
> +struct frmr_handles_page {
> +	struct list_head list;
> +	u32 handles[NUM_HANDLES_PER_PAGE];
> +};
> +
> +/* FRMR queue holds a list of frmr_handles_page.
> + * num_pages: number of pages in the queue.
> + * ci: current index in the handles array across all pages.
> + */
> +struct frmr_queue {
> +	struct list_head pages_list;
> +	u32 num_pages;
> +	unsigned long ci;
> +};
> +
> +struct ib_frmr_pool {
> +	struct rb_node node;
> +	struct ib_frmr_key key; /* Pool key */
> +
> +	/* Protect access to the queue */
> +	spinlock_t lock;
> +	struct frmr_queue queue;
> +};
> +
> +struct ib_frmr_pools {
> +	struct rb_root rb_root;
> +	rwlock_t rb_lock;
> +	const struct ib_frmr_pool_ops *pool_ops;
> +};
> +
> +#endif /* RDMA_CORE_FRMR_POOLS_H */
> diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
> new file mode 100644
> index 000000000000..da92ef4d7310
> --- /dev/null
> +++ b/include/rdma/frmr_pools.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + */
> +
> +#ifndef FRMR_POOLS_H
> +#define FRMR_POOLS_H
> +
> +#include <linux/types.h>
> +#include <asm/page.h>
> +
> +struct ib_device;
> +struct ib_mr;
> +
> +struct ib_frmr_key {
> +	u64 vendor_key;
> +	/* A pool with non-zero kernel_vendor_key is a kernel-only pool. */
> +	u64 kernel_vendor_key;
> +	size_t num_dma_blocks;
> +	int access_flags;
> +	u8 ats:1;
> +};
> +
> +struct ib_frmr_pool_ops {
> +	int (*create_frmrs)(struct ib_device *device, struct ib_frmr_key *key,
> +			    u32 *handles, u32 count);
> +	void (*destroy_frmrs)(struct ib_device *device, u32 *handles,
> +			      u32 count);
> +};
> +
> +int ib_frmr_pools_init(struct ib_device *device,
> +		       const struct ib_frmr_pool_ops *pool_ops);
> +void ib_frmr_pools_cleanup(struct ib_device *device);
> +int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr);
> +int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr);
> +
> +#endif /* FRMR_POOLS_H */
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 0a85af610b6b..6cc557424e23 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -43,6 +43,7 @@
>   #include <uapi/rdma/rdma_user_ioctl.h>
>   #include <uapi/rdma/ib_user_ioctl_verbs.h>
>   #include <linux/pci-tph.h>
> +#include <rdma/frmr_pools.h>
>   
>   #define IB_FW_VERSION_NAME_MAX	ETHTOOL_FWVERS_LEN
>   
> @@ -1886,6 +1887,11 @@ struct ib_mr {
>   	struct ib_dm      *dm;
>   	struct ib_sig_attrs *sig_attrs; /* only for IB_MR_TYPE_INTEGRITY MRs */
>   	struct ib_dmah *dmah;
> +	struct {
> +		struct ib_frmr_pool *pool;
> +		struct ib_frmr_key key;
> +		u32 handle;
> +	} frmr;
>   	/*
>   	 * Implementation details of the RDMA core, don't use in drivers:
>   	 */
> @@ -2879,6 +2885,8 @@ struct ib_device {
>   	struct list_head subdev_list;
>   
>   	enum rdma_nl_name_assign_type name_assign_type;
> +
> +	struct ib_frmr_pools *frmr_pools;
>   };
>   
>   static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,

A potential NULL pointer dereference was identified in 
ib_frmr_pools_cleanup() when device->frmr_pools is not initialized. 
Instead of sending a full v4 of this long series (no review comments 
have been received on v3 so far), posting the diff change here. The 
change simplifies the error unwinding and allows calls to FRMR pools 
cleanup without prior pools initialization. diff --git 
a/drivers/infiniband/core/frmr_pools.c 
b/drivers/infiniband/core/frmr_pools.c index eae15894a3b2..8cecafabda3c 
100644 --- a/drivers/infiniband/core/frmr_pools.c +++ 
b/drivers/infiniband/core/frmr_pools.c @@ -92,7 +92,6 @@ static void 
destroy_frmr_pool(struct ib_device *device,                 kfree(page); 
         } -       rb_erase(&pool->node, &pools->rb_root);         
kfree(pool);  } @@ -135,16 +134,13 @@ EXPORT_SYMBOL(ib_frmr_pools_init); 
  void ib_frmr_pools_cleanup(struct ib_device *device)  {         struct 
ib_frmr_pools *pools = device->frmr_pools; -       struct rb_node *node 
= rb_first(&pools->rb_root); -       struct ib_frmr_pool *pool; +      
  struct ib_frmr_pool *pool, *next; -       while (node) { -            
    struct rb_node *next = rb_next(node); +       if (!pools) +          
      return; -               pool = rb_entry(node, struct ib_frmr_pool, 
node); +       rbtree_postorder_for_each_entry_safe(pool, next, 
&pools->rb_root, node)                 destroy_frmr_pool(device, pool); 
-               node = next; -       }         kfree(pools);         
device->frmr_pools = NULL;


