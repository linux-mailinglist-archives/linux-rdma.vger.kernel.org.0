Return-Path: <linux-rdma+bounces-10507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF31ABFF8C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 00:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7384E0F02
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 22:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C2239E62;
	Wed, 21 May 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUL1rEPi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7603136351;
	Wed, 21 May 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866668; cv=none; b=oBhOeCuYusJY8HoZrli56bIQmOu5poX19iT4zIJg8wwsM/cipTz3KL1bvWbLCLOPS6N8qUUoGL88oa6CWv1cEUpjzGyb5NFYMji0sSuE5OpQoxlxCzvOvn3MENU7v8OY0usfRdHlO7Pi/DUGI5gL09NKuQpe3lV1sIUwx2L3CNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866668; c=relaxed/simple;
	bh=mfOAhsIWu5Z4ODKpt4UPUgtiPYOuu8DX97OEMhASu5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bR1h5Uh1qNpyvquQDJpb2AX8AyNkgriQZDStu1a+OH2hRvJtPio3eMjwLzkLK6C3udAkxrr6rFeunkXP0SnVNkOAjqvRwlHnnEHoNIREgGfcaeU4UziUZi1RWHQjj/1urbLw6XbavDosCxgapUZGUREwOgNSWQbEsire9TMUmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUL1rEPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ECAC4CEE4;
	Wed, 21 May 2025 22:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866668;
	bh=mfOAhsIWu5Z4ODKpt4UPUgtiPYOuu8DX97OEMhASu5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YUL1rEPiwYnxwoN2OoAyzyGKm8BCc9d95twKiFTPMjfwdhNs5O2OzAKgdb8ggXx+3
	 UJiiGWdX8UGQF+BSkt90/59AgI8walNx9x2AQHDpLL6v31o58OakNpvNuYrxw7/H66
	 Md7q30GtamKasCWvDXPkncYzrf3diBC8u9KQIrQHiynVAUP8QrLDeedNCm+3GPzwx1
	 wAX/VZbfZKn7ZiUszLGlKGGvFyNSua/3rSUb+pQcHuLFvji6290jC5Nco3RgaxFLcU
	 qSJU78yAn1eGghCTO5w0m97NsTZKckEebotvqAqFQilRdHfd422dwk7Iu4+cEPRn+Z
	 egpA0kYk8H4hg==
Date: Wed, 21 May 2025 15:31:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, skalluru@marvell.com, manishc@marvell.com,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 tariqt@nvidia.com, saeedm@nvidia.com, louis.peens@corigine.com,
 shshaikh@marvell.com, GR-Linux-NIC-Dev@marvell.com, ecree.xilinx@gmail.com,
 horms@kernel.org, dsahern@kernel.org, ruanjinjie@huawei.com,
 mheib@redhat.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-net-drivers@amd.com, leon@kernel.org
Subject: Re: [PATCH net-next 2/3] udp_tunnel: remove rtnl_lock dependency
Message-ID: <20250521153107.150f01e1@kernel.org>
In-Reply-To: <aC4FK0fmUoaXYt4k@mini-arch>
References: <20250520203614.2693870-1-stfomichev@gmail.com>
	<20250520203614.2693870-3-stfomichev@gmail.com>
	<20250521073401.67fbd1bc@kernel.org>
	<aC4FK0fmUoaXYt4k@mini-arch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 09:54:03 -0700 Stanislav Fomichev wrote:
> > >  enum udp_tunnel_nic_info_flags {
> > > -	/* Device callbacks may sleep */
> > > -	UDP_TUNNEL_NIC_INFO_MAY_SLEEP	= BIT(0),  
> > 
> > Could we use a different lock for sleeping and non-sleeping drivers?  
> 
> We can probably do it if we reorder the locks (as you ask/suggest
> below). Overall, I'm not sure I understand why we want to have two
> paths here. If we can do everything via work queue, why have a separate
> path for the non-sleepable callback? (more code -> more bugs)

I think when I was pulling this code out of the drivers I was trying 
to preserve the fast path for drivers which don't have to sleep.
But if some drivers are okay with the wq then the mechanism must work,
so I guess you're right, it should be fine to make all go via wq.

