Return-Path: <linux-rdma+bounces-20787-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEXWEJBmB2oF1wIAu9opvQ
	(envelope-from <linux-rdma+bounces-20787-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 20:31:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA05563F9
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 20:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2243B30F579D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 18:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E43B3EEAE4;
	Fri, 15 May 2026 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9Mq9SYL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB083EEAED
	for <linux-rdma@vger.kernel.org>; Fri, 15 May 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869509; cv=none; b=cNoamqcR5buNr1ahLYWkO2ckV8bj4BbOhUzejUp8esj59i+eOyNqVUeJwAxojrYpnkUkuzrBSu0ZpmVlg+21AFPDE2arpjO16pbAszsGFCIoGAsRGPrBkuGOR8pJh+O+nROxXlbncxxCp1z5+M73vRlkPj8bKab3gd7IkdKYyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869509; c=relaxed/simple;
	bh=zEvMci9pxnTIa7WoY+kD0AnU5pBy99MDwm1K5SsIF78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vol1yCRLQnShm+EKC/mByKMwLcprduqJslbrO1i49auuiggrFntHCJSgI56Htl0I6zcFYnj2s3/KZmfyH30Yoa9xWlpGuaTJdBU3Vrkyu5nD1qLt+CFzVusf+HE4HXJ++E5KwGOhyrqVBn6BQj5ABlP5aJ2IwWH0uzDiaEt0Sw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9Mq9SYL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778869508; x=1810405508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zEvMci9pxnTIa7WoY+kD0AnU5pBy99MDwm1K5SsIF78=;
  b=k9Mq9SYLl2KV2sz6il+Y9+sVmGnK4YDIqkp0eC3cV8UIZWXN8VqBKn2g
   pyt2+6CqhI5wa6xlW+UMFTOdJktND0Be/tVxJ3b0BF3KVwane5R5vjsoo
   ciaEIEIUa+6x8pzRKORp1AzxHG0ycODzcdV6FgtIrT3VRxoH7S+9yWo9R
   5a65OyJGOBP6DIWw9f61bV9ClY5u0LtwYS4J/qFyTI4TZ3ra0zOUq6ak+
   u+fDWjNV8qK5X11j2EMAxKQ2lrfTS58tUUHMWu75/F7M304daq2LRv+A1
   cNXpl+KqCagUKTPi7iqOQhbWwpvBBj8omFL1QLuMZrtiJIOWmtLmuxFOo
   w==;
X-CSE-ConnectionGUID: WceaN9DiRuyOrDnYGPy3cA==
X-CSE-MsgGUID: Y6VSztZXQGyzLJ/4rrK7Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="90525240"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="90525240"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:25:07 -0700
X-CSE-ConnectionGUID: RL+DVIDDRHy+sE4xVGPatw==
X-CSE-MsgGUID: 9V3VLIdnQ5mRy8Bcq/vpWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="242757890"
Received: from lkp-server02.sh.intel.com (HELO 7a33ad3e7d27) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 15 May 2026 11:25:06 -0700
Received: from kbuild by 7a33ad3e7d27 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNxD2-000000002X3-40Le;
	Fri, 15 May 2026 18:24:36 +0000
Date: Sat, 16 May 2026 02:23:56 +0800
From: kernel test robot <lkp@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH 6/6] RDMA/core: Move flow related functions to
 ib_uverbs_support.ko
Message-ID: <202605160258.313mCXe3-lkp@intel.com>
References: <6-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
X-Rspamd-Queue-Id: 57AA05563F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-20787-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,01.org:url]
X-Rspamd-Action: no action

Hi Jason,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 254f49634ee16a731174d2ae34bc50bd5f45e731]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Gunthorpe/RDMA-core-Move-the-_ib_copy_validate_udata-functions-to-ib_core_uverbs/20260515-124950
base:   254f49634ee16a731174d2ae34bc50bd5f45e731
patch link:    https://lore.kernel.org/r/6-v1-045258567bd6%2B9fe-ib_uverbs_support_ko_jgg%40nvidia.com
patch subject: [PATCH 6/6] RDMA/core: Move flow related functions to ib_uverbs_support.ko
config: x86_64-randconfig-123 (https://download.01.org/0day-ci/archive/20260516/202605160258.313mCXe3-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260516/202605160258.313mCXe3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605160258.313mCXe3-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/infiniband/core/ib_core_uverbs.c:429:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected int ( * )( ... ) @@     got int ( [noderef] *__v )( ... ) @@
   drivers/infiniband/core/ib_core_uverbs.c:429:16: sparse:     expected int ( * )( ... )
   drivers/infiniband/core/ib_core_uverbs.c:429:16: sparse:     got int ( [noderef] *__v )( ... )

vim +429 drivers/infiniband/core/ib_core_uverbs.c

   419	
   420	uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata)
   421	{
   422		struct uverbs_attr_bundle *bundle =
   423			rdma_udata_to_uverbs_attr_bundle(udata);
   424		struct bundle_priv *pbundle =
   425			container_of(&bundle->hdr, struct bundle_priv, bundle);
   426	
   427		lockdep_assert_held(&bundle->ufile->device->disassociate_srcu);
   428	
 > 429		return srcu_dereference(pbundle->method_elm->handler,
   430					&bundle->ufile->device->disassociate_srcu);
   431	}
   432	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

