Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8D1D9AA1
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 17:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgESPEO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgESPEN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 11:04:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED8EC08C5C0;
        Tue, 19 May 2020 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=klHY5uJiJ1ZMv4sROnMdMEUYgzDxI9wNLeNXBZIY+rI=; b=XYll6qzfRprQhwNNyOqxJpYMmg
        6Xqg/zQ6PlnvA3j7E1UEd4IHqyrnczfpL//+QAouvCoGhmyR83pOg5HIfhZBIMMu2uNr4gPtGDsGE
        HKeFcEhZ9Kezr3XXxJqQYuryKOj9+1psnJRSKo2bUoeCHlC41Z+E+Ju+yliydg8KvHXrhRg/70vTf
        ugZIP/pubXS54CzX0CEWbUgmfnPBjW0TFqf0kuJzpsDT+kMz1R7i7SHYClRcW3RhLHawGd9cXYLTK
        o0din+R8ceLHoursAwJjpHrNx6MLYvspuI/c3JC9h3zK+PRtUov/aAuozsFFQ+1dYxp/WmlbrY243
        gNjlsVBA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jb3mp-00020X-GT; Tue, 19 May 2020 15:04:07 +0000
Subject: Re: [PATCH v2] rnbd/rtrs: pass max segment size from blk user to the
 rdma library
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-next@vger.kernel.org, axboe@kernel.dk, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     bvanassche@acm.org, leon@kernel.org, jinpu.wang@cloud.ionos.com
References: <20200519084812.GP188135@unreal>
 <20200519111419.924170-1-danil.kipnis@cloud.ionos.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <63d61bce-afe4-5af7-d181-7380db9a701d@infradead.org>
Date:   Tue, 19 May 2020 08:04:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519111419.924170-1-danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/19/20 4:14 AM, Danil Kipnis wrote:
> When Block Device Layer is disabled, BLK_MAX_SEGMENT_SIZE is undefined.
> The rtrs is a transport library and should compile independently of the
> block layer. The desired max segment size should be passed down by the
> user.
> 
> Introduce max_segment_size parameter for the rtrs_clt_open() call.
> 
> Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Fixes: cb80329c9434 ("RDMA/rtrs: client: private header with client structs and functions")
> Fixes: b5c27cdb094e ("RDMA/rtrs: public interface header to establish RDMA connections")
> 
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> v1->v2 Add Fixes lines.
> 
>  drivers/block/rnbd/rnbd-clt.c          |  1 +
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 17 +++++++++++------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
>  drivers/infiniband/ulp/rtrs/rtrs.h     |  1 +
>  4 files changed, 14 insertions(+), 6 deletions(-)


-- 
~Randy
