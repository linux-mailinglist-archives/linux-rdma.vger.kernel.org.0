Return-Path: <linux-rdma+bounces-22970-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ff8KMU/iT2rfpgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22970-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 20:02:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6835734193
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 20:02:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=B893sAqg;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22970-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22970-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E6E8302C1B8
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075BD43D4FE;
	Thu,  9 Jul 2026 18:02:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED2399887;
	Thu,  9 Jul 2026 18:02:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620165; cv=fail; b=IzkWax1I8Vv2jLYWpQ39PoZIiwPMO7vb0dwu+pKo3M0sw/dsLJWfhNcqzacigdYGBt3yQH4l6FYP5/YoIuRSQFPckM50+vzJ4ek/t2dOCFPOq06iYNF3aGzOrNJXeQVWJnuM25xQXryk0fd18lWzGVx2OXAA6O6pg7Lq1Yk/FDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620165; c=relaxed/simple;
	bh=ABkDIt9wVRD8vNVFpVdCvuJpwoXTUIfShMeRs8LkIVA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p/hfJ+3RYhn8UirEbHav45Cf9iXvhQx2Bcwl+adJd0CoZJuucMETUfxTXc6rr7t4k3pKRFbbAWQVy3glgkj0+Z7qibsFLl5hn2v7J3N0wb22Q2ssyI57bxy+mCMWaA6bUQKzNcKi7GxpbW+k/6pX2+AUZ8LZtsk5Wg+I1GKJT/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B893sAqg; arc=fail smtp.client-ip=52.101.57.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOo6P0H0UyjXQsKCOkhCRE4JrwadrFGO4zD0NSjNGdUR7MLbbtR+LPTaYhi29cTVW7DEpMdzTUbRWQCg+Tb6c6PdkLKYZNDy1lrxdt7RRe6j/4jUZT28eO9WTR4CuJb2NLEVxEvSrJRFQoTsn+5+CVRX+2ee3qBajqOs3A+Ub8xLgolk4CwkXtMr5swTTXMxDUNOUoP8+KE/aRkbwFutvl8wRYKjbzzwkr96nsv7EOSntK/OrMWFdDzOCdzCikJ7KtJcE0y03HiWbaFsTvYoqHmka1486gogx2+m7S/q6LUXEdPLnCKcCDhm3JPXOVeR5NOIS6FNi3nqd4QPejbhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGDjMaNxPXMlXD4eL+1CWOs3oTvaPmNdRWPoFZmRHTI=;
 b=uKXrIi+X9S4OpEF7OLIp/swFW9Eos0QaGZxT14LY3chTSgT1DMNAO1LZXFzMavsXIAC94Ap9KaaqRHwwNxIWj+QF4FyNQehZwEQF61Ah5raq+J8ANH8hhzOwhEMdnD2PBwVBAuUyu93O6ayfgv5Xlt2dvM8Gl1cSoTmS/h/+PnXmqHxQEp+5LALd2vqZ70hvonqMvnwfR0MlfJxnIoNVjo2rEO5hsY0x/22gSF6uFAjXT2WF4jMl1tyeOeYGSkzs36WrIKZHh6ApsOe0M4ibZ0Mt4yGcFIuejAjxhdbx+r5MqlTo8yzxXB7oUbxSK+liuP3LGjuzQ+lLo1QGEci4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGDjMaNxPXMlXD4eL+1CWOs3oTvaPmNdRWPoFZmRHTI=;
 b=B893sAqgLWazxSrpv7XyEXE6TG1jRvC4TcLG1prboJPOF1YIHTCEdhXPRu0dBnTPs8krxNFIS9PGUZbqiIuBki686HXzkC/Gus+2/d2Ta10Vc6PqXHZAlDUHsqHQd3ssL8O/dPKThHvV+Wtp/1Y/+9uXuwoTarkMIhlM4rxvXA1YTUoMlpdEnl1tPqqbXzmtGmfRVhLitEF49ODEQF+BmixFtlx3haZ7APAxE0yxJ4xT5OXpGaF0gO/F4EGUDRBlXivfOVVB06J8LdnfsMiXur5y3dXQsZxOKTcPec9lcyTs43diYGQSt6KRU25WDh27QNoWzpSnyXsVG6Bz0yUI7Q==
