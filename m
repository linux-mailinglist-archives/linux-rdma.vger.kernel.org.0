Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470A11DCEC4
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2020 15:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgEUN5e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgEUN5d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 May 2020 09:57:33 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34DEC061A0E
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 06:57:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t25so5548234qtc.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2020 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j7W9ywLMQHAeSgXHHVTNW+tEAGYOrqGZv07ChKbPK0U=;
        b=UC3YNsrwFVKRisZpMEplsP4MemzXcHs2vj81ppBIN6u+QlsukFQMFpfP/wOuoRpsX2
         TOEY3i06Z0yMohFFcUJ6GBlg3z/NlgPtBtakmBhP1der+DS4MW89ACNMOeWKpTE52B4L
         XD0JjAtyWbXQhLqs6GKz47ipBd3i1Xf/Co5N5n/u7dFIp+O9Fq6ln7YoT8HkGbM5Hd4W
         6vtX8ltki9tNPQxKobcXRCO/AbHvJ5hcVSZSrUsO2VnLtCdOJFrcLElxEYpt8airZPn1
         43tK+BirsNNpIY9Ylv9X+pucgc3wf3rpRxd9cIuJzOsDsoCa90PjiQsTH6zxdxbKv+RA
         9cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j7W9ywLMQHAeSgXHHVTNW+tEAGYOrqGZv07ChKbPK0U=;
        b=EOdRVzAOJpmoIDVo2HYMBU9ubRtzVTuFu7eSN1L2GN4eq2/MgTiK+g4b2z7E0ddcL0
         DAULaEgWoectDKgf2cIu4zNCapSfl4rupK9WKjfpl2adSaBbOXgY8PyH58Gvv8ZB8dju
         ZYeijomrKuTtb7divinMdN8vVIIX0kFY2jf3o0lPWbVc61nANorztqGuxQAvB5EEXhYa
         agDsgpewxhWZe1sc1joGJ/gBe+pR2jQgbOxtF1ZnfF/SqlJm6NC9Lt6jJAO7ax4O5Muu
         I8xkiljchqNxGZSO66K9rrhwaurUv8fmFkuyPZeQk1MWFD/E2hV2Tl/el2Bbng3WCKbl
         yA5g==
X-Gm-Message-State: AOAM531Z8A9GBJuENEtAZX5JVL+bs1gun8dHmqwaLA/1NYbWFQTBzafH
        ewgtYERjurlGx+1enqXFejAOng==
X-Google-Smtp-Source: ABdhPJw42Pfvx3fAqtlsEi+8Z8QrnAuM5OMrh3xOzg+5cXRvKL+5pU8ZI/vxvgeNCHaam8LkmjT/Pg==
X-Received: by 2002:aed:2291:: with SMTP id p17mr11040190qtc.295.1590069452889;
        Thu, 21 May 2020 06:57:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 197sm4188216qkn.136.2020.05.21.06.57.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 06:57:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jblhT-0006Iz-KQ; Thu, 21 May 2020 10:57:31 -0300
Date:   Thu, 21 May 2020 10:57:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Fix setting of wrong bit in
 get/set_feature commands
Message-ID: <20200521135731.GA17583@ziepe.ca>
References: <20200512152204.93091-1-galpress@amazon.com>
 <20200512152204.93091-2-galpress@amazon.com>
 <20200520000428.GA6797@ziepe.ca>
 <1a80d736-3fde-0aca-f04a-d416742bf3ff@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a80d736-3fde-0aca-f04a-d416742bf3ff@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 20, 2020 at 11:03:00AM +0300, Gal Pressman wrote:
> On 20/05/2020 3:04, Jason Gunthorpe wrote:
> > On Tue, May 12, 2020 at 06:22:03PM +0300, Gal Pressman wrote:
> >> When using a control buffer the ctrl_data bit should be set in order to
> >> indicate the control buffer address is valid, not ctrl_data_indirect
> >> which is used when the control buffer itself is indirect.
> >>
> >> Reviewed-by: Firas JahJah <firasj@amazon.com>
> >> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> >> Signed-off-by: Gal Pressman <galpress@amazon.com>
> >>  drivers/infiniband/hw/efa/efa_com_cmd.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > No fixes line??
> 
> The reason I didn't add a fixes line (and sent it to for-next) is that it turns
> out this is the first set feature command to use a control buffer so nothing was
> broken, but this is necessary for patch #2 to work.

It should probably still have a fixes line in case someone decided to
backport the 2nd patch. But applied without

Jason
