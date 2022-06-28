Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59F55EA0A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 18:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiF1Qk0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 12:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbiF1Qgc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 12:36:32 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A037202
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 09:34:48 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v6so10145010qkh.2
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ajFMkRZokrw9ugT5p3XPxnQW7RqcMO0j+zWL5z2QfjA=;
        b=NBpqwfsPYfyGcOD6KE/NTU71hiUeR165iGlwvXJ9JuStO0xEapX1df0SFEQEGGqd6w
         hyHo+zNt3KEJGKD2cPWBGKZwprQaoCmmdT3UhhPkHwbFiKgwbcWvxrfWqbQqh4WdkxWU
         2RdXCO5eUM2rhOiY8cMZJeNvwfy46HDc/EVxDBfRP3yDgRV5hiOBMgQOuWwUiM/yLB75
         V3fgkw1AXjjH3pJEA6pHW//WHL8EQ9z0J9zpXag2bp9+raZHYXyG7ltaWsjuszgGyCZ9
         9vmZERO60OjKkUWVhGHEDsg3HJu/jTnDB6P66s/Dx36aawtyo30ZVfReqtOoobL2LEu1
         nNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ajFMkRZokrw9ugT5p3XPxnQW7RqcMO0j+zWL5z2QfjA=;
        b=Qjp435oShGMqPvea52flUnGVNEc/RdTflSYbS8UrhagvjkmX8PPVfgnzGWMG/UAXdj
         U+rEXPSojNfMqj5ZNTNVtaCt+PSdsF4a1kebT8slVDj71JbUkSY/fphfmuRwo6pQa7XL
         aR6wJZ0/rw1c2M6scoh9WbXiezGT8qvd2Flh7VzImJlTbizeVIU0WtRv4b2k+7uT1c7L
         zT0EFtkZUHlKcBBN0i0BmXpEw2CVE16L0dCRRlrEIWAazX3lXXcTi67UD+Z+wcV7Mahj
         usNXQTEYR9X8uceGsBQ00Ft+bYGAXyU8IUzVAYK5HR/yvMytTuiljktYBUSoAwLZTPxs
         IkKQ==
X-Gm-Message-State: AJIora/UvsM97tk6uXEJiPdYtI2tLMkpvDG+4lHftBKXmTRMtVMBmlZu
        eeb+01WVWY7VxbI8bdfmG9X2uw==
X-Google-Smtp-Source: AGRyM1tOGiGj/4K/VP8Bp37n5DUri/AqOLYrBaFR2ZTCLxD9FgRvYQ+sCBscDV8VFYUxrhjLzhqivw==
X-Received: by 2002:a05:620a:2584:b0:6ab:91fd:15dd with SMTP id x4-20020a05620a258400b006ab91fd15ddmr12058691qko.287.1656434087624;
        Tue, 28 Jun 2022 09:34:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id o6-20020a05622a138600b00304dd83a9b1sm9577551qtk.82.2022.06.28.09.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:34:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o6EAo-0032Tk-6X; Tue, 28 Jun 2022 13:34:46 -0300
Date:   Tue, 28 Jun 2022 13:34:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     haris iqbal <haris.phnx@gmail.com>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote
 versions
Message-ID: <20220628163446.GQ23621@ziepe.ca>
References: <20220609120322.144315-1-haris.phnx@gmail.com>
 <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
 <CAE_WKMy-rGgh_6_=OY_77pXNmV73tmww18eb4+XLpp_DtyASdA@mail.gmail.com>
 <20220624232745.GF23621@ziepe.ca>
 <CAE_WKMwcV_QFyN1j8Mb74-Nxg7V7j1V9M+16OxphUWYAU9m9GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE_WKMwcV_QFyN1j8Mb74-Nxg7V7j1V9M+16OxphUWYAU9m9GA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 28, 2022 at 06:21:09PM +0200, haris iqbal wrote:

> > Yes, no driver in Linux suports a disjoint key space.
> 
> If disjoint key space is not supported in Linux; does this mean
> irrespective of whether an MR is registered (IB_WR_REG_MR) for LOCAL
> or REMOTE access, both rkey and lkey should be set?

No.. It means given any key the driver can always tell if it is a rkey
or a lkey. There is never any aliasing of key values. Thus the API
often doesn't have a away to tell if the given key is an rkey or lkey.
 
> PS: This discussion started in the following thread,
> https://marc.info/?l=linux-rdma&m=165390868832428&w=2

rxe is incorrect to not accept the lkey presented on the
invalidate_rkey input. invalidate_rkey is misnamed.

Jason
