Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A520899
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfEPNwy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 09:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPNwy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 09:52:54 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D9820657;
        Thu, 16 May 2019 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558014774;
        bh=qeX4i0JrTN9jqDaBVzn1t/lmiSevEpaIjo9eG2rgKUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=saDAd4SDQL+BFwDxZ6DosPXunOKY9mTfM0Snwh8+VN0HmVQ0/V87j8U6Bf1WPAxKx
         stpvxMvSH1AqY0W46s/L0vjBPGiwMPIyNyCJUlEIqXO71QkekZ6NE4lQ4LMSbwjXkB
         InH1VpP4piiEdbvJP7Yr9oBzM5Rg3q/4MejNPPb0=
Date:   Thu, 16 May 2019 16:52:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v3] RDMA/srp: Rename SRP sysfs name after IB
 device rename trigger
Message-ID: <20190516135250.GA6026@mtr-leonro.mtl.com>
References: <20190516065738.1423-1-leon@kernel.org>
 <b765380c-6477-6574-6863-74eb4f1e6b1c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b765380c-6477-6574-6863-74eb4f1e6b1c@acm.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 01:33:55PM +0200, Bart Van Assche wrote:
> On 5/16/19 8:57 AM, Leon Romanovsky wrote:
> > +static void srp_rename_dev(struct ib_device *device, void *client_data)
> > +{
> > +	struct srp_device *srp_dev = client_data;
> > +	struct srp_host *host, *tmp_host;
> > +> +	list_for_each_entry_safe(host, tmp_host, &srp_dev->dev_list, list) {
>         ^^^^^^^^^^^^^^^^^^^^^^^^
> Would list_for_each_entry() have been sufficient?

I assumed that if it is enough for srp_remove_one, it will be enough for
rename too.

>
> > +		char name[IB_DEVICE_NAME_MAX * 8];
>
> Why "* 8"? Would "+ 8" have been sufficient?

Typo

>
> Otherwise this patch looks good to me. This patch also passes the tests
> I ran.
>
> Thanks,
>
> Bart.
>
