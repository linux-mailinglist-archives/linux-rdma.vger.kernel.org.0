Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBC12AC671
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Nov 2020 21:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgKIUyy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Nov 2020 15:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKIUyy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Nov 2020 15:54:54 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E88FC0613CF
        for <linux-rdma@vger.kernel.org>; Mon,  9 Nov 2020 12:54:54 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id 13so4790837qvr.5
        for <linux-rdma@vger.kernel.org>; Mon, 09 Nov 2020 12:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZWfCBVb6wdh86JJY+JHZAzKgRO6yO3kF5gcqfRdc/XE=;
        b=RGQUc1i+sxmsUcaYRXj6AGhL/tSQvMOR9P2qRxJil9ZhV2V5Jlrh68grkfTk3yia7Z
         Op3G0kIWOJBeqBGH849j2cmorhXN0c4cTgUnFwDeNpkjzUbMwM3x26eU3lmFAjCtQDbT
         CLE6y/iV0nZxlmDI1pnKq8kH/17KcImqjYRyTUYmBHfVHXt64uuS9QS6vw6pKjsnfYzd
         vuKihFEbwJoRF7kLTtJydJg5SSuBv50YcOJgVda3is0cb05vBS1U0d3d8ptg5thFCeY6
         LotCkTumcfuFOECshfN3HAN1AEjiy5xXCde4oy3YKjD+LrZk29aDvkpVyRrAWCM2+sl4
         9CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWfCBVb6wdh86JJY+JHZAzKgRO6yO3kF5gcqfRdc/XE=;
        b=og7MJDdg9LY738CHaVuuiYRLZ8ikgelOairsb7LEo8b8xXlLFZxmzQdmmGEkkiSnc8
         RBQ8y46SF2U+DTid7xn7dj6bTUXlbz3YYRjJGKoQ+7BgRCIWcFn2kaydI15aF9BnPUh9
         HmYDlmYeuw+2Jb3ixVzDJu3w6ib9FzHYgSqzLw7LgE9IVjwzVyx5Ta38kbc5ncJ50FUm
         DrGXYypg/IlsGwxzC63z/W7e43whjiIGAauFGxTdJTXosNtDhuWC7+p5HhCnrPUmA2yc
         QJ2BVeZ+BVdfZ786yYHd4Roc/nab7MEuyPIo4DpQQnYEEsz9BMGOfzo7M1DQy29ZIjqK
         o9YQ==
X-Gm-Message-State: AOAM533e6fk4OwKWg09W/uxnvs7Fx3Dm3AH8DVeaubyRlbNv231GvjKp
        AhupuANiG/P4PkBUemHgs+AxzQ==
X-Google-Smtp-Source: ABdhPJwgIkXIR1vtoQiV7Ey971G0RSO/aAn38DNq+nnoSmm43OB68r9Nhg47k7XxI4GCjc8Fx7VbdA==
X-Received: by 2002:ad4:57a6:: with SMTP id g6mr6091574qvx.27.1604955293447;
        Mon, 09 Nov 2020 12:54:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x31sm6779466qtb.81.2020.11.09.12.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:54:52 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kcEBg-0026z5-47; Mon, 09 Nov 2020 16:54:52 -0400
Date:   Mon, 9 Nov 2020 16:54:52 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjunz@nvidia.com>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>
Subject: Re: [PATCH] RDMA/siw,rxe: Make emulated devices virtual in the
 device tree
Message-ID: <20201109205452.GI244516@ziepe.ca>
References: <0-v1-dcbfc68c4b4a+d6-virtual_dev_jgg@nvidia.com>
 <677434b0-7482-2a11-ae80-7f9f9563aad0@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <677434b0-7482-2a11-ae80-7f9f9563aad0@acm.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 06, 2020 at 05:04:24PM -0800, Bart Van Assche wrote:
> On 11/6/20 6:00 AM, Jason Gunthorpe wrote:
> > This moves siw and rxe to be virtual devices in the device tree:
> > 
> > lrwxrwxrwx 1 root root 0 Nov  6 13:55 /sys/class/infiniband/rxe0 -> ../../devices/virtual/infiniband/rxe0/
> > 
> > Previously they were trying to parent themselves to the physical device of
> > their attached netdev, which doesn't make alot of sense.
> > 
> > My hope is this will solve some weird syzkaller hits related to sysfs as
> > it could be possible that the parent of a netdev is another netdev, eg
> > under bonding or some other syzkaller found netdev configuration.
> > 
> > Nesting a ib_device under anything but a physical device is going to cause
> > inconsistencies in sysfs during destructions.
> 
> Hi Jason,
> 
> I do not know enough about the code touched by this patch to comment on
> the patch itself. But I expect that the blktests code will have to be
> modified to compensate for this change. How to translate the name of a
> virtual RDMA device into a netdev device with this patch applied?

$ rdma link
link rxe0/1 state ACTIVE physical_state LINK_UP netdev eth1 

Is the correct way

Jason
