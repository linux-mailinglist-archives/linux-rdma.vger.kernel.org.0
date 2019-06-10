Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459DE3B5F6
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 15:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388848AbfFJN1S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 09:27:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36050 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390164AbfFJN1S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jun 2019 09:27:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id p15so3111826qtl.3
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2019 06:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oV6QReXayCtQmoBZLkgDFRu2KT4B65BqRVMpVsE9uYQ=;
        b=Ytu0N2CXCBAu1JBKsLZtGZUes689+cm5THByaSSlP92LxHi2gE1cayUN013z/ZO8jj
         k6Obf/0vHtenaHsBp0FPzCiWJq1fcfdGb6BgaEkHPiHagv+gqqQ+Atny8lANTgoPIa30
         jbQyunb3++roPyjQpWmed9AeyzWqpnhCm4XlkAG5zTbM90MG9ePMvGcAqgZf5HHd5bri
         MuzGDyEDl7OYZXsSPsU/oEV5NkMHV/nch8IDhLPo1WJCgYCFP0ar9+yU5HbNf7iTsxrh
         g33XlfhB+Z1aWRb3D5emXoYI0zpApOjiJ423Tu0uA/I/d3mdySX68sgQhhLpDUdCXZ1i
         O+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oV6QReXayCtQmoBZLkgDFRu2KT4B65BqRVMpVsE9uYQ=;
        b=NAavvyQyLawKuRVRLApAmILkdCLerpxz5VMgQoVO642Ba6doaExOVfOamx0AZ4rbFa
         9v/V/mHdE/p1exRi2FkhxuBJWwIhb60rpDehvXSByCcDyOcQy/FnXWFL4Rux9li/VdBB
         3+OESTHXTXpf3v9a6ouPIjv8KtJ9XXgcGRY4OEFGMmToPdEAZBdNzmRRILjuAWuSh0CQ
         QkZR9bcDivfndzSd73VadSMh2igKbRDEHgROHtiZFEhD2PihfPtNKlZTp+0iyGReS/Js
         +QdlJKKdZL4IR1tPc+9Xb3CVOUrTKTFf/ChZN3VxfroY5N0klIgG4a2OucJMfDz6Re7r
         mjmg==
X-Gm-Message-State: APjAAAUO3xjRjY3ZhvrzkZW3exlKmilCO6mKonkZXb5oBjBevaOJH0Ap
        8TBT7AbG224/xwxh1e/oc2w4uA==
X-Google-Smtp-Source: APXvYqyqj6OjYKArCyPzbWQc7dK4u4q+6RIdTMJVhnlV+pOSUpOtFFbi7Q3oUgHe4oD46fBKZ7oTDA==
X-Received: by 2002:a0c:b5ad:: with SMTP id g45mr57861394qve.231.1560173237482;
        Mon, 10 Jun 2019 06:27:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w56sm6062980qta.72.2019.06.10.06.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 06:27:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1haKKS-0001pX-Lk; Mon, 10 Jun 2019 10:27:16 -0300
Date:   Mon, 10 Jun 2019 10:27:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     wangxi <wangxi11@huawei.com>
Cc:     Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        dledford@redhat.com, linuxarm@huawei.com, leon@kernel.org
Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
Message-ID: <20190610132716.GC18468@ziepe.ca>
References: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
 <1559285867-29529-2-git-send-email-oulijun@huawei.com>
 <20190607164818.GA22156@ziepe.ca>
 <26040386-e155-7223-b2b7-48e74e92b521@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26040386-e155-7223-b2b7-48e74e92b521@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 08, 2019 at 10:24:15AM +0800, wangxi wrote:

> > Why is there an EXPROT_SYMBOL in a IB driver? I see many in
> > hns. Please send a patch to remove all of them and respin this.
> > 
> There are 2 modules in our ib driver, one is hns_roce.ko, another
> is hns_roce_hw_v2.ko. all extern symbols are named like hns_roce_xxx,
> this function defined in hns_roce.ko, and invoked in
> hns_roce_hw_v2.ko.

seems unnecessarily complicated

Jason
