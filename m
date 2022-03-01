Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B697D4C90FE
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Mar 2022 17:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiCARAJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Mar 2022 12:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiCARAJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Mar 2022 12:00:09 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658E91A399
        for <linux-rdma@vger.kernel.org>; Tue,  1 Mar 2022 08:59:27 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id z66so13396224qke.10
        for <linux-rdma@vger.kernel.org>; Tue, 01 Mar 2022 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TrNHDQUkGBu8wydpZ1E/4K+K8I/rZmamog3sPcf8Y6k=;
        b=BLU9kpmY6xJ6EcfxtyZuq7eR48zlZn7mfHZM36yxvbC58xFuhbbL8bCeGbuUU7IhPT
         s3XCPJ07/AEF5CuuU4GXWkw+yG5sXIQ4uMrvy+Zqbh4Yn28xeH9VilTQwtHsVoM1h1lL
         ljOUd+ioDnEitGwWXIyh7zaHtuDlASbWFcnf+4vFCNyMPI2Qefx2aoNOWLtoYbXnYSsz
         FfKl8ihra9h3FvJ/c2x1B8vYiKAM0ZmZg5itrFmmezXKt5a0Trm8SmoAy0GACoB06bZj
         TY+BZ86UbGEhm/mo6U4Yyzib+cCJskq/HoLAayVPMwHWGA0UzIDnp0mzHoDv4rnDp07H
         Ouqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TrNHDQUkGBu8wydpZ1E/4K+K8I/rZmamog3sPcf8Y6k=;
        b=yT2r3vtEUb1TIeNcH+uFIW7max9vPWu8Rax2YWnYKT8FH7nUxaJiPL9u7xIJuTezD7
         HHjrl2w1Ds03/Sl2DBJd5m5oodHp3tQGCgorOspKR/E7rvJci+5hJ5G1dM1hRPwrSp1s
         kGuNuU+T/ffbhSl9J4kemp0EwPKksK13kcjXWJgc2abLvpBdnGAyOMeqdfzrItPHJmsO
         wL6VrfjtsVk6icpdnVp+bJHtceR6x5SH24e3QLGiu2tQIvlgJaKjPkaUc+lwb+iotJqy
         aFrtdkeneP31tkaL+90ER9pYxt/iqKGWSZIax7+dYLZ56x9tv0L2cOu2e5EQowAvGLot
         FBsg==
X-Gm-Message-State: AOAM533sh5Om+FawnIuvycrt1NCFOL3M160TPiE17EyNHgSuJRKIB26/
        fFvOnD2LvK8aJxhzVlfGZTZuLuUfn4hWqg==
X-Google-Smtp-Source: ABdhPJwGXjflRXEhfyNlrFiq4F7WXsdkNnijTRnFZILBpsaX7WQwzzuXfBjPQBrwleYKYkdgR+1wvA==
X-Received: by 2002:a05:620a:1259:b0:62c:eb53:abf6 with SMTP id a25-20020a05620a125900b0062ceb53abf6mr14210849qkl.769.1646153965660;
        Tue, 01 Mar 2022 08:59:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id v8-20020a05620a090800b00648b78de69fsm6783954qkv.4.2022.03.01.08.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 08:59:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nP5qO-003Zxl-6C; Tue, 01 Mar 2022 12:59:24 -0400
Date:   Tue, 1 Mar 2022 12:59:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/hfi1: Allow larger MTU without AIP
Message-ID: <20220301165924.GG6468@ziepe.ca>
References: <1644348309-174874-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
 <42673e10-e828-fd6c-b098-2638cac6bea9@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42673e10-e828-fd6c-b098-2638cac6bea9@cornelisnetworks.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 01, 2022 at 11:49:09AM -0500, Dennis Dalessandro wrote:
> On 2/8/22 2:25 PM, mike.marciniszyn@cornelisnetworks.com wrote:
> > From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> > 
> > The AIP code signals the phys_mtu in the following query_port()
> > fragment:
> > 
> > 	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
> > 				ib_mtu_enum_to_int(props->max_mtu);
> > 
> > Using the largest MTU possible should not depend on AIP.
> > 
> > Fix by unconditionally using the hfi1_max_mtu value.
> > 
> > Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> > Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> >  drivers/infiniband/hw/hfi1/verbs.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
> > index dc9211f..99d0743 100644
> > +++ b/drivers/infiniband/hw/hfi1/verbs.c
> > @@ -1397,8 +1397,7 @@ static int query_port(struct rvt_dev_info *rdi, u32 port_num,
> >  				      4096 : hfi1_max_mtu), IB_MTU_4096);
> >  	props->active_mtu = !valid_ib_mtu(ppd->ibmtu) ? props->max_mtu :
> >  		mtu_to_enum(ppd->ibmtu, IB_MTU_4096);
> > -	props->phys_mtu = HFI1_CAP_IS_KSET(AIP) ? hfi1_max_mtu :
> > -				ib_mtu_enum_to_int(props->max_mtu);
> > +	props->phys_mtu = hfi1_max_mtu;
> >  
> >  	return 0;
> >  }
> 
> Fixes: 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
> 
> Can this just get queued up for-next or should I resubmit with the fixes line above?

Is it OK without the prior patch in the series?

Jason
