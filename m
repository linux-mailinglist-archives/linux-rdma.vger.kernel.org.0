Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D313C207BE6
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404079AbgFXTBM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404055AbgFXTBL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Jun 2020 15:01:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D215C061573
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2020 12:01:10 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b4so2867398qkn.11
        for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2020 12:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UxhuCcM4n/E5ubiIaVoDOG2eQaFaHd2J3jsOWuuGl+4=;
        b=fqoBYDlkavWibY8Ve/ocploAHeB56hpIB3h2aGJ2E4YTtT2+gLxO8Lt/kqyoMuTcba
         oRxOWbDTRwhjjoXyod1iLTZFF5vk632iDrj6ZxK86S/HDVdH7MeYB7YNXXH1RGVMcFnw
         hePKOtytIqX3rbRynZYGaK47mNumW0Ck2JGxzVrwba+rgRSHbFNABY4UyNsQiqIiv1hb
         RrWok1tyo3ptHyKGyhCWGhhbcwUZndsXMtkV5k6YGTdzouZ6F/AVZR9wzMDDRtsGyJ4K
         FpHLA0ald1eSE7hkemvXtvkdUsroDkxKbFl2GGx/6jfxlLwPLJOI1MrlbB4z6hnW5VFZ
         zDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UxhuCcM4n/E5ubiIaVoDOG2eQaFaHd2J3jsOWuuGl+4=;
        b=SPIpV3TpuDI41LWnyZUv/aKpvJWbOb3OJjd8dZnc0tfVu/QTsIJcJMvPuauz/7Db98
         0igrPpwEHBLruEFkJKlU6MnBvzfnYxFeUN8Onpr26WOmUKdUDU97vfMq5vkjWcivxsBm
         LCv0v7Yww5tYRi56FAefd8JV+wDoGOcQqsum4M/5apZuGFBM+jkBgnmaovS82r8kQVka
         UPUN7kfRNSdqnZLhPM/DsOdivPt48cQgifS0ErXpnHXdks8hpbes1M3TH8cMsV+eDa0h
         2cqpp3j0mCRYhGiQgJ7Xegc4E2y4TG1+zLbq4VDyXmL4yt9wWbR/3okzMAfyYViLzshY
         tE8w==
X-Gm-Message-State: AOAM532Tr/4OVWQP6I1rudSd2jDjeHOuNTBlGPxMsbTN4QPV+Cec8eAg
        8UpQonJ7wJbsm6AlNK0fpcnc/A==
X-Google-Smtp-Source: ABdhPJw4IfuyTarkVvkPS5jnYPPqMO5GKfzaJexJCuwb/a3Ll29mTdq+qBtHRH6Pxfv0J3RQ/TG3mg==
X-Received: by 2002:a05:620a:1035:: with SMTP id a21mr24396544qkk.321.1593025269940;
        Wed, 24 Jun 2020 12:01:09 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 195sm4064029qkl.37.2020.06.24.12.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 12:01:09 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1joAdw-00Dgj7-Ee; Wed, 24 Jun 2020 16:01:08 -0300
Date:   Wed, 24 Jun 2020 16:01:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/2] Fixes for module unload
Message-ID: <20200624190108.GN6578@ziepe.ca>
References: <20200623202519.106975.94246.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623202519.106975.94246.stgit@awfm-01.aw.intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 04:32:18PM -0400, Dennis Dalessandro wrote:
> Two fixes for unload path. One is where the module use count got messed up in a
> previous fix, we missed hitting these paths. I missed hitting these paths. The
> other patch is going back to kfree for the dummy netdev. We are currently
> re-working how this dummy netdev stuff works and will send a series for-next
> soon.
> 
> Dennis Dalessandro (2):
>       IB/hfi1: Restore kfree in dummy_netdev cleanup
>       IB/hfi1: Fix module use count flaw due to leftover module put calls

I fixed the bogus Fixes line, please be more carefull

Applied to for-rc

Thanks,
Jason
