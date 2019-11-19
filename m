Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5CC103049
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 00:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKSXeC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 18:34:02 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36321 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfKSXeC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 18:34:02 -0500
Received: by mail-qk1-f196.google.com with SMTP id d13so19610446qko.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 15:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hA9QFQoG45JVVMi1aurebSP2P02QjvBChlvZ9R3trIw=;
        b=agDxJgM9Q1dlGMmqns87NrgFUAScAzJ01oRfAEsKCtJsELwVZS2g4k5ArHSUm4oToq
         ktjuX7xTTShA+VPQkAlxDJ+I/4zB0Z5AmJNhdxLl4gA/QsTTdZN/g/VO4QrjSszmJ08I
         df4gLoBN1I/cwMmW6/AWncyAdizI7M0rp6XpeoT/p6TD4UmGYHYCovVZdjKpVrbGepgC
         pH8rAe0zxjIHfS4Wky8QprXzireuR0GmasUUmF5FA0UB/fzJbkRLt7dWGorc3KRyhlWc
         C61qIoUnHQ7DRGZer1mn8SeQJ6tGgoi58hh8ogS7DM50UBp4ASZvKHC6vdyyK5fN3M04
         J4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hA9QFQoG45JVVMi1aurebSP2P02QjvBChlvZ9R3trIw=;
        b=Uzh6JWtBB93yPbm8xQYZ79S6aIERl93Ul5oer1NslXxZIlSRoLL8DjUxUaAT/PwHEl
         9NbGxhqoFUYKGMT4yptt5S+Fo0xq5NAqS19QdMSctBFluY8FHDTox99dz1AP9g7PYjWk
         MiqooQXklemsw8GrpHW9o3/jcyMRk9tBaTUqJAUEqUmr///w4P9tVigmXlXFGzECovjL
         j9JBL11faMBkmnPxftOgISQ8pLJumcCSXrlRHLee7uvAmY1zgk4K3N6p2cmkmw4wx+/z
         CMjsfzh4bhdIOHpgxtPsVhmWmaf8f2E+zmZps5x5q1ADW/MzxbWvrt8LOr39EWbk9mUH
         jdmQ==
X-Gm-Message-State: APjAAAXP0VuKj1hvW2GzvjTSnH5WOMguxxNzBXQ7GO9Am53tGztW1LQj
        68RiXzmf5/eHxl243PEGn1GcMiyCeFw=
X-Google-Smtp-Source: APXvYqyQ9r9YWdTK7ROBWh9g3sMAmGePK2QGkH1J0YPyl8UM1QbGZ3pmmK4NkYfYyN0w9bsSRSp6ow==
X-Received: by 2002:a37:945:: with SMTP id 66mr185247qkj.324.1574206441386;
        Tue, 19 Nov 2019 15:34:01 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id j3sm10752480qke.25.2019.11.19.15.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 15:34:00 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iXD0S-00054P-4h; Tue, 19 Nov 2019 19:34:00 -0400
Date:   Tue, 19 Nov 2019 19:34:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Vinit Agnihotri <vinita@ryussi.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [question] ibv_reg_mr() returning EACCESS
Message-ID: <20191119233400.GP4991@ziepe.ca>
References: <141f4c07-b7f1-1355-7ff7-d62605ee63b5@ryussi.com>
 <20191115141210.GC4055@ziepe.ca>
 <cc6543bd-0c8d-40e3-f384-68a847b873b3@ryussi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc6543bd-0c8d-40e3-f384-68a847b873b3@ryussi.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

You need this kernel commit

commit 4785860e04bc8d7e244b25257168e1cf8a5529ab
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Fri Nov 30 13:06:21 2018 +0200

    RDMA/uverbs: Implement an ioctl that can call write and write_ex handlers
    
    Now that the handlers do not process their own udata we can make a
    sensible ioctl that wrappers them. The ioctl follows the same format as
    the write_ex() and has the user explicitly specify the core and driver
    in/out opaque structures and a command number.
    
    This works for all forms of write commands.
    
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
    Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
    Signed-off-by: Doug Ledford <dledford@redhat.com>

And a rdma-core new enough to call UVERBS_METHOD_INVOKE_WRITE

On Mon, Nov 18, 2019 at 10:29:33AM +0530, Vinit Agnihotri wrote:
> Thank you Jason.
> 
> I did went through archives for the same.
> 
> Can you please provide pointer towards documentation or
> 
> sample userspace usage for the same? Or which kernel version to be looked
> into?
> 
> 
> Thanks & Regards,
> 
> Vinit.
> 
> On 15/11/19 7:42 PM, Jason Gunthorpe wrote:
> > On Fri, Nov 15, 2019 at 09:27:40AM +0530, Vinit Agnihotri wrote:
> > > Hi,
> > > 
> > > I am trying to use setfsgid()/setfssid() calls to ensure proper access check
> > > for linux users.
> > > 
> > > However if user is non-root then ibv_reg_mr() returns EACCESS. While I am
> > > sure I am calling ibv_reg_mr()
> > > 
> > > as root user, not sure why it still returns EACCESS.
> > > 
> > > While going through libibverbs sources I realize EACCESS might be returned
> > > by this call:
> > > 
> > > if (write(pd->context->cmd_fd, cmd, cmd_size) != cmd_size)
> > >          return errno;
> > > 
> > > Can anyone provide any insight into this behavior? Does calling these
> > > systems calls in threads can affect
> > > 
> > > entire process? I checked /dev/infiniband/* has appropriate privileges.
> > This is a security limitation, if you want do this flow you need a new
> > enough kernel and rdma-core to support the ioctl() scheme for calling
> > verbs
> > 
> > Jason
