Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D33EF195B6A
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2020 17:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgC0Qt0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Mar 2020 12:49:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46883 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbgC0Qt0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Mar 2020 12:49:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id g7so9058859qtj.13
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2020 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r39V2KqVEfk1IDfjZx77OcaJjv04kjF3CXcU01BjV7I=;
        b=hC3Q+HHWiwclJMqVoZa7/j8K00cnyZQ1hL6/6NrQG1Vcu3DuBawZuOP55Q8Rr05+fG
         0i3HM1wSl/d4MyfmHMaNFXgAz+vK3j/SFqHBMNCoShcClIJRQSK8H0XV+1t9zkJpSpRb
         bO0Cs51Oe/PQzWN0rASndYL8yDFfhmK/40DAJbFxR1IeaYB6wCGtAdcb5Jjj8MiIrZbs
         QpWO1jY4DYL3TE6eczrXRksLapEEP4LkPBWdtthIqPMLIQSPmuPnh9EsCJFJ6gYD4ypD
         ukCK0aN9jzkmd2Gk89zPQEU8QgdPCFqvaaRcDopMXLf1hcG/tXrtyNKCnmNnESz3XgMn
         KozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r39V2KqVEfk1IDfjZx77OcaJjv04kjF3CXcU01BjV7I=;
        b=CrpNM67ggo0YsnhFj5gqp31K9PQcmgBCLukwTCpwQksf61NGSp/4czg7T+j+3INCZ6
         x3Q3XuQyUXCyGFHaNYZlvGysHXkMasEKhP8IPLNh7uhlpoOosKY6/X6fR8P07Th7dSfL
         VFVGtDqKUr1ANfr2fmsIzsiqT1koRLTYaVVp1q1VzR8d7ms7/PJiAPgHYNzdkZljvCYZ
         8Frt4i/AWvx4NqdvBt2a7Cif1tPuH+YdXe8p6nLkpnWIGc3M2rqBSUZih14dWiIcvkht
         sjsrjuG88h8OdZkl1yjPYEnpU9BM9e0lThzHmvM3cf0XX3VhoxAHCTngdsYab0+GoQIC
         vegg==
X-Gm-Message-State: ANhLgQ05YVuQsK3T/G4NwIK2AAk2FzYGj1xjbVknwbSlU4ofwKTkjNA/
        TyguAoHlwVB2tvfnc9u7RLhSOw==
X-Google-Smtp-Source: ADFU+vt2lBLBec68oVJIQqslL0jF6popxXradOYScM8mSO+8/UvcUijS85kmtF/FLEWxsgX6Ebw7sQ==
X-Received: by 2002:ac8:928:: with SMTP id t37mr157749qth.36.1585327765616;
        Fri, 27 Mar 2020 09:49:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d185sm4089119qkf.46.2020.03.27.09.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 09:49:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHsAe-0002S9-EV; Fri, 27 Mar 2020 13:49:24 -0300
Date:   Fri, 27 Mar 2020 13:49:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, Mike Marciniszyn <mike.marcinisyzn@intel.com>,
        linux-rdma@vger.kernel.org,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH v2 for-next 07/16] IB/ipoib: Increase ipoib Datagram mode
 MTU's upper limit
Message-ID: <20200327164924.GY20941@ziepe.ca>
References: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
 <20200323231511.64035.16923.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323231511.64035.16923.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 23, 2020 at 07:15:12PM -0400, Dennis Dalessandro wrote:
> @@ -240,13 +241,11 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
>  		priv->broadcast->mcmember.flow_label = mcmember->flow_label;
>  		priv->broadcast->mcmember.hop_limit = mcmember->hop_limit;
>  		/* assume if the admin and the mcast are the same both can be changed */
> +		mtu = rdma_mtu_enum_to_int(priv->ca,  priv->port,
> +					   priv->broadcast->mcmember.mtu);
>  		if (priv->mcast_mtu == priv->admin_mtu)
> -			priv->admin_mtu =
> -			priv->mcast_mtu =
> -			IPOIB_UD_MTU(ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu));
> -		else
> -			priv->mcast_mtu =
> -			IPOIB_UD_MTU(ib_mtu_enum_to_int(priv->broadcast->mcmember.mtu));
> +			priv->admin_mtu = IPOIB_UD_MTU(mtu);
> +		priv->mcast_mtu = IPOIB_UD_MTU(mtu);

Er, how did this ever work? Does the OPA SM not use the 6 & 7 values
for the mtu in the path record? Why is it being changed now?

> +/**
> + * rdma_mtu_from_attr - Return the mtu of the port from the port attribute.
> + * @device: Device
> + * @port_num: Port number
> + * @attr: port attribute
> + *
> + * Return the MTU size supported by the port as an integer value.
> + */
> +static inline int rdma_mtu_from_attr(struct ib_device *device, u8 port,
> +				     struct ib_port_attr *attr)
> +{
> +	if (rdma_core_cap_opa_port(device, port))
> +		return attr->phys_mtu;

Why not just always set this?

Jason
