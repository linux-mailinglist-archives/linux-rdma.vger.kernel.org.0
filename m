Return-Path: <linux-rdma+bounces-16980-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q6ayJ2YBlWnuJwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16980-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 01:01:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A6A15213B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 01:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9508E3013719
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 00:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984188462;
	Wed, 18 Feb 2026 00:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YM1LEvlY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0BF507
	for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 00:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771372899; cv=fail; b=N+6P5GpeQTMky4IdT6CjfNd9/8bVTICKoqtYS/PF9BkjXNUFO1BkelAFVikHud2/kHUipYoPPmZndOay2KNM6NB4lylGMoTBY7TlwtBmC20Uw19lMDqo8CFY57WvSWnQmrEyciwCrUP/YRi5MC+2pGy3u5/9Ht4Ah+7/UbfupoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771372899; c=relaxed/simple;
	bh=aTzBcscwjZXT9C3Sq7vzNCk7tnFUWchlt4CSSJDP7mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cZdu85+jyzX0iymez6AgK4j1MfZr1Wne0Ia3POQCx/rjFX5YUuZueyLqy849EkcXYTbwfspgz7IDzdIVY1Llp1BjgwFKksgaGMBvyonSd4hdUw8NH+b9hHs7CFhQYG0Roqmk8x25bP9tn1IC+SxXNC4xedL7DaWy21+uiSt3NJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YM1LEvlY; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMnEw6CqZdS+18cWyHmTVS6e8qdQY7JX62rj1i5xFP5IIlI8QaY3iwHqqLvttTto15LDDEjyQNWhFCIMyvMt6XFSa3Bz264X1CM4DKwWqKQhOHDLAI5+nt46h/q+TsNKXczVE3xQDOgtK7RlzY+lOcgZofMKocFq69bylMyfRU3rAfzmcNQB+6Kqvcj7mwJUYk086butKymF13ZGWl98DH8qgUV7A72CEyhrda3czIPck4AiUUxwe1xNiwZFDQDTCuv03W4Y3Sror5inc9jRtApQ3eaEFy40IFVa3nzCnaGnol8XiDkSnH64gGcO0QBxNM6YO7VtS+OyiqUsmV54tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhgNsjWPoZtXIxQApUnW/prOaUFrUPUOJ6WYGqinfs0=;
 b=dDXLTlVwJp0ywKp9ci46mYV1iTem8eTG2sLcyCVQcDwcWh11h3EtwrM4wqNG+aWzezisnuU2UNJSvXK/Q+i67KDbBIdTTEmgNIR00uQmy5r+GhihUC/XjiWX7dwYuUjFIxDmuylMKS0hFZVNolryRq6QAYLyKoJ072cMf7MMoMCnzbmEsf3hHoEvZXCxQvHU/EZeDfYjtjN49wnPs/m3LoYjg0fHeF0txRhCOg1vjOqWkXXReQzUXuRvgLGf2DcyUk3VSSXk7gdbjtVKWCtDhRHQ2lzr7KeeZ3lIpSjbAFjJCMfEN8P6fHDXujkRt+nDRO9YgjgP2YDDqKsuV4icgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhgNsjWPoZtXIxQApUnW/prOaUFrUPUOJ6WYGqinfs0=;
 b=YM1LEvlY/GPmx4onRJF3RhsY82/Qhz5Z3IDipqZ6npUuZzr+66uWZx5od9b5FfSKN/oR0XGCzuaRvEruxoZ4Kb/qQQ/Y0YU/AVi/0+lNqW32ek/QRD4Sgo3IJkKiV3OUhZNXRjzEi6M13TE+JVJxn0RPJCVRc0CxbirmqFu54mOx7QNK5pNLc0UXlEP+CF04YKIBl1ULYyaefMwhz/vNFer9VCfwbFltdXMt/JgFIekMW4dMqwVDdr/gTdPBeNG4aHgik+wjz46M5ZxWWAP6yPP/E1dDCEZ2dDu4QxlSan2IBUR444LiBAspM54MvY/YTwd3CrKYYp4z0Cuyqaf0Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 00:01:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 00:01:35 +0000
