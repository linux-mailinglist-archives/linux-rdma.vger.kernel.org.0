Return-Path: <linux-rdma+bounces-17511-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGHzDcNCqWkt3gAAu9opvQ
	(envelope-from <linux-rdma+bounces-17511-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 09:45:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AE220DA7F
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 09:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16072301D319
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 08:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82FE374E66;
	Thu,  5 Mar 2026 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ei0UrF2e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FEA30FC26;
	Thu,  5 Mar 2026 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700348; cv=none; b=RH4zBdO6ft6b2aP8SfwTv5MtFwobKP1x88lz9Ql3c06+1R+VJK3PSthNQRyY79vsb4sUp5RM6Ekh0SCaTUkQ2ng6jrtQ1DKaxuZ+C4WTL/o4yIK+Nj94ymvr9YBb0W7iIBR7V8UJ0z9Ifh9VxZaQsExtkJSK62meL0TmPDg+VMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700348; c=relaxed/simple;
	bh=xNgtMPoKImoCYr8gJJARcB78RmcwRHpu3tklaVxZms4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyUTlEnwrUdARgjaARhnJStaohO3MjSKd2ltuAa3PNFDLzfGaWek2/+Ui3tGqfj5NHEjwPkrl3Uq4g+gmD7F0LufiBRuBAm+Q/EjZQV7PKAu+gamAR7IAgWeQYkCqg9IpVyb7qam9y+iCC9KcoNtMRIs2OJw7HwF1nIOQD4KwYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ei0UrF2e; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772700347; x=1804236347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xNgtMPoKImoCYr8gJJARcB78RmcwRHpu3tklaVxZms4=;
  b=Ei0UrF2eLQuV/l5rZX0iu3sI1UW/HbiBjWNgucgmsXBz/CQ9Y20RvMBh
   xoInW6LD3gZmwKIMlpt4UeF4z2f27RjML20kL7XKKAnNmsXICiz8nypcs
   WBBwI8OoPYOZd7uUD9NRjod/hwwJgw2AGgfkavXYxmzR/YsA4nzGw+kYN
   2YesdDSZugKNfQ/Qy1YtQxlSxqmd9eB+cpSnQqNpbBFPTNwUxyCwdTISn
   8InIbRmp38pa44fvNfLILCiF9oyWs4pbc7omObe0PQONMx4qqMSUxDR4l
   mriB7s24SsU430H7CrtOe2jY5ci3S4HBwp4wMjk1qyxT0Uk5zzuXYXMG7
   A==;
X-CSE-ConnectionGUID: FjkP8ey8RUWe//GP4klIVQ==
X-CSE-MsgGUID: xAsD9KPpRvSs1lYvmyJkjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77650847"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="77650847"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 00:45:46 -0800
X-CSE-ConnectionGUID: FeFniaThThi3umX8U2hWSw==
X-CSE-MsgGUID: j9ykGgsfSoaGhjA966yT4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="218749208"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Mar 2026 00:45:41 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy4Kw-000000000MU-2ojd;
	Thu, 05 Mar 2026 08:45:38 +0000
Date: Thu, 5 Mar 2026 16:45:03 +0800
From: kernel test robot <lkp@intel.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>, saeedm@nvidia.com,
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com,
	anand.a.khoje@oracle.com,
	Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Subject: Re: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Message-ID: <202603051647.fykhqQ3H-lkp@intel.com>
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
X-Rspamd-Queue-Id: D1AE220DA7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17511-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Praveen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v7.0-rc2 next-20260304]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-Kumar-Kannoju/net-mlx5-poll-mlx5-eq-during-irq-migration/20260305-003505
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260304161704.910564-1-praveen.kannoju%40oracle.com
patch subject: [PATCH] net/mlx5: poll mlx5 eq during irq migration
config: x86_64-buildonly-randconfig-002-20260305 (https://download.01.org/0day-ci/archive/20260305/202603051647.fykhqQ3H-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051647.fykhqQ3H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051647.fykhqQ3H-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlx5/core/eq.c:958:6: warning: no previous prototype for function 'mlx5_eq_reap_irq_notify' [-Wmissing-prototypes]
     958 | void mlx5_eq_reap_irq_notify(struct irq_affinity_notify *notify, const cpumask_t *mask)
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/eq.c:958:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     958 | void mlx5_eq_reap_irq_notify(struct irq_affinity_notify *notify, const cpumask_t *mask)
         | ^
         | static 
>> drivers/net/ethernet/mellanox/mlx5/core/eq.c:978:6: warning: no previous prototype for function 'mlx5_eq_reap_irq_release' [-Wmissing-prototypes]
     978 | void mlx5_eq_reap_irq_release(struct kref *ref) {}
         |      ^
   drivers/net/ethernet/mellanox/mlx5/core/eq.c:978:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     978 | void mlx5_eq_reap_irq_release(struct kref *ref) {}
         | ^
         | static 
   2 warnings generated.


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

