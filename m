Return-Path: <linux-rdma+bounces-20935-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFsrOsyKC2p1IwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20935-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 23:55:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51053574224
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 23:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DC2B30943AC
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 21:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A238039A803;
	Mon, 18 May 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pR7a8EmB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05345395D9F
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141004; cv=pass; b=G1OVtXL28cm+52FBe81jsIqKtc/m4cjLgvgvWS6D5FOxGej32TmDuJxClqK6qDOWoEu2Z2vOfqj+ytgoXAy4OGHto4G0GyEmL+z+CkyAPTdQtHhMa+gcig0okjpOB+hz8i0KBs5eA49j1l59mDjU2PSJtQtbBiLz++xtw2MqgHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141004; c=relaxed/simple;
	bh=VkJcVq88PZ051GeKnLPd8Ml2ZKh5BjaQJaJRp7q6aDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U342dHptHhrTbFMCNaVLr9qce5UCjjbvdt7bDduqeVahnB+VhLd4R7dgAIwqrQyx+Wdo70an/ppeLQsq6lqmaT+bad+nQMxV50TGO6wf6xPkt2GWAeg56xQOSjXV51caZIP6Nx+bH7YuQB/ls1dPNhn5lZGq2QsXN6VVnoP3vHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pR7a8EmB; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso815ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 14:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779141002; cv=none;
        d=google.com; s=arc-20240605;
        b=K1F2YIyDuf83UtYj2BkksNIHhvYl3s7SfjVMiJqxOrF/O6U9bUX4krlxOJi1aYuTfb
         hp4QuMWO+UjKNBczpdYjhHOtct+ynadfTFDgRO1xXMpn1vVVKVvJe+rwjeauBMM0zTI2
         Y0nF4E3Z4uq5CRG4izXh8ecsKv2dLej4Q4KynNsB0KEnWAl1oiHfHHFGixveEigJ6eyl
         5jS+x7caX9VZhKhnuAEwVJ9CPUE/c5SDU3G6pUiOZ5lq2K4sjKddsmkZhyYgcC3Qbac/
         ppFcu6k5GY1sPrkmK+hXlzNuwLJJbRigMy4XdCtTYUcbtwq9FBpb1xQ/UlUJvCl/Z+LJ
         D9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6JbypSeXnACgLDxcb5qtpEO/b70xrtWk27xe3ssqhmA=;
        fh=vH8vdgI0g5jc9KVEaptkXRYWQt49N6OX4bFwhXOs/sQ=;
        b=JAaRNhNepvZZsj2WZLkIP1ONHOkEfaqHXY+rpBFUcwYCptq8AaJvk5P6TUFNTTkpOP
         jwaRRNv+dP8R9dbtfw+zaUKdbFPXecHbkVEjwXIrE4dGs7bkPtYefkNTK3ug8mMRas94
         uPD4tZze0+DvQQNv4pfDIRLw5LS2U9dfTFX4KMD9GQM3zt8Fj/FiE6UwKxnNVcDjYXt/
         FMrPjUJgEocZdgedYRHeGiU2U/7DZC7hI1fx9WclIfDNSQvMg2zic0l2WixEYaRBvz5S
         U77eR3beKCIRui15CesT5xaikyMBVcnSENuCZ9mM1HsjKkmEw6L8G2gAUHIshYT/aF4D
         5GeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779141002; x=1779745802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JbypSeXnACgLDxcb5qtpEO/b70xrtWk27xe3ssqhmA=;
        b=pR7a8EmBPVhtgoI+iG1VPzFORXXBx15tpSmrwe8xs+DN6OwRvuST6qoTu/bminXVa0
         MRDXOUz8E5xc9sf3YPgPgTwNuGEIEKHitQ9ysyFhjfqnrPhBl78GpGwEfbS6wmbMNplv
         V06l+xrqnc3BHcmhkaXmEL/IUuKLrAuiBEQ3THI0IO0F6VHOXyzSlOUHrje95ZqjYAUI
         rFx+F0sc9GGw3Fkv0CovlxhYyIsCEIayzRIEzoKdp24HXkdaIHBKm0OTN/uo6BvE7r8y
         w2e0heo0RJLFkXkFjNCvVMt7Fcjc2G0J+gPs6rvi/VohEMuKipuldrZ5eBbZEx6Ftzmi
         XnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141002; x=1779745802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6JbypSeXnACgLDxcb5qtpEO/b70xrtWk27xe3ssqhmA=;
        b=asXFwRow2IpPCEK9aaUWyqT0kGub6QDtFqN5yUdvVGeDgzwsrzqXamGE907TIPn7n4
         nNRapoa3Ws6JamroBzz2Wj+IA8clB5L4eLPyhBm3eCvr5LSh7tDiR2CLsqQIsCPgYXwO
         arN+eqwSL1yP/kwYwsvFX16ltTLI8cFffAS+28jQZpo0GIjRgKxDXHNn89tud/U+E//G
         ux8HqcNz+gBN1bCSkDm6yZ2fcahVF/0ATPyjPiDToLEpkYJTan4UyF5Tx3oSe2ldayFc
         o+jCjq/piFgOFvrlhOhNHnA47O6Gxtut8yX9FsM3DawK2HGnTcuZxJKFTQre/7Dt5IKK
         fcVA==
