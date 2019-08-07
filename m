Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E17FD84950
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 12:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfHGKVJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 06:21:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34263 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfHGKVJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 06:21:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so90825069wrm.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T4g0r09YdZXOGOhY3FY4vZ6XeG/doH79bLoOg/2rG0A=;
        b=VrTuDmPMUSXTx/PPWZF/mh2ApU5H5kSs4S0ETO3FGrXvtMIg9ySW4vnzsWwRNQGwr5
         FUnsSeqfw9+ScnPrG4ga2gv+5u2mT2lFXV8/SsJjvAWEef5dbqJJswM545Cs1FpS2oyB
         Hw/ekyr043YOcK6S3cBdEJzfC7JJ8wMykIEQlVUONiXS2ixpkN3J6Eg+QcVJaDGhlm33
         +onQmdzESExd7mr1PO1CujIGY35humUM0ZfodrPBFUgjME+bXriZK+eXA1xnOLHlba3V
         1HHK5DQNMeI+EBKTZaLI8VBC1C2b6l6g+8EV8GlTVAkt6EQu9kVTF3vo5K2xV87jOJGu
         sm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T4g0r09YdZXOGOhY3FY4vZ6XeG/doH79bLoOg/2rG0A=;
        b=N6ACxnDrKHooL5wIs1gM6ONC3xXmJaP5d0EGRDgQTFYfyvRbtkKaynJiuFN01Q35+O
         pJ8TnkA4mMErNOaGPoNyFwWGLvIbpNDYVZtBCtBNjPiWkVD7/1gWFQemJBrklOy+88GW
         OimJL0z4EAIgaIorxHkDVMLJtVbz2F4DQ3m4Am1Gc7VeIAruCmFCu71ve9GuaDys5EY2
         FG6DuWc51XFAfQdnJLe19S+ZGjUVunzl51EU40uv1ldRmV5YKrf/de2kAEkga6VYrrgS
         Oyly6A4/QBLB5FOs2tOYIGrSKAcs78r0pwuuektIFL4jK3zbrVc68CysoJLDccJW79WP
         +YBg==
X-Gm-Message-State: APjAAAXmYC0PU5fffP9QV3JRLb0Fhq+FmGkV1D46FAOK+td1U+NbxZQe
        BuiMq/D3R3NKk5QpgvgxO0w=
X-Google-Smtp-Source: APXvYqy+s+PTOn/g3BB/ta/Tg6D9/5rpykkVGBboGK1JOimqBL1WNDBpPSLjP/Hyyazn/gAGLEbE8A==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr9001953wrr.194.1565173267149;
        Wed, 07 Aug 2019 03:21:07 -0700 (PDT)
Received: from kheib-workstation (bzq-109-66-104-187.red.bezeqint.net. [109.66.104.187])
        by smtp.gmail.com with ESMTPSA id h133sm97095267wme.28.2019.08.07.03.21.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 03:21:06 -0700 (PDT)
Date:   Wed, 7 Aug 2019 13:21:02 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>
Subject: Re: [PATCH for-next V3 1/4] RDMA: Introduce ib_port_phys_state enum
Message-ID: <20190807102102.GA16257@kheib-workstation>
References: <20190802093210.5705-1-kamalheib1@gmail.com>
 <20190802093210.5705-2-kamalheib1@gmail.com>
 <20190806095638.GU4832@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806095638.GU4832@mtr-leonro.mtl.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 12:56:38PM +0300, Leon Romanovsky wrote:
> On Fri, Aug 02, 2019 at 12:32:07PM +0300, Kamal Heib wrote:
> > In order to improve readability, add ib_port_phys_state enum to replace
> > the use of magic numbers.
> >
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > Reviewed-by: Andrew Boyer <aboyer@tobark.org>
> > ---
> >  drivers/infiniband/core/sysfs.c              | 24 +++++++++++++-------
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  4 ++--
> >  drivers/infiniband/hw/efa/efa_verbs.c        |  2 +-
> >  drivers/infiniband/hw/hns/hns_roce_device.h  | 10 --------
> >  drivers/infiniband/hw/hns/hns_roce_main.c    |  3 ++-
> >  drivers/infiniband/hw/mlx4/main.c            |  3 ++-
> >  drivers/infiniband/hw/mlx5/main.c            |  4 ++--
> >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |  4 ++--
> >  drivers/infiniband/hw/qedr/verbs.c           |  4 ++--
> >  drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  7 +++---
> >  drivers/infiniband/sw/rxe/rxe.h              |  4 ----
> >  drivers/infiniband/sw/rxe/rxe_param.h        |  2 +-
> >  drivers/infiniband/sw/rxe/rxe_verbs.c        |  6 ++---
> >  drivers/infiniband/sw/siw/siw_verbs.c        |  3 ++-
> >  include/rdma/ib_verbs.h                      | 10 ++++++++
> >  15 files changed, 49 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> > index b477295a96c2..46722e04f6e1 100644
> > --- a/drivers/infiniband/core/sysfs.c
> > +++ b/drivers/infiniband/core/sysfs.c
> > @@ -301,14 +301,22 @@ static ssize_t phys_state_show(struct ib_port *p, struct port_attribute *unused,
> >  		return ret;
> >
> >  	switch (attr.phys_state) {
> > -	case 1:  return sprintf(buf, "1: Sleep\n");
> > -	case 2:  return sprintf(buf, "2: Polling\n");
> > -	case 3:  return sprintf(buf, "3: Disabled\n");
> > -	case 4:  return sprintf(buf, "4: PortConfigurationTraining\n");
> > -	case 5:  return sprintf(buf, "5: LinkUp\n");
> > -	case 6:  return sprintf(buf, "6: LinkErrorRecovery\n");
> > -	case 7:  return sprintf(buf, "7: Phy Test\n");
> > -	default: return sprintf(buf, "%d: <unknown>\n", attr.phys_state);
> > +	case IB_PORT_PHYS_STATE_SLEEP:
> > +		return sprintf(buf, "1: Sleep\n");
> > +	case IB_PORT_PHYS_STATE_POLLING:
> > +		return sprintf(buf, "2: Polling\n");
> > +	case IB_PORT_PHYS_STATE_DISABLED:
> > +		return sprintf(buf, "3: Disabled\n");
> > +	case IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING:
> > +		return sprintf(buf, "4: PortConfigurationTraining\n");
> > +	case IB_PORT_PHYS_STATE_LINK_UP:
> > +		return sprintf(buf, "5: LinkUp\n");
> > +	case IB_PORT_PHYS_STATE_LINK_ERROR_RECOVERY:
> > +		return sprintf(buf, "6: LinkErrorRecovery\n");
> > +	case IB_PORT_PHYS_STATE_PHY_TEST:
> > +		return sprintf(buf, "7: Phy Test\n");
> > +	default:
> > +		return sprintf(buf, "%d: <unknown>\n", attr.phys_state);
> >  	}
> 
> If you touch that function, the better way to write it will be like here (without OPA)
> https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/rdma/link.c#n209
> 
> sprintf(buf, "%d: %s\n", attr.phys_state, phys_state_to_str(attr.phys_state));
> 
> Thanks

OK, I'll send v4 soon.

Thanks,
Kamal
