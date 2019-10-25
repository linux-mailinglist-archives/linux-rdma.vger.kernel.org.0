Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B537BE4A8D
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Oct 2019 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390578AbfJYL41 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Oct 2019 07:56:27 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:31710 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfJYL41 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Oct 2019 07:56:27 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x9PArCFF012211;
        Fri, 25 Oct 2019 03:53:13 -0700
Date:   Fri, 25 Oct 2019 16:23:12 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Raju Rangoju <rajur@chelsio.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] RDMA/iw_cxgb4: Avoid touch after free error in ARP
 failure handlers
Message-ID: <20191025105310.GA5562@chelsio.com>
References: <20191025104111.GA12120@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025104111.GA12120@mwanda>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Friday, October 10/25/19, 2019 at 16:11:11 +0530, Dan Carpenter wrote:
> Hello Raju Rangoju,
> 
> The patch 1dad0ebeea1c: "RDMA/iw_cxgb4: Avoid touch after free error
> in ARP failure handlers" from May 15, 2017, leads to the following
> static checker warning:
> 
> 	drivers/infiniband/hw/cxgb4/cm.c:4310 process_work()
> 	warn: 'skb' was already freed.
> 
> drivers/infiniband/hw/cxgb4/cm.c
>   4289  static void process_work(struct work_struct *work)
>   4290  {
>   4291          struct sk_buff *skb = NULL;
>   4292          struct c4iw_dev *dev;
>   4293          struct cpl_act_establish *rpl;
>   4294          unsigned int opcode;
>   4295          int ret;
>   4296  
>   4297          process_timedout_eps();
>   4298          while ((skb = skb_dequeue(&rxq))) {
>   4299                  rpl = cplhdr(skb);
>   4300                  dev = *((struct c4iw_dev **) (skb->cb + sizeof(void *)));
>   4301                  opcode = rpl->ot.opcode;
>   4302  
>   4303                  if (opcode >= ARRAY_SIZE(work_handlers) ||
>   4304                      !work_handlers[opcode]) {
>   4305                          pr_err("No handler for opcode 0x%x.\n", opcode);
>   4306                          kfree_skb(skb);
>   4307                  } else {
>   4308                          ret = work_handlers[opcode](dev, skb);
>   4309                          if (!ret)
>   4310                                  kfree_skb(skb);
> 
> I'm not sure why this warning didn't show up before... :(
> 
> We added some kfree_skb() calls to _put_ep_safe() and _put_pass_ep_safe().
> The thing about kfree_skb() is that it's refcounted so it might not
> free anything so this could be a false positive.  I've looked at the
> code and it looks like it could be a bug?
Hi Dan,
Thanks for the check.
I have observed this and looks like the kfree_skb() in _put_ep_safe() and 
_put_pass_ep_safe() are not needed as the skb is anyway freed by process_work()
I have checked the refcounts before kfree_skb() for _put_ep_safe() and
_put_pass_ep_safe() and they are '1' by simulating the error, so I believe 
kfree_skb() in process_work() should just be enough.
I have tested the patch to remove the kfree_skb() from _put_ep_safe() and
 _put_pass_ep_safe(). It runs fine.

Thanks,
Bharat.

> 
>   4311                  }
>   4312                  process_timedout_eps();
>   4313          }
>   4314  }
> 
> regards,
> dan carpenter
