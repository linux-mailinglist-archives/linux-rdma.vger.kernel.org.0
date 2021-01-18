Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1722FAB0F
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 21:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394187AbhARUJm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 15:09:42 -0500
Received: from mail-1.ca.inter.net ([208.85.220.69]:41946 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394185AbhARUJh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 15:09:37 -0500
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 17EE32EA2F1;
        Mon, 18 Jan 2021 15:08:53 -0500 (EST)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id 6wxIMQiKLd4y; Mon, 18 Jan 2021 14:55:17 -0500 (EST)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id 06E792EA2DB;
        Mon, 18 Jan 2021 15:08:51 -0500 (EST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, ddiss@suse.de,
        bvanassche@acm.org
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
 <20210118182854.GJ4605@ziepe.ca>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
Date:   Mon, 18 Jan 2021 15:08:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118182854.GJ4605@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021-01-18 1:28 p.m., Jason Gunthorpe wrote:
> On Mon, Jan 18, 2021 at 11:30:03AM -0500, Douglas Gilbert wrote:
> 
>> After several flawed attempts to detect overflow, take the fastest
>> route by stating as a pre-condition that the 'order' function argument
>> cannot exceed 16 (2^16 * 4k = 256 MiB).
> 
> That doesn't help, the point of the overflow check is similar to
> overflow checks in kcalloc: to prevent the routine from allocating
> less memory than the caller might assume.
> 
> For instance ipr_store_update_fw() uses request_firmware() (which is
> controlled by userspace) to drive the length argument to
> sgl_alloc_order(). If userpace gives too large a value this will
> corrupt kernel memory.
> 
> So this math:
> 
>    	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);

But that check itself overflows if order is too large (e.g. 65).
A pre-condition says that the caller must know or check a value
is sane, and if the user space can have a hand in the value passed
the caller _must_ check pre-conditions IMO. A pre-condition also
implies that the function's implementation will not have code to
check the pre-condition.

My "log of both sides" proposal at least got around the overflowing
left shift problem. And one reviewer, Bodo Stroesser, liked it.

> Needs to be checked, add a precondition to order does not help. I
> already proposed a straightforward algorithm you can use.

It does help, it stops your proposed check from being flawed :-)

Giving a false sense of security seems more dangerous than a
pre-condition statement IMO. Bart's original overflow check (in
the mainline) limits length to 4GB (due to wrapping inside a 32
bit unsigned).

Also note there is another pre-condition statement in that function's
definition, namely that length cannot be 0.

So perhaps you, Bart Van Assche and Bodo Stroesser, should compare
notes and come up with a solution that you are _all_ happy with.
The pre-condition works for me and is the fastest. The 'length'
argument might be large, say > 1 GB [I use 1 GB in testing but
did try 4GB and found the bug I'm trying to fix] but having
individual elements greater than say 32 MB each does not
seem very practical (and fails on the systems that I test with).
In my testing the largest element size is 4 MB.


Doug Gilbert

