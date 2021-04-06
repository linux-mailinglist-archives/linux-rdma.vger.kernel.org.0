Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE8E35544A
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhDFMyn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhDFMym (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 08:54:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8526C06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 05:54:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w23so5182110edx.7
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pmAPKrwoCSCodte82+9yPUF7rM6NrUmWRa5KeSz5CGQ=;
        b=cC0u27+dfPQYMfHkqqWBtYnlp4E40CCn5R/NejmrtfUAO2uGWYxmw8MdxMLxWy84p+
         vCS3gsivDEaObL+2JTCl+J+Zk+0+vFCHM2E2tIKfdct1qORXdHGac+WdFZRUyeDX4aNq
         NKPDMwTiNAa3BZI8s3HdwAxqdGywknb6ynVcw22iNNUdHb58R/S2GvzV9nu0sYaeYeHe
         WCIASKsE1CGltV+nHO2tHIgQdBiHxldo4zpq9iUU1gQyLE/UHoOIRBy5+kI/9ENyjN0h
         NcSPG7el+A2HLvOuVHXwfI9GO+KcRIRPMuH34wCrPh4OD1YRD5EkVdxkezTP445mOKK9
         WiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmAPKrwoCSCodte82+9yPUF7rM6NrUmWRa5KeSz5CGQ=;
        b=cqbw1dLfmqwgbXxisr1XV4fG+2C5Xii326zTCrVCyXq7zgmzmwaUO7WjDpMihEqlvz
         KKL+gf46DUfCgokgQSK1LwLip4RgiN6niXso5kg4lsV+EIpi63zjTgCGCppHRvtknnQZ
         NOb37bfldPfweDzTO+0v2IVGqRhwYs38+XBF3qnh0yLKCuztKa5Y9qati579If71fWjw
         sKFYc427x+J8RP+mX2a7u9ip0o63tU+uODyVpsKjyLNZyS/MA7SILQlQ1Wschq2Juxtn
         uJXijBv4pwMIZKDdzjjFgE0XWUONk2BNFdGBRdLMU4LRili4L8l2KND0GERtM/NWbIpl
         VPJg==
X-Gm-Message-State: AOAM531jNYTfB7dxMUSFUDqXgOSTilPqptQhCYSTQXxoB+hiUmnBpL9n
        aLv9c7ikL2lk1GR3reR3o3CXeaTfS9Kj4cda3xxTYA==
X-Google-Smtp-Source: ABdhPJziohFjVx1kZHY83u4EQhXg2YBQYcPlmuYinKkc3rsNDW6GfnqT3HcAr65MXsald/lkjWEcYVSPrq836/6/QxI=
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr38017483edu.268.1617713673370;
 Tue, 06 Apr 2021 05:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com> <20210325153308.1214057-7-gi-oh.kim@ionos.com>
 <20210401183825.GB1645857@nvidia.com> <CAJX1YtZTDboK9pP5KzFB0ZEwXMmOYXANhdyhnuBsqAErvaoUag@mail.gmail.com>
 <20210406125106.GP7405@nvidia.com>
In-Reply-To: <20210406125106.GP7405@nvidia.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 6 Apr 2021 14:53:57 +0200
Message-ID: <CAJX1Ytadgxm9YsbH+vTPN7pGUzFbn2uchhU2hU=p32Hm_=A+cA@mail.gmail.com>
Subject: Re: [PATCH for-next 06/22] RDMA/rtrs-clt: Break if one sess is
 connected in rtrs_clt_is_connected
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 6, 2021 at 2:51 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Apr 06, 2021 at 12:23:49PM +0200, Gioh Kim wrote:
>
> > It is a rebase error.
> > Just in case, I copied the corrected patch below and also attached it.
> > If you want me to send the patch again, please inform me.
>
> Follow along on https://patchwork.kernel.org/project/linux-rdma/list/
>
> If your patch isn't there you need to fix something and resend it
>
> Jason

Ok, I will resend that patch.
