Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205B2132E5D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 19:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgAGS0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 13:26:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43384 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgAGS0m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 13:26:42 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so232142qke.10
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7T+Uz+ziIhwrQC1V0AO3Y5+ZIkKPGfie4ADyDKB8cAU=;
        b=it07uPHDjGFZLQpswrCddH3xbdXVBbPpx7Nx/qj/M+AFTfNxE4quAolxqS+arqL82c
         bl2Dty4s2fHhhM+letMeeVrn66LuHeYFxq+gNVaSLml043l3Mgqb4ZuFwUwnaUla9vBU
         XCvnGSIeEWBLy3HClWG54PiF0P9CP0Kw/yorUkncnr/GVkjNLF0VOPdoEqQc1YZs648M
         +wTyOAeW9mG/SF5WZayTC41edK3kWoBdjfGk0WyEi0tItDsszZY4wPlWG0TOaJoVLoYS
         XPL4BZeApnwa5rKBzKuaVQbj42euhCwi2RU/Q78YPwDBnIw92QRCD1G8blFVRkcADxlx
         9fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7T+Uz+ziIhwrQC1V0AO3Y5+ZIkKPGfie4ADyDKB8cAU=;
        b=NoMoRGGXgHqawYGeJwtJgoHi8R+eDXWY4OWDRt46a6HW+tzthqhqA1Y6fo1CarMzX0
         T5wrQH2H7KiFP+TRH7/m0KA8C09xxVGUDa3MRVuJItJpir5HnklLrbif3I0aqAg7H+ZV
         RhIwn3nI8synz/eKc8YxCvn/f4UQR46e/FXIyFBahoPjl7KPWtrJAYiBVuBRb9pxy0YW
         zCQaU6sgI/DM1t0Du8HJLbO5QxZc3zNs6M7R4G+93246CKXa+yznmScFzEdSL6lYdN9H
         RQ7512p9uGwBzgfY0uZhn55bK7Kugg1gnVUo0ouf9/SP73rlFV+7CWYHZ+rEthhqPG7n
         HkZQ==
X-Gm-Message-State: APjAAAWjHxAlDuwUXneiLFvuO9OZxkx90v3agn/D/TX7yzEIOyawaaf9
        Ofh2tyuTbF6yBHOeqEfg3uFBKA==
X-Google-Smtp-Source: APXvYqx7dejdsvwplVt1zaxwDZ5VHKGR9kLeMkjdXFz1Pgrfhz+vaitLElnr3cudKfk5O3dhcZdagQ==
X-Received: by 2002:a37:bcc4:: with SMTP id m187mr655640qkf.329.1578421601844;
        Tue, 07 Jan 2020 10:26:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t29sm186540qkm.27.2020.01.07.10.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 10:26:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iotYv-0008Q7-0P; Tue, 07 Jan 2020 14:26:41 -0400
Date:   Tue, 7 Jan 2020 14:26:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     madhuparnabhowmik04@gmail.com
Cc:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, paulmck@kernel.org, rcu@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list
 checking
Message-ID: <20200107182640.GC26174@ziepe.ca>
References: <20200107173510.20320-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107173510.20320-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 07, 2020 at 11:05:08PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> list_for_each_entry_rcu has built-in RCU and lock checking.
> Pass cond argument to list_for_each_entry_rcu.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
>  drivers/infiniband/hw/hfi1/verbs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
> index 089e201d7550..cab2ff185240 100644
> +++ b/drivers/infiniband/hw/hfi1/verbs.c
> @@ -515,7 +515,8 @@ static inline void hfi1_handle_packet(struct hfi1_packet *packet,
>  				       opa_get_lid(packet->dlid, 9B));
>  		if (!mcast)
>  			goto drop;
> -		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
> +		list_for_each_entry_rcu(p, &mcast->qp_list, list
> +								lock_is_held(&(ibp->rvp.lock).dep_map)) {

This is missing a ',' and isn't indented properly. Does it even
compile?

The idea seems sound though.

Jason
