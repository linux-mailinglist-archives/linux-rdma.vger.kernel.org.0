Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E36C231D66
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 13:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgG2LeW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 07:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2LeW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Jul 2020 07:34:22 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822202074B;
        Wed, 29 Jul 2020 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596022462;
        bh=LF77AgKtx8AW/eGItl5WWLIag8oZekd8TsL3B4/Y+ZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFtyjQaIB1XxBmVTnBcq4+EWqhFcPRZRRQ/OSd3ZJA+o9xpm/F8q/kIGtWt3ppMcS
         s4HKMwtdxZJxc+OMiLnyr3s/tKAKk74DKYDcWgxyv1vAGtME/f9A2vjmlOsbAEoO+n
         Pxjf8ufEobm0Iop/732K1RmLPHLxMrfLGWMutBZ4=
Date:   Wed, 29 Jul 2020 14:34:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     sagi@grimberg.me, yaminf@mellanox.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, bvanassche@acm.org,
        israelr@mellanox.com, oren@mellanox.com, jgg@mellanox.com,
        idanb@mellanox.com
Subject: Re: [PATCH 1/3] IB/iser: use new shared CQ mechanism
Message-ID: <20200729113417.GG75549@unreal>
References: <20200722135629.49467-1-maxg@mellanox.com>
 <b922a13b-592b-0c03-bd0e-c7b6c7d4a54e@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b922a13b-592b-0c03-bd0e-c7b6c7d4a54e@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 29, 2020 at 11:34:11AM +0300, Max Gurtovoy wrote:
> Jason/Leon,
>
> can you please pull this to "for-kernel-5.9" branch please ?
>
> Or do we need more reviews on this series ?

I don't think so, Sagi and Bart are more than enough.

Thanks
