Return-Path: <linux-rdma+bounces-16606-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCw7HDpIhWkN/QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16606-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:47:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB053F9058
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0DF1301F98D
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 01:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09AB1DDC1B;
	Fri,  6 Feb 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OYlGMCr6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848BD18DF80
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342350; cv=fail; b=IIVBoxu+IJODFAqWjW4bixx2EBmV8yuUYR5f2oncuzrDdVQOde2es9MPHdnpY+qEP22YqEQQZiIiCW6kOfxXyGgxdw3ge75eHVv6nOPpyqeWrIMMwNvOMjfIVtEG5yhfx9H77hHETsMP8PvTn/CXY0CozJYmgOoZYvwztpYvmn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342350; c=relaxed/simple;
	bh=N23/o3iMGHQ/lDOgam3tpSkR+EsyXU6D/GwOBgF0Fk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PiSGUTAVD3hT9uBLEDlRBV/MwjxUevpY/1DFblH0jur9s0grlFN+bhq2rnhgD/v72LHeRrbkvRtjP7arLR6GOVPtBkJTfPYZvoVrpglO0a3qMFiSX4dgB8eEGwRMxXp7Nzu8u7peVEpCXGiCSWgvIkgFnxth2VJz2uFZBoKHVJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OYlGMCr6; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1J6WKwiOCcUlkhoykDG6ODxHiDbWI91jlOdJlmd6pyJfqitlB9nCo4zu78EcHilyey3Hmvw3vsp1E8gJGlb/GsF80nNBeKffHW2qkRi98A83tOjnXAbJ6N988Jnbe4MOptdpvWSspolkrGoeWvBHeVJNmgMChv9u8Msf462tddacO5mn7A87SQ+LZSxMVssF1+Ohj73sOsIG8hTHAhH2AHjcg26JTwsC8oppBL5KutK4MSBYIoMKU5HpQHx+IomwgcofJWfmT1NDYYY+S1C7865W9G/nT0MyiWWbIruHFjG8VBTy1OKFVcN2WpeXJEBnrukuSRqHnUXgpaJpXDKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i66UKqAL5Z/VsgxVJAY9N1IXHS9lB+flIplfSc/+BL0=;
 b=xoSGeJVKueMT6yWyLYMleMW0TCywpzFqk4ZTTc08AAb4PwxxhZ734NHwbEvdcfZaHgcc+5nf7pGooPPoWLXVta0ay5JD8mn2crsQiL780i4x18b616Uz2H4DdqK3X2+RLNRv8jvqbV96zQkTrM5lm6Gj1GHbuD1k145ShzeB8ZCQAXb0A1Mi8YYeZxc87Gfg4PiuzmH1OTf5ji9054yz0V+p3y5+0pi4i2TXr7cXFz/QvAKBZEw0S+0aYfOQoDvtAuFcJwypHJryMK28Yz2SmyajGg+D/+1BacDD9MywJbfk4DVkJcGqgTOPNznOpr5ZoDAku+hP8yLU+JQD9c8Bvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i66UKqAL5Z/VsgxVJAY9N1IXHS9lB+flIplfSc/+BL0=;
 b=OYlGMCr6doQlfnsSBFoSfbjARkvtM9ZxGctPEiBenfEGyNbFNWl4kSvPIAvSrXwKM1XG3DeaZAZMdDV+MwSn4BUkNdSD/Rwv1hD49rPnUkuv8qTmivjUOT4cohEatB1hQW6l9dHzDNo7d/tqS4DA8kYpJ+SlCF4/XrHMA4N9Wx4oBGd83ZgXr+KdV5QvIFB8iGz4ZfOPxJ9ariR6jBwbeu0mCTSKnLsuxU+fULQwgMS3iqlPpa4NAyGjPC7+xKczTiP7xTL41mpd4x2MBEQcB+987bvpYpYUMwjOIqdTdf9jZenXOSE4cYXuKNDQnskJ5qguSdRX5+6ylyDV97zGlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 6 Feb
 2026 01:45:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:45:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 01/10] RDMA: Add ib_copy_validate_udata_in()
