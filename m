Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B75422F962
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 21:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgG0Tqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 15:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0Tqx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jul 2020 15:46:53 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2710C061794;
        Mon, 27 Jul 2020 12:46:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E5FF9127768A9;
        Mon, 27 Jul 2020 12:30:07 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:46:52 -0700 (PDT)
Message-Id: <20200727.124652.1347094721322555381.davem@davemloft.net>
To:     jgg@nvidia.com
Cc:     colin.king@canonical.com, mkalderon@marvell.com,
        aelior@marvell.com, dledford@redhat.com, irusskikh@marvell.com,
        alobakin@marvell.com, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: fix assignment of n_rq_elems to incorrect params
 field
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200727161739.GA60250@nvidia.com>
References: <20200727141712.112906-1-colin.king@canonical.com>
        <20200727161739.GA60250@nvidia.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 27 Jul 2020 12:30:08 -0700 (PDT)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>
Date: Mon, 27 Jul 2020 13:17:39 -0300

> On Mon, Jul 27, 2020 at 03:17:12PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>> 
>> Currently n_rq_elems is being assigned to params.elem_size instead of the
>> field params.num_elems.  Coverity is detecting this as a double assingment
>> to params.elem_size and reporting this as an usused value on the first
>> assignment.  Fix this.
>> 
>> Addresses-Coverity: ("Unused value")
>> Fixes: b6db3f71c976 ("qed: simplify chain allocation with init params struct")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/infiniband/hw/qedr/verbs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> DaveM will need to take this since the Fixed patch is in his tree,
> thanks.

Applied to net-next, thanks everyone.
