Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0266113B01F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 17:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgANQ5n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 11:57:43 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36823 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANQ5m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 11:57:42 -0500
Received: by mail-qv1-f65.google.com with SMTP id m14so5981799qvl.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2020 08:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R4InSAKuZ5aCK6QR9Y31K9i3lSVfiJudcKWrhEMNHDc=;
        b=XTiJWkcP0CtYyjzpFYIsdheUjlKBCgS/2w+rJ6OzGCRSJQhoTM3fQPNtiylHKjRsUx
         ayrC2dfUPa3VHxwXtXRAfyuvl5IzL+Clvwtq9p5vFydeY08ncMvtJVlB2PIhe1Cr/Vxv
         DjZgNqeXb4lAgJNIfthyvvgBbP5uaC7dd9oRB4BrVhPE3xX7sATluJtjrCp3PwSdUUoh
         v++u0APj+AaMOwdR3P4C+tYqR1iVvC+ZimG54pzqKaU8TmJ6OcvkixJgzhq+fEJjJ+5D
         JUg1ZiQTPSazNN7A6pMwjLwBMZkHicU2mpVIpCH4LnOO/G9OWeZHvoORlWe2FiaeMlFF
         rKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R4InSAKuZ5aCK6QR9Y31K9i3lSVfiJudcKWrhEMNHDc=;
        b=kQk68JkhiFssXOLVvLjCqS3XF596bXHFgTloPPt4KEcRG+coTrm6nRqOVZFEPGIDrQ
         lOJy2+uFrkBPw1zJxyE/b44iuPHGvdcuxX/nFF7IudSxQhTnVmt8tf5BgVBrhs6eTBMN
         ZD4/Kb0tqIZaR8J0X8t2R7JCv2MOQ/Mh4gq/pZip6fkPWjFuvwUixYQS/aXgXUveI9BO
         qz64YXHY1x3N9D79+R0TSDzqnHpmcbyfg6qpxnboTBAMRUqhLWARRkSTYU7IF9XSNgcU
         ZW1LX7FXZRw+ZI17AwX29B2p4D+5r+GhUDW3e/PVjkW7kRLb/oYRPxfjGoZByOXb3xa5
         /UvQ==
X-Gm-Message-State: APjAAAUZUSXakhcr9QlZPFUUx30/plG50N2zmDvI0txx9Y5HQHM8+9cY
        iOHL3XccBlKQ0hyf9TWSjdv0Gw==
X-Google-Smtp-Source: APXvYqxAwJK6KP985x5SBiObouJjRK4aFNXWGUGpgf/HH+9wFqdlGTn1tzkvG8CrF/UY6GDih4BbRQ==
X-Received: by 2002:a0c:fe8d:: with SMTP id d13mr21133077qvs.150.1579021061827;
        Tue, 14 Jan 2020 08:57:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id j1sm6868284qkl.86.2020.01.14.08.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 08:57:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irPVc-0003VV-RT; Tue, 14 Jan 2020 12:57:40 -0400
Date:   Tue, 14 Jan 2020 12:57:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     madhuparnabhowmik04@gmail.com
Cc:     mike.marciniszyn@intel.com, dennis.dalessandro@intel.com,
        paulmck@kernel.org, joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list
 checking
Message-ID: <20200114165740.GB22037@ziepe.ca>
References: <20200114162345.19995-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114162345.19995-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 14, 2020 at 09:53:45PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> list_for_each_entry_rcu has built-in RCU and lock checking.
> Pass cond argument to list_for_each_entry_rcu.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>  drivers/infiniband/hw/hfi1/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
> index 089e201d7550..22f2d4fd2577 100644
> +++ b/drivers/infiniband/hw/hfi1/verbs.c
> @@ -515,7 +515,7 @@ static inline void hfi1_handle_packet(struct hfi1_packet *packet,
>  				       opa_get_lid(packet->dlid, 9B));
>  		if (!mcast)
>  			goto drop;
> -		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
> +		list_for_each_entry_rcu(p, &mcast->qp_list, list, lockdep_is_held(&(ibp->rvp.lock))) {

Okay, this looks reasonable

Mike, Dennis, is this the right lock to test?

Jason
