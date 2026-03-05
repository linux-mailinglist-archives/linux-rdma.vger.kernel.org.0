Return-Path: <linux-rdma+bounces-17506-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBqdADoEqWlW0QAAu9opvQ
	(envelope-from <linux-rdma+bounces-17506-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 05:19:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D8120ABB7
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 05:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65990305DD77
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 04:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5223F23D7E6;
	Thu,  5 Mar 2026 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iy1qf1p8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082F1A6828;
	Thu,  5 Mar 2026 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772684268; cv=none; b=o4O8eZpGglYgcqePoKt3MLIna+uwBlAoA3XrC4tXdxRYdUch8xal30j0lfiVODhhf9+cJ4bl1/kplypI+FYSLzDs+0pHCznTmyI4nZ3tj5TWUiKY0xE6Yy0Vz3fBN+zSA3Om2lZLmNZotqX9jWeQfjm10pGkNeABUbiNb6tNTZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772684268; c=relaxed/simple;
	bh=ju0G5UZ2rCJU+V3SLjPep3HnbLt/EM2wPBSuA/6zSAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+uzJXOjA+sgv1VUBGl0/f7vqncxnAvtUYzYz3jbWNPNn1KkSYpGleUHWFKEwlWFtCxWQH/Omfm8vNf68D9o2BBiQxBeyEI9D4ArSXaM5eRXaWe3fHiB36tUoT8hR2ot4LjMrU+GzbKj9riLNnQjR5KU0eL4XhUbXG6mRzuzuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iy1qf1p8; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772684265; x=1804220265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ju0G5UZ2rCJU+V3SLjPep3HnbLt/EM2wPBSuA/6zSAY=;
  b=Iy1qf1p8aSKL8u7NrTInlMeyrr6g2HqHsDdjTRkuW+Gshi3tRodlLgcC
   Vw9vXKuGUmLLLJXTT/eO92Q0gVv2vNq1Qj5Z1rzNLki+ysqSMK1uY4tRJ
   9a61016JzDP895N+5yG2tpkER+VhBM4wzlsUmSPy046QqOwRr0j1Gi10m
   bt9TMg6bgvDkr2ehaiDqnpQvLLMi1/UHHwrm+TX0DHcsKfYugJrQMfG37
   sNu4GEar1nX3uEFbZ9K+ozdKHQGMw8T7KWoWviQhbljdjZ7bKgBhKUaHS
   Y0Q5pqQ0aBi/reIHblbiL0n7e83Lhy8c3tdZwMZe6Ks2rqQPjlr1T2mmZ
   g==;
X-CSE-ConnectionGUID: 0+Aq+1nqS/2v1sVQc7qUmg==
X-CSE-MsgGUID: mHQGN7gLQf6og7hlPi12TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84095132"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="84095132"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 20:17:45 -0800
X-CSE-ConnectionGUID: Z0Ncu36vSUSh/gW40dxtLQ==
X-CSE-MsgGUID: ZfeOJtbTQ7u/NXImdFn6Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="218675068"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 04 Mar 2026 20:17:42 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy09a-000000001wb-1w88;
	Thu, 05 Mar 2026 04:17:38 +0000
Date: Thu, 5 Mar 2026 05:17:13 +0100
From: kernel test robot <lkp@intel.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rama.nichanamatlu@oracle.com,
	manjunath.b.patil@oracle.com, anand.a.khoje@oracle.com,
	Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: Re: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Message-ID: <202603050528.5JWnahEr-lkp@intel.com>
References: <20260304161704.910564-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304161704.910564-1-praveen.kannoju@oracle.com>
X-Rspamd-Queue-Id: 58D8120ABB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17506-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,git-scm.com:url,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Action: no action

Hi Praveen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.16-rc1 next-20260304]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-Kumar-Kannoju/net-mlx5-poll-mlx5-eq-during-irq-migration/20260305-003505
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260304161704.910564-1-praveen.kannoju%40oracle.com
patch subject: [PATCH] net/mlx5: poll mlx5 eq during irq migration
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260305/202603050528.5JWnahEr-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603050528.5JWnahEr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603050528.5JWnahEr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlx5/core/eq.c:958:6: warning: no previous prototype for 'mlx5_eq_reap_irq_notify' [-Wmissing-prototypes]
     958 | void mlx5_eq_reap_irq_notify(struct irq_affinity_notify *notify, const cpumask_t *mask)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/mellanox/mlx5/core/eq.c:978:6: warning: no previous prototype for 'mlx5_eq_reap_irq_release' [-Wmissing-prototypes]
     978 | void mlx5_eq_reap_irq_release(struct kref *ref) {}
         |      ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/mlx5_eq_reap_irq_notify +958 drivers/net/ethernet/mellanox/mlx5/core/eq.c

   957	
 > 958	void mlx5_eq_reap_irq_notify(struct irq_affinity_notify *notify, const cpumask_t *mask)
   959	{
   960		u32 eqe_count;
   961		struct mlx5_eq_comp *eq = container_of(notify, struct mlx5_eq_comp, notify);
   962	
   963		if (mlx5_reap_eq_irq_aff_change) {
   964			mlx5_core_warn(eq->core.dev, "irqn = 0x%x migration notified, EQ 0x%x: Cons = 0x%x\n",
   965				       eq->core.irqn, eq->core.eqn, eq->core.cons_index);
   966	
   967			while (!rtnl_trylock())
   968				msleep(20);
   969	
   970			eqe_count = mlx5_eq_poll_irq_disabled(eq);
   971			if (eqe_count)
   972				mlx5_core_warn(eq->core.dev, "Recovered %d eqes on EQ 0x%x\n",
   973					       eqe_count, eq->core.eqn);
   974			rtnl_unlock();
   975		}
   976	}
   977	
 > 978	void mlx5_eq_reap_irq_release(struct kref *ref) {}
   979	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

