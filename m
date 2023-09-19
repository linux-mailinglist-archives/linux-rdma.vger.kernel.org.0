Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DBD7A5DEE
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 11:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjISJaj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 05:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISJai (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 05:30:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B2EEC
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 02:30:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F101FC433C7;
        Tue, 19 Sep 2023 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695115832;
        bh=dEStBRU3J0BamCF9xUQ+Ax1uh2vS2ZVsV5VwPbBbfbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVaHsQOlvfF/2ragS2SYSBm7xPltEUE3C4PQJGyuGAPyjEiDPjliX54YaLOT4Oc+v
         f6pmGQsJt6991B9/3vy+VDK8e5bF8Xx68tm2wlsqLAmZnl5HNXZasjviHbZRvgjqoR
         PHP8jVkjXC1v7f/sifYqLBvRDv6sliWZ4ovBOW6pCAdNsoci+dY9zjHqNEHH/STr68
         njMduyJHQBvzHng4oVukV1dk0ltQdmJiagen0tfiwR4LtngiWNFlaZ1yNb0jQh4rhb
         UoFF0xKVRARAJ5/iIs2muLSnn3q05SasszBQ1+4pzeW4P1M529XyeLkeZqt35kRHHm
         YHw8fkaoJ5yYw==
Date:   Tue, 19 Sep 2023 12:30:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rtrs: Fix the problem of variable not
 initialized fully
Message-ID: <20230919093028.GG4494@unreal>
References: <20230919020806.534183-1-yanjun.zhu@intel.com>
 <20230919081712.GD4494@unreal>
 <01d9dd18-3d63-fabb-33d4-0de528f15a9a@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01d9dd18-3d63-fabb-33d4-0de528f15a9a@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 19, 2023 at 04:26:54PM +0800, Zhu Yanjun wrote:
> 
> 在 2023/9/19 16:17, Leon Romanovsky 写道:
> > On Tue, Sep 19, 2023 at 10:08:06AM +0800, Zhu Yanjun wrote:
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > 
> > > No functionality change. The variable which is not initialized fully
> > > will introduce potential risks.
> > Are you sure about not being initialized?
> 
> About this problem, I think we discussed it previously in RDMA maillist.
> 
> And at that time, IIRC, you shared a link with me. The link is as below.
> 
> https://www.ex-parrot.com/~chris/random/initialise.html
> 
> From what we discussed and the above link, I think it is not initialized
> fully.

I remember that discussion and it was about slightly different thing:
{} vs {0} in Linux kernel.

However I don't think that I sent you that link.
Anyway, let's take this patch as it is harmless.

Thanks

> 
> 
> Zhu Yanjun
> 
> > 
> > Thanks
> > 
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > >   drivers/infiniband/ulp/rtrs/rtrs.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > index 3696f367ff51..d80edfffd2e4 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> > > @@ -255,7 +255,7 @@ static int create_cq(struct rtrs_con *con, int cq_vector, int nr_cqe,
> > >   static int create_qp(struct rtrs_con *con, struct ib_pd *pd,
> > >   		     u32 max_send_wr, u32 max_recv_wr, u32 max_sge)
> > >   {
> > > -	struct ib_qp_init_attr init_attr = {NULL};
> > > +	struct ib_qp_init_attr init_attr = {};
> > >   	struct rdma_cm_id *cm_id = con->cm_id;
> > >   	int ret;
> > > -- 
> > > 2.40.1
> > > 
