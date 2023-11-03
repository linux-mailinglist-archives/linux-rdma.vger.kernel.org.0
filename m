Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A647E07DE
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 18:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjKCR7o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 13:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKCR7n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 13:59:43 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1F219D
        for <linux-rdma@vger.kernel.org>; Fri,  3 Nov 2023 10:59:37 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41cc75c55f0so28009881cf.1
        for <linux-rdma@vger.kernel.org>; Fri, 03 Nov 2023 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699034376; x=1699639176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLQVop9BWjUwlet0sxdAZYNmSmtsMsjIfXOOLsgYfMo=;
        b=QeuK16zfte4QYRQirCx78M+jgrEspXgZv2hjtm+EkIWiH4XosLJBJZAqV4TmOH+oow
         gCcv8kHOiXo9F251XqoK1gW/G0pk8iEYHmgm3BrXW+apDEutnDbPxW4KzOrnqMHXNXUC
         xICkgNwXod7PP612yXl3ULjBEagk0UakmeIr0D6oQI9YJENykquU943EGgaDjmWHWicV
         I/+tUYD3eyk3eFSijiGJsdePuSFckj2MIBUvO6wk0huKYc0DPvxq92QY3jnvqHYHACbA
         wK3xzsk/eNb0Nj73NCRiPHBM1BUl525nGldf4MNFmloffWmmfaYXRW7T6xGDqNv4I+Ck
         wPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699034376; x=1699639176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLQVop9BWjUwlet0sxdAZYNmSmtsMsjIfXOOLsgYfMo=;
        b=SgaQubCoQsRFSQ7Gy04uMMPEJmSyK92vn8KKqdg5eCbYMdITesvXmzFCTHlT6DUxK1
         q2zKV1F5UfM0YOhapNO/7H5+MI9YcwMFnNppBG4BvZVjcV6XSudVF6MQFJoQ02phW1PY
         6yXS9Bq8w9I27+SojGHt1zHDeBUYGGuhe6nHWwH8xclEho8OPbt5n4wzuXeJMjetpph9
         9OaWWzahZS34njl0kpcKpqL2Tr9Eu7vUarVGL9vmJAW0v8NsXJ0QFg8GBLnhpn6jhW3a
         4JRSV+OEiuB586O++Oa5pJ80M6ZPHr4RovsEgTDwaddsNh5G3/139lzAHR9FOvE+u8wa
         s3tg==
X-Gm-Message-State: AOJu0YzwxTKGzWUK/FBw7RcGGtTeup6Qh+V11lM/YwA1RsJse5NqDA/T
        WG2OZoAz8AAzkHr39+4FmfMWGQ==
X-Google-Smtp-Source: AGHT+IHiLilJRSwMyQJLW4e7W6dbViioPiugJYfiEe0r+fuzHFj3mRpPh+Kh1oLGhh8+FSwoIyIFvQ==
X-Received: by 2002:a05:622a:1b86:b0:403:f389:5793 with SMTP id bp6-20020a05622a1b8600b00403f3895793mr5109248qtb.32.1699034376580;
        Fri, 03 Nov 2023 10:59:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id jv12-20020a05622aa08c00b0041b016faf7esm902626qtb.58.2023.11.03.10.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:59:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qyySF-000vzr-25;
        Fri, 03 Nov 2023 14:59:35 -0300
Date:   Fri, 3 Nov 2023 14:59:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        yi.zhang@redhat.com
Subject: Re: [PATCH RFC V2 4/6] RDMA/rxe: Use PAGE_SIZE and PAGE_SHIFT to
 extract address from page_list
Message-ID: <20231103175935.GC4634@ziepe.ca>
References: <20231103095549.490744-1-lizhijian@fujitsu.com>
 <20231103095549.490744-5-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103095549.490744-5-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 03, 2023 at 05:55:47PM +0800, Li Zhijian wrote:
> As we said in previous commit, page_list only stores PAGE_SIZE page, so
> when we extract an address from the page_list, we should use PAGE_SIZE
> and PAGE_SHIFT instead of the ibmr.page_size.

The concept was that the xarray could store anything larger than
PAGE_SIZE and the entry would point at the first struct page of the
contiguous chunk

That looks like it is right, or at least close to right, so lets try
to keep it

Jason
