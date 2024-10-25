Return-Path: <linux-rdma+bounces-5522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9459B04E5
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2024 16:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76DE1F242C8
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2024 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009A70820;
	Fri, 25 Oct 2024 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0DPp3w/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC629A0;
	Fri, 25 Oct 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864920; cv=none; b=R5areYm/JJZsdH+9ZEmXvMFtwO6hreSoD58KK35aq96gOtiyZvIVaeD3ifqPkW+cp+6zS7ulr+LNXujzBkQ3ffD63KQq33hE3IxCBMJzHf3v0QxcgFHq2oJ909EOHpw0ut37d9FfLkoLJZyrqnh7ER15sWj80tQwDNjyGKIk72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864920; c=relaxed/simple;
	bh=dJ/ktQ6IcnDZAarHCaBXoLtVOYprBnc4JXxiUhttUSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMfJ8lDtXdlRyzu81zYqnvWQ665JXQrWV6P+r2urLEV+qqgY5CZ2fpXkJFHziUj0y2v0Bfb2qeZABWe77c3c3+QcnomdB/sxsH7JJeucv/AafZCXFypSzzmvM/5SZIVx+NKW0H9gpKkO3olQq8GYJN3IR8qgnKOVKrYleykmM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0DPp3w/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEEEC4CEC3;
	Fri, 25 Oct 2024 14:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729864919;
	bh=dJ/ktQ6IcnDZAarHCaBXoLtVOYprBnc4JXxiUhttUSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0DPp3w/Dg3sj7hCNTeRkYkj9oeQ4aGCHxb9EBoIKjxb8fDTM4ZC+TOg+vdoNRsBL
	 NcszjfdyD/qUOulwTi657h7nXIgWm04b8s8129nnnl7X48R6EDsgJqKkf6HSB7cuTJ
	 6GZ6ApDfCkkmjG3Zqh9JQJ/tTaZX15/9tZnGbZ7cSvqrZx0AHlbRpRGF2yZquwXctd
	 xalm5aktHxnBt2/qnClTKKySzW/ojZRYuiVLCLEl7LB9i7FZhLZIbJy7EJiRjyRfMu
	 RCKQ06OiToh+gRJDdT2DAe9pj3QZ2/EWqMepVekjwDNhEq6QEKNu0BtpicniAgzvRm
	 ybWYVzE5009ug==
Date: Fri, 25 Oct 2024 15:01:53 +0100
From: Simon Horman <horms@kernel.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241025140153.GB1507976@kernel.org>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025072356.56093-1-wenjia@linux.ibm.com>

On Fri, Oct 25, 2024 at 09:23:55AM +0200, Wenjia Zhang wrote:
> Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
> alternative to get_netdev") introduced an API ib_device_get_netdev.
> The SMC-R variant of the SMC protocol continued to use the old API
> ib_device_ops.get_netdev() to lookup netdev. As this commit 8d159eb2117b
> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
> get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
> ib_device_ops.get_netdev didn't work any more at least by using a mlx5
> device driver. Thus, using ib_device_set_netdev() now became mandatory.
> 
> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
> 
> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> Reported-by: Aswin K <aswin@linux.ibm.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


