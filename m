Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD3151DAF
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 16:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgBDPxl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 10:53:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbgBDPxk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 10:53:40 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913992084E;
        Tue,  4 Feb 2020 15:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580831620;
        bh=JbquLaQ2qe+Jj/CXZffYvdgZYH4HKy8LhjhtskZu8zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeXCCVLrm4DlBpm4O6V14I9L0+kZ7p+6dBJuAwuLpyYfAuNwv/J6iY8WTIQUHzx9G
         9TLKmR1TUdERMdQTK/86uKb2NdTqkqUPAeXbdhbCEXAVFwUKphvvscUad5xFty9nUr
         bzNP3tiul8YczPBbyr6+nZ8FTDRI6rNuRuazTNlw=
Date:   Tue, 4 Feb 2020 17:53:36 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     "Goldman, Adam" <adam.goldman@intel.com>,
        linux-rdma@vger.kernel.org, mike.marciniszyn@intel.com
Subject: Re: [PATCH] kernel-boot: Do not perform device rename on OPA devices
Message-ID: <20200204155336.GA414821@unreal>
References: <1580824520-38122-1-git-send-email-adam.goldman@intel.com>
 <20200204145657.GY414821@unreal>
 <cbc06c0c-400c-93e9-6ced-11b12927ea03@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc06c0c-400c-93e9-6ced-11b12927ea03@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 10:26:22AM -0500, Dennis Dalessandro wrote:
> On 2/4/2020 9:56 AM, Leon Romanovsky wrote:
> > On Tue, Feb 04, 2020 at 08:55:20AM -0500, Goldman, Adam wrote:
> > > From: "Goldman, Adam" <adam.goldman@intel.com>
> > >
> > > PSM2 will not run with recent rdma-core releases. Several tools and
> > > libraries like PSM2, require the hfi1 name to be present.
> > >
> > > Recent rdma-core releases added a new feature to rename kernel devices,
> > > but the default configuration will not work with hfi1 fabrics.
> > >
> > > Related opa-psm2 github issue:
> > >    https://github.com/intel/opa-psm2/issues/43
> >
> > Why don't you fix opa-psm2 and add required rdma-core version
> > checks inside packaging spec files, like we have inside
> > redhat/rdma-core.spec?
> >
> > Thanks
> >
>
> This is the way PSM has operated from day 1. It has been broken by this
> rename stuff. Clearly not everyone is fan, [1] [2] of the rename.

Of course that not everyone will be happy, it is a nature of progress :).

>
> Seems to me like we should revert back to the original behavior. However in
> lieu of that let HW vendors opt out like what this patch from Adam does.
>
> [1] https://marc.info/?l=linux-rdma&m=158082841016117&w=2
> [2] https://marc.info/?l=linux-rdma&m=158082569215149&w=2
>
> -Denny