X-Forwarded-Encrypted: i=1; AFNElJ+cRf7IbSucIxDCcn6gVBj+9Mk23QN3+++tsn3AjOvRvdE1ghl/vw5sS9ajFezJ9XSjItXKTgDjeuGG@vger.kernel.org
X-Gm-Message-State: AOJu0YwCKZUN6VcMS+Lw7gYeQaL1jLqULOIXDYSQg0gYg9t9BADGOKtU
	t7i/WRyFWSeYJRSH6dow4iH5PPxho9mQxaHzkMe/gpfxEyozhzjvFbRcacdVlI1o+3xJVepLO9s
	0YR9G1N4BNNPrkqj4hOoR2rJga1nAd6YgCXYNEtox
X-Gm-Gg: Acq92OGtmrYhqESRHewLpBNqziafSWoOqaTmQoe1ltHgoux64XBmeUNoKpatbru/zn0
	xAiJ/nk8s6mkBr5dhryvirEVNA0+hTYrhiyw2q95cjcNXu1DNNDyfKiZL3Fscz0qxBMJE3MAN/3
	KrqPpN/tAMto9RgytENk1xcVld26/csoFbjWTpdbSuWPjQgCi4d/ufuw7OiVAAuN8GA9Wclx8B8
	1Tv2SWM5GL5k53QRW+leg/0W7J1N37p1YLW83JNCLldLx3XMXUzCpIrxVJQEs/Wdsko9ogaH4W7
	CXkNIRIUgq3fM0bTwzP3yrPAYO7Qt+QMMIit2EHYCT28Qo7UklGRWG/W6dmDeSe1S0ynIPFWoEe
	aU9a3ZXNdYaBGSA3X
X-Received: by 2002:a17:903:2b0e:b0:2bd:7bec:f0e6 with SMTP id
 d9443c01a7336-2bdb3039f44mr4031835ad.1.1779141001688; Mon, 18 May 2026
 14:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518194654.735580-1-dipayanroy@linux.microsoft.com> <20260518194654.735580-2-dipayanroy@linux.microsoft.com>
In-Reply-To: <20260518194654.735580-2-dipayanroy@linux.microsoft.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 18 May 2026 14:49:49 -0700
X-Gm-Features: AVHnY4K_8GpyBqIYGQp4SgXCG1-y0gChQxakRF0W6U_iz8zjhZO9jcW9YHuJGe4
Message-ID: <CAEAWyHcFE5kUPthnRHQJS5s=YBRhdaOP9mYNsxkMt-Pm1U_1+A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net: mana: Add NULL guards in teardown path to
 prevent panic on attach failure
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, leon@kernel.org, 
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org, 
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com, 
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	stephen@networkplumber.org, jacob.e.keller@intel.com, 
	dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org, 
	john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20935-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 51053574224
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 12:52=E2=80=AFPM Dipayaan Roy
<dipayanroy@linux.microsoft.com> wrote:
>
> When queue allocation fails partway through, the error cleanup frees
> and NULLs apc->tx_qp and apc->rxqs. Multiple teardown paths such as
> mana_remove(), mana_change_mtu() recovery, and internal error handling
> in mana_alloc_queues() can subsequently call into functions that
> dereference these pointers without NULL checks:
>
> - mana_chn_setxdp() dereferences apc->rxqs[0], causing a NULL pointer
>   dereference panic (CR2: 0000000000000000 at mana_chn_setxdp+0x26).
> - mana_destroy_vport() iterates apc->rxqs without a NULL check.
> - mana_fence_rqs() iterates apc->rxqs without a NULL check.
> - mana_dealloc_queues() iterates apc->tx_qp without a NULL check.
>
> Add NULL guards for apc->rxqs in mana_fence_rqs(),
> mana_destroy_vport(), and before the mana_chn_setxdp() call. Add a
> NULL guard for apc->tx_qp in mana_dealloc_queues() to skip TX queue
> draining when TX queues were never allocated or already freed.
>
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network=
 Adapter (MANA)")
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 70 +++++++++++--------
>  1 file changed, 41 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 9afc786b297a..0582803907a8 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1727,6 +1727,9 @@ static void mana_fence_rqs(struct mana_port_context=
 *apc)
