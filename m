Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2041CB7D
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 20:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345065AbhI2SIm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 14:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344906AbhI2SIm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Sep 2021 14:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632938820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5fEUwAikCXlY0hPFc3Zca5cd4O3adbLSONrps+zhumI=;
        b=BJRL6SjOCTRVgliVkMU89HH0FQjkLTfEaec/JDHfaAvchXkqS3R9SyfL0eJeVhF3dJfWtA
        +nkXp8tPJZ1/4+oLycZ8/yXxhjTMSkKaffJDvR4voq2pgPS7eR/9LppsmhGQ+lyG/b5wAR
        VnCHp+1eNEVwFei04iqQJj9p3gg5Fzc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-nNqoJ4DYNGKCsEr90nGNgA-1; Wed, 29 Sep 2021 14:06:58 -0400
X-MC-Unique: nNqoJ4DYNGKCsEr90nGNgA-1
Received: by mail-ot1-f70.google.com with SMTP id n5-20020a9d4d05000000b0054d43b72ba5so2424651otf.17
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 11:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5fEUwAikCXlY0hPFc3Zca5cd4O3adbLSONrps+zhumI=;
        b=7kRaeWGiJVZJIFdN5kZcH+hqIngERMQIvxpdmJQqA3RZiIZf8cLha18N1qLCHQJ5rO
         SLyIF0PM6xyCDrTDLzLWSIgFZ+UttPmYlyDyISihGpKK/fVbnDN/sZuB/uEAcwdBfV41
         Zi5URyKMvfOVf3U5LgUcEZXQifKVDdpDLC/FAoHMZFQ//o/nwGAzvEA05xB5YW2GYj6u
         fWUi1iMEkdNqXxhdeCBVlpZBJ2wpsoFalgmyc0eHnGtMs8ef3D5BMNyNPp11CxBoz/IH
         idxOj8yGc0Zm2ltxL/BfR3pOzcjNl4SZNfkzBsbuESRdZ/AzGnZeDcZVE8aCDe4s2Xs/
         0bag==
X-Gm-Message-State: AOAM531ARgfgJa/sC/Wg08J3IjaQOtuiO+dEuipLrNcK681FLQcu24T1
        AFofTgWtGXXjrYarko8u99GMOT6Ng1bNBQY2gG0SAGnZctdBBx0HHoEunDoWc6QSJsUyemvxLPF
        W0stxbPMflfdngy+yQ9H11g==
X-Received: by 2002:a05:6808:243:: with SMTP id m3mr9254411oie.54.1632938817867;
        Wed, 29 Sep 2021 11:06:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4GoRfgX2CpzdS8TMOhpWJSHyKfLJHdPDeL1Co6stqHQwtNdJYf2fM7V3Ug9pt3k4WTpNfQA==
X-Received: by 2002:a05:6808:243:: with SMTP id m3mr9254391oie.54.1632938817587;
        Wed, 29 Sep 2021 11:06:57 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id k1sm97828otr.43.2021.09.29.11.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:06:57 -0700 (PDT)
Date:   Wed, 29 Sep 2021 12:06:55 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH mlx5-next 2/7] vfio: Add an API to check migration state
 transition validity
Message-ID: <20210929120655.28e0b3a6.alex.williamson@redhat.com>
In-Reply-To: <20210929161602.GA1805739@nvidia.com>
References: <cover.1632305919.git.leonro@nvidia.com>
        <c87f55d6fec77a22b110d3c9611744e6b28bba46.1632305919.git.leonro@nvidia.com>
        <20210927164648.1e2d49ac.alex.williamson@redhat.com>
        <20210927231239.GE3544071@ziepe.ca>
        <20210928131958.61b3abec.alex.williamson@redhat.com>
        <20210928193550.GR3544071@ziepe.ca>
        <20210928141844.15cea787.alex.williamson@redhat.com>
        <20210929161602.GA1805739@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 29 Sep 2021 13:16:02 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Sep 28, 2021 at 02:18:44PM -0600, Alex Williamson wrote:
> > On Tue, 28 Sep 2021 16:35:50 -0300
> > Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >   
> > > On Tue, Sep 28, 2021 at 01:19:58PM -0600, Alex Williamson wrote:
> > >   
> > > > In defining the device state, we tried to steer away from defining it
> > > > in terms of the QEMU migration API, but rather as a set of controls
> > > > that could be used to support that API to leave us some degree of
> > > > independence that QEMU implementation might evolve.    
> > > 
> > > That is certainly a different perspective, it would have been
> > > better to not express this idea as a FSM in that case...
> > > 
> > > So each state in mlx5vf_pci_set_device_state() should call the correct
> > > combination of (un)freeze, (un)quiesce and so on so each state
> > > reflects a defined operation of the device?  
> > 
> > I'd expect so, for instance the implementation of entering the _STOP
> > state presumes a previous state that where the device is apparently
> > already quiesced.  That doesn't support a direct _RUNNING -> _STOP
> > transition where I argued in the linked threads that those states
> > should be reachable from any other state.  Thanks,  
> 
> If we focus on mlx5 there are two device 'flags' to manage:
>  - Device cannot issue DMAs
>  - Device internal state cannot change (ie cannot receive DMAs)
> 
> This is necessary to co-ordinate across multiple devices that might be
> doing peer to peer DMA between them. The whole multi-device complex
> should be moved to "cannot issue DMA's" then the whole complex would
> go to "state cannot change" and be serialized.

