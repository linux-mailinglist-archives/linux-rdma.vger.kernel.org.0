Return-Path: <linux-rdma+bounces-8592-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B677A5D7A7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 08:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3CE3B0032
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E20422DF95;
	Wed, 12 Mar 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBPdtlUq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21922DF83
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766163; cv=none; b=KBkN+DOKVhYhdyG+ufM7dH7smVBdHm0EICuW34RMnGN/vqXtyQXsyFNzS5CV2FsfE1HwPbxZYe/nd/RbdKq4GQFScPFAXuudPVdY/lWRUjs/CTfnbFGyDOAAnl4XmYI8ytZXRlGCanO2FoHwbsAu0TfXNwL5f+WnNsCZ3h7JdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766163; c=relaxed/simple;
	bh=BAtR3tzpsGfKBLd1V9FOHO2xVMMAacf2DP5E4jiuhcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8EgH7FjbHQpgb37SzJB/AMolclYH3WH5Cyby1GxoyLLCG/YxkYRNzoPGXQ5D8bDNDhEyOg+PpNTocx4Mq74AqJVyKOoHKt4OmPxKzuaDCV2eiRZ1KN5qPET+yJlPGhlzF1EISNb6hCp6mw92jElUUkFNaShemFg2/6Mhvgp/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBPdtlUq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741766160; x=1773302160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BAtR3tzpsGfKBLd1V9FOHO2xVMMAacf2DP5E4jiuhcQ=;
  b=EBPdtlUq3DpkzCrMM4Qf6x6bBiBC5mzZa2OmLzasY9M8MDdL2vzqsoRY
   V8v/4CAZYXT7UcujXfTGkjvzxSEg2x9sd5SSeWBYi7JRrgi9XVLJnag82
   HXWiSCw7lLIeE5P1rNRWjkrT2VZfe78pr9uRtA/y2fECZEWHgPQXyiM+J
   K3TBDh/HrZVw1HEHrIcF7jLt8x2VrCOyH4vGBhA+M+1XZDioltIV17rQn
   oOSaeo7T7UtwBK+KnKHDAffDW6hAGjCjmmvgeOfpeqqtpedqR4blfDcKI
   fhwR+e+iNb5jtHkD6/PH/4Q7dKx8KPvs1RTTS56F9AvtHOhg2EIJlNEeX
   A==;
X-CSE-ConnectionGUID: IL2U00RHSs6zUScfdot7gQ==
X-CSE-MsgGUID: 0nkdjbJAQCGB8htTCYXc4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42745489"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42745489"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 00:56:00 -0700
X-CSE-ConnectionGUID: 5gcEABVfRsesJz+sMDHt8A==
X-CSE-MsgGUID: UqBupuIVThmnR5o4tcMEmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="157755009"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 12 Mar 2025 00:55:57 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsGwU-0008FI-28;
	Wed, 12 Mar 2025 07:55:54 +0000
Date: Wed, 12 Mar 2025 15:55:51 +0800
From: kernel test robot <lkp@intel.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>, leon@kernel.org,
	jgg@ziepe.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Preethi G <preethi.gurusiddalingeswaraswamy@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-next] RDMA/bnxt_re: Support Perf management counters
Message-ID: <202503121530.oThTZxSC-lkp@intel.com>
References: <1741674104-5477-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741674104-5477-1-git-send-email-selvin.xavier@broadcom.com>

Hi Selvin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.14-rc6 next-20250311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Selvin-Xavier/RDMA-bnxt_re-Support-Perf-management-counters/20250311-144413
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/1741674104-5477-1-git-send-email-selvin.xavier%40broadcom.com
patch subject: [PATCH rdma-next] RDMA/bnxt_re: Support Perf management counters
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250312/202503121530.oThTZxSC-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250312/202503121530.oThTZxSC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503121530.oThTZxSC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/bnxt_re/hw_counters.c: In function 'bnxt_re_assign_pma_port_ext_counters':
>> drivers/infiniband/hw/bnxt_re/hw_counters.c:295:13: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
     295 |         int rc;
         |             ^~
   drivers/infiniband/hw/bnxt_re/hw_counters.c: In function 'bnxt_re_assign_pma_port_counters':
   drivers/infiniband/hw/bnxt_re/hw_counters.c:338:13: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
     338 |         int rc;
         |             ^~


vim +/rc +295 drivers/infiniband/hw/bnxt_re/hw_counters.c

   289	
   290	int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev, struct ib_mad *out_mad)
   291	{
   292		struct ib_pma_portcounters_ext *pma_cnt_ext;
   293		struct bnxt_qplib_ext_stat *estat = &rdev->stats.rstat.ext_stat;
   294		struct ctx_hw_stats *hw_stats = NULL;
 > 295		int rc;
   296	
   297		hw_stats = rdev->qplib_ctx.stats.dma;
   298	
   299		pma_cnt_ext = (void *)(out_mad->data + 40);
   300		if (_is_ext_stats_supported(rdev->dev_attr->dev_cap_flags)) {
   301			u32 fid = PCI_FUNC(rdev->en_dev->pdev->devfn);
   302	
   303			rc = bnxt_qplib_qext_stat(&rdev->rcfw, fid, estat);
   304		}
   305	
   306		pma_cnt_ext = (void *)(out_mad->data + 40);
   307		if ((bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) && rdev->is_virtfn) ||
   308		    !bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
   309			pma_cnt_ext->port_xmit_data =
   310				cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_bytes) / 4);
   311			pma_cnt_ext->port_rcv_data =
   312				cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_bytes) / 4);
   313			pma_cnt_ext->port_xmit_packets =
   314				cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_pkts));
   315			pma_cnt_ext->port_rcv_packets =
   316				cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_pkts));
   317			pma_cnt_ext->port_unicast_rcv_packets =
   318				cpu_to_be64(le64_to_cpu(hw_stats->rx_ucast_pkts));
   319			pma_cnt_ext->port_unicast_xmit_packets =
   320				cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_pkts));
   321	
   322		} else {
   323			pma_cnt_ext->port_rcv_packets = cpu_to_be64(estat->rx_roce_good_pkts);
   324			pma_cnt_ext->port_rcv_data = cpu_to_be64(estat->rx_roce_good_bytes / 4);
   325			pma_cnt_ext->port_xmit_packets = cpu_to_be64(estat->tx_roce_pkts);
   326			pma_cnt_ext->port_xmit_data = cpu_to_be64(estat->tx_roce_bytes / 4);
   327			pma_cnt_ext->port_unicast_rcv_packets = cpu_to_be64(estat->rx_roce_good_pkts);
   328			pma_cnt_ext->port_unicast_xmit_packets = cpu_to_be64(estat->tx_roce_pkts);
   329		}
   330		return 0;
   331	}
   332	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