>         struct mana_rxq *rxq;
>         int err;
>
> +       if (!apc->rxqs)
> +               return;
> +
>         for (rxq_idx =3D 0; rxq_idx < apc->num_queues; rxq_idx++) {
>                 rxq =3D apc->rxqs[rxq_idx];
>                 err =3D mana_fence_rq(apc, rxq);
> @@ -2858,13 +2861,16 @@ static void mana_destroy_vport(struct mana_port_c=
ontext *apc)
>         struct mana_rxq *rxq;
>         u32 rxq_idx;
>
> -       for (rxq_idx =3D 0; rxq_idx < apc->num_queues; rxq_idx++) {
> -               rxq =3D apc->rxqs[rxq_idx];
> -               if (!rxq)
> -                       continue;
> +       if (apc->rxqs) {
>
> -               mana_destroy_rxq(apc, rxq, true);
> -               apc->rxqs[rxq_idx] =3D NULL;
> +               for (rxq_idx =3D 0; rxq_idx < apc->num_queues; rxq_idx++)=
 {
> +                       rxq =3D apc->rxqs[rxq_idx];
> +                       if (!rxq)
> +                               continue;
> +
> +                       mana_destroy_rxq(apc, rxq, true);
> +                       apc->rxqs[rxq_idx] =3D NULL;
> +               }
>         }
>
>         mana_destroy_txq(apc);
> @@ -3269,7 +3275,8 @@ static int mana_dealloc_queues(struct net_device *n=
dev)
>         if (apc->port_is_up)
>                 return -EINVAL;
>
> -       mana_chn_setxdp(apc, NULL);
> +       if (apc->rxqs)
> +               mana_chn_setxdp(apc, NULL);

Is this check required? mana_dealloc_queues() is only called by
mana_detach(). And mana_detach() calls `mana_dealloc_queues()` only if
the port state was previously up. apc->port_is_up seems to be set to
true only on successful queue allocation. Can apc->rxqs be NULL here?

>
>         if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
>                 mana_pf_deregister_filter(apc);
> @@ -3287,33 +3294,38 @@ static int mana_dealloc_queues(struct net_device =
*ndev)
>          * number of queues.
>          */
>
> -       for (i =3D 0; i < apc->num_queues; i++) {
> -               txq =3D &apc->tx_qp[i].txq;
> -               tsleep =3D 1000;
> -               while (atomic_read(&txq->pending_sends) > 0 &&
> -                      time_before(jiffies, timeout)) {
> -                       usleep_range(tsleep, tsleep + 1000);
> -                       tsleep <<=3D 1;
> -               }
> -               if (atomic_read(&txq->pending_sends)) {
> -                       err =3D pcie_flr(to_pci_dev(gd->gdma_context->dev=
));
> -                       if (err) {
> -                               netdev_err(ndev, "flr failed %d with %d p=
kts pending in txq %u\n",
> -                                          err, atomic_read(&txq->pending=
_sends),
> -                                          txq->gdma_txq_id);
> +       if (apc->tx_qp) {

And same as above, is it possible for apc->tx_qp to be NULL here?

> +               for (i =3D 0; i < apc->num_queues; i++) {
> +                       txq =3D &apc->tx_qp[i].txq;
> +                       tsleep =3D 1000;
> +                       while (atomic_read(&txq->pending_sends) > 0 &&
> +                              time_before(jiffies, timeout)) {
> +                               usleep_range(tsleep, tsleep + 1000);
> +                               tsleep <<=3D 1;
> +                       }
> +                       if (atomic_read(&txq->pending_sends)) {
> +                               err =3D
> +                                   pcie_flr(to_pci_dev(gd->gdma_context-=
>dev));
> +                               if (err) {
> +                                       netdev_err(ndev, "flr failed %d w=
ith %d pkts pending in txq %u\n",
> +                                                  err,
> +                                           atomic_read(&txq->pending_sen=
ds),
> +                                           txq->gdma_txq_id);
> +                               }
> +                               break;
>                         }
> -                       break;
>                 }
> -       }
>
> -       for (i =3D 0; i < apc->num_queues; i++) {
> -               txq =3D &apc->tx_qp[i].txq;
> -               while ((skb =3D skb_dequeue(&txq->pending_skbs))) {
> -                       mana_unmap_skb(skb, apc);
> -                       dev_kfree_skb_any(skb);
> +               for (i =3D 0; i < apc->num_queues; i++) {
> +                       txq =3D &apc->tx_qp[i].txq;
> +                       while ((skb =3D skb_dequeue(&txq->pending_skbs)))=
 {
> +                               mana_unmap_skb(skb, apc);
> +                               dev_kfree_skb_any(skb);
> +                       }
> +                       atomic_set(&txq->pending_sends, 0);
>                 }
> -               atomic_set(&txq->pending_sends, 0);
>         }
> +
>         /* We're 100% sure the queues can no longer be woken up, because
>          * we're sure now mana_poll_tx_cq() can't be running.
>          */
> --
> 2.43.0
>
>

