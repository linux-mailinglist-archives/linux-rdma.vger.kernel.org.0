Return-Path: <linux-rdma+bounces-6344-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8CE9E9F54
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 20:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED741882493
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF6194AFB;
	Mon,  9 Dec 2024 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W/Wgnl4S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372517C990;
	Mon,  9 Dec 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772010; cv=fail; b=rZKCUhgignQbDWW915Y9rXgZh9bWpCkUA06vvh0WVDT8PU0MtixmOJi3sGWzjwk+Pbg3eHpxkHQGkcXEpW2SQRJKeF4UTgBRy+1A8duGQy8VoEQOLiUULCfyIoluQk/iszG2TipiMTq4KGbzWO2C/Y2rBu3JJV3iKWphZaJDYIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772010; c=relaxed/simple;
	bh=ohR9YPfjV65o8wuLqQp4oGCyewK+nfsXIW28BaEPhyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k2kyFfaXG+ZnQvuBN+RBQm0UqHeMPyLZHSqQo5kqDJx6QZ85tMwm1NcyRyyOybNYbJRLbxhLnmmxTRAhC4fBpvcwqjOp1RvWgcvUxrPcthgM2wyX5z2glWrVkgkDX0JgMy7CqOqHI8T7mDIVScA5GUiF4zjU0RYcrs5fubtVVmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W/Wgnl4S; arc=fail smtp.client-ip=40.107.212.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEoCeTs4/ES1SqVicVXKq0/ixGkYzzFgRWZiK7cq4Ox2gP+/JpxFJWHvycKcVBRx4McMN4+HMzN6wFISdeWQ1BDaHUCiW6m/0zuHmlFs73OI0ay8BRwZQLF087svLy81BbH4ZU8q8G0Cy8c4qQ61FbZwqbPKWtt96X8YVdBAgIjM1LzqMtk0UomlVO6JTuy+iBoIkXbVH1SwDcHnQMRgnDkXGcZHIsfqtMdDTAfICEhzM/wXump/kQw+jfWkYZDQlJ63HtjKrerw3RZVpeIVOc0V+wwvOwGqZqqI31fqMyNPFmDaUsbN/9cBCGNNxi5JjE5Y7il6YOWfVYzJZh9hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU7b/QTiF6EvEA922JGNoOLLpN2vU5KV26OctsloLdY=;
 b=MPKunpHlrJ3blUhJ2z9z9bNDjjYpgugZM+gWiJzoOk/SPoeLDd3y9Rf2psEI7OjTz/LQiOgykD4CT4MSHFg2+Hzr9173Iluu+RYWZ5tmK7FVO5LZ7edsPOZMISw2EHT/Aw9BVhFQUp9LltmNqp7xV258Abwgov/mfUgvk8PpRMbOPOtFStJ/JdUMy9iSo0ACAdvZo0CIj6yS8zu5OLlqgFWfLuPrz+CZ16y+8OiVT2tdFb/M3fD9m+0TiKZbvCxP/dlmgxNlluFVSPDXn1WvaIY0xGWFtN1REUY0pk+w70jFeBLJGkzY1nmVEfJWhinThadFD9cC5PzG+3nER4Yspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU7b/QTiF6EvEA922JGNoOLLpN2vU5KV26OctsloLdY=;
 b=W/Wgnl4SSJnp08toYSeZZiubhFn5/fBXnStHqKCABl71R++JfvPfaZs168yjaz4UCf42vt13yBbW1MV/uY13zr/izFHmXBBNQY5ANhBZ7pYaUYsSl3shrDJfjpaLIg6KRoxiRLj/KvzVZk8entE3dK7KiK+ijydThpTtMVzHczrnD3ZcIpUdtz7Mh5vvsuOKoc+z81Mdj8YK9jisJgSiYcskP1yk/eJ+PfVFcEgHXRZSikwG5whxJSGOB7Im04wYm4MatZapMDTFzmEYKOKSY8+xp+b1ePSm/U499Uwhm5vhtSmN80Hyt0+0pyKbeYWTGJ/tcBYGypOLxJPi7IdG+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 19:20:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 19:20:04 +0000
Date: Mon, 9 Dec 2024 15:20:03 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
	linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v8 2/6] RDMA/rxe: Move resp_states definition to
 rxe_verbs.h
