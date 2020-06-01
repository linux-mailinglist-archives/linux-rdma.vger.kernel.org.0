Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237931EA3CF
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2020 14:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgFAM0t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jun 2020 08:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgFAM0t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Jun 2020 08:26:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FF2C061A0E
        for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2020 05:26:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i68so7450775qtb.5
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jun 2020 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L5HBZef8rW+3rS1Wf6w+fkABsfR9QDkKriEf9aIYvug=;
        b=Xc3MmKKHmKJeN9/5X1HCEmfWDGw2boEeW6Y7F8qaByTAL9jeGhjH12YjwB0Ruupiug
         uF08s/DpRexYeK+ulezY8je+GmN3T3rGYCLuxmbAXdd8lL21ebDN4PNV+N2L7TaLSKIc
         G8+7FJrDcT2FNyuRFB5YOUVVPDhqw5uattZg15sntBq4N39rnkqLK2XnZNVvVA9XMi+J
         hk/u2ZCghsAwy4XwkWGqTExJTDONaiYAJU8g3SSB4p6GoSBrk1HbtNUxIJyYMP727vGl
         cYSJII1yFZJy22a9L/rhAH3gEKzT8XhPc8HIoYlvQjG9UDAU0jCFaGegmgPPs79mKysy
         fPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L5HBZef8rW+3rS1Wf6w+fkABsfR9QDkKriEf9aIYvug=;
        b=s3k4XX2NPcA0QEqXQZGxDmvTkkzNWDrJt4JD5b6XhpGppAcNtlHgxWNNmovzLsHvc6
         DwCFTDSsaN70qJFW//fzarBMCPx6eG2+lCZL8de8yI/nr0hkZKYweSznVp8D8N9Xc1Zr
         p4hwcSUdlflMWTcDRX86bGeCpG6Jl2sSarl2FbDtn2FNqZ4OsnjWhrwn4rvxGJ7Vrj2+
         Zq/4vgc4R5G73HgY1MFhKbRuuDpbRUEqq8Ln+tb1BckUzVqrFM3tQoIjYw0zzTw7Ai8e
         O2Cl+h//QXKfridsTsV3cmhuT6AF4gbkWzUzamxNmI26i+GKWDCmaQlTPdrmREnplkf1
         b9Ig==
X-Gm-Message-State: AOAM531HAna1Z0frHHU9F+hV3VQ0/n9DkmWGdlIrQE11fWzlhgrKaYM9
        VitjALGmVjnpmNo5I8/JFkTmnQ==
X-Google-Smtp-Source: ABdhPJxRN8IgRI0mV9jBEi+R0gjBN6Ynis1+oJLf0i6CizXtJaU9SFMRFJDv/BPPE68bPuP5X4guvw==
X-Received: by 2002:ac8:775b:: with SMTP id g27mr21781330qtu.217.1591014408100;
        Mon, 01 Jun 2020 05:26:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p11sm15128609qtq.75.2020.06.01.05.26.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jun 2020 05:26:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jfjWg-0002UL-KI; Mon, 01 Jun 2020 09:26:46 -0300
Date:   Mon, 1 Jun 2020 09:26:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 11/11] RDMA/mlx5: Add support to get MR
 resource in RAW format
Message-ID: <20200601122646.GA4872@ziepe.ca>
References: <20200527135408.480878-1-leon@kernel.org>
 <20200527135408.480878-12-leon@kernel.org>
 <20200529233121.GA3296@ziepe.ca>
 <20200531095414.GE66309@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531095414.GE66309@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 31, 2020 at 12:54:14PM +0300, Leon Romanovsky wrote:
> On Fri, May 29, 2020 at 08:31:21PM -0300, Jason Gunthorpe wrote:
> > On Wed, May 27, 2020 at 04:54:08PM +0300, Leon Romanovsky wrote:
> > > From: Maor Gottlieb <maorg@mellanox.com>
> > >
> > > Add support to get MR (mkey) resource dump in RAW format.
> > >
> > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/hw/mlx5/restrack.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
> > > index 9e1389b8dd9f..834886536127 100644
> > > +++ b/drivers/infiniband/hw/mlx5/restrack.c
> > > @@ -116,7 +116,8 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
> > >  	struct nlattr *table_attr;
> > >
> > >  	if (raw)
> > > -		return -EOPNOTSUPP;
> > > +		return fill_res_raw(msg, mr->dev, MLX5_SGMT_TYPE_PRM_QUERY_MKEY,
> > > +				    mlx5_mkey_to_idx(mr->mmkey.key));
> >
> > None of the raw functions actually share any code with the non raw
> > part, why are the in the same function? In fact all the implemenations
> > just call some other function for raw.
> >
> > To me this looks like they should should all be a new op
> > 'fill_raw_res_mr_entry' and drop the 'bool'
> 
> I don't think that this is right approach, we already created ops per-objects
> o remove API multiplexing. Extra de-duplication will create too much ops
> without any real benefit.

If there is no code sharing then they should not be in the same
function at all. More ops is not really a problem.

Jason
