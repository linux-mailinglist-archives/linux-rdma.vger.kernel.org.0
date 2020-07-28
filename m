Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC0E23110B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbgG1Rmb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 13:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731918AbgG1Rmb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 13:42:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F4C061794
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 10:42:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d190so333610wmd.4
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=frlnguLguKvlBsyXRrBXRxT/thMPCjnRf0EfDYjH6Ao=;
        b=l39NScSf7F+vOUDueDUnP1+3vxIuY4Je0NjamLnfPwH82hh/CHkS8OZWvvww6u7UPb
         4/VidAwVMWXg1oKZCiFlCjkjmjN5wpZk8rRAakMhRQ1VWn4NV/ZEmwbE3ocpJRWqhYOg
         si3G7n4VaPAa+uFf77XprdZuP0FHiULTKaJ3jSAn70g96/uhnP3NgOy2rlGLws5z4vN4
         CpCm6OlNtXgGACt+u1z/7pt6el2lJjsmj9Q32v59B1wDBekJyC+FtI9zw6q0Ptj1K1UG
         zqtpNbYcbKo/CdUMsRspGSyad99xbsnBC5BgbUKMqDckYxxGc/wQAEvmRihg5OwDE0Rl
         mzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=frlnguLguKvlBsyXRrBXRxT/thMPCjnRf0EfDYjH6Ao=;
        b=WSWPFM/ZP7ri2Eytczs4jiDSwtt1L7KAQJ6+eYY8++R9Y0s7zBrKEffob7LnGaVTf+
         rsA4bIGD2AFyllwMfHMr5BjibaNFH9EYA7sRRd5GF3oBwLLblAi/SOGT0jcPZeNmMW3g
         ByBZGmtjBcuVLlL8AfWSt72m6u9MHgqW/5wgkVf3gysnfDcKKPfQmu1EzxLGKYU+MNeC
         vw08ZwfHLNy1GguVb50zAnUg6NR9161HhsVrVyRFqiCof//ZF6JDEVMxN48LWdIvl+1d
         0u1gp7MH6iSr5fZt8tmtPyeoHJmH3JpfpHJF4BqTg7KyCu7KYQyH3ORTTxrl06/l2Mcs
         i1yQ==
X-Gm-Message-State: AOAM530SdvzCNv1gkLY8CxvBlsQhvVYPWmyA//CuQrK9/urfZGoIX8BU
        hItvGzqkScdGLSkVY6Z7bJQ=
X-Google-Smtp-Source: ABdhPJx7y86GkyQ6DGLs4KRjXNRV95ZAi587oMRJo8dAnelQneF+LcWfSxdHsLRuxG1r1/P0n5MaPA==
X-Received: by 2002:a1c:5603:: with SMTP id k3mr4892036wmb.22.1595958149491;
        Tue, 28 Jul 2020 10:42:29 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 62sm19640408wrq.31.2020.07.28.10.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 10:42:28 -0700 (PDT)
Date:   Tue, 28 Jul 2020 20:42:25 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Yanjun Zhu <yanjunz@mellanox.com>,
        linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: FW: [PATCH for-next] RDMA/rxe: Remove pkey table
Message-ID: <20200728174225.GA52282@kheib-workstation>
References: <20200723055723.GA828525@kheib-workstation>
 <7a6d602f-1adc-cc36-5a11-e0beb6e31cec@gmail.com>
 <20200723072546.GA835185@kheib-workstation>
 <81816c7d-9b14-98de-c6ee-0a6b4a43a060@gmail.com>
 <20200723131549.GM25301@ziepe.ca>
 <4796e70a-ca67-2d48-fdd8-e5593474d204@gmail.com>
 <20200728083557.GA73564@kheib-workstation>
 <9a6f21eb-a9c7-ed77-31b3-f9befa5a49b0@gmail.com>
 <20200728134442.GA29573@kheib-workstation>
 <93160a8d-fca7-defc-b39e-e6e5a97ddb87@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93160a8d-fca7-defc-b39e-e6e5a97ddb87@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 28, 2020 at 11:46:36PM +0800, Zhu Yanjun wrote:
