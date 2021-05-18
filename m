Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451873882F8
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 01:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhERXJL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 19:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbhERXJL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 19:09:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA139600D3;
        Tue, 18 May 2021 23:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621379272;
        bh=OskfRRbXPJq2kmui4FHW94R4MBK3G9IhGlNoGBoRzo4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gjiqeQs9rYy6GdDG5l2V9SGmbYbDOVEkw87zMlmntg/rQZzGjrNTEgr7NfBcFUQcz
         9OnDAbY2/il8QJw+dq8crcKwMCR+93O2+y6EnOavBIsmVK8eLJ1eAZrGuH+O8aGce0
         prkhE3GM/urhQkz1X/FZgWfCb0Hp3tKlV83rrZw2p0G5VtPsLhi+g1z8ihFQf6/yXf
         isxItsEPYtxzF/Ww4AX6+SYPcaGOWF73vHvo1JBEROuOifUfiQ+JAzGpdGHxaAHW6A
         /gRKPxcH3HSyhU1iSirCC6r61i7+WbNIatycLd8FWKFjFjbvmNzpun6miODsn0132J
         6Eqm86lR1dNSA==
Subject: Re: [PATCH 00/13] Reorganize sysfs file creation for struct
 ib_devices
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <34754eda-f135-8da8-c46f-3ef45a08ea11@kernel.org>
Date:   Tue, 18 May 2021 16:07:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On 5/17/2021 9:47 AM, Jason Gunthorpe wrote:
> IB has a complex sysfs with a deep nesting of attributes. Nathan and Kees
> recently noticed this was not even slightly sane with how it was handling
> attributes and a deeper inspection shows the whole thing is a pretty
> "ick" coding style.
> 
> Further review shows the ick extends outward from the ib_port sysfs and
> basically everything is pretty crazy.
> 
> Simplify all of it:
> 
>   - Organize the ib_port and gid_attr's kobj's to have clear setup/destroy
>     function pairings that work only on their own kobjs.
> 
>   - All memory allocated in service of a kobject's attributes is freed as
>     part of the kobj release function. Thus all the error handling defers
>     the memory frees to a put.
> 
>   - Build up lists of groups for every kobject and add the entire group
>     list as a one-shot operation as the last thing in setup function.
> 
>   - Remove essentially all the error cleanup. The final kobject_put() will
>     always free any memory allocated or do an internal kobject_del() if
>     required. The new ordering eliminates all the other cleanup cases.
> 
>   - Make all attributes use proper typing for the kobj they are attached
>     to. Split device and port hw_stats handling.
> 
>   - Create a ib_port_attribute type and change hfi1, qib and the CM code to
>     work with attribute lists of ib_port_attribute type instead of building
>     their own kobject madness
> 
> This is sort of RFCy in that I qib and hfi1 stuff is complex enough it needs
> Dennis to look at it, and the core stuff has only passed basic testing at this
> moment. Nathan confirmed an earlier version solves the CFI warning.

This series still passes my basic testing of LTP's read_all test case on 
/sys with CFI in enforcing mode. If there is any more in-depth testing, 
I can put it through, let me know. I'll continue testing the series and 
when it is in a mergeable state, I can provide you with a Tested-by tag.

Cheers,
Nathan
