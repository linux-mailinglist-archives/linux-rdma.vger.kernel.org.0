Return-Path: <linux-rdma+bounces-13922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B030BE7553
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 11:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A9218843F5
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001732D24A9;
	Fri, 17 Oct 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XidX42Nh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B833B23958C;
	Fri, 17 Oct 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691670; cv=none; b=XRRMlSeY+fwvtkBjT5Y9z4HBkeFPSwzobeu2LvVCISPJhhQYmPQwdMxkA1sbIfkFQ5uoj4g1tEGeajY/VapjZKQXabiDIk13fMGYIazUY92Ic3/zKq8eiXigqJ8VohBgBiDUQYQTpP+ckA8NDo9vVCKu21MH/4PaMYSvtKR//VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691670; c=relaxed/simple;
	bh=h/YY0gR8/Iiyrguooi9hkeHhvmG/E7t2a4i1d0s7eC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuB1hLxFQHwNFn7i6NfWCrSt7o8Hvyqoh154RL6Fh+0Eaii6lzUpIUCRz/Zg1w08rl+/RxjUq7chDcLgLf5T+rI1hbScAHgTeiESFRpjUZQEPXtZk7JimOMzGKJrqdoWmeDTx9BQbt/8UMgiYuOhyCF7YD3ogNB/+FzP0mOOh1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XidX42Nh; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760691663; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=uycmo3Bm0bR66UePEy8ROQA4xR2I+ASZH2LLLu2tl+0=;
	b=XidX42Nh7IS/uZFUztGeHrKWGPm8dlFVJRBo9lwje82b8af22h8qtcpD4moWNhEwMwp+ABTKxTkubL/CBA0RGMbtFRUebPRDl9O1g5nMLPJ01jKTeUA5Bgw9WZpJWtM0b1wATc34xvA7qPVjiiVFkSRslALNauPTvFUm8jel5qs=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WqPAjNx_1760691661 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 17:01:02 +0800
Date: Fri, 17 Oct 2025 17:01:01 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Simon Horman <horms@kernel.org>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	sidraya@linux.ibm.com, jaka@linux.ibm.com
Subject: Re: [PATCH net-next] net/smc: add full IPv6 support for SMC
Message-ID: <20251017090101.GA80913@j66a10360.sqa.eu95>
References: <20251016054541.692-1-alibuda@linux.alibaba.com>
 <aPD0qwDoYNoTTaur@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPD0qwDoYNoTTaur@horms.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Oct 16, 2025 at 02:35:39PM +0100, Simon Horman wrote:
> On Thu, Oct 16, 2025 at 01:45:41PM +0800, D. Wythe wrote:
> > The current SMC implementation is IPv4-centric. While it contains a
> > workaround for IPv4-mapped IPv6 addresses, it lacks a functional path
> > for native IPv6, preventing its use in modern dual-stack or IPv6-only
> > networks.
> > 
> > This patch introduces full, native IPv6 support by refactoring the
> > address handling mechanism to be IP-version agnostic, which is
> > achieved by:
> > 
> > - Introducing a generic `struct smc_ipaddr` to abstract IP addresses.
> > - Implementing an IPv6-specific route lookup function.
> > - Extend GID matching logic for both IPv4 and IPv6 addresses
> > 
> > With these changes, SMC can now discover RDMA devices and establish
> > connections over both native IPv4 and IPv6 networks.
> > 
> > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > ---
> >  net/smc/af_smc.c   |  35 +++++++----
> >  net/smc/smc_core.h |  40 ++++++++++++-
> >  net/smc/smc_ib.c   | 143 ++++++++++++++++++++++++++++++++++++++-------
> >  net/smc/smc_ib.h   |   9 +++
> >  net/smc/smc_llc.c  |   6 +-
> >  5 files changed, 193 insertions(+), 40 deletions(-)
> > 
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index 77b99e8ef35a..cbff0b29ad5b 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -1132,12 +1132,9 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
> >  
> >  	/* check if there is an rdma v2 device available */
> >  	ini->check_smcrv2 = true;
> > -	ini->smcrv2.saddr = smc->clcsock->sk->sk_rcv_saddr;
> > +
> > +	smc_ipaddr_from(&ini->smcrv2.saddr, smc->clcsock->sk, sk_rcv_saddr, sk_v6_rcv_saddr);
> 
> Hi,
> 
> Unfortunately this introduces a compilation error when CONFIG_IPV6=n.
> 
> In file included from smc_wr.h:20,
>                  from smc_llc.h:16,
>                  from af_smc.c:47:
> af_smc.c: In function ‘smc_find_proposal_devices’:
> /home/horms/projects/linux/linux/include/net/sock.h:388:37: error: ‘struct sock_common’ has no member named ‘skc_v6_rcv_saddr’; did you mean ‘skc_rcv_saddr’?
>   388 | #define sk_v6_rcv_saddr __sk_common.skc_v6_rcv_saddr
>       |                                     ^~~~~~~~~~~~~~~~
> smc_core.h:639:51: note: in definition of macro ‘smc_ipaddr_from’
>   639 |                         __ipaddr->addr_v6 = __sk->_v6_member;   \
>       |                                                   ^~~~~~~~~~
> af_smc.c:1136:77: note: in expansion of macro ‘sk_v6_rcv_saddr’
>  1136 |         smc_ipaddr_from(&ini->smcrv2.saddr, smc->clcsock->sk, sk_rcv_saddr, sk_v6_rcv_saddr);


Thanks for the report, that's my bad... I will fix it in the next version.

D. Wythe

