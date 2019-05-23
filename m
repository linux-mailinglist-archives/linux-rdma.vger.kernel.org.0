Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED8512898E
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 21:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390306AbfEWTkE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 15:40:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390281AbfEWTkD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 May 2019 15:40:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 356F988E63;
        Thu, 23 May 2019 19:40:02 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4820A60BF3;
        Thu, 23 May 2019 19:40:01 +0000 (UTC)
Date:   Thu, 23 May 2019 15:39:59 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190523193959.GA5658@redhat.com>
References: <20190522174852.GA23038@redhat.com>
 <20190522235737.GD15389@ziepe.ca>
 <20190523150432.GA5104@redhat.com>
 <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca>
 <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca>
 <20190523182458.GA3571@redhat.com>
 <20190523191038.GG12159@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190523191038.GG12159@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 23 May 2019 19:40:02 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 04:10:38PM -0300, Jason Gunthorpe wrote:
> 
> On Thu, May 23, 2019 at 02:24:58PM -0400, Jerome Glisse wrote:
> > I can not take mmap_sem in range_register, the READ_ONCE is fine and
> > they are no race as we do take a reference on the hmm struct thus
> 
> Of course there are use after free races with a READ_ONCE scheme, I
> shouldn't have to explain this.

Well i can not think of anything again here the mm->hmm can not
change while driver is calling hmm_range_register() so if you
want i can remove the READ_ONCE() this does not change anything.


> If you cannot take the read mmap sem (why not?), then please use my
> version and push the update to the driver through -mm..

Please see previous threads on why it was a failure.

Cheers,
Jérôme
