Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39606C34A6
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Mar 2023 15:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjCUOqJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Mar 2023 10:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCUOqH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Mar 2023 10:46:07 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE49C67C
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 07:45:55 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c18so18107792qte.5
        for <linux-rdma@vger.kernel.org>; Tue, 21 Mar 2023 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679409955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii1KJEuyAv2H1feuitrwylKSi+/QEEq312SF2quZlzo=;
        b=TLJc+WtHot1+kuXcPeVVNrQWy73zJ4bJ4yCrtN1/4+QHDcxLr9RkC0tTMGAjg3ra5h
         JPoR8S8OPhYS+UhhwzmVAr+Ly9gCnbUeUJOXeEk4ul8QMS4KlwEG8kz5DHT2kcH8HsVf
         kpsBF0gGIfrk++1Il3nQ665KOJsD/Kux4mLFIBYWaWx/LQe75K8y70rZxNmjT5K8erhW
         JC17WMQG0diZ6vnUxvwi5Th/EFzf/bKI/etDifaqS5sIVNQ6b7y03QKzZTcLnNJvLsNF
         jsEAtN/60Q9jXGuXRKMOqjae9Y1HsHMa8FcRtWohV2haxjzdCe4tKZ8sVVP5vKus4UZK
         Gm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii1KJEuyAv2H1feuitrwylKSi+/QEEq312SF2quZlzo=;
        b=ISTwvBCLSphaOM2eLlAZRyqLUCQ73zBIfjkv/6+2YO4hojJMgxFhIhVQ1TRdyocLjJ
         Dad0KoOdUKZ8IE2mRwAvUIQPI2sBImcfFd7QlamOfYWCfjZiTMSaAWRQALvaLzd/7qIZ
         UB+re7VIs+cxcYumERG4GDeDrGf6oeGioU3gXMIhO/ONYICXoNVah+ZznLOe+DG9V4nI
         XiNQpY4N9WVb35W+erwsAjAfjVDIu/KIcsIM26C9RSgTUk7dF8DFswlJKKzu1GbhSTs2
         xAXhXZnUMlyVGgbSnsU6OH6hPwk5e5SeSs56TnU7Mia1tgB73NhUpd19Bp1pDGaO9h3e
         4bwQ==
X-Gm-Message-State: AO0yUKXjfI6LU3l+/Yy1fZCIgWASaayS/RtgdRXOD6Lzv1ZmtyRPYixW
        NJZeD1xNl6QSbScV/SHtEQ5vDwVKOaYn5CgI9NU=
X-Google-Smtp-Source: AK7set+0VtbLvnN2fBDuAEniy8+Sktw34oimNRRvKOye3akSVG2zaI2L55ZZ2UQ4I9Uex6aJJRhz3w==
X-Received: by 2002:a05:622a:116:b0:3ba:1d8d:f6d0 with SMTP id u22-20020a05622a011600b003ba1d8df6d0mr161617qtw.23.1679409954739;
        Tue, 21 Mar 2023 07:45:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id m4-20020ac866c4000000b003e30aec0b70sm2689176qtp.64.2023.03.21.07.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:45:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pedFJ-000Vfh-PV;
        Tue, 21 Mar 2023 11:45:53 -0300
Date:   Tue, 21 Mar 2023 11:45:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [rdma-core v44][bug report]DEB installation failed
Message-ID: <ZBnDIQUbj8Pat5Cx@ziepe.ca>
References: <8b56dfed-3e9b-8a6b-df4c-8f1d4da8a72d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b56dfed-3e9b-8a6b-df4c-8f1d4da8a72d@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 21, 2023 at 06:42:15PM +0800, Cheng Xu wrote:
> Hi, Jason and Leon,
> 
> I found that there is a DEB installation error in rdma-core v44.0.
> The error prompt:
> 
> dpkg: error processing archive libibverbs-dev_44.0-2_arm64.deb (--install):
>  trying to overwrite '/usr/lib/aarch64-linux-gnu/libmana.so', which is also in package ibverbs-providers:arm64 44.0-2
> 
> It has been fixed by commit 766f88465e32 ("debian: Exclude libmana.so from ibverbs-providers")
> in master branch [1]. Today new version is released, but the commit does not present
> in stable-v44 still [2].
> 
> I want to fix this issue for v44, but it seems that there is nobody creating
> PRs for stable-xx branches. How to handle this?

You can refer to Documentation/stable.md

Thanks,
Jason
