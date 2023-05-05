Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1747D6F89EA
	for <lists+linux-rdma@lfdr.de>; Fri,  5 May 2023 21:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjEET6y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 May 2023 15:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjEET6y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 May 2023 15:58:54 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B72197
        for <linux-rdma@vger.kernel.org>; Fri,  5 May 2023 12:58:53 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-74e3de79bf2so209361185a.2
        for <linux-rdma@vger.kernel.org>; Fri, 05 May 2023 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1683316732; x=1685908732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8/0Mz1i3TrsK5EuHofqZpbzmHEgycZi6NeOkBStzxc=;
        b=PibVkdMtrGXG4nJCsSpO+dyX40H7jVmFM5a/TLyr7glOsgpls3oaUCXmR2tz1P9ZQS
         aIq11OVfIkafWXqXLBrCAFAgg0Y6Uif246c/M7XoxGTk1/YmL+2TeAkyQxc6R/ur97Jd
         560EkduqhNdBTHgYaJxzY6GKNBfDvZsCwGX9UabPP64GQQsIpsjxWgkSzQnstnioQBbB
         zrJ8fqnPhTpZ3eUY+phtcjta6ibdPYrH0Ywr6ylLKVGmvwmJ3bNo7C6hHj4haE+y1KXf
         h15FLI8dSGBt01m+IYnKWScqocAfpryZ41pbX20JqaysMzXYOuUkXh+0Mgl0yz70nuQ+
         eEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683316732; x=1685908732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8/0Mz1i3TrsK5EuHofqZpbzmHEgycZi6NeOkBStzxc=;
        b=HBmLD6E0eCiFp4gS9EoIJoFd5M90izFK6dCNva1fkanzp9S2Wy95WurHo73fsfLQtg
         PHBOHpzYzD1gQhre+Mb7uJyE3KxEgJLF2pkE1UUC/VgngZYHfQvx34IPMPbW5bGyOf27
         wOUEPDGPunDMkAsJj7XdgiaxAaGsCCWqz5Bl1OuEsyUWZZluYvUDyKgtZWOla7jGTb9a
         Ly21+twZDbhVpAljEo86w5LG86M1HXKQWKeDm6wf7KYObjxOo8Z3iRswlvjrJC0l0zAF
         Jkdh3NJPyBI+I1w+nwhfwNl2hZOEE0fURRjLW+kT31AnVkv7vq9dCwdG8jUiD/YN8k0d
         TlOw==
X-Gm-Message-State: AC+VfDzqF5laiX76LyoglDa9QV6dLAFZgkRChbz08lGgZTDOmmYWDt1D
        P7YjWvwVOoS8vE+HO65aYlzWf2mCjT/NY0LA4YM=
X-Google-Smtp-Source: ACHHUZ41Fdv176OLWVq9lKASou3V2H+AkTzBXpY6k9951af/PZTdY11T+LpjtJxw5VEsQnvjkhVp8Q==
X-Received: by 2002:a05:622a:1a21:b0:3ef:36d0:c06e with SMTP id f33-20020a05622a1a2100b003ef36d0c06emr4858856qtb.33.1683316732523;
        Fri, 05 May 2023 12:58:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id n10-20020ac8674a000000b003df7d7bbc8csm853125qtp.75.2023.05.05.12.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:58:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pv1Zr-007zWe-A9;
        Fri, 05 May 2023 16:58:51 -0300
Date:   Fri, 5 May 2023 16:58:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <cel@kernel.org>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        BMT@zurich.ibm.com, tom@talpey.com
Subject: Re: [PATCH RFC 3/3] RDMA/siw: Require non-zero 6-byte MACs for soft
 iWARP
Message-ID: <ZFVf+wzF6Px8nlVR@ziepe.ca>
References: <168330051600.5953.11366152375575299483.stgit@oracle-102.nfsv4bat.org>
 <168330138101.5953.12575990094340826016.stgit@oracle-102.nfsv4bat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168330138101.5953.12575990094340826016.stgit@oracle-102.nfsv4bat.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 05, 2023 at 11:43:11AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> In the past, LOOPBACK and NONE (tunnel) devices had all-zero MAC
> addresses. siw_device_create() would fall back to copying the
> device's name in those cases, because an all-zero MAC address breaks
> the RDMA core IP-to-device lookup mechanism.

Why not just make up a dummy address in SIW? It shouldn't need to leak
out of it.. It is just some artifact of how the iWarp stuff has been
designed

Jason
