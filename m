Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E261D6DCC
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 00:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgEQWRi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 18:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgEQWRi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 18:17:38 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB99C05BD09
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 15:17:37 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id p12so6598918qtn.13
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZtCqJbSzSTr/mOw+zKYStT6YhJmMRVpkZgqWDpAi5Rc=;
        b=N++WCpXD1D22zxXcHIsrPS8nLDn5EvvJtiwTQzSsRZEhwh0LHzSwsw8SQpsyXbGhhd
         M512aYEuRlvzCm7a1lOxh4OMUKbVsKxCseVpwzyZRI5hZbqv0j0Id6CaSM3PH++VsjoE
         jdYLYF+sk08HFfKpx18ViLDEXESDc+40y2cwdpAD1Nn5kwe0klahuoc75jRaPAt/zhXv
         qgvE+yTHcSAVsqG/cdjoX/41y46ovWBTQiyZoXcsWV8AdENFfAJjxle09f4oit58sYkQ
         bZe89i1yp0lB9ebCP/lLJwG2/ENX8RQLuM94b/GjrWkROJ77PzYbRwHF/HCxPCT8ELty
         8EpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZtCqJbSzSTr/mOw+zKYStT6YhJmMRVpkZgqWDpAi5Rc=;
        b=rbeWO6awVu11iHMndPQVxn1heM/PARgjzFpTbhAGP1ZzJJZlT7BskV4JhJL0BBBzKG
         OIuwRWjGXggAs37wLIHWftXlBBM9U/ulhlB8q5rr9Zn032JPHubLGqyZHfmHjVGAUWQD
         WprpTfJZtbqYwG8D34A38rycVycJ5gLxxV9XECbXIagta/sMmlLeO96bTkG+RgC12T8C
         /wVTULZgBmeKhkD6mFcLwvaE3iQleiCHA6/osIrbVnjPDtIXl+eleNCppA4pJOMamOy3
         EhqK6xW0wpq/fPGJzkzoeTlDqTFNQqsFD+nIpzr5+ENiC86heQhWiclZ17BKFQvb5Fa3
         eRKg==
X-Gm-Message-State: AOAM530ZDfncGuazUPL/g7czkKJYX1Pim0ifRPEgPqHHsOaVHo1ommyw
        U41ppYi9LGXBBTE2T3GTqgsVzbJAiVY=
X-Google-Smtp-Source: ABdhPJy0NyBiPigc2ASavOe6gEb8l61SV5QZ4f5YpPfRhBRGoN8rY6fPnU2/L/8G76IL3eariMSSjQ==
X-Received: by 2002:aed:2fe2:: with SMTP id m89mr13895278qtd.124.1589753857029;
        Sun, 17 May 2020 15:17:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p2sm6807869qkm.41.2020.05.17.15.17.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 15:17:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaRbD-0003RG-LP; Sun, 17 May 2020 19:17:35 -0300
Date:   Sun, 17 May 2020 19:17:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v15 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
Message-ID: <20200517221735.GA13057@ziepe.ca>
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 11, 2020 at 03:51:06PM +0200, Danil Kipnis wrote:
> Hi all,
>  
> Here is v15 of the RTRS (former IBTRS) RDMA Transport Library and the
> corresponding RNBD (former IBNBD) RDMA Network Block Device, which
> fixes the issues in Makefile in V14 reported-by
> the kbuild test robot (see changelog below). The patchset applies for
> kernel v5.7-rc5.

I don't particularly enjoy having another ULP for a single use case,
but I think Ionos has shown commitment to use and maintain this, so
lets go ahead.

Applied to for-next, with Jen's ack for the block part

There will be probably be a stream of complaints from linux next in
the next weeks or so. Remember the merge window is probably in 2
weeks, so deal with them promptly please.

Thanks,
Jason
