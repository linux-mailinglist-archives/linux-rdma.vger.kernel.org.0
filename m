Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F21F41B771
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 21:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbhI1TVw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 15:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242491AbhI1TVn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Sep 2021 15:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632856803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Za4UIa1i/i1OBgAuhO+2BMEIFPExsbIEIdBHDtNVqsI=;
        b=RyAiQ9C1fZlGABvh/tDHEbHwS8y/EBv8avx0NdMrZoGkHIV1RN6h5XzY/tPbsMl17k1G9Y
        yhjRtshLj1CNwzJ7aKgcwz4vqFwaPX/Su+jRTT0XfI76TuOJfzy7QmUzmA2GpLHdoHNOfz
        l6SUt3FXQACkEdhpU+Xj/bOLlaNfx0w=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-e8F13roDP2-ZaH5zg0krEQ-1; Tue, 28 Sep 2021 15:20:01 -0400
X-MC-Unique: e8F13roDP2-ZaH5zg0krEQ-1
Received: by mail-ot1-f70.google.com with SMTP id t26-20020a9d749a000000b00547047a5594so22064866otk.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 12:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Za4UIa1i/i1OBgAuhO+2BMEIFPExsbIEIdBHDtNVqsI=;
        b=L6KBqytGVIlcfAbnf4S9L8MdEXDyyYG2fFHwZZDP7EFsQVaLBa5bweccrHmcQ7L4fO
         DVsjr9oWdHIh5h1fhQVz2esie3PrMG1VsRaCiaiA697aAEafk6+Ji5jS/TSraGGVl33V
         5JMkt44MGDalYazLB7+Lgky3wPabN+7gRFVDkCgSD4Rp9Pt4UaxyX0XoCDhS9D4XNQfC
         xDhu65uipvRkPnV19oAT3YFdqM547xor+YFPMM+fdPua8a16r1eoKKXID9k2bvTGFdCT
         fLzK+vzA7hKWDhMXHxtyYRjfzo8di1rvLZ1C0y6G31jE1UOxP3dJGPahZg5dDLBSbSj8
         N9Pw==
X-Gm-Message-State: AOAM5318pjpURYispRVwaNniD6jvZ3GkKZiwSKYrHM+avD9CTB+QeUtN
        jJV4CMm8N6Zbt6ooA0eY1jdRG9tu10AQGzv8STWdMTMbs6yWL0H3yS+OEbEEDy6+LeavzxjYAfK
        B2kZl8uncCgovNteNKSNc8Q==
X-Received: by 2002:a54:410b:: with SMTP id l11mr4950324oic.74.1632856800917;
        Tue, 28 Sep 2021 12:20:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNb7SJKsY1fAhfMc6h0vwSeXSkbF/My4fjrvTWCd7Z2VSqxK1ptej7nonv6fRLJYXuWORlyA==
X-Received: by 2002:a54:410b:: with SMTP id l11mr4950299oic.74.1632856800685;
        Tue, 28 Sep 2021 12:20:00 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id u15sm5269230oon.35.2021.09.28.12.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:20:00 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:19:58 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <20210928131958.61b3abec.alex.williamson@redhat.com>
In-Reply-To: <20210927231239.GE3544071@ziepe.ca>
References: <cover.1632305919.git.leonro@nvidia.com>
        <c87f55d6fec77a22b110d3c9611744e6b28bba46.1632305919.git.leonro@nvidia.com>
        <20210927164648.1e2d49ac.alex.williamson@redhat.com>
        <20210927231239.GE3544071@ziepe.ca>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 27 Sep 2021 20:12:39 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, Sep 27, 2021 at 04:46:48PM -0600, Alex Williamson wrote:
> > > +	enum { MAX_STATE = VFIO_DEVICE_STATE_RESUMING };
> > > +	static const u8 vfio_from_state_table[MAX_STATE + 1][MAX_STATE + 1] = {
> > > +		[VFIO_DEVICE_STATE_STOP] = {
> > > +			[VFIO_DEVICE_STATE_RUNNING] = 1,
> > > +			[VFIO_DEVICE_STATE_RESUMING] = 1,
> > > +		},  
> > 
> > Our state transition diagram is pretty weak on reachable transitions
> > out of the _STOP state, why do we select only these two as valid?  
> 
> I have no particular opinion on specific states here, however adding
> more states means more stuff for drivers to implement and more risk
> driver writers will mess up this uAPI.

It looks like state transitions were largely discussed in v9 and v10 of
the migration proposals:

https://lore.kernel.org/all/1573578220-7530-2-git-send-email-kwankhede@nvidia.com/
https://lore.kernel.org/all/1576527700-21805-2-git-send-email-kwankhede@nvidia.com/

I'm not seeing that we really excluded many transitions there.

> So only on those grounds I'd suggest to keep this to the minimum
> needed instead of the maximum logically possible..
> 
> Also, probably the FSM comment from the uapi header file should be
> moved into a function comment above this function?

It's not clear this function shouldn't be anything more than:

	if (new_state > MAX_STATE || old_state > MAX_STATE)
		return false;	/* exited via device reset, */
				/* entered via transition fault */

	return true;

That's still only 5 fully interconnected states to work between, and
potentially a 6th if we decide _RESUMING|_RUNNING is valid for a device
supporting post-copy.

In defining the device state, we tried to steer away from defining it
in terms of the QEMU migration API, but rather as a set of controls
that could be used to support that API to leave us some degree of
independence that QEMU implementation might evolve.

To that extent, it actually seems easier for a device implementation to
focus on bit definition rather than the state machine node.

I'd also vote that any clarification of state validity and transitions
belongs in the uAPI header and a transition test function should
reference that header as the source of truth, rather than the other way
around.  Thanks,

Alex

