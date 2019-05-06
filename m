Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 917FE14F4A
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfEFPJ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:09:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35630 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfEFPJ2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:09:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id c15so665553qkl.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H6kovzfwptqduJcbvs74zyHW33iOCif1bk8VxXbJPDY=;
        b=Y6aO92w8E+8KQ1GGADUpzLkiFrHV2MzcB3VlnbMrkNF/OI/fM2NuQzpRy9nFzkd22w
         OtrFrnUOX00ebwOUT+FKqWQ+f4jmLSJqoIl2xf5zY77JijK6WhyQ1nleMBfvtU3BVaNt
         0zoa+KqRGcwhOtX09I7KiM/Ovw3CBUIkzOWgIG/pXjP3bkWenTFu1vckPpz85LzNfx+c
         Vb9E9j87/Xr4+S8DphhbDlwhQMu0++rQIkeGM9I99cTHhiGSz1yoY30Ii+LnkQzu3esp
         pZGldNqq1RwBEBHw4ZpVkJDPF9Hx9iO8QLxHWzVNE5A4Mtsb5mkV9ahUD3TWCqCdHoIl
         Ae/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H6kovzfwptqduJcbvs74zyHW33iOCif1bk8VxXbJPDY=;
        b=ZuAC4+gF5pzF27aFrssoouEDoO0BhmfubrQoO+Jw5Vnws37z09ONiFip+54K/4SejN
         xEfKu9ArzpZB8Q+Sf0U0bu4aw1tFdpVGmdpbenihGJRxNwf/R1P1sE0I7cneOiVa4UQQ
         2XVL/kR5x4Bjme37IIXui1/ZZ2ldnZOyReJtNVqjE2CM+sg5i+dUL4sYq7FfLf/jvUjq
         a5YrMzOmpN2Rb3yHLQGmFU5taOfSKBLckeWNxWcoBveU/zufpYKPmmc0VH9Jv99Ykqfu
         XYnYrNweMcCHI6Zktna3/Aasc8uVUEL3MK8WEJ3slUKTwINN5ZmgTCwgZ4pP1/Qltr71
         xBUA==
X-Gm-Message-State: APjAAAVDUllQGypz+RNUDtlUoFQbhdBO3FnNtDqS+q2nPkR4i3brMbkY
        5OAP76a4QqdfBua4zVajcPg=
X-Google-Smtp-Source: APXvYqwyWw5vYMRpJThF7bBBPJ1yqo6vswyP1eA/bW1+f6CZkSae6yE/4jxdaMLTaWtY7xOoi+0eug==
X-Received: by 2002:a37:a907:: with SMTP id s7mr21292870qke.124.1557155367694;
        Mon, 06 May 2019 08:09:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:34f3])
        by smtp.gmail.com with ESMTPSA id 76sm1633582qke.46.2019.05.06.08.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:09:25 -0700 (PDT)
Date:   Mon, 6 May 2019 08:09:23 -0700
From:   "Tejun Heo (tj@kernel.org)" <tj@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
Message-ID: <20190506150923.GK374014@devbig004.ftw2.facebook.com>
References: <20190318165205.23550.97894.stgit@scvm10.sc.intel.com>
 <20190318165501.23550.24989.stgit@scvm10.sc.intel.com>
 <20190319192737.GB3773@ziepe.ca>
 <32E1700B9017364D9B60AED9960492BC70CD9227@fmsmsx120.amr.corp.intel.com>
 <20190327152517.GD69236@devbig004.ftw2.facebook.com>
 <20190327171611.GF21008@ziepe.ca>
 <20190327190720.GE69236@devbig004.ftw2.facebook.com>
 <20190327194347.GH21008@ziepe.ca>
 <20190327212502.GF69236@devbig004.ftw2.facebook.com>
 <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053009d7de76f8800304f354e3cbde068453257f.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello, Doug.

On Wed, May 01, 2019 at 10:44:31AM -0400, Doug Ledford wrote:
> The discussion is helpful, but we still need to decide on the patch:
> 
> Correct me if I'm wrong Tejun, but the key issues are:
> 
> All WQ_MEM_RECLAIM work queues are eligible to be run when the machine
> is under extreme memory pressure and attempting to reclaim memory.  That
> means that the workqueue:
> 
> 1) MUST not perform any GFP_ATOMIC allocations as this could deadlock

GFP_ATOMIC or GFP_NOIO allocations are fine as they wouldn't block on
reclaim recursively; however, they can and will fail under severe
memory pressure.

> 2) SHOULD not rely on any GFP_KERNEL allocations as these may fail

Absolutely not, but not because they may fail but because it can end
up creating a waiting loop.

> 3) MUST complete without blocking

Blocking is fine as long as that blocking isn't memory bound.

> 4) SHOULD ideally always make some sort of forward progress if at all
> possible without needing memory allocations to do so

Yes, this is the only requirement.  All restrictions stem from this
one.

Thanks.

-- 
tejun
