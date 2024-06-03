Return-Path: <linux-rdma+bounces-2768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E18D7CB3
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 09:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC2C1C21E05
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 07:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD3A4A9B0;
	Mon,  3 Jun 2024 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phoM3Ab5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D462D057;
	Mon,  3 Jun 2024 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400858; cv=none; b=I1cVMZXARqbmfGklnq84+cRF33rNvFCFiM4GWsjLuRmiIW2SDhvHiLe+0Ez0rZ+iZEJVFy1qzG3N00A9L1n2HKMAkAGmbLhBiPtxTJBfOvhcqhAJVi74YRzvmz/P34ABzKO/UelD7NGuRT8iDm+SNVzsMJF3+AEIW1JsysZIpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400858; c=relaxed/simple;
	bh=wxwWbg2b46+zJFxPNVlScO3DGxRNlklN018zSQ3fydI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6ZIcfyicK/DLF0LmQRmMP3ElVgPK05DsRZf+BR0PyRIf4PwjlMlpofwPlkRuLd4/qQQ7oqhhj5dtHwdIl3d1t1bZcPLJtpYYsNfDHckOhnXw/ksA91in/K5Cp4hjcVfFB6Y1D37IJkJMGmgKI7FtPvXMNbdCuQmnOjuEYkPP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phoM3Ab5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C946CC2BD10;
	Mon,  3 Jun 2024 07:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717400857;
	bh=wxwWbg2b46+zJFxPNVlScO3DGxRNlklN018zSQ3fydI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phoM3Ab5FonLTTegQTSyRNclTSuWJJ3nfiggCwR4vHn0bnTMSC7MPb9kVyzRGtNPp
	 5IMFO7jQ5aZRIP+IVjJhvU4pVm3B5DXckrvGGmLz6njd88wINUgtABJ+c2DPZWzOwW
	 epskO0uVF8VzRRoyXLqvAfpFhK8tnkjBZVQsZIgWYrhqF4kgL9tffgjQDbWVB7f1OA
	 9YmL0OZC9UuLxmeVXbohBNxU7BaqCz/TRvgkFMCZYZRPWa6gFGm1c1zGg0gHByqV2v
	 /YO5aUJWXeZt0ShYNggE7EOZjezRPiq1tx5oC1ZTjqbR8MW6WTV9kasRhtezbMa2e4
	 HCAoHMbpTH83w==
Date: Mon, 3 Jun 2024 08:47:32 +0100
From: Simon Horman <horms@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next v4 3/3] net/smc: Introduce IPPROTO_SMC
Message-ID: <20240603074732.GW491852@kernel.org>
References: <1716955147-88923-1-git-send-email-alibuda@linux.alibaba.com>
 <1716955147-88923-4-git-send-email-alibuda@linux.alibaba.com>
 <20240601130628.GK491852@kernel.org>
 <83a6596b-d9c4-4f2f-9eae-fd35cae561dc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83a6596b-d9c4-4f2f-9eae-fd35cae561dc@linux.alibaba.com>

On Mon, Jun 03, 2024 at 10:57:55AM +0800, D. Wythe wrote:
> 
> 
> On 6/1/24 9:06 PM, Simon Horman wrote:
> > On Wed, May 29, 2024 at 11:59:07AM +0800, D. Wythe wrote:
> > > From: "D. Wythe" <alibuda@linux.alibaba.com>
> > > 
> > > This patch allows to create smc socket via AF_INET,
> > > similar to the following code,
> > > 
> > > /* create v4 smc sock */
> > > v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> > > 
> > > /* create v6 smc sock */
> > > v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> > > 
> > > There are several reasons why we believe it is appropriate here:
> > > 
> > > 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
> > > address. There is no AF_SMC address at all.
> > > 
> > > 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
> > > the infrastructure of AF_INET(6) path, such as common ebpf hooks.
> > > Otherwise, smc have to implement it again in AF_SMC path.
> > > 
> > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > ...
> > 
> > > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > ...
> > 
> > > @@ -3594,9 +3595,31 @@ static int __init smc_init(void)
> > >   		goto out_lo;
> > >   	}
> > > +	rc = proto_register(&smc_inet_prot, 1);
> > > +	if (rc) {
> > > +		pr_err("%s: proto_register smc_inet_prot fails with %d\n", __func__, rc);
> > Hi,
> > 
> > FWIIW, my feeling is that if a log message includes __func__ then it should
> > be a debug level message, and even then I'm dubious about the value of
> > __func__: we do have many tools including dynamic tracing or pinpointing
> > problems.
> > 
> > So I would suggest rephrasing this message and dropping __func__.
> > Or maybe removing it entirely.
> > Or if not, lowering the priority of this message to debug.
> > 
> > If for some reason __func__ remains, please do consider wrapping
> > the line to 80c columns or less, which can be trivially done here
> > (please don't split the format string in any case).
> > 
> > Flagged by checkpatch.pl --max-line-length=80
> 
> 
> Hi Simon,
> 
> Thank you very much for your feedback.
> 
> Allow me to briefly explain the reasons for using pr_err and __func__ here.
> 
> Regarding pr_err, the failure here leads to the failure of the module
> loading, which is definitely an error-level message rather than a
> debug-level one.
> 
> As for __func__, I must admit that the purpose here is simply to align with
> the format of other error messages in smc_init(). In fact, I also feel that
> the presence of
> __func__ doesn't hold significant value because this error will only occur
> within this function. It's meaningless information for both users and kernel
> developers.
> Perhaps a more suitable format would be “smc: xxx: %d”.
> 
> However, if changes are needed, I think they should be made across the board
> in order to maintain a consistent style. Maybe this can be addressed by
> submitting a new patch after this patch. @Wenjia, what do you think?
> 
> Therefore, for now, I would like to wrap this line to not exceed 80
> characters, to ensure it can pass the checkpatch.pl.
> What do you think?

Thanks, I agree with your reasoning.
And I think this is a good approach for this patch.

> 
> Best wishes,
> D. Wythe
> 
> > 
> > > +		goto out_ulp;
> > > +	}
> > > +	inet_register_protosw(&smc_inet_protosw);
> > > +#if IS_ENABLED(CONFIG_IPV6)
> > > +	rc = proto_register(&smc_inet6_prot, 1);
> > > +	if (rc) {
> > > +		pr_err("%s: proto_register smc_inet6_prot fails with %d\n", __func__, rc);
> > Here too.
> > 
> > > +		goto out_inet_prot;
> > > +	}
> > > +	inet6_register_protosw(&smc_inet6_protosw);
> > > +#endif
> > ...
> 

