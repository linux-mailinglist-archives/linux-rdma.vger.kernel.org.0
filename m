Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D0024ED6F
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Aug 2020 16:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgHWOGM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Aug 2020 10:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgHWOGM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Aug 2020 10:06:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A8C061573
        for <linux-rdma@vger.kernel.org>; Sun, 23 Aug 2020 07:06:11 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so8643705ejc.2
        for <linux-rdma@vger.kernel.org>; Sun, 23 Aug 2020 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=P7vPD/SPjuzE440DhcGuyDLwkPlC16FbuZmWW9kpVbI=;
        b=gPTj7c2KhwlyU5mro6Qt48M/jXJXwdK5jwfKZT+hDiQbmVxHp8zxEqpftBnA+k1YbZ
         xhOqXsjOT0JGwwjVEdDUvVWvERk4BFhiWjPj+hihzVDuYtfn13OuR8wXBhSxJO++CYlu
         L+QWMCwT7DdwPan6uO5X+elw6S9Weal4EjdUVM6Xjx9eUXwPV5yBpc4W9ufc6TbRzFjn
         aWKliQf9BpK5fz3yYv0qtM2ihqSr8bDg90YfNP0u7boRU0NfccmficXP+/ZkrrLWnv9F
         2ZE3qJk7GAJeR1SaQVgFPaYrAfQoyinKep+IChYZM290xiH5h7taoxz5OhfRTaFNQQ1z
         nELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=P7vPD/SPjuzE440DhcGuyDLwkPlC16FbuZmWW9kpVbI=;
        b=lwh7UFhRLxyK8HbCCr48MJdIPWghxqcHQ7X6IzBOzLIoItHb6g2xx/Fc8Ankr2jsVd
         8V82X46zHzua5DOCKt1ye4XzUjLB375QoepjPTZ60f5Vmp9pchXLqf0IE5l44rfXw8af
         UQqG/IOmgbLzqrgiK+O5d6dCMeY5SZ9cU6JwqZagWxkZtn3962PF86TxSQhSgaHDouF0
         ZChM1G/7YhM7/gAWVXnio23CFFw7cKO4w1CNWF0121KCKM0XNaHcwLM4BPs/oxEjsdX3
         oYNWD2RgFGx4X+AHMVzofmHGfBL+dCZtSIYc27z6Adj8vgNKpehVR7hYqVF4/sssYRHB
         xYHA==
X-Gm-Message-State: AOAM533APE9XZl3aqmla1pJzACkGvBgbFH81Gjqd+m7AZ7QRajeUmomy
        LET/v+YvF/0lUxfWb7lEE1wlzw==
X-Google-Smtp-Source: ABdhPJzR26bXH44veq9a9IH+5/4gmB2Om/IRi82BqqCR2nawtFXmj66EVLm4h7B5qvbnaaKsgjUaCg==
X-Received: by 2002:a17:906:1106:: with SMTP id h6mr1608654eja.200.1598191570320;
        Sun, 23 Aug 2020 07:06:10 -0700 (PDT)
Received: from localhost ([5.102.238.126])
        by smtp.gmail.com with ESMTPSA id m12sm5989464edv.94.2020.08.23.07.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 07:06:09 -0700 (PDT)
Date:   Sun, 23 Aug 2020 17:06:06 +0300
From:   jackm <jackm@dev.mellanox.co.il>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mark Bloch <markb@mellanox.com>,
        Eli Cohen <eli@mellanox.co.il>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Roland Dreier <rolandd@cisco.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx4: Read pkey table length instead of
 hardcoded value
Message-ID: <20200823170606.00004757@dev.mellanox.co.il>
In-Reply-To: <20200823123342.GC571722@unreal>
References: <20200823061754.573919-1-leon@kernel.org>
        <20200823142739.0000447e@dev.mellanox.co.il>
        <20200823123342.GC571722@unreal>
Organization: Mellanox
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, 23 Aug 2020 15:33:42 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> "props" are cleared by definition of IB/core to make sure that drivers
> doesn't return junk in ->query_port() for the fields that are not
> assigned. This is why I removed redundant assignment to 0.
> 
> Thanks

OK, got it. I remove my objection. No RoCE support basically means that
the pkey_tbl_len field should be treated as an unassigned field (which
will remain zero, like all the other unassigned fields).

-Jack
