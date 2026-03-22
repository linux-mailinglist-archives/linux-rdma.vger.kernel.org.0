Return-Path: <linux-rdma+bounces-18504-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDCtEho8wGmSFAQAu9opvQ
	(envelope-from <linux-rdma+bounces-18504-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 19:59:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C65F2EA672
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 19:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B15E83006780
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D32363C49;
	Sun, 22 Mar 2026 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV153z1/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE171C14A;
	Sun, 22 Mar 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774205972; cv=none; b=al2KPwHmPNvGlUXOdaOowpJcbAvsO/hLXaQJOz2VHktqwSfiXa9NF2EHdBC9j3q+hXaac+Q+S+VU/hk6Hrqeps6X018dJZ1KunvlWtZU6JT0TZsDAmmfvQOV+tbnBs/g3ZcodiBDiwf+yqWffnoWPpHU7lpuyD1WGDdJ9nR8Zj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774205972; c=relaxed/simple;
	bh=cQ2hea2uiUwcJSbEEgjcyZ/JSFXQjtXU/c8ohIadX6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB96Kojv2ifAIkHl7l+eoZvxrfWYsDhNAWwcCQ+Ak5OlgGZJAN5gpaJT5GuByPVoLRAXXMQyQNpgSkjWtyRpCagUs2BTjddjKmtUxXj9kutCeiKiqrtK2yNm7tIfdeWw6i6bM/yETvuvGtzj/iM2e3UCzcFJIDuVwjdOkUjX0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV153z1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD7DC19424;
	Sun, 22 Mar 2026 18:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774205972;
	bh=cQ2hea2uiUwcJSbEEgjcyZ/JSFXQjtXU/c8ohIadX6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eV153z1/Hm8LluW5JZ1frKJNn1SYzmsUu+ppqvyIpg4f5BKzK3suMqOHZxrKmWcsL
	 AFoNFTS6H1M/hFR1MZl1QptSy7eW74K+1cwgby73pvI+Q79jARf2sw5wbf+xp/OIF/
	 BVs3j0I2r6K7Iekh5+bNB4kP2e8cqw1p5Z/nXl3+7y2PrVw1ES5YwTqyonSJwJl6uV
	 Y2v6RzfRccl6pftuLFTc+x2S6t0uCZmbtl8/HkNsmR7SSD9MR4zjcS8fmthNAcRWQL
	 NIakdfUrF9p2J3wT3ItqU/P9q5pK82hPGRi9F4I8mB5pyHDUmq+q2VR7l945A+42bG
	 zeSLRQdd7s5XA==
Date: Sun, 22 Mar 2026 20:59:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: Re: [PATCH] RDMA: update outdated references to hfi1_destroy_qp()
Message-ID: <20260322185927.GE814676@unreal>
References: <20260321105851.7556-1-kexinsun@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321105851.7556-1-kexinsun@smail.nju.edu.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18504-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nju.edu.cn:email]
X-Rspamd-Queue-Id: 9C65F2EA672
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 06:58:51PM +0800, Kexin Sun wrote:
> The function hfi1_destroy_qp() was removed in commit
> 75261cc6ab66 ("staging/rdma/hfi1: Remove destroy qp verb") in
> favor of the rdmavt generic rvt_destroy_qp().  Two comments still
> reference hfi1_destroy_qp() as the waiter that rvt_put_qp() will
> wake up; the actual waiter is now rvt_destroy_qp().  Update both
> references.
> 
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
>  drivers/infiniband/hw/hfi1/qp.c      | 2 +-
>  drivers/infiniband/sw/rdmavt/mcast.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
> index f3d8c0c193ac..bbb23c0386ee 100644
> --- a/drivers/infiniband/hw/hfi1/qp.c
> +++ b/drivers/infiniband/hw/hfi1/qp.c
> @@ -404,7 +404,7 @@ void hfi1_qp_wakeup(struct rvt_qp *qp, u32 flag)
>  		hfi1_qp_schedule(qp);
>  	}
>  	spin_unlock_irqrestore(&qp->s_lock, flags);
> -	/* Notify hfi1_destroy_qp() if it is waiting. */
> +	/* Notify rvt_destroy_qp() if it is waiting. */

Just remove these comments, they have no value.

Thanks

>  	rvt_put_qp(qp);
>  }
>  
> diff --git a/drivers/infiniband/sw/rdmavt/mcast.c b/drivers/infiniband/sw/rdmavt/mcast.c
> index 1fda344d2056..c75be2c53b2d 100644
> --- a/drivers/infiniband/sw/rdmavt/mcast.c
> +++ b/drivers/infiniband/sw/rdmavt/mcast.c
> @@ -49,7 +49,7 @@ static void rvt_mcast_qp_free(struct rvt_mcast_qp *mqp)
>  {
>  	struct rvt_qp *qp = mqp->qp;
>  
> -	/* Notify hfi1_destroy_qp() if it is waiting. */
> +	/* Notify rvt_destroy_qp() if it is waiting. */
>  	rvt_put_qp(qp);
>  
>  	kfree(mqp);
> -- 
> 2.25.1
> 

