Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B10DDCD8
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 07:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfJTF1m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 01:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfJTF1l (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 01:27:41 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 550EF21D80;
        Sun, 20 Oct 2019 05:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571549261;
        bh=nMGy5ZKAqnobkJtSBUgyJSZHhKzTTgjDHePuqK4mlgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zm7eJMcezkLRn1iqjZ23DE6SVJMNTcWy6UA2bYLHKGByCsq9puM4oN19ABLGCF8Fg
         vixfLM1bOZ8XO4ANdug2KRsumzJI9okGOCQN41aB3c2I0Wv5KgwHBDWdhy4zTSkCrW
         NqTwKZkFdxYE75ZPWlJHlTdSkaVzqDq005Zs6vE0=
Date:   Sun, 20 Oct 2019 08:27:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Rafi Wiener <rafiw@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bodong Wang <bodong@mellanox.com>,
        Oleg Kuporosov <olegk@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Clear old rate limit when closing QP
Message-ID: <20191020052717.GA4853@unreal>
References: <20191002120243.16971-1-leon@kernel.org>
 <cca910c4040961729f0f4d0ad248b6b5684c80eb.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cca910c4040961729f0f4d0ad248b6b5684c80eb.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 17, 2019 at 04:12:04PM -0400, Doug Ledford wrote:
> On Wed, 2019-10-02 at 15:02 +0300, Leon Romanovsky wrote:
> > From: Rafi Wiener <rafiw@mellanox.com>
> >
> > Before QP is closed it changes to ERROR state, when this happens
> > the QP was left with old rate limit that was already removed from
> > the table.
> >
> > Fixes: 7d29f349a4b9 ("IB/mlx5: Properly adjust rate limit on QP state
> > transitions")
> > Signed-off-by: Rafi Wiener <rafiw@mellanox.com>
> > Signed-off-by: Oleg Kuporosov <olegk@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>
> If you are in the process of closing the queue pair, does this solve
> some sort of multi-close race, or is it just being pedantic before
> freeing the qp struct?

It fixes real bug with panic, I didn't add splat, because it had debug
info needed to find this problem.

The nutshell of this bug is how we are storing rate limits:
in one table of global mlx5_core_dev and struct (not pointer) of
mlx5_rate_limit inside mlx5_ib_qp. Such combination still allows
access to rate limit (old one) for ibqp, for example for compare
(mlx5_rl_are_equal).

The best solution is to rewrite rl logic to use pointers, but it was too
much to demand from Oleg and Rafi, who stepped on this bug with their
user space application.

Thanks

>
> I took it regardless, just curious.
>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


