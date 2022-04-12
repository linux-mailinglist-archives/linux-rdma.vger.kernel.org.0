Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FA14FE3DE
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356566AbiDLOdj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 10:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350831AbiDLOdj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 10:33:39 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AEF5EDE8
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:31:20 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id bb38so4208734qtb.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oTKt8q7Ij28NyeVaxTwwemGzwBSLgDeyqMqUqlY2kZs=;
        b=J+6/Z9whbeASEx+AAct/eUp3XXlowDtve/nMjJcx8rqkM/z3NDHqvJdbWkXaedi4q3
         B1jkPcM3PCk0PA56BLkaUFZemTbX87MCQJlKLztL2TgXIRMkYJtUYVhx/86mjlvZrVgV
         8LaTe2F6IkAHBMeMkd8UsxLMf+Jd/WMAAGfzh4iYTGtSf3ITyWTuoK3LQp+3I9RUOR0x
         rQvFVvgKZAw8JI3LVgN36qvlibjHP9yqij4uXzNtMFbwpKG4NI9l8g7m+TDSnp0vkCzi
         uCgmX8fxZPYGezwt/tPEp///rM0n6sPMGSOATRMI4oOAERXBNvk1LfV770hBR44ByZ/0
         b57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oTKt8q7Ij28NyeVaxTwwemGzwBSLgDeyqMqUqlY2kZs=;
        b=NdRG0DcTyGf63zJjiv5KkdOe/Sh668zMZNjLIsfZSk+gij8MFGDjgWQvw0a+z6qcZ7
         ClsMcM5HJBZm3TDhD77iY4qcaN+yOeiKgkZYfs4KqDZHPKMCf7UTdfLus88SH3C/gfDZ
         JokyBV1Vng1xHg9n0sFR9j8WePXfunE+FihRhkS6JdNl5WE6wfpn8smrOHIck0tL74Pc
         6BddH0vHJZ5MQmhMORK+c2WvX1QmEbppVQa9LqSY13MVxUvlTWXpsH5MCT9GskcrszVn
         KLdInIWeIOfiDmTxyfiqHRcca81in8FzMWck4MkqUtl3I1jhDDvceSrNz9xQpcB/41dK
         S6+g==
X-Gm-Message-State: AOAM53292KepC+6Newuto3Tt54XiEsoQQR8uCTHwHXjxe/ISnur0ts6P
        M4Yl7F60tjEVEBFrlSr6aHCHkQ==
X-Google-Smtp-Source: ABdhPJx+lQ4diorEMQqhh6gFT8oNcAuJ8aYJnfMFWcUPyHYJw6oJy3uDcppymBzN1K2r/k8uHAKRDw==
X-Received: by 2002:ac8:58d2:0:b0:2e1:c5d9:9060 with SMTP id u18-20020ac858d2000000b002e1c5d99060mr3423984qta.168.1649773879946;
        Tue, 12 Apr 2022 07:31:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b0067afe7dd3ffsm23081746qki.49.2022.04.12.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 07:31:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1neHY6-000uBm-M4; Tue, 12 Apr 2022 11:31:18 -0300
Date:   Tue, 12 Apr 2022 11:31:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix a dead lock problem
Message-ID: <20220412143118.GF64706@ziepe.ca>
References: <20220411200018.1363127-1-yanjun.zhu@linux.dev>
 <20220411115019.GB64706@ziepe.ca>
 <feb4a977-c438-99dd-f31f-08d259c2f75f@linux.dev>
 <20220412135313.GD64706@ziepe.ca>
 <a8be1cf3-62d1-43ea-a86c-70e82c6de702@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8be1cf3-62d1-43ea-a86c-70e82c6de702@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 12, 2022 at 10:28:16PM +0800, Yanjun Zhu wrote:
> 在 2022/4/12 21:53, Jason Gunthorpe 写道:
> > On Tue, Apr 12, 2022 at 09:43:28PM +0800, Yanjun Zhu wrote:
> > > 在 2022/4/11 19:50, Jason Gunthorpe 写道:
> > > > On Mon, Apr 11, 2022 at 04:00:18PM -0400, yanjun.zhu@linux.dev wrote:
> > > > > @@ -138,8 +139,10 @@ void *rxe_alloc(struct rxe_pool *pool)
> > > > >    	elem->obj = obj;
> > > > >    	kref_init(&elem->ref_cnt);
> > > > > -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> > > > > -			      &pool->next, GFP_KERNEL);
> > > > > +	xa_lock_irqsave(&pool->xa, flags);
> > > > > +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> > > > > +				&pool->next, GFP_ATOMIC);
> > > > > +	xa_unlock_irqrestore(&pool->xa, flags);
> > > > 
> > > > No to  using atomics, this needs to be either the _irq or _bh varient
> > > 
> > > If I understand you correctly, you mean that we should use
> > > xa_lock_irq/xa_unlock_irq or xa_lock_bh/xa_unlock_bh instead of
> > > xa_unlock_irqrestore?
> > 
> > This is correct
> > 
> > > If so, xa_lock_irq/xa_unlock_irq or xa_lock_bh/xa_unlock_bh is used here,
> > > the warning as below will appear. This means that __rxe_add_to_pool disables
> > > softirq, but fpu_clone enables softirq.
> > 
> > I don't know what this is, you need to show the whole debug.
> 
> The followings are the warnings if xa_lock_bh + __xa_alloc(...,GFP_KERNEL)
> is used. The diff is as below.
> 
> If xa_lock_irqsave/irqrestore + __xa_alloc(...,GFP_ATOMIC) is used,
> the waring does not appear.

That is because this was called in an atomic context:

> [   92.107490]  __rxe_add_to_pool+0x76/0xa0 [rdma_rxe]
> [   92.107500]  rxe_create_ah+0x59/0xe0 [rdma_rxe]
> [   92.107511]  _rdma_create_ah+0x148/0x180 [ib_core]
> [   92.107546]  rdma_create_ah+0xb7/0xf0 [ib_core]
> [   92.107565]  cm_alloc_msg+0x5c/0x170 [ib_cm]
> [   92.107577]  cm_alloc_priv_msg+0x1b/0x50 [ib_cm]
> [   92.107584]  ib_send_cm_req+0x213/0x3f0 [ib_cm]
> [   92.107613]  rdma_connect_locked+0x238/0x8e0 [rdma_cm]
> [   92.107637]  rdma_connect+0x2b/0x40 [rdma_cm]
> [   92.107646]  ucma_connect+0x128/0x1a0 [rdma_ucm]
> [   92.107690]  ucma_write+0xaf/0x140 [rdma_ucm]
> [   92.107698]  vfs_write+0xb8/0x370
> [   92.107707]  ksys_write+0xbb/0xd0

Meaning the GFP_KERNEL is already wrong.

The AH path needs to have its own special atomic allocation flow and
you have to use an irq lock and GFP_ATOMIC for it.

Jason
