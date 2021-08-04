Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035CB3DF91B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 03:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhHDBCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 21:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhHDBCX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Aug 2021 21:02:23 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF1FC06175F
        for <linux-rdma@vger.kernel.org>; Tue,  3 Aug 2021 18:02:11 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id c137so1211192ybf.5
        for <linux-rdma@vger.kernel.org>; Tue, 03 Aug 2021 18:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Fl/rv1eEWPC0TT5A77tSsqTu0EvYSNBpT/xc7Uppws=;
        b=MgeuuisqVh2s5LStpXaR/gxt+Px76Px2pT9kTnAt+23IFOI8/KpRhkLflgdSvOUCpM
         n/PmEsgVdH+DU3LWDbRQR8x256iej0Eo0OGWq23UKhQ80OXoD/yvTCWKDQyJWbATQQtd
         UyQpg5pS6XUiRiSSeo4UbXiTXswMHEZXfZ/NVmdlcksdfdIfbKeg+lN+x3AT8T4PV8/+
         cXBSQ/YTgTODm9TkihJoXpSqrUsV27EIGus1Sq5Irb1lEq2MWGCxSMRIP585KoxmL3ay
         lsKKjCPi7VaPUGm5CciYLW3a72ioo131sPSUoqTBDP6aJSiz8kOeGV+3a+3Yl0ayQYO9
         rrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Fl/rv1eEWPC0TT5A77tSsqTu0EvYSNBpT/xc7Uppws=;
        b=ZDcXIDxurnHxyUOXFpiMpMHHgyu9kXpHYpvlXt99QDR1CmdrKaMGFA64MWhXR7ubAD
         ri5CrgOq41H5nMf41If44/tZGPXo2PCkPaBugNOyaQ3DqtGGwaT5aaa7ou5Yj2uMvHyS
         HmwteXYmUuYD23YV6J0K0Bq6V4cyKpIWM2q71ych1hzY7XhdF2FMYeKdYN9JvP3SxiSY
         VRmE+Kid7gBAvZS9LrkOgSv6GFgv04aIfuKMJIk51lxGojp8PJw2vyv/ahjxv6Euq2S9
         gTAaK/DFwlyXV6grWBfS3A5X14PiORZSdhtzuYuXR/YEOtxvZw/misVAMj6EaTzKcGz8
         lQ7w==
X-Gm-Message-State: AOAM533lsxjduWZzCEBd7ZfIckBO3b+OD9emRyQNK9vtDQgXLU6DvtIV
        tYIVm70QDlxBiUTpDM8SUPOhwCatfYoWifRzBuk=
X-Google-Smtp-Source: ABdhPJzX+JRgCv/TszV+N7N4OKgPtnzs7WjkYcqHMimfHvyY7u23tsA3Pha/KUHX2zVB2YvZdALJZ2OH91Zx1g97W9o=
X-Received: by 2002:a25:a286:: with SMTP id c6mr30638087ybi.349.1628038930914;
 Tue, 03 Aug 2021 18:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <YQmF9506lsmeaOBZ@unreal>
In-Reply-To: <YQmF9506lsmeaOBZ@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 4 Aug 2021 09:01:59 +0800
Message-ID: <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
Subject: Re: RXE status in the upstream rping using rxe
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 4, 2021 at 2:07 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> Hi,
>
> Can you please help me to understand the RXE status in the upstream?
>
> Does we still have crashes/interop issues/e.t.c?

I made some developments with the RXE in the upstream, from my usage
with latest RXE,
I found the following:

1. rdma-core can not work well with latest RDMA git;
2. There are some problems with rxe in different kernel version;

To 2, the commit
https://patchwork.kernel.org/project/linux-rdma/patch/20210729220039.18549-3-rpearsonhpe@gmail.com/
can relieve this problem,
not sure if some bugs still exist in RXE.

To 1, I will continue to make further investigations.
So we should have time to make tests, fix bugs and make rxe stable.

Zhu Yanjun
>
> Latest commit is:
> 20da44dfe8ef ("RDMA/mlx5: Drop in-driver verbs object creations")
>
> Thanks
