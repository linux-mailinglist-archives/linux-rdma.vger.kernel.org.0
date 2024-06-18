Return-Path: <linux-rdma+bounces-3256-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA89E90C46A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 09:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E801C21CC2
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9673467;
	Tue, 18 Jun 2024 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1FxFYrJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443324EB37;
	Tue, 18 Jun 2024 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694529; cv=none; b=KJ5M95+rn/7+bYWScQunSvRHlkqTrZoCmxagpf3vGFlnzMBoLft9azKYB5IAtiC8IRYlZazedhrCheJ5/z33qjpd2rbkF+jC2dDNRWFaFR3PMEMhR/lYTbtTnp48oke71vpk7MuL3acKwqZpx32Gn2rxn/EjnwYCrPmjwzIzfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694529; c=relaxed/simple;
	bh=OQs0ZHAYq+kY+OsBzADzt52NHiH43maiNAIxI+O162A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKB9OBbvgjomXmCJMm+xPAXcc6GM4JS2jQJaZdS1DuqxUTLVsNzGZoREC1YcQzP5BAqNDAVH6hBPiE/qSgYIE3YBmVeaOZvv5I0jTMtXfAjSqyMHn0cgOpqdTnA43J93RKjqzYKhr0cPNUziDE0JLwuw+yN6UQzD9Ivdi5T/LxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1FxFYrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA54C3277B;
	Tue, 18 Jun 2024 07:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718694528;
	bh=OQs0ZHAYq+kY+OsBzADzt52NHiH43maiNAIxI+O162A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1FxFYrJzlqCmkIEPx5iIrtt1ZKqeBrwJ147/RDW2mcrvLMMcKZAgVBcf1qSB2AHP
	 ED5bZHkJzN140OWBDChSgi9D9vhs8sMAijm6CjK7Zxw2MyIFngQC+ZdxBa5ACZ9y5d
	 YORPPk1F8xcaxcMBQIbmhyqUipnQz2CT+91w13PQ467C5hXA1btgaARGyJjQwsAtIY
	 u90PpjG71SR6AxQLjZ7c+r1bYwEWrXRrihr2SvS1TSAydFyBQCUO64CoLObPMtnOhR
	 rvahs/2U4L6yAZioj/6y+T5kCPt2kudlMtbClsIvOMUZ0Xujde8SQLi4j0UQTP6HoM
	 rriRs2qYQVZAg==
Date: Tue, 18 Jun 2024 10:08:43 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 04/15] net: hbl_cn: QP state machine
Message-ID: <20240618070843.GD4025@unreal>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-5-oshpigelman@habana.ai>
 <20240617131807.GE6805@unreal>
 <a43d2eaf-e295-4ed4-b66a-3f2e96ea088c@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a43d2eaf-e295-4ed4-b66a-3f2e96ea088c@habana.ai>

