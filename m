Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF28036304
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 19:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfFERxD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 13:53:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32974 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfFERxD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 13:53:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id 14so19050136qtf.0
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AeFSC6JZEucsA+9VKl55xzUeFGWhtF5/RIMEh7mJJKQ=;
        b=fmD75cR98GEEROfRtKD0MgRkAxxkWONCPcvLl7CVuvrssDOnt421lG6mbORtC1dMdf
         BZ5BhGC/igA4phLVNFreA1wYafpxmUGBGZV3wcr7nzmIpEffkQxdLNdPdfRnIXZf7Ue8
         qYeV7biABx8O8rhoBppHC1I7nPRg2TiQtAyIsdfvvAGmfnsMS6otwPAXau7GnNlV4yP1
         GMcPJlT3RAYTd3nafWyugaTpLVIcU/PVaeP0vebxP5bBf6yleSJM2w24mooMnkuvcSOW
         j6hX8bbRYZLuWuvjkmkJvBmx80QCey7nd5+e2UOLxQhN8hCYctkLZNNy3N9HxwGEi0Nv
         Vo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AeFSC6JZEucsA+9VKl55xzUeFGWhtF5/RIMEh7mJJKQ=;
        b=c8kvzMiZwkJk/qBeIDaqVz+s+Fbhfi5E9ogTfFtNL+/iNMgSrYGn6atjJ4e9N9RM3h
         KI7UsDCSk7Ie1sTvwJQV8Yeh93pUhf6fgNn8wDkFuoJXfXBGYKYiCLzlZmQbhaeI+vap
         vdg5NLHbYnPZDI8Kz2KAMh6umMPylyKqTdTNm9SVUOQjoVK2vqnmYTwFMK4XLFAZA7JU
         P8gV5Q39tX5/a2CxoSQTRLEgi7ulV3sEq05Tc8oZoyuApr+/IIVGrwdGCcCgqvfmVO03
         pDtL+S4oVrBIHBP2aoajTMWEAvWSHOq/X/vrIkqPjd8w5wkx20dnReznxuumUnwAahHl
         qkOw==
X-Gm-Message-State: APjAAAU+3HPJ+Z6BCXU2OAhhOOXFU2si2cbfnaS8IN0hnvrXggMOlrBi
        1Yct5TmJbj5OTjUG4To+DZuntVdCeQ4Iug==
X-Google-Smtp-Source: APXvYqz1vB5F2MFRttuHI81DD8GEl2cEFPolOn764g3Se1+W/cQqPzFv1TiBwgBFVIHqMVLFsv7ZnA==
X-Received: by 2002:ac8:7545:: with SMTP id b5mr27285503qtr.234.1559757181805;
        Wed, 05 Jun 2019 10:53:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l3sm9850283qtj.1.2019.06.05.10.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 10:53:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYa5s-0001Ku-G3; Wed, 05 Jun 2019 14:53:00 -0300
Date:   Wed, 5 Jun 2019 14:53:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Re: [PATCH for-next v1 00/12] SIW: Software iWarp RDMA (siw)
 driver
Message-ID: <20190605175300.GA3273@ziepe.ca>
References: <20190604181540.GE15385@ziepe.ca>
 <20190603174948.GA13214@ziepe.ca>
 <20190526114156.6827-1-bmt@zurich.ibm.com>
 <OF2964C589.75C558D3-ON0025840F.004421F3-0025840F.0060CBAD@notes.na.collabserv.com>
 <OFF1828D60.768472D6-ON00258410.004A926D-00258410.004B2F1C@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF1828D60.768472D6-ON00258410.004A926D-00258410.004B2F1C@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 01:41:12PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 06/04/2019 08:26PM
> >Cc: linux-rdma@vger.kernel.org
> >Subject: [EXTERNAL] Re: [PATCH for-next v1 00/12] SIW: Software iWarp
> >RDMA (siw) driver
> >
> >On Tue, Jun 04, 2019 at 05:37:15PM +0000, Bernard Metzler wrote:
> >> 
> >> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >> >Date: 06/03/2019 07:50PM
> >> >Cc: linux-rdma@vger.kernel.org
> >> >Subject: [EXTERNAL] Re: [PATCH for-next v1 00/12] SIW: Software
> >iWarp
> >> >RDMA (siw) driver
> >> >
> >> >On Sun, May 26, 2019 at 01:41:44PM +0200, Bernard Metzler wrote:
> >> >> This patch set contributes the SoftiWarp driver rebased for
> >> >> Kernel 5.2-rc1. SoftiWarp (siw) implements the iWarp RDMA
> >> >> protocol over kernel TCP sockets. The driver integrates with
> >> >> the linux-rdma framework.
> >> >> 
> >> >> With this new driver version, the following things where
> >> >> changed, compared to the v8 RFC of siw:
> >> >> 
> >> >> o Rebased to 5.2-rc1
> >> >> 
> >> >> o All IDR code got removed.
> >> >> 
> >> >> o Both MR and QP deallocation verbs now synchronously
> >> >>   free the resources referenced by the RDMA mid-layer.
> >> >> 
> >> >> o IPv6 support was added.
> >> >> 
> >> >> o For compatibility with Chelsio iWarp hardware, the RX
> >> >>   path was slightly reworked. It now allows packet intersection
> >> >>   between tagged and untagged RDMAP operations. While not
> >> >>   a defined behavior as of IETF RFC 5040/5041, some RDMA
> >hardware
> >> >>   may intersect an ongoing outbound (large) tagged message, such
> >> >>   as an multisegment RDMA Read Response with sending an untagged
> >> >>   message, such as an RDMA Send frame. This behavior was only
> >> >>   detected in an NVMeF setup, where siw was used at target side,
> >> >>   and RDMA hardware at client side (during file write). siw now
> >> >>   implements two input paths for tagged and untagged messages
> >each,
> >> >>   and allows the intersected placement of both messages.
> >> >> 
> >> >> o The siw kernel abi file got renamed from siw_user.h to
> >siw-abi.h.
> >> >> 
> >> >> Many thanks for reviewing and testing the driver, especially to
> >> >> Steve, Leon, Jason, Doug, Olga, Dennis, Gal. You all helped to
> >> >> significantly improve the siw driver over the last year. It is
> >> >> very much appreciated.
> >> >
> >> >You need to open a PR for rdma-core before this can be merged with
> >> >the
> >> >userspace part.
> >> >
> >> >Jason
> >> >
> >> >
> >> 
> >> OK I created PR #536, which adds the siw user library to
> >> rdma-core. Unfortunately, when uploading, travis brought
> >> up many issues with atomics etc. Is there a good way to
> >> have the very same strict checking locally, since local build
> >> was always successful...
> >
> >$ buildlib/cbuild build-images travis # once
> >$ buildlib/cbuild pkg travis
> >
> >You'll need docker installed
> >
> >> In any case, sorry for abusing the PR procedure for code cleanup
> >> (amending commits and force push cycles)!
> >
> >It is fine, this is what travis is for..
> >
> Jason, many thanks for the very instant review at github, very much
> appreciated! I changed things accordingly with a new commit. Please let
> me know if you would prefer amend and force push for those changes.

Force push but it is often nice if you include the 'diff' output
between the old and forced commits in the comments, if it is small.

Jason
