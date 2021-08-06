Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6703E215B
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 04:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhHFCFk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 22:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhHFCFk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 22:05:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64396C061798
        for <linux-rdma@vger.kernel.org>; Thu,  5 Aug 2021 19:05:25 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x14so11012264edr.12
        for <linux-rdma@vger.kernel.org>; Thu, 05 Aug 2021 19:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVD3Eum3gpCVQ7RzIcc3zCwRpmo1O+eJklE+w9ViAdw=;
        b=Z1RORBUhuL+2ZU3ssQasEeqTo8CZb0tV1zZRuD92E1ch0VrE05rP89qjOkfEx+sLFI
         XnMle4QEEPiPanzEoCW2551tcYBKdjZePCunnl+02x+O3WyowHueoMBqTgJ8KIIi0I8N
         kHEGmzi2nAKhhwpsv8lB4M+bUez8VbrNWEE/RMPEaUI5pnKl66qcmi/2gHnMYwRI9bzE
         rOgFIQzFOJPg5U8t082AprWZV3dXJYFlKgEX8cNcxCpYr7LyhXvkTmNyNGahjAvyWTGO
         eYjjj1D+0tbBet9DlLQdWFyt+K5+2b0s33nEnOlPqtoaY2fSqV4AiZ+sTQRdx51gqFWH
         OWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVD3Eum3gpCVQ7RzIcc3zCwRpmo1O+eJklE+w9ViAdw=;
        b=nMCN9y+JVvtQOtvSse1j44DndgD7hX8cKGdY5Jftn390IeqAWlNod29x0YjnKG0m6p
         1k3CNVTiTGp1T0iAgy7ASrMDs2eadHB8DDAU04iBZlhRQuBzJQOs/J+LZwOVeb3KZz6M
         eY71JikqgeuIEAx4D4qpd3Y2D2ifzrijP8qpXWD5n90L7GkcwP+myM1Ttt0L0MGFgknl
         Ot/chhpP5M42fyfJFp1HQQs7JOoFK9AGXO53f3N7ddwwRkNcuoZiltCu4Og6X4yhDxu/
         NmK2ot4lhlsmTTuNnpkHPZTS/SEGkah+8agB3AkBw0gDGwfvq2W/rMCE0dHazJDMxnfW
         qYjQ==
X-Gm-Message-State: AOAM5309/IgGYhwmJkDorb0uySv5PDjHvMBn7k66JDK2qISMRIXyN5La
        H/D08k+StXLluw7KRXEnyGheAoa/lCPN+r49wl0=
X-Google-Smtp-Source: ABdhPJz7+p8U8YQBm0mIx5gX3hVg9uyT60udCr3uzPxQSsjNtmk7Gr4Cd8I1iezHMt1UJRIJetOwO8W5SPc4AW2DLYA=
X-Received: by 2002:a05:6402:3128:: with SMTP id dd8mr10509611edb.367.1628215523939;
 Thu, 05 Aug 2021 19:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGiuTXBy2pcSd6PT3_Bdxx6H8QWzXaurSooMz7uhU2rrw@mail.gmail.com>
 <20210806014436.GL543798@ziepe.ca>
In-Reply-To: <20210806014436.GL543798@ziepe.ca>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 5 Aug 2021 22:05:12 -0400
Message-ID: <CAN-5tyEsDnH_3e2qxOpCK1LDhhk=H3WKuYK-KVYLMOCuNz781A@mail.gmail.com>
Subject: Re: Help understand use of MAC address resolution in RDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 5, 2021 at 9:44 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Aug 05, 2021 at 10:38:42AM -0400, Olga Kornievskaia wrote:
> > Hi folks,
> >
> > Can somebody help me understand how RoCE (this is probably RDMA core
> > and not specific to RoCE but I'm not sure) manages destination MAC
> > addresses for its connection?
> >
> > Specifically the problem being observed is a server initiates an RDMA
> > CM disconnect (client replies), client tries to reconnect. Server
> > sends an ARP advertising a different MAC for the IP that the RDMA
> > connection was using. RDMA code keeps sending the RDMA CM connect
> > message to the old MAC for a certains period of time (90-100sec) then
> > it finally sends it to the new MAC address.
> >
> > Question: how does the core RDMA layer manage the MAC address for the
> > connection. Why does it seem like it ignores the ARP updates?
>
> RDMA objects acquire a MAC adress when they are created and do not
> synchronize with the neighbor cache after.
>
> What you are seeing is that the CM_ID object holds the bad mac until
> it is destoroyed and likely a new CM_ID object gets created that holds
> the updated MAC

First of all, thank you for the feedback. A few more questions on
that. It sounds like you are agreeing with me that the ARP update is
ignored. Question: do you think that's an acceptable/expected
behaviour or it's a bug that needs to be fixed? Indeed the successful
CM connect request has a different communication ID on the network
trace. Question: is the period that the CMA would keep retrying before
giving up a configuration option (by the caller of the connection or
system in general)? Would tuning that value to be smaller so that it
is more sensitive to ARP updates be the path forward?

Thank you.

>
> Jason
