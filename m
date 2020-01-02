Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13BF112E9F2
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 19:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgABS2m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 13:28:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44610 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgABS2m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 13:28:42 -0500
Received: by mail-qk1-f195.google.com with SMTP id w127so31990332qkb.11
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jan 2020 10:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7yfBSL7b333vVmNuWf0Eg7CSRDnibjGCkKeYoXOyt28=;
        b=CG5V0ed7nF2Y6mFiOEH07FVOXdvKKaNQYJGYIP7db6v8BiGo6UMj8JMnexLtTrbe0X
         WFYn1A8DeaK8da6yh/Y76ww1SQ+5WE0vD6bePqEHZyv7HtDfdsGUEqVCIbyCM0vOnBmF
         gPWLRlFjXXwJTj/Cw6enVfeodQuMoxeikuqrIITDUU0QBaLma0r5+wbmYtAlW1Alki+7
         L315zur7d97xVL8/kLrAOTma3rc9sy1uk/MkObRyq89GFezP+yvjJJKZOiMLBsRruKQH
         gB5A4rdd7MK+xNWeBv8g7CQFfVTKHqudugs+3hEZrpD2MjhmuX1a2S7HGkj7ilEc3eC4
         B/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7yfBSL7b333vVmNuWf0Eg7CSRDnibjGCkKeYoXOyt28=;
        b=RY0sCxoNVlx+86V+CUP8jC8fWojuDkOAC9fK/3yvfcbXTuRy+ICrdoj2MZlGHst2jn
         OBR+B5j5ZcGm3bxOS8oZ85G5nkrb6RIsiFu5mOQF/YriCdTt1xcYK6WtStfPkL9jJr19
         wl6TLlS3o4VmVYkT+Jila9X9Pg8Qr1buxFTGZxGD1gxW1sI5lbny8tLjYEeAgkFHvzo1
         5j61rrxDjXiD5sk1996xU3c096jAvZNxCtcLufNG/VVBOdCt2NjIiUpYcJm1tUb5J01W
         6QLhD1/1iMaQAfoBKicj82N525O5BiJSjgb1xi7TONGypdJHZNOxAiFE7VfA8io98jIo
         2KyA==
X-Gm-Message-State: APjAAAWMTHdAIJTIqDEExMxNX1ncpxvN/y10FS3Yi7PPhti1sOs8zT+W
        IubrYX31+wdIAXmEsLrC2pcVcA==
X-Google-Smtp-Source: APXvYqxf6p8x7LAWRTtiQlB6P75GHTLc7nCrzNmZ2aqfWA8dW5wI+1HKrUIXmBQVHbB7rWKhXteRsg==
X-Received: by 2002:a37:356:: with SMTP id 83mr63050642qkd.409.1577989721368;
        Thu, 02 Jan 2020 10:28:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q130sm15228641qka.114.2020.01.02.10.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2020 10:28:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1in5D6-0003dH-EA; Thu, 02 Jan 2020 14:28:40 -0400
Date:   Thu, 2 Jan 2020 14:28:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk, hch@infradead.org,
        sagi@grimberg.me, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: Re: [PATCH v6 00/25] RTRS (former IBTRS) rdma transport library and
 RNBD (former IBNBD) rdma network block device
Message-ID: <20200102182840.GF9282@ziepe.ca>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <a56985f4-fbd3-3546-34e1-4185150f4af2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a56985f4-fbd3-3546-34e1-4185150f4af2@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 30, 2019 at 06:39:00PM -0800, Bart Van Assche wrote:
> On 2019-12-30 02:29, Jack Wang wrote:
> > here is V6 of the RTRS (former IBTRS) rdma transport library and the
> > corresponding RNBD (former IBNBD) rdma network block device.
> > 
> > Changelog since v5:
> > 1 rebased to linux-5.5-rc4
> > 2 fix typo in my email address in first patch
> > 3 cleanup copyright as suggested by Leon Romanovsky
> > 4 remove 2 redudant kobject_del in error path as suggested by Leon Romanovsky
> > 5 add MAINTAINERS entries in alphabetical order as Gal Pressman suggested
> 
> Please always include the full changelog when posting a new version.
> Every other Linux kernel patch series I have seen includes a full
> changelog in version two and later versions of its cover letter.

We now also like it if you include URLs to lore.kernel.org for the
prior submissions.

Jason
