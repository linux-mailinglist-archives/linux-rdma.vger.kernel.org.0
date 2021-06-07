Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E11E39EA4B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 01:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFGXqo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 19:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhFGXqn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 19:46:43 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91494C061789
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 16:44:51 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id g12so9835428qvx.12
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 16:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6XCJpSEDadig6sMG+TdcRvTIObt8/yYhSTOVOPCPdvU=;
        b=VbzBYubaVD4swOTb4rPS7L/p9xMaRhJuFVItELtgYh/ORMf1g5fvVelhNSA48Bh89A
         ZJVGc5N0mxVB5nqlpQkReCPPpCHrW0yUYV4VpEKpwFHVuyOihAx84mzKbflnNLCSZE1W
         rzp4ulkMUi20iRcF6psMlPxSVBmZ6gi67TWvm9p0bFUApzq5nkqtLzT0inK+W7E9M9H4
         5wWUImQ77qqlkwOQ/kcjdZ/bJebSkWWWus8q9qwJjTt/+z05cXbb/nYa3DK5wPmyaBvY
         HZ8VikomV53UDTlFWq0zVWjZrHN/Tvwor1m9O+4+7qcXEr6tirya8ogvTi48m4xtTDLt
         FWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6XCJpSEDadig6sMG+TdcRvTIObt8/yYhSTOVOPCPdvU=;
        b=sobr2uTi5QLrzf6cLueOpi0i/58ghvwPc1gi8c7A+cL7xngbpkcuF1iGhMvvLHJ4Ro
         4Wt9FPQUK0FFyPmJ2VpQh5hhheb+IHj5q3IJukOPbJgDpwG99KPKOh2ZrTVQ8QcWrMj2
         IwfRlsZsTGWEk7Gq1LT0xkVyjeFeE1146+F+mSF5874P0zSumqfnLChH35yyNBdLjMEF
         PlKCvFHuiYu4gSeqAX9XfbSlKLm/CE8umH9dUWk8uT5NtAMDJdeQnfl7E4fh6m3jBDb5
         LDz/vbDw5qngyPS0g0+aoRGVVu2pGQOdRk/oHixahc2UeYK+5FgSTjaCl2CJMoAMBKB0
         9r1A==
X-Gm-Message-State: AOAM533thjEgwMXdGYmMfVvvZcbf7MDN5Qbnjvc3vzQOJcjnGUPjHP9i
        xYAWCnn7RfaLyd12kxGesBOXtA==
X-Google-Smtp-Source: ABdhPJzZ7oHyaAgt7NfSCX9DX96GkWdRACUbNIvX+6PkpVmenL2OTjkGxU4L0pCUImVKNUN/0Ug2cw==
X-Received: by 2002:ad4:4783:: with SMTP id z3mr20454991qvy.43.1623109490775;
        Mon, 07 Jun 2021 16:44:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id w3sm10991844qkb.13.2021.06.07.16.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 16:44:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lqOvJ-003WaD-9Z; Mon, 07 Jun 2021 20:44:49 -0300
Date:   Mon, 7 Jun 2021 20:44:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, dledford@redhat.com,
        shayd@nvidia.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] infiniband: core: fix memory leak
Message-ID: <20210607234449.GP1096940@ziepe.ca>
References: <20210605202051.14783-1-paskripkin@gmail.com>
 <YLxbbwcSli9bCec6@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLxbbwcSli9bCec6@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 06, 2021 at 08:21:51AM +0300, Leon Romanovsky wrote:
 
> I think that better fix is:
> https://lore.kernel.org/linux-rdma/f72e27d5c82cd9beec7670141afa62786836c569.1622956637.git.leonro@nvidia.com/T/#u

Can you resend that with the bug report in the comment?
 
What is the issue? Some error path missed a restrack_del? which one?

And I still dislike that patch for adding restrack_del and undoing the
previous patch which was trying to get rid of it, but if it actually
fixes a bug...

Jason
