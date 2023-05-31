Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0BB7189DF
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 21:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjEaTKI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 15:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEaTKH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 15:10:07 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692EB1A4
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 12:09:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75afeacb5e4so713355585a.3
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685560186; x=1688152186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kZ2287o88voOcYCcx3k9sk8BuUckSydDhgvZeg4mWEE=;
        b=P59jbimG6GRw8rZlRD8I7jeWnL/qjjzJlboAzzLBBQPBYl5nE7YATS3xZZ7NvfwgnI
         pH8lvukbrE7PtZAQE9+kCAD9baMB4rF1C3boHfNDXSUpRZia3D1/hXvVdE5L9E1vlCBK
         euwcXGgsz5mz5THFHqthJsEmr0u/Nmr7GydAN7sLt7PYZvEylv1arLftzC0od7lFBSKN
         u9T+YBmSuv19oZq303JfURDZFLL2/FK31v7IFdepIYG67BNIovr1gmLH2/M6vWWc7zFc
         QlZJJ4Y5XMRL4iqqEYhs4473p/M87LyudkmauJJwGpDSos3k2YVhRNDYm8VToPprhKL5
         IV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685560186; x=1688152186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ2287o88voOcYCcx3k9sk8BuUckSydDhgvZeg4mWEE=;
        b=Ig5eTZaDMCBI42g8q6hR2M/oxELyFEyg2nCJHhYZTso9EI4988f5BLV7+9/axMWINd
         d6jst00DkrSkksh1ZCBdFqPUY58oUq1ebBLfnRWEKNdPZ26sIeCybspmh57KeMNKWwTE
         6s+BvaQ1iwYebcwYUHsehqFscsO59ZRmMe6ZTSoi4leGDj2oRZbBB6wA5pYvFeXLaVcm
         GArAVmKpjllJZLwBZoFDMnW1vD7dC6Bt0a/h+YmEyU8HEDy0P1cX3TB4mIYhBZOjbP4j
         Xy7IabXeA+5JlIM4n7XkTr1gAkT4Nl+DrJtNutC42q8idamiehjzU3YS5rqBVarU5oHm
         s0hw==
X-Gm-Message-State: AC+VfDyIBK9AeqqfehcFKI3JakoHRVp/RQhLz2HxTgD3icJihMOLjch6
        56vWmvGlSVpbFpkL63u5lLZJZ9UsixdWuS4cEKY=
X-Google-Smtp-Source: ACHHUZ55NftEVD3EJxAP2+FgLIanS7Tk96nGAkwCvy/EYzn3o7Y78YsFJDTaqRYm2DD77keR0eSufg==
X-Received: by 2002:a05:620a:4147:b0:75b:23a1:362a with SMTP id k7-20020a05620a414700b0075b23a1362amr8834439qko.59.1685560186503;
        Wed, 31 May 2023 12:09:46 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 22-20020a05620a06d600b0075785052e97sm3468495qky.95.2023.05.31.12.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:09:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q4RCb-0017X7-9H;
        Wed, 31 May 2023 16:09:45 -0300
Date:   Wed, 31 May 2023 16:09:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, parav@mellanox.com,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] Revert "IB/core: Fix use workqueue without
 WQ_MEM_RECLAIM"
Message-ID: <ZHebeWlpn68Xa1Hd@ziepe.ca>
References: <20230523155408.48594-1-mlombard@redhat.com>
 <20230523182815.GA2384059@unreal>
 <CAFL455m3T4qrk0Uf5qK7-57Oh6L6AKionfs0mF-imUMYpbqBOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFL455m3T4qrk0Uf5qK7-57Oh6L6AKionfs0mF-imUMYpbqBOg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 29, 2023 at 05:12:33PM +0200, Maurizio Lombardi wrote:
> út 23. 5. 2023 v 20:28 odesílatel Leon Romanovsky <leon@kernel.org> napsal:
> > > workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
> > > [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]
> >
> > And why does nvme-wq need WQ_MEM_RECLAIM flag? I wonder if it is really
> > needed.
> 
> Adding Sagi Grimberg to cc, he probably knows and can explain it better than me.

We already allocate so much memory on these paths it is pretty
nonsense to claim they are a reclaim context. One allocation on the WQ
is not going to be the problem.

Probably this nvme stuff should not be re-using a reclaim marke dWQ
for memory allocating work like this, it is kind of nonsensical.

Jason
