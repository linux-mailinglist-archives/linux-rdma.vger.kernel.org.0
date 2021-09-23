Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4795415CFD
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbhIWLqe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 07:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240539AbhIWLqe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 07:46:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A7A360F44;
        Thu, 23 Sep 2021 11:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632397503;
        bh=bPcEkFOimo2EnpsPJN+XPWyGn8/HSiQU0S0FT2fN8Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDtPer54vPO/xRRgZ9vyPmMpRocO6mI3tQgoPbiA3t/ExgEwbfD7y8I4mj8A8aWLX
         g4NDfzvuoe/cW8vF4EZxf4FTCtReVnT1G5zDT/wU9uxhFL8mrAIzKLlV9c91SuzEPw
         ReOAxMPuGIAEm5ps/GoJTK4yPLKRfiGTkDjvXm+cqoqtwyR/M8z44GfuktMhbH0sti
         UqHC5Au7W6dlSkkKkngxoy3nrFw9Npm+hmMknyIyKb/DM2GUrDnxs8bsMpKIER60F2
         H9OXAiF1bVXUv2+6iEb09gENWIjt5u4KNvT5R7cjQlBfV+JXBAq0/FwcFr9WLNsX+P
         NXxvJXdbimyNg==
Date:   Thu, 23 Sep 2021 14:44:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Message-ID: <YUxou5tFS5zcVAsV@unreal>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
 <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
 <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org>
 <YUwin2cn8X5GGjyY@unreal>
 <CH0PR01MB7153E7BD0F3CFBA384EF97ACF2A39@CH0PR01MB7153.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR01MB7153E7BD0F3CFBA384EF97ACF2A39@CH0PR01MB7153.prod.exchangelabs.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 23, 2021 at 11:04:02AM +0000, Marciniszyn, Mike wrote:
> > 
> > Isn't kptr_restrict sysctl is for that?
> > 
> 
> It doesn't look like that works in irqs, softirqs.

Are you certain about it?

That sysctl is supposed to control the output of %p, nothing more.

> 
> We have plenty of those.
> 
> Mike
