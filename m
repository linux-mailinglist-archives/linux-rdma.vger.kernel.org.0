Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D26487986
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 16:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiAGPG7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 10:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiAGPG6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jan 2022 10:06:58 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C00FC061574
        for <linux-rdma@vger.kernel.org>; Fri,  7 Jan 2022 07:06:58 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id hu2so5693147qvb.8
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jan 2022 07:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hYQYhHsHAJbVMukLcg8X2QT5IbqwNlKKTDW3wITnjcI=;
        b=K3ijA6ZRvWYYCFTqERxGYrUDB2/b1mzEoDOUtWANomQcdsP6/CNs9U5Z3Z4vhOt67D
         PbRCXvWCAB9edMVRsaoXU5vqpiNlDKL2FCwxJIoZK7w2ECHtxIxd6BG2ZX7NnJ7T9+Pa
         JNaAXMh+SrHO/Wo2JGFGSruE+MQbGqLnQDo1c2U/bYMah6NXFS/4LDsN4Cq8uYKA13Kd
         2jg9yJjuIfGlBrgqSnaL6xRKYQCN0FjpEPgzf53xCTm5RRz6/OwqLJO9jqJ6HjNWJw9T
         5eUdtb4Yrd7q41zSxtLoyIeQyDv4rfJ3EOJNOquoSxSwGXn1YZDpyplyQIyOEzn1S41k
         6+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hYQYhHsHAJbVMukLcg8X2QT5IbqwNlKKTDW3wITnjcI=;
        b=24+c6T6yScqYtiwWfoACKXwJeHJPKD/nKKvvx5O7terZdgrn5sVpLv0RpZ2r31I1qU
         RXb8qD/zmR3embfiMQPCfSB86F9NmGuTMZFSLQOwrRd0dGNXQcZmgDTVZ1W/E1Cu5zDP
         J62BoZInaMGdv9b6gySF0Rty7Cw2RHUQl1wZPx4tYSlOsy5k7HcI0kEskzdD13aOcukI
         dfYFdoaOvxgRaN7iB7fGz0Ts01R8K7qVpPRjWspDkSqfqi/sRWyjhSPUaEubNMl5CBBG
         hOKUyEOXAwlPNu5ZoeNbD1aNxLR+KY1mFoQsZTHe4zrPNE6dLXUmrU83Y0M64wQQtGnA
         kJ7w==
X-Gm-Message-State: AOAM5303JhLX5ReaFOlZdveWzUTYIsjkNa+gDoHs30tSTiA0dQVmmj3i
        ZDcYsN8EY9PYSctf1dXMW1FuC8CHK97N+g==
X-Google-Smtp-Source: ABdhPJy2SKzQkjjb7oBYa+H2fNaJNcu2BS2Po0Mh6LtrZsSdz/T/5STQNuCDRH/JNjsF8Q11+jC7nQ==
X-Received: by 2002:a05:6214:20e3:: with SMTP id 3mr56744351qvk.25.1641568017199;
        Fri, 07 Jan 2022 07:06:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u8sm631923qkp.45.2022.01.07.07.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 07:06:56 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n5qpT-00CxKf-W7; Fri, 07 Jan 2022 11:06:56 -0400
Date:   Fri, 7 Jan 2022 11:06:55 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nelson Elhage <nelhage@nelhage.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: rdma-core: ibv_dontfork_range should not round up to page
 boundaries
Message-ID: <20220107150655.GZ6467@ziepe.ca>
References: <CAPSG9dZ-dkWPcbXECQeZyvOHu7M+vfrX+jJDe+fxY6_iSnQyKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSG9dZ-dkWPcbXECQeZyvOHu7M+vfrX+jJDe+fxY6_iSnQyKw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 03, 2022 at 10:26:32AM -0800, Nelson Elhage wrote:

> The proximate bug here is arguably in the libiverbs clients that are
> making the problematic registrations, but I'd like to see libiverbs be
> more helpful here by rejecting non-page-aligned regions, at least in
> fork-safe mode. Marking memory we don't control as `MADV_DONTFORK` is
> *always* incorrect behavior, even if most of the time it may not have
> immediate consequences.

This is a huge ABI break.
 
> I expect this change could pose compatibility problems for existing
> libraries. Potentially it could be rolled out as a warning initially,
> which would help surface the problem and correct downstreams, as well
> as making it easier for administrators to debug this problem.

This is all fixed in newer kernels and rdma-core's. Talk to your
vendors, upgrade, etc..

Jason
