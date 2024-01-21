Return-Path: <linux-rdma+bounces-668-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546F98355E5
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jan 2024 14:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EF62825CC
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jan 2024 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76A337165;
	Sun, 21 Jan 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd3FOdmS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9080C273FB;
	Sun, 21 Jan 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705842585; cv=none; b=jHYO4Nn+MMNPizsCstC9YnVrwRg427CzR3A1/5Zzu8w3q6oyHQimBvyXdoInfEamCnoUgd75MjyMOU8dviFeZK1nDY5eDg3j2V/lACCvjLVd+6HxBIOjJiySLZysZ+NyQdO3L82NbWm5LdL95f8jfGqxZfkKsXTqnmRKakj5F+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705842585; c=relaxed/simple;
	bh=9cyDx1F/dYPJrf8RZbUvqLxyHay+cmGJp31p+JZ2tBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiDCQsa+Ox3ysxwcPsbDDurH0zqqDe+V72QHOzurHimcgFp3mJRW0x5V4XZaKMpZAzc6M0mdWoNBclarzxNiD7ktXzWsG/eJZa/VFht2TC+kSXKVn2xkIasyT3gkuQAY7yGyXn4e4g5GgtyAoN234Yi5upmK3Oo62G/gLLpE4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd3FOdmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A0FC433C7;
	Sun, 21 Jan 2024 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705842585;
	bh=9cyDx1F/dYPJrf8RZbUvqLxyHay+cmGJp31p+JZ2tBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yd3FOdmSElZt7EwwlOyHijJCPPd8/8JTm/iNfsZcAFaJlWSUC7ysZMyGRPvUmMxsv
	 L60jypo5eBKcMvi5iEl9IvUIWaAxmP3x6M3r+d4XUnlT/RMWeK93dvrHosPkKROUUb
	 ZOkcpxfL2xXss9El/SxQTuICc1VV9/hvl9m9JHYYWjFkWujdXhT+ZPZozsH6rx5nEW
	 U+3bqCJ1BRYppcvn76KfHmELqQgyUGAYmE1FA1W5u0P91BEASJ383RwsKMEXxet6D9
	 S/w3yQhIZwS0mrJEgkIJRIsCtZUvFufDAVmkWvUQfRRH769U6ggcFVOygT+/r5/P0A
	 megt6AA8IgTwQ==
Date: Sun, 21 Jan 2024 15:09:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Zhipeng Lu <alexious@zju.edu.cn>, Jason Gunthorpe <jgg@ziepe.ca>,
	Ravi Krishnaswamy <ravi.krishnaswamy@intel.com>,
	Harish Chegondi <harish.chegondi@intel.com>,
	Brendan Cunningham <brendan.cunningham@intel.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: fix a memleak in init_credit_return
Message-ID: <20240121130940.GA7547@unreal>
References: <20240112085523.3731720-1-alexious@zju.edu.cn>
 <20240114090434.GD6404@unreal>
 <28aeb877-c0b4-4236-87d5-0bbaeb185656@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28aeb877-c0b4-4236-87d5-0bbaeb185656@cornelisnetworks.com>

On Thu, Jan 18, 2024 at 06:14:11PM -0500, Dennis Dalessandro wrote:
> On 1/14/24 4:04 AM, Leon Romanovsky wrote:
> > On Fri, Jan 12, 2024 at 04:55:23PM +0800, Zhipeng Lu wrote:
> >> When dma_alloc_coherent fails to allocate dd->cr_base[i].va,
> >> init_credit_return should deallocate dd->cr_base and
> >> dd->cr_base[i] that allocated before. Or those resources
> >> would be never freed and a memleak is triggered.
> >>
> >> Fixes: 7724105686e7 ("IB/hfi1: add driver files")
> >> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> >> ---
> >>  drivers/infiniband/hw/hfi1/pio.c | 6 +++++-
> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
> >> index 68c621ff59d0..5a91cbda4aee 100644
> >> --- a/drivers/infiniband/hw/hfi1/pio.c
> >> +++ b/drivers/infiniband/hw/hfi1/pio.c
> >> @@ -2086,7 +2086,7 @@ int init_credit_return(struct hfi1_devdata *dd)
> >>  				   "Unable to allocate credit return DMA range for NUMA %d\n",
> >>  				   i);
> >>  			ret = -ENOMEM;
> >> -			goto done;
> >> +			goto free_cr_base;
> >>  		}
> >>  	}
> >>  	set_dev_node(&dd->pcidev->dev, dd->node);
> >> @@ -2094,6 +2094,10 @@ int init_credit_return(struct hfi1_devdata *dd)
> >>  	ret = 0;
> >>  done:
> >>  	return ret;
> >> +
> >> +free_cr_base:
> >> +	free_credit_return(dd);
> > 
> > Dennis,
> > 
> > The idea of this patch is right, but it made me wonder, if
> > free_credit_return() is correct.
> 
> Yes, I've double checked the call path and if init_credit_return() fails we do
> not call the free_credit_return().
> 
> So this patch:
> 
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> 
> 
> > 
> > init_credit_return() iterates with help of for_each_node_with_cpus():
> > 
> >   2062 int init_credit_return(struct hfi1_devdata *dd)
> >   2063 {
> > ...
> >   2075         for_each_node_with_cpus(i) {
> >   2076                 int bytes = TXE_NUM_CONTEXTS * sizeof(struct credit_return);
> >   2077
> > 
> > But free_credit_return uses something else:
> >   2099 void free_credit_return(struct hfi1_devdata *dd)
> >   2100 {
> > ...
> >   2105         for (i = 0; i < node_affinity.num_possible_nodes; i++) {
> >   2106                 if (dd->cr_base[i].va) {
> > 
> > Thanks
> > 
> >> +	goto done;
> >>  }
> >>  
> >>  void free_credit_return(struct hfi1_devdata *dd)
> 
> I think we are OK because the allocation uses node_affinity.num_possible_nodes
> and in free_credit_return() we walk that entire array and if something is
> allocated we free it.
> 
> Now why do we use for_each_node_with_cpus() at all? I believe that is because it
> produces a subset of what is represented by num_possible_nodes(), which is OK
> and doesn't leak anything.

You are right, let's wait till merge window ends and we will apply this patch to rdma-rc.

Thanks

> 
> -Denny
> 

