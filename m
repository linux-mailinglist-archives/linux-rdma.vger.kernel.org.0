Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2EF2CD84E
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Dec 2020 14:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgLCN4v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Dec 2020 08:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLCN4v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Dec 2020 08:56:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7DCC061A4E
        for <linux-rdma@vger.kernel.org>; Thu,  3 Dec 2020 05:56:11 -0800 (PST)
Date:   Thu, 3 Dec 2020 14:56:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607003769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=khU8WSt0/NuEG9i4ym8kcPbGwSac+5D9UTwAgcHm56s=;
        b=PEi1Uur/JVHN5yCedLthuD2IhsyDJxikmbcL9I2ToL5X/dHsn7DkgTS0vUo6WYq4Hihgg2
        IljMXpGJv20MkjrE8rSyc9/gWaqgehT82CURz6GBXnmXlqsPm0sFNDTtFt1ZOctLuWOYR3
        hbbUN70THQ6kWydq+hfh8xZJm+aRtK1IaiC5nFToxCAuMdEf7pfMuz2f4GLIcxnjHBBGNI
        sVvj0nSDn+N14+R6mRrmdiaCYjPdMn60KsxErxPA8YXi3O2kl/8Th86F2VkystoyvwFKLg
        zrmzLKF6Hrf3656Dh1FIu0HDDvhhovdbOZRce+rz2q/xSHrHg1TC/xw415jmtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607003769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=khU8WSt0/NuEG9i4ym8kcPbGwSac+5D9UTwAgcHm56s=;
        b=wzbjITy314aby5WjLfcicq/SacRkXfMC+NC6cMqwmfY/tFaCSVypEWPV71jrQMCVfcEPV0
        VSOTOp3HCNx1ZUCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@nvidia.com>,
        linux-rdma@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] IB/iser: Remove in_interrupt() usage.
Message-ID: <20201203135608.f67bmpopealp7xcm@linutronix.de>
References: <20201126202720.2304559-1-bigeasy@linutronix.de>
 <20201126205357.GU5487@ziepe.ca>
 <20201127123455.scnqc7xvuwwofdp2@linutronix.de>
 <20201127130314.GE552508@nvidia.com>
 <20201127141432.z5hqxosugi6uu6i7@linutronix.de>
 <20201127143138.GG552508@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201127143138.GG552508@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020-11-27 10:31:38 [-0400], Jason Gunthorpe wrote:
> > Sure, I would do that but as noted above, it the `frwd_lock' is acquired
> > so you can't acquire the mutex here.
> 
> Ok, well, I'm thinking this patch is OK as is. Lets wait for Max and Sagi

a gentle ping to Max and Sagi in case we still wait for them here.

> Jason

Sebastian
