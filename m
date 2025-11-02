Return-Path: <linux-rdma+bounces-14180-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 712E4C28EE4
	for <lists+linux-rdma@lfdr.de>; Sun, 02 Nov 2025 13:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C916A1889200
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Nov 2025 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291781FF1A1;
	Sun,  2 Nov 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvU3vDG/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6B34D39C;
	Sun,  2 Nov 2025 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762085086; cv=none; b=OOk/IsLoCIcE1C3vJ6BnqLd1JL1IU3EduRx6fMY715cov03AgKX98eUVu5Y4IqTfZdxb8JsXygyqhi9wzkrdgl/FHa2mFNqbIqKgwmy9Cmoy4pDF95gjsFzr6kiJpWMENO0jI4oflfVwourfWEduP6Us5cYB+mX56qUk5NlQw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762085086; c=relaxed/simple;
	bh=GQU2C7dWX/lfhnBUYHjHItoYV0Ug5QaeeEVHoTJ1kIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy/pbvOCKNzhaydsIeCQ+YuuUZAY23nfICogO68H/jiRSHqIlfAsLtz+y0Nb/IFXLYM4Ic9cjt7Tzv6uSWuW22OwrX2rdvtfhvni1HHBlPh67aj6rLx/Cza4XWNHZs5OiSVacsDzA0GPXN91NmPDWGWQka415G/nZkzFk00kYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvU3vDG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EAAC4CEF7;
	Sun,  2 Nov 2025 12:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762085086;
	bh=GQU2C7dWX/lfhnBUYHjHItoYV0Ug5QaeeEVHoTJ1kIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvU3vDG//qQ1kCfP1lCm2VAG3rg0HTh7NcMASr7lUBmWNleNuhK0qo8EwNk+uKpdo
	 Srkqkf/+xr0rbIPsrffWyjwYE3JvqxoPsG7IwjLmCQkim6Q7VJVrFOv8DuQemvgDFg
	 4hQJ4VCWq2KVkKapiZ+D/H0oUw7wLs0lCds/ouIvtseYEBUU2fLxrWlz+Okan9c1dh
	 D/xevHCrBMh+62tHZ4hX3Nx3/Qmwo3z0gJWDUrOyzW5SUlSzuw1mUpOuLefGjOwxM4
	 xlNxx6jHTFrgd78UIOr177rsJKIfjB8DbyuBlmOCGkzjuULaIzfin/K2owqgDXB8NR
	 pNvFp7+Ja5uGA==
Date: Sun, 2 Nov 2025 14:04:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, jgg@ziepe.ca,
	oe-kbuild-all@lists.linux.dev, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: Re: [PATCH rdma-next] RDMA/bnxt_re: Add a debugfs entry for CQE
 coalescing tuning
Message-ID: <20251102120441.GC17533@unreal>
References: <20251030171540.12656-1-kalesh-anakkur.purayil@broadcom.com>
 <202510312213.Pogyd6u5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510312213.Pogyd6u5-lkp@intel.com>

On Fri, Oct 31, 2025 at 11:08:30PM +0800, kernel test robot wrote:
> Hi Kalesh,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on rdma/for-next]
> [also build test WARNING on linus/master v6.18-rc3 next-20251031]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kalesh-AP/RDMA-bnxt_re-Add-a-debugfs-entry-for-CQE-coalescing-tuning/20251031-011453
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> patch link:    https://lore.kernel.org/r/20251030171540.12656-1-kalesh-anakkur.purayil%40broadcom.com
> patch subject: [PATCH rdma-next] RDMA/bnxt_re: Add a debugfs entry for CQE coalescing tuning
> config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251031/202510312213.Pogyd6u5-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510312213.Pogyd6u5-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510312213.Pogyd6u5-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/infiniband/hw/bnxt_re/main.c:70:
> >> drivers/infiniband/hw/bnxt_re/debugfs.h:37:27: warning: 'bnxt_re_cq_coal_str' defined but not used [-Wunused-const-variable=]
>       37 | static const char * const bnxt_re_cq_coal_str[] = {
>          |                           ^~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/bnxt_re_cq_coal_str +37 drivers/infiniband/hw/bnxt_re/debugfs.h
> 
>     36	
>   > 37	static const char * const bnxt_re_cq_coal_str[] = {
>     38		"buf_maxtime",
>     39		"normal_maxbuf",
>     40		"during_maxbuf",
>     41		"en_ring_idle_mode",
>     42		"enable",
>     43	};
>     44	

Right, it shouldn't be placed in header file. It needs to be in debugfs.c

Thanks

> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

