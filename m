Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDF957825D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiGRMau (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiGRMat (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 08:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F2205F7;
        Mon, 18 Jul 2022 05:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBB5614E8;
        Mon, 18 Jul 2022 12:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E75C341C0;
        Mon, 18 Jul 2022 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658147447;
        bh=ECdxE1bsN444YLZGJxne40CdRsdsjAKrmqAIXOOtD2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RF/u2VR6cz7S5mkBDmpzsbDbNjmr7BKs7LNKjeB05r0TTto8rLYuFdRbXFRe+u9QI
         cLOYtLkrOV+9t6opsTPUHf6BVlan3j5F60InYEYyW9BTKM/XoQ3Lh9nFwJ857Lfr5n
         PA05IS5/5ruRYtuWSiDFI9tjDmif6SXp0cQJCY8YJpQe768bsi+fumpQIML3lK9Cl2
         LEPP3hi0jQJr73iGcjhhn2lZqZHIXr73WXdAyp424PvXOiPYgrlYiVtFcQFLCIsz+u
         JOLKiVo771my9jUZ+be2INOxgyltZxeF1UIdXxgUp2C29t2mXTRV9tKPq67kdEJElv
         ZB9RSsFs3x+IQ==
Date:   Mon, 18 Jul 2022 15:30:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Jianglei Nie <niejianglei2021@163.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hfi1: fix potential memory leak in setup_base_ctxt()
Message-ID: <YtVSc7aazgxVFHRa@unreal>
References: <20220711070718.2318320-1-niejianglei2021@163.com>
 <1038e814-5f0d-17a3-1331-8ed24a64d597@cornelisnetworks.com>
 <YtU4eXQCVEPGnh9b@unreal>
 <be437471-0080-8e9c-978a-6029c7826335@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be437471-0080-8e9c-978a-6029c7826335@cornelisnetworks.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 18, 2022 at 08:11:59AM -0400, Dennis Dalessandro wrote:
> On 7/18/22 6:39 AM, Leon Romanovsky wrote:
> > On Mon, Jul 11, 2022 at 07:52:25AM -0400, Dennis Dalessandro wrote:
> >> On 7/11/22 3:07 AM, Jianglei Nie wrote:
> >>> setup_base_ctxt() allocates a memory chunk for uctxt->groups with
> >>> hfi1_alloc_ctxt_rcv_groups(). When init_user_ctxt() fails, uctxt->groups
> >>> is not released, which will lead to a memory leak.
> >>>
> >>> We should release the uctxt->groups with hfi1_free_ctxt_rcv_groups()
> >>> when init_user_ctxt() fails.
> >>>
> >>> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> >>> ---
> >>>  drivers/infiniband/hw/hfi1/file_ops.c | 4 +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
> >>> index 2e4cf2b11653..629beff053ad 100644
> >>> --- a/drivers/infiniband/hw/hfi1/file_ops.c
> >>> +++ b/drivers/infiniband/hw/hfi1/file_ops.c
> >>> @@ -1179,8 +1179,10 @@ static int setup_base_ctxt(struct hfi1_filedata *fd,
> >>>  		goto done;
> >>>  
> >>>  	ret = init_user_ctxt(fd, uctxt);
> >>> -	if (ret)
> >>> +	if (ret) {
> >>> +		hfi1_free_ctxt_rcv_groups(uctxt);
> >>>  		goto done;
> >>> +	}
> >>>  
> >>>  	user_init(uctxt);
> >>>  
> >>
> >> Doesn't seem like this patch is correct. The free is done when the file is
> >> closed, along with other clean up stuff. See hfi1_file_close().
> > 
> > Can setup_base_ctxt() be called twice for same uctxt?
> > You are allocating rcd->groups and not releasing.
> 
> The first thing assign_ctxt() does is a check of the fd->uctxt and it bails with
> -EINVAL. So effectively only once.

I'm slightly confused. How will you release rcd->groups?

assign_ctxt()
 -> setup_base_ctxt()
   -> hfi1_alloc_ctxt_rcv_groups()
      ,,,
      rcd->groups = kzalloc...
      ...
   -> init_user_ctxt() <-- fails and leaves fd->uctx == NULL


...
hfi1_file_close()
  struct hfi1_ctxtdata *uctxt = fdata->uctxt;
  ...
  if (!uctxt)             <-- This is our case
     goto done; 
  ...

done:
  if (refcount_dec_and_test(&dd->user_refcount))
     complete(&dd->user_comp);

  cleanup_srcu_struct(&fdata->pq_srcu);
  kfree(fdata);
  return 0;



> 
> -Denny
> 
> 
