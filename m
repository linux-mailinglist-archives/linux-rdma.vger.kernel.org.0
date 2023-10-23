Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EE87D3F0C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 20:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjJWSVy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 14:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjJWSVx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 14:21:53 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F210BE
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 11:21:51 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b3e7f56ca4so2183961b6e.0
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698085310; x=1698690110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELhPHgmF7pPJ0f5VbSNCKVTdPqoWjN7MfIE8blhP1v8=;
        b=PbZDGy48iqssau03QIP9wvYb2V5M/5cCvDd4R64DNFEgRiKFLbyU047d0oZiYj5ZZd
         KNyNdKEJLnDWRSFx8l3mIPZTSXVsW9vXg21GQKyca7VgSbc6nr4BrLPeyA89N3QpqKDD
         iFfVpeMWULqCn8aMbbcA/n4FeUGFi9NuRmYyynsWX9fTAjyD+0OSgQAC02mtyPb2g11K
         J+vpPbS1e3b7vWxDlRZa0zf6N71NS/Mn5dR3fcRopN9nnFNdYyOKV+it30ljw5F3Uh8w
         jX4A6SHv//xnErt9az90/raLduCT5KJDcN3v4LaxWPFPQH7jiUPe8AgMbdZVcdfdKoWS
         yV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085310; x=1698690110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELhPHgmF7pPJ0f5VbSNCKVTdPqoWjN7MfIE8blhP1v8=;
        b=fJWxEzxhSebKup4ilSTQHAA1HkaDPGqCIDJOMz88ScD+1w8BWYvH0dFqgtuw44QNzn
         O79hhq6kR/vI/a1yisGOm/Xs9C6/jb1z8AtkxPaiD92JTiG8PFuRjEytXeeit2Xqba2g
         ScarxP9Yuo3ePx/1CJ0V6/eKDvNN4P3Px0SiFvFCx6sBTYQGZSSjL9tyPw+LXXQJZUp8
         4qN4WBm2EHjollXmLcBsuIfgX6lZtxu9Sv0BiY6yx1izE9v2vbcsExF39IzJ9dyse06x
         pENeONhREyaazRuDcwQLk2MWmtyuCTwGwMNSOmL3+y5D5sbFUhyGf+ew51bO87cAYXTQ
         XI1g==
X-Gm-Message-State: AOJu0YzGYe0wBWnkrEVs3BX/gKeXc13Uis2uAlYzI0IXLZ6tx5H+qE6T
        bEv9FUWcXG+jlA5q8EniEkgtAg==
X-Google-Smtp-Source: AGHT+IENr5mCUHAQy2/Dcv2K9Fd98rrNYfVmPpwtNc8CFJKK9E6ArTW0+TnAeTK7TBCwNez8Vc6hMQ==
X-Received: by 2002:a05:6808:46:b0:3ad:f866:39bd with SMTP id v6-20020a056808004600b003adf86639bdmr9848014oic.27.1698085310628;
        Mon, 23 Oct 2023 11:21:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id z18-20020a056808029200b003b2f369a932sm1579278oic.49.2023.10.23.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:21:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1quzYj-003jR4-AF;
        Mon, 23 Oct 2023 15:21:49 -0300
Date:   Mon, 23 Oct 2023 15:21:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     sharmaajay@linuxonhyperv.com
Cc:     Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v7 3/5] RDMA/mana_ib: Create adapter and Add error eq
Message-ID: <20231023182149.GK691768@ziepe.ca>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-4-git-send-email-sharmaajay@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697494322-26814-4-git-send-email-sharmaajay@linuxonhyperv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 16, 2023 at 03:12:00PM -0700, sharmaajay@linuxonhyperv.com wrote:
> From: Ajay Sharma <sharmaajay@microsoft.com>
> 
> Create adapter object as nice container for VF resources.
> Add error eq needed for adapter creation and later used
> for notification from Management SW. The management
> software uses this channel to send messages or error
> notifications back to the Client.
> 
> Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c           |  22 ++-
>  drivers/infiniband/hw/mana/main.c             |  97 ++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h          |  33 ++++
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 147 ++++++++++--------
>  drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
>  include/net/mana/gdma.h                       |  13 +-
>  6 files changed, 245 insertions(+), 70 deletions(-)

Split up your patches properly please this says it creates the
adapter, code to create an EQ and process events should not be in this
patch.

Jason
