Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9C16DA823
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Apr 2023 06:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjDGEHd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Apr 2023 00:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDGEHc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Apr 2023 00:07:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F259F9;
        Thu,  6 Apr 2023 21:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680840450; x=1712376450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7C/GtLnvGaUf0LTn+dJO3q6KCE+5wcx6XCokPeAFBSs=;
  b=W/t4nKcFTgT8OMp5vk2ZW15XUg26k9oMX/5kioGkYRGnbFrhNUnX52QL
   +qcHPPhs/tPArsklIqv71pfLLSAOAfZHzGy4UQ0B5g+7F+dtIFSWIqdy9
   RX7YpDVEk70eMbl9Vy/C2a5AArBim1mdehq0ZMr19tonJnLpGb6SDGu8+
   djAumsOlivnGQBwff5ftRfsSNmxM31LHUv3fLgXhcxh+xn/0tkAUiNMc6
   qoCZs0foO2qEozvPID9fOkGteIDzIad7N6ceowiZBJ5XGMg+jwv/o1r6J
   crXxtxhQBUHCIWT2oXwAK0O7PDghydFVgzvbRw7WFaX3MY+l9incQhG3P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="326993443"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="326993443"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 21:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="751903619"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="751903619"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Apr 2023 21:07:27 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkdNm-000S6Q-0A;
        Fri, 07 Apr 2023 04:07:26 +0000
