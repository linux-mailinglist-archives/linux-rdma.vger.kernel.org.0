Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2D7988B8
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Sep 2023 16:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbjIHOa3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Sep 2023 10:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243973AbjIHOa0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Sep 2023 10:30:26 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352F61FDD
        for <linux-rdma@vger.kernel.org>; Fri,  8 Sep 2023 07:30:19 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-414d37bd1e9so15071681cf.3
        for <linux-rdma@vger.kernel.org>; Fri, 08 Sep 2023 07:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694183418; x=1694788218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xuLwfgsvmAUWs7vxqHGdnIpvRxY+S+flrjEPUNwXBKI=;
        b=M4WarCHtCh+dV73cMhkCDNdExz0FQuZ5zqQiAClVRzG9FscGFh5VcQBlvTeaK1Qxbt
         TjYokDGnuL1Oc3NBrwjSi/feR30+0YmthFWYwIFtkqYqH6Xx52uG1IJ+WcY+BqJZzlus
         kDLGOOT/hBLAZvHhShoY7T2WEAxiYceKmlO+ZInOD7guzBjussyeaRtoyE/qWmUDkU6e
         XINmNS/H61q+8aq3quZytrw5HeQeBjI2cWUV5AlebA+QyYOlXmB3fhrGbTulAuLYTtKn
         B81b0k6Z8gOYM3RNv3O9fGHmB3YEH/fQUQs5B26AIInexjkYhc7ri07NqmkAuOJEvXTs
         n+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694183418; x=1694788218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuLwfgsvmAUWs7vxqHGdnIpvRxY+S+flrjEPUNwXBKI=;
        b=OaRih7+25fEhmaHlLJv5YmPWTkWKZsbsQ0KY3y7s8BkHb8SpK5KI/IBk9N7FQkKs2U
         +yRw27LERV8CvswZYqdK6oVXnXi4n2o/f6TQVaYzDZw+WDr0Unr1vZebJ0Jgo2XojWOF
         9YOA6ly+I7mxa14zBP2agHeU9kRNQ+3xtVeAuZrXIqzvJ9lkfMGPuxx8F0UdRg+bwz5L
         oiRVkR4XN51F5C77ntXfNDB8ckRewCgCFwOsESFA0gcei9V5wrt7TvO2VIIHbw+XRxjx
         DiNelUPu9wnRiDhxqCAYfR7gXULPceBoVIDDhuOjEXRUoNDw2tHP8t3eOPQDDX8x2CPG
         Tr0g==
X-Gm-Message-State: AOJu0YwfDWM0+2nwqjE5ShbeLVSrDLO6G8sWcIL/ucvKowxZJ2XTcTmW
        Docq0cRHZHdfvU5psWVet/RSBw==
X-Google-Smtp-Source: AGHT+IFn+3AwcxfCceLAeJPw+uVKytit2Yc1k7eETIMBnv1PTC1MyLerbBnm/iqfTL7DAhdHs0W3DA==
X-Received: by 2002:ac8:5911:0:b0:412:2dd3:e0fb with SMTP id 17-20020ac85911000000b004122dd3e0fbmr3222450qty.5.1694183418289;
        Fri, 08 Sep 2023 07:30:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id x19-20020ac85393000000b0041511b21a7csm64615qtp.40.2023.09.08.07.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:30:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qecUx-001IWw-RI;
        Fri, 08 Sep 2023 11:30:15 -0300
Date:   Fri, 8 Sep 2023 11:30:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH for-next v6 6/7] RDMA/rxe: Add support for
 Send/Recv/Write/Read with ODP
Message-ID: <ZPsv98Mr6ogzchCL@ziepe.ca>
References: <cover.1694153251.git.matsuda-daisuke@fujitsu.com>
 <f15b06b934aa0ace8b28dc046022e5507458eb99.1694153251.git.matsuda-daisuke@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f15b06b934aa0ace8b28dc046022e5507458eb99.1694153251.git.matsuda-daisuke@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 08, 2023 at 03:26:47PM +0900, Daisuke Matsuda wrote:
> +static inline bool rxe_odp_check_pages(struct rxe_mr *mr, u64 iova,
> +				       int length, u32 flags)
> +{
> +	unsigned long lower, upper, idx;
> +	unsigned long hmm_flags = HMM_PFN_VALID;
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +	struct page *page;
> +	bool need_fault = false;
> +
> +	lower = rxe_mr_iova_to_index(mr, iova);
> +	upper = rxe_mr_iova_to_index(mr, iova + length - 1);
> +
> +	if (!(flags & RXE_PAGEFAULT_RDONLY))
> +		hmm_flags |= HMM_PFN_WRITE;
> +
> +	/* xarray is protected by umem_mutex */
> +	for (idx = lower; idx <= upper; idx++) {
> +		page = xa_load(&mr->page_list, idx);
> +
> +		if (!page || !(umem_odp->pfn_list[idx] & hmm_flags)) {
> +			need_fault = true;

Again you don't need the pfn_list and rxe should perhaps ideally find
some way to disable it since we store struct pages in the xarray.

This could also be a xas loop

Jason
