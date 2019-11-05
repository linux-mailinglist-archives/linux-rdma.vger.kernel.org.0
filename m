Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E96EFFB5
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 15:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389470AbfKEO2c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 09:28:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389073AbfKEO2c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 09:28:32 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB5D217F5;
        Tue,  5 Nov 2019 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572964111;
        bh=wXC2FiJ/OcQMSP+Pfa7quOPr5x1hKbbue7h/311W79Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pWdWZi1cIR++D7KZq5mqPk2f0vmCDqQD+pa6Eu2u/fkuZ6VVVYY9elmBHoYdjnYuk
         aGVbSyNX/zJdPeydUxMAHYxWBSmaTw6W313GqiRhwwfxZJP3dLmBZ6ujWCk+YSl1GX
         Yv6fbV2OkrgmoJ2j9xVFBGKez+Xh6R+AgIIrhdTI=
Date:   Tue, 5 Nov 2019 16:28:28 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@hisilicon.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/9] RDMA/hns: Cleanups for hip08
Message-ID: <20191105142828.GB6763@unreal>
References: <1572950394-42910-1-git-send-email-liweihang@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572950394-42910-1-git-send-email-liweihang@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 05, 2019 at 06:39:45PM +0800, Weihang Li wrote:
> These series just make cleanups without changing code logic.
>
> [patch 1/9 ~ 3/9] remove unused variables and structures.
> [patch 4/9 ~ 5/9] modify field and function names.
> [patch 6/9 ~ 7/9] remove dead codes to simplify functions.
> [patch 8/9] replaces non-standard return value with linux error codes.
> [patch 9/9] does some fixes on printings.
>
> Lang Cheng (3):
>   {topost} RDMA/hns: Remove unnecessary structure hns_roce_sqp
>   {topost} RDMA/hns: Simplify doorbell initialization code
>   {topost} RDMA/hns: Modify hns_roce_hw_v2_get_cfg to simplify the codea

You have something weird in your patch titles - "topost".

Thanks
