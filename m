Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193242C3A8A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 09:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgKYILF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 03:11:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbgKYILF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Nov 2020 03:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606291864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tnw84SCEf2LqNbbi56E/cJIEP/Ee74GPqqsq5AqWelw=;
        b=VNPFjmRpah15hYqkp1KKq1K1OKYMwS3h7lhsXH1BesQ4X4pO8vgtHrEdqwCBPFOZfph29d
        drz1tiIuUH5uFcqXCjQYHVLKCDVLe6Wp/+cRb2AtOpqOtEytLRh+nTdF0L4axjGVUxSS/K
        nJcrLTRd6RnVdaR89pKui73M8VacJok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-LcR0kaEVOHOXGHomx5SOKw-1; Wed, 25 Nov 2020 03:11:01 -0500
X-MC-Unique: LcR0kaEVOHOXGHomx5SOKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82E3C81CBDB;
        Wed, 25 Nov 2020 08:11:00 +0000 (UTC)
Received: from localhost (unknown [10.66.128.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC25A18996;
        Wed, 25 Nov 2020 08:10:59 +0000 (UTC)
Date:   Wed, 25 Nov 2020 16:10:57 +0800
From:   Honggang LI <honli@redhat.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
Message-ID: <20201125081057.GA547111@dhcp-128-72.nay.redhat.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com>
 <20201117193329.GH244516@ziepe.ca>
 <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com>
 <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com>
 <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com>
 <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com>
 <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com>
 <648D2533-E8E8-4248-AF2D-C5F1F60E5BFC@oracle.com>
 <alpine.DEB.2.22.394.2011241859340.286936@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2011241859340.286936@www.lameter.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 07:01:25PM +0000, Christopher Lameter wrote:
> On Mon, 23 Nov 2020, Håkon Bugge wrote:
> 
> > > Got version 33.0 from Redhat with the option. Set it but ibacm still times
> > > out when trying to contact the SM.
> >
> > Contact the peer ibacm, that is. Is it started?
> 
> 
> It can contact the peer ibacm if its running on a particular host. Then
> the resolution succeeds. But we want ibacm to talk to the subnet manager.
> 
> > And, ib_acme bypasses the kernel_only check. I assume a real app (e.g.,
> > qperf <destination_ip> -cm1 rc_bw) would work, but incur an excess delay
> > due to the ibacm timeout, before failing back to the kernel neighbour
> > cache.
> 
> Ok. But what does it matter?
> 
> 
> How do I figure out why ibacm is not talking to the subnet manager?

No, you can't talking to subnet manager, if you resolve IPoIB IP address
or hostname to PathRecord. The query MAD packets will be send to one
multicast group all ibacm service attached.

To resolve IPoIB address to PathRecord, you must:
1) The IPoIB interface must UP and RUNNING on the client and target
side.
2) The ibacm service must RUNNING on the client and target.

Thanks

