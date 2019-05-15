Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDA681EFCB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfEOLgg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 07:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731894AbfEOLgd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 07:36:33 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86F02084A;
        Wed, 15 May 2019 11:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557920192;
        bh=gCp1IRfFOrvv2LT3uRsKiXlkR0MpkSxghwWIXw3jEmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAv42JJuDiFunERGt1h5bQYN5x6UB+bnUyw6qNgOcc59lzXCJJXOpu4DnvQo2Etet
         HmzkcrCrhw17tTihNc+2mXLq5jq++MsnDLzsAj0SM1ItIMdL53f1tSpliDlkTbJ1/C
         8gdspmshj3Euda4/rXd2x4l1fxHGIqEOTTlohh0o=
Date:   Wed, 15 May 2019 14:36:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH rdma-next] RDMA/srp: Don't cache device name as part
 of sysfs name
Message-ID: <20190515113628.GL5225@mtr-leonro.mtl.com>
References: <20190515095013.8141-1-leon@kernel.org>
 <20587db8-fd08-534b-56d6-98d261c41914@acm.org>
 <20190515110401.GK5225@mtr-leonro.mtl.com>
 <f684a7db-39b6-167c-423c-a5f0ddae9d7b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f684a7db-39b6-167c-423c-a5f0ddae9d7b@acm.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 01:20:26PM +0200, Bart Van Assche wrote:
> On 5/15/19 1:04 PM, Leon Romanovsky wrote:
> > Any suggestions on what should be done in ib_srp to fix it?
>
> Hi Leon,
>
> How about adding an after_rename function pointer in struct ib_client,
> making ib_device_rename() call that function and adding an
> implementation of that callback in ib_srp that renames the SRP sysfs
> attributes that contain the device name?

Yes, I already implemented this variant, but hoped to see other ideas,
because we have no chances to rollback if something in ib_srp rename phase
will go wrong.

Thanks

>
> Thanks,
>
> Bart.
>
