Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F3E218719
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 14:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgGHMUS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 08:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgGHMUS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 08:20:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE4E20672;
        Wed,  8 Jul 2020 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594210817;
        bh=w5O1gxE3kPuxvSJR+0ciwom9gNRGsB+ORlstXqlL1LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1qWp7RHEzUwDzw91eBi30m/Ouq6lFK2KIECP/Y0otqAx9d5RhmEMcR9sukCJWS/M
         ITpPLSHtlhrfvoUcN8udzxkxxS/WXJuR8n9/3WB994d3CzlGZ8YuPmAXgw1+NxulEu
         wrQ/3vmMeEMRtW6rSmvXB4kHjyI3nS3P5O8vdWoA=
Date:   Wed, 8 Jul 2020 15:20:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: Question about IB_QP_CUR_STATE
Message-ID: <20200708122013.GX207186@unreal>
References: <876ca1eb8667461a9d2e0effb8ee3934@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876ca1eb8667461a9d2e0effb8ee3934@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 08, 2020 at 09:41:26AM +0000, liweihang wrote:
> Hi all,
>
> I'm a little confused about the role of IB_QP_CUR_STATE in the enumeration
> ib_qp_attr_mask.
>
> In manual page of ibv_modify_qp(), comments of cur_qp_state is "Assume this
> is the current QP state". Why we need to get current qp state from users
> instead of drivers?
>
> For example, why the users are allowed to modify qp from RTR to RTS again
> even if the qp's state in driver and hardware has already been RTS.
>
> I would be appretiate it if someone can help with this.

See, IBTA section "11.2.5.2 MODIFY QUEUE PAIR", table 96. "Current QP
state" is valid optional attribute in modify_qp() while transition to RTS.

I guess that the reason is to sync QP states seen by SW with HW.

Thanks

>
> Weihang
