Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88693373C
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2019 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfFCRtv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jun 2019 13:49:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44328 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfFCRtu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jun 2019 13:49:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so10406888qtk.11
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jun 2019 10:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qZx9JW6oeq0PhklcBLISNgQmWnPDVjEknVAZMSrcqTw=;
        b=WRtGVjVOyD6HzGR2LOlVMBKveJNJxEXFSLjfj3CvGu2209K7JaN+hWoBJ+hjynQsuP
         d65/WnOB/W9Zxdppu21Wq52a0oTLKMOBzfPLqfuJCUhPUs32TpEtEpEjPpKQJoXxWUhq
         hqd563VCcaI30pJOvkOtOC2BRpYLFoBSXTuoLqlxukWP2B1oe8UFv4+77a2bnBaJiOFX
         144CseZp7yFGN5BGrzLZSVPSoHv9sYn8g7osnCMZ+ZFpi5HrOI1FQM/J1BCDa5YTyVV9
         LVM7IdizVXdqI+f0C/f10g/qXF3PeRBQ5v+5Tjyux7gu0k53q14nxltczGyfP1YXKEJC
         ep5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qZx9JW6oeq0PhklcBLISNgQmWnPDVjEknVAZMSrcqTw=;
        b=V+8I+l3ISzxzxDDxDBeJSy7e4jHH+j9nRSh5t3jntAUELU/VY8Fjgiv2e/IDdwyInX
         tEHOrQdd1tqvYwOweDhoIDgtXNpN+KkMqzINlbNiuqA7hDgFYLlSd8PxuDuq1/v2N9sf
         KHKiO4Ea+sWk7m5EvQ5P2ZTEAjwbAvjaKqOPq9+MCLI7nlPaJ+DcaDZCMQo1Cxb68g3R
         2leZ11zXWBdnaZOXA7pT3sxrNWYHTIJ0Ij0MmlUr+cWmJHk5rf7n+5AuJ8wGJ4xmyFw4
         zYHD6w1l9NB7f/GbIOuT3tgq5b2GIEiK+5ebXhM1Zg83vIBn2W5Ki9XubZY2nANYiDS9
         90HQ==
X-Gm-Message-State: APjAAAUCOuGIXhaXZAVbVeCMdzZsNcvKFlE0dr134P6cJ7eIZ0/oyhxZ
        f+uKWRLS91BYxiGF8UGTynD5jA==
X-Google-Smtp-Source: APXvYqx91Qn/+7YvFaBJ8q+19AyJZ82lWm0oeK/esWjaqcxpYv+LjbxmhMUbgb6lsmP3fOSNqTpbCA==
X-Received: by 2002:ac8:2fb7:: with SMTP id l52mr3936004qta.93.1559584189909;
        Mon, 03 Jun 2019 10:49:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s35sm379768qts.10.2019.06.03.10.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 10:49:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hXr5g-0003Rg-RB; Mon, 03 Jun 2019 14:49:48 -0300
Date:   Mon, 3 Jun 2019 14:49:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v1 00/12] SIW: Software iWarp RDMA (siw) driver
Message-ID: <20190603174948.GA13214@ziepe.ca>
References: <20190526114156.6827-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526114156.6827-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 26, 2019 at 01:41:44PM +0200, Bernard Metzler wrote:
> This patch set contributes the SoftiWarp driver rebased for
> Kernel 5.2-rc1. SoftiWarp (siw) implements the iWarp RDMA
> protocol over kernel TCP sockets. The driver integrates with
> the linux-rdma framework.
> 
> With this new driver version, the following things where
> changed, compared to the v8 RFC of siw:
> 
> o Rebased to 5.2-rc1
> 
> o All IDR code got removed.
> 
> o Both MR and QP deallocation verbs now synchronously
>   free the resources referenced by the RDMA mid-layer.
> 
> o IPv6 support was added.
> 
> o For compatibility with Chelsio iWarp hardware, the RX
>   path was slightly reworked. It now allows packet intersection
>   between tagged and untagged RDMAP operations. While not
>   a defined behavior as of IETF RFC 5040/5041, some RDMA hardware
>   may intersect an ongoing outbound (large) tagged message, such
>   as an multisegment RDMA Read Response with sending an untagged
>   message, such as an RDMA Send frame. This behavior was only
>   detected in an NVMeF setup, where siw was used at target side,
>   and RDMA hardware at client side (during file write). siw now
>   implements two input paths for tagged and untagged messages each,
>   and allows the intersected placement of both messages.
> 
> o The siw kernel abi file got renamed from siw_user.h to siw-abi.h.
> 
> Many thanks for reviewing and testing the driver, especially to
> Steve, Leon, Jason, Doug, Olga, Dennis, Gal. You all helped to
> significantly improve the siw driver over the last year. It is
> very much appreciated.

You need to open a PR for rdma-core before this can be merged with the
userspace part.

Jason
