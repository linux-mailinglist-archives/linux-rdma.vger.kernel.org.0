Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E173DAC13
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhG2Tul (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 15:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhG2Tul (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 15:50:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE3EC061765
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 12:50:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso17361551pjb.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VxHmkSO6lMxWOzTGY8T2XcFTKLQPNuEd4HaX9SqihB0=;
        b=Ip999ll8j/KFZNQwLeRDBF337rxYHBkPYymOtG+wZDjIVOmRVTNHmLt+Qy+0TmM4qW
         faZzLO2u+JE3TvWdx5bvqlLvkHkqsPLXuoU5OAwMM5/ed/ERjJG/3vr7+eP/zqK7V5Lp
         +nqons7uzFe7QSn5vAmA87xj7x80MR0K/DrATANmLFQa7PRO9z/Gbx9CZe0sfuOIP2Al
         eXpW2t2nfvil3JYtyqyFyaCW9bF4zz+ck3TmeiXbR3LxKXCZHg53EyZT8qj6xgvWKdRF
         f4g8kv88+6t9HetgBJo5xTAJkpQdBVVgHici+WkPvJXlo8y1Kt6Ol7ptNaw0ce0bK6JD
         cajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VxHmkSO6lMxWOzTGY8T2XcFTKLQPNuEd4HaX9SqihB0=;
        b=MfBKlBcki4wm9r9aoqGApg1UkXctapjRHh0VbdBVBEgDxh/pYaDO4fuNMogP7qQLzI
         lyQ/z44OKcuLmhyJJJX0mz+lkNHHTKlpdHGzj8dbuq8bSVhj1GCWewR0k33/zvZiHIaI
         gysf0VpGrMV3KiXrq6PMgj/qUYNNA5nWtz4C4mxiPY2n1vq2WvuiHt73cFfsfgxEINqL
         3nGWjM885J4dxcoaLd3vKwt9wA+BpIZQQDImO9xdxiuvoFwMgUeoUolHPJsUAZ/vSX87
         fGM5mC5k+O/FaosDVttwDyphLuXPfzDsrr+OHVHYceQ4WcYmSqRTqpiVQZd+CP28eElO
         dEfw==
X-Gm-Message-State: AOAM531AsACthAt43kTqzlYcFO+d48s3KX4ILY7GqCxj2JeIGlS4WIWu
        D4260hOrSkZUN2C8iI2dDyQUNmhUFUAZcA==
X-Google-Smtp-Source: ABdhPJzxK0XxnKtjw677GaCbuCERlV+XX7swNCyooaElQASfO83stGGPm/74BLZb0nQLrSKrQCA3yA==
X-Received: by 2002:a63:1d21:: with SMTP id d33mr5208363pgd.340.1627588236766;
        Thu, 29 Jul 2021 12:50:36 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id k3sm826880pfc.16.2021.07.29.12.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:50:36 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1m9C38-00AQpA-6p; Thu, 29 Jul 2021 16:50:34 -0300
Date:   Thu, 29 Jul 2021 16:50:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
Message-ID: <20210729195034.GF543798@ziepe.ca>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 12:33:14PM -0700, Shoaib Rao wrote:

> Can we please accept my initial patch where I bumped up the values of a few
> parameters. We have extensively tested with those values. I will try to
> resolve CRC errors and panic and make changes to other tuneables later?

I think Bob posted something for the icrc issues already

Please try to work in a sane fashion, rxe shouldn't be left broken
with so many people apparently interested in it??

Jason
