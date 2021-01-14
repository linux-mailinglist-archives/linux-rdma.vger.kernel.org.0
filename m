Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95062F5B52
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 08:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbhANHaW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 02:30:22 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3117 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbhANHaW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jan 2021 02:30:22 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffff2e60002>; Wed, 13 Jan 2021 23:29:42 -0800
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan
 2021 07:29:41 +0000
Date:   Thu, 14 Jan 2021 09:29:38 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     Max Gurtovoy <mgurtovoy@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <dledford@redhat.com>, <jgg@nvidia.com>, <oren@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH 3/3] IB/isert: simplify signature cap check
Message-ID: <20210114072938.GM4678@unreal>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
 <20210110111903.486681-3-mgurtovoy@nvidia.com>
 <ea24823d-c1e9-d40f-866b-6671a13c08ad@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ea24823d-c1e9-d40f-866b-6671a13c08ad@grimberg.me>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610609382; bh=YiMsE+aoYYRmYjcdfpgrowDdBGbib4grlhK5MAqsI7A=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy;
        b=K1KPTn0zDCwIapSFFPYabQEdzyl6odMPx/4/t7A3zgdhFQKZSSmLB+uf0UjDU6Fl5
         gTePfWdHAyIXWOY7vIsOxzhMSLjof03gX+jwFUQMNNnL8o7kBGzxI9gBko8WN9y4n2
         k583LYUWNcvm5TKMJNgiypZsMpPvCyqkqpGyU+lrIANAyZVBpQDG3FIYzccmegVQ+i
         1igwYspHl2qttmhIAKJEeJaUu7ASHScl2r7L6HWWpkT0QmSJshyfygG93JHktYkRhx
         TdyRqL6N6uxUtKPY0wyHyduPRHlL37efSnxslEnvmYSmBSZ5etF3NF5NJhkkwyS5dc
         uyG8O3YQCDTOw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 13, 2021 at 04:08:29PM -0800, Sagi Grimberg wrote:
>
> > Use if/else clause instead of "condition ? val1 : val2" to make the code
> > cleaner and simpler.
>
> Not sure what is cleaner and simpler for a simple condition, but I don't
> mind either way...

Agree, probably even more cleaner variant will be:
 device->pi_capable = !!(ib_dev->attrs.device_cap_flags & IB_DEVICE_INTEGRITY_HANDOVER);

Thanks