Date: Tue, 17 Feb 2026 20:01:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 05/10] RDMA: Provide documentation about the uABI
 compatibility rules
Message-ID: <20260218000134.GA723117@nvidia.com>
References: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <5-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
 <20260213102347.GL12887@unreal>
 <20260213125658.GF1218606@nvidia.com>
 <20260213155731.GT12887@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213155731.GT12887@unreal>
X-ClientProxiedBy: BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8ceb78-b00b-41da-7861-08de6e80e149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hhWktNxTZsYVDCEsz8La0nyVUoLKB6G6v8aIZ4Z5335Xis7qjFanp+QqtOy6?=
 =?us-ascii?Q?EKyffx+6xDo1BcDinEh33jrrsLNp7e26INOqC1nRvZ51vYX07hrqSGJ5yi+J?=
 =?us-ascii?Q?jxBgvftfmbtTkGptT61RbX8MCw6XByy6aOVLcS1ky5es1uZ52ImtVOBSvMzT?=
 =?us-ascii?Q?0ocQvn6vUlbVuKnmP8cFGlPF35cr4eZ/5G9nj1lPWBT6eNAsgJiy706lVysO?=
 =?us-ascii?Q?SSIQWOzp1V8FZgoL8kzP9nEsB04IYvbm51kXKWuviCyvoDz7RSaFfIqV/aVH?=
 =?us-ascii?Q?M/nR5H9evpN+jSvBOLkRdFOyVtvbmi22fsAmifzWH9SZtHl65S2YGAX2DoN4?=
 =?us-ascii?Q?GVGyXEDQOjCOlQKJQl619pwnrxS1veTmEF1XSnag3CZsYHfQNq5gcX6S//kk?=
 =?us-ascii?Q?hieigaoRUUx2n9o5g1yNK1FweZyOilVHUiBzD7e1sQb390O/OX4bqZyU1Wbm?=
 =?us-ascii?Q?nqIcuRYUbzUs9npGd8Fv77nOjIfonglzjqJUm6NligH9jImxyiYzqTbtkt+Q?=
 =?us-ascii?Q?dM3fbNTYsDvldt8i6W2sKRY2ohcRwxjGRPph2BMh3f9RDA42TBfCwmvxkkfL?=
 =?us-ascii?Q?bqTwcbhpiUcuqcU65bRIo8V2ZpbreLOMJrNVf16Dcz/x3F/0EwM0cUQS+Ug0?=
 =?us-ascii?Q?QEWW2UmEkc6d9wmN+1ra2O5JGpmj9s4XTXgWstF5fDHAorCscMo8jeKqnruZ?=
 =?us-ascii?Q?hHy7zYOqNwJ2t6XhhOwVMwCsX8CqT1zHecG13t9HSIk8PaJuhNaKWm1n2a0q?=
 =?us-ascii?Q?ay4/K0bW4xJeM6hZZ6gUgwHjC37qTGiitaqlSnuTNYbIGopUo8mpxkp+TPac?=
 =?us-ascii?Q?TS4N41HTIcdhRvOPBbSv6Jkt1gJ3QJr6BRE3OnFdJDehZ9MDsc8WNFnLGu/v?=
 =?us-ascii?Q?ocRKsrrYeW6pjiqw4JkMs6TVn8EsLJvwdmDJQDTyWF8LeZ8Y6Xl7PVt2tejL?=
 =?us-ascii?Q?Mb7rLeQCiykGVLl7/FGDXaJ2+5rDHi1rGSve2xJ6aneKF9GBD3dcfrRXeOuO?=
 =?us-ascii?Q?U66uNJF/8gUXmUMmLnU+Xb5I9qTlqZD0yXL45EnT5DWSpzjje8Z4NrHUhpyy?=
 =?us-ascii?Q?Wr6oDbc7DY2HbaGEtQf8alAf+cmsz7vEXVgQpd7p/ycjvozoGIMprh7QEqP+?=
 =?us-ascii?Q?xhRPJXwS5lRcerZkA4eq0ZG9peKY1P2oEPyUsw+ag5iTz64tGraC5a9+eld/?=
 =?us-ascii?Q?dgKLNSbex2x9HSZBVolSyOrcmD2AmTWRzk7THVW8fxBGEx5ChOMU26kjDcnb?=
 =?us-ascii?Q?lnrjn9lvVYv1kHcPOJOIsUboILzURYS24Q/Q3jREGX8ol+kcuj63Hc9K+wqO?=
 =?us-ascii?Q?ryPwANjEF3CzgBp/S1IbucAgc91fOPMAVJOnNMBj+FtQ22C2VCAvzSPjxpYi?=
 =?us-ascii?Q?Kc3CxlYABolclJ24lQ8lcXA3Cs15GNKugaPwz1DHct/2UZqtmV88Nb+sHu6i?=
 =?us-ascii?Q?EWsz/o5+pRiu/0jldxBHuvQGbOWSk2VEqZYeaVSgw031dFehWx7kAQCteHMZ?=
 =?us-ascii?Q?2nd/BU/xKy0RB2gl1KFAZyaJuQSX7Xh64Y7BFCQPQBqd9Inx8RddgH+i5tsd?=
 =?us-ascii?Q?k+p84QSX7NDzUYkCWuA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PgBNCDoSvp+6WrDpvdzgtRuQONiAQh153eFoJlcGC7+t1Pt25uhfNFxL0SHX?=
 =?us-ascii?Q?eSgWi0AeFNjw9S9DFTqE+DIYNNo7KwVyfhJQwa4I/+bVanNcw8sFhmT6OO6e?=
 =?us-ascii?Q?A/35ASRHCK9+cHpCUowpgr1MdEawYjI9DG8XjgZvWFHOIKJfYUVztcwU2Us1?=
 =?us-ascii?Q?3wQ0DjaT3vdpD6jjkcy5zYJFSGdWW6MrwkTONY34SRLXuowm2bS/M+LNyaN5?=
 =?us-ascii?Q?8NvtOYLqiEhh8Vde5NR4MgYWRUfEqpMsNm6I1gaFD584IOz8um4f9nqOiSX1?=
 =?us-ascii?Q?La4B02f+fVCXIseBHRROEwVXz4bhLJMIRxmNPsPZ6tUgcGPxC3uRxFGCc4jF?=
 =?us-ascii?Q?VLEBNS60QAZbl0pKqSDUN2nVnvj8r4j+TO5zQm45xGnxi6LL1UkVgAGoz7Bw?=
 =?us-ascii?Q?ZqS0R6oJv0rr5dzF6SjwgobPvIA4qjUK/ZmeqPSscskfLSSf6WnS82raDekO?=
 =?us-ascii?Q?o7RkLYCcsd+idtd4vyKldFhSEis/IgwofaG1p9555VmlZSMW7QLjNyFWuPGF?=
 =?us-ascii?Q?ovL05qONIm97/mfJ9GrRcvBVZxztPoa3czJNihAPE0afN6OZfXjnQBb1EASZ?=
 =?us-ascii?Q?b03lKT1AbnrDUqNvqiFNguExZj1R1G7ICwpGuQRqdlwK34/iRTniMJZHlUuz?=
 =?us-ascii?Q?6Mu3sKc5VnGhnrrzIjZ04c/Yb4CpZ9s81JgV+UaMSAKwI+VuFd0XFeTSMuuY?=
 =?us-ascii?Q?OrPqCry4zp1IsGqJFz5km65fjMAbRLPWa3mXfrXlP98CDwh+ZZhnp2IADB+j?=
 =?us-ascii?Q?yxOKtSgH0aLa987L/4hRwo86cLgY/eW/IkxDUV/qbFh1USfnnWZHVoYtpsxP?=
 =?us-ascii?Q?8ZwbqjrqoqO3iKvvZcbNnT7pX/AHQtL2KUQcolCS11KplVGhCEfiwHnYxoAK?=
 =?us-ascii?Q?8OrirrQVzdi8yMySWz5vfaRrGrm43UNEp6IxAC1+/qNOnyMccnFUyzfyod6C?=
 =?us-ascii?Q?dh2xFzJbbBRSfdzdxx5MtBpPTiUjprkuQzFiTIl27BslJ464mR5bOEydCOHh?=
 =?us-ascii?Q?uGzA872XhHcQ/bXJUenzJa0tvgHps5u87S160YG6BQQDpFYymB39hL+FG9lJ?=
 =?us-ascii?Q?YZqVTJpSl1TU/l1CQDUPvlxB2RCkXy5bx7VTUZYWIWkxtGgVzvjew2BQVBBg?=
 =?us-ascii?Q?seyJOAtO+tg69ow49DgrihmxPvnBGfGg3ijJ6/Qmyrkq+m7FEnv0iPYZao5I?=
 =?us-ascii?Q?djb7s0Pen9gXlmG21100+fNngsB9QSdJFzhOmICYKPZHG5ZL3nQgntY+GkL5?=
 =?us-ascii?Q?BYFgcFq6lkVzGQlFzdMFVklYquH6M3JqcNaP6uQy6u0L8dG2apBaTCNdV9lT?=
 =?us-ascii?Q?EGfxO0n81o3xccVDUr1oXzhF3b03iu9I9GbZxGmWc3re67tLYSdJWWvkcqFr?=
 =?us-ascii?Q?j50bZlVD2/wGoz1KvEx5lqp5x+FoZsa+CFoTbsaPyy/okVn7oZFucha8BUEL?=
 =?us-ascii?Q?eikTTH2Pa0VIC2ErUdRW+cxvuvCVdJAkuD2II3U4WfuWrCpNjt+phlu7kM2b?=
 =?us-ascii?Q?MKyNQJXMrFq/5sJZHSF6WDHgL56u/a6fVdSlEEOL8xNuykBoQF3ymSjFVMB+?=
 =?us-ascii?Q?eUGjcbL+naVtatTSMKG3D+oSAEn39VoWtTz8Y0aKPYFZ79X6zc4eVcFxaUxv?=
 =?us-ascii?Q?Dubmx7OqIFTH0R88kYtG34hAsXZjwLmfqp80S2ghe9FGQmdCM5PYrTz6KnAf?=
 =?us-ascii?Q?g9CgASsgywNzZn/tmbIeEq/qeNVdJq/2jMaPTvjH06VTHEBPbTPPBgcRdGdI?=
 =?us-ascii?Q?RmxFNO4lUg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8ceb78-b00b-41da-7861-08de6e80e149
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 00:01:34.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsuY5YSKKhrIqiGK+nNnaASPCwrdZAdMYpiod2v+oBq2VMSlCXeUbJr1ffZYEz2Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16980-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9A6A15213B
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 05:57:31PM +0200, Leon Romanovsky wrote:
> On Fri, Feb 13, 2026 at 08:56:58AM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 13, 2026 at 12:23:47PM +0200, Leon Romanovsky wrote:
> > > On Thu, Feb 05, 2026 at 09:45:39PM -0400, Jason Gunthorpe wrote:
> > > > Write down how all of this is supposed to work using the new helpers.
> > > > 
> > > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > ---
> > > >  include/rdma/ib_verbs.h | 81 +++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 81 insertions(+)
> > > 
> > > Can we add these rules to Chris's review-prompts?
> > 
> > Yes, I was thinking about the same thing, not sure how to do that
> 
> As a start, you can put it into Documentation folder.
> Here https://lore.kernel.org/all/20260212124208.187e53ae@kernel.org,
> Jakub says that Chris is changing prompts to consult with Documentation/*.

Hmm, well lets put a pin in it for now then, I'm not sure what to do
with that. It probably needs some prompt "if you see these functions
then read the comment above struct ib_udata in ib_uverbs.h and check
it" inside Chris's repo.

Jason

