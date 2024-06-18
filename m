Return-Path: <linux-rdma+bounces-3261-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD23E90C788
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 12:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBB92840FD
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 10:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4D4188CB6;
	Tue, 18 Jun 2024 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLTDJsoj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C2215279C;
	Tue, 18 Jun 2024 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701237; cv=none; b=TvO2ByPQiGTxKQTLWef4efKWBFQjmQxE/UxZYuFUe64Y4+RaBRHfQluXgQjOH+pYr3/PmKp4dBddZrRgNoGBK+igldXynuzf3HYJg0lrrRXoV8gnqbwXED3mooP1+wsgDFvez4kV96Y1e3+QfycVN1HpDxdjGYQxw+8sArX8v5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701237; c=relaxed/simple;
	bh=UP+zPKTWJXEf18ikgSz4JVAIi4HunUZiH8TkyYHpONg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vy7dmaTFZBt3JHygu+YAnE3cgbj5m1cr92OWYV5aauQv1Pkr9VKaGHxRhHPlHTFcJy1TC1WvoHrXb5IG3Gkxr3hT9DeaObVhxZMHybaUCgrOzJIExu16nlyY4+fHjdrNyxLnFOO3KoWRtCsVp0iLRf/93R4uRjfizVj/5/Eqfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLTDJsoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E346CC4AF1A;
	Tue, 18 Jun 2024 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718701236;
	bh=UP+zPKTWJXEf18ikgSz4JVAIi4HunUZiH8TkyYHpONg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLTDJsojTqCSSiH8Od+6iE8djCJBBECoHUZgwWuXlJ89vPUUxbifJpaOgfDSZa+4E
	 NWD0mKDGywXNwkEVz0yPZNfLGcsGjPBKvAUzdxZVx3BOquQ+CLjtxm2S5pOB0LA3DE
	 qvUN981vysMzmyvGhZ4SvsgK6oZ3sbVazr1qjhaLrU1NK3+ZcbqBZiycgv9f+YwGVI
	 gfBOpEYY1HdWj3QwICJ+S0P46aTlWNEQ/M3SUZ1Wh4wWIGgsywRtCXYApPWbhDA5Ox
	 YKizgNyEbMnxZSq2eNkEpQNx5g8yo0GujwxmZq7qoi/ySjkW5aeQxOxK520Ym3PpU3
	 xoMCSlKdIkhig==
Date: Tue, 18 Jun 2024 12:00:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 04/15] net: hbl_cn: QP state machine
Message-ID: <20240618090031.GE4025@unreal>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-5-oshpigelman@habana.ai>
 <20240617131807.GE6805@unreal>
 <a43d2eaf-e295-4ed4-b66a-3f2e96ea088c@habana.ai>
 <20240618070843.GD4025@unreal>
 <5bac8717-55d8-419d-b7cd-7fcb69fd49fb@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bac8717-55d8-419d-b7cd-7fcb69fd49fb@habana.ai>

