Return-Path: <linux-rdma+bounces-15420-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00774D0C8E7
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Jan 2026 00:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEE32302036B
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 23:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549433D6CE;
	Fri,  9 Jan 2026 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYm+8HnE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE2B248861;
	Fri,  9 Jan 2026 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001737; cv=none; b=I3DQp9vavdpwYjqot/i6swbchb84VkYVFRwIADbyXi0mESmJ9zk9AEKXCGxnyLR4BamuH503mJ8mIHe5H++QI7t4GPsn7N93oN5DpuHek4iyjunBPxmg/pQQ3HmYIY+0iQSr+/2amCqw70k5q+BqOU3Nhgc4lLx4lYvcQIEriWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001737; c=relaxed/simple;
	bh=Q1c6SA9SoZegHQaoQsX+njuHjd1iEf1cuhLBY5bV4qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRY187e8piMwxxLznaC6VdlrLUnM1HuvSVcJSWqupeSeygpTTOl8XFZ75HbJDtAfY3qwUVNSSgc/Dm6RRMwQvvGhOGURiZjhCAVL3/6qCwfw6xbzOuadwxnBRe9IFfgx0L4RA68ICb5W/ArXMpM+cmpW+VCpMDK7dmgf1FrdxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYm+8HnE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768001734; x=1799537734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q1c6SA9SoZegHQaoQsX+njuHjd1iEf1cuhLBY5bV4qc=;
  b=QYm+8HnE/GeU0Lj3kPM1b4mrGRdcO8UuvkLLbDsai/9j8JoJ32KvCUtv
   7SnD7hVH/hp3H0f3Z1SuD2+xm4HJuvkI1NQrNWYpTjtIcrB9L+ShfrjA0
   E+Az99zUbasWShN+T/prAaTC1PFYAvNXQlv/hHh/HMKCiowd9CsYA/dGF
   T6zCM10OAzu0nu1HITGiqH2RLZLyAMj9xdaMaKaKxNbeHOxSrlYE3R9VW
   IQoL1DWk3yU6lwMCl6kvMpU4nhbjtO29H+RLptqD76guspmOe9lukMmCO
   4aJ0MF0d4wXpNh6+UaTZc0ACZo2Shk9aEbdQgaQQi7MGnJY1AcPPVZ1vr
   w==;
X-CSE-ConnectionGUID: 4xDe1tctQcibag/Hy1lbOg==
X-CSE-MsgGUID: oY4fxBmFR9Kx/njJH4s2cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="79679452"
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="79679452"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 15:35:33 -0800
X-CSE-ConnectionGUID: DA3EGJ76THe/Sdvdi4NDSw==
X-CSE-MsgGUID: e0/EJjYbTDuy6c6td88RCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,215,1763452800"; 
   d="scan'208";a="203662294"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 09 Jan 2026 15:35:27 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1veM0r-0000000029k-15Ib;
	Fri, 09 Jan 2026 23:35:25 +0000
Date: Sat, 10 Jan 2026 00:34:30 +0100
From: kernel test robot <lkp@intel.com>
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
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
Message-ID: <202601100030.nDiAPf7k-lkp@intel.com>
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
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260110/202601100030.nDiAPf7k-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260110/202601100030.nDiAPf7k-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601100030.nDiAPf7k-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dpll/dpll_core.c: In function 'dpll_pin_idx_free':
>> drivers/dpll/dpll_core.c:499:28: warning: integer overflow in expression of type 'int' results in '-2147483648' [-Woverflow]
     499 |         pin_idx -= INT_MAX + 1;
         |                            ^


vim +499 drivers/dpll/dpll_core.c

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

