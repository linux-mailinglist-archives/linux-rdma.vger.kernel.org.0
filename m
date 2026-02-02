Return-Path: <linux-rdma+bounces-16376-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGl0JAUcgWm0EAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16376-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 22:49:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B31D1D53
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 22:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF4413008257
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 21:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FEA2BEFF1;
	Mon,  2 Feb 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKYcQ3L1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F593128D2;
	Mon,  2 Feb 2026 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068972; cv=none; b=jBT1dsdjx/iSgE2IItfHA4G3s6BgHR2LLCBlGm+rVbynppTyZNMIPhWfsI/9FnxO3ByqppVS+MA2trGiN62bLpcZm+KmBb2leyZyULbB0GzDBn2fnFy5eE9lujnx5LqNHZ8Cw5BrfwjO0mVfYIn3BShw5pJ3kYY560ypXkJL1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068972; c=relaxed/simple;
	bh=EY2CrS28kRVeb7uWnMWJfY8xjXKXRdCHiuTKy5sQkoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhUd6JJ1bx97T3jXMyI80u4O8IHCHQJPKglNn78RQWfl9XAighO1EFcwhAn7UbYZU74CwD7AUT5jMeHHkLYuvY0aGt94x/lqy8Uiv2Us1U904UK+wjro89bMVuiNiu6t731lZ8j2N07zjbERXCqo4e2jGQbUNC41mvCONTkRZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKYcQ3L1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770068970; x=1801604970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EY2CrS28kRVeb7uWnMWJfY8xjXKXRdCHiuTKy5sQkoY=;
  b=bKYcQ3L1AlHtTx3aL3vINnmlrJcTWTV6JnNoVpMC3EQsPEtmRHmHWAJB
   dgptjY9N5Kot5pOko6ts1ab6b8O44jrgbtqZXhhnr5iRaSPPWc/iMVD2X
   6n59WqhjMpg0CZy84KMj4SarOsZZcISyRMzpwIB96B+9PgLOo0DylPFEX
   ah1kQP7GvM/X7AOAHCfVeQySIts0XkZ8d5Jik7jszVh4rHjXB+n1dxBKJ
   R62cBqbpYYSjEeJuWV+rbTr7+UGvHFEeraMEWgFKIXD5HdvRPx2Y7ndib
   OJWa5XTPbHXhjsE/pn9ZAAMjRX/rcjS9BRsU67ibRnLlU/x5Ft0GWFAuA
   Q==;
X-CSE-ConnectionGUID: iYpCt/ImSmiCj4tnMUqnOg==
X-CSE-MsgGUID: gzLtq9edQOKRvrB0HrbDVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71317560"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71317560"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 13:49:30 -0800
X-CSE-ConnectionGUID: 1mLhGU+kRviswRU3MKb1ZA==
X-CSE-MsgGUID: 3/hN4atiQQuJCR8s9tAfFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="208743963"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Feb 2026 13:49:24 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vn1nN-00000000fzM-1pxx;
	Mon, 02 Feb 2026 21:49:21 +0000
Date: Tue, 3 Feb 2026 05:48:33 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-rdma@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Richard Cochran <richardcochran@gmail.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 7/9] dpll: Add reference
 count tracking support
Message-ID: <202602030538.6ok1xugA-lkp@intel.com>
References: <20260202171638.17427-8-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202171638.17427-8-ivecera@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[lists.linux.dev,google.com,intel.com,kernel.org,vger.kernel.org,lists.osuosl.org,redhat.com,resnulli.us,gmail.com,microchip.com,linux.dev,nvidia.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-16376-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35B31D1D53
X-Rspamd-Action: no action

Hi Ivan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dpll-Allow-associating-dpll-pin-with-a-firmware-node/20260203-012705
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260202171638.17427-8-ivecera%40redhat.com
patch subject: [Intel-wired-lan] [PATCH net-next v4 7/9] dpll: Add reference count tracking support
config: i386-randconfig-141-20260203 (https://download.01.org/0day-ci/archive/20260203/202602030538.6ok1xugA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602030538.6ok1xugA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602030538.6ok1xugA-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/core/rtnetlink.c:61:
>> include/linux/dpll.h:235:1: error: expected identifier or '('
     235 | {
         | ^
   1 error generated.


vim +235 include/linux/dpll.h

877c40367bc8a7 Ivan Vecera 2026-02-02  232  
877c40367bc8a7 Ivan Vecera 2026-02-02  233  static inline struct dpll_pin *
bed78c2008cb37 Ivan Vecera 2026-02-02  234  fwnode_dpll_pin_find(struct fwnode_handle *fwnode, dpll_tracker *tracker);
877c40367bc8a7 Ivan Vecera 2026-02-02 @235  {
877c40367bc8a7 Ivan Vecera 2026-02-02  236  	return NULL;
877c40367bc8a7 Ivan Vecera 2026-02-02  237  }
5f18426928800c Jiri Pirko  2023-09-13  238  #endif
5f18426928800c Jiri Pirko  2023-09-13  239  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

