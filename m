Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C476C4C467
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 02:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfFTASB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 20:18:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38315 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFTASB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 20:18:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id n11so1295871qtl.5
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 17:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cIOGLozCJyBAki1gkh/WgkoTBRSsN+Kk2Vj57dMrMxA=;
        b=clPXCMsByrA4vDpq71UT3gqte4TddGT2IUNH8vXNl1ldBYcpP11N9qodqtE5I7zpbN
         Hshvdo7tMzzvOtpCdaY3T93/UP+7pTJo1HAlsGCSjfBEXMnwpOrmDgg+wp/hojB+cB27
         1oooDkvl3W7hg8oFF0vsykrE0NvbakrD+VOU+wh8i82gPVa/vZUaLB8vp1WMBgqxcJH3
         oxO2H9vOGKk/0etuPav99x4+rFRwH7HSSdp240JcKHNeJjW2RkgHXIwCdwN4QohUxFAf
         drSqJZr9EJch6mqS5NpPwV2Decf3obu8nrno9kE+9W6F3d24rTtCCt9q1ujIvIpJ1pKV
         hWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIOGLozCJyBAki1gkh/WgkoTBRSsN+Kk2Vj57dMrMxA=;
        b=N627gXyMy0Rc35bnQUVR94g9aUl+XSa2d2BwrrpdDA39efV3AJYplGGQj53j4D5Ysk
         laKEWDiJ57q7/F8tOa0QtOgsy8OowSCoozhxLHdLA/NICI8pJYDQ2GG+KGvNvgiZymYT
         XPx2yJPJJuoXza4Ifx7Uvuh0W3cDrCqE8VUDRrFNy+Z3aCpfKjkSE4be8WoJHcge+J51
         MyfpYnRFJAWkdC/J081w93KyDKWh/njvH35Neu9f+yKJ6gbSScgMr98LmDsEWexjv5Px
         /KAVCarOZgc8wjKABlAQyOZeATtTZ2dG8UQBCtFoVlIzMm7Av198Pz+qOtFFeAATfwyQ
         Tvxw==
X-Gm-Message-State: APjAAAViEHwvIt2easrZ9WpqGt8XkeDTbMcfik9SIVGwFaBOpng9sIDf
        zFRwRka0fG/MsPA34sRcqasBAwVAFRTi+Q==
X-Google-Smtp-Source: APXvYqzwt/OjP7Ky2plH9mFU0FPC7aTgsEFbbyb0yc8qGCQ0u6jkvaDyaOu93YJ2cjQWypwgIFo9uQ==
X-Received: by 2002:ac8:376e:: with SMTP id p43mr110013501qtb.354.1560989880517;
        Wed, 19 Jun 2019 17:18:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z12sm9749661qkf.20.2019.06.19.17.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 17:18:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdkm7-0001Rw-Ll; Wed, 19 Jun 2019 21:17:59 -0300
Date:   Wed, 19 Jun 2019 21:17:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/2] RDMA/netlink: Audit policy settings for netlink
 attributes
Message-ID: <20190620001759.GC14968@ziepe.ca>
References: <cover.1560957168.git.dledford@redhat.com>
 <5ef05339c1d799133076c24e616860a647e96148.1560957168.git.dledford@redhat.com>
 <20190619192431.GA13262@ziepe.ca>
 <b964f5286ad9d2c3f1fb2f4f0f3206ecf9da2ad7.camel@redhat.com>
 <20190619201158.GK9360@ziepe.ca>
 <3695301f8ba9f8902c5c0a00171f6ca72f83faf2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3695301f8ba9f8902c5c0a00171f6ca72f83faf2.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 19, 2019 at 07:59:22PM -0400, Doug Ledford wrote:
> On Wed, 2019-06-19 at 17:11 -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 19, 2019 at 04:02:30PM -0400, Doug Ledford wrote:
> > > On Wed, 2019-06-19 at 16:24 -0300, Jason Gunthorpe wrote:
> > > > > +	nla_strlcpy(client_name,
> > > > > tb[RDMA_NLDEV_ATTR_CHARDEV_TYPE],
> > > > > +		    sizeof(client_name));
> > > > 
> > > > This seems really frail, it should at least have a
> > > > 
> > > > BUILD_BUG_ON(sizeof(client_name) ==
> > > > nldev_policy[RDMA_NLDEV_ATTR_CHARDEV_TYPE].len));
> > > > 
> > > > But I don't think that can compile.
> > > > 
> > > > Are we sure we can't have a 0 length and just skip checking in
> > > > policy?
> > > > It seems like more danger than it is worth.
> > > 
> > > nla_strlcpy takes a size parameter as arg3 and guarantees to put no
> > > more than arg3 bytes - 1 from the source into the dest and
> > > guarantees it's null terminated.  The only difference between
> > > nla_strlcpy and normal strncpy is that nla_strlcpy zeros out any
> > > excess pad bytes that aren't used in the dest by the copy.  If
> > > someone tries to pass in an oversized string, it doesn't matter.  If
> > > someone modifes the function to change the size of client_name, our
> > > nla_strlcpy() is safe because our dest and our len parameters are
> > > always in sync.  I don't see the fragility.
> > 
> > Silently truncating the user input string and not returning an error
> > is a kernel bug.
> 
> That's a matter of expectations.  Looking through all instances of
> nla_strlcpy() in the kernel tree, only about 4 of the 25 or so uses
> check the return code at all

Sadly the kernel is full of bugs :(

Silent string truncation is a well known bug class, I guess Dan
Carpenter just hasn't quite got to sending reports on these cases
yet..

> and only 1 of those returns an error code to the application.  This
> mirrors the behavior people see when they try to do things like
> rename a netdevice and pass in too long of a name.  As long as the
> truncated name isn't taken, it succeeds at the truncated name.

Returning ENOENT, or worse, the entirely wrong result instead of
EINVAL, for a too long string is a straight up bug.

The probability of any user hitting this is very low, but it is not
some well thought out behavior...

> > I dislike strlcpy and friends for the same reason everyone else does -
> > they prevent security failures but create bugs with undetected
> > truncated strings.
> 
> I think the net stack has a fairly well established behavior in regards
> to truncating overly long strings.  

I think it is just bugs. :(

> truncation, or fix the perceived kernel bug?  I don't actually feel
> strongly about it.  I'm used to the truncation behavior.  If you would
> strongly prefer an error on overflow, I'll change the patch up.

The client_name is a stack variable of a completely arbitrary size that
is larger than all existing client_name statics in today's
kernel. Tomorrow it may get bigger, or smaller. Its length absolutely
does not form part of the uAPI contract, and truncation of the user
provided string should always return EINVAL never any other result.

Jason
