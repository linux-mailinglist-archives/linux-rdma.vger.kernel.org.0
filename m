Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6671CE150
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgEKRLd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 13:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbgEKRLd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 May 2020 13:11:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2860C061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 10:11:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i68so8598265qtb.5
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=73X0z/aAzZv5svPIqA/MB9e9/mU9i6rbNe3vZQTeY0o=;
        b=ej76EXg9PlWQOGBWNTm+vUyz8fQhvUF3B5ph56ljC7rt338vGOBYi8lYarRg1QPTqN
         82Zhe7OrQVG+KBjQ749iA9MWpd8LHwrwRyuHPwWW17DuL+IEjtPCZ1Y+tYROTqEIKlDg
         Apiak9QJa4AQlZQFEv8nFeNwVZAJkHtz+IMLcWJjS5t1l2Cs760v3Yy1aURmYsbvDEQX
         LahV6g2T+G7n2p/mpKlqf1rnJz42DnozNfoYwcaJ8suKm7Qn/HCqWgD93prsW5JSQf5x
         tEEFooCFl2qCrtbtDGh+etrzbz7+pJITOFm+uMXzgR7+YPJIweEM+MJqWIAyyXKYtMu4
         maQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=73X0z/aAzZv5svPIqA/MB9e9/mU9i6rbNe3vZQTeY0o=;
        b=QecTZpbwfPpzD46n3R5S1kxWKgi0wvOsm3IbUdKCmK+Ex7Yxr5e3KTpgGINH0mev/F
         G4TlDP1AP1Xf76rdN+0ch8pbXu51SMaT79Xgx0ng/Mw63vidm3RIQrBSLrmnPawjRppj
         1oMgZV4TG1feNaza+U32HEvtnHp9vfXJzYAXObzTQhLTwt9sgDlRRTfqloL7Jf+DjX6E
         XGwZ39dxPSst6DaReuGTbSJbdHpd08jhbXPBhpn3VObRxRNJM4jW/T0hbWeX35moJ6Q1
         XaJbnRHj8fmhC7dG4xJdxAyORoUIAo9NEP0o3u6avL+YBcsTWJeGZu68/kKRCxpW7JjU
         jggQ==
X-Gm-Message-State: AGi0PuYDPnH/dh6fSZy9nsOw67F9aAKUxOkuqbb056WUinUIXa4Ai923
        onTdi5D96lke2MOkxLyOFqOtqg2OfIg=
X-Google-Smtp-Source: APiQypJHSTFDErViwMu6SpqgZhbTayi6npr1p/q0sGEnVEKK5xk6FM5Yj2u6REVBtfLLcXYiODURFg==
X-Received: by 2002:ac8:a02:: with SMTP id b2mr16211196qti.95.1589217092139;
        Mon, 11 May 2020 10:11:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l15sm1084296qti.83.2020.05.11.10.11.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 10:11:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYBxi-0001Xj-Qb; Mon, 11 May 2020 14:11:30 -0300
Date:   Mon, 11 May 2020 14:11:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: Re: [PATCH v2 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
Message-ID: <20200511171130.GV26002@ziepe.ca>
References: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
 <20200323231511.64035.16923.stgit@awfm-01.aw.intel.com>
 <20200327164924.GY20941@ziepe.ca>
 <caa96e5b-b467-d52c-e75d-9c5da11702b9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa96e5b-b467-d52c-e75d-9c5da11702b9@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 11, 2020 at 12:04:55PM -0400, Dennis Dalessandro wrote:
> On 3/27/2020 12:49 PM, Jason Gunthorpe wrote:
> > On Mon, Mar 23, 2020 at 07:15:12PM -0400, Dennis Dalessandro wrote:
> > > @@ -240,13 +241,11 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
> > >   		priv->broadcast->mcmember.flow_label = mcmember->flow_label;
> > >   		priv->broadcast->mcmember.hop_limit = mcmember->hop_limit;
> > >   		/* assume if the admin and the mcast are the same both can be changed */
> > > +		mtu = rdma_mtu_enum_to_int(priv->ca,  priv->port,
> > > +					   priv->broadcast->mcmember.mtu);
> > >   		if (priv->mcast_mtu == priv->admin_mtu)
> > > -			priv->admin_mtu =
> > > -			priv->mcast_mtu =
> > > -			IPOIB_UD_MTU(ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu));
> > > -		else
> > > -			priv->mcast_mtu =
> > > -			IPOIB_UD_MTU(ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu));
> > > +			priv->admin_mtu = IPOIB_UD_MTU(mtu);
> > > +		priv->mcast_mtu = IPOIB_UD_MTU(mtu);
> > 
> > Er, how did this ever work? Does the OPA SM not use the 6 & 7 values
> > for the mtu in the path record? Why is it being changed now?
> 
> Prior to this patch series, we can only run AIP at a max mtu of 4K, even on
> OPA devices. Therefore, we need a way to get the max physical mtu for the
> underlying device.

Well, a month later and I don't evern remember what this is about.

> > > +/**
> > > + * rdma_mtu_from_attr - Return the mtu of the port from the port attribute.
> > > + * @device: Device
> > > + * @port_num: Port number
> > > + * @attr: port attribute
> > > + *
> > > + * Return the MTU size supported by the port as an integer value.
> > > + */
> > > +static inline int rdma_mtu_from_attr(struct ib_device *device, u8 port,
> > > +				     struct ib_port_attr *attr)
> > > +{
> > > +	if (rdma_core_cap_opa_port(device, port))
> > > +		return attr->phys_mtu;
> > 
> > Why not just always set this?
> 
> Because this is a new field and other vendor devices does not set it at all.

Fix the other drivers to set it to the 'else' branch..

Jason
