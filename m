Return-Path: <linux-rdma+bounces-4688-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB5967FDD
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 09:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97CF281448
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8E8149E03;
	Mon,  2 Sep 2024 07:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8NduWHU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6FE32C85
	for <linux-rdma@vger.kernel.org>; Mon,  2 Sep 2024 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260455; cv=none; b=Onxf39Z1/aDSex7JnfEOImUabYIabr8UsHwr+RVjbWj7GybXZIXcYS9JHabAND6REdIBL4OZSSdpkmcRBSdzGXT6nh2kx/qwDX0e19WMAd/IHDwjEJxaS2Nc6L1BcYmrTEW9bhHHTedfpdy0MEcH7GLUz6RZ8V8V5fxP4pQI2aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260455; c=relaxed/simple;
	bh=zFVKin1BG0BDRYWKzcjCTpix7wRWvUQse0/5ImlhpjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBRLtoT8M5zDSBgkLeoTkgyQKZ2Bf9foNyOLJMuTGnhgDeCiTC91tIn6wRHhJUTaHeh9o1ws2kH6Scs7s7qWmYZBhY4RbeUmqn4OSFXIbuBCWOG2LDBeEtJRWKqhcJWlSu9ePr+TZRxcq1ak25KReNxbHVu1lfbgp0Hn3OjJw8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8NduWHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F51C4CEC8;
	Mon,  2 Sep 2024 07:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725260454;
	bh=zFVKin1BG0BDRYWKzcjCTpix7wRWvUQse0/5ImlhpjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8NduWHUBgv4L+Ig9Yj/9PZaScLvsfm9Ol1NU/nbe6BwMI1Qccq2/sQt32ycV0kKt
	 D0O8G6XBsRpIzZ49PuXw2qzs/wLGxEKUaZVzCNCOBepUgrRvF4SNCfbm4PVqHMm+5C
	 Vacg22j3s7QfhgGX9eB/ZUjVkM5/+7a6IwytE+3BGS+ofakpPpGi0K+AdFMIyObd3/
	 KMKrTZV37E+xD4/PJ5Cxuha75m7bhhB+hxtoCz8GKzCVuSEGyFbKNVBZWfKxFmsrMK
	 6Kj7wNIRZUYDqn68GMWZTk0b0M7WlHpCd0xVioFqYGyC5g5um2Q8J0Dhjr0mm4Ul2+
	 eGzHjLIMNONDQ==
Date: Mon, 2 Sep 2024 10:00:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
	=?utf-8?B?6Z2z5paH5a6+?= <jinwenbinxue@163.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug] =?iso-8859-1?Q?rdma-core=2Flibrd?=
 =?iso-8859-1?B?bWFjbS9jbWEuYyByZG1hX2NyZWF0ZV9xcF9leO+8YWRkIGlkLT5jcSBy?=
 =?iso-8859-1?Q?efer_to_qp=5Fattr-=3Ecq?= =?iso-8859-1?Q?=2C?= when
 qp_attr->cq is not NULL, and id->cq is NULL
Message-ID: <20240902070050.GB4026@unreal>
References: <f819f8c.52ce.191927ea67c.Coremail.jinwenbinxue@163.com>
 <63408cd4-c4a9-4268-84a7-2c7fab9b690e@fujitsu.com>
 <34234a57-9553-4193-a855-ee1ebbea3d6e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34234a57-9553-4193-a855-ee1ebbea3d6e@linux.dev>

On Thu, Aug 29, 2024 at 08:04:55PM +0800, Zhu Yanjun wrote:
> 在 2024/8/28 8:51, Zhijian Li (Fujitsu) 写道:
> > Not related to your modification,
> > 
> > In general,
> > - Please report a bug with more details, such as how to reproduce, your expectations and what's the impact, etc...
> > - Please follow the patch submit instruction[1] or a PR if you want to submit a patch to the communities.
> > 
> > [1] https://docs.kernel.org/process/submitting-patches.html
> 
> It seems a rdma-core problem. Not sure if it is reasonable to use the above
> link.

It is, https://github.com/linux-rdma/rdma-core/blob/master/Documentation/contributing.md
# Contributing to rdma-core

rdma-core is a userspace project for a Linux kernel interface and follows many
of the same expectations as contributing to the Linux kernel:

 - One change per patch

   Carefully describe your change in the commit message and break up work into
   appropriate reviewable commits.

   Refer to [Linux Kernel Submitting Patches](https://github.com/torvalds/linux/blob/master/Documentation/process/submitting-patches.rst)
   for general information.

 - Developer Certificate of Origin 'Signed-off-by' lines

   Include a Signed-off-by line to indicate your submission is suitable
   licensed and you have the legal authority to make this submission
   and accept the [DCO](#developers-certificate-of-origin-11)

 - Broadly follow the [Linux Kernel coding style](https://github.com/torvalds/linux/blob/master/Documentation/process/coding-style.rst)

As in the Linux Kernel, commits that are fixing bugs should be marked with a
Fixes: line to help backporting.

....

> 
> Zhu Yanjun
> 
> > 
> > 
> > On 27/08/2024 14:20, 靳文宾 wrote:
> > > 
> > > 
> > > 
> > > 
> > > 
> > > I think the following modification is more correct,
> > > if there have something i dont know, pls tell me, thx
> > > 
> > > 
> > > 
> > > 
> > > 
> > > diff --git a/librdmacm/cma.c b/librdmacm/cma.c
> > > index 7b924bd0d..9e71ba858 100644
> > > --- a/librdmacm/cma.c
> > > +++ b/librdmacm/cma.c
> > > @@ -1654,10 +1654,20 @@ int rdma_create_qp_ex(struct rdma_cm_id *id,
> > >           if (ret)
> > >                   return ret;
> > > 
> > > 
> > > -       if (!attr->send_cq)
> > > +       if (!attr->send_cq) {
> > >                   attr->send_cq = id->send_cq;
> > > -       if (!attr->recv_cq)
> > > +       } else {
> > > +               if (!id->recv_cq)
> > > +                       id->recv_cq = attr->recv_cq;
> > > +       }
> > > +       if (!attr->recv_cq) {
> > >                   attr->recv_cq = id->recv_cq;
> > > +       } else {
> > > +               if (!id->recv_cq)
> > > +                       id->recv_cq = attr->recv_cq;
> > > +       }
> > > +
> > > +
> > >           if (id->srq && !attr->srq)
> > >                   attr->srq = id->srq;
> > >           qp = ibv_create_qp_ex(id->verbs, attr);
> > > 
> > > 
> > > 
> > > 
> 
> 

