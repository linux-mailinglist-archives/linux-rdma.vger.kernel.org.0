Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349746E4FD7
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Apr 2023 20:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjDQSFu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Apr 2023 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDQSF2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Apr 2023 14:05:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A767FB46B;
        Mon, 17 Apr 2023 11:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE6FF620B7;
        Mon, 17 Apr 2023 18:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A889C4339B;
        Mon, 17 Apr 2023 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681754697;
        bh=lEnPOPyb3DT5cv0fGWHOhu7wknil+97PEMXdzv9SzXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvmlC7pHZsXvi5QLTJenil7WnvS2E1E7s0XHO3UI5sOocVqufe1oTkW6RRPZX+V2C
         zvTHTAoJJNN4APvu1S6PBnO6jFNliAj7YMmbcsVar8kcSb0jmmDsF+b+Q4DUg3v4BP
         g0yIn9dHQVeegOJh5WZ/3ZymvjqyVr5X41baYNaHJqaPdg94qsMu/nkkhZ64bTaUXe
         oyzyvTlk7qgT+2DAHAL/7mYwC3nPaunZQysOjNeotMKKF+utnbOimtHa+ZDsYTr/G2
         eBNPK7aMVPDpu/BpzOLYwqPlqVO309LSqIuw0LjUCJPgZbT8vj2vtYSuQgetekIfp/
         qp0aZ7BBJs3hA==
Date:   Mon, 17 Apr 2023 21:04:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next 2/3] RDMA/rtrs: Fix rxe_dealloc_pd warning
Message-ID: <20230417180452.GG15386@unreal>
References: <20230410120809.GN182481@unreal>
 <0d9c57db-bca3-adb4-71fd-7362e4842917@linux.dev>
 <85323eb2-cfc7-d1b8-3a75-3fa63dde29db@fujitsu.com>
 <20230411122651.GV182481@unreal>
 <aa43746f-77f9-8592-5370-2a5042506ee5@fujitsu.com>
 <8fe62e38-e43d-3d6c-624f-1c8ce5859788@linux.dev>
 <f85cdaaa-b1d6-bc89-e963-8b611ae3667d@fujitsu.com>
 <20230413132418.GR17993@unreal>
 <4d1cacbf-f9b2-07c7-75bf-61f34abc1841@linux.dev>
 <7656e04c-1adc-6621-0e45-e2b282e6c143@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7656e04c-1adc-6621-0e45-e2b282e6c143@fujitsu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 17, 2023 at 02:18:24AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 14/04/2023 23:58, Zhu Yanjun wrote:
> > 在 2023/4/13 21:24, Leon Romanovsky 写道:
> >> On Thu, Apr 13, 2023 at 08:12:15AM +0000, Zhijian Li (Fujitsu) wrote:
> >>>
> >>>
> >>> On 13/04/2023 15:35, Guoqing Jiang wrote:
> >>>> Hi,
> >>>>
> >>>> I take a closer look today.
> >>>>
> >>>> On 4/12/23 09:15, Zhijian Li (Fujitsu) wrote:
> >>>>>
> >>>>> On 11/04/2023 20:26, Leon Romanovsky wrote:
> >>>>>> On Tue, Apr 11, 2023 at 02:43:46AM +0000, Zhijian Li (Fujitsu) wrote:
> >>>>>>>
> >>>>>>> On 10/04/2023 21:10, Guoqing Jiang wrote:
> >>>>>>>>
> >>>>>>>> On 4/10/23 20:08, Leon Romanovsky wrote:
> >>>>>>>>> On Mon, Apr 10, 2023 at 06:43:03AM +0000, Li Zhijian wrote:
> >>>>>>>>>> The warning occurs when destroying PD whose reference count is not zero.
> >>>>>>>>>>
> >>>>>>>>>> Precodition: clt_path->s.con_num is 2.
> >>>>>>>>>> So 2 cm connection will be created as below:
> >>>>>>>>>> CPU0                                              CPU1
> >>>>>>>>>> init_conns {                              |
> >>>>>>>>>>       create_cm() // a. con[0] created        |
> >>>>>>>>>>                                               |  a'. rtrs_clt_rdma_cm_handler() {
> >>>>>>>>>>                                               |    rtrs_rdma_addr_resolved()
> >>>>>>>>>>                                               |      create_con_cq_qp(con); << con[0]
> >>>>>>>>>>                                               |  }
> >>>>>>>>>>                                               | in this moment, refcnt of PD was increased to 2+
> >>>>
> >>>> What do you mean "refcnt of PD"? usecnt in struct ib_pd or dev_ref.
> >>>
> >>> I mean usecnt in struct ib_pd
> >>>
> >>>
> >>>
> >>>>
> >>>>>>>>>>                                               |
> >>>>>>>>>>       create_cm() // b. cid = 1, failed       |
> >>>>>>>>>>         destroy_con_cq_qp()                   |
> >>>>>>>>>>           rtrs_ib_dev_put()                   |
> >>>>>>>>>>             dev_free()                        |
> >>>>>>>>>>               ib_dealloc_pd(dev->ib_pd) << PD |
> >>>>>>>>>>                is destroyed, but refcnt is    |
> >>>>>>>>>>                still greater than 0           |
> >>>>
> >>>> Assuming you mean "pd->usecnt". We only allocate pd in con[0] by rtrs_ib_dev_find_or_add,
> >>>> if con[1] failed to create cm, then alloc_path_reqs -> ib_alloc_mr -> atomic_inc(&pd->usecnt)
> >>>> can't be triggered. Is there other places could increase the refcnt?
> >>>
> >>>
> >>> Yes, when create a qp, it will also associate to this PD, that also mean refcnt of PD will be increased.
> >>>
> >>> When con[0](create_con_cq_qp) succeeded, refcnt of PD will be 2. and then when con[1] failed, since
> >>> QP didn't create, refcnt of PD is still 2. con[1]'s cleanup will destroy the PD(ib_dealloc_pd) since dev_ref = 1, after that its
> >>> refcnt is still 1.
> >>
> >> Why is refcnt 1 in con[1] destruction phase? It seems to me like a bug.
> 
> 
> 
> > +	if (!con->has_dev)
> > +		return;
> >  	if (clt_path->s.dev_ref && !--clt_path->s.dev_ref) {
> >  		rtrs_ib_dev_put(clt_path->s.dev);
> >  		clt_path->s.dev = NULL;
> 
> Currently, without this patch:
> 1. PD and clt_path->s.dev are shared among connections.
> 2. every con[n]'s cleanup phase will call destroy_con_cq_qp()
> 3. clt_path->s.dev will be always decreased in destroy_con_cq_qp(), and when
>     clt_path->s.dev become zero, it will destroy PD.
> 4. when con[1] failed to create, con[1] will not take clt_path->s.dev, but it try to decreased clt_path->s.dev <<< it's wrong to do that.

So please fix it by making sure that failure to create con[1] will
release resources which were allocated. If con[1] didn't increase
s.dev_ref, it shouldn't decrease it either.

Thanks

> 
> 
> Thanks
> Zhijian
> 
> > Agree. We should find out why refcnt 1 and fix this problem.
> 
> 
> 
> 
> > 
> > Zhu Yanjun
> >>
> >> Thanks
> > 
