Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECC312FD1C
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 20:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgACTgP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 14:36:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43653 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgACTgO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 14:36:14 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so34922137qtj.10
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 11:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zuUaYNBPZ1N6njG7NelrHir0Zd3pYiOrsH6PxQ5ij80=;
        b=BMywx0qNuxqD/0mSGEj+drgKe+/qw5agj4W1+Zp8Qr20VeXMRnzJpqyUKEJGm/cNtO
         8aGQBTkx2l+5esg4ztDwmbunVr01OwZIn+6FwUF7VGPI7Dh43SVJjJ3HuNdeTcFYCsMb
         jWxgGrAaqbnFtiZTEfZ+rbTlavtO4dT56HIwjctDl93AuppoEg38Y8Pg4NtlXq+X1E84
         doRic8HcIMbOwSKC9eWO8rt2uBr7vSbtZZXJDBMB7amhBbcTJyalWlzluSVPYLfEqPtY
         TeY43SVILaNKGdEFOz1zOY8JkjIp1uaR8WnubNCkP6xwjKdh8q7yiUpC8MumeBLEsvua
         VAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zuUaYNBPZ1N6njG7NelrHir0Zd3pYiOrsH6PxQ5ij80=;
        b=HdPipZLgrKkxKolMUjtM2Ses8CauniBUdIZFwDEFTHel4TIYt9fOxy/Vrx1ODZWGwb
         YMmEV7ZY+1i4cNN7iweKnmGFWgapLkuFJL/MNcAPAo6/54c76UoON/zVIslJdQWGKFOY
         JGeggDlbGuaJs+feb/GqE3lq//XUlulkLNHB0TT7OVyYAPlNK7zAI2FsdOrERY0xlwao
         Jh+Q/MpxQzNLwevavn+QpjyAPDBJnSvPKwHvcYgPSTDZRcTnOyey3WszaToM7t5rt4NS
         F4Xw5dM+CFfkq1YABgGyNkk/52QtSfzi90GA3slH92KJNG7lJqP/i10d4dnJJWNd8wO4
         kJGA==
X-Gm-Message-State: APjAAAWzzF9rW5c7jgnRCXSlxBH7mrUvh+8j3ZOGDyT4HA/zVXTAbFgu
        vIiSefZax13WmKqUcTz1/c4h9KwOAkg=
X-Google-Smtp-Source: APXvYqzgFTgby9b9kb9feeXRfqgQ96llQmigyFe2SL50GnqOpWnH4vIvSB8mJVKMdNUkaA7+iydQLg==
X-Received: by 2002:ac8:7188:: with SMTP id w8mr54331064qto.139.1578080173923;
        Fri, 03 Jan 2020 11:36:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n20sm16727084qkk.54.2020.01.03.11.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 11:36:13 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inSk0-0004Nm-ST; Fri, 03 Jan 2020 15:36:12 -0400
Date:   Fri, 3 Jan 2020 15:36:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 4/6] RDMA/bnxt_re: Refactor device add/remove
 functionalities
Message-ID: <20200103193612.GA16566@ziepe.ca>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
 <1574671174-5064-5-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574671174-5064-5-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 25, 2019 at 12:39:32AM -0800, Selvin Xavier wrote:
>  - bnxt_re_ib_reg() handles two main functionalities - initializing
>    the device and registering with the IB stack.  Split it into 2
>    functions i.e. bnxt_re_dev_init() and bnxt_re_ib_init()  to account
>    for the same thereby improve modularity. Do the same for
>    bnxt_re_ib_unreg()i.e. split into two functions - bnxt_re_dev_uninit()
>    and  bnxt_re_ib_uninit().
>  - Simplify the code by combining the different steps to add and
>    remove the device into two functions.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
>  drivers/infiniband/hw/bnxt_re/main.c | 133 ++++++++++++++++++++---------------
>  1 file changed, 78 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index fbe3192..0cf38a4 100644
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -78,7 +78,8 @@ static struct list_head bnxt_re_dev_list = LIST_HEAD_INIT(bnxt_re_dev_list);
>  /* Mutex to protect the list of bnxt_re devices added */
>  static DEFINE_MUTEX(bnxt_re_dev_lock);
>  static struct workqueue_struct *bnxt_re_wq;
> -static void bnxt_re_ib_unreg(struct bnxt_re_dev *rdev);
> +static void bnxt_re_remove_device(struct bnxt_re_dev *rdev);
> +static void bnxt_re_ib_uninit(struct bnxt_re_dev *rdev);
>  
>  static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
>  {
> @@ -222,7 +223,9 @@ static void bnxt_re_shutdown(void *p)
>  	if (!rdev)
>  		return;
>  
> -	bnxt_re_ib_unreg(rdev);
> +	bnxt_re_ib_uninit(rdev);
> +	/* rtnl_lock held by L2 before coming here */
> +	bnxt_re_remove_device(rdev);

Is this a warning that RTNL is held, or a note that is is required? If
it is the latter then plen use ASSERT_RTNL instead of a comment

Jason
