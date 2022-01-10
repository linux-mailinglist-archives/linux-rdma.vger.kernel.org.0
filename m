Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F615489333
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 09:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiAJIXx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 03:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiAJIXo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jan 2022 03:23:44 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7546AC061751;
        Mon, 10 Jan 2022 00:23:44 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id p37so10004629pfh.4;
        Mon, 10 Jan 2022 00:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+xYnlJoABI9fksQnY6K4TiplumFCQcY2lPH0p4BZgh8=;
        b=W2FhQpHeRx4NUn68nWipL7cP6OZLEUYfZUyz1kXy2ih5gg3PqTpQT/jD5RWisbypzY
         3y48p8S35uixWNVSBsbGZhmPcEa0PII6Bo2rvXSrQhqjzpN2J0PWfv93Yaoi21MIuZKg
         nW+bc6/YkOswThogC9lgCeps0NBBCDW6Bg7MthCRX7vP/JYq4rWtqAS6LwNr3IE4mo2D
         TJN4QnWS3II/jC345mkFQls2bfvKX/OmlGp4QR3pyNyQTjOowq9HCE0094amHYK54Qdk
         E9mzmagDexaKgOB6KmZS3ylXzJOltDB0GvkvXBpCntRlkrwg1fe8pTGS7QC2tiXiUeqX
         wDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+xYnlJoABI9fksQnY6K4TiplumFCQcY2lPH0p4BZgh8=;
        b=MJLB6Je+fyZb2X9EFZ7g+R7DPwIobODaZxi8DZKyUvDSz40VgMfJghoFtMeItLLkoY
         /K1wms9JKxnhwtHPc/Ca/ogcNoK3vug0u9n4OG//nyGrE+K7kEJqq23oq6L+nK3NiVlB
         1kOlyFsvQCpFw2iiImx5JkkALr8l5oPYnb+CnrRylSGLNOiPDh6b4uhYliOiblmBgTSG
         ADAGZsmmPeE+eV8g70GKuBmfr3pN18Hc9MgitIgU+1bw2yf5X9pgUQo9ybeYqma2D7rv
         CUtVsBFEcaQXaBsR6sxBEjXeq3aqy6NtyBg9U02SKHHpR63xWoPAa9nz99YI+wHKOboK
         1x1g==
X-Gm-Message-State: AOAM532yg4tAw46iUAKzAzE02FP3YUVTHYh7iFzbDgU7UdJ8cpbsOd7h
        3f6bfRnhCz90bbA0HZIBFnLwLsuQdWVCu7AKqcI=
X-Google-Smtp-Source: ABdhPJws9mHClVZiAlBdFGwfBQQk0blBhykzVyy9yStxYffcoz3ABoL2/tG4qseqSJzav9nlVRdCrA==
X-Received: by 2002:a63:2c10:: with SMTP id s16mr65847367pgs.173.1641803024031;
        Mon, 10 Jan 2022 00:23:44 -0800 (PST)
Received: from VICKYMQLIN-NB1.localdomain ([103.172.116.195])
        by smtp.gmail.com with ESMTPSA id ng18sm6320388pjb.36.2022.01.10.00.23.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jan 2022 00:23:43 -0800 (PST)
Date:   Mon, 10 Jan 2022 16:23:39 +0800
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Shaobo Xu <xushaobo2@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix missing put_device call in hns_roce_get_cfg
Message-ID: <20220110082339.GA543@VICKYMQLIN-NB1.localdomain>
References: <20220110061234.28006-1-linmq006@gmail.com>
 <YdvjzJuSHTQfSONA@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdvjzJuSHTQfSONA@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,
On Mon, Jan 10, 2022 at 09:44:12AM +0200, Leon Romanovsky wrote:
> 
> This file was removed in the commit 38d220882426 ("RDMA/hns: Remove
> support for HIP06").
> 
> BTW, please recheck your patch submission flow, the received emails have
> broken "To ..." field that makes reply do not work.
> 
Thanks for reminding me. I'll check it.

