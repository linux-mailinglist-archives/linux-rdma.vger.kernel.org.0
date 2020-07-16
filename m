Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD8E2221A2
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 13:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgGPLlS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 07:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgGPLlS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jul 2020 07:41:18 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1100C061755
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jul 2020 04:41:17 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 80so5145130qko.7
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jul 2020 04:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7z07yaF5tVOtRN5BzxzuEbkDvPPTHik1E7Q8FSZDafQ=;
        b=A3gWZCDnd/DTGFO6B4D0Av5VHiGMw413nE1oMj+9b157kKyMmyeXgeI8vAipS5zvs3
         79yQpO8IpmWejPdEMuw1Et10mJO5KcuivxKr7Dqk0oYu73gc1pblBBT1B0xDf5UxsFgR
         r/zSTtcRV2+D9qFjIt55xfr0agZ+ojcnKhwFCTyLCqdXEvXv29TYd7C+lZIhDnyXSa4b
         KCcqSllzAiE1pntUXpmnU5sKJZVmXSzFasR1EBI/wYqhIBuBnPdv2UIICpiJCsUZylA6
         A8kj8pfyGGwuei9l4i9Z3l3iRFBQ04nD9Ux12QzmaBFWaMno4kIKi/omoKiOLFRqdhpo
         Ptkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7z07yaF5tVOtRN5BzxzuEbkDvPPTHik1E7Q8FSZDafQ=;
        b=fcTaTWSNfOXb4q6/6t+RIAE5jcc9Wq8dCRaA8ucTU5XlliZsG3tnL+MkivJg4x9jD9
         HBPn4qOWWHGRK9T8a4QyDE7hLho2NzhJ04X7F+D6Odd+B9IvSvkEp8/DZm+PbDfmcIFq
         2CJDhO6cmj1XvwUGJ6O9jyyjWbo8QWjTTfTaoo1iO01NO7VVeZEJ1fuHrQIumInrU+6o
         uzKyV73emEf4vunZ6PQzWlROqefmnkNVBY+Xa8XseHjSoD93c7LXYl1oVGH7XDybBs1l
         LeZhFmb+AqywpCC1oSo/19oOShij6Rj7GbnU8OwJYaTEVKL8XkWKcylmqS+iauPRdLFV
         R7Cw==
X-Gm-Message-State: AOAM530Bqp9BJ4ssMSkLbtqUMUoEIPy3XfbuImDx9Gg6sPhdrNlGCMTa
        8lSDpxsshexvPxzwg31BJ8qyg8suxec=
X-Google-Smtp-Source: ABdhPJwxbsomUMjj5IVbv36leKjOiRWmuZ3xBnM71VZIk2cGmmAo/FokSX/NR60eWO4QlJqy5qasow==
X-Received: by 2002:a37:954:: with SMTP id 81mr3420229qkj.336.1594899677092;
        Thu, 16 Jul 2020 04:41:17 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 188sm6560780qkf.50.2020.07.16.04.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 04:41:16 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jw2GJ-00Aveg-32; Thu, 16 Jul 2020 08:41:15 -0300
Date:   Thu, 16 Jul 2020 08:41:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Mikhail Malygin <m.malygin@yadro.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sergey Kojushev <S.Kojushev@yadro.com>,
        "linux@yadro.com" <linux@yadro.com>
Subject: Re: [PATCH] rdma_rxe: Prevent access to wr->next ptr afrer wr is
 posted to send queue
Message-ID: <20200716114115.GF25301@ziepe.ca>
References: <A9F28BA8-EAB3-48AC-99C0-09E93D7B9DE0@yadro.com>
 <20200715113743.GC2021234@nvidia.com>
 <6370C3FE-966D-4C6E-AAA1-179F39D382BB@yadro.com>
 <CAD=hENdB-hVZr-ivU9FhVqEiF4WJZmjuY3iFBpuEJqRD548zkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=hENdB-hVZr-ivU9FhVqEiF4WJZmjuY3iFBpuEJqRD548zkQ@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 16, 2020 at 11:17:09AM +0800, Zhu Yanjun wrote:
> On Wed, Jul 15, 2020 at 8:39 PM Mikhail Malygin <m.malygin@yadro.com> wrote:
> >
> > Thanks, I’ll post an updated version.
> >
> > Mikhail
> >
> > > On 15 Jul 2020, at 14:37, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > The spinock in post_one_send() guarantees no reordering across
> 
> How about spin_lock_irqsave?

The unlock of any lock prevents store reordering by definition

Jason
