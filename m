Return-Path: <linux-rdma+bounces-19765-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EEJBk218mmUtgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19765-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:50:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B98649C19D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 03:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BCD53011058
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 01:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073CE224B04;
	Thu, 30 Apr 2026 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gm1VOo3p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679E13A3F7
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777513768; cv=fail; b=nk+GF8ae2KlU2JjUXIWQeWg7tK0uCbFP8+5j5/SmSDlOBXxhzf9MCmhyBLPJ8qMknbC2EVqSyVuBLjC6rkzkmyboRzFDJ9m23R0C50UTf+R+sQWkYuIwuAo3CkaQW6OfNk/PrzdAehsETObj8D5upTT2fJgDXwy7CyuCKJpo0yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777513768; c=relaxed/simple;
	bh=U07nDrw+Ma2c+JVgcyk8J/iyieB8tVmDWT1VC0mDRWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rTZA/CBn2/v2EPZ/hue9gLBlwRUcLloOGfT/F/Djf1nnxG6fW3gsqga40I9+fuSjVaQacTyI65+PzjfSQaF/2SnrE3b4DXY1i1PzAnHsqXAJEkj/qAaE5V0QsExRkT50NJ6COGlePE5B6qGutGmuF7OGJHxwxUekGnCVOprgP+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gm1VOo3p; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mREwfKuZZwJI5wK30hxINy9Ehf3z0E9HACxJvYSzECU6rUFgbB52pO+h+SUpqJEp1ozUvcaIqQ+E+TRM8JkTPO1R9V1GXbjCIb9wfIRBgMBRL/tWzxwvaXn0eEKl0nG442a+nShd6raZi+I9cS4616yvML/++QL5KY5on0oNXlYEYK0BgCTBh0WIb8Le/CPte4N9tuVEOMRbwZuNui7bYEYiCpLETOY1q9REPxvR/bwoCjpWpKch6Jm4VlEbxpUkSkiqzLeAxPwK6TSnvUTu1SX0lElPIM9x165HT2rx5j3bGsdEbES1zKogNKJJm3giec/XiwDH1uZRse+d52TJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U07nDrw+Ma2c+JVgcyk8J/iyieB8tVmDWT1VC0mDRWo=;
 b=Q043pheKl+YbnL0kLTJijzuty/n/UYb6Hv0mmOA3cyQW+HWBRtITP5y2vMboHuw0jkfBNisLPJnh1D72toMMuZrrOIp24GRrStGDiNFHo/8YUQrb2uhQDmSL3QdPvCvIcRjvftYHD4n//6RBv0LlWUYy8geZGvAuWVqaWT/dgyQRgJDiloTkeVpXohHkIYcJpit4zrYqUw9jUXZ0kFqJHVk1eQSBrfmNpk+7vGctL+4+4rkD3lIu9jCucu1/mDsEqmbHR5VtFUVzXnldSsg5iqNk3Q7gLeuccd1nmyZQFM6Sd3yIRcd5Rly5UaOtBNHRvlPcDQX/HtBuB83rWYrVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U07nDrw+Ma2c+JVgcyk8J/iyieB8tVmDWT1VC0mDRWo=;
 b=gm1VOo3pk+QNI/8kD3tdAN46HUSAJRBgUA4O5iUzbvKwMcpnNGnrP1IUy8Sx598MMdams50cQ5ukMo8DPMMlGGul2kncpvRJ3uqp1MuaU3GGugHD6Isq/VuYCAaA46mFm/PSF+Y5KUi4+h6JLnEiuRkR29hy043pVRDNNvUpGbFAqx5WTu5Wo68RW0Ua1H7MgNXN2sT7avEXtuA7oA9C+VWxtIqMcR5IBl4J6IeIDquwMbi1AdROf1YM5x6upCxY4CfIkGlitP8CLeFDqY34HbYjzXZowVBLkSUFsjq7FXpe6j4hbDwUFkB3IchCboX45uiRWwqoNDTdW5HCHA9+tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 01:49:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Thu, 30 Apr 2026
 01:49:24 +0000
Date: Wed, 29 Apr 2026 22:49:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Doug Ledford <doug.ledford@hpe.com>
Cc: Michael Margolin <mrgolin@amazon.com>, leon@kernel.org,
	linux-rdma@vger.kernel.org, sleybo@amazon.com, matua@amazon.com,
	gal.pressman@linux.dev, Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next v2 1/5] RDMA/core: Add Completion Counters
 support