On Tue, Jun 18, 2024 at 07:58:55AM +0000, Omer Shpigelman wrote:
> On 6/18/24 10:08, Leon Romanovsky wrote:
> > On Tue, Jun 18, 2024 at 05:50:15AM +0000, Omer Shpigelman wrote:
> >> On 6/17/24 16:18, Leon Romanovsky wrote:
> >>> [Some people who received this message don't often get email from leon@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >>>
> >>> On Thu, Jun 13, 2024 at 11:21:57AM +0300, Omer Shpigelman wrote:
> >>>> Add a common QP state machine which handles the moving for a QP from one
> >>>> state to another including performing necessary checks, draining
> >>>> in-flight transactions, invalidating caches and error reporting.
> >>>>
> >>>> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> >>>> Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
> >>>> Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
> >>>> Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
> >>>> Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
> >>>> Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
> >>>> Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
> >>>> Co-developed-by: David Meriin <dmeriin@habana.ai>
> >>>> Signed-off-by: David Meriin <dmeriin@habana.ai>
> >>>> Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
> >>>> Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
> >>>> Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
> >>>> Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
> >>>> ---
> >>>>  .../ethernet/intel/hbl_cn/common/hbl_cn_qp.c  | 480 +++++++++++++++++-
> >>>>  1 file changed, 479 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c b/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c
> >>>> index 9ddc23bf8194..26ebdf448193 100644
> >>>> --- a/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c
> >>>> +++ b/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c
> >>>> @@ -6,8 +6,486 @@
> >>>
> >>> <...>
> >>>
> >>>> +/* The following table represents the (valid) operations that can be performed on
> >>>> + * a QP in order to move it from one state to another
> >>>> + * For example: a QP in RTR state can be moved to RTS state using the CN_QP_OP_RTR_2RTS
> >>>> + * operation.
> >>>> + */
> >>>> +static const enum hbl_cn_qp_state_op qp_valid_state_op[CN_QP_NUM_STATE][CN_QP_NUM_STATE] = {
> >>>> +     [CN_QP_STATE_RESET] = {
> >>>> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >>>> +             [CN_QP_STATE_INIT]      = CN_QP_OP_RST_2INIT,
> >>>> +             [CN_QP_STATE_SQD]       = CN_QP_OP_NOP,
> >>>> +             [CN_QP_STATE_QPD]       = CN_QP_OP_NOP,
> >>>> +     },
> >>>> +     [CN_QP_STATE_INIT] = {
> >>>> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >>>> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >>>> +             [CN_QP_STATE_INIT]      = CN_QP_OP_NOP,
> >>>> +             [CN_QP_STATE_RTR]       = CN_QP_OP_INIT_2RTR,
> >>>> +             [CN_QP_STATE_SQD]       = CN_QP_OP_NOP,
> >>>> +             [CN_QP_STATE_QPD]       = CN_QP_OP_NOP,
> >>>> +     },
> >>>> +     [CN_QP_STATE_RTR] = {
> >>>> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >>>> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >>>> +             [CN_QP_STATE_RTR]       = CN_QP_OP_RTR_2RTR,
> >>>> +             [CN_QP_STATE_RTS]       = CN_QP_OP_RTR_2RTS,
> >>>> +             [CN_QP_STATE_SQD]       = CN_QP_OP_NOP,
> >>>> +             [CN_QP_STATE_QPD]       = CN_QP_OP_RTR_2QPD,
> >>>> +     },
> >>>> +     [CN_QP_STATE_RTS] = {
> >>>> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >>>> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >>>> +             [CN_QP_STATE_RTS]       = CN_QP_OP_RTS_2RTS,
> >>>> +             [CN_QP_STATE_SQD]       = CN_QP_OP_RTS_2SQD,
> >>>> +             [CN_QP_STATE_QPD]       = CN_QP_OP_RTS_2QPD,
> >>>> +             [CN_QP_STATE_SQERR]     = CN_QP_OP_RTS_2SQERR,
> >>>> +     },
> >>>> +     [CN_QP_STATE_SQD] = {
> >>>> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >>>> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >>>> +             [CN_QP_STATE_SQD]       = CN_QP_OP_SQD_2SQD,
> >>>> +             [CN_QP_STATE_RTS]       = CN_QP_OP_SQD_2RTS,
> >>>> +             [CN_QP_STATE_QPD]       = CN_QP_OP_SQD_2QPD,
> >>>> +             [CN_QP_STATE_SQERR]     = CN_QP_OP_SQD_2SQ_ERR,
> >>>> +     },
> >>>> +     [CN_QP_STATE_QPD] = {
> >>>> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >>>> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >>>> +             [CN_QP_STATE_SQD]       = CN_QP_OP_NOP,
> >>>> +             [CN_QP_STATE_QPD]       = CN_QP_OP_NOP,
> >>>> +             [CN_QP_STATE_RTR]       = CN_QP_OP_QPD_2RTR,
> >>>> +     },
> >>>> +     [CN_QP_STATE_SQERR] = {
> >>>> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >>>> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >>>> +             [CN_QP_STATE_SQD]       = CN_QP_OP_SQ_ERR_2SQD,
> >>>> +             [CN_QP_STATE_SQERR]     = CN_QP_OP_NOP,
> >>>> +     },
> >>>> +     [CN_QP_STATE_ERR] = {
> >>>> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >>>> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >>>> +     }
> >>>> +};
> >>>
> >>> I don't understand why IBTA QP state machine is declared in ETH driver
> >>> and not in IB driver.
> >>>
> >>
> >> Implementing the actual transitions between the states requires full
> >> knowledge of the HW e.g. when to flush, cache invalidation, timeouts.
> >> Our IB driver is agnostic to the ASIC type by design. Note that more ASIC
> >> generations are planned to be added and the IB driver should not be aware
> >> of these additional HWs.
> >> Hence we implemeted the QP state machine in the CN driver which is aware
> >> of the actual HW.
> > 
> > Somehow ALL other IB drivers are able to implement this logic in the IB,
> > while supporting multiple ASICs. I don't see a reason why you can't do
> > the same.
> > 
> 
> If we are referring to this actual table, then I can move it to the IB
> driver and the CN driver will fetch the needed opcode via a function
> pointer.
> Is that ok?

This table spotted my attention, but right separation shouldn't be limited
to only this table. The outcome of this conversation should be:
"IB specific logic should be in IB driver, and CN driver should be able to
handle only low-level operations".

Thanks

