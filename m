Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D014631EC23
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 17:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhBRQRI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 11:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhBRMyY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Feb 2021 07:54:24 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8940C06178A
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 04:53:41 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id x14so1916781qkm.2
        for <linux-rdma@vger.kernel.org>; Thu, 18 Feb 2021 04:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fIBHs3uIaIrZ1r/oz3ZFJv+kCN5eLCqMPFM6E1WpJOo=;
        b=C6ICp2ngUiE27gx2c2CfR1GlvytWlF/5nH9jPIqvWqQXso2cWj8zIOlSFAwlQ9y76p
         Q5T4VNoMnSQsp4CB2v1+L78V6dsu6lGw5qnMwdLer7B9/KWO5w1uD0aMPQCydV1tCyU9
         qkf7ZFAFzkY0LGAlPvyJPP+QbVTIdOjG2uqaDarj38FbxP0OGEqciG64KBFzj09pY2qu
         n+78B3FogQVOqpGDDV8/AhU9HR/zump1JNdUUHk3zVSxumj/mOayS+x3APPMCfOPBq84
         R8ryRkoHX7z3NGywq+wYpBrLnkCyoXdKRg4vz1+RtOKwd3sArOZenEIHRvot1QIlLbWL
         Yf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fIBHs3uIaIrZ1r/oz3ZFJv+kCN5eLCqMPFM6E1WpJOo=;
        b=jccJ30ICgJpQy8NEFOAPoKernJYJkIr8OOyWUaUCnipkNZxHrpiOMuYm5iWPPsWCZ8
         V8arECgSpii1saolGIoScMIYdN67hvbqGShMRWYPjRKcUnGVSz0TcjZtA1sPg60cK5kM
         iY8oSmib+BWas/NfBYfOtFsyhSaevPMk47VQGhWfOHfdlebVpRYyclcT7+4SDirJpZh8
         ZPum/cbfyq3qA9XW0vkK4pfR+1H+8cKRa7aFroWcqySCWjz4ra3FfyOp69kapmZrTXq/
         lKCq5yh0jc1ZB+dDdAxIesimq88Vc7ugWQZsFdDLiw3/g3cdE3M8H0xdYfmPprMjWCfQ
         Ip9w==
X-Gm-Message-State: AOAM533MSCkxqpJVnD9c1fdLTdP8szfJf2s48N4nzlRilSwG/SV8fgE1
        V1Vosj+v7Xo5kL0F30XSiy3qnw==
X-Google-Smtp-Source: ABdhPJxydS22q/gQdU8EquBqp9GVY7RKQEev0SR1P/rihZZlIl348EenB6ZQVdmML3c8TNCQShOvzA==
X-Received: by 2002:a37:4c09:: with SMTP id z9mr3933634qka.9.1613652820952;
        Thu, 18 Feb 2021 04:53:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id l32sm3223203qtd.95.2021.02.18.04.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 04:53:40 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lCioN-00ATOW-Qv; Thu, 18 Feb 2021 08:53:39 -0400
Date:   Thu, 18 Feb 2021 08:53:39 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ibv_req_notify_cq clarification
Message-ID: <20210218125339.GY4718@ziepe.ca>
References: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd5deec5-8fc6-ccd6-927a-898f6d9ab35b@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 18, 2021 at 11:13:43AM +0200, Gal Pressman wrote:
> I'm a bit confused about the meaning of the ibv_req_notify_cq() verb:
> "Upon the addition of a new CQ entry (CQE) to cq, a completion event will be
> added to the completion channel associated with the CQ."
> 
> What is considered a new CQE in this case?
> The next CQE from the user's perspective, i.e. any new CQE that wasn't consumed
> by the user's poll cq?
> Or any new CQE from the device's perspective?

new CQE from the device perspective.

> For example, if at the time of ibv_req_notify_cq() call the CQ has received 100
> completions, but the user hasn't polled his CQ yet, when should he be notified?
> On the 101 completion or immediately (since there are completions waiting on the
> CQ)?

101 completion

It is only meaningful to call it when the CQ is empty.

Jason
