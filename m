Return-Path: <linux-rdma+bounces-1450-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF3387CE1E
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 14:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD451F2285C
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5171A28DCF;
	Fri, 15 Mar 2024 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvaLr8W6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33525760;
	Fri, 15 Mar 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710509552; cv=fail; b=UUOmh+XI7k+LW2dz6z8vqzYhHrEnj5vkPjKkcN7UOnSlbomGqH4Zdm03tm3U8GMwVP0FL/1YiKclFX8QZfHp6l718j6tB/HZagK02Cw998e8o07ChBzTSE5HGFWRxl3CoGkryiQ7ihVaWQE5p88hAFqrIqA11TmeY4taHKqcQEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710509552; c=relaxed/simple;
	bh=CEjfgR3PIvhyADeYEr9OhVz49Og/H79MobK1KIHjbWM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=otNy4KyY99PYKcxwlyWBJKN38N3+JaTz+WRTBnginjHzNIKlRjwfJO4v76cGV9NpnF1/jCpaMHjWkVdz1GoZijcGrGxKi0GGi2dypkADO7BUjQrH2RJHLOveYlULTM7Zy9ehWaipaNDibcpONetO9oQa9HCodC0zxXOyNy80iYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvaLr8W6; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710509550; x=1742045550;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CEjfgR3PIvhyADeYEr9OhVz49Og/H79MobK1KIHjbWM=;
  b=bvaLr8W6WEFrBF8lMpIdKnEcQNeomebevDAyLrMyzrGIdkla2KcFRfm+
   cSS3Z+LTm/CJzDPEuSboEXZIQhuRIzxJE7pSn9GahtTVUWoDTqiu5QZrd
   Wg3aE74wnLSHRxpwEbpj0MuEHNk7dsTjxbwqVqgeQw22GTkhIP0ioLx1/
   Mc5ZSWMXXJaQZ2V79t9KDcdGkB3n5JrEZ5ol+ZbJcNADIsxJczbNmJByj
   9ugXfswc5IsYqAQfIp4Si2MgKe06yeqvhA65VaCuKUq+XBto662i9lIU+
   Rxd/iezQtbYGDfmsRPtrMwixeGiaOQQ8uiKQ2j191gJlEwSFhGwuEgYWa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="27852521"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="27852521"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 06:32:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="17272361"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 06:32:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 06:32:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 06:32:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 06:32:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 06:32:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVxBjfEbK9Xm7d2rWNz6KggivyXZchKJLBYy2AxslTsJWpcTRR3ByYOjY7VblxM4tRBpc45QdeW75T1RC9fCoB8/OYgRz2hD2tcRO9ydfR0lchimck6h267OxYZLH9C5nzVDznO1C8Bi5A5++zgkvN2aFo8yOq9C5sJLHwIiOwUONa+1QSJdb67LJDeQFt+Uh5+bO05L1wvrkpHi0Xivpv7edtlApRbUNArQlGNMdptE6eOcIVEpODIpE87fYQBGJXrNRfN+BVEeY/38jxS+vF0zYpGi9TpgjyoXBvjv02w5tXEXclOoBFPynTJwA2sFW4pNJUMrMnqY8E4pOigzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/65AOV0+EJ8mxuqpJhE9yK4tknHkaGfdZP0S/ukUQo=;
 b=fFzANUfHwccc97AooOJ845ZgF/H1PmpUl8c4UkFjkARMsg/s7+PNeGQPl+WxL5Bt9nj2fmzVNC+K2WAbVJbBUliPST9TSr1qXd5dTrPQcFJUwPocdpveU5cxQquRNBTyziVuAZEGlK7HkrO2VFaJh3d3v+7ybeqX16duYHpeWboLLdf+9CHkvXF3paCll/DkxUs5Xfe+O1pnWHiUygMb0prb5Do1KcXoE3mf6rB6e2xix/1zbZ5fMnpR9ewIchVzt/GE4WRbDbJOXva38fkScBukF1v80W47B+a9VereGJ47yyVZZROVManrxN8/bBs/AzSDeSZ41/2RyAKIlCFtLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by CH3PR11MB7868.namprd11.prod.outlook.com (2603:10b6:610:12e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 13:32:19 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 13:32:19 +0000
Date: Fri, 15 Mar 2024 14:32:12 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Yewon Choi <woni9911@gmail.com>
CC: Allison Henderson <allison.henderson@oracle.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
	<linux-kernel@vger.kernel.org>, "Dae R. Jeong" <threeearcat@gmail.com>
Subject: Re: [PATCH net v2] rds: introduce acquire/release ordering in
 acquire/release_in_xmit()
Message-ID: <ZfRN3A2yiWwAtIFf@localhost.localdomain>
References: <ZfQUxnNTO9AJmzwc@libra05>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZfQUxnNTO9AJmzwc@libra05>
X-ClientProxiedBy: DU7P250CA0011.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::26) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|CH3PR11MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: ed8f403c-4094-4e9e-9391-08dc44f456af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRal6I5Sv/pBMqSypRv0vLtC2+Mzk69PEBt6z0PGcxVlxcKYS0r7W1jrKRaNXsmc6W2C++5Y6rV3UEe0A9yqURNXcgq0PMX2TExQEh4JYUgzSrhk5yi+dWfMm/OATz6LpTmJUbPiVJGQEsIAAOSxx8lhPHiS1OhLoGEU2Lw9Vv73ul8E17/+SS6IOJfGzjEaA+Z/DddjPstYZLfM+8/dNsT2VBoWvt83BWiL2eFiyIaDPjJ5wh6GidudTgQqvSt35Q/RoAcIq/h91DTKcAPpFjphGcSCtTL0QwflbRH2SH2fgHEHXFJLhd+os5vbH9anI5KTm00nLnk1rdKeiaTk1uiql3fECUSdT10FtANs5imsEIbk67Vs4y6mMyd7imCmLA5/EpBJ9XH5SO+D3AspquYZhQdXVhCoBzuXfshbpriG25/izmyzR+2J0oV/C01ht8XDXvXZIU1BMq/iF7dmiG4XA0jc6LUqvQ/aoei2SpUof0z0OJllhQFSh4VWUn286pKugGAKLsWtisr+bJNXaavaFrquzHXQvR3oqMZaCxFEh7ItmQE0Y8IAZo8yclVLmqiPRX405aALP3Kfe9ghS/gqLIyaKlNwf+UGFEP9Icv/44SYeoHRZSotFoc3o1xKxqBd1kt5Q6jsA23sg//lIBqAqm1yQ0aWtL8XD94W1zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tA+TAA5atzhTulFGsN+X4GE0WUkQcGt0UdJGQlreFoqYLDrBKMXIJ3xN9yOK?=
 =?us-ascii?Q?NAHA+qCo/O5xVM1z44Ap4pew81EL2EW03Ap7hQ1o9UNrzXWsYpq2lp4BZ4QB?=
 =?us-ascii?Q?43UgT/GVY7HGp+4d+nkKzN2UZbEhVzloIhJ+EyB9Ywls3uR+3tIG7EYhzSj0?=
 =?us-ascii?Q?Sk96g84IK1Gk4III2rNW4ooSGp9kuZyAHlCqe0mod5XPuWCr1FZ97Piuw8Rf?=
 =?us-ascii?Q?mKV2OJ6y8HswDbatt6+GKEhRLWnfFKr8yGwAYdHGAEYDVHYZUWLfmqxQCfMF?=
 =?us-ascii?Q?iAOlZE20c7Pchlb5MMDP0EhouKj0htJKbNl2mSRlhN7Y3d+O7wsLZWO5NltO?=
 =?us-ascii?Q?5iwDaw1OlbCuB3/KWHuWAiS5qKlUo2ZPuIMs2ArTlHh2mqeQH8KuT+Uq3Wgx?=
 =?us-ascii?Q?wxm6I1DwNSP7mzkzCQZnBa0R7mvJAuaHDqHMVGXt9Lu+K8KQVCuqziA7mXiq?=
 =?us-ascii?Q?W9wWVjJPEg7p2whgCHAnFBmnFKo+WZ3L8nZCG9VGqOLpkOP/BxIAHzVEpzEv?=
 =?us-ascii?Q?WCCIpbuvsx9DjrMLj7pCU0yvdYJBROPhPXzpwcRTfroO5zr/HKtaZuCzXgRX?=
 =?us-ascii?Q?9gIt/eMmrOLCqfkt8J0iOY7KrvUrlr4KMCqlKWybgE/329iMYmqL36zkaiMi?=
 =?us-ascii?Q?5vuI7RqATTRUQ5PKASr94rl281fcN2t7WM6UTGiBwwRqQi6F50U2eaZu+M3Z?=
 =?us-ascii?Q?HqIYj88T5SrjsbktzwAMt64u7EA6g8cNoOufIlUcSZwPxYIVm5JO4iVjjdjG?=
 =?us-ascii?Q?f8LGH7wLouUyKT0LLwKMh/VYNjLvSik25pjTevpL9cyZeAxC5+PCHmMktobK?=
 =?us-ascii?Q?07TZE+1309Sme48UBNu3Iibhgo4vPtuT60G8LUga1/KP3ll1359eEsBcamva?=
 =?us-ascii?Q?Wnx9mGGGe8dJMqoFo2M6CG+Qfb75SZAYbw7ZYU47xH6kV4cIVNbZRyeDE4cY?=
 =?us-ascii?Q?LSM7lm3Z3byBgeIawa3Rjr+dd3YaZyFSVV9xF3lqYwLqjx/SxScVoRauLgLP?=
 =?us-ascii?Q?O1YxTgn5x5QghtIrl7HMlenGdlVcD8MH5yaQCCBq+f7/oUio/y7GVkxA0O+G?=
 =?us-ascii?Q?po6ywyymaUgyUGnXGBXBahj7ICEwTZdzwPrCozCESvu4iGIDG5fMvWDoMuae?=
 =?us-ascii?Q?IKYxxHSftJXXw3asJcHKCVL/14mV5DGdJQcVcu7IwIFPKulvVWQVCGKUVcGx?=
 =?us-ascii?Q?N38NzdbC1hGb/urLLCS0d5cRpC+hUdcI0Z+TctQykbhuuDV2dV2w0idP6UOV?=
 =?us-ascii?Q?mHpJfH5p4ayVakhvj38A//wc70oNP6B3girnI8y/VnlgJnAxFThldPGWTwch?=
 =?us-ascii?Q?Cz6SIPVQ1T+GKGcnE/j1SqTdvIPY3ORBAyf7EQx1UavS1BHFbbWRuxxexAW7?=
 =?us-ascii?Q?kgUEN3Z+Q1mEZqsE39x+ZqPaSP4skry5kTXCB9rAksiW/LWOi7klynvi/FYx?=
 =?us-ascii?Q?MFPmBPwcvM0h+2sVMNXTsXKvSXFrmScSPCXbfQkWSIpUGU1rbABs2x/MZBzb?=
 =?us-ascii?Q?e+h9WMQ0d/8/t/j//AML+1lCEIIh/EGpg9BkcKnrmNeZR+8EjldAwYnvhiBE?=
 =?us-ascii?Q?IQ0bWJKIcHkajaCl7w7OwqsACQY2wyAyIuOnd5qd9SM9Obd7c4WN0309Ow9i?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8f403c-4094-4e9e-9391-08dc44f456af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 13:32:19.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: to8sbQuVCnRiFSItghO1TvTQXwir/iMeDumZAZkvL00ktvrdsMLEKD4ocmOL4iFa40EmXmo/JtJHzL+yvkagsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7868
