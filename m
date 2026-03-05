Return-Path: <linux-rdma+bounces-17514-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDSQMOlNqWk14AAAu9opvQ
	(envelope-from <linux-rdma+bounces-17514-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 10:33:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631D20E80F
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADCEB303AA97
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E1377EDE;
	Thu,  5 Mar 2026 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQfvwjIj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797E2330B14;
	Thu,  5 Mar 2026 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702991; cv=none; b=i7VLxZya8UY9CItH0OwGeE6afmKFIotkBWSjpUMaeFG/JAeixw+xGmIvaVwN78zAFQwAZyADwecc7VyoeiaFskeSgo0P84ZruPHzu6qvEXM3IYRSPxZksO29b1QczGOiThQIwLAbM65Q/ll1xH8lAQeSaqD6VT/QYY0Bt9Pk+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702991; c=relaxed/simple;
	bh=N9sXOBoTWgQKudwcJBZjeZWGoJgvejxlsaLCol4fg3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7NM00JfvTFttlVAIOWaQzagNf2oHRQunjFZbApM1xAvZn3KfeHNTQn7Uaut2zJnY4+qOuJ6Q/afYdzU1zJ7hRxpmIiRcMeH8ZZ5OkZGQWCvFaWSVJIArvPFsAMyQ6mYlkMUFUAQyhsrmpLFMrRVdjUwPHKwGrR9x8Q7esXR9ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KQfvwjIj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772702990; x=1804238990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N9sXOBoTWgQKudwcJBZjeZWGoJgvejxlsaLCol4fg3s=;
  b=KQfvwjIj6SxTbCFMnsEBdnrW57ePy/NGfKFXd2vMsGGaUivuvp2/NW6A
   /ZdBQf6A/8TS3lTWD8UANdY8319HK9LDmvl2alC63jsNmYlJ9zPCko2Lj
   CLZ5fPt/ObPbmR/xZG6Xwf4avRnr6NUqeBvrFy4Gp3D0pP7a02fR2arg/
   j+hntPPFzLEaddbp7tI3h3ompGkX7NpestqyUAaqUnpK4cC07cNfqCyo7
   iSuPRsjTlbAyIBVUfEJFop82Xv3C5apsr0NtNeBhKSmZM8ZZwX2JRdLSh
   jUOM4D/kq+OKDBnqRSh8RJlsbsqoE5vkvM4CK07+7CpGEAqp/0uDKPu5N
   w==;
X-CSE-ConnectionGUID: 6U1RWKW/Qb2FnkxoA4/HMw==
X-CSE-MsgGUID: Vts2Y68qQNKD6OVxEPB3ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77655246"
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="77655246"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 01:29:48 -0800
X-CSE-ConnectionGUID: pioHOlYERfm3eicoQfYz9w==
X-CSE-MsgGUID: Hy0m9MfUT9q5ZieRYt+iug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,102,1770624000"; 
   d="scan'208";a="249088615"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Mar 2026 01:29:45 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vy51Z-000000000Pu-27Q4;
	Thu, 05 Mar 2026 09:29:41 +0000
Date: Thu, 5 Mar 2026 17:29:22 +0800
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
Message-ID: <202603051743.ceus9qzu-lkp@intel.com>
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
X-Rspamd-Queue-Id: 2631D20E80F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17514-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260305/202603051743.ceus9qzu-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603051743.ceus9qzu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603051743.ceus9qzu-lkp@intel.com/

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

