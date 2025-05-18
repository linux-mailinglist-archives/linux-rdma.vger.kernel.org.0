Return-Path: <linux-rdma+bounces-10396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5964AABAEE0
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 11:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197FE3B80EF
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 09:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA02629C;
	Sun, 18 May 2025 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkx6soYQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79CB3FC7
	for <linux-rdma@vger.kernel.org>; Sun, 18 May 2025 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747558825; cv=none; b=ni+hXY7n9iHMhlyB0eAxp6Tg8ywZmg6CVk/PeHvFSWyMKfmLFFebj5GljitknZN7/9BiQxq28oYYeruXmWZ5GhAu4j8Z2kwMXEnX85RcNjJKmByK+SooN7RYG99z53vSgy+oQp03W+7IhsIbQmx41t4NV9f8HsP92jQH5szDLRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747558825; c=relaxed/simple;
	bh=NqVNquXZueROoXVaIsiRPpeKazcgFW+Qym3kneSp40o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQKPHfwz6kP16Hj7tWQxRNT6tVdjmH8cXl7jLvd27Z7+g0pZmrQZBMgMK1lmhPBbCq3gd6Lxdo+yarHkvCAqNWzU1lk+NGdYTL0vf2OMu+VhsrNJ/GhdknQlPkujQRqqw5Q4df1sRvsRaXxcQJWbr3QSCFKi9w9m7KOaXNvRpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkx6soYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9D7C4CEE7;
	Sun, 18 May 2025 09:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747558824;
	bh=NqVNquXZueROoXVaIsiRPpeKazcgFW+Qym3kneSp40o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkx6soYQkDoHtKhxnbw/ZzMnLl1NeuM6qiNbmNIiXJIi0Zu7yYYl3oZ4mfJQBSsf4
	 2hhyeqUNybM3v2YyB7uI8/+A3ZxrcoeVK88fKi1oMYNOffBvbjXi8ljdbQQ+W9XSYg
	 0nvO78ow+2ztu57hekdTsdlWajQNGhW1GiNFybFMVPZ/3370KnsIwc3TnSgTkKrw31
	 sj86HOhT/yaVQ05771fT7VjCbOSWB6txgU7J35czQ8I7CnOe7LUKfOHo+7/EhRZTn2
	 v879MmnjBVDLqH/tv5uUlFBhr/mXKLo9+lD3OB37+bFQ0fYALUD7xIckhv3g6Qu2YV
	 Ij/uyDTCd8EwQ==
Date: Sun, 18 May 2025 10:00:20 +0100
From: Simon Horman <horms@kernel.org>
To: goralbaris <goralbaris@gmail.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH net-next v2] Replace strncpy with strscpy
Message-ID: <20250518090020.GA366906@horms.kernel.org>
References: <20250408212122.10517-1-goralbaris@gmail.com>
 <20250517181248.28913-1-goralbaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517181248.28913-1-goralbaris@gmail.com>

On Sat, May 17, 2025 at 09:12:48PM +0300, goralbaris wrote:
> Hi,
> Any news about this Patch?

Hi Baris,

I expect this patch floundered because it was not CCed to netdev.

In any case, there was a separate effort to address this problem.

- [PATCH v2] net: rds: Replace strncpy with strscpy in connection setup
  by Shankari Anand
  https://lore.kernel.org/netdev/20250426192113.47012-1-shankari.ak0208@gmail.com/

I would suggest that a successful patch should:

* Use the two-argument variant of strscpy_pad (see thread above)
* Include commentary in the commit message regarding
  - Why strctpy* is preferred over strncpy (you already did that :).
  - Why strscpy_pad is appropriate instead of strscpy
* CC all relevant parties, including netdev, the Netdev maintainers,
  Shankari Anand and Allison Henderson

