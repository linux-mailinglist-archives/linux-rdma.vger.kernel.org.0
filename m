Return-Path: <linux-rdma+bounces-13906-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2146ABE5419
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 21:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58CA584294
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 19:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEED32DC763;
	Thu, 16 Oct 2025 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xa4cbksi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818714F112;
	Thu, 16 Oct 2025 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643597; cv=none; b=cHDbckQjgiDrxr1MxcfmwPQe9YLH4mfZUQZY1n2bXyJ4hZM6HmC5DKeb8Tq0DhByisYDYkcP+TyijXDCppH/h13qi+QHFsHsOBCECA84z5oPOQUyaGeL1oNE6rX+lccrVJQI26JKS79ysvwsPXJTQhdw7G2YKY8jz6fzIsDSLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643597; c=relaxed/simple;
	bh=CC/AgS6gk9HMNPlrpGG6X9jAb39xkIRmyJwwtgPVL0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxDzCaOauYRH9dma5veNSu6g9IiKN9PP1HB7U7wbaNp6LKxZ3a+3JLjDJO2/jK3LmFmeZpB951ZQtWkoJQQMdCQ13Kl3D0FiKMrBOnJ+yViOfhZqTKdClvqA69FgUQ49freBnNUNRst6xTb8sS3QhHVEPJP3zu2sqxRa4LdOyCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xa4cbksi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760643596; x=1792179596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CC/AgS6gk9HMNPlrpGG6X9jAb39xkIRmyJwwtgPVL0Q=;
  b=Xa4cbksieYVCNshC28sOwNRMFWq7gsWVvZfryWEg/tTw5Ox1gIuY2xnN
   NqXwBt/rXJvwsZynFWQdNrr8B2a0iAzVnncrwA5wUhmhaC1PoUo/5Lnho
   T/Bkju0D3f5fO+E8ixDm8KwaQEJFAzWQtRga8eGTqSf75i7XOFiXbrPCj
   PYtWdqWbWuCMRYQxxwJpMN2V+rxa7he/DWQ/T7AFV+khAzx1+CN7CrT0H
   cvPVz6KXgAffQCntpxeiHsl5omV94DtTnUttZFxiE7YRc/vkaL0kj84+e
   eAkt8PudTA/BqLilbRrbPmoqflkOLV08XgqRGAkRlVQgngEpV9pc2LP0G
   g==;
X-CSE-ConnectionGUID: G4ztYf/qQ2++eiTSUHD1mg==
X-CSE-MsgGUID: 0breztugSJaK9jQc4cTaQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73966931"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="73966931"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 12:39:55 -0700
X-CSE-ConnectionGUID: NiWqnOR8QWa3OZf6Nqok/A==
X-CSE-MsgGUID: ceApWpnpTTWBjGlb+XGk2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182224908"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 16 Oct 2025 12:39:50 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v9TpE-0005Br-2h;
	Thu, 16 Oct 2025 19:39:48 +0000
Date: Fri, 17 Oct 2025 03:39:24 +0800
From: kernel test robot <lkp@intel.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	sidraya@linux.ibm.com, jaka@linux.ibm.com
Subject: Re: [PATCH net-next] net/smc: add full IPv6 support for SMC
Message-ID: <202510170341.RsDKVdRg-lkp@intel.com>
References: <20251016054541.692-1-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016054541.692-1-alibuda@linux.alibaba.com>

