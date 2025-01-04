Return-Path: <linux-rdma+bounces-6814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC29A015D7
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2025 17:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A2C7A1736
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CF1C5F36;
	Sat,  4 Jan 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIiKBqtq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5E18C008;
	Sat,  4 Jan 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736008813; cv=none; b=i3QRm53/GEppvnA+NqKsUb7MH1WhO6/SsjgcrROuW4w972K15WRlXO16vrt/cOnUzyvx/nsqOJvv8rPImy94zz5S5JY2zGl2Hdlk0zJuhbMul4fKw4qgrZ392IwsjDERLLdHG1Xgs2CxVOVvK4tuCO1SQ/8U4nT6LMb+jom+y9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736008813; c=relaxed/simple;
	bh=WhcARQrOYd0kxlrcV5SsxGxVxRxXshHTRGRV3vNYsCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pn5xr4tggTZg4cdt4oh+xmYKP8DILghtYKn4zYor0ozGoQyBIk2P8sU3EXS05xyswjhWY5dRmV0EZFQbzDFzfFjneQFjxTLNWMtwXxmfTRrWmSNEkEjGHKZBzPiNcHsr1XC9QeIRhUiKZPYxl8D9w+Yw4ZpDh0q7IlZ8CPrJm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIiKBqtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6375EC4CED1;
	Sat,  4 Jan 2025 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736008813;
	bh=WhcARQrOYd0kxlrcV5SsxGxVxRxXshHTRGRV3vNYsCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pIiKBqtq/rVrj2YuUse8AQcxf5eZoif77sniQGOGBO7mosIG7iREDKIEUjuaM25Gm
	 a9dEqL3Ma2P0bjJfFr2YlF7DvJJFMOkPIym21eqDvja18Jc+OIbw23k9TAXewGFLzL
	 tlS4HZq4X/CopSzSKLbhRnx4WK0mC0/gYCHKokktzn3wwW5jby8EtZUTcoByeBs6sd
	 86InkpP0L4GON4XUYvzaeBrXR3bIGEIqYQIfqLyRex620638kwTdKeRtqqBDcIwy5A
	 Fex8i/BhL6ZKs83b483RsEYVrnDbYn7VFtbkjv6BFOTEm381txR9jzr77v9Ii/jm1y
	 CUpoLhnDeHnwQ==
Date: Sat, 4 Jan 2025 08:40:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>, PASIC@de.ibm.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
Message-ID: <20250104084011.15446a17@kernel.org>
In-Reply-To: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Dec 2024 12:04:55 +0800 Guangguan Wang wrote:
> The command 'smc_pnet -a -I <ethx> <pnetid>' will add <pnetid>
> to the pnetid table and will attach the <pnetid> to net device
> whose name is <ethx>. But When do SMCR by <ethx>, in function
> smc_pnet_find_roce_by_pnetid, it will use <ethx>'s base ndev's
> pnetid to match rdma device, not <ethx>'s pnetid. The asymmetric
> use of the pnetid seems weird. Sometimes it is difficult to know
> the hierarchy of net device what may make it difficult to configure
> the pnetid and to use the pnetid. Looking into the history of
> commit, it was the commit 890a2cb4a966 ("net/smc: rework pnet table")
> that changes the ndev from the <ethx> to the <ethx>'s base ndev
> when finding pnetid by pnetid table. It seems a mistake.
> 
> This patch changes the ndev back to the <ethx> when finding pnetid
> by pnetid table.

SMC maintainers, please review..

