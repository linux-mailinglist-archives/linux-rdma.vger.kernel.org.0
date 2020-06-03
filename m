Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C851ED0AC
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 15:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgFCNWP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 09:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgFCNWO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jun 2020 09:22:14 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCB4C08C5C0
        for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2020 06:22:14 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id fc4so1061756qvb.1
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2020 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=urDPGzpmtHdu41YvIlqB9jRN+JAehUGupRwJ8KbTqRM=;
        b=f6myegJF5aRm1xhYcfKOK/xXRD549eOV9CU9zQltb1FqhOYSOgrJL/VvYE3UCj/TjT
         WZmIFPnqcGceQcgsQlHH82G0FT/yLCvJY6gQFawHDEy2MnqqH3rhCUN/a2RrF458k9Ir
         DErCyk4Z0mshc03i+9asW3K8MY0gx+oO0dY2cB68BnxK9nxJKf6DQcNjmlXCqvUbLfS+
         XrnPWVDEzs8BE5dLe4bzV5WQrsMTkm7IY7vGRK/Zg7DkHY3vjFwLdokUv6zSZ8oX3oz7
         ZWeKT3la1R0Ao4qaLtOdph0J0zOixHQ+hYi4s/DRAQvtNmV/DAeTV653+aT19RzvPiKE
         H+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urDPGzpmtHdu41YvIlqB9jRN+JAehUGupRwJ8KbTqRM=;
        b=eB6cAJjNtEwMf2xIQHeY9jUJrtj3HSzwhzFE4EDXmblIoV0ZAV6j2cWRJwZiMmCjaB
         eJrV8iBAgfW5f006+1AY49FfgNqNoxTunhqkHA71hpq5za4XlqWPzlFct0KR3jP6AJm0
         sNettVups/f8v5wzKFwvoGu0AqkYCUIsa5v49NpIsbeCevcjkMw4ToBqMDBVAUT2uqcL
         cdsz70SbZQAqw3ahRg7S4Zd4qjzv4rKZWB3w/ZLYnTRrM6YtSRxKQkui1iZqvcWo9i/Z
         rkeVdB7ebubcqev/RfYwhpEXklCM4o2VzHUZm5ZKt4t13SPDiMYHBvZYGRPETbadhvnK
         OHTQ==
X-Gm-Message-State: AOAM532MXpLQKFXYsXBNaYuANZBM3I1w5C4XvtAdXp9UUEsqZjmINOGW
        kwe+wW11tzeTapXUtJEY9g59YHfrLjE=
X-Google-Smtp-Source: ABdhPJwqVIwvxq66mpTiEoG0NKVdyj3hKiXNcMxhkWLFm7J3Md5V/oPpilhIo5LJMiVGCVUCq/KjAA==
X-Received: by 2002:ad4:5987:: with SMTP id ek7mr1823353qvb.206.1591190533746;
        Wed, 03 Jun 2020 06:22:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z4sm1508029qkj.131.2020.06.03.06.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 06:22:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jgTLP-000kj0-Lv; Wed, 03 Jun 2020 10:22:11 -0300
Date:   Wed, 3 Jun 2020 10:22:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: A question about cm_destroy_id()
Message-ID: <20200603132211.GH6578@ziepe.ca>
References: <8d6802a1-1706-0c01-78bf-0cdd3fea0881@oracle.com>
 <20200603115532.GG6578@ziepe.ca>
 <134e6cca-5e7e-25c6-7504-b785f60727a0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134e6cca-5e7e-25c6-7504-b785f60727a0@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 03, 2020 at 08:46:17PM +0800, Ka-Cheong Poon wrote:
> On 6/3/20 7:55 PM, Jason Gunthorpe wrote:
> > On Wed, Jun 03, 2020 at 04:53:57PM +0800, Ka-Cheong Poon wrote:
> > > Suppose the cm_id state is IB_CM_REP_SENT when cm_destroy_id() is
> > > called.  Then it calls cm_send_rej_locked().  In cm_send_rej_locked(),
> > > it calls cm_enter_timewait() and the state is changed to IB_CM_TIMEWAIT.
> > > Now back to cm_destroy_id(), it breaks from the switch statement.  And
> > > the next call is WARN_ON(cm_id->state != IB_CM_IDLE).  The cm_id state
> > > is IB_CM_TIMEWAIT so it will log a warning.  Is the warning intended in
> > > this case?
> > 
> > Yes the warning is intended, most likely the break should be changed
> > to goto retest
> 
> 
> Like this?
> 
> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
> index 17f14e0..1c2bf18 100644
> +++ b/drivers/infiniband/core/cm.c
> @@ -1076,7 +1076,9 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
>         case IB_CM_REP_SENT:
>         case IB_CM_MRA_REP_RCVD:
>                 ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
> -               /* Fall through */
> +               cm_send_rej_locked(cm_id_priv, IB_CM_REJ_CONSUMER_DEFINED, NULL,
> +                                  0, NULL, 0);
> +               goto retest;

Yes, that is good, can you make a formal patch?

Jason
