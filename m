Return-Path: <linux-rdma+bounces-21854-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mPYEG2MFI2qpggEAu9opvQ
	(envelope-from <linux-rdma+bounces-21854-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:20:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B9D64A194
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=sieSLIgO;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21854-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21854-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F05CB305FB0F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB6838C2C3;
	Fri,  5 Jun 2026 17:14:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DCF28541A
	for <linux-rdma@vger.kernel.org>; Fri,  5 Jun 2026 17:14:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679651; cv=fail; b=K4rdu2wOWq4jBURXZ7ISnuB2FgOcntSaJgsI3St4BwdIzce6q9KVPG5fw2cOFpq5I54RGSjOxck9qUiXaxJIG8Y/pcQSEr+nHx+y0UIautYjQWzxkuTB2CBXmtj/xHO45It5eAsnDuCYHcdK82xc9N6lWVaQgBD4zFZD6gHffl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679651; c=relaxed/simple;
	bh=bqe2cR2w5L5x2sh4sNHyjmGFFGAsaHezNrUQ59lK1qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PDNhWW8KSFjzQhOnBuW/IxUVvYMvP70AG0BqbVm9qjsq7xFLEsymG76bg38NaWjxZPHx9v4gbPP5GXD1+n06DfoID2vaZnHuoWRaApnRZz4VxnD4Y1xOl4fz/Woe/sckaLKB56rn4TF8CLcljkA22J/nWU7oqHUiWFOWSK0PwdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sieSLIgO; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5dLNO4wGfHZmPlWkZs8n1jtfpacY5HfOfgIhwWDdycXz7XV9v113dnVMAb+7LcxbNZnX9WKtRsDQnMAlZW3duxs7uY0MKxUD7OiO3X30DbzZLmxPK2MkdmL8I7VmpDgrEXoSYGgUndo+lBOKCO/3eQ/Eon3PWUnsTPQmiukoDL9BZJtLIvGvpelu8XlcfGfmeddiSdzBFqMKsCh1EuGCXRfF5b8fSUQxAX6RdSHYN8jSjBNYxO7pJrFMS5vQUHNZ19SPfkplwp9xtN0KHwk7fGRi49VdonsmF0Nbwo6kfsJBqVwSfkWLGnKUlPjusv0rg783EU0b6L/ohz8wVM8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXkRjE7djSe0SMnJ0Zlcaix+IQUmKsZGyF1V4YnmYKI=;
 b=cBldJK7iiLozOs3o+5VUxiHInjTij2vN9sUROYpYrOqHsXiuns6juE5QWG8YR/4fAWCPq5Tgz+mjh+QTjOGlcHTcLd7C1l9UNgoTirJzftZwenrTi6GZLhP/OE8+BB0SlBzU+NRFiIA+LLne5IO/s0n/vKmQgsAOAeWgOdS32oQp7WTJQL/DWJXlDEwklVqxCy1uNLq+9CjpuLsyNoEqORHGX7VaWXfZF6npYVY0ESXfLxCOq3v+QKh8hI2XocG3Z+nXPoOLPyvFOS8sm/pAVW0m5jMa7aSnqg9E0gu5wYP4yZTnv18qx/ZEqRZ9ePzaFmkcFTYjCcQQmcN36eRtRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXkRjE7djSe0SMnJ0Zlcaix+IQUmKsZGyF1V4YnmYKI=;
 b=sieSLIgOTO6MQ5qspECgQIoFUaR/NZkXz5wfa21nHAEbpUI+3epneW6Yso+vBXtSPm8AVstP8quRsvPolhNzJ1DFSZr/SiTvhiDbEOfRz6vWCex9+RQTBalt/WeONIZuVpKgdzkamjJFwA5CBDqnjmeiCMEUxTebloXDQumUTh+Kcy2yDLuikzUijVnKRIlkVlVlV8HRhH00bY8CfiKXLujkjlAyB5Xnl7Lsl5WbV4cEHLe6OsNFDHmepWwtgNuB6OIG4kxfrjMsbtNarj7CbCViX3UDq2FZipavqg+09L5NlQfGbIJSQOoXpp7wOaNnVRyUWou7XWk+1VJaL7fFjw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 17:14:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 17:14:06 +0000
Date: Fri, 5 Jun 2026 14:14:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Initialize iwmr->access during MR
 registration
Message-ID: <20260605171405.GB2771195@nvidia.com>
References: <20260604154104.4035581-1-jmoroni@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604154104.4035581-1-jmoroni@google.com>
X-ClientProxiedBy: YT4PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7920e3-e6ce-4d38-15a3-08dec325d9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	cQxY0jMBMIzNloa1gfa0HzH62nFnZuCUJTS61i/nDi/x45CFHS7coxyv49w3LYAjhcjuUHzchPnXIVj8GtUZ0RTPvvba4ltrZAtJyrw21gC++L0hE2S1JhXZwftfOHY8RW/XB2pd09kqAxgfyb0RcUiHvkdsQw2L7nDeuENOYsKDK21BTgy1thcFA/S5LX252WinNcV0zgGN6OxjNLN1+1OpHl+tYHgvpaaMWXnu2mm+qpFXtBO84RKvXSRfsQ3QqccupceRCqMjqJseqEIVFPdP8LSoiUZ4a1nKeuU6okbu57nOM2mSzvDNvAGHBbIvDR8bYXwdxm+WjvOxzb7yHwlKptXp8xN/ZMA6MbEiJk3wt4pLYT8sdBQ4ATIe9bSq9qpT76qLKK+G8KQdLkUeIBRtRCW1vxDoywwt3l4lXdaaTKpUjSvwVemQ5QMvcMVZgzbBwVeqDI4N6a6kWBS9zq+7V0La+HikmtzBqLD7dPD+7gD6xY0Yk1ZWwnDqVnndCyaO33LSXVCW4JBxYUC1egyZB+55BolYYgEQG9SNyofO2Lr9AfmsU3b+oVz5DUeOcD3wH0/gNx8XIVfBOnldG7l87IF/a7KJ6j4cMRrH3Ry1Y0VTZGCngJdBFahlmWEeiVirde/m/33tS4PVRj+sJpIyL5j0SaJBWaT/e5XvXIHocGzS4ZL5WswkLR9npK25
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rkrX3kb7zlLEBnvmKiMNGRF4nUFe3wxTFhHt9LZFv+w26rLC3mRthtVWjnYy?=
 =?us-ascii?Q?OpJQi6XyLBCZpBUXt83KHQtxL0Xqoolr6cB2C8+tCsMULcN7ic8JUixQkPWs?=
 =?us-ascii?Q?hg0MMzTcFe189iruwn5v6V13q4v5eBwucEBRbrL5kmhOTX2A2Qe3raZymCs8?=
 =?us-ascii?Q?tRfaJ7HKpC6ZLdZMpl5F2lcgFh7Gdb1VzZeEX7hKfroFf3mTURpxFUFnaQkj?=
 =?us-ascii?Q?b/7PCMA0ji3UHb6nnbYilMOOGS3TRntsYhq5+X64Cwl8EC5SfBMurlMy9i5U?=
 =?us-ascii?Q?KbtSjfCmuRMjwpJ8/wH0/ikQtxMpwkNsfcvGwsHbsau3nIx6PstRlI2ZyheQ?=
 =?us-ascii?Q?Z7cBT6O6n6G7LO2D1nREZrnXGX+po+ZevS/IhYCQy4u95rgDIugoMexJsakw?=
 =?us-ascii?Q?DO0Ww8Hsbeki/COPxKkD/hq3qimNg2OC9DFOagfFtLby2FxjWOQXQkd+rQ4X?=
 =?us-ascii?Q?faHCH40S+warG+D/fP9yYpJV7C3We+9XpYn9IC0tIg3JGrSFjM0YBpLul2BN?=
 =?us-ascii?Q?50DRYS+5bG5CWeXBZ8r5S66xhLZK536N7MYBMAKNjj8wLue6mg54VrgL9C68?=
 =?us-ascii?Q?A3P07O0reFUnyEptkIwaCtTcLJ6VHtwussAfXqPZzzI7ZuuPtlGVGb4QNWJc?=
 =?us-ascii?Q?cevj12JwzuhY/ZCwneJAUp7x7SOj8i+Pt2uQXhf5mL9pGGN/pBuSadhibJwQ?=
 =?us-ascii?Q?002H+5eAQtoZGy/TEhUwypZtWq0TpbmSNbakk/9BgAqjWTGL7nqcATXQK3cw?=
 =?us-ascii?Q?Wq51+up1bIzOqjpCkpgueAOTqEVSs2CZ5iEuv6Gv6/nhOJO4yV/tnCB81jFT?=
 =?us-ascii?Q?yPdJEI23yPZHl3vcAKXhcE8QizbBSwFP/2717x71vJ8XDtNAxL4uOqC28KDY?=
 =?us-ascii?Q?moG4WojgJyNoqtV6HwacTjvdCYJbk0obCXYgU9R/Rv30gTaRaT9Z/Tcg1s0N?=
 =?us-ascii?Q?eHcT56SaVq4MI0PR19E0dUgPLz+n7tnsMwuuoor4emH5EknNZinkn9w+Nzlk?=
 =?us-ascii?Q?bd1VWZBWF5kI6wO4sQRtbGDoBlsugwz3eK7k6yRSnmqwb0/DFG3YvxBUfBGm?=
 =?us-ascii?Q?2684GlYygJD4VZGveY5VwW78ujWV9xziu4CN48kZGkPWona4KCg0Hph6OSh2?=
 =?us-ascii?Q?r7Dp38GjLoBo7M29kYxjLI531Y8yIpt3zPyEZKv8zOijjTHrjThVCZkFl6fD?=
 =?us-ascii?Q?M0BqvmJ7T0N3uD0AdIAv+NNi5xybHebil8rsfxV+ED0K2RvQxqPyFUrXlx44?=
 =?us-ascii?Q?FgCclVvXY3M3mIfqNTBf0fmnIOtDMNBfoTkQfFUQ4foLLsqhFxlUMc5PnDOg?=
 =?us-ascii?Q?0T/rTbXLWZiNKQI3V4EYgoT6E39yrPMZhTaHmnlLUXcsErkWp9bs9yWbyirD?=
 =?us-ascii?Q?YODw9s8T/nO6HcablKUn7CkJYzhK1jyAqTulaQFFjhIr2FeTyvD8GWTOs44b?=
 =?us-ascii?Q?mZQaFQ+t1Z0NR4Os9hB7QoM9xVwA3y6XtXP0kBxFmlsx7CdoGtsLCDBSvUK1?=
 =?us-ascii?Q?3HS8UEsruGUeBhXkZOAwK574+iSVZkTnYtVaCoqqL6YJEdrrXz9qzs7WTLy4?=
 =?us-ascii?Q?uS4Ta4kCZrR/lBp6JDU+/SC4Hn/5NlXgmzUOFpPTmc/UXGj1VHNkBLDFLBMB?=
 =?us-ascii?Q?qxfITh9r0NBlBDav40IIuT6C+s4cRKXIO3dgncKa53paw7LYKfANlvSDMlwa?=
 =?us-ascii?Q?ZJp8qDodvjciWf9rP98oAo2uTfKGpTlU/yjxBsg9vsaNB0mE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7920e3-e6ce-4d38-15a3-08dec325d9a1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 17:14:06.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcSDD6FEPzG631/f4tgtta7K0P2YPQCM0lLbQRerwb4iQTn/uu0pTe/Whi3Qzxe+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21854-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:tatyana.e.nikolova@intel.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:mid,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0B9D64A194

On Thu, Jun 04, 2026 at 03:41:04PM +0000, Jacob Moroni wrote:
> Initialize iwmr->access during initial user mem registration so
> that it contains a valid value during a subsequent rereg_mr.
> 
> Otherwise, a rereg_mr that doesn't set IB_MR_REREG_ACCESS (for
> example, one that only changes the PD) ends up clearing the
> access flags in HW since iwmr->access is zero-initialized, which
> is not intended.
> 
> Fixes: 5ac388db27c4 ("RDMA/irdma: Add support to re-register a memory region")
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next

Still more preexisting Sashiko issues:

https://sashiko.dev/#/patchset/20260604154104.4035581-1-jmoroni%40google.com

This one sounds bad:

 This is a pre-existing issue, but could this sequence allow arbitrary
 physical memory access when an MR re-registration fails?

Sigh, rereg_mr is a trainwreck in every driver.

I fixed mlx5 a long time ago, there is a new flow now for rereg where
the driver can create a new mr from scratch and return that. irdma
should do that for any destructive change like replacing the
umem. Otherwise it is impossible to get the error semantics correct.

Jason

