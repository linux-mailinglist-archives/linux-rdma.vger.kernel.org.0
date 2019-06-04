Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4B034FB6
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2019 20:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfFDSPo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jun 2019 14:15:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33363 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFDSPo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jun 2019 14:15:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id 14so14946641qtf.0
        for <linux-rdma@vger.kernel.org>; Tue, 04 Jun 2019 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2AVnwxn/Q1pA8yF2ApeB1vPhUb5YTZoVKn4E5jQwD4Q=;
        b=JFGQY1DkFMPSOVi1PApUljiMYBEZn0Fu3uFCphBv7qbg00tfWlmqxrWXUzWqDomSwq
         +onM/yg7cVzpXFB/M0ZBm/xcc1c74pyBDzK9C5NGqPwSfX47f2bGjOzqrObiVDxoirj5
         aLA1h35ykZQXynoIB834h7uRvrQieh1ChABKoGhvKnhzfukX44MtJtgIiRjI5VkTbYvu
         tRxHSdOqRlDcsmKvG9qMt1baygZqTKmPjtBQ23s/831JH+fpPYDYmEms+9WDHjNH5h79
         UauKvAsm0WJmfw+6wWLqGvr0l1ignUBMRx6MJJ7TenRv3U+mbzMiLuILm79BDyG4aw/E
         5MUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2AVnwxn/Q1pA8yF2ApeB1vPhUb5YTZoVKn4E5jQwD4Q=;
        b=W7WqJKnRAe4CQhPdCN9HYXa65nqJtPL21Vi2w58hOKy2vLlpmHJa4eVtAEQReo46ln
         1/TZycvO8IrMEMpTwRunUFbNirv2FSmqj5aJeMbKZUDB9QMzCwYKez0rY/9QeIphsm3i
         OJsfb9Nh+KXqlyUz56/KCsAwS4RE7eWrxPTvIaWoO8o+UQo4yVQDzRxSBjnDp8V+ver/
         Yjb27pbtP2qppZ3LNq30IRZSkE060Jc2gfhO508jHXu+hexkYg0fFjK052YmKv6xKTHD
         pegzDCuZCsIK8XeKJz5tPMbONKPNmnW+syDvfBj571WsqYKG5kaJir9SzLrqBScKnRcQ
         4XsQ==
X-Gm-Message-State: APjAAAVTBSOLNDydYbt2VeWPkrfN4GyT6Kz3AfLIfY0Ky1uguAzvpcyJ
        AGxIrsbmbfCjdhfazyOZyNOGa9ipZ7cOcA==
X-Google-Smtp-Source: APXvYqwaKrAnlC+sus35uwV5TvOjJjXzbr9DlReCCWM7QAqFyFu78Hpjy8xtqdSPnEnGo4yEW01zgw==
X-Received: by 2002:a05:6214:1c2:: with SMTP id c2mr9498273qvt.71.1559672142851;
        Tue, 04 Jun 2019 11:15:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a51sm11360292qta.85.2019.06.04.11.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 11:15:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYDyG-000202-Sj; Tue, 04 Jun 2019 15:15:40 -0300
Date:   Tue, 4 Jun 2019 15:15:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v1 00/12] SIW: Software iWarp RDMA (siw) driver
Message-ID: <20190604181540.GE15385@ziepe.ca>
References: <20190603174948.GA13214@ziepe.ca>
 <20190526114156.6827-1-bmt@zurich.ibm.com>
 <OF2964C589.75C558D3-ON0025840F.004421F3-0025840F.0060CBAD@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2964C589.75C558D3-ON0025840F.004421F3-0025840F.0060CBAD@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 04, 2019 at 05:37:15PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 06/03/2019 07:50PM
> >Cc: linux-rdma@vger.kernel.org
> >Subject: [EXTERNAL] Re: [PATCH for-next v1 00/12] SIW: Software iWarp
> >RDMA (siw) driver
> >
> >On Sun, May 26, 2019 at 01:41:44PM +0200, Bernard Metzler wrote:
> >> This patch set contributes the SoftiWarp driver rebased for
> >> Kernel 5.2-rc1. SoftiWarp (siw) implements the iWarp RDMA
> >> protocol over kernel TCP sockets. The driver integrates with
> >> the linux-rdma framework.
> >> 
> >> With this new driver version, the following things where
> >> changed, compared to the v8 RFC of siw:
> >> 
> >> o Rebased to 5.2-rc1
> >> 
> >> o All IDR code got removed.
> >> 
> >> o Both MR and QP deallocation verbs now synchronously
> >>   free the resources referenced by the RDMA mid-layer.
> >> 
> >> o IPv6 support was added.
> >> 
> >> o For compatibility with Chelsio iWarp hardware, the RX
> >>   path was slightly reworked. It now allows packet intersection
> >>   between tagged and untagged RDMAP operations. While not
> >>   a defined behavior as of IETF RFC 5040/5041, some RDMA hardware
> >>   may intersect an ongoing outbound (large) tagged message, such
> >>   as an multisegment RDMA Read Response with sending an untagged
> >>   message, such as an RDMA Send frame. This behavior was only
> >>   detected in an NVMeF setup, where siw was used at target side,
> >>   and RDMA hardware at client side (during file write). siw now
> >>   implements two input paths for tagged and untagged messages each,
> >>   and allows the intersected placement of both messages.
> >> 
> >> o The siw kernel abi file got renamed from siw_user.h to siw-abi.h.
> >> 
> >> Many thanks for reviewing and testing the driver, especially to
> >> Steve, Leon, Jason, Doug, Olga, Dennis, Gal. You all helped to
> >> significantly improve the siw driver over the last year. It is
> >> very much appreciated.
> >
> >You need to open a PR for rdma-core before this can be merged with
> >the
> >userspace part.
> >
> >Jason
> >
> >
> 
> OK I created PR #536, which adds the siw user library to
> rdma-core. Unfortunately, when uploading, travis brought
> up many issues with atomics etc. Is there a good way to
> have the very same strict checking locally, since local build
> was always successful...

$ buildlib/cbuild build-images travis # once
$ buildlib/cbuild pkg travis

You'll need docker installed

> In any case, sorry for abusing the PR procedure for code cleanup
> (amending commits and force push cycles)!

It is fine, this is what travis is for..

Jason
