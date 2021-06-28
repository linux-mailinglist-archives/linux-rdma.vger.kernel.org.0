Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA923B5AC5
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jun 2021 10:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhF1JAz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 05:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhF1JAz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Jun 2021 05:00:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33AB461988;
        Mon, 28 Jun 2021 08:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624870709;
        bh=cUTM5AtfwSy9/q9vanMNxkfuM/ARelGi0PEx2mbUVco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McMOzvxofe9O5FooiitkLI0XRbIMd0njSmBOdGcWpDahDmzCc6E4y78jUF4Y30ZgK
         lTbWy3Vko/D6EICeY9po9ZjzFV/z+WdBimj2h87YGObRJIDQhhoIVO9gE/OyooFcBX
         Ge3yCaAoFukwff3JYM3PnIhtuoTPkAz7gnKiVgzNSa+dNMbKxjDlsqmXdwp71blBCp
         HfsxFQKWyrZWVo6DsHzvZKashvv40SzL09mufWUenLbL+DZUDFL4HIZRGQL0yw6cl0
         m/rH4FyDRX1JZvS6S2L4kHL6fZD14UmS1UgYGMtlj7BCPqksln+XqgXF+057J52YP0
         sdorudwOAuQ8w==
Date:   Mon, 28 Jun 2021 11:58:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tamir Ronen <tamirr@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Upstream IB management maintenance handover
Message-ID: <YNmPMqfsyQS+XMKh@unreal>
References: <PH0PR12MB5402DF8E4A7DA783B49917D7B9039@PH0PR12MB5402.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB5402DF8E4A7DA783B49917D7B9039@PH0PR12MB5402.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 28, 2021 at 08:05:30AM +0000, Tamir Ronen wrote:
> Hi,
> 
> My two years period  as upstream IB management maintainer (for OpenSM and ibsim) is now coming to an end. It's been my pleasure to have worked with the linux-rdma community.
> 
> Please welcome Julia Levin <juliav@nvidia.com> and Aleksandr Minchiu <alexmi@nvidia.com> as the new maintainers for these components. They have both been involved with IB management internally at Nvidia for quite some time now so they are uniquely qualified to step into the maintainership role. Julia will be taking over OpenSM and Aleksandr will be taking over ibsim. Please join me in wishing them success in their new roles.

Please send me their Github usernames and I'll add them to the
linux-rdma organization, so they will be able to do releases.

Thanks

> 
> -- Tamir.
