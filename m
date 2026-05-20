Return-Path: <linux-rdma+bounces-21030-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I86OGWBDWrUyQUAu9opvQ
	(envelope-from <linux-rdma+bounces-21030-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 11:39:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9B58AEE9
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7569E30620FF
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 09:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EC03C9EEE;
	Wed, 20 May 2026 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TX/RVl0s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE43C9888;
	Wed, 20 May 2026 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269818; cv=none; b=KO2IR6gzE7e36aw3D0cWeFekP5kmvykWAU9OmP5rxf0832WTAtYgdN0Vag6yn66A3UZMdfp004pjNlK8HPADUoB6Stvyp/DTqdqMmdVjYOMHJbpHxHMO7eXH0e2JjzJKv1T3ypFdA85ml7vaft7xilbVJUyl8WcQ/vLu5N5OZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269818; c=relaxed/simple;
	bh=MKx+Ty10TaoeZJ5q8WkDOwfGzFRcJF9CsGFBUgLYLdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXqXyxfhRM/FRWEhnBr8h7lMLklF31INzxbJeTR2JR+E9xwZecer2nVwN47p90M6sSq+Wf/VWQtlwk4vDUjSrskYahwKepex5OihpCqinrrtEkhlsB8pQs6N4o8An2BpgncRMmS3nUUw9U1H4ZgOIKlC/5+hSxKuRc9YNhXBjbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TX/RVl0s; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779269814; x=1810805814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MKx+Ty10TaoeZJ5q8WkDOwfGzFRcJF9CsGFBUgLYLdg=;
  b=TX/RVl0stWQkNEymj3Za5b/AERonXgxSKIc4fMUTMttIuOPy+GmtVJ9H
   ui32rP2xS9t0dqgKiBoLIx1gIvSncgKAr4gjGA15yQQh1PLKmVmZqtyHf
   IcT1UvcdsAvrvZu7dB63ykv5ISHlCXWqEwFzyB4s3Zj6mW31x01qdrtcG
   ghJcuaMow2S1knCXMbfW/ne9TgaCoGN+F5BcQ0aJ551jIE8pOn0nREhvu
   YNxZnTMxa40F98vf9RGec+yH81mniYjJ8wrPMZgqlCBKjeNNnwmyArlt8
   JU4nEwXkgHCTqa4zhkQw7YfHp7MRcK04uYYKYDaJTsQZSCF/yCPd14ugj
   g==;
X-CSE-ConnectionGUID: AqC7veb8Q064/jCKgdW/+A==
X-CSE-MsgGUID: o7Tc+bnLTGGpTPYI7qpXxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79310765"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="79310765"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 02:36:53 -0700
X-CSE-ConnectionGUID: ZmIhuF4bRAyagXLFbJ3g+Q==
X-CSE-MsgGUID: j2qBrrkfT1Ou413/Rh0Dww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="239113754"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 20 May 2026 02:36:51 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPdLf-000000002v7-3LdC;
	Wed, 20 May 2026 09:36:24 +0000
Date: Wed, 20 May 2026 17:35:48 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: remove extraneous dummy helper functions
Message-ID: <202605201724.StvoCZ6d-lkp@intel.com>
References: <20260519203629.1341667-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519203629.1341667-1-arnd@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-21030-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 5FF9B58AEE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.1-rc4]
[also build test ERROR on linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/RDMA-core-remove-extraneous-dummy-helper-functions/20260520-044317
base:   v7.1-rc4
patch link:    https://lore.kernel.org/r/20260519203629.1341667-1-arnd%40kernel.org
patch subject: [PATCH] RDMA/core: remove extraneous dummy helper functions
config: hexagon-randconfig-002-20260520 (https://download.01.org/0day-ci/archive/20260520/202605201724.StvoCZ6d-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260520/202605201724.StvoCZ6d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605201724.StvoCZ6d-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: _ib_copy_validate_udata_in
   >>> referenced by siw_verbs.c:1373 (drivers/infiniband/sw/siw/siw_verbs.c:1373)
   >>>               drivers/infiniband/sw/siw/siw_verbs.o:(siw_reg_user_mr) in archive vmlinux.a
   >>> referenced by siw_verbs.c:1373 (drivers/infiniband/sw/siw/siw_verbs.c:1373)
   >>>               drivers/infiniband/sw/siw/siw_verbs.o:(siw_reg_user_mr) in archive vmlinux.a

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_STMFX
   Depends on [n]: HAS_IOMEM [=y] && I2C [=y] && OF [=n]
   Selected by [y]:
   - PINCTRL_STMFX [=y] && PINCTRL [=y] && I2C [=y] && HAS_IOMEM [=y]

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

