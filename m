Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65751D0EC8
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 12:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbgEMKCQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 06:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387493AbgEMKCJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 06:02:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C0FC061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 03:02:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h17so11213635wrc.8
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AZ2PpraJk5BqpBiJd2vZOsuZr8AFn5l1GRqTTK6M890=;
        b=X6dr5m1OXa5Gk6VjCe8HNoCOn/zMYHnbTdqIHIdPm3Hc84zgraA0scB+OaxMkcD6mS
         cJu1Ud9M67iEs6UXZHDWQ3s1h7/Eoxo6pTlOvZwP/aIa4BEt9LGHR1g8zkB/GoitrRnH
         BvVXrxkE6zWYHuNafwHu0P+pbv31AT3aReEII+7EkqvUl/KKQOI+mTQYgT4Z2gS8eiKZ
         mAVUkRULqiZoc3xXLVzYraq6qGU3Ck2WnYmc0Jjuxh+h/OzA3l5s/r0qp9Ss8WKmkFU8
         c5yD2s8VozOMTmM1h06qWIvAsvNWO9si/nYKtIocrVSLqUEHBChqiEfKWqbjGzOzhpLf
         yqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AZ2PpraJk5BqpBiJd2vZOsuZr8AFn5l1GRqTTK6M890=;
        b=t9ps2iSGikm7yimqHJkJTGemYskY3EcjAxVr8DGtcSznPsIY3zX/9FlLAsLzVEp2sH
         gNDHp+h73d5MRKqO5B6B6tUUv95aFKg50lu/dV4nY8QzPo595unZ95xGpzbSRD3hRBZ5
         MuGnQeGu5CdwfS/9pXmtTYHsEjccshiKxcsHmDSQeGtGQhu0vq0Kq7fv/WMpjb5GoQ/C
         2z2XVYemUdC8ajq6Q3HzrOPMUy66Le0/TIP7kiQ5Pza8KmDbPFrWvK25CTYU6pU8Oh1l
         s8UVPC136E3el8kk6MF+e0g5fZoEBvRtHtUWLrxOLauHoyjTctbwBUioXO5yV2MPuZJt
         rhTQ==
X-Gm-Message-State: AOAM532egnqcIlhYfJvLvjor2+fSudNWnR54mA2FG2Zw4vnh75pRzO9J
        SGpVQjwHQDVkp+6AvgborbY=
X-Google-Smtp-Source: ABdhPJzquOlPkcMsyQjWX5M+RQIscIysEevddYbREgNQLU0jtyy4PQFKSw30/NpKw1B7GLBk/s3k0w==
X-Received: by 2002:adf:f783:: with SMTP id q3mr6785553wrp.348.1589364128028;
        Wed, 13 May 2020 03:02:08 -0700 (PDT)
Received: from kheib-workstation ([37.142.4.4])
        by smtp.gmail.com with ESMTPSA id r9sm18064897wmg.47.2020.05.13.03.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 03:02:07 -0700 (PDT)
Date:   Wed, 13 May 2020 13:02:04 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix disabling device management
Message-ID: <20200513100204.GA92901@kheib-workstation>
References: <20200511222918.62576-1-kamalheib1@gmail.com>
 <20200513072203.GR4814@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513072203.GR4814@unreal>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 10:22:03AM +0300, Leon Romanovsky wrote:
> On Tue, May 12, 2020 at 01:29:18AM +0300, Kamal Heib wrote:
> > Avoid disabling device management for devices that don't support
> > Management datagrams (MADs) by checking if the "mad_agent" pointer is
> > initialized before calling ib_modify_port, also change the error message
> > to a warning and make it more informative.
> >
> > Fixes: 09f8a1486dca ("RDMA/srpt: Fix handling of SR-IOV and iWARP ports")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > index 7ed38d1cb997..7b21792ab6f7 100644
> > --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> > +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> > @@ -625,14 +625,18 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
> >  		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
> >  	};
> >  	struct srpt_port *sport;
> > +	int ret;
> >  	int i;
> >
> >  	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
> >  		sport = &sdev->port[i - 1];
> >  		WARN_ON(sport->port != i);
> > -		if (ib_modify_port(sdev->device, i, 0, &port_modify) < 0)
> > -			pr_err("disabling MAD processing failed.\n");
> >  		if (sport->mad_agent) {
> > +			ret = ib_modify_port(sdev->device, i, 0, &port_modify);
> > +			if (ret < 0)
> > +				pr_warn("%s-%d: disabling device management failed (%d). Note: this is expected if SR-IOV is enabled.\n",
> > +					dev_name(&sport->sdev->device->dev),
> 
> The ib_modify_port() shouldn't be called if it expected to fail.
> 
> Thanks

OK, Do you know if there is a way to check if the created ib device is
for VF to avoid calling ib_modify_port()?

Thanks,
Kamal

> 
> > +					sport->port, ret);
> >  			ib_unregister_mad_agent(sport->mad_agent);
> >  			sport->mad_agent = NULL;
> >  		}
> > --
> > 2.25.4
> >
