Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F5D678F12
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jan 2023 04:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjAXDn1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Jan 2023 22:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjAXDn0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Jan 2023 22:43:26 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF4827986
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jan 2023 19:43:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y19so16925669edc.2
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jan 2023 19:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PtD7UJ/zWeFZbRIwZ4qVyLcByuOH0Z7mqR7SJRgIGPY=;
        b=QKPzACtVYkndFA3xw+Dsw0gB+FydTwYJyLhzHEF/upuh3SNVYHhWNAzGjpK6/U+Bxp
         CF2l8C7rZmC3L3Hj/hQX9+YMe6tNXOy3SpB3XVT07Iobvgs0d+HNNHeaT1qhBTV8LRZI
         OJLDXW2Q9k+NkbeWCZKnh+OgDP1UDyUktOqKZQoMU4U6eYZpcdEe0IZhIgBVSti4Euj3
         szI7f7RDWKTsVtDxZx0pMSlv9/mU+2M2xDIwK1LrBgJGa2jfyUM8hZpZLm93s12C7hOq
         ZPCDSC8H8xJ3G0XgeHYlqzvqf032gCQ6Ui2FBi46C1IbzcuJ5muXGZ+YNKy+xtK1EDFl
         +qNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtD7UJ/zWeFZbRIwZ4qVyLcByuOH0Z7mqR7SJRgIGPY=;
        b=x8lFEPGDnUexv2Q9Kmg5iK91nKV/OVCxrYT1C8PQNwSMCJ9JT/3Yctom+huRSDtBSt
         3OXXSzrCQW/wCHFvNibFPtxIYmKqiLnHgkOms69A0bFIt4flEnIjfHqk4JK2Zlk7G/jM
         zHK4KCk5lf61j/4WTNrltnbGGSuKalmytKHiPaMzhIZU1wt4e4U71OFBnsSeuEr8iFUJ
         KF1CeOWe52LL8+Q5m2qAIOORrG5d60QdzNLSblWk29/3bmLdH+hf3ESEZ3+cuOEziyxZ
         CYQ/QCJhB4DRoxvTblh/X1N9pCQAvjLY0UuZ/fvGqxGNKxy72/AyQGiAyDs768KGI0sy
         xZFg==
X-Gm-Message-State: AFqh2krip05X1SO52zAptv1ngHFfJGMjqccQXPsFk+GqpX3jlXc/l+kS
        Ew8M2AEAkOnzNjIWDdMIhSLw+4asUSgTAVOeLJZxVy9BJHI=
X-Google-Smtp-Source: AMrXdXvo1JajJZ2YMo+b/NsE48DxLm8CxquhfsafwfdJeehdBM88kBem/oVN5L8kxKb7zKqZKnvm9p4JEnM2zCCxQ5k=
X-Received: by 2002:aa7:c488:0:b0:48e:82fa:47ca with SMTP id
 m8-20020aa7c488000000b0048e82fa47camr3379128edq.72.1674531804025; Mon, 23 Jan
 2023 19:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20230117172540.33205-1-rpearsonhpe@gmail.com> <Y87h1Cl7aYXDD49M@nvidia.com>
In-Reply-To: <Y87h1Cl7aYXDD49M@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 24 Jan 2023 11:43:11 +0800
Message-ID: <CAD=hENfvup4mwZz9rCjpc5-Oar3mzFDdnvTHoT9FbRVFu28O9g@mail.gmail.com>
Subject: Re: [PATCH for-next v6 0/6] RDMA/rxe: Replace mr page map with an xarray
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 24, 2023 at 3:36 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Jan 17, 2023 at 11:25:35AM -0600, Bob Pearson wrote:
> > This patch series replaces the page map carried in each memory region
> > with a struct xarray. It is based on a sketch developed by Jason
> > Gunthorpe. The first five patches are preparation that tries to
> > cleanly isolate all the mr specific code into rxe_mr.c. The sixth
> > patch is the actual change.
>
> I think this is fine, are all the other people satisfied?

I noticed that RXE is disabled in RHEL9.x. And in RHEL 8.x, RXE still
is enabled.
It seems that RXE is disabled in RHEL 9.x because of instability.
And recently RXE accepted several patch series.
IMO, we should have more time to make tests and fix bugs before the
new patch series are accepted.

This can make RXE more stable. And more linux distributions will enable it.
Or else, more and more linux distributions will disable RXE. Less and
less users will use RXE.
Finally RXE will never be used in the future.

I think, this is not what the RXE guys expect.

As such, it had better have more time to make tests and let RXE more stable.
We should not accept too many patch series in short time. Too many
patch series will bring risks.

Zhu Yanjun


>
> Thanks,
> Jason
