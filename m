Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C472A49CC
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 16:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgKCPa5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 10:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgKCPa4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 10:30:56 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D46C0613D1
        for <linux-rdma@vger.kernel.org>; Tue,  3 Nov 2020 07:30:56 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 12so11082993qkl.8
        for <linux-rdma@vger.kernel.org>; Tue, 03 Nov 2020 07:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VxeSfICDXO/fijI3ChFyffAZJEiR1PbbXR5I/+DreEA=;
        b=K5BTk00RNEUCvNGSa1EgUo9SJXoHNHm1OxrbjRN3KZh4m7WtGki+tU42qOMd8lSlnI
         6vhmjUWYS0B0j0/yujChFmt8442sDOO8KZ2PiRYRJl/tj0xhHsEyUIXJS6SYGGfo7IYB
         8Of5C80LQ9Ijb23mXgQj/icgHLITgEBGwiDxBhT9hDmzHe6u9peWwOu9rQ0sZDbZQWPG
         NPJiD/+viaikn1grTsslM1tgKYYy2KBBMtVUUZLmBGaIGGnYiqfswqTnJKs0n/ngbsCO
         jh13Xn78PYcgnSk9XdGJx/ze5WdvGJIeRCRVoQrygBRBAao2U5KyxDMn/B6UUr/iZtyM
         6H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VxeSfICDXO/fijI3ChFyffAZJEiR1PbbXR5I/+DreEA=;
        b=mNCUS47VAhqLrkFs4mw212yd4NdqXR76EGJWU9p8tDHV7BCf4coVb/Qtjj0TOQx1AM
         RwwfijMtF0WTehYCdidpQpmem5ClpqAy0zu/VkmAAQDFPcgy7RX59qhvUZxUxfUSI30K
         CaV+FzdlslmaGrEntUoonCLJdRdzjeymfsYrsfKjrFLF+vQluiIpofUfd3nk7olsFJpL
         SMVnF8K6SHJF6wPyHxh/HNSLw4QyqD4Fe49N2x513jHj88B4ZfwhFuer8quMkVCLKucV
         GBFCKappE1fZoGxgJVfL3GkrDamMcaPt1uZk3JXv/m0WUzQPPX1sQToYItDcCPnaDY+X
         oqiw==
X-Gm-Message-State: AOAM531ieybKgLik4chw237j5nWq4ApwL0pU7CMEbj1kM5DHa0HadVqD
        N+3fkGu8Ms9YoGTWD/aduXbTn4GsiMMD7QIo
X-Google-Smtp-Source: ABdhPJx+kS6b6p5yeY98c8NmifWxxUHuAtbCrKaK46zf0YFRFuW2XVG13oaQH7AVcT2td0VbOh39qg==
X-Received: by 2002:a37:686:: with SMTP id 128mr19304114qkg.421.1604417455288;
        Tue, 03 Nov 2020 07:30:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g1sm10251437qtp.74.2020.11.03.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:30:54 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kZyGs-00Fw8U-5g; Tue, 03 Nov 2020 11:30:54 -0400
Date:   Tue, 3 Nov 2020 11:30:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     bugzilla-daemon@bugzilla.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [Bug 210021] New: IB/rxe: build error due to unmet dependency
 for CRYPTO_CRC32 by RDMA_RXE
Message-ID: <20201103153054.GN36674@ziepe.ca>
References: <bug-210021-11804@https.bugzilla.kernel.org/>
 <CAD=hENcffzhy5ACO2TqH0t57uJQ3fG7B5e2few++niB9Xd9M-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENcffzhy5ACO2TqH0t57uJQ3fG7B5e2few++niB9Xd9M-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 03, 2020 at 10:30:50PM +0800, Zhu Yanjun wrote:
> On Tue, Nov 3, 2020 at 7:33 PM <bugzilla-daemon@bugzilla.kernel.org> wrote:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=210021
> >
> >             Bug ID: 210021
> >            Summary: IB/rxe: build error due to unmet dependency for
> >                     CRYPTO_CRC32 by RDMA_RXE
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 5.4.4
> >           Hardware: All
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: normal
> >           Priority: P1
> >          Component: Infiniband/RDMA
> >           Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
> >           Reporter: fazilyildiran@gmail.com
> >                 CC: dledford@redhat.com, fazilyildiran@gmail.com,
> >                     leon@leon.nu, paul@pgazz.com
> >         Regression: No
> >
> > Created attachment 293417
> > reproduce.tar.gz
> >
> > Attachment (reproduce.tar.gz) content:
> >  - sample.config: Config file to reproduce the bug.
> >  - build_out.txt: Output of Kbuild including the error messages.
> >
> > When RDMA_RXE is enabled and CRYPTO is disabled, it results in the
> > following Kbuild warning:
> >
> > WARNING: unmet direct dependencies detected for CRYPTO_CRC32
> 
> https://lkml.org/lkml/2020/9/15/360
> 
> Please check this mail thread.
> 
> The discussion is in the above link.

I'd like crypto people to weight on what is proper here

Jason
