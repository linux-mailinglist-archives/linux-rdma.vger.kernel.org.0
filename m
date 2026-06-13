Return-Path: <linux-rdma+bounces-22186-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UuaLMoi1LGqoVgQAu9opvQ
	(envelope-from <linux-rdma+bounces-22186-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 03:42:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252667D768
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 03:42:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eoM7JN0E;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22186-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22186-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2971E3147EB6
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 01:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05D3A1E96;
	Sat, 13 Jun 2026 01:42:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACFD39FCCD;
	Sat, 13 Jun 2026 01:42:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781314942; cv=none; b=BnK5tKWDroBub4iJUqRskmPmZojHdHQbbUNeHkp8e00R0SFnuCv56UNUNIzUngkWJ67QQCb+/YMIRy9XQ+HFEs5bWT6RcRZwACGg1fLdx9HNAKJAbYoUtUvhP1YtaUZTqOxQB5zdiEZP4dhjHU01GD1NGEeeewyfnArBH81jw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781314942; c=relaxed/simple;
	bh=bqb3LM0D/JpOKMHF6rodJMPFtBaH/MwufcJA6Zk47xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3+hhjjgGF6em7Lamcm6wAaueV4ISRURrCoeHuQi1dfMy/BtuE+s7R/C5AFSPafddMSF5WH2vqO4iUX1I78z8Sit4nLh7VV0KdY08oTORctC4ZtekE501j1zunm9Mnht83gMrg/N+rQDcZfv9fG/x0J+0gmWy4l34erw7e0QE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoM7JN0E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCFF1F000E9;
	Sat, 13 Jun 2026 01:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781314938;
	bh=fDBHk68G0pC/YyoOUjQpa4Baza1QBFeBgxY8euxgm2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eoM7JN0EdCHRIx5JeR+KUvjOdDlcbTdn7YPNAG6m0FAgpwWQxT/5pDQ6itbJbZ+gZ
	 Wfb/Z4Ujd/08mUBBt/VzS6jTvTOemMQ8rFEwPWgll6ytWVi4ED/V2WuDXqM+0ZYidb
	 Pv6lmA/gItv3Xv4ZasVKzNK+58iSzzN0PP1cvMXmMp0YTST95pheD2yx3yJR9Rgu64
	 Flrb7Da1gs5aFSepFdihNa4WEF4le8Z/RIXVed3gHGj85Gc5cwsqvIxEKcm+0L7Jta
	 Id8OzB24xJU2Ou0C2tiaxo1Nj4OBre1K6sDUvRCCtoQ4PIyE02rSo042pQ4bHssgEn
	 hMk12Zl4SZa2g==
From: Jakub Kicinski <kuba@kernel.org>
To: tariqt@nvidia.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	saeedm@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gal@nvidia.com,
	lkayal@nvidia.com,
	cratiu@nvidia.com
Subject: Re: [PATCH net] net/mlx5e: Fix oops from ERR_PTR in act-miss restore teardown
Date: Fri, 12 Jun 2026 18:42:16 -0700
Message-ID: <20260613014216.2828397-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611134836.534015-1-tariqt@nvidia.com>
References: <20260611134836.534015-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22186-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:vladbu@nvidia.com,m:paulb@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:lkayal@nvidia.com,m:cratiu@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2252667D768

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/mlx5e: Fix oops from ERR_PTR in act-miss restore teardown

This change clears attr->act_id_restore_rule to NULL after
esw_add_restore_rule() fails, so the teardown path no longer
dereferences an ERR_PTR cookie as if it were a real mlx5_flow_handle.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index a9001d1c902f..4c135858f297 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -5863,6 +5863,7 @@ int mlx5e_tc_action_miss_mapping_get(struct mlx5e_priv *priv, struct mlx5_flow_a
>  	attr->act_id_restore_rule = esw_add_restore_rule(esw, *act_miss_mapping);
>  	if (IS_ERR(attr->act_id_restore_rule)) {
>  		err = PTR_ERR(attr->act_id_restore_rule);
> +		attr->act_id_restore_rule = NULL;
>  		goto err_rule;
>  	}

[High]
The commit message states that after this change "teardown only sees
NULL or a valid handle", framing NULL as benign.  Is that invariant
actually enforced on the consumer side?

Looking at the teardown helper:

drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:mlx5e_tc_action_miss_mapping_put() {
    struct mapping_ctx *ctx = mlx5e_get_priv_obj_mapping(priv);

    if (is_mdev_switchdev_mode(priv->mdev))
        mlx5_del_flow_rules(attr->act_id_restore_rule);
    mapping_remove(ctx, act_miss_mapping);
}

There is no NULL check before mlx5_del_flow_rules(), and
mlx5_del_flow_rules() itself dereferences handle->rule[0] without a
NULL check:

drivers/net/ethernet/mellanox/mlx5/core/fs_core.c:mlx5_del_flow_rules() {
    struct fs_fte *fte;
    int i;
    ...
    fs_get_obj(fte, handle->rule[0]->node.parent);
    down_write_ref_node(&fte->node, false);
    ...
}

So on any path where mlx5e_tc_action_miss_mapping_put() is reached with
attr->act_id_restore_rule == NULL in switchdev mode, this patch
converts the original ERR_PTR dereference into a NULL dereference at
the same site rather than avoiding the crash.

Today the put is gated by attr->ct_attr.offloaded in
mlx5_tc_ct_delete_flow(), and __mlx5_tc_ct_flow_offload() leaves
offloaded clear when mlx5e_tc_action_miss_mapping_get() fails, so the
specific oops in the call trace should no longer be reachable.  But
should the put be made symmetric with the new "NULL or valid" producer
contract, e.g.:

    if (is_mdev_switchdev_mode(priv->mdev) && attr->act_id_restore_rule)
        mlx5_del_flow_rules(attr->act_id_restore_rule);

so that any future caller that relies on the documented invariant
(including mlx5e_clone_flow_attr_for_post_act() in en_tc.c, which
already inherits this field) does not reintroduce the same oops with a
slightly different fault address?
-- 
pw-bot: cr

