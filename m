Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FB71E13F0
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 20:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbgEYSPh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 14:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbgEYSPg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 14:15:36 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60506C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 11:15:36 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id v15so8358299qvr.8
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 11:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4oc6+KJENdkLyDcBMJZbiD9PuuEYBYJUhM2Tc0NW2eo=;
        b=cFtWSXT9GIQdNvpV01FnNaUohwABWGC2YIBzgENpbAFEW7aoXmS1cNLAWWcODoYZmB
         77tdO0ejsM6nPOxKUCqnxl0wpd2hU7yx0dqAYJhy7CoHVXgFDEwy7HY7xB/ivp6/15xr
         p9KQ0ADh8XYt0rsirnc8z7bz+Q5bbbljkZwCgSOFyi9oFokti+VjqAxraKcbmwF9h8IV
         O0pyDP95tgHOYr5SdNh8VqVt1CzLMG2W3QUgsFGiKLLffk6b5yB10zvjh81jzOFDXn+p
         +26f25U60+gnHftH1klCkk5XviHHKCWSoMFNvdwxQtirDHXcQsnCPw0H1PUSpxif/RsT
         oMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4oc6+KJENdkLyDcBMJZbiD9PuuEYBYJUhM2Tc0NW2eo=;
        b=ReMFlPN65mcnsGPnPnDpv8DmFi6l4miT9hNqeGGIfmx7ofOy+K7SZ3tZQCUdynvosI
         xEgwcXfvoTTMfaLu3s5ggdUp17q6h87fP7cTTVWZWKTkXBgFA3fQhx++kNwHB81dToGv
         O+g0iXit50dBxLcvfXDfjhQJFvach7Ga4qySpfWHNQhlTPhL9RyPDpFufAtCL7WR8nu5
         PK4C5Doc2YA6mbJ7CwD02SbPfTE9DX2bjkXAGeBgO1VHFNGj4P6dYcQ63lI+E9ZDANNu
         PMvga8Sj4CVv0MBtWBeAf89Lah4you5YFXKrWuwZuYqnC2jJ9VkQxThHN4i+2ZcJTqes
         q4MA==
X-Gm-Message-State: AOAM530YPCHwf9NZZaFmP4rr5a1GDQhCz1lNu9Y3E/9gD8o/gdeoaAt0
        8HmkKz9olxismFnmiTex6xeH4KlenU8=
X-Google-Smtp-Source: ABdhPJz8o5wkhtDsAZVpxuz/YjDBCbDExpZ4B3bdC3LzxJlzTtgllZ6+sTjTUE7QhfWG32dtuoYUlg==
X-Received: by 2002:a05:6214:ca:: with SMTP id f10mr17281698qvs.185.1590430535647;
        Mon, 25 May 2020 11:15:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l1sm9407752qtl.3.2020.05.25.11.15.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 11:15:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdHdO-00079D-Rj; Mon, 25 May 2020 15:15:34 -0300
Date:   Mon, 25 May 2020 15:15:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 3/7] RDMA/ucma: Extend ucma_connect to
 receive ECE parameters
Message-ID: <20200525181534.GH744@ziepe.ca>
References: <20200413141538.935574-1-leon@kernel.org>
 <20200413141538.935574-4-leon@kernel.org>
 <20200525174141.GA24366@ziepe.ca>
 <20200525174739.GH10591@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525174739.GH10591@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 08:47:39PM +0300, Leon Romanovsky wrote:
> On Mon, May 25, 2020 at 02:41:41PM -0300, Jason Gunthorpe wrote:
> > On Mon, Apr 13, 2020 at 05:15:34PM +0300, Leon Romanovsky wrote:
> >
> > > -	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
> > > +	in_size = min_t(size_t, in_len, sizeof(cmd));
> > > +	if (copy_from_user(&cmd, inbuf, in_size))
> > >  		return -EFAULT;
> > >
> > >  	if (!cmd.conn_param.valid)
> > > @@ -1086,8 +1089,13 @@ static ssize_t ucma_connect(struct ucma_file *file, const char __user *inbuf,
> > >  		return PTR_ERR(ctx);
> > >
> > >  	ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
> > > +	if (offsetofend(typeof(cmd), ece) <= in_size) {
> > > +		ece.vendor_id = cmd.ece.vendor_id;
> > > +		ece.attr_mod = cmd.ece.attr_mod;
> > > +	}
> >
> > The uapi changes in the prior patch should be placed in the patches
> > that actually implement them, eg one here..
> 
> I wanted to simplify the series and keep its bisectable at the same
> time. Should I squash them?

Yes, the two structs should be introduced in the patches that populate
them, that is the usual wy.

> > > diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
> > > index 71f48cfdc24c..86a849214c84 100644
> > > +++ b/include/rdma/rdma_cm.h
> > > @@ -264,6 +264,17 @@ int rdma_init_qp_attr(struct rdma_cm_id *id, struct ib_qp_attr *qp_attr,
> > >   */
> > >  int rdma_connect(struct rdma_cm_id *id, struct rdma_conn_param *conn_param);
> > >
> > > +/**
> > > + * rdma_connect_ece - Initiate an active connection request with ECE data.
> > > + * @id: Connection identifier to connect.
> > > + * @conn_param: Connection information used for connected QPs.
> > > + * @ece: ECE parameters
> > > + *
> > > + * See rdma_connect() explanation.
> > > + */
> > > +int rdma_connect_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
> > > +		     struct rdma_ucm_ece *ece);
> >
> > kdoc's go in the C files
> 
> I know, but didn't know if to follow existing pattern or not.

I've been of the opinion that new code should follow the expected
style.

Trying to keep some huge matrix of certain files have certain legacy
exceptions is too hard on my brain.

Jason
