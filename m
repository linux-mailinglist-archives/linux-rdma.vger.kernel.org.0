Return-Path: <linux-rdma+bounces-17617-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJqXOkUhq2mPaAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17617-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 19:47:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596E3226D6F
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 19:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60B5E3096064
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F249A421A07;
	Fri,  6 Mar 2026 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmHr8s0c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4578E4219ED
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822835; cv=pass; b=SV8j0douLXD0zRQLtbnrxb+mXmg4aj3jaIWuUscxZWqBf7MCCtn9nMDg1Wcd5JVbOiB7Jevj/EoU8JYli0iV5FlX0Wq5AuUt6L62KnHWJ54Ohyt4bqlCrRcBaCHlf1GqaHgaKcVTHhfhAo4F7bdTkyN9Qp+dZXYB/ia4lrZyNxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822835; c=relaxed/simple;
	bh=g0vdLma7xjZDXNlTrA81K4zbu/aX7VEdpvCQsPHac+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5voogk2Dp8tZmfjOYRUzIwB523YSm0ISvU3rEP9rkp8oQ3YPXxJap1Gb/68EZGuGuN6j5muCzHRPJTlJUnNY9F4lttII0FvzcqFcXAcJbbY64IiFizKVdMNTB4ATvsqEqBKNuGhQphxW+1hc0i3Z3myY32Q7Hgb1+dLDR+T0W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmHr8s0c; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-464bc03efd8so5630693b6e.2
        for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 10:47:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772822830; cv=none;
        d=google.com; s=arc-20240605;
        b=lpcfVdrREnJPRVLn5xwOxM0K0GOTnBOh+YqXaMy8R9cRNVBtYlxWoPjINdUvoV3G08
         mDH1HCOJlNWjqbGu8u8y88b0eKIpEd/YPPmAlxWm+M8Ej11BzBBov1yYRAkF680Pn+dy
         2kdKQEjkM9+8E8ioViNC3/luerOt9o3T8WMYJthbfALJ7OBdcZhNLMRcJSiMhCmc9nuW
         8Lt7Zi0UMTPRwedBOeXCMGF6N0eFEQDWiNZoaVX852l7VtsT0r43HobCYMhR52BDFAsB
         njUfaIOG59Kah4uyxHIZ6t3Lhcegtf+HwThApgfK6+8uJ0scmQ7m93tK/Jvjg25/v++/
         Rbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2hWhdVZAhgQqjpgcV2poIb1s6L7chcwtFWzoWcynC0A=;
        fh=d065i3ZGq5/6F6Lknnn7ep8EDmYw9Vq7uHiGbcicIbQ=;
        b=FkqGWzNl1EeQkM7uMofmgnx4AUZYpx1/ZqtN4xs5soLJDUdZ7wr4mvb3I42CJUY43t
         yjxHLJ8ByT8FfaPi8b4bRQe+fclcRl/1QlEY+DDAbYUiPcvWi8R+VM5J/nZ8x9NR1oLt
         +E18KCSAbUA90MAQSEucYBKpQcp5s3GW6qhuqFNApLwIsSR+lW7CTWWT5CGmoZML8opo
         ac1aL5GM2PtWF5g5ZcPy8FNGKE29zAjz61FrGDemwOlROVJwM7TmWLyW5PsCr5hUb8y/
         1oCA9iH1ejppasWot6SeISlm/kAn3P10zOE2kXTQRaUg+telI6AWzh3bWhz4igwsHKdk
         d8Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772822830; x=1773427630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hWhdVZAhgQqjpgcV2poIb1s6L7chcwtFWzoWcynC0A=;
        b=mmHr8s0chcn9e8Z4V2k5vT82WPObhdUqH1VWIL3u+SgBxPCX7K7H/zWfUaeRUbZPDQ
         /8aNWcV2emYatTwZoNzn+/HmcN15XVcoclterrH3dxHQplbETRhfZqe+7Jw9jW8oZWFI
         SlRcNLdE9c56m9dWilTrgFGru0S7XKszA9RudPfT9l9349zfO2wC8CKbMzJNkmz9/XBt
         aGVxzA2oXfNuREbhIZ5hq94dgKS5w/areyIRTyvJOC1uk4O2iHUEjBD0BOzUKmN2SDD5
         GypAaV91Ace1NpL+bXe7qM/8Qp9Fw2PL3xYt7KoU1XrU9Y9me6sMKmL+e9lAG4Jy60b6
         8IXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772822830; x=1773427630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2hWhdVZAhgQqjpgcV2poIb1s6L7chcwtFWzoWcynC0A=;
        b=cblwhzHBekgl3epji74K7yVoaUkMIcdxFntkwsnoEYLYPl9P/oNE6eWp0ptRcxI7VU
         2yyaQZ6MBRtNTTC5o38yzL1uyXBajhriHIA512G/Q2q/yAG78+z1mJ9WqJYEBxCq3/hX
         HM6Y+Gp3pVSP1KQ5/bSmVbmSWJGRd9sQ3wv8DqTAt1RURxL9DxvQXmDpOha+irHfG9NM
         686bDZp/Rg6675BnUuAJ13daH34n6ebNiPTikXK1yrgUcT4yoGP5808kcryd6jOasmqU
         x9mU2ElZ8/8OnN5Lx96RxPGMcLfSzKzSDDkxLO8MLgU2N/AubTlXJb0CPG1zhCYhCLAG
         Yk2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXK+psINyprHDsjjLpw2gn6/mE+u/hMYVeyE84B64iq0i8WfdD/PxGsMS7cL7LdMCBf1P9gPzKCpKPp@vger.kernel.org
