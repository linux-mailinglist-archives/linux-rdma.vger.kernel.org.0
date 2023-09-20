Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF57A82F3
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 15:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjITNJZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 09:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbjITNJW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 09:09:22 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF74E5F
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 06:07:56 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1c4cf775a14so3999008fac.3
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 06:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1695215275; x=1695820075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFRz6Zqj+DjTdiABwAtsKDAebeoDOSPfTRgX/zFgA+8=;
        b=N1uKL1s4CTmfDAPFsH6aNJF+mkdxBUjJNlZU1kfQFP+Y75X6s3aLfoRByHwxdNtFRY
         WtoxKMoPar3kIn/ItW12CPxwYG6kQSb5YojRhSKwpwLhs7v9IxEMnuEE5+CWV4hKTwRy
         XWk41l+pYvqqs63S1bXCe/N0WMUemQYT1b5K7VxmJ34k5wQ7tsX33fzh67PKsbO8r/fx
         5KX1OAVB+M6v3y3sQAkDiXDtul+ynuvjUHb0sZGcbgcvb4zrDqfYI6ClKq1AB2PQ+Y9C
         GCO81tXwfrvH5FG3YSLXX8WXFY0OMFVTnRLZDVsEoOETl2JI9znYrK2vtjE0UATpEr8F
         eIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695215275; x=1695820075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFRz6Zqj+DjTdiABwAtsKDAebeoDOSPfTRgX/zFgA+8=;
        b=T+BpfBfrTOFdTCI7YscvpmxWbXpIaARNbshShVTJSPJUXxgxs38ywPJQPHxnGcgohh
         Id17qhVfmhMEqfjHd0m0FfFKwLNa0iT792M2rEkDuioeR0s6UdFVkqDJpJH2lMafgMj/
         T2PuPyxyj5ZVIJkfYYqFuy+lnW0RCDrxNGi09cfk6UVFKCsQIeZq4y9zH9NAyiHf1SQb
         aNHco69uQQdfoa5x/44JBruVg/rDZQnbYh8/0R/l5uLlRl0eZHnLs75S34I9keBcvpr3
         NvGMkYWAvifpoYF+ekLrxyLbXS4zbh3v7WwZ/nW3UW/73JnH3T/Bwi0Qvh+UBY6z+sK0
         DJFA==
X-Gm-Message-State: AOJu0YwUNojx131trtwkjhZmap/Sh5H1MBuAgm4znJTfY0w4LT/M1thA
        Q3nAcSeortnHXzvfoMR/wLUKITz+YCxXuOLyRP1qkg==
X-Google-Smtp-Source: AGHT+IHpSxK5BP5dhOj4rfHK/rocSUG0aW8vpYE7sD8Pag4INHPVDz1IDYA4UFNOyf9MANakf/7zxqR5d9/E0e6RVHg=
X-Received: by 2002:a05:6870:51c6:b0:1d6:3b76:aae1 with SMTP id
 b6-20020a05687051c600b001d63b76aae1mr2546575oaj.39.1695215275260; Wed, 20 Sep
 2023 06:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230918142700.12745-1-vitaly@enfabrica.net> <20230919072136.GB4494@unreal>
 <CAF0Wxh=YhKCLbOLZ+-b+_rmzRoWQtqoBGn6Bo9X3zR308Vm1zA@mail.gmail.com>
 <CAF0Wxhkxa1Lk76nnkTQbNL6_v_4amczVd=wodPt00iOU2WB6+w@mail.gmail.com>
 <20230920054452.GH4494@unreal> <20230920125507.GU13733@nvidia.com>
In-Reply-To: <20230920125507.GU13733@nvidia.com>
From:   Vitaly Mayatskikh <vitaly@enfabrica.net>
Date:   Wed, 20 Sep 2023 09:07:44 -0400
Message-ID: <CAF0WxhkuN0J3K5tUw0rb3-v=zKPKTh5YcCGSciaBXx9yfN-GEw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/core: use rdma_cap_iw_cm() in rdma_resolve_route()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Roland Dreier <roland@enfabrica.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 20, 2023 at 8:55=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:

> > > > Our driver does not support iWarp, but implements IW_CM callbacks. =
The patch has
> > > > the only fix that was needed to make it work w/o a full blown iWarp=
.
> >
> > It is hard to say without having driver in-tree and seeing the result o=
f
> > ib_device_check_mandatory() in regards of kverbs_provider variable.
> >
> > Does any existing in-tree driver require the proposed change in
> > rdma-cm?
>
> Yes, lets see a driver first please.
>
> iWarp CM is tightly tied to iWarp, I have a hard time understanding
> how you could have the CM without supporting iWarp too.

Yes, it is coming. Not sure about the timeline, but the intent is to
opensource the drivers. I'll defer the patch till then.

The IB driver implements ib_device_ops->iw_* ops and cq/qp/mr-related
kverbs. This is sufficient for CM to work with the device in
principle.

Thanks.
