Return-Path: <linux-rdma+bounces-21211-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e8NuCVpbE2pa/AYAu9opvQ
	(envelope-from <linux-rdma+bounces-21211-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 22:11:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5A15C4155
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 22:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC1293001456
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E812F31D757;
	Sun, 24 May 2026 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sR3oJkiR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D330149F
	for <linux-rdma@vger.kernel.org>; Sun, 24 May 2026 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779653462; cv=fail; b=QxeDoDK9V17htWl+Zg6UoAzSBskunuQucM8qEWlwdhN2EZE8BgMpIoJ7N2C0ISpaYXxOevHnmu4CIAc/bF3bqgV/9ZRvl9smkb3xLGdO9AsaNwMigG+jhlHpKITugWdIk/xp7GbvhYj/azIg8FNEa2Qw7ZWbZDK5QFrpkAGsAQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779653462; c=relaxed/simple;
	bh=f5PX785Hmz66CVIYEDydIubE89Nx5Joh+ygNo07nHSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hvqJutJ2pIWzkI5QrHEj3kg55sE/cWxzp7aOatGlXMlgSsCylQwvtcHl3UatdJgcuAkgYev0fyLSA4HgvL4dlAS/ZnlpIrbv2wDVXvoPW9VDMtUmzPHi+So8CQBU8yHmwm+aaClqwH4E5QdqKl9PtrRCtycPuEA9RZsJjNqUW0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sR3oJkiR; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErJt11zLXGlXTsR6ITbf539mkK2cDjIaMGIYmG0zVvGqv/9F7YyI9S8F8cdTGi5MOQqL+3fJCJe9X6Eh5vm3js+OIubnJN51Ei+r8mT6wQK1xcDGHpf/T8baeQNvgmYz3meQiOP35oLrVRyzDhBX1e2XMHtp7l3ZRQexDt1uNloCrZTDfyaep6UjgKpOhykYg+e6mLfJ4SgCLOH0kTGtReaFpUH3XvJAQlk3WfmhUQqC9sH4nxOgoUxorvVx5rG9hXg3JAEA8x9NnK2WSi937Fur+wCCqVNzmB5lT+4D8XVzU+06ansXp8haBL1ss0Q3vovci4HZzQ1ChM8CEKC6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ei8nTT4Tf7MCeGSEFJHUBXzTFYMmMf/zfM16AN8bbA=;
 b=jtOUBt3noqc6r5eK9Hhioys4Yc/B1GU7dzobGL3VzoMdp7Vjnh1s/XY+DPdjOuDcMVwvLRRmIpiDSu9R4AXjTv3EozbvGI+hIcVR4U/RCUKD9ZiYrrOKqj1EoJz/KIe6HA3UCppASy8oVT+GtVv23GDW2EzYPcparfihApA8/urx4jmcDwIwxLwtZ6xD+1GCTvGMRc33xUPG8q+oI+BGvJPyl5rzDKRDsGk1lynYWMiUJKBZ6JXFOi3eVYiRShU2OA0eRgnq0SdE+FIQGgX/O0khBszeuEDmlsbjhhcRIOsaKRtf+cHbC9cwqlpc5OL9GPNxXzTcYKUD8TmmvKZ7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ei8nTT4Tf7MCeGSEFJHUBXzTFYMmMf/zfM16AN8bbA=;
 b=sR3oJkiRHqyEFeojRd0MoT4bRNrMVRz8EQsWwQHnJVW1EwcfUyhTKNYDe205aAC/rTW78kTXee+UOhXtiluvkjugt9GUWxKfihJ0yDIuvQNeSM/EWgz2jT7AYdftK7fNuvchnTl6fOD7nNdWewiEAyeWqhMMf6xC15ao5nqraLKvWEDg8hRJOZrSZTowY4LoHq2eTveRo7EqrBRkVIee17e0Tk9TQ18/lPbnLjEE2ZPp/0gMX04zYJ0xC1cJ6MuGTTIOLIHIkrHeU5xdYSd/BaN8LDwRfTWGMHlzUm/c+T3uy0s541voneZIiw23jYcgYYDOTxlcXtymuEg3L+GJeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW5PR12MB5623.namprd12.prod.outlook.com (2603:10b6:303:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 20:10:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 20:10:57 +0000
Date: Sun, 24 May 2026 17:10:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v7 0/9] RDMA/bnxt_re: Support QP uapi extensions
Message-ID: <20260524201056.GA2094414@nvidia.com>
References: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
X-ClientProxiedBy: IA1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW5PR12MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f766714-b9cb-4bef-8d2b-08deb9d09112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	4LbCk6vUzKs7PDuCNw0n2UTT4ZX2R4GM36bxZhaIv3r3zi/czWYKDOheHMHz+DPc/ibOO1FiaMji7t1SbtySlA56LfjOMA4765ECjQksXcbUe59kEuuXADf4U6Qtgry8o1s11MrQ+j44rVzi8rClSITKOhMYFm5vrGS6P9l3VvOJx+GBYlovVCPANflgJ0uzvpgQpVd0M7818h5anVRoMuUcab9+32VWOKs70inxesvrnLVsUT9Y1j/+4dOuAede2Ig7r2EBfl8xSlsa2ZGGM1CiVlMKm0QZaQ6Ozm/wZ4QJImGMDQu9b1uDZOd0Tdf4LSP3Iy7iN/8MrqgzmSEA9NvdjIDiGods0sj9PS15zoCndx9bvlXpaarr6ZMPDQOThthVk+VRvz+PCwLropf8hyC3BgFREjSe59wQ5wVgCp3ZVxoxH8I8HxcI0TlE5/suP1RJW1pRoCAigzEnJPe4nHFP/fuCyqj76IVNmlJb1/bvNKKWjzlo0HN6+dl6D3REqRYF1/tu0o8zhok5veLWsL+4p11fWVffmBPKOKbruAWFFLMeyGM8X/4Po6LBV/3+nlY0RRh/sCDgLN1V9wfMCumBNlJkY6YbM0gKnoiOaPjKY2kL6usrdNFjiOvR/mFFDYAq40m6W6Zhzc93emU6a1LOI4D/Nd080Pp14xxZoPctKS91SkHWj7z4g1wBbhM3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lKeHrKFNjN9Xgo0QyGvYGv7uKoqj5URRM2iJloxh0K236Lyp5HAICe2ufXQj?=
 =?us-ascii?Q?CSohWeYUUuatrZ7d1scouqRDuUBINmkc2o2v/AgeelM9hVaRY3hHb0FXf1vW?=
 =?us-ascii?Q?hlG2cEEkMw7jDRcX8Ftcyaud6CcsksxdJ0omi7ZrKF6+5GaiNySRvshV/PCU?=
 =?us-ascii?Q?r1V+TR24ThjjoMJ6jrLcplcdeXa5T2jgrUA37a6iAODpN5uXuQuNvtfAY4of?=
 =?us-ascii?Q?X93VlHipIhnnrpO9U8t/ekM3sxM2I/hHiqEX9GYlNAtd+DGds/A7fIz9PpAf?=
 =?us-ascii?Q?PfTkxYPp7oGWq8nyPcq6rDEFJRmVDu8u2y2y3fQuzPklBiraUSxFiG0eC1XE?=
 =?us-ascii?Q?o34X5vQ7dZs2TGjT0czCgGfy/CxMheDk1perZzGyrX6rBXKbP1oNMpFOMKKY?=
 =?us-ascii?Q?dH//Zh7EpPaJcrHXFkVd1xUGE4sbcDkV1yE0sMgyucsiVYzzFkaByo6Twp4a?=
 =?us-ascii?Q?wYPYGxISdkdv4brZLvCc1gBhI5V3NNTNhTY6csDPTjGO2dTqeWhz+E5+vIhC?=
 =?us-ascii?Q?tXz/qCI7bIaomJq6u6rheuaveQSPDJ9P1Eo2TyGriQfwa0uh5C77jZMx9Y+i?=
 =?us-ascii?Q?N/JGyWDh2+Yu2fZPlYfrkz2ui82UBWJ8iJ7sqj+x3RGb/q4krSbzc2Us9qaW?=
 =?us-ascii?Q?PfZqFTedhKpVkvRebuYEhqXq/7jf2qjahI+XvGa+Woh30MOx+IO105ud/kbI?=
 =?us-ascii?Q?piZODKqHSEgfbD4omo5uueHRCI/ebhR+QGG3iZ+zou2SOvquSg5C7ap8IP63?=
 =?us-ascii?Q?aUrMFsX1w+q3YYp0G8Xa+cUGiyrQHU1nKUnT8aHx4dmOB1ZxsHDo1pl1fCig?=
 =?us-ascii?Q?jvHZCXJABbORyaTcmpVVMXBVKB0kYZIdXxPRKpkTyzLfUOr8MNm1TyxhBWA3?=
 =?us-ascii?Q?7baks+vl2oVjvLz3GmpJNy9Q07CT2hjQxrrCjjz6GTkZbFObnEGnod9/ePMS?=
 =?us-ascii?Q?aIi9NdMNB2cCDbKs6YWcs7WFvLCixj69dctrvBaKYPpU2/Et217N+FOss7EY?=
 =?us-ascii?Q?4c4ICv5HxmDoCvrbcS7XyS0nMSlFoAaX9tQq4hiP9eIQllDOxdoMPG7nRXZ2?=
 =?us-ascii?Q?3YrFpNrlrGhZHbFjJMozlUarmCHmKlTXWco536SqP1Hw8ZM7kpPywfTaX6SC?=
 =?us-ascii?Q?4cjUTq9HyHs4WNFLkFgaYuSxgL6WlsZwWWuqquC89ruuCG9cIctzSzdHVwv+?=
 =?us-ascii?Q?gr+8Q0LZaRBDxQcHPPhDZKyxf16rFpXv7wikOCgqZtnzJCtxJ4DMrbD/6pOv?=
 =?us-ascii?Q?4rT4+ga9bJxd1+nTMcE/YwtYxQ81rM9k5tkYCYhoAsTRbCdzoX3UsxBz9hg2?=
 =?us-ascii?Q?vJITsydaE71RGQjJMu2D0Cin5smMp3wdZma8G0bZWyN6tZszcL7hFOo+9Chu?=
 =?us-ascii?Q?2+rtbF0uDiW7hNAseLY8sZw5Jirw35VVn5BlffVAltpX/KuUcBUxf0nuMDiL?=
 =?us-ascii?Q?Xp29ZLcnxb2r6dKnByPEOMEBbmiWm5w9BAlYCTsjWoAtpP7Ii9Az6Vo7w1+G?=
 =?us-ascii?Q?pZdEOk92vPxz8JbgvPXJoKwt8tVAfXRk43b285TBW//HT3rZhwz5hxIZMSsJ?=
 =?us-ascii?Q?CuLQf5oXBa2mqRfBuWTQBhU4EaRnlJs9X0WxTq6P1SN+mZHYTicCMfqNfmjh?=
 =?us-ascii?Q?QAjOzzWJfhBl3nUwtnpADd5Fs8+g7Jjwh87he7gfwPV+hgW5UU+PlrkDSIfB?=
 =?us-ascii?Q?5cKAH9yAHKakCbbfkHzJnAkkKURP7Gs6WmmK55/zk+eB/284?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f766714-b9cb-4bef-8d2b-08deb9d09112
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 20:10:57.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ajex0hEvBTCKMdz1lc2k2LNux6lNwhcnwAAAwZUQHGbfk2Ou5FUTT0FsNue0CDC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5623
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21211-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9D5A15C4155
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 08:30:32PM +0530, Sriharsha Basavapatna wrote:

> Sriharsha Basavapatna (9):
>   RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
>   RDMA/bnxt_re: Update rq depth for app allocated QPs
>   RDMA/bnxt_re: Update sq depth for app allocated QPs
>   RDMA/bnxt_re: Update msn table size for app allocated QPs
>   RDMA/bnxt_re: Update hwq depth for app allocated QPs
>   RDMA/bnxt_re: Enhance dbr usecnt logic in doorbell uapis
>   RDMA/bnxt_re: Enhance dpi lifecycle logic in doorbell uapis
>   RDMA/bnxt_re: Support doorbells for app allocated QPs
>   RDMA/bnxt_re: Enable app allocated QPs

Applied to for-next, thanks

Jason

