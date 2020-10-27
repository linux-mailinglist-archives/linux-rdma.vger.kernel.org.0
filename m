Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C605C29A42C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 06:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505910AbgJ0FfC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Oct 2020 01:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505909AbgJ0FfC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Oct 2020 01:35:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25212085B;
        Tue, 27 Oct 2020 05:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603776900;
        bh=o8KjwG1qgEHLFE0CgMa83Nii4UJZz4VslTjNoSG8VP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qasIW30+C+JaIyl9mr2lLd8RjP2dFIdLZlBYcwSlGaPw9SQxkEtPUEXcDTWWphp+V
         BnnD4I5Id4HVl93mkvDV3qtPY034cPFy1cjPX+0wMOfxhoaJ+aamo/AXSHU1xAbnE+
         BzU06FcVBTRfZIqP6XxHDDlMUr8155RXbXrVap/Y=
Date:   Tue, 27 Oct 2020 07:34:56 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org,
        "Nicholas A. Bellinger" <nab@risingtidesystems.com>,
        target-devel@vger.kernel.org
Subject: Re: [PATCH rdma-next] IB/srpt: Fix memory leak in srpt_add_one
Message-ID: <20201027053456.GD4821@unreal>
References: <20201026132737.1338171-1-leon@kernel.org>
 <93385ff4-cab7-05f2-e29a-82c9c71e47fa@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93385ff4-cab7-05f2-e29a-82c9c71e47fa@acm.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 26, 2020 at 07:22:07PM -0700, Bart Van Assche wrote:
> On 10/26/20 6:27 AM, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@nvidia.com>
> >
> > In case srpt_refresh_port failed for the second port, then
> > we don't unregister the MAD agnet.
>                               ^^^^^
>                               agent?
>
> The commit message is incomplete. Why does this patch have a Fixes tag?
> The commit message should explain this but doesn't explain this.
>
> What does this patch actually change? ib_unregister_mad_agent() is only
> called by the current code if sport->mad_agent != NULL.

Failure in srpt_refresh_port() for the second port will leave MAD
registered for the first one, however the srpt_add_one() will be
marked as "failed" and SRPT will leak resources for that registered
but not used and released first port.

This is what is written in the commit message.

>
> > -static void srpt_unregister_mad_agent(struct srpt_device *sdev)
> > +static void __srpt_unregister_mad_agent(struct srpt_device *sdev, int port_cnt)
> >  {
> >  	struct ib_port_modify port_modify = {
> >  		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
> > @@ -633,7 +627,10 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
> >  	struct srpt_port *sport;
> >  	int i;
> >
> > -	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
> > +	if (!port_cnt)
> > +		return;
> > +
> > +	for (i = 1; i <= port_cnt; i++) {
> >  		sport = &sdev->port[i - 1];
> >  		WARN_ON(sport->port != i);
> >  		if (sport->mad_agent) {
>
> If this patch is retained, please leave the if-test out if you agree
> that it is not necessary. I'm concerned that it will confuse readers.

No problem.

>
> Thanks,
>
> Bart.
