Return-Path: <linux-rdma+bounces-511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D68820BE1
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Dec 2023 16:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87424281CB0
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Dec 2023 15:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B8163CF;
	Sun, 31 Dec 2023 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgO03Hm0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3942563B9;
	Sun, 31 Dec 2023 15:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1399CC433C8;
	Sun, 31 Dec 2023 15:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704037746;
	bh=qjUVcibRSmXJ6O51ss3IGOGL/tih+9HEbavaa2G55e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgO03Hm0VirEz61lQKPqNSNVskfvtJG5mtp8T7W/yBuAsozFhci0zHCQx3wfs8K8b
	 Bv02dXX9NcPjJIz9lCdseTAromPWdQLt+mSrSShpVi9Vh8THloF7pOOpPe1Qqn+lP8
	 AGHJLl+oxV9M0fufBQ//1ohkLYlbssGJVCVDg+3prQd025DZ0HjQNeb82Ro2EMXsbJ
	 2MbFe/CO/J28bvB7VlmQQhp42cDxSwhZtxG9p9p2yEjnBMPL+GxqahwsqTK3VDDX+9
	 Fvnd1r4gq+CNkR5+VMVYs84mzKS5c37WuAXjVKjJiuhyXoI0FLAn4q9MNWCcPtnxPV
	 lRR6MxeGGspWQ==
Date: Sun, 31 Dec 2023 17:49:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: jgg@ziepe.ca, gustavoars@kernel.org, bvanassche@acm.org,
	markzhang@nvidia.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/sa_query: use validate not parser in
 ib_nl_is_good_resolve_resp
Message-ID: <20231231154902.GD6849@unreal>
References: <20231230051956.82499-1-linma@zju.edu.cn>
 <20231230154422.GB6849@unreal>
 <7d95dbb5.63777.18cbe57e107.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d95dbb5.63777.18cbe57e107.Coremail.linma@zju.edu.cn>

On Sun, Dec 31, 2023 at 01:27:59PM +0800, Lin Ma wrote:
> Hello Leon,
> 
> > > The attributes array `tb` in ib_nl_is_good_resolve_resp is never used
> > > after the parsing. Therefore use nla_validate_deprecated function here
> > > for improvement.
> > 
> > What did this change improve?
> > 
> 
> To my concern, the nla_validate_deprecated, compared to nla_parse_deprecated,
> will at lease save a memset in function nla_parse_deprecated
> 
> ```
> if (tb)
>     memset(tb, 0, sizeof(struct nlattr *) * (maxtype + 1));
> ```
> 
> Morever, because the `nla_validate_deprecated` just validate the attributes
> array and will not try to retrieve the nla pointers. It shall be faster
> and cleaner here :D.

We don't care about speed in this path.
Let's leave the code as is.

Thanks

> 
> Regards
> Lin

