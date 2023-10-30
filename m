Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DF07DBA01
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Oct 2023 13:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjJ3Mku (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Oct 2023 08:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjJ3Mkp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Oct 2023 08:40:45 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF3BB7
        for <linux-rdma@vger.kernel.org>; Mon, 30 Oct 2023 05:40:42 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-778925998cbso320111285a.0
        for <linux-rdma@vger.kernel.org>; Mon, 30 Oct 2023 05:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698669642; x=1699274442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=molrN2bMHZh5oor/TkmRjLj+0zRtggCfyjqWbE6KD7Y=;
        b=TWUljpkKBRQDSdiZrDj91bhZlj0iyh5unbJp/nTN5ubk02zM5gf3U6QkOMxVqaBHDG
         0wtbrwENeLw3wozE/ODscMrpnH8VDwkcRMSY7LFgAa9G3eCxzHKKJExJH8Yc5rkQO4lt
         9CGsaFw+ej/fjuz/+Om2eWPux0h1dzkSySdtHMSXECVIRk/uvi8dBgxt3Y1rTFQ7WVCs
         0q729rVn7BqyzhERyjJypAA7+OMvobRJKJbW6HGF3KHGt8ViND6tr/EsZTLwnICFjaov
         ShBiryzG/SMsBVCk2x7TAtrDxTWmpqRnaIW8mk48MuPdzBssExWrFf6MKVuLFhgGd43n
         Niiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698669642; x=1699274442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=molrN2bMHZh5oor/TkmRjLj+0zRtggCfyjqWbE6KD7Y=;
        b=T+86PjBz+Jb02CYlKBHRA11cHPhaxgf+R9YXmoNhyzCJbgZXbOd22CBA+OtYbpPwK9
         FQSykyeIPvWSaBcxGgUG0B5ddMp9TCE70KCgAJpPQSXBEFU2Fbh7Ahf9jBlw1RV5a3YY
         QAL73EoaMBseBWWVewrWlwPl0X0wFl111Rre2z9Ik5I/yATWfCdhe5K/1yKHuutPiMXS
         GwzY/C7A9J4DqsHBueuJARRjtrjoouxSXljyWyvhL9oL05uZ+w2h3PggVVkSpXas1dq9
         xpHu8MZGL6wUmgGRBtUY68i+bZRRxN82OqMg8ZfMat8olD5dGXpfpvgMb6eLeEYUuSZT
         mGoA==
X-Gm-Message-State: AOJu0Yztn20brQMFi14HXRCxCxq4hGPTbFaaUJTQDL4PDiUKd3e6rzRP
        ANKhmU+O1t3yU58TW38nkH42Ug==
X-Google-Smtp-Source: AGHT+IFQiTGf+DpYZI6/KAqgrSYdCWdsolhWJXAygY+kM8KIkHic0hv7QBHipjDqmxhiqJNkm+vWyg==
X-Received: by 2002:a05:620a:3953:b0:778:ba89:2fbd with SMTP id qs19-20020a05620a395300b00778ba892fbdmr9362026qkn.36.1698669642074;
        Mon, 30 Oct 2023 05:40:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id a11-20020a05620a124b00b0076cbcf8ad3bsm3234305qkl.55.2023.10.30.05.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:40:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qxRZR-006euh-5R;
        Mon, 30 Oct 2023 09:40:41 -0300
Date:   Mon, 30 Oct 2023 09:40:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH RFC 1/2] RDMA/rxe: don't allow registering !PAGE_SIZE mr
Message-ID: <20231030124041.GE691768@ziepe.ca>
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <4da48f85-a72f-4f6b-900f-fc293d63b5ae@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da48f85-a72f-4f6b-900f-fc293d63b5ae@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 30, 2023 at 07:51:41AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 27/10/2023 13:41, Li Zhijian wrote:
> > mr->page_list only encodes *page without page offset, when
> > page_size != PAGE_SIZE, we cannot restore the address with a wrong
> > page_offset.
> > 
> > Note that this patch will break some ULPs that try to register 4K
> > MR when PAGE_SIZE is not 4K.
> > SRP and nvme over RXE is known to be impacted.
> > 
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_mr.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> > index f54042e9aeb2..61a136ea1d91 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -234,6 +234,12 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
> >   	struct rxe_mr *mr = to_rmr(ibmr);
> >   	unsigned int page_size = mr_page_size(mr);
> >   
> > +	if (page_size != PAGE_SIZE) {
> 
> It seems this condition is too strict, it should be:
> 	if (!IS_ALIGNED(page_size, PAGE_SIZE))
> 
> So that, page_size with (N * PAGE_SIZE) can work as previously.
> Because the offset(mr.iova & page_mask) will get lost only when !IS_ALIGNED(page_size, PAGE_SIZE)

That makes sense

Jason
