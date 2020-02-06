Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4EF154B02
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 19:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgBFSW4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 13:22:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36761 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgBFSWz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Feb 2020 13:22:55 -0500
Received: by mail-qk1-f194.google.com with SMTP id w25so6520196qki.3
        for <linux-rdma@vger.kernel.org>; Thu, 06 Feb 2020 10:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DFZckoeIAHaHqFi2Cw0rXqd65Qsk59NQ0HtgDj8IRkk=;
        b=cyNy8MEPpI8yCllu/p3JSKwr0r7A7qChulpB4EC9wHl7LjphBwFqba+ReZVFhuAMCH
         nk1mtRPvY5ESEujMVDkOQ5J+zTrwG1bszg8cFw6Ev4jinvQkzGCWTeU0V6g8/ZtpKEV+
         7znO78E7ixo2qZ7qcZ048Euic432w3kqahCnSaS4bXIGjHzmWOcU1ANxEUA9tHSbBpsj
         oeoISht3fFwP5Cb7vpaOvLtbVDuUeY21d2ME8BX6jixTv1uKLUhlXZFFEMkRDpjmbUfW
         +2NnIWhgifYNnUf6FO8cmr95ZTdNTkRGDWCUWzfmHPd8BUgrlVtghcnDRJ9hJKrQED9z
         W4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DFZckoeIAHaHqFi2Cw0rXqd65Qsk59NQ0HtgDj8IRkk=;
        b=aq31iYJK9L4BBwQ6uDspMLVqRr2q3zNSK0NQ4wdk8TMWfI2rxA8hWpltktvP/1YN1v
         UjTh0go6ccpizMVODQJzsXaO30uPFFTTETRl3JFkB677ojyTHgfQOe9KB+HoY95mbqRw
         EyNhCbYW6ODSJfXxbSJ3QTxoELPLQ+DCIVOJE/IFywy0jPia1iZiwQyRacATY+edCLjU
         4vd+5a+QIZaXJ/K+xPiCSOkc80r/Im85BYh7Uj9G02VSMnpbaypRpVspVloC5p7UZchY
         2UULCe3CgAAFlZo2Goo4mLJbIuPYRhftUMdCCeA8FKPC3wlx39MSXuG8cUv9jvEvSl2g
         1zZQ==
X-Gm-Message-State: APjAAAXeProK1Bh6mG+cLm8+hgqi2lPStzJteWCw+5hIE2lKOcSLIN7L
        U8RFlXD0MvgNtafUW299XUlOrg==
X-Google-Smtp-Source: APXvYqx2tXuG3rmaKyq3RhM0bPVF5QM1EnLNCLzulIa3+M1Q+tlUsZDvNIwpb3c6/HLYJtHA6Trnsw==
X-Received: by 2002:a37:6296:: with SMTP id w144mr2009185qkb.25.1581013374744;
        Thu, 06 Feb 2020 10:22:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id r1sm20205qtu.83.2020.02.06.10.22.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 10:22:54 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1izlnh-0001ZM-LC; Thu, 06 Feb 2020 14:22:53 -0400
Date:   Thu, 6 Feb 2020 14:22:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     "Goldman, Adam" <adam.goldman@intel.com>,
        linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
Message-ID: <20200206182253.GI25297@ziepe.ca>
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
 <20200205191227.GE28298@ziepe.ca>
 <daa60df0-04e1-d33c-fdc9-5a3fea2688cb@intel.com>
 <20200205205402.GC25297@ziepe.ca>
 <0f9fd27d-4bb8-b51d-1fdc-20a5b0d5d9e2@intel.com>
 <20200206135226.GE25297@ziepe.ca>
 <0706151d-836d-c1e3-6cfb-d10d6eb7d2f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0706151d-836d-c1e3-6cfb-d10d6eb7d2f1@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 06, 2020 at 12:51:58PM -0500, Dennis Dalessandro wrote:
> On 2/6/2020 8:52 AM, Jason Gunthorpe wrote:
> > On Wed, Feb 05, 2020 at 04:59:11PM -0500, Dennis Dalessandro wrote:
> > > > I would actively block an attempt to try and do an end-run around
> > > > upstream like this. rdma-core is supposed to be the defacto
> > > > configuration, not be modified randomly by distros as before.
> > > 
> > > No but users should be free to name their devices how they want should they
> > > not?
> > 
> > Isn't that exactly why PSM is broken?
> > 
> > These days I can do
> > 
> > $ rdma link add hfi1_0 type siw netdev eth0
> > 
> > and PSM will become very confused.
> > 
> > This is why keying off the device name was *never* OK.
> > 
> > > > Why isn't psm keying off it's own chardev anyhow? There should be back
> > > > links to the RDMA device in sysfs from there.
> > > 
> > > No arguments here. No sense in going down this road though at this point in
> > > the game.
> > 
> > I'm not sure what these means? Are you saying you won't be fixing PSM? Why?
> > 
> 
> It's not worth going through the same to have a cdev or not argument over
> again.

What do you mean? You already have the extra cdev. It has a stable
name - I see hfi1_%d used as the pattern.

It even creates a class called hfi1

If you want to enumerate devices of this class readdir on
/sys/class/hfi1. This is yours, it will have only your devices. This
is what should have been done from the beginning.

If you want to find the RDMA parent then
readlink("/sys/class/hfi1/hfi1_xx/") + "/../.." should give it to you

Assuming the driver doesn't screw up the usage of sysfs.. Oh, right,
it does, and that never did get fixed.

The struct hfi1_devdata can not have both a struct kobj and a struct
ib_device as inline members. It *should not* have a kobject at all, it
should be using cdev_device_add() and specifying the ib_device as the
parent. Due to these mistakes I suppose the hfi1_x chardev is placed
incorrectly in sysfs.

So you fix it all up. Fix the kernel, fix the psm, etc. You insistend
on this extra char dev, you need to take responsibility to make sure
it is done properly and doesn't interfere with the rest of the system.

Jason
