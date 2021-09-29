Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F7841C611
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344344AbhI2NwF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 09:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344318AbhI2NwF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Sep 2021 09:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632923423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FhEYkN6eSJLZP/cV07GjlQRPbO9M+hVC+ywwE/y96y8=;
        b=gl7PIxOHnXveXEhqmHZ/sFQ962stFMlpM+TVhOzsI+RTkQpQWU5twg07D6lcl4aAlZtr0/
        puj0zUBNjvHLm2KobPmcvyITiOwYzY9CsimohDTXbBO9LbMJB/cCWAfrbj504xZ/IrEcUS
        iO3ipYfwt4CicWHo1xTT4fXUjxFCjro=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-p9cxh8Y-NSivRrdFft3iXQ-1; Wed, 29 Sep 2021 09:50:22 -0400
X-MC-Unique: p9cxh8Y-NSivRrdFft3iXQ-1
Received: by mail-oo1-f72.google.com with SMTP id o8-20020a4aabc8000000b002b601d1fb33so1549452oon.23
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 06:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FhEYkN6eSJLZP/cV07GjlQRPbO9M+hVC+ywwE/y96y8=;
        b=Au50LX9siuB3MD5WsePokKl9JAuI/PEvHCnrZxBlvbQ71Uw3V4IFEyiQq5tI8wrVHq
         n1xUc2hFJJAaWG9Uc9JIuQ9THIaG7aFRnLJOvLZc877ywMifWghASbj/3RNVKXq7QW2Q
         lJbbVaB/DDp5NF3dQOfOVTMXOv54plFdsfqVUMI1Bg/b09tbsOEkMfgqACZdP0paXf+z
         fa4EqR5/alU4o3KczEaArxHolejQCW3OMTf9504u+kgBD4jrNXWUIqFlP1hMWXbn6WJh
         NjoynnuNnk+f6a/8Z4VrWqR23eP0tDKclmUW6gWoJAfWGDbeDtrsMlHEAkC4MJSfX3kS
         OZRw==
X-Gm-Message-State: AOAM5314bFv13KXT0X+BP5iDGC/u/mp+pWzGOw2O3q7UUYhN5IzXXJoc
        VEhEjZjfd61R43dNeQUOh2i7/3qVeokbb8YiWq0VNha83Xnz7zIMU9fQRupMpAcHRIJcxk3c45A
        3d3KCazjq1brTp8OfYuj7Jg==
X-Received: by 2002:aca:adc5:: with SMTP id w188mr8119133oie.40.1632923421713;
        Wed, 29 Sep 2021 06:50:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBuOrTDixbcm+glLpv+7QenclxccxJ6UkYSq7KtnLZB5CHTBD74Coi0b7Um+05XIgMwgd7Pg==
X-Received: by 2002:aca:adc5:: with SMTP id w188mr8119119oie.40.1632923421462;
        Wed, 29 Sep 2021 06:50:21 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id p8sm458585oti.15.2021.09.29.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 06:50:21 -0700 (PDT)
Date:   Wed, 29 Sep 2021 07:50:19 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Kirti Wankhede <kwankhede@nvidia.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH mlx5-next 2/7] vfio: Add an API to check migration state
 transition validity
Message-ID: <20210929075019.48d07deb.alex.williamson@redhat.com>
In-Reply-To: <1eba059c-4743-4675-9f72-1a26b8f3c0f6@nvidia.com>
References: <cover.1632305919.git.leonro@nvidia.com>
        <c87f55d6fec77a22b110d3c9611744e6b28bba46.1632305919.git.leonro@nvidia.com>
        <20210927164648.1e2d49ac.alex.williamson@redhat.com>
        <20210927231239.GE3544071@ziepe.ca>
        <25c97be6-eb4a-fdc8-3ac1-5628073f0214@nvidia.com>
        <20210929063551.47590fbb.alex.williamson@redhat.com>
        <1eba059c-4743-4675-9f72-1a26b8f3c0f6@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 29 Sep 2021 16:26:55 +0300
Max Gurtovoy <mgurtovoy@nvidia.com> wrote:

> On 9/29/2021 3:35 PM, Alex Williamson wrote:
> > On Wed, 29 Sep 2021 13:44:10 +0300
> > Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >  
> >> On 9/28/2021 2:12 AM, Jason Gunthorpe wrote:  
> >>> On Mon, Sep 27, 2021 at 04:46:48PM -0600, Alex Williamson wrote:  
> >>>>> +	enum { MAX_STATE = VFIO_DEVICE_STATE_RESUMING };
> >>>>> +	static const u8 vfio_from_state_table[MAX_STATE + 1][MAX_STATE + 1] = {
> >>>>> +		[VFIO_DEVICE_STATE_STOP] = {
> >>>>> +			[VFIO_DEVICE_STATE_RUNNING] = 1,
> >>>>> +			[VFIO_DEVICE_STATE_RESUMING] = 1,
> >>>>> +		},  
> >>>> Our state transition diagram is pretty weak on reachable transitions
> >>>> out of the _STOP state, why do we select only these two as valid?  
> >>> I have no particular opinion on specific states here, however adding
> >>> more states means more stuff for drivers to implement and more risk
> >>> driver writers will mess up this uAPI.  
> >> _STOP == 000b => Device Stopped, not saving or resuming (from UAPI).
> >>
> >> This is the default initial state and not RUNNING.
> >>
> >> The user application should move device from STOP => RUNNING or STOP =>
> >> RESUMING.
> >>
> >> Maybe we need to extend the comment in the UAPI file.  
> >
> > include/uapi/linux/vfio.h:
> > ...
> >   *  +------- _RESUMING
> >   *  |+------ _SAVING
> >   *  ||+----- _RUNNING
> >   *  |||
> >   *  000b => Device Stopped, not saving or resuming
> >   *  001b => Device running, which is the default state
> >                              ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > ...
> >   * State transitions:
> >   *
> >   *              _RESUMING  _RUNNING    Pre-copy    Stop-and-copy   _STOP
> >   *                (100b)     (001b)     (011b)        (010b)       (000b)
> >   * 0. Running or default state
> >   *                             |
> >                   ^^^^^^^^^^^^^
> > ...
> >   * 0. Default state of VFIO device is _RUNNING when the user application starts.
> >        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > The uAPI is pretty clear here.  A default state of _STOP is not
> > compatible with existing devices and userspace that does not support
> > migration.  Thanks,  
> 
> Why do you need this state machine for userspace that doesn't support 
> migration ?

For userspace that doesn't support migration, there's one state,
_RUNNING.  That's what we're trying to be compatible and consistent
with.  Migration is an extension, not a base requirement.

> What is the definition of RUNNING state for a paused VM that is waiting 
> for incoming migration blob ?

A VM supporting migration of the device would move the device to
_RESUMING to load the incoming data.  If the VM leaves the device in
_RUNNING, then it doesn't support migration of the device and it's out
of scope how it handles that device state.  Existing devices continue
running regardless of whether the VM state is paused, it's only devices
supporting migration where userspace could optionally have the device
run state follow the VM run state.  Thanks,

Alex

