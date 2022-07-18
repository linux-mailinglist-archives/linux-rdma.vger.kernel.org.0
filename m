Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B41577FE1
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 12:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiGRKkB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 06:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGRKkA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 06:40:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263F6FD0A;
        Mon, 18 Jul 2022 03:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCF18B81104;
        Mon, 18 Jul 2022 10:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034DDC341C0;
        Mon, 18 Jul 2022 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658140797;
        bh=zf1MiV+FPlhhdv93l8bdMeh9ZVMkjbxac2qq4+1QQLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C8MxKJnWnYKNXeHu0tB+4x6EtqyHZWKpmJ2mljcC5Nl3b83WIGvt6VPJkVp/qpUZz
         fTzZIdSMperNbfVjfeS29LuBJuwV0gPeIMTOecRymWH4Zu8x2FzzKmufDipC2nL/Ax
         V1v80VuZSWuf4ycScgce7YPIlhCbIsBQ+uQkJiFRSRLTb1ulWFUQ+aFE56lCNGOFmX
         3ylwaFk2nW04/O3qucJaJiIQ9JIo1XE2wcqTciH9DZbcFUiqNCbXiVDrYmktITqGpa
         C/6cOfwyA73dej0r6XL2HVSmMxlrSqtp+pDDWz/WkLr+KvVG2x8sknmZdyT+fyqvsX
         +byfIzyDLi2NQ==
Date:   Mon, 18 Jul 2022 13:39:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Jianglei Nie <niejianglei2021@163.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hfi1: fix potential memory leak in setup_base_ctxt()
Message-ID: <YtU4eXQCVEPGnh9b@unreal>
References: <20220711070718.2318320-1-niejianglei2021@163.com>
 <1038e814-5f0d-17a3-1331-8ed24a64d597@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038e814-5f0d-17a3-1331-8ed24a64d597@cornelisnetworks.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 11, 2022 at 07:52:25AM -0400, Dennis Dalessandro wrote:
> On 7/11/22 3:07 AM, Jianglei Nie wrote:
> > setup_base_ctxt() allocates a memory chunk for uctxt->groups with
> > hfi1_alloc_ctxt_rcv_groups(). When init_user_ctxt() fails, uctxt->groups
> > is not released, which will lead to a memory leak.
> > 
> > We should release the uctxt->groups with hfi1_free_ctxt_rcv_groups()
> > when init_user_ctxt() fails.
> > 
> > Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> > ---
> >  drivers/infiniband/hw/hfi1/file_ops.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
> > index 2e4cf2b11653..629beff053ad 100644
> > --- a/drivers/infiniband/hw/hfi1/file_ops.c
> > +++ b/drivers/infiniband/hw/hfi1/file_ops.c
> > @@ -1179,8 +1179,10 @@ static int setup_base_ctxt(struct hfi1_filedata *fd,
> >  		goto done;
> >  
> >  	ret = init_user_ctxt(fd, uctxt);
> > -	if (ret)
> > +	if (ret) {
> > +		hfi1_free_ctxt_rcv_groups(uctxt);
> >  		goto done;
> > +	}
> >  
> >  	user_init(uctxt);
> >  
> 
> Doesn't seem like this patch is correct. The free is done when the file is
> closed, along with other clean up stuff. See hfi1_file_close().

Can setup_base_ctxt() be called twice for same uctxt?
You are allocating rcd->groups and not releasing.

Thanks

> 
> -Denny
