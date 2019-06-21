Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE3D4EF97
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 21:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFUTqu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 15:46:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36644 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFUTqt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jun 2019 15:46:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id p15so8159998qtl.3
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2019 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jDKOLvAZVK3p+ZWp8OuSqnDaO2OfqaqhbxDV60Rh4mU=;
        b=JEI/LcRmtKhPwa+q5By5mEAN9GdgP8GV5eeetvS5rsYpAQHgVnG52rxonSPsGghvcg
         PfAXBmiCbAeeJwxaS8mMBPv0Qad6VYvE8hSu+0aNjnl3EX/V5eJAvK4PfHNge16V9zIs
         iXUASbX2PI8gxHgkVAze27YG8QYUpr2Z8TjwdaNJPj7X+wvht492EKBc7PyFT9rLMPB3
         ua0dTLDkNSm2iwQiujgG2zrTvMVLY4XhrdCNGuyVG3Rcb07hC4DnLKXLTFMIOnd2+EgL
         M40pn9tGg5tjeWIOOgBKtVK15LImjflWcgw91a0hi1FKlKgZlZuGiwkh89XwOkxCbq1E
         vP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jDKOLvAZVK3p+ZWp8OuSqnDaO2OfqaqhbxDV60Rh4mU=;
        b=AjPzWanBw8PNc9EbslhErwLNnqa+4IQBh4077kH65q9xbGpiELkRRVSSKUmua7On6a
         X5XUUmi8TKBNiTOeBqLu391uH+tKbnLfKleOgEcyOqIzTtvUntYCYdt9GdfflWxuqi/8
         62XYvaXKz7ds0/ZwV93ZC7DSd7ar5z8/WzpqbkcFxXLRL6exB0gdjynkIZA28/7RjzmB
         68QhNzJrxCq6f085DS2FvPv6qcbP3oqfdkqPV93MwSWttGYUaMmBuRVdpeXCmGKOCSKu
         VE4Iu644gABRMDZ7k9w6rnZ8qJBEzA/Ka2I0V0y/qr4bPA5wTwZ6L8AWRfc/rhX+D66M
         6u/g==
X-Gm-Message-State: APjAAAUvwsoGxXUmCxl6Cm4xwCgK3MLmTNqtrMphgZ/MkGlaLIUqXpsh
        ushVd0wJFqN5PXj9Vq1zdBST9A==
X-Google-Smtp-Source: APXvYqyWE96lWOXmMBBhuad4N3T+HyL6X6eq4uUTz9OkKy2j98lhbe4T/QRibzhp91ygqiUaNkVGdg==
X-Received: by 2002:ac8:7342:: with SMTP id q2mr25012759qtp.134.1561146408892;
        Fri, 21 Jun 2019 12:46:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d123sm2180313qkb.94.2019.06.21.12.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 12:46:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hePUl-0007wR-Nm; Fri, 21 Jun 2019 16:46:47 -0300
Date:   Fri, 21 Jun 2019 16:46:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH v2 2/2] RDMA/netlink: Audit policy settings for netlink
 attributes
Message-ID: <20190621194647.GX19891@ziepe.ca>
References: <b77fa93a0a34dc0ae40bdbac83ea419a0d8879ff.1561048044.git.dledford@redhat.com>
 <20190621182028.GA22934@ziepe.ca>
 <9864929b96df09102ec801b2e70806cdf266e107.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9864929b96df09102ec801b2e70806cdf266e107.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 21, 2019 at 03:34:28PM -0400, Doug Ledford wrote:
> On Fri, 2019-06-21 at 15:20 -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 20, 2019 at 12:30:17PM -0400, Doug Ledford wrote:
> > > For all string attributes for which we don't currently accept the
> > > element as input, we only use it as output, set the string length to
> > > RDMA_NLDEV_ATTR_EMPTY_STRING which is defined as 1.  That way we
> > > will
> > > only accept a null string for that element.  This will prevent
> > > someone
> > > from writing a new input routine that uses the element without also
> > > updating the policy to have a valid value.
> > > 
> > > Also while there, make sure the existing entries that are valid have
> > > the
> > > correct policy, if not, correct the policy.  Remove unnecessary
> > > checks
> > > for nla_strlcpy() overflow once the policy has been set correctly.
> > 
> > The above commit message paragraph is out of date now.
> > 
> > Otherwise looks OK to me, it would be nice if we could avoid sizing
> > the string in the policy, but OK otherwise.
> > 
> > FWIW this is probably how other netlink users in net are making their
> > use of strings OK. The policy will reliably trigger the EINVAL if the
> > policy length and the buffer length are identical.
> 
> If that's the case, then we can go back to the original patch and drop
> all the checking of string copy overruns because I set all of the policy
> elements on anything that was a valid input to the input size.

Which was fine for things with nice unfrail global values, but the
client_name stack var was not like that.. Maybe just give it some
global value?

Jason
