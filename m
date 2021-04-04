Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4193537BF
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Apr 2021 12:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhDDKOY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Apr 2021 06:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhDDKOX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Apr 2021 06:14:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAA5A61380;
        Sun,  4 Apr 2021 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617531259;
        bh=kGaiu4eCDXIyHJPpus90cTM4tVbLRfcOvw7/mP7u0eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoBRUwZIjZqXCCoYLfH54xaUTi184aQHVI3E9FvVw5EvxSBv2aBlS6rSiSy+mc4sU
         hnrvmeKZQwZl0U7qgrjsj5jH18rnuwoMXIb1mdD42XrrzvWEqUsTDyAVpGT5CDFNl2
         S0Ze+VYPXb/ISFjXHhwRXrpsSNVO1JJ8sdfdfh5kDE/GE1nHgQ0qsEg0o1Y920gwgG
         c9nH8+uE5yelXwAQfPTHsHoqKdUWGD2khurS4CjLvDU5kgClx7yZs1hsMbsA+WixTi
         ZIbCBK9kkKynwm/4d1Y7ne+dg68qYhSsadSFLtbjDntTy07ZoZj9oA3cYaN3dtU84d
         6mUnku3WXRoIg==
Date:   Sun, 4 Apr 2021 13:14:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lang Cheng <chenglang@huawei.com>
Cc:     Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/3] RDMA/hns: Enable all CMDQ context
Message-ID: <YGmRd+ZzaKGrYcQo@unreal>
References: <1617262341-37571-1-git-send-email-liweihang@huawei.com>
 <1617262341-37571-2-git-send-email-liweihang@huawei.com>
 <YGXFtqbcVGLiKfXD@unreal>
 <3782ed3b-f630-8174-5d65-6a458fcdcd8f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3782ed3b-f630-8174-5d65-6a458fcdcd8f@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 02, 2021 at 09:26:38AM +0800, Lang Cheng wrote:
> 
> 
> On 2021/4/1 21:08, Leon Romanovsky wrote:
> > On Thu, Apr 01, 2021 at 03:32:19PM +0800, Weihang Li wrote:
> > > From: Lang Cheng <chenglang@huawei.com>
> > > 
> > > Fix error of cmd's context number calculation algorithm to enable all of
> > > 32 cmd entries and support 32 concurrent accesses.
> > > 
> > > Signed-off-by: Lang Cheng <chenglang@huawei.com>
> > > Signed-off-by: Weihang Li <liweihang@huawei.com>
> > > ---
> > >   drivers/infiniband/hw/hns/hns_roce_cmd.c    | 62 ++++++++++++-----------------
> > >   drivers/infiniband/hw/hns/hns_roce_device.h |  6 +--
> > >   2 files changed, 27 insertions(+), 41 deletions(-)
> > 
> > <...>
> > 
> > > -	WARN_ON(cmd->free_head < 0);
> > > -	context = &cmd->context[cmd->free_head];
> > > -	context->token += cmd->token_mask + 1;
> > > -	cmd->free_head = context->next;
> > > +
> > > +	do {
> > > +		context = &cmd->context[cmd->free_head];
> > > +		cmd->free_head = context->next;
> > > +	} while (context->busy);
> > > +
> > > +	context->busy = 1;
> > 
> > This "busy" flag after do-while together with release in __hns_roce_cmd_mbox_wait()
> > is interesting thing. Are you sure that it won't loop forever here?
> > 
> 
> When initializing resources in hns_roce_cmd_use_events(), ensure that the
> number of semaphores is consistent with the depth of context[].
> 
> int hns_roce_cmd_use_events( )
> {
> 	hr_cmd->context = kcalloc(hr_cmd->max_cmds, ...);
> 	sema_init(&hr_cmd->event_sem, hr_cmd->max_cmds);
> }
> 
> Then, when someone gets the event_sem in hns_roce_cmd_mbox_wait(), it means
> that there must be a not busy context.

OK, thanks

> 
> Thanks.
> 
> > Thanks
> > .
> > 

> null
