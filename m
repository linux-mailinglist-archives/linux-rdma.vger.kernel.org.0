Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B871CF27F0
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2019 08:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfKGHPs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Nov 2019 02:15:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfKGHPs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 Nov 2019 02:15:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C78821D6C;
        Thu,  7 Nov 2019 07:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573110947;
        bh=jKE4clSo5i0vJ59le3QfsJ+P5dEmnU/nblheiIfUgMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDSuRhNLikrUmaLbiGk5aAurX7mxcrAb9R1D9vcvCHq8qK/OpN3ir0mvrpm9v4lcD
         tGfGbRk8gs2KhXy3LEBuJ8vrQ7M38TuKI9Zd58B4FvFeruNxJ4rwyhqXO+dG2CE0Ox
         fxOkzOXiwXh+mQ2+LoRHVaKlwfZzMLpBKtwItRro=
Date:   Thu, 7 Nov 2019 08:15:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/qib: Validate ->show()/store() callbacks before
 calling them
Message-ID: <20191107071545.GA1117452@kroah.com>
References: <d45cc26361a174ae12dbb86c994ef334d257924b.1573096807.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d45cc26361a174ae12dbb86c994ef334d257924b.1573096807.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 07, 2019 at 08:50:25AM +0530, Viresh Kumar wrote:
> The permissions of the read-only or write-only sysfs files can be
> changed (as root) and the user can then try to read a write-only file or
> write to a read-only file which will lead to kernel crash here.
> 
> Protect against that by always validating the show/store callbacks.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/infiniband/hw/qib/qib_sysfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
