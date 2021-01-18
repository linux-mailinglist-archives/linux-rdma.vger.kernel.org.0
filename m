Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98F52FAA97
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 20:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437666AbhARTul (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 14:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437662AbhARTuL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 14:50:11 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8319AC061575
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 11:49:31 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id l14so8066991qvh.2
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 11:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JsXrRxwX4Ihy82+cpBIV1dM0HTdGoCQx+Xj3M+InpDQ=;
        b=golZbkSPtyEEby7hQbkus5qmO8Z/T1CiupAtIFBtNYS9N8VEmlvSIs2kHpT/5evhYL
         1dQJbVWDQ7euR0A/LRJEyF5PPiuatrULPYtcYmwAw5V1Cj2J6+x2SHg9cGFgZWjGE9dh
         fu/VdUJq6hXNfQFIDYuHdK64b3x0U0cs7Gijtj0Yvc6U12gb9aeVAKCS92lc2iWNRwwV
         Acqx9j9bfLQVdiV/umj2+pLUwL05zp+ayg4TApeusgtm5iW7ZbcoBE1E/Rt5ICnmBp1O
         PGi2T9uSqftYthlujxDhfzjoUW2du97mOGgepdEFAaRXEkJyWj4j715OBaQ22tllK7Li
         vB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JsXrRxwX4Ihy82+cpBIV1dM0HTdGoCQx+Xj3M+InpDQ=;
        b=RYmrC948UZta50fdFLTZ0dXC++o2bTycT5YwisStvuB9BNp8yBwZ416ngRmDzb1Z6j
         2iafb64BUBIws/r8EGEQExIKEVnYcvLeJarpOdFsVpq8JKL9z/QP6IAcEkonQ3xOyZXw
         v/mEK4xMSs6vTvn64PeJZAalHHCk/lcdWklIRPcMTlE1gflTekBg7MfCk0piUfvLPPl5
         q1EQ8Mg3dwA7A7IVfHxELF5DlM724QdMbzbA5nnwu33S1LgB1kqwWKdRg7GG7RZZRhHF
         KbKtOw/HZUvXzBUSPiSjt7XsvsHWQkXd4Qvtk2bEIFvkcbcxvCgLzMwZtg+agjqTx2e3
         qmeg==
X-Gm-Message-State: AOAM5325cvkWd6x6GZRSi/BvA5PJPY3rDDaHLqg7wEGyYEtD+4WGQDNZ
        +KMwrcO1QLnW5TBni5da8ThSiQ==
X-Google-Smtp-Source: ABdhPJw7vQbTWWphTJ3i/i69+aC/fxAxYGVWVZ32XVC4uYKN3THDs21AiFcqMy3gLMNF3UDp7L+qBg==
X-Received: by 2002:a05:6214:14af:: with SMTP id bo15mr981014qvb.19.1610999370705;
        Mon, 18 Jan 2021 11:49:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id l26sm3516622qtr.36.2021.01.18.11.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:49:30 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1aWn-0033Im-PE; Mon, 18 Jan 2021 15:49:29 -0400
Date:   Mon, 18 Jan 2021 15:49:29 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ryan Stone <rysto32@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: mad.c appears to use msec_to_jiffies incorrectly
Message-ID: <20210118194929.GN4605@ziepe.ca>
References: <CAFMmRNzVPd-3SV=LQb+cKFj4yBB-BEvV1d3bmKeLxjcswZtD0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFMmRNzVPd-3SV=LQb+cKFj4yBB-BEvV1d3bmKeLxjcswZtD0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 15, 2021 at 04:31:56PM -0500, Ryan Stone wrote:
> I'm looking at how MADs are timed out in drivers/infiniband/core/mad.c
> and I think that the timeouts are just implemented incorrectly.  An
> ib_mad_send_wr_private's timeout value is always initialized like
> this:
> 
> mad_send_wr->timeout = msecs_to_jiffies(send_buf->timeout_ms);
> 
> This converts a timeout value in milliseconds to a relative value in
> jiffies (e.g. if timeout_ms is 500 and HZ is 100, then msec_to_jiffies
> returns 5).  However there are a number of places in mad.c that use
> this as though it's an absolute jiffies value.  For example,
> timeout_sends() compares the value to the current jiffies counter:
> 
> https://code.woboq.org/linux/linux/drivers/infiniband/core/mad.c.html#2853
> 
> This doesn't make any sense. In principle it should be fixed by
> instead initializing timeout as follows:
> 
> mad_send_wr->timeout = jiffies + msecs_to_jiffies(send_buf->timeout_ms);
> 
> but there are also a number of places that check if timeout > 0 to see
> if it's active and that needs to be fixed, possibly with a separate
> active flag.
> 
> Am I missing something, or is this just broken?

I seem to recall there are two flows here that don't overlap re-using
the timeout field for two different things..

It adjusts from one domain to the other in places like this:

static void wait_for_response(struct ib_mad_send_wr_private *mad_send_wr)
{
	mad_send_wr->timeout += jiffies;

It is so convoluted, so who knows if it could be right or not.

Jason
