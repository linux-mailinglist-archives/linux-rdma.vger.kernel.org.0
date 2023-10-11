Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C3F7C60DA
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Oct 2023 01:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjJKXKZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 19:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjJKXKZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 19:10:25 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5877B7
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 16:10:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4194d89a6dfso2555671cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Oct 2023 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697065822; x=1697670622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pE4C1PjtBwHfwQnQ/BWQr6OrTGyHylYmZgGyzqVL5/U=;
        b=XpNHneBPrWUvofoEizNZP5HzzkxU8yrUIF5sl8cT5G4aG1Xkz2P0UFrCMgc9bJ4nkG
         bdsQYfFwU58uIjlunSvwTAgF2ioZ5AShGdrxfo6Jucnsu+109NrrkLvNdtEq1wuMLFF/
         hwGYLJO7swgyeEgJzvnScORJWDbPq3vrP6481X/nRK1Hz5pxAz0dmtYyBvYO8qTKyofZ
         urG+miT8HC/sRHNpGRGV3vCxudRWHOsE1j0NTO4lRXE+9PpoYKfiOGxaj1mEZrkqK6Ku
         d0MczA8VO9WOpMSpa+ES97K8sk1B3r21AHqx3f9bKgvQh5eqN4BYhgMgAavAefuoL1Uj
         x+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697065822; x=1697670622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pE4C1PjtBwHfwQnQ/BWQr6OrTGyHylYmZgGyzqVL5/U=;
        b=jmrHb2DEfozFZRIK3qeah7Ujp31zFVlznC8URvpO81wYItbYdbp5D/jXBFGbZrcFY2
         IyhLyIj7En8mSNe+DtxwkdbtUDtI55URj82/aAtBFpLwL2I1Z4//7ZyfRjKQv2UgRtYB
         OySBbLaoZvNRCi+B0dQsJ1jE3Wug6k+vR+qW7nga2qy71TsVAw46TOANDxNBzZ4Jo8jY
         LQR/xGoB4aNa+FK46rYh2/TRrLWw4SdqeSF98SjCHCjY2p0XGrkzgZPE7A/96VJvP+YX
         fsyQBi8JdPkEn6q6Vr8kFQm+qKkIsdiTzk2xkUmGN/9Z9BVqP8t5stqDJ2cn74B8zRtg
         WIIg==
X-Gm-Message-State: AOJu0YyfPNSmdnPqzdjB2Xln3gexleasniAjRos1/cuiizo4Xm2bTZbQ
        CeleXtfEQX8qJj8JbJKljfB3LQ==
X-Google-Smtp-Source: AGHT+IEsBh106ERG5fcZutotax71+to9I7W4F2Eq39+fQZfREWil8ZfLKHw8e5yzZK96gO3ySOZs3g==
X-Received: by 2002:ac8:5d8f:0:b0:410:60a4:ffbc with SMTP id d15-20020ac85d8f000000b0041060a4ffbcmr26726688qtx.66.1697065821813;
        Wed, 11 Oct 2023 16:10:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id l17-20020ac81491000000b004181d77e08fsm5699199qtj.85.2023.10.11.16.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:10:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qqiLM-0014Y3-H6;
        Wed, 11 Oct 2023 20:10:20 -0300
Date:   Wed, 11 Oct 2023 20:10:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shay Drory <shayd@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
Message-ID: <20231011231020.GG55194@ziepe.ca>
References: <20230928-mlx5_init_fix-v1-1-79749d45ce60@linux.ibm.com>
 <20230928175959.GU1642130@unreal>
 <a1f8b9f8c2f9aecde8ac17831b66f72319bf425a.camel@linux.ibm.com>
 <20230929103117.GB1296942@unreal>
 <ZSbtMO8AWLx29RBS@x130>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSbtMO8AWLx29RBS@x130>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 11, 2023 at 11:45:04AM -0700, Saeed Mahameed wrote:
> > > The above works too. Maybe for consistency within probe_one() it would
> > > then make sense to also rename set_dma_caps() to mlx5_dma_init()?
> > 
> > Sounds great, thanks
> > 
> > BTW, I was informed offlist that Saeed also has fix to this issue,
> > but I don't know if he wants to progress with that fix as it has wrong
> > RCA in commit message and as an outcome of that much complex solution,
> > which is not necessary.
> > 
> > So I would be happy to see your patch with mlx5_dma_init().
> > 
> > Thanks
> > 
> 
> Actually I prefer the internal patch, it moves the dma parts out of
> mlx5_cmd_init() into mlx5_cmd_enable() which happens after dma caps are
> set. since it is using the current mlx5 function structure and breakdown, I
> prefer it over adding new function to the driver.
> 
> I will share the patch, I will let Niklas test it and approve it before
> submission.

Let's hurry please, mlx5 will be broken on S390 in rc1 if this is not
fixed soon.

Jason
