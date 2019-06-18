Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE64A1BB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 15:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfFRNJy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 09:09:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42898 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbfFRNJx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 09:09:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id b18so8460812qkc.9
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GJ7vqtKeJxHjsYlGQdIfaZLAJz4bfK60EqYMhIlyf3Q=;
        b=pHH5ksTtRXUx+kZNA/sp/7FMv8fCr1D20QD+tDaOyTkWzttsq6bBZBWr3dVmjWNyJg
         F3kDTEAhvW98zvzuD5np+iExxM4ptNzm+ZCfYb7LHcn85v7k+scEJMLwO1MIeII5S+Tx
         fAUvG54qjUuN5By2RIcnYoFz0meWG8ScOZaIfG5Vdeq5cSNRAIOyLRSw7RBUxroWnYXV
         6ECNbPm+DE4YJSU/0RPjgz9UM1VmtDZkadImMdaWNGogWdPFDouApc+w8/KB2IrafeOK
         s0mHcKeZVIBK6xwHc3hfN5MuHCWyb6Q9/JcaIgO45dKRkl/7sW7QNPFhb99FtVk28kIK
         e2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJ7vqtKeJxHjsYlGQdIfaZLAJz4bfK60EqYMhIlyf3Q=;
        b=CwTBRNOCYW65TgyVtuY1zN2e6veV7W8LVJ08LA9SFNfPHPFy9GAtHEHM1EhQn8j6hV
         SGzMHDKUBOvlUS4lLlUoEWpsl1rqbC0jnWK9JbtG7pAhTmiSvh2eN7Q43alSSGxCbqWc
         FvjsJx/065UnUFsHFCCKHVZ8Ql7WkqcoIMFUCHP5PlhUiVOk1ohj16fnAdqDWTHzvTpW
         oGZ2QZIQR926YGLvOYkuA0C8t2y0Lmk9dXz+UGUQrfM9dfIdPwJ/vB0fYwUrsz7W2Wqd
         5Kc9ygj5DafYyPjJN/Qluh/MvMx+WtIjEdObPSpjv74ksIHD54mQLDtqG3uVv+P5wSxE
         SLHw==
X-Gm-Message-State: APjAAAUbOKKINbLWr9g5EQJ8gC0i0JojZ6SCKdP5RDuq8vhowjQfcJXD
        mw1MFmmjkvCinVHFNF0yC1Q66C0YNurnww==
X-Google-Smtp-Source: APXvYqyx8DEg0DOxaRaMNtmVya86cKGPC5BcDPZxathvPrtAMg3MKBm+qGu4gsCdchxkXH0o5UWdwQ==
X-Received: by 2002:a37:a854:: with SMTP id r81mr17405657qke.53.1560863392616;
        Tue, 18 Jun 2019 06:09:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q36sm10372173qtc.12.2019.06.18.06.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 06:09:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdDrz-0002ao-N3; Tue, 18 Jun 2019 10:09:51 -0300
Date:   Tue, 18 Jun 2019 10:09:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] RDMA: Report available cdevs through
 RDMA_NLDEV_CMD_GET_CHARDEV
Message-ID: <20190618130951.GD6961@ziepe.ca>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-4-jgg@ziepe.ca>
 <20190618121900.GL4690@mtr-leonro.mtl.com>
 <20190618130150.GB6961@ziepe.ca>
 <20190618130411.GM4690@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618130411.GM4690@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 01:04:14PM +0000, Leon Romanovsky wrote:
> On Tue, Jun 18, 2019 at 10:01:50AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 18, 2019 at 12:19:04PM +0000, Leon Romanovsky wrote:
> > > > diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
> > > > index 9903db21a42c58..b27c02185dcc19 100644
> > > > +++ b/include/uapi/rdma/rdma_netlink.h
> > > > @@ -504,6 +504,7 @@ enum rdma_nldev_attr {
> > > >  	RDMA_NLDEV_ATTR_CHARDEV_NAME,		/* string */
> > > >  	RDMA_NLDEV_ATTR_CHARDEV_ABI,		/* u64 */
> > > >  	RDMA_NLDEV_ATTR_CHARDEV,		/* u64 */
> > > > +	RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID,       /* u64 */
> > >
> > > This should be inside nla_policy too.
> >
> > It is an output, not an input. policy only checks inputs.
> 
> We are putting in policy everything to ensure that it won't be forgotten
> once output field will be used as an input.

Adding dead never tested code is more likely to just get it wrong..

Jason
