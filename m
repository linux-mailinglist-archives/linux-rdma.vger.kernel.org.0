Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECE1162F89
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 20:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgBRTNx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 14:13:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35973 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRTNx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 14:13:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id t83so3645230qke.3
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 11:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4MqPI0YZVcJ/M7z1uH3QC/Xv1dQK0BRIdqeCvbipMks=;
        b=ipsElP0XPsQQ2fPxzFqNikjRhNwB3jhR8D9LakryBAtLieFmRSEEN3+jagsEjoMQ5e
         lCJ1sUZROrSCcxSV9faAr9kMEi1tZ0c+/PtFSQAdaqUcvNXHmJFBoPxv5uSKmG9k3J54
         Za7aRdnNTGdBYxCWCrUapOAClMrM7yRNqjIJ+ySmKDFfb+lUcCtOGnUxQInp0nZUjwd+
         jmc/MfhJKXOFYbtSMcWpKQEZUO+Lro7KKpND/g2He55/48IZXHSLYYTU3lfwvezXuDY2
         ZfpuWXElO47JbJdVgMOU4Uf550aPd0p6qsdUKOshlZls5t+GRtJxZufgT4xA5X6/OSLg
         F5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4MqPI0YZVcJ/M7z1uH3QC/Xv1dQK0BRIdqeCvbipMks=;
        b=B/BHL1vEPZkma/HeRzOFqlTpAzYquSh4L06OQqRAibP4ZXCFMokKCQwEuZqnFXehib
         Bcso0W5/F6OuoQaBnCKCQCDXS08LnEvyt1tohClvBPqEBVpuxpj6r39gthpDXqjIWELh
         BodNZhdyr18UAFl2uS92qCVMcW2tfTNj+UNIf/w2lxy5tMR3uZSgaQMIiA0uDszXR30K
         Z+Om1vcHxUWzbV6RjxqhUAoJ4LxBEAjru7jh+zPesKbwOPvtFB4yib4qYnWhsQRCyJ7T
         aOsFWurpcv4A8/ZLHImls4ZVJ6K9CCN7WZjpACIrXHy5frPhUE3nCQq5bBaHBJJ0wZu5
         FahA==
X-Gm-Message-State: APjAAAWgguQL3ao/pnJnhqyROVN/bylRswvIdq+qlPFso850gjvw1GQD
        dBf+h4qEDk8DqBPG9oAVzqgOvA==
X-Google-Smtp-Source: APXvYqz8MrchkirmhWmNcA2YqGMSBfxoA932vCwGMydC7f/hhr/dTBtPdloragljniYb2ZhPcJyiRg==
X-Received: by 2002:a05:620a:999:: with SMTP id x25mr19893529qkx.87.1582053232761;
        Tue, 18 Feb 2020 11:13:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 132sm1953505qkn.109.2020.02.18.11.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 11:13:52 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j48Jb-0007dJ-GR; Tue, 18 Feb 2020 15:13:51 -0400
Date:   Tue, 18 Feb 2020 15:13:51 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+adb15cf8c2798e4e0db4@syzkaller.appspotmail.com>,
        chuck.lever@oracle.com, danielj@mellanox.com, danitg@mellanox.com,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in rdma_listen (2)
Message-ID: <20200218191351.GF31668@ziepe.ca>
References: <00000000000012a4cd05854a1d0a@google.com>
 <20200218122717.10748-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218122717.10748-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 08:27:17PM +0800, Hillf Danton wrote:
> Check if rdma is being reclaimed before listening on device while
> reclaimer is waiting for rdma to become quiesce.

This is the usual syzkaller bug in rdma_cm

The test causes rdma_resolve_addr() and rdma_listen() to run
concurrently.

There is no sane locking, so in turn this causes invariants to become
violated, in particular, in rdma_listen() we can have !id->device
but also !cma_any_addr(cma_src_addr(id_priv).

This causes cma_listen_on_all() to wrongly be called and because the
invariant is screwed up cma_cancel_listens() doesn't undo it.

Thus we fail to list_del id_priv->list from the listen_any_list and
the next manipulation of the list gets a use-after on the list member
which was now freed.

The fix is the same as all the others, add some kind of locking
instead of all this defective cma_comp_exch() thing..

Jason