X-OriginatorOrg: intel.com

On Fri, Mar 15, 2024 at 06:28:38PM +0900, Yewon Choi wrote:
> acquire/release_in_xmit() work as bit lock in rds_send_xmit(), so they
> are expected to ensure acquire/release memory ordering semantics.
> However, test_and_set_bit/clear_bit() don't imply such semantics, on
> top of this, following smp_mb__after_atomic() does not guarantee release
> ordering (memory barrier actually should be placed before clear_bit()).
> 
> Instead, we use clear_bit_unlock/test_and_set_bit_lock() here.
> 
> Fixes: 0f4b1c7e89e6 ("rds: fix rds_send_xmit() serialization")
> Fixes: 1f9ecd7eacfd ("RDS: Pass rds_conn_path to rds_send_xmit()")
> Signed-off-by: Yewon Choi <woni9911@gmail.com>
> ---
> Changes in v1 -> v2:
> - Added missing Fixes tags
> 
>  net/rds/send.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/rds/send.c b/net/rds/send.c
> index 5e57a1581dc6..8f38009721b7 100644
> --- a/net/rds/send.c
> +++ b/net/rds/send.c
> @@ -103,13 +103,12 @@ EXPORT_SYMBOL_GPL(rds_send_path_reset);
>  
>  static int acquire_in_xmit(struct rds_conn_path *cp)
>  {
> -	return test_and_set_bit(RDS_IN_XMIT, &cp->cp_flags) == 0;
> +	return test_and_set_bit_lock(RDS_IN_XMIT, &cp->cp_flags) == 0;
>  }
>  
>  static void release_in_xmit(struct rds_conn_path *cp)
>  {
> -	clear_bit(RDS_IN_XMIT, &cp->cp_flags);
> -	smp_mb__after_atomic();
> +	clear_bit_unlock(RDS_IN_XMIT, &cp->cp_flags);
>  	/*
>  	 * We don't use wait_on_bit()/wake_up_bit() because our waking is in a
>  	 * hot path and finding waiters is very rare.  We don't want to walk
> -- 
> 2.43.0
> 

LGTM

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


