Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0C61D924D
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 10:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgESIpP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 04:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgESIpO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 May 2020 04:45:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C58B3204EA;
        Tue, 19 May 2020 08:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589877914;
        bh=/oUIKyijMY9tBYtAg0iDoMrJ26ailaXDLYdRp1LFwGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDMP1nvPxb4PCpjWKEnytQzy+Haj2zHnFp9EBlFIA9FhVywEsPzqr2mSk7Ldz5nqg
         vB4LXdzTCYpCz+9KKa21RlcGAY2LUkV5YrJAHVwKBN9rYUI7YIl6CPw+z3H1ziPojk
         S44vXK94LNj/f50d8Alq52vqABjB+vr271weSA4o=
Date:   Tue, 19 May 2020 11:45:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca,
        linux-next@vger.kernel.org, jinpu.wang@cloud.ionos.com,
        dledford@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        bvanassche@acm.org, rdunlap@infradead.org
Subject: Re: [PATCH 0/1] Fix RTRS compilation with block layer disabled
Message-ID: <20200519084510.GO188135@unreal>
References: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
 <20200519080136.885628-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519080136.885628-1-danil.kipnis@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 10:01:35AM +0200, Danil Kipnis wrote:
> Hi Jason, Hi All,
>
> this fixes the compilation problem reported by Randy Dunlap for RTRS on
> rdma for-next.
>
> Jason, am I even doing the right thing sending the fixes for the issues
> reported for the for-next for RTRS/RNBD to here?
>
> Danil Kipnis (1):
>   rnbd/rtrs: pass max segment size from blk user to the rdma library

Danil,

There is no need in cover letter for one patch.

Thanks

>
>  drivers/block/rnbd/rnbd-clt.c          |  1 +
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 17 +++++++++++------
>  drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
>  drivers/infiniband/ulp/rtrs/rtrs.h     |  1 +
>  4 files changed, 14 insertions(+), 6 deletions(-)
>
> --
> 2.25.1
>
