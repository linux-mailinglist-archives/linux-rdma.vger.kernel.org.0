Return-Path: <linux-rdma+bounces-4063-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AFC93F2A5
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 12:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB971F222FF
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14937143C7D;
	Mon, 29 Jul 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m5rgXWsM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA212143873;
	Mon, 29 Jul 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248879; cv=none; b=kCeKt2ItW4qD1/hlodcbVjBYiW2GeU7NMlsb6JO5i40XbUG3V4FiCJ10cBaOHQ/zX6PjaxiI/7EdOZoMYNGp9YDAIdvCLWYB84QrZsuYseweT70x7ZtbKwgorrOphtieWBXHhfne16sqHxGt5DZ5V2Gh462unG06yNUsr1Wqfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248879; c=relaxed/simple;
	bh=Bt99ge3UUZGPkVxOwjK0CeLHXnSXdbcs1gevqufOntg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ewr2AD7j6paN+I8bqNEoQmyZMdU7LvqZjImdhhpJWEJ7F5Oj+TkdmmvlBNnk10Ua3CrPd+Q2CU8SiMd+yj17urmISGPAeIeti7pEd87ArKXBRtn3B/KSlhEo0K7HbVmBZQuOHp/Y4wxU5herIlrzJ81zq6zurc0HzsY6sPNAAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m5rgXWsM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722248878; x=1753784878;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Bt99ge3UUZGPkVxOwjK0CeLHXnSXdbcs1gevqufOntg=;
  b=m5rgXWsMaVGy12/4ilQY1djYu9Q37+mvkuxorQppjNccBnxkRHF69VSv
   KiGdSSeAEX/hU5SpG3MOEduL9QUY1Z1EgXjoww8z3uk/1C5i//BbHdJJd
   t2oCR7v6M8qgemiJyhWAaBBPQ0j8w2IfubWtIkOPvM1ytK1iEt5pHv+9a
   fXp1Y3qljI8FV3X2CnMh/7cEf8AUzJLzAwAzdVlGduFBSyrl4iICI0xW+
   u4Haa/T6xRwBjOXYkfKSn4Jl6x/qcm5AIjrTDB8FG+6V018IVCAnTxiB1
   WhoAZcl/Kb4OBf6+PjVAvrleACduwARVe+WwKJy8veHt/Ka6WNKcZdXJQ
   A==;
X-CSE-ConnectionGUID: TGJvmAnvS4aKhXpdVNx+lw==
X-CSE-MsgGUID: cwTsFYcJSZW1RrFCwrXejg==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="37502565"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="37502565"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 03:27:57 -0700
X-CSE-ConnectionGUID: Ynsp7EQmRje2W4uZXxa9yQ==
X-CSE-MsgGUID: ZV+fiUwNQXmPYSqHZqNgKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="77171478"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 03:27:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 29 Jul 2024 13:27:44 +0300 (EEST)
To: Matthew W Carlis <mattc@purestorage.com>
cc: macro@orcam.me.uk, alex.williamson@redhat.com, bhelgaas@google.com, 
    christophe.leroy@csgroup.eu, davem@davemloft.net, 
    david.abdurachmanov@gmail.com, edumazet@google.com, kuba@kernel.org, 
    leon@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, Lukas Wunner <lukas@wunner.de>, 
    mahesh@linux.ibm.com, Mika Westerberg <mika.westerberg@linux.intel.com>, 
    mpe@ellerman.id.au, Netdev <netdev@vger.kernel.org>, npiggin@gmail.com, 
    oohall@gmail.com, pabeni@redhat.com, pali@kernel.org, saeedm@nvidia.com, 
    sr@denx.de, wilson@tuliptree.org
Subject: Re: PCI: Work around PCIe link training failures
In-Reply-To: <20240726080446.12375-1-mattc@purestorage.com>
Message-ID: <914b7d34-9ed5-cd99-cb76-f6f8eccb842e@linux.intel.com>
References: <20240724191830.4807-1-mattc@purestorage.com> <20240726080446.12375-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 26 Jul 2024, Matthew W Carlis wrote:

> On Mon, 22 Jul 2024, Maciej W. Rozycki wrote:
> 
> > The main reason is it is believed that it is the downstream device
> > causing the issue, and obviously you can't fetch its ID if you can't
> > negotiate link so as to talk to it in the first place.
> 
> Have had some more time to look into this issue. So, I think the problem
> with this change is that it is quite strict in its assumptions about what
> it means when a device fails to train, but in an environment where hot-plug
> is exercised frequently you are essentially bound have something interrupt
> the link training. In the first case where we caught this problem our test
> automation was doing some power cycle tortures on our endpoints. If you catch
> the right timing the link will be forced down to Gen1 forever without some other
> automation to recover you unless your device is the one single device in the
> allowlist which had the hardware bug in the first place.
> 
> I wonder if we can come up with some kind of alternative.

The most obvious solution is to not leave the speed at Gen1 on failure in 
Target Speed quirk but to restore the original Target Speed value. The 
downside with that is if the current retraining interface (function) is 
used, it adds delay. But the retraining functions could be reworked such 
that the retraining is only triggered in case the Target Speed quirk 
fails but we don't wait for its result (which will very likely fail 
anyway).

-- 
 i.


