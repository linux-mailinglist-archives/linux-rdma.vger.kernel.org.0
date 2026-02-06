Return-Path: <linux-rdma+bounces-16613-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE0pClpIhWkN/QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16613-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:48:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E0F90BD
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20F1D304C7F6
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 01:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67F5248861;
	Fri,  6 Feb 2026 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPzPrhHK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491021D3E2
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342353; cv=fail; b=DJ5wqSTeYeEfqfEfVDNgsrjKsTt07Ea1hSUdLsh+HPQ518oSPvRiIYO0skuHOpZjNBdzlyvwPkcyzpWFq6IcROjK0DlZGeSNqXwT2AnW+tK1Y9xI9zM41h594hz5ATKUGceuDGyJSIuOfN6gvFzrkKCd7xLoh9sblFt3n1ie9Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342353; c=relaxed/simple;
	bh=Tx3byKT8A+RG3udiSLiJmX6416ROamj926QlvOO73Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FeeOs0rkNlLtpFpW+w7m+jzaymeIeIggeMFkl5nGP29SU8BaVerCAB9R+gm9O58n3FHG5lRmI0n4OjPRIZjtQqrXlNN+r41hF9bIABctNkjEoCx0uPUtwGyT6eH+EMRedTE1au37HBw2CltwCTnoNeXQhorWD4zKPYSb6Y2Z77A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EPzPrhHK; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqm6CxD3WK8P/OM3q2DzDseKWtg3Fw6CbrBu1Yc1/0GRR/iA+Os1kwnIaaFdNrbZ1G/iNyLgnl0XknDvWv1SNaQxxCi5C9dz5pa9iXqDgS2gD/9qGwRVhC2w26N8AlmWv0o43qK/ZJMt8K+lgWl7IsYZiFJvJyZYD4TQi70bFYJeJ3DjGFufMSJn0XpURM0w87ubE6b3JGVyjr5+XQbKHVmkxjvVgCci/N6pFHT56EEcNjJ2/snRTd2Pix/ZKviSeXtuNsud4Siwv20FS97TkTuF9Gr6H/vr4ORISaSTDD9U30LYJVm3orw4oIzM9KhU/OFqOs0m1894EZn8xONXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J3FTJ0R9kixfvVGFpORgkHUe2wP2fUFfd6uzqtd9jw=;
 b=XzQSjdWKifucPdDS7HgWBlxzOccVmfLyOhMt3EtCAGvB+WhvS6211oI40BVcvSckZ1ZHnjikrrRbhYwZX4K0m1jDtM5C7vndFFYiNaXxRy+/fAkdBjARIeu3G4wyQAkAkC8RkyXEwZXspfobBB+xVWxUjqBHFoj/nljBqEBBCB6qV4talrcC2PjW9kvKtibahqX6zcLUBE5LTSOHOT6D5Xu6iiN9RFxMFVIpO6hM+Dogphmg737PZCOkwbBorAUfJRLkpkyvXr+kB+i6TqkUxDpcnXjYFbAlLVcsOdcrARL1B5B8amxJK3tWvZfXPZx9Pa6NJvmiSDsYS/7PuekMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J3FTJ0R9kixfvVGFpORgkHUe2wP2fUFfd6uzqtd9jw=;
 b=EPzPrhHK4y8xm9Erg6zDlc9OspdN+mRFv2jVgAXPBVt+LqESBXTPlr3e8XCOQrDMNkYeIUYDJtykI9zAITcLQ/IpF9KM+TigsRgUfa8kk95zocfVcILwcLmSkm/8iq+QT7XQygPitV1gtWtlFv6LXZpoqESVU5nDVznIaA6VNdQQc0btuA4tGkYFoZhntYIZPY+PYM0RizZmCOmJ223YUCG/KPtIKcNmCWViaoneELbTyEDzyhkE6YM6gRgn6sBhYLKl7WdFk9SD0gMqbKPdPGHYDv70PUTZdG/cHYNyOf2WhZknD/4wv1ZkTlMe04vKfRgtzH0EAY8T4TIiJpuEFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 6 Feb
 2026 01:45:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:45:49 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 02/10] RDMA: Add ib_copy_validate_udata_in_cm()
