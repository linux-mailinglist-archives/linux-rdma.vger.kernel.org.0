Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CED37D3EC4
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjJWSPC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 14:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjJWSPC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 14:15:02 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CBDBE
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 11:15:00 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ce2ea3a944so2537251a34.1
        for <linux-rdma@vger.kernel.org>; Mon, 23 Oct 2023 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698084899; x=1698689699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEHshj4ZGLSNUd1/3J7uLikUiQYUKL38M7lUB087fzk=;
        b=pLl4V02x1g+KaWGkeoEaRAtGZ4uvxAvbsXh3RWA4MZd7Z3mKpeTNMUpsoRIW6SQgjD
         vjHHrsnCuycG0Jtxh8hmDTAQsZAGUOzvvVwOnlw164sgcOLjJ1m987eZfDtTpxbf+nH2
         KA5p7fjDTEBiLjpqY3jiu3aD8HMxm9sizINmLH2UxnoYXOYmPJ55iLgr8AIDVt9+507a
         KCQRYRlpk0g7+T6RWrtU16Bt8h1Xy+1kIV8RUoBFBJeG6CbQN/1EKQHO9up4HEBBUa8I
         FHQybkh7ecT33SFnaaMYpF4PBcqb3NK00CSwIof4FV2yUskciQNw2f3sTrXrxaSiub63
         RQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084899; x=1698689699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEHshj4ZGLSNUd1/3J7uLikUiQYUKL38M7lUB087fzk=;
        b=DscID/c/U2Iicqhcc6sNquLluESn90aO+L+qtMCuvWkO3B5brD06vYv0WxlRyaANEj
         T4qU7JnLGxQGAR23r4fbGnpRJG/ZETuyJr5vMRoRvPPPIToZr0ktg3OlAUj8UFb3+G2/
         hg1Pk+J4iV9PIZDXl5woQFB3jwDD4YdwKbf1FKRvN/zMeoTyzmyZpyTdlWQiL8/T4LTE
         hRDNE26QSKGeDKphnAmLjyOb7iTQ/ODWKYHqMoqVcTXzt1mW5wB3iZl8UeuNrouzLT44
         omtFNxQDzP2SLJwJiLGcvVx0VbzHnv+yPL1fbooe1zQZsVPw9vmELkWshx3kX+nUgcxZ
         Dd8w==
X-Gm-Message-State: AOJu0YzAhPgrZLuK2cvNpEtL/6e1y8GhfPwwkPs4O8hEn1ezJNSGilo6
        0nEg50VneJHadRSJstgaCcuL5lTGKa4M2IOqvTQ=
X-Google-Smtp-Source: AGHT+IETjW4KVURL38sAuytMhqq9oI5+G8qJObbDoigH6JMmCgE8pXkkrgDDG3XrQXmZN4EUlkVEng==
X-Received: by 2002:a05:6830:2702:b0:6be:e447:da3 with SMTP id j2-20020a056830270200b006bee4470da3mr9821558otu.28.1698084899393;
        Mon, 23 Oct 2023 11:14:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id k14-20020a056830168e00b006ce2e464a45sm1530719otr.29.2023.10.23.11.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:14:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1quzS5-003jNB-IG;
        Mon, 23 Oct 2023 15:14:57 -0300
Date:   Mon, 23 Oct 2023 15:14:57 -0300
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
Subject: Re: [Patch v7 1/5] RDMA/mana_ib: Rename all mana_ib_dev type
 variables to mib_dev
Message-ID: <20231023181457.GI691768@ziepe.ca>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-2-git-send-email-sharmaajay@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697494322-26814-2-git-send-email-sharmaajay@linuxonhyperv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 16, 2023 at 03:11:58PM -0700, sharmaajay@linuxonhyperv.com wrote:
> From: Ajay Sharma <sharmaajay@microsoft.com>
> 
> This patch does not introduce any functional changes. It
> creates naming convention to distinguish especially when
> used in the same function.Renaming all mana_ib_dev type
> variables to mib_dev to have clean separation between
> eth dev and ibdev variables.

> Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/cq.c      | 12 ++--
>  drivers/infiniband/hw/mana/device.c  | 34 +++++------
>  drivers/infiniband/hw/mana/main.c    | 87 ++++++++++++++--------------
>  drivers/infiniband/hw/mana/mana_ib.h |  9 +--
>  drivers/infiniband/hw/mana/mr.c      | 29 +++++-----
>  drivers/infiniband/hw/mana/qp.c      | 84 +++++++++++++--------------
>  drivers/infiniband/hw/mana/wq.c      | 21 +++----
>  7 files changed, 141 insertions(+), 135 deletions(-)

Please no, don't create pointless giant churn like this. It only hurts
backporters

Maybe just target the functions with more than one type

Jason
