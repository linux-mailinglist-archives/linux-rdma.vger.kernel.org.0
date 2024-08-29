Return-Path: <linux-rdma+bounces-4627-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A2963F85
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 11:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503F9B217FD
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 09:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A750A15666A;
	Thu, 29 Aug 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/qE+Fij"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890118C03F
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922528; cv=none; b=FlO2aVRlj0NduQyuARAtPfxEk5ucdoulYezfiTTLuakIEyJNFP0g6jKfZ24NHDpV+s0VTnsG+AN7IRg+inUEAxE4ZXcxtFnQjcFs2EKslYOQwws71S2wx+c+x0eMdkWYRbo1ZwA5HGfVGW+Wo5KR7MSBkUAdOB7xYTCrsZg9jj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922528; c=relaxed/simple;
	bh=8DS27ZW58nH7Zyu+fD+XCziCBpLJW6EnfDWKw96qvJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H43PIeX9941rohYO8v3K6ouRXyy3w+PyrB00Jxj2PPEdnQ3ptBEdyGqVIMAfN3TXvaOfuiR25U55os+f4E62RilYNCVTYPCorl2OMWNzZZ65Qy8LMmfPKoZXXGqfrdS8fshl3jieNdvvqTZXikAqD2Hyhsw0jJOyB8G4Ltrytsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/qE+Fij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A78BC4CEC1;
	Thu, 29 Aug 2024 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724922528;
	bh=8DS27ZW58nH7Zyu+fD+XCziCBpLJW6EnfDWKw96qvJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/qE+Fij7D8SNPeLboQtGKU7UBXEqt1tuPjuCf9NHk1WVV2hhivxU4sU77U5jGPTW
	 BBJfptaqaBR4vGaXP6GY1YNSpvB8QBcx7+VTMWVZgGfnkLQkdY3/rtBX0MninxOcGa
	 DXk4mmkUHx03ZlXy6GSJCJ8WJzT+BMLr9fBV/hLm6aS6Mc1Ty4YfkU49t+5hwLWpML
	 io8Rc/xbP7jOVfZYGOV3iDdsbUVQIxYJm7rWR7RLc3OYoJ9QEZaRswmpdYKwoLpIuP
	 T9z758/I4FwIHoQ7Aop65kdfaBoemfJRTBHnn1KsEchUA96HJy38VR9JFbQ188KmrO
	 sAjLx++0upp1Q==
Date: Thu, 29 Aug 2024 12:08:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: =?utf-8?B?6Z2z5paH5a6+?= <jinwenbinxue@163.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug] =?utf-8?Q?rdma-core=2Flibrdmacm?=
 =?utf-8?B?L2NtYS5jIHJkbWFfY3JlYXRlX3FwX2V477yaYWRkIGlkLT5jcSByZWZlciB0?=
 =?utf-8?Q?o?= qp_attr->cq, when qp_attr->cq is not NULL, and id->cq is NULL
Message-ID: <20240829090844.GA26654@unreal>
References: <f819f8c.52ce.191927ea67c.Coremail.jinwenbinxue@163.com>
 <63408cd4-c4a9-4268-84a7-2c7fab9b690e@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63408cd4-c4a9-4268-84a7-2c7fab9b690e@fujitsu.com>

On Wed, Aug 28, 2024 at 12:51:30AM +0000, Zhijian Li (Fujitsu) wrote:
> Not related to your modification,
> 
> In general,
> - Please report a bug with more details, such as how to reproduce, your expectations and what's the impact, etc...
> - Please follow the patch submit instruction[1] or a PR if you want to submit a patch to the communities.
> 
> [1] https://docs.kernel.org/process/submitting-patches.html

+1

Thanks

> 
> 
> On 27/08/2024 14:20, 靳文宾 wrote:
> > 
> > 
> > 
> > 
> > 
> > I think the following modification is more correct,
> > if there have something i dont know, pls tell me, thx
> > 
> > 
> > 
> > 
> > 
> > diff --git a/librdmacm/cma.c b/librdmacm/cma.c
> > index 7b924bd0d..9e71ba858 100644
> > --- a/librdmacm/cma.c
> > +++ b/librdmacm/cma.c
> > @@ -1654,10 +1654,20 @@ int rdma_create_qp_ex(struct rdma_cm_id *id,
> >          if (ret)
> >                  return ret;
> > 
> > 
> > -       if (!attr->send_cq)
> > +       if (!attr->send_cq) {
> >                  attr->send_cq = id->send_cq;
> > -       if (!attr->recv_cq)
> > +       } else {
> > +               if (!id->recv_cq)
> > +                       id->recv_cq = attr->recv_cq;
> > +       }
> > +       if (!attr->recv_cq) {
> >                  attr->recv_cq = id->recv_cq;
> > +       } else {
> > +               if (!id->recv_cq)
> > +                       id->recv_cq = attr->recv_cq;
> > +       }
> > +
> > +
> >          if (id->srq && !attr->srq)
> >                  attr->srq = id->srq;
> >          qp = ibv_create_qp_ex(id->verbs, attr);
> > 
> > 
> > 
> > 
> > 