X-Gm-Message-State: AOJu0YzDD3B62W2q9q4L6Y9O44Qep1YcZYqBld5ysbo9J05P0boZL66M
	r/3d2G+MaLR6FVGymKX2bCE6mUlWHMflt0N1xw46gF9XA6sNTD3avaDCN4zm+5Lob7EmFKDOoKa
	ch7WYsP0yjn1U8Xj0YshWPFy0nxagqgk/9zcl
X-Gm-Gg: ATEYQzzObqzulaLySV88tdx86fn2kWiIROW7dDkn9ZNKgcjwh76+LdIsdVxKM6083Ev
	H3q9lwz9JtXAY7j5RkX/B/4prUp3zYU6h5UAw0N9mugELZFA02mWlySbQYe7Ii4XpLDTeZPRRhQ
	ZmWs3DnIRVaX3tOnUUCyMHpxJqVTm4LPKZs+ft0Np2cAgBysABZdZkvqHZ5qf+8dTvzOabFIp0H
	5FO5ehCwMPq/22AbGK2WLvH6POnEwlW+ifi7hQ5As/143AMg8vEa/j+RwLLmqq97QeNbWQRHEWp
	N5dN8GsnKZwzZ93hPA==
X-Received: by 2002:a05:6808:1a12:b0:45f:535:a81b with SMTP id
 5614622812f47-466dca45cacmr1736666b6e.20.1772822829773; Fri, 06 Mar 2026
 10:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305142634.1813208-1-tariqt@nvidia.com> <20260305142634.1813208-6-tariqt@nvidia.com>
