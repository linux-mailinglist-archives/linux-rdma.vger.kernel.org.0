Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0EA230584
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 10:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgG1IgC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 04:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgG1IgC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 04:36:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03934C061794
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 01:36:02 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so17325854wml.3
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wy6Pk2N46siICn3gqgMyAIH2HUaoIhFGrgO/jZD7Lx4=;
        b=WnQ4tF07eT7km5h9+yxSCgs6IQQP8HTNuFJ/XHBsOEWWM+r3ejncP6iApVmFO2WfHt
         57xbdOFOh4gIAFZYzstJQvOFwRbILwTCaB6Pz+kLXX7/mT0y1ROxJXJ4Ccv/D+boYNbd
         JeTUncPiIKmjMMS2bHU1DykdKP/WRLqoiDmZgJt0PthFrnyq59p8HUX8JXKNl5fe8PDa
         LpzHwhK1o6IYLQ/ddY/YUHsiO3UyWJd4/XcVCWOadRCFtZV0C8RPAPpFv4cULzCg11Bk
         FFxB7xAqptyg2fJcHbL2OCwaQtIGqug3+W3jU/bRhr+RKY8sErHdlvZpXvh5LhTvoLzi
         1Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wy6Pk2N46siICn3gqgMyAIH2HUaoIhFGrgO/jZD7Lx4=;
        b=s0uSnxsV20GTrY79/cr1EXoEqOwG70eiyKpmF/v99D557jqv/68FcYs7rsVDM8XY2z
         NonFgm+SzKAUE8Dw7EaXMdgjNRca/yueO/A7ZgyJu4EVuU2QNE2SZ2mG104vXYEY1DNs
         Mun8FQlO6HUiojK76BVmHB57UTgA2KUEstPFw2aYZTD6xeqRKtgB1Q4yvCjXCDEcZevf
         PpNwARmUAozuTUmNVqOkqV0iY+W2HKCW5DO6qUgY23ZKxFCSggeJVB15ATeDjccmsVBZ
         X+qk2TJWiSRMu/DHrpEDb/1utPqLNS+mFZtdblG8zjGsIGnMwxV0Cd92UAop8A1UpJwI
         IBhA==
X-Gm-Message-State: AOAM531LmzrNoi1LtcPjoY/9x6gkozgEaWf7Xin1cc7tEE1oW/Z7GY6Y
        LyrIKoaKFCnmJoLfuj64Kug=
X-Google-Smtp-Source: ABdhPJzhB+R+d8Q3bCe2SrHe8xFKGbhOzHNwQZv9VA6iFp/0tbUmYpkMt9ya+Zni0xBs8jJnJDh7mg==
X-Received: by 2002:a05:600c:2209:: with SMTP id z9mr2910615wml.70.1595925360732;
        Tue, 28 Jul 2020 01:36:00 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id t25sm2834863wmj.18.2020.07.28.01.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 01:36:00 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:35:57 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Yanjun Zhu <yanjunz@mellanox.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: FW: [PATCH for-next] RDMA/rxe: Remove pkey table
Message-ID: <20200728083557.GA73564@kheib-workstation>
References: <20200721101618.686110-1-kamalheib1@gmail.com>
 <AM6PR05MB6263CFB337190B1740CDF4B7D8780@AM6PR05MB6263.eurprd05.prod.outlook.com>
 <CAD=hENePPVzfaC_YtCL1izsFSi+U_T=0m18MujARznsWbj=q5g@mail.gmail.com>
 <20200723055723.GA828525@kheib-workstation>
 <7a6d602f-1adc-cc36-5a11-e0beb6e31cec@gmail.com>
 <20200723072546.GA835185@kheib-workstation>
 <81816c7d-9b14-98de-c6ee-0a6b4a43a060@gmail.com>
 <20200723131549.GM25301@ziepe.ca>
 <4796e70a-ca67-2d48-fdd8-e5593474d204@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4796e70a-ca67-2d48-fdd8-e5593474d204@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 23, 2020 at 11:15:00PM +0800, Zhu Yanjun wrote:
> On 7/23/2020 9:15 PM, Jason Gunthorpe wrote:
> > On Thu, Jul 23, 2020 at 09:08:39PM +0800, Zhu Yanjun wrote:
> > > On 7/23/2020 3:25 PM, Kamal Heib wrote:
> > > > On Thu, Jul 23, 2020 at 02:58:41PM +0800, Zhu Yanjun wrote:
> > > > > On 7/23/2020 1:57 PM, Kamal Heib wrote:
> > > > > > On Wed, Jul 22, 2020 at 10:09:04AM +0800, Zhu Yanjun wrote:
> > > > > > > On Tue, Jul 21, 2020 at 7:28 PM Yanjun Zhu <yanjunz@mellanox.com> wrote:
> > > > > > > > From: Kamal Heib <kamalheib1@gmail.com>
> > > > > > > > Sent: Tuesday, July 21, 2020 6:16 PM
> > > > > > > > To: linux-rdma@vger.kernel.org
> > > > > > > > Cc: Yanjun Zhu <yanjunz@mellanox.com>; Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
> > > > > > > > Subject: [PATCH for-next] RDMA/rxe: Remove pkey table
> > > > > > > > 
> > > > > > > > The RoCE spec require from RoCE devices to support only the defualt pkey, While the rxe driver maintain a 64 enties pkey table and use only the first entry. With that said remove the maintaing of the pkey table and used the default pkey when needed.
> > > > > > > > 
> > > > > > > Hi Kamal
> > > > > > > 
> > > > > > > After this patch is applied, do you make tests with SoftRoCE and mlx hardware?
> > > > > > > 
> > > > > > > The SoftRoCE should work well with the mlx hardware.
> > > > > > > 
> > > > > > > Zhu Yanjun
> > > > > > > 
> > > > > > Hi Zhu,
> > > > > > 
> > > > > > Yes, please see below:
> > > > > > 
> > > > > > $ ibv_rc_pingpong -d mlx5_0 -g 11
> > > > > >      local address:  LID 0x0000, QPN 0x0000e3, PSN 0x728a4f, GID ::ffff:172.31.40.121
> > > > > Can you make tests with GSI QP?
> > > > > 
> > > > > Zhu Yanjun
> > > > > 
> > > Is this the GSI ?
> > > 
> > > Please check GSI in "InfiniBandTM Architecture Specification Volume 1
> > > Release 1.3"
> > > 
> > > Then make tests with GSI again.
> 
> The followings are also removed by this commit. Not sure if it is good.
> 
> "
> 
> C9-42: If the destination QP is QP1, the BTH:P_Key shall be compared to the
> set of P_Keys associated with the port on which the packet arrived. If the
> P_Key matches any of the keys associated with the port, it shall be
> considered valid.
> 
> "
>

The above is correct for ports that configured to work in InfiniBand
mode, while in RoCEv2 mode only the default P_Key should be associated
with the port (Please see below from "ANNEX A17:   ROCEV2 (IP ROUTABLE
ROCE)):

"""
17.7.1 LOADING THE P_KEY TABLE

Compliance statement C17-7: on page 1193 describes requirements for
setting the P_Key table based on an assumption that the P_Key table is
set directly by a Subnet Manager. However, RoCEv2 ports do not support
InfiniBand Subnet Management. Therefore, compliance statement C17-7:
on page 1193 does not apply to RoCEv2 ports.

Methods for setting the P_Key table associated with a RoCEv2 port are
not defined in this specification, except for the requirements for a
default P_Key described elsewhere in this annex.
"""

Thanks,
Kamal


> > rping uses RDMA CM which goes over the GSI
> > 
> > Jason
> 
> 
