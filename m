Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F8A4B721
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 13:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfFSLey (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 07:34:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43077 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731626AbfFSLey (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 07:34:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so12980838qto.10
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 04:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Lo9X66uznaZ6SGYkNk0Sx1BYJ1CIYwurC70zh2R4uz8=;
        b=FKAUonMZk1gq68qWyHk5hxQwjYagl4YsmsAJviMRujON6p/cymKi6K/YRCSBGj83zJ
         JkfE/8aIyLUhGGY3g43VYw3XN/P1XonbUFKtelLRQiEwpnDabiu0XyHp4MTd4BxXnjq0
         V7oSMVDQ0B9LhdM9XamUqUYQ5FEAD5RlNAb4/W6UMjxMBMs9JgY42UFu4GcvX+n/zWDK
         MfPOy1Eqv9vEhMluQPKsGeBikLCd90E0ip1ORNx/X6O84GweOuD7mvfqOcigbyXMEBZB
         NoPogRjRvgMiG+lHlke1ShBBcwTOJQM51QTvE9P4WYq9zRxtb4rz854nmVnQvJZtVMtb
         Qb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Lo9X66uznaZ6SGYkNk0Sx1BYJ1CIYwurC70zh2R4uz8=;
        b=DZzenQI1NMZFWtdS99lVadebj8pc471tEv3SeiYlURu8fWfqk4vP1PAv5+DOYizyZU
         PfFYRaqPXERFMearoA+a6nPCCrD7n+Zm5ZrnW3kGmYy0JZyXgZ5kMKabzKamoYQrHU2N
         Rp/jZlA7ASkM/p3BzPi4YyCOoeEH1VtmCZbLODTDqcYAaKTdenYHL2altLPiH8gvp8NZ
         chrQVmyAKrtlBkVAnIO590Pa7x+b/IDKws7PyP6nhn2mEI/V7WgX3xcXz/Qb0oZjYVcS
         2ZNSXkdotnjx1BcKRqkVy1PQsVWTkVJF/rwRPTAoTbWSkCBzju0OewuK5B0+3JXXfFrr
         /cBA==
X-Gm-Message-State: APjAAAWihoOGuKovAcyzeeXvAnGd7sZebhHalpE1eZcAg12qQwwfohxI
        x08FobP4YQIhDSBLDO2kmHS4/A==
X-Google-Smtp-Source: APXvYqysE5jQwu5IGvItnPtoqMfHXLCakREbAz5IbbNkflU7Xd2VYz5hjEn1/wSvLEs0Ks3ehAZ0LQ==
X-Received: by 2002:ad4:5388:: with SMTP id i8mr6987929qvv.166.1560944093328;
        Wed, 19 Jun 2019 04:34:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i22sm10799810qti.30.2019.06.19.04.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 04:34:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdYrc-0002xP-6l; Wed, 19 Jun 2019 08:34:52 -0300
Date:   Wed, 19 Jun 2019 08:34:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 06/12] mm/hmm: Hold on to the mmget for the
 lifetime of the range
Message-ID: <20190619113452.GB9360@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-7-jgg@ziepe.ca>
 <20190615141435.GF17724@infradead.org>
 <20190618151100.GI6961@ziepe.ca>
 <20190619081858.GB24900@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619081858.GB24900@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 19, 2019 at 01:18:58AM -0700, Christoph Hellwig wrote:
> >  	mutex_lock(&hmm->lock);
> > -	list_del(&range->list);
> > +	list_del_init(&range->list);
> >  	mutex_unlock(&hmm->lock);
> 
> I don't see the point why this is a list_del_init - that just
> reinitializeѕ range->list, but doesn't change anything for the list
> head it was removed from.  (and if the list_del_init was intended
> a later patch in your branch reverts it to plain list_del..)

Just following the instructions:

/**
 * list_empty_careful - tests whether a list is empty and not being modified
 * @head: the list to test
 *
 * Description:
 * tests whether a list is empty _and_ checks that no other CPU might be
 * in the process of modifying either member (next or prev)
 *
 * NOTE: using list_empty_careful() without synchronization
 * can only be safe if the only activity that can happen
 * to the list entry is list_del_init(). Eg. it cannot be used
 * if another CPU could re-list_add() it.
 */

Agree it doesn't seem obvious why this is relevant when checking the
list head..

Maybe the comment is a bit misleading?

Jason
