Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D4522B02C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jul 2020 15:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgGWNPy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jul 2020 09:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWNPx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jul 2020 09:15:53 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC7C0619DC
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jul 2020 06:15:52 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b25so4333587qto.2
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jul 2020 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s3Kz4WBShDcs5qgGm1I0zwpbjzaO6oOIg1RR99W83uk=;
        b=FVdYHBmQeVgErF01FCx4tlKbcpgrwsThu6AQSkytBrXt1uctsIMASR9huX2+27lo8Q
         apLOrlIzlFsZqQhrgvcDDNKIH5vy7MiYhvuQKuBm+IXWEYY1FtWS5MYHd0uCBwnXdlnB
         McosGiCxz0i5rBXLoXh+0HOSYFJ9v1o+gJ7Yc8q6aK9fm77qN56wZ4AhVBguhBbFUvxb
         zHqx6ReCcblTmuCsZFKGHgEPnPk6tCLiA48DNL1Cebl/DuOWcgdUXiDXi1ccBKZxwxQP
         P52SIu+NteSx54g2j3Y61uJWBZ7YOpJAAzPCNg5Xxpspc4oAIJnjXdbJrj+heqENYmEl
         k6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s3Kz4WBShDcs5qgGm1I0zwpbjzaO6oOIg1RR99W83uk=;
        b=M0ldcheVZPBRMTbYxftTe7H/KOps1OQUKC9IkalIkmWxLyjZ9pMQrQBDlJd9UAkJyq
         cO2sx2EQjgaAzNnu/MRp4Q0BOtJ0khoPHdUgfOWSixER36GzAyC43iUTkrOTnXJqKztY
         DADz+RoUYNITHqe5kXSBKRlWaB3BKhR71UMw5TWj9m+yjmV0KFL81ngr3tRl2D2O1zZ/
         b2NTBVWIaKCKE9pJaqhiK+R90D55ob5SAKArkY8KOfla2Oh5IuKjL//2SoTIKvuGPEk+
         rCLALnNob8xfKFMwqj2+0qp0oDXHoOdmb7ohj9Tqo8Rk4NujFagplSMTBPq+L97enyg7
         rijA==
X-Gm-Message-State: AOAM532LWD4MQmnck1L4eArg804pBUpBWrwhFuzh4xHKKnekG3QzzcEk
        O3U6Z1Qn3mspXub1VoO20whrRQ==
X-Google-Smtp-Source: ABdhPJxy5XEb01ao792t5Wg1n0213n6OndW0Ru8pyozBNrsfYcCCqVzN6xS753DAjfziXULTOCbrwA==
X-Received: by 2002:ac8:7343:: with SMTP id q3mr4394973qtp.165.1595510151151;
        Thu, 23 Jul 2020 06:15:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u6sm2558404qtc.34.2020.07.23.06.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 06:15:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1jyb4f-00EMx9-MR; Thu, 23 Jul 2020 10:15:49 -0300
Date:   Thu, 23 Jul 2020 10:15:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Kamal Heib <kamalheib1@gmail.com>,
        Yanjun Zhu <yanjunz@mellanox.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: FW: [PATCH for-next] RDMA/rxe: Remove pkey table
Message-ID: <20200723131549.GM25301@ziepe.ca>
References: <20200721101618.686110-1-kamalheib1@gmail.com>
 <AM6PR05MB6263CFB337190B1740CDF4B7D8780@AM6PR05MB6263.eurprd05.prod.outlook.com>
 <CAD=hENePPVzfaC_YtCL1izsFSi+U_T=0m18MujARznsWbj=q5g@mail.gmail.com>
 <20200723055723.GA828525@kheib-workstation>
 <7a6d602f-1adc-cc36-5a11-e0beb6e31cec@gmail.com>
 <20200723072546.GA835185@kheib-workstation>
 <81816c7d-9b14-98de-c6ee-0a6b4a43a060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81816c7d-9b14-98de-c6ee-0a6b4a43a060@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 23, 2020 at 09:08:39PM +0800, Zhu Yanjun wrote:
> On 7/23/2020 3:25 PM, Kamal Heib wrote:
> > On Thu, Jul 23, 2020 at 02:58:41PM +0800, Zhu Yanjun wrote:
> > > On 7/23/2020 1:57 PM, Kamal Heib wrote:
> > > > On Wed, Jul 22, 2020 at 10:09:04AM +0800, Zhu Yanjun wrote:
> > > > > On Tue, Jul 21, 2020 at 7:28 PM Yanjun Zhu <yanjunz@mellanox.com> wrote:
> > > > > > 
> > > > > > From: Kamal Heib <kamalheib1@gmail.com>
> > > > > > Sent: Tuesday, July 21, 2020 6:16 PM
> > > > > > To: linux-rdma@vger.kernel.org
> > > > > > Cc: Yanjun Zhu <yanjunz@mellanox.com>; Doug Ledford <dledford@redhat.com>; Jason Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
> > > > > > Subject: [PATCH for-next] RDMA/rxe: Remove pkey table
> > > > > > 
> > > > > > The RoCE spec require from RoCE devices to support only the defualt pkey, While the rxe driver maintain a 64 enties pkey table and use only the first entry. With that said remove the maintaing of the pkey table and used the default pkey when needed.
> > > > > > 
> > > > > Hi Kamal
> > > > > 
> > > > > After this patch is applied, do you make tests with SoftRoCE and mlx hardware?
> > > > > 
> > > > > The SoftRoCE should work well with the mlx hardware.
> > > > > 
> > > > > Zhu Yanjun
> > > > > 
> > > > Hi Zhu,
> > > > 
> > > > Yes, please see below:
> > > > 
> > > > $ ibv_rc_pingpong -d mlx5_0 -g 11
> > > >     local address:  LID 0x0000, QPN 0x0000e3, PSN 0x728a4f, GID ::ffff:172.31.40.121
> > > Can you make tests with GSI QP?
> > > 
> > > Zhu Yanjun
> > > 
> 
> Is this the GSI ?
> 
> Please check GSI in "InfiniBandTM Architecture Specification Volume 1
> Release 1.3"
> 
> Then make tests with GSI again.

rping uses RDMA CM which goes over the GSI

Jason
