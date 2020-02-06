Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37EDA154578
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 14:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBFNw2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 08:52:28 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46801 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFNw2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Feb 2020 08:52:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id e25so4465644qtr.13
        for <linux-rdma@vger.kernel.org>; Thu, 06 Feb 2020 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O/gnv25DuucfF8OGOdRxq2DyV1i1cV8dY7+A2O3nrGY=;
        b=XTDUOxh/w2Zp2lepmzqeKYsFQaEjHZpB1lHHAPr0sCqftpmOawuRz3h/xrbaAYfRQn
         hYwM/YNk1kuAqQOhW9Bsj6hm0SVdVNqLZ3ZbRTPtEz5rM2t7N88/RY+GyPgmq1RVYk3M
         SzwnQDT9hb1zKiCxcwT/MR36kL57IUua5lgl0fD42dfIRDcnUn1doFBZH0vmL7tJ1i3X
         twfzmMiCfKDKwqAsFMKPijN8v9EHsnesC4LuQJwkltyRcs9z6o5NJUUg1SpN7IF+SY7P
         zpv0Wm3NhlGyCwoBbH9aCKfrophXu07IWrRB9mcp/N3AUOasNlJGTW1xSRQt/JK+ugp1
         jP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O/gnv25DuucfF8OGOdRxq2DyV1i1cV8dY7+A2O3nrGY=;
        b=hIs3CHw0U47q89fKN2PlvdTlzD9Wn8thsKP4ytKNnjjpVxwKU2RYzFloKfvxOpUcB+
         1O5VJsK9jfP25I4R5byCyNrKqpWVDn9qpEdx+2gJLdxHc7Aa6La6uhcGADrCT6pLfxbw
         Y7EB4pKC4htj/t3i0ovkW0RcFSbbKhJpvZv6C/gxEzWDJKFQTCm0YuD9cer4WoolY2Of
         wHmN8RWDnsj3FeJ7BiZ+v50re8Y1s5mg3Akc6WTo26plsX4rlSa0N5rXjJ2yuwat/9vk
         hsefIrBKWFzXKi0nVQvYz1SAfRlLbCJzCwTSdoUhcBKWhiy/kBdWtcl51KRjjEbwXPx4
         qHTg==
X-Gm-Message-State: APjAAAXfIDgMXHQP9xcNR3q4aQvOq1vmaqUvuiYC4EdoktP/0M7Zo7aS
        R7gzNvuriGBcFspSKFNX4bCfsw==
X-Google-Smtp-Source: APXvYqy92XseOwz+8TpXcZhXRKuH41vfNIfjDwBAQM1GjLvLNJODoVM+6R9erghL/F3zMf7x4ayCdA==
X-Received: by 2002:ac8:768d:: with SMTP id g13mr2670783qtr.7.1580997147257;
        Thu, 06 Feb 2020 05:52:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o55sm1736138qtf.46.2020.02.06.05.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 05:52:26 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1izhZy-0002rQ-6x; Thu, 06 Feb 2020 09:52:26 -0400
Date:   Thu, 6 Feb 2020 09:52:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     "Goldman, Adam" <adam.goldman@intel.com>,
        linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
Message-ID: <20200206135226.GE25297@ziepe.ca>
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
 <20200205191227.GE28298@ziepe.ca>
 <daa60df0-04e1-d33c-fdc9-5a3fea2688cb@intel.com>
 <20200205205402.GC25297@ziepe.ca>
 <0f9fd27d-4bb8-b51d-1fdc-20a5b0d5d9e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f9fd27d-4bb8-b51d-1fdc-20a5b0d5d9e2@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 05, 2020 at 04:59:11PM -0500, Dennis Dalessandro wrote:
> > I would actively block an attempt to try and do an end-run around
> > upstream like this. rdma-core is supposed to be the defacto
> > configuration, not be modified randomly by distros as before.
> 
> No but users should be free to name their devices how they want should they
> not?

Isn't that exactly why PSM is broken?

These days I can do

$ rdma link add hfi1_0 type siw netdev eth0

and PSM will become very confused.

This is why keying off the device name was *never* OK.

> > Why isn't psm keying off it's own chardev anyhow? There should be back
> > links to the RDMA device in sysfs from there.
> 
> No arguments here. No sense in going down this road though at this point in
> the game.

I'm not sure what these means? Are you saying you won't be fixing PSM? Why?

Jason