On Tue, Jun 18, 2024 at 05:50:15AM +0000, Omer Shpigelman wrote:
> On 6/17/24 16:18, Leon Romanovsky wrote:
> > [Some people who received this message don't often get email from leon@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Thu, Jun 13, 2024 at 11:21:57AM +0300, Omer Shpigelman wrote:
> >> Add a common QP state machine which handles the moving for a QP from one
> >> state to another including performing necessary checks, draining
> >> in-flight transactions, invalidating caches and error reporting.
> >>
> >> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> >> Co-developed-by: Abhilash K V <kvabhilash@habana.ai>
> >> Signed-off-by: Abhilash K V <kvabhilash@habana.ai>
> >> Co-developed-by: Andrey Agranovich <aagranovich@habana.ai>
> >> Signed-off-by: Andrey Agranovich <aagranovich@habana.ai>
> >> Co-developed-by: Bharat Jauhari <bjauhari@habana.ai>
> >> Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
> >> Co-developed-by: David Meriin <dmeriin@habana.ai>
> >> Signed-off-by: David Meriin <dmeriin@habana.ai>
> >> Co-developed-by: Sagiv Ozeri <sozeri@habana.ai>
> >> Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
> >> Co-developed-by: Zvika Yehudai <zyehudai@habana.ai>
> >> Signed-off-by: Zvika Yehudai <zyehudai@habana.ai>
> >> ---
> >>  .../ethernet/intel/hbl_cn/common/hbl_cn_qp.c  | 480 +++++++++++++++++-
> >>  1 file changed, 479 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c b/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c
> >> index 9ddc23bf8194..26ebdf448193 100644
> >> --- a/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c
> >> +++ b/drivers/net/ethernet/intel/hbl_cn/common/hbl_cn_qp.c
> >> @@ -6,8 +6,486 @@
> > 
> > <...>
> > 
> >> +/* The following table represents the (valid) operations that can be performed on
> >> + * a QP in order to move it from one state to another
> >> + * For example: a QP in RTR state can be moved to RTS state using the CN_QP_OP_RTR_2RTS
> >> + * operation.
> >> + */
> >> +static const enum hbl_cn_qp_state_op qp_valid_state_op[CN_QP_NUM_STATE][CN_QP_NUM_STATE] = {
> >> +     [CN_QP_STATE_RESET] = {
> >> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >> +             [CN_QP_STATE_INIT]      = CN_QP_OP_RST_2INIT,
> >> +             [CN_QP_STATE_SQD]       = CN_QP_OP_NOP,
> >> +             [CN_QP_STATE_QPD]       = CN_QP_OP_NOP,
> >> +     },
> >> +     [CN_QP_STATE_INIT] = {
> >> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >> +             [CN_QP_STATE_INIT]      = CN_QP_OP_NOP,
> >> +             [CN_QP_STATE_RTR]       = CN_QP_OP_INIT_2RTR,
> >> +             [CN_QP_STATE_SQD]       = CN_QP_OP_NOP,
> >> +             [CN_QP_STATE_QPD]       = CN_QP_OP_NOP,
> >> +     },
> >> +     [CN_QP_STATE_RTR] = {
> >> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >> +             [CN_QP_STATE_RTR]       = CN_QP_OP_RTR_2RTR,
> >> +             [CN_QP_STATE_RTS]       = CN_QP_OP_RTR_2RTS,
> >> +             [CN_QP_STATE_SQD]       = CN_QP_OP_NOP,
> >> +             [CN_QP_STATE_QPD]       = CN_QP_OP_RTR_2QPD,
> >> +     },
> >> +     [CN_QP_STATE_RTS] = {
> >> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >> +             [CN_QP_STATE_RTS]       = CN_QP_OP_RTS_2RTS,
> >> +             [CN_QP_STATE_SQD]       = CN_QP_OP_RTS_2SQD,
> >> +             [CN_QP_STATE_QPD]       = CN_QP_OP_RTS_2QPD,
> >> +             [CN_QP_STATE_SQERR]     = CN_QP_OP_RTS_2SQERR,
> >> +     },
> >> +     [CN_QP_STATE_SQD] = {
> >> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >> +             [CN_QP_STATE_SQD]       = CN_QP_OP_SQD_2SQD,
> >> +             [CN_QP_STATE_RTS]       = CN_QP_OP_SQD_2RTS,
> >> +             [CN_QP_STATE_QPD]       = CN_QP_OP_SQD_2QPD,
> >> +             [CN_QP_STATE_SQERR]     = CN_QP_OP_SQD_2SQ_ERR,
> >> +     },
> >> +     [CN_QP_STATE_QPD] = {
> >> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >> +             [CN_QP_STATE_SQD]       = CN_QP_OP_NOP,
> >> +             [CN_QP_STATE_QPD]       = CN_QP_OP_NOP,
> >> +             [CN_QP_STATE_RTR]       = CN_QP_OP_QPD_2RTR,
> >> +     },
> >> +     [CN_QP_STATE_SQERR] = {
> >> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >> +             [CN_QP_STATE_SQD]       = CN_QP_OP_SQ_ERR_2SQD,
> >> +             [CN_QP_STATE_SQERR]     = CN_QP_OP_NOP,
> >> +     },
> >> +     [CN_QP_STATE_ERR] = {
> >> +             [CN_QP_STATE_RESET]     = CN_QP_OP_2RESET,
> >> +             [CN_QP_STATE_ERR]       = CN_QP_OP_2ERR,
> >> +     }
> >> +};
> > 
> > I don't understand why IBTA QP state machine is declared in ETH driver
> > and not in IB driver.
> > 
> 
> Implementing the actual transitions between the states requires full
> knowledge of the HW e.g. when to flush, cache invalidation, timeouts.
> Our IB driver is agnostic to the ASIC type by design. Note that more ASIC
> generations are planned to be added and the IB driver should not be aware
> of these additional HWs.
> Hence we implemeted the QP state machine in the CN driver which is aware
> of the actual HW.

Somehow ALL other IB drivers are able to implement this logic in the IB,
while supporting multiple ASICs. I don't see a reason why you can't do
the same.

> 
> >> +
> > 
> > <...>
> > 
> >> +             /* Release lock while we wait before retry.
> >> +              * Note, we can assert that we are already locked.
> >> +              */
> >> +             port_funcs->cfg_unlock(cn_port);
> >> +
> >> +             msleep(20);
> >> +
> >> +             port_funcs->cfg_lock(cn_port);
> > 
> > lock/unlock through ops pointer doesn't look like a good idea.
> > 
> 
> More ASIC generations will be added once we merge the current Gaudi2 code.
> On other ASICs the locking granularity is different because some of the HW
> resources are shared between different logical ports.
> Hence it is was logical for us to implement it with a function pointer so
> each ASIC specific code can implemnet the locking properly.

We are reviewing this code which is for the current ASIC, not for the
unknown future ASICs. Please don't over engineer the first submission.
You will always be able to improve/change the code once you decide to
upstream your future ASICs.

Thanks

