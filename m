Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7DE56BAAD
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 15:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiGHN3X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiGHN3W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 09:29:22 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D12CC86
        for <linux-rdma@vger.kernel.org>; Fri,  8 Jul 2022 06:29:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id bs20so27198903qtb.11
        for <linux-rdma@vger.kernel.org>; Fri, 08 Jul 2022 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=igWhkETj07ZDrQH1PHnSKrg/K7u4e3MV+GpORTrUsWY=;
        b=YgMUPP2XXiFkCiz7CJrgqZ/plfCfdDKFC7DfHnsDdhuW8Z5FMpkz2UH1R8nXnDxRIz
         iz6FpKMYpvRLICU/5GosQ5q503dYQtnKBdKzH93GcW8HaC5pWXC2OQK7ALRNBwXQZ2hA
         qAz7owTk67dRrC4bOswsa0FkMNVJxdVaj2ZmM7x/pT2lv2m1S2KWmZaC0U+xWL51zoje
         1p1TAGLF9uLnKTESi1hYv+3s0bMShu+A8+MFtuaghT+m3zzbM5gWVoBKMTqjzlKUFQSG
         zdOxdrgj16uhlvwksodNZsbRBQnUHKXeXpD0ko1otQ43XFSYKLc0zJn4rgv8//iJwRtX
         AFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=igWhkETj07ZDrQH1PHnSKrg/K7u4e3MV+GpORTrUsWY=;
        b=4pFvARPFNSnl+9v/47ZEAEfcHox4gD4teZNZFF97x2TawMd/UckjvlwATbzn9ho4H4
         POFDI8JZpVyqGeMtjmB/gbSs914zW6laIbojmF1dP/s8ZR/hfvmfQ//LiNymvxJvCjTm
         8xJqMv/lwWBy3/wf1RQJdvyMSOISRk9Gk6pY6WatYHZm9/dquTClBR5ioZQ6aQObh9/B
         Lq0Ceb86oW4O60YyOUR8snqHCsbX68/n6yPBFBnoRyTLM1P2TMv+AUYv0Nx90NJvwr7v
         MXYSK9LmKhHUHhb4RJDjnMgCyXfsVNKZODv5y0AgT7PZZxWoGavJzpgZwo74qXdqqBPn
         cXWA==
X-Gm-Message-State: AJIora8UIjdlSQIQYun10G8SJra+RcEvdAJTA1TjZGjgDEEnPyJXR9Gq
        uW5rOXNyljSKYFIHRbATYHIrrEUpohm0xQ==
X-Google-Smtp-Source: AGRyM1splZVTEZEF+xBUizr3MMJwHdPsWW2Pe9oTnl7ehD11zp9QGX1kCO+xHpzR6leozHJHKpvAbQ==
X-Received: by 2002:a05:622a:1305:b0:31d:3d10:fd88 with SMTP id v5-20020a05622a130500b0031d3d10fd88mr2873142qtk.168.1657286958828;
        Fri, 08 Jul 2022 06:29:18 -0700 (PDT)
Received: from ziepe.ca ([142.177.133.130])
        by smtp.gmail.com with ESMTPSA id u4-20020a05620a430400b006a6d7c3a82esm34812150qko.15.2022.07.08.06.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:29:17 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o9o2m-0001Ks-VL; Fri, 08 Jul 2022 10:29:16 -0300
Date:   Fri, 8 Jul 2022 10:29:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Creating new RDMA driver for habanalabs
Message-ID: <20220708132916.GA4459@ziepe.ca>
References: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
 <20210822223128.GZ543798@ziepe.ca>
 <CAFCwf10LXiAxf7Xr+pMcmSk-_q1FEY_YcBjoH05K0mkK9hMCYA@mail.gmail.com>
 <20210823130419.GA543798@ziepe.ca>
 <CAFCwf11NeJYDMBXaNTpQ+dLecxoAnFYE2Z9T9D4-A5gLtf8q+A@mail.gmail.com>
 <CAFCwf13LRmez63hGmXMDO2FoC3Qo_2BwtAtnzyJ70=_OcTc23w@mail.gmail.com>
 <20220706162448.GK23621@ziepe.ca>
 <CAFCwf10rGdOx94bOOW8vfuW73H_KFKPu2tg2Hpduzd+1OjnVOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10rGdOx94bOOW8vfuW73H_KFKPu2tg2Hpduzd+1OjnVOw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 07, 2022 at 12:30:03PM +0300, Oded Gabbay wrote:
> > >    These limitations are not relevant to a deployment where all the NICs are
> > >    Gaudi NICs, because we can use a single rkey for all MRs.
> >
> > Er, that is weird, did you mean to say you have only one MR per PD and
> > that it always has a fixed value?

> Not exactly. We have multiple MRs per PD, but the driver assigns the
> same rkey (fixed value) for all created MRs. Our h/w matches the rkey
> with the one that is written in the QP. The rkey is not part of the actual
> MMU translation that is done inside our h/w. The MMU translation is
> done using the PD (we call it ASID - address space ID) and Address.

I don't understand this at all - how can you have multiple MRs if
there is only one ASID per PD? The MR is logically the ASID since the
MR is the verbs model for MMU translation.

So, if you have one ASID per PD and multiple MRs, what are the MRs
supposed to be?

Jason
