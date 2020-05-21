Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA9E1DD2E1
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2020 18:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgEUQNG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 May 2020 12:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUQNG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 May 2020 12:13:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04F1C061A0E;
        Thu, 21 May 2020 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Qvj+YhI/0PK/4MddY8tEV6SkdBBTdLqfKHDVigUBDOs=; b=WSGMIYzJbA1Y5BlqgYvxPpUM/2
        rgTxmUggczJMNQXqI5xmzvVCMTlUBKh0dWmIyrnKrlY3aBa77YJZRMEQ6SgSekInCLR5v9Y1jfkXZ
        LPF7wvoj8tfILnMGh6ZTnYk41SEj45tNlVFFPmqbKFRgkPKl2DkGeWZmoJ9DcAPsNHcpu7lmKgYFF
        TFTQ9yPump0GJV92T8aAQf6E0Sgz9oDc2g/HEOeJu245f5QAS05XDpCu/mJb+h9HYr17FO+oi+P8X
        z/LZid1jJec7DwDqGdqcW40abOS8zNgLaXuTCQT6fpm9KhoiZ3LKSHqpfml/dZuH38dxF4xIGIfKQ
        xSt+C5HA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbnoc-0004rZ-5a; Thu, 21 May 2020 16:13:02 +0000
Subject: Re: [PATCH v2] rnbd/rtrs: pass max segment size from blk user to the
 rdma library
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-next@vger.kernel.org, axboe@kernel.dk, dledford@redhat.com,
        bvanassche@acm.org, leon@kernel.org, jinpu.wang@cloud.ionos.com
References: <20200519084812.GP188135@unreal>
 <20200519111419.924170-1-danil.kipnis@cloud.ionos.com>
 <20200519234443.GB30609@ziepe.ca>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6de09fa5-5a4f-dec4-7101-8dd27ca4c764@infradead.org>
Date:   Thu, 21 May 2020 09:12:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519234443.GB30609@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/19/20 4:44 PM, Jason Gunthorpe wrote:
> On Tue, May 19, 2020 at 01:14:19PM +0200, Danil Kipnis wrote:
>> When Block Device Layer is disabled, BLK_MAX_SEGMENT_SIZE is undefined.
>> The rtrs is a transport library and should compile independently of the
>> block layer. The desired max segment size should be passed down by the
>> user.
>>
>> Introduce max_segment_size parameter for the rtrs_clt_open() call.
>>
>> Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
>> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
>> Fixes: cb80329c9434 ("RDMA/rtrs: client: private header with client structs and functions")
>> Fixes: b5c27cdb094e ("RDMA/rtrs: public interface header to establish RDMA connections")
>>
>> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>> ---
>> v1->v2 Add Fixes lines.
> 
> Applied to for-next, thanks

Hi Jason,

Does your "for-next" feed into linux-next?
I am still seeing this build error today (linux-next 20200521).

thanks.
-- 
~Randy

