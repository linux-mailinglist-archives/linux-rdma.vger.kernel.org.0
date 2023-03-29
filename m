Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6996CED39
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 17:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjC2Pou (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 11:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjC2Pos (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 11:44:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB0855AA
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 08:44:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c18so15309675ple.11
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680104680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlJRl8unuKE1aCfBdVRKi5WW2RTIZ7b4J3MrkN7spUA=;
        b=C4g/W1VXFQo0M44uyoPG57i9G6iB3Na6m7Yw7bGIpDMRZZUnxP8ITMcg7jUR9AN/Yv
         4dJFO6xlg3YTgB17qI5KJpweVXb6TzSzi8ClGkAvEDUVqfH774V3/T4pRjkLZn/yZ4rW
         rlN+COTzaHMVQNidV25UY31zZ8Hwsk8AZTpM4RwerFD2/9KZCwDNGi1NXCJqR8nlQv+u
         1EbdvU5u8opqGFnM/WBEX+pWXJYr04bTPy3dUi1N5/At7WdlrBvSpIMWc2SRXzI6fyyv
         qk681EZjJXxi+Mtkk1A/MpnGkdvcqU4eAuZyJtl17dpb8dFH6r1aFPcFCplUvbIHq/ar
         56Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlJRl8unuKE1aCfBdVRKi5WW2RTIZ7b4J3MrkN7spUA=;
        b=NbutHhY0bN+LVYr5P/VkU63eg3tG04kmate8zJbDBaan8Jl1wK4UNEz1Ie/BavIWJA
         3Wf2kU0D4d5t1XOySUwOyEwfuDn7+aLGuHCACXocpv9m0+IeaXQu4CoiGq0LK+zq33QS
         OcIvnwujolEvz4NGJAqwM+qYVGTQAQtgTNHcus3PAY6lCZKuGE2h7RbEweYmALhBsl/z
         90+y/ZwA1gNUpqI3qmblUXM8D11I7GrP5grZWnYwC60kQhBszWRaScPdKMhI4zxDGLZm
         f1Gs27scpxux+2QecFuf4sopPReTYFu1cuqonTA67lUPorWC5zTOoPi53xUElVHs75gO
         NlvQ==
X-Gm-Message-State: AAQBX9cVab4EmlRlRwRiqL4gWFwTUcVFIunBw7rL5n8yZztoQGsa+iuh
        AJT2mgR6sAAexPauufk4KkoD+A==
X-Google-Smtp-Source: AKy350Z6UvGVWZ8sMr8s17h+m9nEHH3UJIf4AYCblxmKoR14WSjiq3KJP8jjGV5h6SvTQOpj6Ze95Q==
X-Received: by 2002:a17:90b:1d86:b0:23b:3f18:a8fe with SMTP id pf6-20020a17090b1d8600b0023b3f18a8femr22367612pjb.31.1680104680149;
        Wed, 29 Mar 2023 08:44:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id i19-20020a17090adc1300b0023a8d3a0a6fsm1558970pjv.44.2023.03.29.08.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:44:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1phXyX-004coE-Ol;
        Wed, 29 Mar 2023 12:44:37 -0300
Date:   Wed, 29 Mar 2023 12:44:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: don't ignore client->add() failures
Message-ID: <ZCRc5S9QGZqcZhNg@ziepe.ca>
References: <0e031582-aed6-58ee-3477-6d787f06560a@I-love.SAKURA.ne.jp>
 <ZCLOYznKQQKfoqzI@ziepe.ca>
 <a9960371-ef94-de6e-466f-0922a5e3acf3@I-love.SAKURA.ne.jp>
 <ZCLQ0XVSKVHV1MB2@ziepe.ca>
 <ec025592-3390-cf4f-ed03-c3c6c43d9310@I-love.SAKURA.ne.jp>
 <ZCMTZWdY7D7mxJuE@ziepe.ca>
 <d2dfb901-50b1-8e34-8217-d29e63f421c7@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2dfb901-50b1-8e34-8217-d29e63f421c7@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 07:17:26AM +0900, Tetsuo Handa wrote:
> On 2023/03/29 1:18, Jason Gunthorpe wrote:
> > On Tue, Mar 28, 2023 at 11:59:48PM +0900, Tetsuo Handa wrote:
> >> Without this patch, __ib_unregister_device(device) is not called because
> >> enable_device_and_get() returns 0 because add_client_context() returns 0
> >> because add_client_context() ignores client->add() failures. As a result,
> >> device's refcount remains 7, which later prevents unregister_netdevice()
> >>  from unregistering this device.
> > 
> > That is completely correct, the device was successfully registered
> > without one of the clients.
> 
> ib_register_device() is responsible for unregistering that device (by calling
> __ib_unregister_device(device)) if ib_register_device() failed to
> initialize a device, isn't it?

Yes, if it fails. It isn't returning a failure code, so of course it
doesn't fail.

You changed this code and forced it to always fail, so of course it
radically changes everything about the bug you are looking at.

> The caller of ib_register_device() (i.e. siw_device_register() from
> siw_newlink()) is assuming that somebody will call __ib_unregister_device(),
> but nobody is calling __ib_unregister_device().

On the success path this stuff happens during dellink

Jason 
