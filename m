Return-Path: <linux-rdma+bounces-11038-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302AAACF22B
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 16:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F77171E43
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 14:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664B16FF37;
	Thu,  5 Jun 2025 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GuCjIDEA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA43778F2B;
	Thu,  5 Jun 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134349; cv=none; b=fDQXDOiW3WEscG1xRlphklmL4P2jBn/Cqz2l6O1G62nC//IQxZ8BLMLpe3u9J5K5ynJKWR+fj0tiJxtn4irNnKBx4jJ2E/rgVA7Dc1ijkcrqWic1tJF/p251kjWuTlworczgbTO0WZ3MIBx8LHpNeyimPLAJ8LKe0rWY5Kbi2bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134349; c=relaxed/simple;
	bh=xLpKEOc8fA92QFRjW1J6rRuu45Xm62oHNsj8UqAmlzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOe/YVxvKxqnX+DEHHI1fz42DfIx6wYq0OB9MmlBWOLk/1DcqO/Gjeb0XfpfEpQjSHf9CIbPW3DQ37q/RpKcVOFsPy/k8CLQX/bK3BT8RKRchpaPh3V9Q0Wij0IOboqp5toNKw0L6YG65X1g0pACtY+i1SVYME5j9YvhTVn5rHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GuCjIDEA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7aizhFKosYRXj/8cXtw1gmVuAjL4hzqqXZZX38VaLYU=; b=GuCjIDEAIG1HbRH58bql6xqyV8
	90UmDU4JJtQF/WNHqOP77Nqu5xkYG8Yn+z4dF6wXA7vWpblIGEhsHuCDTXLWAJpkspcHCNV5gs4zu
	rOK19VcfR/zcGT7OrybHj6y969jfu4myNQlgr5+thc2hF7kbZKVPuL1H5o2LDNEctxTesAUgcdY3K
	IoPlvEPKm9ke418mrZcKK6c0+P16h9T5tdV6SKgJIrCNzq9VjI4rAx5HHRAHSfM/z2F7uHkVg+WyZ
	194Rjn0oa4J0gaq0iJhs/LKYBYTYhWA5GbsRFxkk3WOUrCvHpu80IRo8WCEnMD72MJV0PaOBw7+cr
	VAoHdaMw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNBkD-00000004Kor-33hj;
	Thu, 05 Jun 2025 14:39:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5E1330057C; Thu,  5 Jun 2025 16:39:00 +0200 (CEST)
Date: Thu, 5 Jun 2025 16:39:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-modules@vger.kernel.org, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] module: Make sure relocations are applied to the
 per-CPU section
Message-ID: <20250605143900.GV39944@noisy.programming.kicks-ass.net>
References: <202506041623.e45e4f7d-lkp@intel.com>
 <20250604152707.CieD9tN0@linutronix.de>
 <20250605060738.SzA3UESe@linutronix.de>
 <beb343ec-6349-4f9c-9fea-588b04eb49ee@suse.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb343ec-6349-4f9c-9fea-588b04eb49ee@suse.com>

On Thu, Jun 05, 2025 at 03:44:23PM +0200, Petr Pavlu wrote:

> For instance:
> 
> 	/*
> 	 * Don't bother with non-allocated sections.
> 	 *
> 	 * An exception is the percpu section, which has separate allocations
> 	 * for individual CPUs. We relocate the percpu section in the initial
> 	 * ELF template and subsequently copy it to the per-CPU destinations.
> 	 */
> 	if (!(info->sechdrs[infosec].sh_flags & SHF_ALLOC) &&
> 	    infosec != info->index.pcpu)
> 		continue;

Right, and pcpu is a data section and should not have relative
relocations, only absolute.

So copying things should not be a problem.

