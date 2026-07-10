Return-Path: <linux-rdma+bounces-22995-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oR4/Ns6+UGro4QIAu9opvQ
	(envelope-from <linux-rdma+bounces-22995-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 11:43:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AB8739344
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 11:43:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Aj1r4knP;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22995-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22995-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D395C3009F87
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 09:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A74D3F5BEC;
	Fri, 10 Jul 2026 09:41:20 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDCC3F5BF3
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 09:41:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676480; cv=none; b=mSonRecVbj/BX0V8aS67Dxm9hvl6C6k30WuBipl91kCYW+ljE2nTN+QK+Z31gkHxjLBM22mpfhmUO13ZW9ho/YjgZm6nVRBJzTlAEUDwZBvGqlXnA0dJehv3t0VCUgnOvTZLsSAwLA7G9YKyuVLhPCvqqXqe9LPBPlFgJMYPTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676480; c=relaxed/simple;
	bh=26n3C6fmi3dDyJgdUQ54kS61oR3PQKVNyDpt3lEa+eU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pB7N2sZLGQiXc0JqXPpwkAP7/9Y74ELK+AEU9mDQ4b5ietryMuqefjdXKhzN/p1SpRo2Yl5ELumX5Az3Q6C/Jf+W0hpzNhn+jKOMIYwdD14qhe0b7+Snv514aoR8/nJRlPquTF0DtPU80MsmagbG6CkJxoTPhSiNBvwaeWq5G8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aj1r4knP; arc=none smtp.client-ip=209.85.210.53
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso685712a34.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 02:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783676476; x=1784281276; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U3EBDRwV8tjmyMrX3V8ppuehdOxA6uAyrfKgHZsDhZw=;
        b=Aj1r4knPFyUiesepMlMY5EynyE7gbtsKvTKri91ks3jkZqMlVTVPkaWqI6HeQDgdrJ
         eqjeCJN1rct41Y2aFVoDu3FhPCyGIkpeS+pKT9C7Grg9fRbSxfvqn7urfTh9kiLXA0g4
         NLF8yAEWXMfayHIriM3aEmXRpjTlzXafAHQ8qM+uRj30FfCn5PIsoGE/NJjIc3ZVwv2o
         HuYtSkfZNBOWM7Hx1k+7MYfmUJwE0l5y/XO5HfUjhC4lN0RRqhQxpGwfoVC/4h/8ayyL
         B08zcgEGZ9EQWJzF5TjC3q/jfj5NEsMYoom4oBLOej6gEJP+UPluSqjqQb1+zj32Eq1R
         hsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676476; x=1784281276;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U3EBDRwV8tjmyMrX3V8ppuehdOxA6uAyrfKgHZsDhZw=;
        b=JBISfEjjAkMVmQeZEwW9Yhs0fgXp5T6OwK8ldmIYwJtrQvp4fXk1jKb0laP0tgQixv
         l3GbXd2BwfmwYkQt4v72nPklmmhnVxp/N/JpB22eXULkkMr1l2xjzsmQXypPsZtYNfVG
         t78k7zTiGpwaR+XJw0jSQQOyKLSfVUwU4uuOQfoprnGkoMsP4VmtrogZlgeYb6BPzAsj
         v4UjjPnZfS8tw24RRAJo/F4R2iMGOn9SgYuX6XU2hMMLbI9Bpzn9Ib3+uE4u7z6aGPBZ
         axBXSUY4etGurD1okkrG13bAwu/91rrSibA8BXCoTVcLccq9yJb+17okIMKeUKGJJgcS
         KcPw==
X-Gm-Message-State: AOJu0Yy/E2fUl5z+U+sZk2qAb3toVIuBtDNNEOG+P0bJxk+ORbJAE9RM
	1w4BOC4D0XNc2fbk/GNCEp6rJq9388w3+81VzrnV094E13odAkA0XvAiPH/Qmdbu+dQ=
X-Gm-Gg: AfdE7cmlHg7iRrO+T6R/L8gRNfi/yDGi2+6bsKD/7KZmWaogSNqDfHbMltGbXu7RZhT
	ab+5SVE/MXwP/bUgyUxy0ebvaeVgs+7b6kvEIQ4sOHDicSeYUbJsqg1nm1+fgC8lJop4/OHbTPA
	Dn4D81O4qy2II/n4YbAZmvOittrQFiSplGsKVG8SlPuWfMBDX3o9Ub/pADnjjVCdZTiledVp4/B
	vJEtjQWhVYPx9eW1My/sOpGm+Ka6anXXiwY9BGBpCGT14XI0VDd0keKhNxr7cCwcCPt81vdV7ls
	IUqzvC5owrfFDPLYc3Ipmz0r5AJBheusttHQt0hNBF3pum9IcAmImLqJiftiuFbZGtxA8ltvUhq
	vPyKNASjg4qDgyKyldcocO7+at848YsZl86E2PnAciaMgfof1N7t2GzxwWD3AC1/Y/TTyAKdpsq
	kHjDDF
X-Received: by 2002:a9d:6a10:0:b0:7e6:c8e:89f3 with SMTP id 46e09a7af769-7ebf26576d9mr1178331a34.6.1783676476561;
        Fri, 10 Jul 2026 02:41:16 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2631dfsm5990126a34.13.2026.07.10.02.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:41:14 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:41:08 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: Change TTC rules to match on undecrypted ESP
 packets
Message-ID: <alC-NENMq3PjalQV@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jianbol@nvidia.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[error27@gmail.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22995-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32AB8739344

Hello Jianbo Liu,

Commit 9f24f0c4d4dd ("net/mlx5: Change TTC rules to match on
undecrypted ESP packets") from Sep 18, 2025 (linux-next), leads to
the following Smatch static checker warning:

	drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c:614 mlx5_create_ttc_table_groups()
	warn: passing zero to 'PTR_ERR'

drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
    529 static int mlx5_create_ttc_table_groups(struct mlx5_ttc_table *ttc,
    530                                         bool use_ipv)
    531 {
    532         const struct mlx5_fs_ttc_groups *groups = ttc->groups;
    533         int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
    534         int ix = 0;
    535         u32 *in;
    536         int err;
    537         u8 *mc;
    538 
    539         ttc->g = kzalloc_objs(*ttc->g, groups->num_groups);
    540         if (!ttc->g)
    541                 return -ENOMEM;
    542         in = kvzalloc(inlen, GFP_KERNEL);
    543         if (!in) {
    544                 kfree(ttc->g);
    545                 ttc->g = NULL;
    546                 return -ENOMEM;
    547         }
    548 
    549         mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
    550         if (use_ipv)
    551                 MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ip_version);
    552         else
    553                 MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ethertype);
    554         MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
    555 
    556         /* TCP UDP group */
    557         if (groups->use_l4_type) {
    558                 MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.l4_type);
    559                 MLX5_SET_CFG(in, start_flow_index, ix);
    560                 ix += groups->group_size[ttc->num_groups];
    561                 MLX5_SET_CFG(in, end_flow_index, ix - 1);
    562                 ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
    563                 if (IS_ERR(ttc->g[ttc->num_groups]))
    564                         goto err;
    565                 ttc->num_groups++;
    566 
    567                 MLX5_SET(fte_match_param, mc, outer_headers.l4_type, 0);
    568         }
    569 
    570         /* L4 Group */
    571         MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ip_protocol);
    572         MLX5_SET_CFG(in, start_flow_index, ix);
    573         ix += groups->group_size[ttc->num_groups];
    574         MLX5_SET_CFG(in, end_flow_index, ix - 1);
    575         ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
    576         if (IS_ERR(ttc->g[ttc->num_groups]))
    577                 goto err;
    578         ttc->num_groups++;
    579 
    580         if (mlx5_ttc_has_esp_flow_group(ttc)) {
    581                 err = mlx5_create_ttc_table_ipsec_groups(ttc, use_ipv, in, &ix);
    582                 if (err)
    583                         goto err;


The error code is supposed to stored in ttc->g[ttc->num_groups].
(don't look at me, I didn't invent the rules).

    584 
    585                 MLX5_SET(fte_match_param, mc,
    586                          misc_parameters_2.ipsec_next_header, 0);
    587         }
    588 
    589         /* L3 Group */
    590         MLX5_SET(fte_match_param, mc, outer_headers.ip_protocol, 0);
    591         MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
    592         MLX5_SET_CFG(in, start_flow_index, ix);
    593         ix += groups->group_size[ttc->num_groups];
    594         MLX5_SET_CFG(in, end_flow_index, ix - 1);
    595         ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
    596         if (IS_ERR(ttc->g[ttc->num_groups]))
    597                 goto err;
    598         ttc->num_groups++;
    599 
    600         /* Any Group */
    601         memset(in, 0, inlen);
    602         MLX5_SET_CFG(in, start_flow_index, ix);
    603         ix += groups->group_size[ttc->num_groups];
    604         MLX5_SET_CFG(in, end_flow_index, ix - 1);
    605         ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
    606         if (IS_ERR(ttc->g[ttc->num_groups]))
    607                 goto err;
    608         ttc->num_groups++;
    609 
    610         kvfree(in);
    611         return 0;
    612 
    613 err:
--> 614         err = PTR_ERR(ttc->g[ttc->num_groups]);
    615         ttc->g[ttc->num_groups] = NULL;
    616         kvfree(in);
    617 
    618         return err;
    619 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

