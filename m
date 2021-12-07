Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1AF46B71A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 10:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhLGJef (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 04:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbhLGJef (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Dec 2021 04:34:35 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B914C061574
        for <linux-rdma@vger.kernel.org>; Tue,  7 Dec 2021 01:31:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r11so54126186edd.9
        for <linux-rdma@vger.kernel.org>; Tue, 07 Dec 2021 01:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=opj4WcdlI5ZNn+l9eJPmDZe9yfO0cVZ4QibiFV7tQzQ=;
        b=fhj4tk3pqga2TINcGmzrrO3h+4L3iU1O/Q5JMWP56KnaH2GDxBq2SfnA8Byudsrj4b
         X3wXoVEHZY9EgvxkDAz73gAWjZTlLDpFZLOANgxe/oyYGqqKrnibo+/ygU96GxxfyJcw
         LlK2rapyqWhtx7W6DY9FPoGYjqDTITkgwikRF3krjKPN1JdsMmUIbTCLVOuPxKgI19Fr
         aqODZt0dVcbquOHVp9j+v+KxJM/gHPbbM8GRSuq4+3uFz/t6rjKFSs0aDPwKoAxxF/uA
         g4n6KF73+gCk0uuHmQMPwpBmWj6TG2Wb5Fn7uSP9w3bf4ZhkrkNi3Om4TB5/DinTdSMZ
         HZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=opj4WcdlI5ZNn+l9eJPmDZe9yfO0cVZ4QibiFV7tQzQ=;
        b=Ojcm7x/Uo8DbOiempNtY8gwRqqU46eJ2JunS8lHyBgowxpOwJi6TSqRE5ISV5s4Cxa
         zM62deUN0OjSmKTeAwvmMDr8OIO7fKsFvM2rvLxJDm2Q7cKpQ1/BciIkjlWYxHgcgpX4
         C2usGEpxHWNgVPtwQji3CClaL9/rYIFoMargF7kfjvoLqQJrjdNsW2htKI9n7S3N1HKG
         2mR3cYFQVVBDYx1uLMGQkup8ZUD1qmtk+/BUpdW4uGgE20pzLxT7lQHt25aTr0diGHxD
         PDYOQqfFhpESKE5ppewwAyH8u3CKlc4h7Z05woJY00LSz1h2a9zI4KX5bZtWxBvTB0TX
         Kmnw==
X-Gm-Message-State: AOAM533utgiyE5+1J9u1DR7h0EuO50HeAl5CsaP4GCUblT3kVfR56Kxu
        9yf5ybemHEGBhZ9x6Aok29U=
X-Google-Smtp-Source: ABdhPJz1+UZJeC84QtybhYp0O+C8+Mykhp/VLuww4r9KilNyO1y0t9prawQtINpSq+aQ4uUDzkvBiQ==
X-Received: by 2002:a17:906:5d0b:: with SMTP id g11mr51286704ejt.110.1638869464104;
        Tue, 07 Dec 2021 01:31:04 -0800 (PST)
Received: from fedora ([2a00:a040:19b:e02f::1006])
        by smtp.gmail.com with ESMTPSA id x22sm7993476ejc.97.2021.12.07.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 01:31:03 -0800 (PST)
Date:   Tue, 7 Dec 2021 11:31:00 +0200
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>
Subject: Re: [PATCH for-next] RDMA/qedr: Fix reporting max_{send/recv}_wr
 attrs
Message-ID: <Ya8p1Ade+lWn/APx@fedora>
References: <20211206201314.124947-1-kamalheib1@gmail.com>
 <20211206210655.GR5112@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210655.GR5112@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 05:06:55PM -0400, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 10:13:14PM +0200, Kamal Heib wrote:
> > Fix the wrongly reported max_send_wr and max_recv_wr attributes for user
> > QP by making sure to save their valuse on QP creation, so when query QP
> > is called the attributes will be reported correctly.
> > 
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > ---
> >  drivers/infiniband/hw/qedr/verbs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Fixes line?
> 
> Jason

Fixes: cecbcddf6461 ("qedr: Add support for QP verbs")

Thanks,
Kamal
