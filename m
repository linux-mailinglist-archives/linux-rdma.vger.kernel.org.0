Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8A15C04D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2020 15:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgBMO2V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 09:28:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42971 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMO2V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Feb 2020 09:28:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id r5so4463396qtt.9
        for <linux-rdma@vger.kernel.org>; Thu, 13 Feb 2020 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r0RlfLcqIUwkSA7VxqzqkyT+4hV7hsl+i/zcvS6bOrk=;
        b=ns4FinbbHS7kVBjbRv+7/rpzQVjth+eC5QN+F3psQIWBqwfEHxcO9dtmdMhV18Wo0t
         ziz9LTlcAOiBaVtghKnHOII/gZ5Y3L+TOGwpxfsvGJI/yxg5B5fZ2uwOuQhLKCcXI7/a
         gFg4zd58Kh4oHj/Jeve+LQiUriE5NKYq2VD6tR+3shRhf3UVkhAWCPL4VTdqtoG2ho+E
         yc2vcfmANZtlQxsnJTOEsB6JFC15iC4uFgBLL/uCZsi85up20MnCdVSn6zrr+ojdAzlz
         K6ijARP8MMYs9+CwdWPI4PomujYwdKXcce1hYC8Bz3I3VM8RCNr418nUmh/yGZ5yxl25
         IvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r0RlfLcqIUwkSA7VxqzqkyT+4hV7hsl+i/zcvS6bOrk=;
        b=jBYYoy3zh5gv87jJCr9OcABuegps7OayqpVkm2cYcR3sIaDPKw4gqfMFv7eyXf6Loo
         2+JaJpDiAkSXaGsFOpdfOQcjDwrbpM4kTApj2VchqLNEIOldy8AAV9KihDgZ+Tl4qYXR
         u1GTTjG4FOjgBoUHc1yyYZmvQqhDVl4mS0BXMUjrMOCPeRF8MJ3DpNX3pkEHI+G7/RW4
         HhMo7LBY7hwOkBXLRlPRi3fp7QhGtnsrI0wCSaQWpN4ICP7sJ2G3fCsNgljwq6R4G9Re
         mBgt8kVP+U3VV0AQkCYeh5J2gUYs8RIP7qS5+M8Z1hfwDLYn6XKqj+EnGXorFWRNSan6
         AHUw==
X-Gm-Message-State: APjAAAWxgcirqURI7+H0EPFR2bSjbFbrZCNkL24O8rBiQFsEFSuyjxLW
        l1WBrGDghXCPpaMbargBqXfjtFRQeDb15Q==
X-Google-Smtp-Source: APXvYqxd8JFLsOs7rQumzXI41ANdLU044qaAKu4RnItr9XIO40YSIvh6lRkTOvD5iIPpkseKLFIe3A==
X-Received: by 2002:ac8:a83:: with SMTP id d3mr12029129qti.228.1581604099673;
        Thu, 13 Feb 2020 06:28:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v2sm1516968qto.73.2020.02.13.06.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 06:28:19 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2FTW-0004MB-MO; Thu, 13 Feb 2020 10:28:18 -0400
Date:   Thu, 13 Feb 2020 10:28:18 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH rdma-rc 8/9] IB/umad: Fix kernel crash while unloading
 ib_umad
Message-ID: <20200213142818.GA16120@ziepe.ca>
References: <20200212072635.682689-1-leon@kernel.org>
 <20200212072635.682689-9-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212072635.682689-9-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 12, 2020 at 09:26:34AM +0200, Leon Romanovsky wrote:
> From: Yonatan Cohen <yonatanc@mellanox.com>
> 
> When unloading ib_umad, remove ibdev sys file 1st before
> port removal to prevent kernel oops.
> 
> ib_mad's method ibdev_show() might access a umad port
> whoes ibdev field has already been NULLed when rmmod ib_umad
> was issued from another shell.
> 
> Consider this scenario
> 	         shell-1            	shell-2
> 	        rmmod ib_mod    	cat /sys/devices/../ibdev
> 	            |           		|
> 	        ib_umad_kill_port()        ibdev_show()
> 	     port->ib_dev = NULL	dev_name(port->ib_dev)
> 
> kernel stack
> PF: error_code(0x0000) - not-present page
> Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
> RIP: 0010:ibdev_show+0x18/0x50 [ib_umad]
> RSP: 0018:ffffc9000097fe40 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffffffffa0441120 RCX: ffff8881df514000
> RDX: ffff8881df514000 RSI: ffffffffa0441120 RDI: ffff8881df1e8870
> RBP: ffffffff81caf000 R08: ffff8881df1e8870 R09: 0000000000000000
> R10: 0000000000001000 R11: 0000000000000003 R12: ffff88822f550b40
> R13: 0000000000000001 R14: ffffc9000097ff08 R15: ffff8882238bad58
> FS:  00007f1437ff3740(0000) GS:ffff888236940000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000004e8 CR3: 00000001e0dfc001 CR4: 00000000001606e0
> Call Trace:
>  dev_attr_show+0x15/0x50
>  sysfs_kf_seq_show+0xb8/0x1a0
>  seq_read+0x12d/0x350
>  vfs_read+0x89/0x140
>  ksys_read+0x55/0xd0
>  do_syscall_64+0x55/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9:
> 
> Fixes: e9dd5daf884c ("IB/umad: Refactor code to use cdev_device_add()")

This is the wrong fixes line, this ordering change was actually
deliberately done:

commit cf7ad3030271c55a7119a8c2162563e3f6e93879
Author: Parav Pandit <parav@mellanox.com>
Date:   Fri Dec 21 16:19:24 2018 +0200

    IB/umad: Avoid destroying device while it is accessed
    
    ib_umad_reg_agent2() and ib_umad_reg_agent() access the device name in
    dev_notice(), while concurrently, ib_umad_kill_port() can destroy the
    device using device_destroy().
    
            cpu-0                               cpu-1
            -----                               -----
        ib_umad_ioctl()
            [...]                            ib_umad_kill_port()
                                                  device_destroy(dev)
    
            ib_umad_reg_agent()
                dev_notice(dev)

The mistake in the above was to move the device_dstroy() down, not
split it into device_del() above and put_device() below.

Now that is already split we are OK.

Jason
