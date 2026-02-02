Return-Path: <linux-rdma+bounces-16379-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePoTHzE6gWmUEwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16379-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 00:58:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A635D2CB1
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 00:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4B903026147
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 23:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C936214A;
	Mon,  2 Feb 2026 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ky7Zgrep"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C75318ED4;
	Mon,  2 Feb 2026 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770076601; cv=none; b=d7mL9kIbNy85TpI2pYmvaGdnnJT8xKE4ti97jp/C/E4xo4T3zry2cdD06HF39EB5PtS2uv3tV3+zaq8kvEbZQyTyIPgHrh3hnorgIX1orRYHt1VNjggy96eJ1dm+E6jQZ/HwnPzK9dOvqKiq3vXoORl/TxRXWJy7rZsRqVd/sJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770076601; c=relaxed/simple;
	bh=ZtK3OYsfbQaKryYG3GNg+fYHVaBUJzVlFN3ArYyXJF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blN1lBXU6PunrBYgmDPKM7mik1avlQRUFvIkp2gy45zwonATP5RO6Q0dOAp75vrB53dn7EtDRs17YxqdbAs6Zj+qGBLWbB1CZq7I0wDhHGq+dt85TZXly6zUqYuG3UR8SRksnYHSxnpin+24KyOVIWYcvXtc4MCxODRhhEz5lwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ky7Zgrep; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770076599; x=1801612599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZtK3OYsfbQaKryYG3GNg+fYHVaBUJzVlFN3ArYyXJF8=;
  b=ky7Zgrepbjnt1tHdXF7XUGgB7ltSgtre73WqcbZxhVRHrsZxATLx3def
   2OWkQRnLZtE9eYEkd/lxGZZdE7HP52kHFe6wttgc64XBgBjqx6QuBpXSQ
   4zRgHPmxTK4FpLmmoFA6uj85Ft8RuLCjExtbJLQhFA2M00yp9KdAPEfSB
   PV9YAvku9i5cdIXnokWV9wFNkHklRTHmCzuFs6uH7DMLa5C2NaZmmz/6w
   FgFLh+utYDFuL/Y6JMQWQwEfXVBIbKqeufOzgKACALaQLdbA+eB2Zy2Gl
   if8yDnEebaCcGGQNvYoN1zb65TqRh1FOzcndpLdA+td1GIYc3OTghF+Vg
   g==;
X-CSE-ConnectionGUID: Gt5xiJodT22cx67zNaq2uA==
X-CSE-MsgGUID: p3nSC4x9Q2KYfmvwhgoU+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="75097557"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="75097557"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 15:56:35 -0800
X-CSE-ConnectionGUID: L+pyejYsRy6s24YSBOKrEw==
X-CSE-MsgGUID: cgdgIDZnThCzdIH8XF/Dyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="209135095"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 02 Feb 2026 15:56:29 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vn3mN-00000000g3Y-0ynt;
	Mon, 02 Feb 2026 23:56:27 +0000
Date: Tue, 3 Feb 2026 07:55:33 +0800
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
Message-ID: <202602030740.Jdw6BiOU-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[lists.linux.dev,google.com,intel.com,kernel.org,vger.kernel.org,lists.osuosl.org,redhat.com,resnulli.us,gmail.com,microchip.com,linux.dev,nvidia.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-16379-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A635D2CB1
X-Rspamd-Action: no action

Hi Ivan,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dpll-Allow-associating-dpll-pin-with-a-firmware-node/20260203-012705
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260202171638.17427-8-ivecera%40redhat.com
patch subject: [Intel-wired-lan] [PATCH net-next v4 7/9] dpll: Add reference count tracking support
config: parisc-randconfig-001-20260203 (https://download.01.org/0day-ci/archive/20260203/202602030740.Jdw6BiOU-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602030740.Jdw6BiOU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602030740.Jdw6BiOU-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from net/core/rtnetlink.c:61:
>> include/linux/dpll.h:235:1: error: expected identifier or '(' before '{' token
     235 | {
         | ^
>> include/linux/dpll.h:234:1: warning: 'fwnode_dpll_pin_find' declared 'static' but never defined [-Wunused-function]
     234 | fwnode_dpll_pin_find(struct fwnode_handle *fwnode, dpll_tracker *tracker);
         | ^~~~~~~~~~~~~~~~~~~~


vim +235 include/linux/dpll.h

877c40367bc8a7 Ivan Vecera 2026-02-02  232  
877c40367bc8a7 Ivan Vecera 2026-02-02  233  static inline struct dpll_pin *
bed78c2008cb37 Ivan Vecera 2026-02-02 @234  fwnode_dpll_pin_find(struct fwnode_handle *fwnode, dpll_tracker *tracker);
877c40367bc8a7 Ivan Vecera 2026-02-02 @235  {
877c40367bc8a7 Ivan Vecera 2026-02-02  236  	return NULL;
877c40367bc8a7 Ivan Vecera 2026-02-02  237  }
5f18426928800c Jiri Pirko  2023-09-13  238  #endif
5f18426928800c Jiri Pirko  2023-09-13  239  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

