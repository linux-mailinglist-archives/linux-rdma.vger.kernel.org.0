Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBA2B6F53
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 20:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgKQTut (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 14:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgKQTus (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Nov 2020 14:50:48 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC493C0613CF
        for <linux-rdma@vger.kernel.org>; Tue, 17 Nov 2020 11:50:48 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 11so21885727qkd.5
        for <linux-rdma@vger.kernel.org>; Tue, 17 Nov 2020 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NypQx984dAXlmJpVO3kBy4u4BTutVPH4kO2vdac5fW8=;
        b=dSm8iPYkHnDlt8o69Eopxj6Jkw+BVIUSjpv8KDcpLATQOkmZkuBFfHwAq886hwftB8
         yDwH61uKBAPM2j8UzjEL4pqM0T1GXmoKLXa7FVacLue8JcihEPwrs7ZP4WmFve1P6HCh
         qBC7Yi2KEVepbRXHJH7xWgLggzSuf1VkbBEpv6d+lM4WWInqbmGc0Uq6g5m/97hyrnVk
         N/p4O0LD0UkQtNvpF94ju3ga1uwTe2b8MvvJeFwc4r+f7Gw7ZeXpZ7surZQnd9j32XrD
         RZDRLNfPQzBeHogPCqHL6XgggVpCy09kEpU2ofPrg+DfICTSNmAserSnqkD/Xf8imlfi
         8ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NypQx984dAXlmJpVO3kBy4u4BTutVPH4kO2vdac5fW8=;
        b=iJPnEDYMLhz2iUvtMy6ktrQNiCVXiCOdI+ZYO0gugq2v2Je8lFo0cenOTAqcSso0dR
         vEV000pdq7EvC60ukFf3KhKXOiVA8yvZKmOL1D8OCHfp9N0CPF2b7klP3X2s6ywacBiJ
         0YePlL2VXYe0Yub8beFqP8TKq4JMf/RffKvvJJNtb65hWEhbSa9a0GXMigC2mvs3NgP6
         GPTHu/2AzFoYQeZC7nmcBuBSbsV0c4pHgylj/uN5/0swNQMHlY5EInr9V/uSnaziiqvK
         sJC1INp5lYEdOpOfB45bQ9rCMvhiOPyd+q1uq3ru/0IwWNdh8WIgLw33Pozv00hwsmrk
         +N9A==
X-Gm-Message-State: AOAM530v175DA76xts6t1W7imXEWFV4qo+n7PlqGUvOysLpeESRTjVMS
        g46KvTDfiThPUuf7pMspn3mUuw==
X-Google-Smtp-Source: ABdhPJwU78HaRRxwEllvjAXvquK9oGFxriPrrJKwqqE4qpH/N+p8F72b3P5tIfRti7e+Vf3qidexKQ==
X-Received: by 2002:a37:7c81:: with SMTP id x123mr1183098qkc.383.1605642647996;
        Tue, 17 Nov 2020 11:50:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q11sm14304473qtp.47.2020.11.17.11.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:50:47 -0800 (PST)
From:   jgg@ziepe.ca
X-Google-Original-From: Jason Gunthorpe <jgg@ziepe.ca>, Eran Ben Elisha <eranbe@mellanox.com>
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kf702-007NUp-Bl; Tue, 17 Nov 2020 15:50:46 -0400
Date:   Tue, 17 Nov 2020 15:50:46 -0400
To:     Timo Rothenpieler <timo@rothenpieler.org>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Issue after 5.4.70->5.4.77 update: mlx5_core: reg_mr_callback:
 async reg mr failed. status -11
Message-ID: <20201117195046.GI244516@ziepe.ca>
References: <53e3f194-fe27-ba79-bcff-6dd1d778ede0@rothenpieler.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e3f194-fe27-ba79-bcff-6dd1d778ede0@rothenpieler.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 17, 2020 at 04:54:30PM +0100, Timo Rothenpieler wrote:
> The most likely candidate for this seems to be
> 0ec52f0194638e2d284ad55eba5a7aff753de1b9(RDMA/mlx5: Disable
> IB_DEVICE_MEM_MGT_EXTENSIONS if IB_WR_REG_MR can't work)  which was merged
> in 5.4.73. There were also a lot of mlx5 related changes in 5.4.71 though.
> Though since this is a production system, I cannot sensibly bisect this.

It is very unlikely, neither mlx5 or ipoib read that bit.

That error print is very bad:

  Nov 17 01:12:58 store01 kernel: mlx5_core 0000:01:00.0: cmd_work_handler:887:(pid 383): failed to allocate command entry

It really shouldn't happen

This is more likely the cause:

commit 073fff8102062cd675170ceb54d90da22fe7e668
Author: Eran Ben Elisha <eranbe@mellanox.com>
Date:   Tue Aug 4 10:40:21 2020 +0300

    net/mlx5: Avoid possible free of command entry while timeout comp handler
    
    [ Upstream commit 50b2412b7e7862c5af0cbf4b10d93bc5c712d021 ]
    
    Upon command completion timeout, driver simulates a forced command
    completion. In a rare case where real interrupt for that command arrives
    simultaneously, it might release the command entry while the forced
    handler might still access it.

Most likely it is missing some element.

Eran, can you check why v5.4.77 is totaly broken?

Jason
