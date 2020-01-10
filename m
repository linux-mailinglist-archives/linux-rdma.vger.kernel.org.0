Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624041371DA
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 16:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgAJPyK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 10:54:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34424 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgAJPyK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 10:54:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so1341955pfc.1
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 07:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SK9SfM0s44elgGzLaJeFK5jMx7NIcHCDZF3x9nv0Lxs=;
        b=aBV1vy75sNaosplHJ4H3qazVSebNElcAVlUb+HrjOZPq1vvWoFf9dEImAwbKzRGAey
         WXFZW3qa2v84cafmXiduuTXYX7tiAt38D7DQCWgB/pNRtn4obYWkC9IU5eWvee8iLkNT
         whWf5etBpitExpwXzzboEVpBB0lB6AIMlr6bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SK9SfM0s44elgGzLaJeFK5jMx7NIcHCDZF3x9nv0Lxs=;
        b=BC5mOWRprGaqWqg+8sSyDo4VFEDr7ea+HoxLaFwqlVGgmZWHtHQ2Ku6Bql/Og+KQBL
         tmh4eg1vJb7D+pf9LAZ1GwJanouttFilqPAaUp3Zgz9O4bKaWHsSBIcI6PgI9uGSuVxN
         rbuPPWZdlf4XWQyX4PW/9cASZkCwKdF3DORAeOcLYPQNhTFfm6urELgRmi8UVrFyvGAD
         S1zVpZXhSJDIeT/6rqkuZhxnObZK1Kyv1uFvcz+xvAHHlv195yeUZeLPAm3WNNggq9kZ
         t+D37AmT+SzT08kHjpliGrO/W3/tuTLK5QH+p71aP7Y+JC5IWu8PaxHqiOEF02uMeGem
         VHxg==
X-Gm-Message-State: APjAAAXtbOmXI+Ku+IYqCLXDCMIenai5QKmZQib3ft7+qOiOx+Tqon3g
        paAloT4pTad8LGTQTyiTDTXJSg==
X-Google-Smtp-Source: APXvYqycGLOZaBaQu3Hqaeuta4YY/jPKmGOsSO3iqRpNJkIQ54WkKeTGxoc6scloX9pTQNenda0JAg==
X-Received: by 2002:a63:541e:: with SMTP id i30mr5002051pgb.183.1578671649500;
        Fri, 10 Jan 2020 07:54:09 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w6sm3769223pfq.99.2020.01.10.07.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 07:54:08 -0800 (PST)
Date:   Fri, 10 Jan 2020 10:54:07 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     jgg@ziepe.ca, dennis.dalessandro@intel.com,
        mike.marciniszyn@intel.com, dledford@redhat.com,
        paulmck@kernel.org, rcu@vger.kernel.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list
 checking
Message-ID: <20200110155407.GB128013@google.com>
References: <20200107192912.22691-1-madhuparnabhowmik04@gmail.com>
 <20200107203354.GD26174@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107203354.GD26174@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 08, 2020 at 01:35:07PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> On Wed, Jan 08, 2020 at 12:59:12AM +0530, madhuparnabhowmik04@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > 
> > list_for_each_entry_rcu has built-in RCU and lock checking.
> > Pass cond argument to list_for_each_entry_rcu.
> > 
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> >  drivers/infiniband/hw/hfi1/verbs.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
> > index 089e201d7550..e6abdbcb4ffb 100644
> > +++ b/drivers/infiniband/hw/hfi1/verbs.c
> > @@ -515,7 +515,8 @@ static inline void hfi1_handle_packet(struct hfi1_packet *packet,
> >  				       opa_get_lid(packet->dlid, 9B));
> >  		if (!mcast)
> >  			goto drop;
> > -		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
> > +		list_for_each_entry_rcu(p, &mcast->qp_list, list,
> > +					lock_is_held(&(ibp->rvp.lock).dep_map)) {
> 
> Why .dep_map? Does this compile?

Yeah, have you really compiled this? Don't send patches without at least
compile testing !!

> Alternatively, it can be lockdep_is_held(ibp->rvp.lock).
> Please refer to the macro(link below) and let me know if the usage of lock_is_held()
> in the patch is correct.
> 
> https://elixir.bootlin.com/linux/v5.5-rc2/source/include/linux/lockdep.h#L364

Please use lockdep_is_held(). Thanks.

thanks,

 - Joel

> 
> Thanks,
> Madhuparna
> Jason
