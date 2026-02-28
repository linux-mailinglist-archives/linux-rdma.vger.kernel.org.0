Return-Path: <linux-rdma+bounces-17334-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LytLoLComls5QQAu9opvQ
	(envelope-from <linux-rdma+bounces-17334-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 11:25:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C8E1C208A
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 11:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80177303277B
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Feb 2026 10:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7CD41C2F7;
	Sat, 28 Feb 2026 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L1vpT7wm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352CD41C2E6
	for <linux-rdma@vger.kernel.org>; Sat, 28 Feb 2026 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772274303; cv=none; b=m1bAWCrtE98x6kDY0Kba/qyba+2719GUrPIiH3CE2n7Jg5IHa0JcnscT45pPnNJYy1wPD1wWtuXfudtuTtru7QOoFDdT30YBgJa8JtYgGu6y2sZtywreCq7pmZKZxdz29nojvJeAo9zhsBiqPUkJMzsj/HxR2eoD1hI7hS2cbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772274303; c=relaxed/simple;
	bh=qgxr04DzpqZuuvLJo39Vf9euXNTZ/DZ7hjmExj4iNdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrpIqqH8m9542VSUbJC78PGMLFcnJtG+oOURlTn3NU5IXE8OW/iE1HbAO7k0bmiECeEK5QA//rfIhR+1m2p5WEMaHqSYt6TB+KbGhqhLVuOcwxKWcr0KLpjS4DaYraXDa6EFFF9YAV20r4cC1h3Z59VoMNB4Vv2iiu74F5FVcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L1vpT7wm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772274301; x=1803810301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qgxr04DzpqZuuvLJo39Vf9euXNTZ/DZ7hjmExj4iNdE=;
  b=L1vpT7wmFG8KGLOns6WAVMjiwLXH3sz3FfDI3s3XupDlZ3sb0uOmU5qi
   8KHr4mCcy5p7sbKXU2HClbzut5QGYBWsGS/DlQh1hUHibvDmKx+1VL/qA
   sLTCMIsY+4DKS9SFeedhnyOEgbeA0vqE/kmdZHKXsalnw/8IuRB+XrQkN
   hl8VXDNNBRRU9AR4CQ4bUMOTT6O2RIG4VJTzdiiFtmST5WKbMFx+FJez9
   D8bLRDwU2P+uPjtb9L+hJsTjoitJ0cOSNpAiwnEBlriEyrlOaAX5403vR
   lO0YE9D7FgXf3PbJM6NCwuuf5rLZ6yoDENaKiimps2b+R98KKG3ifmCtg
   w==;
X-CSE-ConnectionGUID: 59kAyCuPR/Ga78yE5z6m2g==
X-CSE-MsgGUID: wt6tFUbuQsuiuLNoyplzrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="77216647"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="77216647"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 02:25:01 -0800
X-CSE-ConnectionGUID: +rmd393YT4S5jGy/dmhnNg==
X-CSE-MsgGUID: tryl4o5iRDSH9797dWTdIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="214914795"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 28 Feb 2026 02:24:58 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwHVI-00000000BSh-00XA;
	Sat, 28 Feb 2026 10:24:56 +0000
Date: Sat, 28 Feb 2026 18:24:21 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH v2 03/13] RDMA: Add ib_copy_validate_udata_in()
Message-ID: <202602281856.cOumhTuc-lkp@intel.com>
References: <3-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17334-lists,linux-rdma=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F0C8E1C208A
X-Rspamd-Action: no action

Hi Jason,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3f4a08e64442340f4807de63e30aef22cc308830]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Gunthorpe/RDMA-Use-copy_struct_from_user-instead-of-open-coding/20260227-093947
base:   3f4a08e64442340f4807de63e30aef22cc308830
patch link:    https://lore.kernel.org/r/3-v2-13af4a900857%2B4f13-bnxt_re_uapi_jgg%40nvidia.com
patch subject: [PATCH v2 03/13] RDMA: Add ib_copy_validate_udata_in()
config: i386-randconfig-141-20260227 (https://download.01.org/0day-ci/archive/20260228/202602281856.cOumhTuc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602281856.cOumhTuc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602281856.cOumhTuc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/rdma/uverbs_std_types.h:10,
                    from drivers/infiniband/core/uverbs.h:49,
                    from drivers/infiniband/core/nldev.c:44:
   include/rdma/uverbs_ioctl.h: In function '_ib_copy_validate_udata_in':
>> include/rdma/uverbs_ioctl.h:964:17: error: 'EVINAL' undeclared (first use in this function); did you mean 'EINVAL'?
     964 |         return -EVINAL;
         |                 ^~~~~~
         |                 EINVAL
   include/rdma/uverbs_ioctl.h:964:17: note: each undeclared identifier is reported only once for each function it appears in


vim +964 include/rdma/uverbs_ioctl.h

   959	
   960	static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
   961						     size_t kernel_size,
   962						     size_t minimum_size)
   963	{
 > 964		return -EVINAL;
   965	}
   966	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

