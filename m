Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1E9B150741
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 14:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgBCNa4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 08:30:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgBCNa4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Feb 2020 08:30:56 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10CF220721;
        Mon,  3 Feb 2020 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580736655;
        bh=l1hGlV6EJjRK63ezMZBBQm4f35pY9nw/Z8Cb5oARWPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4jCHWiwsbjZHlzi4PhbG1m+bDCMmIRw3r+aoul+y4HySUO/EbRFDvA1WSbPCj90h
         TQjbXIwXFQvgQpbTYV27WDTiyl6semGMEkgCeDR4r6ozkvHQ9irPq4zwkeuN3GgXhT
         nynTwBoMXHo7xy5Gz/WRGW5rDYHeZh4SqG9fF2wg=
Date:   Mon, 3 Feb 2020 15:30:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Frank Huang <tigerinxm@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: a strange lock
Message-ID: <20200203133050.GP414821@unreal>
References: <CAKC_zSu1SQgNT5Yyg49qe+r+hux-3oCqzZPvH0b7pjaPz2x2Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKC_zSu1SQgNT5Yyg49qe+r+hux-3oCqzZPvH0b7pjaPz2x2Rw@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 03, 2020 at 08:31:10PM +0800, Frank Huang wrote:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/infiniband/core/cma.c#n1832
>
> /*
> * Wait for any active callback to finish.  New callbacks will find
> * the id_priv state set to destroying and abort.
> */
> mutex_lock(&id_priv->handler_mutex);
> mutex_unlock(&id_priv->handler_mutex);
>
> It does nothing between the lock, what 's the meaning of it?

It is a way to implement wait_for_completion paradigm, by ensuring
that all cm_id works or will see RDMA_CM_DESTROYING state (they need
to take handler_mutex, before every call to cma_exch), or will
complete their execution and release handler_mutex.

Thanks
