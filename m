Return-Path: <linux-rdma+bounces-2962-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268318FF6A4
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3131E1C26477
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7F713B583;
	Thu,  6 Jun 2024 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7sjR1wk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168CF73459;
	Thu,  6 Jun 2024 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708945; cv=none; b=N01paAagr+t5qs2gnx3HntpiznNwCRi3fGStu1K3SOfbJiiUSne7dWzj3uGoSlyfXpajbajOBTU3igtZBLt4O6CNuxpbbJpmnv3VUEpy3Y3yMepQXxmp8X3stFPedWFecIxyqdlg9VnTMdXyQZyOV7gDiNoVCRi1r5OjW4mh4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708945; c=relaxed/simple;
	bh=+p/KGBKns0paXmt8PnPRVgYGqV6ZYHrcf+zDWUrbD+U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tVjuXk34vfrqjzXHfMeBXsR7b008dCYOaYl7E67Kw9nQBpNWNDqa5GMfliqNaLBlwkiU0H06n/w/ibMMSAs/QysOa7tsK/zVUarDWgsgAyY8vKJWJtgXtW7VnfxAZTD3aCTLy7WwuXUba26odpYMNWGqUR50YmwbrCaixntlOus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7sjR1wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EE0C2BD10;
	Thu,  6 Jun 2024 21:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717708944;
	bh=+p/KGBKns0paXmt8PnPRVgYGqV6ZYHrcf+zDWUrbD+U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=D7sjR1wkUEGvDiDCMwIx7m1+76moMr/bP3ojV58ZipOJpj+Vrr9LGPp69nu13HfF0
	 u5uM3WLDvIcdlIeU3+vpdfkZqTa/dtLfuH2Pw0YaniL1hbZqt2LIUa5PgemWhsKuRf
	 tU2p8O1RTpsgPO1aZXLfAt7zC+mnmJtJ/OgfDz7OBZl2vWJZrcaJOuEHWpacYXdeQS
	 16unvP+mFNxsH6bG2Yu7s600/B3nlWKkMPYo/jsLQf9gU8Plb3jr37mmADTvmm/mj8
	 xBJxQmbuS5sxRQtYOwCkvjbiftf1rtSKcmpQnpZHHpTRNqbkG2rXGvJPjoKmcclaBS
	 8CAqXWoJUkpOg==
Date: Thu, 6 Jun 2024 14:22:24 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
    wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org, 
    davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
    linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com, 
    edumazet@google.com
Subject: Re: [PATCH net-next v6 3/3] net/smc: Introduce IPPROTO_SMC
In-Reply-To: <1717592180-66181-4-git-send-email-alibuda@linux.alibaba.com>
Message-ID: <6e0f1c4a-4911-51c3-02fa-a449f2434ef1@kernel.org>
References: <1717592180-66181-1-git-send-email-alibuda@linux.alibaba.com> <1717592180-66181-4-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 5 Jun 2024, D. Wythe wrote:

> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> This patch allows to create smc socket via AF_INET,
> similar to the following code,
>
> /* create v4 smc sock */
> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>
> /* create v6 smc sock */
> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
>
> There are several reasons why we believe it is appropriate here:
>
> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
> address. There is no AF_SMC address at all.
>
> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
> Otherwise, smc have to implement it again in AF_SMC path.
>
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> include/uapi/linux/in.h |   2 +
> net/smc/Makefile        |   2 +-
> net/smc/af_smc.c        |  16 ++++-
> net/smc/smc_inet.c      | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
> net/smc/smc_inet.h      |  22 +++++++
> 5 files changed, 208 insertions(+), 3 deletions(-)
> create mode 100644 net/smc/smc_inet.c
> create mode 100644 net/smc/smc_inet.h
>
> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
> index e682ab6..0c6322b 100644
> --- a/include/uapi/linux/in.h
> +++ b/include/uapi/linux/in.h
> @@ -83,6 +83,8 @@ enum {
> #define IPPROTO_RAW		IPPROTO_RAW
>   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
> #define IPPROTO_MPTCP		IPPROTO_MPTCP
> +  IPPROTO_SMC = 263,		/* Shared Memory Communications		*/
> +#define IPPROTO_SMC		IPPROTO_SMC

Hello,

It's not required to assign IPPROTO_MPTCP+1 as your new IPPROTO_SMC value. 
Making IPPROTO_MAX larger does increase the size of the inet_diag_table. 
Values from 256 to 261 are usable for IPPROTO_SMC without increasing 
IPPROTO_MAX.

Just for background: When we added IPPROTO_MPTCP, we chose 262 because it 
is IPPROTO_TCP+0x100. The IANA reserved protocol numbers are 8 bits wide 
so we knew we would not conflict with any future additions, and in the 
case of MPTCP is was convenient that truncating the proto value to 8 bits 
would match IPPROTO_TCP.

- Mat

>   IPPROTO_MAX
> };

