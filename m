Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 132BFE900A
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 20:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfJ2ThN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 15:37:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38955 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfJ2ThN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Oct 2019 15:37:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id t8so22004652qtc.6
        for <linux-rdma@vger.kernel.org>; Tue, 29 Oct 2019 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ndPchJCINSLW6zXoxwghNw45dTEmLArUMZOFT2JSm2k=;
        b=O64hEkEFvzxf/oLPkeITelUjFffJdehBUleCEHwDLSm2tNqPIO9qJFp8jQoVvUpXbB
         JN6oE4ALPBqQF5cPIG11DQjPR+EHCfXmNTOKu5+iqnWrZL8aC8Kki4UvCRUsT9Y+TqUg
         wDmRTXdU9F0zscrO3Ar/Z93Eyf7jcKtxMo6264OsyRBFpcGL3LXB2ChlHrWEf8zxu2v9
         v4v97ZY6Uinq4hqGFYgNuehEeXPgEMgnuXPXIr/p4XLileZh7fixH2T45yOOy4CuMIrE
         6qy9QX/7QYa81lKgLJeuAuhSVwjEEwU8KbDWyuQcOqYWm+TIZJ8lfKB8OcZO0vAH3vnB
         Jkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ndPchJCINSLW6zXoxwghNw45dTEmLArUMZOFT2JSm2k=;
        b=Wo6HmX1AKMOx86eZwmFg2DBPArKHRqBde2IQQ5ggKmPg6QqfxV7ehrfrsyhtc4eRdE
         eUAydIXrqM2FACNCiO5ssAbBX1dnrk7AJ5wjcelbWGECblC7Kr7t5bw/zHSaPX2ZFZW8
         lnpe1nu0CMS/ILvaiJiW409oivQmKPiCqTNLI3uE52l+1NkmQVpvSTqo0r4K8900L8Vn
         J9xwsqsY1X8c4tp/0q47OeJsYy3KiZUO3DLMm05yjJYrevVgzYXeoXTmtCP9ifLXV1Dz
         n6wOX0mEbj7D4t8p1ChAXgqrIdGiFWglBPUWpuJsP+CY+DbllsUzKteIYA1WS/EXwL0i
         pzVA==
X-Gm-Message-State: APjAAAWAZb9Qa5AKt/MruHjq5K5B0GrEM7575PUI4mnGNoiyQHqiJT+4
        rCXclIPQf5ZfPGfqqP2Oc7LJpA==
X-Google-Smtp-Source: APXvYqzDt0MMA1QUgAHudYW9T+91MvBi4R6sHQNiU/d17LpSx/RDcWvqDkCwhIP0T6AJyKbynUqXZg==
X-Received: by 2002:a0c:85e4:: with SMTP id o91mr24953809qva.16.1572377832171;
        Tue, 29 Oct 2019 12:37:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c23sm10608811qte.66.2019.10.29.12.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 12:37:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPXIl-00009L-62; Tue, 29 Oct 2019 16:37:11 -0300
Date:   Tue, 29 Oct 2019 16:37:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Honggang LI <honli@redhat.com>
Cc:     bvanassche@acm.org, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [rdma-core patch v2] srp_daemon: print maximum initiator to
 target IU size
Message-ID: <20191029193711.GA531@ziepe.ca>
References: <20190925004200.32401-1-honli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925004200.32401-1-honli@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 25, 2019 at 08:42:00AM +0800, Honggang LI wrote:
> From: Honggang Li <honli@redhat.com>
> 
> The 'Send Message Size' field of IOControllerProfile attributes
> contains the maximum initiator to target IU size.
> 
> When there is something wrong with SRP login to a third party
> SRP target, whose ib_srpt parameters can't be collected with
> ordinary method, dump the 'Send Message Size' may help us to
> diagnose the problem.
> 
> Signed-off-by: Honggang Li <honli@redhat.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  srp_daemon/srp_daemon.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks

Things will go faster if you send rdma-core patches as PRs.. It saves
me a bunch of work :)

Jason
