Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A1C2452AE
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgHOVyU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgHOVwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:52:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ADDC061235
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:45:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a5so10071924wrm.6
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+/aQPgBdctfCPkN2hsKPsv6boSaHaEN13UyN4xwV5wE=;
        b=MHKoo7DCs5fHWAvtff6EIY7D/hJHp24zHtuKEc/vJMN5VcYuVv8I/1uMI8uaPgjtcw
         bBMbE8FexiGLLFxMU7gOq3y+TzLhYeKQU0RsSqJ0xGmOPlQgtDQX/SvzAWzAK68DyCgD
         i/LaqykKOWNw/pCN/UKF5fN6RuyVV0EfACgAOo9gWlHvY69yeqM7nS+0xzsj1W2jLWEX
         8D75pzQraiu+kBy3x7UdpxjNZR49v2k02eTvFJABr6SdEyW6/DsZik92iDUbl0I1hLPs
         JXp3stppcDVkPvzNq+DHjsWDvRLsT5CuFzi1/hRMn+BiPC6N4gEpObmDBgKdt2qLhM/r
         yDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+/aQPgBdctfCPkN2hsKPsv6boSaHaEN13UyN4xwV5wE=;
        b=BxjfFrqs4G8PX0bS3+j/okTSosQUlnAIMZ6t8/Mn22opwclsYkdHt/2A24VdQoNZ9j
         AxaUjhIY/m1hJJ0NDH9pQ/qu/bYh1Gq/y7OjiMsJSQah/qENpl+xe0HkR82/BwQrNQX1
         OJOlFbyTx470hXITOrJLo4h0yjz//FWB9XRkm9OeiLDQU97HkPFr5X5OWaIWM8EHdSUf
         M9e7zfheCytDXNAd5pneZ3bF+o4d5Ikasw+zNBricsEwoVNKxHtzHuCrlTCSyrdj0iUm
         sK6lswD7eMEKQzzrD/kZcpsgaPf9Hamaj8meiBOHZNVMMWHB1bzXmWyrtWSqgjS7DkyT
         NzVw==
X-Gm-Message-State: AOAM5312QoqE2vmK4dMun89RfHCF3jPT5L986iEenUwHRYSs6P+cucfs
        e13Bl4G5g74Og9QPC+6siWKDEA==
X-Google-Smtp-Source: ABdhPJy1Ks7m4wNqY3xj2Br282e4/ffX4B8ONEyjVpIaYR5PrTlOIMUPByiKuibHFE+Oy7oMmgjPgg==
X-Received: by 2002:adf:ca06:: with SMTP id o6mr5285330wrh.181.1597470339433;
        Fri, 14 Aug 2020 22:45:39 -0700 (PDT)
Received: from gmail.com ([141.226.169.176])
        by smtp.gmail.com with ESMTPSA id f124sm19635765wmf.7.2020.08.14.22.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:45:38 -0700 (PDT)
Date:   Sat, 15 Aug 2020 08:45:35 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] xprtrdma: make sure MRs are unmapped before freeing them
Message-ID: <20200815054535.GA3337941@gmail.com>
References: <20200814173734.3271600-1-dan@kernelim.com>
 <5B87C3B5-B73D-40FD-A813-B3929CDF7583@oracle.com>
 <20200814191056.GA3277556@gmail.com>
 <DA35C71E-101D-45F6-A5BE-23493F7119C0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA35C71E-101D-45F6-A5BE-23493F7119C0@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 14, 2020 at 04:21:54PM -0400, Chuck Lever wrote:
> 
> 
> > On Aug 14, 2020, at 3:10 PM, Dan Aloni <dan@kernelim.com> wrote:
> > 
> > On Fri, Aug 14, 2020 at 02:12:48PM -0400, Chuck Lever wrote:
> >> Hi Dan-
> >> 
> >>> On Aug 14, 2020, at 1:37 PM, Dan Aloni <dan@kernelim.com> wrote:
> >>> 
> >>> It was observed that on disconnections, these unmaps don't occur. The
> >>> relevant path is rpcrdma_mrs_destroy(), being called from
> >>> rpcrdma_xprt_disconnect().
> >> 
> >> MRs are supposed to be unmapped right after they are used, so
> >> during disconnect they should all be unmapped already. How often
> >> do you see a DMA mapped MR in this code path? Do you have a
> >> reproducer I can try?
> > 
> > These are not graceful disconnections but abnormal ones, where many large
> > IOs are still in flight, while the remote server suddenly breaks the
> > connection, the remote IP is still reachable but refusing to accept new
> > connections only for a few seconds.
> 
> Ideally that's not supposed to matter. I'll see if I can reproduce
> with my usual tricks.
> 
> Why is your server behaving this way?

It's a dedicated storage cluster under a specific testing scenario,
implementing floating IPs.  Haven't tried, but maybe the same scenario
can be reproduced with a standard single Linux NFSv3 server by fiddling
with nfsd open ports.

-- 
Dan Aloni
