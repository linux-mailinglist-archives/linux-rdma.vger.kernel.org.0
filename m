Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5202A742A02
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 17:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjF2Pzz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 11:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjF2Pzu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 11:55:50 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83A335A5
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 08:55:49 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76728ae3162so73774385a.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 08:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1688054149; x=1690646149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MmuCu9mHYiJDkmMldLMvwModVEF7nAvRq0D8pDRfktA=;
        b=F1WXio4rGIeCn35mC+D451WXDv45KSiy/bySr4gxQcmVa72vN6GasQ2sc8E5tOYzv/
         iphxykRc+M3rUQhpfpXb0ImHpv1SpXMfppayq9Jugd2S1K51VP7PovSc1mraxktZdHYE
         /30Qjk01BX8hRTW5IZRA5I8X1+mGBVknLvat5wP/KbE8VCv6vj9bYSph5gr36nGk4IKX
         9kVW3ouOZcklfcMkXrYrc2FtH7NWJruSnHb3sjW59ElHjqHbhGuOoIggHStMmDzeLgV9
         /j9RDM+t9R7+Sb3s4XKczUTCDCicF/3Q6Dp1VftTc9LZxU6dNKFFJUFGVLbCTSP/d1fy
         01lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688054149; x=1690646149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmuCu9mHYiJDkmMldLMvwModVEF7nAvRq0D8pDRfktA=;
        b=Qyasj5atHJZjhrwfCOF8gPZA0v3JLs4W3kbn5lSD1v5VdXhp+zeJsZfj3HULVlZetp
         DeXV1f0DN1QXOy98ms2QYIs1OIzkXJSq4Vc9ZUZwye3Mt1EIUPZf6ZWH+E4R/r2okpAG
         XYgQlGCeUWzCxYKbY2HJtspsdjeiktfrKXWjbdiUI/etXO/mkDLgFluulFIKCuUXwJBz
         S5cx4FPlY/JElylh9QiQ90q06YNGFr9RquC7484otNYq03h4xJdkPQuitv8pTZnTzc5h
         nwnuK3PuU5gmCE5L39HctYM4qw+As8j/MRzxGpQ0QrtMsb8ofpC6qJye1B2Ev04QzUh1
         2pew==
X-Gm-Message-State: AC+VfDxCAJAZg5YyXt+mWY57w7ri+4R1Prvedfl/Yh15bI8vLD/irB2O
        8HahpGa69Aj7hEypyfMJfT9/xQ==
X-Google-Smtp-Source: ACHHUZ7RWfuY+qHs7Eijw1yy8e/xuC55o3nJ8io0l3k/jjRRGO4IxiqIhSe3sY7fzRWEZq8pbJnT/Q==
X-Received: by 2002:a05:620a:4cd:b0:767:2d6a:c8f5 with SMTP id 13-20020a05620a04cd00b007672d6ac8f5mr2850399qks.13.1688054148789;
        Thu, 29 Jun 2023 08:55:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id z22-20020ae9c116000000b0075c9e048b19sm6363508qki.29.2023.06.29.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:55:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qEtzn-009tYx-O7;
        Thu, 29 Jun 2023 12:55:47 -0300
Date:   Thu, 29 Jun 2023 12:55:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vacek <neelx@redhat.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Rogerio Moraes <rogerio@cadence.com>
Subject: Re: [PATCH v2] verbs: fix compilation warning with C++20
Message-ID: <ZJ2pg52rmRhf1SBp@ziepe.ca>
References: <20230609153147.667674-1-neelx@redhat.com>
 <20230613131931.738436-1-neelx@redhat.com>
 <CACjP9X9T_HbR5Up4zx6xUJ3tE=HzXGE3WtRiRZNDES3f-1ou1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACjP9X9T_HbR5Up4zx6xUJ3tE=HzXGE3WtRiRZNDES3f-1ou1w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 29, 2023 at 02:41:16PM +0200, Daniel Vacek wrote:
> Bump.
> 
> Was this forgotten or overlooked?

No, it just has to be processed manually if it is not a github PR..

Jason
