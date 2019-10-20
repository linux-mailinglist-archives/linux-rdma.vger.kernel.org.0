Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F4CDDD5A
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 10:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfJTIzE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 04:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfJTIzE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Oct 2019 04:55:04 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B4E8218BA;
        Sun, 20 Oct 2019 08:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571561703;
        bh=BRR/yP/FRWHv36DJZyO0jKl41SAS2hPBbxoDlq2/xNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBYIvjBpYMQwguRvH+cwigSQNHPlRGXOyhcvMBWjsRJ2qjYt6t5kZBSxEEzUt72xr
         /lqTkqV1L/MNazc1oKJ9uBoGRpyFxlRk9RUP/lWZ5cP9Sfaa26ACFHRff/9hzMUdRX
         0kbMEM+Bo+w0N6/K1BDUkNLoN/zIIv9OpJAfBljU=
Date:   Sun, 20 Oct 2019 11:54:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Or Gerlitz <gerlitz.or@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH rdma-next 4/6] RDMA/cm: Delete useless QPN masking
Message-ID: <20191020085459.GD4853@unreal>
References: <20191020071559.9743-1-leon@kernel.org>
 <20191020071559.9743-5-leon@kernel.org>
 <CAJ3xEMjmTnmdzaUoHreZVYyVMxwKi6W9qOGsweisO1uyzfVnKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ3xEMjmTnmdzaUoHreZVYyVMxwKi6W9qOGsweisO1uyzfVnKg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 11:48:39AM +0300, Or Gerlitz wrote:
> On Sun, Oct 20, 2019 at 10:18 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > QPN is supplied by kernel users who controls and creates valid QPs,
>
> AFAIK this can also arrive from user-space, agree?

Not in this path, anyway we are masking it again while writing
to the spec struct,

>
> > such flow ensures that QPN is limited to 24bits and no need to mask
> > already valid QPN.
