Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486EE52AC0D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352783AbiEQTf0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 15:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349411AbiEQTfT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 15:35:19 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B15517DB
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 12:35:18 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id j6so15325780qkp.9
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QnbKYBhh3c63Yumph0EWjqW7Wj2wBUNjFmt4Rfdy8jc=;
        b=UCDLE6mdjuGa1AhVdCEcBtExr96rjGXBSfEIQfr7ykTyHhQER0s0t79knhisfx/JC1
         LjKqwJmJLW3zBjmEU2Rnwt7SKxPUics0pfUJVLOHxKJJL3Q18/6zj6anFNufHe7u6Twr
         LNNH2zyFm1uVvNAvNrH6PLvqGI5JoCIpeafoNbKLk2ArMwb81GrFbAO0pw1kAq5TfDWw
         lIO8eTksc5Cgo1IbAOny3t54T3tlORvXjrZ2VxK2keaT+hG7v0H6LH8ca5anh2hlDwDE
         y02VhaC+GMQGeVU/EG/l6UccIUFS9muojSW9hKGhwex+CwPVJm9IvzBQ+NRJGsIXocRd
         rdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QnbKYBhh3c63Yumph0EWjqW7Wj2wBUNjFmt4Rfdy8jc=;
        b=vHCDeMu+ohZGY+qK4XKq32DEqnGJvVGGPLAT1XQ2K2Qkmhi/1o1icg2P6k41y2b2P1
         lO4zb2x4JRlpXyr8aTVFIplFVdkYwVGn7wTg8XMptBEGfUDBqQMEO4YdQFPCcBNTzgNO
         KVJqWdGui4IqKJza+QtLQ8TZc+qTywhV9II+OCIuGGZOeKxybbJ9wlgbRaFxTTvzG71M
         e57JP9V+V0TsZQWONqfbe56hlgGpAuLkb4qDzcw5+y89XkW3Kygl1BXUTnTSuWSZ3Ng8
         zuQdFZOZhy8qAvKtTpz+hKqLKcn48V8NX9L/bWfpKR8CalzdDQwVsxvHikgnM05gt6Ie
         W25g==
X-Gm-Message-State: AOAM531MorXq61dRFh6YWMSiTQ13C0Y8i2FKN6SM+vLtO2TtVGkG274D
        kJmKBd1s34uo6g2roS0F7Gu3qACJA4RMHA==
X-Google-Smtp-Source: ABdhPJw0eqpSbzGKh5H8X2cDcZfGERE5Mhf/8w5a5kiJ3PoOwP56ky0cT+SyFvH1q1HRmRLcR5AZ6Q==
X-Received: by 2002:a37:a04b:0:b0:69f:baff:b185 with SMTP id j72-20020a37a04b000000b0069fbaffb185mr17318830qke.176.1652816117436;
        Tue, 17 May 2022 12:35:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f6-20020a05622a114600b002f39b99f69esm8203853qty.56.2022.05.17.12.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 12:35:16 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nr2yR-008A2U-Qr; Tue, 17 May 2022 16:35:15 -0300
Date:   Tue, 17 May 2022 16:35:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Long Li <longli@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 05/12] net: mana: Set the DMA device max page size
Message-ID: <20220517193515.GN63055@ziepe.ca>
References: <1652778276-2986-1-git-send-email-longli@linuxonhyperv.com>
 <1652778276-2986-6-git-send-email-longli@linuxonhyperv.com>
 <20220517145949.GH63055@ziepe.ca>
 <PH7PR21MB3263EFA8F624F681C3B57636CECE9@PH7PR21MB3263.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3263EFA8F624F681C3B57636CECE9@PH7PR21MB3263.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 17, 2022 at 07:32:51PM +0000, Long Li wrote:
> > Subject: Re: [PATCH 05/12] net: mana: Set the DMA device max page size
> > 
> > On Tue, May 17, 2022 at 02:04:29AM -0700, longli@linuxonhyperv.com wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > The system chooses default 64K page size if the device does not
> > > specify the max page size the device can handle for DMA. This do not
> > > work well when device is registering large chunk of memory in that a
> > > large page size is more efficient.
> > >
> > > Set it to the maximum hardware supported page size.
> > 
> > For RDMA devices this should be set to the largest segment size an ib_sge can
> > take in when posting work. It should not be the page size of MR. 2M is a weird
> > number for that, are you sure it is right?
> 
> Yes, this is the maximum page size used in hardware page tables.

As I said, it should be the size of the sge in the WQE, not the
"hardware page tables"

Jason
