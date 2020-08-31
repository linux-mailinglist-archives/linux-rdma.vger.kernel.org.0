Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265D2257E19
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHaQAj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 12:00:39 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38541 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgHaQAg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 12:00:36 -0400
Received: from webmail.gandi.net (webmail23.sd4.0x35.net [10.200.201.23])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPA id CB065FF80D;
        Mon, 31 Aug 2020 16:00:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 31 Aug 2020 19:00:32 +0300
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: remove unnecessary fallthrough usage
In-Reply-To: <20200831153440.GA24045@ziepe.ca>
References: <20200831153033.113952-1-cengiz@kernel.wtf>
 <20200831153440.GA24045@ziepe.ca>
Message-ID: <33b7fe93c7fd17658baeabd233d38099@kernel.wtf>
X-Sender: cengiz@kernel.wtf
User-Agent: Roundcube Webmail/1.3.15
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-08-31 18:34, Jason Gunthorpe wrote:
> On Mon, Aug 31, 2020 at 06:30:34PM +0300, Cengiz Can wrote:
>> Since /* fallthrough */ comments are deprecated[1], they are being 
>> replaced
>> by new 'fallthrough' pseudo-keyword.
>> 
>> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?\
>>         highlight=fallthrough#implicit-switch-case-fall-through
>> 
>> This sometimes leads to unreachable code warnings by static analyzers,
>> particularly in this case, Coverity Scanner. (CID 1466512)
>> 
>> Remove unnecessary 'fallthrough' keywords to prevent dead code
>> warnings.
>> 
>> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
>> ---
>>  drivers/infiniband/hw/qib/qib_mad.c | 2 --
>>  1 file changed, 2 deletions(-)
> 
> Alex beat you to it:
> 
> https://patchwork.kernel.org/patch/11736039/

Well, I'm glad it's fixed :)

Thanks for sharing

> 
> Thanks,
> Jason

-- 
Cengiz Can
@cengiz_io
