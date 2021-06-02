Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD04D39899D
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 14:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhFBMf0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 08:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhFBMfZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 08:35:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6BCB613B8;
        Wed,  2 Jun 2021 12:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622637222;
        bh=miRjTtiZRHo1tSKbaixL/u5ulDWB0rxCGkUBBVp+0KA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O14GwIcsULtb08iz9QHq1xNXsFYmE0k6Thx/ScK8ZEd19iF2vofsVg0XP1hifQoL8
         2xZ32vVox8M3g4sAXF7DDeehA4qJXAYWuDvFkJN84GMW/EYEpLGv2feFslniYDJpJl
         Yc38ZexnKxdu5Ge8yqjy1zPOo72ud3qInKC1xblOf1nc7+WSuGd01ZaBcwBCVJSnSn
         MaxOosdxO1gdXl+YTsUnTbEqxC3ETLG6giMLOKL6fSxqE1lpKwxLL85TPlDOXwCCI5
         NagjT7NjGbSjvQGqjsOchCgmNk1kIxhPftN+SKpxJy3SH5FwqPUSnSVF8I9ncf6/th
         AWtBFSC/d+XcQ==
Date:   Wed, 2 Jun 2021 15:33:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     linux-rdma@vger.kernel.org, lizhijian@fujitsu.com
Subject: Re: rdma_get_cm_event error behaviour defined?
Message-ID: <YLd6o7p6+29Sjdtq@unreal>
References: <YKJAKy1oNcTd7sRn@work-vm>
 <YLYXBD9jupPOslnR@unreal>
 <YLYasCUuuNMpag2M@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLYasCUuuNMpag2M@work-vm>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 01, 2021 at 12:32:00PM +0100, Dr. David Alan Gilbert wrote:
> * Leon Romanovsky (leon@kernel.org) wrote:
> > On Mon, May 17, 2021 at 11:06:35AM +0100, Dr. David Alan Gilbert wrote:
> > > Hi,
> > >   Is 'rdma_get_cm_event's behaviour in initialising **event
> > > defined in the error case?
> > >   We don't see anything in the manual page, my reading of the
> > > code is it's not set/changed in the case of failure - but is
> > > that defined?
> > >   It would be good if the manpage could explicitly state it.
> > 
> > AFAIK, the general practice do not rely on any output argument if
> > function returns an error and I'm not sure that the man update is
> > needed.
> 
> The case we had was whether we needed to clean up or not in the error
> case; the original code in qemu was:
> 
>     2496     ret = rdma_get_cm_event(rdma->channel, &cm_event);
>     2497     if (ret) {
>     2498         perror("rdma_get_cm_event after rdma_connect");
>     2499         ERROR(errp, "connecting to destination!");
>     2500         rdma_ack_cm_event(cm_event);
>     2501         goto err_rdma_source_connect;
>     2502     }
> 
> and Li spotted that rdma_ack_cm_event  would seg in the case
> rdma_get_cm_event failed.

man page says that you should rdma_ack_cm_event() on success only.

   14 All events which are allocated by rdma_get_cm_event must be released,
   15 there should be a one-to-one correspondence between successful gets
   16 and acks.  This call frees the event structure and any memory that it
   17 references.

> 
> While I agree on not relying on an output; without a definition you're
> stuck between not knowing if you're leaking an event that should
> have been cleaned up.

You are not supposed to have rdma_ack_cm_event() in your snippet.

Thanks
