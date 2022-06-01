Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA153A562
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jun 2022 14:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbiFAMqD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jun 2022 08:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353086AbiFAMqC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jun 2022 08:46:02 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1B16FA00
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jun 2022 05:45:58 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id i19so1318644qvu.13
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jun 2022 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ooKzx/PLlUEW72sZZpr/gukQbTFbGyWj7z70NcgCmqc=;
        b=Hx2H33dnMryRuImn0cIZ4YekbwxEr8xim03iBeXhLVGjtl0dJoAKJbiCI1iAcKyUdv
         aSPg/u2lO8izkzLncqgnp0h0RukjDQCG/OxC2K8/zSR42HQGRG53EimW/DOGwvahk9pb
         HJqWQXaMvDWWnhWJiAoT6Uyx/11erTKfP/Td00oSFbUdd6z3WFMD/zraMSOD4MiKsW3v
         vNDkgZq+IOKoy78PsrBrOa5/q2XMVa/7Tyr6bI770omEa5oLkc024pWIWtrVueOGj3ID
         9fBo4etNd1VVVF55WxKsgC0ErddNWTSQqn+rhddlzzdFAzK6HZEUbpzKOa4bmHnWwVrN
         UKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ooKzx/PLlUEW72sZZpr/gukQbTFbGyWj7z70NcgCmqc=;
        b=nZb/cCmZ4CFwTIrQd3A/aBy7BpSQtcPNrDzw3yu8A4IVVwKeXSnkpIpyIRYTrFiAVB
         NW9CJ5Cl8YWUtfVIpppQYFAcRjKu5djSDD1dUAjIz/ttgJGNHAV0QX+VmrgRvjS4tTjR
         9vKJ7FdwPc57p2wMpwydk4U+chPOhuoHFQE3Q+uLhamI0/cI99OY8zHb/OMpR4o0kg8U
         BfwyrLI1ONwbiT81fnLGFMXNF5Ye9UTTVTIwzaNkUitFptklsf9YzdznCYXpsiqlsiXb
         EqYH39znMC7taRXXm41AnHzJZbVHI62yYMRV9agXDbWekIRuqRTKKdGvIrxk7RkhzZ2S
         UQQw==
X-Gm-Message-State: AOAM531mS5mNEA+U8Vh5gjL4C6atr5/bAXtVlnYtGWP30cIIBOxDDJk5
        8DtvKZydCYRbfNFS73KvKk361Q==
X-Google-Smtp-Source: ABdhPJxgU0qcGAEEkwWzfSnGIhQHNGRbgJDA6ZV8b6pnQlzFtVryOsxZpk531dBvIja/tM1r8AEOUw==
X-Received: by 2002:a05:6214:2245:b0:464:6b29:f443 with SMTP id c5-20020a056214224500b004646b29f443mr2914412qvc.99.1654087558029;
        Wed, 01 Jun 2022 05:45:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l22-20020a05620a28d600b006a5bc8e956esm1166173qkp.133.2022.06.01.05.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:45:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nwNjY-00G0Au-AK; Wed, 01 Jun 2022 09:45:56 -0300
Date:   Wed, 1 Jun 2022 09:45:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Message-ID: <20220601124556.GI2960187@ziepe.ca>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
 <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 31, 2022 at 10:55:46AM -0700, Bart Van Assche wrote:
> On 5/31/22 05:35, Jason Gunthorpe wrote:
> > On Sat, May 28, 2022 at 09:00:16PM +0200, Bart Van Assche wrote:
> > > On 5/27/22 14:52, Jason Gunthorpe wrote:
> > > > That only works if you can detect actual different lock classes during
> > > > lock creation. It doesn't seem applicable in this case.
> > > 
> > > Why doesn't it seem applicable in this case? The default behavior of
> > > mutex_init() and related initialization functions is to create one lock
> > > class per synchronization object initialization caller.
> > > lockdep_register_key() can be used to create one lock class per
> > > synchronization object instance. I introduced lockdep_register_key() myself
> > > a few years ago.
> > 
> > I don't think this should be used to create one key per instance of
> > the object which would be required here. The overhead would be very
> > high.
> 
> Are we perhaps referring to different code changes? I'm referring to the
> code change below. The runtime and memory overhead of the patch below
> should be minimal.

This is not minimal, the lockdep graph will expand now with a node per
created CM ID ever created and with all the additional locking
arcs. This is an expensive operation.

AFIAK keys should not be created per-object like this but based on
object classes known when the object is created - eg a CM listening ID
vs a connceting ID as an example

This might be a suitable hack if the # of objects was small???

Jason
