Return-Path: <linux-rdma+bounces-9309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898B0A82D06
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D9F17EBBA
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BD26FDAC;
	Wed,  9 Apr 2025 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbJKORGg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD75D477;
	Wed,  9 Apr 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217946; cv=none; b=mYYsVhq9esqtFZXHt6LEwWMV/xdjdAiq7UD2zJ7n+Z6V+y51Zf0FSLSOTDTh+pqr+XANNNKeZeA2B2O/FuIo1ST1nlDwayZo5qEoIjfBbNp75j/DNXFWkvBIYtidvwjQzQgJ3ZQWJuTv2YK/sw8DHI6M0gyDTNqESDGgn4e1QnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217946; c=relaxed/simple;
	bh=+t6xw7m0q6WPq2Jw3j13KPOpZzbLg3nbPA2/0Hrlzo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqW+8Sjy/p+gdrM0q41QtBHanl9p4APCgVvcHUE/0fvq9bUzpx9dQyGREBykm5AerfSmSkD3iMY5IvV9I3nhfvT3GfgIgs8Jy1Mg6NseznpD8cu8LuAYc1+J+1bCN/MXpBRJqMRtmMMnYZhJ4eyIQ4C3pJ45smyPg8/6Uh4YdmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbJKORGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD96DC4CEE2;
	Wed,  9 Apr 2025 16:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744217945;
	bh=+t6xw7m0q6WPq2Jw3j13KPOpZzbLg3nbPA2/0Hrlzo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbJKORGgWX0gptcxrSltnrxMTzoGdG4u7DKDbvduF1bNz3HWt+F9qNWQXZuL27MqB
	 zV8r/NcJdOMfQ2yWC0t6m7Z1DNgdjDCFkuuJedRmUPe7qIBbAEd3l68BzN16088awZ
	 P+s2gr2eEOC8zmkmLII6J9zr+kFgcz2SBkSGo5/lOdEznKw+JzXHXkHrwwnJkQ8ZMs
	 7p/C1IHoU3P+ezEHCtEwi7xcMPMcYl0ifHyWHjaZkalJad12qDiA1lHlDKbq4R5Rmr
	 p0NVINgzhdpeau6nPbk73znjjTXt9OjTNy0xEaUpecU6kfCgcyJuDfjmXAU/ZbFoov
	 tYp3PSpu7dohA==
Date: Wed, 9 Apr 2025 19:58:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Christian Benvenuti <benve@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA: Don't use %pK through printk
Message-ID: <20250409165859.GM199604@unreal>
References: <20250407-restricted-pointers-infiniband-v1-1-22b20504b84d@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407-restricted-pointers-infiniband-v1-1-22b20504b84d@linutronix.de>

On Mon, Apr 07, 2025 at 10:25:09AM +0200, Thomas Weißschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). 

Just for the record, this clarification was added in commit:
a48849e2358e ("printk: clarify the documentation for plain pointer printing"), in 2021.

Thanks

