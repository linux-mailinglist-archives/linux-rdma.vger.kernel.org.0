Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054C036B37B
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 14:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhDZMtr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbhDZMtq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Apr 2021 08:49:46 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA3C061574
        for <linux-rdma@vger.kernel.org>; Mon, 26 Apr 2021 05:49:04 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id x27so27126683qvd.2
        for <linux-rdma@vger.kernel.org>; Mon, 26 Apr 2021 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5V1M/8wTL+44XN0WSBaBO0JAykjaa0+R1F+N5lVVpTE=;
        b=W7NdTBvtFAoUr3u7J2lJ2QrDQqXSt6VE3rrbE3waas4eZQhgt35WAusmKPZbFpKsjN
         Z13E8peIeM/EBkFUgwNT8P5pA5G63RhPCEaLKCxwxGGo9hTZwWKEM8cr85aW3hrHAfjJ
         eIdbixyYoPpJoVKw6EGZjcaG1e1DAXUu7a0BZ+fqqLHqa6eAq6f/VRXVqcqQ0951qvSS
         nSe4BMdLhOSCburrVe0Cp6DEIQ4hFY5XaBjI/uUcGMEsog2LOgJ1kydmTj8JTdL3aE0B
         0ybQiyALYn3oPitMAP0JReiC0PWOOiRjNfLOXhwWZprOuGN9zo6XWqezUIduPvFgcIQE
         RjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5V1M/8wTL+44XN0WSBaBO0JAykjaa0+R1F+N5lVVpTE=;
        b=BziQ2hyGDmEqTTNUBQUrt68F8xF+eq6DxYQEf5/1gfl9zr/tNdUaeMPwnFk5eJLYnr
         K5ZXFfq4hHG7MeMAROGfUMNg0fcZXgTqTG6TEIQgr4PxyNN6DU3mDxjrRrPnxgSsqDwm
         lswVvcS4g03Om7zYhUEQR7KZXo55uktxFznjWI0zvANWJ76OodCX6LsckhVCATWL/830
         +RZBoEnf42Gx2CQ2oGb/N3O/PXf6SonbLDmz+3BBeQwpyTrBxXciT2CGSYxTcP95imiv
         ZjCUGxcMAAj1+FIxCLsj+mCGWD4hzchcrs8JaQfCPuPJD+klymEXF6UFieXrg/F6AtT/
         897A==
X-Gm-Message-State: AOAM530HZHJ00PP43/Cf0PzysI1GO5xX0OLRgAwbL3eVAqfekh57iZaN
        rmxlXSJ+MTxRLIXVnLEFDv9Fyg==
X-Google-Smtp-Source: ABdhPJwuo00Q8Wo160RxwXVr2Fz9UAZebNH187bXKA1AmF1neYyCfP+9/qc6WfqcqCrI40AZEbtXAg==
X-Received: by 2002:a0c:fcc8:: with SMTP id i8mr5721104qvq.31.1619441343595;
        Mon, 26 Apr 2021 05:49:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id 19sm3098116qkg.54.2021.04.26.05.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 05:49:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lb0fe-00D1tc-9F; Mon, 26 Apr 2021 09:49:02 -0300
Date:   Mon, 26 Apr 2021 09:49:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Benjamin Drung <benjamin.drung@ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: rdma-core: Minimum supported Debian & Ubuntu releases
Message-ID: <20210426124902.GJ2047089@ziepe.ca>
References: <8d930476e5daf34147a178420596230dfecf2038.camel@cloud.ionos.com>
 <YHQttR48FsDJkuWd@unreal>
 <20210413164012.GJ227011@ziepe.ca>
 <84ac2b08ac7440b12ddca7da7e722168cc15cd32.camel@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ac2b08ac7440b12ddca7da7e722168cc15cd32.camel@ionos.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 26, 2021 at 11:12:50AM +0200, Benjamin Drung wrote:
> Am Dienstag, den 13.04.2021, 13:40 -0300 schrieb Jason Gunthorpe:
> > On Mon, Apr 12, 2021 at 02:23:33PM +0300, Leon Romanovsky wrote:
> > > On Mon, Apr 12, 2021 at 12:31:26PM +0200, Benjamin Drung wrote:
> > > > Hi,
> > > > 
> > > > which Debian & Ubuntu releases should rdma-core support? Do we
> > > > have a
> > > > policy for that like all LTS versions?
> > > 
> > > I don't think that we have a policy for that.
> > 
> > I understand there are still active users on the prior LTS, so I
> > would
> > prefer to keep that working.
> 
> So to put numbers on it. rdma-core should support:
> 
> * Debian 9 (stretch) or newer
> * Ubuntu 18.04 LTS (bionic) or newer
> 
> Debian 9 is currently oldstable and Ubuntu 18.04 LTS is the second
> newest Ubuntu LTS version. Or do you refer to Debian 8 "jessie" (which
> EOL last year) and Ubuntu 16.04 LTS (EOL around now)?

Yes 16.04 :( Maybe it is nearing dead now, but if we don't have a
strong reason to kill it I'd prefer to leave it be. Basically if it
is in buildlib/azure-pipelines.yml it should work.

Even centos6 is still in active use for some reason, and our container
images for it can't even be built anymore :\

I don't have any info on Debian users.

Jason
