Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9304A7272CC
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 01:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFGXSs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jun 2023 19:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjFGXSq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jun 2023 19:18:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17A32680
        for <linux-rdma@vger.kernel.org>; Wed,  7 Jun 2023 16:18:45 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f83971680eso9333771cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jun 2023 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686179925; x=1688771925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIOzJhT0hqKstM2S6gEQTLViDTnNFBm2YwBvNjGNAeI=;
        b=dyKY0yS96TF3LukPXH++FnWmRIEStl3jjAnrVa0ByfpcXQkA2sKHL0z4wX3+NYtqyC
         Td7JVNmzPvr52KUNGXUmHGyM//vofyiQv/CpYob8yW0rtlReZXpUGRs/5MfsNU4T2Gth
         XmiQyRqw5Q7hxjCNfOKUFTMAyRo0y4m3QuFxJ/UpKubVJVSlNXabE6pzuGO8cVryRuDy
         uf6hVZPOFH1nKtQadyZDhkf1Hdo12bUa6+ThDEe4v5wKylCBU4VBaMqhQs8m9T5mmcUH
         Fsg4srnZk8aI9jMuPf5dsZP15rUx5CR68VNL9IiybcGhoC2i7eW9mQcZ5E5nqduAPK3G
         +/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686179925; x=1688771925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIOzJhT0hqKstM2S6gEQTLViDTnNFBm2YwBvNjGNAeI=;
        b=K8u5aUeo+CQG+GhqKMtePpBi8b3WRSDPfkurwYzl7g324KqyDhblAajp5DK/wQu+sS
         X/TMlETie9VsH6Jh27X3EbIkMlBWvXnQ7hR/VflK3n1F4D7Mr8Ba67aPRBnPScbmZkNm
         I60d3UnIzC+HQYZhYSK1U6+8sZy7c4GDx8iS19u71q+5fzD7HDF/b3G0Di+BS8ziB5gG
         FySwWrynNGp+KcuDfh4V/2RjwLZhBpKeyeFxzLvba2eCDcTT4Y6UIirC2FXJG/w+yGd3
         YrBy4f6Lypub3RHL3XHLCtBL8kMhYhBh+NuNU9iHbht5EBuF3YjNrHOHRQNwxN2BNDna
         ogBw==
X-Gm-Message-State: AC+VfDzM1aNtFtSjTQHXRTLLbG8kIku0JiBX/I9KgH6ZFoVjGh7pDiMK
        vce12p/3rClZFGlJBs8n/nEKtQ==
X-Google-Smtp-Source: ACHHUZ5iyUE2d3PTdgxxvmoAboA/kaux55d2TBr0vmLzVM/URImo3XCoCol6OqOX1WFL/IwfgbqR5A==
X-Received: by 2002:ac8:5acf:0:b0:3f8:1ac2:4ece with SMTP id d15-20020ac85acf000000b003f81ac24ecemr447152qtd.34.1686179924792;
        Wed, 07 Jun 2023 16:18:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g13-20020ac8124d000000b003f4a76d4981sm259410qtj.66.2023.06.07.16.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:18:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q72QN-003Mqb-Al;
        Wed, 07 Jun 2023 20:18:43 -0300
Date:   Wed, 7 Jun 2023 20:18:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next 13/15] net/mlx5: Skip inline mode check after
 mlx5_eswitch_enable_locked() failure
Message-ID: <ZIEQU7cLLXXk1Nqy@ziepe.ca>
References: <20230606071219.483255-1-saeed@kernel.org>
 <20230606071219.483255-14-saeed@kernel.org>
 <20230606220117.0696be3e@kernel.org>
 <ZICP4kWm5moYRKm1@ziepe.ca>
 <20230607091909.321fc5d7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607091909.321fc5d7@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 07, 2023 at 09:19:09AM -0700, Jakub Kicinski wrote:

> > If it is really important add a 'cc: stable'.
> > 
> > If it is sort of important then send it to the -rc tree.
> > 
> > Otherwise dump it in the merge window.
> 
> You just said that people can't predict the importance of their fixes
> and yet you draw categories.

The categories exist in our workflow - we have two patch streams to
Linus and the cc stable mechanism for Greg and others. This is what
Greg/Linus defined. Maintainers have to funnel patches into these
streams.

I said people have trouble categorizing their own work into each
stream. Many people legitimately disagree what should go in each
stream. If patch comes to the list with the best guess then the
community/maintainer can help and create some consistency.

If people self-censor their Fixes lines this is harder.

Further, there is a legitimate disagreement on what should and should
not be backported. Keeping the Fixes lines allows everyone to make
their own choices. If something doesn't go to -rc because it doesn't
meet Linus's threshold it may still need to be backported.

> > But mark it with Fixes regardless
> 
> Every subsystem can make their own rules. In netdev Fixes go to net.

I don't really like this position that every maintainer and every
subsystem can do whatever they want.

Jason