Message-ID: <20260430014922.GF3225388@nvidia.com>
References: <20260416212327.18191-1-mrgolin@amazon.com>
 <20260416212327.18191-2-mrgolin@amazon.com>
 <2bfaa4cc-8e4f-43ad-a483-36ac1ae3caea@hpe.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bfaa4cc-8e4f-43ad-a483-36ac1ae3caea@hpe.com>
X-ClientProxiedBy: SJ0PR05CA0134.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b42e34-8172-4712-6414-08dea65ab4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	a8FiG/D6r1VvFV10K/NWR06aqLqgIQdBdu4dJBUTVoyu2fG60wNLce1lVIou6SbaM6QU2W+AJVsXUkI0TxrjjFutZFIoc+vxerkKAaQaK8xvGyIEPd/vL83VfqVSAVDKnogX38xBiwYp7TZCiL7QMC8kOC66LiAFtLJ8UeQzAnVD+l+YLqkb1xQVAEf1XUn4U3Kf0P0w57Iby3X2RFC+jYen+Rd2ZjTPJWVUuNqtMgaTY6FItTjAVima9TqrFM3UldgL/YW5O8lXsE1vabmtNTMsayRjP2AatdI+Gv8q42EwbkKZd7lvZmvTuR6xkqR/iuOmnZYeBhQxWOlz+yfNDQK/aPLNgvjPgTnd4gYvh35ygynBvJBU1YFERViUMMfamMED0AefD7YKfyUT6WxXr6X3J528cvHyYbejDXayVnNhO2rYtltdVcBxGkWlNzs/M1Qdk8zwhCW+0o3+MVoZ32OXI+F3pFIRTJh+EnLNZIjfHmFnBNJn1L5N9ZSz3NZXOIdenE12bzkb/64KvSRYZG/I2wndWnmUTR1pkDXhLzrDbeUEaWFxWp6vvs6HQItuHEAi316ZknUzc0iQ9B2KRelLs7yGUAzKmgnzie06GbA4VKShxaI+yc6OmA48H+nlgyM2D674Y0NAmrvs22xwnURrL9ZyvDUu0LcmeoyMVDFBHr8d6ZBSe4PFlJIXhs6Z5lbZbrgka74p0mRzAZaO9+tzZLF4jI2yBP48nMTBIPI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1giDdKkQFUgowHbQxwwSPB3hV4OgDFt8UBMn9toANn2pMtKm+NaMRnR/4zam?=
 =?us-ascii?Q?gFKSbujaoh6oekuFHqBsyqw4QNaRl4tf6u7SdLTiuq9S+RB8oPlMhiBaySaJ?=
 =?us-ascii?Q?jY7OjZNvQtmAIjSgfsVN2dxqYZ5YGqHZ8iHLrhxhHYmgMrbCWmID6ql8XEBm?=
 =?us-ascii?Q?8mM99KFGqb22PPTG+8i2mqa/XzZ9nABawdEx5G0FUv9n+uFc2HL5pmHoNgG2?=
 =?us-ascii?Q?4GlggNVoUgKZ4oT1lTzKzmJgQisUDOj+5Haav1ojPHCyT+zDqfa6Te0oOgYx?=
 =?us-ascii?Q?9FYvImqutRJheUwUwWZSqxA7gfq4pipM+RYX13dHmk05jEDj4KZJigz5fB52?=
 =?us-ascii?Q?cNbORfUSRJ3Am9muvVs+c8/IrPRp9cg5N9RgvYb5NYd3CuxmBImfQ+Fw2kaj?=
 =?us-ascii?Q?qnfKdS5S0qGgyAYYmszrZRQFZTSMxbc1ElaSFCeyQkF4fOoUlHPczB1QPQzF?=
 =?us-ascii?Q?X1LAQRlNpkloQv5daFo1dM+ce6r8O+S2gnjntHDbzr9Rp9jUQciVnIIdnPnJ?=
 =?us-ascii?Q?mcLVnfH8O4XvjMdkuHSHf+XRW7IEjZri+JMBGLIEoV1Qbj1cVmi5O+6HVFdn?=
 =?us-ascii?Q?JKaBYOblHNFHMIo0dYcupp0ZsZcpIAlhdl4PoTYFkfqqqeoJvKnWeIKWIa0L?=
 =?us-ascii?Q?7iBbxY/vGA1smp2rUBhl0PvNCkW1A7doNL9ujKUqTg57dDeMrn1RNny4/MvU?=
 =?us-ascii?Q?Th9KpjA5c5thLUO16aPH9EjX501RoWJRLboiJQknoCLzvXlos5dwWfKQJMiA?=
 =?us-ascii?Q?MoMXyXav8wUFtf0H7U8VZICKETIemAkr6VLADHYmvAIvz/AsdsJ+SAQo2AHH?=
 =?us-ascii?Q?v+NEUWvWT9KbzSbSS+seebUcMcow7K/fcqhVrUf0VCnsT9GTcmIPA5g/zUz8?=
 =?us-ascii?Q?6maD41u3grO9F5CWKzEtrEqISo2C6Ecg3OGycB2pFhB2HMOItK/9O1xuTgTc?=
 =?us-ascii?Q?I3eMryp7Otu+nRjBFL/ZSOWExK8OfIS6QW+3iggUGmSAss2raiRmndonhSEh?=
 =?us-ascii?Q?OxNd9JR21381h4T/e0lldvspDkLn5DpLjxjzgq1NpMBs7nLy9GUoQ+0EIUiZ?=
 =?us-ascii?Q?sbv8uBqKVh+ygC6hi+TdgLG7opA2zCSyheya+Czr2TqKj/phz731rGjX329u?=
 =?us-ascii?Q?JK9lFH6crdi3pr24neADOuI2xkqMZlp6PLjVQRB5sGJDOtNYTSzxtk6Y6elW?=
 =?us-ascii?Q?kovgay3y6tDBO7sqET/f1o35pnbudYhDv9R43VNi6xV/yGfiYEwcuP65fIn+?=
 =?us-ascii?Q?N6OKdZ9/4JOtuApVPgKSruab1olZubj9b3aP67Y9VVv0lKGhx4pofU79CjnB?=
 =?us-ascii?Q?pyq+5nZEkdV08Z+hm4R3esTvMYoKyavuh5LNiXS8L0KfZFej1Zewnf9tnXWx?=
 =?us-ascii?Q?bMZ/Fin0thrrUvcj7jnPxQ2zhjjGLgzETKMl+i2vI1SK+eAo/bsGmAPFiVcr?=
 =?us-ascii?Q?Q9HWeRyyw1M/h+yQyVlzV23irdbCrOY9ZpdisVSaHpa6VUMnMdDqMmsaLkgR?=
 =?us-ascii?Q?rcQ3Sh2WI1rWFIsyOgqVJGqOlztKuNz4lhzN6CWkZSA7iFAUqMiljOjFvTup?=
 =?us-ascii?Q?TylBI+ulVgYAN/AUP7Cj3MoaQfgWlxqdAZcfiHdJr+anIoWPboWcZROR9AVB?=
 =?us-ascii?Q?I0i4QBPuM6Jl0GJ/+EkBzD8vBH0yQ3mcrDuYwBKSiPz2ZD91Z3bIaC6Dp3Xd?=
 =?us-ascii?Q?wEuEzLLfarOOaWWmViThfwHsx1mEJAj4t0RQVQmPZXSpyU1b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b42e34-8172-4712-6414-08dea65ab4b9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 01:49:24.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ta21uHRPTML+lqh2rGT6tOJ4cZ9q5BHlbPnX6QhHXEM1mUdImS+Gof7MfotGdDU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465
X-Rspamd-Queue-Id: 8B98649C19D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19765-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]

On Wed, Apr 29, 2026 at 06:50:54PM -0600, Doug Ledford wrote:
> 1) Make qp attachment optional
> 2) Extend create verb to differentiate between on-card counter with umem
> target and in-umem counter
> 3) Extend create verb to pass in optional trigger or wait capability to
> perform limited umem updates based upon passed in option
> 4) Modify read operation so that it can either return the value directly or
> just trigger an async update of a buffer backed counter (especially useful
> if the umem counter is on a GPU, is set for a triggered update, and you just
> want to force an immediate async update)

After all that is it still a "completion" counter? It seems like it is
counting something else than a shortcut to polling a CQ?

Jason

