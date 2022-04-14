Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC67B501907
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Apr 2022 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239911AbiDNQu2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Apr 2022 12:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241055AbiDNQuH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Apr 2022 12:50:07 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4533ECF498
        for <linux-rdma@vger.kernel.org>; Thu, 14 Apr 2022 09:18:49 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id c1so4357538qvl.3
        for <linux-rdma@vger.kernel.org>; Thu, 14 Apr 2022 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iizSLVYJf8CJXzL0aeTNK3oe3LsDjGkfK9h/v52u4fg=;
        b=YwuXSW4nEqF1X8v4JNtfFwRw7cwDDOk6e+rlunZF6rYmKxhQa3Y5cwxKMtVqPCWARl
         NlwT/P2jcMJCVyOgjHWbPLqEW5ETQnvhtdRyFYMFlQfhCkZ2aaVZBLwBEGV54IjwqCO+
         MEH73dAuCU/k0s9N8yW88VhMPvVQQsqBULusyJ2d3VmmuSJdZZksgKUld3bNrse1Q/nN
         gT8gSGiEE8Yl2nJ6vnSwrcdqck0Bf+F+jiaZPzf7gtvn66cENV/fdLi++qxZSSUhOp1n
         5q8dXFR2jcLh3ZqlTUNDTrAr4+iLdUZ4meXzBXTR52+YhymNdNen0ojjkiAUi9cikYJw
         2rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iizSLVYJf8CJXzL0aeTNK3oe3LsDjGkfK9h/v52u4fg=;
        b=lCokYIYaPlfynDhE2QCac6IYEShbV9qVD98EKj1IwKxKhMfbaSBjawurCH3WTfolml
         o0cERCKhQKPk7rKnUclFh82KrSg34VU73SWSbRYn2CEcmFd58bz07JLteZyf3rVgNVAc
         gFSso3zexyqwLnGoCK4QH1nY82jXMSrxDtYQ6razzwMbFmS4hroPIuqSGZy3GhLkRCd7
         7lLN1QOAsj/Xgveu7cBtTwQofcOS7+x06Bt6vQoI1cWmmZqqu+HXYZWkkmKSpkowSYoc
         v2HL/j/uLbFhkhToyxuOJ+11mMDiQhav/9xg1ag5OLQUtyiK1JJV9RZpv6fmC/TUc6DH
         4GYA==
X-Gm-Message-State: AOAM531B3oei2na8945qL9vj2YIpWIxK4MXj1g70bg8LmW1n7YElr//P
        kRQDTeIgy+us4DLMqKrQHDWQKw==
X-Google-Smtp-Source: ABdhPJyGkoDNku9R5CyjH+RfeB7l1WKj4ktw3MDroY/YkLEp/jz2Ur8bfqIO1nPNY9cJqnorIPrYPg==
X-Received: by 2002:a05:6214:ac5:b0:446:1054:bb26 with SMTP id g5-20020a0562140ac500b004461054bb26mr9473225qvi.55.1649953128344;
        Thu, 14 Apr 2022 09:18:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id e15-20020a05622a110f00b002e1ed105652sm1487434qty.2.2022.04.14.09.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 09:18:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nf2BC-002Irf-SH; Thu, 14 Apr 2022 13:18:46 -0300
Date:   Thu, 14 Apr 2022 13:18:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv3 1/1] RDMA/rxe: Fix a dead lock problem
Message-ID: <20220414161846.GM64706@ziepe.ca>
References: <20220413074208.1401112-1-yanjun.zhu@linux.dev>
 <20220413004504.GH64706@ziepe.ca>
 <81db8dcc-e417-bff5-b7ec-1067c717ea62@linux.dev>
 <56c4e893-223d-ad6b-2fa9-ca8b2aace9de@linux.dev>
 <20220414135255.GK64706@ziepe.ca>
 <75363d6a-99f2-f61a-0f41-87e641746efa@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75363d6a-99f2-f61a-0f41-87e641746efa@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 14, 2022 at 11:13:57PM +0800, Yanjun Zhu wrote:
> 在 2022/4/14 21:52, Jason Gunthorpe 写道:
> > On Thu, Apr 14, 2022 at 09:01:29PM +0800, Yanjun Zhu wrote:
> > 
> > > > > Still no, this does almost every allocation - only AH with the
> > > > > non-blocking flag set should use this path.
> > 
> > > To the function ib_send_cm_req, the call chain is as below.
> > > 
> > > ib_send_cm_req --> cm_alloc_priv_msg --> cm_alloc_msg --> rdma_create_ah -->
> > > _rdma_create_ah --> rxe_create_ah --> rxe_av_chk_attr -->__rxe_add_to_pool
> > > 
> > > As such, xa_lock_irqsave/irqrestore is selected.
> > 
> > As I keep saying, only the rxe_create_ah() with the non-blocking flag
> > set should use the GFP_ATOMIC. All other paths must use GFP_KERNEL.
> > 
> 
> Got it. The GFP_ATOMIC/GFP_KERNEL are used in different paths.
> rxe_create_ah will use GFP_ATOMIC and others will use GFP_KERNEL.
> So the codes should be as below:

This seems better

Jason
