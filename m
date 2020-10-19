Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74BB292D97
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Oct 2020 20:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgJSSbf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Oct 2020 14:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbgJSSbf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Oct 2020 14:31:35 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A0C0613CE
        for <linux-rdma@vger.kernel.org>; Mon, 19 Oct 2020 11:31:35 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p9so1279132ilr.1
        for <linux-rdma@vger.kernel.org>; Mon, 19 Oct 2020 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KiYHkdjSKwc5nxbsgSu+T0wEJF/MXkVPRwhMCfSdY6s=;
        b=AJcK4ZsTLW6to30sHE97EeRWXtJ7lm7xB9ZsTPR14jw6la3mDUfNEDb3DISqDiqa3W
         RDVInYQS0gQYEDpEb9Zrdw9gRpxxSZUt33rS6Yq2HcXFkCfKiqAMtuZziQYX7RceXMLP
         3a8xb4AbG0DqWFM/iPX4ftVDlN3DNN1ewyF8JKytKdBEdArKPVTGVKj7S4sn2UQg5kXC
         ahgwfHcYi8ZoJurr2yOfQ0HEK2iQzeZ/romy9wWE4w+iD465t0n27btLnMPDvXpyxo6E
         pjiss1oTTrtNzS0c+Cgh6BE+HUbGVOziwGHkldFCqK7fs3nd5JeYmgTewS4ooDqIQkA8
         EJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KiYHkdjSKwc5nxbsgSu+T0wEJF/MXkVPRwhMCfSdY6s=;
        b=Ab8zna4b48LUXFQjQUzR23eD4IuxcjtU/Bt9qvm63QFh7CML8qQXw4tCDlantAzbXS
         8AD+CDCRX8M0V/z2i55NAnWY3K+D331K/mVWgXO+1IKvaJw+T0lQIMYv4B9rcnEXxB4H
         UcFwd/iB0XB1ZJoRiiMpa8mEktXUXgKPvq5WIRU2r5TyzPJZPr3Og5hIqqzuxbh05uBl
         QRchY8+QY59eUw60O3LeBTvvdGCZAyKEK69izDVPqGbpd/0PCDwjFGXNerryqsS+8LY9
         LPyPP908VZKEZN+2QSOcdCsubxmQjTllxxAy//XGUY1MNkv2s4CkA+jjnCed2cwo44y5
         isBQ==
X-Gm-Message-State: AOAM533ndt8NTTaq3KT6sFim9lfuYTAwL2v5wWYJEHnfivJAlVyfH3uu
        H+b75SCtS3ph4Xer+e60euvOvA==
X-Google-Smtp-Source: ABdhPJx2J7Nb9vZk6Pdn0u10l8qaqfMqvDqZT00lsW3WJmYkZeju5ClGLzmUj9yuYB8/O6WQas/Y0A==
X-Received: by 2002:a05:6e02:970:: with SMTP id q16mr1144831ilt.69.1603132294692;
        Mon, 19 Oct 2020 11:31:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b9sm448279ilq.51.2020.10.19.11.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 11:31:33 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kUZwS-002cPP-N4; Mon, 19 Oct 2020 15:31:32 -0300
Date:   Mon, 19 Oct 2020 15:31:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201019183132.GE37159@ziepe.ca>
References: <20201009143940.GT5177@ziepe.ca>
 <0E82FB51-244C-4134-8F74-8C365259DCD5@gmail.com>
 <20201009145706.GU5177@ziepe.ca>
 <EC7EE276-3529-4374-9F90-F061AAC3B952@gmail.com>
 <20201009150758.GV5177@ziepe.ca>
 <7EC25CA9-27B5-4900-B49C-43D29ED06EB6@gmail.com>
 <20201009153406.GA5177@ziepe.ca>
 <4e630f85-c684-1e56-bb68-22c37872c728@oracle.com>
 <20201016185443.GA37159@ziepe.ca>
 <35A86DEC-33E8-4637-BEBB-767202CF0247@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35A86DEC-33E8-4637-BEBB-767202CF0247@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 16, 2020 at 04:49:41PM -0400, Chuck Lever wrote:
> 
> 
> > On Oct 16, 2020, at 2:54 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Mon, Oct 12, 2020 at 04:20:40PM +0800, Ka-Cheong Poon wrote:
> >> On 10/9/20 11:34 PM, Jason Gunthorpe wrote:
> >> 
> >>> Yes, because namespaces are fundamentally supposed to be anchored in
> >>> the processes inside the namespace.
> >>> 
> >>> Having the kernel jump in and start opening holes as soon as a
> >>> namespace is created is just wrong.
> >>> 
> >>> At a bare minimum the listener should not exist until something in the
> >>> namespace is willing to work with RDS.
> >> 
> >> 
> >> As I mentioned in a previous email, starting is not the problem.  It
> >> is the problem of deleting a namespace.
> > 
> > Starting and ending are symmetric. When the last thing inside the
> > namespace stops needing RDS then RDS should close down the cm_id's.
> 
> Unfortunately, cluster heartbeat requires the RDS listener endpoint
> to continue after the last RDS user goes away, if the container
> continues to exist.

What purpose is the heartbeat if nobody is listening for RDS stuff
inside the net namespace anyhow?

> IMO having an explicit RDS start-up and shutdown apart from namespace
> creation and deletion is a cleaner approach. On a multi-tenant system
> with many containers, some of those containers will want RDS listeners
> and some will not. RDS should not assume that every net namespace
> needs or wants to have a listener.

Right

Jason
