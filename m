Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C357860B4C5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJXSD2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 14:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJXSCr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 14:02:47 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7F2BE24
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 09:43:27 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id d13so6409480qko.5
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQUAOIAwlBb1Ac+IMwvAIs+PccHrMcnmJEUvE59sduo=;
        b=jewwKjOp110j3RCbj7CHLjBE8dKB97kT3YOWZrJPH+I0aKVAMllj00IyW4LjSUObNq
         xZxAev3oxd6QAV4hE5YaXUEwQ94oeJowwRgOVnBVYCVeLA7+SgH23Crl+teu7+moouXr
         gfuNjRMaQKPr6BvDDAGWe6LVGeKCG8OaK80wRHJUeGWx6m0v2AdBntfj/jIHl2MmQb9n
         mm8j4G9pPI7B2/mhfoyv1MaZ6w8ykxNfmPwYLQHr9h0ZLbQq4ZWPG3HllMuO/v4hz27Q
         6gbNQv12/D6WvhnQQUceQqVe8ihCDkBq5rmJBdOlJce/N4Nz7zGsAJlwQp0R9/ienRWm
         brBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQUAOIAwlBb1Ac+IMwvAIs+PccHrMcnmJEUvE59sduo=;
        b=0HoB6SPz2Ekyy0+dHYsbuG4FoWa5Rwoszve9jgNHPbqJ4XPBdPsaUSONmRBvFMECgc
         n71iWSpmm/LReEm4SCZ1Q3EWwxCvN6yRsG/pjhYbMOoyG2mzKqANVxAmqpK8HemZb6cs
         +60RgSYcXdN4wnfI8bBldX6zWtxMXioyHfZfhTp7iF09GUfu2AyMUDhT+60r4pnGbc5/
         DSLmM0BpLF9HbHofZTH304Eg5Yowc7mexY+Vo4YUZtNEMP8Fq2SVRjaGhHsItjkmlgbU
         c5lH9dkDG5shkR2C7nBRUQ5iOlpYiyeGhjWqRbhxS9MkQ8WmNQf+QW4wk8uRy5ezUmHi
         pWNg==
X-Gm-Message-State: ACrzQf1VKVIjKx4+fZqtPr0EsjOkXYQLWP3VUdjqAAy6Frqzeq9pETpj
        CDa8TFsuQszfsDtYSMGDYJ7QPg==
X-Google-Smtp-Source: AMsMyM4MXMW3GmPJvEEh/mqAM/OPAdIuvpMk9/nnN9yyv8FxhAGbMQqjRxi5gOjjZPTaf43M0wJ8fQ==
X-Received: by 2002:a05:620a:1a82:b0:6ee:d1b9:95b7 with SMTP id bl2-20020a05620a1a8200b006eed1b995b7mr23057529qkb.128.1666629691890;
        Mon, 24 Oct 2022 09:41:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a29d100b006bbf85cad0fsm275754qkp.20.2022.10.24.09.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:41:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1on0W2-00DXTk-FI;
        Mon, 24 Oct 2022 13:41:30 -0300
Date:   Mon, 24 Oct 2022 13:41:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Zhu Yanjun <yanjun.zhu@intel.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/3] RDMA net namespace
Message-ID: <Y1bAOn6/p/TGDvV+@ziepe.ca>
References: <20221024011007.GE63658@linux.alibaba.com>
 <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <e4b62ef709c43ff7425d9a02efaecc5c@linux.dev>
 <20221024115228.GF63658@linux.alibaba.com>
 <662d6804-0e16-117e-d4a4-9abd4a2e8c75@linux.dev>
 <20221024143521.GG63658@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024143521.GG63658@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 24, 2022 at 10:35:21PM +0800, Dust Li wrote:

> For the netdevice, that's true. But for RDMA, we should not even see
> the ib device in the containers any more, so I think we cannot create
> qp/cq, and RDMA is not available for these containers in this case.

Correct, in shared mode the RDMA device should only allow using GID
table entries that have netdevs that are present in the processe's net
namespace.

This is, in general, the philosophy. The user is supposed to keep the
various devices in the namespace in sync, because the kernel cannot
guess what is correct.

Jason
