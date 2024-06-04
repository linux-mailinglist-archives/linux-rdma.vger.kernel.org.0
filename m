Return-Path: <linux-rdma+bounces-2844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617818FB7E2
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF4C2830E8
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FE5146D49;
	Tue,  4 Jun 2024 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jl02ARun"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676A50A6D;
	Tue,  4 Jun 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515927; cv=none; b=Ku8/pKhgMxDwb6y5h7wLR2AMByvPyGfLpLkGjqYAyGlt8e9gckeq3Phvp8COpBBfyfTPAU0t8m+UWyhpUf44X1oW3rhDJ2h9maiMn/cx0Jbu2KaNC33wE//MlYAHSZfW4S0nKwHFo4g7xUBgF+Ke+1yM7HRPTnDKDHM/INyt/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515927; c=relaxed/simple;
	bh=fxhufSj1kMUMH8lKvvr/CVA0StD+PGE7fnR3oK/5h8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ivth4cfC7ruO8kYTnE3A4+ZYBrQ6rJqoTo3p6G+M1J8qMQUMgZJrQWu66sPgUjdIUrbUkmIxhd2ETG3O+N2lCXJvCdu7Xc3qfSS46/Id1wuK58KylQ6t8gyIL9RCEfRIkORFH6MdvYndsnVa/1a1hVMQbDOcuDL5IiXbPt2eojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jl02ARun; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717515926; x=1749051926;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=fxhufSj1kMUMH8lKvvr/CVA0StD+PGE7fnR3oK/5h8s=;
  b=jl02ARunw6bSXMeehE8arEYWrNRDjacWMaq6X15RXj24BNLV/5kXGHnX
   SGKbHHQfP6z3GBL/1CgwgKotOzefEeyWBC2lMEgG3qr/6o/fjrg/OciLl
   CqXYr75LKBQxkcbQPOlYMd7zhJRA3AoZkQoW5YGYVFDZ1aA1KFOcgGb3a
   lVqQs0+nG0WKFxZp9zcPPf2KfM+Yojsp0Nqhr+cuWXzE9xA0aTK+2IklG
   SPMPJs5GwB3nUf3IkjsVBmEp5XmpM5UKLNLUdqlIZzuBLDSesrpVGjn3m
   2tDwZ2xhFgiLJnwZrxoCWrK+MOAWR9o0BaQnKMBu9oaD+nWe2QIRpSCXw
   A==;
X-CSE-ConnectionGUID: 2He3MRpISvmlopd40SQTNA==
X-CSE-MsgGUID: zujNSxsVRkaHR4FlYEXBxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25186329"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="25186329"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:45:25 -0700
X-CSE-ConnectionGUID: VTXMJTn+TjeA9zQFUPRCKA==
X-CSE-MsgGUID: 0hBBlcbISreYSez/xGyHCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="42390458"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 08:45:21 -0700
Date: Tue, 4 Jun 2024 18:45:28 +0300
From: Imre Deak <imre.deak@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Tejun Heo <tj@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>,
	Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <Zl82mAP7EakKzVRg@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <Zl8k/8/yQLnZcGd3@ideak-desk.fi.intel.com>
 <665f30d54276e_4a4e629427@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <665f30d54276e_4a4e629427@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Jun 04, 2024 at 08:20:53AM -0700, Dan Williams wrote:
> Imre Deak wrote:
> > Hi,
> > 
> > [Sorry for the previous message, resending it now
> >  with proper In-reply-to: header added.]
> > 
> > I see a similar issue, a corruption in the lock_keys_hash while
> > alloc_workqueue()->lockdep_register_key() iterates it, see [1] for the
> > stacktrace.
> > 
> > Not sure if related or even will solve [1], but [2] will revert
> > 
> > commit 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> > 
> > which does
> > 
> > lockdep_register_key(&dev->cfg_access_key);
> > 
> > in pci_device_add() and doesn't unregister the key when the pci device is
> > removed (and potentially freed); so basically 7e89efc6e9e4 was missing a
> > 
> > lockdep_unregister_key();
> > 
> > in pci_destroy_dev().
> > 
> > Based on the above I wonder if 7e89efc6e9e4 could also lead to the
> > corruption of lock_keys_hash after a pci device is removed.o
> 
> Are you running with the revert applied and still seeing issues?

The revert is not yet applied and so [1] happened with a kernel
containing 7e89efc6e9e4.

[1] https://intel-gfx-ci.01.org/tree/drm-tip/IGT_7875/bat-atsm-1/dmesg0.txt

