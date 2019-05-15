Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F074A1FA08
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 20:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfEOSdq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 14:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfEOSdq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 May 2019 14:33:46 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E61320843;
        Wed, 15 May 2019 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557945225;
        bh=nigG5OWsba3FepSmlfAcb54+5f9vuI+zlbkPwAEoS4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFRHXzv40OiTUPE7BcK4g+b4OW1CtnTV26mE035v1FVV6Qf3bVRAeQBThJhoxX6nT
         goH2ziOopcnEfoWS75xc+4Iq/p8H/w7PWDCp+ULrBP8ckj/4jD89Ef2hKTwJPEWdX9
         KGMsEso/RivRXPuwp/BO5SdzoAn28gaUT0XhKJiY=
Date:   Wed, 15 May 2019 21:33:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH rdma-next v2] RDMA/srp: Rename SRP sysfs name after
 IB device rename trigger
Message-ID: <20190515183342.GQ5225@mtr-leonro.mtl.com>
References: <20190515170638.11913-1-leon@kernel.org>
 <97b980a9-6a2a-234e-c12c-b7ee5fd4262e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b980a9-6a2a-234e-c12c-b7ee5fd4262e@acm.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 07:32:35PM +0200, Bart Van Assche wrote:
> On 5/15/19 7:06 PM, Leon Romanovsky wrote:
> > +	list_for_each_entry_safe(host, tmp_host, &srp_dev->dev_list, list) {
> > +		char name[IB_DEVICE_NAME_MAX * 2] = {};
>                           ^^^^^^^^^^^^^^^^^^^^^^
> I think this should be IB_DEVICE_NAME_MAX + 8 instead of ... * 2. Please
> also consider to leave out the initialization of the char array since
> snprintf() overwrites the array whether or not it has been initialized.

Any reason why shoud we care for this micro optimizations?

>
> > +		snprintf(name, IB_DEVICE_NAME_MAX * 2, "srp-%s-%d",
>                                ^^^^^^^^^^^^^^^^^^^^^^
> Please change this into sizeof(name) such that the size expression only
> occurs once.

The same as sizeof it is calculated once at the stage of defines
expansion.

>
> Thanks,
>
> Bart.
>