Date: Thu,  5 Feb 2026 21:45:36 -0400
Message-ID: <2-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0042.namprd20.prod.outlook.com
 (2603:10b6:208:235::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8a1e95-764d-45b6-6f24-08de65217344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lTLchlgILET04ePyW1UCNzBD7tuMwpP72RTZ3OsWjuNe30XAj912Dr4KeV4H?=
 =?us-ascii?Q?bmBYuhzwDjfRISawRP2QJ3wDtR3JKrbvP/r/2MmW0s8QzLDKUXSEH0KlSzrC?=
 =?us-ascii?Q?ToCYSbXktoMOxkOIgBMUgezc2wi8+FSjMc5ppE6CgjAMwEKehOekveP6OrBO?=
 =?us-ascii?Q?cxKPbQ2h5cMiV9PBOVlNipK8gIXAeHscHvcc36GnKLMJVrMWTSMJZJfXkT6t?=
 =?us-ascii?Q?qn3osD2GEAQ/h795I6Ek+5OtKmd/LIKlREP2y8Mo2WbfiSh0V4G49IMCY9KF?=
 =?us-ascii?Q?Fh1b8GHMLAxV4FsYzKg/s23umkMGoVUV31NlYcAT3tULZESgYFov+YjvUVD+?=
 =?us-ascii?Q?0TpDTZi0sAwAdHjR3aHdBhxuou4RtPKW4kHYQVFQkr+TD26hf82eFy5rDH1L?=
 =?us-ascii?Q?AmcSAuUv0N/ve7WSQtPNaXr0WqPgzjqGLc7enrtGEJho0IdPpb1okONK7wxT?=
 =?us-ascii?Q?KIQbcEnxtPsfaG+MXOqBenoDZzg1iHgGBXEuwc5SBsUZfPl6AasP964ixBwO?=
 =?us-ascii?Q?O3EvseqSixwfobBMDHbADIQon5QxfRRjkDYmJ0dQMiGb4wCmFLvfkYuP08OX?=
 =?us-ascii?Q?DWOY8OQivBBtKmu3SiJCL+MwOcYhY+uFty5zJq7Z3w5sqadM1tSt1zrcwFVF?=
 =?us-ascii?Q?jHTd9QtaTtaDIeCkqZKMzCjWvES+YPmNCgmaFB+kdKH6OYhDPtlLLRrtdRQL?=
 =?us-ascii?Q?pY4+ZjJcPLGupYTZn3RSAuFr4UIbX7k4cjcmYRRjzC7miJ8SQAXzewHNs8tE?=
 =?us-ascii?Q?JJgHKZRcv+WuZUI/Ot6b2XuYvExRbxGu1rt2KtsTdy7fOCq9aW5tD3q2M2Wo?=
 =?us-ascii?Q?hC9Ak9Rio0O1Qvq/NMVXWQzSB8i29g1RYTlvTmuObQ9mAci9Qty6ssxzWfRP?=
 =?us-ascii?Q?bheied4BjC1eubZoGKeDbq6Ff0qwCWq15UCztHFa5P3GoPhvVZKdgN2I9d2S?=
 =?us-ascii?Q?OFu+fKUwdUaPAY3wTIC4BAUIMcBFYdUpc9cJBN7+9hcT5czTmki84AxN5MMz?=
 =?us-ascii?Q?h9ayIBrNk74YQTs73rFjAe0vGjBeGsWILOKe4dX2lDoeuUkSV6ROrj5x95tN?=
 =?us-ascii?Q?xsJ6zVgv2kqcBIXzfrRuP1zppIPF5wqdDkdczKA1PvFoApNtX8/YQ9hdcVb+?=
 =?us-ascii?Q?DTB28Z31i3F3Z/MhVg7vCd38jkUgGfJ1d/DLvrgBJP4oGtJspwFkw5BdHqFQ?=
 =?us-ascii?Q?WuFkA5tGF4fZPstOH+1rqpHBRK/c/t2+BL+mnO447i3ZYqn77saVS41XghuD?=
 =?us-ascii?Q?V110dM+iaYoOTZUB7nOhGkruFLgC3KGitYE+i3PuXsktY/dqsYTu8X++/J1x?=
 =?us-ascii?Q?5k7kb61/+Z2wiWLg181voF3y/NyJUv+BMA4wvAsgp27Jy4i915w3c8aKklVo?=
 =?us-ascii?Q?lBW1JTqV6xDbvJ3nwd2Bce3HDtHLSdR6G+H/jiy3vFvAiy7nZ+BQP3R1qTuH?=
 =?us-ascii?Q?Ou8Hjb4uvGisNAueGvWLqw7MtHcF6HTIWRQHiqiWdfXPawL0GALRqKZKg3Hx?=
 =?us-ascii?Q?dGjffCbCwVyI9Qc+iOWg4AkRbnHwcZd5Apfv5kutfbIphE50K24hgw/r+UpA?=
 =?us-ascii?Q?NtwEEWUbYSCY4VVlZiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zVwC656JaBAzSzOK/tnA9z68VMnGsQv680g7yJSsa3Lf7ahVvukYMG8b29jt?=
 =?us-ascii?Q?mMXXwOAKVzBWXfUPBzF/9qISf6uE04aONXPzTiPcrYJU3gctGrbNXgam762I?=
 =?us-ascii?Q?DAaZf+0/QzT8tjUBVahYRZwcwjLNLhYWLrGXtFJgDb2cgXd4S2Z70n0cn3gZ?=
 =?us-ascii?Q?/3KjklrbuSnCdVZMtC0FVXD5oD51/WSYWxroha+x6IEpiOzmdYhRNc9VdVsE?=
 =?us-ascii?Q?5p8uKCg9k711YpvSlEH54LTT+r8S6iVThh8QpOAmBG03Zxyp7ZDHQEzwCKoL?=
 =?us-ascii?Q?1AdrtXe5WjhzYGE+Ew9ZkDJ83tA5n5LkHV2qZ75efF/jeeFx4e0Z+HwYDh9Y?=
 =?us-ascii?Q?VjcDvJ0UKsNCkYqmNbwOnIDiIdtBT3eXXp/9a4sqtdJfizSzYOTXynkZVf+D?=
 =?us-ascii?Q?n9WT8fEm4zl8XLcEHC0/ag/UgFHhZUNrKR4tAwgT7bp+byrB68BkNNOGK15V?=
 =?us-ascii?Q?Cy7hGPs2xHSLE6v9uMpSU7aoprPjfl8e4iDAue+s2AVglxl/aqioDaPMCg8x?=
 =?us-ascii?Q?YmT4cbG6MADOOZzagNgzEYH5DvUFcKsxM8P3CFpqZo12Xeg0RvSlAz7M80sX?=
 =?us-ascii?Q?UgT1Y3R37FhsUw1DU/i/G9UNQDOnnwxVrh1LhuGtvEHXR4ST8ZuQLAJS/h++?=
 =?us-ascii?Q?7VIk0V/VeAUgvEO4KwvFxfJbAt2axp+uGVIwIE3+KxTF7INCmSYt7Tmki1r8?=
 =?us-ascii?Q?tnfq1xXYyxcyKMmsIupuP0kLC6NBfe5Mvt65t3khHbhiYDYfyy9Xhf4JTaAk?=
 =?us-ascii?Q?Ng9n7dkeIlsnZPGZlykH0k8m2CCKgUmEJ6W8KkDdlMWttLPThFtl+gLeoCIk?=
 =?us-ascii?Q?qTU7X/KR1q7YuSEjCDYkag2Jf08lN03fzNDSpvpL5TL5+b/A5GQVzqlR45E3?=
 =?us-ascii?Q?FZonyA+lUSOdYUHwegHwkjzhhGU7eK1y7nDEEm+nEMPTHzr3RJE2QtSB+fX+?=
 =?us-ascii?Q?lmqwH5s2BN47ouzZ7/pYqvswpLfB7Nm0FqJQdx0TutmIeatyWmxXuISGVFCP?=
 =?us-ascii?Q?JR98q1ZQjMcaLYcXxdSaGl/Y4AvA/EUTsQw5YORo6DUFu0pD6baybirR89tN?=
 =?us-ascii?Q?SG0cCPdLtc0fIOb35Jvktzyp5M8K7K1CU5BQ2me86BTUK0vdD4rAiUORBJ4w?=
 =?us-ascii?Q?q2bTQudWGheZkxEBW4l1F94/28J0/1qfjgsecFymp7uxuPNnj41nfjZvQJW1?=
 =?us-ascii?Q?He2UDekn2Wl24ghkOET9jZc0m8JgWH9qMVeDdvj2orqY6Yye1JqSn6fzMRel?=
 =?us-ascii?Q?HeAo4Iggs7nvHNfTkN130ZcYbAKsjT96GrnEq0H0IxRJDjNtw5b10b8LOxQe?=
 =?us-ascii?Q?gEgcF8yQg6TstkhxlzZRxRRi5uz1F9zbmWAXN6nfrGXB9Gcv9huxY78Dwmi4?=
 =?us-ascii?Q?bQ1eu74jh1nknz+F41xKMS6QojU1H2yJg6mxNDNS1G702E+5s6xf8THy4pN0?=
 =?us-ascii?Q?t+86BcpXHzMIWbcwh2MVNVRwx5x4nqvxhq8tkaaMFISMffIKUUSIVNQZgpoS?=
 =?us-ascii?Q?MlgUAE7XAo3fNsjBFDn/qgKan673ks1mf6t/VFgV0XOSs0gwh/kPxjW94HE2?=
 =?us-ascii?Q?MIvISzV84Y2YMddCtIJs9tyWh/Gfifl3DqqNroyfD68XlacEpXeFTdm2ztrM?=
 =?us-ascii?Q?5QCSqc+bvnholabtLZjH33jWSaNVb0qSdcM76gIh0eVuU5iWlr3cSOvEND30?=
 =?us-ascii?Q?vRLgcI+1k0oqv1nWvL5FNx0l0Nf7CsxjjtX9zHRk7FQ2j4WmLPkO59tMbT7H?=
 =?us-ascii?Q?GHlND0Ma3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8a1e95-764d-45b6-6f24-08de65217344
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:45:47.8740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhyQvTS+Bxcc5ARxEs59txPLw05FmufEMS9WBgDc5rhtFbI8ZIYywBGFIWdwuyvA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16613-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA4E0F90BD
X-Rspamd-Action: no action

For structures with comp_mask also absorb the check of comp_mask valid
bits into the helper. This is slightly tricky because ~ might not fully
extend to 64 bits, the helper inserts an explicit type to ensure that ~
covers all bits.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/ib_verbs.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 32dc674ef78cf1..bb61cab2ef9a06 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3156,6 +3156,27 @@ static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 						       _end_member));     \
 	})
 
+/**
+ * ib_copy_validate_udata_in_cm - Copy the req structure and check the comp_mask
+ * @_udata: The system calls ib_udata struct
+ * @_req: The name of an on-stack structure that holds the driver data
+ * @_end_member: The member in the struct that is the original end of struct
+ *               from the first kernel to introduce it.
+ * @_valid_cm: A bitmask of bits permitted in the comp_mask_field.
+ *
+ * Check that the udata input request struct is properly formed for this kernel.
+ * Then copy it into req
+ */
+#define ib_copy_validate_udata_in_cm(_udata, _req, _end_member, _valid_cm)    \
+	({                                                                    \
+		typeof((_req).comp_mask) __valid_cm = _valid_cm;              \
+		int ret =                                                     \
+			ib_copy_validate_udata_in(_udata, _req, _end_member); \
+		if (!ret && (_req).comp_mask & ~__valid_cm)                   \
+			ret = -EOPNOTSUPP;                                    \
+		ret;                                                          \
+	})
+
 /**
  * ib_modify_qp_is_ok - Check that the supplied attribute mask
  * contains all required attributes and no attributes not allowed for
-- 
2.43.0


