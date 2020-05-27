Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC91E384B
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 07:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725267AbgE0Fgt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 01:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgE0Fgt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 01:36:49 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBF5C061A0F
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2020 22:36:49 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c8so4254752iob.6
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2020 22:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+33IHvHg9l9gswl7fI7C4X9FRLy830LMkChW6WC/cUA=;
        b=BlD5XN1AAhRm9KFXZllVNUp5NRjWd856tepnKGFe93hHXC0ZnbgQg/ExbE8pVmi08U
         Zzh4GxHsmcaDU5ZcIll8xc2pk3pt5SiF9reQGXArOJJF1i8QMQMKDRmj8L/xdkBeZMiX
         s8g/lKfQlTBDfPEw4PKLAv93WN0YBk8Kd9KS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+33IHvHg9l9gswl7fI7C4X9FRLy830LMkChW6WC/cUA=;
        b=ASBg9hgmPZy6Z9SF9Nkl8LGqfcAtvjHgkGSelWnOZVfMz4QS7vY1E6MuAPD2/vI0kG
         TpO0QkCn4e3Ef8P30+ymggevQNRCutlVmswfv4CDiG13RTPK1iDI1d7ZOLsSKdRyAFY3
         srDsdG47KPMNlPC54ZXermvwRYzHv71YNDNso3fVxZZ6Rpfd5w4W0CitI1RLsY4sh3x4
         OlQcoa9LyL0PZjAGBzCbwrsbh+4kkck0KxRjPxafA1A3PYrq0DT4tlXCBlZzY5hEhx9O
         lUU4Vaqcv4VJl3u8DVNFgMcP2Psvdxu/zqa4dQut2MafgsYB/i5I2qZ0UhPOAgiwvXET
         LJXA==
X-Gm-Message-State: AOAM531tX2BJEyX62hhWarlI2swdTU9Kv32Iifgs/trqdV4HAbOln1xp
        70FF8z9LngaLdfM78CNBJlt2EJKf+3C71HUn2b8S3f+u7cM=
X-Google-Smtp-Source: ABdhPJyeOWxouJKZtHyIhmfw9QLGcnQzy1s9KW1gpD//pKWXJGjAzZk28VAJnqybup+WQdT9ko0RRtqZYexXfjgIeYY=
X-Received: by 2002:a02:3b4b:: with SMTP id i11mr4269773jaf.16.1590557808236;
 Tue, 26 May 2020 22:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <1590470402-32590-1-git-send-email-devesh.sharma@broadcom.com> <20200526193141.GT24561@mellanox.com>
In-Reply-To: <20200526193141.GT24561@mellanox.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Wed, 27 May 2020 11:06:11 +0530
Message-ID: <CANjDDBh9o1VM9-4tS1tpXj23Euyhu-JWsB76p94q4aNs79R5uA@mail.gmail.com>
Subject: Re: [PATCH for-next 0/2]: Broadcom's driver update
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 1:01 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Tue, May 26, 2020 at 01:20:00AM -0400, Devesh Sharma wrote:
> > This series is mainly focused on adding driver fast path
> > changes to support variable sized wqe support. There are
> > two patches.
> >
> > The first patch is a big patch and contain core changes to
> > support the feature. Since the change is related to fast
> > path, the patch is not splitted into multiple patches.
> > We want to push all related changes in one go.
>
> That makes no sense, everyone else splits their patches.
I agree with both you and Leon about the size of the patch and there
is a guideline of sending smaller patches. I will have to see which
all parts I can split and re-send. I was not sure about the
functionality of the driver wrt each patch which comes out as a result
of split. These changes are quite closely woven. I will try though and
send a V2. Thanks
>
> > The second patch is relatively few lines and changes the
> > ABI.
> >
> > The corresponding library changes will follow short after
> > this patch series.
>
> You have to open a PR on rdma-core before any uapi changes should be
> merged.
Yeah sure, I will open that.
>
> Jason