Message-ID: <20241209192003.GB2368570@nvidia.com>
References: <20241009015903.801987-1-matsuda-daisuke@fujitsu.com>
 <20241009015903.801987-3-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009015903.801987-3-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: BN0PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:408:eb::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 71548e91-dcc2-4d06-9f37-08dd18867c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lArx0a5JRIA+XVQTtiv3E7UgJrZe+qNZXT5Z3113Qyy0lNB+Eqd0DbRas05q?=
 =?us-ascii?Q?N7vXzNRlb4S3m7/k5flbbS+qNBROlTeiq49CnNgRW+cknPdGJBAs1HBVR7Tr?=
 =?us-ascii?Q?pErRPrxBtA+iILbeEK7q1jPwWAtDaPSN0cmKKHpqDB40YRjS2HXX2uMoVVKK?=
 =?us-ascii?Q?OxuYPh+1YZWW6eLqhG+FG02CYNYiAr04CZRQC2fBSCwBi5Lup8MFZjPO8XcN?=
 =?us-ascii?Q?Q5dp46WXSLcGZ9Yn0L04ywQb70g2SWS+G9FfRCHAO8JIG/Mc+gNRPnsle9C5?=
 =?us-ascii?Q?u1j1lE1R+y4PPsGoQt8sN9zTDBwotxPiTe8szzTccpoht5ppmiD15Uqv/iKK?=
 =?us-ascii?Q?r9gWYxNYoCCa8meUk2DzzrTKLltOqqSIhtONDCc+9G9q7lUugNA1QxcapfQU?=
 =?us-ascii?Q?vIHEbHvKLFS8xvfusPp0P77s3HsaTs0RChIEBG29GYqX3dXG/AOcFsfLrla1?=
 =?us-ascii?Q?Uoy8IQwdDjw6SUAmezgbwx/1mgAFnXGWKkK4tW8OZWg0LhJTcqklPevNzJ7F?=
 =?us-ascii?Q?YHKUz+SFb+lbAZmLKBj4fAXfeeZMnvLsP9NWf8P0V9eFUmCyI231k8t0Kf6A?=
 =?us-ascii?Q?Vl/LMD6XbcncBc5kcM+C8zH0wwr+AbHvKmmkYZNn+eZYArRe5L/bZYMFbJjl?=
 =?us-ascii?Q?F68pE2+uv0E6SXaSN/e8l0iaIDZNN4HCKKMDBnQ1pBPeg23q4v6K1uQOYRg+?=
 =?us-ascii?Q?cx8CcFg9wyeJBbGB7LEPRfzyRQ1GHUaL7i1g3Wl73yAXb4SV4gO6g+Y8sVMx?=
 =?us-ascii?Q?7xFPt03jkA1P4ODxtT4iB+Qcl1KXijyYVMNWhWRXfR+z8o7ahVjTA+ZBeWKQ?=
 =?us-ascii?Q?e+uaZv3/pnOR7FdkTefKuHn2tJiItJKJ2xAVkQSNdF8RIzZ66r2DkBO79DbN?=
 =?us-ascii?Q?bqt/huMGqRLvc9FEUQneyMjN9fSwXjf7jaL2q3sLOkTR132Uo78K+I7i10wV?=
 =?us-ascii?Q?spjsCj4gV5P0n3hfatrjAZBZ3GYYDXWHnkJnF/6Rc312Lcl6T7mLvY6fKom5?=
 =?us-ascii?Q?7ko8mXNoSvXOLdl2LMYqnRChPpMT1KIIAmEh+EbXgm/P9SGVXKOjV+n6K736?=
 =?us-ascii?Q?7cQm2iUvSSivJwSTa2Vmc1Bs4cwAbkKp0D+lOQQkGkxy1KemrwRmHhIiUcLF?=
 =?us-ascii?Q?AabjLeZTODJlCfkRTXDZJj+Ydkmn70V6wvtLZiyX/o3dCzyl6oNjNhKdnYyK?=
 =?us-ascii?Q?GnUtX8mCvTzh2O7FNrE9h/k5cSv3rLrPhxf6wp9RtFPQ4XKavPxO/bedWurs?=
 =?us-ascii?Q?NCzlwqAR+IWt+2AmyQouS+epi0f+ql+tAgTlPDQFvN2gFZz9ZfA56SNs+uIJ?=
 =?us-ascii?Q?K67NlRUNOozWq9yc52n2zFrJTmF4C1Y1DFS2R+IEk1rNKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L40/Wbositk3VnMvTlGUKTu+1E5hNRxrLjuSa7alsT1FsQO3TAT7DQUuAuG0?=
 =?us-ascii?Q?M9R7yVtSPT7QRAiAX9tEdAXZ/EXx15mbXTvrIEMqoWj/LtpTQLcb0sanfVXQ?=
 =?us-ascii?Q?iaWQqBYqH+79vj8n4rSKJ+Tx+TJ+p30kuVrylP/tqjW8NM8qzunYKxawRVRn?=
 =?us-ascii?Q?Uo8K3xi6J5G2qtfQ4eXzl9mk1zvPdPvyNCc2iijyOCmSzskVtzujbood4aWN?=
 =?us-ascii?Q?wQMvIQA7GYsTzvEisdzhK23GEla/TW2HF8iTXRx8lgxTXwb7Wkb41RHQXKzA?=
 =?us-ascii?Q?bg1ZnVFjlLElRmhPsj5pA7a5hAXV9jqBCwu1LeuuZw+AJxwW77MDkyxU7r8B?=
 =?us-ascii?Q?k7xSNOZifiJXpn6WOrhsD3nDMsJX7gpDAXQvuwHrdvyh1Zk7aU8SDi31zq/w?=
 =?us-ascii?Q?9/sRVyAFbQUD5Ca0KjBI3dQBu7oFWU7nxhp2PJ8tJvpVwvDhOnO+rbBGMssN?=
 =?us-ascii?Q?7jaX0FtLz4czJAtOKRbNAcWc2TM0V87QnPSxXYtHHYLurOSq3vIhnQNPxa4v?=
 =?us-ascii?Q?aVXYdZmPBCUTiDOSkBzODsf0rXEpV1qfsgQfkgja9hQYA1PvMskN5REphn8C?=
 =?us-ascii?Q?OCyGwtwsv+bJVqr3jMcps9SsAMo8wplokSLP2x2ieoGUu3oOer+10Z4xIOcs?=
 =?us-ascii?Q?aJcjRFD2LgjyRb0yhYPm0BQW8I3zNFZ3IaNwOjbmAslCIYp86U5sxAdi8bA5?=
 =?us-ascii?Q?kr/T1ykAWwuLTRDN+O2Xs+A+7t4NIna83fjRqxiwQGfAqHpatSPG4QRbifgw?=
 =?us-ascii?Q?wM5iLpmVPV/Wkf5LgN8oZl2VVkoCTzfZGEOznTMfvMh6itQA+epEasDj2tKS?=
 =?us-ascii?Q?KXetraJVHFOuWDQefEL0kHKoBqlg9001TFzSeVKFIUrBOviFVK4jKTdkvhdD?=
 =?us-ascii?Q?p/cOXDRNpOuK4pJ7GF7sTTEgeFfZSF0ADeICGM6VRBeD5ENx3rTOVEJWYJzg?=
 =?us-ascii?Q?Kiuo4b+/E5zECNATFvymdQaiLg3YBppklitgJxEnpsr19p5QqMoEZbLJ3pdw?=
 =?us-ascii?Q?VVMB9dbYiZY+5US1PI2g7XxlzIzNtvGI+kRuFgyGAX5BM/QLwf3a25fVKhNo?=
 =?us-ascii?Q?sXqgOmTRXQOJ/v6x4sAswmAHqMXO2KXtJuPmh1s+wyvhFJbG2cUK4KpGNFco?=
 =?us-ascii?Q?WTHNDehr5lDEd4EdhGGcc8avOoVTZWOFeOJDb6Gp8KWT+7mrK2FYqJas5B/Q?=
 =?us-ascii?Q?rDznBEOxlXCheF6kxNEpIJ6M17GHCJCyE3zjrqJLLoYF+k4H6wN3aq+NFby1?=
 =?us-ascii?Q?te8eB6norM2T9d4J+QQ7GYklRIAG8a7nmEGV0NZ2VAJB54hF2G0nben2d1gf?=
 =?us-ascii?Q?PwkBPMu0DeLHX16j/QE99tULCJTTcbTc/UV34r5e+9W/DUDCoEz2LeYvfpMZ?=
 =?us-ascii?Q?D6xiyrza1kpqfTYlQYNx90OaX1nf5xfKO2ZYGK4M664lkvW8A7fo+Bg33Ubj?=
 =?us-ascii?Q?8Au5k35Db+7ExTVaiyYszuHehlA7fnEKdY6fZ3YYGHowKYcDhFrlnDKJE/Dl?=
 =?us-ascii?Q?jN15SBxcqIg8uBSJwOapxAd7FPR94Oct65Az9Ia5TbMrXBA5sS4E2UbyeVl3?=
 =?us-ascii?Q?UuqxyMBot8lHNaB/NSzLTChX/ScwHXjPLE6TfW7a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71548e91-dcc2-4d06-9f37-08dd18867c26
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:20:04.6217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsJbRCmujLGT8Iga80XrkN3TtDXBgD80qrMH5rlh+pkZrbzXpazndg5zSf7N4k3i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581

On Wed, Oct 09, 2024 at 10:58:59AM +0900, Daisuke Matsuda wrote:
> To use the resp_states values in rxe_loc.h, it is necessary to move the
> definition to rxe_verbs.h, where other internal states of this driver are
> defined.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.h       | 37 ---------------------------
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 37 +++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 37 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

