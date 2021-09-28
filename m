Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90E41A399
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 01:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbhI0XOU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 19:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbhI0XOU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 19:14:20 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F3AC061765
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 16:12:41 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id cv2so6213667qvb.5
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 16:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HhHbYcRrYUniJihY2TuxYK4nsJLomp8TORJtQl8OuLk=;
        b=c1NXwty+0m4ophjnwc6UmaIG6zX5tLPqbvrYftzueWDcsZFTgNXaTlObvyc9/bXbcz
         U69Q82CMaN5ALwi0XcRVMDVeo68h8Aku/l5WTtRi390n8Cu2eLWp9qzNbU1xPM+IK4+5
         36Le/IM7Vq37qE4hUNdUlT9ZY7raR6zkBcuJGTMw0VJUaY/BeMeioVYj41G0sCG0cfJ8
         CeIaZ72sONQDvQBjUVsiQfGBCZenWAXKzB/0NL9lxEJTmAr8NoQX5q97ICzCwTdG9HoG
         aczy4X5owRGaVLuqm9F7UQ1NXqQNONKF2eonr7pNK+sDBvZBi4rjvkkeT6sNP5Yk7dXa
         +PZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HhHbYcRrYUniJihY2TuxYK4nsJLomp8TORJtQl8OuLk=;
        b=g49QlcuStMrZId0Lf0GpOd+GKvVNmJGT3bN72usxnvoUSL8JB7CI8x6uRwjJtIF2pW
         k+CZwnITAVXfhiA37bYmn+tkBzU9adEaHkVY8iP9JMWhpDp+/TErmJlA5iglXe5ojJL6
         zqjDN7uuVAramq5Mg8N7wAPEP7XAA3iPDpXEcocRBMQmn7SaTxfHXCYRRQ5pyefC8+Zp
         J2dII9opLz2Tkv2Z5es7quFQoeiQ19cNwsrMfklHuvyFSwh3WBzAQ295gEtDHaFXVaV9
         9/HCIIONSl39A0vOeMzXX3YvdS2w5mopQ+wgbG6jpsouuUd7vOvICMO5/5pj/9IprjqH
         4FDg==
X-Gm-Message-State: AOAM531M3W8QTTzBAdFU5vMy23O6WaHeez5Lr7pYk3DbnK60bI1vYbRF
        lrVkyEFLUfG/o+2nri5RZ7ndoA==
X-Google-Smtp-Source: ABdhPJybY4umULY/QeKIrQcOKOKOIhuwMlFfilsotb/TFl5kj4bu88ZB+d8YhrepFonJ8bWWMqnqqQ==
X-Received: by 2002:ad4:54ee:: with SMTP id k14mr2405164qvx.46.1632784361010;
        Mon, 27 Sep 2021 16:12:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c19sm13895533qkl.63.2021.09.27.16.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 16:12:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mUznb-006g1w-Nf; Mon, 27 Sep 2021 20:12:39 -0300
Date:   Mon, 27 Sep 2021 20:12:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
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
Message-ID: <20210927231239.GE3544071@ziepe.ca>
References: <cover.1632305919.git.leonro@nvidia.com>
 <c87f55d6fec77a22b110d3c9611744e6b28bba46.1632305919.git.leonro@nvidia.com>
 <20210927164648.1e2d49ac.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927164648.1e2d49ac.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 27, 2021 at 04:46:48PM -0600, Alex Williamson wrote:
> > +	enum { MAX_STATE = VFIO_DEVICE_STATE_RESUMING };
> > +	static const u8 vfio_from_state_table[MAX_STATE + 1][MAX_STATE + 1] = {
> > +		[VFIO_DEVICE_STATE_STOP] = {
> > +			[VFIO_DEVICE_STATE_RUNNING] = 1,
> > +			[VFIO_DEVICE_STATE_RESUMING] = 1,
> > +		},
> 
> Our state transition diagram is pretty weak on reachable transitions
> out of the _STOP state, why do we select only these two as valid?

I have no particular opinion on specific states here, however adding
more states means more stuff for drivers to implement and more risk
driver writers will mess up this uAPI.

So only on those grounds I'd suggest to keep this to the minimum
needed instead of the maximum logically possible..

Also, probably the FSM comment from the uapi header file should be
moved into a function comment above this function?

Jason
