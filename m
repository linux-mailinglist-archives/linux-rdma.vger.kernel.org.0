Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9429D4C21F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 22:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfFSUMA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 16:12:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40129 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSUMA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 16:12:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so574400qtn.7
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FPz4fCD9I1nqLaGFZ73wl0iYMlV95hp392qM+38zx30=;
        b=fhVBB9A7gzlrUi09IMku7RbSUHi0gr4pYy33DZOzGjtl0FA+AMYnHHlDrKITL/8bEu
         pBOf8Bl3iODLm1X7bZImWgplG3fa7xDVsScKS3HVDDQSW7x+UNK0k2Iztug1hn2vVt4D
         T6+PkxCRzgfxosV6J8qKXo+3ziwuUGoUsD1nzpU5qeo4kgTG5aPLEIOuxtyLFCA3f6Oi
         eNRxDHZsl3yyw5uYi3PG93JvJdqhf6pY2lSnPOBPqN1UQRjaId6UMA4iZFAZDL2z3O7H
         TMomz93YccKQBlrfoU7Vd7VPi7Q1PTSctTeupMiIvdLoMzgL3LXTofPp7RnwpNDZx5X0
         tp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FPz4fCD9I1nqLaGFZ73wl0iYMlV95hp392qM+38zx30=;
        b=Dj5NwAyGTrYF+VYMHf/qkUIUv4SkkRzxATHE/uzUZrBJlmwJVQnhH77LWpwOCYONzE
         6gvPSc/ESnpG7p4MsFxOsFUzdIZ/JegX4rVJnSDLn26SYZQxPtJky3UG+A4hQG1ul6Pl
         FpTnsj8S4q+4RiJ8AkM+DdN75DBLwrwYS/qogRIqxOdQGIoZtSycZ8efkhiUxjUXXveV
         6KiNz+sVWWHBi9cYMCVQ9TOqeMk8jcpIz0pwbPi73m7XBWAUCIe/fydmaPc5L6sXv9p8
         MHyz2NISyygWdC8js/xDelx91uFh5Z+SHQEPY1auwY+a9x9yp4MrGTWcQKWhWCeewEyL
         1rcg==
X-Gm-Message-State: APjAAAVHM8V2ExjoMy0GrEECotPpxCW2yfwNu0f9AiILCEVQ5ekHVNQ6
        sU3HaRj6NmB3A2tNr9oVIUyG8w==
X-Google-Smtp-Source: APXvYqyqjMs/A15UUmOHDrBRWJ8TPAFMIcW9sul1ZDIjjIHJe3A0ojSOaJDQCrMj3BNrgCCckNjjTQ==
X-Received: by 2002:a0c:ae50:: with SMTP id z16mr34400789qvc.60.1560975119282;
        Wed, 19 Jun 2019 13:11:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k5sm10764186qkc.75.2019.06.19.13.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 13:11:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdgw2-0002kp-2L; Wed, 19 Jun 2019 17:11:58 -0300
Date:   Wed, 19 Jun 2019 17:11:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/2] RDMA/netlink: Audit policy settings for netlink
 attributes
Message-ID: <20190619201158.GK9360@ziepe.ca>
References: <cover.1560957168.git.dledford@redhat.com>
 <5ef05339c1d799133076c24e616860a647e96148.1560957168.git.dledford@redhat.com>
 <20190619192431.GA13262@ziepe.ca>
 <b964f5286ad9d2c3f1fb2f4f0f3206ecf9da2ad7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b964f5286ad9d2c3f1fb2f4f0f3206ecf9da2ad7.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 19, 2019 at 04:02:30PM -0400, Doug Ledford wrote:
> On Wed, 2019-06-19 at 16:24 -0300, Jason Gunthorpe wrote:
> > 
> > > +	nla_strlcpy(client_name, tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE],
> > > +		    sizeof(client_name));
> > 
> > This seems really frail, it should at least have a
> > 
> > BUILD_BUG_ON(sizeof(client_name) ==
> > nldev_policy[RDMA_NLDEV_ATTR_CHARDEV_TYPE].len));
> > 
> > But I don't think that can compile.
> > 
> > Are we sure we can't have a 0 length and just skip checking in policy?
> > It seems like more danger than it is worth.
> 
> nla_strlcpy takes a size parameter as arg3 and guarantees to put no
> more than arg3 bytes - 1 from the source into the dest and
> guarantees it's null terminated.  The only difference between
> nla_strlcpy and normal strncpy is that nla_strlcpy zeros out any
> excess pad bytes that aren't used in the dest by the copy.  If
> someone tries to pass in an oversized string, it doesn't matter.  If
> someone modifes the function to change the size of client_name, our
> nla_strlcpy() is safe because our dest and our len parameters are
> always in sync.  I don't see the fragility.

Silently truncating the user input string and not returning an error
is a kernel bug.

I dislike strlcpy and friends for the same reason everyone else does -
they prevent security failures but create bugs with undetected
truncated strings.

> > >  	if (tb[RDMA_NLDEV_ATTR_DEV_INDEX]) {
> > >  		index = nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
> > > diff --git a/include/uapi/rdma/rdma_netlink.h
> > > b/include/uapi/rdma/rdma_netlink.h
> > > index b27c02185dcc..24ff4ffa30dd 100644
> > > +++ b/include/uapi/rdma/rdma_netlink.h
> > > @@ -285,6 +285,7 @@ enum rdma_nldev_command {
> > >  };
> > >  
> > >  enum {
> > > +	RDMA_NLDEV_ATTR_EMPTY_STRING = 1,
> > >  	RDMA_NLDEV_ATTR_ENTRY_STRLEN = 16,
> > 
> > The empty thing is just an internal implementation detail, should not
> > leak into uapi
> 
> So was ENTRY_STRLEN.  Once I audited and set all non-input strings to
> EMPTY_STRING, ENTRY_STRLEN isn't even used any more.  It happens to be
> the same as IFNAMSIZ and so could be used in its place, but doesn't have
> to be.

Should move both then

Jason
