Return-Path: <linux-rdma+bounces-15184-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C171ACD975D
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04CA53016191
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 13:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78CF3358A4;
	Tue, 23 Dec 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNpTEEys"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BA190462;
	Tue, 23 Dec 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497090; cv=none; b=ig9ZJEc7zi4DpZHO9CZwhbGJMIqdMOaZrhNVdbzoKNJ1rkHN7BExdLWG5S/FfFULvGPcqOcYefoIPqHXWhvdbPzXpwWldD89YUaFxGFpKMZ0cWMoHA60Tx/DYGtv8NsbeV+t7Ku/QZNp/m/YDDg3UV5WtgAoI2BKybfytzAUmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497090; c=relaxed/simple;
	bh=WCBWujyaYXzSfhtQmnWXP8FlBsnTvfy+Mg/ntFvi0JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8Fc1iQ/3TQW4Qs9/JgWAqFSLOehuZY417KZxiXZnx8QfzJElksH5N5wrp7L1KFrzVGvJ16+2YZnTBp/haqbkG0YaSoaT19hE3ms2YZEEOFokAqFIc215X52CC7ZksSa65aBl7RfWgL/qUV0o2FP7CybT06fa5yzPMNxajkp+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNpTEEys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D66CC113D0;
	Tue, 23 Dec 2025 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766497090;
	bh=WCBWujyaYXzSfhtQmnWXP8FlBsnTvfy+Mg/ntFvi0JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNpTEEys6ESetW1HimHqAdtC6opRCB1xAQo7U21K2Hdc+mjs5TYh7zUhkeZe1bLcW
	 d4XVMv4TkBS89Ahd/RZ9f/O+6ot98o4kh9Dnwx8EFnak9r+rkLeW54MjyumMftIL3F
	 lN2YzRQTp6dFLMTZ4Cotmkpu4y9hFr5nklZx62HciA/rjCg4i6yEZGpoeT9Ao3i9+p
	 gaFeSzBRAL+6ivXfUmgshnwvc/FBtNA5Bqy1CGNIsTNDKiNeTOGfRVZHNrmCPNvMYy
	 fibm+r8LlLZL+DYCerZsSE1GN0Gf6hGkLOvNfFdu+dwUs0ahhoCv8P1AhEDlvNKNWR
	 uvNvdkd/o4BgA==
Date: Tue, 23 Dec 2025 15:38:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Honggang LI <honggangli@163.com>
Cc: haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: remove dead code
Message-ID: <20251223133804.GA11869@unreal>
References: <20251201032405.484231-1-honggangli@163.com>
 <20251218132259.GE39046@unreal>
 <aUoK5SoYcJXTpUAQ@fedora>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUoK5SoYcJXTpUAQ@fedora>

On Tue, Dec 23, 2025 at 11:22:13AM +0800, Honggang LI wrote:
> On Thu, Dec 18, 2025 at 03:22:59PM +0200, Leon Romanovsky wrote:
> > Subject: Re: [PATCH] RDMA/rtrs: remove dead code
> > From: Leon Romanovsky <leon@kernel.org>
> > Date: Thu, 18 Dec 2025 15:22:59 +0200
> > 
> > 
> > You can go one step further and remove rkey too.
> 
> You are right. But I'd like to keep rkey for readability.
> 
> How about follwing patch?
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 9ecc6343455d..4efb71c04a40 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -208,7 +208,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
>  	size_t sg_cnt;
>  	int err, offset;
>  	bool need_inval;
> -	u32 rkey = 0;
> +	u32 rkey;
>  	struct ib_reg_wr rwr;
>  	struct ib_sge *plist;
>  	struct ib_sge list;
> @@ -240,11 +240,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
>  	wr->wr.num_sge	= 1;
>  	wr->remote_addr	= le64_to_cpu(id->rd_msg->desc[0].addr);
>  	wr->rkey	= le32_to_cpu(id->rd_msg->desc[0].key);
> -	if (rkey == 0)
> -		rkey = wr->rkey;
> -	else
> -		/* Only one key is actually used */
> -		WARN_ON_ONCE(rkey != wr->rkey);
> +	rkey = wr->rkey;
>  
>  	wr->wr.opcode = IB_WR_RDMA_WRITE;
>  	wr->wr.wr_cqe   = &io_comp_cqe;
> 
> 
> Anyway, if you persisted, I will send a new patch as you suggested.

Please send new patch, there is not much readability in keeping "rkey =
wr->rkey" line.

Thanks

> 
> thanks
> > 
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index 9ecc6343455d..396dfc41e6da 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -208,7 +208,6 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
> >         size_t sg_cnt;
> >         int err, offset;
> >         bool need_inval;
> > -       u32 rkey = 0;
> >         struct ib_reg_wr rwr;
> >         struct ib_sge *plist;
> >         struct ib_sge list;
> > @@ -240,12 +239,6 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
> >         wr->wr.num_sge  = 1;
> >         wr->remote_addr = le64_to_cpu(id->rd_msg->desc[0].addr);
> >         wr->rkey        = le32_to_cpu(id->rd_msg->desc[0].key);
> > -       if (rkey == 0)
> > -               rkey = wr->rkey;
> > -       else
> > -               /* Only one key is actually used */
> > -               WARN_ON_ONCE(rkey != wr->rkey);
> > -
> >         wr->wr.opcode = IB_WR_RDMA_WRITE;
> >         wr->wr.wr_cqe   = &io_comp_cqe;
> >         wr->wr.ex.imm_data = 0;
> > @@ -277,7 +270,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
> >                 inv_wr.opcode = IB_WR_SEND_WITH_INV;
> >                 inv_wr.wr_cqe   = &io_comp_cqe;
> >                 inv_wr.send_flags = 0;
> > -               inv_wr.ex.invalidate_rkey = rkey;
> > +               inv_wr.ex.invalidate_rkey = wr->rkey;
> >         }
> >  
> >         imm_wr.wr.next = NULL;
> > ~
> > 
> > >  
> > >  	wr->wr.opcode = IB_WR_RDMA_WRITE;
> > >  	wr->wr.wr_cqe   = &io_comp_cqe;
> 

