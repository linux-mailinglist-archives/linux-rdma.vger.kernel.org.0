Return-Path: <linux-rdma+bounces-15482-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8CD14E4A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 20:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20A8E302DCBF
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 19:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D303191D3;
	Mon, 12 Jan 2026 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4dq3UQu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD209318EF7;
	Mon, 12 Jan 2026 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768245599; cv=none; b=Mt8S1H76O/N5AuXbPW1rxFnJnhn0Z59TaxMvNArByAc5J8aypAzxroX+YO7RVHavG9LP69G5Er1CEYa0wSRk3r8jNORvzcE+/SOp2UeKa9ZPyFpEeYDPUEoVTfokzvRKxc6EOqU3wMQ+x48DEtrtLt+gGNK3xBpTOkX2W5ecGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768245599; c=relaxed/simple;
	bh=8XdDuYY8o16AHBqptf2+Lenxj/jSJqYCRVV3ayhVeHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdAXbHT7FlrxGay2lcXwgRa1Rboppo/j3zimxAabWQvRAOlykPwWWInCFhh/yFLgPUpdqsA2QUXqn8Lk4XZpoGsjiH1op+mGWh6MNVYmyIqtUXjXwY5+5M+nsKhQKxTnL2k8PApAVQb9llWLZkxeHkPWzoScKunyQgZqxLnPX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4dq3UQu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768245596; x=1799781596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8XdDuYY8o16AHBqptf2+Lenxj/jSJqYCRVV3ayhVeHI=;
  b=i4dq3UQuLJKe0UMkY2PBi/sS5UEiZ3MC7haLiYb2wmgqdc/r9+7O1WEC
   7Ay8FKRVgZtTkaET2HqF5Ag4qlGp+Tuh68Wo34iF6P9xLgEGo0ktY3QcM
   oVX3DoUho2NbqSw0qdtcuXRmsuevqrAr+8su1fQldrm7WU6UF9GLk5LzF
   DqfWhxXPNp/o6im2TYhqg5QA1L71qv+Fj2s0jMZH0P6+tl2ydfd+ADb3g
   zvuOO3kFYxMm++r/gQ+EWxiAKuvk1prCnw3KoArMCTCX4MwOtDkTt+AFT
   dfsJ83a0yu7EAB6u1CYpAzGS7hEajbO5DtfZ1oVJjGOPfs/WIZEANlnMu
   w==;
X-CSE-ConnectionGUID: rf9aYiOiSRaJWLL0AnWM1A==
X-CSE-MsgGUID: KYMo2/e6TDSyUUn11/mp+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69450951"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="69450951"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 11:19:54 -0800
X-CSE-ConnectionGUID: MXpzZ1xnR9iTu7OhIX4rXg==
X-CSE-MsgGUID: +gG6zgHgS7iFR/wRaFE7Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="203987512"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 12 Jan 2026 11:19:49 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfNS6-00000000Dme-1S2R;
	Mon, 12 Jan 2026 19:19:46 +0000
Date: Tue, 13 Jan 2026 03:19:09 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Rob Herring <robh@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-rdma@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Richard Cochran <richardcochran@gmail.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 06/12] dpll: Support dynamic
 pin index allocation
Message-ID: <202601130301.7QjXjwFp-lkp@intel.com>
References: <20260108182318.20935-7-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108182318.20935-7-ivecera@redhat.com>

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dt-bindings-dpll-add-common-dpll-pin-consumer-schema/20260109-022618
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260108182318.20935-7-ivecera%40redhat.com
patch subject: [Intel-wired-lan] [PATCH net-next 06/12] dpll: Support dynamic pin index allocation
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260113/202601130301.7QjXjwFp-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260113/202601130301.7QjXjwFp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601130301.7QjXjwFp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dpll/dpll_core.c:499:21: warning: overflow in expression; result is -2147483648 with type 'int' [-Winteger-overflow]
     499 |         pin_idx -= INT_MAX + 1;
         |                            ^
   1 warning generated.


vim +/int +499 drivers/dpll/dpll_core.c

   490	
   491	static void dpll_pin_idx_free(u32 pin_idx)
   492	{
   493		if (pin_idx <= INT_MAX)
   494			return; /* Not a dynamic pin index */
   495	
   496		/* Map the index value from dynamic pin index range to IDA range and
   497		 * free it.
   498		 */
 > 499		pin_idx -= INT_MAX + 1;
   500		ida_free(&dpll_pin_idx_ida, pin_idx);
   501	}
   502	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

