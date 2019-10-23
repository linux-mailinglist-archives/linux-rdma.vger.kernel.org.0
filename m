Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE5CE1E41
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392242AbfJWOfP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 10:35:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38273 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbfJWOfP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 10:35:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id o25so19212876qtr.5
        for <linux-rdma@vger.kernel.org>; Wed, 23 Oct 2019 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BBH5Rnd8qI7ba/kSiowYm5SUOZd/lg4e7UPTl0dCgh4=;
        b=h/Vf3F4mNJZ76+07hJm7jgTBQniQRjmr2r7Ny8UpVaWPKlttX0/hGxSzDBmIeknII6
         Bb6ClbhTOVCRuoS7Yqt+NXPlGzMTvPCkR4c6F+73Nq9tHA5N600KLEVhE/BzxDPR0MXM
         iwn1lUKrTcbhQicoWTUoDd9ruUeBfEzejNSWZeC8CWMbWSoyp2aDKGVtBOp6jacq4xKl
         ANZyKQcUydN0vco5HyXRByO9S2LtALnMfQzsJ/NB7OG6V+jnhRddhz7+fFytnZpdsTG+
         hrPq4C2S0BQdyCVzvtDUmdIzaRQ3FW8qkokkqx6LypCphHfRugoQdAiElDFvVesvvCcw
         Owgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BBH5Rnd8qI7ba/kSiowYm5SUOZd/lg4e7UPTl0dCgh4=;
        b=Dxb7TYo77PfDSpGH+M83da5GBJcMAIX+E5ZqFeYF4ce3NA/6cnoSq0KsNORvX7obqr
         VPatMkvBfeE0PLS9/JzeQlB1eN/HfYOxMHDpFA/bRWo9uJ6LJxHUfmvOYqjITFXZ/1W5
         4SkpUJzvTInJX0yrEbUI44SDtkL9ldtwKwLfUHpHSfMqyCYTmBkeXkyzTS1GnbjNHmdM
         0f3JM2ioLOEeO6HFwhma/hJKIx3pITxpmqfpD+21hmlQmLnx0xbqVpPB4lOqEBbhw0s5
         tGscADKZ5gs470E0EyIUYA+R4LqrGAovQ0rEh8nBg4roQYCLHFl7lkYdcvKqeaXAvKz5
         Tbpw==
X-Gm-Message-State: APjAAAXtEKd2y2f1P+Ub2XZvC4IQSd9EC3tVefaYTyKE8Kt67W/Cy5Kq
        EL4D7OS/FUNsUKWHr3LVBU0KAQ==
X-Google-Smtp-Source: APXvYqx4oSJ0gKRmyFGMEtgLJ3/HygwUR4zurQkElAgS6bJP0e13+9OUZbduRXw1jKt9gi2tUZa3ZQ==
X-Received: by 2002:a0c:8eca:: with SMTP id y10mr6209616qvb.138.1571841314446;
        Wed, 23 Oct 2019 07:35:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c14sm14479085qta.80.2019.10.23.07.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 07:35:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNHjF-0003GS-1m; Wed, 23 Oct 2019 11:35:13 -0300
Date:   Wed, 23 Oct 2019 11:35:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/4] EFA RDMA read support
Message-ID: <20191023143513.GJ23952@ziepe.ca>
References: <20190910134301.4194-1-galpress@amazon.com>
 <24527b2a-3bd2-cee5-0383-277c6e72af5c@amazon.com>
 <20191021173119.GG25178@ziepe.ca>
 <f7767c14-25d6-f9d0-8f31-2e53e3480543@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7767c14-25d6-f9d0-8f31-2e53e3480543@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 12:55:27PM +0300, Gal Pressman wrote:
> On 21/10/2019 20:31, Jason Gunthorpe wrote:
> > On Sun, Oct 20, 2019 at 10:03:27AM +0300, Gal Pressman wrote:
> >> On 10/09/2019 16:42, Gal Pressman wrote:
> >>> Hi,
> >>>
> >>> The following series introduces RDMA read support and capabilities
> >>> reporting to the EFA driver.
> >>>
> >>> The first two patches aren't directly related to RDMA read, but refactor
> >>> some bits in the device capabilities struct.
> >>>
> >>> The last two patches add support for remote read access in MR
> >>> registration and expose the RDMA read related attributes to the
> >>> userspace library.
> >>>
> >>> PR was sent:
> >>> https://github.com/linux-rdma/rdma-core/pull/576
> >>
> >> Should I resubmit patches 2-4?
> > 
> > No it is still on patchworks. You said not to apply your series until
> > you said it was OK
> 
> Thanks, is it possible to send a mail when the series is reviewed/ready to merge
> and waiting to be applied?

Oh, I wasn't going to review anything until it was ready to apply

> You can drop this one from patchworks.

done

Jason
