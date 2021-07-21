Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE983D0A05
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 09:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhGUHKB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 03:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235869AbhGUHJR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 03:09:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 083A9611C1;
        Wed, 21 Jul 2021 07:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626853793;
        bh=NiAJktv7ds+8oKSDNOTKvzGUhZmEmpyNWO4ZqNTOKkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFr9PKZEaWZ1nQXZa8lR21YIcIUfrVKgjHhFCCLi9A2jWAlMSs7erV26W8yLyyzro
         04j5UUqK1bk4ho7WtzCjq6clfuczklHHke6g6a1CP2ds7RTgWM6zqG0AwHGirYaY6J
         WuBeozLqluxktzZXhZDQmKwscn/UZV72hQTT6CYSJbA8V/msE67dsVzgO5iQiZlucS
         SxUEgzlfw6tot/u9pgPZmSI9qMkyL4hdLmqHhSStX6wN0IjNOKh9hpkQPaMbFfgTTl
         IgtPDTJGikFSwZ93sRfp7Kpylrwpwl8sBFlsJ9gr26dPGIEQyrD/5ZBknoICyvPXub
         PefzkmH5tX3oA==
Date:   Wed, 21 Jul 2021 10:49:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-next 4/7] RDMA/core: Reorganize create QP low-level
 functions
Message-ID: <YPfRnt4XeMIgZnn/@unreal>
References: <cover.1626846795.git.leonro@nvidia.com>
 <328963df8e30bfc040c846d2c7626becd341f3ec.1626846795.git.leonro@nvidia.com>
 <11e8e739-99b4-8ebe-38e1-de36b21b0f25@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11e8e739-99b4-8ebe-38e1-de36b21b0f25@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 21, 2021 at 03:47:34PM +0800, Mark Zhang wrote:
> On 7/21/2021 2:13 PM, Leon Romanovsky wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The low-level create QP function grew to be larger than any sensible
> > incline function should be. The inline attribute is not really needed
> > for that function and can be implemented as exported symbol.
> 
> incline -> inline?

Thanks

> 
> 
