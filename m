Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C1137BCC9
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhELMtW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 08:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhELMtW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 May 2021 08:49:22 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15223C061574
        for <linux-rdma@vger.kernel.org>; Wed, 12 May 2021 05:48:14 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 1so17080434qtb.0
        for <linux-rdma@vger.kernel.org>; Wed, 12 May 2021 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=angoNOTrCU+oO0Cd8aus/UUUwewH8cKVQ7s7fn9CN6g=;
        b=Ho7F32smGsxfTT70mBrAkYU7dDka6aCEN5mvBQYClxeUibke/4zub3VTRtiyrUAigU
         KxM0/xjYlYCbOVP0Nr0N20sdljjDpveaX93zZ1aw9F60RA73NCz5+MXuhBr6svrs1kqr
         p35xFYB2T0GpHRZbKKvQgPdUpQOmpwGje8E9l4XhIeY5bMS/ApggPg4J1oTVmKxPNKLI
         nBsANnY/yDHed0INIib7IDnsqvBcV0s3SR1gmZh6HC29LadS+SkvPGRHFmXKhAOb8Rt0
         u1QwBpDiGPkFVp1r4wuMdWzY2nbrmcEKmYxbzkew/1Khw9gfDCKw0XIdhe6aU8Fw35so
         MyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=angoNOTrCU+oO0Cd8aus/UUUwewH8cKVQ7s7fn9CN6g=;
        b=R8YfvmoV8MoS4i5xno4edjuSuNW/ws9qMzukOtipQcFfqoKUvm+IFM03JQL61JLCJ1
         oxcOk1A/eFl8wwZp2bj2cTeTV6vD5vEgRwINYF13mMEIpkJ2Q3pNvhOg5SGTONcJUZL/
         etHOvfpukcgRmfCfYsFPxujEZjjyxl7TJsx1nl/7LHcBE/SYwyxQ2rBsHkgYm//0aoy1
         6q6IQB87+L1H5tDeW7xMFig+KRtF9xvzwXQ4xp9CzGPIsQlE+7Y/W/s3/zV1AN0u3Cdc
         ektnGcKtdVqnhovtwrsrGl8zRLdj+y9Yzdyo3Y3IAtSeQhihRWDajUvo8IbQB8S5tDqU
         vx0w==
X-Gm-Message-State: AOAM531XXY10lk55ABGKRZpfSvOug0QbfIeiWjM1MZeG1aw75QCfcDOp
        jUscz40RaRJRUywgW/UUU8aEpg==
X-Google-Smtp-Source: ABdhPJy2vrNRZMwFn/Pkb+R0Tp25auiuNkXiIp8TEHLE7VOxTzbPk4RdWd5OluUMJnwoRmXTL/DESQ==
X-Received: by 2002:ac8:6d17:: with SMTP id o23mr32864140qtt.139.1620823693362;
        Wed, 12 May 2021 05:48:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id v18sm12202299qkv.34.2021.05.12.05.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 05:48:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lgoHc-005pYz-A9; Wed, 12 May 2021 09:48:12 -0300
Date:   Wed, 12 May 2021 09:48:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 1/1] RDMA/rxe: remove the unnecessary break
Message-ID: <20210512124812.GD1096940@ziepe.ca>
References: <20210510084235.223628-1-yanjun.zhu@intel.com>
 <CAD=hENfbmEasEY4n7fN9NV4HjQWOPE6kJRROYWn+q_j33JOwHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENfbmEasEY4n7fN9NV4HjQWOPE6kJRROYWn+q_j33JOwHQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 10:45:17AM +0800, Zhu Yanjun wrote:
> On Mon, May 10, 2021 at 12:18 AM Zhu Yanjun <yanjun.zhu@intel.com> wrote:
> >
> > From: Zhu Yanjun <zyjzyj2000@gmail.com>
> >
> > In the final default, the break is not necessary.
> 
> Hi, Jason Gunthorpe and Leon Romanovsky
> 
> Gently ping

I'm not keen on this kind of churn

Jason
