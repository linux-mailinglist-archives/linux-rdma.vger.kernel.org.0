Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E354321C89B
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2020 12:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgGLKoZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jul 2020 06:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGLKoY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Jul 2020 06:44:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814AD206F0;
        Sun, 12 Jul 2020 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594550663;
        bh=ihv/l9aP+j/Lm8U8zXoL+LCZMt0De/q4f9a80tGX3Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZVAP2uxpjqDkYmydCZgtbbVEH3cKEGW2+UoUW2OevRy8E9Te4ti6EYH0vmyjDeIJ
         LWlSBM1UExYYEnPhAxSXbkVUeLXVttaVSQJUy2x/y4ry2gY6GXToVoesrmjvTQrPKN
         vH+wXr8gEG0vBkj/ow0gyIaCQQqP6omQ7ya4joVQ=
Date:   Sun, 12 Jul 2020 13:44:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     liweihang <liweihang@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: Question about IB_QP_CUR_STATE
Message-ID: <20200712104419.GA7287@unreal>
References: <876ca1eb8667461a9d2e0effb8ee3934@huawei.com>
 <881488e6-03d8-1e01-076c-5c901d84a44a@amazon.com>
 <20200708154434.GA1276673@unreal>
 <a738e3f3-e2bc-a670-7292-8025c78e210d@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a738e3f3-e2bc-a670-7292-8025c78e210d@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 09, 2020 at 09:13:45AM +0300, Gal Pressman wrote:
> On 08/07/2020 18:44, Leon Romanovsky wrote:
> > On Wed, Jul 08, 2020 at 03:42:34PM +0300, Gal Pressman wrote:
> >> On 08/07/2020 12:41, liweihang wrote:
> >>> Hi all,
> >>>
> >>> I'm a little confused about the role of IB_QP_CUR_STATE in the enumeration
> >>> ib_qp_attr_mask.
> >>>
> >>> In manual page of ibv_modify_qp(), comments of cur_qp_state is "Assume this
> >>> is the current QP state". Why we need to get current qp state from users
> >>> instead of drivers?
> >>>
> >>> For example, why the users are allowed to modify qp from RTR to RTS again
> >>> even if the qp's state in driver and hardware has already been RTS.
> >>>
> >>> I would be appretiate it if someone can help with this.
> >>>
> >>> Weihang
> >>>
> >>
> >> Talking about IB_QP_CUR_STATE, I see many drivers filling it in their query QP
> >> callback although it should only be used in modify operations.. Is there a
> >> reason not to remove it?
> >
> > IBTA section "11.2.5.3 QUERY QUEUE PAIR" has line about IB_QP_CUR_STATE.
> > It is one of output modifiers.
> >
> > Thanks
> >
>
> It says the current QP state should be returned, that's what qp_state field is used for.
> According to the man pages:
>
> libibverbs/man/ibv_query_qp.3:
>                enum ibv_qp_state       qp_state;            /* Current QP state */
>                enum ibv_qp_state       cur_qp_state;        /* Current QP state - irrelevant for ibv_query_qp */

I don't think that users read it, because ibv_cmd_query_qp() filled
qp_state to be equal to cur_qp_state from day one.

Thanks
