Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8736F398A38
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 15:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhFBNNF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 09:13:05 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:37386 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhFBNNF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Jun 2021 09:13:05 -0400
Received: by mail-wr1-f54.google.com with SMTP id q5so2262520wrs.4
        for <linux-rdma@vger.kernel.org>; Wed, 02 Jun 2021 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gBCJYnoJpuqRW576Yf02FGegSq1LCH38/9HZEgrcF2c=;
        b=TgWgsv5nRzRRcE/o23ajEupAx5DJm/qWcSffnlMtO1W9BcsCOQ1KrTx0GzR+D5X+Ep
         vMFnIAIbW33t+D6wyHGCO0pgAEFUwQAwDbY63Xya9OHWVIKhYylp0yzchvF0vKWhArFT
         VWSD3sw6anwKUE9m+k3GdKGj67Tf6FLrfAYDONfmPropGa6EGqQ9/FFGHTb4+a0FRWyU
         DlesGOE6iz0lmITLuMJ2Zycb/L73fn2tFxz3yeJs7TLqWRMlGzHpQ0hkrCsqLGONavSr
         pyvDMcNHyXwkSIoxsGfYdCGttDBA7O11u76zyVpoI1hF9MYXMRudISmlCrFKwqWtp3jT
         PxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gBCJYnoJpuqRW576Yf02FGegSq1LCH38/9HZEgrcF2c=;
        b=NFR4PEMXiFm6K9EhYSZEzsQYmDXqDzM9rxkIMvTmHSmDlG+VnKR2RoIKNA7kKv87Po
         HqCUG7mVwkv6LiHglQez0HxhhuRXR1dvT9f3sBmOMzl2XhBRexrnBUszvUDKqFk5UIUD
         xZGVi2JR+ZAwr+RjlqHcSEgO47HrPsF0NtD48kWzDAtDumxBnoPM9JlSj7sEj4Poj8Uo
         MHXrE/YW9CXiaOsGtsF+5hptP5frMMym3A03Opl3n8AiHh/RP03LWs1nfl3+X3rEe2gr
         DbYxynhO4x4sY02cI6v0cIpJw/10Hip90xKT+vak3I5mJRnPp1btUn2O+1TcJXljuOP8
         kP7g==
X-Gm-Message-State: AOAM532PtP81ONtd6S9XOD5QMddZfllIcsZMLXFLiTl1eKRMT6tZOsG4
        zQW2XCBgML8ftAD6UYH73zA=
X-Google-Smtp-Source: ABdhPJywfkSpOTcaKQ/5zgOQCjFuZ1qsgYQgrZls+OHcy7DjBgHOKTUG/vwyyH7sUphhAsRezCcCBA==
X-Received: by 2002:a5d:4385:: with SMTP id i5mr12164325wrq.233.1622639410340;
        Wed, 02 Jun 2021 06:10:10 -0700 (PDT)
Received: from kheib-workstation (bzq-109-67-139-103.red.bezeqint.net. [109.67.139.103])
        by smtp.gmail.com with ESMTPSA id t14sm6446949wra.60.2021.06.02.06.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:10:09 -0700 (PDT)
Date:   Wed, 2 Jun 2021 16:10:07 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix failure during driver load
Message-ID: <YLeDL+Omy8QdI+Q+@kheib-workstation>
References: <CAD=hENe9O+3Z9ck6G5+t9RaVpbqUL-edfa+b1-Ki5NZO0eJPPA@mail.gmail.com>
 <8649FCE4-EAEE-4DA9-AF51-FC6329F67C43@gmail.com>
 <CAD=hENdazayh5wmjd=3shHMVrNMrMw40qFdDFbkTqtaST46o8A@mail.gmail.com>
 <YLX5PLZjjoRiDNGN@kheib-workstation>
 <CAD=hENc2v4j9KyAL_La9tZcFzzcGyJdnw=5gwxwyekDxD7aOqA@mail.gmail.com>
 <20210601170132.GN1096940@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601170132.GN1096940@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 01, 2021 at 02:01:32PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 01, 2021 at 11:59:44PM +0800, Zhu Yanjun wrote:
> > On Tue, Jun 1, 2021 at 5:09 PM Kamal Heib <kamalheib1@gmail.com> wrote:
> > >
> > > On Tue, Jun 01, 2021 at 04:11:08PM +0800, Zhu Yanjun wrote:
> > > > On Tue, Jun 1, 2021 at 3:56 PM kamal heib <kamalheib1@gmail.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > On 1 Jun 2021, at 10:45, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> > > > > >
> > > > > > ﻿On Tue, Jun 1, 2021 at 1:58 PM Kamal Heib <kamalheib1@gmail.com> wrote:
> > > > > >>
> > > > > >> To avoid the following failure when trying to load the rdma_rxe module
> > > > > >> while IPv6 is disabled, Add a check to make sure that IPv6 is enabled
> > > > > >> before trying to create the IPv6 UDP tunnel.
> > > > > >>
> > > > > >> $ modprobe rdma_rxe
> > > > > >> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted
> > > > > >
> > > > > > About this problem, this link:
> > > > > > https://patchwork.kernel.org/project/linux-rdma/patch/20210413234252.12209-1-yanjun.zhu@intel.com/
> > > > > > also tries to solve ipv6 problem.
> > > > > >
> > > > > > Zhu Yanjun
> > > > > >
> > > > >
> > > > > Yes, but this patch is fixing the problem more cleanly and I’ve tested it.
> > 
> > Please check this link
> > https://lore.kernel.org/linux-rdma/20210326012723.41769-1-yanjun.zhu@intel.com/T/
> > carefully.
> > 
> > Please pay attention to the comments from Jason Gunthorpe
> 
> I think the comment still holds, the correct fix is to detect the -97
> errno down in the call chain and just ignore ipv6 support in this
> case.
> 
> Jason

OK, Could you please tell me what do you think about the following:

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 01662727dca0..144d9e1c1c3d 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -208,6 +208,11 @@ static struct socket *rxe_setup_udp_tunnel(struct net *net, __be16 port,
        /* Create UDP socket */
        err = udp_sock_create(net, &udp_cfg, &sock);
        if (err < 0) {
+               if (ipv6 && (err == -EAFNOSUPPORT)) {
+                       pr_warn("IPv6 is not supported can not create UDP socket\n");
+                       return NULL;
+               }
+
                pr_err("failed to create udp socket. err = %d\n", err);
                return ERR_PTR(err);
        }


Thanks,
Kamal