Date:   Fri, 7 Apr 2023 12:07:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     xiaolinkui <xiaolinkui@126.com>,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] RDMA/hfi: add a judgment on the availability of cpumask
Message-ID: <202304071125.xK1fezQ1-lkp@intel.com>
References: <20230404030525.24020-1-xiaolinkui@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404030525.24020-1-xiaolinkui@126.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi xiaolinkui,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v6.3-rc5 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/xiaolinkui/RDMA-hfi-add-a-judgment-on-the-availability-of-cpumask/20230404-113847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20230404030525.24020-1-xiaolinkui%40126.com
patch subject: [PATCH] RDMA/hfi: add a judgment on the availability of cpumask
config: x86_64-randconfig-a003-20220117 (https://download.01.org/0day-ci/archive/20230407/202304071125.xK1fezQ1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/206c6fc9aa5afd354f4201216ca8c2c0057fb49d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review xiaolinkui/RDMA-hfi-add-a-judgment-on-the-availability-of-cpumask/20230404-113847
        git checkout 206c6fc9aa5afd354f4201216ca8c2c0057fb49d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/infiniband/hw/hfi1/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304071125.xK1fezQ1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5,
                    from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/percpu.h:5,
                    from include/linux/arch_topology.h:9,
                    from include/linux/topology.h:30,
                    from drivers/infiniband/hw/hfi1/affinity.c:6:
   drivers/infiniband/hw/hfi1/affinity.c: In function 'hfi1_get_proc_affinity':
>> drivers/infiniband/hw/hfi1/affinity.c:1050:30: warning: the address of 'diff' will always evaluate as 'true' [-Waddress]
    1050 |         if (!ret || unlikely(!diff))
         |                              ^
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> drivers/infiniband/hw/hfi1/affinity.c:1053:30: warning: the address of 'hw_thread_mask' will always evaluate as 'true' [-Waddress]
    1053 |         if (!ret || unlikely(!hw_thread_mask))
         |                              ^
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> drivers/infiniband/hw/hfi1/affinity.c:1056:30: warning: the address of 'available_mask' will always evaluate as 'true' [-Waddress]
    1056 |         if (!ret || unlikely(!available_mask))
         |                              ^
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
>> drivers/infiniband/hw/hfi1/affinity.c:1059:30: warning: the address of 'intrs_mask' will always evaluate as 'true' [-Waddress]
    1059 |         if (!ret || unlikely(!intrs_mask))
         |                              ^
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^


vim +1050 drivers/infiniband/hw/hfi1/affinity.c

   995	
   996	int hfi1_get_proc_affinity(int node)
   997	{
   998		int cpu = -1, ret, i;
   999		struct hfi1_affinity_node *entry;
  1000		cpumask_var_t diff, hw_thread_mask, available_mask, intrs_mask;
  1001		const struct cpumask *node_mask,
  1002			*proc_mask = current->cpus_ptr;
  1003		struct hfi1_affinity_node_list *affinity = &node_affinity;
  1004		struct cpu_mask_set *set = &affinity->proc;
  1005	
  1006		/*
  1007		 * check whether process/context affinity has already
  1008		 * been set
  1009		 */
  1010		if (current->nr_cpus_allowed == 1) {
  1011			hfi1_cdbg(PROC, "PID %u %s affinity set to CPU %*pbl",
  1012				  current->pid, current->comm,
  1013				  cpumask_pr_args(proc_mask));
  1014			/*
  1015			 * Mark the pre-set CPU as used. This is atomic so we don't
  1016			 * need the lock
  1017			 */
  1018			cpu = cpumask_first(proc_mask);
  1019			cpumask_set_cpu(cpu, &set->used);
  1020			goto done;
  1021		} else if (current->nr_cpus_allowed < cpumask_weight(&set->mask)) {
  1022			hfi1_cdbg(PROC, "PID %u %s affinity set to CPU set(s) %*pbl",
  1023				  current->pid, current->comm,
  1024				  cpumask_pr_args(proc_mask));
  1025			goto done;
  1026		}
  1027	
  1028		/*
  1029		 * The process does not have a preset CPU affinity so find one to
  1030		 * recommend using the following algorithm:
  1031		 *
  1032		 * For each user process that is opening a context on HFI Y:
  1033		 *  a) If all cores are filled, reinitialize the bitmask
  1034		 *  b) Fill real cores first, then HT cores (First set of HT
  1035		 *     cores on all physical cores, then second set of HT core,
  1036		 *     and, so on) in the following order:
  1037		 *
  1038		 *     1. Same NUMA node as HFI Y and not running an IRQ
  1039		 *        handler
  1040		 *     2. Same NUMA node as HFI Y and running an IRQ handler
  1041		 *     3. Different NUMA node to HFI Y and not running an IRQ
  1042		 *        handler
  1043		 *     4. Different NUMA node to HFI Y and running an IRQ
  1044		 *        handler
  1045		 *  c) Mark core as filled in the bitmask. As user processes are
  1046		 *     done, clear cores from the bitmask.
  1047		 */
  1048	
  1049		ret = zalloc_cpumask_var(&diff, GFP_KERNEL);
> 1050		if (!ret || unlikely(!diff))
  1051			goto done;
  1052		ret = zalloc_cpumask_var(&hw_thread_mask, GFP_KERNEL);
> 1053		if (!ret || unlikely(!hw_thread_mask))
  1054			goto free_diff;
  1055		ret = zalloc_cpumask_var(&available_mask, GFP_KERNEL);
> 1056		if (!ret || unlikely(!available_mask))
  1057			goto free_hw_thread_mask;
  1058		ret = zalloc_cpumask_var(&intrs_mask, GFP_KERNEL);
> 1059		if (!ret || unlikely(!intrs_mask))
  1060			goto free_available_mask;
  1061	
  1062		mutex_lock(&affinity->lock);
  1063		/*
  1064		 * If we've used all available HW threads, clear the mask and start
  1065		 * overloading.
  1066		 */
  1067		_cpu_mask_set_gen_inc(set);
  1068	
  1069		/*
  1070		 * If NUMA node has CPUs used by interrupt handlers, include them in the
  1071		 * interrupt handler mask.
  1072		 */
  1073		entry = node_affinity_lookup(node);
  1074		if (entry) {
  1075			cpumask_copy(intrs_mask, (entry->def_intr.gen ?
  1076						  &entry->def_intr.mask :
  1077						  &entry->def_intr.used));
  1078			cpumask_or(intrs_mask, intrs_mask, (entry->rcv_intr.gen ?
  1079							    &entry->rcv_intr.mask :
  1080							    &entry->rcv_intr.used));
  1081			cpumask_or(intrs_mask, intrs_mask, &entry->general_intr_mask);
  1082		}
  1083		hfi1_cdbg(PROC, "CPUs used by interrupts: %*pbl",
  1084			  cpumask_pr_args(intrs_mask));
  1085	
  1086		cpumask_copy(hw_thread_mask, &set->mask);
  1087	
  1088		/*
  1089		 * If HT cores are enabled, identify which HW threads within the
  1090		 * physical cores should be used.
  1091		 */
  1092		if (affinity->num_core_siblings > 0) {
  1093			for (i = 0; i < affinity->num_core_siblings; i++) {
  1094				find_hw_thread_mask(i, hw_thread_mask, affinity);
  1095	
  1096				/*
  1097				 * If there's at least one available core for this HW
  1098				 * thread number, stop looking for a core.
  1099				 *
  1100				 * diff will always be not empty at least once in this
  1101				 * loop as the used mask gets reset when
  1102				 * (set->mask == set->used) before this loop.
  1103				 */
  1104				cpumask_andnot(diff, hw_thread_mask, &set->used);
  1105				if (!cpumask_empty(diff))
  1106					break;
  1107			}
  1108		}
  1109		hfi1_cdbg(PROC, "Same available HW thread on all physical CPUs: %*pbl",
  1110			  cpumask_pr_args(hw_thread_mask));
  1111	
  1112		node_mask = cpumask_of_node(node);
  1113		hfi1_cdbg(PROC, "Device on NUMA %u, CPUs %*pbl", node,
  1114			  cpumask_pr_args(node_mask));
  1115	
  1116		/* Get cpumask of available CPUs on preferred NUMA */
  1117		cpumask_and(available_mask, hw_thread_mask, node_mask);
  1118		cpumask_andnot(available_mask, available_mask, &set->used);
  1119		hfi1_cdbg(PROC, "Available CPUs on NUMA %u: %*pbl", node,
  1120			  cpumask_pr_args(available_mask));
  1121	
  1122		/*
  1123		 * At first, we don't want to place processes on the same
  1124		 * CPUs as interrupt handlers. Then, CPUs running interrupt
  1125		 * handlers are used.
  1126		 *
  1127		 * 1) If diff is not empty, then there are CPUs not running
  1128		 *    non-interrupt handlers available, so diff gets copied
  1129		 *    over to available_mask.
  1130		 * 2) If diff is empty, then all CPUs not running interrupt
  1131		 *    handlers are taken, so available_mask contains all
  1132		 *    available CPUs running interrupt handlers.
  1133		 * 3) If available_mask is empty, then all CPUs on the
  1134		 *    preferred NUMA node are taken, so other NUMA nodes are
  1135		 *    used for process assignments using the same method as
  1136		 *    the preferred NUMA node.
  1137		 */
  1138		cpumask_andnot(diff, available_mask, intrs_mask);
  1139		if (!cpumask_empty(diff))
  1140			cpumask_copy(available_mask, diff);
  1141	
  1142		/* If we don't have CPUs on the preferred node, use other NUMA nodes */
  1143		if (cpumask_empty(available_mask)) {
  1144			cpumask_andnot(available_mask, hw_thread_mask, &set->used);
  1145			/* Excluding preferred NUMA cores */
  1146			cpumask_andnot(available_mask, available_mask, node_mask);
  1147			hfi1_cdbg(PROC,
  1148				  "Preferred NUMA node cores are taken, cores available in other NUMA nodes: %*pbl",
  1149				  cpumask_pr_args(available_mask));
  1150	
  1151			/*
  1152			 * At first, we don't want to place processes on the same
  1153			 * CPUs as interrupt handlers.
  1154			 */
  1155			cpumask_andnot(diff, available_mask, intrs_mask);
  1156			if (!cpumask_empty(diff))
  1157				cpumask_copy(available_mask, diff);
  1158		}
  1159		hfi1_cdbg(PROC, "Possible CPUs for process: %*pbl",
  1160			  cpumask_pr_args(available_mask));
  1161	
  1162		cpu = cpumask_first(available_mask);
  1163		if (cpu >= nr_cpu_ids) /* empty */
  1164			cpu = -1;
  1165		else
  1166			cpumask_set_cpu(cpu, &set->used);
  1167	
  1168		mutex_unlock(&affinity->lock);
  1169		hfi1_cdbg(PROC, "Process assigned to CPU %d", cpu);
  1170	
  1171		free_cpumask_var(intrs_mask);
  1172	free_available_mask:
  1173		free_cpumask_var(available_mask);
  1174	free_hw_thread_mask:
  1175		free_cpumask_var(hw_thread_mask);
  1176	free_diff:
  1177		free_cpumask_var(diff);
  1178	done:
  1179		return cpu;
  1180	}
  1181	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
