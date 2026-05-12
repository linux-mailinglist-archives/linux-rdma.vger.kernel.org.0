Return-Path: <linux-rdma+bounces-20457-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mQlzBrPAAmpJwQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20457-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 07:54:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE2651A7E7
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 07:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32F1030418BD
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E343E0257;
	Tue, 12 May 2026 05:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kw15HBKE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458823D6CD9;
	Tue, 12 May 2026 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564645; cv=none; b=VvO86X/n4eCIclZJWFdvB6RG2VTuAdwA5CZoy9zHg1RW9JgIkePwTunzoGvjy8LF7S96e0gkVWeCdm8ZByeeS5Aq4IM1qOsLagUXO/BpsDsDPepGRKAd09Y/TcIKCpeAAgO7T1EXASl1Kj4PUCn7+gDlSM4b8581KJx5nk9hb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564645; c=relaxed/simple;
	bh=ZoE7384it269htn0b+KDZdQY37BAyNlYlcmt+DIxG1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSg8+Atoc16O9+S4ACZokOdyWPyyfA9W/xYaY9xQAEfU6IQy2wHp72mRZwLpXUZAWpq95kGhqxitbP93OT1Lnr/cU+VZgiq0ypsWAoW+h4Dtyw9rIQSppzZZtmYcloYW5Z8rMxshfzaTs9KX1wA5lKexRtgUflmY2bqDveBZ3eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kw15HBKE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778564637; x=1810100637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZoE7384it269htn0b+KDZdQY37BAyNlYlcmt+DIxG1g=;
  b=kw15HBKEuCIosFo9qDAEvmBgClM2fztQSb62x6Ka8vX/xYryhPGW52eX
   7t35ADmwJxAJHBxRix4ZSy5Gc1cSEz4zUhKrUNNvflSGDAEgn6mi/LUUF
   HOKuIbT2qPGKB81H9wXx23KTkDhKgSWI+BhdLqocc1A4eA00F94s8xNdK
   CxW+5bLYWMl+4JkcpP+qHxUY9b8NWsdv33kSq+D/dYjftUDJEeBx2nKfZ
   XXR+9AGM0aW+NsaELPq+BhJS0goQbL+3sWOrWJoM2vfwRAbwT/G0H7Gh1
   Mx4uyIx1SWgqQqr+aEiS1jiKKiwRt7kaQLAiBz4xW5JMIRWwOc/7RySZj
   Q==;
X-CSE-ConnectionGUID: bxjVTsY7Qom4oZcnAa2iPg==
X-CSE-MsgGUID: 0vdZpEZMRAqLFKrd0jd3gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="82030807"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="82030807"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:43:51 -0700
X-CSE-ConnectionGUID: lhCniQ8jShSB+CKNYqq58Q==
X-CSE-MsgGUID: W26M/UnMTr+ZE0KRXyzpfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231262144"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 May 2026 22:43:47 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMfuC-000000001ej-2gVp;
	Tue, 12 May 2026 05:43:44 +0000
Date: Tue, 12 May 2026 13:42:56 +0800
From: kernel test robot <lkp@intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, Simon Horman <horms@kernel.org>,
	Allison Henderson <achender@kernel.org>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>,
	Maoyi Xie <maoyi.xie@ntu.edu.sg>
Subject: Re: [PATCH net v3] rds: filter RDS_INFO_* getsockopt by caller's
 netns
Message-ID: <202605121353.896RQym5-lkp@intel.com>
References: <20260511070211.1033178-1-maoyi.xie@ntu.edu.sg>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511070211.1033178-1-maoyi.xie@ntu.edu.sg>
X-Rspamd-Queue-Id: 0EE2651A7E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20457-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Maoyi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b266bacba796ff5c4dcd2ae2fc08aacf7ab39153]

url:    https://github.com/intel-lab-lkp/linux/commits/Maoyi-Xie/rds-filter-RDS_INFO_-getsockopt-by-caller-s-netns/20260512-045249
base:   b266bacba796ff5c4dcd2ae2fc08aacf7ab39153
patch link:    https://lore.kernel.org/r/20260511070211.1033178-1-maoyi.xie%40ntu.edu.sg
patch subject: [PATCH net v3] rds: filter RDS_INFO_* getsockopt by caller's netns
config: arm-randconfig-001-20260512 (https://download.01.org/0day-ci/archive/20260512/202605121353.896RQym5-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260512/202605121353.896RQym5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605121353.896RQym5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/rds/tcp.c:42:
   In file included from net/rds/rds.h:10:
   include/uapi/linux/rds.h:233:18: warning: field peer_addr within 'struct rds6_info_tcp_socket' is less aligned than 'struct in6_addr' and is usually due to 'struct rds6_info_tcp_socket' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     233 |         struct in6_addr peer_addr;
         |                         ^
>> net/rds/tcp.c:52:21: warning: variable 'rds_tcp_tc_count' set but not used [-Wunused-but-set-global]
      52 | static unsigned int rds_tcp_tc_count;
         |                     ^
>> net/rds/tcp.c:54:21: warning: variable 'rds6_tcp_tc_count' set but not used [-Wunused-but-set-global]
      54 | static unsigned int rds6_tcp_tc_count;
         |                     ^
   3 warnings generated.
--
>> net/rds/af_rds.c:46:22: warning: variable 'rds_sock_count' set but not used [-Wunused-but-set-global]
      46 | static unsigned long rds_sock_count;
         |                      ^
   1 warning generated.


vim +/rds_tcp_tc_count +52 net/rds/tcp.c

70041088e3b9766 Andy Grover       2009-08-21  41  
70041088e3b9766 Andy Grover       2009-08-21 @42  #include "rds.h"
70041088e3b9766 Andy Grover       2009-08-21  43  #include "tcp.h"
70041088e3b9766 Andy Grover       2009-08-21  44  
70041088e3b9766 Andy Grover       2009-08-21  45  /* only for info exporting */
70041088e3b9766 Andy Grover       2009-08-21  46  static DEFINE_SPINLOCK(rds_tcp_tc_list_lock);
70041088e3b9766 Andy Grover       2009-08-21  47  static LIST_HEAD(rds_tcp_tc_list);
1e2b44e78eead7b Ka-Cheong Poon    2018-07-23  48  
1e2b44e78eead7b Ka-Cheong Poon    2018-07-23  49  /* rds_tcp_tc_count counts only IPv4 connections.
1e2b44e78eead7b Ka-Cheong Poon    2018-07-23  50   * rds6_tcp_tc_count counts both IPv4 and IPv6 connections.
1e2b44e78eead7b Ka-Cheong Poon    2018-07-23  51   */
ff51bf841587c75 stephen hemminger 2010-10-19 @52  static unsigned int rds_tcp_tc_count;
e65d4d96334e3ff Ka-Cheong Poon    2018-07-30  53  #if IS_ENABLED(CONFIG_IPV6)
1e2b44e78eead7b Ka-Cheong Poon    2018-07-23 @54  static unsigned int rds6_tcp_tc_count;
e65d4d96334e3ff Ka-Cheong Poon    2018-07-30  55  #endif
70041088e3b9766 Andy Grover       2009-08-21  56  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

