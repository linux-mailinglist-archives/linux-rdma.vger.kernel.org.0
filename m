Return-Path: <linux-rdma+bounces-9670-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EADA96843
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 13:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2793B0A48
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 11:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871EB27C84B;
	Tue, 22 Apr 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeduEDjh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450751A317D;
	Tue, 22 Apr 2025 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745323141; cv=none; b=Xz+CJNQlOw16oOA/RfqiRxG30yvWDbEtXIn7cdCErJ7+0BCB80d3iLvGIkelhU+3DCZa4R6YjlfgWzdq93Zec40qeA0aWeJ27A7SonCMAQ/M9LXKhnnszdagIxG7TW9Ch2OV7wXuJDqc91iTEj5WBjka5b9cPou5SVoJLB05iDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745323141; c=relaxed/simple;
	bh=mXQqE7jsF1nJPYIblj3ihzKXApRzO+HNzd9SJrr6fEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us8MOLYjjZ46ZAGE8uCeF3K1kmtet9mwO3tWiPXlz/JEC4W+7/bpj0SAbvXYdMfSxygxMukFsgXxau1YYvzOP7D7RloqTlLtSneT/ShTOJunU8GltX1uSch+vS3s6pSwVYeI0kqRXvzuj4emdnbPkmkaT68BIm5qXgsBULZEXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeduEDjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F77C4CEE9;
	Tue, 22 Apr 2025 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745323140;
	bh=mXQqE7jsF1nJPYIblj3ihzKXApRzO+HNzd9SJrr6fEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZeduEDjh8IQkHNbRA3mM2iocErCuUx8wCPNatoJJC9887nQo9XlBSH+0PBrxTbZKQ
	 yOMO6Knrh5AeUu8vjDGwKWFNLRJX+3Wy63a7Z+F1yKf9wGVAa1NPTol5md9NLWwPhJ
	 vpt4CjX8fCoDoWGcVAAvv0bKJkRbWyZzVPbznl1aBzBh2f3DlYfwGxX9twPm34Zfv0
	 rfQ6FtG9bfGLKbDVWF+qQbflKAfGLnW4up6fVoirefN/75VWXH6BpwF1jGu0NGBYKE
	 x5X8U6KS/yQLYvDpzOAXAHDWxzZmKyrleRdr7Q3yNxbeyQ1yGIXd2ArRKBnGJZkstq
	 9eYyrrWJugJZg==
Date: Tue, 22 Apr 2025 14:58:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: l1138897701 <l1138897701@163.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, luoqing@kylinos.cn,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] rdma: infiniband: Added __alloc_cq request value
 Return value non-zero value determination
Message-ID: <20250422115853.GF48485@unreal>
References: <20250407093341.3245344-1-l1138897701@163.com>
 <20250407162559.GA1562048@ziepe.ca>
 <7afc834e.5498.1965c20f9f0.Coremail.l1138897701@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7afc834e.5498.1965c20f9f0.Coremail.l1138897701@163.com>

On Tue, Apr 22, 2025 at 02:13:07PM +0800, l1138897701 wrote:
> In fact, the occurrence of this problem is because when the outbox driver is compiled and installed,

So let's fix your out-of-tree driver.

Thanks

