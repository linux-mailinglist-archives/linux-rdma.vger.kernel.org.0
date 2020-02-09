Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C395156AEC
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Feb 2020 15:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgBIO5k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Feb 2020 09:57:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgBIO5k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 9 Feb 2020 09:57:40 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 361E920733;
        Sun,  9 Feb 2020 14:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581260259;
        bh=4XVPW0fRJ5NlFJm2qZ1lpi/YtEUv6R1dFTz6ggXQG9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z5d/bG/ibkbZIwzjRjN53ZCivR1Vf9JN1TNErvFaQ/HpcplrZbwfCQqOz+Aeaif1t
         edni+nHB5MDgmC6jJAincijS9zs1zDlnrv/7ith/5Iw4ASvaPDkq8n6ZTYKbaDGBLs
         4+9RKFoYLu8nA098G1kkbp4RJhlw9KK0jcGl5HNE=
Date:   Sun, 9 Feb 2020 16:57:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: maximum QP size
Message-ID: <20200209145736.GG13557@unreal>
References: <CAOc41xHpF5VXK_-L_BeaU9v842BuRd2QTXkZunDKDgiEhixFtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOc41xHpF5VXK_-L_BeaU9v842BuRd2QTXkZunDKDgiEhixFtg@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 06, 2020 at 09:18:00PM -0800, Dimitris Dimitropoulos wrote:
> Hi,
>
> I'm running the ibv_rc_pingpong example and I notice as as rx-depth
> increases the QP create fails, eg at 50k. My understanding is this
> variable controls the number of RECV WR that will be posted in advance
> before SEND WRs are posted.
>
> Is there a limitation on the queue size (the size is unit32_t) and if
> so why ? Also is there a way around it ?

The rx-depth is translated to the size of completion queue buffer.
That buffer used by hardware to post completions - writing completion
queue elements (CQEs) and it is allocated when creating the CQ.

Maximum number of CQEs can be retrieved by the ibv_devinfo -v, see max_cqe field.

Thanks

>
> Regards
> Dimitris
