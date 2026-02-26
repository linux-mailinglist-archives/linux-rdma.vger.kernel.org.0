Return-Path: <linux-rdma+bounces-17231-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPuCHB5YoGkNigQAu9opvQ
	(envelope-from <linux-rdma+bounces-17231-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:26:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D6A1A781C
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F54A317AE96
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FA3361677;
	Thu, 26 Feb 2026 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehUMl2x+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD73A7F5F
	for <linux-rdma@vger.kernel.org>; Thu, 26 Feb 2026 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115185; cv=none; b=dYZSGffojIm6/6m/bGx/FPR2feBnLSA2tNk7Sx465n8nw92fJdjrqJn+6o4ZbJwT+7WVrybMPQ0wTrkjR6yBMkK+x84hrszb0X8QC3Q1pWkKX1aQdE1H/UDU0qzYuJXsmPkKrYaZ1PoOwa65088LEvPmHRwrf27k+J6wkZ71MZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115185; c=relaxed/simple;
	bh=YHkYLJkrxQKk8P3iPcTfm92Eyr6TvYztuyrgZ91uuWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsIMa8NYC2rJjBacodYx6pVoGwDLP0ItWBkKaEIxS18IwoI/iV111MdWMBbJhcso8UoJhIBlYbTnrAGnruj2H8u39DjYgu+avAb8A8Tq20mhUF90+HyyRUBYdqtBm33EiQqcFYpA4ale+9iVcmn0tgpReNMWYTghjgOfZYkh33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehUMl2x+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772115184; x=1803651184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YHkYLJkrxQKk8P3iPcTfm92Eyr6TvYztuyrgZ91uuWI=;
  b=ehUMl2x+dUeMUvmZFFkY7voASqHLcGz9h5wAp1yzl5+b+kw+F6F8v328
   0MKDE1oGXskksCS1MIxzvGtx0s1bp4FPMDZ2qrHFX0GpVxG8kwOmrCCqf
   qelnFprZiRZ1I6MiPKU+dzSE5NkKJc+Fti+4S/ItZoeBQFHpOpIMkWA2v
   sc2dmjmLknw4YQ4BXxYWV8ztJ8tDwHPB+aBxuiIIFCyVl6N6GI3KvNIW0
   G8vsqEgqQaoLCi9cgOoOzz7omsbZGCdZ49pkdtiKJszbKKGVFDtsBzjZ2
   35IkFwbpbAm6zneyv8IygRMXbz0fJSuSke6rCguUhc8+8XONEV8+/GTv4
   w==;
X-CSE-ConnectionGUID: figWlFg2QnKLrGkJT7mnrg==
X-CSE-MsgGUID: tcvpSbPXQ4+sF7ssBmtrqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="72386376"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="72386376"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 06:13:03 -0800
X-CSE-ConnectionGUID: EN3QXzL7T4uiHr0/EEQO/Q==
X-CSE-MsgGUID: 75l5kbGFQlO/0GZKybbXOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="221089488"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 26 Feb 2026 06:13:02 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvc6t-000000009TD-1C9I;
	Thu, 26 Feb 2026 14:12:59 +0000
Date: Thu, 26 Feb 2026 22:08:15 +0800
From: kernel test robot <lkp@intel.com>
To: David Ahern <dsahern@kernel.org>, zyjzyj2000@gmail.com, jgg@ziepe.ca,
	leon@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Add network namespace support
Message-ID: <202602262248.Yp5zxM1F-lkp@intel.com>
References: <20260225172622.7589-1-dsahern@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225172622.7589-1-dsahern@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17231-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,git-scm.com:url,01.org:url]
X-Rspamd-Queue-Id: D1D6A1A781C
X-Rspamd-Action: no action

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rdma/for-next]
[also build test WARNING on linus/master v7.0-rc1 next-20260225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Ahern/RDMA-rxe-Add-network-namespace-support/20260226-012818
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20260225172622.7589-1-dsahern%40kernel.org
patch subject: [PATCH] RDMA/rxe: Add network namespace support
config: x86_64-randconfig-r064-20260226 (https://download.01.org/0day-ci/archive/20260226/202602262248.Yp5zxM1F-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260226/202602262248.Yp5zxM1F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602262248.Yp5zxM1F-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: rxe_net_exit+0x3 (section: .text) -> rxe_net_ops (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: rxe_net_init+0x18 (section: .text) -> rxe_net_ops (section: .init.data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

