Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC5F244EAE
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Aug 2020 21:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgHNTLC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Aug 2020 15:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgHNTLC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Aug 2020 15:11:02 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85423C061385
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 12:11:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a15so9221578wrh.10
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PRu88AJhldS1lNC0c30yIgBUYGYlLLRszggUHMMkPo8=;
        b=Xs8bs92lB3HwFxqZ5/GwxZYFl0PImsE7MC+giGirkNIuf9u5BX/GLKbzn3ySBgPVus
         R/9pT2EKH+MwJL3XZQbyBGU3E3jzuUDc3Zzp06Gz0aCGEu3uhhjr6FL6/KToEHKihUYj
         VT2Vo4ZK/T1DomTO0OkOpcj0z3HIwwYqLAL0ccqe6Wit+UGlaXqEhNLoPD8YbUqS3UUd
         sn/Vb2xcUK23EFCzQGcv4XTSLrPyxLyVFMsden5cz7m1/K/hRHxgZcK7x2Vzs+Vl91qD
         qeY4mOMIadcygpiGTWubRpBvpEQNwzmYbbIYw3I5ZU45OWVELHYbbcVd2LW7aYqZScsv
         oQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PRu88AJhldS1lNC0c30yIgBUYGYlLLRszggUHMMkPo8=;
        b=ZmzSsToZftaAwu4VcZ3LkRNBGUwX94kSA2BCSQlPRtl7OM1rGtAlyLMyUP081XrumT
         i3AHFyU1ecYttwqCqQdRtn2XB0MbDYbM6QTPyOYBuXg3UD79kHFJWEfkBz8oMpU6KEuy
         hyX/gYoYAgw5WVkaVAKbWYLdNFwZe0cseLXsFzEhJpJ/8o3J8s54uD5d4BxS01Kl9GaQ
         K/cF0PgeLE7lIZHrgpoMpLI3CzIsj1G/Ge5VdthfCRum92Uk4tCMjqAQJvg39NQTFj3q
         9tAgl9DG1nvadxo1gBHLM8r1fpsOycCkkpn/xVRIM1aLsf1zcGx+UtHuEH6Z43ML2JWg
         0gfQ==
X-Gm-Message-State: AOAM532gl9himcCFFy8EGz3E0HCXYzrywBUvAd3j97Ib2GIuT/EF7nGW
        CmTeFK30t9nqpgL1J5DXmA8+lw==
X-Google-Smtp-Source: ABdhPJzdi0k25GA/hzgBdCYsuX1cEq85uobtkZq+Bl04RFC42zBj35CJEoPMAjxTSi5RLETkUBxgCg==
X-Received: by 2002:a05:6000:124c:: with SMTP id j12mr3927859wrx.83.1597432260125;
        Fri, 14 Aug 2020 12:11:00 -0700 (PDT)
Received: from gmail.com ([141.226.169.176])
        by smtp.gmail.com with ESMTPSA id o2sm15786868wmh.5.2020.08.14.12.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 12:10:59 -0700 (PDT)
Date:   Fri, 14 Aug 2020 22:10:56 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] xprtrdma: make sure MRs are unmapped before freeing them
Message-ID: <20200814191056.GA3277556@gmail.com>
References: <20200814173734.3271600-1-dan@kernelim.com>
 <5B87C3B5-B73D-40FD-A813-B3929CDF7583@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B87C3B5-B73D-40FD-A813-B3929CDF7583@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 14, 2020 at 02:12:48PM -0400, Chuck Lever wrote:
> Hi Dan-
> 
> > On Aug 14, 2020, at 1:37 PM, Dan Aloni <dan@kernelim.com> wrote:
> > 
> > It was observed that on disconnections, these unmaps don't occur. The
> > relevant path is rpcrdma_mrs_destroy(), being called from
> > rpcrdma_xprt_disconnect().
> 
> MRs are supposed to be unmapped right after they are used, so
> during disconnect they should all be unmapped already. How often
> do you see a DMA mapped MR in this code path? Do you have a
> reproducer I can try?

These are not graceful disconnections but abnormal ones, where many large
IOs are still in flight, while the remote server suddenly breaks the
connection, the remote IP is still reachable but refusing to accept new
connections only for a few seconds.

We may also need reconnection attempts in the background trying to
recover the xprt, so that with short reconnect timeouts it may be enough
for xprt_rdma_close() to be triggered from xprt_rdma_connect_worker(),
leading up to rpcrdma_xprt_disconnect().

-- 
Dan Aloni
