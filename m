Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD38B2A7845
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 08:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKEHtZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 02:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgKEHtY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 02:49:24 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D433C0613D3
        for <linux-rdma@vger.kernel.org>; Wed,  4 Nov 2020 23:49:24 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id cw8so1212875ejb.8
        for <linux-rdma@vger.kernel.org>; Wed, 04 Nov 2020 23:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HiHN7cEc9FvAFXuwqXLWF0XbMGI5NJnlheI3AC/p0Rk=;
        b=sDW2kw2WIZtOBBqP3OLvBf0PZR4l//kVfPnpgjZLMq0vnE4tjG4Ig8z5tff+gOMOP0
         snGDBlsMM8PeDWRiOvFXKxwsoy/1Xtb6Xcc7mo4BQMPh/IrM38WXigtT7wQwr6ggUOjR
         dnfFwV5wvxh5jl5IGJroHGHpfEDC4ES+wgWgBUaJCOqtZ8QG5P0CUCQzNp78U2eeV7O5
         yCCmjn+yqQ4xcVOlwAcacEw2ny9JMCkuwMdXa4VYdR8fSYj/JM2Oeviqgge95DNvbHBt
         rfnzbtVc3h3BTVvE+MV5I+onfG+QEpeqBoYtXw43J1bzbdBKp+zHOxdL3J2AqKAJxUFO
         MhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HiHN7cEc9FvAFXuwqXLWF0XbMGI5NJnlheI3AC/p0Rk=;
        b=Slpnf4D3vxzZLiP/s8OJ0XySnRiv76F1ZBA9RzhV/Hca7w6gGod3hJeANzd+RhbAgA
         K3kMVB8UEfFfXimV6WLpM+yB5vOWx7wpiTUNv6ZN7HNJ4fB7a8QteWvlbxCS3eHxhk8t
         hOjoGOKrk1nNG8KSpbLqXGoEF58GRMdHny3Gq8LdytIDnM+okHxKbADH7+s5wvv0A9qa
         vkT5MX7rPnkWngQzKXpOLorGOLxr2BmOQfFTGPSXNjvzoruqPpz3NIaQ5UK1VT/5wQ51
         SASk6NkZFalCIuBtO67Y9S09Vdqk5sTY+psFBwzg3WFLapr/livk8mZ6p/Pz38ooqi4M
         b8tA==
X-Gm-Message-State: AOAM531cKHnGDXlv0opFHgKdygA8c4JAi37/rHIU+GivIxhtfywgN5J+
        FdiSGID7Cu/2CJ9bA/ylCGG3iLtMTQow3I9X7YXdVQ==
X-Google-Smtp-Source: ABdhPJzMyeNcHa42GSktT9mkjMahMnmlITf9LkRgdVukR/ujD9xIfq3TSrJb0lT83dAIiwc3ssEcu4HrZhS0QU6AnNw=
X-Received: by 2002:a17:906:4306:: with SMTP id j6mr1091381ejm.523.1604562563054;
 Wed, 04 Nov 2020 23:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20201101201542.2027568-1-leon@kernel.org> <20201101201542.2027568-7-leon@kernel.org>
 <20201103154525.GO36674@ziepe.ca> <CAPcyv4jP9nFAGdvB7agg3x7Y7moHGcxLd5=f5=5CXnJRUf3n9w@mail.gmail.com>
 <20201105073302.GA3415673@kroah.com>
In-Reply-To: <20201105073302.GA3415673@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Nov 2020 23:49:11 -0800
Message-ID: <CAPcyv4iJZNsf9fnx2BkyCG9ECm85mFshaoxaZ3=kzMz-2-hCQQ@mail.gmail.com>
Subject: Re: [PATCH mlx5-next v1 06/11] vdpa/mlx5: Connect mlx5_vdpa to
 auxiliary bus
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Netdev <netdev@vger.kernel.org>, Parav Pandit <parav@nvidia.com>,
        Roi Dayan <roid@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Patil, Kiran" <kiran.patil@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David M Ertman <david.m.ertman@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 4, 2020 at 11:32 PM gregkh <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 04, 2020 at 03:21:23PM -0800, Dan Williams wrote:
> > On Tue, Nov 3, 2020 at 7:45 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > [..]
> > > > +MODULE_DEVICE_TABLE(auxiliary, mlx5v_id_table);
> > > > +
> > > > +static struct auxiliary_driver mlx5v_driver = {
> > > > +     .name = "vnet",
> > > > +     .probe = mlx5v_probe,
> > > > +     .remove = mlx5v_remove,
> > > > +     .id_table = mlx5v_id_table,
> > > > +};
> > >
> > > It is hard to see from the diff, but when this patch is applied the
> > > vdpa module looks like I imagined things would look with the auxiliary
> > > bus. It is very similar in structure to a PCI driver with the probe()
> > > function cleanly registering with its subsystem. This is what I'd like
> > > to see from the new Intel RDMA driver.
> > >
> > > Greg, I think this patch is the best clean usage example.
> > >
> > > I've looked over this series and it has the right idea and
> > > parts. There is definitely more that can be done to improve mlx5 in
> > > this area, but this series is well scoped and cleans a good part of
> > > it.
> >
> > Greg?
> >
> > I know you alluded to going your own way if the auxiliary bus patches
> > did not shape up soon, but it seems they have and the stakeholders
> > have reached this consensus point.
> >
> > Were there any additional changes you wanted to see happen? I'll go
> > give the final set another once over, but David has been diligently
> > fixing up all the declared major issues so I expect to find at most
> > minor incremental fixups.
>
> This is in my to-review pile, along with a load of other stuff at the
> moment:
>         $ ~/bin/mdfrm -c ~/mail/todo/
>         1709 messages in /home/gregkh/mail/todo/
>
> So give me a chance.  There is no rush on my side for this given the
> huge delays that have happened here on the authorship side many times in
> the past :)

Sure, I was more looking to confirm that it's worth continuing to
polish this set given your mention of possibly going a different
direction.

> If you can review it, or anyone else, that is always most appreciated.

Thanks, will do.