Are you anticipating p2p from outside the VM?  The typical scenario
here would be that p2p occurs only intra-VM, so all the devices would
stop issuing DMA (modulo trying to quiesce devices simultaneously).

> The expected sequence at the device is thus
> 
> Resuming
>  full stop -> does not issue DMAs -> full operation
> Suspend
>  full operation -> does not issue DMAs -> full stop
> 
> Further the device has two actions
>  - Trigger serializating the device state
>  - Trigger de-serializing the device state
> 
> So, what is the behavior upon each state:
> 
>  *  000b => Device Stopped, not saving or resuming
>      Does not issue DMAs
>      Internal state cannot change
> 
>  *  001b => Device running, which is the default state
>      Neither flags
> 
>  *  010b => Stop the device & save the device state, stop-and-copy state
>      Does not issue DMAs
>      Internal state cannot change
> 
>  *  011b => Device running and save the device state, pre-copy state
>      Neither flags
>      (future, DMA tracking turned on)
> 
>  *  100b => Device stopped and the device state is resuming
>      Does not issue DMAs
>      Internal state cannot change

cannot change... other that as loaded via migration region.

>      
>  *  110b => Error state
>     ???
> 
>  *  101b => Invalid state
>  *  111b => Invalid state
> 
>     ???
> 
> What should the ??'s be? It looks like mlx5 doesn't use these, so it
> should just refuse to enter these states in the first place..

_SAVING and _RESUMING are considered mutually exclusive, therefore any
combination of both of them is invalid.  We've chosen to use the
combination of 110b as an error state to indicate the device state is
undefined, but not _RUNNING.  This state is only reachable by an
internal error of the driver during a state transition.

The expected protocol is that if the user write to the device_state
register returns an errno, the user reevaluates the device_state to
determine if the desired transition is unavailable (previous state
value is returned) or generated a fault (error state value returned).
Due to the undefined state of the device, the only exit from the error
state is to re-initialize the device state via a reset.  Therefore a
successful device reset should always return the device to the 001b
state.

The 111b state is also considered unreachable through normal means due
to the _SAVING | _RESUMING conflict, but suggests the device is also
_RUNNING in this undefined state.  This combination has no currently
defined use case and should not be reachable.

The 101b state indicates _RUNNING while _RESUMING, which is simply not
a mode that has been spec'd at this time as it would require some
mechanism for the device to fault in state on demand.
 
> The two actions:
>  trigger serializing the device state
>    Done when asked to go to 010b ?

When the _SAVING bit is set.  The exact mechanics depends on the size
and volatility of the device state.  A GPU might begin in pre-copy
(011b) to transmit chunks of framebuffer data, recording hashes of
blocks read by the user to avoid re-sending them during the
stop-and-copy (010b) phase.  A device with a small internal state
representation may choose to forgo providing data in the pre-copy phase
and entirely serialize internal state at stop-and-copy.

>  trigger de-serializing the device state
>    Done when transition from 100b -> 000b ?

100b -> 000b is not a required transition, generally this would be 100b
-> 001b, ie. end state of _RUNNING vs _STOP.

I think the requirement is that de-serialization is complete when the
_RESUMING bit is cleared.  Whether the driver chooses to de-serialize
piece-wise as each block of data is written to the device or in bulk
from a buffer is left to the implementation.  In either case, the
driver can fail the transition to !_RESUMING if the state is incomplete
or otherwise corrupt.  It would again be the driver's discretion if
the device enters the error state or remains in _RESUMING.  If the user
has no valid state with which to exit the _RESUMING phase, a device
reset should return the device to _RUNNING with a default initial state.

> There is a missing state "Stop Active Transactions" which would be
> only "does not issue DMAs". I've seen a proposal to add that.

This would be to get all devices to stop issuing DMA while internal
state can be modified to avoid the synchronization issue of trying to
stop devices concurrently?  For PCI devices we obviously have the bus
master bit to manage that, but I could see how a migration extension
for such support (perhaps even just wired through to BM for PCI) could
be useful.  Thanks,

Alex

