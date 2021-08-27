Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C03F98E3
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 14:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbhH0MLZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 08:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhH0MLZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Aug 2021 08:11:25 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E7DC061757
        for <linux-rdma@vger.kernel.org>; Fri, 27 Aug 2021 05:10:36 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t190so6864782qke.7
        for <linux-rdma@vger.kernel.org>; Fri, 27 Aug 2021 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tabyB924yXzKjpImGrZhEjdKF7M150xI6NXPXiRzacQ=;
        b=BXOWR0PoIMXAKeleGwpfna7bI0eKjcWwgsphSW8ThLvagIpDr0ls8T2rwQF4WaCYAP
         Nq8VthgBIjaMUmNkJJE5Hwe0p/+3AElNMwCti8WYko1Ip355vTLK41xamz4sDzkVarCy
         TuTYufAPQjwnsjTbjgE8ZUjjOE4nIIg6xWTi5I0b8whsNLyXTuNpMRqj7m25O1m/kjyi
         tGleiN1YawmdwDRDS6nIrbww73nh546jFUpBOYpQ8ryhiIH/GPQxhlfqdnkbPU9jgudD
         udg/fSkl8CvxxWVRbSd6JBto62jmSLZwL21/ci7CBLE9os8UXBW4oIz1k3angsHEHn8J
         OzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tabyB924yXzKjpImGrZhEjdKF7M150xI6NXPXiRzacQ=;
        b=GsVxl+td//K2ha02w4jinI6OpTpLhCUyMw16goWwlibr72gWlzVCFwKO8E2e299b+p
         DI6c37YB1RYw56uEGoqSlq8AYpeVtxFnekaLWdIvepPmKKr0m2a3obcnP0ql31X2yCrx
         3Q3PzJFzZn1dXPs5WOUAlBPfm8xlivnn9BZYnw+zP6et/if6jzQN62ZVRsfrkW8QDQ6P
         gBCMqgeBGJ2tc+NfcUy9isuOJDgPluPDH99TRflCn2D++mOdJyMgggpKQeWgJetqkDHv
         LC3chfJYpVyapr9FBax05FC6jIsQbnJAk1vMUk3+8GC4pxD/aKdp1iahEFyN5BAeY3LW
         q01A==
X-Gm-Message-State: AOAM530SSkcocZAIg+tsIZIhh4Y6imQcn5fl/Pd7qRJ3z9HsEFCrWtRa
        k2K2h14w1zD8/5mqQHOKszsw7g==
X-Google-Smtp-Source: ABdhPJxcPlkQBE/+4Tx66G5euuWsIpG7RqUHiGHzvkWM9wne3DI0N4maWU6ebpmyWqNselqD09P/QQ==
X-Received: by 2002:a05:620a:7d5:: with SMTP id 21mr8703422qkb.339.1630066235609;
        Fri, 27 Aug 2021 05:10:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b1sm3451778qtj.76.2021.08.27.05.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 05:10:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mJags-005eR4-H7; Fri, 27 Aug 2021 09:10:34 -0300
Date:   Fri, 27 Aug 2021 09:10:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        Yishai Hadas <yishaih@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: Re: RDMA/rpma + fsdax(ext4) was broken since 36f30e486d
Message-ID: <20210827121034.GG1200268@ziepe.ca>
References: <8b2514bb-1d4b-48bb-a666-85e6804fbac0@cn.fujitsu.com>
 <68169bc5-075f-8260-eedc-80fdf4b0accd@cn.fujitsu.com>
 <20210806014559.GM543798@ziepe.ca>
 <b5e6c4cd-8842-59ef-c089-2802057f3202@cn.fujitsu.com>
 <10c4bead-c778-8794-f916-80bf7ba3a56b@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c4bead-c778-8794-f916-80bf7ba3a56b@fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 27, 2021 at 08:15:40AM +0000, lizhijian@fujitsu.com wrote:
> i looked over the change-log of hmm_vma_handle_pte(), and found that before
> 4055062 ("mm/hmm: add missing call to hmm_pte_need_fault in HMM_PFN_SPECIAL handling")
> 
> hmm_vma_handle_pte() will not check pte_special(pte) if pte_devmap(pte) is true.
> 
> when we reached
> "if (pte_special(pte) && !is_zero_pfn(pte_pfn(pte))) {"
> the pte have already presented and its pte's flag already fulfilled the request flags.
> 
> 
> My question is that
> Per https://01.org/blogs/dave/2020/linux-consumption-x86-page-table-bits,
> pte_devmap(pte) and pte_special(pte) could be both true in fsdax user case, right ?

How? what code creates that?

I see:

insert_pfn():
	/* Ok, finally just insert the thing.. */
	if (pfn_t_devmap(pfn))
		entry = pte_mkdevmap(pfn_t_pte(pfn, prot));
	else
		entry = pte_mkspecial(pfn_t_pte(pfn, prot));

So what code path ends up setting both bits?

Jason
