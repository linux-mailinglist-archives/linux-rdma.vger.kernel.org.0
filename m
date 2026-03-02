Return-Path: <linux-rdma+bounces-17401-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOUYCyzopWlLHwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17401-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:42:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C65671DEE83
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 20:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF8E13015D80
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CE447DD69;
	Mon,  2 Mar 2026 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuZjr/60"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5147D950;
	Mon,  2 Mar 2026 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480549; cv=none; b=Nlb1Txu+12sLYYWLo+4lOYBRHlUEGO5jtWFNz23LpO/Bu4V+xsBHr1iLrUQNMEXvCoLvLiit1Y+m1gGCLkmktXAr2fnr170t00aCIJG6kD8m0EhvXsxoaaEl9Psg1Ik5BcrnTFJuZQTPP7MwuaX6krqyomMP7vuOatoDWMAmvpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480549; c=relaxed/simple;
	bh=JPYvrKxoYGEZTL5J1MUdq9CGTebDSQtlDwt5Cv600V4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CG1EQvmySxZQnpBkJPTypiT8LUJ4+xw5PDy/+uv/5PyN65lhKHgGAt04JYXOSh1Sp3l97XeefTgmZO1s3JviZkNNiFJTamlckjLHA6LDh+Jp9iYS2sxc1R1GtDKh7WXC6IQGWZyd0Xcb+aOOmMTDNM4NO/YJmcMRoUea/6zoUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuZjr/60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAE8C19423;
	Mon,  2 Mar 2026 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772480548;
	bh=JPYvrKxoYGEZTL5J1MUdq9CGTebDSQtlDwt5Cv600V4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZuZjr/60wdzKtA0aVnr3EDkDaIvHTlAKRvUTIAvi4DyWUHVkH61GxdxijLiO8HyJJ
	 BqNGx0nmawGVWpxRJjmai7eiR1AOlUlclQTfgobE/sw6Uh76aDm5Tc0HyE5Nhva8PY
	 rwsc/t5BjqrtKFOtkyvGVLwudLwcEiwJP5tyc8IaB3S7SjIfHt1CHM8xwZkN7CZ0cq
	 e87z98fI5J7m4w4WuuakgbEIn9uf7+XtRFiPh6qU5zEsWcah1zw5iTkNhdzfpoCurC
	 Ln+cC/cXjFnp3ramIveloSC1gvvdovOkcaYjNyG93HbMJUKAJjwFD0KH2B1FDj3s4r
	 ok7+/MKet9E6Q==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: allen.hubbe@amd.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260227061809.2979990-1-abhijit.gangurde@amd.com>
References: <20260227061809.2979990-1-abhijit.gangurde@amd.com>
Subject: Re: [PATCH 1/1] RDMA/ionic: Preserve and set Ethernet source MAC
 after ib_ud_header_init()
Message-Id: <177248054555.993928.15778358538433900026.b4-ty@kernel.org>
Date: Mon, 02 Mar 2026 14:42:25 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-47773
X-Rspamd-Queue-Id: C65671DEE83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17401-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Fri, 27 Feb 2026 11:48:09 +0530, Abhijit Gangurde wrote:
> ionic_build_hdr() populated the Ethernet source MAC (hdr->eth.smac_h) by
> passing the header’s storage directly to rdma_read_gid_l2_fields().
> However, ib_ud_header_init() is called after that and re-initializes the
> UD header, which wipes the previously written smac_h. As a result, packets
> are emitted with an zero source MAC address on the wire.
> 
> Correct the source MAC by reading the GID-derived smac into a temporary
> buffer and copy it after ib_ud_header_init() completes.
> 
> [...]

Applied, thanks!

[1/1] RDMA/ionic: Preserve and set Ethernet source MAC after ib_ud_header_init()
      https://git.kernel.org/rdma/rdma/c/cbbdb148c62814

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


