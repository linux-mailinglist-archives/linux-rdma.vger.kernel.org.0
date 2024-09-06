Return-Path: <linux-rdma+bounces-4791-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F796EC03
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 09:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7120A1F22F95
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 07:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1799314A604;
	Fri,  6 Sep 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrONg+MT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C822087;
	Fri,  6 Sep 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607939; cv=none; b=lygNUuZEcnrGCAeibOyY04jIgUe7A4AOxtWZ098pmCd5j1uZT+3tZy1x7F4CMoWMwpZb1ajmhuDGOirYUa3ftFWOIngCk+TgixCfEiJ4gSz7nSFg/n0Dkoy5l8cEQKrAuit8uFLZcBBnIGJVZoKe5FX8jws8sJvCDD1G/0oGdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607939; c=relaxed/simple;
	bh=0ujc+nfTNN9nhLzROOGShpK7AILBFxlSDt8oV0JgkCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6jQn4jXI+/ZNzSKor7MmBega6J0+6c/0ZgUJuQf8gig6RZsXah5TR6c3K71sTETbnfghTbSrgMscGl41ZNczq0qdYp8oGgzB+f19DqjA18it9dxCQoaBbS6ZnIH7WyXRDlKqW5hN/wB4JgbPSnhA4gdN8SqOYnPhttNXntoJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrONg+MT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BA3C4CEC4;
	Fri,  6 Sep 2024 07:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725607939;
	bh=0ujc+nfTNN9nhLzROOGShpK7AILBFxlSDt8oV0JgkCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrONg+MTLk+TGoLggG32kls4zfNqVdb0HFmyIBxI5vhreQMUePoWRKbRohR8cO+wu
	 AR/mop/H87aDgXDTFjgq9J+jYk9c8gh5azIriXrnGyB5pZ5pX2CMz8BEr3+6KbpJTW
	 A9VUWJbcs9Pelgq4g+qtfv2RjlDhvoY7nUwSgN5Mxhuc4IHMfBzgvGnqG80YDwSl+I
	 XHx9Y6B1wcgHrq8GQglA2t4BqrUeR+2uC4sRr5ijkxRKQF2YYSPwYymeMV6ABZTiU+
	 U5xM5OjiDlFeJl9vzxnSTKDC5NqHvZqY3kJwE12YcOUoogwcsaqp+TSNm0ALdnX6M0
	 8xiFmhTtd2M0Q==
Date: Fri, 6 Sep 2024 08:32:14 +0100
From: Simon Horman <horms@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1 net-next] net: ethernet: mellanox: mlx5: core: Use
 ERR_CAST() to return
Message-ID: <20240906073214.GA2097826@kernel.org>
References: <20240829081404.2898004-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829081404.2898004-1-yanzhen@vivo.com>

On Thu, Aug 29, 2024 at 04:14:04PM +0800, Yan Zhen wrote:
> Using ERR_CAST() is more reasonable and safer, When it is necessary
> to convert the type of an error pointer and return it.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>

Thanks,

I agree that this change is correct.
And it seems to be the only case where this change is
relevant in this file.

And, personally, I do see a value in reducing naked casts,
even if the macro is doing much the same thing. Because
using a macro is more expressive about intent.

But, OTOH, I do see that there is a cost in terms of code-churn,
something for the maintainer to weigh-up.

Reviewed-by: Simon Horman <horms@kernel.org>