In-Reply-To: <20260305142634.1813208-6-tariqt@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 6 Mar 2026 10:46:57 -0800
X-Gm-Features: AaiRm53OuZX6bDZqk3KXf0VBvaW1qaEMHdpnSE_P0kEPcVqB5bhMoCryjsytJug
Message-ID: <CAMB2axO9TLY7MznMYtvbfSp5Qev=W4ZM8EtnxFBs_gM=P9vmXQ@mail.gmail.com>
Subject: Re: [PATCH net 5/5] net/mlx5e: RX, Fix XDP multi-buf frag counting
 for legacy RQ
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 596E3226D6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17617-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,iogearbox.net,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qemu.org:url,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 6:27=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> wro=
te:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> XDP multi-buf programs can modify the layout of the XDP buffer when the
> program calls bpf_xdp_pull_data() or bpf_xdp_adjust_tail(). The
> referenced commit in the fixes tag corrected the assumption in the mlx5
> driver that the XDP buffer layout doesn't change during a program
> execution. However, this fix introduced another issue: the dropped
> fragments still need to be counted on the driver side to avoid page
> fragment reference counting issues.
>
> Such issue can be observed with the
> test_xdp_native_adjst_tail_shrnk_data selftest when using a payload of
> 3600 and shrinking by 256 bytes (an upcoming selftest patch): the last
> fragment gets released by the XDP code but doesn't get tracked by the
> driver. This results in a negative pp_ref_count during page release and
> the following splat:
>
>   WARNING: include/net/page_pool/helpers.h:297 at mlx5e_page_release_frag=
mented.isra.0+0x4a/0x50 [mlx5_core], CPU#12: ip/3137
>   Modules linked in: [...]
>   CPU: 12 UID: 0 PID: 3137 Comm: ip Not tainted 6.19.0-rc3+ #12 NONE
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-g=
a6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:mlx5e_page_release_fragmented.isra.0+0x4a/0x50 [mlx5_core]
>   [...]
>   Call Trace:
>    <TASK>
>    mlx5e_dealloc_rx_wqe+0xcb/0x1a0 [mlx5_core]
>    mlx5e_free_rx_descs+0x7f/0x110 [mlx5_core]
>    mlx5e_close_rq+0x50/0x60 [mlx5_core]
>    mlx5e_close_queues+0x36/0x2c0 [mlx5_core]
>    mlx5e_close_channel+0x1c/0x50 [mlx5_core]
>    mlx5e_close_channels+0x45/0x80 [mlx5_core]
>    mlx5e_safe_switch_params+0x1a5/0x230 [mlx5_core]
>    mlx5e_change_mtu+0xf3/0x2f0 [mlx5_core]
>    netif_set_mtu_ext+0xf1/0x230
>    do_setlink.isra.0+0x219/0x1180
>    rtnl_newlink+0x79f/0xb60
>    rtnetlink_rcv_msg+0x213/0x3a0
>    netlink_rcv_skb+0x48/0xf0
>    netlink_unicast+0x24a/0x350
>    netlink_sendmsg+0x1ee/0x410
>    __sock_sendmsg+0x38/0x60
>    ____sys_sendmsg+0x232/0x280
>    ___sys_sendmsg+0x78/0xb0
>    __sys_sendmsg+0x5f/0xb0
>    [...]
>    do_syscall_64+0x57/0xc50
>
> This patch fixes the issue by doing page frag counting on all the
> original XDP buffer fragments for all relevant XDP actions (XDP_TX ,
> XDP_REDIRECT and XDP_PASS). This is basically reverting to the original
> counting before the commit in the fixes tag.
>
> As frag_page is still pointing to the original tail, the nr_frags
> parameter to xdp_update_skb_frags_info() needs to be calculated
> in a different way to reflect the new nr_frags.

I see the error I made. Thanks for fixing it.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>
> Fixes: afd5ba577c10 ("net/mlx5e: RX, Fix generating skb from non-linear x=
dp_buff for legacy RQ")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Cc: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
> index 40e53a612989..268e20884757 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1589,6 +1589,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, s=
truct mlx5e_wqe_frag_info *wi
>         struct skb_shared_info *sinfo;
>         u32 frag_consumed_bytes;
>         struct bpf_prog *prog;
> +       u8 nr_frags_free =3D 0;
>         struct sk_buff *skb;
>         dma_addr_t addr;
>         u32 truesize;
> @@ -1631,15 +1632,13 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq,=
 struct mlx5e_wqe_frag_info *wi
>
>         prog =3D rcu_dereference(rq->xdp_prog);
>         if (prog) {
> -               u8 nr_frags_free, old_nr_frags =3D sinfo->nr_frags;
> +               u8 old_nr_frags =3D sinfo->nr_frags;
>
>                 if (mlx5e_xdp_handle(rq, prog, mxbuf)) {
>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT,
>                                                  rq->flags)) {
>                                 struct mlx5e_wqe_frag_info *pwi;
>
> -                               wi -=3D old_nr_frags - sinfo->nr_frags;
> -
>                                 for (pwi =3D head_wi; pwi < wi; pwi++)
>                                         pwi->frag_page->frags++;
>                         }
> @@ -1647,10 +1646,8 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, =
struct mlx5e_wqe_frag_info *wi
>                 }
>
>                 nr_frags_free =3D old_nr_frags - sinfo->nr_frags;
> -               if (unlikely(nr_frags_free)) {
> -                       wi -=3D nr_frags_free;
> +               if (unlikely(nr_frags_free))
>                         truesize -=3D nr_frags_free * frag_info->frag_str=
ide;
> -               }
>         }
>
>         skb =3D mlx5e_build_linear_skb(
> @@ -1666,7 +1663,7 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, s=
truct mlx5e_wqe_frag_info *wi
>
>         if (xdp_buff_has_frags(&mxbuf->xdp)) {
>                 /* sinfo->nr_frags is reset by build_skb, calculate again=
. */
> -               xdp_update_skb_frags_info(skb, wi - head_wi - 1,
> +               xdp_update_skb_frags_info(skb, wi - head_wi - nr_frags_fr=
ee - 1,
>                                           sinfo->xdp_frags_size, truesize=
,
>                                           xdp_buff_get_skb_flags(&mxbuf->=
xdp));
>
> --
> 2.44.0
>

