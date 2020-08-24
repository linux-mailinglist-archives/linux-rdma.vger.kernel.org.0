Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B58B250B3F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 00:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHXWAF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 18:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHXWAF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 18:00:05 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3637C061574
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 15:00:04 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 144so9119651qkl.5
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 15:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jTvi36PtrPCa8KRZMnZagR00ztzDmQDCsc+sihgZ0D0=;
        b=Itg82sK7OOutg4JelsbXVX8N1SuCvEcRCnT9SbsS7nvwltlhDWcuizikKe6+bHcv+i
         BQHIqvdWOCKP1qMNKliwO4JjFFu1cCujYPHXBVJXaK8XKaF+mmsARiZ+SyVjtmnFnpY3
         u7o/6tC3XgEiZxCQXaQFukVzV4mU5y13aY9WKDi4CFbOdzlHndhYmYfCSgWfQTbcKcv/
         QFi/XwCBvf/3VPvNCYft7L0vu2ENzgnToS6n92T3Zj17PA8jUZzeafRY3Pf3AGG6ltQm
         vYKGkdfRUa1XSNSwnjbxFW6RDkq1ltTYJoebr6INKibKrgsRLs/9kvfm3nChEhbfNHsK
         5Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jTvi36PtrPCa8KRZMnZagR00ztzDmQDCsc+sihgZ0D0=;
        b=HS1yRdKbPelybQ5WCFIB/LLZQWR9S8w7WZf7dmychw0d23sK4OhdTZk6CPWXbTk3SD
         BLSAyTXWReHhN4IkhhQLwJXNTB6TQuPCCNpenI/buXvJysqLUYKX+3OY7m65xepxsZ8z
         MdqM8aVVwKIX0yQ8grPYqD0j9xmQpf9X4Luv7tUSXxZJn/MJ7Oe0OqQ6FTIgaBZGbPLM
         tcy57STsUdRUHLhSct3pJc40EcfANo8wFwthJCt3fftQRqRINxw4XmFOL6GEKKDcTO7b
         154LRU3p6oUD45pYlNqksWUHj6OxV77SxnaTb9sfiHyvifa705GvJCfITqPQR4BGGo67
         +MTg==
X-Gm-Message-State: AOAM530cg4vzeu76c/NWUL5VD/4c9Orc1+19sX7kfU7c3/xek41J8m6k
        DTh6c1d8MVt5DcORxxJzbnGKlg==
X-Google-Smtp-Source: ABdhPJxacNjFM5WToptGYtB1Dl+H+Fr7GUSfEWsHKuepFySIUIO72S5dzZcK6alEvKaZGT/rbEZiLg==
X-Received: by 2002:a05:620a:1355:: with SMTP id c21mr6918902qkl.378.1598306404171;
        Mon, 24 Aug 2020 15:00:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l38sm12528626qtl.58.2020.08.24.15.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:00:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kAKVW-00E0BC-O6; Mon, 24 Aug 2020 19:00:02 -0300
Date:   Mon, 24 Aug 2020 19:00:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 1/6] RDMA/bnxt_re: Remove the qp from list only if
 the qp destroy succeeds
Message-ID: <20200824220002.GF24045@ziepe.ca>
References: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
 <1598292876-26529-2-git-send-email-selvin.xavier@broadcom.com>
 <20200824190141.GL571722@unreal>
 <CA+sbYW3R_uScvS63dWNNVO4965OjOCRPagpqOY1JKrbsOTEEeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW3R_uScvS63dWNNVO4965OjOCRPagpqOY1JKrbsOTEEeQ@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 01:06:23AM +0530, Selvin Xavier wrote:
> On Tue, Aug 25, 2020 at 12:31 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Aug 24, 2020 at 11:14:31AM -0700, Selvin Xavier wrote:
> > > Driver crashes when destroy_qp is re-tried because of an
> > > error returned. This is because the qp entry was  removed
> > > from the qp list during the first call.
> >
> > How is it possible that destroy_qp fail?
> >
> One possibility is when the FW is in a crash state.   Driver commands
> to FW  fails and it reports an error status for destroy_qp verb.
> Even Though the chances of this failure is less,  wanted to avoid a
> host crash seen in this scenario.

Drivers are not allowed to fail destroy - the only exception is if a
future destroy would succeed for some reason.

This patch should ignore the return code from FW and clean up all the
host memory. If the FW is not responding then the device should be
killed and the DMA allowed bit turned off in the PCI config space.

Jason
