Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF552A582
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 16:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349513AbiEQO7y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 10:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiEQO7x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 10:59:53 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02D74AE27
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 07:59:51 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id n10so14542986qvi.5
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tr4AALZAcgwN+FDcDi87udLeLPWs7ZAJ5eWXrFs/jlw=;
        b=lXoa1En3yZsvkJXX4fuc+7NHLvgNe+4aH70ouZjesRaJiFMXxX3QG3dsf1t5fkrHcb
         Q8gmODYofe2MNMy1TlXekQuey0cpzxYl3vDW46FRA52AmehrCMEYrd4QWaOy8MeNpl7n
         r2yRQaaRg1vKoHAskReKzSNsHzUKAFzqElkPIEBcZy3mlGI3b6d3rlaY5P12JlQs7UWd
         QLNWlpQ27uK+EAd2OXnozD8WszrLY7zYOUN/aZzWwDPhI8oQerbmRCZqrKlH5G+DbRRC
         rv7+mMxfFlLS1KzK4rWDUMW1nZocWhEwhzR9/aOyS48LCiph4jdfVp12q2437zUeTfhE
         E0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tr4AALZAcgwN+FDcDi87udLeLPWs7ZAJ5eWXrFs/jlw=;
        b=NXIm9X4gl2HaAeeq6svJ/7u4ooamNhLXfL0aqSG55YMM+lAwShjNNG9/hvcDdTVi1I
         hWoW565kolDHneDUo+v4W1ptmbhw5vhfZAruLi7DVDJ9rg2NPIEUVJCBS87LzkWI1dZV
         WDXTY+vkuVXPzFQWI/whDp2KftqsFYN3/Thbp2uhM/gDNLNhYgnr9BLSGX2TWIK77hMf
         rozLYR3CRPqXeJoU3ZHJJ4YLcDfGOiQyNJqO27+yYcsfByq2K1cbeRONieUPqSDk3j5x
         Batj0WcV1BOfY4JIkjsDX2FZAn4tusxXoe5NzN49bv6KGYgxCo0dWNw63TtGp76mONMs
         fNQg==
X-Gm-Message-State: AOAM531ZPuW8DO2qFkrSbLjxTAQP1sSN1GJR9rvg72w3b+xpB88icwqz
        mrtJEjFBV/FEzaXEe8TJlM47KA==
X-Google-Smtp-Source: ABdhPJx0troKsku15aanl/7FKxHDc5w10XHBWKlnQ8Fmx7m1X3jRjlIfgLoQRfI9MNsqxTicoEk4/w==
X-Received: by 2002:a05:6214:27c2:b0:45b:9ee:7310 with SMTP id ge2-20020a05621427c200b0045b09ee7310mr20771589qvb.85.1652799591107;
        Tue, 17 May 2022 07:59:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 16-20020a370710000000b0069fc13ce1d7sm7735790qkh.8.2022.05.17.07.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:59:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nqyft-0084Ur-Sq; Tue, 17 May 2022 11:59:49 -0300
Date:   Tue, 17 May 2022 11:59:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     longli@microsoft.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 05/12] net: mana: Set the DMA device max page size
Message-ID: <20220517145949.GH63055@ziepe.ca>
References: <1652778276-2986-1-git-send-email-longli@linuxonhyperv.com>
 <1652778276-2986-6-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652778276-2986-6-git-send-email-longli@linuxonhyperv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 17, 2022 at 02:04:29AM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> The system chooses default 64K page size if the device does not specify
> the max page size the device can handle for DMA. This do not work well
> when device is registering large chunk of memory in that a large page size
> is more efficient.
> 
> Set it to the maximum hardware supported page size.

For RDMA devices this should be set to the largest segment size an
ib_sge can take in when posting work. It should not be the page size
of MR. 2M is a weird number for that, are you sure it is right?

Jason
