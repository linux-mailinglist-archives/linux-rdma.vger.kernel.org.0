Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E74501446
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Apr 2022 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbiDNOnk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Apr 2022 10:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347774AbiDNN7c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Apr 2022 09:59:32 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16548ADD4A
        for <linux-rdma@vger.kernel.org>; Thu, 14 Apr 2022 06:52:57 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c1so3865231qkf.13
        for <linux-rdma@vger.kernel.org>; Thu, 14 Apr 2022 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BrENB0ndzA6sXcjqSabcRcOVCFFsAtgFIC6+k4juiUk=;
        b=HATmW/NzJDJ6tDn1Lo230NKKklHJKKvhmlTos12ONPwDlwxhMjjshuFppmcxlL3L+i
         wuAPMTCX1SbYF6MjD4zCJ3lwarUdjQVaKD/uS0qsJUoU5Ev8k7fNWu059BWQQTHJG415
         JM2aRLU1EzZQV/S+Dq2S8sCgX+Y+yEXuZIPn8u8UmQ+j/LG48Ao1J93YTtptnV4JK9Xx
         FD1SXa06oUlcSpexoTty2xJaQe8xihjtaXF7/mfYLESF1YCjVfVfAu3PIdImYA0GnQHr
         mwL1azySG+Nj+XDcsodZz6kEpLfGkEDb9KObzLhnVd+82fT8/O9EzcAWCvkvKVrHKUYW
         lPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BrENB0ndzA6sXcjqSabcRcOVCFFsAtgFIC6+k4juiUk=;
        b=z5gLCWKMo1PcDckdPLsAPVnkgFly9wjWqFAbHudv/i95JHRblqhtBAyNnzkQjfWbxQ
         QPGLk8K97e89wZWCy4tU1pB5m3o0Sub9f/k5lunxebdf2kHhaFGoI1xZagmU3CL1u+c/
         fHpyFoVRKd58NVGqjC220I9h5e/FWSp8FjEs4qx+p9/4qnOHSsOEaCzj6LAaAc4LGW/l
         Ukx/OOkM+kwixoit3qhe+GNNXjPCZD2FV9HreE3d1vj7HftLQ17ALsYxe+lR+mRb8YYH
         QA0IDMqNJ371Se9Y4CiWRPByBrbhaPmL59IkF7iL4xRhDFjflrBPRWBpf9Cn68KIupWB
         fr/Q==
X-Gm-Message-State: AOAM530SPx3jTIIpXLYEOmUVdtCpDq6UOLj0PBiheVD4wXb2VDszuf8a
        9VEjw/RleFE3IBQ8y2h0FcsP2g==
X-Google-Smtp-Source: ABdhPJx8DbGRU2iEWOAqVQjgq4WH1G7ubAvM/SIH67rX5U2F/e5adupMPAQ8I8XI1+18T64kVPJ6gg==
X-Received: by 2002:a05:620a:1008:b0:69c:7df2:aa13 with SMTP id z8-20020a05620a100800b0069c7df2aa13mr1343939qkj.263.1649944376226;
        Thu, 14 Apr 2022 06:52:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id bj12-20020a05620a190c00b0069c7df40747sm569834qkb.133.2022.04.14.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:52:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nezu3-0023yE-2O; Thu, 14 Apr 2022 10:52:55 -0300
Date:   Thu, 14 Apr 2022 10:52:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv3 1/1] RDMA/rxe: Fix a dead lock problem
Message-ID: <20220414135255.GK64706@ziepe.ca>
References: <20220413074208.1401112-1-yanjun.zhu@linux.dev>
 <20220413004504.GH64706@ziepe.ca>
 <81db8dcc-e417-bff5-b7ec-1067c717ea62@linux.dev>
 <56c4e893-223d-ad6b-2fa9-ca8b2aace9de@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c4e893-223d-ad6b-2fa9-ca8b2aace9de@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 14, 2022 at 09:01:29PM +0800, Yanjun Zhu wrote:

> > > Still no, this does almost every allocation - only AH with the
> > > non-blocking flag set should use this path.

> To the function ib_send_cm_req, the call chain is as below.
> 
> ib_send_cm_req --> cm_alloc_priv_msg --> cm_alloc_msg --> rdma_create_ah -->
> _rdma_create_ah --> rxe_create_ah --> rxe_av_chk_attr -->__rxe_add_to_pool
> 
> As such, xa_lock_irqsave/irqrestore is selected.

As I keep saying, only the rxe_create_ah() with the non-blocking flag
set should use the GFP_ATOMIC. All other paths must use GFP_KERNEL.

Jason