Hi Wythe,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/D-Wythe/net-smc-add-full-IPv6-support-for-SMC/20251016-134735
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251016054541.692-1-alibuda%40linux.alibaba.com
patch subject: [PATCH net-next] net/smc: add full IPv6 support for SMC
config: s390-randconfig-002-20251017 (https://download.01.org/0day-ci/archive/20251017/202510170341.RsDKVdRg-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251017/202510170341.RsDKVdRg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510170341.RsDKVdRg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/smc/smc_wr.h:20,
                    from net/smc/smc_llc.h:16,
                    from net/smc/af_smc.c:47:
   net/smc/af_smc.c: In function 'smc_find_proposal_devices':
>> include/net/sock.h:389:37: error: 'struct sock_common' has no member named 'skc_v6_rcv_saddr'; did you mean 'skc_rcv_saddr'?
    #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
                                        ^~~~~~~~~~~~~~~~
   net/smc/smc_core.h:639:30: note: in definition of macro 'smc_ipaddr_from'
       __ipaddr->addr_v6 = __sk->_v6_member; \
                                 ^~~~~~~~~~
   net/smc/af_smc.c:1136:70: note: in expansion of macro 'sk_v6_rcv_saddr'
     smc_ipaddr_from(&ini->smcrv2.saddr, smc->clcsock->sk, sk_rcv_saddr, sk_v6_rcv_saddr);
                                                                         ^~~~~~~~~~~~~~~
   In file included from net/smc/af_smc.c:32:
   net/smc/af_smc.c: In function 'smc_connect_rdma_v2_prepare':
>> include/net/sock.h:389:37: error: 'struct sock_common' has no member named 'skc_v6_rcv_saddr'; did you mean 'skc_rcv_saddr'?
    #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
                                        ^~~~~~~~~~~~~~~~
   net/smc/af_smc.c:1241:53: note: in expansion of macro 'sk_v6_rcv_saddr'
       if (smc_ib_find_route_v6(net, &smc->clcsock->sk->sk_v6_rcv_saddr,
                                                        ^~~~~~~~~~~~~~~
   In file included from net/smc/smc_wr.h:20,
                    from net/smc/smc_llc.h:16,
                    from net/smc/af_smc.c:47:
   net/smc/af_smc.c: In function 'smc_find_rdma_v2_device_serv':
>> include/net/sock.h:389:37: error: 'struct sock_common' has no member named 'skc_v6_rcv_saddr'; did you mean 'skc_rcv_saddr'?
    #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
                                        ^~~~~~~~~~~~~~~~
   net/smc/smc_core.h:639:30: note: in definition of macro 'smc_ipaddr_from'
       __ipaddr->addr_v6 = __sk->_v6_member; \
                                 ^~~~~~~~~~
   net/smc/af_smc.c:2320:74: note: in expansion of macro 'sk_v6_rcv_saddr'
     smc_ipaddr_from(&ini->smcrv2.saddr, new_smc->clcsock->sk, sk_rcv_saddr, sk_v6_rcv_saddr);
                                                                             ^~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for I2C_K1
   Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && OF [=n]
   Selected by [y]:
   - MFD_SPACEMIT_P1 [=y] && HAS_IOMEM [=y] && (ARCH_SPACEMIT || COMPILE_TEST [=y]) && I2C [=y]


vim +389 include/net/sock.h

4dc6dc7162c08b Eric Dumazet             2009-07-15  368  
68835aba4d9b74 Eric Dumazet             2010-11-30  369  #define sk_dontcopy_begin	__sk_common.skc_dontcopy_begin
68835aba4d9b74 Eric Dumazet             2010-11-30  370  #define sk_dontcopy_end		__sk_common.skc_dontcopy_end
4dc6dc7162c08b Eric Dumazet             2009-07-15  371  #define sk_hash			__sk_common.skc_hash
5080546682bae3 Eric Dumazet             2013-10-02  372  #define sk_portpair		__sk_common.skc_portpair
05dbc7b59481ca Eric Dumazet             2013-10-03  373  #define sk_num			__sk_common.skc_num
05dbc7b59481ca Eric Dumazet             2013-10-03  374  #define sk_dport		__sk_common.skc_dport
5080546682bae3 Eric Dumazet             2013-10-02  375  #define sk_addrpair		__sk_common.skc_addrpair
5080546682bae3 Eric Dumazet             2013-10-02  376  #define sk_daddr		__sk_common.skc_daddr
5080546682bae3 Eric Dumazet             2013-10-02  377  #define sk_rcv_saddr		__sk_common.skc_rcv_saddr
^1da177e4c3f41 Linus Torvalds           2005-04-16  378  #define sk_family		__sk_common.skc_family
^1da177e4c3f41 Linus Torvalds           2005-04-16  379  #define sk_state		__sk_common.skc_state
^1da177e4c3f41 Linus Torvalds           2005-04-16  380  #define sk_reuse		__sk_common.skc_reuse
055dc21a1d1d21 Tom Herbert              2013-01-22  381  #define sk_reuseport		__sk_common.skc_reuseport
9fe516ba3fb29b Eric Dumazet             2014-06-27  382  #define sk_ipv6only		__sk_common.skc_ipv6only
26abe14379f8e2 Eric W. Biederman        2015-05-08  383  #define sk_net_refcnt		__sk_common.skc_net_refcnt
^1da177e4c3f41 Linus Torvalds           2005-04-16  384  #define sk_bound_dev_if		__sk_common.skc_bound_dev_if
^1da177e4c3f41 Linus Torvalds           2005-04-16  385  #define sk_bind_node		__sk_common.skc_bind_node
8feaf0c0a5488b Arnaldo Carvalho de Melo 2005-08-09  386  #define sk_prot			__sk_common.skc_prot
07feaebfcc10cd Eric W. Biederman        2007-09-12  387  #define sk_net			__sk_common.skc_net
efe4208f47f907 Eric Dumazet             2013-10-03  388  #define sk_v6_daddr		__sk_common.skc_v6_daddr
efe4208f47f907 Eric Dumazet             2013-10-03 @389  #define sk_v6_rcv_saddr	__sk_common.skc_v6_rcv_saddr
33cf7c90fe2f97 Eric Dumazet             2015-03-11  390  #define sk_cookie		__sk_common.skc_cookie
70da268b569d32 Eric Dumazet             2015-10-08  391  #define sk_incoming_cpu		__sk_common.skc_incoming_cpu
8e5eb54d303b7c Eric Dumazet             2015-10-08  392  #define sk_flags		__sk_common.skc_flags
ed53d0ab761f5c Eric Dumazet             2015-10-08  393  #define sk_rxhash		__sk_common.skc_rxhash
efe4208f47f907 Eric Dumazet             2013-10-03  394  
5d4cc87414c5d1 Eric Dumazet             2024-02-16  395  	__cacheline_group_begin(sock_write_rx);
43f51df4172955 Eric Dumazet             2021-11-15  396  
9115e8cd2a0c6e Eric Dumazet             2016-12-03  397  	atomic_t		sk_drops;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  398  	__s32			sk_peek_off;
7d452516b67add Eric Dumazet             2025-09-29  399  	struct sk_buff_head	sk_error_queue;
b178bb3dfc30d9 Eric Dumazet             2010-11-16  400  	struct sk_buff_head	sk_receive_queue;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  401  	/*
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  402  	 * The backlog queue is special, it is always used with
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  403  	 * the per-socket spinlock held and requires low latency
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  404  	 * access. Therefore we special case it's implementation.
b178bb3dfc30d9 Eric Dumazet             2010-11-16  405  	 * Note : rmem_alloc is in this structure to fill a hole
b178bb3dfc30d9 Eric Dumazet             2010-11-16  406  	 * on 64bit arches, not because its logically part of
b178bb3dfc30d9 Eric Dumazet             2010-11-16  407  	 * backlog.
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  408  	 */
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  409  	struct {
b178bb3dfc30d9 Eric Dumazet             2010-11-16  410  		atomic_t	rmem_alloc;
b178bb3dfc30d9 Eric Dumazet             2010-11-16  411  		int		len;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  412  		struct sk_buff	*head;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  413  		struct sk_buff	*tail;
fa438ccfdfd3f6 Eric Dumazet             2007-03-04  414  	} sk_backlog;
b178bb3dfc30d9 Eric Dumazet             2010-11-16  415  #define sk_rmem_alloc sk_backlog.rmem_alloc
2c8c56e15df3d4 Eric Dumazet             2014-11-11  416  
5d4cc87414c5d1 Eric Dumazet             2024-02-16  417  	__cacheline_group_end(sock_write_rx);
5d4cc87414c5d1 Eric Dumazet             2024-02-16  418  
5d4cc87414c5d1 Eric Dumazet             2024-02-16  419  	__cacheline_group_begin(sock_read_rx);
5d4cc87414c5d1 Eric Dumazet             2024-02-16  420  	/* early demux fields */
5d4cc87414c5d1 Eric Dumazet             2024-02-16  421  	struct dst_entry __rcu	*sk_rx_dst;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  422  	int			sk_rx_dst_ifindex;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  423  	u32			sk_rx_dst_cookie;
5d4cc87414c5d1 Eric Dumazet             2024-02-16  424  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

