Return-Path: <linux-rdma+bounces-14258-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F5AC35BFA
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 14:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5028418C826C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404663081A6;
	Wed,  5 Nov 2025 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N97HW+vp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC0314D22
	for <linux-rdma@vger.kernel.org>; Wed,  5 Nov 2025 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347731; cv=none; b=dbPy7756Ss1FCE5HBtll7Rm9grPq/ICm8shRWQlHFW3LT8Rxk9GIZwpPKZtwWoYEIcci39Vkz5OeXWB+GO1b6Cd5wjaIbKieP8v8UhoBgE7KPXizSks02fDrtEzgNe0BwhM+ISYc84RCq8D4A8OkpW+MfBDORAURBuxQ2sWbelc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347731; c=relaxed/simple;
	bh=2nn3r3K471DeTFVRTd9sYcn7gmPIiCR0EVwS+oKAKAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkaF8jt0KIGe0pWct3ztqrjnFD25Y36e6Imk9V0EWPm+OzE3Ho/JXYC4S76iGF9ssVXOFuuhjMClCco2ZcV+EtGOQr4281xgn4M8aHfvZODCCCyZmEDphO/DpYEy7UvQQZgjxnFzFmq9haqytEV0ZXloOQW2nmnqDLO+SjLiHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N97HW+vp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7015C4CEF8;
	Wed,  5 Nov 2025 13:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762347730;
	bh=2nn3r3K471DeTFVRTd9sYcn7gmPIiCR0EVwS+oKAKAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N97HW+vpp8dTbmVdvokahVJEA0pc1M+u8SMX6pU/ae5PxuLu7kFCcWe4a8cg/ul31
	 3MG1vcCvJtPBUtyGNAEp6U8Er8VTo8VhUyaKShq7z0BDYsOP4rW5luA+P5Chbpcce7
	 sERf9E1naX6ooFVFa7QqrsKzR9mUmWpkARWGeteFO59xQ4kptaO3+G3VtvakjvZGrf
	 8Mp9Own4eukpo6Obzb8m7//1Lt1d841j+o/8ln8ClLFSR+WdKJh0iYVGXcFJM2BW9N
	 PzFlXin9RYVdTDcKT5C3viIGl8+qwLT2j6UnrvOZMWoOrY/p/zDED0EkI91/3nZ0yq
	 3ODb/rvXFxUTg==
Date: Wed, 5 Nov 2025 15:02:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
	syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-next 1/1] RDMA/core: Fix WARNING in
 gid_table_release_one
Message-ID: <20251105130205.GD16832@unreal>
References: <20251104020845.254870-1-yanjun.zhu@linux.dev>
 <20251104130001.GI1204670@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104130001.GI1204670@ziepe.ca>

On Tue, Nov 04, 2025 at 09:00:01AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 03, 2025 at 06:08:45PM -0800, Zhu Yanjun wrote:
> > @@ -800,13 +800,24 @@ static void release_gid_table(struct ib_device *device,
> >  		return;
> >  
> >  	for (i = 0; i < table->sz; i++) {
> > +		int cnt = 200;
> > +
> >  		if (is_gid_entry_free(table->data_vec[i]))
> >  			continue;
> >  
> > -		WARN_ONCE(true,
> > -			  "GID entry ref leak for dev %s index %d ref=%u\n",
> > +		WARN_ONCE(table->data_vec[i]->state != GID_TABLE_ENTRY_PENDING_DEL,
> > +			  "GID entry ref leak for dev %s index %d ref=%u, state: %d\n",
> >  			  dev_name(&device->dev), i,
> > -			  kref_read(&table->data_vec[i]->kref));
> > +			  kref_read(&table->data_vec[i]->kref), table->data_vec[i]->state);
> > +
> > +		while ((kref_read(&table->data_vec[i]->kref) > 0) && (cnt > 0)) {
> > +			cnt--;
> > +			msleep(10);
> > +		}
> 
> Definately don't want to see this looping.
> 
> If it is waiting for the work queue then maybe this should flush the
> work queue.
> 
> Something like this?
> 
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -799,7 +799,19 @@ static void release_gid_table(struct ib_device *device,
>         if (!table)
>                 return;
>  
> +       mutex_lock(&table->lock);
>         for (i = 0; i < table->sz; i++) {
> +               if (is_gid_entry_free(table->data_vec[i]))
> +                       continue;
> +
> +               /*
> +                * The entry may be sitting in the WQ waiting for
> +                * free_gid_work(), flush it to try to clean it.
> +                */
> +               mutex_unlock(&table->lock);
> +               flush_workqueue(ib_wq);
> +               mutex_lock(&table->lock);

I don't think that this is right thing to do. If you want, you can call
to flush_workqueue(ib_wq) in ib_cache_release_one().

Thanks



> +
>                 if (is_gid_entry_free(table->data_vec[i]))
>                         continue;
>  
> @@ -808,6 +820,7 @@ static void release_gid_table(struct ib_device *device,
>                           dev_name(&device->dev), i,
>                           kref_read(&table->data_vec[i]->kref));
>         }
> +       mutex_unlock(&table->lock);
>  
>         mutex_destroy(&table->lock);
>         kfree(table->data_vec);
> 
> 
> 

