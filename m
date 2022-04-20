Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F012508D82
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 18:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380681AbiDTQoL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 12:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353698AbiDTQoK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 12:44:10 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FB31C931
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 09:41:24 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id y19so1729159qvk.5
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a0xAdyTd3UEGCCIxMuWK2NQGNgRm5FZ0wW3W7rwBTJQ=;
        b=bjPsUEnt9+TL91IV1vmLMm0cP8q3ah4fNKBZHL+2WMcMHEUalYHys1pJLeDRNs3NWS
         Q1VmJpyAnhd1Q47tr27SGja/9pl+ljj2PvouLWQGZVo9C9sMLRrd98DVJ6ia0i2/FqgA
         u5Ax7NeLDrnIIP7otHcYH1ByXsdQD7bWdDN7DDXbCYmJUmKEMYzQl66Ph1QKE9iycEt9
         L3H0oRcy5ZrVWyYwHTKPYUKnI3lZE+P5RgIe16boragtRrqsjY+XMizqEhtahJlm3uuW
         ER9EkGOVqL2RbKiS0RTT58ye1nF8ps6QOHZbx1H9qim4Yyhau317fxas0ZP1+UVJffYp
         ihXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a0xAdyTd3UEGCCIxMuWK2NQGNgRm5FZ0wW3W7rwBTJQ=;
        b=crqeDLPe+W4aBIVfYoGrscQACgI/48caLBmWFVFdryGfmBYjBXpLP5GSqZrzA6HkmU
         kfP7CpIxiF2AwWGsyOtXpnVixrF7xNleDacO+q791s9U760brvH3Dhq2bCI0oZLqhJb3
         5+ziFPs1Cp2QcxxP1lbXRkbgerhiaLfFg2fFyI57K33CGJkbxtAsPHBDYNtSQg9iaTlc
         peZ5Aud13W+UTGz2UnunET0hqQPjR4uOp1KqUPAnAl8b5ajgXKCE5iEEPP+/hVa5xsKk
         ubMwW6q7UlNxJZIInFbOBQF9pb7u/CkvG+nFRgNWw6fpRNx9R3/nM9H7nK6C9bRIpfe5
         9Jdg==
X-Gm-Message-State: AOAM5335hwc7h7c+gniihjEfx2+gi4wSXuQL8cPhwQgdd24ddXUAAnRS
        m1dQSNIgn3XsjUe5+VgdgmO1rHrgvrPy9g==
X-Google-Smtp-Source: ABdhPJwuEBXiB0s9B7PJB7qbWeygCok9EwT+S4QgEUhh1IxSoNtnW8Vpgt48BTeBV9ugp52LMoCi+g==
X-Received: by 2002:a05:6214:20af:b0:446:787a:e748 with SMTP id 15-20020a05621420af00b00446787ae748mr6115896qvd.79.1650472883527;
        Wed, 20 Apr 2022 09:41:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q8-20020a05622a04c800b002e06d7c1eabsm1958684qtx.16.2022.04.20.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:41:22 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nhDOM-0061UJ-6Y; Wed, 20 Apr 2022 13:41:22 -0300
Date:   Wed, 20 Apr 2022 13:41:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCHv4 1/2] RDMA/rxe: Fix a dead lock problem
Message-ID: <20220420164122.GS64706@ziepe.ca>
References: <20220415195630.279510-1-yanjun.zhu@linux.dev>
 <e217ab50-75ff-9112-e492-a70cca50759b@gmail.com>
 <0d88246e-c29a-27c0-95c5-da73f52e6a59@linux.dev>
 <726e75b0-c165-92f8-c367-1a5a777bc8b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <726e75b0-c165-92f8-c367-1a5a777bc8b1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 15, 2022 at 01:35:58AM -0500, Bob Pearson wrote:

> I mean the trace you show here shows an instance of xa_lock being
> acquired from the pd pool followed by an instance of xa_lock being
> acquired from rxe_pool_get_index from the ah pool. They are different
> locks. They can't deadlock against each other. So there must be
> some other trace (not shown) that also gets xa_lock from the ah pool.

This is because lockdep groups locks by allocation point into the same
'lock class' so as far as lockdep is concerned the AH and PD's are all
the same lock and you'll get reports like the above.

The same issue will show up with AH only, you just need to hit a path
that allocates an AH from a process context, like uverbs.

Jason
