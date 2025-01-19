Return-Path: <linux-rdma+bounces-7081-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3ACA160E3
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 09:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF4D18856B7
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5901E19B59C;
	Sun, 19 Jan 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT0J+t7g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A54EB674
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737275189; cv=none; b=I10raZcmNQ/9GyFnq00Y0QuFWGK/Jf+PatLeonUjK75kfw4p1EIueKbxVnTfNZ473QKmttHr3GgfL2rg9BsaJS8xWd1YqeTzt0Mu+PfvDBOZx1PPepfBbsKwwipJWgM+Ftp7+tLgHh/dtc3UmoReQtAem2vnZhYzYSVFx4p5+pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737275189; c=relaxed/simple;
	bh=SLlz+ung3f5q3utqUEJcAk/qR7evp1Z9+QKW6r6bf6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwOoyjs9fvDNAti2wF/JmhdxU4yadn7gyrCtoYFZHOwCbm9vgpCnWv8XW41YnMrlw5oL3FHkamwP8FcTkm94i9EFc4Oy8sJQroul3rRHC5HU8+QlLYwsz+47tlcxeHPFVAq6nhYp+35jqkmxIQpcMygqZMu6t+aG4UFYotgxYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pT0J+t7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C178C4CED6;
	Sun, 19 Jan 2025 08:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737275188;
	bh=SLlz+ung3f5q3utqUEJcAk/qR7evp1Z9+QKW6r6bf6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pT0J+t7gV5T6Gt8laEljxBOwTJV1xO9ONVC5/C2PD+kSd2/A0qQz/ZqoxRcB0jbSy
	 bYj7LSI2o3bKpJVCC191tA5ZEbPxPYm/nuha2A8ROrHC3ScNOiNzio7rWHVSzdfHHq
	 QwmumM1URTZjkwCfLr8y7oOafkSOZfnHTLvVR/REqMX9BcuEx6xtsC9cv13NV3XXZt
	 Idj5YHq+pCSSfIO9LI42gxivPuMDh8qZQWNMLRylBW24lbUqwU0B1IRPtXkI4yTJ7N
	 3Ua4lENcCv29ijuSm2WADw/aWr71N20sJ1sbAwGdTowEOntBNylEgJBPyChtdlogjK
	 pfmsLHlI4I2Cg==
Date: Sun, 19 Jan 2025 10:26:24 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next v1 1/2] IB/mad: Add state machine to MAD layer
Message-ID: <20250119082624.GA21007@unreal>
References: <cover.1736258116.git.leonro@nvidia.com>
 <bf1d3e6c5eceb452a4fa4f6d08ea6b5220ab5cc9.1736258116.git.leonro@nvidia.com>
 <20250114194208.GF5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114194208.GF5556@nvidia.com>

On Tue, Jan 14, 2025 at 03:42:08PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 07, 2025 at 04:02:12PM +0200, Leon Romanovsky wrote:
> > +static void handle_send_state(struct ib_mad_send_wr_private *mad_send_wr,
> > +		       struct ib_mad_agent_private *mad_agent_priv)
> > +{
> > +	if (!mad_send_wr->state) {
> 
> What is this doing? state is an enum, what is !state supposed to be? 0
> is not a valid value in the enum.
> 
> > @@ -1118,15 +1209,12 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
> >  		mad_send_wr->max_retries = send_buf->retries;
> >  		mad_send_wr->retries_left = send_buf->retries;
> >  		send_buf->retries = 0;
> > -		/* Reference for work request to QP + response */
> > -		mad_send_wr->refcount = 1 + (mad_send_wr->timeout > 0);
> > -		mad_send_wr->status = IB_WC_SUCCESS;
> > +		mad_send_wr->state = 0;
> 
> Same, enums should not be assigned to constants. If you want another
> state you need another IB_MAD_STATE value and use it here and above.

Sure, will change.

> 
> > +#define EXPECT_MAD_STATE(mad_send_wr, expected_state)                  \
> > +	{                                                              \
> > +		if (IS_ENABLED(CONFIG_LOCKDEP))                        \
> > +			WARN_ON(mad_send_wr->state != expected_state); \
> > +	}
> > +#define EXPECT_MAD_STATE3(mad_send_wr, expected_state1, expected_state2, \
> > +			  expected_state3)                               \
> > +	{                                                                \
> > +		if (IS_ENABLED(CONFIG_LOCKDEP))                          \
> > +			WARN_ON(mad_send_wr->state != expected_state1 && \
> > +				mad_send_wr->state != expected_state2 && \
> > +				mad_send_wr->state != expected_state3);  \
> > +	}
> > +#define NOT_EXPECT_MAD_STATE(mad_send_wr, wrong_state)              \
> > +	{                                                           \
> > +		if (IS_ENABLED(CONFIG_LOCKDEP))                     \
> > +			WARN_ON(mad_send_wr->state == wrong_state); \
> > +	}
> 
> These could all be static inlines, otherwise at least
> mad_send_wr->state needs brackets (mad_send_wr)->state

I don't think that it is worth to have functions here.

Thanks

> 
> Jason

