Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33076E0E74
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 15:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDMNYZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 09:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDMNYY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 09:24:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE47213A;
        Thu, 13 Apr 2023 06:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 225C163718;
        Thu, 13 Apr 2023 13:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FB1C433EF;
        Thu, 13 Apr 2023 13:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681392262;
        bh=KuxotA2X64nDchQM+BqVErMy/wOEGlek580an2yVZcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkb7UL+pBaB950GCAe8DgJ1EgS7prvAGfUaWkcl38+k0eUuV5Ra5KLb4gbw2ebvxW
         27Hf0E0rl18W/jYHuUPUFlvppucNvKmRq3eb1lPj8d4wgjo4QqXZjpPAbS83YkgNjN
         Xpq/Kvj624zOC7yx+iTEQNZtv01trXojgeJCLa6hzSoptnMxxX37X5Q0LL3GmpZ9QL
         ob22VoL4C8BtVFGvkWN/vDwmOolAPcLk1feoCjjwmgkM8t+oPeh5khnY3UfMzqM5+h
         oY7v91gYl6kBs2c01O2dtRTb8h6sCpusykfJIywEYgZ7wDTH99Sv8zqg7bqHcg7eR+
         +GFmnaUKFaq2g==
Date:   Thu, 13 Apr 2023 16:24:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Message-ID: <20230413132418.GR17993@unreal>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
 <1681108984-2-3-git-send-email-lizhijian@fujitsu.com>
 <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
 <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
 <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 13, 2023 at 08:12:15AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 13/04/2023 15:35, Guoqing Jiang wrote:
> > Hi,
> > 
> > I take a closer look today.
> > 
> > On 4/12/23 09:15, Zhijian Li (Fujitsu) wrote:
> >>
> >> On 11/04/2023 20:26, Leon Romanovsky wrote:
> >>> On Tue, Apr 11, 2023 at 02:43:46AM +0000, Zhijian Li (Fujitsu) wrote:
> >>>>
> >>>> On 10/04/2023 21:10, Guoqing Jiang wrote:
> >>>>>
> >>>>> On 4/10/23 20:08, Leon Romanovsky wrote:
> >>>>>> On Mon, Apr 10, 2023 at 06:43:03AM +0000, Li Zhijian wrote:
> >>>>>>> The warning occurs when destroying PD whose reference count is not zero.
> >>>>>>>
> >>>>>>> Precodition: clt_path->s.con_num is 2.
> >>>>>>> So 2 cm connection will be created as below:
> >>>>>>> CPU0                                              CPU1
> >>>>>>> init_conns {                              |
> >>>>>>>      create_cm() // a. con[0] created        |
> >>>>>>>                                              |  a'. rtrs_clt_rdma_cm_handler() {
> >>>>>>>                                              |    rtrs_rdma_addr_resolved()
> >>>>>>>                                              |      create_con_cq_qp(con); << con[0]
> >>>>>>>                                              |  }
> >>>>>>>                                              | in this moment, refcnt of PD was increased to 2+
> > 
> > What do you mean "refcnt of PD"? usecnt in struct ib_pd or dev_ref.
> 
> I mean usecnt in struct ib_pd
> 
> 
> 
> > 
> >>>>>>>                                              |
> >>>>>>>      create_cm() // b. cid = 1, failed       |
> >>>>>>>        destroy_con_cq_qp()                   |
> >>>>>>>          rtrs_ib_dev_put()                   |
> >>>>>>>            dev_free()                        |
> >>>>>>>              ib_dealloc_pd(dev->ib_pd) << PD |
> >>>>>>>               is destroyed, but refcnt is    |
> >>>>>>>               still greater than 0           |
> > 
> > Assuming you mean "pd->usecnt". We only allocate pd in con[0] by rtrs_ib_dev_find_or_add,
> > if con[1] failed to create cm, then alloc_path_reqs -> ib_alloc_mr -> atomic_inc(&pd->usecnt)
> > can't be triggered. Is there other places could increase the refcnt?
> 
> 
> Yes, when create a qp, it will also associate to this PD, that also mean refcnt of PD will be increased.
> 
> When con[0](create_con_cq_qp) succeeded, refcnt of PD will be 2. and then when con[1] failed, since
> QP didn't create, refcnt of PD is still 2. con[1]'s cleanup will destroy the PD(ib_dealloc_pd) since dev_ref = 1, after that its
> refcnt is still 1.

Why is refcnt 1 in con[1] destruction phase? It seems to me like a bug.

Thanks