Received: from BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 18:02:39 +0000
Received: from BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81]) by BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81%3]) with mapi id 15.21.0181.010; Thu, 9 Jul 2026
 18:02:39 +0000
Message-ID: <c3c87760-43cc-443b-9dc6-09bf18ddea96@nvidia.com>
Date: Thu, 9 Jul 2026 21:02:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 1/8] RDMA/core: Add
 rdma_restrack_begin/abort/commit_del() operations
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Gal Pressman <galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>,
 Mark Bloch <markb@mellanox.com>, Neta Ostrovsky <netao@nvidia.com>,
 Mark Zhang <markzhang@nvidia.com>, Mark Zhang <markz@mellanox.com>,
 Majd Dibbiny <majd@mellanox.com>, Yishai Hadas <yishaih@nvidia.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Patrisious Haddad <phaddad@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>
References: <20260701-restrack-uaf-fix-resub-v1-0-c660cda4df2a@nvidia.com>
 <20260701-restrack-uaf-fix-resub-v1-1-c660cda4df2a@nvidia.com>
 <20260702174651.GT7525@ziepe.ca>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <20260702174651.GT7525@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0304.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::9) To BL3PR12MB6473.namprd12.prod.outlook.com
 (2603:10b6:208:3b9::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6473:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd8ea83-15c1-45a2-665d-08dedde4436f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	X4EcgaMKgOZRtoLnRQLIgyO811h9fM1xYDB9Rm9QeQSGcaKE4Mdru/yUGM2KysNcYK8IL8va3kW4I6AhqRcBS2UMvUB8WSdiI7wXcgybQO8xSKPJc/yrYBe9X4YJqXYyrk5sqnxIZ6/cSy1Pg9ukzMwMNpg1dPfS8dkHgTuXsyPl4b68nEpAUE5Wd9Jy9Ei4MuOsDxHdl/Ni/hr7KIsk/pf2CBkAlMATJrQ3oOM3MUyc61brg+ME1MjZEObnIzJ7AeDYuPl0mmecIcZycbT+bldIwDIokEjs5vSIiunq6cuvOOEzVOxiRL5eaFIp9umXNYgekEdb/rPiRqnB/XexqJ2phOoKgC6l3FQ918ivHTDbpLrci4TXeKbu8Ny22hqCpP8iwIG9JkEOgU7WVyZR8FMwj2XgmWstJljREJDjKd5nSQyPOwkN0W3L5oCNHPW0Mb4X0vanENeGlQdQT+4g+KSRCt9+tMOK/aoDxJA7nc84C8kevfHsmSJA7+4rSfPhWiLdEvixb4cDiWShqijAapDqI645zTt4UwIl7OdITh9siXzoxLSicted6QJjXtnRBI4i4/+jf8ptNCiXF1ZzhPT/RsEas5GchhfLtRhcaWXvb7D6GXJh6viouq6ivvbHk5B2sN07hnMwc+mYLhMWPwnkJH5aV94rJk78mZwJQV0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHhaVWxpSWtLcHJGc0hKSW5mbUtYOTlQWDlJaWNCY2d3M1lUeFZ5WHVBMGly?=
 =?utf-8?B?WVYvWG5NTmxCWVY1cGlGSmxRTnp1bXZNZVJUcEIxUkVuYmlQYldib3BTT3VE?=
 =?utf-8?B?RDhWYlZ3TW1DU2QrOHB5elZGU2djU0VrQXZGTjk2dHo2Wm04YWxmV3ZTOTNU?=
 =?utf-8?B?TFFib3hrTnIzOUxNTUIvK3FLdmUvV3hPSHBkbFk3S2J5b1BkMFozQjBuWW9Y?=
 =?utf-8?B?UWpmcmpVNWNOdkh1Vkp4cytqeEdRN1BYWEt4K25LQ2c0d2JLanpFM1hCZS9H?=
 =?utf-8?B?MTQ5MUFFZ0cxQXkwV2RJN0NpN1NVMjNrd2RORm5nT244endHR2E1ajhqSzJD?=
 =?utf-8?B?bmVYN0dKN0haaVBOSzlqSWlDOGVFMzkrNCtMb2xGampsNnpMRUFQOCtYeVFo?=
 =?utf-8?B?OG5mSXJWdFFOLzlmU2g2M3N5UzJPTGZuTUVBQjhpcDExaElsdXpsSW8vOUpR?=
 =?utf-8?B?eVN3SkVYR1AyTkhGK2RhdENNUkNTKzRsUkxNS24wckdHNjFJdUxZVkw5dGd2?=
 =?utf-8?B?N3A2bjFqM1lzZk8zWklmV0pWYUFXcVNlYW1oUTVTTzhZWTJtVjFzZnVYbDdF?=
 =?utf-8?B?bDBRcUJTYm1RdWJ6M3BTME5JOUQrT3RPSmFGZzRBUXlmTE03VlFvWnpybGZL?=
 =?utf-8?B?S1dwdkFkZjFGRFR1dEk3bHhpcTFBVlVQd1QybXpkME9Zc3dITGx3UVJXT2wy?=
 =?utf-8?B?QktWajRoWjRNTkdHZVE0c3QvbVpJRTZMNG5qOGMxUVpVV05ScERQcUk1dDJ1?=
 =?utf-8?B?TEI1ckk3Z2U3Y1JQV3VtVDBTbmViOWt2RmVxcmc0WXBHcDNIRnQ2RkN2QzFv?=
 =?utf-8?B?K2F4S2JhNG1lcVI2bFc2UVdqTUYxWjYrQ3YzcTdLZU9QUXVZekVMUUJmVWxZ?=
 =?utf-8?B?RGs1Z21uVm1ZaUdGSmVHTnJqdVd5OTZBaU1CM0pQZzdFZ3JCQm9yRnJNZTVE?=
 =?utf-8?B?QURRdnhObkdPTnk2SDJ2WEF1SjhCOHplaEUvckptb2JkQy96Mmh0bm9sazd3?=
 =?utf-8?B?SmRsZmlhNW1lVzJuS25TeU15ejRYclR3WVpYMElyVU5BZzdJandHd1ZxNEU1?=
 =?utf-8?B?T3JsUUQyU1hjNGxvRGIxalRjT01WOFJCRFNIbHhEeHFYbnBobTMxdy8xeXJC?=
 =?utf-8?B?UWhvWXVPalFpL201YTRSSDI0NlcxcFdocGNGY09CWXQ5NjV3ZXR0V0F5Tjlh?=
 =?utf-8?B?N3FjRzVFTHUvK2c2anVoSnY0azM3Vmh3NzVNWlJBZWFpS0FtWmhpdDlOLzVE?=
 =?utf-8?B?c3IwT2xoVi9BOXJtZm9wTDRCdG1hVUVLSWpvV2FrVFFST1JiS2pFWHVHZkhp?=
 =?utf-8?B?S1lQcWFzdlllTnN1RWZhR09BQzRUM2dCYnFzZkJ5MTlaaVE5ZDhMci9hV0dX?=
 =?utf-8?B?dGEvbDI2NDV3UmVGaVY4Vkw4Y25YNnZlVUdpL29LUG9KRWNXcHpXMTdkUTZv?=
 =?utf-8?B?TVd1NTd4ODJQMENldEJ2SnFJenEveWVjQW9hM0swWlYxVGthcnI5U3N0Q004?=
 =?utf-8?B?MVQzUkJWU3AyOW14Y3pBL3MwL00zZEhxK3J2S0ppMlZVWTJseHBtSDljVUo0?=
 =?utf-8?B?WVE3M21ITTF3YWE3YlB2dC81NUZIcURHZHQ0V0tqN3k3YjdrMTlhaDk2S1NC?=
 =?utf-8?B?WHFON1ZsSWJrb2tHdXpXQU1vV0tkdE5EL2FjdjUzRmRrSVdBQ2wvTml1c3lO?=
 =?utf-8?B?WDhGYmhYeVdQaitTN3l1N3J5YWRPc2wrL2dQZW84Mm9ManRFdFNBa2lpR0l5?=
 =?utf-8?B?SXdPTnYrNnhDbUhGcys1Y3laQktSUjc2Z0ZvZGMyYWRHODZvZVVhdkhzRWhy?=
 =?utf-8?B?TVVNZUVuUHFoM0grNlVQUU5HY1RpdGwvd0N1bEE5YUJER1E3VnZzTUZwaFNB?=
 =?utf-8?B?eXN5cDl6TlordVMrcmxHSml1a1c1S2p0L0J6Y1VhVVNtV2hZN1VRR1ZQempw?=
 =?utf-8?B?YXU4NWVXYXo2V3lCdFF2WW1SeWRIYnpUNGpzbnFlRTRqdzBBUS9EZXJtRkxH?=
 =?utf-8?B?NVhMenIvOFM2ZmlKT2I1SUU1S1BXVGlReFYwVFc5YmRFc1cyUUZ4QTNsOU8v?=
 =?utf-8?B?dUcrWHNuTmhwakp5WVBPcUd1RmNJVzNyREZkQlZPMkhmc29DOFVzWG5vNDFR?=
 =?utf-8?B?bzhZbkpwVFVPOEF0dHVLdnBQc1F4RTRPQ1NNNzdESHNqenBSL3dEMUNta2Ex?=
 =?utf-8?B?Q0JwbXczNUpTLzAwclFHVFVjbHNYaTExa3pBcjh3bkVaREg4bzEwT0xyRkdv?=
 =?utf-8?B?bFJRUmdZYVNPdWFnZXdJdTlZOTI4ZHdtMFIzUVYya2RvWkhvcjVZd0tKZmJJ?=
 =?utf-8?B?VHVseWRvYWhDOWp1OHdkZ3NXVWxtd0hOUDB0UjJMSFNna1dTZFNHQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd8ea83-15c1-45a2-665d-08dedde4436f
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 18:02:38.9407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSB+M2EfkreALxgIIOKjy07IKROZrSITkcLBbUynqhZ9D879RJi4T8IWe7O6K/FljQitCBEJIfsf7saytdEwiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22970-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:netao@nvidia.com,m:markzhang@nvidia.com,m:markz@mellanox.com,m:majd@mellanox.com,m:yishaih@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,cornelisnetworks.com,amazon.com,gmail.com,mellanox.com,nvidia.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6835734193



On 7/2/2026 8:46 PM, Jason Gunthorpe wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Jul 01, 2026 at 03:28:15PM +0300, Edward Srouji wrote:
> 
>> +static void restrack_drain_res(struct rdma_restrack_root *rt,
>> +                            struct rdma_restrack_entry *res)
>> +{
>> +     struct rdma_restrack_entry *old;
>> +
>> +     old = xa_cmpxchg(&rt->xa, res->id, res, XA_ZERO_ENTRY, GFP_KERNEL);
>> +     WARN_ON(old != res);
>> +
>> +     rdma_restrack_put(res);
>> +     wait_for_completion(&res->comp);
>> +}
> 
>> + */
>> +void rdma_restrack_begin_del(struct rdma_restrack_entry *res)
>> +{
>> +     struct rdma_restrack_root *rt;
>> +
>> +     if (!res->valid)
>> +             return;
>> +
>> +     if (res->no_track) {
>> +             rdma_restrack_put(res);
>> +             wait_for_completion(&res->comp);
>> +             return;
>> +     }
>> +
>> +     rt = res_to_rt(res);
>> +     if (!rt)
>> +             return;
>> +
>> +     restrack_drain_res(rt, res);
> 
> Why the duplicatin of the put and wait? Maybe
>   restrack_drain_res(NULL, res)
> 
> should just skip the xa part? Same for the other functions.
> 
> Jason

NP, I think they can be easily squashed within the drain() and restore() 
functions.
I'll send a V2 soon, sorry for the delayed response.


