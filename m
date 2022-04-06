Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652054F6D92
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Apr 2022 23:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiDFV6c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Apr 2022 17:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiDFV5W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Apr 2022 17:57:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54525A582
        for <linux-rdma@vger.kernel.org>; Wed,  6 Apr 2022 14:53:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nt14-20020a17090b248e00b001ca601046a4so7134072pjb.0
        for <linux-rdma@vger.kernel.org>; Wed, 06 Apr 2022 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/t0ovIQiUOSTuPx9jgrpi/PzvlKilbnhNLqfgQvkTNs=;
        b=QL0b/ugDp7rEfToKioRS6zaw7qMCtRzhXcx97rQeoYhDmLHwlXGgRRpH9/kMshrhwz
         ZvfKDIfCfddTINqz3Ut1ZA5+lG4dH51YXHRcB685tp/LLFVd+aL6aDHRAaXBXeaP6ANW
         4wa9+Hz52fWdDsWuwwvC2oYNMX47hWa75bcMo1oNuFEnf2Q+saFIXZmUZ5kOGRfNhDI2
         VqFM4m5yVogBKZQfMTG0q4TTzLkFv0CfYmaikSIzrQwO3FFMv665RR+Woci08izfo7pg
         zKIWsGtKJoQaGHwZlbiuouHhnmLo+dBwCFunJka+1riOfe31SJ/hXerOQsM4QBAwMxpQ
         u3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/t0ovIQiUOSTuPx9jgrpi/PzvlKilbnhNLqfgQvkTNs=;
        b=FJ/i+CC7lhCpsLzQZZSXLx223x0U+xarjc7JeRsRcfLwOoG6WboXPbe/CFPCREYLEc
         rJ6MJolnFYnLLmHkBVzqWPOEUi6hmMJcB0k/MorqxCS1SRFVfr636Ip8khnOUcsl63fs
         JjmAWNzN4rpieOXHKd2N/SpCtUX1ppwqjfJhfjhqUqNPInc5CzyUQ5LohvYEOAMQQATG
         lWGgW7ngc53M53aN0Y6UP1sg8Xju2fZpLIiWiL0IJIpjbwWjmLb/uoE5JR0p2y/Atcof
         bgpAe1mzQltoa2yN18J6Mz2OWrcOWg/fVsjb9yc0YmrNEC1vvYuquYfrhsk+GMNFJBWX
         UBNQ==
X-Gm-Message-State: AOAM532BQ0uVPufdHGf2NkUkX9stnxD+7ondOIFMNpCVMVz2c5ioUu7E
        Fb7YWqEP7iZLzM7UFHpNsZUl3Q==
X-Google-Smtp-Source: ABdhPJzpSTHlVf5liK/Coh3Y8gHE/AVi3LRJciJq/cTWPnnJs2IFkVnqTH+/PxB+ksKiO4u5dnoncQ==
X-Received: by 2002:a17:903:246:b0:153:87f0:a93e with SMTP id j6-20020a170903024600b0015387f0a93emr10696792plh.171.1649282021257;
        Wed, 06 Apr 2022 14:53:41 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm20683081pfh.84.2022.04.06.14.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:53:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ncDas-00DxdY-9t; Wed, 06 Apr 2022 18:53:38 -0300
Date:   Wed, 6 Apr 2022 18:53:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     kernel test robot <lkp@intel.com>, benve@cisco.com,
        neescoba@cisco.com, kbuild-all@lists.01.org,
        linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/usnic: Refactor usnic_uiom_alloc_pd()
Message-ID: <20220406215338.GU64706@ziepe.ca>
References: <ef607cb3f5a09920b86971b8c8e60af8c647457e.1649169359.git.robin.murphy@arm.com>
 <202204070316.vOzwORw5-lkp@intel.com>
 <87075d61-c51c-8d94-9263-17aa40f7d70e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87075d61-c51c-8d94-9263-17aa40f7d70e@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 06, 2022 at 10:39:47PM +0100, Robin Murphy wrote:
> On 2022-04-06 20:54, kernel test robot wrote:
> > Hi Robin,
> > 
> > I love your patch! Yet something to improve:
> > 
> > [auto build test ERROR on rdma/for-next]
> > [also build test ERROR on v5.18-rc1 next-20220406]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> 
> Oops, I failed to notice that this does actually depend on the other patch I
> sent cleaning up iommu_present()[1] - I should have sent them together as a
> series, sorry about that.

No worries, I'll take care to order it right

Jason