> On 7/28/2020 9:44 PM, Kamal Heib wrote:
> > On Tue, Jul 28, 2020 at 09:21:06PM +0800, Zhu Yanjun wrote:
> > > On 7/28/2020 4:35 PM, Kamal Heib wrote:
> > > > On Thu, Jul 23, 2020 at 11:15:00PM +0800, Zhu Yanjun wrote:
> > > > > On 7/23/2020 9:15 PM, Jason Gunthorpe wrote:
> > > > > > On Thu, Jul 23, 2020 at 09:08:39PM +0800, Zhu Yanjun wrote:
> > > > > > > On 7/23/2020 3:25 PM, Kamal Heib wrote:
> > > > > > > > On Thu, Jul 23, 2020 at 02:58:41PM +0800, Zhu Yanjun wrote:
> > > > > > > > > On 7/23/2020 1:57 PM, Kamal Heib wrote:
> > > > > > > > > > On Wed, Jul 22, 2020 at 10:09:04AM +0800, Zhu Yanjun wrote:
> > > > > > > > > > > On Tue, Jul 21, 2020 at 7:28 PM Yanjun Zhu <yanjunz@mellanox.com> wrote:
> > > > > > > > > > > > From: Kamal Heib <kamalheib1@gmail.com>
> > > > > > > > > > > > Sent: Tuesday, July 21, 2020 6:16 PM
> > > > > > > > > > > > To: linux-rdma@vger.kernel.org
> > > > > > > > > > > > Cc: Yanjun Zhu <yanjunz@mellanox.com>; Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
> > > > > > > > > > > > Subject: [PATCH for-next] RDMA/rxe: Remove pkey table
> > > > > > > > > > > > 
> > > > > > > > > > > > The RoCE spec require from RoCE devices to support only the defualt pkey, While the rxe driver maintain a 64 enties pkey table and use only the first entry. With that said remove the maintaing of the pkey table and used the default pkey when needed.
> > > > > > > > > > > > 
> > > > > > > > > > > Hi Kamal
> > > > > > > > > > > 
> > > > > > > > > > > After this patch is applied, do you make tests with SoftRoCE and mlx hardware?
> > > > > > > > > > > 
> > > > > > > > > > > The SoftRoCE should work well with the mlx hardware.
> > > > > > > > > > > 
> > > > > > > > > > > Zhu Yanjun
> > > > > > > > > > > 
> > > > > > > > > > Hi Zhu,
> > > > > > > > > > 
> > > > > > > > > > Yes, please see below:
> > > > > > > > > > 
> > > > > > > > > > $ ibv_rc_pingpong -d mlx5_0 -g 11
> > > > > > > > > >        local address:  LID 0x0000, QPN 0x0000e3, PSN 0x728a4f, GID ::ffff:172.31.40.121
> > > > > > > > > Can you make tests with GSI QP?
> > > > > > > > > 
> > > > > > > > > Zhu Yanjun
> > > > > > > > > 
> > > > > > > Is this the GSI ?
> > > > > > > 
> > > > > > > Please check GSI in "InfiniBandTM Architecture Specification Volume 1
> > > > > > > Release 1.3"
> > > > > > > 
> > > > > > > Then make tests with GSI again.
> > > > > The followings are also removed by this commit. Not sure if it is good.
> > > > > 
> > > > > "
> > > > > 
> > > > > C9-42: If the destination QP is QP1, the BTH:P_Key shall be compared to the
> > > > > set of P_Keys associated with the port on which the packet arrived. If the
> > > > > P_Key matches any of the keys associated with the port, it shall be
> > > > > considered valid.
> > > > > 
> > > > > "
> > > > > 
> > > > The above is correct for ports that configured to work in InfiniBand
> > > > mode, while in RoCEv2 mode only the default P_Key should be associated
> > > > with the port (Please see below from "ANNEX A17:   ROCEV2 (IP ROUTABLE
> > > > ROCE)):
> > > > 
> > > > """
> > > > 17.7.1 LOADING THE P_KEY TABLE
> > > > 
> > > > Compliance statement C17-7: on page 1193 describes requirements for
> > > > setting the P_Key table based on an assumption that the P_Key table is
> > > > set directly by a Subnet Manager. However, RoCEv2 ports do not support
> > > > InfiniBand Subnet Management. Therefore, compliance statement C17-7:
> > > > on page 1193 does not apply to RoCEv2 ports.
> > > "
> > > 
> > > C17-7: An HCA shall require no OS involvement to set the P_Key table;
> > > 
> > > the P_Key table shall be set directly by Subnet Manager MADs.
> > > 
> > > "
> > > 
> > > In SoftRoCE, what set the P_Key table?
> > > 
> > No one is setting the P_Key table in SoftRoCE, and no subnet manager in
> > the RoCE fabric.
> > 
> > Could you please tell me what is wrong with this patch?
> 
> Please read the mail thread again.
> 
> GSI QP number is 1. In your commits, the handle of qpn == 1 is removed.
> 
> It seems that it conflicts with IB specification.
> 
> Not sure if it is good.
>

Could you please read my patch again and point to what do you think is
wrong?

What I did in this patch is to verify that the pkey value in the
received packet is the default P_Key regardless of the qpn, because RoCE
devices should maintain only the default P_Key.

Thanks,
Kamal

> > 
> > Thanks,
> > Kamal
> > 
> > > > Methods for setting the P_Key table associated with a RoCEv2 port are
> > > > not defined in this specification, except for the requirements for a
> > > > default P_Key described elsewhere in this annex.
> > > > """
> > > > 
> > > > Thanks,
> > > > Kamal
> > > > 
> > > > 
> > > > > > rping uses RDMA CM which goes over the GSI
> > > > > > 
> > > > > > Jason
> 
> 
