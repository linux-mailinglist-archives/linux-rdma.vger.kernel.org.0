Return-Path: <linux-rdma+bounces-4305-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CB394E087
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 10:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9C0B21006
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE48219E0;
	Sun, 11 Aug 2024 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ8Ywb2i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A304A22EE8;
	Sun, 11 Aug 2024 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723365098; cv=none; b=Za/ZWDfjcHJ6OMBrXtFSXdR1COuhXtQFqzf/acRsUyzcDFONnQ4q3dVKgp6HvDa0GDlbOgwgDWfLPtrFIHt2MYDIVJZv4aGYH/Ls46NgY5Um+IfktejwJAk0Y8m3pn3u6NLdaccrlIg4I/7nXxlKb9cM9194k0Voc9V00KHzY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723365098; c=relaxed/simple;
	bh=kzajr3Hjnuc15lf2t6XaLhgE+cZOuYOk7G1o9maXKSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itBvyHYU3rs1UmXz6hGNIBzmwnSQ8QcGmQHiu2ec4SB7DtjjhBsTgdPFV7I1ALmKPhcDE72LYUeA/Bc4WemmzsOEls+1OrMadmeoxHl4ys4PA3SpyOw+rVwZqlK6KeTLifsx8Xkafa+BLHosa9+vUac79c0fekr0saDRNMubvEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ8Ywb2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59000C4AF0C;
	Sun, 11 Aug 2024 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723365098;
	bh=kzajr3Hjnuc15lf2t6XaLhgE+cZOuYOk7G1o9maXKSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQ8Ywb2iYilEVn1XF3RZRLwtNBhN8pXek14ssYNNWdbjK+RYnbfhTn9uFHG0nB1La
	 ix1nw61dETixYmC7r0RRMb9oOvQZMFnoG0j3N8eiSdbeUKZpr1qHJm9PbpTxC6POo4
	 FHvF1Bcx9UbK6qvQ269SEtoBNRynRfo5j/7LRFD39uOhLiOPJx3j4LATYpyrASNhnm
	 HDc9278UKI3UqqwhMmQw6D+rWHMDuvkggRXmmWW+tmAYz8EhcllNKDrM10aCjg20R5
	 pzssrl5MTaRQ0WRraph49wI+lbZ3qwKRvMWOAk6dubbZgDkBe5gun42IMDqZBR8AS/
	 /FtZZ60VQ7CqA==
Date: Sun, 11 Aug 2024 11:31:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Liu Jian <liujian56@huawei.com>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, jgg@ziepe.ca,
	zyjzyj2000@gmail.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 4/4] RDMA/rxe: Set queue pair cur_qp_state when
 being queried
Message-ID: <20240811083133.GA5925@unreal>
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <20240809083148.1989912-5-liujian56@huawei.com>
 <72029ea9-f550-470e-9e5d-42e95ca4592e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72029ea9-f550-470e-9e5d-42e95ca4592e@linux.dev>

On Fri, Aug 09, 2024 at 07:06:34PM +0800, Zhu Yanjun wrote:
> 在 2024/8/9 16:31, Liu Jian 写道:
> > Same with commit e375b9c92985 ("RDMA/cxgb4: Set queue pair state when
> >   being queried"). The API for ib_query_qp requires the driver to set
> > cur_qp_state on return, add the missing set.
> > 
> 
> Add the following?
> Cc: stable@vger.kernel.org

There is no need to add stable tag for RXE driver. Distros are not
supporting this driver, which is used for development and not for
production.

Thanks

> 
> > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > Signed-off-by: Liu Jian <liujian56@huawei.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_verbs.c | 2 ++
> >   1 file changed, 2 insertions(+)

