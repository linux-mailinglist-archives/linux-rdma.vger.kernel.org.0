Return-Path: <linux-rdma+bounces-15467-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27634D1386D
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 16:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 172A9301264B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414D32E0B6E;
	Mon, 12 Jan 2026 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lumYmJh3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF292BDC0E;
	Mon, 12 Jan 2026 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230817; cv=none; b=hoOlYE0CZ0JJqZhzP7BHqfqOB744nSDzO0hU95cnMXGFsutkL503OhNf8Blz6lBdSE1rRkFcJqcApme8c7EWlU8o0mPvt6r7jHFviBgF6+mlmztTNIwk2HWJ2aDxhM4wJj3t4rvLmcm5eQiLHigLjozmSWWsgOUjSH9GEgibpPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230817; c=relaxed/simple;
	bh=FH5lvgGlxlgcsI/c3Wc4LZGoA4WSMGev1ZgnwDVgbkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pW3B5hU+gNtS+E8mRN741XEszJDg8Er6qiHLbS9B/NiN/I1fQQdWY6W+kQ5jYNJ+lyB5YoHbjXDrvZeSFNijvXkoFw3ZuwfA2tpt68cJCfU9qx+n5DYJhtvMruu4u/J+m+9WLMaakwbyMzG24OKOWUFAbjPc0fPeh2j/aPXHZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lumYmJh3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768230815; x=1799766815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FH5lvgGlxlgcsI/c3Wc4LZGoA4WSMGev1ZgnwDVgbkw=;
  b=lumYmJh3lREzppEyuWTo96UN5qHsU6SL4JQMeIdp+CNHsYruHmIcldGb
   c5iXHEWz1RaJ2Et9I1WXmOddUjWq0imkB1AZPJ6jwZHnj8uKz8U7fMnL8
   zggojf93pYbJjHJ3U0FT0TD8Muq65qWKbG6/AtAUYafaNJBI7mNeKlb9R
   cPQWGpdu8HK3F6NzqjyIBlGDu4npJssEhuh5x618zfzjKS3KBQ530aYzx
   ldO0snRQhq6UiZvQOn4aoQIKY20Nvix6C6M72OA9/uYajeDjal+tZWWRy
   mWxxKA/MtX9sQdRYQ6PrYeeB6PfyvljQbBntcRhsL3FXmXzcglmLHeOjv
   A==;
X-CSE-ConnectionGUID: rVkuwlMYTtqccaomg/qjxg==
X-CSE-MsgGUID: AuS1hlPGRe+K/evU/xG+fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73349100"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73349100"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 07:13:34 -0800
X-CSE-ConnectionGUID: mwqoedS6SCmoCk5xw0p26g==
X-CSE-MsgGUID: imcgvPMSRA2CwgvMwt4IgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="208632334"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Jan 2026 07:13:29 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfJbi-00000000DUC-04q9;
	Mon, 12 Jan 2026 15:13:26 +0000
Date: Mon, 12 Jan 2026 23:13:09 +0800
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
Message-ID: <202601122216.BCarSN6K-lkp@intel.com>
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
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260112/202601122216.BCarSN6K-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601122216.BCarSN6K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601122216.BCarSN6K-lkp@intel.com/

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

