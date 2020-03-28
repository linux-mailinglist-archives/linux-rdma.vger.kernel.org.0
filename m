Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A11521969F3
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 00:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgC1XGn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 19:06:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42063 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgC1XGn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 28 Mar 2020 19:06:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id t9so11975595qto.9
        for <linux-rdma@vger.kernel.org>; Sat, 28 Mar 2020 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xiiE4MtXJp9hkPcDnN/sQzesIxVhebufxtu0qtQrjA4=;
        b=bbi60nrZ4ywmQSEb4pSKe69S89HDAHQvuBKySngYK9t4M7i007YgJNkvH53HOCYFat
         X6wsWvNJs1i4rB4/VQjbOn2rpcm6EPAzLbTLEGrmD0jTWG3o2wbmru3Va7N+DMB8ELFY
         f1IS1DdW4Zj+KxRGk0dCELaJv86v8isO9ibjCnysgWVzrQp+R4Fs53fVYtFp98ygy4F3
         LTN4zgLRMW36GrmjpnOl6IFmk8Qxqims/9dxD0BxG3DikQC41JsLqpqHeFBFANbzZsID
         XlRILL8BXJLMdeJYPtm2iWfpQ/NcEPQD6/rkVCr9LFcBAUPhvfvRozWQQDHwLkOdAYmJ
         VxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xiiE4MtXJp9hkPcDnN/sQzesIxVhebufxtu0qtQrjA4=;
        b=eTlqPtx6cCFy9HG7kJLNAv1iyF4f04ZdgqRYxanlE0+JrXr9P5Upg83H3cFmBkLEBD
         0cPm6fkipheLg4i62Sx8T6LagRT0HlItDdFw8BX0PnH5yceGjwbLTZ+sxiHAU4DZurxt
         s+7DPHLQp4JidxGByI5igWDowsBXbuSuyN2FpWKN/1ue61I7RKhTAPBTFEbbd4bRdQCw
         gYN1i3nB4JZ81AgojdI8Gjt+w+OVAyqUFbWFMBBTvav+KQfFFIaz/RbTqYdZFOg0/zjM
         arlEX2Nm4aIuvGN0AWN08QwubLWUItFoSSSnjhi2+ZXWMcMx6REvORv374qaKPi0AO9u
         cw3A==
X-Gm-Message-State: ANhLgQ0ygXPuvTP8mZ439+0ExPxb5LP92lX+qoBam2llmR/Wrw5wkWGK
        ga5yw5nOEtYALHu3zrfmPQP7zg==
X-Google-Smtp-Source: ADFU+vtRJdqd6DLnH7AJC62lsLqGNivqvD/MGWC65hyeHkAUJvj2tViyQIY6BNU7golEoiZHt5tahw==
X-Received: by 2002:ac8:3550:: with SMTP id z16mr5668621qtb.217.1585436801870;
        Sat, 28 Mar 2020 16:06:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h11sm6989944qta.44.2020.03.28.16.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 16:06:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIKXI-0000m5-Cw; Sat, 28 Mar 2020 20:06:40 -0300
Date:   Sat, 28 Mar 2020 20:06:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v11 23/26] block/rnbd: server: sysfs interface functions
Message-ID: <20200328230640.GC20941@ziepe.ca>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-24-jinpu.wang@cloud.ionos.com>
 <8ecc1c47-bad0-dadb-7861-8776b89f0174@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ecc1c47-bad0-dadb-7861-8776b89f0174@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 28, 2020 at 12:31:08PM -0700, Bart Van Assche wrote:
> On 2020-03-20 05:16, Jack Wang wrote:
> > This is the sysfs interface to rnbd mapped devices on server side:
> > 
> >   /sys/devices/virtual/rnbd-server/ctl/devices/<device_name>/
> >     |- block_dev
> >     |  *** link pointing to the corresponding block device sysfs entry
> >     |
> >     |- sessions/<session-name>/
> >     |  *** sessions directory
> >        |
> >        |- read_only
> >        |  *** is devices mapped as read only
> >        |
> >        |- mapping_path
> >           *** relative device path provided by the client during mapping
> > 
> 
> > +static struct kobj_type ktype = {
> > +	.sysfs_ops	= &kobj_sysfs_ops,
> > +};
> 
> From Documentation/kobject.txt: "One important point cannot be
> overstated: every kobject must have a release() method." I think this is
> something that Greg KH feels very strongly about. Please fix this.

more importantly you can't implement kobjects correctly without a
release so there is some bug in here.

Jason
