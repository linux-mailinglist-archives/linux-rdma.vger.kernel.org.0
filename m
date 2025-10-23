Return-Path: <linux-rdma+bounces-14015-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E05C01137
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF493AC2F9
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC06313551;
	Thu, 23 Oct 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khIBllnt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B7431065A;
	Thu, 23 Oct 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222004; cv=none; b=WWFAHEh3aIIHVzcu4T6OHUmX5yKBxKx3tgkibRlTiUOn/eVGW9p7Tg3LyL12zo6hrqlCSM6FmGq3IE+zzMAR8Vsh6ymNUX5Qtr1kSu9nzeS2wg5BucJky1+t7vecVCx0ShsIzBTX649ILJIKHE4Q9Q5NLowjEt/Fe21y1PpmJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222004; c=relaxed/simple;
	bh=0BdvxipZ7Z8089xLEyq2Gdq4U4r8rrCMVqe6yDIXHms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZgwmKDPeogIQ2V7gdFr0pNvnainxim7MxVAvk7rmA+3SNGhW50DUyWWRLCuSkHK/Ok4UOqsUT93EAa5r6QN3v0GIObtk6u4E62StoyGfJ9WcwCwYepTwb7Gv80uRY82kJ3QdjgM6ES+W+xSI+/DIBX0L0kFoemy/CfTaxOeZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khIBllnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C96C4CEE7;
	Thu, 23 Oct 2025 12:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761222003;
	bh=0BdvxipZ7Z8089xLEyq2Gdq4U4r8rrCMVqe6yDIXHms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khIBllnt5MbiMfUYcunriE0lBqGx1MNV3SaywVPSlsZ3wQ7s64CxJyfjUI7rQOILL
	 VUjHpFptN4ORPJHD+QgIBwXHYSV7kfimzttUfPAdVFUBdDCYqSW7oH4z3KDkNUFbEJ
	 MDPHB7l9tb9sLIDOefcI6HxL/vJAMb8zBasoub/teJ2cz3hNyPeggdHhVGeZ/2Vyhv
	 VWU0xlYUhhIFp/+CAtyx5tgj+VMxpc/GrbfAsmcarpIpYTNlH2q+ukenezA1qpapJl
	 MuN+4ZAuR+oLGvt4Lvh4PZ96qzq9/YoEChkhuZJ1KySztuIQAs2dH7wkqky2Hq72oF
	 /qRuHCVyaQ8Yw==
Date: Thu, 23 Oct 2025 13:19:57 +0100
From: Simon Horman <horms@kernel.org>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] smc: rename smc_find_ism_store_rc to reflect
 broader usage
Message-ID: <aPodbbH2QwNxzW1d@horms.kernel.org>
References: <20251023020012.69609-1-dust.li@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023020012.69609-1-dust.li@linux.alibaba.com>

On Thu, Oct 23, 2025 at 10:00:12AM +0800, Dust Li wrote:
> The function smc_find_ism_store_rc() is used to record the reason
> why a suitable device (either ISM or RDMA) could not be found.
> However, its name suggests it is ISM-specific, which is misleading.
> 
> Rename it to better reflect its actual usage.
> 
> No functional changes.
> 
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>

Reviewed-by: Simon Horman <horms@kernel.org>