Date: Thu,  5 Feb 2026 21:45:35 -0400
Message-ID: <1-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0031.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e68ae18-5657-4841-31b2-08de652171c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zWvHz6qhcShDa5T3sHKRy9v88oV4BfrVS76k40S3hxAocWqEEhOAQ5D7DUJy?=
 =?us-ascii?Q?JzzyguDzh66F0puiXlZIZ9jU7fq/qDRjbG2F/mrzFdEHHQnqqwh+HN0tHBxz?=
 =?us-ascii?Q?BkM+JK/UxiZuoF3g91X0CfRPa5QgATADqxEyQ9pC9piI24twO5Cjq+5Xh9lo?=
 =?us-ascii?Q?ZUCK87gWVLPhBwLUYMDvoA9L2L+x/wis9uiEx9S3mYeZSXAaUVkhQzlcbfSk?=
 =?us-ascii?Q?Tsi+jEQ1v7+1FTWEEGhkmoCYlhfdd66YRB7OMRZjAO42ITUS8lW4x/ujcyNW?=
 =?us-ascii?Q?3Uy/LLXOrehvEPDkX+R74fm7HcxLgJLeI4alkbce8XoudgHPT3WmWPuetOyl?=
 =?us-ascii?Q?DePT5BRUxOyxDt9Fn7kiN+m3YI8aHVi6xKKLMHG8gMvBI0o16WIlp/+fZgDE?=
 =?us-ascii?Q?EcsUNVr1YsKaB/6DWBgRTHg7DHgWAdW2aLW+xSIMw8aaI46VlEQi3rx5AJZE?=
 =?us-ascii?Q?n50cFtCg+W+ujmlnYrDcN3n8vNrXpJp8iZ7cPfscQI8UJao9ckvojYMT8dLs?=
 =?us-ascii?Q?YKclRaEVxmKwIFNFtB6FR14ulqgsR5tSkX26mSI+FpbyW3H4BZFZnPxPYvvM?=
 =?us-ascii?Q?T1KZbuOR1tHyOJLRYcjsuV9cVrTANdjFVnpabOysXsXW4UUk7n9md5+Q1OSp?=
 =?us-ascii?Q?FwbJDmllXv01iWo0Mgvk+HkHg7p5FLbBiCB3oR5J6qCSs5QG6FaBE3AlPExf?=
 =?us-ascii?Q?hfIR4GnMnax2zTasGUT7sF0e8txH3pEIK7X3riiijXOUG7gatbgOlpVWtvbw?=
 =?us-ascii?Q?Pf5f5Atww60uckHw1ofSnVLxjXk540HOzKtuG1QwYdjBDwWkFZZ+jBhND7z3?=
 =?us-ascii?Q?J8/5D/HdrXrvAT26t07OLVZWrdDxAGsyqz0ED42bDq88SoSiZrnD3tLmWVyQ?=
 =?us-ascii?Q?/i59Sl63cwel20IBEgwFm9Ex6LT88PAXSo6j+ItMo69gz77z+nI372s7KRGQ?=
 =?us-ascii?Q?pUV6deOv/DU3MlT6BQbttK+OnTwz2fVkahpH4UqquURKWgQVzzMwbuoTgy+r?=
 =?us-ascii?Q?WXwXXfE0Eb2st4ANKvAwuWEUzdpqyF4QL+C+nu8fC63uwxYhfnEPh5alNEgx?=
 =?us-ascii?Q?T12U7LaQnn3jIVL3QQ9Z9G8Syn//pziUuz1BIZ28atIdPTro+DeOogj5WzXA?=
 =?us-ascii?Q?79wBG7nc7GVS1/WkXC9tHQ3AyrbhkxdWUkvJA8E5UMTCU7c1ia00JhZu3c7Z?=
 =?us-ascii?Q?7y1GvKCpqwNuYtre/US+wBbDM0FE3LiMkaI7eVBfpf1eu5LfhnICHZbp9Rok?=
 =?us-ascii?Q?da9+CqLhZp0MYoLQJZGfer+xA5bMsG0fs3t6IZa9zKMm4yzdSOfJzRHG0mr0?=
 =?us-ascii?Q?aeqJKlBLQGzDnmgmjSUiLHNkEco4Va9Xw0aPppa1+giw2sxn5spBdPz1mB/m?=
 =?us-ascii?Q?EA5Q9bVQ44I2yLN0wBlqkZhaUljg3ng0EWvYDRhAO+jc4EVXdcE94RelQeWv?=
 =?us-ascii?Q?54N28eR4K3lGAfPC/+rXzbBUxB1j/VdLjzk8oCsj276ykjjsSIB5yNlZBy4Z?=
 =?us-ascii?Q?zLTdflbLkLrTxEO5L9Moheqd4A7VUkC7bFEHwMvN48Gbrh2i7fbKVfc2ut7A?=
 =?us-ascii?Q?L2LLssIiW64RaOmoBuA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g5I1IQEWXYGX1/aXjiMrRPmKOf117KzS2wFBgqZseZ/ZzZQRR6S06r3ZXszX?=
 =?us-ascii?Q?2NRGdKsQfwd7FigpyPVLpMBo+SPCyrqE5a5n7/QYvhIM/T4yo3ituKVx3es7?=
 =?us-ascii?Q?65lJ2YR/ebYe1usUEmBvPAbghkx4N/sAhszw4OQAQv5wHgbhGrGTIDMU5l6b?=
 =?us-ascii?Q?3/ZYSKhA7r/EZWj6d+QfCdZXts0+Cx+7Yk+t7QSsmCj0EMdIPbarzkGgZX73?=
 =?us-ascii?Q?EnAtnpjli1lehckcL8X2eggb6EujUfyYtshzSvFU0UVNhppg81ZS6I0bWbNs?=
 =?us-ascii?Q?8oUmV8hvMjPyuJECDS7UhvGoYBYEnC918/QoWj43/eydzRpoSt5eBqswiNt7?=
 =?us-ascii?Q?RUjQ0TlkJvcgvwcIckVdKff6/KjVZ+0EKXHTSreziO8kLf1RANKFDm2hS/0V?=
 =?us-ascii?Q?/xEtIfZ0xiHYvog+0QfmMcdhkoMHHvFGIWOlnj3qapGVc/VGmGpSflShmixS?=
 =?us-ascii?Q?chV920KHi13ad2YI3d+BdZhL+9Qo2bxBBRB8h1DdPhoE2d7KZ7cysUs5Xbgp?=
 =?us-ascii?Q?zrBt6VH1sz4EaHITEqaQdUgplUxKYPBMWUvQ7Co/gL82tRcmyWygAV4fuyYV?=
 =?us-ascii?Q?OLbBhbPKepkpfjjHD/TzO/wlQaof2EYe6F4WOdEArh1NAiINsk3DSIJj1IEJ?=
 =?us-ascii?Q?kdTl6LAa8iTSfEGJhis2GrK4f4ZeA5IeYCTbDvrZn4GXBS0jp2QvUhZ1Ru7n?=
 =?us-ascii?Q?Yk3wH6WZGRwa11npvRwUcGRSQ7ux0LHwoE4sxdCyP0T2zMEOji480fDwU0UJ?=
 =?us-ascii?Q?JApqL8ueUmZBk4aiLT3CaDHdcSNc0OInOA+L62ZqxbJTok9MV0FpjKrxxnGc?=
 =?us-ascii?Q?PdX30lD4HcnFKg89u/aBKU6I5JQATQqVx+ZKtG35f/d16hMIJGCpAE799aGW?=
 =?us-ascii?Q?rlGm6EcEkVeR2EnP6AKD6AQ83PHZPHVOpCWmOJXvj1f/6ifJsU5pYK6fsr66?=
 =?us-ascii?Q?sxvX6wirHOXhaMgJ35S9S97H1m+NXLz49CIVdeLBAgglqjk/VzCd1U/yWQ9P?=
 =?us-ascii?Q?v+66AXaLY+p2Nz2dUwogSKXSVgkrJJs1BrxJlIqt3eoptCPJCd9EUg9tdfd6?=
 =?us-ascii?Q?2/sa5hiGpFNCxxMXsQJW2pzCGO5dJcyWhIaoOy4SF8kSqZGbAtMQeCk+4nWL?=
 =?us-ascii?Q?dVjAH2QGCobmu8SMSVJ29K6zVIFBs7RrH1WlC0cOUAt+r0W5rfH4wKuTmkWx?=
 =?us-ascii?Q?Cww+xTJXZfJ2+65lZ74SqBC/VxsetRGiaO281Bk9pohURYR9UrMr3nigfp39?=
 =?us-ascii?Q?TSBsiUA/Ue6rsvQmI/E1Z5WZLLiIzrC1/EoV3ZwJfyMVZZcnrFehEflQ7zUZ?=
 =?us-ascii?Q?7ER5rzsWUl8391pxJWPn9zJ39d+mhzpfLoN4b+UYn+kJEn7/TprUWWI5CbqR?=
 =?us-ascii?Q?DY9P+PFWvIF0AX5kKB5rnT0CFJ5EM4p9HvleQITscAoiYeBSDV86f9U8EmoH?=
 =?us-ascii?Q?U93Ypk40fqSSxHY4oen4KZGrZ6OKZSGs+0pyh+HuQ0hhlSjKdElpiBY/UUDf?=
 =?us-ascii?Q?BF/YfKnrEn08GBzjnQaqu3XREy0V9IEO21WVHVBIeCF/UEzyC6SNP4xHWb3m?=
 =?us-ascii?Q?45ghpR87cg36gxQftvlKkeoemCHX18JHn1pfIGLgYF4V+EHPo70GEApmnuIo?=
 =?us-ascii?Q?CsnIJYrrEx5TziuoVOEFAfU9oMPB1zO1FjkpTz65E2LaDte7n6Gp6LlB4C3R?=
 =?us-ascii?Q?h8uCOwnTkOuY3277jb+oxF/KYUJpz4/ynJU96ZIl+b8WKmIMmc8xI3M3rWlw?=
 =?us-ascii?Q?/mQ46GzGlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e68ae18-5657-4841-31b2-08de652171c3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:45:45.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBI3yjr0XCelMCrmzeAhZjbyrxkGbN6SWIF0+rJzeVLzs39QYgw6wuvXoU5WATxf
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
	TAGGED_FROM(0.00)[bounces-16606-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: CB053F9058
X-Rspamd-Action: no action

Add a new function to consolidate the required compatibility pattern for
driver data of checking against a minimum size, and checking for unknown
trailing bytes to be zero into a function.

This new function uses the faster copy_struct_from_user() instead of
trying to directly check for zero.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/ib_verbs.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 8bd020da774531..32dc674ef78cf1 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3119,6 +3119,43 @@ static inline bool ib_is_udata_cleared(struct ib_udata *udata,
 	return ib_is_buffer_cleared(udata->inbuf + offset, len);
 }
 
+static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
+					     size_t kernel_size,
+					     size_t minimum_size)
+{
+	int err;
+
+	if (udata->inlen < minimum_size)
+		return -EINVAL;
+	err = copy_struct_from_user(req, kernel_size, udata->inbuf,
+				    udata->inlen);
+	if (err) {
+		if (err == E2BIG)
+			return -EOPNOTSUPP;
+		return err;
+	}
+	return 0;
+}
+
+/**
+ * ib_copy_validate_udata_in - Copy and validate that the request structure is
+ *                             compatible with this kernel
+ * @_udata: The system calls ib_udata struct
+ * @_req: The name of an on-stack structure that holds the driver data
+ * @_end_member: The member in the struct that is the original end of struct
+ *               from the first kernel to introduce it.
+ *
+ * Check that the udata input request struct is properly formed for this kernel.
+ * Then copy it into req
+ */
+#define ib_copy_validate_udata_in(_udata, _req, _end_member)              \
+	({                                                                \
+		static_assert(__same_type(*(typeof(&(_req)))0, (_req)));  \
+		_ib_copy_validate_udata_in(_udata, &(_req), sizeof(_req), \
+					   offsetofend(typeof(_req),      \
+						       _end_member));     \
+	})
+
 /**
  * ib_modify_qp_is_ok - Check that the supplied attribute mask
  * contains all required attributes and no attributes not allowed for
-- 
2.43.0


